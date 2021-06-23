# add & configure Laravel Mix - WebPack to a [new] Laravel project

# DOCS: https://laravel-mix.com/extensions/webpack

# CONFIGS:
#
#   features:
#     js: 'svelte' || 'vue'

set_current_patch 'mix:webpack'

puts
patch_start


# set the config value if not set
confs.set('dev.mix.webpack', value: true) unless confs.fetch('dev.mix.webpack')

if js_configured?

  template(tmpl_file("mix/#{get_js_type}/webpack.config.js"), 'webpack.config.js')
  git_commit('added webpack.config.js file')
  logger.success 'added webpack.config.js file'

# replace contents in webpack.mix.js
oldcode = <<-FIND
  // insert
FIND
newcode = <<-NEW
  .webpackConfig(require('./webpack.config'))
  // .version()
  // .sourceMaps()
  // insert
NEW
  gsub_file('webpack.mix.js', oldcode, newcode, verbose_opts)
  git_commit('updated webpack.mix.js')
  logger.success 'updated webpack.mix.js file with WebPack configs'

  if svelte?
    run_patch('js:svelte:loader')

    run_patch('js:svelte:preprocess')
  end

else
  logger.fatal('mix:webpack: failed to access the js.type setting')
end


patch_end
puts
