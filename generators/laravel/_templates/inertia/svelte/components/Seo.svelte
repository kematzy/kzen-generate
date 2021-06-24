<script>
  import { siteTitle, siteDescription } from '@/store.js'
  export let title
  export let description
  $: desc = description ? description : $siteDescription
</script>

<svelte:head>
  <title>{ title ? `${title} | ${$siteTitle}` : $siteTitle }</title>
  <meta name="description" content="{desc}" />
</svelte:head>