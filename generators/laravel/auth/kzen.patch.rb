# add Kzen Auth support to a [new] Laravel project

# DOCS:

set_current_patch 'auth:kzen'

puts
patch_start


# add auth controllers taken from Laravel Breeze
[
  'AuthenticatedSessionController.php',
  'ConfirmablePasswordController.php',
  'EmailVerificationNotificationController.php',
  'EmailVerificationPromptController.php',
  'NewPasswordController.php',
  'PasswordResetLinkController.php',
  'RegisteredUserController.php',
  'VerifyEmailController.php',
].each do |c|
  template(tmpl_file("auth/kzen/Controllers/Auth/#{c}"), "app/Http/Controllers/Auth/#{c}", verbose_opts)
  git_commit("add Auth/#{c} file")
  logger.success "added Auth/#{c} file"
end

# add auth LoginRequest taken from Laravel Breeze
template(
  tmpl_file("auth/kzen/Requests/Auth/LoginRequest.php"),
  'app/Http/Requests/Auth/LoginRequest.php',
  verbose_opts
)
git_commit('add Requests/Auth/LoginRequest.php file')
logger.success 'added Requests/Auth/LoginRequest.php file'

# add Svelte components
f = 'components/auth/AuthBox.svelte'
template(tmpl_file("auth/kzen/svelte/#{f}"), "resources/js/#{f}", verbose_opts)
git_commit("add #{f} file")
logger.success "added #{f} file"

# add Svelte pages
[
  'auth/ConfirmPassword.svelte',
  'auth/ForgotPassword.svelte',
  'auth/Login.svelte',
  'auth/Register.svelte',
  'auth/ResetPassword.svelte',
  'auth/VerifyEmail.svelte',
  'admin/Dashboard.svelte',
  'admin/Settings.svelte',
  'admin/user/Profile.svelte',
  'PrivacyPolicy.svelte',
  'TermsOfService.svelte',
].each do |c|
  template(tmpl_file("auth/kzen/svelte/pages/#{c}"), "resources/js/pages/#{c}", verbose_opts)
  git_commit("add page: #{c} file")
  logger.success "added page: #{c} file"
end


find = <<-FIND
    public const HOME = '/home';
FIND
replace = <<-NEW
    public const HOME = '/admin/dashboard';
NEW
gsub_file('app/Providers/RouteServiceProvider.php', find, replace, verbose_opts)
git_commit('update Home in RouteServiceProvider.php file')
logger.success 'update Home in RouteServiceProvider.php file'


find = <<-FIND
// auth_routes
FIND
replace = <<-NEW
require __DIR__.'/auth.php';

Route::group(['middleware' => ['auth', 'verified'], 'prefix' => 'admin'], function () {
  Route::get('/', function () { return Inertia::render('admin/Dashboard'); })->name('admin.index');
  Route::get('/dashboard', function () { return Inertia::render('admin/Dashboard'); })->name('admin.dashboard');

  // ## Admin Settings routes
  Route::get('/settings', function () { return Inertia::render('admin/Settings'); })->name('admin.settings');
  // ## Admin User routes
  Route::get('/user/profile', function () { return Inertia::render('admin/user/Profile'); })->name('admin.user.profile');

}); // /group

NEW
gsub_file('routes/web.php', find, replace, verbose_opts)
git_commit('added Auth & Dashboard routes')
logger.success 'added Auth & Dashboard routes'


template(tmpl_file("auth/kzen/auth.php"), 'routes/auth.php', verbose_opts)
git_commit('added Auth routes')
logger.success 'added Auth routes'


# class User extends Authenticatable implements MustVerifyEmail
find = <<-FIND
class User extends Authenticatable
FIND
replace = <<-NEW
class User extends Authenticatable implements MustVerifyEmail
NEW
gsub_file('app/Models/User.php', find, replace, verbose_opts)
git_commit('add MustVerifyEmail to User model')
logger.success 'added MustVerifyEmail to User model'

# artisan_cmd()


# safelist: ['flex-row', 'flex-row-reverse', 'flex-col', 'flex-col-reverse'],


patch_end
puts
