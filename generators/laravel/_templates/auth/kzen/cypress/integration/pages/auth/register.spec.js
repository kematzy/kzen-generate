// pages/auth/register.spec.js created with Cypress

describe('Zen Admin Starter (Laravel, InertiaJS & Svelte)', () => {

  context('GET /register', () => {

    context('HTML output', () => {

      before(() => {
        cy.refreshDatabase()
        cy.seed()
        cy.visit('/register')
      })


      describe('SEO tags', () => {

        it('has the correct <title>', () => {
          cy.title().should('eq', `Register | ${Cypress.env('site_title')}`)
        })

        it('has the correct <meta description>', () => {
          cy.get('meta[name="description"]')
            .should('have.attr', 'content', Cypress.env('site_description'));
        })

      })
      // /SEO tags


      describe('the Register Form', () => {

        describe('the Name field ', () => {

          it('has a label with the text Name: and a required span tag', () => {
            cy.get('label[for="name"]')
              .should('have.class', 'form-label')
              .contains('Name')
              .find('span')
                .should('have.class', 'required')

          })

          it('has an input field', () => {
            cy.get('input[type="text"][name="name"][required]')
              .should('have.class', 'form-input')
              .should('have.attr', 'autocapitalize', 'off')
              // .should('have.attr', 'autofocus')
          })

          it('accepts input', () => {
            cy.get('input[name="name"]')
              .should("have.value", "")
              .type("Jane")
              .should("have.value", "Jane")
          })

        })
        // /Name field


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
              .should('have.attr', 'autocomplete', 'new-password')
          })

          it('accepts input', () => {
            cy.get('input[name="password"]')
              .clear()
              .type("topsecret")
              .should("have.value", "topsecret")
          })

        })
        // /Password field


        describe('the Confirm Password field ', () => {

          it('has a label with the text Password Confirmation: and a required span tag', () => {
            cy.get('label[for="password_confirmation"]')
              .should('have.class', 'form-label')
              .contains('Password Confirmation')
              .find('span')
                .should('have.class', 'required')
          })

          it('has an input field', () => {
            cy.get('input[name="password_confirmation"][type=password][required=""]')
              .should('have.class', 'form-input')
              .should('have.attr', 'autocomplete', 'new-password')
          })

          it('accepts input', () => {
            cy.get('input[name="password_confirmation"]')
              .clear()
              .type("topsecret")
              .should("have.value", "topsecret")
          })

        })
        // /Confirm Password field


        describe('the Terms & Privacy checkbox', () => {

          it('has a label tag', () => {
            cy.get('label[for="terms"]')
              .should('have.class', 'flex items-center mt-12 select-none')
              .find('span')
              .should('have.class', 'text-sm')
              .contains('I agree to the Terms of Service and Privacy Policy')
          })

          describe('with an embedded input[checkbox]', () => {

            it('that has the correct classes', () => {
              cy.get('input#terms[type="checkbox"]')
                .should('have.class', 'mr-3')
            })

            it('that is unchecked by default', () => {
              cy.get('input#terms[type="checkbox"]')
                .should('not.be.checked')
            })

            it('that accepts input', () => {
              cy.get('input#terms[type="checkbox"]')
                .click()
                .should('be.checked')
            })

          })
          // /with an embedded input[checkbox]


          describe('contains a Terms of Service link', () => {

            it('that links to the Terms of Service page', () => {
              cy.get('a[href*="/terms-of-service"]')
                .should('have.attr', 'target', '_blank')
                .contains('Terms of Service')
            })

            it('that works', () => {
              cy.get('a[href*="/terms-of-service"]')
                .then(link => {
                  cy.request(link.prop('href'))
                  .its('status')
                  .should('eq', 200)
                })
            })

          })
          // /contains a Terms of Service link

          describe('contains a Privacy Policy link', () => {

            it('that links to the Privacy Policy page', () => {
              cy.get('a[href*="/privacy-policy"]')
                .should('have.attr', 'target', '_blank')
                .contains('Privacy Policy')
            })

            it('that works', () => {
              cy.get('a[href*="/privacy-policy"]')
                .then(link => {
                  cy.request(link.prop('href'))
                    .its('status')
                    .should('eq', 200)
                })
            })

          })
          // /contains a Privacy Policy link

        })
        // /Terms & Privacy checkbox


        describe('the Login link', () => {

          it('is present and has the correct text, link and classes', () => {
            cy.get('.page-links  [href*="/login"]')
              .should('have.text', 'Login?')
              .should('have.attr', 'title', 'back to the Login page')
              // .and('have.class', '')
          })

          it('should navigate to the login page', () => {
            cy.get('[href*="/login"]').click()
            cy.url().should('eq', `${Cypress.config().baseUrl}/login`)
            cy.visit('/register')
          })

        })
        // /the Already Registered link


        describe('the Register button', () => {

          it('is present and has the correct text & correct classes', () => {
            cy.get('button[type="submit"]')
              .contains('Register')
              .should('have.class', 'btn-primary btn-sm wide')
          })

        })
        // /Register button

      })
      // the Register Form

    })
    // /HTML output


    context('Functionality', () => {

      beforeEach(() => {
        cy.refreshDatabase()
        cy.seed()
        cy.visit('/register')
      })


      describe('When registering', () => {

        describe('shows errors on missing or wrong input', () => {

          it('should require the passwords to match', () => {
            cy.get('input[name="name"]').type('Jane')
            cy.get('input[name="email"]').type('janeblogs@email.com')
            cy.get('input[name="password"]').type('topsecret')
            cy.get('input[name="password_confirmation"]').type('notthesame')
            cy.get('button[type="submit"]').click()

            cy.get('#input-password .form-error')
              .contains('The password confirmation does not match')
          })

          it('should warn for existing email', () => {
            cy.get('input[name="name"]').type('Joe')
            cy.get('input[name="email"]').type('joeblogs@email.com')
            cy.get('input[name="password"]').type('topsecret')
            cy.get('input[name="password_confirmation"]').type('topsecret')
            cy.get('input#terms[type=checkbox]').click()
            cy.get('button[type="submit"]').click()

            cy.get('#input-email .form-error')
              .contains('The email has already been taken.')
          })

          it('should require the terms checkbox to be filled', () => {
            cy.get('input[name="name"]').type('Jane')
            cy.get('input[name="email"]').type('janeblogs@email.com')
            cy.get('input[name="password"]').type('topsecret')
            cy.get('input[name="password_confirmation"]').type('topsecret')
            cy.get('button[type="submit"]').click()

            cy.get('#input-terms .form-error')
              .contains('The terms must be accepted.')
          })

        })
        // /shows errors on missing or wrong input


        describe('successfully registers a new user', () => {

          it('and redirects to the Dashboard page', () => {
            cy.get('input[name="name"]').type("Jane")
            cy.get('input[name="email"]').type("janeblogs@email.com")
            cy.get('input[name="password"]').type("topsecret")
            cy.get('input[name="password_confirmation"]').type("topsecret")
            cy.get('input#terms[type=checkbox]').click()
            cy.get('button[type="submit"]').click()

            cy.url()
              .should('be.equal', `${Cypress.config().baseUrl}/verify-email`)
          })

        })
        // /successfully registers a new user

      })
      // /When registering

    })

  })
  // Context GET /register

})
// /Zen Admin Starter (Laravel, InertiaJS & Svelte)
