<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class CreateTriggerForTableRecordCommand4 extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'command:CreateTriggerForTableRecordCommand4';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Comondo para crear un Trigger para la tabla record que sirve para llevar un historico de marcajes y en que dispositivo marco esa persona cada vez que se haga una sincrinizacion de los registros del dispositivo a la base local.';

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
            CREATE TRIGGER updateRecord 
            ON [dbo].[Record]
            AFTER INSERT AS
            BEGIN
            declare @id_user int
            select @id_user = IdUser from inserted

            declare @ShiftId int
            select @ShiftId = ShiftId from [dbo].[UserShift] where IdUser=@id_user

            declare @Description varchar(255)
            select @Description = Description from [dbo].[Shift] where ShiftId = @ShiftId

            declare @RecordTime datetime
            select @RecordTime = RecordTime from inserted

            declare @T2InHour int 
            declare @T2InMinute int
            declare @T2OutHour int
            declare @T2OutMinute int

            select @T2InHour = T2InHour from [dbo].[ShiftDetail] where ShiftId = @ShiftId and DayId = (select datepart(DW, @RecordTime)-2)

            select @T2InMinute = T2InMinute from [dbo].[ShiftDetail] where ShiftId = @ShiftId and DayId = (select datepart(DW, @RecordTime)-2)

            select @T2OutHour = T2OutHour from [dbo].[ShiftDetail] where ShiftId = @ShiftId and DayId = (select datepart(DW, @RecordTime)-2)

            select @T2OutMinute = T2OutMinute from [dbo].[ShiftDetail] where ShiftId = @ShiftId and DayId = (select datepart(DW, @RecordTime)-2)

            update [dbo].[Record] set Description=@Description, T2InHour=@T2InHour, 
            T2InMinute=@T2InMinute, T2OutHour=@T2OutHour, T2OutMinute=@T2OutMinute
            where IdUser=@id_user and RecordTime = @RecordTime

            END;");
    }
}


// CREATE TRIGGER updateRecord 
//             ON [dbo].[Record]
//             AFTER INSERT AS
//             BEGIN
//             declare @id_user int
//             select @id_user = IdUser from inserted

//             declare @ShiftId int
//             select @ShiftId = ShiftId from [dbo].[UserShift] where IdUser=@id_user

//             declare @Description varchar(255)
//             select @Description = Description from [dbo].[Shift] where ShiftId = @ShiftId

//             declare @RecordTime datetime
//             select @RecordTime = RecordTime from inserted

//             declare @T2InHour int 
//             declare @T2InMinute int
//             declare @T2OutHour int
//             declare @T2OutMinute int

//             select @T2InHour = T2InHour from [dbo].[ShiftDetail] where ShiftId = @ShiftId and DayId = (select datepart(DW, @RecordTime)-2)

//             select @T2InMinute = T2InMinute from [dbo].[ShiftDetail] where ShiftId = @ShiftId and DayId = (select datepart(DW, @RecordTime)-2)

//             select @T2OutHour = T2OutHour from [dbo].[ShiftDetail] where ShiftId = @ShiftId and DayId = (select datepart(DW, @RecordTime)-2)

//             select @T2OutMinute = T2OutMinute from [dbo].[ShiftDetail] where ShiftId = @ShiftId and DayId = (select datepart(DW, @RecordTime)-2)

//             update [dbo].[Record] set Description=@Description, T2InHour=@T2InHour, 
//             T2InMinute=@T2InMinute, T2OutHour=@T2OutHour, T2OutMinute=@T2OutMinute
//             where IdUser=@id_user and RecordTime=@RecordTime


