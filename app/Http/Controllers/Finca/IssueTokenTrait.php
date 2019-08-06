<?php 

namespace App\Http\Controllers\Finca;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

trait IssueTokenTrait{
    /**
     * Funcion issueToken llamado interno de la ruta oauth/token para 
     * generar la credencial de acceso (Token) del usuario para las
     * funciones login, refresh.
     *
     * @param  string  grant_type
     * @param  string  client_id
     * @param  string  client_secret
     * @param  string  username
     * @param  string  scope
     * @return json  credencial
     */
    public function issueToken(Request $request, $grantType, $scope = ""){
        $params=[
        'grant_type'=>$grantType,
        'client_id'=> $this->client->id,
        'client_secret' => $this->client->secret,
        'username'=> $request->email?: $request->name,
        'scope'=> $scope
        ];

        $request->request->add($params);
        $proxy = Request::create('oauth/token', 'POST');
        return Route::dispatch($proxy);
    }

    /**
     * Funcion issueTokenRegister llamado interno de la ruta oauth/token para 
     * generar la credencial de acceso (Token) del usuario para la funcion
     * register.
     *
     * @param  string  grant_type
     * @param  string  client_id
     * @param  string  client_secret
     * @param  string  username
     * @param  string  password
     * @param  string  scope
     * @return json  credencial
     */
    public function issueTokenRegister(Request $request, $grantType, $scope = "*"){
        $params=[
        'grant_type'=>$grantType,
        'client_id'=> $this->client->id,
        'client_secret' => $this->client->secret,
        'username'=> $request->email ?: $request->name,
        'password' => $request->password,
        'scope'=> $scope
        ];

        $request->request->add($params);
        $proxy = Request::create('oauth/token', 'POST');
        return Route::dispatch($proxy);
    }
}