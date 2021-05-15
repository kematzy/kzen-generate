# prompts:  laravel db

puts
logger.debug("start prompt: #{current_patch}")

# check if we have db.type already defined
db = confs.fetch('db.type')
say_status :debug, "db is =>: #{db.inspect}"
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
    confs.set('db.host', value: prompt.ask("Add the DB Host", default: '127.0.0.1'))
    # port
    confs.set('db.port', value: prompt.ask("Add the DB Port", default: dbtype == 'mysql' ? '3306' : '5432' ))
    # database
    confs.set('db.database', value: prompt.ask("Add the DB database name", default: confs.fetch(:project_name).gsub('-', '_') + '_dev'))
    # username
    confs.set('db.username', value: prompt.ask("Add the DB username", default: dbtype == 'mysql' ? 'root' : 'postgres'))
    # password
    confs.set('db.password', value: prompt.mask("Add the DB password", default: ''))
  end
end
logger.debug("set db to: #{confs.fetch(:db)}")

# confs.set('db.type', value: prompt.select("Choose DB setup?", %w(sqlite pgsql mysql), default: 'sqlite')) unless confs.fetch('db.type')

# handle pg & mysql
# dbtype = confs.fetch('db.type')



puts
logger.debug("end prompt: #{current_patch}")
