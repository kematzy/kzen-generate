<script>
  import { fade, fly } from 'svelte/transition'
  import Overlay from '@/components/Overlay.svelte'
  import NavLink from '@/components/NavLink.svelte'

  export let open = false
  let ani = { y: 200, duration: 350 }

  // <li>
  //   <NavLink to="admin.users.index" title="Admin Users page" on:overlaytoggle>Users</NavLink>
  // </li>
  // <li>
  //   <NavLink to="admin.roles.index" title="Admin User Roles page" on:overlaytoggle>Roles</NavLink>
  // </li>
  // <li>
  //   <NavLink to="admin.permissions.index" title="Admin Permissions page" on:overlaytoggle>Permissions</NavLink>
  // </li>
</script>

<Overlay id="overlay-nav" bind:open={open}>
  <div class="flex flex-wrap">
    <div class="w-full column sm:w-1/2 md:w-1/3 lg:w-1/4" in:fly="{{ ...ani, delay: 150 }}" out:fade>
      <h3>Main Nav Section</h3>
      <ul>
        <li>
          <NavLink to="admin.dashboard" title="Admin Dashboard page" on:overlaytoggle>Dashboard</NavLink>
        </li>
        <li>
          <NavLink to="admin.settings" title="Admin Settings page" on:overlaytoggle>Settings</NavLink>
        </li>
      </ul>
    </div>
    <div class="w-full column sm:w-1/2 md:w-2/3 lg:w-1/4 sm:px-4" in:fly="{{ ...ani, delay: 300 }}" out:fade>
      <h3>Sub Nav Section</h3>
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cumque, quas hic. Quo facere quis quas nihil vitae illo animi eaque porro! Libero quas exercitationem dolores facilis architecto maxime sint labore!</p>
    </div>
    <div class="w-full column lg:w-2/4 lg:border-t" in:fly="{{ ...ani, delay: 450 }}" out:fade>
      <p class="pt-12 text-gray-500 lg:w-2/3">General info is shown in this section. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cumque, quas hic. Quo facere quis quas nihil vitae illo animi eaque porro! Libero quas exercitationem dolores facilis architecto maxime sint labore!</p>
    </div>
  </div>
</Overlay>
