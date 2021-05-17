<script>
  export let open = false
  export let id = 'menu'
  export let klass = ''
</script>

<button class:open on:click={() => open = !open} {id} class={klass}>
  <svg width="30" height="20">
    <line id="top"    x1=0 y1=2  x2=30 y2=2  />
    <line id="middle" x1=0 y1=10 x2=22 y2=10 />
    <line id="bottom" x1=0 y1=18 x2=30 y2=18 />
  </svg>
</button>

<style lang="postcss" scoped>
  svg {
    min-height: 20px;
    transition: transform 0.3s ease-in-out;
  }

  svg line {
    stroke: currentColor;
    stroke-width: 3;
    transition: transform 0.3s ease-in-out
  }

  button {
    color: var(--kzen-header-link);
    margin-right: 1rem;
    border: none;
    z-index: 20;
    cursor: pointer;
  }

  button:hover {
    color: var(--kzen-link-hover);
  }

  button:focus {
    outline: 2px solid transparent;
    outline-offset: 2px;
  }

  .open svg {
    transform: scale(0.7)
  }

  .open #top {
    transform: translate(6px, 0px) rotate(45deg)
  }

  .open #middle {
    opacity: 0;
  }

  .open #bottom {
    transform: translate(-12px, 10px) rotate(-45deg)
  }
</style>
