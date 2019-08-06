<?php

namespace App\Http\Controllers\Finca;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\User;
use Laravel\Passport\Client;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;
use Zend\Diactoros\Response;

class LoginController extends Controller
{
    use IssueTokenTrait;
    
    private $client;

    /**
     * Funcion __construct crea el objeto client que es el consesor
     * de contraseñas y para obtener sus datos requeridos para la
     * autorización de nuevas credenciales de acceso (Tokens).
     *
     * @param  int  id_client
     * @return object  client
     */
    public function __construct(){
        $this->client = Client::find(1);
    }

    /**
     * Funcion login genera la credencial de acceso 
     * (Token) del usuario.
     *
     * @param  string  email
     * @param  string  password
     * @return json  credencial
     */
    public function login(Request $request){
        $this->validate($request, [
            'email' => 'required',
            'password' => 'required'
        ]);

        return $this->issueToken($request, 'password');
    }

    /**
     * Funcion refresh renovación de la credencial de acceso 
     * (Token) del usuario.
     *
     * @param  string  refresh_token
     * @return json  credencial
     */
    public function refresh(Request $request){
        $this->validate($request, [
            'refresh_token' => 'required'
        ]);

        return $this->issueToken($request, 'refresh_token');
    }

    /**
     * Funcion logout revocación la credencial de acceso 
     * (Token) del usuario.
     *
     * @return json  respuesta
     */
    public function logout(Request $request){
        $accessToken = Auth::user()->token();

        DB::table('oauth_refresh_tokens')
            ->where('access_token_id', $accessToken->id)
            ->update(['revoked' => true]);

        $accessToken->revoke();

        return response()->json(['respuesta' => 2], 200);
    }
}
