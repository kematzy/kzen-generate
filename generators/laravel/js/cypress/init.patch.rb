# add Cypress support to a [new] Laravel project

# DOCS:

set_current_patch 'js:cypress:init'

puts
patch_start


# set the config value if not set
confs.set('js.cypress', value: true) unless confs.fetch('js.cypress')


npm_install_dev_if_not_installed?('cypress')

run('npx cypress open', debug_opts)

contents = <<-NEW
# CYPRESS: Ignore the default installs
cypress/fixtures/example.json
# cypress/fixtures/users.json
cypress/integration/examples
cypress/screenshots/
cypress/support/routes.json
database/cypress.sqlite
NEW
append_to_file('.gitignore', contents, verbose_opts)
# git_commit('gitignore cypress examples')
# logger.success "gitignored cypress examples"

git_commit('npx cypress open & updated .gitignore')
logger.success "ran nxp cypress open & updated .gitignore"


find = "{}"
replace = <<-NEW
{
  "baseUrl": "http://#{confs.fetch('project_name')}.test",
  "viewportWidth": 1280,
  "viewportHeight": 900,
  "env": {
    "site_title": "Laravel, InertiaJS & Svelte Starter",
    "site_description": "Laravel, InertiaJS & Svelte Starter ($store)"
  }
}
NEW
gsub_file('cypress.json', find, replace, verbose_opts)
git_commit('add baseUrl & env to cypress.json')
logger.success 'added baseUrl & env to cypress.json'

composer_install('laracasts/cypress --dev')

artisan_cmd('cypress:boilerplate')

gsub_file('.env.cypress', 'APP_ENV=local', 'APP_ENV=cypress', verbose_opts)
logger.success 'updated APP_ENV in .env.cypress file'

db_file = "#{File.expand_path(Dir.pwd)}/database/cypress.sqlite"
replace = <<-NEW
DB_CONNECTION=sqlite
DB_DATABASE=#{db_file}
DB_FOREIGN_KEYS=true
NEW
gsub_file('.env.cypress', 'DB_CONNECTION=sqlite', replace, verbose_opts)
logger.success 'updated DB setting in .env.cypress file'

gsub_file('.env.cypress', 'MAIL_MAILER=smtp', 'MAIL_MAILER=log', verbose_opts)
logger.success 'updated MAIL_MAILER in .env.cypress file'

git_commit('updated .env.cypress file')
logger.success 'updated .env.cypress file'

run("touch #{db_file}", debug_opts)
logger.success 'created cypress.sqlite file'

artisan_cmd('migrate --env cypress')
logger.success 'migrated cypress.sqlite database'

find = '"production": "TAILWIND_MODE=build NODE_ENV=production mix --production"'
replace = <<-NEW
"production": "TAILWIND_MODE=build NODE_ENV=production mix --production",
"cypress:open": "cypress open"
NEW

gsub_file('package.json', find, replace, verbose_opts)
git_commit('updated package.json with Cypress starter')
logger.success 'updated package.json with Cypress starter'


find = <<-OLD
    on('task', require('./swap-env'));
OLD
replace = <<-NEW
    on('task', require('./swap-env'));

    // ignore the default example files
    config.ignoreTestFiles = "**/examples/*.spec.js";
    return config;
NEW

gsub_file('cypress/plugins/index.js', find, replace, verbose_opts)
git_commit('hide Cypress examples in Cypress UI')
logger.success 'ignored Cypress examples in Cypress UI'


template(tmpl_file("js/cypress/integration/pages/welcome.spec.js"), 'cypress/integration/pages/welcome.spec.js', verbose_opts)
git_commit('added welcome.spec tests')
logger.success 'added welcome.spec tests'

patch_end
puts
