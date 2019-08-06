<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class UsersPermissions extends Model
{
    // Nombre de la tabla en SQL server.
    protected $table='users_permissions';

    /**
     * The attributes that are mass assignable.
     * Atributos que se pueden asignar de manera masiva.
     *
     * @var array
     */
    protected $fillable = ['id_user','reporasis',
    'creaemp',
    'agdispemp',
    'editemp',
    'reghue',
    'deledispemp',
    'dept',
    'creadisp',
    'opdoor',
    'editdisp',
    'exportusrdisp',
    'mapadisp',
    'edithrs',
    'creaparam',
    'crearusrs',
    'editusrs',
    'created_at',
    'updated_at'
    ];

    public $timestamps = false;
}
