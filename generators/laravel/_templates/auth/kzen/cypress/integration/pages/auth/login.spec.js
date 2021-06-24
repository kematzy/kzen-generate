// pages/auth/login.spec.js created with Cypress

describe('Zen Admin Starter (Laravel, InertiaJS & Svelte)', () => {

  context('GET /login', () => {

    context('HTML output', () => {

      before(() => {
        cy.refreshDatabase()
        cy.seed()
        cy.visit('/login')
      })


      describe('SEO tags', () => {

        it('has the correct <title>', () => {
          cy.title().should('eq', `Login | ${Cypress.env('site_title')}`)
        })

        it('has the correct <meta description>', () => {
          cy.get('meta[name="description"]')
            .should('have.attr', 'content', Cypress.env('site_description'));
        })

      })
      // /SEO tags

      describe('the Login Form', () => {

        describe('the Email field ', () => {

          it('has a label with the text Email: and a required span tag', () => {
            cy.get('label[for="email"]')
              .should('have.class', 'form-label')
              .contains('Email')
              .find('span')
                .should('have.class', 'required')
          })

          it('has an input field', () => {
            cy.get('input[type="email"][name="email"][required=""]')
              .should('have.class', 'form-input')
              .should('have.attr', 'autocapitalize', 'off')
          })

          it('accepts input', () => {
            cy.get('input[name="email"]')
              .clear()
              .type("janeblogs@email.com")
              .should("have.value", "janeblogs@email.com")
          })

        })
        // /Email field


        describe('the Password field ', () => {

          it('has a label with the text Password: and a required span tag', () => {
            cy.get('label[for="password"]')
              .should('have.class', 'form-label')
              .contains('Password')
              .find('span')
                .should('have.class', 'required')
          })

          it('has an input field', () => {
            cy.get('input[type="password"][name="password"][required=""]')
              .should('have.class', 'form-input')
          })

          it('accepts input', () => {
            cy.get('input[name="password"]')
              .clear()
              .type("topsecret")
              .should("have.value", "topsecret")
          })

        })
        // /Password field


        describe('the Remember me checkbox', () => {

          it('has a label tag', () => {
            cy.get('label[for="remember"]')
              .should('have.class', 'flex items-center select-none')
              .find('span')
              .should('have.class', 'text-sm')
              .contains('Remember Me?')
          })

          describe('with an embedded input[checkbox]', () => {

            it('that has the correct classes', () => {
              cy.get('input#remember[type="checkbox"]')
                .should('have.class', 'mr-3')
            })

            it('that is checked by default', () => {
              cy.get('input#remember[type="checkbox"]')
                .should('be.checked')
            })

            it('that accepts input', () => {
              cy.get('input#remember[type="checkbox"]')
                .click()
                .should('not.be.checked')
            })

          })
          // /with an embedded input[checkbox]

        })
        // /Remember Me checkbox

        describe('the Login button', () => {

          it('is present and has the correct text & correct classes', () => {
            cy.get('button[type="submit"]')
              .contains('Login')
              .should('have.class', 'btn-primary btn-sm wide')
          })

        })
        // /Login button


        describe('the Register? link', () => {

          it('is present and has the correct text, link and classes', () => {
            cy.get('.auth-alt-page-links  [href*="/register"]')
              .should('have.text', 'Register?')
              .should('have.attr', 'title', 'Please Register if you are not already registered')
              // .and('have.class', '')
          })

          it('should navigate to the register page', () => {
            cy.get('[href*="/register"]').click()
            cy.url().should('eq', `${Cypress.config().baseUrl}/register`)
            cy.visit('/login')
          })

        })
        // /the Register? link

        describe('the Forgot Password link', () => {

          it('is present and has the correct text, link and classes', () => {
            cy.get('.auth-alt-page-links  [href*="/forgot-password"]')
              .should('have.text', 'Forgot Your Password?')
              .should('have.attr', 'title', 'Forgotten your password? Request a reset')
              // .and('have.class', '')
          })

          it('should navigate to the forgot-password page', () => {
            cy.get('[href*="/forgot-password"]').click()
            cy.url().should('eq', `${Cypress.config().baseUrl}/forgot-password`)
            cy.visit('/login')
          })

        })
        // /the Forgot password link

      })
      // the Login Form

    })
    // /context HTML output


    context('Functionality', () => {

      beforeEach(() => {
        cy.refreshDatabase()
        cy.seed()
        cy.visit('/login')
      })

      describe('When logging in', () => {

        describe('shows errors on missing or wrong input', () => {

          // it('should require the password to be present', () => {
          //   cy.get('input[name="email"]').clear().type('janeblogs@email.com')
          //   cy.get('input[name="password"]').clear()
          //   cy.get('button[type="submit"]').click()

          //   cy.get('#error-status')
          //     .contains('The password confirmation does not match')
          // })

          it('should require the correct email', () => {
            cy.get('input[name="email"]').clear().type('doesnotexist@email.com')
            cy.get('input[name="password"]').clear().type('topsecret')
            cy.get('input#remember[type=checkbox]').check()
            cy.get('button[type="submit"]').click()

            cy.get('#error-status')
              .contains('These credentials do not match our records.')
          })

          it('should require the correct password', () => {
            cy.get('input[name="email"]').clear().type('joeblogs@email.com')
            cy.get('input[name="password"]').clear().type('incorrect')
            cy.get('button[type="submit"]').click()

            cy.get('#error-status')
              .contains('These credentials do not match our records.')
          })

        })
        // /shows errors on missing or wrong input


        describe('successfully log in a verified existing user', () => {

          it('and redirects to the Dashboard page', () => {
            cy.get('input[name="email"]').clear().type("joeblogs@email.com")
            cy.get('input[name="password"]').clear().type("password")
            cy.get('input#remember[type=checkbox]').click()
            cy.get('button[type="submit"]').click()

            cy.url()
              .should('not.be.equal', `${Cypress.config().baseUrl}/verify-email`)
              .should('be.equal', `${Cypress.config().baseUrl}/admin/dashboard`)
          })

        })
        // /successfully log in an existing user

        describe('stops an unverified user from accessing the Admin section', () => {

          it('by redirecting to the Email Verify page', () => {
            cy.get('input[name="email"]').clear().type("jillblogs@email.com")
            cy.get('input[name="password"]').clear().type("password")
            cy.get('input#remember[type=checkbox]').click()
            cy.get('button[type="submit"]').click()

            cy.url()
              .should('be.equal', `${Cypress.config().baseUrl}/verify-email`)
            cy.get('h3')
              .contains('Verify Your Email')

            cy.visit('/admin/dashboard')
              .assertRedirect('/verify-email')
          })

        })
        // /stops an unverified user from accessing the Admin section

      })
      // /When logging in

    })
    // /Functionality

  })
  // Context GET /login

})
// /Zen Admin Starter (Laravel, InertiaJS & Svelte)
