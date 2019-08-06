<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Record extends Model
{
	//Modulo no de Laravel para manejar compound keys|llaves compuestas
	use \LaravelTreats\Model\Traits\HasCompositePrimaryKey;

     // Nombre de la tabla en SQL server.
	protected $table='Record';

	// Eloquent asume que cada tabla tiene una clave primaria con una columna llamada id.
	// Si éste no fuera el caso entonces hay que indicar cuál es nuestra clave primaria en la tabla:
	protected $primaryKey = [
		'IdUser'
		,'RecordTime'
		,'RecordType'
	];

	/**
     * The attributes that are mass assignable.
     * Atributos que se pueden asignar de manera masiva.
     *
     * @var array
     */
	protected $fillable = [
		'IdUser'
		,'RecordTime'
		,'MachineNumber'
		,'RecordType'
		,'VerifyMode'
		,'Workcode'
		,'Comment'
		,'CreatedDate'
		,'CreatedBy'
		,'ModifiedDate'
		,'ModifiedBy'
	];

	/**
     * Indicates if the model should be timestamped.
     * Indicamos si el modelo debe tener la marca de tiempo timestampe|fecha y hora.
     *
     * @var bool
     */
	public $timestamps = false;
	
	// Aquí ponemos los campos que no queremos que se devuelvan en las consultas.
	/*
	|	protected $hidden = ['created_at','updated_at'];
	*/ 

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
