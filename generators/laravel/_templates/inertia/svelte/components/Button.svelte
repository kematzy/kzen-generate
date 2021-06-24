<script>
  // options: primary/secondary/success/danger/warning
  //          info/save/cancel/delete/icon/text
  export let kind = 'primary'
  // toggle for outline variant
  export let outline = false
  // options: xs/sm/base/md/lg/xl
  export let size = 'sm'
  // toggle for spinner
  export let loading = false

  // possible btn-types: btn-primary, btn-secondary,
  //                     btn-cancel, btn-delete, btn-outline,
  //                     btn-icon, btn-text
  $: zize =  size ? `btn-${size}` : 'btn-sm'

  // possible btn-types: btn-primary, btn-secondary,
  //                     btn-cancel, btn-delete,
  //                     btn-icon, btn-text
  $: klass = outline ? `btn-${kind}-outline` : `btn-${kind}`

  $: props = {
    ...$$restProps,
    class: `${klass} ${zize} ${$$restProps.class || ''}`,
  }
</script>

<button {...props} type="submit" disabled={loading}>
  {#if loading}
    <div class="mr-2 btn-spinner" />
  {/if}
  <slot />
</button>
