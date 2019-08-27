<?php

namespace App\Http\Controllers\Finca;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\User;
use App\RoleUser;
use App\UserBiometric;
use Illuminate\Support\Facades\Log;
use Auth;
use Illuminate\Support\Facades\DB;
use App\UserShift;
use Carbon\Carbon;
use App\Http\Controllers\Finca\BioTrackCmdController;
use App\Http\Controllers\Finca\RegisterController;
use App\Device_User;
use App\Http\Controllers\UsersPermissionsController;
use App\Http\Controllers\DoorPermissionsController;
use App\Http\Controllers\UsersDepartmentsController;

class UserController extends Controller
{
    /**
     * Funcion allusers busca y lista todos los usuarios
     * con estado activo en el sistema biometrico con su departamento
     * ordenados de forma ascendente por medio de su nombre.
     *
     * @return json  respuesta
     */
    public function allusrs(){
        $allusers = DB::table('User')
        ->join('Department', 'User.IdDepartment', '=', 'Department.IdDepartment')
        ->where('User.IdDepartment','NOT LIKE',1)
        ->orderBy('User.Name', 'asc')
        ->get();
        return response()->json($allusers, 200);
    }
    public function allusers()
    {
        if (Auth::user()->id == 1) {
            $allusers = DB::table('User')
                ->join('Department', 'User.IdDepartment', '=', 'Department.IdDepartment')
                ->where('User.IdDepartment','NOT LIKE',1)
                ->orderBy('User.Name', 'asc')
                ->get();

            /*
        por motivos de depurar la base de datos quitamos el filtro
        ->where('User.IdDepartment','NOT LIKE',1)
    */

            return response()->json(['respuesta' => $allusers], 200);
        }else{
            $depts=DB::table('users_departments')
            ->where('Id_user',Auth::user()->id)
            ->get();
            $final=[];

            foreach($depts as $dept){
                $allusers = DB::table('User')
                ->join('Department', 'User.IdDepartment', '=', 'Department.IdDepartment')
                ->where('User.IdDepartment','NOT LIKE',1)
                ->where('User.IdDepartment',$dept->Id_department)
                ->orderBy('User.Name', 'asc')
                ->get();

                foreach($allusers as $singleuser){
                    array_push($final,$singleuser);
                }

            }
            
           

            /*
        por motivos de depurar la base de datos quitamos el filtro
        ->where('User.IdDepartment','NOT LIKE',1)
    */

            return response()->json(['respuesta' => $final], 200);
        }
    }

    /**
     * Funcion allUsersOfPlataform busca y lista todos los usuarios
     * con estado activo de la plataforma con su departamento
     * ordenados de forma ascendente por medio de su nombre.
     *
     * @return json  respuesta
     */
    public function allUsersOfPlataform(Request $request)
    {

        try {
            $allusers = DB::table('users')
                ->join('role_user', 'users.id', '=', 'role_user.user_id')
                ->join('roles', 'role_user.role_id', '=', 'roles.id')
                ->select(
                    'users.id',
                    DB::raw("CONCAT(users.name, ' ', users.last_name) as fullname"),
                    'users.email',
                    'users.no_identidad',
                    'users.activo',
                    'role_user.role_id',
                    'users.telefono',
                    'users.genero',
                    'roles.name as nombre_rol'
                )
                ->orderBy('fullname', 'asc')
                ->get();

            /*$user=User::find();
            $rol= RoleUser::where('user_id', Auth::user()->id)->value('role_id'); 
            $user->rol = $rol;
            return response()->json($user,200);*/
            if ($allusers) {
                return response()->json(['respuesta' => $allusers], 200);
            } else
                return response()->json(['respuesta' => 'No hay usuarios existentes en la plataforma.'], 422);
        } catch (Exception $e) {
            return response()->json(['respuesta' => 'Error inesperado allUsersOfPlataform.'], 422);
        }
    }


    /**
     * Funcion userByDepartment busca y lista todos los usuarios
     * por departamento y que su estado sea activo en el sistema.
     *
     * @param  number  IdDepartment
     * @return json  respuesta
     */
    public function userByDepartment(Request $request)
    {
        $this->validate($request, [
            'IdDepartment' => 'required',
        ]);

        $userByDepartment = UserBiometric::where([
            ['IdDepartment', '=', request('IdDepartment')],
            ['Active', '=', 1]
        ])
            ->get();

        return response()->json(['respuesta' => $userByDepartment], 200);
    }

    /**
     * Funcion userByDevice busca y lista todos los usuarios
     * por dispositivo.
     *
     * @param  number  IdDevice
     * @return json  respuesta
    
    public function userByDevice(Request $request){
        $this->validate($request, [
            'IdDevice' => 'required',
        ]);

        $userByDevice = DB::table('User')
                ->join('Device_User', 'User.IdUser', '=', 'Device_User.IdUser')
                ->join('Department', 'User.IdDepartment', '=', 'Department.IdDepartment')
                ->where('Device_User.IdDevice','=',request('IdDevice'))
                ->orderBy('User.Name', 'asc')
                ->get();

        return response()->json(['respuesta'=> $userByDevice],200);
    }*/

    /**
     * Funcion userById buscar un usuario
     * por medio de su id.
     *
     * @param  number  IdUser
     * @return json  user
     */
    public function userById(Request $request)
    {
        $this->validate($request, [
            'IdUser' => 'required',
        ]);

        $UserShift = UserShift::where('IdUser', request('IdUser'))->value('UserShiftId');

        $userById;
        if ($UserShift) {
            $userById = DB::table('User')
                ->join('UserShift', 'User.IdUser', '=', 'UserShift.IdUser')
                ->where('User.IdUser', request('IdUser'))
                ->first();

            if ($userById) {
                return response()->json(['respuesta' => $userById], 200);
            } else {
                return response()->json(['respuesta' => 'El usuario no existe.'], 422);
            }
        } else {
            $userById = UserBiometric::find(request('IdUser'));

            if ($userById) {
                return response()->json(['respuesta' => $userById], 200);
            } else {
                return response()->json(['respuesta' => 'El usuario no existe 2.'], 422);
            }
        }
    }

    /**
     * Funcion editUser actualiza la informacion del usuario
     * por medio de su id.
     *
     * @param  number  IdUser
     * @param  string  Name
     * @param  string  IdentificationNumber
     * @param  datetime  Birthday
     * @param  number  IdDepartment
     * @param  number  Active
     * @param  number  UseShift
     * @param  array  listDispositivos
     * @param  array  fingerprints
     * @return json  mensaje
     */
    public function editUser(Request $request)
    {
        try {
            date_default_timezone_set('America/Tegucigalpa');
            $this->validate($request, [
                'IdUser' => 'required',
                'Name' => 'required',
                'IdentificationNumber' => 'required',
                'Birthday' => 'required',
                'IdDepartment' => 'required',
                'Active' => 'required',
                'ShiftId' => 'required'
            ]);

            //declaracion de variables
            $errors = [];
            $id = request('IdUser');
            $name = request('Name');
            $estado = request('Active');

            $fingerprints = request('fingerprints');
            if(isset($request->listaDispositivos)){
                $lista = request('listaDispositivos');
                /*no obligatorio pero recibira lista de dispositivos
              si esta vacia la lista no hace nada solo actualiza la data del empleado
              de lo contrario procedemos a inyectar los nuevos dispositivos


              crear instancia de biometrico por ip y usar la funcion update_user_data

              modificacion futura al tener el escaner dactilar es actualizar una huella en
              especifico usar update_user_fingerprint ($user_id, $index, $data) solo si envian nuevas
              huellas por medio de cada disp.*/

                /*INICIO inyectar usuario a sus nuevos dispositivos*/
                $registerController = new RegisterController();
                $inyectarEmpleado = $registerController->inyectarEmpleado($lista, $fingerprints, $id, $name, $estado);
                if (count($inyectarEmpleado) == 0) {

                    /*INICIO actualizar usuario*/
                    $user = UserBiometric::find($id);
                    $user->Name = $name;
                    $user->IdentificationNumber = request('IdentificationNumber');
                    $user->Birthday = request('Birthday');
                    $user->IdDepartment = request('IdDepartment');
                    $user->Active = $estado;
                    $user->ModifiedBy = $this->idOfUserCurrent();
                    $user->ModifiedDatetime = date('Y-m-d H:i:s');
                    $response = $user->save();
                    /*FIN actualizar usuario*/

                    /*INICIO actualizar horario asignado si no tiene se le crea*/
                    $UserShiftId = UserShift::where('IdUser', '=', $id)->value('UserShiftId');
                    if (!$UserShiftId) {
                        /*INICIO asignar dispositivo/os al usuario*/
                        $errors = array_push($errors, $this->asignarDispositivos($lista, $id));
                        /*FIN asignar dispositivo/os al usuario*/

                        /*INICIO asignar horario/os al usuario*/
                        $dateCurrent = Carbon::now();
                        //Suma 1 año a la fecha actual
                        $endDate = $dateCurrent->addYears(1);

                        $horario = new UserShift();
                        $horario->IdUser = $user->IdUser;
                        $horario->ShiftId = request('ShiftId');
                        $horario->BeginDate = $dateCurrent;
                        $horario->EndDate = $endDate;
                        $horario->save();
                        /*FIN asignar horario/os al usuario*/
                    } else {
                        /*INICIO asignar dispositivo/os al usuario*/
                        $errors = array_push($errors, $this->asignarDispositivos($lista, $id));
                        /*FIN asignar dispositivo/os al usuario*/

                        /*INICIO asignar horario/os al usuario*/
                        DB::table('UserShift')->where([
                            ['IdUser', '=', $id],
                            ['UserShiftId', '=', $UserShiftId]
                        ])
                            ->update(['ShiftId' => request('ShiftId')]);
                        /*FIN asignar horario/os al usuario*/
                    }
                    /*FIN actualizar horario asignado*/

                    return response()->json([
                        'respuesta' => 'Usuario actualizado con éxito.',
                        'user' => $user,
                        'errors' => $errors
                    ], 200);
                    /*FIN inyectar usuario a sus nuevos dispositivos*/
                } else {
                    $errors = ['No se creo el empleado, su horario y dispositivos asignado localmente. Para la correcta funcionalidad por favor verifique que el o los dispositivos seleccionados estan encendidos, en red u otro problema, si no es así descarte los dispositivos con fallos.'];
                    return response()->json(['respuesta' => $inyectarEmpleado, 'errors' => $errors], 422);
                }
            }

            /*INICIO actualizar usuario*/
            $user = UserBiometric::find($id);
            $user->Name = $name;
            $user->IdentificationNumber = request('IdentificationNumber');
            $user->Birthday = request('Birthday');
            $user->IdDepartment = request('IdDepartment');
            $user->Active = $estado;
            $user->ModifiedBy = $this->idOfUserCurrent();
            $user->ModifiedDatetime = date('Y-m-d H:i:s');
            $response = $user->save();
            /*FIN actualizar usuario*/
            return response()->json([
                'respuesta' => 'Usuario actualizado con éxito.',
                'user' => $user,
                'errors' => $errors
            ], 200);

        } catch (Exception $e) {
            Log::error('Error update_user: ' . $e);
            return response()->json(['respuesta' => 'Error al actualizar el usuario. ERRR: ' . $e->getMessage()], 422);
        }
    }

    public function asignarDispositivos($listaDispositivos, $id)
    {
        $errors = [];
        $tamaño = count($listaDispositivos);
        for ($i = 0; $i < $tamaño; $i++) {
            $IdDevice = $listaDispositivos[$i]['IdDevice'];
            $existe = Device_User::where([
                ['IdUser', '=', $id],
                ['IdDevice', '=', $IdDevice]
            ])->first();
            if (!$existe) {
                $Device_User = new Device_User();
                $Device_User->IdUser = $id;
                $Device_User->IdDevice = $IdDevice;
                $Device_User->save();
            } else {
                array_push($errors, $i . ' de los ' . $tamaño . ' dispositivos no existen.');
            }
        }
        return $errors;
    }

    /**
     * Funcion infoUserCurrent devuelve un json con toda la informacion
     * del usuario autenticado y se obtiene el rol de este por medio
     * de su id.
     *
     * @return json user
     */
    public function infoUserCurrent()
    {
        if (Auth::check()) {
            $user = Auth::user();
            $rol = RoleUser::where('user_id', Auth::user()->id)->value('role_id');
            $user->rol = $rol;
            return response(json_encode($user), 200);
        }
    }

    public function actplatformuser()
    {

        $u_id = request('id');
        $user = DB::table('users')->where('id', '=', $u_id);
        $user->update([
            'name' => request('name'),
            'last_name' => request('last_name'),
            'no_identidad' => request('no_identidad'),
            'email' => request('email'),
            'telefono' => request('telefono'),
            'genero' => request('genero')
        ]);

        if (!empty(request('dispositivos'))) {
            DoorPermissionsController::save(request('id'), request('dispositivos'));
        }

        if (!empty(request('departamentos'))) {
            UsersDepartmentsController::save(request('id'), request('departamentos'));
        }

        return response()->json('Usuario Actualizado con éxito.', 200);
    }

    public function platformuserData()
    {
        $u_id = request('id_user');
        $user = DB::table('users')->where('id', '=', $u_id)->get(['id', 'name', 'last_name', 'no_identidad', 'email', 'telefono', 'genero']);


        if ($user) {
            return response()->json($user->first(), 200);
        }
    }

    /**
     * Funcion idOfUserCurrent devuelve el id del usuario que este
     * autenticado.
     *
     * @return int id
     */
    public function idOfUserCurrent()
    {
        if (Auth::check()) {
            $user = Auth::user();
            return $user->id;
        } else {
            return 'Login please';
        }
    }


    public  function updateTDispositivos(Request $request)
    {
        $id = $request->id;

        $where=["DANIA BIBIAM TALAVERA SANDOVAL",
            "DANITZA ELIZABETH AGUILAR REYES",
            "DILCIA BRICELDA GUILLEN GONZALES",
            "DUNIA ISABEL ORDOÑEZ ORDOÑEZ",
            "EDA LILIA ALVARADO ESCALANTE",
            "EMERITA JAMILETH BUSTAMANTE ARDON",
            "ENA ROSARIO BRAN ALVARADO",
            "FANY YESSENIA FLORES ESPINAL",
            "GABRIELA ELIZABETH RODRIGUEZ",
            "GLORIA SUYAPA ANDRADE LAGOS",
            "GREICY NOHEMY HERRERA VELASQUEZ",
            "HILDA YOLIBETH MENDOZA ESPINAL",
            "JENY LIZETH VINDEL MORGA",
            "JESSICA CAROLINA DUARTE MONDRAGON",
            "KAREN PATRICIA BELIX ESCOBAR",
            "KARINA ARGENTINA CACERES ZAVALA",
            "KATY CECILIA BLANDON SOSA",
            "MARIA TERESA PONCE PONCE",
            "MARIELA YICEL CASTELLANOS GAITAN",
            "NELY ARGENTINA RODRIGUEZ RODRIGUEZ",
            "NOLVIA MARGARITA RAMOS ALVARADO",
            "SELENA MARICRUZ RODRIGUEZ",
            "STEPHANY SARAHI VALLE CARRANZA",
            "ALEX ARTURO CASTRO CRUZ",
            "FREDIS DAVID RODRIGUEZ VALDEZ",
            "RAMON ENRIQUE MURILLO SAUCEDA",
            "VICTOR NAUN CRUZ ARDON",
            "DAVID ALEXANDER DIAZ CORRALES"];
        $pila=[];
        foreach ($where as $nombre){
            $u=new UserBiometric();
            $user = $u->where('Name',$nombre);
            $agregear=$user->get(['IdUser']);
            array_push($pila,$agregear->first()["IdUser"]);
        }



            return response()->json($pila);

    }
}
