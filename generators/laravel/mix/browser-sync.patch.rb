# add & configure Laravel Mix - BrowserSync to a [new] Laravel project

# DOCS: https://laravel-mix.com/docs/6.0/browsersync
#       https://browsersync.io/docs/options/


set_current_patch 'mix:browsersync'

puts
patch_start


npm_install_dev('browser-sync browser-sync-webpack-plugin', 'installed browserSync packages')

newcode = <<-NEW
// insert
    .browserSync('http://#{@project_name}.test')
NEW

# replace contents in webpack.mix.js
gsub_file('webpack.mix.js', '// insert', newcode, verbose_opts)
git_commit('update webpack.mix.js')
logger.success 'updated webpack.mix.js file with browserSync configs'


patch_end
puts
