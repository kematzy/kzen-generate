# add Pretty Routes artisan command to a [new] Laravel project

# DOCS: https://github.com/Wulfheart/pretty-routes

set_current_patch 'dev:pretty-routes'

puts
patch_start


composer_install('wulfheart/pretty_routes')


patch_end
puts
