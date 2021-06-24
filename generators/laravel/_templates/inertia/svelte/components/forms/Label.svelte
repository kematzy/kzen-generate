<script>
  export let id
  export let value
  export let required = false

  $: props = {
    ...$$restProps,
    class: `form-label ${$$restProps.class || ''}`,
  }
  $: req = required ? ' <span class="required" title="required field">*</span>' : ''
</script>

<!-- svelte-ignore a11y-label-has-associated-control -->
<label {id} {...props}>
  {#if value}
    {value}:{@html req}
  {:else}
    <slot />
  {/if}
</label>
