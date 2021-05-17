<script>
  import { inertia } from '@inertiajs/inertia-svelte'

  export let to
  export let as
</script>

<div>
  {#if as == 'button'}
    <button type="submit" class="block w-full px-4 py-2 text-sm leading-5 text-gray-700 text-left hover:bg-gray-100 focus:outline-none focus:bg-gray-100 transition">
      <slot></slot>
    </button>
  {:else if as == 'a'}
    <a
      href={to}
      class="block px-4 py-2 text-sm leading-5 text-gray-700 hover:bg-gray-100 focus:outline-none focus:bg-gray-100 transition"
      use:inertia
    >
      <slot />
    </a>
  {:else if as == 'post'}
    <a
      href={to}
      class="block px-4 py-2 text-sm leading-5 text-gray-700 hover:bg-gray-100 focus:outline-none focus:bg-gray-100 transition"
      use:inertia="{{ method: 'post' }}"
    >
      <span class="flex flex-row items-center justify-start">
        <slot />
      </span>
    </a>
  {:else}
    <a
      href={to}
      class="block px-4 py-2 text-sm leading-5 text-gray-700 hover:bg-gray-100 focus:outline-none focus:bg-gray-100 transition"
      use:inertia
    >
      <slot />
    </a>
  {/if}
</div>
