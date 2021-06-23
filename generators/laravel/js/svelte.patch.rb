# add Svelte support to a [new] Laravel project

# DOCS:

set_current_patch 'js:svelte'

puts
patch_start


# tell confs we are using Svelte, NOTE! overwrites existing value.
confs.set('js.type', value: 'svelte')

npm_install_if_not_installed?('svelte')

npm_install_dev_if_not_installed?('svelte-loader')

npm_install_dev_if_not_installed?('svelte-preprocess')


contents = <<-CODE
const preprocess = require('svelte-preprocess');

module.exports = {
  preprocess: preprocess({
    // postcss: true,
  })
};

CODE
create_file('svelte.config.js', contents, verbose_opts)
git_commit('add svelte.config.js file for better VS Code support')
logger.success 'added svelte.config.js file for better VS Code support'

if postCSS?

find = <<-FIND
    // postcss: true,
FIND
replace = <<-CODE
    // postcss: true,
    postcss: {
      // syntax: 'postcss-scss',
      // parser: 'postcss-scss',
      plugins: [
        require('postcss-import'),
        require('tailwindcss'),
        require('postcss-nesting'),
        require('autoprefixer')
      ]
    }
CODE
  gsub_file('svelte.config.js', find, replace, verbose_opts)
  git_commit('add postCSS configs to svelte.config.js')
  logger.success 'added postCSS configs to svelte.config.js'

end


# TODO: add this to .vscode/settings.json file
# "prettier.enable": true,

# // TODO: make this config optional
# "[svelte]": {
#   "editor.defaultFormatter": "svelte.svelte-vscode"
# },
# "svelte.plugin.css.diagnostics.enable": false,


patch_end
puts
