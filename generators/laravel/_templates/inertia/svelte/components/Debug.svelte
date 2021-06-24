<script>
  import { debugEnabledToggle, debugShowToggle } from '@/store.js'

  export let obj

  function toggle() {
    $debugShowToggle ? debugShowToggle.set(false) : debugShowToggle.set(true)
  }
  // styles extracted to css/app/components/debug.css
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
