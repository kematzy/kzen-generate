<script>
  import { pageFade, overlayHelpToggle, overlayNavToggle } from '@/store.js'
  import { fade } from 'svelte/transition'
  import { page } from '@inertiajs/inertia-svelte'

  import Navbar from '@/components/Navbar.svelte'
  import OverlayNav from '@/components/OverlayNav.svelte'
  import OverlayHelp from '@/components/OverlayHelp.svelte'
  // import Sidebar from '@/components/Sidebar.svelte'
  import Debug from '@/components/Debug.svelte'

  // HANDLERS
  function handleToggleOverlay(e) {
    console.log('Admin => handleToggleOverlay: ', e)
    $overlayNavToggle ? overlayNavToggle.set(false) : overlayNavToggle.set(true);
  }

  function handleToggleHelp(e) {
    console.log('Admin => handleToggleHelp: ', e)
    $overlayHelpToggle ? overlayHelpToggle.set(false) : overlayHelpToggle.set(true);
    console.log('Help overlay: ', $overlayHelpToggle)
  }

  $: user = $page.auth && $page.auth.user

  // <Sidebar bind:open={$overlayNavToggle} />
  // $: console.log(`LayoutAdmin: the url is: ${window.location.href}`);
</script>

<main class="admin-wrapper" transition:fade="{ $pageFade }">
  <OverlayNav bind:open={$overlayNavToggle} on:overlaytoggle={handleToggleOverlay} />
  <OverlayHelp bind:open={$overlayHelpToggle} on:togglehelp={handleToggleHelp} />
  <Navbar bind:open={$overlayNavToggle} />
  <slot />
</main>

<Debug obj={[$page]} />
