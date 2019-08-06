<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Rango_fechas extends Model
{
    // Nombre de la tabla en SQL server.
    protected $table='Rango_fechas';

    /**
     * The attributes that are mass assignable.
     * Atributos que se pueden asignar de manera masiva.
     *
     * @var array
     */
    protected $fillable = [
		'id'
	    ,'nombre'
	    ,'id_departamento'
	    ,'departamento'
	    ,'nombre_horario'
	    ,'hora_entrada'
	    ,'minutos_entrada'
	    ,'hora_salida'
	    ,'minutos_salida'
	    ,'IdDia'
	    ,'Dia'
	    ,'fecha'
        ,'dispositivo'
    ];

    /**
     * Indicates if the model should be timestamped.
     * Indicamos si el modelo debe tener la marca de tiempo timestampe|fecha y hora.
     *
     * @var bool
     */
    public $timestamps = false;
}
