# add & configure Laravel Mix - WebPack to a [new] Laravel project

# DOCS: https://laravel-mix.com/extensions/webpack

# CONFIGS:
#
#   features:
#     js: 'svelte' || 'vue'

set_current_patch 'mix:webpack'

puts
patch_start


if confs.fetch('js.type')

  template(tmpl_file("mix/#{confs.fetch('js.type')}/webpack.config.js"), 'webpack.config.js')
  git_commit('added webpack.config.js file')
  logger.success 'added webpack.config.js file'

  # replace contents in webpack.mix.js
  newcode = <<-NEW
  .webpackConfig(require('./webpack.config'))
      // insert
  NEW
  gsub_file('webpack.mix.js', '// insert', newcode, verbose_opts)
  git_commit('updated webpack.mix.js')
  logger.success 'updated webpack.mix.js file with WebPack configs'

else
  logger.fatal('mix:webpack: failed to access the js.type setting')
end


patch_end
puts
