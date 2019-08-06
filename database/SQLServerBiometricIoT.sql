--Debe crear la carpeta BT en la Unidad C:
--o cambiar la ruta de creación de los archivos de la base de datos

USE [master]
GO
/****** Object:  Database [BDBioAdminSQL]    Script Date: 06/07/2011 16:07:51 ******/
CREATE DATABASE [BDBioAdminSQL] ON  PRIMARY 
( NAME = N'BDBioAdminSQL_dat', FILENAME = N'C:\bt\BDBioAdminSQL.mdf' , SIZE = 6000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BDBioAdminSQL_log', FILENAME = N'C:\bt\BDBioAdminSQL.ldf' , SIZE = 6000KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 COLLATE Latin1_General_CI_AS
GO


use [BDBioAdminSQL]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Exception]') AND type in (N'U'))
BEGIN
CREATE TABLE [Exception](
	[IdException] [int] IDENTITY(1,1) NOT NULL,
	[BeginingDate] [datetime] NULL,
	[EndingDate] [datetime] NULL,
	[Description] [varchar](255) NULL,
	[Recurring] [bit] NOT NULL,
	[Comment] [varchar](250) NULL,
	[IdDepartment] [int] NULL,
	[IdUser] [int] NULL,
	[PaymentType] [int] NULL,
	[PaymentFactor] [int] NULL,
 CONSTRAINT [aaaaaException_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdException] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Exception]') AND name = N'IdDepartment')
CREATE NONCLUSTERED INDEX [IdDepartment] ON [Exception] 
(
	[IdDepartment] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Exception]') AND name = N'IdException')
CREATE UNIQUE NONCLUSTERED INDEX [IdException] ON [Exception] 
(
	[IdException] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Exception]') AND name = N'IdUser')
CREATE NONCLUSTERED INDEX [IdUser] ON [Exception] 
(
	[IdUser] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Language]') AND type in (N'U'))
BEGIN
CREATE TABLE [Language](
	[IdLanguage] [smallint] NOT NULL,
	[Description] nvarchar(max) NULL,
	[Image] varchar(max) NULL,
 CONSTRAINT [aaaaaLanguage_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdLanguage] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Log]') AND type in (N'U'))
BEGIN
CREATE TABLE [Log](
	[IdUser] [int] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[IdAction] [smallint] NOT NULL,
	[LastValue] [varchar](250) NULL,
	[NewValue] [varchar](250) NOT NULL,
 CONSTRAINT [aaaaaLog_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdUser] ASC,
	[ActionDate] ASC,
	[IdAction] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[LogAction]') AND type in (N'U'))
BEGIN
CREATE TABLE [LogAction](
	[IdLogAction] [int] NOT NULL,
	[IdLanguage] [int] NOT NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [aaaaaLogAction_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdLogAction] ASC,
	[IdLanguage] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[LogAction]') AND name = N'IdLanguage')
CREATE NONCLUSTERED INDEX [IdLanguage] ON [LogAction] 
(
	[IdLanguage] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Parameter]') AND type in (N'U'))
BEGIN
CREATE TABLE [Parameter](
	[IdParameter] [int] NOT NULL,
	[IdParameterCategory] [int] NOT NULL,
	[DataType] [smallint] NOT NULL,
	[Value] [nvarchar](max) NULL,
	[Values] [nvarchar](255) NULL,
 CONSTRAINT [aaaaaParameter_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdParameter] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ParameterCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [ParameterCategory](
	[IdParameterCategory] [int] NOT NULL,
	[Hide] [smallint] NOT NULL,
 CONSTRAINT [aaaaaParameterCategory_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdParameterCategory] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ParameterCategoryName]') AND type in (N'U'))
BEGIN
CREATE TABLE [ParameterCategoryName](
	[IdParameterCategory] [int] NOT NULL,
	[IdLanguage] [smallint] NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[Comment] [varchar](250) NOT NULL,
 CONSTRAINT [aaaaaParameterCategoryName_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdParameterCategory] ASC,
	[IdLanguage] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Department]') AND type in (N'U'))
BEGIN
CREATE TABLE [Department](
	[IdDepartment] [int] NOT NULL,
	[IdParent] [int] NULL,
	[Description] [varchar](255) NULL,
	[SupervisorName] [varchar](255) NULL,
	[SupervisorEmail] [varchar](255) NULL,
	[Comment] [varchar](255) NULL,
	[DepartamentosSuperiores] varchar(max) NULL,
	[DepartamentosInferiores] varchar(max) NULL,
 CONSTRAINT [aaaaaDepartment_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdDepartment] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Profile]') AND type in (N'U'))
BEGIN
CREATE TABLE [Profile](
	[IdProfile] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](255) NOT NULL,
 CONSTRAINT [aaaaaProfile_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdProfile] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UserShift]') AND type in (N'U'))
BEGIN
CREATE TABLE [UserShift](
	[UserShiftId] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NULL,
	[ShiftId] [int] NULL,
	[BeginDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [aaaaaUserShift_PK] PRIMARY KEY NONCLUSTERED 
(
	[UserShiftId] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[UserShift]') AND name = N'ShiftId')
CREATE NONCLUSTERED INDEX [ShiftId] ON [UserShift] 
(
	[ShiftId] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[UserShift]') AND name = N'UserShiftId')
CREATE NONCLUSTERED INDEX [UserShiftId] ON [UserShift] 
(
	[UserShiftId] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RecordAux]') AND type in (N'U'))
BEGIN
CREATE TABLE [RecordAux](
	[IdRecord] [int] IDENTITY(1,1) NOT NULL,
	[Operation] [int] NULL,
	[IdUser] [int] NOT NULL,
	[RecordTime] [datetime] NOT NULL,
	[RecordTimeAux] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [aaaaaRecordAux_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdUser] ASC,
	[RecordTime] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[RecordAux]') AND name = N'IdRecord')
CREATE NONCLUSTERED INDEX [IdRecord] ON [RecordAux] 
(
	[IdRecord] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[RecordAux]') AND name = N'RecordIdUser')
CREATE NONCLUSTERED INDEX [RecordIdUser] ON [RecordAux] 
(
	[IdUser] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RecordCuttingHour]') AND type in (N'U'))
BEGIN
CREATE TABLE [RecordCuttingHour](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NULL,
	[CuttingHour] [int] NULL,
	[CuttingMinute] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [aaaaaRecordCuttingHour_PK] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[RecordCuttingHour]') AND name = N'IdUser')
CREATE NONCLUSTERED INDEX [IdUser] ON [RecordCuttingHour] 
(
	[IdUser] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Shift]') AND type in (N'U'))
BEGIN
CREATE TABLE [Shift](
	[ShiftId] [int] IDENTITY(1,1) NOT NULL,
	[IdOdoo] [int] NOT NULL,
	[Description] [varchar](255) NULL,
	[Comment] [varchar](255) NULL,
	[CuttingHour] [int] NULL,
	[CuttingMinute] [int] NULL,
	[Cycle] [int] null,
 CONSTRAINT [aaaaaShift_PK] PRIMARY KEY NONCLUSTERED 
(
	[ShiftId] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShiftDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [ShiftDetail](
	[ShiftId] [int] NOT NULL,
	[DayId] [int] NOT NULL,
	[Description] [varchar](255) NULL,
	[Type] [int] NULL,
	[T1AttTime] [int] NULL,
	[T1OverTime1] [bit] NOT NULL,
	[T1OverTime1Minutes] [int] NULL,
	[T1OverTime1Factor] [int] NULL,
	[T1OverTime2] [bit] NOT NULL,
	[T1OverTime2Minutes] [int] NULL,
	[T1OverTime2Factor] [int] NULL,
	[T1OverTime3] [bit] NOT NULL,
	[T1OverTime3Minutes] [int] NULL,
	[T1OverTime3Factor] [int] NULL,
	[T1OverTime4] [bit] NOT NULL,
	[T1OverTime4Minutes] [int] NULL,
	[T1OverTime4Factor] [int] NULL,
	[T1OverTime5] [bit] NOT NULL,
	[T1OverTime5Minutes] [int] NULL,
	[T1OverTime5Factor] [int] NULL,
	[T1AccumulateOverTime] [bit] NOT NULL,
	[T1ValidateMinOverTime] [bit] NOT NULL,
	[T1MinOverTime] [int] NULL,
	[T2BeginOverTime] [bit] NOT NULL,
	[T2BeginOverTimeHour] [int] NULL,
	[T2BeginOverTimeMinute] [int] NULL,
	[T2BeginOverTimeFactor] [int] NULL,
	[T2ValidateMinBeginOverTime] [bit] NOT NULL,
	[T2MinBeginOverTime] [int] NULL,
	[T2InHour] [int] NULL,
	[T2InMinute] [int] NULL,
	[T2OutHour] [int] NULL,
	[T2OutMinute] [int] NULL,
	[T2EndOverTime1] [bit] NOT NULL,
	[T2OverTime1BeginHour] [int] NULL,
	[T2OverTime1BeginMinute] [int] NULL,
	[T2OverTime1EndHour] [int] NULL,
	[T2OverTime1EndMinute] [int] NULL,
	[T2OverTime1Factor] [int] NULL,
	[T2EndOverTime2] [bit] NOT NULL,
	[T2OverTime2BeginHour] [int] NULL,
	[T2OverTime2BeginMinute] [int] NULL,
	[T2OverTime2EndHour] [int] NULL,
	[T2OverTime2EndMinute] [int] NULL,
	[T2OverTime2Factor] [int] NULL,
	[T2EndOverTime3] [bit] NOT NULL,
	[T2OverTime3BeginHour] [int] NULL,
	[T2OverTime3BeginMinute] [int] NULL,
	[T2OverTime3EndHour] [int] NULL,
	[T2OverTime3EndMinute] [int] NULL,
	[T2OverTime3Factor] [int] NULL,
	[T2EndOverTime4] [bit] NOT NULL,
	[T2OverTime4BeginHour] [int] NULL,
	[T2OverTime4BeginMinute] [int] NULL,
	[T2OverTime4EndHour] [int] NULL,
	[T2OverTime4EndMinute] [int] NULL,
	[T2OverTime4Factor] [int] NULL,
	[T2EndOverTime5] [bit] NOT NULL,
	[T2OverTime5BeginHour] [int] NULL,
	[T2OverTime5BeginMinute] [int] NULL,
	[T2OverTime5EndHour] [int] NULL,
	[T2OverTime5EndMinute] [int] NULL,
	[T2OverTime5Factor] [int] NULL,
	[T2ValidateMinOverTime] [bit] NOT NULL,
	[T2MinOverTime] [int] NULL,
	[RestType] [int] NULL,
	[RT1Minute] [int] NULL,
	[RT1Max] [int] NULL,
	[RT21BeginHour] [int] NULL,
	[RT21BeginMinute] [int] NULL,
	[RT21EndHour] [int] NULL,
	[RT21EndMinute] [int] NULL,
	[RT22] [bit] NOT NULL,
	[RT22BeginHour] [int] NULL,
	[RT22BeginMinute] [int] NULL,
	[RT22EndHour] [int] NULL,
	[RT22EndMinute] [int] NULL,
	[RT23] [bit] NOT NULL,
	[RT23BeginHour] [int] NULL,
	[RT23BeginMinute] [int] NULL,
	[RT23EndHour] [int] NULL,
	[RT23EndMinute] [int] NULL,
	[RT2OverTime] [bit] NOT NULL,
	[RT2OverTimeFactor] [int] NULL,
	[RT2ValidateMinOverTime] [bit] NOT NULL,
	[RT2MinOverTime] [int] NULL,
	[AutoRestMinute] [int] NULL,
	LeastTimeAutoAssigned BIT default 0,
	PayExtraTimeOnBegin	BIT,
	PayExtraTimeOnEnd BIT,
	PayFactExtraTimeOnBegin INTEGER, 
	PayFactExtraTimeOnEnd INTEGER,
	ValidateExtraTimeOnBegin BIT,
	ValidateExtraTimeOnEnd BIT,
	MinExtraTimeOnBegin INTEGER, 
	MinExtraTimeOnEnd INTEGER,
 CONSTRAINT [aaaaaShiftDetail_PK] PRIMARY KEY NONCLUSTERED 
(
	[ShiftId] ASC,
	[DayId] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[ShiftDetail]') AND name = N'DayId')
CREATE NONCLUSTERED INDEX [DayId] ON [ShiftDetail] 
(
	[DayId] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[User]') AND type in (N'U'))
BEGIN
CREATE TABLE [User](
	[IdUser] [int] NOT NULL,
	[IdOdoo] [int] NOT NULL,
	[IdentificationNumber] [varchar](20) NULL,
	[Name] [varchar](250) NOT NULL,
	[Gender] [smallint] NULL,
	[Title] [varchar](100) NULL,
	[Birthday] [datetime] NULL,
	[PhoneNumber] [varchar](50) NULL,
	[MobileNumber] [varchar](50) NULL,
	[Address] [varchar](250) NULL,
	[ExternalReference] [varchar](50) NULL,
	[IdDepartment] [int] NOT NULL,
	[Position] [varchar](150) NULL,
	[Active] [smallint] NOT NULL,
	[Picture] varchar(max) NULL,
	[PictureOrientation] [smallint] NULL,
	[Privilege] [int] NOT NULL,
	[HourSalary] [decimal](10, 2) NOT NULL,
	[Password] [varchar](50) NULL,
	[PreferredIdLanguage] [smallint] NOT NULL,
	[Email] [varchar](200) NULL,
	[Comment] [varchar](200) NULL,
	[ProximityCard] [varchar](50) NULL,
	[LastRecord] [datetime] NULL,
	[LastLogin] [datetime] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDatetime] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedDatetime] [datetime] NOT NULL,
	[AdministratorType] [int] NULL,
	[IdProfile] [int] NULL,
	[DevPassword] [varchar](255) NULL,
	[UseShift] [bit] NOT NULL,
	SendSMS int NULL,
	SMSPhone varchar(50)  NULL,
	TemplateCode int NULL,	
	[ApplyExceptionPermition] [bit] NULL,
	[ExceptionPermitionBegin] [datetime] NULL,
	[ExceptionPermitionEnd] [datetime] NULL,
 CONSTRAINT [aaaaaUser_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdUser] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[User]') AND name = N'UserCreatedBy')
CREATE NONCLUSTERED INDEX [UserCreatedBy] ON [User] 
(
	[CreatedBy] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[User]') AND name = N'UserModifiedBy')
CREATE NONCLUSTERED INDEX [UserModifiedBy] ON [User] 
(
	[ModifiedBy] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ParameterName]') AND type in (N'U'))
BEGIN
CREATE TABLE [ParameterName](
	[IdParameter] [int] NOT NULL,
	[IdLanguage] [smallint] NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[Comment] [varchar](250) NULL,
 CONSTRAINT [aaaaaParameterName_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdParameter] ASC,
	[IdLanguage] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ProfileDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [ProfileDetail](
	[IdProfile] [int] NOT NULL,
	[IdRight] [int] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Device]') AND type in (N'U'))
BEGIN
CREATE TABLE [Device](
	[IdDevice] [int] IDENTITY(1,1) NOT NULL,
	[MachineNumber] [int] NOT NULL,
	[MachinePassword] [varchar](50) NULL,
	[Description] [varchar](250) NULL,
	[Comment] [varchar](250) NULL,
	[ConnectionType] [varchar](100) NOT NULL,
	[IP] [varchar](20) NULL,
	[PortNumber] [smallint] NULL,
	[SerialPort] [int] NULL,
	[BaudRate] [decimal](10, 2) NULL,
	[Type] [int] NOT NULL,
	[Connect] [bit] NOT NULL,
	[Synchronize] [bit] NOT NULL,
	[DownloadRecords] [bit] NOT NULL,
	[Attendance] [int] NULL,
 CONSTRAINT [aaaaaDevice_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdDevice] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UserFace]') AND type in (N'U'))
BEGIN
CREATE TABLE [UserFace](
	[IdUser] [int] NOT NULL,
	[FaceIndex] [varchar](255) NOT NULL,
	[FaceSize] [int] NULL,
	[FaceData] varchar(max) NULL,
	[VALID] [int] NULL,
	[RESERVE] [int] NULL,
	[ACTIVETIME] [int] NULL,
	[VFCOUNT] [int] NULL,
 CONSTRAINT [aaaaaUserFace_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdUser] ASC,
	[FaceIndex] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[UserFace]') AND name = N'UserUserFace')
CREATE NONCLUSTERED INDEX [UserUserFace] ON [UserFace] 
(
	[IdUser] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UserFingerprint]') AND type in (N'U'))
BEGIN
CREATE TABLE [UserFingerprint](
	[IdUser] [int] NOT NULL,
	[FingerNumber] [smallint] NOT NULL,
	[Version] [smallint] NOT NULL,
	[FingerPrintSize] [int] NULL,
	[FingerPrint] varchar(max) NULL,
 CONSTRAINT [aaaaaUserFingerprint_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdUser] ASC,
	[FingerNumber] ASC,
	[Version] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[UserFingerprint]') AND name = N'UserUserFingerprint')
CREATE NONCLUSTERED INDEX [UserUserFingerprint] ON [UserFingerprint] 
(
	[IdUser] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Record]') AND type in (N'U'))
BEGIN
CREATE TABLE [Record](
	[IdUser] [int] NOT NULL,
	[RecordTime] [datetime] NOT NULL,
	[MachineNumber] [int] NOT NULL,
	[RecordType] [int] NOT NULL,
	[VerifyMode] [int] NULL,
	[Workcode] [int] NOT NULL,
	[Comment] [varchar](250) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
 CONSTRAINT [aaaaaRecord_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdUser] ASC,
	[RecordTime] ASC,
	[RecordType] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Record]') AND name = N'RecordIdUser')
CREATE NONCLUSTERED INDEX [RecordIdUser] ON [Record] 
(
	[IdUser] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Record]') AND name = N'UserRecord')
CREATE NONCLUSTERED INDEX [UserRecord] ON [Record] 
(
	[IdUser] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[UserFace_FK00]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserFace]'))
ALTER TABLE [dbo].[UserFace]  WITH CHECK ADD  CONSTRAINT [UserFace_FK00] FOREIGN KEY([IdUser])
REFERENCES [User] ([IdUser])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[UserFingerprint_FK00]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserFingerprint]'))
ALTER TABLE [dbo].[UserFingerprint]  WITH CHECK ADD  CONSTRAINT [UserFingerprint_FK00] FOREIGN KEY([IdUser])
REFERENCES [User] ([IdUser])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[Record_FK00]') AND parent_object_id = OBJECT_ID(N'[dbo].[Record]'))
ALTER TABLE [dbo].[Record]  WITH CHECK ADD  CONSTRAINT [Record_FK00] FOREIGN KEY([IdUser])
REFERENCES [User] ([IdUser])

GO

CREATE TABLE [ACCZone1] ( [Id] int not null, [Name] varchar(100),[MondayStartTime] DATETIME, [MondayEndTime] DATETIME,[TuesdayStartTime] DATETIME, [TuesdayEndTime] DATETIME,[WednesdayStartTime] DATETIME, [WednesdayEndTime] DATETIME,[ThursdayStartTime] DATETIME, [ThursdayEndTime] DATETIME,[FridayStartTime] DATETIME, [FridayEndTime] DATETIME,[SaturdayStartTime] DATETIME, [SaturdayEndTime] DATETIME,[SundayStartTime] DATETIME, [SundayEndTime] DATETIME, [ModificationDate] DATETIME)
GO
ALTER TABLE ACCZone1 ADD CONSTRAINT PK_ACCZone1 PRIMARY KEY CLUSTERED (Id) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TABLE [ACCGroup] ( [Id] int not null, [Name] varchar(100), [ACCZone1] int,[ACCZone2] int,[ACCZone3] int,[ModificationDate] DATETIME)
GO
ALTER TABLE ACCGroup ADD CONSTRAINT PK_ACCGroup PRIMARY KEY CLUSTERED (Id) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TABLE [ACCComb] ( [Id] int not null, [Name] varchar(100), [ACCGroup1] int,[ACCGroup2] int,[ACCGroup3] int,[ACCGroup4] int,[ACCGroup5] int,[ACCGroup6] int,[ModificationDate] DATETIME)
GO
ALTER TABLE ACCComb ADD CONSTRAINT PK_ACCComb PRIMARY KEY CLUSTERED (Id) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TABLE [ACCUser] ( [UserId] int not null,[ACCGroup] int,[ACCZone1] int,[ACCZone2] int,[ACCZone3] int,[UseGroup] int,[ModificationDate] DATETIME)
GO
ALTER TABLE ACCUser ADD CONSTRAINT PK_ACCUser PRIMARY KEY CLUSTERED (UserId) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE name = 'Device_User' AND XTYPE = 'U')
	CREATE TABLE Device_User
	(
		IdUser		int not null,
		IdDevice	int not null,
		CONSTRAINT FK_User FOREIGN KEY (IdUser) REFERENCES [User] (IdUser),
		CONSTRAINT FK_Device FOREIGN KEY (IdDevice) REFERENCES [Device] (IdDevice)
	)
GO

IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE name = 'LeastTimeAutoAssign' AND XTYPE = 'U')
	CREATE TABLE LeastTimeAutoAssign
	(
		ShiftId				int,	
		DayId				int,
		InHour				int,
		InMinute			int,
		PreMinuteTime		int,
		PostMinuteTime		int,
		InTime				datetime,
		InPreTime			datetime,
		InPostTime			datetime,
		CutInHour			datetime,
		CutOutHour			datetime, 
		CONSTRAINT PK_LeastTimeAutoAssign PRIMARY KEY (ShiftId,DayId,InHour,InMinute),
		CONSTRAINT FK_ShiftDetail FOREIGN KEY (ShiftId,DayId) REFERENCES [ShiftDetail] (ShiftId,DayId)
	)
GO


IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'ShiftDetail' 
           AND  COLUMN_NAME = 'LeastTimeAutoAssigned')
BEGIN
	ALTER TABLE ShiftDetail ADD LeastTimeAutoAssigned BIT DEFAULT 'false'
END

insert into [dbo].[Department]([IdParent],[Description],[SupervisorName],[SupervisorEmail],[Comment]) values (null,N'Company',N'',N'',N'')

GO

insert into [dbo].[Device]([MachineNumber],[MachinePassword],[Description],[Comment],[ConnectionType],[IP],[PortNumber],[SerialPort],[BaudRate],[Type],[Connect],[Synchronize],[DownloadRecords],[Attendance]) values (1,N'',N'BioMetric Device',N'',N'0',N'192.168.1.201',4370,0,4.00,12,0,0,0,0)

GO

insert into [dbo].[Language]([IdLanguage],[Description],[Image]) values (0,N'Español',N'c:\es.jpg')
insert into [dbo].[Language]([IdLanguage],[Description],[Image]) values (1,N'English',N'c:\en.jpg')

GO

insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (0, 0, 'Acción Desconocida')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (0, 1, 'Unknown Action')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (1, 0, 'Ingreso al sistema')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (1, 1, 'System Login')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (2, 0, 'Cambio de Parámetros')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (2, 1, 'Change in Parameters')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (3, 0, 'Agregar Dispositivo')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (3, 1, 'Add Device')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (4, 0, 'Modificar Dispositivo')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (4, 1, 'Modify Device')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (5, 0, 'Borrar Dispositivo')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (5, 1, 'Delete Device')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (6, 0, 'Agregar Departamento')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (6, 1, 'Add Department')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (7, 0, 'Modificar Departamento')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (7, 1, 'Modify Department')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (8, 0, 'Borrar Departamento')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (8, 1, 'Delete Department')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (9, 0, 'Agregar Horario')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (9, 1, 'Add Shift')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (10, 0, 'Modificar Horario')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (10, 1, 'Modify Shift')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (11, 0, 'Borrar Horario')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (11, 1, 'Delete Shift')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (12, 0, 'Agregar Perfil')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (12, 1, 'Add Profile')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (13, 0, 'Modificar Perfil')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (13, 1, 'Modify Profile')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (14, 0, 'Borrar Perfil')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (14, 1, 'Delete Profile')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (15, 0, 'Agregar Usuario')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (15, 1, 'Add User')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (16, 0, 'Modificar Usuario')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (16, 1, 'Modify User')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (17, 0, 'Borrar Usuario')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (17, 1, 'Delete User')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (18, 0, 'Cambiar Departamento de Usuario')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (18, 1, 'Change User´s Department')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (19, 0, 'Importar Usuarios')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (19, 1, 'Import Users')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (20, 0, 'Exportar Usuarios')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (20, 1, 'Export Users')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (21, 0, 'Descargar Usuarios')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (21, 1, 'Download Users')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (22, 0, 'Cargar Usuarios')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (22, 1, 'Upload Users')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (23, 0, 'Borrar Usuarios del Dispositivo')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (23, 1, 'Delete Users from Device')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (24, 0, 'Importar Registros')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (24, 1, 'Import Records')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (25, 0, 'Exportar Registros')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (25, 1, 'Export Records')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (26, 0, 'Descargar Registros')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (26, 1, 'Download Records')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (27, 0, 'Sincronizar Dispositivo')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (27, 1, 'Synchronize Device')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (28, 0, 'Agregar Feriado')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (28, 1, 'Add Holiday')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (29, 0, 'Modificar Feriado')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (29, 1, 'Modify Holiday')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (30, 0, 'Borrar Feriado')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (30, 1, 'Delete Holiday')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (31, 0, 'Limpiar Datos')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (31, 1, 'Clear Data')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (32, 0, 'Actualizar Sistema')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (32, 1, 'System Update')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (33, 0, 'Cambiar Conexión de Base de Datos')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (33, 1, 'Change Database Connection')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (34, 0, 'Visualizar Reportes')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (34, 1, 'View Reports')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (35, 0, 'Salir del Sistema')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (35, 1, 'System Logout')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (36, 0, 'Agregar registro')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (36, 1, 'Add record')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (37, 0, 'Modificar registro')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (37, 1, 'Modify record')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (38, 0, 'Borrar registro')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (38, 1, 'Delete record')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (39, 0, 'Asignar horario')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (39, 1, 'Assign shift')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (40, 0, 'Modificar asignación de horario')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (40, 1, 'Modify shift assignment')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (41, 0, 'Borrar asignación de horario')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (41, 1, 'Delete shift assignment')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (42, 0, 'Abrir puerta')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (42, 1, 'Open Door')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (43, 0, 'Reiniciar Dispositivo')
insert into [dbo].[logaction](idLogAction,IdLanguage,Description) values (43, 1, 'Restart Device')

GO

insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (0,0)
insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (1,0)
insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (2,0)
insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (3,0)
insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (4,0)
insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (5,0)
insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (6,0)
insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (7,1)
insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (8,1)
insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (9,1)
insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (10,1)
insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (11,0)
insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (12,0)
insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (13,0)
insert into [ParameterCategory]([IdParameterCategory],[Hide]) values (14,0)
go
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (0, 0, 'Generales', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (0, 1, 'Main', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (1, 0, 'Tareas', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (1, 1, 'Tasks', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (2, 0, 'Cálculo de Salario', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (2, 1, 'Salary Calculation', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (3, 0, 'Columnas en los Reportes', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (3, 1, 'Report Columns', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (4, 0, 'Columnas en Marcas', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (4, 1, 'Record Columns', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (5, 0, 'Columnas en Resumen por día', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (5, 1, 'Columns in records by day', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (6, 0, 'Exportación Automática', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (6, 1, 'Automatic Export', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (7, 0, 'Plantillas de Reportes', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (7, 1, 'Report Templates', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (8, 0, 'Plantillas de Registros', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (8, 1, 'Record Templates', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (9, 0, 'Plantillas de Resumen por día', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (9, 1, 'Templates for records by day', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (10, 0, 'Parámetros de Configuración', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (10, 1, 'Configuration Parameters', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (11, 0, 'SMS', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (11, 1, 'SMS', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (12, 0, 'Correo Electrónico', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (12, 1, 'E-Mail', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (13, 0, 'ADMS Cloud', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (13, 1, 'ADMS Cloud', '')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (14, 0, 'Ordenamiento de disposivo','Se pueden ordenar los dispositivos por Nombre o Número de dispositivo')
insert into [ParameterCategoryName]([IdParameterCategory],[IdLanguage],[Description],[Comment]) values (14, 1, 'Devices ordering', '')
go
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (0,0,4,'1',N'Español,English,Ελληνικά,Portuguese')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1,0,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2,0,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3,0,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (120,0,0,'True',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4,1,2,'0',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (5,1,5,'00:00:00',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6,1,5,'00:00:00',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (10,2,0,'True',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (11,2,0,'True',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (12,2,0,'True',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (13,2,0,'True',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (200,6,5,'00:00:00',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (205,6,6,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (210,6,1,',',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (215,6,7,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (225,6,2,'1',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (300,6,5,'00:00:00',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (304,6,1,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (305,6,6,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (311,6,1,',',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (315,6,7,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (325,6,2,'1',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (10001,10,2,'1',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (10002,10,2,'41',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1000,0,4,'1','dd-MM-yy,dd-MM-yyyy,MM-dd-yy,MM-dd-yyyy,yy-MM-dd,yyyy-MM-dd')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1005,0,4,'0','/,-, ,NA')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1010,0,4,'1','HH:mm,HH:mm:ss,hh:mm tt,hh:mm:ss tt')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1015,0,4,'0',':')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1020,0,5,'00:00:00',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1030,0,2,'2',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1035,0,4,'1','.,COMMA')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1040,0,8,'<style type=''text/css'' > body {font-family:Tahoma, serifSansSerifMonospace; background-color: white; color:DimGray; } h1 { color: SteelBlue;  } h3 { color: LemonChiffon; } h4 { color: LemonChiffon; } h5 { color: DarkSlateGray; } table { background-color:black; color: black; font-size:small;} thead td{ background-color: SteelBlue } tfoot td{ background-color: SteelBlue } td { background-color: white; } .username td{ background-color: Gainsboro } .usertotal td{ font-weight:bold; background-color: Lavender } .deptname td{ background-color: Lavender } .depttotal td{ font-weight:bold; background-color: Gainsboro } .fila1 { background-color: Gainsboro } .fila2 { background-color: whitesmoke } </style>',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1050,0,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1900,3,4,'0','HH:mm,Decimal,Min,Sec')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1910,3,4,'0','Code,Id,Reference')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1920,3,4,'0','Date,Dept,Code,Name')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1925,3,4,'1','ASC,DESC')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1930,3,4,'1','Date,Dept,Code,Name')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1935,3,4,'0','ASC,DESC')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1940,3,4,'2','Date,Dept,Code,Name')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1945,3,4,'0','ASC,DESC')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2000,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2005,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2010,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2020,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2030,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2035,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2038,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2039,3,0,'True',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2040,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2050,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2060,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2070,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2080,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2090,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2100,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2110,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2120,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2130,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2140,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2150,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2160,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2170,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2180,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2190,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2200,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2210,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2220,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2230,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2240,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2250,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2260,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2270,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2280,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2290,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2300,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2305,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2320,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2330,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2335,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2350,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2360,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2370,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2380,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2390,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2400,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2410,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2420,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2430,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2440,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2450,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2460,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2470,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2471,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2472,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2473,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2474,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2475,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2480,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2490,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2500,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2505,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2510,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2520,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2530,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2540,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2550,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2558,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2560,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2570,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2580,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2590,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2600,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2603,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2613,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2610,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2620,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2630,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2640,3,1,'A',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2641,3,1,'T',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2642,3,1,'t',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2643,3,1,'E',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2644,3,1,'e',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2645,3,1,'o',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2646,3,1,'r',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2647,3,1,'O',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2648,3,1,'X',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3001,4,2,'1',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3010,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3011,4,2,'11',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3020,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3021,4,2,'2',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3030,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3031,4,2,'3',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3040,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3041,4,2,'5',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3050,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3051,4,2,'6',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3060,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3061,4,2,'7',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3070,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3071,4,2,'9',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3080,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3081,4,2,'12',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3090,4,0,'True',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3091,4,2,'8',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3100,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3101,4,2,'8',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3110,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3111,4,2,'10',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3120,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3121,4,2,'4',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3122,4,0,'True',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3130,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3131,4,2,'14',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3140,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3141,4,2,'16',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3150,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3151,4,2,'13',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3160,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3161,4,2,'15',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3170,1,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3171,1,9,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3172,1,2,'0',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3173,1,1,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4000,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4001,5,2,'5',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4011,5,2,'1',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4020,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4021,5,2,'26',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4030,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4031,5,2,'2',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4040,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4041,5,2,'3',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4050,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4051,5,2,'27',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4060,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4061,5,2,'6',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4070,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4071,5,2,'17',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4080,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4081,5,2,'18',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4090,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4091,5,2,'19',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4100,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4101,5,2,'20',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4110,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4111,5,2,'21',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4120,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4121,5,2,'22',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4130,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4131,5,2,'23',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4140,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4141,5,2,'24',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4150,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4151,5,4,'0','HH:mm,Decimal,Min')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4152,5,2,'7',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4160,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4161,5,4,'0','HH:mm,Decimal,Min')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4162,5,2,'9',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4170,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4171,5,4,'0','HH:mm,Decimal,Min')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4172,5,2,'11',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4180,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4181,5,4,'0','HH:mm,Decimal,Min')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4182,5,2,'13',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4190,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4191,5,4,'0','HH:mm,Decimal,Min')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4192,5,2,'8',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4200,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4201,5,4,'0','HH:mm,Decimal,Min')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4202,5,2,'10',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4210,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4211,5,4,'0','HH:mm,Decimal,Min')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4212,5,2,'12',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4220,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4221,5,4,'0','HH:mm,Decimal,Min')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4222,5,2,'14',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4230,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4231,5,4,'0','HH:mm,Decimal,Min')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4232,5,2,'15',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4240,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4241,5,4,'0','HH:mm,Decimal,Min')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4242,5,2,'16',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4250,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4252,5,2,'4',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4253,5,0,'True',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4260,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4262,5,2,'25',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4270,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4272,5,2,'28',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4280,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4282,5,2,'29',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (101,0,2,'0',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (5000,11,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (5001,11,4,'0','COM1,COM2,COM3,COM4,COM5,COM6,COM7,COM8,COM9,COM10,COM11,COM12,COM13,COM14,COM15,COM16,COM17,COM18')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (5002,11,4,'6','9600,19200,38400,57600,115200,230400,460800,921600')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (5003,11,4,'3','5,6,7,8')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (5004,11,4,'0','1,1.5,2')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (5005,11,4,'0','None,Even,Odd')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (5006,11,1,'{0} - {1} ha marcado',null)
go
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6000,12,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6001,12,1,'smtp.server.com',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6002,12,2,'25',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6003,12,1,'xx@yy.com',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6004,12,1,'123',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6005,12,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6006,12,1,'Notificación de Registro',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6007,12,1,'{0} - {1} ha marcado',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6008,12,1,'xx@yy.com',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6100,13,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6101,13,4,'0','SQL Server,My SQL')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6102,13,1,'localhost',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6103,13,2,'1433',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6104,13,1,'user',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6105,13,1,'password',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6106,13,1,'adms_db',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (6107,13,1,'',null)

insert into parameter(idParameter, idParameterCategory, DataType, [Value]) values (102,0,2,'0')
insert into parameter(idParameter, idParameterCategory, DataType, [Value]) values (103,0,2,'0')
insert into parameter(idParameter, idParameterCategory, DataType, [Value]) values (110,0,0,'False')
insert into parameter(idParameter, idParameterCategory, DataType, [Value]) values (115,0,0,'False')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (7001,7,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (7002,7,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (7003,7,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (7004,7,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (7005,7,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (8001,8,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (8002,8,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (8003,8,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (8004,8,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (8005,8,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (9001,9,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (9002,9,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (9003,9,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (9004,9,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (9005,9,8,'',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3999,14,4,'0','Nombre / Name / όνομα / Nome , Número / Number / Αριθμός / Número')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2011,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2012,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3022,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3023,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4032,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4033,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1051,0,1,10,null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1052,0,4,1,'V5,V7')
go

insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (0, 0, 'Idioma Predefinido', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (0, 1, 'Default Language', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1, 0, 'Iniciar Programa Automáticamente', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1, 1, 'Start Program automatically', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2, 0, 'Minimizar al iniciar programa', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2, 1, 'Minimize at start', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3, 0, 'Solicitar clave para cerrar programa', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3, 1, 'Request password to close program', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4, 0, '	Descargar registros automáticamente cada  (minutos, 0 = Manual )', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4, 1, 'Automatically download records every (minutes, 0 = Manually )', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5, 0, 'Sincronizar fecha/hora de los dispositivos a las (00:00 = Manual)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5, 1, 'Synchronyze device´s date/time at (00:00 = Manually)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6, 0, 'Descargar registros a las (00:00 = Manual)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6, 1, 'Download records at (00:00 = Manually)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (10, 0, 'Rebajar del salario las llegadas tardías de la hora de entrada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (10, 1, 'Deduct late check-in records from salary', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (11, 0, 'Rebajar del salario las llegadas tardías de recesos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (11, 1, 'Deduct late check-in break records from salary', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (12, 0, 'Rebajar del salario las salidas anticipadas', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (12, 1, 'Deduct early check-out records from salary', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (13, 0, 'Rebajar del salario los recesos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (13, 1, 'Deduct breaks from salary', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (200, 0, 'Exportar registros a las (00:00 = Manual)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (200, 1, 'Export records at (00:00 = Manually)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (205, 0, 'Archivo de Formato de exportación predeterminado', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (205, 1, 'Default export format file', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (210, 0, 'Separador para archivos exportados', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (210, 1, 'Export file separator', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (215, 0, 'Nombre archivo exportación', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (215, 1, 'Export file name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (225, 0, 'Días  a exportar', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (225, 1, 'Days to export', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1000, 0, 'Formato predeterminado para Fechas', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1000, 1, 'Default date format', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1005, 0, 'Separador para Fechas', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1005, 1, 'Date separator', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1010, 0, 'Formato predeterminado para Horas', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1010, 1, 'Default format for Hours', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1015, 0, 'Separador para Horas', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1015, 1, 'Hours separator', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1020, 0, 'Hora de Corte predeterminada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1020, 1, 'Default cut-off time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1025, 1, 'Default decimal positions', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1030, 0, 'Número de decimales predeterminado', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1035, 0, 'Separador de decimales', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1035, 1, 'Decimal separator', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1040, 0, 'Estilo para archivo html', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1040, 1, 'Style for html file', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1900, 0, 'Formato para Tiempos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1900, 1, 'Format for Times', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2000, 0, 'No Mostrar Nombre de Departamento', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2000, 1, 'Do Not Show Department Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2005, 0, 'No Mostrar Código del Usuario', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2005, 1, 'Do Not Show User Code', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2010, 0, 'No Mostrar Nombre de Empleado', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2010, 1, 'Do Not Show Employee Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2020, 0, 'No Mostrar Referencia', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2020, 1, 'Do Not Show Reference', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2030, 0, 'No Mostrar Número de Identificación', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2030, 1, 'Do Not Show Identification Number', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2035, 0, 'No Mostrar Fecha', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2035, 1, 'Do Not Show Date', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2038, 0, 'No Mostrar Día de la semana', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2038, 1, 'Do Not Show Day of the Week', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2040, 0, 'No Mostrar Nombre de Horario', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2040, 1, 'Do Not Show Shift´s Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2050, 0, 'No Mostrar Hora de Entrada del Horario', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2050, 1, 'Do Not Show Shift´s Check-in Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2060, 0, 'No Mostrar Hora de Salida del Horario', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2060, 1, 'Do Not Show Shift´s Check-out Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2070, 0, 'No Mostrar Hora de Entrada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2070, 1, 'Do Not Show Check-in Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2080, 0, 'No Mostrar Nombre del Día de Entrada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2080, 1, 'Do Not Show Name of In-Day', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2090, 0, 'No Mostrar Año de la Entrada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2090, 1, 'Do Not Show In-Year', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2100, 0, 'No Mostrar Mes de la Entrada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2100, 1, 'Do Not Show In-Month', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2110, 0, 'No Mostrar Fecha de Día de Entrada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2110, 1, 'Do Not Show In-Day´s Date', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2120, 0, 'No Mostrar Hora de Salida', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2120, 1, 'Do Not Show Check-out Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2130, 0, 'No Mostrar Nombre de Día de Salida', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2130, 1, 'Do Not Show Out-Day´s Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2140, 0, 'No Mostrar Año de la Salida', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2140, 1, 'Do Not Show Out-Year', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2150, 0, 'No Mostrar Mes de la Salida', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2150, 1, 'Do Not Show Out-Month', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2160, 0, 'No Mostrar Fecha de Día de Salida', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2160, 1, 'Do Not Show Out-Day´s Date', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2170, 0, 'No Mostrar Listado con todos los Registros', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2170, 1, 'Do Not Show Record List', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2180, 0, 'No Mostrar Registro 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2180, 1, 'Do Not Show Record 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2190, 0, 'No Mostrar Registro 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2190, 1, 'Do Not Show Record 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2200, 0, 'No Mostrar Registro 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2200, 1, 'Do Not Show Record 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2210, 0, 'No Mostrar Registro 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2210, 1, 'Do Not Show Record 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2220, 0, 'No Mostrar Registro 5', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2220, 1, 'Do Not Show Record 5', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2230, 0, 'No Mostrar Registro 6', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2230, 1, 'Do Not Show Record 6', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2240, 0, 'No Mostrar Registro 7', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2240, 1, 'Do Not Show Record 7', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2250, 0, 'No Mostrar Registro 8', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2250, 1, 'Do Not Show Record 8', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2260, 0, 'No Mostrar Número de Registros', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2260, 1, 'Do Not Show Number of Records', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2270, 0, 'No Mostrar Tiempo Regular', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2270, 1, 'Do Not Show Regular Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2280, 0, 'No Mostrar Salario Regular', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2280, 1, 'Do Not Show Regular Salary', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2290, 0, 'No Mostrar Tiempo Tarde a la Entrada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2290, 1, 'Do Not Show Late Check-In Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2300, 0, 'No Mostrar Tiempo tarde en recesos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2300, 1, 'Do Not Show Break Late Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2305, 0, 'No Mostrar Tiempo tarde', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2305, 1, 'Do Not Show Late Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2320, 0, 'No Mostrar Tiempo salidas anticipadas', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2320, 1, 'Do Not Show early check-out time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2330, 0, 'No Mostrar Tiempo salidas anticipadas (Recesos)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2330, 1, 'Do Not Show early check-out time (Breaks)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2335, 0, 'No Mostrar Tiempo salidas anticipadas', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2335, 1, 'Do Not Show early check-out time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2350, 0, 'No Mostrar Cantidad de recesos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2350, 1, 'Do Not Show number of breaks', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2360, 0, 'No Mostrar Tiempo total de recesos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2360, 1, 'Do Not Show total break time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2370, 0, 'No Mostrar Tiempo extra no pagado antes del inicio de la jornada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2370, 1, 'Do Not Show unpaid early overtime (before regular hours)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2380, 0, 'No Mostrar Tiempo extra pagado antes del inicio de la jornada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2380, 1, 'Do Not Show paid early overtime (before regular hours)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2390, 0, 'No Mostrar Pago de Tiempo extra antes del inicio de la jornada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2390, 1, 'Do Not Show early overtime payment (before regular hours)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2400, 0, 'No Mostrar Total de Tiempo extra antes de la jornada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2400, 1, 'Do Not Show total early overtime (before regular hours)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2410, 0, 'No Mostrar Tiempo extra no pagado después del fin de la jornada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2410, 1, 'Do Not Show unpaid late overtime (after regular hours)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2420, 0, 'No Mostrar Tiempo extra 1 pagado después del fin de la jornada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2420, 1, 'Do Not Show paid late overtime 1 (after regular hours)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2430, 0, 'No Mostrar Tiempo extra 2 pagado después del fin de la jornada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2430, 1, 'Do Not Show paid late overtime 2 (after regular hours)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2440, 0, 'No Mostrar Tiempo extra 3 pagado después del fin de la jornada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2440, 1, 'Do Not Show paid late overtime 3 (after regular hours)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2450, 0, 'No Mostrar Tiempo extra 4 pagado después del fin de la jornada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2450, 1, 'Do Not Show paid late overtime 4 (after regular hours)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2460, 0, 'No Mostrar Tiempo extra 5 pagado después del fin de la jornada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2460, 1, 'Do Not Show paid late overtime 5 (after regular hours)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2470, 0, 'No Mostrar Pago de Tiempo extra  después del fin de la jornada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2470, 1, 'Do Not Show late overtime payment (after regular hours)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2480, 0, 'No Mostrar Total de Tiempo extra después del fin de la jornada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2480, 1, 'Do Not Show total late overtime (after regular hours)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2490, 0, 'No Mostrar Tiempo extra no pagado de recesos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2490, 1, 'Do Not Show unpaid break overtime', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2500, 0, 'No Mostrar Tiempo extra pagado de recesos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2500, 1, 'Do Not Show paid break overtime', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2505, 0, 'No Mostrar Pago de Tiempo Extra Recesos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2505, 1, 'Do Not Show break overtime payment', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2510, 0, 'No Mostrar Total de Tiempo extra (Recesos)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2510, 1, 'Do Not Show Total overtime (Breaks)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2520, 0, 'No Mostrar Total de horas extras pagadas ', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2520, 1, 'Do Not Show Total paid overtime', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2530, 0, 'No Mostrar Total de horas extras no pagadas ', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2530, 1, 'Do Not Show Total unpaid overtime', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2540, 0, 'No Mostrar Total de horas extras ', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2540, 1, 'Do Not Show Total overtime', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2550, 0, 'No Mostrar Pago total de horas extras', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2550, 1, 'Do Not Show Total overtime payment', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2558, 0, 'No Mostrar descripción de Feriados/excepciones', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2558, 1, 'Do Not Show description of holidays/exceptions', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2560, 0, 'No Mostrar Tiempo Feriados/excepciones ', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2560, 1, 'Do Not Show Holidays/Exceptions Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2570, 0, 'No Mostrar Pago Feriados/Excepciones', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2570, 1, 'Do Not Show Holidays/Exceptions Payment', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2580, 0, 'No Mostrar Número de Ausencias', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2580, 1, 'Do Not Show Number of Absences', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2590, 0, 'No Mostrar Tiempo Total en la empresa', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2590, 1, 'Do Not Show Total Time at the company', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2600, 0, 'No Mostrar Tiempo Efectivo en la empresa', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2600, 1, 'Do Not Show Net Time Worked', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2610, 0, 'No Mostrar Porcentaje efectivo', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2610, 1, 'Do Not Show Percentage Time Worked', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2620, 0, 'No Mostrar Salario Total', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2620, 1, 'Do Not Show Total Salary', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3000, 0, 'No Mostrar Código', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3000, 1, 'Do Not Show User ID', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3001, 0, 'Orden para Código', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3001, 1, 'Order for User ID', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3010, 0, 'No Mostrar Número de Identificación', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3010, 1, 'Do Not Show Identification Number', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3011, 0, 'Orden para Número de Identificación', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3011, 1, 'Order for Identification Number', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3020, 0, 'No Mostrar Nombre', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3020, 1, 'Do Not Show Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3021, 0, 'Orden para Nombre', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3021, 1, 'Order for Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3030, 0, 'No Mostrar Departamento', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3030, 1, 'Do Not Show Department Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3031, 0, 'Orden para Departamento', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3031, 1, 'Order for Department Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3040, 0, 'No Mostrar Hora del Registro', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3040, 1, 'Do Not Show Record Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3041, 0, 'Orden para Hora del Registro', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3041, 1, 'Order for Record Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3050, 0, 'No Mostrar Tipo de Registro', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3050, 1, 'Do Not Show Record Type', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3051, 0, 'Orden para Tipo de Registro', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3051, 1, 'Order for Record Type', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3060, 0, 'No Mostrar Modo de Verificación', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3060, 1, 'Do Not Show Verification Mode', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3061, 0, 'Orden para Modo de Verificación', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3061, 1, 'Order for Verification Mode', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3070, 0, 'No Mostrar Código de Trabajo', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3070, 1, 'Do Not Show Work Code', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3071, 0, 'Orden para Código de Trabajo', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3071, 1, 'Order for Work Code', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3080, 0, 'No Mostrar Comentario', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3080, 1, 'Do Not Show Comment', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3081, 0, 'Orden para Comentario', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3081, 1, 'Order for Comment', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3090, 0, 'No Mostrar Número de Dispositivo', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3090, 1, 'Do Not Show Device Number', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3091, 0, 'Orden para Número de Dispositivo', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3091, 1, 'Order for Device Number', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3100, 0, 'No Mostrar Nombre de Dispositivo', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3100, 1, 'Do Not Show Device Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3101, 0, 'Orden para Nombre de Dispositivo', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3101, 1, 'Order for Device Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3110, 0, 'No Mostrar Referencia', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3110, 1, 'Do Not Show External Reference', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3111, 0, 'Orden para Referencia', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3111, 1, 'Order for External Reference', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3120, 0, 'No Mostrar Día de la semana', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3120, 1, 'Do Not Show Day of the Week', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3121, 0, 'Orden para Día de la semana', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3121, 1, 'Order for Day of the Week', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3130, 0, 'No Mostrar Fecha de Creación', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3130, 1, 'Do Not Show Creation Date', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3131, 0, 'Orden para Fecha de Creación', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3131, 1, 'Order for Creation Date', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3140, 0, 'No Mostrar Fecha de Modificación', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3140, 1, 'Do Not Show Modification Date', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3141, 0, 'Orden para Fecha Modificación', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3141, 1, 'Order for Modification Date', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3150, 0, 'No Mostrar Código de Creador', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3150, 1, 'Do Not Show Creator Code', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3151, 0, 'Orden para Código de Creador', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3151, 1, 'Order for Creator Code', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3160, 0, 'No Mostrar Código de Modificador', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3160, 1, 'Do Not Show Modifier Code', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3161, 0, 'Orden para Código de Modificador', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3161, 1, 'Order for Modifier Code', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4000, 0, 'No Mostrar Fecha', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4000, 1, 'Do Not Show Date', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4001, 0, 'Orden para Fecha', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4001, 1, 'Order for Date', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4010, 0, 'No Mostrar Código', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4010, 1, 'Do Not Show User ID', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4011, 0, 'Orden para Código', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4011, 1, 'Order for User ID', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4020, 0, 'No Mostrar Número de Identificación', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4020, 1, 'Do Not Show Identification Number', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4021, 0, 'Orden para Número de Identificación', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4021, 1, 'Order for Identification Number', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4030, 0, 'No Mostrar Nombre', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4030, 1, 'Do Not Show Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4031, 0, 'Orden para Nombre', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4031, 1, 'Order for Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4040, 0, 'No Mostrar Departamento', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4040, 1, 'Do Not Show Department Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4041, 0, 'Orden para Departamento', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4041, 1, 'Order for Department Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4050, 0, 'No Mostrar Referencia', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4050, 1, 'Do Not Show External Reference', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4051, 0, 'Orden para Referencia', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4051, 1, 'Order for External Reference', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4060, 0, 'No Mostrar Registros', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4060, 1, 'Do Not Show Records', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4061, 0, 'Orden para Registros', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4061, 1, 'Order for Records', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4070, 0, 'No Mostrar Registro 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4070, 1, 'Do Not Show Record 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4071, 0, 'Orden para Registro 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4071, 1, 'Order for Record 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4080, 0, 'No Mostrar Registro 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4080, 1, 'Do Not Show Record 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4081, 0, 'Orden para Registro 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4081, 1, 'Order for Record 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4090, 0, 'No Mostrar Registro 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4090, 1, 'Do Not Show Record 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4091, 0, 'Orden para Registro 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4091, 1, 'Order for Record 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4100, 0, 'No Mostrar Registro 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4100, 1, 'Do Not Show Record 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4101, 0, 'Orden para Registro 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4101, 1, 'Order for Record 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4110, 0, 'No Mostrar Registro 5', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4110, 1, 'Do Not Show Record 5', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4111, 0, 'Orden para Registro 5', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4111, 1, 'Order for Record 5', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4120, 0, 'No Mostrar Registro 6', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4120, 1, 'Do Not Show Record 6', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4121, 0, 'Orden para Registro 6', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4121, 1, 'Order for Record 6', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4130, 0, 'No Mostrar Registro 7', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4130, 1, 'Do Not Show Record 7', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4131, 0, 'Orden para Registro 7', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4131, 1, 'Order for Record 7', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4140, 0, 'No Mostrar Registro 8', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4140, 1, 'Do Not Show Record 8', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4141, 0, 'Orden para Registro 8', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4141, 1, 'Order for Record 8', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4150, 0, 'No Mostrar Tiempo 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4150, 1, 'Do Not Show Time 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4151, 0, 'Formato para Tiempo 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4151, 1, 'Format for Time 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4152, 0, 'Orden para Tiempo 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4152, 1, 'Order for Time 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4160, 0, 'No Mostrar Tiempo 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4160, 1, 'Do Not Show Time 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4161, 0, 'Formato para Tiempo 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4161, 1, 'Format for Time 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4162, 0, 'Orden para Tiempo 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4162, 1, 'Order for Time 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4170, 0, 'No Mostrar Tiempo 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4170, 1, 'Do Not Show Time 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4171, 0, 'Formato para Tiempo 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4171, 1, 'Format for Time 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4172, 0, 'Orden para Tiempo 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4172, 1, 'Order for Time 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4180, 0, 'No Mostrar Tiempo 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4180, 1, 'Do Not Show Time 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4181, 0, 'Formato para Tiempo 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4181, 1, 'Format for Time 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4182, 0, 'Orden para Tiempo 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4182, 1, 'Order for Time 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4190, 0, 'No Mostrar Descanso 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4190, 1, 'Do Not Show Break 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4191, 0, 'Formato para Descanso 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4191, 1, 'Format for Break 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4192, 0, 'Orden para Descanso 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4192, 1, 'Order for Break 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4200, 0, 'No Mostrar Descanso 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4200, 1, 'Do Not Show Break 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4201, 0, 'Formato para Descanso 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4201, 1, 'Format for Break 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4202, 0, 'Orden para Descanso 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4202, 1, 'Order for Break 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4210, 0, 'No Mostrar Descanso 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4210, 1, 'Do Not Show Break 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4211, 0, 'Formato para Descanso 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4211, 1, 'Format for Break 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4212, 0, 'Orden para Descanso 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4212, 1, 'Order for Break 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4220, 0, 'No Mostrar Tiempo de Trabajo', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4220, 1, 'Do Not Show Time Worked', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4221, 0, 'Formato para Tiempo de Trabajo', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4221, 1, 'Format for Time Worked', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4222, 0, 'Orden para Tiempo de Trabajo', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4222, 1, 'Order for Time Worked', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4230, 0, 'No Mostrar Tiempo Total Descanso', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4230, 1, 'Do Not Show Total Break Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4231, 0, 'Formato para Tiempo Total Descanso', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4231, 1, 'Format for Total Break Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4232, 0, 'Orden para Tiempo Total Descanso', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4232, 1, 'Order for Total Break Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4240, 0, 'No Mostrar Tiempo Total', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4240, 1, 'Do Not Show Total Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4241, 0, 'Formato para Tiempo Total', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4241, 1, 'Format for Total Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4242, 0, 'Orden para Tiempo Total', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4242, 1, 'Order for Total Time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4250, 0, 'No Mostrar Día de la semana', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4250, 1, 'Do Not Show Day of the Week', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4252, 0, 'Orden para Día de la Semana', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4252, 1, 'Order for Day of the Week', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4260, 0, 'No Mostrar Total de Registros', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4260, 1, 'Do Not Show Total Records', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4262, 0, 'Orden para Total de Registros', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4262, 1, 'Order for Total Records', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (10001, 0, 'Versión 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (10001, 1, 'Version 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (10002, 0, 'Versión 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (10002, 1, 'Version 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (120, 0, 'Permitir solamente una sesión de la aplicación abierta', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (120, 1, 'Only allow one session open', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1050, 0, 'Mostrar ficha de Control de Acceso', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1050, 1, 'Show Access Control section', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1910, 0, 'Mostrar como identificador', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1910, 1, 'Show as identifier', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1920, 0, '1ro Ordenar por', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1920, 1, '1st Order by', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1925, 0, '1er Tipo de Orden', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1925, 1, '1st Order Type', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1930, 0, '2do Ordenar por', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1930, 1, '2nd Order by', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1935, 0, '2do Tipo de Orden', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1935, 1, '2nd Order Type', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1940, 0, '3ro Ordenar por', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1940, 1, '3rd Order by', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1945, 0, '3er Tipo de Orden', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1945, 1, '3rd Order Type', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2039, 0, 'Mostrar Nombre del Día de la semana (Si no, muestra el número)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2039, 1, 'Show name for Day of the week (if not, show the number)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2471, 0, 'No Mostrar Pago de Tiempo extra 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2471, 1, 'Do Not Show late overtime 1 payment', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2472, 0, 'No Mostrar Pago de Tiempo extra 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2472, 1, 'Do Not Show late overtime 2 payment', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2473, 0, 'No Mostrar Pago de Tiempo extra 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2473, 1, 'Do Not Show late overtime 3 payment', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2474, 0, 'No Mostrar Pago de Tiempo extra 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2474, 1, 'Do Not Show late overtime 4 payment', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2475, 0, 'No Mostrar Pago de Tiempo extra 5', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2475, 1, 'Do Not Show late overtime 5 payment', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2603, 0, 'No Mostrar Tiempo Regular Trabajado', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2603, 1, 'Do Not Show Regular Time Worked', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2613, 0, 'No Mostrar Salario Regular Trabajado', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2613, 1, 'Do Not Show Salary for Regular Time Worked', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2630, 0, 'No Mostrar Exceso de Recesos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2630, 1, 'Do Not Show Excess Break time', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2640, 0, 'Abreviación para Ausencia', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2640, 1, 'Abbreviation for Absence', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2641, 0, 'Abreviación para Tardía a la Entrada', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2641, 1, 'Abbreviation for Late check-in', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2642, 0, 'Abreviación para Tardía del Receso', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2642, 1, 'Abbreviation for Late from break', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2643, 0, 'Abreviación para Salida Temprana', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2643, 1, 'Abbreviation for Early check-out', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2644, 0, 'Abreviación para Salida Temprana a Receso', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2644, 1, 'Abbreviation for early check-out to break', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2645, 0, 'Abreviación para Tiempo Extra al Inicio', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2645, 1, 'Abbreviation early overtime', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2646, 0, 'Abreviación para Tiempo Extra en Recesos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2646, 1, 'Abbreviation for break overtime', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2647, 0, 'Abreviación para Tiempo Extra a la Salida', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2647, 1, 'Abbreviation for late overtime', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2648, 0, 'Abreviación para Excepciones', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2648, 1, 'Abbreviation for Exceptions', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3122, 0, 'Mostrar Nombre del Día de la semana (Si no, muestra el número)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3122, 1, 'Show name for Day of the week (if not, show the number)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3170, 0, 'Respaldar y Borrar luego de descargar registros', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3170, 1, 'Back-up and Delete after downloading records', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3171, 0, 'Directorio para los respaldos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3171, 1, 'Back-up directory', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3172, 0, 'Borrar registros solo si sobrepasa (0= borrar siempre)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3172, 1, 'Delete records only if there are over (0= always erase)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3173, 0, 'Ejecutar tareas solo desde estas computadoras (IPs separadas por ;)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3173, 1, 'Execute tasks from these computers only (Ips separated by ;)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4253, 0, 'Mostrar Nombre del Día de la semana (Si no, muestra el número)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4253, 1, 'Show name of Day of the week (if not, show the number)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4270, 0, 'No Mostrar Primer Registro', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4270, 1, 'Do Not Show First Record', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4272, 0, 'Orden para Primer Registro', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4272, 1, 'Order for First Record', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4280, 0, 'No Mostrar Último Registro', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4280, 1, 'Do Not Show Last Record', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4282, 0, 'Orden para Último Registro', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4282, 1, 'Order for Last Record', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5000, 0, 'Enviar mensajes SMS a teléfonos móviles', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5000, 1, 'Send SMS messages to cellphones', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5001, 0, 'Puerto', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5001, 1, 'Port', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5002, 0, 'Velocidad', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5002, 1, 'BaudRate', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5003, 0, 'Bits de Datos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5003, 1, 'Data Bits', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5004, 0, 'Bits de detención', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5004, 1, 'Stop Bits', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5005, 0, 'Bits de paridad', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5005, 1, 'Parity Bits', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5006, 0, 'Mensaje SMS: use {0} para fecha y {1} para el nombre (en ese orden)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (5006, 1, 'SMS message: use {0} for the date and {1} for the name (in that order)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (101, 0, 'Tiempo Mínimo entre Registros (MIN)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (101, 1, 'Minimum time in between records (MIN)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (102, 0, 'Tiempo Mínimo para Tardías', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (102, 1, 'Minimum time to become late', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (103, 0, 'Tiempo Mínimo para Salidas Tempranas', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (103, 1, 'Minimum time for early check-out state', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (110, 0, 'Si día en horario cubre 2 días, contabilizar en el primer día', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (110, 1, 'If a workday covers 2 days, record it on the first day', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (115, 0, 'Ordenar listas de usuarios por código (si no, ordena por Nombre)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (115, 1, 'Order user list by code (if not, sort by Name)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (7001, 0, 'Reporte 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (7001, 1, 'Report 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (7002, 0, 'Reporte 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (7002, 1, 'Report 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (7003, 0, 'Reporte 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (7003, 1, 'Report 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (7004, 0, 'Reporte 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (7004, 1, 'Report 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (7005, 0, 'Reporte 5', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (7005, 1, 'Report 5', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (8001, 0, 'Reporte 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (8001, 1, 'Report 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (8002, 0, 'Reporte 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (8002, 1, 'Report 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (8003, 0, 'Reporte 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (8003, 1, 'Report 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (8004, 0, 'Reporte 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (8004, 1, 'Report 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (8005, 0, 'Reporte 5', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (8005, 1, 'Report 5', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (9001, 0, 'Reporte 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (9001, 1, 'Report 1', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (9002, 0, 'Reporte 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (9002, 1, 'Report 2', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (9003, 0, 'Reporte 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (9003, 1, 'Report 3', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (9004, 0, 'Reporte 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (9004, 1, 'Report 4', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (9005, 0, 'Reporte 5', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (9005, 1, 'Report 5', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (300, 0, 'Exportar reporte a las (00:00 = Manual)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (300, 1, 'Export report at (00:00 = Manually)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (305, 0, 'Archivo de Formato de exportación predeterminado', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (305, 1, 'Default export format file', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (311, 0, 'Separador para archivos exportados', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (311, 1, 'Export file separator', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (315, 0, 'Nombre archivo exportación', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (315, 1, 'Export file name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (325, 0, 'Días a exportar', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (325, 1, 'Days to export', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (304, 0, 'Exportar los días (Número del Día separado por coma; vacío = diario)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (304, 1, 'Export days (Day number separator is a comma; empty = everyday)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6000, 0, 'Enviar correos electrónicos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6000, 1, 'Send e-mails', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6001, 0, 'Servidor SMTP', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6001, 1, 'SMTP Server', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6002, 0, 'Puerto', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6002, 1, 'Port', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6003, 0, 'Usuario', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6003, 1, 'User', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6004, 0, 'Clave', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6004, 1, 'Password', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6005, 0, 'Usar SSL', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6005, 1, 'Use SSL', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6006, 0, 'Título del Correo electrónico: use {0} para fecha, {1} para el nombre y {2} para el nombre del dispositivo (en ese orden)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6006, 1, 'E-mail title: use {0} for the date, {1} for the name, and {2} for the device name (in that order)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6007, 0, 'Mensaje de correo electrónico: use {0} para fecha, {1} para el nombre y {2} para el nombre del dispositivo (en ese orden)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6007, 1, 'E-mail message: use {0} for the date, {1} for the name, and {2} for the device name (in that order)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6008, 0, 'Dirección de correo electrónico desde donde se envían los mensajes', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6008, 1, 'From E-mail address', '')
go
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6100, 0, 'Descargar registros de ADMS Cloud', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6100, 1, 'Download records from ADMS Cloud', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6101, 0, 'Tipo de Servidor de Base de Datos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6101, 1, 'Database server Type', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6102, 0, 'Servidor', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6102, 1, 'Server', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6103, 0, 'Puerto', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6103, 1, 'Port', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6104, 0, 'Usuario', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6104, 1, 'User', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6105, 0, 'Clave', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6105, 1, 'Password', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6106, 0, 'Nombre de la Base de Datos', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6106, 1, 'Database Name', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6107, 0, 'Tiempo de Espera de Conexión (Predeterminado=Blanco)', '')
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (6107, 1, 'Connection Timeout (Default=Blank)', '')


GO

insert into [dbo].[Profile]([Description]) values (N'ADM')

GO

insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,100)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10101)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10102)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10103)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10104)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,101)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,102)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,103)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,104)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10501)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10502)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10503)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10504)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10505)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10506)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10507)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10508)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10509)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10510)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10511)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10512)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,105)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10601)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10602)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10603)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10604)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10605)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10606)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,106)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10701)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10702)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,107)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,108)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10802)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10803)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10804)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,109)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,110)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,111)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,200)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,201)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,202)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,20)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,0)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,112)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10513)
insert into [dbo].[ProfileDetail]([IdProfile],[IdRight]) values (1,10514)

GO


insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 1, 'Z01' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 2, 'Z02' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 3, 'Z03' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 4, 'Z04' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 5, 'Z05' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 6, 'Z06' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 7, 'Z07' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 8, 'Z08' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 9, 'Z09' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 10, 'Z10' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 11, 'Z11' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 12, 'Z12' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 13, 'Z13' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 14, 'Z14' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 15, 'Z15' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 16, 'Z16' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 17, 'Z17' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 18, 'Z18' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 19, 'Z19' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 20, 'Z20' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 21, 'Z21' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 22, 'Z22' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 23, 'Z23' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 24, 'Z24' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 25, 'Z25' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 26, 'Z26' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 27, 'Z27' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 28, 'Z28' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 29, 'Z29' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 30, 'Z30' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 31, 'Z31' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 32, 'Z32' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 33, 'Z33' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 34, 'Z34' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 35, 'Z35' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 36, 'Z36' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 37, 'Z37' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 38, 'Z38' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 39, 'Z39' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 40, 'Z40' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 41, 'Z41' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 42, 'Z42' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 43, 'Z43' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 44, 'Z44' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 45, 'Z45' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 46, 'Z46' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 47, 'Z47' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 48, 'Z48' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 49, 'Z49' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 
insert into [ACCZone1] ( [Id] , [Name] ,[MondayStartTime] , [MondayEndTime] ,[TuesdayStartTime] , [TuesdayEndTime] ,[WednesdayStartTime] , [WednesdayEndTime] ,[ThursdayStartTime] , [ThursdayEndTime] ,[FridayStartTime] , [FridayEndTime] ,[SaturdayStartTime] , [SaturdayEndTime] ,[SundayStartTime] , [SundayEndTime] , [ModificationDate] )  values ( 50, 'Z50' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59' ,'00:00:00' , '23:59:59','00:00:00' , '23:59:59','00:00:00' , '23:59:59',getdate() ) 

GO

insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 1 , 'Grp01' , 1 ,0 ,0 ,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 2 , 'Grp02' , 0 ,0 ,0 ,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 3 , 'Grp03' , 0 ,0 ,0 ,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 4 , 'Grp04' , 0 ,0 ,0 ,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 5 , 'Grp05' , 0 ,0 ,0 ,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 6 , 'Grp06' , 0 ,0 ,0 ,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 7 , 'Grp07' , 0 ,0 ,0 ,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 8 , 'Grp08',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 9 , 'Grp09',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 10 , 'Grp10',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 11 , 'Grp11',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 12 , 'Grp12',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 13 , 'Grp13',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 14 , 'Grp14',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 15 , 'Grp15',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 16 , 'Grp16',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 17 , 'Grp17',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 18 , 'Grp18',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 19 , 'Grp19',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 20 , 'Grp20',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 21 , 'Grp21',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 22 , 'Grp22',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 23 , 'Grp23',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 24 , 'Grp24',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 25 , 'Grp25',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 26 , 'Grp26',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 27 , 'Grp27',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 28 , 'Grp28',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 29 , 'Grp29',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 30 , 'Grp30',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 31 , 'Grp31',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 32 , 'Grp32',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 33 , 'Grp33',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 34 , 'Grp34',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 35 , 'Grp35',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 36 , 'Grp36',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 37 , 'Grp37',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 38 , 'Grp38',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 39 , 'Grp39',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 40 , 'Grp40',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 41 , 'Grp41',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 42 , 'Grp42',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 43 , 'Grp43',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 44 , 'Grp44',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 45 , 'Grp45',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 46 , 'Grp46',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 47 , 'Grp47',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 48 , 'Grp48',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 49 , 'Grp49',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 50 , 'Grp50',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 51 , 'Grp51',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 52 , 'Grp52',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 53 , 'Grp53',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 54 , 'Grp54',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 55 , 'Grp55',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 56 , 'Grp56',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 57 , 'Grp57',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 58 , 'Grp58',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 59 , 'Grp59',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 60 , 'Grp60',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 61 , 'Grp61',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 62 , 'Grp62',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 63 , 'Grp63',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 64 , 'Grp64',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 65 , 'Grp65',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 66 , 'Grp66',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 67 , 'Grp67',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 68 , 'Grp68',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 69 , 'Grp69',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 70 , 'Grp70',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 71 , 'Grp71',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 72 , 'Grp72',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 73 , 'Grp73',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 74 , 'Grp74',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 75 , 'Grp75',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 76 , 'Grp76',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 77 , 'Grp77',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 78 , 'Grp78',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 79 , 'Grp79',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 80 , 'Grp80',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 81 , 'Grp81',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 82 , 'Grp82',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 83 , 'Grp83',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 84 , 'Grp84',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 85 , 'Grp85',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 86 , 'Grp86',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 87 , 'Grp87',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 88 , 'Grp88',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 89 , 'Grp89',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 90 , 'Grp90',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 91 , 'Grp91',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 92 , 'Grp92',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 93 , 'Grp93',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 94 , 'Grp94',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 95 , 'Grp95',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 96 , 'Grp96',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 97 , 'Grp97',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 98 , 'Grp98',0,0,0,getdate())
insert into [ACCGroup] ( [Id] , [Name] , [ACCZone1] ,[ACCZone2] ,[ACCZone3] ,[ModificationDate]) values ( 99 , 'Grp99',0,0,0,getdate())



GO

insert into [ACCComb] ( [Id] , [Name] , [ACCGroup1] ,[ACCGroup2] ,[ACCGroup3] ,[ACCGroup4] ,[ACCGroup5] ,[ACCGroup6] ,[ModificationDate] ) values ( 1 , 'Comb01' , 1 ,0 ,0 ,0 ,0 ,0 ,getdate() )
insert into [ACCComb] ( [Id] , [Name] , [ACCGroup1] ,[ACCGroup2] ,[ACCGroup3] ,[ACCGroup4] ,[ACCGroup5] ,[ACCGroup6] ,[ModificationDate] ) values ( 2 , 'Comb02' , 0 ,0 ,0 ,0 ,0 ,0 ,getdate() )
insert into [ACCComb] ( [Id] , [Name] , [ACCGroup1] ,[ACCGroup2] ,[ACCGroup3] ,[ACCGroup4] ,[ACCGroup5] ,[ACCGroup6] ,[ModificationDate] ) values ( 3 , 'Comb03' , 0 ,0 ,0 ,0 ,0 ,0 ,getdate() )
insert into [ACCComb] ( [Id] , [Name] , [ACCGroup1] ,[ACCGroup2] ,[ACCGroup3] ,[ACCGroup4] ,[ACCGroup5] ,[ACCGroup6] ,[ModificationDate] ) values ( 4 , 'Comb04' , 0 ,0 ,0 ,0 ,0 ,0 ,getdate() )
insert into [ACCComb] ( [Id] , [Name] , [ACCGroup1] ,[ACCGroup2] ,[ACCGroup3] ,[ACCGroup4] ,[ACCGroup5] ,[ACCGroup6] ,[ModificationDate] ) values ( 5 , 'Comb05' , 0 ,0 ,0 ,0 ,0 ,0 ,getdate() )
insert into [ACCComb] ( [Id] , [Name] , [ACCGroup1] ,[ACCGroup2] ,[ACCGroup3] ,[ACCGroup4] ,[ACCGroup5] ,[ACCGroup6] ,[ModificationDate] ) values ( 6 , 'Comb06' , 0 ,0 ,0 ,0 ,0 ,0 ,getdate() )
insert into [ACCComb] ( [Id] , [Name] , [ACCGroup1] ,[ACCGroup2] ,[ACCGroup3] ,[ACCGroup4] ,[ACCGroup5] ,[ACCGroup6] ,[ModificationDate] ) values ( 7 , 'Comb07' , 0 ,0 ,0 ,0 ,0 ,0 ,getdate() )
insert into [ACCComb] ( [Id] , [Name] , [ACCGroup1] ,[ACCGroup2] ,[ACCGroup3] ,[ACCGroup4] ,[ACCGroup5] ,[ACCGroup6] ,[ModificationDate] ) values ( 8 , 'Comb08' , 0 ,0 ,0 ,0 ,0 ,0 ,getdate() )
insert into [ACCComb] ( [Id] , [Name] , [ACCGroup1] ,[ACCGroup2] ,[ACCGroup3] ,[ACCGroup4] ,[ACCGroup5] ,[ACCGroup6] ,[ModificationDate] ) values ( 9 , 'Comb09' , 0 ,0 ,0 ,0 ,0 ,0 ,getdate() )
insert into [ACCComb] ( [Id] , [Name] , [ACCGroup1] ,[ACCGroup2] ,[ACCGroup3] ,[ACCGroup4] ,[ACCGroup5] ,[ACCGroup6] ,[ModificationDate] ) values ( 10 , 'Comb10' , 0 ,0 ,0 ,0 ,0 ,0 ,getdate() )

GO
--#12022014 I

IF OBJECT_ID (N'dbo.GetDayOfWeek', N'FN') IS NOT NULL
    DROP FUNCTION dbo.GetDayOfWeek;
GO

CREATE FUNCTION dbo.GetDayOfWeek(@initialDay datetime,@dayId int)
	RETURNS int
BEGIN
	declare @dow int
	SET @dow = DATEPART(dw,@initialDay)
	RETURN CASE @dow+@dayId
		WHEN 8	THEN 1
		WHEN 9	THEN 2
		WHEN 10 THEN 3
		WHEN 11 THEN 4
		WHEN 12 THEN 5
		WHEN 13 THEN 6
		ELSE @dow+@dayId END
END
GO

CREATE FUNCTION [dbo].[ArrayToTable] (@delimStr NVARCHAR(max))
RETURNS @StrValTable TABLE 
(-- Add the column definitions for the TABLE variable here
	StrVal int
)
AS
BEGIN
    -- Fill the table variable with the rows for your result set
    DECLARE @strlist NVARCHAR(max), @pos INT, @delim CHAR, @lstr NVARCHAR(max)
    SET @strlist = ISNULL(@delimStr,'')
    SET @delim = ','
    WHILE ((len(@strlist) > 0) and (@strlist <> ''))
    BEGIN
        SET @pos = charindex(@delim, @strlist)        
		IF @pos > 0
		   BEGIN
              SET @lstr = substring(@strlist, 1, @pos-1)
              SET @strlist = ltrim(substring(@strlist,charindex(@delim, @strlist)+1, 8000))
           END
        ELSE
		   BEGIN
              SET @lstr = @strlist
              SET @strlist = ''
           END
        INSERT @StrValTable VALUES (@lstr)
    END
        RETURN 
END
GO



CREATE PROCEDURE PRC_ANS_LEASTTIME_ABSENCE
	
	@varListaUsuarios		VARCHAR (MAX),
	@FechaMin				DATETIME,
	@FechaMax				DATETIME,
	@varListaDepartments	VARCHAR(MAX),
	@ShiftId				INT,
	@ExcepId				INT,
	@InRecord			datetime,
	@OutRecord			datetime
AS
	
BEGIN
	SELECT s8.IdUser,s8.ShiftId,s8.RecordTime,s8.INTime,OutTime,INTIMECORRECTION,OUTTIMECORRECTION,
	CASE WHEN (CASE WHEN (DATEDIFF(hh,RecordTime,INTIMECORRECTION) = 0) 
					THEN DATEDIFF(mi,RecordTime,INTIMECORRECTION)
					ELSE DATEDIFF(hh,RecordTime,INTIMECORRECTION) * 60 END) < 0
		 THEN 'ENTRADA TARDIA'
		 WHEN (CASE WHEN (DATEDIFF(hh,RecordTime,INTIMECORRECTION) = 0) 
					THEN DATEDIFF(mi,RecordTime,INTIMECORRECTION)
					ELSE DATEDIFF(hh,RecordTime,INTIMECORRECTION) * 60 end) > 0
		 THEN 'OK'
		 ELSE 'OK'
		 END AS MARCAJEENTRADA,
	(DATEDIFF(SECOND,
	CONVERT(DATETIME,(CAST(RecordTime AS float)-FLOOR(CAST(RecordTime AS float))) ),
	CONVERT(DATETIME,(CAST(INTIMECORRECTION AS float)-FLOOR(CAST(INTIMECORRECTION AS float))) ))) 
	AS DIFTIMEENTRADA,
		 CASE WHEN (CASE WHEN (DATEDIFF(hh,OUTTIMECORRECTION,RecordTime) = 0) 
					THEN DATEDIFF(mi,OUTTIMECORRECTION,RecordTime)
					ELSE DATEDIFF(MI,OUTTIMECORRECTION,RecordTime)  END) < 0
		 THEN 'SALIDA ANTICIPADA'
		 WHEN (CASE WHEN (DATEDIFF(hh,OUTTIMECORRECTION,RecordTime) = 0) 
					THEN DATEDIFF(MI,OUTTIMECORRECTION,RecordTime)
					ELSE DATEDIFF(MI,OUTTIMECORRECTION,RecordTime)  end) > 0
		 THEN 'OK'
		 ELSE 'OK'
		 END AS MARCAJESALIDA,
	(DATEDIFF(SECOND,
	CONVERT(DATETIME,(CAST(OUTTIMECORRECTION AS float)-FLOOR(CAST(OUTTIMECORRECTION AS float))) ),
	CONVERT(DATETIME,(CAST(RecordTime AS float)-FLOOR(CAST(RecordTime AS float))) ))) 
	AS DIFTIMESALIDA,
	s8.BeginDate,s8.EndDate,s8.DayId,s8.inhour,s8.inminute,s8.preminutetime,s8.postminutetime,
	s8.dayinweek,s8.InPreTime,s8.InPostTime,s8.IdException,s8.[Description],s8.BeginingDate,
	s8.EndingDate,OutPreTime,OutPostTime
	FROM
	(SELECT 	
	s7.IdUser,s7.ShiftId,s7.BeginDate,s7.EndDate,s7.DayId,s7.inhour,s7.inminute,s7.preminutetime,s7.postminutetime,
	s7.dayinweek,s7.RecordTime,s7.INTime,s7.InPreTime,s7.InPostTime,s7.IdException,s7.[Description],s7.BeginingDate,
	s7.EndingDate,OutTime,OutPreTime,OutPostTime,
	CASE WHEN 	
		(DATEPART(HH,InTime) BETWEEN DATEPART(HH,BeginingDate) AND DATEPART(HH,EndingDate))
		 THEN EndingDate			
		 ELSE INTime
		 END AS INTIMECORRECTION,
	CASE WHEN 	
		(DATEPART(HH,OutTime) BETWEEN DATEPART(HH,BeginingDate) AND DATEPART(HH,EndingDate))
		 THEN BeginingDate			
		 ELSE OutTime
		 END AS OUTTIMECORRECTION
	FROM
	(SELECT s5.IdUser,s5.ShiftId,s5.BeginDate,s5.EndDate,s5.DayId,s5.inhour,s5.inminute,s5.preminutetime,s5.postminutetime,
	s5.dayinweek,s5.RecordTime,s5.INTime,s5.InPreTime,s5.InPostTime,s7.IdException,s7.[Description],s7.BeginingDate,
	s7.EndingDate,OutTime,OutPreTime,OutPostTime
	FROM
	(
	SELECT s3.IdUser,s3.ShiftId,s3.BeginDate,s3.EndDate,s3.DayId,s3.inhour,s3.inminute,s3.preminutetime,s3.postminutetime,
	s3.dayinweek,s4.RecordTime,INTime,InPreTime,InPostTime,TiempoHorario, OutTime,OutPreTime,OutPostTime
	FROM
	(
	select s1.IdUser,s1.ShiftId,s1.BeginDate,s1.EndDate,s1.DayId,s2.inhour,s2.inminute,s2.preminutetime,s2.postminutetime,
	dbo.GetDayOfWeek(S1.BeginDate,s1.DayId) AS dayinweek,s2.INTime,s2.InPreTime,s2.InPostTime,TiempoHorario,
	DATEADD(MI,RT1Minute+AutoRestMinute,(DATEADD(MI,TiempoHorario,InTime))) as OutTime,
	DATEADD(mi,RT1Minute+AutoRestMinute,(DATEADD(mi,-1*preminutetime,DATEADD(MI,TiempoHorario,InTime)))) AS OutPreTime,
	DATEADD(mi,RT1Minute+AutoRestMinute,(DATEADD(mi,postminutetime,DATEADD(MI,TiempoHorario,InTime)))) AS OutPostTime 
	FROM
	(SELECT us.IdUser,us.ShiftId,us.BeginDate,us.EndDate,sd.T1AttTime AS TiempoHorario,DayId AS DayId,sd.RT1Minute,AutoRestMinute
	FROM UserShift us,ShiftDetail sd
	WHERE us.ShiftId = sd.ShiftId
	AND sd.ShiftId = @ShiftId
	AND sd.LeAStTimeAutoASsigned = 1
	AND us.IdUser IN (SELECT StrVal FROM ArrayToTable (@varListaUsuarios))
	AND (@FechaMin BETWEEN us.BeginDate AND us.EndDate
	OR @FechaMax BETWEEN us.BeginDate AND us.EndDate))s1,	
	(select ShiftId,DayId,InTime,InPreTime,InPostTime,InHour,InMinute,PreMinuteTime,PostMinuteTime FROM LeAStTimeAutoASsign where ShiftId = @ShiftId)s2	
	where s1.ShiftId = s2.shiftid
	AND s2.DayId = s1.DayId)s3,	
	(SELECT IdUser,RecordTime,DATEPART(dw,RecordTime) AS dayinweek FROM Record rc 
	WHERE rc.IdUser IN (SELECT StrVal FROM ArrayToTable (@varListaUsuarios))
	AND rc.RecordTime BETWEEN @InRecord AND @OutRecord 
	AND rc.RecordType NOT IN (2,3))s4	
	WHERE s3.IdUser = s4.IdUser 
	AND s3.dayinweek = s4.dayinweek
	AND s4.RecordTime BETWEEN s3.BeginDate AND s3.EndDate
	AND 
	(
		CONVERT(TIME,s4.RecordTime,108) BETWEEN CONVERT(TIME,s3.InPreTime,108) AND CONVERT(TIME,s3.InPostTime,108)
		OR CONVERT(TIME,s4.RecordTime,108) BETWEEN CONVERT(TIME,s3.OutPreTime,108) AND CONVERT(TIME,s3.OutPostTime,108)
	)
	)s5 
	LEFT JOIN
	(SELECT IdException,BeginingDate,EndingDate,[Description] FROM Exception 
	WHERE  IdUser IN (SELECT StrVal FROM ArrayToTable(@varListaUsuarios))
	OR IdDepartment IN (SELECT StrVal FROM ArrayToTable(@varListaDepartments)))s7 	
	ON
	(s5.InTime BETWEEN s7.BeginingDate AND s7.EndingDate))s7)s8
END	

--#12022014 F
-- #07052014 I

--insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (104,10,0,'False','')
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2011,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2012,3,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3022,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3023,4,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4032,5,0,'False',null)
insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (4033,5,0,'False',null)

go
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2011 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2011, 0, N'No Mostrar E-mail de Empleado', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2011 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2011, 1, N'Do Not Show Employee E-mail', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2012 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2012, 0, N'No Mostrar Puesto de Empleado', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2012 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2012, 1, N'Do Not Show Employee Position', '')


IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3022 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3022, 0,N'No Mostrar E-mail de Empleado', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3022 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3022, 1,N'Do Not Show Employee E-mail', '')

IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3023 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3023, 0, N'No Mostrar Puesto de Empleado', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3023 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3023, 1, N'Do Not Show Employee Position', '')


IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 4032 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4032, 0, N'No Mostrar E-mail de Empleado', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 4032 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4032, 1, N'Do Not Show Employee E-mail', '')

IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 4033 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4033, 0, N'No Mostrar Puesto de Empleado', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 4033 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4033, 1, N'Do Not Show Employee Position', '')

IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 1051 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1051,0,N'Tiempo de apertura de la cerradura',null)
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 1051 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1051,1,N'Lock opening delay',null)
GO
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 1052 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1052,0,N'Utilizar caras ',null)
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 1052 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1052,1,N'Use face template ',null)
-- #07052014 F
-- #12022014 I
-- Greek / Griego / Ελληνικά
IF NOT EXISTS (SELECT [IdLanguage] FROM [Language] WHERE [IdLanguage] = 2 AND [Description] = N'Ελληνικά') INSERT INTO [Language] ([IdLanguage],[Description],[Image]) VALUES (2,N'Ελληνικά','c:\el.jpg')
go
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 0 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (0,2,N'Άγνωστη ενέργεια')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 1 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (1,2,N'Είσοδος στο σύστημα')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 2 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (2,2,N'Αλλαγή παραμέτρων')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 3 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (3,2,N'Προσθήκη συσκευής')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 4 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (4,2,N'Τροποποίηση συσκευής')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 5 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (5,2,N'Διαγραφή συσκευής')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 6 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (6,2,N'Προσθήκη τμήματος')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 7 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (7,2,N'Τροποποίηση τμήματος')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 8 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (8,2,N'Διαγραφή τμήματος')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 9 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (9,2,N'Προσθήκη βάρδιας')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 10 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (10,2,N'Τροποποίηση βάρδιας')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 11 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (11,2,N'Διαγραφή βάρδιας')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 12 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (12,2,N'Προσθήκη προφίλ')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 13 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (13,2,N'Τροποποίηση προφίλ')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 14 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (14,2,N'Διαγραφή προφίλ')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 15 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (15,2,N'Προσθήκη χρήστη')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 16 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (16,2,N'Τροποποίηση χρήστη')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 17 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (17,2,N'Διαγραφή χρήστη')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 18 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (18,2,N'Αλλαγή τμήματος χρήστη')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 19 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (19,2,N'Εισαγωγή χρηστών')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 20 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (20,2,N'Εξαγωγή χρηστών')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 21 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (21,2,N'Λήψη χρηστών')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 22 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (22,2,N'Μεταφόρτωση χρηστών')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 23 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (23,2,N'Διαγραφή χρηστών από τη συσκευή')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 24 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (24,2,N'Εισαγωγή εγγραφών')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 25 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (25,2,N'Εξαγωγή εγγραφών')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 26 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (26,2,N'Λήψη εγγραφών')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 27 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (27,2,N'Συγχρονισμός συσκευής')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 28 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (28,2,N'Προσθήκη αργίας')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 29 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (29,2,N'Τροποποίηση αργίας')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 30 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (30,2,N'Διαγραφή αργίας')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 31 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (31,2,N'Διαγραφή δεδομένων')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 32 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (32,2,N'Ενημέρωση συστήματος')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 33 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (33,2,N'Αλλαγή σύνδεσης βάσης δεδομένων')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 34 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (34,2,N'Εμφάνιση αναφορών')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 35 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (35,2,N'Έξοδος από το σύστημα')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 36 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (36,2,N'Προσθήκη εγγραφής')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 37 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (37,2,N'Τροποποίηση εγγραφής')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 38 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (38,2,N'Διαγραφή εγγραφής')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 39 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (39,2,N'Ανάθεση βάρδιας')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 40 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (40,2,N'Τροποποίηση ανάθεσης βάρδιας')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 41 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (41,2,N'Διαγραφή ανάθεσης βάρδιας')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 42 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (42,2,N'Άνοιγμα πόρτας')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 43 and IdLanguage = 2) insert into LogAction (IdLogAction,IdLanguage,Description) Values (43,2,N'Επανεκκίνηση συσκευής')

IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 0 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (0,2,N'Κύριες',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 1 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (1,2,N'Εργασίες',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 2 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (2,2,N'Υπολογισμός μισθού',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 3 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (3,2,N'Στήλες αναφορών',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 4 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (4,2,N'Στήλες εγγραφών',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 5 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (5,2,N'Στήλες σε εγγραφές ανά ημέρα',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 6 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (6,2,N'Αυτόματη εξαγωγή',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 7 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (7,2,N'Πρότυπα αναφορών',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 8 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (8,2,N'Πρότυπα εγγραφών',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 9 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (9,2,N'Πρότυπα για εγγραφές ανά ημέρα',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 10 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (10,2,N'Παράμετροι ρύθμισης',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 11 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (11,2,N'SMS',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 12 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (12,2,N'E-mail',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 13 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (13,2,N'ADMS Cloud',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 14 and [IdLanguage] = 2) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (14,2,N'	',N'')
go

IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =0 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (0,2,N'Αρχική γλώσσα',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1,2,N'Αυτόματη εκκίνηση του προγράμματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2,2,N'Ελαχιστοποίηση κατά την εκκίνηση',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3,2,N'Κλείσιμο προγράμματος με κωδικό',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4,2,N'Αυτόματη λήψη εγγραφών κάθε (λεπτά, 0 = χειροκίνητα)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5,2,N'Συγχρονισμός ημερομηνίας/ώρας συσκευής σε (00:00 = χειροκίνητα)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6,2,N'Λήψη εγγραφών σε (00:00 = χειροκίνητα)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =10 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (10,2,N'Αφαίρεση εγγραφών με καθυστέρηση άφιξης από τον μισθό',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =11 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (11,2,N'Αφαίρεση εγγραφών με καθυστέρηση άφιξης από διάλειμμα από τον μισθό',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =12 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (12,2,N'Αφαίρεση εγγραφών με νωρίτερη αποχώρηση από τον μισθό',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =13 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (13,2,N'Αφαίρεση διαλειμμάτων από τον μισθό',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =200 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (200,2,N'Εξαγωγή αρχείων σε (00:00 = χειροκίνητα)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =205 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (205,2,N'Αρχικός τύπος αρχείου εξαγωγής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =210 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (210,2,N'Διαχωριστής αρχείου εξαγωγής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =215 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (215,2,N'Όνομα αρχείου εξαγωγής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =225 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (225,2,N'Ημέρες για την εξαγωγή',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1000 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1000,2,N'Αρχική μορφή ημερομηνίας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1005 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1005,2,N'Διαχωριστής ημερομηνίας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1010 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1010,2,N'Αρχική μορφή ώρας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1015 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1015,2,N'Διαχωριστής ωρών',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1020 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1020,2,N'Αρχική καταληκτική ώρα',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1030 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1030,2,N'Αρχικά δεκαδικά ψηφία',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1035 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1035,2,N'Διαχωριστής δεκαδικών',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1040 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1040,2,N'Στυλ αρχείου html',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1900 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1900,2,N'Μορφή ωρών',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2000 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2000,2,N'εμφανίζεται το όνομα του τμήματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2005 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2005,2,N'εμφανίζεται ο κωδικός χρήστη',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2010 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2010,2,N'εμφανίζεται το όνομα του χρήστη',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2020 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2020,2,N'εμφανίζεται η αναφορά',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2030 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2030,2,N'εμφανίζεται ο αριθμός αναγνώρισης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2035 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2035,2,N'εμφανίζεται η ημερομηνία',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2038 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2038,2,N'εμφανίζεται η ημέρα της εβδομάδας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2040 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2040,2,N'εμφανίζεται το όνομα της βάρδιας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2050 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2050,2,N'εμφανίζεται η ώρα άφιξης στη βάρδια',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2060 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2060,2,N'εμφανίζεται η ώρα αποχώρησης από τη βάρδια',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2070 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2070,2,N'εμφανίζεται η ώρα άφιξης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2080 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2080,2,N'εμφανίζεται το όνομα της ημέρας εισόδου',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2090 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2090,2,N'εμφανίζεται το έτος εισόδου',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2100 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2100,2,N'εμφανίζεται ο μήνας εισόδου',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2110 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2110,2,N'εμφανίζεται η ημερομηνία της ημέρας εισόδου',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2120 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2120,2,N'εμφανίζεται η ώρα αποχώρησης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2130 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2130,2,N'εμφανίζεται το όνομα της ημέρας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2140 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2140,2,N'εμφανίζεται το έτος εξόδου',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2150 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2150,2,N'εμφανίζεται ο μήνας εξόδου',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2160 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2160,2,N'εμφανίζεται η ημερομηνία της ημέρας εξόδου',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2170 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2170,2,N'εμφανίζεται η λίστα εγγραφών',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2180 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2180,2,N'εμφανίζεται η εγγραφή 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2190 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2190,2,N'εμφανίζεται η εγγραφή 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2200 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2200,2,N'εμφανίζεται η εγγραφή 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2210 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2210,2,N'εμφανίζεται η εγγραφή 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2220 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2220,2,N'εμφανίζεται η εγγραφή 5',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2230 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2230,2,N'εμφανίζεται η εγγραφή 6',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2240 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2240,2,N'εμφανίζεται η εγγραφή 7',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2250 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2250,2,N'εμφανίζεται η εγγραφή 8',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2260 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2260,2,N'εμφανίζεται ο αριθμός των εγγραφών',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2270 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2270,2,N'εμφανίζεται ο κανονικός χρόνος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2280 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2280,2,N'εμφανίζεται ο κανονικός μισθός',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2290 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2290,2,N'εμφανίζεται ο χρόνος αργοπορημένης άφιξης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2300 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2300,2,N'εμφανίζεται ο χρόνος αργοπορημένου διαλείμματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2305 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2305,2,N'εμφανίζεται ο χρόνος καθυστέρησης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2320 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2320,2,N'εμφανίζεται ο χρόνος νωρίτερης αποχώρησης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2330 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2330,2,N'εμφανίζεται ο χρόνος νωρίτερης αποχώρησης (διαλείμματα)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2335 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2335,2,N'εμφανίζεται ο χρόνος νωρίτερης αποχώρησης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2350 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2350,2,N'εμφανίζεται ο αριθμός των διαλειμμάτων',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2360 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2360,2,N'εμφανίζεται ο συνολικός χρόνος διαλείμματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2370 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2370,2,N'εμφανίζεται απλήρωτη υπερωρία (πριν το ωράριο)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2380 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2380,2,N'εμφανίζεται πληρωμένη υπερωρία (πριν το ωράριο)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2390 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2390,2,N'εμφανίζεται πληρωμή υπερωρίας (πριν το ωράριο)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2400 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2400,2,N'εμφανίζεται η συνολική υπερωρία (πριν το ωράριο)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2410 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2410,2,N'εμφανίζεται απλήρωτη υπερωρία (μετά το ωράριο)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2420 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2420,2,N'εμφανίζεται πληρωμένη υπερωρία 1 (μετά το ωράριο)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2430 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2430,2,N'εμφανίζεται πληρωμένη υπερωρία 2 (μετά το ωράριο)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2440 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2440,2,N'εμφανίζεται πληρωμένη υπερωρία 3 (μετά το ωράριο)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2450 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2450,2,N'εμφανίζεται πληρωμένη υπερωρία 4 (μετά το ωράριο)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2460 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2460,2,N'εμφανίζεται πληρωμένη υπερωρία 5 (μετά το ωράριο)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2470 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2470,2,N'εμφανίζεται η πληρωμή υπερωρίας (μετά το ωράριο)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2480 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2480,2,N'εμφανίζεται η συνολική υπερωρία (μετά το ωράριο)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2490 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2490,2,N'εμφανίζεται η απλήρωτη υπερωρία διαλείμματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2500 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2500,2,N'εμφανίζεται η πληρωμένη υπερωρία διαλείμματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2505 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2505,2,N'εμφανίζεται η πληρωμή υπερωρίας διαλείμματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2510 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2510,2,N'εμφανίζεται η συνολική υπερωρία (διαλείμματα)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2520 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2520,2,N'εμφανίζεται η συνολική πληρωμένη υπερωρία',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2530 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2530,2,N'εμφανίζεται η συνολική απλήρωτη υπερωρία',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2540 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2540,2,N'εμφανίζεται η συνολική υπερωρία',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2550 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2550,2,N'εμφανίζεται η συνολική πληρωμή υπερωρίας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2558 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2558,2,N'Να μην εμφανίζονται περιγραφές αργιών/εξαιρέσεων',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2560 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2560,2,N'εμφανίζεται ο χρόνος αργιών/εξαιρέσεων',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2570 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2570,2,N'εμφανίζεται η πληρωμή αργιών/εξαιρέσεων',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2580 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2580,2,N'εμφανίζεται ο αριθμός των απουσιών',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2590 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2590,2,N'εμφανίζεται ο συνολικός χρόνος στην εταιρεία',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2600 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2600,2,N'εμφανίζεται ο καθαρός χρόνος εργασίας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2610 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2610,2,N'εμφανίζεται το ποσοστό του χρόνου εργασίας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2620 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2620,2,N'εμφανίζεται ο συνολικός μισθός',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3000 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3000,2,N'εμφανίζεται ο αριθμός αναγνώρισης χρήστη',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3001 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3001,2,N'Σειρά για αριθμό αναγνώρισης χρήστη',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3010 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3010,2,N'εμφανίζεται ο αριθμός αναγνώρισης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3011 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3011,2,N'Σειρά για αριθμό αναγνώρισης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3020 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3020,2,N'εμφανίζεται το όνομα',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3021 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3021,2,N'Σειρά για όνομα',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3030 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3030,2,N'εμφανίζεται το όνομα του τμήματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3031 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3031,2,N'Σειρά για όνομα τμήματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3040 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3040,2,N'εμφανίζεται ο χρόνος εγγραφής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3041 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3041,2,N'Σειρά για τον χρόνο εγγραφής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3050 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3050,2,N'εμφανίζεται ο τύπος εγγραφής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3051 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3051,2,N'Σειρά για τον τύπο εγγραφής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3060 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3060,2,N'εμφανίζεται ο τρόπος επαλήθευσης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3061 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3061,2,N'Σειρά για τον τρόπο επαλήθευσης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3070 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3070,2,N'εμφανίζεται ο κωδικός εργασίας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3071 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3071,2,N'Σειρά για κωδικό εργασίας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3080 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3080,2,N'εμφανίζεται σχόλιο',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3081 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3081,2,N'Σειρά για σχόλιο',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3090 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3090,2,N'εμφανίζεται ο αριθμός συσκευής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3091 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3091,2,N'Σειρά για αριθμό συσκευής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3100 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3100,2,N'εμφανίζεται το όνομα της συσκευής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3101 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3101,2,N'Σειρά για όνομα συσκευής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3110 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3110,2,N'εμφανίζεται η εξωτερική αναφορά',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3111 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3111,2,N'Σειρά για εξωτερική αναφορά',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3120 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3120,2,N'εμφανίζεται η ημέρα της εβδομάδας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3121 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3121,2,N'Σειρά για την ημέρα της εβδομάδας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3130 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3130,2,N'εμφανίζεται η ημερομηνία δημιουργίας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3131 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3131,2,N'Σειρά για ημερομηνία δημιουργίας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3140 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3140,2,N'εμφανίζεται η ημερομηνία τροποποίησης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3141 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3141,2,N'Σειρά για ημερομηνία τροποποίησης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3150 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3150,2,N'εμφανίζεται ο κωδικός δημιουργού',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3151 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3151,2,N'Σειρά για κωδικό δημιουργού',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3160 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3160,2,N'εμφανίζεται ο κωδικός τρoποποιητή',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3161 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3161,2,N'Σειρά για κωδικό τροποποιητή',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4000 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4000,2,N'εμφανίζεται η ημερομηνία',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4001 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4001,2,N'Σειρά για την ημερομηνία',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4010 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4010,2,N'εμφανίζεται ο αριθμός αναγνώρισης χρήστη',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4011 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4011,2,N'Σειρά για αριθμό αναγνώρισης χρήστη',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4020 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4020,2,N'εμφανίζεται ο αριθμός αναγνώρισης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4021 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4021,2,N'Σειρά για αριθμό αναγνώρισης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4030 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4030,2,N'εμφανίζεται το όνομα',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4031 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4031,2,N'Σειρά για όνομα',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4040 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4040,2,N'εμφανίζεται το όνομα του τμήματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4041 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4041,2,N'Σειρά για όνομα τμήματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4050 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4050,2,N'εμφανίζεται η εξωτερική αναφορά',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4051 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4051,2,N'Σειρά για εξωτερική αναφορά',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4060 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4060,2,N'Να μην εμφανίζονται εγγραφές',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4061 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4061,2,N'Σειρά εγγραφών',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4070 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4070,2,N'εμφανίζεται η εγγραφή 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4071 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4071,2,N'Σειρά εγγραφής 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4080 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4080,2,N'εμφανίζεται η εγγραφή 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4081 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4081,2,N'Σειρά εγγραφής 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4090 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4090,2,N'εμφανίζεται η εγγραφή 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4091 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4091,2,N'Σειρά εγγραφής 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4100 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4100,2,N'εμφανίζεται η εγγραφή 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4101 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4101,2,N'Σειρά εγγραφής 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4110 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4110,2,N'εμφανίζεται η εγγραφή 5',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4111 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4111,2,N'Σειρά εγγραφής 5',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4120 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4120,2,N'εμφανίζεται η εγγραφή 6',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4121 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4121,2,N'Σειρά εγγραφής 6',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4130 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4130,2,N'εμφανίζεται η εγγραφή 7',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4131 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4131,2,N'Σειρά εγγραφής 7',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4140 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4140,2,N'εμφανίζεται η εγγραφή 8',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4141 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4141,2,N'Σειρά εγγραφής 8',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4150 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4150,2,N'εμφανίζεται ο χρόνος 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4151 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4151,2,N'Μορφή χρόνου 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4152 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4152,2,N'Σειρά χρόνου 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4160 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4160,2,N'εμφανίζεται ο χρόνος 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4161 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4161,2,N'Μορφή χρόνου 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4162 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4162,2,N'Σειρά χρόνου 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4170 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4170,2,N'εμφανίζεται ο χρόνος 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4171 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4171,2,N'Μορφή χρόνου 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4172 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4172,2,N'Σειρά χρόνου 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4180 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4180,2,N'εμφανίζεται ο χρόνος 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4181 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4181,2,N'Μορφή χρόνου 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4182 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4182,2,N'Σειρά χρόνου 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4190 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4190,2,N'εμφανίζεται το διάλειμμα 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4191 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4191,2,N'Μορφή διαλείμματος 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4192 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4192,2,N'Σειρά διαλείμματος 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4200 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4200,2,N'εμφανίζεται το διάλειμμα 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4201 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4201,2,N'Μορφή διαλείμματος 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4202 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4202,2,N'Σειρά διαλείμματος 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4210 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4210,2,N'εμφανίζεται το διάλειμμα 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4211 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4211,2,N'Μορφή διαλείμματος 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4212 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4212,2,N'Σειρά διαλείμματος 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4220 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4220,2,N'εμφανίζεται ο δεδουλευμένος χρόνος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4221 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4221,2,N'Μορφή δεδουλευμένου χρόνου',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4222 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4222,2,N'Σειρά δεδουλευμένου χρόνου',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4230 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4230,2,N'εμφανίζεται ο συνολικός χρόνος διαλείμματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4231 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4231,2,N'Μορφή συνολικού χρόνου διαλείμματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4232 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4232,2,N'Σειρά συνολικού χρόνου διαλείμματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4240 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4240,2,N'εμφανίζεται ο συνολικός χρόνος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4241 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4241,2,N'Μορφή συνολικού χρόνου',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4242 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4242,2,N'Σειρά συνολικού χρόνου',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4250 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4250,2,N'εμφανίζεται η ημέρα της εβδομάδας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4252 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4252,2,N'Σειρά για ημέρα της εβδομάδας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4260 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4260,2,N'Να μην εμφανίζονται οι συνολικές εγγραφές',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4262 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4262,2,N'Σειρά για συνολικές εγγραφές',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =10001 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (10001,2,N'Έκδοση 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =10002 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (10002,2,N'Έκδοση 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =120 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (120,2,N'Να επιτρέπεται μόνο μία συνεδρία ανοιχτή',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1050 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1050,2,N'Εμφάνιση τμήματος ελέγχου πρόσβασης',N'')

IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1910 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1910,2,N'Εμφάνιση ως αναγνωριστικού',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1920 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1920,2,N'1η σειρά ανά',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1925 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1925,2,N'1ος τύπος σειράς',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1930 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1930,2,N'2η σειρά ανά',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1935 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1935,2,N'2ος τύπος σειράς',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1940 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1940,2,N'3η σειρά ανά',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1945 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1945,2,N'3ος τύπος σειράς',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2039 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2039,2,N'Εμφάνιση ονόματος ημέρας εβδομάδας (αν όχι, εμφάνιση αριθμού)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2471 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2471,2,N'εμφανίζεται πληρωμή υπερωρίας 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2472 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2472,2,N'εμφανίζεται πληρωμή υπερωρίας 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2473 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2473,2,N'εμφανίζεται πληρωμή υπερωρίας 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2474 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2474,2,N'εμφανίζεται πληρωμή υπερωρίας 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2475 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2475,2,N'εμφανίζεται πληρωμή υπερωρίας 5',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2603 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2603,2,N'εμφανίζεται ο κανονικός χρόνος εργασίας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2613 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2613,2,N'εμφανίζεται ο μισθός για τον κανονικό χρόνο εργασίας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2630 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2630,2,N'εμφανίζεται η υπέρβαση του χρόνου διαλείμματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2640 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2640,2,N'Συντομογραφία για απουσία',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2641 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2641,2,N'Συντομογραφία για καθυστέρηση άφιξης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2642 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2642,2,N'Συντομογραφία για καθυστέρηση διαλείμματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2643 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2643,2,N'Συντομογραφία για αποχώρηση νωρίτερα',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2644 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2644,2,N'Συντομογραφία για νωρίτερη διακοπή για διάλειμμα',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2645 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2645,2,N'Συντομογραφία για άφιξη νωρίτερα',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2646 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2646,2,N'Συντομογραφία για υπερωρία διαλείμματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2647 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2647,2,N'Συντομογραφία για υπερωρία',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2648 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2648,2,N'Συντομογραφία για εξαιρέσεις',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3122 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3122,2,N'Εμφάνιση ονόματος ημέρας εβδομάδας (αν όχι, εμφάνιση αριθμού)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3170 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3170,2,N'Αντίγραφο ασφαλείας και διαγραφή μετά τη λήψη αρχείων',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3171 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3171,2,N'Θέση αντιγράφου ασφαλείας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3172 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3172,2,N'Διαγραφή εγγραφών μόνο αν υπερβαίνουν (0= διαγραφή πάντα)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3173 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3173,2,N'Εκτέλεση εργασιών μόνο από αυτούς τους υπολογιστές (διευθύνσεις IP διαχωρισμένες με ;)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4253 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4253,2,N'Εμφάνιση ονόματος ημέρας εβδομάδας (αν όχι, εμφάνιση αριθμού)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4270 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4270,2,N'εμφανίζεται η πρώτη εγγραφή',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4272 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4272,2,N'Σειρά για την πρώτη εγγραφή',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4280 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4280,2,N'εμφανίζεται η τελευταία εγγραφή',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4282 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4282,2,N'Σειρά για την τελευταία εγγραφή',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5000 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5000,2,N'Αποστολή μηνυμάτων SMS σε κινητά',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5001 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5001,2,N'Θύρα',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5002 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5002,2,N'Ταχύτητα',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5003 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5003,2,N'Bit δεδομένων',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5004 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5004,2,N'Bit σταματήματος',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5005 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5005,2,N'Bit ισοτιμίας',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5006 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5006,2,N'Μήνυμα SMS: χρησιμοποιήστε {0} για την ημερομηνία και {1} για το όνομα (με αυτή τη σειρά)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =101 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (101,2,N'Ελάχιστος χρόνος ανάμεσα στις εγγραφές (ΛΕΠΤΑ)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =102 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (102,2,N'Ελάχιστος χρόνος για ορισμό καθυστέρησης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =103 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (103,2,N'Ελάχιστος χρόνος για ορισμό νωρίτερης αποχώρησης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =110 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (110,2,N'Αν μια εργάσιμη καλύπτει 2 ημέρες, να εγγραφεί την πρώτη ημέρα',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =115 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (115,2,N'Κλήση λίστας χρηστών ανά κωδικό (αν όχι, ταξινόμηση ανά όνομα)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =7001 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (7001,2,N'Αναφορά 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =7002 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (7002,2,N'Αναφορά 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =7003 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (7003,2,N'Αναφορά 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =7004 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (7004,2,N'Αναφορά 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =7005 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (7005,2,N'Αναφορά 5',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =8001 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (8001,2,N'Αναφορά 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =8002 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (8002,2,N'Αναφορά 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =8003 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (8003,2,N'Αναφορά 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =8004 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (8004,2,N'Αναφορά 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =8005 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (8005,2,N'Αναφορά 5',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =9001 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (9001,2,N'Αναφορά 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =9002 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (9002,2,N'Αναφορά 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =9003 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (9003,2,N'Αναφορά 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =9004 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (9004,2,N'Αναφορά 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =9005 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (9005,2,N'Αναφορά 5',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =300 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (300,2,N'Εξαγωγή αναφοράς στις (00:00 = χειροκίνητα)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =305 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (305,2,N'Αρχική μορφή αρχείου εξαγωγής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =311 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (311,2,N'Διαχωριστής αρχείου εξαγωγής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =315 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (315,2,N'Όνομα αρχείου εξαγωγής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =325 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (325,2,N'Ημέρες για εξαγωγή',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =304 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (304,2,N'Ημέρες εξαγωγής (Διαχωριστικό του αριθμού ημέρας είναι το κόμμα. Άδειο = καθημερινά)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6000 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6000,2,N'Αποστολή e-mail',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6001 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6001,2,N'Εξυπηρετητής SMTP',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6002 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6002,2,N'Θύρα',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6003 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6003,2,N'Χρήστης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6004 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6004,2,N'Κωδικός',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6005 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6005,2,N'Χρήση SSL',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6006 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6006,2,N'Τίτλος e-mail: χρήση {0} για την ημερομηνία, {1} για το όνομα και {2} για το όνομα της συσκευής (με αυτή τη σειρά)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6007 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6007,2,N'Μήνυμα e-mail: χρήση {0} για την ημερομηνία, {1} για το όνομα και {2} για το όνομα της συσκευής (με αυτή τη σειρά)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6008 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6008,2,N'Από τη διεύθυνση e-mail',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6100 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6100,2,N'Λήψη αρχείων από το ADMS Cloud',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6101 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6101,2,N'Τύπος εξυπηρετητή βάσης δεδομένων',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6102 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6102,2,N'Εξυπηρετητής',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6103 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6103,2,N'Θύρα',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6104 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6104,2,N'Χρήστης',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6105 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6105,2,N'Κωδικός',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6106 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6106,2,N'Όνομα βάσης δεδομένων',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6107 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6107,2,N'Λήξη χρόνου σύνδεσης (Αρχική ρύθμιση = κενό)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3999 AND IdLanguage = 2) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3999,2,N'Κλήση συσκευών ανά όνομα',N'')
go
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2011 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2011,2,N'Εμφάνιση email Υπαλλήλου',N'')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2012 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2012,2,N'δείξει τη θέση Υπαλλήλου',N'')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3022 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3022,2,N'Εμφάνιση email Υπαλλήλου',N'')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3023 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3023,2,N'δείξει τη θέση Υπαλλήλου',N'')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 4032 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4032,2,N'Εμφάνιση email Υπαλλήλου',N'')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 4033 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4033,2,N'δείξει τη θέση Υπαλλήλου',N'')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 1051 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1051,2,N'Ανοιχτό καθυστέρηση κλειδαριά',N'')

IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 1052 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1052,2,N'Πρότυπο πρόσωπο ',null)
-- #12022014 F

-- Portuguese
IF NOT EXISTS (SELECT [IdLanguage] FROM [Language] WHERE [IdLanguage] = 3 AND [Description] = 'Portuguese') INSERT INTO [Language] ([IdLanguage],[Description],[Image]) VALUES (3,N'Portuguese','c:\pt.jpg')

IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 0 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (0,3,N'Ação Desconhecida')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 1 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (1,3,N'Login no Sistema')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 2 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (2,3,N'Alteração de Parâmetros')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 3 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (3,3,N'Adicionar Dispositivo')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 4 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (4,3,N'Modificar Dispositivo')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 5 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (5,3,N'Eliminar Dispositivo')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 6 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (6,3,N'Adicionar Departamento')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 7 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (7,3,N'Modificar Departamento')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 8 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (8,3,N'Eliminar Departamento')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 9 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (9,3,N'Adicionar Horário')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 10 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (10,3,N'Modificar Horário')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 11 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (11,3,N'Eliminar Horário')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 12 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (12,3,N'Adicionar Perfil')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 13 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (13,3,N'Modificar Perfil')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 14 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (14,3,N'Eliminar Perfil')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 15 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (15,3,N'Adicionar Utilizador')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 16 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (16,3,N'Modificar Utilizador')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 17 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (17,3,N'Eliminar Utilizador')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 18 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (18,3,N'Alterar Departamento de Utilizador')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 19 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (19,3,N'Importar Utilizadores')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 20 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (20,3,N'Exportar Utilizadores')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 21 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (21,3,N'Download Utilizadores')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 22 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (22,3,N'Upload Utilizadores')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 23 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (23,3,N'Eliminar Utilizadores do Dispositivo')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 24 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (24,3,N'Importar Registos')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 25 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (25,3,N'Exportar Registos')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 26 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (26,3,N'Download Registos')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 27 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (27,3,N'Sincronizar Dispositivo')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 28 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (28,3,N'Adicionar Feriado')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 29 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (29,3,N'Modificar Feriado')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 30 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (30,3,N'Eliminar Feriado')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 31 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (31,3,N'Limpar Dados')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 32 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (32,3,N'Atualizar Sistema')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 33 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (33,3,N'Alterar Ligação da Base de Dados')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 34 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (34,3,N'Visualizar Relatórios')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 35 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (35,3,N'Sair do Sistema')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 36 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (36,3,N'Adicionar registo')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 37 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (37,3,N'Modificar registo')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 38 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (38,3,N'Eliminar registo')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 39 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (39,3,N'Atribuir horário')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 40 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (40,3,N'Modificar atribuição de horário')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 41 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (41,3,N'Eliminar atribuição de horário')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 42 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (42,3,N'Abrir porta')
IF NOT EXISTS (Select idLogAction from [logaction] where idLogAction = 43 and IdLanguage = 3) insert into LogAction (IdLogAction,IdLanguage,Description) Values (43,3,N'Reiniciar Dispositivo')
go
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 0 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (0,3,N'Gerais',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 1 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (1,3,N'Tarefas',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 2 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (2,3,N'Cálculo do Salário',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 3 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (3,3,N'Colunas do Relatório',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 4 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (4,3,N'Colunas do Registo',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 5 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (5,3,N'Colunas nos registos por dia',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 6 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (6,3,N'Exportação Automática',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 7 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (7,3,N'Templates de Relatório',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 8 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (8,3,N'Templates de Registo',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 9 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (9,3,N'Templates de Registos por dia',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 10 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (10,3,N'Parâmetros de Configuração',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 11 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (11,3,N'SMS',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 12 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (12,3,N'Correio Eletrónico',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 13 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (13,3,N'ADMS Cloud',N'')
IF NOT EXISTS (SELECT IdParameterCategory FROM ParameterCategoryName WHERE IdParameterCategory = 14 and [IdLanguage] = 3) insert into ParameterCategoryName ([IdParameterCategory],[IdLanguage],[Description],[Comment]) VALUES (14,3,N'Ordenamento do dispositivo',N'')

IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =0 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (0,3,N'Idioma Predefinido',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1,3,N'Iniciar Programa Automaticamente',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2,3,N'Minimizar ao iniciar programa',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3,3,N'Solicitar palavra-passe para fechar o programa',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4,3,N'Download registos automaticamente cada (minutos, 0 = Manual)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5,3,N'Sincronizar data/hora dos dispositivos às (00:00 = Manual)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6,3,N'Download registos às (00:00 = Manual)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =10 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (10,3,N'Deduzir do salário os atrasos registados à entrada',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =11 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (11,3,N'Deduzir do salário os atrasos registados das pausas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =12 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (12,3,N'Deduzir do salário as saídas antecipadas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =13 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (13,3,N'Deduzir do salário as pausas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =200 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (200,3,N'Exportar registos às (00:00 = Manual)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =205 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (205,3,N'Arquivo de Formato de exportação predefinido',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =210 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (210,3,N'Separador para arquivos exportados',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =215 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (215,3,N'Nome arquivo exportação',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =225 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (225,3,N'Dias a exportar',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1000 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1000,3,N'Formato predefinido para Datas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1005 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1005,3,N'Separador para Datas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1010 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1010,3,N'Formato predefinido para Horas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1015 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1015,3,N'Separador para Horas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1020 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1020,3,N'Hora de Corte predefinido',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1030 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1030,3,N'Número de decimais predefinido',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1035 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1035,3,N'Separador de decimais',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1040 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1040,3,N'Estilo para arquivo html',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1900 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1900,3,N'Formato para Tempos',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2000 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2000,3,N'Não Mostrar Nome do Departamento',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2005 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2005,3,N'Não Mostrar Código do Utilizador',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2010 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2010,3,N'Não Mostrar Nome do Empregado',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2020 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2020,3,N'Não Mostrar Referência',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2030 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2030,3,N'Não Mostrar Número de Identificação',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2035 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2035,3,N'Não Mostrar Data',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2038 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2038,3,N'Não Mostrar Dia da semana',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2040 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2040,3,N'Não Mostrar Nome do Horário',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2050 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2050,3,N'Não Mostrar Hora de Entrada no Horário',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2060 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2060,3,N'Não Mostrar Hora de Saída no Horário',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2070 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2070,3,N'Não Mostrar Hora de Entrada',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2080 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2080,3,N'Não Mostrar Nome do Dia de Entrada',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2090 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2090,3,N'Não Mostrar Ano de Entrada',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2100 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2100,3,N'Não Mostrar Mês de Entrada',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2110 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2110,3,N'Não Mostrar Data do Dia de Entrada',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2120 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2120,3,N'Não Mostrar Hora de Saída',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2130 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2130,3,N'Não Mostrar Nome do Dia de Saída',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2140 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2140,3,N'Não Mostrar Ano de Saída',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2150 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2150,3,N'Não Mostrar Mês de Saída',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2160 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2160,3,N'Não Mostrar Data do Dia de Saída',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2170 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2170,3,N'Não Mostrar Listagem com os Registos',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2180 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2180,3,N'Não Mostrar Registo 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2190 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2190,3,N'Não Mostrar Registo 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2200 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2200,3,N'Não Mostrar Registo 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2210 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2210,3,N'Não Mostrar Registo 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2220 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2220,3,N'Não Mostrar Registo 5',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2230 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2230,3,N'Não Mostrar Registo 6',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2240 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2240,3,N'Não Mostrar Registo 7',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2250 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2250,3,N'Não Mostrar Registo 8',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2260 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2260,3,N'Não Mostrar Número de Registos',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2270 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2270,3,N'Não Mostrar Hora Regular',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2280 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2280,3,N'Não Mostrar Salário Regular',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2290 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2290,3,N'Não Mostrar Atraso na Hora de Entrada',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2300 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2300,3,N'Não Mostrar Atrasos no Regresso da Pausa',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2305 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2305,3,N'Não Mostrar Atraso',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2320 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2320,3,N'Não Mostrar Hora de saídas antecipadas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2330 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2330,3,N'Não Mostrar Hora de saídas antecipadas (pausas)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2335 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2335,3,N'Não Mostrar Hora de saídas antecipadas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2350 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2350,3,N'Não Mostrar número de pausas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2360 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2360,3,N'Não Mostrar total de horas de pausa',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2370 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2370,3,N'Não Mostrar horas extraordinárias não remuneradas ao início do horário normal de trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2380 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2380,3,N'Não Mostrar horas extraordinárias remuneradas ao início do horário normal de trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2390 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2390,3,N'Não Mostrar remuneração das horas extraordinárias ao início do horário normal de trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2400 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2400,3,N'Não Mostrar total de horas extraordinárias ao início do horário normal de trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2410 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2410,3,N'Não Mostrar horas extraordinárias não remuneradas ao fim do horário normal de trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2420 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2420,3,N'Não Mostrar horas extraordinárias 1 remuneradas ao fim do horário normal de trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2430 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2430,3,N'Não Mostrar horas extraordinárias 2 remuneradas ao fim do horário normal de trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2440 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2440,3,N'Não Mostrar horas extraordinárias 3 remuneradas ao fim do horário normal de trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2450 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2450,3,N'Não Mostrar horas extraordinárias 4 remuneradas ao fim do horário normal de trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2460 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2460,3,N'Não Mostrar horas extraordinárias 5 remuneradas ao fim do horário normal de trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2470 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2470,3,N'Não Mostrar remuneração de horas extraordinárias ao fim do horário normal de trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2480 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2480,3,N'Não Mostrar total de horas extraordinárias ao fim do horário normal de trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2490 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2490,3,N'Não Mostrar horas extraordinárias não remuneradas de pausas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2500 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2500,3,N'Não Mostrar horas extraordinárias remuneradas de pausas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2505 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2505,3,N'Não Mostrar Remuneração de horas extraordinárias de pausas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2510 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2510,3,N'Não Mostrar Total de horas extraordinárias (Pausas)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2520 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2520,3,N'Não Mostrar Total de horas extraordinárias remuneradas ',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2530 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2530,3,N'Não Mostrar Total de horas extraordinárias não remuneradas ',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2540 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2540,3,N'Não Mostrar Total de horas extraordinárias ',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2550 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2550,3,N'Não Mostrar Remuneração total de horas extraordinárias',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2558 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2558,3,N'Não Mostrar descrição de Feriados/exceções',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2560 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2560,3,N'Não Mostrar Tempo Feriados/exceções ',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2570 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2570,3,N'Não Mostrar Remuneração Feriados/Exceções',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2580 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2580,3,N'Não Mostrar Número de Ausências',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2590 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2590,3,N'Não Mostrar Tempo Total na empresa',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2600 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2600,3,N'Não Mostrar Tempo Efetivo na empresa',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2610 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2610,3,N'Não Mostrar Percentagem efetiva',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2620 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2620,3,N'Não Mostrar Salário Total',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3000 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3000,3,N'Não Mostrar ID Utilizador',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3001 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3001,3,N'Ordem do ID Utilizador',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3010 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3010,3,N'Não Mostrar Número de Identificação',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3011 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3011,3,N'Ordem do Número de Identificação',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3020 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3020,3,N'Não Mostrar Nome',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3021 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3021,3,N'Ordem do Nome',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3030 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3030,3,N'Não Mostrar Nome do Departamento',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3031 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3031,3,N'Ordem do Nome de Departamento',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3040 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3040,3,N'Não Mostrar Hora do Registo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3041 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3041,3,N'Ordem do Hora do Registo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3050 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3050,3,N'Não Mostrar Tipo de Registo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3051 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3051,3,N'Ordem do Tipo de Registo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3060 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3060,3,N'Não Mostrar Modo de Verificação',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3061 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3061,3,N'Ordem do Modo de Verificação',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3070 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3070,3,N'Não Mostrar Código de Trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3071 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3071,3,N'Ordem do Código de Trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3080 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3080,3,N'Não Mostrar Comentário',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3081 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3081,3,N'Ordem do Comentário',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3090 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3090,3,N'Não Mostrar Número de Dispositivo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3091 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3091,3,N'Ordem do Número de Dispositivo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3100 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3100,3,N'Não Mostrar Nome de Dispositivo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3101 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3101,3,N'Ordem do Nome de Dispositivo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3110 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3110,3,N'Não Mostrar Referência',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3111 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3111,3,N'Ordem da Referência',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3120 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3120,3,N'Não Mostrar Dia da semana',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3121 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3121,3,N'Ordem do Dia da semana',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3130 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3130,3,N'Não Mostrar Data de Criação',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3131 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3131,3,N'Ordem da Data de Criação',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3140 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3140,3,N'Não Mostrar Data de Modificação',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3141 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3141,3,N'Ordem da Data Modificação',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3150 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3150,3,N'Não Mostrar Código de Criador',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3151 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3151,3,N'Ordem do Código de Criador',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3160 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3160,3,N'Não Mostrar Código de Modificador',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3161 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3161,3,N'Ordem do Código de Modificador',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4000 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4000,3,N'Não Mostrar Data',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4001 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4001,3,N'Ordem da Data',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4010 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4010,3,N'Não Mostrar Código',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4011 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4011,3,N'Ordem do Código',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4020 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4020,3,N'Não Mostrar Número de Identificação',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4021 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4021,3,N'Ordem do Número de Identificação',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4030 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4030,3,N'Não Mostrar Nome',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4031 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4031,3,N'Ordem do Nome',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4040 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4040,3,N'Não Mostrar Departamento',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4041 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4041,3,N'Ordem do Departamento',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4050 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4050,3,N'Não Mostrar Referência',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4051 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4051,3,N'Ordem da Referência',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4060 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4060,3,N'Não Mostrar Registos',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4061 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4061,3,N'Ordem dos Registos',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4070 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4070,3,N'Não Mostrar Registo 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4071 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4071,3,N'Ordem dos Registo 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4080 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4080,3,N'Não Mostrar Registo 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4081 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4081,3,N'Ordem dos Registo 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4090 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4090,3,N'Não Mostrar Registo 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4091 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4091,3,N'Ordem dos Registo 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4100 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4100,3,N'Não Mostrar Registo 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4101 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4101,3,N'Ordem dos Registo 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4110 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4110,3,N'Não Mostrar Registo 5',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4111 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4111,3,N'Ordem dos Registo 5',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4120 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4120,3,N'Não Mostrar Registo 6',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4121 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4121,3,N'Ordem dos Registo 6',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4130 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4130,3,N'Não Mostrar Registo 7',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4131 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4131,3,N'Ordem dos Registo 7',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4140 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4140,3,N'Não Mostrar Registo 8',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4141 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4141,3,N'Ordem dos Registo 8',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4150 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4150,3,N'Não Mostrar Tempo 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4151 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4151,3,N'Formato para Tempo 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4152 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4152,3,N'Ordem do Tempo 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4160 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4160,3,N'Não Mostrar Tempo 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4161 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4161,3,N'Formato para Tempo 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4162 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4162,3,N'Ordem do Tempo 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4170 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4170,3,N'Não Mostrar Tempo 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4171 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4171,3,N'Formato para Tempo 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4172 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4172,3,N'Ordem do Tempo 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4180 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4180,3,N'Não Mostrar Tempo 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4181 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4181,3,N'Formato para Tempo 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4182 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4182,3,N'Ordem do Tempo 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4190 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4190,3,N'Não Mostrar Pausa 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4191 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4191,3,N'Formato para Pausa 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4192 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4192,3,N'Ordem da Pausa 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4200 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4200,3,N'Não Mostrar Pausa 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4201 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4201,3,N'Formato para Pausa 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4202 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4202,3,N'Ordem da Pausa 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4210 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4210,3,N'Não Mostrar Pausa 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4211 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4211,3,N'Formato para Pausa 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4212 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4212,3,N'Ordem da Pausa 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4220 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4220,3,N'Não Mostrar Tempo de Trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4221 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4221,3,N'Formato para Tempo de Trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4222 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4222,3,N'Ordem do Tempo de Trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4230 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4230,3,N'Não Mostrar Tempo Total de Pausa',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4231 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4231,3,N'Formato para Tempo Total de Pausa',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4232 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4232,3,N'Ordem do Tempo Total de Pausa',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4240 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4240,3,N'Não Mostrar Tempo Total',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4241 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4241,3,N'Formato para Tempo Total',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4242 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4242,3,N'Ordem do Tempo Total',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4250 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4250,3,N'Não Mostrar Dia da semana',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4252 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4252,3,N'Ordem do Dia da Semana',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4260 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4260,3,N'Não Mostrar Total de Registos',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4262 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4262,3,N'Ordem do Total de Registos',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =10001 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (10001,3,N'Versão 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =10002 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (10002,3,N'Versão 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =120 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (120,3,N'Permitir apenas uma sessão da aplicação aberta',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1050 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1050,3,N'Mostrar ficha de Controlo de Acesso',N'')

IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1910 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1910,3,N'Mostrar como identificador',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1920 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1920,3,N'1.º Ordenar por',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1925 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1925,3,N'1.º Ordenar tipo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1930 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1930,3,N'2.º Ordenar por',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1935 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1935,3,N'2.º Ordenar tipo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1940 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1940,3,N'3.º Ordenar por',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =1945 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (1945,3,N'3.º Ordenar tipo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2039 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2039,3,N'Mostrar Nome do Dia da semana (Se não, mostrar o número)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2471 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2471,3,N'Não Mostrar remuneração de horas extraordinárias 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2472 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2472,3,N'Não Mostrar remuneração de horas extraordinárias 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2473 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2473,3,N'Não Mostrar remuneração de horas extraordinárias 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2474 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2474,3,N'Não Mostrar remuneração de horas extraordinárias 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2475 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2475,3,N'Não Mostrar remuneração de horas extraordinárias 5',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2603 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2603,3,N'Não Mostrar Horário Regular Trabalhado',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2613 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2613,3,N'Não Mostrar Salário Regular Trabalhado',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2630 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2630,3,N'Não Mostrar Excesso de Pausas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2640 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2640,3,N'Abreviatura para Ausência',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2641 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2641,3,N'Abreviatura para atraso na hora de entrada',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2642 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2642,3,N'Abreviatura para atraso no regresso da pausa',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2643 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2643,3,N'Abreviatura para Saída Antecipada',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2644 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2644,3,N'Abreviatura para Saída Antecipada para pausa',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2645 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2645,3,N'Abreviatura para horas extraordinárias antes do horário normal de trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2646 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2646,3,N'Abreviatura para horas extraordinárias nas pausas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2647 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2647,3,N'Abreviatura para horas extraordinárias depois do horário normal de trabalho',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =2648 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (2648,3,N'Abreviatura para Exceções',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3122 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3122,3,N'Mostrar Nome do Dia da semana (Se não, mostrar o número)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3170 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3170,3,N'Backup e eliminar após fazer download dos registos',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3171 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3171,3,N'Backup diretório',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3172 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3172,3,N'Eliminar registos apenas se ultrapassar (0= eliminar sempre)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3173 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3173,3,N'Executar tarefas apenas a partir destes computadores (IPs separados por ;)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4253 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4253,3,N'Mostrar Nome do Dia da semana (Se não, mostrar o número)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4270 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4270,3,N'Não Mostrar Primeiro Registo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4272 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4272,3,N'Ordem do Primeiro Registo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4280 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4280,3,N'Não Mostrar Último Registo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =4282 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (4282,3,N'Ordem do Último Registo',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5000 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5000,3,N'Enviar mensagens SMS para telemóveis',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5001 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5001,3,N'Porta',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5002 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5002,3,N'Velocidade',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5003 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5003,3,N'Bits de Dados',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5004 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5004,3,N'Bits de detenção',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5005 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5005,3,N'Bits de paridade',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =5006 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (5006,3,N'Mensagem SMS: usar {0} para data e {1} para o nome (nessa ordem)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =101 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (101,3,N'Tempo Mínimo entre Registos (MIN)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =102 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (102,3,N'Tempo Mínimo para haver atraso',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =103 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (103,3,N'Tempo Mínimo para saídas antecipadas',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =110 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (110,3,N'Se um dia de trabalho abrange 2 dias, registar no primeiro dia',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =115 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (115,3,N'Ordenar listas de utilizadores por código (se não, ordenar por nome)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =7001 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (7001,3,N'Relatório 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =7002 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (7002,3,N'Relatório 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =7003 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (7003,3,N'Relatório 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =7004 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (7004,3,N'Relatório 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =7005 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (7005,3,N'Relatório 5',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =8001 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (8001,3,N'Relatório 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =8002 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (8002,3,N'Relatório 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =8003 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (8003,3,N'Relatório 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =8004 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (8004,3,N'Relatório 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =8005 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (8005,3,N'Relatório 5',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =9001 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (9001,3,N'Relatório 1',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =9002 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (9002,3,N'Relatório 2',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =9003 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (9003,3,N'Relatório 3',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =9004 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (9004,3,N'Relatório 4',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =9005 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (9005,3,N'Relatório 5',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =300 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (300,3,N'Exportar relatório às (00:00 = Manual)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =305 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (305,3,N'Arquivo de formato de exportação predefinido',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =311 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (311,3,N'Separador para arquivos exportados',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =315 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (315,3,N'Nome arquivo exportação',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =325 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (325,3,N'Dias para exportar',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =304 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (304,3,N'Exportar dias (Número do dia separado por vírgula; vazio = diário)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6000 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6000,3,N'Enviar correios eletrónicos',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6001 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6001,3,N'Servidor SMTP',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6002 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6002,3,N'Porta',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6003 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6003,3,N'Utilizador',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6004 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6004,3,N'Palavra-passe',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6005 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6005,3,N'Usar SSL',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6006 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6006,3,N'Título do Correio eletrónico: usar {0} para a data {1} para o nome e {2} para o nome do dispositivo (nessa ordem)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6007 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6007,3,N'Mensagem de correio eletrónico: usar {0} para a data {1} para o nome e {2} para o nome do dispositivo (nessa ordem)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6008 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6008,3,N'Endereço de correio eletrónico a partir de onde são enviadas as mensagens',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6100 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6100,3,N'Download registos de ADMS Cloud',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6101 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6101,3,N'Tipo de Servidor de Base de Dados',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6102 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6102,3,N'Servidor',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6103 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6103,3,N'Porta',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6104 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6104,3,N'Utilizador',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6105 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6105,3,N'Palavra-passe',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6106 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6106,3,N'Nome da Base de Dados',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =6107 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (6107,3,N'Tempo de Espera de Ligação (Predefinido=Branco)',N'')
IF NOT EXISTS (SELECT IdParameter FROM ParameterName WHERE IdParameter =3999 AND IdLanguage = 3) INSERT INTO ParameterName ([IdParameter],[IdLanguage],[Description],[Comment]) VALUES (3999,3,N'Ordenar dispositivos por nome',N'')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2011 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2011,3,N'Não mostra E-mail do Empregado',N'')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2012 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2012,3,N'Não Mostrar Posição do Empregado',N'')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3022 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3022,3,N'Não mostra E-mail do Empregado',N'')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3023 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3023,3,N'Não Mostrar Posição do Empregado',N'')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 4032 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4032,3,N'Não mostra E-mail do Empregado',N'')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 4033 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4033,3,N'Não Mostrar Posição do Empregado',N'')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 1051 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1051,3,N'Abrir atraso bloqueio','')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 1052 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1052,3,N'Rosto ',null)
go
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 10004  and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (10004,0,N'First Run',null)
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 10004  and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (10004,1,N'First Run',null)
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 10004  and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (10004,2,N'First Run',null)
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 10004  and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (10004,3,N'First Run',null)

insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (10004,10,0,'False','')

IF NOT EXISTS (select [IdParameter] from [Parameter] where [IdParameter] = 2013) insert into [Parameter] (IdParameter,IdParameterCategory,DataType,[Value],[Values]) values (2013,3,0,'False',NULL)
IF NOT EXISTS (select [IdParameter] from [Parameter] where [IdParameter] = 3024) insert into [Parameter] (IdParameter,IdParameterCategory,DataType,[Value],[Values]) values (3024,4,0,'False',NULL)
IF NOT EXISTS (select [IdParameter] from [Parameter] where [IdParameter] = 4034) insert into [Parameter] (IdParameter,IdParameterCategory,DataType,[Value],[Values]) values (4034,5,0,'False',NULL)
go

IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2013 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2013, 0, N'No Mostrar Tardjeta de proximidad', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2013 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2013, 1, N'Do Not Show Proximity card', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2013 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2013, 2, N'Μην Δείξτε την κάρτα εγγύτητας', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2013 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2013, 3, N'Não mostrar cartões de proximidade', '')

IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3024 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3024, 0, N'No Mostrar Tardjeta de proximidad', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3024 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3024, 1, N'Do Not Show Proximity card', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3024 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3024, 2, N'Μην Δείξτε την κάρτα εγγύτητας', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3024 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3024, 3, N'Não mostrar cartões de proximidade', '')

IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 4034 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4034, 0, N'No Mostrar Tardjeta de proximidad', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 4034 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4034, 1, N'Do Not Show Proximity card', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 4034 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4034, 2, N'Μην Δείξτε την κάρτα εγγύτητας', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 4034 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (4034, 3, N'Não mostrar cartões de proximidade', '')


--20150402 I

IF NOT EXISTS (Select [IdParameter] from [Parameter] where [IdParameter] = 2649) insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2649,3,1,'Report 1',null)
IF NOT EXISTS (Select [IdParameter] from [Parameter] where [IdParameter] = 2650) insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2650,3,1,'Report 2',null)
IF NOT EXISTS (Select [IdParameter] from [Parameter] where [IdParameter] = 2651) insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2651,3,1,'Report 3',null)
IF NOT EXISTS (Select [IdParameter] from [Parameter] where [IdParameter] = 2652) insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2652,3,1,'Report 4',null)
IF NOT EXISTS (Select [IdParameter] from [Parameter] where [IdParameter] = 2653) insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (2653,3,1,'Report 5',null)
go
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2649 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2649, 0, N'Nombre Reporte 1', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2650 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2650, 0, N'Nombre Reporte 2', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2651 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2651, 0, N'Nombre Reporte 3', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2652 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2652, 0, N'Nombre Reporte 4', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2653 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2653, 0, N'Nombre Reporte 5', '')

IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2649 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2649, 1, N'Report 1 name', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2650 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2650, 1, N'Report 2 name', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2651 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2651, 1, N'Report 3 name', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2652 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2652, 1, N'Report 4 name', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2653 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2653, 1, N'Report 5 name', '')

IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2649 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2649, 2, N'Αναφορά 1 όνομα', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2650 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2650, 2, N'Αναφορά 2 όνομα', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2651 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2651, 2, N'Αναφορά 3 όνομα', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2652 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2652, 2, N'Αναφορά 4 όνομα', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2653 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2653, 2, N'Αναφορά 5 όνομα', '')

IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2649 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2649, 3, N'Relatório 1 nome', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2650 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2650, 3, N'Relatório 2 nome', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2651 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2651, 3, N'Relatório 3 nome', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2652 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2652, 3, N'Relatório 4 nome', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 2653 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (2653, 3, N'Relatório 5 nome', '')
go

IF NOT EXISTS (Select [IdParameter] from [Parameter] where [IdParameter] = 3162) insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3162,4,1,'Records 1',null)
IF NOT EXISTS (Select [IdParameter] from [Parameter] where [IdParameter] = 3163) insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3163,4,1,'Records 2',null)
IF NOT EXISTS (Select [IdParameter] from [Parameter] where [IdParameter] = 3164) insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3164,4,1,'Records 3',null)
IF NOT EXISTS (Select [IdParameter] from [Parameter] where [IdParameter] = 3165) insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3165,4,1,'Records 4',null)
IF NOT EXISTS (Select [IdParameter] from [Parameter] where [IdParameter] = 3166) insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (3166,4,1,'Records 5',null)
go
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3162 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3162, 0, N'Nombre Registros 1', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3163 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3163, 0, N'Nombre Registros 2', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3164 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3164, 0, N'Nombre Registros 3', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3165 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3165, 0, N'Nombre Registros 4', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3166 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3166, 0, N'Nombre Registros 5', '')

IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3162 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3162, 1, N'Records 1 name', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3163 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3163, 1, N'Records 2 name', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3164 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3164, 1, N'Records 3 name', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3165 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3165, 1, N'Records 4 name', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3166 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3166, 1, N'Records 5 name', '')

IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3162 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3162, 2, N'Εγγραφές 1 όνομα', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3163 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3163, 2, N'Εγγραφές 2 όνομα', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3164 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3164, 2, N'Εγγραφές 3 όνομα', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3165 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3165, 2, N'Εγγραφές 4 όνομα', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3166 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3166, 2, N'Εγγραφές 5 όνομα', '')

IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3162 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3162, 3, N'Registros 1 nome', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3163 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3163, 3, N'Registros 2 nome', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3164 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3164, 3, N'Registros 3 nome', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3165 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3165, 3, N'Registros 4 nome', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 3166 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (3166, 3, N'Registros 5 nome', '')
go
--20150402 F
--20150703 I
IF NOT EXISTS (Select [IdParameter] from [Parameter] where [IdParameter] = 1053) insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1053,0,0,'False',null)
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 1053 and [IdLanguage] = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1053, 0, N'Agregar feriados a nivel de empleado', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 1053 and [IdLanguage] = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1053, 1, N'Add holidays to employee level', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 1053 and [IdLanguage] = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1053, 2, N'Προσθέστε τις διακοπές στο επίπεδο των εργαζομένων', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where [IdParameter] = 1053 and [IdLanguage] = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1053, 3, N'Adicionar feriados ao nível do empregado', '')
--20150703 F

--CREATE NONCLUSTERED INDEX [ExceptionIndex]
--ON [dbo].[Exception] ([BeginingDate])
--INCLUDE ([IdException],[EndingDate],[Description],[Recurring],[Comment],[IdDepartment],[IdUser],[PaymentType],[PaymentFactor])
--GO

IF NOT EXISTS (Select [IdParameter] from [Parameter] where IdParameter = 1061) insert into [Parameter]([IdParameter],[IdParameterCategory],[DataType],[Value],[Values]) values (1061,0,0,'False',N'')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where IdParameter = 1061 and IdLanguage = 0) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1061, 0, N'Código de usuario de 10 dígitos (Los dispisitivos deben ser actualizados para soportar 10 dígitos)', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where IdParameter = 1061 and IdLanguage = 1) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1061, 1, N'User code of 10 digits (The devices must be updated to allow 10 digits)', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where IdParameter = 1061 and IdLanguage = 2) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1061, 2, N'Κωδικός Χρήστη δέκα ψηφία (Οι συσκευές πρέπει να επικαιροποιηθεί ώστε να καταστεί δυνατή δέκα ψηφία)', '')
IF NOT EXISTS (Select [IdParameter] from [ParameterName] where IdParameter = 1061 and IdLanguage = 3) insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (1061, 3, N'O código do usuário de dez dígitos (Os dispositivos devem ser atualizado para permitir que dez dígitos)', '')


update ParameterName set Description = N'Horario' where IdParameter = 2040 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Shift' where IdParameter = 2040 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το όνομα της βάρδιας' where IdParameter = 2040 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Nome do Horário' where IdParameter = 2040 and IdLanguage = 3 -- por

update ParameterName set Description = N'Entrada' where IdParameter = 2070 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Check-in' where IdParameter = 2070 and IdLanguage = 1 -- eng
update ParameterName set Description = N'μην εμφανίζεται η ώρα άφιξης' where IdParameter = 2070 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Hora de Entrada' where IdParameter = 2070 and IdLanguage = 3 -- por

update ParameterName set Description = N'Día de la semana entrada' where IdParameter = 2080 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Name of In-Day' where IdParameter = 2080 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το όνομα της ημέρας εισόδου' where IdParameter = 2080 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Nome do Dia de Entrada' where IdParameter = 2080 and IdLanguage = 3 -- por

update ParameterName set Description = N'Salida' where IdParameter = 2120 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Check-out Time' where IdParameter = 2120 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η ώρα αποχώρησης' where IdParameter = 2120 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Hora de Saída' where IdParameter = 2120 and IdLanguage = 3 -- por

update ParameterName set Description = N'Día de la semana salida' where IdParameter = 2130 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Out-Day´s Name' where IdParameter = 2130 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το όνομα της ημέρας' where IdParameter = 2130 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Nome do Dia de Saída' where IdParameter = 2130 and IdLanguage = 3 -- por

update ParameterName set Description = N'Tarde' where IdParameter = 2305 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Late Time' where IdParameter = 2305 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο χρόνος καθυστέρησης' where IdParameter = 2305 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Atraso' where IdParameter = 2305 and IdLanguage = 3 -- por

update ParameterName set Description = N'Temprano Salida' where IdParameter = 2320 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show early check-out time' where IdParameter = 2320 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο χρόνος νωρίτερης αποχώρησης' where IdParameter = 2320 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Hora de saídas antecipadas' where IdParameter = 2320 and IdLanguage = 3 -- por

update ParameterName set Description = N'Temprano Receso' where IdParameter = 2330 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show early check-out time (Breaks)' where IdParameter = 2330 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο χρόνος νωρίτερης αποχώρησης (διαλείμματα)' where IdParameter = 2330 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Hora de saídas antecipadas (pausas)' where IdParameter = 2330 and IdLanguage = 3 -- por

update ParameterName set Description = N'Temprano' where IdParameter = 2335 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show early check-out time' where IdParameter = 2335 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο χρόνος νωρίτερης αποχώρησης' where IdParameter = 2335 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Hora de saídas antecipadas' where IdParameter = 2335 and IdLanguage = 3 -- por

update ParameterName set Description = N'Extra no pagado a la entrada' where IdParameter = 2370 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show unpaid early overtime (before regular hours)' where IdParameter = 2370 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται απλήρωτη υπερωρία (πριν το ωράριο)' where IdParameter = 2370 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar horas extraordinárias não remuneradas ao início do horário normal de trabalho' where IdParameter = 2370 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Extra pagado a la entrada' where IdParameter = 2380 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show paid early overtime (before regular hours)' where IdParameter = 2380 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται πληρωμένη υπερωρία (πριν το ωράριο)' where IdParameter = 2380 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar horas extraordinárias remuneradas ao início do horário normal de trabalho' where IdParameter = 2380 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Pago extra a la entrada' where IdParameter = 2390 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show early overtime payment (before regular hours)' where IdParameter = 2390 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται πληρωμή υπερωρίας (πριν το ωράριο)' where IdParameter = 2390 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar remuneração das horas extraordinárias ao início do horário normal de trabalho' where IdParameter = 2390 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Total extra a la entrada' where IdParameter = 2400 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show total early overtime (before regular hours)' where IdParameter = 2400 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η συνολική υπερωρία (πριν το ωράριο)' where IdParameter = 2400 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar total de horas extraordinárias ao início do horário normal de trabalho' where IdParameter = 2400 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Extra no pagado a la salida' where IdParameter = 2410 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show unpaid late overtime (after regular hours)' where IdParameter = 2410 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται απλήρωτη υπερωρία (μετά το ωράριο)' where IdParameter = 2410 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar horas extraordinárias não remuneradas ao fim do horário normal de trabalho' where IdParameter = 2410 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Extra salida 1' where IdParameter = 2420 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show paid late overtime 1 (after regular hours)' where IdParameter = 2420 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται πληρωμένη υπερωρία 1 (μετά το ωράριο)' where IdParameter = 2420 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar horas extraordinárias 1 remuneradas ao fim do horário normal de trabalho' where IdParameter = 2420 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Extra salida 2' where IdParameter = 2430 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show paid late overtime 2 (after regular hours)' where IdParameter = 2430 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται πληρωμένη υπερωρία 2 (μετά το ωράριο)' where IdParameter = 2430 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar horas extraordinárias 2 remuneradas ao fim do horário normal de trabalho' where IdParameter = 2430 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Extra salida 3' where IdParameter = 2440 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show paid late overtime 3 (after regular hours)' where IdParameter = 2440 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται πληρωμένη υπερωρία 3 (μετά το ωράριο)' where IdParameter = 2440 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar horas extraordinárias 3 remuneradas ao fim do horário normal de trabalho' where IdParameter = 2440 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Extra salida 4' where IdParameter = 2450 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show paid late overtime 4 (after regular hours)' where IdParameter = 2450 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται πληρωμένη υπερωρία 4 (μετά το ωράριο)' where IdParameter = 2450 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar horas extraordinárias 4 remuneradas ao fim do horário normal de trabalho' where IdParameter = 2450 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Extra salida 5' where IdParameter = 2460 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show paid late overtime 5 (after regular hours)' where IdParameter = 2460 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται πληρωμένη υπερωρία 5 (μετά το ωράριο)' where IdParameter = 2460 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar horas extraordinárias 5 remuneradas ao fim do horário normal de trabalho' where IdParameter = 2460 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Pago extra a la salida' where IdParameter = 2470 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show late overtime payment (after regular hours)' where IdParameter = 2470 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η πληρωμή υπερωρίας (μετά το ωράριο)' where IdParameter = 2470 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar remuneração de horas extraordinárias ao fim do horário normal de trabalho' where IdParameter = 2470 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Monto Extras 1' where IdParameter = 2471 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show late overtime 1 payment' where IdParameter = 2471 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται πληρωμή υπερωρίας 1' where IdParameter = 2471 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar remuneração de horas extraordinárias 1' where IdParameter = 2471 and IdLanguage = 3 -- por
    
update ParameterName set Description = N'Monto Extras 2' where IdParameter = 2472 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show late overtime 2 payment' where IdParameter = 2472 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται πληρωμή υπερωρίας 2' where IdParameter = 2472 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar remuneração de horas extraordinárias 2' where IdParameter = 2472 and IdLanguage = 3 -- por 
   
update ParameterName set Description = N'Monto Extras 3' where IdParameter = 2473 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show late overtime 3 payment' where IdParameter = 2473 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται πληρωμή υπερωρίας 3' where IdParameter = 2473 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar remuneração de horas extraordinárias 3' where IdParameter = 2473 and IdLanguage = 3 -- por  

update ParameterName set Description = N'Monto Extras 4' where IdParameter = 2474 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show late overtime 4 payment' where IdParameter = 2474 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται πληρωμή υπερωρίας 4' where IdParameter = 2474 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar remuneração de horas extraordinárias 4' where IdParameter = 2474 and IdLanguage = 3 -- por
    
update ParameterName set Description = N'Monto Extras 5' where IdParameter = 2475 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show late overtime 5 payment' where IdParameter = 2475 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται πληρωμή υπερωρίας 5' where IdParameter = 2475 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar remuneração de horas extraordinárias 5' where IdParameter = 2475 and IdLanguage = 3 -- por

update ParameterName set Description = N'Total Extra a la Salida' where IdParameter = 2480 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show total late overtime (after regular hours)' where IdParameter = 2480 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η συνολική υπερωρία (μετά το ωράριο)' where IdParameter = 2480 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar total de horas extraordinárias ao fim do horário normal de trabalho' where IdParameter = 2480 and IdLanguage = 3 -- por

update ParameterName set Description = N'Pago Extra Receso' where IdParameter = 2505 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show break overtime payment' where IdParameter = 2505 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η πληρωμή υπερωρίας διαλείμματος' where IdParameter = 2505 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Remuneração de horas extraordinárias de pausas' where IdParameter = 2505 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Extra Receso' where IdParameter = 2510 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Total overtime (Breaks)' where IdParameter = 2510 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η συνολική υπερωρία (διαλείμματα)' where IdParameter = 2510 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Total de horas extraordinárias (Pausas)' where IdParameter = 2510 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Extras' where IdParameter = 2540 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Total overtime' where IdParameter = 2540 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η συνολική υπερωρία' where IdParameter = 2540 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Total de horas extraordinárias ' where IdParameter = 2540 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Pago extras' where IdParameter = 2450 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Total overtime payment' where IdParameter = 2450 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η συνολική πληρωμή υπερωρίας' where IdParameter = 2450 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Remuneração total de horas extraordinárias' where IdParameter = 2450 and IdLanguage = 3 -- por
  
update ParameterName set Description = N'Ausente' where IdParameter = 2580 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Number of Absences' where IdParameter = 2580 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο αριθμός των απουσιών' where IdParameter = 2580 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Número de Ausências' where IdParameter = 2580 and IdLanguage = 3 -- por
    
update ParameterName set Description = N'Tiempo trabajado pagado' where IdParameter = 2600 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Net Time Worked' where IdParameter = 2600 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο καθαρός χρόνος εργασίας' where IdParameter = 2600 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Tempo Efetivo na empresa' where IdParameter = 2600 and IdLanguage = 3 -- por
    
update ParameterName set Description = N'Porcentaje trabajado' where IdParameter = 2610 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Percentage Time Worked' where IdParameter = 2610 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το ποσοστό του χρόνου εργασίας' where IdParameter = 2610 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Percentagem efetiva' where IdParameter = 2610 and IdLanguage = 3 -- por
    
update ParameterName set Description = N'Pago total' where IdParameter = 2620 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Total Salary' where IdParameter = 2620 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο συνολικός μισθός' where IdParameter = 2620 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Salário Total' where IdParameter = 2620 and IdLanguage = 3 -- por
    
update ParameterName set Description = N'Exceso en receso' where IdParameter = 2630 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Excess Break time' where IdParameter = 2630 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η υπέρβαση του χρόνου διαλείμματος' where IdParameter = 2630 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Excesso de Pausas' where IdParameter = 2630 and IdLanguage = 3 -- por
    
update ParameterName set Description = N'Tiempo excepción' where IdParameter = 2560 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Do Not Show Holidays/Exceptions Time' where IdParameter = 2560 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο χρόνος αργιών/εξαιρέσεων' where IdParameter = 2560 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Não Mostrar Tempo Feriados/exceções ' where IdParameter = 2560 and IdLanguage = 3 -- por
    
update ParameterName set Description = N'Pago excepción' where IdParameter = 2570 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Holidays/Exceptions Payment' where IdParameter = 2570 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η πληρωμή αργιών/εξαιρέσεων' where IdParameter = 2570 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Remuneração Feriados/Exceções' where IdParameter = 2570 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Nombre de Departamento' where IdParameter = 2000 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Department Name' where IdParameter = 2000 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το όνομα του τμήματος' where IdParameter = 2000 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Nome do Departamento' where IdParameter = 2000 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Código del Usuario' where IdParameter = 2005 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show User Code' where IdParameter = 2005 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο κωδικός χρήστη' where IdParameter = 2005 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Código do Utilizador' where IdParameter = 2005 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Nombre de Empleado' where IdParameter = 2010 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Employee Name' where IdParameter = 2010 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το όνομα του χρήστη' where IdParameter = 2010 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Nome do Empregado' where IdParameter = 2010 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar E-mail' where IdParameter = 2011 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Employee E-mail' where IdParameter = 2011 and IdLanguage = 1 -- eng
update ParameterName set Description = N'Εμφάνιση email Υπαλλήλου' where IdParameter = 2011 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar E-mail do Empregado' where IdParameter = 2011 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Puesto' where IdParameter = 2012 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Employee Position' where IdParameter = 2012 and IdLanguage = 1 -- eng
update ParameterName set Description = N'δείξει τη θέση Υπαλλήλου' where IdParameter = 2012 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Posição do Empregado' where IdParameter = 2012 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Referencia' where IdParameter = 2020 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Reference' where IdParameter = 2020 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η αναφορά' where IdParameter = 2020 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Referência' where IdParameter = 2020 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Número de Identificación' where IdParameter = 2030 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Identification Number' where IdParameter = 2030 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο αριθμός αναγνώρισης' where IdParameter = 2030 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Número de Identificação' where IdParameter = 2030 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Fecha' where IdParameter = 2035 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Date' where IdParameter = 2035 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η ημερομηνία' where IdParameter = 2035 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Data' where IdParameter = 2035 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Día de la semana' where IdParameter = 2038 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Day of the Week' where IdParameter = 2038 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η ημέρα της εβδομάδας' where IdParameter = 2038 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Dia da semana' where IdParameter = 2038 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Hora de Entrada del Horario' where IdParameter = 2050 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Shift´s Check-in Time' where IdParameter = 2050 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η ώρα άφιξης στη βάρδια' where IdParameter = 2050 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Hora de Entrada no Horário' where IdParameter = 2050 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Hora de Salida del Horario' where IdParameter = 2060 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Shift´s Check-out Time' where IdParameter = 2060 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η ώρα αποχώρησης από τη βάρδια' where IdParameter = 2060 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Hora de Saída no Horário' where IdParameter = 2060 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Año de la Entrada' where IdParameter = 2090 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show In-Year' where IdParameter = 2090 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το έτος εισόδου' where IdParameter = 2090 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Ano de Entrada' where IdParameter = 2090 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Mes de la Entrada' where IdParameter = 2100 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show In-Month' where IdParameter = 2100 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο μήνας εισόδου' where IdParameter = 2100 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Mês de Entrada' where IdParameter = 2100 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Fecha de Día de Entrada' where IdParameter = 2110 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show In-Day´s Date' where IdParameter = 2110 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η ημερομηνία της ημέρας εισόδου' where IdParameter = 2110 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Data do Dia de Entrada' where IdParameter = 2110 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Año de la Salida' where IdParameter = 2140 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Out-Year' where IdParameter = 2140 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το έτος εξόδου' where IdParameter = 2140 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Ano de Saída' where IdParameter = 2140 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Mes de la Salida' where IdParameter = 2150 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Out-Month' where IdParameter = 2150 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο μήνας εξόδου' where IdParameter = 2150 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Mês de Saída' where IdParameter = 2150 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Fecha de Día de Salida' where IdParameter = 2160 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Out-Day´s Date' where IdParameter = 2160 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η ημερομηνία της ημέρας εξόδου' where IdParameter = 2160 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Data do Dia de Saída' where IdParameter = 2160 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Listado con todos los Registros' where IdParameter = 2170 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record List' where IdParameter = 2170 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η λίστα εγγραφών' where IdParameter = 2170 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Listagem com os Registos' where IdParameter = 2170 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 1' where IdParameter = 2180 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 1' where IdParameter = 2180 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 1' where IdParameter = 2180 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 1' where IdParameter = 2180 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 2' where IdParameter = 2190 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 2' where IdParameter = 2190 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 2' where IdParameter = 2190 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 2' where IdParameter = 2190 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 3' where IdParameter = 2200 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 3' where IdParameter = 2200 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 3' where IdParameter = 2200 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 3' where IdParameter = 2200 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 4' where IdParameter = 2210 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 4' where IdParameter = 2210 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 4' where IdParameter = 2210 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 4' where IdParameter = 2210 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 5' where IdParameter = 2220 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 5' where IdParameter = 2220 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 5' where IdParameter = 2220 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 5' where IdParameter = 2220 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 6' where IdParameter = 2230 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 6' where IdParameter = 2230 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 6' where IdParameter = 2230 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 6' where IdParameter = 2230 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 7' where IdParameter = 2240 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 7' where IdParameter = 2240 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 7' where IdParameter = 2240 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 7' where IdParameter = 2240 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 8' where IdParameter = 2250 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 8' where IdParameter = 2250 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 8' where IdParameter = 2250 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 8' where IdParameter = 2250 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Número de Registros' where IdParameter = 2260 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Number of Records' where IdParameter = 2260 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο αριθμός των εγγραφών' where IdParameter = 2260 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Número de Registos' where IdParameter = 2260 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tiempo Regular' where IdParameter = 2270 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Regular Time' where IdParameter = 2270 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο κανονικός χρόνος' where IdParameter = 2270 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Hora Regular' where IdParameter = 2270 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Salario Regular' where IdParameter = 2280 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Regular Salary' where IdParameter = 2280 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο κανονικός μισθός' where IdParameter = 2280 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Salário Regular' where IdParameter = 2280 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tiempo Tarde a la Entrada' where IdParameter = 2290 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Late Check-In Time' where IdParameter = 2290 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο χρόνος αργοπορημένης άφιξης' where IdParameter = 2290 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Atraso na Hora de Entrada' where IdParameter = 2290 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tiempo tarde en recesos' where IdParameter = 2300 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Break Late Time' where IdParameter = 2300 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο χρόνος αργοπορημένου διαλείμματος' where IdParameter = 2300 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Atrasos no Regresso da Pausa' where IdParameter = 2300 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Cantidad de recesos' where IdParameter = 2350 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show number of breaks' where IdParameter = 2350 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο αριθμός των διαλειμμάτων' where IdParameter = 2350 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar número de pausas' where IdParameter = 2350 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tiempo total de recesos' where IdParameter = 2360 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show total break time' where IdParameter = 2360 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο συνολικός χρόνος διαλείμματος' where IdParameter = 2360 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar total de horas de pausa' where IdParameter = 2360 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tiempo extra no pagado de recesos' where IdParameter = 2490 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show unpaid break overtime' where IdParameter = 2490 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η απλήρωτη υπερωρία διαλείμματος' where IdParameter = 2490 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar horas extraordinárias não remuneradas de pausas' where IdParameter = 2490 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tiempo extra pagado de recesos' where IdParameter = 2500 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show paid break overtime' where IdParameter = 2500 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η πληρωμένη υπερωρία διαλείμματος' where IdParameter = 2500 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar horas extraordinárias remuneradas de pausas' where IdParameter = 2500 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Total de horas extras pagadas ' where IdParameter = 2520 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Total paid overtime' where IdParameter = 2520 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η συνολική πληρωμένη υπερωρία' where IdParameter = 2520 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Total de horas extraordinárias remuneradas ' where IdParameter = 2520 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Total de horas extras no pagadas' where IdParameter = 2530 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Total unpaid overtime' where IdParameter = 2530 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η συνολική απλήρωτη υπερωρία' where IdParameter = 2530 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Total de horas extraordinárias não remuneradas ' where IdParameter = 2530 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Pago total de horas extras' where IdParameter = 2550 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Total overtime payment' where IdParameter = 2550 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η συνολική πληρωμή υπερωρίας' where IdParameter = 2550 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Remuneração total de horas extraordinárias' where IdParameter = 2550 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar descripción de Feriados/excepciones' where IdParameter = 2558 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show description of holidays/exceptions' where IdParameter = 2558 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζονται περιγραφές αργιών/εξαιρέσεων' where IdParameter = 2558 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar descrição de Feriados/exceções' where IdParameter = 2558 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tiempo Total en la empresa' where IdParameter = 2590 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Total Time at the company' where IdParameter = 2590 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο συνολικός χρόνος στην εταιρεία' where IdParameter = 2590 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Tempo Total na empresa' where IdParameter = 2590 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Código' where IdParameter = 3000 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show User ID' where IdParameter = 3000 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο αριθμός αναγνώρισης χρήστη' where IdParameter = 3000 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar ID Utilizador' where IdParameter = 3000 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Número de Identificación' where IdParameter = 3010 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Identification Number' where IdParameter = 3010 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο αριθμός αναγνώρισης' where IdParameter = 3010 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Número de Identificação' where IdParameter = 3010 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Nombre' where IdParameter = 3020 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Name' where IdParameter = 3020 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το όνομα' where IdParameter = 3020 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Nome' where IdParameter = 3020 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Departamento' where IdParameter = 3030 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Department Name' where IdParameter = 3030 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το όνομα του τμήματος' where IdParameter = 3030 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Nome do Departamento' where IdParameter = 3030 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Hora del Registro' where IdParameter = 3040 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record Time' where IdParameter = 3040 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο χρόνος εγγραφής' where IdParameter = 3040 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Hora do Registo' where IdParameter = 3040 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tipo de Registro' where IdParameter = 3050 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record Type' where IdParameter = 3050 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο τύπος εγγραφής' where IdParameter = 3050 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Tipo de Registo' where IdParameter = 3050 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Modo de Verificación' where IdParameter = 3060 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Verification Mode' where IdParameter = 3060 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο τρόπος επαλήθευσης' where IdParameter = 3060 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Modo de Verificação' where IdParameter = 3060 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Código de Trabajo' where IdParameter = 3070 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Work Code' where IdParameter = 3070 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο κωδικός εργασίας' where IdParameter = 3070 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Código de Trabalho' where IdParameter = 3070 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Comentario' where IdParameter = 3080 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Comment' where IdParameter = 3080 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται σχόλιο' where IdParameter = 3080 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Comentário' where IdParameter = 3080 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Número de Dispositivo' where IdParameter = 3090 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Device Number' where IdParameter = 3090 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο αριθμός συσκευής' where IdParameter = 3090 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Número de Dispositivo' where IdParameter = 3090 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Nombre de Dispositivo' where IdParameter = 3100 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Device Name' where IdParameter = 3100 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το όνομα της συσκευής' where IdParameter = 3100 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Nome de Dispositivo' where IdParameter = 3100 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Referencia' where IdParameter = 3110 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show External Reference' where IdParameter = 3110 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εξωτερική αναφορά' where IdParameter = 3110 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Referência' where IdParameter = 3110 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Día de la semana' where IdParameter = 3120 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Day of the Week' where IdParameter = 3120 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η ημέρα της εβδομάδας' where IdParameter = 3120 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Dia da semana' where IdParameter = 3120 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Fecha de Creación' where IdParameter = 3130 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Creation Date' where IdParameter = 3130 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η ημερομηνία δημιουργίας' where IdParameter = 3130 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Data de Criação' where IdParameter = 3130 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Fecha de Modificación' where IdParameter = 3140 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Modification Date' where IdParameter = 3140 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η ημερομηνία τροποποίησης' where IdParameter = 3140 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Data de Modificação' where IdParameter = 3140 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Código de Creador' where IdParameter = 3150 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Creator Code' where IdParameter = 3150 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο κωδικός δημιουργού' where IdParameter = 3150 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Código de Criador' where IdParameter = 3150 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Código de Modificador' where IdParameter = 3160 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Modifier Code' where IdParameter = 3160 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο κωδικός τρoποποιητή' where IdParameter = 3160 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Código de Modificador' where IdParameter = 3160 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Fecha' where IdParameter = 4000 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Date' where IdParameter = 4000 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η ημερομηνία' where IdParameter = 4000 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Data' where IdParameter = 4000 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Código' where IdParameter = 4010 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show User ID' where IdParameter = 4010 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο αριθμός αναγνώρισης χρήστη' where IdParameter = 4010 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Código' where IdParameter = 4010 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Número de Identificación' where IdParameter = 4020 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Identification Number' where IdParameter = 4020 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο αριθμός αναγνώρισης' where IdParameter = 4020 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Número de Identificação' where IdParameter = 4020 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Nombre' where IdParameter = 4030 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Name' where IdParameter = 4030 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το όνομα' where IdParameter = 4030 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Nome' where IdParameter = 4030 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Departamento' where IdParameter = 4040 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Department Name' where IdParameter = 4040 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το όνομα του τμήματος' where IdParameter = 4040 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Departamento' where IdParameter = 4040 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Referencia' where IdParameter = 4050 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show External Reference' where IdParameter = 4050 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εξωτερική αναφορά' where IdParameter = 4050 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Referência' where IdParameter = 4050 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registros' where IdParameter = 4060 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Records' where IdParameter = 4060 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζονται εγγραφές' where IdParameter = 4060 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registos' where IdParameter = 4060 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 1' where IdParameter = 4070 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 1' where IdParameter = 4070 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 1' where IdParameter = 4070 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 1' where IdParameter = 4070 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 2' where IdParameter = 4080 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 2' where IdParameter = 4080 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 2' where IdParameter = 4080 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 2' where IdParameter = 4080 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 3' where IdParameter = 4090 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 3' where IdParameter = 4090 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 3' where IdParameter = 4090 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 3' where IdParameter = 4090 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 4' where IdParameter = 4100 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 4' where IdParameter = 4100 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 4' where IdParameter = 4100 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 4' where IdParameter = 4100 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 5' where IdParameter = 4110 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 5' where IdParameter = 4110 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 5' where IdParameter = 4110 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 5' where IdParameter = 4110 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 6' where IdParameter = 4120 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 6' where IdParameter = 4120 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 6' where IdParameter = 4120 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 6' where IdParameter = 4120 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 7' where IdParameter = 4130 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 7' where IdParameter = 4130 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 7' where IdParameter = 4130 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 7' where IdParameter = 4130 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Registro 8' where IdParameter = 4140 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Record 8' where IdParameter = 4140 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η εγγραφή 8' where IdParameter = 4140 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Registo 8' where IdParameter = 4140 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tiempo 1' where IdParameter = 4150 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Time 1' where IdParameter = 4150 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο χρόνος 1' where IdParameter = 4150 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Tempo 1' where IdParameter = 4150 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tiempo 2' where IdParameter = 4160 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Time 2' where IdParameter = 4160 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο χρόνος 2' where IdParameter = 4160 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Tempo 2' where IdParameter = 4160 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tiempo 3' where IdParameter = 4170 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Time 3' where IdParameter = 4170 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο χρόνος 3' where IdParameter = 4170 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Tempo 3' where IdParameter = 4170 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tiempo 4' where IdParameter = 4180 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Time 4' where IdParameter = 4180 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο χρόνος 4' where IdParameter = 4180 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Tempo 4' where IdParameter = 4180 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Descanso 1' where IdParameter = 4190 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Break 1' where IdParameter = 4190 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το διάλειμμα 1' where IdParameter = 4190 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Pausa 1' where IdParameter = 4190 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Descanso 2' where IdParameter = 4200 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Break 2' where IdParameter = 4200 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το διάλειμμα 2' where IdParameter = 4200 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Pausa 2' where IdParameter = 4200 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Descanso 3' where IdParameter = 4210 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Break 3' where IdParameter = 4210 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται το διάλειμμα 3' where IdParameter = 4210 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Pausa 3' where IdParameter = 4210 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tiempo de Trabajo' where IdParameter = 4220 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Time Worked' where IdParameter = 4220 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο δεδουλευμένος χρόνος' where IdParameter = 4220 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Tempo de Trabalho' where IdParameter = 4220 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tiempo Total Descanso' where IdParameter = 4230 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Total Break Time' where IdParameter = 4230 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο συνολικός χρόνος διαλείμματος' where IdParameter = 4230 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Tempo Total de Pausa' where IdParameter = 4230 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tiempo Total' where IdParameter = 4240 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Total Time' where IdParameter = 4240 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο συνολικός χρόνος' where IdParameter = 4240 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Tempo Total' where IdParameter = 4240 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Día de la semana' where IdParameter = 4250 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Day of the Week' where IdParameter = 4250 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η ημέρα της εβδομάδας' where IdParameter = 4250 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Dia da semana' where IdParameter = 4250 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Total de Registros' where IdParameter = 4260 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Total Records' where IdParameter = 4260 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζονται οι συνολικές εγγραφές' where IdParameter = 4260 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Total de Registos' where IdParameter = 4260 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Primer Registro' where IdParameter = 4270 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show First Record' where IdParameter = 4270 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η πρώτη εγγραφή' where IdParameter = 4270 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Primeiro Registo' where IdParameter = 4270 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Último Registro' where IdParameter = 4280 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Last Record' where IdParameter = 4280 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται η τελευταία εγγραφή' where IdParameter = 4280 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Último Registo' where IdParameter = 4280 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tarjeta de proximidad' where IdParameter = 2013 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Proximity card' where IdParameter = 2013 and IdLanguage = 1 -- eng
update ParameterName set Description = N'την κάρτα εγγύτητας' where IdParameter = 2013 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar cartões de proximidade' where IdParameter = 2013 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar E-mail' where IdParameter = 3022 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Employee E-mail' where IdParameter = 3022 and IdLanguage = 1 -- eng
update ParameterName set Description = N'Εμφάνιση email Υπαλλήλου' where IdParameter = 3022 and IdLanguage = 2 -- gre
update ParameterName set Description = N' Mostra E-mail do Empregado' where IdParameter = 3022 and IdLanguage = 3 -- por

update ParameterName set Description = N' Mostrar Puesto' where IdParameter = 3023 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Employee Position' where IdParameter = 3023 and IdLanguage = 1 -- eng
update ParameterName set Description = N'δείξει τη θέση Υπαλλήλου' where IdParameter = 3023 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Posição do Empregado' where IdParameter = 3023 and IdLanguage = 3 -- por

update ParameterName set Description = N'Mostrar Tarjeta de proximidad' where IdParameter = 3024 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Proximity card' where IdParameter = 3024 and IdLanguage = 1 -- eng
update ParameterName set Description = N'την κάρτα εγγύτητας' where IdParameter = 3024 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar cartões de proximidade' where IdParameter = 3024 and IdLanguage = 3 -- por


update ParameterName set Description = N'Mostrar Tarjeta de proximidad' where IdParameter = 4034 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Proximity card' where IdParameter = 4034 and IdLanguage = 1 -- eng
update ParameterName set Description = N'την κάρτα εγγύτητας' where IdParameter = 4034 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar cartões de proximidade' where IdParameter = 4034 and IdLanguage = 3 -- por

update ParameterName set Description = N'Tiempo Regular Trabajado' where IdParameter = 2603 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Regular Time Worked' where IdParameter = 2603 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο κανονικός χρόνος εργασίας' where IdParameter = 2603 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Horário Regular Trabalhado' where IdParameter = 2603 and IdLanguage = 3 -- por

update ParameterName set Description = N'Salario Regular Trabajado' where IdParameter = 2613 and IdLanguage = 0 -- esp
update ParameterName set Description = N'Show Salary for Regular Time Worked' where IdParameter = 2613 and IdLanguage = 1 -- eng
update ParameterName set Description = N'εμφανίζεται ο μισθός για τον κανονικό χρόνο εργασίας' where IdParameter = 2613 and IdLanguage = 2 -- gre
update ParameterName set Description = N'Mostrar Salário Regular Trabalhado' where IdParameter = 2613 and IdLanguage = 3 -- por

IF NOT EXISTS(select * from parameter where idparameter = 10005)
begin
insert into [Parameter] (IdParameter,IdParameterCategory,DataType,[Value],[Values]) values (10005,10,0,'False',NULL)
update parameter set Value = 'T' where IdParameterCategory = 3 and DataType = 0 and Value = 'True'
update parameter set Value = 'F' where IdParameterCategory = 3 and DataType = 0 and Value = 'False'
update parameter set Value = 'False' where IdParameterCategory = 3 and DataType = 0 and Value = 'T'
update parameter set Value = 'True' where IdParameterCategory = 3 and DataType = 0 and Value = 'F'

update parameter set Value = 'T' where IdParameterCategory = 4 and DataType = 0 and Value = 'True'
update parameter set Value = 'F' where IdParameterCategory = 4 and DataType = 0 and Value = 'False'
update parameter set Value = 'False' where IdParameterCategory = 4 and DataType = 0 and Value = 'T'
update parameter set Value = 'True' where IdParameterCategory = 4 and DataType = 0 and Value = 'F'
update parameter set Value = 'True' where idparameter = 10005
end
go

alter table Exception add WholeDay bit default 'false' not null
go

insert into [Parameter] (IdParameter,IdParameterCategory,DataType,[Value],[Values]) values (10006,10,0,'False',NULL)
insert into [ParameterName]([IdParameter],[IdLanguage],[Description],[Comment]) values (10006,0,N'Faltan usuarios por descargar del dispositivo',N'')
go

/*Tablas para usuarios con id tipo string*/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UserStr]') AND type in (N'U'))
BEGIN
CREATE TABLE [UserStr](
	[IdUser] [varchar](20) NOT NULL,
	[IdentificationNumber] [varchar](20) NULL,
	[Name] [varchar](250) NOT NULL,
	[Gender] [smallint] NULL,
	[Title] [varchar](100) NULL,
	[Birthday] [datetime] NULL,
	[PhoneNumber] [varchar](50) NULL,
	[MobileNumber] [varchar](50) NULL,
	[Address] [varchar](250) NULL,
	[ExternalReference] [varchar](50) NULL,
	[IdDepartment] [int] NOT NULL,
	[Position] [varchar](150) NULL,
	[Active] [smallint] NOT NULL,
	[Picture] varchar(max) NULL,
	[PictureOrientation] [smallint] NULL,
	[Privilege] [int] NOT NULL,
	[HourSalary] [decimal](10, 2) NOT NULL,
	[Password] [varchar](50) NULL,
	[PreferredIdLanguage] [smallint] NOT NULL,
	[Email] [varchar](200) NULL,
	[Comment] [varchar](200) NULL,
	[ProximityCard] [varchar](50) NULL,
	[LastRecord] [datetime] NULL,
	[LastLogin] [datetime] NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[CreatedDatetime] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NOT NULL,
	[ModifiedDatetime] [datetime] NOT NULL,
	[AdministratorType] [int] NULL,
	[IdProfile] [int] NULL,
	[DevPassword] [varchar](255) NULL,
	[UseShift] [bit] NOT NULL,
	SendSMS int NULL,
	SMSPhone varchar(50)  NULL,
	TemplateCode int NULL,	
	[ApplyExceptionPermition] [bit] NULL,
	[ExceptionPermitionBegin] [datetime] NULL,
	[ExceptionPermitionEnd] [datetime] NULL,
 CONSTRAINT [UserStr_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdUser] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UserFingerprintStr]') AND type in (N'U'))
BEGIN
CREATE TABLE [UserFingerprintStr](
	[IdUser] [varchar] (20) NOT NULL,
	[FingerNumber] [smallint] NOT NULL,
	[Version] [smallint] NOT NULL,
	[FingerPrintSize] [int] NULL,
	[FingerPrint] varchar(max) NULL,
 CONSTRAINT [UserFingerprintStr_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdUser] ASC,
	[FingerNumber] ASC,
	[Version] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UserFaceStr]') AND type in (N'U'))
BEGIN
CREATE TABLE [UserFaceStr](
	[IdUser] [varchar] (20) NOT NULL,
	[FaceIndex] [varchar](255) NOT NULL,
	[FaceSize] [int] NULL,
	[FaceData] varchar(max) NULL,
	[VALID] [int] NULL,
	[RESERVE] [int] NULL,
	[ACTIVETIME] [int] NULL,
	[VFCOUNT] [int] NULL,
 CONSTRAINT [UserFaceStr_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdUser] ASC,
	[FaceIndex] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RecordStr]') AND type in (N'U'))
BEGIN
CREATE TABLE [RecordStr](
	[IdUser] [varchar](20) NOT NULL,
	[RecordTime] [datetime] NOT NULL,
	[MachineNumber] [int] NOT NULL,
	[RecordType] [int] NOT NULL,
	[VerifyMode] [int] NULL,
	[Workcode] [int] NOT NULL,
	[Comment] [varchar](250) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar] (20) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NOT NULL,
 CONSTRAINT [RecordStr_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdUser] ASC,
	[RecordTime] ASC,
	[RecordType] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ExceptionStr]') AND type in (N'U'))
BEGIN
CREATE TABLE [ExceptionStr](
	[IdException] [int] IDENTITY(1,1) NOT NULL,
	[BeginingDate] [datetime] NULL,
	[EndingDate] [datetime] NULL,
	[Description] [varchar](255) NULL,
	[Recurring] [bit] NOT NULL,
	[Comment] [varchar](250) NULL,
	[IdDepartment] [int] NULL,
	[IdUser] [varchar](20) NULL,
	[PaymentType] [int] NULL,
	[PaymentFactor] [int] NULL,
 CONSTRAINT [ExceptionStr_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdException] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RecordStr]') AND type in (N'U'))
BEGIN
CREATE TABLE [RecordStr](
	[IdUser] [varchar](20) NOT NULL,
	[RecordTime] [datetime] NOT NULL,
	[MachineNumber] [int] NOT NULL,
	[RecordType] [int] NOT NULL,
	[VerifyMode] [int] NULL,
	[Workcode] [int] NOT NULL,
	[Comment] [varchar](250) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
 CONSTRAINT [RecordStr_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdUser] ASC,
	[RecordTime] ASC,
	[RecordType] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RecordAuxStr]') AND type in (N'U'))
BEGIN
CREATE TABLE [RecordAuxStr](
	[IdRecord] [int] IDENTITY(1,1) NOT NULL,
	[Operation] [int] NULL,
	[IdUser] [varchar](20) NOT NULL,
	[RecordTime] [datetime] NOT NULL,
	[RecordTimeAux] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
 CONSTRAINT [RecordAuxStr_PK] PRIMARY KEY NONCLUSTERED 
(
	[IdUser] ASC,
	[RecordTime] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE name = 'Device_UserStr' AND XTYPE = 'U')
	CREATE TABLE Device_UserStr
	(
		IdUser		varchar(20) not null,
		IdDevice	int not null,
		CONSTRAINT FK_UserStr FOREIGN KEY (IdUser) REFERENCES [UserStr] (IdUser),
		CONSTRAINT FK_DeviceStr FOREIGN KEY (IdDevice) REFERENCES [Device] (IdDevice)
	)
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UserShiftStr]') AND type in (N'U'))
BEGIN
CREATE TABLE [UserShiftStr](
	[UserShiftId] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [varchar](20) NULL,
	[ShiftId] [int] NULL,
	[BeginDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [UserShiftStr_PK] PRIMARY KEY NONCLUSTERED 
(
	[UserShiftId] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RecordCuttingHourStr]') AND type in (N'U'))
BEGIN
CREATE TABLE [RecordCuttingHourStr](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [varchar](20) NULL,
	[CuttingHour] [int] NULL,
	[CuttingMinute] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [RecordCuttingHourStr_PK] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[RecordCuttingHourStr]') AND name = N'IdUser')
CREATE NONCLUSTERED INDEX [IdUser] ON [RecordCuttingHourStr] 
(
	[IdUser] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

END
GO

IF NOT EXISTS (select [IdParameter] from [Parameter] where [IdParameter] = 6203)
insert into Parameter (IdParameter,IdParameterCategory,DataType,Value,[Values]) values (6203,0,1,3,NULL)
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6203 and IdLanguage = 0) 
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6203,0,N'Tipo de verificación contraseña','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6203 and IdLanguage = 1) 
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6203,1,N'Verification type Password','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6203 and IdLanguage = 2) 
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6203,2,N'Τύπος επαλήθευσης Κωδικός πρόσβασης','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6203 and IdLanguage = 3) 
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6203,3,N'Tipo de verificação Senha','')
--Huella 1
IF NOT EXISTS (select [IdParameter] from [Parameter] where [IdParameter] = 6201)
insert into Parameter (IdParameter,IdParameterCategory,DataType,Value,[Values]) values (6201,0,1,1,NULL)
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6201 and IdLanguage = 0) 
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6201,0,N'Tipo de verificación huella digital 1','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6201 and IdLanguage = 1)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6201,1,N'Verification type Fingerprint 1','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6201 and IdLanguage = 2)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6201,2,N'Τύπος επαλήθευσης Δακτυλικό αποτύπωμα','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6201 and IdLanguage = 3)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6201,3,N'Tipo de verificação Impressão digital 1','')
--Huella 2
IF NOT EXISTS (select [IdParameter] from [Parameter] where [IdParameter] = 6202)
insert into Parameter (IdParameter,IdParameterCategory,DataType,Value,[Values]) values (6202,0,1,1,NULL)
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6202 and IdLanguage = 0) 
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6202,0,N'Tipo de verificación huella digital 2','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6202 and IdLanguage = 1)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6202,1,N'Verification type Fingerprint 2','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6202 and IdLanguage = 2)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6202,2,N'Τύπος επαλήθευσης Δακτυλικό αποτύπωμα 2','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6202 and IdLanguage = 3)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6202,3,N'Tipo de verificação Impressão digital 2','')
--Huella 3
IF NOT EXISTS (select [IdParameter] from [Parameter] where [IdParameter] = 6205)
insert into Parameter (IdParameter,IdParameterCategory,DataType,Value,[Values]) values (6205,0,1,1,NULL)
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6205 and IdLanguage = 0) 
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6205,0,N'Tipo de verificación huella digital 3','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6205 and IdLanguage = 1)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6205,1,N'Verification type Fingerprint 3','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6205 and IdLanguage = 2)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6205,2,N'Τύπος επαλήθευσης Δακτυλικό αποτύπωμα 3','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6205 and IdLanguage = 3)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6205,3,N'Tipo de verificação Impressão digital 3','')

--Tarjeta
IF NOT EXISTS (select [IdParameter] from [Parameter] where [IdParameter] = 6204)
insert into Parameter (IdParameter,IdParameterCategory,DataType,Value,[Values]) values (6204,0,1,4,NULL)
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6204 and IdLanguage = 0)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6204,0,N'Tipo de verificación tarjeta de proximidad','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6204 and IdLanguage = 1)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6204,1,N'Verification type Password','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6204 and IdLanguage = 2)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6204,2,N'Τύπος επαλήθευσης Κάρτα εγγύτητας','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6204 and IdLanguage = 3)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6204,3,N'Tipo de verificação Cartão de proximidade','')
--Face
IF NOT EXISTS (select [IdParameter] from [Parameter] where [IdParameter] = 6215)
insert into Parameter (IdParameter,IdParameterCategory,DataType,Value,[Values]) values (6215,0,1,15,NULL)
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6215 and IdLanguage = 0)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6215,0,N'Tipo de verificación rostro','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6215 and IdLanguage = 1)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6215,1,N'Verification type Face','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6215 and IdLanguage = 2)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6215,2,N'Τύπος επαλήθευσης Πρόσωπο','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6215 and IdLanguage = 3)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6215,3,N'Tipo de verificação Face','')

--Algoritmo de huellas
IF NOT EXISTS (select [IdParameter] from [Parameter] where [IdParameter] = 6300)
insert into Parameter (IdParameter,IdParameterCategory,DataType,Value,[Values]) values (6300,0,4,0,'10,9')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6300 and IdLanguage = 0)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6300,0,N'Algoritmo para huella preferido','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6300 and IdLanguage = 1)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6300,1,N'Default fingerprint algorithm','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6300 and IdLanguage = 2)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6300,2,N'Προεπιλεγμένος αλγόριθμος δακτυλικών αποτυπωμάτων','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 6300 and IdLanguage = 3)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (6300,3,N'Algoritmo de impressão digital padrão','')

-- DB Version update required
IF NOT EXISTS (select [IdParameter] from [Parameter] where [IdParameter] = 10007)
insert into Parameter (IdParameter,IdParameterCategory,DataType,Value,[Values]) values (10007,0,4,'20190108',NULL)


-- Automatic users download 
IF NOT EXISTS (select [IdParameter] from [Parameter] where [IdParameter] = 3174)
insert into Parameter (IdParameter,IdParameterCategory,DataType,Value,[Values]) values (3174,0,0,'True',NULL)

IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 3174 and IdLanguage = 0)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (3174,0,N'Agregar usuarios al descargar registros','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 3174 and IdLanguage = 1)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (3174,1,N'Add users when downloading records','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 3174 and IdLanguage = 2)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (3174,2,N'Προσθέστε χρήστες κατά τη λήψη αρχείων','')
IF NOT EXISTS (select [IdParameter] from [ParameterName] where [IdParameter] = 3174 and IdLanguage = 3)
insert into ParameterName (IdParameter,IdLanguage,[Description],Comment) values (3174,3,N'Adicionar usuários ao baixar registros','')
