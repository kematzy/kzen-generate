import { App } from '@inertiajs/inertia-svelte'
import { InertiaProgress } from '@inertiajs/progress'
import PublicLayout from './layouts/Public.svelte'
import AdminLayout from './layouts/Admin.svelte'

InertiaProgress.init({
  // The delay after which the progress bar will
  // appear during navigation, in milliseconds.
  delay: 250,

  // The color of the progress bar.
  color: '#29d',

  // Whether to include the default NProgress styles.
  includeCSS: true,

  // Whether the NProgress spinner will be shown.
  showSpinner: false,
})

const el = document.getElementById('app')


new App({
  target: el,
  props: {
    initialPage: JSON.parse(el.dataset.page),
    resolveComponent: name => import(`./pages/${name}.svelte`)
    .then((page) => {
      if (page.layout === undefined) {
        page.layout = name.startsWith('admin/') ? AdminLayout : PublicLayout
      }
      // if (page.layout === undefined && name.startsWith('auth/')) {
      //     page.layout = AuthLayout
      //   // } else if (page.layout === undefined && !name.startsWith('admin/')) {
      //   //   page.layout = AdminLayout
      //   } else {
      //     page.layout = PublicLayout
      //   }
      return page
    }),
  },
})