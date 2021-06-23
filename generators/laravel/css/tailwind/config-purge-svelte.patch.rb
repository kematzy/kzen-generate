# Add improved purge support to the Tailwind.config.js file in a Laravel app

set_current_patch 'css:tailwind:config-purge-svelte'

puts
patch_start


if tailwindCSS? && svelte?

  # update Tailwind.config.js with purge settings
find = <<-FIND
  purge: ['./resources/**/*.{js,svelte,vue,blade.php}'],
FIND
replace = <<-NEW
  // purge: ['./resources/**/*.{js,svelte,vue,blade.php}'],
  purge: {
    mode: 'all',
    content: ['./resources/**/*.{js,svelte,vue,blade.php}'],

    options: {
      whitelistPatterns: [/svelte-/],
      defaultExtractor: (content) =>
        [...content.matchAll(/(?:class:)*([\\w\\d-/:%.]+)/gm)].map(([_match, group, ..._rest]) => group),
      keyframes: true,
    },
  },
NEW
  gsub_file('tailwind.config.js', find, replace, verbose_opts)
  git_commit('update the Tailwind config with Svelte purge setup')
  logger.success 'updated the Tailwind config with Svelte purge setup'

else
  patch_required_for_feature('css:tailwind', 'Tailwind & Svelte')
end


patch_end
puts
