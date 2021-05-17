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


<style lang="scss">
  .overlay {
    /* background-color: rgba(243, 244, 246, 0.95); */
    background-color: var(--kzen-overlay-bg);
    position: absolute;
    width: 100%;
    top: -100%;
    height: calc(100% - 52px);
    transition: 0.35s ease-in-out;
    z-index: 30;

    &.open {
      visibility: visible;
    }
  }

  .overlay-scale {
    visibility: hidden;
    opacity: 0;
    transform: scale(0.5);
    transition: transform 0.5s, opacity 0.5s, visibility 0s 0.5s;
  }

  .overlay-scale.open {
    top: 52px;
    visibility: visible;
    opacity: 1;
    transform: scale(1);
    transition: transform 0.4s, opacity 0.4s;
  }

  .overlay-content {
    // border: var(--kzen-overlay-border);
    margin: 1rem 0.5rem;
    height: calc(100% - 4rem);
  }
</style>