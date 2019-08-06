<?php

namespace App\Http\Controllers\Finca;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Profile;

class ProfileController extends Controller
{
	/**
     * Funcion profile lista todos los perfiles existentes para
     * asignar al usuario.
     *
     * @return json  respuesta
     */
    public function profile(){
    	$profile = Profile::select('IdProfile', 'Description')->get();
    	
    	return response()->json(['respuesta'=> $profile],200);
    }
}
