<?php

namespace App\Http\Controllers\Finca;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Shift;
use App\ShiftDetail;

class ShiftController extends Controller
{
	/**
     * Funcion shift devuelve un json con los horarios existentes.
     *
     * @return json respuesta
     */
    public function shift(){
    	$shift = Shift::select('ShiftId', 'Description')->get();
    	
    	return response()->json(['respuesta'=> $shift],200);
    }

    /**
     * Funcion registerShift crea un nuevo horario al sistema.
     *
     * @param  string  Description
     * @return json  respuesta
     */
    public function registerShift(Request $request){
        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'Description' => ['required', 'string'],
            'T2InHour' => ['required'],
            'T2InMinute' => ['required'],
            'T2OutHour' => ['required'],
            'T2OutMinute' => ['required']
        ]);

        $existe = Shift::where('Description', request('Description'))->first();

        if ($existe) {
            return response()->json(['respuesta'=> 'El nombre de horario ya existe.']);
        }else{
            /* INICIO Crear horario*/
            $shift = new Shift();
            $shift->Description = request('Description');
            $shift->Comment = '';
            $shift->CuttingHour = 0;
            $shift->CuttingMinute = 0;
            $shift->Cycle = 7;
            $shift->save();
            /* FIN Crear horario*/

            /*INICIO Crear detalle de horario*/
            $ShiftId = $shift->ShiftId;

            $diaSemana =['Lunes',
                         'Martes',
                         'Miercoles',
                         'Jueves',
                         'Viernes',
                         'Sabado',
                         'Domingo'];

            for ($i=0; $i < 7; $i++) {

                $shiftDetail = new ShiftDetail();
                $shiftDetail->ShiftId = $ShiftId;
                $shiftDetail->DayId = $i;
                $shiftDetail->Description = $diaSemana[$i];

                $T2InHour = request('T2InHour');
                $T2InMinute =request('T2InMinute');
                $T2OutHour = request('T2OutHour');
                $T2OutMinute = request('T2OutMinute');

                if ($i != 6) {
                    if (count($T2InHour)>1) {
                        $shiftDetail->Type = 2;
                        $shiftDetail->T2InHour = $T2InHour[$i];
                        $shiftDetail->T2InMinute = $T2InMinute[$i];
                        $shiftDetail->T2OutHour = $T2OutHour[$i];
                        $shiftDetail->T2OutMinute = $T2OutMinute[$i];
                        $shiftDetail->T2OverTime1BeginHour = $T2OutHour[$i];
                        $shiftDetail->T2OverTime1BeginMinute = $T2OutMinute[$i];
                    }else{
                        $shiftDetail->Type = 2;
                        $shiftDetail->T2InHour = $T2InHour[0];
                        $shiftDetail->T2InMinute = $T2InMinute[0];

                        /* Representa dia viernes para establecer el mismo horario
                         * para todos los días -1 hora
                         */
                        if ($i == 4) {
                            $shiftDetail->T2OutHour = $T2OutHour[0] - 1;
                            $shiftDetail->T2OverTime1BeginHour = $T2OutHour[0] - 1;
                        } else {
                            $shiftDetail->T2OutHour = $T2OutHour[0];
                            $shiftDetail->T2OverTime1BeginHour = $T2OutHour[0];
                        }
                        
                        $shiftDetail->T2OutMinute = $T2OutMinute[0];
                        
                        $shiftDetail->T2OverTime1BeginMinute = $T2OutMinute[0];
                    }          
                }else{
                    /*Representa un dia Domingo*/
                    $shiftDetail->Type = 1;
                    $shiftDetail->T2InHour = 0;
                    $shiftDetail->T2InMinute = 0;
                    $shiftDetail->T2OutHour = 0;
                    $shiftDetail->T2OutMinute = 0;
                    $shiftDetail->T2OverTime1BeginHour = 0;
                    $shiftDetail->T2OverTime1BeginMinute = 0;
                }

                $shiftDetail->T1AttTime = 0;
                $shiftDetail->T1OverTime1 = 0;
                $shiftDetail->T1OverTime1Minutes = 0;
                $shiftDetail->T1OverTime1Factor = 100;
                $shiftDetail->T1OverTime2 = 0;
                $shiftDetail->T1OverTime2Minutes = 0;
                $shiftDetail->T1OverTime2Factor = 100;
                $shiftDetail->T1OverTime3 = 0;
                $shiftDetail->T1OverTime3Minutes = 0;
                $shiftDetail->T1OverTime3Factor = 100;
                $shiftDetail->T1OverTime4 = 0;
                $shiftDetail->T1OverTime4Minutes = 0;
                $shiftDetail->T1OverTime4Factor = 100;
                $shiftDetail->T1OverTime5 = 0;
                $shiftDetail->T1OverTime5Minutes = 0;
                $shiftDetail->T1OverTime5Factor = 100;
                $shiftDetail->T1AccumulateOverTime = 0;
                $shiftDetail->T1ValidateMinOverTime = 0;
                $shiftDetail->T1MinOverTime = 0;
                $shiftDetail->T2BeginOverTime = 0;
                $shiftDetail->T2BeginOverTimeHour = 0;
                $shiftDetail->T2BeginOverTimeMinute = 0; 
                $shiftDetail->T2BeginOverTimeFactor = 100;
                $shiftDetail->T2ValidateMinBeginOverTime = 0;
                $shiftDetail->T2MinBeginOverTime = 0;
                $shiftDetail->T2EndOverTime1 = 0;
                $shiftDetail->T2OverTime1EndHour = 0;
                $shiftDetail->T2OverTime1EndMinute = 0;
                $shiftDetail->T2OverTime1Factor = 100;
                $shiftDetail->T2EndOverTime2 = 0;
                $shiftDetail->T2OverTime2BeginHour = 0;
                $shiftDetail->T2OverTime2BeginMinute = 0;
                $shiftDetail->T2OverTime2EndHour = 0;
                $shiftDetail->T2OverTime2EndMinute = 0;
                $shiftDetail->T2OverTime2Factor = 100;
                $shiftDetail->T2EndOverTime3 = 0;
                $shiftDetail->T2OverTime3BeginHour = 0;
                $shiftDetail->T2OverTime3BeginMinute = 0;
                $shiftDetail->T2OverTime3EndHour = 0;
                $shiftDetail->T2OverTime3EndMinute = 0;
                $shiftDetail->T2OverTime3Factor = 100;
                $shiftDetail->T2EndOverTime4 = 0;
                $shiftDetail->T2OverTime4BeginHour = 0;
                $shiftDetail->T2OverTime4BeginMinute = 0;
                $shiftDetail->T2OverTime4EndHour = 0;
                $shiftDetail->T2OverTime4EndMinute = 0;
                $shiftDetail->T2OverTime4Factor = 100;
                $shiftDetail->T2EndOverTime5 = 0;
                $shiftDetail->T2OverTime5BeginHour = 0;
                $shiftDetail->T2OverTime5BeginMinute = 0;
                $shiftDetail->T2OverTime5EndHour = 0;
                $shiftDetail->T2OverTime5EndMinute = 0;
                $shiftDetail->T2OverTime5Factor = 100;
                $shiftDetail->T2ValidateMinOverTime = 0;
                
                $shiftDetail->T2MinOverTime = 1;
                
                $shiftDetail->RestType = 0;
                $shiftDetail->RT1Minute = 0;
                $shiftDetail->RT1Max = 0;
                $shiftDetail->RT21BeginHour = 0;
                $shiftDetail->RT21BeginMinute = 0;
                $shiftDetail->RT21EndHour = 0;
                $shiftDetail->RT21EndMinute = 0;
                $shiftDetail->RT22 = 0;
                $shiftDetail->RT22BeginHour = 0;
                $shiftDetail->RT22BeginMinute = 0;
                $shiftDetail->RT22EndHour = 0;
                $shiftDetail->RT22EndMinute = 0;
                $shiftDetail->RT23 = 0;
                $shiftDetail->RT23BeginHour = 0;
                $shiftDetail->RT23BeginMinute = 0;
                $shiftDetail->RT23EndHour = 0;
                $shiftDetail->RT23EndMinute = 0;
                $shiftDetail->RT2OverTime = 0;
                $shiftDetail->RT2OverTimeFactor = 100;
                $shiftDetail->RT2ValidateMinOverTime = 0;
                $shiftDetail->RT2MinOverTime = 0;
                $shiftDetail->AutoRestMinute = 0;
                $shiftDetail->LeastTimeAutoAssigned = 0;
                $shiftDetail->PayExtraTimeOnBegin = 0;
                $shiftDetail->PayExtraTimeOnEnd = 0;
                $shiftDetail->PayFactExtraTimeOnBegin = 100;
                $shiftDetail->PayFactExtraTimeOnEnd = 100;
                $shiftDetail->ValidateExtraTimeOnBegin = 0;
                $shiftDetail->ValidateExtraTimeOnEnd = 0;
                $shiftDetail->MinExtraTimeOnBegin = 0;
                $shiftDetail->MinExtraTimeOnEnd = 0;
                $shiftDetail->CuttingHourDay = null;
                $shiftDetail->CuttingMinuteDay = null;
                $shiftDetail->save();
                
            }
            /*FIN Crear detalle de horario*/

            return response()->json(['message'=> 'Horario creado con éxito.',
                                     'horario' => $shift,
                                     'horariodetalle' => $shiftDetail],201);
        }
    }

    /**
     * Funcion editShift actualiza el nombre del horario
     * por medio de su id.
     *
     * @param  number  ShiftId
     * @param  string  Description
     * @return json  respuesta
     */
    public function editShift(Request $request){
        try {

            $this->validate($request, [
                'ShiftId' => 'required',
                'nombre_horario' => 'required'
            ]);

            $editShift = Shift::find(request('ShiftId'));
            $editShift->Description = request('nombre_horario');
            $editShift->save();

            return response()->json(['respuesta' => 'Horario actualizado con éxito.',
                                     'Horario' => $editShift],200);
        } catch (Exception $e) {
            Log::error('Error update_shiftDetail: '.$e);
            return response()->json(['respuesta'=> 'Error al actualizar el horario.'.$e],422);
        }
    }
}
