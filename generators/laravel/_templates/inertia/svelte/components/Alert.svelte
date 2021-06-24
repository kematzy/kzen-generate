<script>
  import { slide } from 'svelte/transition';

  export let key = 'info'
  export let message = null

  let show = true

  function deleteAlert(id) {
    show = false
  }

  setTimeout(function() {
    deleteAlert(alert.id)
   }, 3500)
</script>


{#if show}
  <div class="alert alert-{key}" transition:slide|local>
    <div class="alert-content">
      <i class="las la-bell alert-icon"></i>
      {message}
    </div>
    <button type="button" class="alert-button" on:click={deleteAlert}>
      <i class="las la-times"></i>
    </button>
  </div>
{/if}
