<script>
  import { siteTheme } from '@/store.js'
  import Icon from '@/components/Icon.svelte'

  function toggle() {
    $siteTheme === 'light' ? siteTheme.set('dark') : siteTheme.set('light')
  }

  // siteTheme can be either: null or light/dark
  $: btnTxt = ($siteTheme == null)
      ? (localStorage.getItem('theme') === 'dark') ? 'Light' : 'Dark'
      : ($siteTheme === 'dark') ? 'Light' : 'Dark'
  $: klass = ($siteTheme == null)
      ? (localStorage.getItem('theme') === 'dark') ? 'transform rotate-180' : ''
      : ($siteTheme === 'dark') ? 'transform rotate-180' : ''
</script>

<button class="dropdown-item-button" on:click={toggle} title="theme switcher (dark / light modes)">
  <span class="flex flex-row items-center justify-start">
    <Icon name="adjust" klass="nav-icon {klass}" />
    <span>{btnTxt} Mode</span>
  </span>
</button>
