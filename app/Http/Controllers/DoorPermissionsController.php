<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DoorPermissions;
use PHPUnit\Runner\Exception;
use App\Device;
use Illuminate\Support\Facades\DB;

class DoorPermissionsController extends Controller
{
    public static function save($id, $devices)
    {
        
        $errcount = 0;
        foreach ($devices as $device) {
            $exists = DoorPermissions::where('Id_user', '=', $id)
                ->where('Id_Device', '=', $device['IdDevice'])->first();
            if ($exists) { } else {
                $perms = new DoorPermissions();
                $perms->Id_user = $id;
                $perms->Id_Device = $device['IdDevice'];

                if (!$perms->save()) {
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

    public function showPermissions()
    {
        $id = request('id_user');
        if (request()->has('nombre')) {
            $puertas = DB::table('Device')
                ->join('door_permissions', 'Device.IdDevice', '=', 'door_permissions.Id_Device')
                ->select('door_permissions.Id_Device', 'Device.Description')
                ->where('Id_user', '=', $id)->get();
            if (count($puertas)>0) {
                return response()->json(['puertas' => $puertas], 200);
            } else {
                return response()->json("Este usuario no tiene puertas asignadas", 200);
            }
        }


        $perms = new DoorPermissions();
        $exists = $perms->where('Id_user', '=', $id)->get(['Id_user'])->first();
        if ($exists) {
            $permisos = $perms->where('Id_user', '=', $id)->get();

            return response()->json(['puertas' => $permisos], 200);
        } else {
            return response()->json("Este usuario no tiene puertas asignadas", 200);
        }
    }

    public function deletePermissions()
    {
        $id = request('id_user');
        $device = request('id_device');

        $perms = new DoorPermissions();
        $exists = $perms->where('Id_user', '=', $id)->where('Id_Device', '=', $device)->get(['id_user'])->first();
        if ($exists) {
            $del = DoorPermissions::where('Id_user', '=', $id)->where('Id_Device', '=', $device);
            if ($del->delete()) {
                return response()->json('Puerta eliminada correctamente.', 200);
            } else {
                return response()->json('Ocurrió un error al eliminar esta puerta.', 500);
            }
        } else {
            return response()->json("Este usuario no tiene esta puerta asignada", 200);
        }
    }
}
