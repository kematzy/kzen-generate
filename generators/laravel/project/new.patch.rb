# create a new Laravel project and set it up

set_current_patch 'project:new'

# puts
patch_start


# test for config variables or load prompts
if File.exists?("#{Dir.pwd}/kzen.config.yaml")
  konfs = confs.read
  say_status :info, "configurations found: [#{konfs.inspect}]"
else
  say_status :warn, 'no configurations found'
end

# see if configs tells us to be silent
run_prompt('project/new') unless confs.fetch(:silent)


#### SCRIPT PARTS BELOW:

@project_name = confs.fetch(:project_name)


# 1)  Create project folder
# FileUtils.mkdir_p "#{Dir.pwd}/#{@project_name}"
# run("mkdir #{@project_name}", capture: @out_capture)
run("laravel new #{@project_name}", debug_opts)
logger.success "created new Laravel project: [#{bbg(@project_name)}]"

inside @project_name do
  # append current dir to configs paths
  confs.prepend_path(Dir.pwd)
  # then save the configs
  confs.write

  if confs.fetch('features.git')
    puts
    run('git init', debug_opts)
    logger.git "created Git repository"

    git_commit('initial commit')
    logger.git "created initial commit"
  else
    logger.warn "skipped creating Git repo"
  end

  if confs.fetch('db')
    # logger.info('should run :db patch')
    run_patch("db:#{confs.fetch('db.type')}")
    # logger.info('should have run :db patch')
  end

end


puts
patch_end
