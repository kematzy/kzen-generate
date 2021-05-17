# add & configure StyleLint in a [new] Laravel project

# DOCS: https://stylelint.io

set_current_patch 'css:stylelint'

puts
patch_start


npm_install_dev('stylelint stylelint-config-standard stylelint-config-recommended')

template(tmpl_file("stylelint/stylelintrc.json"), '.stylelintrc.json', verbose_opts)
git_commit('added .stylelintrc.json')
logger.success 'added .stylelintrc.json file'

template(tmpl_file("stylelint/vscode-settings.json"), '.vscode/settings.json', verbose_opts)
git_commit('added .vscode/settings.json')
logger.success 'added .vscode/settings.json file'

npm_run_dev


patch_end
puts
