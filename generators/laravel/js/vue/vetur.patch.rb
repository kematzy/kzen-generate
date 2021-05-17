# add Vue Vetur support to a [new] Laravel project

# DOCS:

set_current_patch 'js:vue:vetur'

puts
patch_start


contents = <<~VSCODE
{
  "include": [
    "./resources/js/**/*"
  ]
}
VSCODE
create_file('jsconfig.json', contents, verbose_opts)
git_commit('add jconfig.json file for Vetur support')
logger.success 'added jsconfig.json file for Vetur'


patch_end
puts
