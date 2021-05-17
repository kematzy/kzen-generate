# set up db in a [new] Laravel project


set_current_patch 'db'

puts
patch_start


logger.info("db => [#{confs.fetch('db').inspect}]")

run_prompt('db') unless confs.fetch(:silent)


patch_end
puts
