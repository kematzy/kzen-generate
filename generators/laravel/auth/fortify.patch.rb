# Adding Fortify Authentication support to a [new] Laravel project

# DOCS: https://laravel.com/docs/8.x/fortify

set_current_patch 'auth:fortify'

puts
patch_start


composer_install('laravel/fortify')

artisan_cmd('vendor:publish --provider="Laravel\Fortify\FortifyServiceProvider"')

artisan_migrate(:silent)

# npm_install('fortify packages')

#  npm_run('dev', 'generated .css assets')


patch_end
puts
