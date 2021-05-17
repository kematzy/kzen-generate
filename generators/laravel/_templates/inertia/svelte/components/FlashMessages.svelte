<script>
  import { page } from '@inertiajs/inertia-svelte'
  import Alert from '@/components/Alert.svelte'
</script>

{#if $page.props.flash.message}
  <Alert key={$page.props.flash.key} message={$page.props.flash.message} />
{/if}
