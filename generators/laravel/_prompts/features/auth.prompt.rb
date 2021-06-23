# prompts:  features


set_current_prompt 'features:auth'

puts
prompt_start


features = [
  { key: 'breeze', name: fmtmenu('Breeze Setup', 'sets up Laravel Breeze with InertiaJS & Vue support'), value: 'breeze' },
  { key: 'fortify', name: fmtmenu('Fortify Setup', 'sets up Laravel Fortify support (Note! no frontend)'), value: 'fortify' },
  # { key: 'jetstream.svelte', name: fmtmenu('JetStream (Inertia & Svelte) Setup', 'sets up Laravel JetStream with InertiaJS & Svelte support'), value: 'jetstream_inertia_svelte' },
  { key: 'jetstream.vue', name: fmtmenu('JetStream (Inertia & Vue) Setup', 'sets up Laravel JetStream with InertiaJS & Vue support'), value: 'jetstream_inertia_vue' },
  { key: 'jetstream.livewire', name: fmtmenu('JetStream (Livewire) Setup', 'sets up Laravel JetStream with Livewire support'), value: 'jetstream_livewire' },
  { key: 'laratrust', name: fmtmenu('LaraTrust Setup', 'sets up Laravel role-based access control support'), value: 'laratrust' },
]

puts
choices = prompt.multi_select("Choose Auth Setup?", features)

# logger.info("auth choices:  [#{choices.inspect}]")

# AUTH
confs.set('auth.breeze', value: choices.include?('breeze') ? true : false)
confs.set('auth.fortify', value: choices.include?('fortify') ? true : false)
# confs.set('auth.jetstream.svelte', value: choices.include?('jetstream_inertia_svelte') ? true : false)
confs.set('auth.jetstream.vue', value: choices.include?('jetstream_inertia_vue') ? true : false)
confs.set('auth.jetstream.livewire', value: choices.include?('jetstream_livewire') ? true : false)
confs.set('auth.laratrust', value: choices.include?('laratrust') ? true : false)


prompt_end
puts
