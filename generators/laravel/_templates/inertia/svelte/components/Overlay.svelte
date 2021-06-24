<script>
  import { fade } from 'svelte/transition'

  export let open = false
  export let id = 'overlay'
</script>

<div {id} class="overlay overlay-scale" class:open out:fade>
  <div class="overlay-content" class:open>
    <slot />
  </div>
</div>
