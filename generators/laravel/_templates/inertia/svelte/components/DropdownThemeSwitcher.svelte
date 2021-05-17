<script>
  import { siteTheme } from '@/store.js'
  import Icon from '@/components/Icon.svelte'

  function toggle() {
    $siteTheme === 'light' ? siteTheme.set('dark') : siteTheme.set('light');
    // console.log('siteTheme set to: ', $siteTheme)
  }
</script>

<button class="dropdown-item-button" on:click={toggle} title="theme switcher (dark / light modes)">
  <span class="flex flex-row items-center justify-start">
    <Icon name="adjust" klass="nav-icon { $siteTheme === 'dark' ? 'transform rotate-180' : '' }" />
    <span>{ $siteTheme === 'dark' ? 'Light' : 'Dark' } Mode</span>
  </span>
</button>
