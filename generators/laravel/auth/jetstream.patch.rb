# Adding Laravel Jetstream support to a [new] Laravel project

# DOCS: https://jetstream.laravel.com/1.x/installation.html

set_current_patch 'auth:jetstream'

puts
patch_start


# TODO: move these propmts

# check for JS Setup support
choices = [
  { name: 'Livewire (AlpineJS)', value: 'livewire' },
  { name: 'InertiaJS (Vue & Svelte)', value: 'inertia' }
]

confs.set('auth.jetstream.type', value: prompt.select('Choose JS setup?', choices)
# check for Teams support
confs.set('auth.jetstream.teams', value: prompt.ask?('Add Teams support?', default: false)
# check for API support
confs.set('auth.jetstream.api', value: prompt.ask?('Add API support?')
# check for Terms support
confs.set('auth.jetstream.terms', value: prompt.yes?('Add Terms & Privacy Policy support?')
# check for Profile Photo support
confs.set('auth.jetstream.profile', value: prompt.ask?('Add Terms & Privacy Policy support?')

# check if we should publish the JetStream views
if confs.fetch('auth.jetstream.type') == 'livewire'
  confs.set('auth.jetstream.publish_views', value: prompt.yes?("Publish JetStream views?")
end


composer_install('laravel/jetstream')

# create the install string
cmd = "jetstream:install #{confs.fetch('auth.jetstream.type')}"
cmd = "#{cmd} --teams" if confs.fetch('auth.jetstream.teams')

artisan_cmd(cmd)

artisan_migrate(:silent)

npm_install('JetStream packages')

npm_run_dev('generated .css assets')

artisan_migrate_fresh

if confs.fetch('auth.jetstream.api')
  gsub_file('config/jetstream.php', '// Features::api(),', 'Features::api(),', verbose_opts)
  git_commit('enabled API support')
  logger.success 'jetstream: enabled API support'
end

if confs.fetch('auth.jetstream.terms')
  gsub_file('config/jetstream.php', '// Features::termsAndPrivacyPolicy(),', 'Features::termsAndPrivacyPolicy(),', verbose_opts)
  git_commit('enabled Terms & Privacy Policy support')
  logger.success 'jetstream: enabled Terms & Privacy Policy support'
end

if confs.fetch('auth.jetstream.profile')
  gsub_file('config/jetstream.php', '// Features::profilePhotos(),', 'Features::profilePhotos(),', verbose_opts)
  artisan_cmd('storage:link')
end

# Publish the JetStream views if LiveWire
artisan_cmd('vendor:publish --tag=jetstream-views') if confs.set('auth.jetstream.publish_views')

# check if using inertia & Vue, if so add vetur configs
patch_run('js:vue:vetur') if confs.set('auth.jetstream.type') == 'inertia'


patch_end
puts


