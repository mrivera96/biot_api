<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class UserFingerprint extends Model
{
    //Documentation https://github.com/mopo922/LaravelTreats
	//Modulo no de Laravel para manejar llaves compuestas|compound keys
	use \LaravelTreats\Model\Traits\HasCompositePrimaryKey;

    // Nombre de la tabla en SQL server.
	protected $table='UserFingerprint';

	// Eloquent asume que cada tabla tiene una clave primaria con una columna llamada id.
	// Si éste no fuera el caso entonces hay que indicar cuál es nuestra clave primaria en la tabla:
	/**
     * The primary key of the table.
     *
     * @var array
     */
    protected $primaryKey = ['IdUser', 'FingerNumber', 'Version'];

    public $incrementing = false;

	/**
     * The attributes that are mass assignable.
     * Atributos que se pueden asignar de manera masiva.
     *
     * @var array
     */
	protected $fillable = [
		'IdUser'
		,'FingerNumber'
		,'Version'
		,'FingerPrintSize'
		,'FingerPrint'
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
	// 1 usuario puede tener muchos dispositivos  ->belongsToMany()
	//  etc..
	// Relación:
	public function user()
	{
		// muchas huella pertenece a un usuario.
		// $this hace referencia al objeto que tengamos en ese momento de UserFingerprint.
		return $this->belongsTo('App\User');
	}
}
