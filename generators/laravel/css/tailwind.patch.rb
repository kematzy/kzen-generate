# add & configure Tailwind CSS to a [new] Laravel project

# DOCS: https://tailwindcss.com/docs/guides/laravel


set_current_patch 'css:tailwind' # current patch

puts
patch_start

# tell confs we are using TailwindCSS
confs.set('css.tailwind', value: true) unless confs.fetch('css.tailwind')


npm_install_dev('tailwindcss@latest', 'installed latest tailwindcss package')

npm_install_dev('autoprefixer@latest', 'installed latest autoprefixer package')

patch_run('css:postcss') # defaults to postCSS

npm_install_dev('resolve-url-loader@^3.1.2 --legacy-peer-deps')

npx_run('tailwindcss init')

gsub_file('tailwind.config.js',
  'purge: []',
  "mode: 'jit',\n  purge: []",
  verbose_opts
)
git_commit('update tailwind.config.js with JIT setup')
logger.success 'updated tailwind.config.js file with JIT setup'

gsub_file('tailwind.config.js',
  'purge: []',
  "purge: ['./resources/**/*.{js,svelte,vue,blade.php}']",
  verbose_opts
)
git_commit('update tailwind.config.js with purge setup')
logger.success 'updated tailwind.config.js file with purge setup'

gsub_file('tailwind.config.js',
  'darkMode: false, // or \'media\' or \'class\'',
  "darkMode: 'class',  // false or 'media' or 'class'",
  verbose_opts
)
git_commit('update tailwind.config.js with darkMode setup')
logger.success 'updated tailwind.config.js file with darkMode setup'

# patch_run('css:tailwind:config-purge')


# TODO: add Montserrat font loading to Layouts
contents  = <<-CODE
  theme: {
    extend: {
      fontFamily: {
        sans: ['Montserrat', 'sans-serif']
      },
      colors: {
        // CONCEPT:  DEFAULT: = base colour, then 5 darker / brighter colours on each side
        'dark': {
          'b5': '#32353D',
          'b4': '#30333B',
          'b3': '#2E3139',
          'b2': '#2C3038',
          'b1': '#2A2E36',
          DEFAULT: '#282c34',
          'd1': '#25272C',
          'd2': '#212328',
          'd3': '#1D1F24',
          'd4': '#181B20',
          'd5': '#14171C'
        },
        'light': {
          'b5': '#ffffff',
          'b4': '#fcfcfc',
          'b3': '#faf8f8',
          'b2': '#f7f5f5',
          'b1': '#f4f1f1',
          DEFAULT: '#ebedef',
          'd1': '#f0ebea',
          'd2': '#ece7e6',
          'd3': '#e9e4e3',
          'd4': '#e5e0df',
          'd5': '#e1dcdb'
        },
        'primary': {
          'b5': '#A855F7',
          'b4': '#9E4DE9',
          'b3': '#9445DC',
          'b2': '#8A3ECE',
          'b1': '#8036C1',
          DEFAULT: '#653B89',
          'd1': '#752EB3',
          'd2': '#6B26A6',
          'd3': '#611F98',
          'd4': '#57178B',
          'd5': '#4D0F7D'
        },
        'secondary': {
          'b5': '#746B87',
          'b4': '#6E6484',
          'b3': '#685D81',
          'b2': '#61577D',
          'b1': '#5B507A',
          DEFAULT: '#554977',
          'd1': '#4E426D',
          'd2': '#473C64',
          'd3': '#41355A',
          'd4': '#3A2F51',
          'd5': '#332847'
        },
        'success': {
          DEFAULT: '#304C2F',
          '50': '#4B7749',
          '100': '#487246',
          '200': '#426840',
          '300': '#3C5F3A',
          '400': '#365534',
          '500': '#304C2F',
          '600': '#2A4229',
          '700': '#243923',
          '800': '#1E2F1D',
          '900': '#182617'
        },
        'warning': {
          // https://www.tailwindshades.com/#color=7A5824&step-up=3&step-down=3&name=dallas
          DEFAULT: '#7A5A24',
          '50': '#AF8234',
          '100': '#A97D32',
          '200': '#9D752F',
          '300': '#916C2B',
          '400': '#866328',
          '500': '#7A5A24',
          '600': '#6E5221',
          '700': '#62491D',
          '800': '#56401A',
          '900': '#4B3716'
        },
        'error': {
          DEFAULT: '#642626',
          '50': '#963939',
          '100': '#903737',
          '200': '#853232',
          '300': '#7A2E2E',
          '400': '#6F2A2A',
          '500': '#642626',
          '600': '#592222',
          '700': '#4E1D1D',
          '800': '#431919',
          '900': '#371515'
        },
        'info': {
          // https://www.tailwindshades.com/#color=24487A&step-up=3&step-down=3&name=info
          DEFAULT: '#24487A',
          '50': '#3467AF',
          '100': '#3264A9',
          '200': '#2F5D9D',
          '300': '#2B5691',
          '400': '#284F86',
          '500': '#24487A',
          '600': '#21416E',
          '700': '#1D3A62',
          '800': '#1A3356',
          '900': '#162C4B'
        },
        'bluegray': {
          // https://www.tailwindshades.com/#color=576B84&step-up=9&step-down=10&name=blue-bayoux
          DEFAULT: '#576B84',
          '50': '#CCD4DD',
          '100': '#BFC8D4',
          '200': '#A3B1C2',
          '300': '#8799B0',
          '400': '#6C829D',
          '500': '#576B84',
          '600': '#435265',
          '700': '#2F3947',
          '800': '#1A2028',
          '900': '#060709'
        },
      },
    },
  },
CODE
gsub_file('tailwind.config.js', "theme: {\n    extend: {},\n  },", contents, verbose_opts)
git_commit('update tailwind configs with fonts & colors')
logger.success 'updated tailwind configs with fonts & colors'

# oldcode = <<-OLD
#     require('postcss-nesting'),
# OLD

# newcode = <<-NEW
#     require('postcss-nesting'),
#     require('tailwindcss'),
#     require('autoprefixer')
# NEW

# # replace contents in webpack.mix.js
# gsub_file('webpack.mix.js', oldcode, newcode, verbose_opts)
# git_commit('update webpack.mix.js')
# logger.success 'updated webpack.mix.js file with Tailwind CSS configs'


# run_patch('css:')

# template(tmpl_file("mix/#{confs.fetch('js.type')}/webpack.config.js"), 'webpack.config.js')
# git_commit('added webpack.config.js file')
# logger.success 'added webpack.config.js file'


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


directory(tmpl_dir('postcss'), 'resources/css', verbose_opts)
git_commit('added core postCSS files')
logger.success "added core postCSS files"


# setup browserSync support
patch_run('mix:browser-sync') if confs.fetch('features.mix.browsersync')

# setup StyleLint support
patch_run('css:stylelint') if confs.fetch('features.css.stylelint')


# npm run dev
# npm_run_dev 'ran npm run dev to generate .css assets'


gsub_file('resources/views/welcome.blade.php',
    /<style>(.*)<\/style>/m,
    '<link href="{{ mix(\'/css/app.css\') }}" rel="stylesheet" />',
    verbose_opts
)
git_commit('replace embedded CSS with app.css')
logger.success "replaced embedded CSS with app.css"


patch_end
puts
