# Adding Ziggy support for Inertia JS projects to a [new] Laravel project

# DOCS: https://inertiajs.com/server-side-setup
#       https://github.com/tightenco/ziggy


set_current_patch 'inertiajs:ziggy'

puts
patch_start


composer_install('tightenco/ziggy')

gsub_file('resources/views/app.blade.php', '<!-- Scripts -->', "@routes\n  <!-- Scripts -->", verbose_opts)
git_commit('added @routes to views/app.blade file')
logger.success 'added @routes to views/app.blade file'


patch_end
puts
