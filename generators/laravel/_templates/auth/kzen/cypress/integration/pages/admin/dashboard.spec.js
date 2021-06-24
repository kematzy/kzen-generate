// pages/admin/dashboard.spec.js created with Cypress

describe('Zen Admin Starter (Laravel, InertiaJS & Svelte)', () => {

  context('GET /admin/dashboard', () => {

    context('HTML output', () => {

      before(() => {
        cy.refreshDatabase()
        cy.seed()
        cy.login({ email: 'joeblogs@email.com' })
        cy.visit('/admin/dashboard')
      })

      describe('SEO tags', () => {

        it('has the correct <title>', () => {
          cy.title().should('eq', `Dashboard | ${Cypress.env('site_title')}`)
        })

        it('has the correct <meta description>', () => {
          cy.get('meta[name="description"]')
            .should('have.attr', 'content', Cypress.env('site_description'));
        })

      })
      // /SEO tags


      describe('the Header', () => {

        it('should have the correct classes', () => {
          cy.get('#header')
            .should('have.class', 'fixed top-0 z-20 flex items-center justify-between w-full p-2 shadow')
            // should find the
        });

        describe('the first nav element', () => {

          it('should have a Hamburger button', () => {
            cy.get('#header nav:first button#btn-hamburger')
              .should('have.class', 'mr-4 border-none cursor-pointer z-20')
                .find('svg')
                  .should('have.attr', 'width', 30)
                  .should('have.attr', 'height', 20)
          });

          it('should have the zenAdmin logo svg embedded', () => {
            cy.get('#header nav:nth-child(1) svg#logo')
              // .should('have.attr', 'viewbox', '0 0 160 25')
              .should('have.class', 'fill-current h-5 pl-2 md:h-6 md:pl-6')
          })

        });


        describe('the second nav element', () => {

          it('should have a Help button', () => {
            cy.get('#header nav:nth-child(2) button#btn-help')
              .should('have.class', 'btn nav-icon')
              .should('have.attr', 'title', 'TODO: add Help section here')
              .find('i')
                .should('have.class', 'las la-question-circle nav-icon')
          });

          describe('should have a Dropdown User menu', () => {

            it('with the correct id and classes', () => {
              cy.get('#header nav:nth-child(2) #dropdown-user')
                .should('have.class', 'relative')
            });

            it('with a trigger button and user-circle icon', () => {
              cy.get('#header #dropdown-user .dropdown-trigger button')
                .should('have.class', 'btn nav-icon')
                .should('have.attr', 'title', 'User dropdown menu...')
                  .find('i')
                    .should('have.class', 'las la-user-circle nav-icon')
            });

            it('with a hidden .dropdown-overlay', () => {
              cy.get('#header #dropdown-user .dropdown-overlay')
                .should('have.attr', 'style', 'display: none;')
            });

            it('with a hidden .dropdown-menu', () => {
              cy.get('#header #dropdown-user .dropdown-menu')
                .should('have.class', 'dropdown-menu origin-top-right right-0 w-64')
                .should('have.attr', 'style', 'display: none;')
              cy.get('.dropdown-menu div')
                .should('have.class', 'rounded-md ring-1 ring-black ring-opacity-5 py-1')
            });

            it('with a header displaying the current User\'s name', () => {
              cy.get('#dropdown-user .dropdown-menu div :nth-child(1)')
                .should('have.class', 'dropdown-header')
                .find('small')
                  .contains('Current User:')
              cy.get('#dropdown-user .dropdown-header span')
                .contains('Joe Blogs')
            });

            it('with dividers as the 2nd, 4th & 7th items', () => {
              cy.get('#dropdown-user .dropdown-menu div :nth-child(2)')
                .should('have.class', 'dropdown-item-divider')
              cy.get('#dropdown-user .dropdown-menu div :nth-child(4)')
                .should('have.class', 'dropdown-item-divider')
              cy.get('#dropdown-user .dropdown-menu div :nth-child(7)')
                .should('have.class', 'dropdown-item-divider')
            });

            it('with a mode (Theme) Switcher', () => {
              cy.get('#dropdown-user .dropdown-menu div :nth-child(3)')
                .contains('Light Mode')
              cy.get('#dropdown-user .dropdown-menu div :nth-child(3)')
                .should('have.class', 'dropdown-item')
                  .find('button')
                    .should('have.attr', 'title', 'theme switcher (dark / light modes)')
                      .find('span')
                        .should('have.class', 'flex flex-row items-center justify-start')
                        .find('i')
                          .should('have.class', 'las la-adjust nav-icon transform rotate-180')
            });

            it('with a link to the User\'s Profile page', () => {
              cy.get('#dropdown-user .dropdown-menu div :nth-child(5)')
                .contains('Profile')
              cy.get('#dropdown-user .dropdown-menu div :nth-child(5)')
                .should('have.class', 'dropdown-item')
                  .find('a.dropdown-item-link[href*="/admin/user/profile"]')
                    .should('have.class', 'dropdown-item-link')
                    .should('have.attr', 'title', 'edit your profile')
                      .find('span')
                        .should('have.class', 'flex flex-row items-center justify-start')
                          .find('i')
                            .should('have.class', 'las la-user-alt nav-icon')
            });

            it('with a link to the Settings page', () => {
              cy.get('#dropdown-user .dropdown-menu div :nth-child(6)')
                .contains('Settings')
              cy.get('#dropdown-user .dropdown-menu div :nth-child(6)')
                .should('have.class', 'dropdown-item')
                  .find('a.dropdown-item-link[href*="/admin/settings"]')
                    .should('have.class', 'dropdown-item-link')
                    .should('have.attr', 'title', 'access site-wide settings')
                      .find('span')
                        .should('have.class', 'flex flex-row items-center justify-start')
                          .find('i')
                            .should('have.class', 'las la-cog nav-icon')
            });

            it('with a Logout button', () => {
              cy.get('#dropdown-user .dropdown-menu div :nth-child(8)')
                .contains('Logout')
              cy.get('#dropdown-user .dropdown-menu div :nth-child(8)')
                .should('have.class', 'dropdown-item')
                  .find('a.dropdown-item-link[href*="/logout"]')
                    .should('have.class', 'dropdown-item-link')
                    .should('have.attr', 'title', 'log out from the Admin section')
                      .find('span')
                        .should('have.class', 'flex flex-row items-center justify-start')
                          .find('i')
                            .should('have.class', 'las la-power-off nav-icon')
            });

          });

        });

      })
      // /the Header


      describe.skip('the Page contents', () => {

        it('has a main section with the Welcome contents included', () => {
          cy.get('main > .py-12 > div')
            .should('have.class', 'max-w-7xl mx-auto sm:px-6 lg:px-8')
            .within(($main) => {
              cy.get('div')
                .should('have.class', 'bg-white overflow-hidden shadow-xl sm:rounded-lg')

              cy.get('div > div')
                .should('have.class', 'p-6 sm:px-20 bg-white border-b border-gray-200')
            })
        })

        it('the Welcome contents include a header section', () => {
          cy.get('main > .py-12 > .max-w-7xl > .bg-white > div > div')
            .should('have.class', 'p-6 sm:px-20 bg-white border-b border-gray-200')
            .within(($main) => {
              cy.get('div > div > svg')
                .should('have.class', 'block h-12 w-auto')
                .should('have.attr', 'viewBox', '0 0 317 48')

              cy.get('div.mt-8.text-2xl')
                .contains('Welcome to your Jetstream application!')
              cy.get('div.mt-6.text-gray-500')
                .contains('Laravel Jetstream provides a beautiful, robust starting point for your next Laravel application.')
            })
        })

      })
      // /the Page contents

    })
    // /HTML output


    context('Functionality', () => {

      beforeEach(() => {
        cy.refreshDatabase()
        cy.seed()
        cy.login({ email: 'joeblogs@email.com' })
        cy.visit('/admin/dashboard')
      })


      describe('Hamburger button / OverlayNav', () => {

        it('should toggle the Navigation Overlay', () => {
          cy.get('#btn-hamburger')
            .click()

          cy.get('#overlay-nav')
            .should('be.visible')

          cy.get('#btn-hamburger')
            .click()

          cy.get('#overlay-nav')
            .should('not.be.visible')
        });

      });


      describe('Help button / OverlayHelp', () => {

        it('should toggle the Help Overlay', () => {
          cy.get('#btn-help')
            .click()

          cy.get('#overlay-help')
            .should('be.visible')

          cy.get('#btn-help')
            .click()

          cy.get('#overlay-help')
            .should('not.be.visible')

        });
      });


      describe('Dropdown functionality', () => {

        it('should toggle the User Dropdown menu', () => {
          cy.get('#dropdown-user .dropdown-trigger')
            .click()

          cy.get('#dropdown-user .dropdown-menu')
            .should('be.visible')

            cy.get('#dropdown-user .dropdown-overlay')
            .should('be.visible')

          cy.get('#dropdown-user .dropdown-overlay')
            .click()

          cy.get('#dropdown-user .dropdown-overlay')
            .should('not.be.visible')

          cy.get('#dropdown-user .dropdown-menu')
            .should('not.be.visible')
        })

      })
      // /Dropdown functionality


      describe('Logout', () => {

        before(() => {
          cy.intercept('POST', '/logout').as('postLogout')
          cy.intercept('GET', '/').as('getHome')
        })

        it('should handle clicks to logout', () => {
          cy.get('#dropdown-user .dropdown-trigger')
            .click()

          cy.get('#dropdown-user a[href*="/logout"]')
            .click()

          cy.wait('@postLogout')
            .its('response.body')
              .should('contain', 'Redirecting')

          cy.wait('@getHome').url()
            .should('be.equal', `${Cypress.config('baseUrl')}/`)
        })

      })
      // /Logout

    })
    // /Functionality

  })
  // Context GET /dashboard

})
// /Zen Admin Starter (Laravel, InertiaJS & Svelte)
