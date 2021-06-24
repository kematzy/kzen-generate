<script>
  import { siteTheme } from '@/store.js'
  import Icon from '@/components/Icon.svelte'

  function toggle() {
    $siteTheme === 'light' ? siteTheme.set('dark') : siteTheme.set('light')
  }

  $: klass = ($siteTheme == null)
      ? (localStorage.getItem('theme') === 'dark') ? 'transform rotate-180' : ''
      : ($siteTheme === 'dark') ? 'transform rotate-180' : ''
</script>

<button class="btn" on:click|preventDefault={toggle} title="theme switcher (dark / light modes)">
  <Icon name="adjust" klass={klass} />
</button>
