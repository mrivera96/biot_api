<?php

namespace App\Http\Controllers\Finca;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Device;
use Illuminate\Support\Facades\DB;
use Auth;

class DeviceController extends Controller
{
	/**
     * Funcion device lista todos los dispositivos biometricos
     * existentes.
     *
     * @return json  respuesta
     */
    public function device(){
        if (Auth::user()->id == 1) {
            $device = Device::orderBy('Description', 'asc')->get();
            
            return response()->json(['data'=> $device],200);
        }
            $devices=DB::table('door_permissions')
            ->where('Id_user', Auth::user()->id)
            ->get();
            $final=[];

            foreach($devices as $device){
                $usrdevices=Device::where('IdDevice', $device->Id_Device)
                ->get();
                foreach($usrdevices as $usrdev){
                    array_push($final,$usrdev);
                }
            }

            return response()->json(['data'=> $final],200);
        
    }

    /**
     * Funcion registerDevice crea un nuevo dispositivo biometrico
     * para al sistema.
     *
     * @param  int  IdDevice
     * @param  int  MachineNumber
     * @param  string  Description
     * @param  string  ConnectionType
     * @param  string  IP
     * @param  int  PortNumber
     * @param  int  Type
     * @return json  respuesta
     */
    public function registerDevice(Request $request){
        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'MachineNumber' => ['required', 'int'],
            'Description' => ['required', 'string'],
            'ConnectionType' => ['required', 'string'],
            'IP' => ['required', 'string'],
            'PortNumber' => ['required', 'int'],
            'Type' => ['required', 'int']
        ]);

        $nombreDispositivo = Device::select('Description')->where('Description', request('Description'))->value('Description');

        if ($nombreDispositivo == request('Description')) {
            return response()->json(['message'=> 'El nombre del dispositivo ya existe.'],422);
        }else{
            $registerDevice = new Device();
            $registerDevice->MachineNumber = request('MachineNumber');
            $registerDevice->MachinePassword = '';
            $registerDevice->Description = request('Description');
            $registerDevice->Comment = '';
            $registerDevice->ConnectionType = request('ConnectionType'); // 11 = pantalla monocromatica 12 = identificador de rostro
            $registerDevice->IP = request('IP');
            $registerDevice->PortNumber = request('PortNumber');
            $registerDevice->SerialPort = 0;
            $registerDevice->BaudRate = 4.00;
            $registerDevice->Type = request('Type'); // 11 = pantalla monocromatica 12 = identificador de rostro
            $registerDevice->Connect = 0;
            $registerDevice->Synchronize = 1;
            $registerDevice->DownloadRecords = 0;
            $registerDevice->Attendance = 0;
            $registerDevice->save();

            return response()->json(['message'=> 'Nuevo dispositivo creado con éxito.',
                                     'departamento' => $registerDevice],201);
        }
    }

    /**
     * Función deviceById obtiene el dispositivo existente
     * por medio de su IdDevice.
     *
     * @param  int  IdDevice
     * @return json  respuesta
     */
    public function deviceById(Request $request){
        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'IdDevice' => ['required', 'int']
        ]);

        $deviceById = Device::find(request('IdDevice'));
        
        return response()->json(['respuesta' => $deviceById],200);
    }

    /**
     * Funcion editDevice edita la informacion de un dispositivo.
     *
     * @param  int  IdDevice
     * @param  int  MachineNumber
     * @param  string  Description
     * @param  string  ConnectionType
     * @param  string  IP
     * @param  int  PortNumber
     * @param  int  Type
     * @return json  mensaje
     */
    public function editDevice(Request $request){
        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'IdDevice' => ['required', 'int'],
            'MachineNumber' => ['required', 'int'],
            'Description' => ['required', 'string'],
            'ConnectionType' => ['required', 'string'],
            'IP' => ['required', 'string'],
            'PortNumber' => ['required', 'int'],
            'Type' => ['required', 'int']
        ]);

        $nombreDispositivo = Device::select('Description')->where('Description', request('Description'))->value('Description');

        if ($nombreDispositivo == request('Description')) {
            return response()->json(['message'=> 'El nombre del dispositivo ya existe.'],422);
        }else{
            $editDevice = Device::find(request('IdDevice'));
            $editDevice->IdDevice = request('IdDevice');
            $editDevice->MachineNumber = request('MachineNumber');
            $editDevice->MachinePassword = '';
            $editDevice->Description = request('Description');
            $editDevice->Comment = '';
            $editDevice->ConnectionType = request('ConnectionType');
            $editDevice->IP = request('IP');
            $editDevice->PortNumber = request('PortNumber');
            $editDevice->SerialPort = 0;
            $editDevice->BaudRate = 4.00;
            $editDevice->Type = request('Type'); // 11 = pantalla monocromatica 12 = identificador de rostro
            $editDevice->Connect = 0;
            $editDevice->Synchronize = 1;
            $editDevice->DownloadRecords = 0;
            $editDevice->Attendance = 0;
            $editDevice->save();

            return response()->json(['message'=> 'Dispositivo actualizado con éxito.',
                                 'dispositivo' => $editDevice],200);
        }
    }
}
