<?php

namespace App\Http\Controllers\Finca;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\System_Parameters;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Finca\UserController;

class System_ParametersController extends Controller
{
	/**
     * Funcion allsystemparameters lista todos los parametros del sistema
     * existentes.
     *
     * @return json  respuesta
     */
    public function allsystemparameters(){
    	$allsystemparameters = System_Parameters::orderBy('parametro', 'asc')->get();

    	if (count($allsystemparameters)>=1) {
    		return response()->json(['respuesta'=> $allsystemparameters],200);
    	} else
    		return response()->json(['message'=> 'No hay parametros registrados.'],422);
    }

    /**
     * Funcion registerSystemParameters crea un nuevo parametro
     * para al sistema.
     *
     * @param  string  parametro
     * @param  string  descripcion
     * @param  string  valor_parametro
     * @param  string  valores_permitidos
     * @param  string  valor_minimo
     * @param  string  valor_maximo
     * @param  int  activo
     * @param  string  visible
     * @param  int  CreatedBy
     * @param  int  ModifiedBy
     * @return json  respuesta
     */
    public function registerSystemParameters(Request $request){
        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'parametro' => ['required', 'string'],
            'descripcion' => ['required', 'string'],
            'valor_parametro' => ['required', 'string'],
            'valores_permitidos' => ['required', 'string'],
            'valor_minimo' => ['required', 'string'],
            'valor_maximo' => ['required', 'string'],
            'activo' => ['required', 'int'],
            'visible' => ['required', 'string']
        ]);

        $nombreSystemParameters = System_Parameters::select('parametro')->where('parametro', request('parametro'))->value('parametro');

        if ($nombreSystemParameters == request('parametro')) {
            return response()->json(['message'=> 'El nombre del parametro ya existe.'],422);
        }else{
        	$userController = new UserController();
            
            $registerSystemParameters = new System_Parameters();
            $registerSystemParameters->parametro = request('parametro');
            $registerSystemParameters->descripcion = request('descripcion');
            $registerSystemParameters->valor_parametro = request('valor_parametro');
            $registerSystemParameters->valores_permitidos = request('valores_permitidos');
            $registerSystemParameters->valor_minimo = request('valor_minimo');
            $registerSystemParameters->valor_maximo = request('valor_maximo');
            $registerSystemParameters->activo = request('activo'); 
            $registerSystemParameters->visible = request('visible');
            $registerSystemParameters->CreatedBy = $userController->idOfUserCurrent();
            $registerSystemParameters->ModifiedBy = 0;
            $registerSystemParameters->save();

            return response()->json(['message'=> 'Nuevo parametro creado con éxito.',
                                     'parametro' => $registerSystemParameters],201);
        }
    }

    /**
     * Funcion systemParametersById buscar el parametro del sistema
     * por medio de su id.
     *
     * @param  int  id
     * @return json  respuesta
     *
     */
    public function systemParametersById(Request $request){
        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'id' => 'required'
        ]);

        $id = request('id');
        $parametro = System_Parameters::find($id);
        if ($parametro) {
            return response()->json(['respuesta' =>$parametro],200);
        }else
            return response()->json(['respuesta' => 'Fallo al obtener la data del parametro.'],422);
    }

    /**
     * Funcion registerSystemParameters valida los datos y actualiza un parametro
     * del sistema.
     *
     * @param  int  id
     * @param  string  parametro  no requerido pero siempre se debe enviar
     * @param  string  descripcion
     * @param  string  valor_parametro
     * @param  string  valores_permitidos
     * @param  string  valor_minimo
     * @param  string  valor_maximo
     * @param  int  activo
     * @param  string  visible
     * @param  int  ModifiedBy
     * @return json  respuesta
     */
    public function updateSystemParameters(Request $request){
        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'id' => ['required', 'int'],
            'descripcion' => ['required', 'string'],
            'valor_parametro' => ['required', 'string'],
            'valores_permitidos' => ['required', 'string'],
            'valor_minimo' => ['required', 'string'],
            'valor_maximo' => ['required', 'string'],
            'activo' => ['required', 'int'],
            'visible' => ['required', 'string']
        ]);

        $id = request('id');
        $parametro = request('parametro');
        $descripcion = request('descripcion');
        $valor_parametro = request('valor_parametro');
        $valores_permitidos = request('valores_permitidos');
        $valor_minimo = request('valor_minimo');
        $valor_maximo = request('valor_maximo');
        $activo = request('activo');
        $visible = request('visible');
        
        if ($parametro) {
            $existe = System_Parameters::select('parametro')->where('parametro', $parametro)->value('parametro');
            if ($existe == request('parametro')) {
                return response()->json(['message'=> 'El nombre del parametro ya existe.'],422);
            }else{
                $response =$this->insertSystem_Parameter($id, $parametro, $descripcion, $valor_parametro, $valores_permitidos,
                                           $valor_minimo, $valor_maximo, $activo, $visible);

                if ($response) {
                    return response()->json(['message' => 'Parametro editado con éxito.'],201);
                }else
                    return response()->json(['message' => 'Fallo al editar el parametro.'],422);
            }
        }else{
            $parametro = System_Parameters::select('parametro')->where('id', $id)->value('parametro');
            $response =$this->insertSystem_Parameter($id, $parametro, $descripcion, $valor_parametro, $valores_permitidos,
                                           $valor_minimo, $valor_maximo, $activo, $visible);

                if ($response) {
                    return response()->json(['message' => 'Parametro editado con éxito.'],201);
                }else
                    return response()->json(['message' => 'Fallo al editar el parametro.'],422);
        }
    }

    /**
     * Funcion insertSystem_Parameter realiza la actualización de parametro
     * del sistema.
     *
     * @param  int  id
     * @param  string  parametro  no requerido pero siempre se debe enviar
     * @param  string  descripcion
     * @param  string  valor_parametro
     * @param  string  valores_permitidos
     * @param  string  valor_minimo
     * @param  string  valor_maximo
     * @param  int  activo
     * @param  string  visible
     * @param  int  ModifiedBy
     * @return boolean  true
     */
    public function insertSystem_Parameter($id, $parametro, $descripcion, $valor_parametro, $valores_permitidos,
                                           $valor_minimo, $valor_maximo, $activo, $visible){
        $userController = new UserController();
        $updateSystemParameters = System_Parameters::find($id);
        $updateSystemParameters->parametro = $parametro;
        $updateSystemParameters->descripcion = $descripcion;
        $updateSystemParameters->valor_parametro = $valor_parametro;
        $updateSystemParameters->valores_permitidos = $valores_permitidos;
        $updateSystemParameters->valor_minimo = $valor_minimo;
        $updateSystemParameters->valor_maximo = $valor_maximo;
        $updateSystemParameters->activo = $activo;
        $updateSystemParameters->visible = $visible;
        $updateSystemParameters->ModifiedBy = $userController->idOfUserCurrent();
        $response = $updateSystemParameters->save();

        if ($response) {
            return true;
        }else
            return false;
    }




    public function hola(Request $request)
    {
        $this->validate($request, [
            'IdUser' => 'required',
        ]);

        return response()->json(['respuesta'=> request('IdUser')],200);
    }
}
