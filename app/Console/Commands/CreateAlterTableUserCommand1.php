<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class CreateAlterTableUserCommand1 extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'command:CreateAlterTableUserCommand1';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Altera la tabla User agregando nueva columna de referencia para Odoo.';

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
        DB::statement("ALTER TABLE [BDBioAdminSQL].[dbo].[User] ADD IdOdoo int NULL;");
    }
}
