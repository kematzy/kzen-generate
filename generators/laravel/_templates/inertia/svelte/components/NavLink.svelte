<script>
  import { createEventDispatcher } from 'svelte'
  import { inertia } from '@inertiajs/inertia-svelte'
  import { route, startsWith } from '@/utils'

  const dispatch = createEventDispatcher()

  export let to = ''
  export let title = 'undefined title'

  let href, props, isPartiallyCurrent, isCurrent, ariaCurrent, isActive
  let path = window.location.href

  $: href = route(to)
  $: isPartiallyCurrent = startsWith(path, href)
  $: isCurrent = href === path
  $: ariaCurrent = isCurrent ? 'page' : undefined;
  $: isActive = (isPartiallyCurrent || isCurrent)

  $: props = {
    class: isActive ? 'nav-link active' : 'nav-link',
    title: title,
    // 'data-active': isActive,
    // 'data-current': isCurrent,
    // 'data-partial': isPartiallyCurrent,
    // 'data-path': path,
    // 'data-href': href,
  }

  const hide = () => {
    dispatch('overlaytoggle')
    console.log('NavLink: hide() dispatched: path:', href)
  }
</script>

<a {href} aria-current="{ariaCurrent}" {...props} use:inertia on:click={hide}>
  <slot />
</a>
