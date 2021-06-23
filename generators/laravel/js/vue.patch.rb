# add Vue support to a [new] Laravel project

# DOCS:

set_current_patch 'js:vue'

puts
patch_start

patch_disabled

# npm_install_if_not_installed?('vue')

# patch_run('js:vue:vetur')

# if vue?

#   contents = <<~VSCODE
#   {
#     "include": [
#       "./resources/js/**/*"
#     ]
#   }
#   VSCODE
#   create_file('jsconfig.json', contents, verbose_opts)
#   git_commit('add jconfig.json file for Vetur support')
#   logger.success 'added jsconfig.json file for Vetur'

# else
#   patch_required_for_feature('js:vue', 'Vue')
# end

patch_end
puts
