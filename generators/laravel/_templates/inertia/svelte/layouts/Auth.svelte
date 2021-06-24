<script>
  import { pageFade } from '@/store.js'
  import { page } from '@inertiajs/inertia-svelte'
  import { fade } from 'svelte/transition'
  import Debug from '@/components/Debug.svelte'

  // $: console.log(`LayoutAuth: the url is: ${window.location.href}`);
</script>

<div class="auth-wrapper" transition:fade="{$pageFade}">
  <slot />
</div>

<Debug obj={[$page]} />
