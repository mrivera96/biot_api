<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddPermisosToPermissions extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('users_permissions', function (Blueprint $table) {
            $table->boolean('param_sect')->default(false);
            $table->boolean('users_sect')->default(false);
            $table->boolean('hors_sect')->default(false);
            $table->boolean('btn_editemp')->default(false);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('users_permissions', function (Blueprint $table) {
            //
        });
    }
}
