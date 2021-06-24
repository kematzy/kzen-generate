import { writable } from 'svelte/store'

// ### SITE THEME
// the theme setting are one of the first items set in the app when loading the page.
// so we set it up and then subscribe to any changes.
// if no stored theme, we check for prefers dark mode, and sets the theme to dark automatically
// else we set the theme to what's stored
// any changes to the theme, sets the <html> tag also
const storedTheme = localStorage.getItem('theme')
export const siteTheme = writable(storedTheme)
siteTheme.subscribe((v) => {
  let pd = window.matchMedia('(prefers-color-scheme: dark)').matches // check for dark mode preference
  let t = (v == null)
      ? (pd) ? 'dark' : 'light'
      : (v === 'dark') ? 'dark' : 'light'

  console.log('store:Theme set: ', t, ', was:', v, ', prefers dark?: ', pd)
  // set the <html...> tag class, removing any existing classes
  document.documentElement.className = `h-full ${t}`
  localStorage.setItem('theme', t)  // save the theme settings
})

// ### SITE TITLE:
export const siteTitle = writable('Laravel, InertiaJS & Svelte Starter')
// ### SITE DESCRIPTION:
export const siteDescription = writable('Laravel, InertiaJS & Svelte Starter ($store)')

// ### PAGE FADE:
export const pageFade = writable({ duration: 500, delay: 250, opacity: 0.5, start: 0.5 })

// ### TOGGLE NAV OVERLAY:
export const overlayNavToggle = writable(false)
// ### TOGGLE HELP OVERLAY:
export const overlayHelpToggle = writable(false)

// ### TOGGLE DEBUG ENABLED:
export const debugEnabledToggle = writable(true)
// ### TOGGLE DEBUG VISIBLE:
export const debugShowToggle = writable(false)
