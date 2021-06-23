# add Pretty Routes artisan command to a [new] Laravel project

# DOCS: https://github.com/Wulfheart/pretty-routes

set_current_patch 'dev:pretty-routes'

puts
patch_start

# set the config value if not set
confs.set('dev.pretty-routes', value: true) unless confs.fetch('dev.pretty-routes')

composer_install('wulfheart/pretty_routes')


patch_end
puts
