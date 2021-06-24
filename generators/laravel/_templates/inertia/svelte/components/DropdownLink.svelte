<script>
  import { inertia } from '@inertiajs/inertia-svelte'

  export let to
  export let as

  let klass = (as === 'button') ? 'dropdown-item-button' : 'dropdown-item-link'
  $: props = {
    ...$$restProps,
    class: `${klass} ${$$restProps.class || ''}`,
  }
</script>

<div class="dropdown-item">
  {#if as == 'button'}
    <button type="submit" {...props}>
      <span class="flex flex-row items-center justify-start">
        <slot />
      </span>
    </button>
  {:else if as == 'ext'}
    <a href={to} {...props} target="_blank">
      <span class="flex flex-row items-center justify-start">
        <slot />
      </span>
    </a>
  {:else if as == 'post'}
    <a href={to} {...props} use:inertia="{{ method: 'post' }}">
      <span class="flex flex-row items-center justify-start">
        <slot />
      </span>
    </a>
  {:else}
    <a href={to} {...props} use:inertia>
      <span class="flex flex-row items-center justify-start">
        <slot />
      </span>
    </a>
  {/if}
</div>
