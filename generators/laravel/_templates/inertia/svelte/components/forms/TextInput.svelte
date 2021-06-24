<script>
  import { nanoid } from 'nanoid'
  import Label from '@/components/forms/Label.svelte'

  export let value = null
  export let label
  export let type = 'text'
  export let field = ''
  export let required = false
  export let id = `input-${type}-${nanoid(5)}`
  export let error

  let input

  export const focus = () => input.focus()
  export const select = () => input.select()

  $: props = {
    ...$$restProps,
    id: id,
    class: 'form-input',
    name: field,
    type: type,
    required: required ? true : null
  }

  function update(event) {
    value = event.target.value
  }
</script>

<div id="input-{field}" class={$$restProps.class}>
  <Label {id} value={label} for={field} {required} />

  <input {...props} bind:this={input} class:error {value} on:input={update} />

  {#if error}
    <div class="form-error">{error}</div>
  {/if}
</div>
