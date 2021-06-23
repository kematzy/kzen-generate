

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
        git_commit("composer require #{package}")
        logger.success("installed #{package} package")
      end


      #### ARTISAN HELPERS

      def artisan_migrate(silent = nil)
        run("php artisan migrate", debug_opts)
        git_commit("php artisan migrate", silent) if git_dirty?
        logger.success("ran artisan migrate")
      end

      def artisan_migrate_fresh(silent = nil)
        run("php artisan migrate:fresh", debug_opts)
        git_commit("php artisan migrate:fresh", silent) if git_dirty?
        logger.success("ran artisan migrate:fresh")
      end

      def artisan_cmd(cmd, message = 'ran artisan command')
        run("php artisan #{cmd}", debug_opts)
        git_commit("artisan #{cmd}")
        logger.success("#{message}: #{cmd}")
      end


      #### NPM HELPERS

      def npm_install(packages, msg = nil)
        run("npm install #{packages}", debug_opts)
        git_commit("npm install #{packages}")
        message = msg ? msg : "npm install #{packages}"
        logger.success(message)
      end

      def npm_install_dev(packages, msg = nil)
        run("npm install -D #{packages}", debug_opts)
        git_commit("npm install -D #{packages}")
        message = msg ? msg : "npm install -D #{packages}"
        logger.success(message)
      end

      def npm_run(task, msg = nil)
        run("npm run #{task}", debug_opts)
        git_commit("npm run #{task}")
        logger.success("ran npm run #{task}: #{msg}")
      end

      def npm_run_dev(msg = nil)
        run("npm run dev", capture: @out_capture)
        git_commit('npm run dev')
        logger.success "ran npm run dev: #{msg}"
      end

      def npx_run(task, msg = nil)
        run("npx #{task}", capture: @out_capture)
        git_commit("npx #{task}")
        message = msg ? msg : "ran npx task: #{task}"
        logger.success(message)
      end

      def npm_install_if_not_installed?(package, msg = nil)
        if package_installed?(package)
          logger.warn("npm package: #{package} already installed")
        else
          npm_install(package, msg)
        end
      end

      def npm_install_dev_if_not_installed?(package, msg = nil)
        if package_installed?(package)
          logger.warn("npm package: #{package} already installed")
        else
          npm_install_dev(package, msg)
        end
      end


      #### JS HELPERS

      def js_configured?
        !confs.fetch('js.type').nil?
      end

      def get_js_type
        confs.fetch('js.type') || 'svelte'
      end

      def svelte?
        confs.fetch('js.type') === 'svelte'
      end

      def vue?
        confs.fetch('js.type') === 'vue'
      end

      def inertiaJS?
        confs.fetch('js.inertiajs')
      end

      def cypress?
        confs.fetch('js.cypress')
      end


      #### CSS HELPERS

      def get_css_type
        confs.fetch('css.type') || 'postcss'
      end

      def postCSS?
        confs.fetch('css.type') === 'postcss'
      end

      def scss?
        confs.fetch('css.type') === 'scss'
      end

      def tailwindCSS?
        confs.fetch('css.tailwind')
      end

  end

end

