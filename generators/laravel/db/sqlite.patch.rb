# set up a SQLite db in a [new] Laravel project


puts
logger.begin("patch: db:sqlite")

confs.append_path(Dir.pwd)
confs.read

logger.debug "db =>  [#{confs.fetch('db').inspect}]"

# # run prompt unless silent
# run_prompt('db') unless confs.fetch(:silent)

db_fullpath = "database/database.sqlite"

gsub_file('.env', 'DB_', '# DB_', verbose_opts)
logger.info "commented out default DB configs"
# logger.info "pwd: [#{`pwd`.chomp}]"

insert_into_file(
  '.env',
  "\n\nDB_CONNECTION=sqlite",
  { after: "LOG_LEVEL=debug" }.merge(verbose_opts)
)
logger.info "added SQLite DB configs"

run("touch #{db_fullpath}", debug_opts)
logger.success "created SQLite DB file"

artisan_migrate "migrated DB"

append_to_file('.gitignore', "\n\n# ignore SQLite DBs\n*.sqlite", verbose_opts)
git_commit('db:sqlite: configured SQLite DB setup')
logger.info "committed db:sqlite setup"


logger.end("patch: db:sqlite")
puts
