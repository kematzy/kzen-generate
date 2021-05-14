#!/usr/bin/env ruby
require "rubygems" # ruby1.9 doesn't "require" it though
require 'fileutils'
require 'thor'
require 'tty-prompt'
require 'tty-config'
require 'tty-logger'
require 'pastel'
require 'active_support/all'



module Kzen

  class Laravel < Thor::Group
    include Thor::Actions

    # Define the source template root
    def self.source_root
      "#{ENV['HOME']}/.kzen"
    end

    def self.banner
      'kzen laravel [path:2:patch:name] [options]'
    end

    def prompt
      @prompt ||= TTY::Prompt.new(help_color: :blue)
    end

    def confs
      @configs ||= TTY::Config.new do |c|
        c.filename = "kzen.config"
        c.extname = ".yml"
        # c.append_path Dir.pwd
        c.append_path Dir.home
      end
    end

    def logger
      @logger = TTY::Logger.new do |config|
        config.types = {
          git:   { level: :info },
          db:    { level: :info },
          begin: { level: :info },
          end:   { level: :info },
        }
        config.handlers = [
          [:console, {
            styles: {
              git: {
                symbol: " ✱ ",
                label: "git",
                color: :yellow,
                levelpad: 6
              },
              db: {
                symbol: " ≡ ",
                label: "db",
                color: :bright_magenta,
                levelpad: 7
              },
              begin: {
                symbol: " » ",
                label: "begin",
                color: :cyan,
                levelpad: 4
              },
              end: {
                symbol: " « ",
                label: "end",
                color: :cyan,
                levelpad: 6
              },
            }
          }]
        ]
      end
    end

    def format
      @pastel = Pastel.new
    end

    desc "Description:\n\n\t'kzen laravel [patch.name] [vars]' applies the patch in the current directory"

    argument :source, desc: 'The source directory name'
    argument :patch, desc: 'The patch name or URL of the required patch'
    # argument :name, desc: 'The patch name or URL of the required patch'

    class_option :root,  desc: 'The root destination', aliases: '-r', default: ".",   type: :string
    class_option :git,   desc: 'Run Git add & commit after patch', aliases: '-g', default: true, type: :boolean
    class_option :debug,   desc: 'Run command with full output', default: false, type: :boolean

    add_runtime_options!

    # Show help if no argv givens
    # require_arguments

    # handle errors better
    def self.exit_on_failure?; true; end


    def start
      @time_start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      puts
      logger.begin("Started running: #{format.bright_cyan.bold("'#{current_patch}'")}")
      puts
    end


    def read_configs

    end


    def setup_patch
      # self.destination_root = File.expand_path(File.join(options[:root]))
      @source_path          = "#{Kzen::Laravel.source_root}/#{source}"
      @dest_path            = File.expand_path(`pwd`.chomp)


      @out_verbose          = options[:debug] ? true : false
      @out_capture          = options[:debug] ? false : true

      # @patch                = @args.shift

      @patch_name           = patch.split(':').last
      @namespaced_path      = patch.tr(":", "/")

      @author_name          = `git config user.name`.chomp
      @author_email         = `git config user.email`.chomp
      @year                 = Time.now.strftime('%Y')

      # say "\n"
      # say_status :start, "#{source} #{@patch}"

      # say "self.inspect [#{Kzen::Laravel.source_root}]"
      # say "self.inspect [#{self.inspect}]"

      # we look for the patch first, if NOT found give a list of available patches
      if File.exist?("#{@source_path}/#{@namespaced_path}.patch.rb")
        begin
          # say "\nYES: that patch was found [#{@source_path}/#{@namespaced_path}.patch.rb]"
          apply("#{@source_path}/#{@namespaced_path}.patch.rb", verbose: false)
        rescue Exception => e
          say "Error: [ #{e.inspect} ]"
        end

      else
        say_status :error, "No such patch [ #{patch} ] found.", :red
        say_status :info, "-- Available patches are:"

        Dir["#{@source_path}/**/*.patch.rb"].each do |f|
          say_status :info, "-- #{f.sub("#{@source_path}/", '').sub('.patch.rb', '').gsub('/', ':')}"
        end

        say_status :info, "-- Terminated execution", :red
        exit
      end
    end

    # Finish message
    def finish
      puts
      logger.end("Finished running: #{format.bright_cyan.bold("'#{current_patch}'")}")
      puts
      ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      elapsed = ending - @time_start
      logger.success("Successfully generated '#{current_patch}' in #{elapsed.round(4)} seconds")
    end

    private

      def debug_opts
        if options[:debug]
          { verbose: true, capture: false }
        else
          { verbose: false, capture: true }
        end
      end

      def verbose_opts(opts = {})
        if options[:debug]
          { verbose: true }.merge(opts)
        else
          { verbose: false }.merge(opts)
        end
      end

      def if_verbose
        options[:debug] ? true : false
      end

      def if_capture
        options[:debug] ? false : true
      end

      def git_commit(message)
        if git_dirty?
          run("git add . ", debug_opts) if options[:git]
          run("git commit -m '#{message}'", debug_opts) if options[:git]
          say_status :git, "commit: #{message}", :yellow
        else
          say_status :git, 'no changes to commit', :yellow
        end
      end

      def git_dirty?
        res = `git status`
        res =~ /nothing to commit, working tree clean/ ? false : true
      end


      def tmpl_file(path)
        "#{@source_path}/_templates/#{path}"
      end
  end
end

Kzen::Laravel.start
