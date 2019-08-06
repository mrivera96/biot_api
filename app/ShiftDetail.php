<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ShiftDetail extends Model
{
	//Documentation https://github.com/mopo922/LaravelTreats
	//Modulo no de Laravel para manejar llaves compuestas|compound keys
	use \LaravelTreats\Model\Traits\HasCompositePrimaryKey;

    // Nombre de la tabla en SQL server.
	protected $table='ShiftDetail';

	// Eloquent asume que cada tabla tiene una clave primaria con una columna llamada id.
	// Si éste no fuera el caso entonces hay que indicar cuál es nuestra clave primaria en la tabla:
	/**
     * The primary key of the table.
     *
     * @var array
     */
    protected $primaryKey = ['ShiftId', 'DayId'];

    public $incrementing = false;

	/**
     * The attributes that are mass assignable.
     * Atributos que se pueden asignar de manera masiva.
     *
     * @var array
     */
	protected $fillable = [
		'ShiftId'
		,'DayId'
		,'Description'
		,'Type'
		,'T1AttTime'
		,'T1OverTime1'
		,'T1OverTime1Minutes'
		,'T1OverTime1Factor'
		,'T1OverTime2'
		,'T1OverTime2Minutes'
		,'T1OverTime2Factor'
		,'T1OverTime3'
		,'T1OverTime3Minutes'
		,'T1OverTime3Factor'
		,'T1OverTime4'
		,'T1OverTime4Minutes'
		,'T1OverTime4Factor'
		,'T1OverTime5'
		,'T1OverTime5Minutes'
		,'T1OverTime5Factor'
		,'T1AccumulateOverTime'
		,'T1ValidateMinOverTime'
		,'T1MinOverTime'
		,'T2BeginOverTime'
		,'T2BeginOverTimeHour'
		,'T2BeginOverTimeMinute'
		,'T2BeginOverTimeFactor'
		,'T2ValidateMinBeginOverTime'
		,'T2MinBeginOverTime'
		,'T2InHour'
		,'T2InMinute'
		,'T2OutHour'
		,'T2OutMinute'
		,'T2EndOverTime1'
		,'T2OverTime1BeginHour'
		,'T2OverTime1BeginMinute'
		,'T2OverTime1EndHour'
		,'T2OverTime1EndMinute'
		,'T2OverTime1Factor'
		,'T2EndOverTime2'
		,'T2OverTime2BeginHour'
		,'T2OverTime2BeginMinute'
		,'T2OverTime2EndHour'
		,'T2OverTime2EndMinute'
		,'T2OverTime2Factor'
		,'T2EndOverTime3'
		,'T2OverTime3BeginHour'
		,'T2OverTime3BeginMinute'
		,'T2OverTime3EndHour'
		,'T2OverTime3EndMinute'
		,'T2OverTime3Factor'
		,'T2EndOverTime4'
		,'T2OverTime4BeginHour'
		,'T2OverTime4BeginMinute'
		,'T2OverTime4EndHour'
		,'T2OverTime4EndMinute'
		,'T2OverTime4Factor'
		,'T2EndOverTime5'
		,'T2OverTime5BeginHour'
		,'T2OverTime5BeginMinute'
		,'T2OverTime5EndHour'
		,'T2OverTime5EndMinute'
		,'T2OverTime5Factor'
		,'T2ValidateMinOverTime'
		,'T2MinOverTime'
		,'RestType'
		,'RT1Minute'
		,'RT1Max'
		,'RT21BeginHour'
		,'RT21BeginMinute'
		,'RT21EndHour'
		,'RT21EndMinute'
		,'RT22'
		,'RT22BeginHour'
		,'RT22BeginMinute'
		,'RT22EndHour'
		,'RT22EndMinute'
		,'RT23'
		,'RT23BeginHour'
		,'RT23BeginMinute'
		,'RT23EndHour'
		,'RT23EndMinute'
		,'RT2OverTime'
		,'RT2OverTimeFactor'
		,'RT2ValidateMinOverTime'
		,'RT2MinOverTime'
		,'AutoRestMinute'
		,'LeastTimeAutoAssigned'
		,'PayExtraTimeOnBegin'
		,'PayExtraTimeOnEnd'
		,'PayFactExtraTimeOnBegin'
		,'PayFactExtraTimeOnEnd'
		,'ValidateExtraTimeOnBegin'
		,'ValidateExtraTimeOnEnd'
		,'MinExtraTimeOnBegin'
		,'MinExtraTimeOnEnd'
		,'CuttingHourDay'
		,'CuttingMinuteDay'
	];

	/**
     * Indicates if the model should be timestamped.
     * Indicamos si el modelo debe tener la marca de tiempo timestampe|fecha y hora.
     *
     * @var bool
     */
	public $timestamps = false;
	
	/**
     * The attributes that should be hidden for arrays.
     * Aquí ponemos los campos que no queremos que se devuelvan en las consultas.
     *
     * @var array
     */
	//protected $hidden = ['created_at','updated_at']; 

	// Definimos a continuación la relación de esta tabla con otras.
	// Ejemplos de relaciones:
	// 1 usuario tiene 1 teléfono   ->hasOne() Relación 1:1
	// 1 teléfono pertenece a 1 usuario   ->belongsTo() Relación 1:1 inversa a hasOne()
	// 1 post tiene muchos comentarios  -> hasMany() Relación 1:N 
	// 1 comentario pertenece a 1 post ->belongsTo() Relación 1:N inversa a hasMany()
	// 1 usuario puede tener muchos roles  ->belongsToMany()
	//  etc..
	// Relación:
	/*
		public function department()
		{
			// 1 avión pertenece a un Fabricante.
			// $this hace referencia al objeto que tengamos en ese momento de Avión.
			//return $this->belongsTo('App\Fabricante');
		}
	*/
}
