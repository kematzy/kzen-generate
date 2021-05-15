# Configure a PostgreSQL DB for a new Laravel project

## TASKS:

# 1) change the info in .env file
# 2) create the postgres database
# 3) migrate database

# sudo -u postgres psql
# psql (12.5 (Ubuntu 12.5-0ubuntu0.20.04.1))

# postgres=# \conninfo
# You are connected to database "postgres" as user "postgres" via socket in "/var/run/postgresql" at port "5432".

# postgres=# \q

# ❯ sudo -u postgres createuser -D -A -P kzen
# [sudo] password for kzen:
# Enter password for new role: 123456
# Enter it again: 123456

puts
logger.begin('patch: db:pgsql')

confs.append_path(Dir.pwd)
confs.read

logger.debug "db =>  [#{confs.fetch('db').inspect}]"

replace_in_file('.env', [
    { find: 'DB_CONNECTION=mysql',  replace: "DB_CONNECTION=#{confs.fetch('db.type')}" },
    { find: 'DB_HOST=127.0.0.1',    replace: "DB_HOST=#{confs.fetch('db.host')}" },
    { find: 'DB_PORT=3306',         replace: "DB_PORT=#{confs.fetch('db.port')}" },
    { find: 'DB_DATABASE=laravel',  replace: "DB_DATABASE=#{confs.fetch('db.database')}" },
    { find: 'DB_USERNAME=root',     replace: "DB_USERNAME=#{confs.fetch('db.username')}" },
    { find: 'DB_PASSWORD=',         replace: "DB_PASSWORD=#{confs.fetch('db.password')}", },
  ],
  'added PostgreSQL DB configs'
)

# gsub_file('.env',
#   'DB_CONNECTION=mysql',
#   "DB_CONNECTION=#{confs.fetch('db.type')}",
#   verbose_opts
# )
# gsub_file('.env',
#   'DB_PORT=3306',
#   "DB_PORT=#{confs.fetch('db.port')}",
#   verbose_opts
# )
# gsub_file('.env',
#   'DB_DATABASE=laravel',
#   "DB_DATABASE=#{confs.fetch('db.database')}",
#   verbose_opts
# )
# gsub_file('.env',
#   'DB_USERNAME=root',
#   "DB_USERNAME=#{confs.fetch('db.username')}",
#   verbose_opts
# )
# gsub_file('.env',
#   'DB_PASSWORD=',
#   "DB_PASSWORD=#{confs.fetch('db.password')}",
#   verbose_opts
# )
# logger.success, "added PostgreSQL DB configs"


# sudo -u postgres createdb -O kzen grl_admin_app

run("/usr/bin/createdb #{confs.fetch('db.database')}", debug_opts)
logger.success, "created #{confs.fetch('db.database')} DB in PostgreSQL"

artisan_migrate 'migrated DB'


logger.end('patch: db:pgsql')
puts
