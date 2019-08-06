<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class CreateAlterTableRecordCommand3 extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'command:CreateAlterTableRecordCommand3';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Altera la tabla Record agregando nuevas columnas necesarias para la funcionalidad del Reporte.';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        //
        DB::statement("
            ALTER TABLE dbo.Record ADD
                Description varchar(100) NULL,
                T2InHour int NULL,
                T2InMinute int NULL,
                T2OutHour int NULL,
                T2OutMinute int NULL
        ");
    }
}
