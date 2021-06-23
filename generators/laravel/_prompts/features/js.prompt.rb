# prompts:  features


set_current_prompt 'features:js'

puts
prompt_start


features = [
  { key: 'js.prettier', name: fmtmenu('Prettier Setup', 'adds prettier support'), value: 'prettier' },
  { key: 'svelte',      name: fmtmenu('Svelte Setup', 'sets up Svelte support'), value: 'svelte' },
  { key: 'cypress',     name: fmtmenu('Cypress Setup', 'sets up Cypress for End-2-End testing support'), value: 'cypress' },
  { key: 'vue',         name: fmtmenu('Vue Setup', 'sets up Vue support'), value: 'vue' },
]

puts
choices = prompt.multi_select("Choose JS features?", features)

# logger.info("js choices:  [#{choices.inspect}]")

# JS
confs.set('js.type', value: choices.include?('svelte') ? 'svelte' : choices.include?('vue') ? 'vue' : nil)
# confs.set('js.type', value: 'vue') if choices.include?('vue')

# confs.set('features.js.svelte', value: choices.include?('svelte') ? true : false)
confs.set('js.cypress', value: choices.include?('cypress') ? true : false)
confs.set('js.prettier', value: choices.include?('prettier') ? true : false)


prompt_end
puts
