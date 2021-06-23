# Add Prettier support to a Laravel project

set_current_patch 'js:prettier'

puts
patch_start

# set the config value if not set
confs.set('js.prettier', value: true) unless confs.fetch('js.prettier')


npm_install_dev('@prettier/plugin-php')

npm_install_dev('prettier')

npm_install_dev('prettier-plugin-svelte') if svelte?

npm_install_dev('prettier-plugin-vue') if vue?

template(tmpl_file("js/#{get_js_type}-prettierrc"), '.prettierrc', verbose_opts)
git_commit('added .prettierrc file')
logger.success 'added .prettierrc file'


# update package.json with prettier support
find = <<-FIND
        "prod": "npm run production",
FIND

replace = <<-NEW
        "prettier": "prettier --write ./resources/js/**/*",
        "prod": "npm run production",
NEW
gsub_file('package.json', find, replace, verbose_opts)
git_commit('update package.json with prettier command')
logger.success 'updated package.json with prettier command'


# TODO: add this to .vscode/settings.json file
# "prettier.enable": true,


patch_end
puts
