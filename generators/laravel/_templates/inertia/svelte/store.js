import { writable } from 'svelte/store'

// ### SITE THEME
const storedTheme = localStorage.getItem('theme')
export const siteTheme = writable(storedTheme)
siteTheme.subscribe((v) => {
  localStorage.setItem('theme', v === 'dark' ? 'dark' : 'light')
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
