# Common Svelte installs

set_current_patch 'js:svelte'


puts
patch_start


npm_install('svelte')

npm_install_dev('svelte-loader')

npm_install_dev('svelte-preprocess')


patch_end
puts

