# Add Svelte-loader support to an existing solution

set_current_prompt 'js:svelte:loader'

puts
patch_start

# set the config value if not set
confs.set('js.svelte.svelte-loader', value: true) unless confs.fetch('js.svelte.svelte-loader')


# 1) test for svelte-loader config first. If found, then inform, else install svelte-loader
npm_install_dev_if_not_installed?('svelte-loader')

# 2) update webpack.config.js with svelte-preprocess settings
find = <<-FIND
      // svelte_loader_replace
FIND
replace = <<-NEW
      {
        test: /\\.(svelte)$/,
        resolve: {
          fullySpecified: false // load Svelte correctly
        },
        use: {
          loader: 'svelte-loader',
          options: {
            emitCss: true,
            hotReload: true,
            // compilerOptions: {
            //   css: false
            // },
            // postCSS_replace
            // svelte_preprocess_replace
          },
        },
      },
NEW
gsub_file('webpack.config.js', find, replace, verbose_opts)

# test for postCSS and postCSS configurations
if postCSS?

find = <<-FIND
            // postCSS_replace
FIND
replace = <<-NEW
            postcss: true,
            // postcss: {
            //   syntax: 'postcss-scss',
            //   // parser: 'postcss-scss',
            //   plugins: [
            //     // require("tailwindcss"),      // tailwind(),
            //     // require("postcss-nesting"),  // postcssNesting(),
            //     // require("autoprefixer"),     // autoprefixer()
            //   ],
            // },
NEW
  gsub_file('webpack.config.js', find, replace, verbose_opts)
  git_commit('update svelte-loader config in Webpack config with postCSS')
  logger.success 'updated svelte-loader config in Webpack config with postCSS'

end


patch_end
puts
