# add Spatie Ray Debug app support to a [new] Laravel project

# DOCS: https://spatie.be/docs/ray/v1/installation-in-your-project/laravel

set_current_patch 'dev:ray'

puts
patch_start


composer_install('spatie/laravel-ray')

artisan_cmd('ray:publish-config', 'published the spatie/laravel-ray config')

patch_end
puts
