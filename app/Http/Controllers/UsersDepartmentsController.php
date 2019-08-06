<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\UsersDepartments;
class UsersDepartmentsController extends Controller
{
    public static function save($id,  $depts)
    {     
        $errcount = 0;
        foreach ($depts as $depto) {
            $exists = UsersDepartments::where('Id_user', '=', $id)
                ->where('Id_department', '=', $depto['Id_department'])->first();
            if ($exists) { } else {
                $depts = new UsersDepartments();
                $depts->Id_user = $id;
                $depts->Id_department = $depto['Id_department'];

                if (!$depts->save()) {
                    $errcount++;
                }
            }
        }

         if ($errcount > 0) {
            return false;
        } else {
            return true;
        }
    }

    public function showDepartments()
    {
        $id = request('id_user');
        
        $depts = new UsersDepartments();
        $exists = $depts->where('Id_user', '=', $id)->get(['Id_user'])->first();
        if ($exists) {
            $permisos = $depts->where('Id_user', '=', $id)->get();

            return response()->json(['departamentos' => $permisos], 200);
        } else {
            return response()->json("Este usuario no tiene departamentos asignados", 200);
        }
    }

    public function deleteDeparments()
    {
        $id = request('id_user');
        $depto = request('id_depto');

        $depts = new UsersDepartments();
        $exists = $depts->where('Id_user', '=', $id)->where('Id_department', '=', $depto)->get(['Id_user'])->first();
        if ($exists) {
            $del = UsersDepartments::where('Id_user', '=', $id)->where('Id_department', '=', $depto);
            if ($del->delete()) {
                return response()->json('Departamento eliminado correctamente.', 200);
            } else {
                return response()->json('Ocurrió un error al eliminar este departamento.', 500);
            }
        } else {
            return response()->json("Este usuario no tiene este departamento asignado", 200);
        }
    }
}