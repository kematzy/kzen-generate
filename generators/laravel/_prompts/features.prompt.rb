# prompts:  features


set_current_prompt 'features'

puts
prompt_start


### HANDLE FEATURE ADDITIONS:

features = [
  { key: 'git', name: fmtmenu('Git Setup', 'sets up a Git repository & commits script changes'), value: 'git' },
  { key: 'github', name: fmtmenu('GitHub Setup', 'sets up a new GitHub repository'), value: 'github' },
]
puts
choices = prompt.multi_select("Choose Git features?", features)
# GIT
confs.set('features.git', value: choices.include?('git') ? true : false)
confs.set('features.github', value: choices.include?('github') ? true : false)


### CSS FEATURE ADDITIONS:
features = [
  { key: 'tailwind', name: fmtmenu('Tailwind Setup', 'sets up Tailwind JIT with SCSS support'), value: 'tailwind' },
  { key: 'stylelint', name: fmtmenu('Stylelint Setup', 'adds stylelint support to Tailwind & SCSS'), value: 'stylelint' },
]

puts
choices = prompt.multi_select("Choose CSS features?", features)

# CSS
confs.set('features.css.tailwind', value: choices.include?('tailwind') ? true : false)
confs.set('features.css.stylelint', value: choices.include?('stylelint') ? true : false)


### DEV FEATURE ADDITIONS:
features = [
  # DEV
  { key: 'telescope', name: fmtmenu('Telescope', 'installs Laravel Telescope debugging package'), value: 'telescope' },
  # { key: 'telescopetoolbar', name: fmtmenu('Telescope Toolbar', 'adds browser toolbar to Telescope package'), value: 'telescopetoolbar' },
  { key: 'dev.ray', name: fmtmenu('Ray Debug', 'adds Ray debug app support'), value: 'dev_ray' },
  { key: 'dev.pretty-routes', name: fmtmenu('Pretty Routes', 'adds artisan command for pretty routes output'), value: 'dev_prettyroutes' },
  # MAIL
  { key: 'mailtrap', name: fmtmenu('MailTrap Emails', 'adds external email handling during development'), value: 'mailtrap' },
  # MIX
  { key: 'browsersync', name: fmtmenu('BrowserSync', 'adds browser live-reloads during development'), value: 'browsersync' },
]

puts
choices = prompt.multi_select("Choose DEV features?", features)

# DEV
confs.set('features.dev.telescope', value: choices.include?('telescope') ? true : false)
confs.set('features.dev.telescopetoolbar', value: choices.include?('telescopetoolbar') ? true : false)
confs.set('features.dev.ray', value: choices.include?('dev_ray') ? true : false)
confs.set('features.dev.pretty-routes', value: choices.include?('dev_prettyroutes') ? true : false)
# MAIL
confs.set('features.mail.mailtrap', value: choices.include?('mailtrap') ? true : false)
# MIX
confs.set('features.mix.browsersync', value: choices.include?('browsersync') ? true : false)


prompt_end
puts
