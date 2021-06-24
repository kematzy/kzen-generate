<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::factory()->state([
          'name' => 'Joe Blogs',
          'email' => 'joeblogs@email.com',
          // 'password' => Hash::make('password'),
        ])->create();

        User::factory()->state([
          'name' => 'Jill Blogs',
          'email' => 'jillblogs@email.com',
          // 'password' => Hash::make('password'),
        ])->unverified()->create();

        $user = User::factory()->state([
          'name' => 'James Blogs',
          'email' => 'jamesblogs@email.com',
          // 'password' => Hash::make('password'),
        ])->create();

        $token = Password::broker()->createToken($user);

        DB::table('password_resets')->delete();

        DB::table('password_resets')->insert([
          'email' => $user->email,
          'token' => $token,
        ]);

        // echo DB::table('password_resets')->get();
    }
}
