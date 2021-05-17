<script>
  import { debugEnabledToggle, debugShowToggle } from '@/store.js'

  export let obj

  function toggle() {
    $debugShowToggle ? debugShowToggle.set(false) : debugShowToggle.set(true)
  }
</script>

{#if $debugEnabledToggle}
  <div class="debug-bar">
    <div class="flex items-center justify-between">
      <h4>DEBUG</h4>
      <button on:click="{toggle}">
        {#if $debugShowToggle}
          <svg viewBox="0 0 32 32" class="w-auto h-4">
            <path fill="currentColor" d="M 4.21875 10.78125 L 2.78125 12.21875 L 15.28125 24.71875 L 16 25.40625 L 16.71875 24.71875 L 29.21875 12.21875 L 27.78125 10.78125 L 16 22.5625 Z"/>
          </svg>
        {:else}
          <svg viewBox="0 0 32 32" class="w-auto h-4">
            <path fill="currentColor" d="M 16 6.59375 L 15.28125 7.28125 L 2.78125 19.78125 L 4.21875 21.21875 L 16 9.4375 L 27.78125 21.21875 L 29.21875 19.78125 L 16.71875 7.28125 Z"/>
          </svg>
        {/if}
      </button>
    </div>
    {#if $debugShowToggle}
      <div class="debug-contents">
        <pre>{JSON.stringify(obj, undefined, 2)}</pre>
      </div>
    {/if}
  </div>
{/if}


<style lang="scss">
  .debug-bar {
    @apply fixed shadow-md bottom-0 left-0;
    /* background-color: rgba(209, 211, 215, 0.5); */
    background-color: rgb(232, 232, 236, 0.9);
    border-top-right-radius: 0.25rem;
    bottom: 0;
    left: 0;
    min-height: 2rem;
    padding: 0.25rem 0.5rem;
    z-index: 9998;

    h4 {
      @apply text-xs leading-4 px-2 my-1 mx-0;
      color: rgba(103, 113, 125, 0.75);
    }

    button {
      @apply pt-0 pr-2 pb-0 pl-4 text-xs leading-4 ;
      color: rgba(103, 113, 125, 0.75);

      &:hover {
        color:rgba(50, 63, 75, 0.85);
      }

      &:focus {
        outline: none;
      }
    }
  }

  .debug-contents {
    @apply leading-5 text-sm font-mono h-96 mt-1 p-4 w-full rounded overflow-scroll;
    background-color: rgba(243, 244, 246, 1);
    color: rgba(75, 85, 99, 1);
    border: 1px solid #ddd;
  }
</style>
