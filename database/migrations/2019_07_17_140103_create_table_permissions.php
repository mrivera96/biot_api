<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTablePermissions extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users_permissions', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('id_user');
            $table->boolean('reporasis');
            $table->boolean('creaemp');
            $table->boolean('agdispemp');
            $table->boolean('editemp');
            $table->boolean('reghue');
            $table->boolean('deledispemp');
            $table->boolean('dept');
            $table->boolean('creadisp');
            $table->boolean('opdoor');
            $table->boolean('editdisp');
            $table->boolean('exportusrdisp');
            $table->boolean('mapadisp');
            $table->boolean('edithrs');
            $table->boolean('creaparam');
            $table->boolean('crearusrs');
            $table->boolean('editusrs');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('table_permissions');
    }
}
