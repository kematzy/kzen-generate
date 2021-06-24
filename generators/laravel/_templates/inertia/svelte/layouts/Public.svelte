<script>
  import { pageFade } from '@/store.js'
  import { fade } from 'svelte/transition'
  import { page } from '@inertiajs/inertia-svelte'
  import Debug from '@/components/Debug.svelte'

  // $: user = $page.props.auth && $page.props.auth.user
  // $: console.log(`LayoutPublic: the url is: ${window.location.href}`);
</script>

<main class="public-wrapper" transition:fade="{ $pageFade }">
  <slot />
</main>

<Debug obj={[$page]} />
