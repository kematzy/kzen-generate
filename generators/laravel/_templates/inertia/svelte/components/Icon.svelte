<script>
  export let name = 'home'
  export let klass = 'nav-icon'
</script>

<i class="las la-{name} {klass}"></i>

<style lang="postcss">
  .nav-icon {
    @apply text-xl py-1 px-2 md:text-2xl md:px-3;
  }
</style>
