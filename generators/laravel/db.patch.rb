# set up db in a [new] Laravel project

# say "\n"
# say_status 'laravel:db', "--> start"
puts
logger.begin(current_patch)

confs.append_path(Dir.pwd)
confs.read

# say_status 'debug:laravel:db', confs.fetch('db').inspect, :yellow
logger.info "db =>  [#{confs.fetch('db').inspect}]"

# run prompt unless silent
run_prompt('db') unless confs.fetch(:silent)


puts
logger.end(current_patch)
