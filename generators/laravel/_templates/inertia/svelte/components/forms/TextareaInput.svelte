<script>
  import { onMount } from 'svelte'
  import { nanoid } from 'nanoid'
  import fitTextarea from 'fit-textarea'
  import Label from '@/components/forms/Label.svelte'

  export let id = `textarea-input-${nanoid(5)}`
  export let value = null
  export let field = ''
  export let required = false
  export let label
  export let error
  export let autosize = false

  let input

  export const focus = () => input.focus()
  export const select = () => input.select()

  $: props = {
    ...$$restProps,
    class: 'form-textarea',
    rows: 5,
    name: field,
    required: required ? true : null
  }

  onMount(() => {
    if (autosize) {
      fitTextarea.watch(input)
    }
  })

  function update(event) {
    value = event.target.value
  }
</script>

<div id="input-{field}" class={$$restProps.class}>
  <Label {id} value={label} for={field} {required} />

  <textarea {id} {...props} bind:this={input} class:error {value} on:input={update} />

  {#if error}
    <div class="form-error">{error}</div>
  {/if}
</div>
