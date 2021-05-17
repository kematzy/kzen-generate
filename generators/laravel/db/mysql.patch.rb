# Configure a MySQL DB for a new Laravel project

## TASKS:

# 1) change the info in .env file
# 2) create the postgres database
# 3) migrate database

set_current_patch 'db:mysql'

puts
patch_start


logger.debug("db => [#{confs.fetch('db').inspect}]")

replace_in_file('.env', [
  { find: 'DB_CONNECTION=mysql',  replace: "DB_CONNECTION=#{confs.fetch('db.type')}" },
  { find: 'DB_HOST=127.0.0.1',    replace: "DB_HOST=#{confs.fetch('db.host')}" },
  { find: 'DB_PORT=3306',         replace: "DB_PORT=#{confs.fetch('db.port')}" },
  { find: 'DB_DATABASE=laravel',  replace: "DB_DATABASE=#{confs.fetch('db.database')}" },
  { find: 'DB_USERNAME=root',     replace: "DB_USERNAME=#{confs.fetch('db.username')}" },
  { find: 'DB_PASSWORD=',         replace: "DB_PASSWORD=#{confs.fetch('db.password')}", },
],
'added MySQL DB configs'
)


# # gsub_file(
# #   '.env',
# #   'DB_CONNECTION=mysql',
# #   'DB_CONNECTION=mysql',
# #   verbose_opts
# # )
# gsub_file(
#   '.env',
#   'DB_HOST=127.0.0.1',
#   'DB_HOST=localhost',
#   verbose_opts
# )
# # gsub_file(
# #   '.env',
# #   'DB_PORT=3306',
# #   'DB_PORT=3306',
# #   verbose_opts
# # )
# gsub_file(
#   '.env',
#   'DB_DATABASE=laravel',
#   "DB_DATABASE=#{db_name}",
#   verbose_opts
# )
# gsub_file(
#   '.env',
#   'DB_USERNAME=root',
#   'DB_USERNAME=kzen',
#   verbose_opts
# )
# gsub_file(
#   '.env',
#   'DB_PASSWORD=',
#   'DB_PASSWORD=',
#   verbose_opts
# )
# say_status :info, "added MySQL DB configs"

# say_status :info, "commented out default DB configs"

run("/usr/bin/mysql -u #{confs.fetch('db.username')} -e \"CREATE DATABASE #{confs.fetch('db.database')}\";", debug_opts)
logger.success "created mysql DB file"

artisan_migrate "migrated DB"


# patch_end
patch_end
puts
