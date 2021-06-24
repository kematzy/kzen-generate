// pages/welcome.spec.js created with Cypress

describe('Laravel (InertiaJS & Svelte)', () => {
  context('GET / (welcome)', () => {

    context('HTML output', () => {

      before(() => {
        cy.refreshDatabase()
        cy.seed()
        cy.visit('/')
      })

      describe('SEO tags', () => {

        // beforeEach(() => {})

        it('has the correct <title>', () => {
          cy.title().should('eq', `Welcome | ${Cypress.env('site_title')}`)
        })

        it('has the correct <meta description>', () => {
          cy.get('meta[name="description"]')
            .should('have.attr', 'content', Cypress.env('site_description'));
        })

      })
      // /SEO tags


      //auth_links


    })
    // /context HTML Output

  })
  // Context GET /

})
// /Laravel (InertiaJS & Svelte)
