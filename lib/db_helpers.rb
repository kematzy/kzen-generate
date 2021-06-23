

module Kzen

  module DbHelpers

    def self.included(base) #:nodoc:
      super(base)
      base.extend ClassMethods
    end

    module ClassMethods
    end


    private

      #### DB SQLITE HELPERS

      def db_sqlite?
        confs.fetch('db.type') === 'sqlite'
      end
      alias_method :sqlite?, :db_sqlite?

      def db_sqlite_exists?(dbname = 'database')
        res = File.exists?("database/#{dbname}.sqlite")
        if res
          logger.info("SQLite DB: #{bg(dbname)} exists")
          return true
        else
          logger.warn("SQLite DB: #{bdy(dbname)} does NOT exist")
          return false
        end
      end

      def db_sqlite_create(dbname = 'database')
        run("touch database/#{dbname}.sqlite", debug_opts)
        logger.success("created SQLite DB: #{dbname}")
      end

      def db_sqlite_drop(dbname)
        run("rm database/#{dbname}.sqlite", debug_opts)
        logger.success("deleted SQLite DB: #{dbname}")
      end


      #### DB MYSQL HELPERS

      def db_mysql?
        confs.fetch('db.type') === 'mysql'
      end
      alias_method :mysql?, :db_mysql?

      def db_mysql_exists?(dbname = confs.fetch('db.database'))
        res = `/usr/bin/mysql -u #{confs.fetch('db.username')} -e "SHOW DATABASES" | grep #{confs.fetch('db.database')}`.chomp!
        if res.nil?
          logger.warn("MySQL DB: #{bdy(confs.fetch('db.database'))} does NOT exist")
          return false
        else
          logger.info("MySQL DB: #{bbg(confs.fetch('db.database'))} exists")
          return true
        end
      end

      def db_mysql_create(dbname, dbuser)
        run("/usr/bin/mysql -u #{dbuser} -e \"CREATE DATABASE IF NOT EXISTS #{dbname}\";", debug_opts)
        logger.success("created MySQL DB: #{dbname}")
      end

      def db_mysql_drop(dbname, dbuser)
        run("/usr/bin/mysql -u #{dbuser} -e \"DROP DATABASE IF EXISTS #{dbname}\";", debug_opts)
        logger.success("dropped MySQL DB: #{dbname}")
      end


      #### DB PGSQL HELPERS

      def db_pgsql?
        confs.fetch('db.type') === 'pgsql'
      end
      alias_method :pgsql?, :db_pgsql?

      def db_pgsql_exists?(dbname = confs.fetch('db.database'))
        res = `/usr/bin/psql -U #{confs.fetch('db.username')} -l |  grep #{confs.fetch('db.database')} | wc -l`.chomp!
        logger.warn("db_pgsql_exists? => [#{res}]")
        if res.to_s === '1'
          logger.info("PostgreSQL DB: #{bbg(confs.fetch('db.database'))} exists")
          return true
        else
          logger.warn("PostgreSQL DB: #{bdy(confs.fetch('db.database'))}) does NOT exist")
          return false
        end
      end

      def db_pgsql_create(dbname, dbuser)
        logger.info("about to create a PostgresSQL DB with dbname=[#{dbname}], user=[#{dbuser}]")
        run("/usr/bin/createdb -U #{dbuser} #{dbname}", debug_opts)
        logger.success("created PostgresSQL DB: #{dbname}")
      end

      def db_pgsql_drop(dbname, dbuser)
        run("/usr/bin/dropdb -U #{dbuser} #{dbname}", debug_opts)
        logger.success("dropped PostgresSQL DB: #{dbname}")
      end

  end

end
