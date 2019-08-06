<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CallTriggerRecordCommand4 extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Artisan::call("command:CreateTriggerForTableRecordCommand4");
    }
    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::statement("
            IF OBJECT_ID ('updateRecord', 'TR') IS NOT NULL  
            DROP TRIGGER updateRecord;
        ");
    }
}
