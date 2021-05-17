# add & configure Tailwind CSS to a [new] Laravel project

# DOCS: https://tailwindcss.com/docs/guides/laravel


set_current_patch 'css:tailwind' # current patch

puts
patch_start


npm_install_dev('tailwindcss@latest postcss@latest autoprefixer@latest', 'installed tailwindcss, postcss & autoprefixer packages')

npm_install_dev('postcss-import postcss-preset-env', 'installed postcss-import & postcss-preset-env packages')

npm_install_dev('sass sass-loader')

npm_install_dev('resolve-url-loader@^3.1.2 --legacy-peer-deps')

npx_run('tailwindcss init')

gsub_file('tailwind.config.js',
  'purge: []',
  "mode: 'jit',\n  purge: ['./resources/**/*.{js,svelte,vue,blade.php}']",
  verbose_opts
)
logger.success 'updated tailwind.config.js file with jit & purge setup'

# TODO: add Montserrat font loading to Layouts
gsub_file(
  'tailwind.config.js',
  "theme: {\n    extend: {},\n  }",
  "theme: {\n    extend: {\n      fontFamily: {\n        sans: ['Montserrat', 'sans-serif']\n      }\n    },\n  }",
  verbose_opts
)
git_commit('update tailwind.config.js')
logger.success 'updated tailwind.config.js file with fontFamily'


oldcode = <<-OLD
    .postCss('resources/css/app.css', 'public/css', [
        //
    ]);
OLD

# .sass('resources/scss/tailwind.scss', 'public/css')
newcode = <<-NEW
    .sass('resources/scss/app.scss', 'public/css')
    .options({
        processCssUrls: false,
        postCss: [
            require('postcss-import'),
            require('tailwindcss'),
            require('postcss-preset-env')({ stage: 1 }),
            // require('autoprefixer'),
        ],
    })
    .version()
    .sourceMaps()
    // insert
    ;
NEW

# replace contents in webpack.mix.js
gsub_file('webpack.mix.js', oldcode, newcode, verbose_opts)
git_commit('update webpack.mix.js')
logger.success 'updated webpack.mix.js file with Tailwind CSS configs'

gsub_file('package.json',
    '"development": "mix"',
    '"development": "TAILWIND_MODE=build mix"',
    verbose_opts
)
gsub_file('package.json',
    '"watch": "mix watch"',
    '"watch": "TAILWIND_MODE=watch NODE_ENV=development mix watch"',
    verbose_opts
)
gsub_file('package.json',
    '"production": "mix --production"',
    '"production": "TAILWIND_MODE=build NODE_ENV=production mix --production"',
    verbose_opts
)
git_commit('update package.json to handle Tailwind JIT support')
logger.success 'updated package.json to handle Tailwind JIT support'

# ['tailwind', 'app', 'app/_theme',
#   'kzen/animations', 'kzen/buttons', 'kzen/alerts' ,
#   'kzen/debug', 'kzen/globals','kzen/mixins',
#   'kzen/scrollbars', 'kzen/dropdowns', 'kzen/forms',
#   'kzen/tables', 'kzen/paginations', 'kzen/overlays',
# ].each do |f|
#   template(tmpl_file("scss/#{f}.scss"), "resources/scss/#{f}.scss", verbose_opts)
# end
directory(tmpl_dir('scss'), 'resources/scss', verbose_opts)
git_commit('tailwind: added core SCSS files')
logger.success "added core SCSS files"


# TODO:  fails at this position with 'resolve-url-loader' un-committed as a npm package

# npm run dev
npm_run_dev 'ran npm run dev to generate .css assets'


patch_end
puts
