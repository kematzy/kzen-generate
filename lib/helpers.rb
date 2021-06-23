
module Kzen

  module Helpers

    def self.included(base) #:nodoc:
      super(base)
      base.extend ClassMethods
    end

    module ClassMethods
    end


    private

      def debug_opts(opts = {})
        if debug?
          { verbose: true, capture: false }.merge(opts)
        else
          { verbose: false, capture: true }.merge(opts)
        end
      end

      def verbose_opts(opts = {})
        if debug?
          { verbose: true }.merge(opts)
        else
          { verbose: false }.merge(opts)
        end
      end

      def verbose?
        options[:debug] ? true : false
      end
      alias_method :if_verbose, :verbose?

      def capture?
        options[:debug] ? false : true
      end
      alias_method :if_capture, :capture?

      def debug?
        options[:debug]
      end


      #### FILE HELPERS

      def file_contains?(haystack, needle)
        File.readlines(File.expand_path(haystack)).grep(/#{needle}/).size > 0
      end

      def package_installed?(package)
        res = File.readlines(File.expand_path('package.json')).grep(/"#{package}"/).size > 0
        if res
          logger.info("Yes, '#{package}' node package installed")
          return true
        else
          logger.info("No, '#{package}' node package NOT installed")
          return false
        end
      end


      #### GIT HELPERS

      def git?
        # options[:git]
        confs.fetch('git.enabled')
      end
      alias_method :using_git?, :git?

      def git_dirty?
        if git?
          # using git, so test for status
          res = `git status`
          res =~ /nothing to commit, working tree clean/ ? false : true
        else
          # not using git
          false
        end
      end

      def git_commit(message, silent = nil)
        if git?
          if git_dirty?
            # we are using git and it's dirty
            run("git add . ", debug_opts)
            run("git commit -m '#{@current_patch}: #{message}'", debug_opts)
            logger.git("#{@current_patch}: #{message}")
          else
            # using git, but not dirty, so log infom
            logger.git('no changes to commit', @patch) unless silent
          end
        else
          # do nothing, not using git
        end
      end


      #### PATCH HELPERS

      def patch_run(path, opts={})
        if patch_exists?(path)
          @active_patch = path
          apply(patch_path(path), debug_opts.merge(opts))
        else
          logger.error("No patch found to run with [#{bbr(path)}]", path, patch_path(path))
        end
      end
      alias_method :run_patch, :patch_run

      def patch_exists?(path)
        File.exist?(patch_path(path))
      end

      def patch_path(path)
        "#{@source_path}/#{path.gsub(':', '/')}.patch.rb"
      end

      def set_current_patch(p = nil)
        @previous_patch = @current_patch
        @current_patch = p.nil? ? @patch : p
      end

      def patch_start(custom = nil)
        c = custom.nil? ? @current_patch : custom
        logger.begin("patch: #{dc(c)}")
      end

      def patch_end(custom = nil)
        c = custom.nil? ? @current_patch : custom
        logger.end("patch: #{dc(c)}")
        @current_patch = @previous_patch
      end

      def get_current_patch
        @current_patch
      end

      def patch_required_for_feature(parent_patch, feature)
        logger.fatal "Unable to run '#{get_current_patch}' because #{feature} is not configured"
        logger.info " -- run 'kzen laravel #{parent_patch}' before running this commmand"
      end

      def patch_recommended(parent_patch, feature)
        logger.info "Recommendation: Feature #{feature} is not configured"
        logger.info " -- run 'kzen laravel #{parent_patch}' to install this functionality"
      end

      def patch_disabled
        logger.fatal "This patch: '#{get_current_patch}' is disabled or not ready for use"
      end

      #### PROMPT HELPERS

      def prompt_exists?(path)
        File.exist?(prompt_path(path))
      end
      alias_method :prompt_exist?, :prompt_exists?

      def prompt_path(path)
        "#{@source_path}/_prompts/#{path}.prompt.rb"
      end

      def prompt_run(path)
        if prompt_exists?(path)
          apply(prompt_path(path), debug_opts)
        else
          logger.error("No prompt found to run with [#{bbr(path)}]", path, prompt_path(path))
        end
      end
      alias_method :run_prompt, :prompt_run

      def set_current_prompt(p)
        @current_prompt = p
      end

      def prompt_start(custom = nil)
        c = custom.nil? ? @current_prompt : custom
        logger.begin("prompt: #{dc(c)}")
      end

      def prompt_end(custom = nil)
        c = custom.nil? ? @current_prompt : custom
        logger.end("prompt: #{dc(c)}")
      end

      #### FILE HELPERS

      def replace_in_file(file, replacements, msg, opts={})
        replacements.each do |r|
          gsub_file(file, r.find, r.replace, verbose_opts.merge(opts))
        end
        git_commit(msg)
        logger.success(msg)
      end

  end

end