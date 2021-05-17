# Tests for database table exists

set_current_patch 'db:exists' # current patch

puts
patch_start


db_sqlite_exists? if db_sqlite?

db_mysql_exists? if db_mysql?

db_pgsql_exists? if db_pgsql?


patch_end
# puts
