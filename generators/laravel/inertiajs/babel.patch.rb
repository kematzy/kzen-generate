# Add Babel dynamic import support to an existing solution

set_current_prompt 'inertiajs:babel'

puts
patch_start


npm_install_dev_if_not_installed?('@babel/plugin-syntax-dynamic-import')

contents = <<~APP
{
  "plugins": ["@babel/plugin-syntax-dynamic-import"]
}
APP
create_file('.babelrc', contents, verbose_opts)
git_commit('add .babelrc file')
logger.success 'added .babelrc file'


patch_end
puts
