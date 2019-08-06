<?php

use Illuminate\Database\Seeder;
use App\System_Parameters;

class SystemParametersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        $SystemParameter = new System_Parameters();
        $SystemParameter->parametro = "receso desayuno";
        $SystemParameter->descripcion = "Pausa o suspensión temporal de actividades para desayunar.";
        $SystemParameter->valor_parametro = "00:30:00";
        $SystemParameter->valores_permitidos = "00:15:00, 00:30:00, 00:45:00";
        $SystemParameter->valor_minimo = "00:15:00";
        $SystemParameter->valor_maximo = "00:45:00";
        $SystemParameter->activo = 1;
        $SystemParameter->visible = "S";
        $SystemParameter->CreatedBy = 0;
        $SystemParameter->ModifiedBy = 0;
        $SystemParameter->save();

        //
        $SystemParameter1 = new System_Parameters();
        $SystemParameter1->parametro = "receso almuerzo";
        $SystemParameter1->descripcion = "Pausa o suspensión temporal de actividades para almorzar.";
        $SystemParameter1->valor_parametro = "00:45:00";
        $SystemParameter1->valores_permitidos = "00:30:00, 00:45:00, 01:00:00";
        $SystemParameter1->valor_minimo = "00:30:00";
        $SystemParameter1->valor_maximo = "01:00:00";
        $SystemParameter1->activo = 1;
        $SystemParameter1->visible = "S";
        $SystemParameter1->CreatedBy = 0;
        $SystemParameter1->ModifiedBy = 0;
        $SystemParameter1->save();

        //
        $SystemParameter2 = new System_Parameters();
        $SystemParameter2->parametro = "restar minutos viernes";
        $SystemParameter2->descripcion = "Cantidad de minutos para restar al horario de día sábado, si los empleados deben salir antes del horario normal.";
        $SystemParameter2->valor_parametro = "0";
        $SystemParameter2->valores_permitidos = "De 0 a 59";
        $SystemParameter2->valor_minimo = "0";
        $SystemParameter2->valor_maximo = "59";
        $SystemParameter2->activo = 1;
        $SystemParameter2->visible = "S";
        $SystemParameter2->CreatedBy = 0;
        $SystemParameter2->ModifiedBy = 0;
        $SystemParameter2->save();

        //
        $SystemParameter3 = new System_Parameters();
        $SystemParameter3->parametro = "restar horas viernes";
        $SystemParameter3->descripcion = "Cantidad de horas para restar al día sábado, si los empleados deben salir antes del horario normal.";
        $SystemParameter3->valor_parametro = "1";
        $SystemParameter3->valores_permitidos = "De 0 a 12";
        $SystemParameter3->valor_minimo = "0";
        $SystemParameter3->valor_maximo = "12";
        $SystemParameter3->activo = 1;
        $SystemParameter3->visible = "S";
        $SystemParameter3->CreatedBy = 0;
        $SystemParameter3->ModifiedBy = 0;
        $SystemParameter3->save();
    }
}
