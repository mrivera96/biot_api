<?php

use Illuminate\Database\Seeder;
use App\Role;
class RoleTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        $adminRole = new Role();
        $adminRole->name = "Administrator";
        $adminRole->description = "Admnistración total del sistema.";
        $adminRole->save();

        //
        $adminRole = new Role();
        $adminRole->name = "Usuario";
        $adminRole->description = "Admnistración de la reporteria en modo solo de lectura.";
        $adminRole->save();

    }
}
