<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class System_Parameters extends Model
{
    // Nombre de la tabla en SQL server.
    protected $table='System_Parameters';

    /**
     * The attributes that are mass assignable.
     * Atributos que se pueden asignar de manera masiva.
     *
     * @var array
     */
    protected $fillable = [
        'parametro', 'descripcion', 'valor_parametro', 'valores_permitidos', 'valor_minimo', 'valor_maximo', 'activo', 'visible', 'CreatedBy', 'ModifiedBy'
    ];

    /**
     * The attributes that should be hidden for arrays.
     * Aquí ponemos los campos que no queremos que se devuelvan en las consultas.
     *
     * @var array
     */
    protected $hidden = [];

    // Definimos a continuación la relación de esta tabla con otras.
    // Ejemplos de relaciones:
    // 1 usuario tiene 1 teléfono   ->hasOne() Relación 1:1
    // 1 teléfono pertenece a 1 usuario   ->belongsTo() Relación 1:1 inversa a hasOne()
    // 1 post tiene muchos comentarios  -> hasMany() Relación 1:N 
    // 1 comentario pertenece a 1 post ->belongsTo() Relación 1:N inversa a hasMany()
    // 1 usuario puede tener muchos roles  ->belongsToMany()
    //  etc..
    // Relación:
    
    /*public function roles(){
        // 1 usuario pertenece a varios roles.
        // $this hace referencia al objeto que tengamos en ese momento de Usuario.
        return $this->belongsToMany('App\Role');
    }*/
}
