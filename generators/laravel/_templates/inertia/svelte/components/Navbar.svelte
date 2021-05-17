<script>
  import { overlayHelpToggle } from '@/store.js'
  import ZenLogo from '@/components/ZenLogo.svelte'
  import HamburgerBtn from '@/components/BtnHamburger.svelte'
  import Icon from '@/components/Icon.svelte'
  import DropdownUser from '@/components/DropdownUser.svelte'
  // import MessageDropdown from '@/components/MessageDropdown.svelte' // <MessageDropdown />
  import FlashMessages from '@/components/FlashMessages.svelte'

  export let open = false
  let helpIcon = 'question-circle'
  let helpTitle = 'TODO: add Help section here'

  function toggleHelp() {
    $overlayHelpToggle ? overlayHelpToggle.set(false) : overlayHelpToggle.set(true)
  }
  $: helpIcon = ($overlayHelpToggle) ? 'compress-arrows-alt' : 'question-circle'
  $: helpTitle = ($overlayHelpToggle) ? 'click to close the Help Section' : 'TODO: add Help section here'
</script>

<section id="header" class="flex items-center justify-between p-2">
  <nav class="flex pl-2">
    <HamburgerBtn bind:open />
    <ZenLogo klass="h-5 pl-2 md:h-6 md:pl-6" />
  </nav>

  <nav class="flex">
    <button class="btn" title={helpTitle} on:click={toggleHelp}>
      <Icon name={helpIcon} />
    </button>

    <DropdownUser />
  </nav>
</section>

<FlashMessages />
