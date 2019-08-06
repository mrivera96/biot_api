<?php

use Illuminate\Database\Seeder;
use App\Department;

class DepartmentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        $departmentFather = new Department();
        //$departmentFather->IdDepartment = 1000;
        $departmentFather->IdParent = null;
        $departmentFather->Description = "Diadema Zona Franca Hondurass";
        $departmentFather->SupervisorName = "ICT";
        $departmentFather->SupervisorEmail = "";
        $departmentFather->Comment = "";
        $departmentFather->DepartamentosSuperiores = null;
        $departmentFather->DepartamentosInferiores = null;
        $departmentFather->save();

        $setId = Department::find($departmentFather->IdDepartment);
        $setId->IdDepartment = 1000;
        $setId->save();
    }
}
