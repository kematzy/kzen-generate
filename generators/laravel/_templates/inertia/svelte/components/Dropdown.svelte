<script>
  import { fade } from 'svelte/transition'
  import { isEscKey } from '@/utils'

  export let align = 'right'
  export let width = 'w-64'
  export let contentClasses = 'py-1'

  let open = false
  let alignment = ''

  $: alignment = (align === 'left')
    ? 'origin-top-left left-0'
    : (align === 'right') ? 'origin-top-right right-0' : 'origin-top'

  $: style = open ? '' : 'display: none;'

  // HANDLERS
  function handleEscKey (event) {
    if (open && isEscKey(event)) { open = false }
  }

  // FUNCTIONS
  function toggle () {
    open = !open
  }

  function close () {
    open = false
  }
</script>


<svelte:window on:keydown={handleEscKey} />


<div {...$$restProps} class="relative">
  <div class="dropdown-trigger" on:click={toggle}>
    <slot name="trigger"></slot>
  </div>

  <!-- Full Screen Dropdown Overlay -->
  <div class="dropdown-overlay" {style} on:click={close}></div>

  <div transition:fade={{ delay: 250, duration: 300 }} class="dropdown-menu {alignment} {width}" {style} on:click={close}>
    <div class="rounded-md ring-1 ring-black ring-opacity-5 {contentClasses}">
      <slot name="content"></slot>
    </div>
  </div>
</div>
