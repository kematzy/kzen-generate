// pages/auth/forgot-password.spec.js created with Cypress

describe('Zen Admin Starter (Laravel, InertiaJS & Svelte)', () => {
  context('GET /forgot-password', () => {

    context('HTML Output', () => {

      before(() => {
        cy.refreshDatabase()
        cy.seed()
        cy.visit('/forgot-password')
      })


      describe('SEO tags', () => {

        it('has the correct <title>', () => {
          cy.title().should('eq', `Forgot Your Password? | ${Cypress.env('site_title')}`)
        })

        it('has the correct <meta description>', () => {
          cy.get('meta[name="description"]')
            .should('have.attr', 'content', Cypress.env('site_description'));
        })

      })
      // /SEO tags


      describe('the ForgotPassword Form', () => {

        describe('the Email field ', () => {

          it('has a label with the text Email: and a required span tag', () => {
            cy.get('label[for="email"]')
              .should('have.class', 'form-label')
              .contains('Email')
              .find('span')
                .should('have.class', 'required')
          })

          it('has an input field', () => {
            cy.get('input[type="email"][name="email"][required]')
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


        describe('the ForgotPassword button', () => {

          it('is present and has the correct type, text and classes', () => {
            cy.get('button[type="submit"')
              .contains('Send Reset Email')
              .should('have.class', 'btn-primary btn-sm wide')
          })

        })
        // /ForgotPassword button

      })
      // the ForgotPassword Form

    })
    // /context HTML Output


    context('Functionality', () => {

      beforeEach(() => {
        cy.refreshDatabase()
        cy.seed()
        cy.visit('/forgot-password')
      })

      describe('When submitting the form', () => {

        describe('shows errors on missing or wrong input', () => {

          it('should require the correct email', () => {
            cy.get('input[name="email"]').clear().type('nonexistant@email.com')
            cy.get('button[type="submit"]').click()

            cy.get('#input-email > .form-error')
              .contains('We can\'t find a user with that email address.')
          })

        })
        // /shows errors on missing or wrong input

        describe('forgot-password works successfully', () => {

          it('and redirects back to the Forgot Password page with the correct status message', () => {
            cy.get('input[name="email"]').clear().type('joeblogs@email.com')
            cy.get('button[type="submit"]').click()

            cy.get('div.mb-4.text-sm.font-medium.text-success-400')
              .contains('We have emailed your password reset link!')

            cy.url()
              .should('be.equal', `${Cypress.config().baseUrl}/forgot-password`)
          })

        })
        // /forgot-password works successfully

      })
      // /When submitting the form

    })
    // /context Functionality

  })
  // Context GET /forgot-password

})
// /Zen Admin Starter (Laravel, InertiaJS & Svelte)
