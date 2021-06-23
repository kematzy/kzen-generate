# Add Svelte-preprocess support to an existing solution

set_current_prompt 'js:svelte:preprocess'

puts
patch_start


# set the config value if not set
confs.set('js.svelte.svelte-preprocess', value: true) unless confs.fetch('js.svelte.svelte-preprocess')

# 1) test for svelte-preprocess . If found, then inform, else install svelte-preprocess
npm_install_dev_if_not_installed?('svelte-preprocess')


find = <<-FIND
            // svelte_preprocess_replace
FIND
replace = <<-NEW
            preprocess: require('svelte-preprocess')({
              sourceMap: true,
              postcss: true,
              // postcss: {
              //   syntax: 'postcss-scss',
              //   // parser: 'postcss-scss',
              //   plugins: [
              //     // require("tailwindcss"),      // tailwind(),
              //     // require("postcss-nesting"),  // postcssNesting(),
              //     // require("autoprefixer"),     // autoprefixer(),
              //   ],
              // },
              // we'll extract any component CSS out into
              // a separate file — better for performance
              // css: css => {
              //   css.write('public/css/bundle.css')
              // },
            }),
NEW
gsub_file('webpack.config.js', find, replace, verbose_opts)
git_commit('add svelte-preprocess configs to Webpack config file')
logger.success 'added svelte-preprocess configs to Webpack config file'


patch_end
puts
