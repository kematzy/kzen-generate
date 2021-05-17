<script>
  import { createEventDispatcher } from 'svelte';
  import Icon from '@/components/Icon.svelte'

  const dispatch = createEventDispatcher()

  // holds the name of the model to be deleted
  export let model = 'User'
</script>

<button
  class="btn-delete"
  tabindex="-1"
  type="button"
  title="Delete the {model}"
  on:click={() => dispatch('delete')}
  >
  <Icon name="trash" />
  Delete {model}
</button>

<style class="scss">
  .btn-delete {
    @apply rounded text-red-400 border border-gray-300 bg-transparent uppercase flex items-center;
    padding: 0rem 1rem 0rem 0;
    margin: 0 1rem 0 0;

    &:focus,
    &:hover {
      @apply text-white bg-red-500;
    }
  }
</style>