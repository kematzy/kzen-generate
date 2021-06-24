<script>
  import { page } from '@inertiajs/inertia-svelte'
  // import { route } from '@/utils'
  import Seo from '@/components/Seo.svelte'

  let title = 'User Profile'

  $: user = $page.props && $page.props.auth.user
</script>

<Seo {title} />

<div class="page-container">
  <div class="w-full">
    <h2 class="h3">{title}</h2>

    <div class="w-full p-4 mt-4 font-mono border rounded-lg border-light-d3 dark:border-dark-b2">
      <pre>{ JSON.stringify(user, null, 2)}</pre>
    </div>
  </div>
</div>
