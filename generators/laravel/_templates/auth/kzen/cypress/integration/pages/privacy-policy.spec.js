// pages/terms-of-service.spec.js created with Cypress

describe('Zen Admin Starter (Laravel, InertiaJS & Svelte)', () => {

  context('GET /privacy-policy', () => {

    context('HTML output', () => {

      before(() => {
        cy.refreshDatabase()
        cy.seed()
        cy.visit('/privacy-policy')
      })

      describe('SEO tags', () => {

        it('has the correct <title>', () => {
          cy.title().should('eq', `Our Privacy Policy | ${Cypress.env('site_title')}`)
        })

        it('has the correct <meta description>', () => {
          cy.get('meta[name="description"]')
            .should('have.attr', 'content', Cypress.env('site_description'));
        })

      })
      // /SEO tags


      describe('the Logo', () => {

        it('is an svg embedded in a link to homepage', () => {
          cy.get('.auth-terms-wrapper .auth-terms-inner a[href*="/"]')
            .should('have.attr', 'title', 'back to the main page')
            .find('svg#logo')
              .should('have.attr', 'viewBox', '0 0 160 25')
              .should('have.class', 'fill-current h-10 w-auto')
        })

      })
      // /the Logo


      describe('the Page Contents', () => {

        it('contains an H2 header with the correct text', () => {
          cy.get('.auth-terms-contents h2')
            .contains('Our Privacy Policy')
        })

        it('contains a paragraph with the correct text', () => {
          cy.get('.auth-terms-contents p:first')
            .contains('Edit this file to define the privacy policy for your application.')
        })

      })
      // /the Page Contents

    })
    // /context HTML Output

  })
  // Context GET /privacy-policy

})
// /Zen Admin Starter (Laravel, InertiaJS & Svelte)
