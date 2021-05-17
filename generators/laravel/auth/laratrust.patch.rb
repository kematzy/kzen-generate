# Adding LaraTrust support to a [new] Laravel project

# DOCS: https://laratrust.santigarcor.me/docs/6.x/

set_current_patch 'auth:laratrust'

puts
patch_start


composer_install('santigarcor/laratrust')

artisan_cmd('vendor:publish --tag="laratrust"', 'created local LaraTrust config file')

artisan_migrate ''

# npm_install

npm_run_dev


patch__end
puts
