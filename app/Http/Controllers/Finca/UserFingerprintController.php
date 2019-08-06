<?php

namespace App\Http\Controllers\Finca;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class UserFingerprintController extends Controller
{
    //
    public function getUserFingerprint($user_id)
    {
    	$getUserFingerprint = DB::table('UserFingerprint')
                ->where('IdUser',$user_id)
                ->get();

    	return $getUserFingerprint;
    }
}
