<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class CreateOrReplaceViewForRangeReportCommand5 extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'view:CreateOrReplaceViewForRangeReportCommand5';
    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Create or Replace SQL View.';
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
     * Para crear o actualizar la vista
     *
     * @return mixed
     */
    public function handle()
    {
        DB::statement("
            CREATE VIEW Rango_fechas
            as 
            select [User].IdUser as id,
                   [User].Name as nombre,
                   Department.IdDepartment as id_departamento,
                   Department.Description as departamento,
                   Record.Description as nombre_horario,
                   Record.T2InHour as hora_entrada,
                   Record.T2InMinute as minutos_entrada,
                   Record.T2OutHour as hora_salida,
                   Record.T2OutMinute as minutos_salida,
                   ShiftDetail.DayId as IdDia,
                   ShiftDetail.Description as Dia,
                   Record.RecordTime as fecha,
                   Device.Description as dispositivo
            from 
                [dbo].[User] 
                    join Record on [dbo].[User].IdUser = Record.IdUser
                    join Device on [dbo].[Record].MachineNumber = Device.MachineNumber
                    join Department on [dbo].[User].IdDepartment=Department.IdDepartment
                    join UserShift on [dbo].[User].IdUser=UserShift.IdUser
                    join Shift on UserShift.ShiftId=Shift.ShiftId
                    join ShiftDetail on Shift.ShiftId=ShiftDetail.ShiftId
            where ShiftDetail.DayId !=6
                    and [dbo].[User].Active = 1
            group by
                [dbo].[User].IdUser,
                    [dbo].[User].Name,
                    Department.IdDepartment,
                    Department.Description,
                    Record.Description,
                    Record.T2InHour,
                    Record.T2InMinute,
                    Record.T2OutHour,
                    Record.T2OutMinute,
                    Record.RecordTime,
                    ShiftDetail.DayId,
                    ShiftDetail.Description,
                    Device.Description;
        ");
    }

    /*
        /* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.
        BEGIN TRANSACTION
        SET QUOTED_IDENTIFIER ON
        SET ARITHABORT ON
        SET NUMERIC_ROUNDABORT OFF
        SET CONCAT_NULL_YIELDS_NULL ON
        SET ANSI_NULLS ON
        SET ANSI_PADDING ON
        SET ANSI_WARNINGS ON
        COMMIT
        BEGIN TRANSACTION
        GO
        ALTER TABLE dbo.Record ADD
            Description varchar(100) NULL,
            T2InHour int NULL,
            T2InMinute int NULL,
            T2OutHour int NULL,
            T2OutMinute int NULL
        GO
        ALTER TABLE dbo.Record SET (LOCK_ESCALATION = TABLE)
        GO
        COMMIT
    */
}
