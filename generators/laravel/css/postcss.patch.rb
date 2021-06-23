# add & configure postCSS to a [new] Laravel project

# DOCS: https://tailwindcss.com/docs/guides/laravel

set_current_patch 'css:postcss' # current patch

puts
patch_start

# set the config value if not set
confs.set('css.type', value: 'postcss') unless confs.fetch('css.type')


npm_install_dev('postcss@latest', 'installed latest postcss package')

npm_install_dev('postcss-import', 'installed postcss-import package')

npm_install_dev('postcss-load-config', 'installed postcss-load-config package')

npm_install_dev('postcss-nesting', 'installed postcss-nesting package')

npm_install_dev('postcss-scss', 'installed postcss-scss package')

# replace contents in webpack.mix.js
oldcode = <<-OLD
    .postCss('resources/css/app.css', 'public/css', [
        //
    ]);
OLD
newcode = <<-NEW
  .postCss('resources/css/app.css', 'public/css', [
    require('postcss-import'),
    require('postcss-nesting'),
    #{'require(\'tailwindcss\'),' if tailwindCSS?}
    #{'require(\'autoprefixer\'),' if tailwindCSS?}
  ])
  // insert
  ;
NEW
gsub_file('webpack.mix.js', oldcode, newcode, verbose_opts)
git_commit('update webpack.mix.js with postCSS configs')
logger.success 'updated webpack.mix.js with postCSS configs'

# setup postcss.config.js file
contents = <<~CONFIG
module.exports = {
  syntax: 'postcss-scss',
  // parser: 'postcss-scss',
  plugins: [
    require('postcss-import'),
    #{'require(\'tailwindcss\'),' if tailwindCSS?}
    require('postcss-nesting'),
    #{'require(\'autoprefixer\'),' if tailwindCSS?}
  ]
}
CONFIG
create_file('postcss.config.js', contents, verbose_opts)
git_commit('added postcss.config.js file')
logger.success 'added postcss.config.js file'


patch_end
puts
