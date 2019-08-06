<?php

use Illuminate\Database\Seeder;
use App\User;
use App\Role;

class UserTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
    	$role_admin = Role::where('name', 'Administrator')->first();
        //
        $user = new User();
        $user->name = 'Ramiro';
        $user->last_name = 'Sosa';
        $user->no_identidad = '0803-1982-05475';
        $user->email = 'ramiro.sosa@davidoff.com';
        $user->password = bcrypt('Diadema.2019');
        $user->activo = 1;
        $user->telefono = 88996655;
        $user->genero = 'M';
        $user->save();
        $user->roles()->attach($role_admin);

        //
        $user1 = new User();
        $user1->name = 'Josue';
        $user1->last_name = 'Harding';
        $user1->no_identidad = '0803-1983-05475';
        $user1->email = 'josue.harding@davidoff.com';
        $user1->password = bcrypt('Diadema.2019');
        $user1->activo = 1;
        $user1->telefono = 88996656;
        $user1->genero = 'M';
        $user1->save();
        $user1->roles()->attach($role_admin);

        //
        $user2 = new User();
        $user2->name = 'César';
        $user2->last_name = 'Rodriguez';
        $user2->no_identidad = '0803-1984-05475';
        $user2->email = 'cesar.rodriguez@davidoff.com';
        $user2->password = bcrypt('Diadema.2019');
        $user2->activo = 1;
        $user2->telefono = 88996657;
        $user2->genero = 'M';
        $user2->save();
        $user2->roles()->attach($role_admin);

        //
        $user3 = new User();
        $user3->name = 'Ever';
        $user3->last_name = 'Cruz';
        $user3->no_identidad = '0803-1985-05475';
        $user3->email = 'ever.cruz@davidoff.com';
        $user3->password = bcrypt('Diadema.2018');
        $user3->activo = 1;
        $user3->telefono = 88996658;
        $user3->genero = 'M';
        $user3->save();
        $user3->roles()->attach($role_admin);

    }
}
