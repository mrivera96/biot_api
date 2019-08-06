<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class UsersDepartments extends Model
{
    protected $table="users_departments";
    public $timestamps=false;
    protected $fillable=['Id_user', 'Id_department'];
}
