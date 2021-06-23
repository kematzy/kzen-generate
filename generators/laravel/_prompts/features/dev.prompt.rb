# prompts:  features


set_current_prompt 'features:dev'

puts
prompt_start


features = [
  # DEV
  { key: 'dev.telescope', name: fmtmenu('Telescope', 'installs Laravel Telescope debugging package'), value: 'telescope' },
  # { key: 'dev.telescopetoolbar', name: fmtmenu('Telescope Toolbar', 'adds browser toolbar to Telescope package'), value: 'telescopetoolbar' },
  { key: 'dev.ray', name: fmtmenu('Ray Debug', 'adds Ray debug app support'), value: 'dev_ray' },
  { key: 'dev.pretty-routes', name: fmtmenu('Pretty Routes', 'adds artisan command for pretty routes output'), value: 'dev_prettyroutes' },
  # MAIL
  { key: 'dev.mail.mailtrap', name: fmtmenu('MailTrap Emails', 'adds external email handling during development'), value: 'mailtrap' },
  # MIX
  { key: 'dev.mix.browsersync', name: fmtmenu('BrowserSync', 'adds browser live-reloads during development'), value: 'browsersync' },
]

puts
choices = prompt.multi_select("Choose DEV features?", features)

# logger.info("dev choices:  [#{choices.inspect}]")

# DEV
confs.set('dev.telescope', value: choices.include?('telescope') ? true : false)
confs.set('dev.telescope-toolbar', value: true)
# confs.set('dev.telescopetoolbar', value: choices.include?('telescopetoolbar') ? true : false)
confs.set('dev.ray', value: choices.include?('dev_ray') ? true : false)
confs.set('dev.pretty-routes', value: choices.include?('dev_prettyroutes') ? true : false)
# MAIL
confs.set('dev.mail.mailtrap', value: choices.include?('mailtrap') ? true : false)
# MIX
confs.set('dev.mix.browsersync', value: choices.include?('browsersync') ? true : false)


prompt_end
puts
