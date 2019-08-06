<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class CallViewReportCommand5 extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Artisan::call("view:CreateOrReplaceViewForRangeReportCommand5");
    }
    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        /*
        para sql server 2017*/
        DB::statement("DROP VIEW IF EXISTS Rango_fechas;");

        /*para sql server 2014
        DB::statement("if exists(select 1 from sys.views where name='Rango_fechas' and type='v')
                       drop view Rango_fechas;");*/
    }
}
