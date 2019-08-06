<?php

namespace App\Http\Controllers\Finca;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Department;

class DepartmentController extends Controller
{
	/**
     * Función department lista todos los departamentos existentes
     * omitiendo el IdDepartment = 1 con Description = Diadema Zona Franca Honduras.
     *
     * @return json  respuesta
     */
    public function department(){
    	$department = Department::select('IdDepartment', 'Description')
                                    ->where('IdDepartment','NOT LIKE',1)->orderBy('Description', 'asc')->get();
    	
    	return response()->json(['respuesta'=> $department],200, [], JSON_NUMERIC_CHECK);
    }

    /**
     * Funcion registerDepartment crea un nuevo departamento al sistema.
     *
     * @param  int  IdParent
     * @param  string  Description
     * @param  string  SupervisorName
     * @return json  respuesta
     */
    public function registerDepartment(Request $request){
        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'IdParent' => ['required', 'int'],
            'Description' => ['required', 'string'],
            'SupervisorName' => ['required', 'string']
        ]);

        $department = new Department();
        $department->IdParent = request('IdParent');
        $department->Description = request('Description');
        $department->SupervisorName = request('SupervisorName');
        $department->save();

        return response()->json(['message'=> 'Departmento creado con éxito.',
                                 'departamento' => $department],201);

    }

    /**
     * Función departmentById obtiene el departamento existente
     * por medio de su IdDepartment.
     *
     * @param  int  IdDepartment
     * @return json  respuesta
     */
    public function departmentById(Request $request){
        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'IdDepartment' => ['required', 'int']
        ]);

        $padres = Department::select('IdDepartment', 'Description')
                                    ->where('IdDepartment','NOT LIKE',request('IdDepartment'))->orderBy('Description', 'asc')->get();

        $departmentById = Department::find(request('IdDepartment'));
        
        return response()->json(['respuesta' => $departmentById,
                                 'padres' => $padres],200);
    }

    /**
     * Funcion editDepartment edita la informacion de un departamento.
     *
     * @param  int  IdDepartment
     * @param  int  IdParent
     * @param  string  Description
     * @param  string  SupervisorName
     * @return json  respuesta
     */
    public function editDepartment(Request $request){
        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'IdDepartment' => ['required', 'int'],
            'IdParent' => ['required', 'int'],
            'Description' => ['required', 'string'],
            'SupervisorName' => ['required', 'string']
        ]);

        $nombreDepartamento = Department::select('Description')->where('Description', request('Description'))->value('Description');

        if ($nombreDepartamento == request('Description')) {
            return response()->json(['message'=> 'El nombre de departmento ya existe.'],422);
        }else{
            $department = Department::find(request('IdDepartment'));
            $department->IdParent = request('IdParent');
            $department->Description = request('Description');
            $department->SupervisorName = request('SupervisorName');
            $department->save();

            return response()->json(['message'=> 'Departmento actualizado con éxito.',
                                     'departamento' => $department],200);
        }
    }
}
