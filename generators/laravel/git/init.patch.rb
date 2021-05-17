# Creates Git repository and adds first committ

set_current_patch 'git:init'

# puts
patch_start


run('git init', debug_opts)
logger.git "created Git repository"

git_commit('initial commit')


patch_end
# puts
