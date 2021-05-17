# Configure a MySQL DB for a new Laravel project

## TASKS:

# 1) change the info in .env file
# 2) create the postgres database
# 3) migrate database

set_current_patch 'db:mysql'

puts
patch_start


logger.debug("db => [#{confs.fetch('db').inspect}]")

# replace_in_file('.env', [
#   { find: 'DB_CONNECTION=mysql',  replace: "DB_CONNECTION=#{confs.fetch('db.type')}" },
#   { find: 'DB_HOST=127.0.0.1',    replace: "DB_HOST=#{confs.fetch('db.host')}" },
#   { find: 'DB_PORT=3306',         replace: "DB_PORT=#{confs.fetch('db.port')}" },
#   { find: 'DB_DATABASE=laravel',  replace: "DB_DATABASE=#{confs.fetch('db.database')}" },
#   { find: 'DB_USERNAME=root',     replace: "DB_USERNAME=#{confs.fetch('db.username')}" },
#   { find: 'DB_PASSWORD=',         replace: "DB_PASSWORD=#{confs.fetch('db.password')}", },
# ],
# 'added MySQL DB configs'
# )


gsub_file('.env',
  'DB_HOST=127.0.0.1',
  "DB_HOST=#{confs.fetch('db.host')}",
  verbose_opts
)
unless confs.fetch('db.port') == 3306
  gsub_file('.env',
    'DB_PORT=3306',
    "DB_PORT=#{confs.fetch('db.port')}",
    verbose_opts
  )
end
gsub_file('.env',
  'DB_DATABASE=laravel',
  "DB_DATABASE=#{confs.fetch('db.database')}",
  verbose_opts
)
gsub_file('.env',
  'DB_USERNAME=root',
  "DB_USERNAME=#{confs.fetch('db.username')}",
  verbose_opts
)
gsub_file('.env',
  'DB_PASSWORD=',
  "DB_PASSWORD=#{confs.fetch('db.password')}",
  verbose_opts
)
logger.success('added MySQL DB configs')

# say_status :info, "commented out default DB configs"

db_mysql_create(confs.fetch('db.username'), confs.fetch('db.database')) unless db_mysql_exists?

# logger.info('creating db starting')
# # begin
#   run("/usr/bin/mysql -u #{confs.fetch('db.username')} -e \"CREATE DATABASE IF NOT EXISTS #{confs.fetch('db.database')}\";", debug_opts)
#   logger.success('created mysql DB file')
# # rescue => SystemExit
# #   logger.fatal("creating database '#{bbr(confs.fetch('db.database'))}' failed")
# # end
# logger.info('creating db finished')

artisan_migrate('migrated DB')


# patch_end
patch_end
puts
