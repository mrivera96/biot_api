<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\UsersPermissions;

class UsersPermissionsController extends Controller
{
    public function save(){
        $id=request('id_user');
        $permissions=request('permissions');

        $perms=new UsersPermissions();
        $exists=$perms->where('id_user','=',$id)->get();
        if(count($exists)>0){

            try{
                $update=$perms->where('id_user','=', $id);
                $update=$update->update([
                    'reporasis'=>$permissions['reporasis'],
                'creaemp'=>$permissions['creaemp'],
                'agdispemp'=>$permissions['agdispemp'],
                'editemp'=>$permissions['editemp'],
                'reghue'=>$permissions['reghue'],
                'deledispemp'=>$permissions['deledispemp'],
                'dept'=>$permissions['dept'],
                'creadisp'=>$permissions['creadisp'],
                'opdoor'=>$permissions['opdoor'],
                'editdisp'=>$permissions['editdisp'],
                'exportusrdisp'=>$permissions['exportusrdisp'],
                'mapadisp'=>$permissions['mapadisp'],
                'edithrs'=>$permissions['edithrs'],
                'creaparam'=>$permissions['creaparam'],
                'crearusrs'=>$permissions['crearusrs'],
                'editusrs'=>$permissions['editusrs'],
                    'param_sect'=>$permissions['param_sect'],
                    'users_sect'=>$permissions['users_sect'],
                    'hors_sect'=>$permissions['hors_sect'],
                    'btn_editemp'=>$permissions['btn_editemp']
                ]);
                return response()->json('Permisos guardados correctamente', 200);
            }catch(Exception $e){
                return response()->json('Error al actualizar los permisos.',500);
            }
            
        }else{
            try{
                $new=new UsersPermissions();
                $new->id_user=$id;
                $new->reporasis     =$permissions['reporasis'];
                $new->creaemp		=$permissions['creaemp'];
                $new->agdispemp		=$permissions['agdispemp'];
                $new->editemp		=$permissions['editemp'];
                $new->reghue		=$permissions['reghue'];
                $new->deledispemp	=$permissions['deledispemp'];
                $new->dept			=$permissions['dept'];
                $new->creadisp		=$permissions['creadisp'];
                $new->opdoor		=$permissions['opdoor'];
                $new->editdisp		=$permissions['editdisp'];
                $new->exportusrdisp	=$permissions['exportusrdisp'];
                $new->mapadisp		=$permissions['mapadisp'];
                $new->edithrs		=$permissions['edithrs'];
                $new->creaparam		=$permissions['creaparam'];
                $new->crearusrs		=$permissions['crearusrs'];
                $new->editusrs		=$permissions['editusrs'];
                $new->param_sect    =$permissions['param_sect'];
                $new->users_sect    =$permissions['users_sect'];
                $new->hors_sect     =$permissions['hors_sect'];
                $new->btn_editemp   =$permissions['btn_editemp'];
                $new->save();
                return response()->json('Permisos guardados correctamente', 200);
            }catch(Exception $e){
                return response()->json('Error al guardar los permisos.', 500);
            }
        }
    }

    public function showPermissions(){
        $id=request('id_user');

        $perms=new UsersPermissions();
        $exists=$perms->where('id_user','=',$id)->get(['id_user'])->first();
        if($exists){
            $permisos=$perms->where('id_user','=',$id)->get(['reporasis',
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
                'param_sect',
                'users_sect',
                'hors_sect',
                'btn_editemp'
                ])->first();
            return response()->json(['id'=>$exists,'permisos'=>$permisos], 200);
        }else{
            return response()->json("Este usuario no tiene permisos asignados", 200);
        }
    }

    
}
