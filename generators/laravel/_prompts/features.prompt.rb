# prompts:  features


set_current_prompt 'features'

puts
prompt_start


### HANDLE FEATURE ADDITIONS:

features = [
  { key: 'git.enabled', name: fmtmenu('Git Setup', 'sets up a Git repository & commits script changes'), value: 'git' },
  { key: 'github', name: fmtmenu('GitHub Setup', 'sets up a new GitHub repository'), value: 'github' },
]
puts
choices = prompt.multi_select("Choose Git features?", features)

# logger.info("git choices:  [#{choices.inspect}]")

unless choices.include?('git')
  if prompt.ask?('Are you sure you want to disable Git?')
    confs.set('git.enabled', value: false)
  else
    confs.set('git.enabled', value: true)
  end
else
  confs.set('git.enabled', value: choices.include?('git') ? true : false)
end

confs.set('git.github', value: choices.include?('github') ? true : false)



### CSS FEATURE ADDITIONS:
# TODO: add support for SCSS setup instead of postCSS
features = [
  { key: 'css.tailwind', name: fmtmenu('Tailwind Setup', 'sets up Tailwind JIT with postCSS support'), value: 'tailwind' },
  { key: 'css.stylelint', name: fmtmenu('Stylelint Setup', 'adds stylelint support to Tailwind & postCSS'), value: 'stylelint' },
]

puts
choices = prompt.multi_select("Choose CSS features?", features)

# logger.info("css choices:  [#{choices.inspect}]")

# CSS
confs.set('css.tailwind', value: choices.include?('tailwind') ? true : false)
confs.set('css.stylelint', value: choices.include?('stylelint') ? true : false)


### JS FEATURE ADDITIONS:
run_prompt('features/js')


### AUTH FEATURE ADDITIONS:
# run_prompt('features/auth')


### DEV FEATURE ADDITIONS:
run_prompt('features/dev')


prompt_end
puts
