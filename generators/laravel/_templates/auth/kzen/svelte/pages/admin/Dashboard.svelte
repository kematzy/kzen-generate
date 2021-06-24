<script>
  import { inertia, page } from '@inertiajs/inertia-svelte'
  import { route } from '@/utils'
  import Seo from '@/components/Seo.svelte'

  let title = 'Dashboard'

  $: user = $page.props && $page.props.auth.user
</script>

<Seo {title} />

<div class="page-container">

  <div class="w-full">
    <h2 class="h3">Admin Dashboard page</h2>

    <a href="{ route('admin.settings') }" use:inertia class="ml-4">Settings</a>

    <div class="w-full p-4 mt-4 font-mono border rounded-lg border-light-d3 dark:border-dark-b2">
      <pre>{ JSON.stringify(user, null, 2)}</pre>
    </div>
  </div>

</div>
