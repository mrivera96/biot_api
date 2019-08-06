<?php

namespace App\Http\Controllers\Finca;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\ShiftDetail;
use Illuminate\Support\Facades\DB;
use App\System_Parameters;
use Carbon\Carbon;

class ShiftDetailController extends Controller
{
	/**
     * Funcion shiftDetailByShiftId muestra el detalle de horario de un
     * dispositivo por medio de su ShiftId y DayId, dependiendo que dias
     * se quieren asi sera la respuesta.
     *
     * Se requieren las 2 ids ya que la tabla contiene llaves compuestas
     *
     * @param  number  IdUser
     * @return json  user
     */
    public function shiftDetailByShiftId(Request $request){
    	$this->validate($request, [
            'ShiftId' => 'required',
            'DayId' => 'required',
        ]);

        $dias = [0,1,2,3,4,5,6];
        $tamaño = count($dias);
        $shiftDetailByShiftId = [];

        for ($i=0; $i < $tamaño; $i++) { 
            $ids = ['ShiftId' => request('ShiftId'),
                'DayId' => $dias[$i]];

            $sDBSI = ShiftDetail::find($ids);
            array_push($shiftDetailByShiftId, $sDBSI);
        }       

    	if ($shiftDetailByShiftId[0]) {
    		return response()->json(['respuesta'=> $shiftDetailByShiftId],200);
    	} else {
	    	return response()->json(['respuesta'=> 'El detalle de horario del dispositivo no existe.'],422);
    	}
    }

    /**
     * Funcion detailShiftById muestra el detalle de horario
     * por medio de su id.
     *
     * @param  number  ShiftId
     * @return json  mensaje
     */
    public function detailShiftById(Request $request){
    	try {
	    	$this->validate($request, [
	    		'ShiftId' => 'required'
	        ]);

	    	$detailShiftById = DB::table('Shift')
                ->join('ShiftDetail', 'Shift.ShiftId', '=', 'ShiftDetail.ShiftId')
                ->select('Shift.ShiftId', 
                		 'Shift.Description as nombre_horario',
	                     'ShiftDetail.T2InHour as hora_entrada',
	                     'ShiftDetail.T2InMinute as minutos_entrada',
	                     'ShiftDetail.T2OutHour as hora_salida',
	                     'ShiftDetail.T2OutMinute as minutos_salida')
                ->where('Shift.ShiftId', request('ShiftId'))
                ->first();

            if ($detailShiftById) {
	    		return response()->json(['respuesta'=> $detailShiftById],200);
	    	} else {
		    	return response()->json(['respuesta'=> 'El horario no tiene un detalle.'],422);
	    	}
    	} catch (Exception $e) {
    		Log::error('Error detailShiftById: '.$e);
    		return response()->json(['respuesta'=> 'Error inesperado detailShiftById.'.$e],422);
    	}
    }

    /**
     * Funcion editShiftDetail actualiza la informacion del usuario
     * por medio de su id.
     *
     * @param  number  ShiftId
     * @param  string  T2InHour
     * @param  string  T2InMinute
     * @param  string  T2OutHour
     * @param  string  T2OutMinute
     * @return json  mensaje
     */
    public function editShiftDetail(Request $request){
    	try {
	    	$this->validate($request, [
	    		'ShiftId' => 'required',
	    		'T2InHour' => 'required',
	    		'T2InMinute' => 'required',
	    		'T2OutHour' => 'required',
	    		'T2OutMinute' => 'required'
	        ]);

	    	for ($i=0; $i < 6; $i++) {

	    		$ids = ['ShiftId' => request('ShiftId'),
	    				'DayId' => $i];

	    		$editShiftDetail = ShiftDetail::find($ids);

	    		if (!$editShiftDetail) {
	    			return response()->json(['respuesta'=> 'El detalle de horario no existe.'],422);
	    		}

                $T2InHour = request('T2InHour'); 
                $T2InMinute = request('T2InMinute');
                $T2OutHour = request('T2OutHour');
                $T2OutMinute = request('T2OutMinute');

                if (count($T2InHour)>1) {
                    $editShiftDetail->T2InHour = $T2InHour[$i];
                    $editShiftDetail->T2InMinute = $T2InMinute[$i];
                    $editShiftDetail->T2OutHour = $T2OutHour[$i];
                    $editShiftDetail->T2OutMinute = $T2OutMinute[$i];
                    $editShiftDetail->T2OverTime1BeginHour = $T2OutHour[$i];
                    $editShiftDetail->T2OverTime1BeginMinute = $T2OutMinute[$i];
                    $editShiftDetail->save();
                } else {
                    $editShiftDetail->T2InHour = $T2InHour[0];
                    $editShiftDetail->T2InMinute = $T2InMinute[0];

                    /* Representa dia viernes para establecer el mismo horario
                     * para todos los días -1 hora
                     */
                    if ($i == 4) {
                        /* Parametros del sistema para restar el tiempo del dia viernes
                         */
                        $restarHorasViernes = System_Parameters::select('valor_parametro')->where('parametro', 'restar horas viernes')->value('valor_parametro');

                        $restarMinutosViernes = System_Parameters::select('valor_parametro')->where('parametro', 'restar minutos viernes')->value('valor_parametro');

                        $hora = Carbon::create(0, 0, 0, $T2OutHour[0],$T2OutMinute[0]);
                        $hora->subHours($restarHorasViernes);
                        $hora->subMinutes($restarMinutosViernes);
                        $horasSalida = $hora->hour;
                        $minutosSalida = $hora->minute;

                        /*Si la resta devuelve negativo se establecen a 0 las horas y minutos*/
                        if ($horasSalida < 0) {
                            $horasSalida = $T2OutHour[0];
                        }

                        if ($minutosSalida < 0) {
                            $minutosSalida = $T2OutMinute[0];
                        }

                        if ($T2OutHour[0] == 0) {
                            $editShiftDetail->T2OutHour = $T2OutHour[0];
                            $editShiftDetail->T2OverTime1BeginHour = $T2OutHour[0];
                            $editShiftDetail->T2OutMinute = $T2OutMinute[0];
                            $editShiftDetail->T2OverTime1BeginMinute = $T2OutMinute[0];
                        } else {
                            $editShiftDetail->T2OutHour = $horasSalida;
                            $editShiftDetail->T2OutMinute = $minutosSalida;
                            $editShiftDetail->T2OverTime1BeginHour = $horasSalida;
                            $editShiftDetail->T2OverTime1BeginMinute = $minutosSalida;
                        }
                    } else {
                        $editShiftDetail->T2OutHour = $T2OutHour[0];
                        $editShiftDetail->T2OverTime1BeginHour = $T2OutHour[0];
                        $editShiftDetail->T2OutMinute = $T2OutMinute[0];
                        $editShiftDetail->T2OverTime1BeginMinute = $T2OutMinute[0];
                    }

                    $editShiftDetail->save();
                }
	    	}
	    	
	    	return response()->json(['message'=> 'Horario actualizado con éxito.',
                                 	 'horario' => $editShiftDetail],200);
		    	
	    } catch (Exception $e) {
    		Log::error('Error detailShiftById: '.$e);
    		return response()->json(['respuesta'=> 'Error al obtener el detalle de horario.'.$e],422);
    	}
    }
}
