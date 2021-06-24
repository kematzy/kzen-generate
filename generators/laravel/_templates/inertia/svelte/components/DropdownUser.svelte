<script>
  import { page } from '@inertiajs/inertia-svelte';
  import { route } from '@/utils'
  import Dropdown from '@/components/Dropdown.svelte'
  import DropdownLink from '@/components/DropdownLink.svelte'
  import DropdownThemeSwitcher from '@/components/DropdownThemeSwitcher.svelte'
  import Icon from '@/components/Icon.svelte'

  $: user = $page.props && $page.props.auth.user
</script>

<Dropdown id="dropdown-user">

  <svelte:fragment slot="trigger">
    <button class="btn nav-icon" title="User dropdown menu...">
      <Icon name="user-circle" />
    </button>
  </svelte:fragment>

  <svelte:fragment slot="content">
    {#if user}
      <div class="dropdown-header">
        <small>Current User:</small>
        <span>{user.name}</span>
      </div>
    {/if}

    <div class="dropdown-item-divider"></div>

    <div class="dropdown-item">
      <DropdownThemeSwitcher />
    </div>

    <div class="dropdown-item-divider"></div>

    <DropdownLink to="{ route('admin.user.profile') }" title="edit your profile">
      <Icon name="user-alt" />
      <span>Profile</span>
    </DropdownLink>

    <DropdownLink to="{ route('admin.settings') }" title="access site-wide settings">
      <Icon name="cog" />
      <span>Settings</span>
    </DropdownLink>

    <div class="dropdown-item-divider"></div>

    <DropdownLink to="{ route('logout') }" as="post" title="log out from the Admin section">
      <Icon name="power-off" />
      <span>Logout</span>
    </DropdownLink>

  </svelte:fragment>

</Dropdown>
