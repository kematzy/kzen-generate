# Adding Inertia JS support to a [new] Laravel project

# DOCS: https://inertiajs.com/server-side-setup

set_current_patch 'js:inertia'

puts
patch_start


# TODO: move this to a prompt
unless confs.fetch('js.type')
  confs.set('js.type', value: prompt.select("Choose JS setup?", [ {name:'Svelte',value:'svelte'},{name:'Vue',value:'vue'} ]))
end

# install InertiaJS
composer_install('inertiajs/inertia-laravel')

template(tmpl_file("inertia/app.blade.php"), 'resources/views/app.blade.php', verbose_opts)
git_commit('add views/app.blade.php file')
logger.success 'added views/app.blade.php file'

artisan_cmd('inertia:middleware')

after = '\Illuminate\Routing\Middleware\SubstituteBindings::class,'
newcode = <<~NEW
#{after}
\\App\\Http\\Middleware\\HandleInertiaRequests::class,
NEW
gsub_file('app/Http/Kernel.php', after, newcode, verbose_opts)
git_commit('update app/Http/Kernel.php with middleware')
logger.success 'updated app/Http/Kernel.php file with inertia middleware'

npm_install("@inertiajs/inertia @inertiajs/inertia-#{confs.fetch('js.type')} #{confs.fetch('js.type')}")

npm_install('@inertiajs/progress')

npm_install('@babel/plugin-syntax-dynamic-import')

contents = <<~APP
{
  "plugins": ["@babel/plugin-syntax-dynamic-import"]
}
APP
create_file('.babelrc', contents, verbose_opts)
git_commit('add .babelrc file')
logger.success 'added .babelrc file'

directory(tmpl_dir("inertia/#{confs.fetch('js.type')}"), 'resources/js', verbose_opts)
logger.success 'updated resources/js/app.js file'

# add tightenco/ziggy support
run_patch('inertiajs:ziggy')

# ensure the correct webpack config is present
run_patch('mix:webpack')


puts
patch_end
