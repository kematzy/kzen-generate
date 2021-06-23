# prompts:  /project:new


set_current_prompt 'project:new'

# puts
prompt_start

# set the project name
confs.set_if_empty(:project_name, value: prompt.ask("What is the project name?", default: 'my-new-laravel-project'))

prompt_run('db')

prompt_run('features')


prompt_end
# puts
