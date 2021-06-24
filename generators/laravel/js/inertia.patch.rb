# Adding Inertia JS support to a [new] Laravel project

# DOCS: https://inertiajs.com/server-side-setup

set_current_patch 'js:inertia'

puts
patch_start


# TODO: move this to a prompt
unless confs.fetch('js.type')
  confs.set('js.type', value: prompt.select("Choose JS setup?", [ {name:'Svelte',value:'svelte'},{name:'Vue',value:'vue'} ]))
end

# set the config value if not set
confs.set('js.inertiajs', value: true) unless confs.fetch('js.inertiajs')

# install InertiaJS
composer_install('inertiajs/inertia-laravel')

artisan_cmd('inertia:middleware')

find = <<-FIND
    public function share(Request $request)
    {
        return array_merge(parent::share($request), [
            //
        ]);
    }
FIND
replace = <<-NEW
    public function share(Request $request)
    {
        return array_merge(parent::share($request), [
            // Lazily
            'auth.user' => fn () => $request->user()
                ? $request->user()->only('id', 'name', 'email')
                : null,

            //
            // 'session' => session()->all(),
            'flash' => function () {
                if (session()->has('_flash.old')) {
                    $key = $this->getFlashKey(session('_flash.old'));
                } elseif (session()->has('_flash.new')) {
                    $key = $this->getFlashKey(session('_flash.new'));
                } else {
                    $key = null;
                }
                return [
                    'key' => $key,
                    'message' => $key !== null ? session()->get($key) : null,
                    // 'error' => Session::get('error'),
                    // 'info' => Session::get('info'),
                    // 'success' => Session::get('success'),
                    // 'warning' => Session::get('warning'),
                    'keys' => session('_flash'),
                ];
            },
        ]);
    }

    protected function getFlashKey($flash) {
        $keys = ['success', 'info', 'warning', 'error'];
        foreach($keys as $k) {
          if (in_array($k, $flash)) {
            return $k;
          }
      }
    }

NEW
gsub_file('app/Http/Middleware/HandleInertiaRequests.php', find, replace, verbose_opts)
git_commit('update the HandleInertiaRequests middleware')
logger.success 'updated the HandleInertiaRequests middleware'


find = <<-FIND
            \\App\\Http\\Middleware\\VerifyCsrfToken::class,
FIND
replace = <<-NEW
            \\App\\Http\\Middleware\\VerifyCsrfToken::class,
            \\App\\Http\\Middleware\\HandleInertiaRequests::class,
NEW
gsub_file('app/Http/Kernel.php', find, replace, verbose_opts)
git_commit('update app/Http/Kernel.php with middleware')
logger.success 'updated app/Http/Kernel.php file with inertia middleware'


### NPM INSTALLS

npm_install("@inertiajs/inertia @inertiajs/inertia-#{get_js_type}")

npm_install('@inertiajs/progress')

patch_run("js:#{get_js_type}")


### ADD FILES ===========

patch_run('js:prettier')

patch_run('inertiajs:babel')


template(tmpl_file("inertia/app.blade.php"), 'resources/views/app.blade.php', verbose_opts)
git_commit('add views/app.blade.php file')
logger.success 'added views/app.blade.php file'

# Add JS components, layouts and pages
directory(tmpl_dir("inertia/#{get_js_type}"), 'resources/js', verbose_opts)
git_commit('added resource/js contents')
logger.success 'added resources/js contents'


patch_run('css:tailwind:config-purge-svelte') if svelte?

# add tightenco/ziggy support
patch_run('inertiajs:ziggy')

# ensure the correct webpack config is present
patch_run('mix:webpack')


#  add routes

find = <<-FIND
use Illuminate\\Support\\Facades\\Route;
FIND
replace = <<-NEW
use Illuminate\\Foundation\\Application;
use Illuminate\\Support\\Facades\\Route;
use Inertia\\Inertia;
// route_includes
NEW
gsub_file('routes/web.php', find, replace, verbose_opts)
git_commit('add Inertia includes in routes/web')
logger.success 'add Inertia includes in routes/web'

find = <<-FIND
Route::get('/', function () {
    return view('welcome');
});
FIND
replace = <<-NEW
Route::get('/', function () {
    return Inertia::render('Welcome', [
        'enabled' => [
          'login' => Route::has('login'),
          'register' => Route::has('register'),
        ],
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
})->name('home');

// auth_routes
NEW
gsub_file('routes/web.php', find, replace, verbose_opts)
git_commit('update home route')
logger.success 'updated home route'

remove_file('resources/views/welcome.blade.php', verbose_opts)
git_commit('removed unused blade file')
logger.success 'removed unused blade file'


puts
patch_end
