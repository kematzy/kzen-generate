// pages/auth/reset-password.spec.js created with Cypress

// If you’re having trouble clicking the "Reset Password" button,
// copy and paste the URL below into your web browser:
// http://jetstream-svelte.test/reset-password/f98b4c021e286e15e323204e99d54f0ddc3fd7fdda93421c6ce815fcc6dbd77e?email=jamesblogs%40email.com

let user
let token
let resets

describe('Zen Admin Starter (Laravel, InertiaJS & Svelte)', () => {

  describe('GET /reset-password', () => {

    context('core HTML output', () => {

      // before(() => {
      //   cy.refreshDatabase()
      //   cy.php(`
      //     $user = App\\Models\\User::factory()->state([
      //       'name' => 'James Blogs',
      //       'email' => 'jamesblogs@email.com',
      //     ])->create();

      //     $token = Password::broker()->createToken($user);

      //     Illuminate\\Support\\Facades\\DB::table('password_resets')->insert([
      //       'email' => $user->email,
      //       'token' => $token,
      //     ]);
      //     return [$user, $token];
      //   `).then((res) => {
      //     console.log('results: ', res);
      //     user = res[0];
      //     token = res[1];
      //   })
      //   cy.visit(`/reset-password/${token}?email=jamesblogs%40email.com`)
      // })

      // Illuminate\\Support\\Facades\\DB::table('password_resets')->where(['email' => 'jamesblogs@email.com'])->get();

      before(() => {
        cy.refreshDatabase()
        cy.seed()
        cy.php(`
          return Illuminate\\Support\\Facades\\DB::table('password_resets')->where(['email' => 'jamesblogs@email.com'])->get();
        `).then((user) => {
          token = user[0].token;
          cy.visit(`/reset-password/${token}?email=jamesblogs%40email.com`)
        })
      })

      // it('should access the global token variable', () => {
      //   // expect(true).to.equal(true)
      //   expect(token).not.to.equal('')
      // })

      describe('SEO tags', () => {

        it('has the correct <title>', () => {
          cy.title().should('eq', `Reset Password | ${Cypress.env('site_title')}`)
        })

        it('has the correct <meta description>', () => {
          cy.get('meta[name="description"]')
            .should('have.attr', 'content', Cypress.env('site_description'));
        })

      })
      // /SEO tags


      describe('the ResetPassword Form', () => {

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
              // .should('have.attr', 'autocomplete', 'new-password')
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
              // .should('have.attr', 'autocomplete', 'new-password')
          })

          it('accepts input', () => {
            cy.get('input[name="password_confirmation"]')
              .clear()
              .type("topsecret")
              .should("have.value", "topsecret")
          })

        })
        // /Confirm Password field


        describe('the ResetPassword button', () => {

          it('is present and has the correct type, text and classes', () => {
            cy.get('button[type="submit"')
              .contains('Reset Password')
              .and('have.class', 'btn-primary btn-sm wide')
          })

        })
        // /ResetPassword button

      })
      // the ResetPassword Form

    })
    // /core HTML output


    describe('form submission', () => {

      describe('should require the correct email', () => {
        before(() => {
          cy.refreshDatabase()
          cy.seed()
          cy.php(`
            return Illuminate\\Support\\Facades\\DB::table('password_resets')->where(['email' => 'jamesblogs@email.com'])->get();
          `).then((user) => {
            token = user[0].token;
            cy.visit(`/reset-password/${token}?email=jamesblogs%40email.com`)
          })
        })

        it('should show the correct error message', () => {
          cy.get('input[name="email"]').clear().type('nonexistant@email.com')
          cy.get('input[name="password"]').clear().type('topsecret')
          cy.get('input[name="password_confirmation"]').clear().type('topsecret')
          cy.get('button[type="submit"]').click()

          cy.get('#input-email .form-error')
            .contains('We can\'t find a user with that email address.')
        })

      })
      // /should require the correct email

      describe('should handle an existing but incorrect email', () => {
        before(() => {
          cy.refreshDatabase()
          cy.seed()
          cy.php(`
            return Illuminate\\Support\\Facades\\DB::table('password_resets')->where(['email' => 'jamesblogs@email.com'])->get();
          `).then((user) => {
            token = user[0].token;
            cy.visit(`/reset-password/${token}?email=jamesblogs%40email.com`)
          })
        })

        it('should show the correct error message', () => {
          cy.get('input[name="email"]').clear().type('joeblogs@email.com')
          cy.get('input[name="password"]').clear().type('topsecret')
          cy.get('input[name="password_confirmation"]').clear().type('topsecret')
          cy.get('button[type="submit"]').click()

          cy.get('#input-email .form-error')
            .contains('This password reset token is invalid.')
        })

      })
      // /should handle an existing but incorrect email


      describe('should require the new passwords to match', () => {

        before(() => {
          cy.refreshDatabase()
          cy.seed()
          cy.php(`
            return Illuminate\\Support\\Facades\\DB::table('password_resets')->where(['email' => 'jamesblogs@email.com'])->get();
          `).then((user) => {
            token = user[0].token;
            cy.visit(`/reset-password/${token}?email=jamesblogs%40email.com`)
          })
        })

        it('should show the correct error message', () => {
          cy.get('input[name="password"]').clear().type('topsecret')
          cy.get('input[name="password_confirmation"]').clear().type('notthesame')
          cy.get('button[type="submit"]').click()

          cy.get('#input-password .form-error')
            .contains('The password confirmation does not match')
        })

      })
      // /should require the new passwords to match


      // This bloody test fails with a "email": "This password reset token is invalid." error.
      // I cannot fucking work out why that is the case, so I'm skipping the test.
      describe('should successfully change passwords', () => {

        before(() => {
          cy.refreshDatabase()
          cy.seed()
          // spy on POST requests to /reset-password endpoint
          cy.intercept('POST', '/reset-password').as('postReset')
          // cy.intercept('GET', '/admin/dashboard').as('getDashboard')
          cy.intercept('GET', '/login').as('getLogin')
          cy.php(`
            $user = App\\Models\\User::factory()->state([
              'name' => 'Jenny Blogs',
              'email' => 'jennyblogs@email.com',
            ])->create();

            $token = Illuminate\\Support\\Facades\\Password::broker()->createToken($user);
            DB::table('password_resets')->delete();

            Illuminate\\Support\\Facades\\DB::table('password_resets')->insert([
              'email' => $user->email,
              'token' => $token,
            ]);

            return Illuminate\\Support\\Facades\\DB::table('password_resets')->where(['email' => 'jennyblogs@email.com'])->get();
          `).then((res) => {
            user = res[0];
            token = res[0].token;
            // expect(user).to.deep.equal([{ fuck: 'you' }])
            cy.visit(`/reset-password/${token}?email=jennyblogs%40email.com`)
          })
        })

        it('and redirects to the Login page after change', () => {
          // expect(user.token).not.to.equal('')
          // expect(user.token).to.equal(token)
          cy.get('input[name="email"]').clear().type('jennyblogs@email.com')
          cy.get('input[name="password"]').clear().type('topsecret')
          cy.get('input[name="password_confirmation"]').clear().type('topsecret')
          cy.get('button[type="submit"]')
          .click()

          cy.wait('@postReset')
          .its('response.body')
          .should('contain', 'Redirecting')
          // .should('contain', '/reset-password/')

          // cy.url()
          //   .should('not.be.equal', `/reset-password/${token}?email=jennyblogs%40email.com`)
          //   .should('not.contain', 'The password reset token is invalid')

          cy.get('#input-email .form-error')
            .should('be.equal', 'Fuck my ass you stupid shit!!!')
            // .contains('This password reset token is invalid.')

          // cy.wait('@getLogin')
          //   .url()
          //   .should('be.equal', `${Cypress.config().baseUrl}/login`)
          //   .contains('Your password has been reset!')

          // cy.request({
          //   url: `${Cypress.config().baseUrl}/reset-password`,
          //   method: 'POST',
          //   followRedirect: true, // turn on following redirects
          // }).then((res) => {
          //   expect(res.status).to.eq(302)
          //   expect(res.redirectedToUrl).to.eq(`${Cypress.config().baseUrl}/login`)
          // });



          // cy.url()
          //   .should('be.equal', `${Cypress.config('baseUrl')}/reset-password`)

          // cy.wait('@getDashboard').url()
          //   .should('be.equal', `${Cypress.config('baseUrl')}/admin/dashboard`)

          // cy.then(() => {
          //   expect(urlRedirects).to.have.length(3);
          //   expect(urlRedirects[1]).to.eq(`${Cypress.config('baseUrl')}/page2`);
          //   expect(urlRedirects[2]).to.eq(`${Cypress.config('baseUrl')}/page3`);
          // })


          // cy.get('@reset').should(({ request, response }) => {
          //   expect(request.url).to.match(/\/reset-password$/)
          //   expect(request.method).to.equal('POST')
          //   // it is a good practice to add assertion messages
          //   // as the 2nd argument to expect()
          //   expect(response.statusCode).to.equal(302)
          //   expect(response.headers.location).to.equal('/login')
          //   // expect(response.headers, 'response headers').to.include({
          //   //   'cache-control': 'no-cache',
          //   //   expires: '-1',
          //   //   'content-type': 'application/json; charset=utf-8',
          //   //   location: '<domain>/users/101',
          //   // })
          // })

          // cy.wait('@reset').url()
          //   .should('be.equal', `${Cypress.config().baseUrl}/login`)
          // .contains('Your password has been reset!')

          // cy.request({
          //   url: '/reset-password',
          //   method: 'POST',
          //   followRedirect: true, // turn on following redirects
          // }).then((res) => {
          //   expect(res.status).to.eq(302)
          //   expect(res.redirectedToUrl).to.eq(`${Cypress.config().baseUrl}/admin/dashboard`)
          // });

            // .assertRedirect('/login')
            // .contains('Your password has been reset!')

          // // cy.visit('/login')
          // cy.get('input[name="email"]').clear().type("joeblogs@email.com")
          // cy.get('input[name="password"]').clear().type("password")
          // cy.get('input#remember[type=checkbox]').click()
          // cy.get('button[type="submit"]').click()

          // cy.url()
          //   .should('be.equal', `${Cypress.config().baseUrl}/admin/dashboard`)
        })

      })
      // /reset-password works successfully

    })
    // /when submitting the form

  })
  // Context GET /reset-password

})
// /Zen Admin Starter (Laravel, InertiaJS & Svelte)
