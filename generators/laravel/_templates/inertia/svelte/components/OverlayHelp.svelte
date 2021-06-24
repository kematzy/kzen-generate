<script>
  import { overlayHelpToggle } from '@/store.js'
  import { fade, fly } from 'svelte/transition'
  import Overlay from '@/components/Overlay.svelte'

  export let open = false
  let ani = { y: 200, duration: 350 }

  function closeHelp() {
    overlayHelpToggle.set(false)
  }
</script>

<Overlay id="overlay-help" bind:open={open}>
  <div class="flex flex-wrap">
    <div class="flex flex-col items-start justify-start w-full column md:w-1/3 lg:w-1/4" in:fly="{{ ...ani, delay: 150 }}" out:fade>
      <h3 class="pt-8">Help Sections</h3>
      <ul>
        <li>Overview</li>
        <li>Settings</li>
        <li>Users</li>
      </ul>
    </div>
    <div class="w-full column md:w-2/3 lg:w-3/4 md:pt-0" in:fly="{{ ...ani, delay: 300 }}" out:fade>
      <div class="flex items-center justify-end w-full pr-8">
        <button class="flex items-center justify-between text-base text-gray-400 uppercase hover:text-primary-800 focus:outline-none" on:click={closeHelp}>
          <span>Close Help Section</span>
        </button>
      </div>

      <div class="w-4/5 md:w-3/4 lg:w-2/3">
        <h3>Main Content Section</h3>
        <p>
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cumque, quas hic. Quo facere quis quas nihil vitae illo animi eaque porro! Libero quas exercitationem dolores facilis architecto maxime sint labore!
        </p>

        <p class="text-gray-500">
          General info is shown in this section. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cumque, quas hic. Quo facere quis quas nihil vitae illo animi eaque porro! Libero quas exercitationem dolores facilis architecto maxime sint labore!
        </p>
      </div>
    </div>
  </div>
</Overlay>
