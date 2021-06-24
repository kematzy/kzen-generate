<script>
  import ZenLogo from '@/components/ZenLogo.svelte'

  export let reversed

  let rev = reversed ? 'flex-col lg:flex-row-reverse' : 'flex-col lg:flex-row'
  let rounded = reversed ? 'rounded-r-lg' : 'rounded-l-lg'
  let border = reversed ? 'md:border-l' : 'md:border-r'
  border = `${border} md:border-light-d3 dark:md:border-dark-d2`
</script>

<div class="w-full mx-auto md:w-4/5 sm:px-6 lg:items-center lg:px-8 2xl:max-w-7xl">

  <div class="flex {rev} shadow-md sm:rounded-lg bg-light-d1 dark:bg-dark-d1 dark:shadow-lg">
    <!-- form side -->
    <div class="w-full py-12 px-2 sm:px-6 border-t md:border-t-0 border-light-b2 dark:border-dark-b3 {rounded}">
      <div class="flex flex-col items-center justify-center w-full p-4 2xl:p-0">
        <slot name="form">
          <!-- form  -->
        </slot>
      </div>
    </div>
    <!-- /form side -->

    <!-- logo side -->
    <div class="p-6 flex flex-col items-center justify-center w-full bg-light-d4 dark:bg-dark-d2 {rounded} {border}">
      <slot name="logo">
        <ZenLogo klass="h-10 w-auto text-primary dark:text-primary-d2" />
        <h3>Laravel - Svelte & InertiaJS</h3>
      </slot>
    </div>
    <!-- /logo side -->
  </div>
  <!-- /inner-box -->

</div>
<!-- /outer-box -->
