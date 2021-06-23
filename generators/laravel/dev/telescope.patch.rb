# add Telescope & Telescope Debug bar to a [new] Laravel project

# DOCS: https://laravel.com/docs/8.x/telescope

set_current_patch 'dev:telescope'

puts
patch_start


# set the config value if not set
confs.set('dev.telescope', value: true) unless confs.fetch('dev.telescope')

composer_install('laravel/telescope')

artisan_cmd('telescope:install', 'installed laravel/telescope package')

artisan_migrate

patch_run('dev:telescope-toolbar') if confs.fetch('dev.telescope-toolbar')


patch_end
puts