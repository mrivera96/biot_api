<?php

namespace App\Http\Controllers\CatalogProducts;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Edujugon\Laradoo\Odoo;
use OdooClient\Client;
use function GuzzleHttp\json_encode;

class CatalogProductsController extends Controller
{
    //
    protected $odoo;



    /**
     *  credentials set.
        protected $host = 'http://10.203.101.97:8069';
        protected $db = 'david';
     */

    /*
            3meses de evaluacion 
            edisoft royalcaribean, oscar lopez, 
        */


    protected $host = 'http://10.203.101.39:8069';
    protected $db = 'Davidoff';
    //protected $host = 'http://10.203.101.97:8069';
    //protected $db = 'david';
    protected $username = 'admin';
    protected $password = '2020.Alejo';

    public function __construct()
    {
        $this->odoo = new Odoo();
        $this->createOdooInstance();
    }

    /**
     * Connect with the odoo and create the oddo instance.
     */
    protected function createOdooInstance()
    {
        //dd('url: ' . $this->host . ' db:' . $this->db . ' user:' . $this->username . ' pass:' . $this->password);
        $this->odoo = $this->odoo
            ->username($this->username)
            ->password($this->password)
            ->db($this->db)
            ->host($this->host)
            ->connect();
    }



    /**CREAR ARREGLO QUE DEVUELVA LOS CAMPOS MENOS LA IMAGEN, RECORRER ESE ARREGLO PARA CONSULTAR LA IMAGEN
     * INSERTAR ESE RESULTADO EN OTRO ARREGLO Y DEVOLVERLO
     */

    public function getProducts(Request $request)
    {

        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'region' => 'required'
        ]);


        try {
            $can = $this->odoo->where('region', '=', request('region'))
                ->fields(['name', 'default_code', 'image', 'creater', 'create_date', 'update_date', 'product_tmpl_id'])
                ->get('product.product');


            if (count($can) > 0) {
                return response()->json(['data' => $this->utf8_converter($can)], 200, [], JSON_UNESCAPED_UNICODE);
            } else {
                $pila = [];
                $iresponse = $this->odoo->where('region', '=', request('region'))
                    ->fields(['id'])
                    ->get('product.product');


                for ($i = 0; $i < sizeof($iresponse); $i++) {
                    $fresponse = $this->odoo->where('id', '=', utf8_encode($iresponse[$i]['id']))
                        ->fields(['name', 'default_code', 'image', 'creater', 'create_date', 'update_date', 'product_tmpl_id'])
                        ->get('product.product');

                    array_push($pila, $fresponse->first());
                }

                return response()->json(['data' => $this->utf8_converter($pila)], 200, [], JSON_UNESCAPED_UNICODE);
            }
        } catch (Exception $ex) {
            return response()->json("error: " . $ex->getMessage());
        }
    }

    public function getBOM(Request $request)
    {
        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'templateId' => 'required'
        ]);

        $ids = $this->odoo->where('product_tmpl_id', '=', intval(request('templateId')))
            ->search('mrp.bom');

        $lineBom = $this->odoo->where('bom_id', '=', $ids[0])
            ->fields(['product_id'])
            ->get('mrp.bom.line');

        return response()->json(['data' => $this->utf8_converter($lineBom)], 200, [], JSON_UNESCAPED_UNICODE);
    }

    public function getPhases(Request $request)
    {
        //Validacion de campos que se pueden recibir
        $this->validate($request, [
            'productId' => 'required'
        ]);

        $can = $this->odoo->where('product_id', '=', intval(request('productId')))
            ->fields(['numero_fase', 'name', 'img_fase1'])
            ->get('product.diadema.catalogo');

        if (count($can) > 0) {
            return response()->json(['data' => $this->utf8_converter($can)], 200, [], JSON_UNESCAPED_UNICODE);
        } else {
            $pila = [];
            $iresponse = $this->odoo->where('product_id', '=', intval(request('productId')))
            ->fields(['id'])
            ->get('product.diadema.catalogo');

            for ($i = 0; $i < sizeof($iresponse); $i++) {
                $fresponse = $this->odoo->where('id', '=', $iresponse[$i]['id'])
                ->fields(['numero_fase', 'name', 'img_fase1'])
                ->get('product.diadema.catalogo');

                array_push($pila, $fresponse->first());
            }

            return response()->json(['data' => $this->utf8_converter($pila)], 200, [], JSON_UNESCAPED_UNICODE);
            
        }
    }

    public function utf8_converter($array)
    {
        array_walk_recursive($array, function (&$item, $key) {
            //if(!mb_detect_dcoding($item, 'utf-8', true)){
            $item = utf8_encode($item);
            //}
        });

        return $array;
    }
}
