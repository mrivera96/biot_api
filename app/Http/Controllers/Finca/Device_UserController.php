<?php

namespace App\Http\Controllers\Finca;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Device_User;
use Illuminate\Support\Facades\DB;
use App\biotrackcmdphp\BioTrackCmd;
use App\Record;
use App\User;
use App\UserFingerprint;


class Device_UserController extends Controller
{
    /**
     * Funcion deleteDeviceUser elimina el registro donde se asigna
     * el dispositivo a un empleado.
     *
     * @param  int  user_id
     * @param  int  device_id
     * @return json  respuesta
     */
    public function deleteDeviceUser($user_id, $device_id)
    {
        $deleteDeviceUser = Device_User::where([
            ['IdUser', '=', $user_id],
            ['IdDevice', '=', $device_id]
        ])->delete();
        if ($deleteDeviceUser) {
            return true;
        } else
            return false;
    }

    /**
     * Funcion getDeviceUser lista todos los dispositivos en los que esta
     * ubicado un empleado si este existe en el dispositivo fisico y no en la base
     * local, obtendra dicho registro y lo guardara localmente.
     *
     * se realiza esto para bases ya existentes que quieran user el sistema Reporteria Biometrico Camacho
     *
     * @param  int  IdUser
     * @return json  respuesta
     */
    public function getDeviceUser(Request $request)
    {
        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'IdUser' => 'required'
        ]);

        $tieneDisp = DB::table('User')
            ->where('tieneDispositivo', 1)
            ->where('IdUser', $request->IdUser)
            ->get();
            
        if(count($tieneDisp)==0){
            return response()->json(['respuesta' => 'El empleado no tiene dispositivos asignados.'], 422);
        }

        $listDevice = DB::table('Device')->select('IdDevice', 'IP', 'Type')->get();
        $IdUser = request('IdUser');
        $huellasEncontradas = [];
        $type = "";
        $getDeviceUser = DB::table('Device_User')
            ->join('Device', 'Device_User.IdDevice', '=', 'Device.IdDevice')
            ->where('Device_User.IdUser', $IdUser)
            ->get();

        if (count($getDeviceUser) == 0) {
            foreach ($listDevice as $key) {

                if ($key->Type == 11) {
                    $type = "bw";
                } else {
                    $type = "bioface";
                }

                $cmd = new BioTrackCmd($type, $key->IP);
                $existeEnDispositivo = $cmd->get_user($IdUser);
                if ($existeEnDispositivo) {
                    $Device_User = new Device_User();
                    $Device_User->IdUser = $IdUser;
                    $Device_User->IdDevice = $key->IdDevice;
                    $Device_User->save();
                }
            }

            $getDeviceUser = DB::table('Device_User')
                ->join('Device', 'Device_User.IdDevice', '=', 'Device.IdDevice')
                ->where('Device_User.IdUser', $IdUser)
                ->get();
            $huellasEncontradas = "No";

            if (count($getDeviceUser) > 0) {
                return response()->json(['respuesta' => $getDeviceUser, 'tieneHuellas' => $huellasEncontradas], 200);
            } else
                return response()->json(['respuesta' => 'El empleado no tiene dispositivos asignados.'], 422);
        } else {

            $getUserFingerprint = DB::table('UserFingerprint')->where('IdUser', $IdUser)->get();
            if (count($getUserFingerprint) == 0) {
                $huellasEncontradas = $this->tieneHuellas($getDeviceUser, $IdUser);
            } else {
                $huellasEncontradas = $getUserFingerprint;
            }

            if (count($getDeviceUser) > 0) {
                return response()->json(['respuesta' => $getDeviceUser, 'tieneHuellas' => $huellasEncontradas], 200);
            } else
                return response()->json(['respuesta' => 'El empleado no tiene dispositivos asignados.'], 422);
        }

        return response()->json(['respuesta' => $getUserFingerprint, 'tieneHuellas' => $huellasEncontradas], 200);
    }

    public function tieneHuellas($devicesUser, $idUser)
    {
        //$huellasEncontradas = [];
        $type = "";
        $tamaño = count($devicesUser);
        for ($i = 0; $i < $tamaño; $i++) {
            $type = "bw";
            if ($devicesUser[$i]->Type != 11) {
                $type = "bioface";
            } 

            $cmdH = new BioTrackCmd($type, $devicesUser[$i]->IP);
            if($cmdH){
                $user = $cmdH->get_user_data($idUser);
                if ($user) {
                    $huellas = $user['userFingerprints'];
                    $tamaño2 = count($huellas);

                    for ($x = 0; $x < $tamaño2; $x++) {
                        $fingerPrint = $huellas[$x];
                        $usrfing = new UserFingerprint();
                        if ($fingerPrint) {
                            $usrfing->IdUser = $idUser;
                            $usrfing->FingerNumber = strval($x);
                            $usrfing->Version = strval(10);
                            $usrfing->FingerPrintSize = strval(strlen($fingerPrint));
                            $usrfing->FingerPrint = $fingerPrint;
                            $usrfing->save();
                        }
                    }
                    break;
                } 
            }
            

        }
        $getUserFingerprint = DB::table('UserFingerprint')->where('IdUser', $idUser)->get();
        return $getUserFingerprint;

/*
        for ($i = 0; $i < $tamaño; $i++) {
            if ($devicesUser[$i]->Type == 11) {
                $type = "bw";
            } else {
                $type = "bioface";
            }

            $cmdH = new BioTrackCmd($type, $devicesUser[$i]->IP);
            $user = $cmdH->get_user_data($idUser);

             if ($user){
                $huellasEncontradas = $user['userFingerprints'];
            }


            if ($user) {
                $huellas = $user['userFingerprints'];
            } else {
                $huellas = [];
            }

            $tamaño2 = count($huellas);

            if (count($huellasEncontradas) > 0) {
                return $huellasEncontradas;
            } else {
                $usrfing = new UserFingerprint();

                for ($x = 0; $x < $tamaño2; $x++) {
                    $fingerPrint = $huellas[$x];
                    if ($fingerPrint) {

                        $data = [
                            'IdUser' => $idUser,
                            'FingerNumber' => strval($x),
                            'Version' => strval(10),
                            'FingerPrintSize' => strval(strlen($fingerPrint)),
                            'FingerPrint' => $fingerPrint
                        ];


                        array_push($huellasEncontradas, $data);
                    }
                }
            }
        }*/
    }

    public function depUserDB()
    {
        $user = [
            1,
            3,
            5,
            7,
            9,
            30,
            33,
            37,
            45,
            60,
            71,
            78,
            84,
            253,
            255,
            256,
            258,
            259,
            260,
            261,
            262,
            263,
            264,
            265,
            341,
            350,
            503,
            504,
            521,
            522,
            526,
            528,
            532,
            537,
            543,
            549,
            555,
            557,
            572,
            574,
            577,
            581,
            586,
            592,
            602,
            623,
            630,
            654,
            659,
            678,
            696,
            719,
            721,
            725,
            726,
            729,
            732,
            734,
            737,
            740,
            741,
            745,
            747,
            749,
            753,
            754,
            755,
            756,
            757,
            758,
            771,
            772,
            776,
            778,
            781,
            783,
            784,
            785,
            787,
            788,
            839,
            891,
            928,
            938,
            939,
            949,
            953,
            965,
            967,
            985,
            993,
            994,
            1007,
            1011,
            1017,
            1036,
            1045,
            1057,
            1072,
            1073,
            1075,
            1089,
            1090,
            1094,
            1101,
            8000,
            8004,
            8005,
            8008,
            8011,
            8012,
            8013,
            8014,
            8015,
            8016,
            8017,
            8018,
            9005,
            9006,
            9008,
            9009,
            1234567
        ];


        for ($i = 0; $i < sizeof($user); $i++) {
            $record = DB::table('User')->where('IdUser', '=', $user[$i]);

            $record->delete();
        }
    }

    public function depurarUser(Request $request)
    {
        /*Validacion de campos que se pueden recibir
        $this->validate($request, [
            'IdUser' => 'required'
        ]);*/

        $user = [
            1,
            3,
            5,
            7,
            9,
            30,
            33,
            37,
            45,
            60,
            71,
            78,
            84,
            253,
            255,
            256,
            258,
            259,
            260,
            261,
            262,
            263,
            264,
            265,
            341,
            350,
            503,
            504,
            521,
            522,
            526,
            528,
            532,
            537,
            543,
            549,
            555,
            557,
            572,
            574,
            577,
            581,
            586,
            592,
            602,
            623,
            630,
            654,
            659,
            678,
            696,
            719,
            721,
            725,
            726,
            729,
            732,
            734,
            737,
            740,
            741,
            745,
            747,
            749,
            753,
            754,
            755,
            756,
            757,
            758,
            771,
            772,
            776,
            778,
            781,
            783,
            784,
            785,
            787,
            788,
            839,
            891,
            928,
            938,
            939,
            949,
            953,
            965,
            967,
            985,
            993,
            994,
            1007,
            1011,
            1017,
            1036,
            1045,
            1057,
            1072,
            1073,
            1075,
            1089,
            1090,
            1094,
            1101,
            8000,
            8004,
            8005,
            8008,
            8011,
            8012,
            8013,
            8014,
            8015,
            8016,
            8017,
            8018,
            9005,
            9006,
            9008,
            9009,
            1234567
        ];

        $listDevice = DB::table('Device')->select('IdDevice', 'IP', 'Type')->get();

        for ($i = 0; $i < count($user); $i++) {
            foreach ($listDevice as $key) {

                if ($key->Type == 11) {
                    $type = "bw";
                } else {
                    $type = "bioface";
                }

                $cmd = new BioTrackCmd($type, $key->IP);
                $del_user = $cmd->delete_user($user[$i]);
            }
        }

        return response()->json(['respuesta' => 'todos los usuarios eliminados'], 200);


        //$IdUser = request('IdUser');         
    }
}
