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

<style lang="scss">
  .alert {
    @apply w-full flex items-center justify-between z-10 fixed rounded-b shadow;
    top: 3.5rem;
  }

  .alert-button {
    @apply border-l py-1 appearance-none;

    i {
      @apply text-base py-1 px-2 md:px-4;
    }
  }

  .alert-content {
    @apply text-sm font-medium flex items-center;
  }

  .alert-icon {
    @apply text-lg py-1 px-2 md:text-xl md:px-3;
  }

  .alert-success {
    @apply bg-green-200 text-green-700 border-t border-green-400;

    .alert-button {
      @apply border-green-300;

      &:hover {
        @apply bg-green-300 rounded-br;
        color: #fff;
      }
    }
  }

  .alert-info {
    @apply bg-blue-200 text-blue-700 border-t border-blue-400;

    .alert-button {
      @apply border-blue-400;

      &:hover {
        @apply bg-blue-300 rounded-br;
        color: #fff;
      }
    }
  }

  .alert-warning {
    @apply bg-yellow-200 text-yellow-800;

    .alert-button {
      @apply border-yellow-300;

      &:hover {
        @apply bg-yellow-300 rounded-br;
        color: #fff;
      }
    }
  }

  .alert-error {
    @apply bg-red-300 text-red-900;

    .alert-button {
      @apply border-red-400;

      &:hover {
        @apply bg-red-400 rounded-br;
        color: #fff;
      }
    }
  }
</style>