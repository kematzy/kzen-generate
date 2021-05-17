# add Telescope Debug bar to a [new] Laravel project

# DOCS: https://laravel.com/docs/8.x/telescope

set_current_patch 'dev:telescope-toolbar'

puts
patch_start


# install telescope
composer_install('fruitcake/laravel-telescope-toolbar --dev')

artisan_cmd('vendor:publish --provider="Fruitcake\TelescopeToolbar\ToolbarServiceProvider"', 'installed telescope toolbar')


patch_end
puts
