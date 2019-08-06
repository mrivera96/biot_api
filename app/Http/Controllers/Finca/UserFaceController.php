<?php

namespace App\Http\Controllers\Finca;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class UserFaceController extends Controller
{
    //
    public function getUserFace($user_id)
    {
    	$getUserFace = DB::table('UserFace')
                ->where('IdUser',$user_id)
                ->get();

    	return $getUserFace;
    }
}
