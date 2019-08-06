<?php

namespace App\Http\Controllers\Finca;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\User;
use Laravel\Passport\Client;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\UserBiometric;
use App\Role;
use Illuminate\Support\Facades\Auth;
use App\Device_User;
use App\UserShift;
use Carbon\Carbon;
use App\Http\Controllers\Finca\UserController;
use App\Http\Controllers\Finca\BioTrackCmdController;

class RegisterController extends Controller
{
    use IssueTokenTrait;

    private $client;

    /**
     * Funcion __construct crea el objeto cliente para obtener sus
     * caracteristicas y proveer 
     *
     * @param  int  id_client
     * @return object  client
     */
    public function __construct()
    {
        $this->client = Client::find(1);
    }

    /**
     * Funcion registerUserBiometric crea un nuevo usuario al biometrico
     * se crea el usuario, se le asigan los dispositivos que pertenece y
     * se le asigna su horario.
     *
     * @param  int  IdUser
     * @param  string  IdentificationNumber
     * @param  string  Name
     * @param  int  IdDepartment
     * @param  string  ShiftId
     * @param  string  active
     * @param  datetime  Birthday
     * @param  array  dispositivos
     * @param  array  huellas
     * @return json  respuesta
     */
    public function registerUserBiometric(Request $request)
    {
        try {
            date_default_timezone_set('America/Tegucigalpa');
            
            //Validacion de campos que se pueden recibir
            $this->validate($request, [
                'IdUser' => 'required',
                'IdentificationNumber' => 'required',
                'Name' => ['required', 'string', 'max:255'],
                'IdDepartment' => 'required',
                'ShiftId' => 'required',
                'Active' => 'required',
                'Birthday' => 'required',
                'listaDispositivos' => 'required',
                'fingerprints' => 'required'           
            ]);

            
            //declaracion de variables
            $errors = [];
            $date = Carbon::now();
            $userController = new UserController();
            $id = request('IdUser');
            $name = request('Name');
            $estado = request('Active');
            $userById = UserBiometric::find($id);
            $lista = request('listaDispositivos');
            $fingerprints = request('fingerprints');

            /*$lista = [
                        [
                            'IdDevice' => '1005',
                            'IP' => '10.203.231.188',
                            'Type' => 'bioface'
                        ],
                        [
                            'IdDevice' => '3021',
                            'IP' => '10.203.41.39',
                            'Type' => 'bw'
                        ]
                     ];

            $fingerprints = [
                                '',
                                '',
                                '',
                                'SmVTUzIxAAADJiQECAUHCc7QAAAbJ2kBAAAAg8sWpiYqAPIPtACEAAEpwABbAHsPRQBcJuQPrABhADsPUyaHANkPtQBbAGsp2ACeACQPJgCyJqIP3AC6AOsOaCa6AFEPuQAKADwr1QDQADINpADmJksPywD6APAP7iYXAbIPhQDhATYprwAzAS0PogA3JzYP8AA4AW4PWCZFATgPngCDAbYptPPL9rt64BOurcsEeX61e3aKnc2G5wMPeYaL/AU91ouP9+OT30UwGlYoiYGZ+xu9O1GIgTJxLI9k/g4pewvfeyPrgA8tNHIMHQbR9+eRAd1iF3cXFgevh/zeDwlufz+HfwFxpVsLsXri++77pic3BVeHkvmeg4BdJAEvBUuHbIpxpVqDQigAIO4BAtscWgYAlRCidPwoAbcScYBVBHDD5AgAnxRpwaFsByaBFWd+DgB+Hn7jasFkef0Nxc8lUcBsZsBpEcXXNaCQwJDAZP+yBwOePAA7RwUAdUF3tgYAt0QDOP0QA5hbgMTC/4k6wmZMCACxYQD/9MFBMAAPc6CHwqzDwOfBwXvAdMHTAQlcnX5qxJN+BXRmPgAPlp5wfATBxqT+clbAchLFsZhSomrBe8DBB8HC5AwAuZ4J/DvC/mr+/1MKAN1lIv17Nv4QALGiqKLB5sNmwnTBGMQWr4ZzasPAw8MHxP3nemRsFgDga6TBvcfEcm9raU4UAja3qYd3wcMEo2FZDAC7vRr9OWTB5sP+/cYKACW+M+RHwFoKAGoFU8LYhWgMAKzIlpB45f+MDQCxypXDZOfBwcT9w8DXAN3srMLEwcjEVn7C53oJAMHMMDpkfyoBtdJJi3G9xA4mutIwNYuQswYD8tIwWMEJACbUKGJTwh8BFdd0wcLnwISGxMTBB8DC58HBwcH+wgXA/eXDwwsAud/4ZMLngsQIAF3piWrDewsAY+lGWYH/xjkAFfG3wcIFwcPnw8LAwsLDAMNhosHB/2rEZswAyNg2d8P+kwbVhSsSwY0DEK826MAANmY4OsIdEdZLpx5EwMFfw8IOm3tWw05SQgALhgEDJgpFUgA=',
                                '',
                                '',
                                'SlNTUzIxAAADEBQECAUHCc7QAAAbEWkBAAAAgj0VfhA6AA4OkgCHAI0eeQBJAIkOeABXEKUPfwBfANMPbRBzAH0PrwC4AJ4flQCCAJEPjACJEG4PIQCaACkPchCdAA8PjQBmAI4fXQCsAG8PCAC7ECYPgwDHAEkPVhDTAAAPpAA8ADIfdwAfAT4PfgA1ETIPXABKAQUPpBBKAUgOwYREgrHpgIJpB0p5AHwuZuz/KgtvGP4XHp7ImkKJ4WrT7kFjXA+y+0MRLPc5FZt+PgKCh+NjhW+if7fv2aO4hzGHfIO+/UIBPGNZYr8CB4/rnxafwRGmfG+MSpK+dFTjtvf7p4MDXoEkH2L7re8DBxr3mJXCe7uPGRcSD7ibOeYAIC8BxPMa3AgAjxkT/4T9khcBfxoXwMAF//4XAXgkE1MqxgDKLCX9DwBZKcP+w9EpRGXADgCZNgruZP7/Q8DABQMDY0aJwQUAT4eAwHQEAMBYJFjAAIFNDf3//wcAklh5af/CFAAYYyjC/9D/Ny7///8FVsMcAYFjGlY2oMELEGtug8J+g8YAcWMN/ggAanW/c5IXARV96UY1zgBjcwj//sA2wIcDA1WKccEVACNQ5/1QPf4wVP/BBUcJEGycgIjBwacTAz6f6UD+/yqEwFFEAgAsn2nAywB3sBHA/f8+UwXAwxoBWattdHmlAwPBuyLABADMeSlfCAELweJMQYX8/S5Fwf/B/v/IAILTlsTCxMKAmf8NEH7Ij8PCxbxkwkwNAIfLHi8E/kVmEQBZzfokOjH8R1kLAFHUXgXDZ9L+lg8AWdQ4/SA7PCkKAGvxuMfH0MLAhBkAAj3M/tL9wDcj//w6/sPvwf7Awf5bzQBj6FeQgggAcjwi/igmCQCl/DAFQMPT/QsAa/0n6iP95sAHEGUALew0BgBiDFfFaQbVZA0tVf4aEAsRFsIx7zck/f3A/wX+wu7BwMD/wQXVdiAqLxgQlFjMQYPCncTEoMDBwASMFABHX6f8M8H2/vrr/f/+//7/Ov397VNCAAtDAcUACFVTAA==',
                                '',
                                '',
                                ''];*/


            if (!$userById) {

                $inyectarEmpleado = $this->inyectarEmpleado($lista, $fingerprints, $id, $name, $estado);

                if (count($inyectarEmpleado) == 0 ) {
                    /*INICIO crear empleado de biometrico*/
                    $user = UserBiometric::create([
                        'IdUser' => $id,
                        'IdentificationNumber' => request('IdentificationNumber'),
                        'Name' => $name,
                        'Birthday' => request('Birthday'),
                        'IdDepartment' => request('IdDepartment'),
                        'Active' => $estado,
                        'Privilege' => 0,
                        'HourSalary' => 00.00,
                        'Password' => 'HolaMundo',
                        'PreferredIdLanguage' => 0,
                        'ProximityCard' => '',
                        'CreatedBy' => $userController->idOfUserCurrent(),
                        'CreatedDatetime' => $date,
                        'ModifiedBy' => 0,
                        'ModifiedDatetime' => $date,
                        'IdProfile' => null,
                        'DevPassword' => '',
                        'UseShift' => 1,
                        'TemplateCode' => 0
                    ]);

                    $user->IdUser = $id;
                    /*FIN crear usuario de biometrico*/

                    if ($user) {
                        /*INICIO asignar dispositivo al empleado localmente*/
                        $tamaño = count($lista);
                        for ($i=0; $i < $tamaño; $i++) { 
                            $IdDevice = $lista[$i]['IdDevice'];
                            $existe = Device_User::where([
                                                        ['IdUser', '=', $id],
                                                        ['IdDevice', '=', $IdDevice]
                                                     ])->first();
                            if (!$existe) {
                               $Device_User = new Device_User();
                               $Device_User->IdUser = $id;
                               $Device_User->IdDevice = $IdDevice;
                               $Device_User->save();
                            }else{
                                array_push($errors, $i.' de los '.$tamaño.' dispositivos no existen.');
                            }
                        }
                        /*FIN asignar dispositivo al empleado localmente*/

                        /*INICIO asignar horario/os al empleado*/
                        $dateCurrent = Carbon::now();
                        //Suma 1 año a la fecha actual
                        $endDate = $dateCurrent->addYears(1);
                        $horario = new UserShift();
                        $horario->IdUser = $id;
                        $horario->ShiftId = request('ShiftId');
                        $horario->BeginDate = $date;
                        $horario->EndDate = $endDate;
                        $horario->save();
                        /*FIN asignar horario/os al empleado*/

                        if ($horario) {
                            return response()->json(['respuesta'=> 'Usuario creado con éxito.', 'user' => $user, 'errors' => $errors],201);
                        } else
                            return response()->json(['respuesta'=> 'Error inesperado función registerUserBiometric, no se registro el horario', 'errors' => $errors],422);
                    }else
                        return response()->json(['respuesta'=> 'Error inesperado función registerUserBiometric, no se registro el empleado y su horario.', 'errors' => $errors],422);
                } else{
                    $errors = [ 'No se creo el empleado, su horario y dispositivos asignado localmente. Para la correcta funcionalidad por favor verifique que el o los dispositivos seleccionados estan encendidos, en red u otro problema, si no es así descarte los dispositivos con fallos.' ];
                    return response()->json(['respuesta' => $inyectarEmpleado, 'errors' => $errors], 422);
                }
                   
            } else
                return response()->json(['respuesta'=> 'El id de empleado ya existe.', 'errors' => $errors],422);
               
        } catch (Exception $e) {
            Log::error('Error create_employed: '.$e);
            return response()->json(['respuesta'=> 'Fatal error, en crear nuevo empleado.', 'errors' => $e],422);
        }
    }

    /**
     * Funcion inyectarEmpleado inserta directamente un empleado al dispositivo o dispositivos
     * a los que fue asignado, si fue correcto todo retorna 0 errores de lo contrario 
     * lista los errores encontrados con un breve descripción del posible error.
     *
     * @param  array  listaDispositivos
     * @param  array  listHuellas
     * @param  int  id
     * @param  string  nombre
     * @param  int  estado
     * @return array  errors 
     */
    public function inyectarEmpleado($listaDispositivos, $listHuellas, $id, $nombre, $estado)
    {
        $errors = [];
        $cmd = new BioTrackCmdController();
        /*INICIO asignar dispositivo/os al usuario*/
        if (count($listaDispositivos) > 1) {
            $data = $this->data($id, $nombre, $listHuellas, $estado);
            for ($i=0; $i < count($listaDispositivos); $i++) { 
                /*
                inject users to biometric Detail in BioTrackCmdController
                $listaDispositivos[$i]['Type']
                */
                if ($this->hayHuellas($listHuellas)) {
                    $IP = $listaDispositivos[$i]['IP'];
                    $type = $listaDispositivos[$i]['Type'] /*'bioface'*/;
                    $inyeccion = $cmd->inject_user_to_device($type, $IP, $data);

                    if ($inyeccion) {
                        $errors = [];
                    }else
                         array_push($errors, 'Dispositivo con IP: '.$IP.' no se encuentra, usuario no asignado a este dispositivo.');
                }else{
                    return $errors = [ 'No se pueden asignar varios dispositivos sin las huellas del empleado.' ];
                }    
            }

            return $errors;
        }else{
            /*
            inject users to biometric Detail in BioTrackCmdController
            $listaDispositivos[0]['Type']
            */
            $IP = $listaDispositivos[0]['IP'];
            $type = $listaDispositivos[0]['Type'];
            if ($this->hayHuellas($listHuellas)) {
                $data = $this->data($id, $nombre, $listHuellas, $estado);
                $inyeccion = $cmd->inject_user_to_device($type, $IP, $data);
                if ($inyeccion) {
                    return $errors = [];
                }else
                    return $errors = [ 'Dispositivo con IP: '.$IP.' no se encuentra, usuario no asignado a este dispositivo.' ];
            }else{
                $inyeccion = $cmd->add_user($type, $IP, $id, $nombre);
                if ($inyeccion) {
                    return $errors = [];
                }else
                    return $errors = [ 'Dispositivo con IP: '.$IP.' no se encuentra, usuario no asignado a este dispositivo.' ];
            }
        }
        /*FIN asignar dispositivo/os al usuario*/
    }



    /**
     * Funcion hayHuellas verifica si se estan recibiendo por lo menos 1 huella
     * del empleado.
     *
     * @param  array  listHuellas
     * @return boolean  true  (si hay por lo menos 1 huella.) 
     */
    public function hayHuellas($listHuellas)
    {
        if ($listHuellas[0] == '' &&
            $listHuellas[1] == '' &&
            $listHuellas[2] == '' &&
            $listHuellas[3] == '' &&
            $listHuellas[4] == '' &&
            $listHuellas[5] == '' &&
            $listHuellas[6] == '' &&
            $listHuellas[7] == '' &&
            $listHuellas[8] == '' &&
            $listHuellas[9] == '' ) {
            return false;
        }else
            return true;
    }    

    /**
     * Funcion register crea un nuevo usuario al sistema
     * se busca el rol a asignar y finalmente crea su
     * credencial de acceso (Token).
     *
     * @param  string  name
     * @param  string  last_name
     * @param  string  no_identidad
     * @param  string  email
     * @param  string  password
     * @param  int  telefono
     * @param  string  genero
     * @param  int  rol
     * @return json  credencial
     */
    public function register(Request $request)
    {
        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'name' => ['required', 'string', 'max:25'],
            'last_name' => ['required', 'string', 'max:25'],
            'no_identidad' => ['required', 'string', 'max:15'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users,email'],
            'password' => ['required', 'string', 'min:6', 'confirmed'],
            'telefono' => ['required', 'int'],
            'genero' => ['required', 'string', 'max:1'],
            'rol' => ['required', 'int']
        ]);

        try {
            $user = new User();
            $user->name = request('name');
            $user->last_name = request('last_name');
            $user->no_identidad = request('no_identidad');
            $user->email = request('email');
            $user->password = bcrypt(request('password'));
            $user->activo = 1;
            $user->telefono = request('telefono');
            $user->genero = request('genero');
            $user->save();

            $rol = Role::where('id', request('rol'))->first();

            $user->roles()->attach($rol);

            return $this->issueTokenRegister($request, 'password');
        } catch (Exception $e) {
            return response()->json(['fatalerror'=> 'Error inesperado register.'],422);
        }
    }

    public function data($id, $name, $fingerprint, $estado)
    {
        $data = [
            'userId' => $id,
            'userName' => $name,
            'userPassword' => '123456',
            'userPrivilege'=> 0,
            'userCardNumber'=> '',
            'userEnabled'=> $estado,
            'userFingerprints'=> [
                $fingerprint[0],
                $fingerprint[1],
                $fingerprint[2],
                $fingerprint[3],
                $fingerprint[4],
                $fingerprint[5],
                $fingerprint[6],
                $fingerprint[7],
                $fingerprint[8],
                $fingerprint[9]
            ],
            'userFace'=> ''
        ];

        return $data;
    }
}
