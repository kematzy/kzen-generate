<script>
  import { fade } from 'svelte/transition'
  import { isEscKey } from '@/utils'

  export let align = 'right'
  export let width = 'w-48'
  export let contentClasses = 'py-1 bg-white'

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


<div class="relative">
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

<style style="scss" global>
  .dropdown-overlay {
    @apply fixed inset-0 z-40;
    background-color: var(--kzen-header-bg);
  }

  .dropdown-menu {
    @apply origin-top-right absolute z-50 mt-2 rounded-md shadow-lg;
    background-color: var(--kzen-header-bg);
  }

  .dropdown-header {
    @apply block px-4 pt-2 pb-3 text-xs uppercase;
    color: var(--kzen-header-link);
  }

  .dropdown-item-button {
    @apply w-full focus:outline-none;
  }

  .dropdown-item-link,
  .dropdown-item-button {
    @apply block text-base;
    padding: 0.5rem 1rem 0.5rem 0;
    color: var(--kzen-header-link);

    &.nav-icon {
      @apply text-xl;
    }

    &:hover {
      color: var(--kzen-link-hover);
      background-color: var(--kzen-dropdown-hover);
    }
  }

  .dropdown-item-divider {
    border-top: var(--kzen-dropdown-divider);
  }

</style>
