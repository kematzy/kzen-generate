# Adding LaraTrust support to a [new] Laravel project

# DOCS: https://laratrust.santigarcor.me/docs/6.x/

set_current_patch 'auth:laratrust'

puts
patch_start


composer_install('santigarcor/laratrust')

artisan_cmd('vendor:publish --tag="laratrust"', 'created local LaraTrust config file')

# IMPORTANT
#
# Before running the command go to your config/laratrust.php file and change the values according to your needs.

artisan_cmd('laratrust:setup')

# Dump the autoloader:
run('composer dump-autoload', debug_opts)

artisan_migrate


artisan_cmd('laratrust:seeder')

artisan_cmd('vendor:publish --tag="laratrust-seeder"', 'created LaraTrust seeder config file')

# Dump the autoloader:
run('composer dump-autoload', debug_opts)


find = <<-FIND
use Illuminate\\Database\\Seeder;
FIND
replace = <<-NEW
use Illuminate\\Database\\Seeder;
use Database\\Seeders\\LaratrustSeeder;
NEW
gsub_file('database/seeders/DatabaseSeeder.php', find, replace, verbose_opts)

find = <<-FIND
        $this->call([
FIND
replace = <<-NEW
        $this->call([
          LaratrustSeeder::class,
NEW
gsub_file('database/seeders/DatabaseSeeder.php', find, replace, verbose_opts)

git_commit('add LaratrustSeeder to DatabaseSeeder')
logger.success 'added LaratrustSeeder to DatabaseSeeder'



find = <<-FIND
    'create_users' => false,
FIND
replace = <<-NEW
    // 'create_users' => false,
    'create_users' => true,
NEW
gsub_file('config/laratrust_seeder.php', find, replace, verbose_opts)
git_commit('LaratrustSeeder configs: enable creation of role users')
logger.success 'LaratrustSeeder configs: enable creation of role users'

find = <<-FIND
    'permissions_map' => [
        'c' => 'create',
        'r' => 'read',
        'u' => 'update',
        'd' => 'delete'
    ]
FIND
replace = <<-NEW
    'permissions_map' => [
        'c' => 'create',
        'r' => 'read',
        'u' => 'update',
        'd' => 'delete',
        'x' => 'restore',
    ]
NEW
gsub_file('config/laratrust_seeder.php', find, replace, verbose_opts)
git_commit('LaratrustSeeder configs: enable restore permission')
logger.success 'LaratrustSeeder configs: enable restore permission'

find = <<-FIND
    'roles_structure' => [
        'superadministrator' => [
            'users' => 'c,r,u,d',
            'payments' => 'c,r,u,d',
            'profile' => 'r,u'
        ],
        'administrator' => [
            'users' => 'c,r,u,d',
            'profile' => 'r,u'
        ],
        'user' => [
            'profile' => 'r,u',
        ],
        'role_name' => [
            'module_1_name' => 'c,r,u,d',
        ]
    ],
FIND
replace = <<-NEW
    'roles_structure' => [
        'superadmin' => [
            'users' => 'c,r,u,d,x',
            'roles' => 'c,r,u,d,x',
            'permissions' => 'c,r,u,d,x',
            // 'payments' => 'c,r,u,d,x',
            'profile' => 'r,u'
        ],
        'admin' => [
            'users' => 'c,r,u',
            'roles' => 'c,r,u',
            'permissions' => 'c,r,u',
            'profile' => 'r,u'
        ],
        'user' => [
            'profile' => 'r,u',
        ],
        // 'role_name' => [
        //     'module_1_name' => 'c,r,u,d',
        // ]
    ],
NEW
gsub_file('config/laratrust_seeder.php', find, replace, verbose_opts)
git_commit('LaratrustSeeder configs: update default role structures')
logger.success 'LaratrustSeeder configs: update default role structures'

gsub_file('database/seeders/LaratrustSeeder.php', '@app.com', '@example.com', verbose_opts)
git_commit('LaratrustSeeder: update default email address')
logger.success 'LaratrustSeeder: update default email address'


# update User model
find = <<-FIND
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];
FIND
replace = <<-NEW
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    /**
     * The relationships that should always be loaded.
     *
     * @var array
     */
    protected $with = ['roles:id,name,display_name'];

   //models_user_sentinel
}
NEW
gsub_file('app/Models/User.php', find, replace, verbose_opts)
git_commit('update User model setup')
logger.success 'update User model setup'


# update Role model
find = <<-FIND
class Role extends LaratrustRole
{
    public $guarded = [];
}
FIND
replace = <<-NEW
class Role extends LaratrustRole
{
    public $guarded = [];

    /**
    * The attributes that are mass assignable.
    *
    * @var array
    */
    protected $fillable = [
        'name',
        'display_name',
        'description',
    ];

    /**
    * The attributes that should be hidden for arrays.
    *
    * @var array
    */
    protected $hidden = [];

    /**
    * The attributes that should be cast to native types.
    *
    * @var array
    */
    protected $casts = [];

    /**
    * The relationships that should always be loaded.
    *
    * @var array
    */
    // protected $with = ['permissions:id,name,display_name,description'];

    //models_role_sentinel
}
NEW
gsub_file('app/Models/Role.php', find, replace, verbose_opts)
git_commit('update Role model setup')
logger.success 'update Role model setup'


# update Permission model
find = <<-FIND
class Permission extends LaratrustRole
{
    public $guarded = [];
}
FIND
replace = <<-NEW
class Permission extends LaratrustRole
{
    public $guarded = [];

    /**
    * The attributes that are mass assignable.
    *
    * @var array
    */
    protected $fillable = [
        'name',
        'display_name',
        'description',
    ];

    /**
    * The attributes that should be hidden for arrays.
    *
    * @var array
    */
    protected $hidden = [];

    /**
    * The attributes that should be cast to native types.
    *
    * @var array
    */
    protected $casts = [];

    /**
    * The relationships that should always be loaded.
    *
    * @var array
    */
    // protected $with = ['roles:id,name,display_name,description'];

    //models_permission_sentinel
}
NEW
gsub_file('app/Models/Permission.php', find, replace, verbose_opts)
git_commit('update Permission model setup')
logger.success 'update Permission model setup'


if confs.fetch('auth:kzen') && svelte?
  # update
  gsub_file('resources/js/pages/auth/Login.svelte', 'joeblogs@email.com', 'superadmin@example.com', verbose_opts)
  git_commit('update default email address in Login.svelte')
  logger.success 'update default email address in Login.svelte'

  # update the Svelte stuff
  npm_run_dev
end


patch__end
puts
