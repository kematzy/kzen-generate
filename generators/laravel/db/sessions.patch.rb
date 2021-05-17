# Adding Database support for Sessions to a [new] Laravel project

# DOCS: https://laravel.com/docs/8.x/session#database

set_current_patch 'db:sessions'

patch_start


logger.debug "db => [#{confs.fetch('db').inspect}]"

# Convert to db sessions storage

### Configure .env files
gsub_file('.env', 'SESSION_DRIVER=file', 'SESSION_DRIVER=database', verbose_opts)
logger.success 'updated SESSION_DRIVER in .env file'

gsub_file('.env.example', 'SESSION_DRIVER=file', 'SESSION_DRIVER=database', verbose_opts)
git_commit('updated SESSION_DRIVER in .env.example file')
logger.success 'updated SESSION_DRIVER in .env.example file'


artisan_cmd 'session:table', 'generated session table migration'

artisan_migrate 'migrated db sessions'


patch_end
