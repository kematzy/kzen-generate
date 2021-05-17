# Adding Laravel Breeze support to a [new] Laravel project

# DOCS: https://laravel.com/docs/8.x/starter-kits


set_current_patch 'auth:breeze' # current patch

puts
patch_start


composer_install('laravel/breeze --dev')

artisan_cmd('breeze:install --inertia')

artisan_migrate(:silent)

npm_install('breeze packages')

# npm_run_dev('generated .css assets')


patch_end
puts
