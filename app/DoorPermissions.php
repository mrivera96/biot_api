<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class DoorPermissions extends Model
{
    protected $table      ="door_permissions";
    public $timestamps =false;
    protected $fillable   = ['id_user','principal','servidores','entrada_produccion','entrada_empaque'];
}
