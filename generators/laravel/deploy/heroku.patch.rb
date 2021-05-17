# Setting up Heroku deployment

# DOCS: https://devcenter.heroku.com/articles/getting-started-with-laravel#creating-a-procfile

set_current_patch 'deploy:heroku'

puts
patch_start

# TODO: add more Heroku deployment setups here and test for current status so that script can be used on both new projects
#       and live projects.

contents = <<~PROCFILE
web: vendor/bin/heroku-php-nginx public/
PROCFILE

create_file('Procfile', contents, verbose_opts)
git_commit('added Heroku Procfile')
logger.success 'added Heroku Procfile'


patch_end
puts
