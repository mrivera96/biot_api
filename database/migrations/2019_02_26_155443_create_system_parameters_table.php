<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSystemParametersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('System_Parameters', function (Blueprint $table) {
            $table->increments('id');
            $table->string('parametro', 50)->unique();
            $table->string('descripcion', 250);
            $table->string('valor_parametro');
            $table->string('valores_permitidos')->nullable();
            $table->string('valor_minimo')->nullable();
            $table->string('valor_maximo')->nullable();
            $table->integer('activo');
            $table->string('visible', 1);
            $table->integer('CreatedBy');
            $table->integer('ModifiedBy');
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
        Schema::dropIfExists('System_Parameters');
    }
}
