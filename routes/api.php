<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
//INICIO ROUTES BIOTRACKCMD
//SOLO SON DE PRUEBA
Route::get('get_serial','Finca\BioTrackCmdController@get_serial');//
Route::get('get_firmware_version','Finca\BioTrackCmdController@get_firmware_version');//
Route::get('get_fingerprint_version','Finca\BioTrackCmdController@get_fingerprint_version');//
Route::get('get_device_info','Finca\BioTrackCmdController@get_device_info');//
Route::get('get_user','Finca\BioTrackCmdController@get_user');//
Route::get('get_users','Finca\BioTrackCmdController@get_users');//
Route::get('get_user_data','Finca\BioTrackCmdController@get_user_data');//
Route::get('delete_user','Finca\BioTrackCmdController@delete_user');//
Route::get('delete_user_password','Finca\BioTrackCmdController@delete_user_password');////PRUEBA
Route::get('delete_user_fingerprints','Finca\BioTrackCmdController@delete_user_fingerprints');//NO 
Route::get('delete_user_face','Finca\BioTrackCmdController@delete_user_face');//PRUEBA
Route::get('delete_all_users','Finca\BioTrackCmdController@delete_all_users');//NI LO INTENTO
Route::get('enable_user','Finca\BioTrackCmdController@enable_user');//
Route::get('disable_user','Finca\BioTrackCmdController@disable_user');//
Route::get('add_user','Finca\BioTrackCmdController@add_user2');//
Route::get('update_user_name','Finca\BioTrackCmdController@update_user_name');//
Route::get('update_user_password','Finca\BioTrackCmdController@update_user_password');//
Route::get('update_user_fingerprint','Finca\BioTrackCmdController@update_user_fingerprint');//
Route::get('update_user_face','Finca\BioTrackCmdController@update_user_face');//
Route::get('update_user_data','Finca\BioTrackCmdController@update_user_data');//
Route::get('sync_clock','Finca\BioTrackCmdController@sync_clock');//
Route::get('get_log','Finca\BioTrackCmdController@get_log');//

Route::get('depurarUser','Finca\Device_UserController@depurarUser');
Route::get('depUserDB','Finca\Device_UserController@depUserDB');
//FIN ROUTES BIOTRACKCMD
//SOLO SON DE PRUEBA
Route::get('calculo','Finca\ReportController@calculoMarcadoAdelantado');
Route::get('updateTDis','Finca\UserController@updateTDispositivos');

//INICIO ROUTES CATALOGPRODUCTS
Route::post('getProducts', 'CatalogProducts\CatalogProductsController@getProducts');// ODOO
Route::post('getBOM', 'CatalogProducts\CatalogProductsController@getBOM');// ODOO
Route::post('getPhases', 'CatalogProducts\CatalogProductsController@getPhases');// ODOO
//FIN ROUTES CATALOGPRODUCTS


//INICIO TRAER DATA ODOO
//Route::get('departamentosOdoo','CatalogProducts\OdooController@getDepartments');//
Route::get('departamentosOdooToSQL','CatalogProducts\OdooController@getDepartmentsInsert');//
Route::get('horariosOdoo','CatalogProducts\OdooController@getShifts');//
Route::get('detalleHorariosOdoo','CatalogProducts\OdooController@getShiftDetail');//
Route::get('empleadosOdoo','CatalogProducts\OdooController@getEmployees');//
Route::get('empleadosOdooToSQL','CatalogProducts\OdooController@getEmployeesInsert');//
Route::get('usuariosget','Finca\UserController@allusrs');

Route::get('usuariosplataformaPrueba','Finca\UserController@allUsersOfPlataform');
Route::post('reportesOdoo','Finca\ReportController@reports');

//INICIO ROUTES FINCABIOMETRIC
Route::post('login','Finca\LoginController@login');//
Route::middleware('auth:api')->group(function () {
    Route::post('reportes','Finca\ReportController@reports');//
    Route::post('reporteporusuario','Finca\ReportController@reportByUser');//
	
	Route::get('usuarios','Finca\UserController@allusers');//
	//Route::get('usuarios','CatalogProducts\OdooController@getEmployees');//
	Route::post('usuario','Finca\UserController@userById');//
	Route::post('editarusuario','Finca\UserController@editUser');//
	Route::post('crearusuario','Finca\RegisterController@registerUserBiometric');//
	Route::post('guardarpermisos','UsersPermissionsController@save');
	Route::post('verpermisos','UsersPermissionsController@showPermissions');
	Route::post('guardarpermisosdoor','DoorPermissionsController@save');
	Route::post('verpermisosdoor','DoorPermissionsController@showPermissions');
	Route::post('borrarpermisosdoor','DoorPermissionsController@deletePermissions');
	Route::post('guardardepartments','UsersDepartmentsController@save');
	Route::post('verdepartments','UsersDepartmentsController@showDepartments');
	Route::post('deletedepartments','UsersDepartmentsController@deleteDeparments');

	

	Route::get('departamentos','Finca\DepartmentController@department');//
	
	Route::post('departamento', 'Finca\DepartmentController@departmentById');//
	Route::post('creardepartamento','Finca\DepartmentController@registerDepartment');//
	Route::post('editardepartamento', 'Finca\DepartmentController@editDepartment');//
	Route::post('usuariospordepartamento','Finca\UserController@userByDepartment');//

	Route::get('horarios','Finca\ShiftController@shift');//	
	Route::post('crearhorario','Finca\ShiftController@registerShift');//
	Route::post('editarhorario','Finca\ShiftController@editShift');//
	Route::post('editarhorariodetalle','Finca\ShiftDetailController@editShiftDetail');//
	Route::post('horariodetalles','Finca\ShiftDetailController@detailShiftById');//
	Route::post('horariodetalledias','Finca\ShiftDetailController@shiftDetailByShiftId');//

	Route::get('dispositivos','Finca\DeviceController@device');//
	Route::post('dispositivo','Finca\DeviceController@deviceById');//
	Route::post('creardispositivo','Finca\DeviceController@registerDevice');//
	Route::post('editardispositivo','Finca\DeviceController@editDevice');//
	Route::post('usuariospordispositivo','Finca\BioTrackCmdController@userByDevice');//
	Route::post('dispositivosporusuario','Finca\Device_UserController@getDeviceUser');//
	Route::post('borrarusuariodeldispositivo','Finca\BioTrackCmdController@delete_user_to_device');//
	Route::post('actualizarhuella','Finca\BioTrackCmdController@actualizarHuella');//
	Route::post('abrirpuerta','Finca\BioTrackCmdController@open_door');//	
	
	Route::get('perfil','Finca\ProfileController@profile');//
	Route::post('register','Finca\RegisterController@register');//
	Route::post('actplatformuser','Finca\UserController@actplatformuser');//
	Route::post('platformuserData','Finca\UserController@platformuserData');//
	Route::post('refreshtoken','Finca\LoginController@refresh');//
	Route::post('logout','Finca\LoginController@logout');//
	Route::get('infouser', 'Finca\UserController@infoUserCurrent');//
	Route::get('usuariosplataforma','Finca\UserController@allUsersOfPlataform');//

	Route::get('parametros','Finca\System_ParametersController@allsystemparameters');//
	Route::post('parametro','Finca\System_ParametersController@systemParametersById');//
	Route::post('crearparametro','Finca\System_ParametersController@registerSystemParameters');//
	Route::post('editarparametro','Finca\System_ParametersController@updateSystemParameters');//
});
//FIN ROUTES FINCABIOMETRIC


/*
	EXCEL
	https://plnkr.co/edit/Hc4nq1EQMNEbJJHb6MbU?p=preview


	SERVER FINCA
	Credencilaes SQL SERVER
	usuario:	sa
	contraseña: .2019ICT

	Credenciales Equipo
	contraseña: .2019ICT

*/
