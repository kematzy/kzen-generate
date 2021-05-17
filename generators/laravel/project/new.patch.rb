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
  if confs.fetch('features.git')
    run_patch('git/init')
  else
    logger.warn "skipped creating Git repo"
  end

  # 3) Add DB setup
  run_patch("db:#{confs.fetch('db.type')}") if confs.fetch('db')

  # 4) Ensure DB Sessions support
  run_patch('db:sessions') if confs.fetch('db')

  # 5) Features: Add Tailwind support (including: Stylelint, BrowserSync)
  run_patch('css:tailwind') if confs.fetch('features.css.tailwind')

  # then save the configs
  confs.write
end


puts
patch_end
