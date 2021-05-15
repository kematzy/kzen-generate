# prompts:  /project:new

puts
logger.debug("start prompt: #{current_patch}")

# set the project name
confs.set_if_empty(:project_name, value: prompt.ask("What is the project name?", default: 'my-new-laravel-project'))

prompt_run('db')
# say_status :debug, "set db:type to: #{confs.fetch('db.type')}"


### HANDLE FEATURE ADDITIONS:
features = [
  { key: 'git', name: 'Git Setup', value: 'git' },
  { key: 'github', name: 'GitHub Setup', value: 'github' },
  { key: 'tailwind', name: 'Tailwind CSS Setup', value: 'tailwind' },
  { key: 'telescope', name: 'Telescope Debug Setup', value: 'telescope' },
  { key: 'mailtrap', name: 'Mailtrap.io Email handling', value: 'mailtrap' },
]

choices = prompt.multi_select("Add features?", features)

# choices = prompt.multi_select("Add features?") do |menu|
#   # menu.default :tailwind,
#   menu.choice 'Git setup',       { git: true }
#   menu.choice 'GitHub setup',    { github: true }
#   menu.choice 'Tailwind CSS',    { tailwind: true }
#   menu.choice 'Telescope Debug', { telescope: true }
#   menu.choice 'Mailtrap.io Email handling', { mailtrap: true }
# end


confs.set('features.git', value: choices.include?('git') ? true : false)
confs.set('features.github', value: choices.include?('github') ? true : false)
confs.set('features.tailwind', value: choices.include?('tailwind') ? true : false)
confs.set('features.telescope', value: choices.include?('telescope') ? true : false)
confs.set('features.mail.mailtrap', value: choices.include?('mailtrap') ? true : false)

# persist the configurations
# confs.write

# say_status 'laravel:project:new', "<-- (prompt)"

puts
logger.debug("end prompt: #{current_patch}")
