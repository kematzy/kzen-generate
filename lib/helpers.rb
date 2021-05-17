
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


      #### GIT HELPERS

      def git?
        options[:git]
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
        if git_dirty?
          # we are using git and it's dirty
          run("git add . ", debug_opts)
          run("git commit -m '#{@patch}: #{message}'", debug_opts)
          logger.git("#{@patch}: #{message}")
        elsif git?
          # using git, but not dirty, so log info
          logger.git('no changes to commit', @patch) unless silent
        else
          # do nothing, not using git
        end
      end


      #### PATCH HELPERS

      def patch_run(path, opts={})
        if patch_exists?(path)
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


  end

end