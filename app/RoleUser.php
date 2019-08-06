<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class RoleUser extends Model
{
	// Nombre de la tabla en SQL server.
    protected $table ='role_user';

    /**
     * The attributes that are mass assignable.
     * Atributos que se pueden asignar de manera masiva.
     *
     * @var array
     */
    protected $fillable = [
        'role_id', 'user_id'
    ];
    
    // Definimos a continuación la relación de esta tabla con otras.
    // Ejemplos de relaciones:
    // 1 usuario tiene 1 teléfono   ->hasOne() Relación 1:1
    // 1 teléfono pertenece a 1 usuario   ->belongsTo() Relación 1:1 inversa a hasOne()
    // 1 post tiene muchos comentarios  -> hasMany() Relación 1:N 
    // 1 comentario pertenece a 1 post ->belongsTo() Relación 1:N inversa a hasMany()
    // 1 usuario puede tener muchos roles  ->belongsToMany()
    //  etc..
    // Relación:
    public function roles(){
    	// 1 rol pertenece a varios usuarios.
        // $this hace referencia al objeto que tengamos en ese momento de RoleUser.
    	return $this->belongsToMany('App\Role')->withTimestamps();
	}

    public function users(){
    	// 1 usuario pertenece a varios roles.
        // $this hace referencia al objeto que tengamos en ese momento de RoleUser.
    	return $this->belongsToMany('App\User')->withTimestamps();
	}
}
