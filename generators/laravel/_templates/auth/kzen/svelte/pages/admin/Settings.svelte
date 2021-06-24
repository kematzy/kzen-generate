<script>
  import { inertia } from '@inertiajs/inertia-svelte'
  import { route } from '@/utils'
  import Seo from '@/components/Seo.svelte'

  let title = 'Settings'
</script>

<Seo {title} />

<div class="relative flex flex-col justify-center min-h-screen items-top sm:items-center sm:pt-0">
  <h1>Admin {title}</h1>
</div>
