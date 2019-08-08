<?php

namespace App\Http\Controllers\Finca;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use App\UserBiometric;
use App\Rango_fechas;
use Carbon\Carbon;
use DateTime;
use App\System_Parameters;
use Illuminate\Support\Str;

class ReportController extends Controller
{
    /**
     * Funcion reports devuelve un json con los registros de marcadado de hora
     * de los usuarios en el biometrico segun la fecha, fecha por rangos y departamento,
     * si no se envia un valor de IdDepartment retorna todos los registros sin
     * aplicar el filtro por departamentos.
     *
     * @param  number  IdDepartment no esta validada pero es necesario siempre enviarla.
     * @param  date  fecha
     * @param  date  DayId
     * @return json respuesta
     */
    public function reports(Request $request)
    {

        $this->validate($request, [
            'fecha' => 'required',
            'DayId' => 'required'
        ]);

        $str_fecha = request('fecha');
        $between = preg_split("/\,/", $str_fecha);

        if (count($between) > 1) {
            if (request('IdDepartment')) {

                $reports = Rango_fechas::select(
                    'id',
                    'nombre',
                    'id_departamento',
                    'departamento',
                    'nombre_horario',
                    DB::raw('CONVERT(varchar, fecha, 103) fecha')
                )
                    ->where('id_departamento', request('IdDepartment'))
                    ->whereRaw("fecha >= ? AND fecha <= ?", array($between[0] . " 00:00:00", $between[1] . " 23:59:59"))
                    ->distinct()->orderBy('id', 'asc')
                    ->get();

                $tamaño = count($reports);
                $pila = [];
                for ($i = 0; $i < $tamaño; $i++) {

                    $id = $reports[$i]->id;
                    $id_departamento = $reports[$i]->id_departamento;
                    $fecha = $reports[$i]->fecha;
                    $dt = Carbon::createFromFormat('d/m/Y', $fecha);


                    $reportFor = Rango_fechas::select(
                        'nombre',
                        'departamento',
                        'nombre_horario',
                        'hora_entrada',
                        'minutos_entrada',
                        'hora_salida',
                        'minutos_salida',
                        DB::raw('MIN(CONVERT(varchar, fecha, 8)) as fecha_y_hora_marco_min'),
                        DB::raw('MAX(CONVERT(varchar, fecha, 8)) as fecha_y_hora_marco_max')
                    )
                        ->where([
                            ['id', '=', $id],
                            ['id_departamento', '=', $id_departamento],
                            ['IdDia', '=', $dt->dayOfWeek - 1],
                            [DB::raw('CONVERT(varchar, fecha, 103)'), '=', $fecha]
                        ])
                        ->groupBy(
                            'nombre',
                            'departamento',
                            'nombre_horario',
                            'hora_entrada',
                            'minutos_entrada',
                            'hora_salida',
                            'minutos_salida'
                        )
                        ->get();

                    $tamañoFinal = count($reportFor);
                    for ($y = 0; $y < $tamañoFinal; $y++) {
                        $numDia = $dt->dayOfWeek - 1;
                        $dia = $this->nombreDelDia($numDia);

                        $horastrabajadas = $this->horasTrabajadas($reportFor[$y]->fecha_y_hora_marco_min, $reportFor[$y]->fecha_y_hora_marco_max);

                        $horasrealestrabajadas = $this->horasTrabajadasMenosHorasdeComer($reportFor[$y]->fecha_y_hora_marco_min, $reportFor[$y]->fecha_y_hora_marco_max);

                        if($reportFor[$y]->fecha_y_hora_marco_min== $reportFor[$y]->fecha_y_hora_marco_max){
                            $reportFor[$y]->horasrealestrabajadas = "marcaje incorrecto";
                            $reportFor[$y]->horastrabajadas = "marcaje incorrecto";
                            $reportFor[$y]->salioantes="marcaje incorrecto";
                            $reports[$y]->extras="marcaje incorrecto";
                        }else{
                            $reportFor[$y]->horastrabajadas = $horastrabajadas->format('%h horas %i minutos');
                            $reportFor[$y]->horasrealestrabajadas = "{$horasrealestrabajadas->hour} horas {$horasrealestrabajadas->minute} minutos";
                            $hrms=intval( substr($reportFor[$y]->fecha_y_hora_marco_max,0,2));
                            $mms=intval(substr($reportFor[$y]->fecha_y_hora_marco_max,3,5));
                            $hos=$reportFor[$y]->hora_salida;
                            $mos=$reportFor[$y]->minutos_salida;
                            $reportFor[$y]->salioantes=$this->calculoMarcadoAdelantado($hrms,$mms,$hos,$mos);
                            $reports[$y]->extras=$this->calculoHorasExtras($hrms,$mms,$hos,$mos);

                        }
                        $hrme=intval(substr($reports[$y]->fecha_y_hora_marco_min,0,2));
                        $mme=intval(substr($reports[$y]->fecha_y_hora_marco_min,3,5));
                        $heo=$reports[$y]->hora_entrada;
                        $meo=$reports[$y]->minutos_entrada;
                        $reports[$y]->asis=$this->calculoMarcadoAtrasado($hrme,$mme,$heo,$meo);
                        $reportFor[$y]->dia = $dia;
                        $reportFor[$y]->fecha = $fecha;
                        array_push($pila, $reportFor[$y]);
                    }
                }

                $quantityEmployees = UserBiometric::where('IdDepartment', request('IdDepartment'))->count();

                return response()->json([
                    'respuesta' => $pila,
                    'cantidadempleadosdepto' => $quantityEmployees
                ], 200);
            }

            $reports = Rango_fechas::select(
                'id',
                'nombre',
                'id_departamento',
                'departamento',
                'nombre_horario',
                DB::raw('CONVERT(varchar, fecha, 103) fecha')
            )
                ->whereRaw("fecha >= ? AND fecha <= ?", array($between[0] . " 00:00:00", $between[1] . " 23:59:59"))
                ->distinct()->orderBy('id', 'asc')
                ->get();

            $tamaño = count($reports);
            $pila = [];
            for ($i = 0; $i < $tamaño; $i++) {

                $id = $reports[$i]->id;
                $id_departamento = $reports[$i]->id_departamento;
                $fecha = $reports[$i]->fecha;
                $dt = Carbon::createFromFormat('d/m/Y', $fecha);

                $reportFor = Rango_fechas::select(
                    'nombre',
                    'departamento',
                    'nombre_horario',
                    'hora_entrada',
                    'minutos_entrada',
                    'hora_salida',
                    'minutos_salida',
                    DB::raw('MIN(CONVERT(varchar, fecha, 8)) as fecha_y_hora_marco_min'),
                    DB::raw('MAX(CONVERT(varchar, fecha, 8)) as fecha_y_hora_marco_max')
                )
                    ->where([
                        ['id', '=', $id],
                        ['IdDia', '=', $dt->dayOfWeek - 1],
                        [DB::raw('CONVERT(varchar, fecha, 103)'), '=', $fecha]
                    ])
                    ->groupBy(
                        'nombre',
                        'departamento',
                        'nombre_horario',
                        'hora_entrada',
                        'minutos_entrada',
                        'hora_salida',
                        'minutos_salida'
                    )
                    ->get();

                $tamañoFinal = count($reportFor);
                for ($y = 0; $y < $tamañoFinal; $y++) {
                    $numDia = $dt->dayOfWeek - 1;
                    $dia = $this->nombreDelDia($numDia);

                    $horastrabajadas = $this->horasTrabajadas($reportFor[$y]->fecha_y_hora_marco_min, $reportFor[$y]->fecha_y_hora_marco_max);
                    $horasrealestrabajadas = $this->horasTrabajadasMenosHorasdeComer($reportFor[$y]->fecha_y_hora_marco_min, $reportFor[$y]->fecha_y_hora_marco_max);

                    if($reportFor[$y]->fecha_y_hora_marco_min== $reportFor[$y]->fecha_y_hora_marco_max){
                        $reportFor[$y]->horasrealestrabajadas = "marcaje incorrecto";
                        $reportFor[$y]->horastrabajadas = "marcaje incorrecto";
                        $reportFor[$y]->salioantes="marcaje incorrecto";
                        $reports[$y]->extras="marcaje incorrecto";
                    }else{
                        $reportFor[$y]->horastrabajadas = $horastrabajadas->format('%h horas %i minutos');
                        $reportFor[$y]->horasrealestrabajadas = "{$horasrealestrabajadas->hour} horas {$horasrealestrabajadas->minute} minutos";
                        $hrms=intval( substr($reportFor[$y]->fecha_y_hora_marco_max,0,2));
                        $mms=intval(substr($reportFor[$y]->fecha_y_hora_marco_max,3,5));
                        $hos=$reportFor[$y]->hora_salida;
                        $mos=$reportFor[$y]->minutos_salida;
                        $reportFor[$y]->salioantes=$this->calculoMarcadoAdelantado($hrms,$mms,$hos,$mos);
                        $reports[$y]->extras=$this->calculoHorasExtras($hrms,$mms,$hos,$mos);

                    }
                    $hrme=intval(substr($reports[$y]->fecha_y_hora_marco_min,0,2));
                    $mme=intval(substr($reports[$y]->fecha_y_hora_marco_min,3,5));
                    $heo=$reports[$y]->hora_entrada;
                    $meo=$reports[$y]->minutos_entrada;
                    $reports[$y]->asis=$this->calculoMarcadoAtrasado($hrme,$mme,$heo,$meo);
                    $reportFor[$y]->dia = $dia;
                    $reportFor[$y]->fecha = $fecha;
                    array_push($pila, $reportFor[$y]);
                }
            }

            $quantityEmployees = UserBiometric::where('Active', 1)->count();

            return response()->json([
                'respuesta' => $pila,
                'cantidadempleadosdepto' => $quantityEmployees
            ], 200);
        } else {
            if (request('IdDepartment')) {

                $reports = DB::table('User')
                    ->join('Record', 'User.IdUser', '=', 'Record.IdUser')
                    ->join('Department', 'User.IdDepartment', '=', 'Department.IdDepartment')
                    ->join('UserShift', 'User.IdUser', '=', 'UserShift.IdUser')
                    ->join('Shift', 'UserShift.ShiftId', '=', 'Shift.ShiftId')
                    ->join('ShiftDetail', 'Shift.ShiftId', '=', 'ShiftDetail.ShiftId')
                    ->select(
                        'User.IdUser as id',
                        'User.Name as nombre',
                        'Department.IdDepartment as id_departamento',
                        'Department.Description as departamento',
                        'Shift.Description as nombre_horario',
                        'ShiftDetail.T2InHour as hora_entrada',
                        'ShiftDetail.T2InMinute as minutos_entrada',
                        'ShiftDetail.T2OutHour as hora_salida',
                        'ShiftDetail.T2OutMinute as minutos_salida',
                        DB::raw('MIN(CONVERT(varchar, Record.RecordTime, 8)) as fecha_y_hora_marco_min'),
                        DB::raw('MAX(CONVERT(varchar, Record.RecordTime, 8)) as fecha_y_hora_marco_max'),
                        DB::raw('MAX(CONVERT(varchar, Record.RecordTime, 103)) as fecha')
                    )
                    ->where([
                        ['Department.IdDepartment', '=', request('IdDepartment')],
                        ['ShiftDetail.DayId', '=', request('DayId')]
                    ])
                    ->whereDate('Record.RecordTime', '=', request('fecha'))
                    ->groupBy(
                        'User.IdUser',
                        'User.Name',
                        'Department.IdDepartment',
                        'Department.Description',
                        'Shift.Description',
                        'ShiftDetail.T2InHour',
                        'ShiftDetail.T2InMinute',
                        'ShiftDetail.T2OutHour',
                        'ShiftDetail.T2OutMinute'
                    )
                    ->get();

                $tamaño = count($reports);
                $pila = [];
                for ($i = 0; $i < $tamaño; $i++) {
                    $fecha = $reports[$i]->fecha;
                    $dt = Carbon::createFromFormat('d/m/Y', $fecha);

                    $numDia = $dt->dayOfWeek - 1;
                    $dia = $this->nombreDelDia($numDia);

                    $horastrabajadas = $this->horasTrabajadas($reports[$i]->fecha_y_hora_marco_min, $reports[$i]->fecha_y_hora_marco_max);
                    $horasrealestrabajadas = $this->horasTrabajadasMenosHorasdeComer($reports[$i]->fecha_y_hora_marco_min, $reports[$i]->fecha_y_hora_marco_max);

                    if($reports[$i]->fecha_y_hora_marco_min== $reports[$i]->fecha_y_hora_marco_max){
                        $reports[$i]->horasrealestrabajadas = "marcaje incorrecto";
                        $reports[$i]->horastrabajadas = "marcaje incorrecto";
                        $reports[$i]->salioantes="marcaje incorrecto";
                        $reports[$i]->extras="marcaje incorrecto";
                    }else{
                        $reports[$i]->horastrabajadas = $horastrabajadas->format('%h horas %i minutos');
                        $reports[$i]->horasrealestrabajadas = "{$horasrealestrabajadas->hour} horas {$horasrealestrabajadas->minute} minutos";
                        $hrms=intval( substr($reports[$i]->fecha_y_hora_marco_max,0,2));
                        $mms=intval(substr($reports[$i]->fecha_y_hora_marco_max,3,5));
                        $hos=$reports[$i]->hora_salida;
                        $mos=$reports[$i]->minutos_salida;
                        $reports[$i]->salioantes=$this->calculoMarcadoAdelantado($hrms,$mms,$hos,$mos);
                        $reports[$i]->extras=$this->calculoHorasExtras($hrms,$mms,$hos,$mos);
                    }
                    $hrme=intval(substr($reports[$i]->fecha_y_hora_marco_min,0,2));
                    $mme=intval(substr($reports[$i]->fecha_y_hora_marco_min,3,5));
                    $heo=$reports[$i]->hora_entrada;
                    $meo=$reports[$i]->minutos_entrada;
                    $reports[$i]->asis=$this->calculoMarcadoAtrasado($hrme,$mme,$heo,$meo);
                    $reports[$i]->dia = $dia;
                    array_push($pila, $reports[$i]);
                }

                $quantityEmployees = UserBiometric::where('IdDepartment', request('IdDepartment'))->count();

                return response()->json([
                    'respuesta' => $pila,
                    'cantidadempleadosdepto' => $quantityEmployees
                ], 200);
            }

            $reports = DB::table('User')
                ->join('Record', 'User.IdUser', '=', 'Record.IdUser')
                ->join('Department', 'User.IdDepartment', '=', 'Department.IdDepartment')
                ->join('UserShift', 'User.IdUser', '=', 'UserShift.IdUser')
                ->join('Shift', 'UserShift.ShiftId', '=', 'Shift.ShiftId')
                ->join('ShiftDetail', 'Shift.ShiftId', '=', 'ShiftDetail.ShiftId')
                ->select(
                    'User.IdUser as id',
                    'User.Name as nombre',
                    'Department.IdDepartment as id_departamento',
                    'Department.Description as departamento',
                    'Shift.Description as nombre_horario',
                    'ShiftDetail.T2InHour as hora_entrada',
                    'ShiftDetail.T2InMinute as minutos_entrada',
                    'ShiftDetail.T2OutHour as hora_salida',
                    'ShiftDetail.T2OutMinute as minutos_salida',
                    DB::raw('MIN(CONVERT(varchar, Record.RecordTime, 8)) as fecha_y_hora_marco_min'),
                    DB::raw('MAX(CONVERT(varchar, Record.RecordTime, 8)) as fecha_y_hora_marco_max'),
                    DB::raw('MAX(CONVERT(varchar, Record.RecordTime, 103)) as fecha')
                )
                ->where('ShiftDetail.DayId', '=', request('DayId'))
                ->whereDate('Record.RecordTime', '=', request('fecha'))
                ->groupBy(
                    'User.IdUser',
                    'User.Name',
                    'Department.IdDepartment',
                    'Department.Description',
                    'Shift.Description',
                    'ShiftDetail.T2InHour',
                    'ShiftDetail.T2InMinute',
                    'ShiftDetail.T2OutHour',
                    'ShiftDetail.T2OutMinute'
                )
                ->get();

            $tamaño = count($reports);
            $pila = [];
            for ($i = 0; $i < $tamaño; $i++) {
                $fecha = $reports[$i]->fecha;
                $dt = Carbon::createFromFormat('d/m/Y', $fecha);

                $numDia = $dt->dayOfWeek - 1;
                $dia = $this->nombreDelDia($numDia);

                $horastrabajadas = $this->horasTrabajadas($reports[$i]->fecha_y_hora_marco_min, $reports[$i]->fecha_y_hora_marco_max);
                $horasrealestrabajadas = $this->horasTrabajadasMenosHorasdeComer($reports[$i]->fecha_y_hora_marco_min, $reports[$i]->fecha_y_hora_marco_max);


                if($reports[$i]->fecha_y_hora_marco_min== $reports[$i]->fecha_y_hora_marco_max){
                    $reports[$i]->horasrealestrabajadas = "marcaje incorrecto";
                    $reports[$i]->horastrabajadas = "marcaje incorrecto";
                    $reports[$i]->salioantes="marcaje incorrecto";
                    $reports[$i]->extras="marcaje incorrecto";
                }else{
                    $reports[$i]->horastrabajadas = $horastrabajadas->format('%h horas %i minutos');
                    $reports[$i]->horasrealestrabajadas = "{$horasrealestrabajadas->hour} horas {$horasrealestrabajadas->minute} minutos";
                    $hrms=intval( substr($reports[$i]->fecha_y_hora_marco_max,0,2));
                    $mms=intval(substr($reports[$i]->fecha_y_hora_marco_max,3,5));
                    $hos=$reports[$i]->hora_salida;
                    $mos=$reports[$i]->minutos_salida;
                    $reports[$i]->salioantes=$this->calculoMarcadoAdelantado($hrms,$mms,$hos,$mos);
                    $reports[$i]->extras=$this->calculoHorasExtras($hrms,$mms,$hos,$mos);

                }
                $hrme=intval(substr($reports[$i]->fecha_y_hora_marco_min,0,2));
                $mme=intval(substr($reports[$i]->fecha_y_hora_marco_min,3,5));
                $heo=$reports[$i]->hora_entrada;
                $meo=$reports[$i]->minutos_entrada;
                $reports[$i]->asis=$this->calculoMarcadoAtrasado($hrme,$mme,$heo,$meo);
                $reports[$i]->dia = $dia;
                array_push($pila, $reports[$i]);
            }

            $quantityEmployees = UserBiometric::where('Active', 1)->count();

            return response()->json([
                'respuesta' => $pila,
                'cantidadempleadosdepto' => $quantityEmployees
            ], 200);
        } //fin de else principal
    } //fin de reports

    /**
     * Funcion calculoMarcadoAtrasado es para determinar si el empleado entró tarde o su marcaje está dentro del rango de 5 minutos antes
     * o 5 minutos despues
     * .
     */
    private function calculoMarcadoAtrasado($hem,$mem,$heo,$meo) {

        $horaOficial = new DateTime();
        $horaMarco = new DateTime();
        $horaMarco->setTime($hem, $mem,00,000);
        $horaOficial->setTime($heo, $meo, 00, 000);

        if($horaMarco > $horaOficial){
            $resta = $horaMarco ->diff ($horaOficial);

            if($resta->format('%I')>5){
                return "SÍ";
            }
        }

        return "NO";
    }


    /**
     * Funcion calculoMarcadoAdelantado es para determinar si el empleado salió antes o su marcaje está dentro del rango de 5 minutos antes
     * o 5 minutos despues
     * .
     */
    private function calculoMarcadoAdelantado($hsm,$msm,$hso,$mso) {

        $horaOficial = new DateTime();
        $horaMarco = new DateTime();
        $horaMarco->setTime($hsm, $msm,00,000);
        $horaOficial->setTime($hso, $mso, 00, 000);

        if($horaMarco < $horaOficial){
            $resta = $horaMarco ->diff ($horaOficial);

            if($resta->format('%I')>5){
                return $resta->format('-%H:%I:%S');
            }
        }

        return "salida correcta";
    }

    /**
     * Funcion calculoHorasExtras es para las horas extras que hizo el empleado
     * .
     */


    /**
     * Abreviaturas
     * hem = hora entrada marcar
     * mem = minutos entrada marcar
     * hsm = hora salida marcar
     * msm = minutos salida marcar
     */
    private function calculoHorasExtras($hsm, $msm, $hso, $mso) {
        $horaOficial = new DateTime();
        $horaMarco = new DateTime();
        $horaMarco->setTime($hsm, $msm, 00, 000);
        $horaOficial->setTime($hso, $mso, 00, 000);

        if($horaMarco>$horaOficial){
            $resta = $horaOficial -> diff($horaMarco);
            if($resta->format('%I')>5){
                return $resta->format('%H:%I:%S');
            }

        }

        return 0;

    }

    /**
     * Funcion reportByUser devuelve un json con los registros de marcadado de hora
     * del usuario en el biometrico segun una fecha unica o por rangos, aplica el filtro
     * por el departamento de dicho usuario.
     *
     * @param  int  IdUser
     * @param  date  fecha
     * @return json respuesta
     */
    public function reportByUser(Request $request)
    {
        $this->validate($request, [
            'IdUser' => 'required',
            'fecha' => 'required'
        ]);

        $Str_fecha = request('fecha');
        $between;
        try {
            //$between = "2018-11-1,2018-11-3";
            $between = explode(",", $Str_fecha);
        } catch (Exception $e) {
            $between = [$Str_fecha];
        }

        if (count($between) > 1) {
            $reports = Rango_fechas::select(
                'id',
                'nombre',
                'id_departamento',
                'departamento',
                'nombre_horario',
                DB::raw('CONVERT(varchar, fecha, 103) fecha')
            )
                ->where('id', request('IdUser'))
                ->whereRaw("fecha >= ? AND fecha <= ?", array($between[0] . " 00:00:00", $between[1] . " 23:59:59"))
                ->distinct()->orderBy('id', 'asc')
                ->get();

            $tamaño = count($reports);
            $pila = [];
            for ($i = 0; $i < $tamaño; $i++) {
                $id = $reports[$i]->id;
                $id_departamento = $reports[$i]->id_departamento;
                $fecha = $reports[$i]->fecha;
                $dt = Carbon::createFromFormat('d/m/Y', $fecha);
                $numDia = $dt->dayOfWeek - 1;
                $dia = $this->nombreDelDia($numDia);

                if ($dia != "Sabado") {
                    $reportFor = Rango_fechas::select(
                        'nombre',
                        'departamento',
                        'nombre_horario',
                        'hora_entrada',
                        'minutos_entrada',
                        'hora_salida',
                        'minutos_salida',
                        DB::raw('MIN(CONVERT(varchar, fecha, 8)) as fecha_y_hora_marco_min'),
                        DB::raw('MAX(CONVERT(varchar, fecha, 8)) as fecha_y_hora_marco_max')
                    )
                        ->where([
                            ['id', '=', $id], ['id_departamento', '=', $id_departamento],
                            ['IdDia', '=', $numDia],
                            [DB::raw('CONVERT(varchar, fecha, 103)'), '=', $fecha]
                        ])
                        ->groupBy(
                            'nombre',
                            'departamento',
                            'nombre_horario',
                            'hora_entrada',
                            'minutos_entrada',
                            'hora_salida',
                            'minutos_salida'
                        )

                        ->get();

                    $min = $reportFor[0]->fecha_y_hora_marco_min;
                    $max = $reportFor[0]->fecha_y_hora_marco_max;

                    $dispositivoEntrada = Rango_fechas::select('dispositivo as dispEntrada')
                        ->where([
                            ['id', '=', $id], ['id_departamento', '=', $id_departamento],
                            ['IdDia', '=', $numDia], [DB::raw('CONVERT(varchar, fecha, 8)'), '=', $min]
                        ])->get();

                    $dispositivoSalida = Rango_fechas::select('dispositivo as dispSalida')
                        ->where([
                            ['id', '=', $id], ['id_departamento', '=', $id_departamento],
                            ['IdDia', '=', $numDia], [DB::raw('CONVERT(varchar, fecha, 8)'), '=', $max]
                        ])->get();

                    $reportFor[0]->dispositivoEntrada = $dispositivoEntrada[0]->dispEntrada;
                    $reportFor[0]->dispositivoSalida = $dispositivoSalida[0]->dispSalida;

                    $tamaño2 = count($reportFor);
                    for ($y = 0; $y < $tamaño2; $y++) {
                        /*HORAS TRABAJADAS EN MILISEGUNDOS POR DIA basado en la hora de entrada y salida de ese dia*/
                        $horasTrabajadasSinComer = $this->horasTrabajadas($min, $max);
                        $horastrabajadasmenoshorasdecomer = $this->horasTrabajadasMenosHorasdeComer($min, $max);

                        /*HORAS TEORICAS EN MILISEGUNDOS POR DIA basado en el horario de ese dia*/
                        $totalHorasTrabajadasTeorico = $this->totalHorasTrabajadasTeorico($reportFor[$y]->hora_entrada, $reportFor[$y]->minutos_entrada, $reportFor[$y]->hora_salida, $reportFor[$y]->minutos_salida);

                        $reportFor[$y]->dia = $dia;
                        $reportFor[$y]->fecha = $fecha;
                        /*HORAS TEORICAS EN MILISEGUNDOS POR DIA basado en el horario de ese dia*/
                        $reportFor[$y]->horasteoricopordiamilisegundos = $totalHorasTrabajadasTeorico->timestamp;
                        $reportFor[$y]->horasteoricopordia = "{$totalHorasTrabajadasTeorico->hour} horas {$totalHorasTrabajadasTeorico->minute} minutos";
                        /*HORAS TRABAJADAS EN MILISEGUNDOS POR DIA basado en la hora de entrada y salida de ese dia*/
                        $reportFor[$y]->horastrabajadassincomer = $horasTrabajadasSinComer->format('%h horas %i minutos');
                        $reportFor[$y]->horasrealestrabajadasmilisegundos = $horastrabajadasmenoshorasdecomer->timestamp;
                        $reportFor[$y]->horasrealestrabajadas = "{$horastrabajadasmenoshorasdecomer->hour} horas {$horastrabajadasmenoshorasdecomer->minute} minutos";
                        array_push($pila, $reportFor[$y]);
                    }
                }
            }

            $arrayTeoricoMilisegundos = [];
            $arrayRealTeoricoMilisegundos = [];
            if ($pila) {
                $tamañoFinal = count($pila);
                for ($x = 0; $x < $tamañoFinal; $x++) {
                    array_push($arrayTeoricoMilisegundos, $pila[$x]->horasteoricopordiamilisegundos);
                    array_push($arrayRealTeoricoMilisegundos, $pila[$x]->horasrealestrabajadasmilisegundos);
                }
            }

            $totalTeoricoFinal = array_sum($arrayTeoricoMilisegundos);
            $totalRealTeoricoFinal = array_sum($arrayRealTeoricoMilisegundos);

            return response()->json([
                'respuesta' => $pila,
                'totalTeoricoFinal' => $totalTeoricoFinal,
                'totalRealTeoricoFinal' => $totalRealTeoricoFinal
            ], 200);
        } else {
            $reports = Rango_fechas::select(
                'id',
                'nombre',
                'id_departamento',
                'departamento',
                'nombre_horario',
                DB::raw('CONVERT(varchar, fecha, 103) fecha')
            )
                ->where([
                    ['id', '=', request('IdUser')],
                    [DB::raw('CONVERT(date, fecha, 103)'), '=', $between[0]]
                ])
                ->distinct()->orderBy('id', 'asc')
                ->get();

            if (count($reports) == 1) {
                $id = $reports[0]->id;
                $id_departamento = $reports[0]->id_departamento;
                $fecha = $reports[0]->fecha;
                $dt = Carbon::createFromFormat('d/m/Y', $fecha);
                $numDia = $dt->dayOfWeek - 1;
                $dia = $this->nombreDelDia($numDia);

                if ($dia != "Sabado") {
                    $reportFor = Rango_fechas::select(
                        'nombre',
                        'departamento',
                        'nombre_horario',
                        'hora_entrada',
                        'minutos_entrada',
                        'hora_salida',
                        'minutos_salida',
                        DB::raw('MIN(CONVERT(varchar, fecha, 8)) as fecha_y_hora_marco_min'),
                        DB::raw('MAX(CONVERT(varchar, fecha, 8)) as fecha_y_hora_marco_max')
                    )
                        ->where([
                            ['id', '=', $id], ['id_departamento', '=', $id_departamento],
                            ['IdDia', '=', $numDia], [DB::raw('CONVERT(varchar, fecha, 103)'), '=', $fecha]
                        ])
                        ->groupBy(
                            'nombre',
                            'departamento',
                            'nombre_horario',
                            'hora_entrada',
                            'minutos_entrada',
                            'hora_salida',
                            'minutos_salida'
                        )
                        ->get();

                    $min = $reportFor[0]->fecha_y_hora_marco_min;
                    $max = $reportFor[0]->fecha_y_hora_marco_max;

                    $dispositivoEntrada = Rango_fechas::select('dispositivo as dispEntrada')
                        ->where([
                            ['id', '=', $id], ['id_departamento', '=', $id_departamento],
                            ['IdDia', '=', $numDia], [DB::raw('CONVERT(varchar, fecha, 8)'), '=', $min]
                        ])->get();

                    $dispositivoSalida = Rango_fechas::select('dispositivo as dispSalida')
                        ->where([
                            ['id', '=', $id], ['id_departamento', '=', $id_departamento],
                            ['IdDia', '=', $numDia], [DB::raw('CONVERT(varchar, fecha, 8)'), '=', $max]
                        ])->get();

                    $reportFor[0]->dispositivoEntrada = $dispositivoEntrada[0]->dispEntrada;
                    $reportFor[0]->dispositivoSalida = $dispositivoSalida[0]->dispSalida;

                    /*HORAS TRABAJADAS EN MILISEGUNDOS POR DIA basado en la hora de entrada y salida de ese dia*/
                    $horasTrabajadasSinComer = $this->horasTrabajadas($min, $max);
                    $horastrabajadasmenoshorasdecomer = $this->horasTrabajadasMenosHorasdeComer($min, $max);

                    /*HORAS TEORICAS EN MILISEGUNDOS POR DIA basado en el horario de ese dia*/
                    $totalHorasTrabajadasTeorico = $this->totalHorasTrabajadasTeorico($reportFor[0]->hora_entrada, $reportFor[0]->minutos_entrada, $reportFor[0]->hora_salida, $reportFor[0]->minutos_salida);

                    $reportFor[0]->dia = $dia;
                    $reportFor[0]->fecha = $fecha;
                    /*HORAS TEORICAS EN MILISEGUNDOS POR DIA basado en el horario de ese dia*/
                    $reportFor[0]->horasteoricopordiamilisegundos = $totalHorasTrabajadasTeorico->timestamp;
                    $reportFor[0]->horasteoricopordia = "{$totalHorasTrabajadasTeorico->hour} horas {$totalHorasTrabajadasTeorico->minute} minutos";
                    /*HORAS TRABAJADAS EN MILISEGUNDOS POR DIA basado en la hora de entrada y salida de ese dia*/
                    $reportFor[0]->horastrabajadassincomer = $horasTrabajadasSinComer->format('%h horas %i minutos');
                    $reportFor[0]->horasrealestrabajadasmilisegundos = $horastrabajadasmenoshorasdecomer->timestamp;
                    $reportFor[0]->horasrealestrabajadas = "{$horastrabajadasmenoshorasdecomer->hour} horas {$horastrabajadasmenoshorasdecomer->minute} minutos";

                    return response()->json([
                        'respuesta' => $reportFor,
                        'totalTeoricoFinal' => $reportFor[0]->horasteoricopordiamilisegundos,
                        'totalRealTeoricoFinal' => $reportFor[0]->horasrealestrabajadasmilisegundos
                    ], 200);
                } else {
                    return response()->json(['message' => 'El día sábado no es parte de los horarios de contrato'], 200);
                }
            } else {
                return response()->json(['message' => 'El empleado no se presento a trabajar este día o no marco sus horarios.'], 200);
            }
        }
    }

    /* 8 A 3:30*/

    /**
     * Funcion nombreDelDia devuelve el nombre del día de la semana por medio de
     * su numero de día (Basados en la libreria de Carbon).
     *
     * @param  int  numDia
     * @return string nombre de día
     */
    public function nombreDelDia($numDia)
    {
        if ($numDia == 0) {
            return 'Lunes';
        } else if ($numDia == 1) {
            return 'Martes';
        } else if ($numDia == 2) {
            return 'Miercoles';
        } else if ($numDia == 3) {
            return 'Jueves';
        } else if ($numDia == 4) {
            return 'Viernes';
        } else if ($numDia == 5) {
            return 'Sabado';
        } else
            return 'Domingo';
    }

    /**
     * Funcion horasTrabajadas devuelve la diferencia de tiempo en milisegundos de
     * un rango de fechas inicial y final.
     *
     * @param  time  horaMin
     * @param  time  horaMax
     * @return int milisegundos
     */
    public function horasTrabajadas($horaMin, $horaMax)
    {
        $inicioHorasTrabajoDia = new DateTime($horaMin); //fecha inicial
        $finalHorasTrabajoDia = new DateTime($horaMax); //fecha de cierre
        return $inicioHorasTrabajoDia->diff($finalHorasTrabajoDia);
    }

    /**
     * Funcion horasTrabajadasMenosHorasdeComer devuelve la diferencia de tiempo en milisegundos de
     * un rango de horas inicial y final menos los lapsos de tiempo de receso.
     *
     * usamos la función horasTrabajadas para obtener el tiempo base trabajado y luego se resta
     * el tiempo de receso, establecido en los parametros del sistema.
     *
     * @param  time  horaMin
     * @param  time  horaMax
     * @return int milisegundos
     */
    public function horasTrabajadasMenosHorasdeComer($horaMin, $horaMax)
    {
        $desayuno = System_Parameters::select('valor_parametro')->where('parametro', 'receso desayuno')->value('valor_parametro');
        $almuerzo = System_Parameters::select('valor_parametro')->where('parametro', 'receso almuerzo')->value('valor_parametro');
        $horas = ((int) Str::substr($desayuno, 0, 2) + (int) Str::substr($almuerzo, 0, 2));
        $minutos = ((int) Str::substr($desayuno, 3, 2) + (int) Str::substr($almuerzo, 3, 2));

        $horasTrabajadas = $this->horasTrabajadas($horaMin, $horaMax);
        $horasRealesTrabajadas = Carbon::create(0, 0, 0, $horasTrabajadas->h, $horasTrabajadas->i);
        $horasRealesTrabajadas->subHours($horas);
        $horasRealesTrabajadas->subMinutes($minutos);
        return $horasRealesTrabajadas;
    }

    /**
     * Funcion totalHorasTrabajadasTeorico devuelve la diferencia de tiempo en milisegundos de
     * un rango de horas inicial y final del horario establecido para los biometricos.
     *
     * usamos la función horasTrabajadas para obtener el tiempo base trabajado y luego se da
     * formato creando el tiempo por medio de la libreria Carbon.
     *
     * @param  string  hora_entrada
     * @param  string  minutos_entrada
     * @param  string  hora_salida
     * @param  string  minutos_salida
     * @return timestamp
     */
    public function totalHorasTrabajadasTeorico($hora_entrada, $minutos_entrada, $hora_salida, $minutos_salida)
    {
        /*HORAS TEORICAS EN MILISEGUNDOS POR DIA basado en el horario de ese dia*/
        $horasTeoricoEntrada = "{$hora_entrada}:{$minutos_entrada}:00";
        $horasTeoricoSalida = "{$hora_salida}:{$minutos_salida}:00";
        $horasTeoricoPorDia = $this->horasTrabajadas($horasTeoricoSalida, $horasTeoricoEntrada);
        $totalHorasTrabajadasTeorico = Carbon::create(0, 0, 0, $horasTeoricoPorDia->h, $horasTeoricoPorDia->i, $horasTeoricoPorDia->s);
        return $totalHorasTrabajadasTeorico;
    }
}
