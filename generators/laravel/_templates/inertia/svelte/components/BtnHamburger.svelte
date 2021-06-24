<script>
  export let open = false
  export let id = 'btn-hamburger'
  export let klass = ''
  // styles extracted to css/app/components/header.css
</script>

<button {id} class:open on:click={() => open = !open} class="mr-4 border-none cursor-pointer z-20 {klass}">
  <svg width="30" height="20">
    <line id="top"    x1=0 y1=2  x2=30 y2=2  />
    <line id="middle" x1=0 y1=10 x2=22 y2=10 />
    <line id="bottom" x1=0 y1=18 x2=30 y2=18 />
  </svg>
</button>
