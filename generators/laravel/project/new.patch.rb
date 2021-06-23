# create a new Laravel project and set it up

set_current_patch 'project:new'

# puts
patch_start


# see if configs tells us to be silent
run_prompt('project/new') unless confs.fetch(:silent)


#### SCRIPT PARTS BELOW:

@project_name = confs.fetch(:project_name)

# 1)  Create Laravel project folder
run("laravel new #{@project_name}", debug_opts)
puts
logger.success "created new Laravel project: #{bbg(@project_name)}"

inside @project_name do
  # append current dir to configs paths
  confs.prepend_path(Dir.pwd)

  # 2) Handle Git repository
  if confs.fetch('git.enabled')
    patch_run('git/init')
  else
    logger.warn "skipped creating Git repo"
  end

  # 3) Add DB setup
  patch_run("db:#{confs.fetch('db.type')}") if confs.fetch('db')

  # 4) Ensure DB Sessions support
  patch_run('db:sessions') if confs.fetch('db')

  # 5) Features: Add Tailwind support (including: Stylelint, BrowserSync)
  patch_run('css:tailwind') if confs.fetch('css.tailwind')

  # 6) Features: Add Telescope support (including: Telescope Toolbar)
  patch_run('dev:telescope') if confs.fetch('dev.telescope')

  # 7) Features: Add Ray Debug support (including: none)
  patch_run('dev:ray') if confs.fetch('dev.ray')

  # 8) Features: Add Pretty Routes support (including: none)
  patch_run('dev:pretty-routes') if confs.fetch('dev.pretty-routes')

  # 9) Features: Add Mail Mailtrap support (including: none)
  patch_run('dev:mail:mailtrap') if confs.fetch('dev.mail.mailtrap')

  set_current_patch 'project:new' # reset before ending script

  gsub_file('.editorconfig', 'indent_size = 4', 'indent_size = 2', verbose_opts)
  git_commit('updated .editorconfig file indentation size')
  logger.success 'updated .editorconfig file indentation size'


  # # 10) Features: Add JS:Svelte support (including: none)
  # patch_run('js:svelte') if confs.fetch('features.js.svelte')

  # # 11) Features: Add JS:Prettier support (including: none)
  # patch_run('js:prettier') if confs.fetch('features.js.prettier')

  # then save the configs
  confs.write(force: true)
  git_commit('saved kzen.config.yml')

end


patch_end
puts
