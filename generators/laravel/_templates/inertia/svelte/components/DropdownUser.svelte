<script>
  import { inertia, page } from '@inertiajs/inertia-svelte'
  import { route } from '@/utils'
  import Dropdown from '@/components/Dropdown.svelte'
  import DropdownLink from '@/components/DropdownLink.svelte'
  import DropdownThemeSwitcher from '@/components/DropdownThemeSwitcher.svelte'
  import Icon from '@/components/Icon.svelte'

  let user = $page.props.user
</script>

<Dropdown icon="user-circle" id="dropdown-user" title="User dropdown menu...">
  <div class="dropdown-header">
    <span class="block text-xs text-primary-300">Current User:</span>
    <span class="block text-base">{ user.name }</span>
  </div>

  <div class="dropdown-item-divider"></div>

  <DropdownThemeSwitcher />

  <div class="dropdown-item-divider"></div>

  <a href="{ route('admin.user.profile') }" class="dropdown-item-link" use:inertia>
    <span class="flex flex-row items-center justify-start">
      <Icon name="user-alt" />
      <span>Profile</span>
    </span>
  </a>

  <a href="{ route('admin.settings') }" class="dropdown-item-link" use:inertia>
    <span class="flex flex-row items-center justify-start">
      <Icon name="cog" />
      <span>Settings</span>
    </span>
  </a>

  <div class="dropdown-item-divider"></div>

  <DropdownLink to="{ route('logout') }" as="post">
    <Icon name="power-off" />
    <span>Logout</span>
  </DropdownLink>
  <a href="{ route('logout') }" class="dropdown-item-link" use:inertia="{{ method: 'post' }}">
    <span class="flex flex-row items-center justify-start">
    </span>
  </a>
</Dropdown>
