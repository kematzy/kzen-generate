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

set_current_patch 'db:pgsql' # current patch

puts
patch_start


logger.debug("db => [#{confs.fetch('db').inspect}]")

gsub_file('.env',
  'DB_CONNECTION=mysql',
  "DB_CONNECTION=#{confs.fetch('db.type')}",
  verbose_opts
)
logger.success("PG: .env DB_CONNECTION=[#{confs.fetch('db.type')}]")
gsub_file('.env',
  'DB_PORT=3306',
  "DB_PORT=#{confs.fetch('db.port')}",
  verbose_opts
)
logger.success("PG: .env DB_PORT=[#{confs.fetch('db.port')}]")
gsub_file('.env',
  "DB_DATABASE=#{@project_name.gsub('-', '_')}",
  "DB_DATABASE=#{confs.fetch('db.database')}",
  verbose_opts
)
logger.success("PG: .env DB_DATABASE=[#{confs.fetch('db.database')}]")
gsub_file('.env',
  'DB_USERNAME=root',
  "DB_USERNAME=#{confs.fetch('db.username')}",
  verbose_opts
)
logger.success("PG: .env DB_USERNAME=[#{confs.fetch('db.username')}]")
gsub_file('.env',
  'DB_PASSWORD=',
  "DB_PASSWORD=#{confs.fetch('db.password')}",
  verbose_opts
)
logger.success("PG: .env DB_PASSWORD=[#{confs.fetch('db.password')}]")
logger.success("added PostgreSQL DB configs")

db_pgsql_create(confs.fetch('db.database'), confs.fetch('db.username')) unless db_pgsql_exists?

artisan_migrate 'migrated DB'


patch_end
puts

# sudo -u postgres createdb -O kzen grl_admin_app
