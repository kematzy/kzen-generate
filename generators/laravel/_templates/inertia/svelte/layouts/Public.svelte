<script>
  import { siteTheme, pageFade } from '@/store.js'
  import { fade } from 'svelte/transition'
  import { page } from '@inertiajs/inertia-svelte'
  import Debug from '@/components/Debug.svelte'

  $: document.body.className = `${$siteTheme}-mode` // dark / light

  // $: user = $page.auth && $page.auth.user
</script>

<main transition:fade="{ $pageFade }">
  <div class="flex items-center justify-start w-full">
    <button class="py-2 px-4 { $siteTheme === 'light' ? 'text-purple-800 font-medium' : '' }}" on:click={() => siteTheme.set('light')}>Light</button>
    <button class="py-2 px-4 { $siteTheme === 'dark' ? ' text-purple-700 font-medium' : '' }}" on:click={() => siteTheme.set('dark')}>Dark</button>
  </div>
  <slot />
</main>

<Debug obj={[$page]} />
