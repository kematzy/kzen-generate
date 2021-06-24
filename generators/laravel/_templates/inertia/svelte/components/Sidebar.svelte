<script>
  import { inertia } from '@inertiajs/inertia-svelte'
  const route = window.route
  export let open = false

  $: style = open ? ' width: 18rem;' : 'display: none;'

</script>


<div class="admin-sidebar" {style}>
  <div class="sidebar-logo">
    <a href={route('admin.index')} title="back to main admin section" use:inertia>
      zen<strong>Admin</strong>
    </a>
  </div>

  <nav class="sidebar-menu">
    <ul>
      <li class="nav-item">
        <a href={route('admin.dashboard')} title="back to the Dashboard section" class="nav-link" use:inertia>
          <i class="nav-icon la la-dashboard"></i>
          <span class="nav-title">Dashboard</span>
        </a>
      </li>
    </ul>

    <ul>
      <li class="section-header">Theme</li>
      <li class="nav-item">
        <a href={route('admin.settings')} title="back to the Colours section" class="nav-link" use:inertia>
          <i class="nav-icon la la-cog"></i>
          <span class="nav-title">Settings</span>
        </a>
      </li>
      <li class="nav-item">
        <a href={route('admin.user.profile')} title="back to the Colours section" class="nav-link" use:inertia>
          <i class="nav-icon la la-user"></i>
          <span class="nav-title">Profile</span>
        </a>
      </li>
    </ul>
  </nav>
</div>
