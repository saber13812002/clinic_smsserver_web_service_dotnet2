USE [master]
GO
/****** Object:  Database [Clinic]    Script Date: 11/03/2014 11:59:37 ******/
CREATE DATABASE [Clinic] ON  PRIMARY 
( NAME = N'Clinic', FILENAME = N'H:\mesbahsoft csharp projects\clinic\demo\Clinic.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Clinic_log', FILENAME = N'H:\mesbahsoft csharp projects\clinic\demo\Clinic_log.ldf' , SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Clinic] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Clinic].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Clinic] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [Clinic] SET ANSI_NULLS OFF
GO
ALTER DATABASE [Clinic] SET ANSI_PADDING OFF
GO
ALTER DATABASE [Clinic] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [Clinic] SET ARITHABORT OFF
GO
ALTER DATABASE [Clinic] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [Clinic] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [Clinic] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [Clinic] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [Clinic] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [Clinic] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [Clinic] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [Clinic] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [Clinic] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [Clinic] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [Clinic] SET  DISABLE_BROKER
GO
ALTER DATABASE [Clinic] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [Clinic] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [Clinic] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [Clinic] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [Clinic] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [Clinic] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [Clinic] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [Clinic] SET  READ_WRITE
GO
ALTER DATABASE [Clinic] SET RECOVERY FULL
GO
ALTER DATABASE [Clinic] SET  MULTI_USER
GO
ALTER DATABASE [Clinic] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [Clinic] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'Clinic', N'ON'
GO
USE [Clinic]
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 11/03/2014 11:59:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Split]
(
    @List varchar(max),
    @SplitOn nvarchar(5)
)
RETURNS @RtnValue table
(
    Id int identity(1,1),
    Value nvarchar(max)
)
AS
BEGIN
    While (Charindex(@SplitOn,@List)>0)
    Begin

        Insert Into @RtnValue (value)
        Select
        Value = ltrim(rtrim(Substring(@List,1,Charindex(@SplitOn,@List)-1)))

        Set @List = Substring(@List,Charindex(@SplitOn,@List)+len(@SplitOn),len(@List))
    End

    Insert Into @RtnValue (Value)
    Select Value = ltrim(rtrim(@List))

Return
END
GO
/****** Object:  Table [dbo].[setting]    Script Date: 11/03/2014 11:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[setting](
	[StartDay] [datetime] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Ceil]    Script Date: 11/03/2014 11:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
create FUNCTION [dbo].[Ceil](@x FLOAT(53))
RETURNS BIGINT
AS
BEGIN
	DECLARE @Result BIGINT

	IF @x >= 0
		SET @Result = CEILING(@x)
	ELSE
		SET @Result = FLOOR(@x)
	
	RETURN @Result
END
GO
/****** Object:  Table [dbo].[Appointment]    Script Date: 11/03/2014 11:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RequestTime] [nvarchar](50) NULL,
	[TimeTurn] [nvarchar](50) NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[NationalCode] [nvarchar](50) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[DateTurn] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SentSms]    Script Date: 11/03/2014 11:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SentSms](
	[RequestID] [nchar](10) NOT NULL,
	[MobileNumber] [nchar](11) NOT NULL,
	[MsgBody] [nvarchar](50) NOT NULL,
	[Delivered] [bit] NULL,
	[msgID] [bigint] NULL,
	[SectionID] [bigint] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 22 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 22 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 24 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 24 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 24 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'4         ', N'023301     ', N'Oct 28 2014  2:24PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'5         ', N'093323301  ', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'4         ', N'023301     ', N'Oct 28 2014  2:24PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'5         ', N'093323301  ', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'4         ', N'023301     ', N'Oct 28 2014  2:24PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'5         ', N'093323301  ', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'4         ', N'023301     ', N'Oct 28 2014  2:24PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'5         ', N'093323301  ', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'4         ', N'023301     ', N'Oct 28 2014  2:24PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'5         ', N'093323301  ', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'4         ', N'023301     ', N'Oct 28 2014  2:24PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'5         ', N'093323301  ', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'4         ', N'023301     ', N'Oct 28 2014  2:24PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'5         ', N'093323301  ', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'4         ', N'023301     ', N'Oct 28 2014  2:24PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'5         ', N'093323301  ', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'4         ', N'023301     ', N'Oct 28 2014  2:24PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'5         ', N'093323301  ', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'4         ', N'023301     ', N'Oct 28 2014  2:24PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'5         ', N'093323301  ', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'4         ', N'023301     ', N'Oct 28 2014  2:24PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'5         ', N'093323301  ', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'2         ', N'09332523301', N'Oct 28 2014  2:20PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'3         ', N'09332523301', N'Oct 28 2014  2:21PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'6         ', N'09332523301', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'4         ', N'023301     ', N'Oct 28 2014  2:24PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'5         ', N'093323301  ', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'4         ', N'023301     ', N'Oct 28 2014  2:24PM', NULL, NULL, 1)
INSERT [dbo].[SentSms] ([RequestID], [MobileNumber], [MsgBody], [Delivered], [msgID], [SectionID]) VALUES (N'5         ', N'093323301  ', N'Oct 28 2014  2:29PM', NULL, NULL, 1)
/****** Object:  Table [dbo].[Intermittence]    Script Date: 11/03/2014 11:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Intermittence](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VisitDateTime] [datetime] NOT NULL,
	[SectionID] [int] NOT NULL,
	[NationalityCode] [nchar](10) NOT NULL,
	[Telphone] [nchar](15) NOT NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Intermittence] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Intermittence] ON
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (1, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'11111111  ', N'09127579374    ', 1)
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (2, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'22222222  ', N'434434         ', 1)
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (3, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'33333333  ', N'09127579345    ', 0)
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (4, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'44444444  ', N'37734239       ', 1)
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (5, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'55555555  ', N'09127579322    ', 0)
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (6, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'66666666  ', N'5467891253678  ', 1)
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (7, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'77777777  ', N'54263798       ', 1)
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (8, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'88888888  ', N'54263798       ', 1)
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (9, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'99999999  ', N'54263798       ', 1)
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (10, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'10101010  ', N'09123456782    ', 0)
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (11, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'12121212  ', N'09123456787    ', 0)
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (12, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'131313131 ', N'54263798       ', 1)
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (13, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'1414141414', N'09123456782    ', 0)
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (14, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'151515115 ', N'54263798       ', 1)
INSERT [dbo].[Intermittence] ([ID], [VisitDateTime], [SectionID], [NationalityCode], [Telphone], [Status]) VALUES (15, CAST(0x0000A3D500EC7B10 AS DateTime), 1, N'1616161616', N'09123456782    ', 0)
SET IDENTITY_INSERT [dbo].[Intermittence] OFF
/****** Object:  UserDefinedFunction [dbo].[Fix]    Script Date: 11/03/2014 11:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
create FUNCTION [dbo].[Fix](@x FLOAT(53))
RETURNS BIGINT
AS
BEGIN
	DECLARE @Result BIGINT

	IF @x >= 0
		SET @Result = FLOOR(@x)
	ELSE
		SET @Result = CEILING(@x)
	
	RETURN @Result
END
GO
/****** Object:  Table [dbo].[Documents]    Script Date: 11/03/2014 11:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Documents](
	[CustomerID] [nchar](10) NULL,
	[document] [ntext] NULL,
	[image] [image] NULL,
	[ID] [bigint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 11/03/2014 11:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SectionID] [int] NULL,
	[StartTime] [int] NULL,
	[EndTime] [int] NULL,
	[RequestRateInHour] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 11/03/2014 11:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [nchar](10) NULL,
	[Fname] [nchar](10) NULL,
	[Lname] [nchar](10) NULL,
	[FatherName] [nchar](10) NULL,
	[Adress] [nvarchar](50) NULL,
	[IsuranceID] [nchar](10) NULL,
	[Telphone] [numeric](18, 0) NULL,
	[Mobile] [numeric](18, 0) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Customer] ([CustomerID], [Fname], [Lname], [FatherName], [Adress], [IsuranceID], [Telphone], [Mobile]) VALUES (N'11111111  ', N'صادق      ', N'صادقی     ', N'علی       ', N'فقثضصبدضتثب', N'234234    ', CAST(34234234 AS Numeric(18, 0)), CAST(9123456789 AS Numeric(18, 0)))
INSERT [dbo].[Customer] ([CustomerID], [Fname], [Lname], [FatherName], [Adress], [IsuranceID], [Telphone], [Mobile]) VALUES (N'  22222222', N' ناهید    ', N'توکلی     ', N'وحید      ', N'خیابان لال', N'456789    ', CAST(34567890 AS Numeric(18, 0)), CAST(912345678 AS Numeric(18, 0)))
/****** Object:  UserDefinedFunction [dbo].[civil_jdn]    Script Date: 11/03/2014 11:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
create FUNCTION [dbo].[civil_jdn](@Year AS INT,@Month AS INT,@Day AS INT,@CalendarType AS INT = -1) RETURNS INT
AS
BEGIN
	DECLARE @Result INT
	
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
    DECLARE @OYear AS INT
    DECLARE @OMonth AS INT
    DECLARE @ODay AS INT

	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	
	IF @CalendarType = -1
		SET @CalendarType = @Gregorian

    IF @CalendarType = @Gregorian AND ((@Year > 1582) OR 
        ((@Year = 1582) AND (@Month > 10)) OR 
        ((@Year = 1582) AND (@Month = 10) AND (@Day > 14))) 
    BEGIN
        SET @OYear = @Year
        SET @OMonth = @Month
        SET @ODay = @Day
        SET @Result = dbo.Fix((1461 * (@OYear + 4800 + dbo.Fix((@OMonth - 14) / CAST(12 AS REAL)))) / CAST(4 AS REAL)) 
            + dbo.Fix((367 * (@OMonth - 2 - 12 * (dbo.Fix((@OMonth - 14) / CAST(12 AS REAL))))) / CAST(12 AS REAL))
            - dbo.Fix((3 * (dbo.Fix((@OYear + 4900 + dbo.Fix((@OMonth - 14) / CAST(12 AS REAL))) / CAST(100 AS REAL)))) / CAST(4 AS REAL))
            + @ODay - 32075
	END
    ELSE
        SET @Result = dbo.julian_jdn(@Year, @Month, @Day)
    
	RETURN @Result
END
GO
/****** Object:  StoredProcedure [dbo].[GetIntermittence]    Script Date: 11/03/2014 11:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<MRezaee>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetIntermittence] 
	
	--@Date datetime
AS
BEGIN
 
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from Intermittence where DATEdiff(day,VisitDateTime,GETDATE())=1 and   [Status]=0

END
GO
/****** Object:  UserDefinedFunction [dbo].[persian_jdn]    Script Date: 11/03/2014 11:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[persian_jdn](@Year As INT,@Month As INT,@Day As INT) RETURNS INT AS
BEGIN
    DECLARE @PERSIAN_EPOCH INT
    SET @PERSIAN_EPOCH = 1948321 -- The JDN of 1 Farvardin 1

    DECLARE @epbase AS INT
    DECLARE @epyear AS INT
    DECLARE @mdays AS INT
    DECLARE @Result AS INT
    
    IF @Year >= 0
        SET @epbase = @Year - 474
    ELSE
        SET @epbase = @Year - 473
    
    SET @epyear = 474 + (@epbase % 2820)
    
    IF @Month <= 7
        SET @mdays = (@Month - 1) * 31
    ELSE
        SET @mdays = (@Month - 1) * 30 + 6
    
    SET @Result =
		  @Day
		+ @mdays
		+ dbo.Fix(((@epyear * 682) - 110) / CAST(2816 AS REAL))
		+ (@epyear - 1) * 365
		+ dbo.Fix(@epbase / CAST(2820 AS REAL)) * 1029983
		+ (@PERSIAN_EPOCH - 1)
		
	RETURN @Result
END
GO
/****** Object:  StoredProcedure [dbo].[SetSmsInfo]    Script Date: 11/03/2014 11:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Rezaei>

-- =============================================
CREATE PROCEDURE [dbo].[SetSmsInfo]
 @Ids ntext
,@SmsBody ntext	
AS
BEGIN
DECLARE c CURSOR READ_ONLY FAST_FORWARD FOR
   select Value from   dbo.split(@Ids,',')


	DECLARE @id Int

-- Open the cursor
OPEN c

FETCH NEXT FROM c INTO @id
WHILE (@@FETCH_STATUS = 0)
BEGIN
   --  select  ID,Telphone, VisitDateTime,SectionID  from Intermittence where ID=@id

   insert into SentSms ([RequestID]
      ,[MobileNumber]
      ,[MsgBody],SectionID
       ) 
    select  ID,Telphone, VisitDateTime,SectionID  from Intermittence where ID=@id
    FETCH NEXT FROM c INTO @id
END

	CLOSE c
DEALLOCATE c
	
	SET NOCOUNT ON;

  
END
GO
/****** Object:  StoredProcedure [dbo].[SetDecisiveIntermittence]    Script Date: 11/03/2014 11:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<MRouinfar>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE  PROCEDURE [dbo].[SetDecisiveIntermittence] 
	
@ID int,
@Status bit
AS
BEGIN
 
	update Intermittence set [Status]=@Status where ID=@ID
END
GO
/****** Object:  StoredProcedure [dbo].[SetCostumerInfo]    Script Date: 11/03/2014 11:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Rezaei>

-- =============================================
create PROCEDURE [dbo].[SetCostumerInfo]
@CustomerID nvarchar(10), @Fname  nvarchar(10), @Lname   nvarchar(10),
 @FatherName  nvarchar(10), @Adress  nvarchar(10), @IsuranceID  nvarchar(10), @Telphone  nvarchar(10), @Mobile  nvarchar(10)
	
AS
begin
   insert into Customer( CustomerID, Fname, Lname, FatherName, Adress, IsuranceID, Telphone, Mobile
       ) 
    values(@CustomerID, @Fname, @Lname, @FatherName, @Adress, @IsuranceID, @Telphone, @Mobile
    )
END
GO
/****** Object:  StoredProcedure [dbo].[SetAppointment]    Script Date: 11/03/2014 11:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Rezaei>

-- =============================================
CREATE PROCEDURE [dbo].[SetAppointment]
 @RequestTime  nvarchar(10), @TimeTurn   nvarchar(10),
 @DepartmentID  nvarchar(10), @NationalCode  nvarchar(10), @PhoneNumber  nvarchar(10), @DateTurn  nvarchar(10)
	
AS
begin
   insert into Appointment([RequestTime]
      ,[TimeTurn]
      ,[DepartmentID]
      ,[NationalCode]
      ,[PhoneNumber]
      ,[DateTurn]
       ) 
    values( @RequestTime, @TimeTurn, @DepartmentID, @NationalCode, @PhoneNumber, @DateTurn
    )
END
GO
/****** Object:  UserDefinedFunction [dbo].[ToPersianDate]    Script Date: 11/03/2014 11:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
create FUNCTION [dbo].[ToPersianDate](
	@Date datetime--,
	--@SEPARATOR AS CHAR(1) = '/'
	) RETURNS CHAR(10) --RETURNS CHAR(10)
AS  
BEGIN
	--DECLARE @Result CHAR(10)
	DECLARE @Result CHAR(10)
	DECLARE @DateStr VARCHAR(10)
	DECLARE @SEPARATOR CHAR(1)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
		DECLARE @Time time 
		DECLARE @Minute INT 
		 
	SET @DateStr = CAST(CAST(@Date as DATE) AS VARCHAR(10))
	set @Time = Cast(cast(@Date as time)  as time)
	SET @SEPARATOR = '-'
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @DateStr)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@DateStr, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @DateStr, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@DateStr,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@DateStr)
		BEGIN
			SET @temp = RIGHT(@DateStr,LEN(@DateStr) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- civil_persian
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.civil_jdn(@IYear,@IMonth,@IDay,@Gregorian)
		
		-- jdn_persian
		DECLARE @depoch AS INT
		DECLARE @cycle AS INT
		DECLARE @cyear AS INT
		DECLARE @ycycle AS INT
		DECLARE @aux1 AS INT
		DECLARE @aux2 AS INT
		DECLARE @yday AS INT
	    
		SET @depoch = @jdn - dbo.persian_jdn(475, 1, 1)
		SET @cycle = dbo.Fix(@depoch / CAST(1029983 AS REAL))
		SET @cyear = @depoch % 1029983
		IF @cyear = 1029982
			SET @ycycle = 2820
		ELSE
		BEGIN
			SET @aux1 = dbo.Fix(@cyear / CAST(366 AS REAL))
			SET @aux2 = @cyear % 366
			SET @ycycle = FLOOR(((2134 * @aux1) + (2816 * @aux2) + 2815) / CAST(1028522 AS REAL)) + @aux1 + 1
		END
	    
		SET @OYear = @ycycle + (2820 * @cycle) + 474
		IF @OYear <= 0 
			SET @OYear = @OYear - 1
	    
		SET @yday = (@jdn - dbo.persian_jdn(@OYear, 1, 1)) + 1
		IF @yday <= 186 
			SET @OMonth = dbo.Ceil(@yday / CAST(31 AS REAL))
		ELSE
			SET @OMonth = dbo.Ceil((@yday - 6) / CAST(30 AS REAL))
	    
		SET @ODay = (@jdn - dbo.persian_jdn(@OYear, @OMonth, 1)) + 1
		
		SET @Result =	RIGHT('0000'	+ CAST(@OYear	AS VARCHAR(10)),4) + '/' + 
						RIGHT('0'		+ CAST(@OMonth	AS VARCHAR(10)),2) + '/' + 
						RIGHT('0'		+ CAST(@ODay	AS VARCHAR(10)),2) +CAST(@Time	AS VARCHAR(10)) 
	END
	--REPLACE(Cast(AllocationMap.CommoditiesCode as nvarchar(4000)),','+@Code+',',',')
	RETURN @Result
END
GO
/****** Object:  StoredProcedure [dbo].[GetCalendar]    Script Date: 11/03/2014 11:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<MRezaee>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCalendar] 
	
	--@Date datetime
AS
BEGIN
 
	SET NOCOUNT ON;
       -- Insert statements for procedure here
	  SELECT ID, [dbo].ToPersianDate( VisitDateTime) as Date,SectionID,NationalityCode,Customer.Fname,Customer.Lname
	  from Intermittence
	  left outer join Customer on Customer.CustomerID=Intermittence.NationalityCode
	  where DATEdiff(day,VisitDateTime,GETDATE())=1 and Status=1

END
GO
/****** Object:  Default [DF_Intermittence_Status]    Script Date: 11/03/2014 11:59:40 ******/
ALTER TABLE [dbo].[Intermittence] ADD  CONSTRAINT [DF_Intermittence_Status]  DEFAULT ((0)) FOR [Status]
GO
