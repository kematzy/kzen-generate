# prompts:  laravel db


set_current_prompt 'db'

puts
prompt_start


# check if we have db.type already defined
db = confs.fetch('db.type')
logger.debug("db is =>: #{db.inspect}")

defaults = {
  sqlite: { name: 'database' },
  pgsql:  { host: '127.0.0.1', port: '5432', username: 'kzen', password: '123456' },
  mysql:  { host: 'localhost', port: '3306', username: 'kzen', password: '' },
}

# db: can either be:
#   1) nil (nothing here)
#   2) a string (sqlite)
#   2) a hash (pg/mysql)

if confs.fetch('db.type')
  dbtype = confs.fetch('db.type')

  # if dbtype != 'sqlite'
  #   # confirm settings exists
  #   host = confs.fetch('db.host')
  #   confs.set('db.host', value: prompt.ask("Confirm the DB Host", default: host ? host : '127.0.0.1'))

  #   port = confs.fetch('db.port')
  #   confs.set('db.port', value: prompt.ask("Confirm the DB port", default: port ? port : (dbtype == 'mysql' ? '3306' : '5432')))

  #   database = confs.fetch('db.database')
  #   confs.set('db.database', value: prompt.ask("Confirm the DB database", default: database ? database : confs.fetch(:project_name).gsub('-', '_') + '_dev') )

  #   username = confs.fetch('db.username')
  #   confs.set('db.username', value: prompt.ask("Confirm the DB username", default: username ? username : (dbtype == 'mysql' ? 'root' : 'postgres') ))

  #   confs.set('db.password', value: prompt.mask("Retype your DB password if any", default: ''))
  # end
else
  dbtype = prompt.select("Choose DB setup?", %w(sqlite pgsql mysql), default: 'sqlite')
  confs.set('db.type', value: dbtype)

  if dbtype != 'sqlite'
    # host
    confs.set('db.host', value: prompt.ask("Add the DB Host", default: defaults[dbtype.to_sym][:host]))
    # port
    confs.set('db.port', value: prompt.ask("Add the DB Port", default: defaults[dbtype.to_sym][:port]))
    # database
    confs.set('db.database', value: prompt.ask("Add the DB database name", default: confs.fetch(:project_name).gsub('-', '_') + '_dev'))
    # username
    confs.set('db.username', value: prompt.ask("Add the DB username", default: defaults[dbtype.to_sym][:username]))
    # password
    confs.set('db.password', value: prompt.ask("Add the DB password", default: defaults[dbtype.to_sym][:password]))
  end
end
logger.info("set db to: #{confs.fetch(:db)}")


prompt_end
puts
