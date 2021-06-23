# Add improved purge support to the Tailwind.config.js file in a Laravel app

set_current_patch 'css:tailwind:config-purge'

puts
patch_start


if tailwindCSS?

  # update Tailwind.config.js with purge settings
find = <<-FIND
  purge: [],
FIND
replace = <<-NEW
  purge: ['./resources/**/*.{js,svelte,vue,blade.php}'],
NEW
  gsub_file('tailwind.config.js', find, replace, verbose_opts)
  git_commit('update the Tailwind config with purge setup')
  logger.success 'updated the Tailwind config with purge setup'

else
  patch_required_for_feature('css:tailwind', 'Tailwind')
end


patch_end
puts
