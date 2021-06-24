<script>
  import { createEventDispatcher } from 'svelte';
  import Button from '@/components/Button.svelte'
  import Icon from '@/components/Icon.svelte'

  const dispatch = createEventDispatcher()

  // holds the name of the model to be deleted
  export let model

  let tt = model ? `Delete the ${model}` : 'Delete'
  let txt = model ? `Delete ${model}` : 'Delete'

</script>

<Button kind="delete" title={tt} on:click={() => dispatch('delete')}>
  <Icon name="trash" />
  {txt}
</Button>
