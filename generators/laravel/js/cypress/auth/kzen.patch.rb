# add Cypress tests for Kzen Auth support to a [new] Laravel project

# DOCS:

set_current_patch 'js:cypress:auth:kzen'

puts
patch_start


if cypress?

  template(tmpl_file("auth/kzen/cypress/UserSeeder.php"), 'database/seeders/UserSeeder.php', verbose_opts)
  git_commit('add UserSeeder for Cypress tests')
  logger.success 'add UserSeeder for Cypress tests'

find = <<-OLD
use Illuminate\\Database\\Seeder;
OLD
replace = <<-NEW
use Illuminate\\Database\\Seeder;
use Database\\Seeders\\UserSeeder;
NEW

  gsub_file('database/seeders/DatabaseSeeder.php', find, replace, verbose_opts)

find = <<-OLD
        // \\App\\Models\\User::factory(10)->create();
OLD
replace = <<-NEW
        // \\App\\Models\\User::factory(10)->create();
        $this->call([
          UserSeeder::class,
        ]);
NEW
  gsub_file('database/seeders/DatabaseSeeder.php', find, replace, verbose_opts)
  git_commit('update DatabaseSeeder with UserSeeder')
  logger.success 'update DatabaseSeeder with UserSeeder'


  [
    'cypress/integration/pages/admin/dashboard.spec.js',
    'cypress/integration/pages/auth/forgot-password.spec.js',
    'cypress/integration/pages/auth/login.spec.js',
    'cypress/integration/pages/auth/register.spec.js',
    'cypress/integration/pages/auth/reset-password.spec.js',
    'cypress/integration/pages/privacy-policy.spec.js',
    'cypress/integration/pages/terms-of-service.spec.js',
  ].each do |c|
    template(tmpl_file("auth/kzen/#{c}"), c, verbose_opts)
    git_commit("add Cypress spec: #{c} file")
    logger.success "added Cypress spec: #{c} file"
  end

find = <<-OLD
      //auth_links
OLD
replace = <<-NEW
    describe('User Auth links', () => {

      describe('when logged out', () => {

        before(() => {
          cy.visit('/')
        })

        describe('the Login link', () => {

          it('is present and has the correct text, link and classes', () => {
            cy.get('[href*="/login"]')
              .should('have.text', 'Login')
              .and('have.class', 'text-sm')
          })

        })
        // /the Login link

        describe('the Register link', () => {

          it('is present and has the correct text, link and classes', () => {
            cy.get('[href*="/register"]')
              .should('have.text', 'Register')
              .and('have.class', 'ml-4 text-sm')
          })

        })
        // /the Register link

        describe('the Dashboard link', () => {

          it('is NOT present', () => {
            cy.get('[href*="/admin/dashboard"]').should('not.exist')
          })

        })
        // /the Dashboard link


      })
      // /when logged out


      describe('when logged in', () => {

        beforeEach(() => {
          cy.login({ email: 'joeblogs@email.com' })
          cy.visit('/')
        })

        describe('the Dashboard link', () => {

          it('is present and has the correct text, link and classes', () => {
            cy.get('[href*="/admin/dashboard"]')
              .should('have.text', 'Admin')
              .and('have.class', 'ml-4 text-sm')
          })

        })

        describe('the Login link', () => {

          it('is NOT present', () => {
            cy.get('[href*="/login"]').should('not.exist')
          })

        })
        // /the Login link

        describe('the Register link', () => {

          it('is NOT present', () => {
            cy.get('[href*="/register"]').should('not.exist')
          })

        })
        // /the Register link

      })
      // /when logged in

    })
    // /User Auth links
NEW
  gsub_file('cypress/integration/pages/welcome.spec.js', find, replace, verbose_opts)
  git_commit('update cypress/pages/welcome with Auth links')
  logger.success 'update cypress/pages/welcome with Auth links'

  npm_run_dev

else
  patch_required_for_feature('js:cypress', 'Cypress')
end

patch_end
puts
