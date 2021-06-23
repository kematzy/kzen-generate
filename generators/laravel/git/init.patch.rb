# Creates Git repository and adds first committ

set_current_patch 'git:init'

# puts
patch_start

# set the config value if not set
confs.set('git.enabled', value: true) unless confs.fetch('git.enabled')

run('git init', debug_opts)
logger.git "created Git repository"

# ignore public directory changes
contents  = <<~CODE

# temporary exclusions
public/css/app.css
public/js/*.js
public/js/*.txt
public/mix-manifest.json
CODE
append_to_file('.gitignore', contents, debug_opts)

git_commit('initial commit')


patch_end
# puts
