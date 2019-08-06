<?php

namespace App\Http\Controllers\CatalogProducts;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Edujugon\Laradoo\Odoo;
use App\Shift;
use App\ShiftDetail;
use App\Department;
use App\UserBiometric;
use App\UserShift;
use Illuminate\Support\Facades\DB;
class OdooController extends Controller
{
	protected $odoo;
	protected $host = 'http://10.203.101.39:8069';
    protected $db = 'Davidoff';
    protected $username = 'admin';
    protected $password = 'admin';

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

     /*
	* Get departments of database Odoo and insert into sql Server db
    */
    public function getDepartmentsInsert(Request $request)
    {
    	$can = $this->odoo->fields(['name','parent_id'])
                          ->get('hr.department');
        
        foreach ($can as $key => $value) {
            $insertDepartment = new Department();
            $existe = Department::where('Description','=', $value['name'])->first();
            if($existe){
              $editDepartment = Department::find($value['id']);
              $editDepartment->Description = $value['name'];
              $editDepartment->IdParent = intval($value['parent_id']);
              $editDepartment->save();
             
            }else{
                
                DB::beginTransaction();
                DB::unprepared('SET IDENTITY_INSERT Department ON');
                
                $insertDepartment->IdDepartment = $value['id'];
                $insertDepartment->Description = $value['name'];
                $insertDepartment->IdParent = intval($value['parent_id']);
                $insertDepartment->save();
                DB::unprepared('SET IDENTITY_INSERT Department OFF');
                DB::commit();
            
             }
        }                  	
    }

    /*
	* Get departments of database Odoo
    */
    public function getDepartments(Request $request)
    {
    	$can = $this->odoo->fields(['name'])
                          ->get('hr.department');

    	return response()->json(['data'=> $this->utf8_converter($can)],200, [], JSON_UNESCAPED_UNICODE);
    }
	
	/*
	* Get shifts of database Odoo
    */
	public function getShifts(Request $request)
    {
    	$can = $this->odoo->get('resource.calendar');
    
        foreach ($can as $key => $value) {
            $insertShift = new Shift();
            $existe = Shift::where('Description','=', $value['name'])->first();
            if($existe){
              $editShift = Shift::find($value['id']);
              $editShift->Description = $value['name'];
              $editShift->save();

            }else{
                
                DB::beginTransaction();
                DB::unprepared('SET IDENTITY_INSERT Shift ON');
                
                $insertShift->ShiftId=$value['id'];
                $insertShift->Description = $value['name'];
                $insertShift->Comment = '';
                $insertShift->CuttingHour = 0;
                $insertShift->CuttingMinute = 0;
                $insertShift->Cycle = 7;
                $insertShift->save();
                DB::unprepared('SET IDENTITY_INSERT Shift OFF');
                DB::commit();
          
             }
        }
        
    	//return response()->json(['data'=> $this->utf8_converter($can)],200, [], JSON_UNESCAPED_UNICODE);
    }
	
	/*
	* Get shift_detail of database Odoo
    */
	/*public function getShiftDetail(Request $request)
    {
	
        $can = $this->odoo->get('resource.calendar.attendance');
        
       foreach ($can as $key => $value) {
            $insertShift = new ShiftDetail();
            $existe = ShiftDetail::where('Description','=', $value['name'])->first();
            $tipo=1;
            if(intval($value['dayofweek'])==6){
                $tipo=2;
            }
            $InTimehour=intval($value['hour_from']);
            $InTimeminute=($value['hour_from']-$InTimehour)*60;
            $OutTimehour=intval($value['hour_to']);
            $OutTimeminute=($value['hour_to']-$OutTimehour)*60;

            if($existe){
              $editShift = Shift::find($value['id']);
              $editShift->Description = $value['name'];
              $editShift->save();
              echo ("ya existe");
            }else{

                
                DB::beginTransaction();
                DB::unprepared('SET IDENTITY_INSERT ShiftDetail ON');
                
                $insertShift->ShiftId=$value['id'];
                $insertShift->DayId=$value['dayofweek'];
                $insertShift->Description = $value['name'];
                $insertShift->Type=$tipo;
                $insertShift->T2InHour= $InTimehour;
                $insertShift->T2InMinute= $InTimeminute;
                $insertShift->T2OutHour=$OutTimehour;
                $insertShift->T2OutMinute= $OutTimeminute;
         OJO $insertShift->T2OverTime1BeginHour=0;
            OJO $insertShift->T2OverTime1BeginMinute=0;
                $insertShift->T1AttTime=0;
                $insertShift->T1OverTime1=0;
                $insertShift->T1OverTime1Minutes=0;
                $insertShift->T1OverTime1Factor=100;
                $insertShift->T1OverTime2=0;
                $insertShift->T1OverTime2Minutes=0;
                $insertShift->T1OverTime2Factor=100;
                $insertShift->T1OverTime3=0;
                $insertShift->T1OverTime3Minutes=0;
                $insertShift->T1OverTime3Factor=100;
                $insertShift->T1OverTime4=0;
                $insertShift->T1OverTime4Minutes=0;
                $insertShift->T1OverTime4Factor=100;
                $insertShift->T1OverTime5=0;
                $insertShift->T1OverTime5Minutes=0;
                $insertShift->T1OverTime5Factor=100;
                $insertShift->T1AccumulateOverTime=0;
                $insertShift->T1ValidateMinOverTime=0;
                $insertShift->T1MinOverTime=0;
                $insertShift->T2BeginOverTime=0;
                $insertShift->T2BeginOverTimeHour=0;
                $insertShift->T2BeginOverTimeMinute=0;
                $insertShift->T2BeginOverTimeFactor=100;
                $insertShift->T2ValidateMinBeginOverTime=0;
                $insertShift->T2MinBeginOverTime=0;
                $insertShift->T2EndOverTime1=0;
                $insertShift->T2OverTime1EndHour=0;
                $insertShift->T2OverTime1EndMinute=0;
                $insertShift->T2OverTime1Factor=100;
                $insertShift->T2EndOverTime2=0;
                $insertShift->T2OverTime2BeginHour=0;    
                $insertShift->T2OverTime2BeginMinute=0;
                $insertShift->T2OverTime2EndHour=0;
                $insertShift->T2OverTime2EndMinute=0;
                $insertShift->T2OverTime2Factor=100;
                $insertShift->T2EndOverTime3=0;
                $insertShift->T2OverTime3BeginHour=0;
                $insertShift->T2OverTime3BeginMinute=0;
                $insertShift->T2OverTime3EndHour=0;
                $insertShift->T2OverTime3EndMinute=0;
                $insertShift->T2OverTime3Factor=100;
                $insertShift->T2EndOverTime4=0;
                $insertShift->T2OverTime4BeginHour=0;
                $insertShift->T2OverTime4BeginMinute=0;
                $insertShift->T2OverTime4EndHour=0;
                $insertShift->T2OverTime4EndMinute=0;
                $insertShift->T2OverTime4Factor=100;
                $insertShift->T2EndOverTime5=0;
                $insertShift->T2OverTime5BeginHour=0;
                $insertShift->T2OverTime5BeginMinute=0;
                $insertShift->T2OverTime5EndHour=0;
                $insertShift->T2OverTime5EndMinute=0;
                $insertShift->T2OverTime5Factor=100;
                $insertShift->T2ValidateMinOverTime=0;
                $insertShift->T2MinOverTime=1;
                $insertShift->RestType=0;
                $insertShift->RT1Minute=0;
                $insertShift->RT1Max=0;
                $insertShift->RT21BeginHour=0;
                $insertShift->RT21BeginMinute=0;
                $insertShift->RT21EndHour=0;
                $insertShift->RT21EndMinute=0;
                $insertShift->RT22=0;
                $insertShift->RT22BeginHour=0;
                $insertShift->RT22BeginMinute=0;
                $insertShift->RT22EndHour=0;
                $insertShift->RT22EndMinute=0;
                $insertShift->RT23=0;
                $insertShift->RT23BeginHour=0;
                $insertShift->RT23BeginMinute=0;
                $insertShift->RT23EndHour=0;
                $insertShift->RT23EndMinute=0;
                $insertShift->RT2OverTime=0;
                $insertShift->RT2OverTimeFactor=100;
                $insertShift->RT2ValidateMinOverTime=0;
                $insertShift->RT2MinOverTime=0;
                $insertShift->AutoRestMinute=0;
                $insertShift->LeastTimeAutoAssigned=0;
                $insertShift->PayExtraTimeOnBegin=0;
                $insertShift->PayExtraTimeOnEnd=0;
                $insertShift->PayFactExtraTimeOnBegin=100;
                $insertShift->PayFactExtraTimeOnEnd=100;
                $insertShift->ValidateExtraTimeOnBegin=0;
                $insertShift->ValidateExtraTimeOnEnd=0;
                $insertShift->MinExtraTimeOnBegin=0;
                $insertShift->MinExtraTimeOnEnd=0; 
                $insertShift->save();
                DB::unprepared('SET IDENTITY_INSERT ShiftDetail OFF');
                DB::commit();
          
             }
        }
       
    	return response()->json(['data'=> $this->utf8_converter($can)],200, [], JSON_UNESCAPED_UNICODE);
    }*/
    /*
	* Get Employees of database Odoo
    */
    public function getEmployees(Request $request)
    {
    	$can = $this->odoo->fields(['code_employee','identification_id','name','gender','birthday','department_id'])
                //->where('code_employee','=','123 BORRAR')                  
        ->get('hr.employee');
                         
    	return response()->json(['data'=> $this->utf8_converter($can)],200, [], JSON_UNESCAPED_UNICODE);
    }

    /*
    * Get Employees of database Odoo and insert int MSQL
        Género  Masculino  1
                Femenino   2
    */
    public function getEmployeesInsert(Request $request)
    {
        $can = $this->odoo->get('hr.employee');
    
        foreach ($can as $key => $value) {
            $insertEmployee = new UserBiometric();
            $id_comparar = intval($value['code_employee']);
            $existe = UserBiometric::where('IdUser','=', $id_comparar )->first();
               
            $gender=1;
            if($value['gender']=='female'){
                $gender=1; 
            }
            if($existe){
              $editEmployee = UserBiometric::find($value['code_employee']);
              $editEmployee->IdentificationNumber = $value['identification_id'];
              $editEmployee->Name = utf8_decode($value['name']);
              $editEmployee->Gender = $gender ;
              $editEmployee->Birthday = $value['birthday'];
              $editEmployee->IdDepartment = intval($value['department_id'][0]);
              $editEmployee->Active=$value['active'];
              $editEmployee->CreatedDatetime =$value['create_date'];
              $editEmployee->ModifiedDatetime = $value['write_date'];
              $editEmployee->privilege = 0;
              $editEmployee->HourSalary=0.00;
              $editEmployee->preferredIdLanguage = 0;
              $editEmployee->ProximityCard=0;
              $editEmployee->UseShift=1;
              $editEmployee->TemplateCode=-1;
              $editEmployee->CreatedBy = intval($value['create_uid']);
              $editEmployee->ModifiedBy = intval($value['write_uid']);
              $editEmployee->IdOdoo = intval($value['id']);

              $editEmployee->save();

            }else{
                
                
                
                $insertEmployee->IdUser = intval($value['code_employee']);
                $insertEmployee->IdentificationNumber = $value['identification_id'];
                $insertEmployee->Name = utf8_decode($value['name']);
                $insertEmployee->Gender = $gender;
                $insertEmployee->Birthday = $value['birthday'];
                $insertEmployee->IdDepartment = intval($value['department_id']);
                $insertEmployee->Active=$value['active'];
                $insertEmployee->CreatedDatetime = $value['create_date'];
                $insertEmployee->ModifiedDatetime = $value['write_date'];
                $insertEmployee->privilege = 0;
                $insertEmployee->HourSalary=0.00;
                $insertEmployee->preferredIdLanguage = 0;
                $insertEmployee->ProximityCard=0;
                $insertEmployee->UseShift=1;
                $insertEmployee->TemplateCode=-1;
                $insertEmployee->CreatedBy = intval($value['create_uid']);
                $insertEmployee->ModifiedBy = intval($value['write_uid']);
                $insertEmployee->IdOdoo = intval($value['id']);
                
                $insertEmployee->save();
          
             }

             $UserShift = new UserShift();
             $UserShift->IdUser = intval($value['code_employee']);
             $UserShift->ShiftId = $value['resource_calendar_id'][0];
             $UserShift->save();
        }
    }
	
	
	

    public function utf8_converter($array)
    {
        array_walk_recursive($array, function(&$item, $key){
        //if(!mb_detect_dcoding($item, 'utf-8', true)){
                $item = utf8_decode($item);
        //}
	    });

	    return $array;
    }
}
