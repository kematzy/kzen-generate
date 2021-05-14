

module Kzen

  module LaravelHelpers

    def self.included(base) #:nodoc:
      super(base)
      base.extend ClassMethods
    end

    module ClassMethods
    end


    private

      #### COMPOSER HELPERS

      def composer_install(package)
        run("composer require #{package}", debug_opts)
        git_commit("#{@patch}: composer require #{package}")
        logger.success("installed #{package} package")
      end


      #### ARTISAN HELPERS

      def artisan_migrate(silent = nil)
        run("php artisan migrate", debug_opts)
        git_commit("#{@patch}: php artisan migrate", silent) if git_dirty?
        logger.success("ran artisan migrate")
      end

      def artisan_cmd(cmd, message = 'ran artisan command')
        run("php artisan #{cmd}", debug_opts)
        git_commit("artisan #{cmd}")
        logger.success("#{message}: #{cmd}")
      end

      #### NPM HELPERS


      def npm_install(msg = nil)
        run("npm install", debug_opts)
        git_commit('npm install')
        logger.success("npm install: #{msg}" ) if msg
      end

      def npm_run(task, msg = nil)
        run("npm run #{task}", debug_opts)
        git_commit("npm run #{task}")
        logger.success("ran npm run #{task}: #{msg}")
      end


  end

end

