# Add mailtrap.io configurations to a [new] Laravel project


set_current_patch 'dev:mail:mailtrap'

puts
patch_start

# set the config value if not set
confs.set('dev.mail.mailtrap', value: true) unless confs.fetch('dev.mail.mailtrap')


gsub_file('.env', 'MAIL_HOST=mailhog', 'MAIL_HOST=smtp.mailtrap.io', verbose_opts)
logger.success 'updated MAIL_HOST setting in .env file'
gsub_file('.env.example', 'MAIL_HOST=mailhog', 'MAIL_HOST=smtp.mailtrap.io', verbose_opts)
logger.success 'updated MAIL_HOST setting in .env.example file'

gsub_file('.env', 'MAIL_PORT=1025', 'MAIL_PORT=2525', verbose_opts)
logger.success 'updated MAIL_PORT setting in .env file'
gsub_file('.env.example', 'MAIL_PORT=1025', 'MAIL_PORT=2525', verbose_opts)
logger.success 'updated MAIL_PORT setting in .env.example file'

# TODO: make the username & passwords dynamic (based on propmpt input)
gsub_file('.env', 'MAIL_USERNAME=null', 'MAIL_USERNAME=5ea4244f31bb3a', verbose_opts)
logger.success 'updated MAIL_USERNAME setting in .env file'

gsub_file('.env', 'MAIL_PASSWORD=null', 'MAIL_PASSWORD=0c413e6b1ecda4', verbose_opts)
logger.success 'updated MAIL_PASSWORD setting in .env file'

gsub_file('.env', 'MAIL_ENCRYPTION=null', 'MAIL_ENCRYPTION=tls', verbose_opts)
logger.success 'updated MAIL_ENCRYPTION setting in .env file'
gsub_file('.env.example', 'MAIL_ENCRYPTION=null', 'MAIL_ENCRYPTION=tls', verbose_opts)
logger.success 'updated MAIL_ENCRYPTION setting in .env.example file'

gsub_file('.env', 'MAIL_FROM_ADDRESS=null', "MAIL_FROM_ADDRESS=admin@#{@project_name}.test", verbose_opts)
logger.success 'updated MAIL_PASSWORD setting in .env file'

git_commit('updated .env files with MailTrap.io info')


patch_end
puts
