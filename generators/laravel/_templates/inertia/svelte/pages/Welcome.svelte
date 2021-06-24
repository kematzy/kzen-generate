<script>
  import { inertia, page } from '@inertiajs/inertia-svelte'
  import { route } from '@/utils'
  import ZenLogo from '@/components/ZenLogo.svelte'
  import Seo from '@/components/Seo.svelte'

  export let enabled = {};
  export let laravelVersion;
  export let phpVersion;
</script>

<Seo title="Welcome" />

<div class="relative flex justify-center min-h-screen items-top sm:items-center sm:pt-0">

  <div class="fixed top-0 right-0 px-6 py-4 sm:block">
    {#if !$page.props.auth.user}
      {#if enabled.login}
        <a href="{ route('login') }" class="text-sm" use:inertia>
          Login
        </a>
      {/if}

      {#if enabled.register}
        <a href="{ route('register') }" class="ml-4 text-sm" use:inertia>
          Register
        </a>
      {/if}
    {/if}

    {#if $page.props.auth.user}
      <a href="{ route('admin.dashboard') }" class="ml-4 text-sm" use:inertia>
        Admin
      </a>
    {/if}
  </div>

  <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
    <div class="mt-8 overflow-hidden bg-white shadow dark:bg-dark-d2 sm:rounded-lg">
      <div class="flex justify-center w-full p-4 border-b bg-light-b1 dark:bg-dark-d1 dark:border-dark-b4">
        <ZenLogo klass="h-8 w-auto my-2 text-primary-d1" />
      </div>
      <div class="grid grid-cols-1 md:grid-cols-2">
        <div class="p-6">
          <div class="flex items-center">
            <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" class="w-8 h-8 text-primary">
                <path d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
            </svg>
            <div class="ml-4 text-lg font-semibold leading-7">
              <a href="https://laravel.com/docs" class="text-gray-900 dark:text-gray-300">Documentation</a>
            </div>
          </div>

          <div class="ml-12">
            <div class="mt-2 text-sm text-gray-600 dark:text-gray-400">
              Laravel has wonderful, thorough documentation covering every aspect of the framework. Whether you are new to the framework or have previous experience with Laravel, we recommend reading all of the documentation from beginning to end.
            </div>
          </div>
        </div>

        <div class="p-6 border-t border-gray-200 dark:border-gray-700 md:border-t-0 md:border-l">
          <div class="flex items-center">
            <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" class="w-8 h-8 text-primary">
              <path d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"></path>
              <path d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"></path>
            </svg>
            <div class="ml-4 text-lg font-semibold leading-7">
              <a href="https://laracasts.com" class="text-gray-900 dark:text-gray-300">Laracasts</a>
            </div>
          </div>

          <div class="ml-12">
            <div class="mt-2 text-sm text-gray-600 dark:text-gray-400">
              Laracasts offers thousands of video tutorials on Laravel, PHP, and JavaScript development. Check them out, see for yourself, and massively level up your development skills in the process.
            </div>
          </div>
        </div>

        <div class="p-6 border-t border-gray-200 dark:border-gray-700">
          <div class="flex items-center">
            <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" class="w-8 h-8 text-primary-b2">
              <path d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"></path>
            </svg>
            <div class="ml-4 text-lg font-semibold leading-7">
              <a href="https://laravel-news.com/" class="text-gray-900 dark:text-gray-300">Laravel News</a>
            </div>
          </div>

          <div class="ml-12">
            <div class="mt-2 text-sm text-gray-600 dark:text-gray-400">
              Laravel News is a community driven portal and newsletter aggregating all of the latest and most important news in the Laravel ecosystem, including new package releases and tutorials.
            </div>
          </div>
        </div>

        <div class="p-6 border-t border-gray-200 dark:border-gray-700 md:border-l">
          <div class="flex items-center">
            <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" class="w-8 h-8 text-primary-d1">
              <path d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
            <div class="ml-4 text-lg font-semibold leading-7 text-gray-900 dark:text-gray-300">
              Vibrant Ecosystem
            </div>
          </div>

          <div class="ml-12">
            <div class="mt-2 text-sm text-gray-600 dark:text-gray-400">
              Laravel's robust library of first-party tools and libraries, such as
              <a href="https://forge.laravel.com" class="underline">Forge</a>,
              <a href="https://vapor.laravel.com" class="underline">Vapor</a>,
              <a href="https://nova.laravel.com" class="underline">Nova</a>, and
              <a href="https://envoyer.io" class="underline">Envoyer</a>
              help you take your projects to the next level. Pair them with powerful open source libraries like
              <a href="https://laravel.com/docs/billing" class="underline">Cashier</a>,
              <a href="https://laravel.com/docs/dusk" class="underline">Dusk</a>,
              <a href="https://laravel.com/docs/broadcasting" class="underline">Echo</a>,
              <a href="https://laravel.com/docs/horizon" class="underline">Horizon</a>,
              <a href="https://laravel.com/docs/sanctum" class="underline">Sanctum</a>,
              <a href="https://laravel.com/docs/telescope" class="underline">Telescope</a>, and more.
            </div>
          </div>
        </div>
      </div>
      <div class="w-full px-6 py-2 border-t bg-light-b1 dark:bg-dark-d1 dark:border-dark-b4">
        <p class="py-2 m-0 text-center">Footer</p>
      </div>
    </div>

    <div class="flex justify-center mt-4 sm:items-center sm:justify-between">
      <div class="pl-4 text-sm text-center sm:text-left text-dark-b5 dark:text-gray-500">
        <div class="flex items-center">
          Left side
        </div>
      </div>

      <div class="pr-4 ml-4 text-sm text-center sm:text-right sm:ml-0 text-dark-b5 dark:text-gray-500">
        Laravel v{ laravelVersion } (PHP v{ phpVersion })
      </div>
    </div>
  </div>
</div>
