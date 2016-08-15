USE [master]
GO
/****** Object:  Database [DemoMisrLab_V1]    Script Date: 8/15/2016 11:28:25 AM ******/
CREATE DATABASE [DemoMisrLab_V1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Lab', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\DemoMisrLab_V1_New.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Lab_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\DemoMisrLab_V1_New_log.ldf' , SIZE = 29504KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DemoMisrLab_V1] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DemoMisrLab_V1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DemoMisrLab_V1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET ARITHABORT OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [DemoMisrLab_V1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DemoMisrLab_V1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DemoMisrLab_V1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DemoMisrLab_V1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DemoMisrLab_V1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET RECOVERY FULL 
GO
ALTER DATABASE [DemoMisrLab_V1] SET  MULTI_USER 
GO
ALTER DATABASE [DemoMisrLab_V1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DemoMisrLab_V1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DemoMisrLab_V1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DemoMisrLab_V1] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [DemoMisrLab_V1]
GO
/****** Object:  StoredProcedure [dbo].[AddPatientRequest]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddPatientRequest] 
@patientId int, @doctorRefId int, @organizationId int, @comment nvarchar(255), @priority varchar(20),
@paid decimal, @totalOrganizationCost decimal, @totalPatientCost decimal, @extraDiscount decimal,
@extraCost decimal, @attachmentSession varchar(50), @analyzesIds varchar(500)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @requestNumber INT;

    -- Insert statements for procedure here
	select @requestNumber EXEC GetRequestNumber ;
	-- Update RunNumber set RunNum = @runNumber + 1;
	select @requestNumber;
END


GO
/****** Object:  StoredProcedure [dbo].[GetAnalysisRunNumber]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GetAnalysisRunNumber] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @runNumber INT;

    -- Insert statements for procedure here
	select @runNumber =  RunNum from RunNumber;
	Update RunNumber set RunNum = @runNumber + 1;
	select @runNumber;
END


GO
/****** Object:  StoredProcedure [dbo].[GetPatientRefID]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GetPatientRefID] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @refID INT;

    -- Insert statements for procedure here
	select @refID =  LastPatientRefID from PatientRefID;
	Update PatientRefID set LastPatientRefID = @refID + 1;
	select @refID;
END


GO
/****** Object:  StoredProcedure [dbo].[GetPlanNumber]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[GetPlanNumber] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @planNumber INT;

    -- Insert statements for procedure here
	select @planNumber =  PlanNum from PlanNumber;
	Update PlanNumber set PlanNum = @planNumber + 1;
	select @planNumber;
END


GO
/****** Object:  StoredProcedure [dbo].[GetRequestNumber]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRequestNumber] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @requestNumber VARCHAR(10);

    -- Insert statements for procedure here
	select @requestNumber =  (Prefix + '-' + CONVERT(varchar(10), Number) )  from RequestNumber;
	Update RequestNumber set Number = (select top(1) Number from RequestNumber) + 1;
	select @requestNumber;
END


GO
/****** Object:  Table [dbo].[Analysis]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Analysis](
	[AnalysisID] [int] IDENTITY(1,1) NOT NULL,
	[AnalysisCode] [varchar](50) NOT NULL,
	[AnalysisName] [nvarchar](250) NOT NULL,
	[SampleTypeID] [int] NOT NULL,
	[CostPrice] [decimal](18, 0) NOT NULL,
	[UnitId] [int] NOT NULL,
 CONSTRAINT [PK_Analysis] PRIMARY KEY CLUSTERED 
(
	[AnalysisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AnalysisResultDetails]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AnalysisResultDetails](
	[AnalysisDetailId] [int] IDENTITY(1,1) NOT NULL,
	[AnalysisId] [int] NOT NULL,
	[ResultTitle] [varchar](100) NOT NULL,
	[Description] [varchar](250) NULL,
	[UnitOfMeasure] [varchar](50) NOT NULL,
	[MinimumValue] [varchar](20) NOT NULL,
	[MaximumValue] [varchar](20) NOT NULL,
	[MaleNormalRange] [varchar](50) NOT NULL,
	[FemaleNormalRange] [varchar](50) NOT NULL,
	[DataType] [varchar](10) NOT NULL,
	[SectionTitle] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AnalysisDetails] PRIMARY KEY CLUSTERED 
(
	[AnalysisDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CategoryType]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CategoryType](
	[CategoryTypeID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryTypeName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_CategoryType] PRIMARY KEY CLUSTERED 
(
	[CategoryTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[City]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[CityID] [int] IDENTITY(1,1) NOT NULL,
	[ProvinceID] [int] NOT NULL,
	[CityName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Condition]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Condition](
	[ConditionID] [int] NOT NULL,
	[ConditionName] [varchar](50) NOT NULL,
	[RequiredData] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Condition] PRIMARY KEY CLUSTERED 
(
	[ConditionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Device]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Device](
	[DeviceId] [int] IDENTITY(1,1) NOT NULL,
	[DeviceName] [varchar](100) NOT NULL,
	[DeviceCode] [varchar](50) NULL,
	[DeviceDescription] [varchar](255) NULL,
	[Capacity] [int] NOT NULL,
 CONSTRAINT [PK_Device] PRIMARY KEY CLUSTERED 
(
	[DeviceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DeviceAnalysis]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceAnalysis](
	[DeviceAnalysisId] [int] IDENTITY(1,1) NOT NULL,
	[RequestedAnalysisId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[ReceiveDate] [datetime] NOT NULL,
	[PlanId] [int] NOT NULL,
	[RakeNumber] [int] NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[DeviceAnalysisId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DevicePlan]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DevicePlan](
	[PlanId] [int] IDENTITY(1,1) NOT NULL,
	[PlanNumber] [varchar](10) NOT NULL,
	[TestDate] [datetime] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[UnitId] [int] NOT NULL,
	[DeviceId] [int] NOT NULL,
 CONSTRAINT [PK_Plan] PRIMARY KEY CLUSTERED 
(
	[PlanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DoctorRef]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DoctorRef](
	[DoctorRefID] [int] IDENTITY(1,1) NOT NULL,
	[DoctorName] [nvarchar](100) NOT NULL,
	[SpecialID] [int] NULL,
	[CityID] [int] NULL,
	[Address] [nvarchar](100) NULL,
	[Mobile] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[InsertionDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DoctorRef] PRIMARY KEY CLUSTERED 
(
	[DoctorRefID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DoctorSpecialization]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoctorSpecialization](
	[SpecialID] [int] IDENTITY(1,1) NOT NULL,
	[SpecialName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DoctorSpecialization] PRIMARY KEY CLUSTERED 
(
	[SpecialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employee]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[JobDate] [datetime] NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
	[CityID] [int] NULL,
	[BirthDay] [date] NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[CurrentBranchID] [int] NOT NULL,
	[JobTitleID] [int] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Entity]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entity](
	[EntityID] [int] IDENTITY(1,1) NOT NULL,
	[EntityName] [nvarchar](30) NOT NULL,
	[EntityDescription] [nvarchar](255) NULL,
 CONSTRAINT [PK_Entity] PRIMARY KEY CLUSTERED 
(
	[EntityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EntityAction]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntityAction](
	[ActionID] [int] IDENTITY(1,1) NOT NULL,
	[ActionName] [nvarchar](10) NOT NULL,
	[ActionDescription] [nvarchar](255) NULL,
 CONSTRAINT [PK_EntityAction] PRIMARY KEY CLUSTERED 
(
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobTitle]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobTitle](
	[JobTitleID] [int] IDENTITY(1,1) NOT NULL,
	[JobCode] [nvarchar](20) NOT NULL,
	[JobTitle] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_JobTitle] PRIMARY KEY CLUSTERED 
(
	[JobTitleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LabBranch]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LabBranch](
	[BranchID] [int] IDENTITY(1,1) NOT NULL,
	[BranchName] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
	[CityID] [int] NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[EstablishedDate] [date] NOT NULL,
 CONSTRAINT [PK_LabBranch] PRIMARY KEY CLUSTERED 
(
	[BranchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NotDeliveredAnalysis]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotDeliveredAnalysis](
	[NotDeliveredId] [int] IDENTITY(1,1) NOT NULL,
	[RequestedAnalysisId] [int] NOT NULL,
	[NotDeliveredDate] [datetime] NOT NULL,
	[ReasonId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
 CONSTRAINT [PK_NotDeliveredAnalysis] PRIMARY KEY CLUSTERED 
(
	[NotDeliveredId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NotDeliveredReason]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NotDeliveredReason](
	[ErrorId] [int] IDENTITY(1,1) NOT NULL,
	[ErrorMessage] [varchar](255) NOT NULL,
 CONSTRAINT [PK_NotDeliveredReason] PRIMARY KEY CLUSTERED 
(
	[ErrorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Organization]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organization](
	[OrganizationID] [int] IDENTITY(1,1) NOT NULL,
	[OrganizationName] [nvarchar](50) NOT NULL,
	[PackageID] [int] NOT NULL,
	[InsertionDate] [datetime] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[PatientCanReceiveResult] [bit] NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[OrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrganizationCondition]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrganizationCondition](
	[OrganizationConditionID] [int] NOT NULL,
	[OrganizationID] [int] NOT NULL,
	[ConditionID] [int] NOT NULL,
	[IsFound] [bit] NULL,
 CONSTRAINT [PK_OrginzationCondition] PRIMARY KEY CLUSTERED 
(
	[OrganizationConditionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrganizationConsuming]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrganizationConsuming](
	[OrganizationID] [int] NOT NULL,
	[AnalysisID] [int] NOT NULL,
	[ConsumingPercentage] [decimal](18, 0) NULL,
 CONSTRAINT [PK_OrganizationConsuming] PRIMARY KEY CLUSTERED 
(
	[OrganizationID] ASC,
	[AnalysisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrganizationInfo]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrganizationInfo](
	[OrganizationInfoID] [int] NOT NULL,
	[OrganizationID] [int] NOT NULL,
	[Address] [nvarchar](50) NULL,
	[CityID] [int] NULL,
	[Phone] [nvarchar](15) NULL,
 CONSTRAINT [PK_OrganizationInfo] PRIMARY KEY CLUSTERED 
(
	[OrganizationInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Package]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Package](
	[PackageID] [int] IDENTITY(1,1) NOT NULL,
	[PackageName] [nvarchar](50) NOT NULL,
	[PackageDiscription] [nvarchar](50) NOT NULL,
	[CategoryTypeID] [int] NOT NULL,
 CONSTRAINT [PK_Package] PRIMARY KEY CLUSTERED 
(
	[PackageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PackageCostList]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackageCostList](
	[PackageID] [int] NOT NULL,
	[AnalysisID] [int] NOT NULL,
	[CurrentAnalysisDiscountRate] [decimal](18, 0) NOT NULL,
	[NewAnalysisDiscountRate] [decimal](18, 0) NULL,
 CONSTRAINT [PK_PackageCostList] PRIMARY KEY CLUSTERED 
(
	[PackageID] ASC,
	[AnalysisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Patient]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[PatientID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Gender] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NULL,
	[CityID] [int] NULL,
	[NationalID] [nchar](16) NULL,
	[BirthDate] [datetime] NULL,
	[Mobile] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[EmployeeID] [int] NOT NULL,
	[ReferenceID] [int] NOT NULL,
	[RegisteredDate] [datetime] NOT NULL,
	[LastDataModified] [datetime] NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientRefID]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientRefID](
	[LastPatientRefID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientRequest]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientRequest](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NOT NULL,
	[RequestDate] [datetime] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[Comment] [nvarchar](255) NULL,
	[DoctorRefID] [int] NULL,
	[Priority] [varchar](10) NULL,
	[OrganizationID] [int] NULL,
	[RequestedRefID] [varchar](20) NOT NULL,
	[AttachmentSession] [varchar](50) NULL,
	[ExtraDiscount] [decimal](18, 0) NULL,
	[ExtraCost] [decimal](18, 0) NULL,
	[TotalPatientCost] [decimal](18, 0) NULL,
	[TotalOrganizationCost] [decimal](18, 0) NULL,
	[RequestNumber] [varchar](16) NOT NULL,
 CONSTRAINT [PK_PatientRequest] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientRequestAnalysis]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientRequestAnalysis](
	[RequestedAnalysisID] [int] IDENTITY(1,1) NOT NULL,
	[RequestID] [int] NOT NULL,
	[AnalysisID] [int] NOT NULL,
	[RequestDate] [datetime] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[RunNumber] [varchar](30) NULL,
 CONSTRAINT [PK_PatientRequests] PRIMARY KEY CLUSTERED 
(
	[RequestedAnalysisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientRequestAnalysisStatus]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientRequestAnalysisStatus](
	[RequestAnalysisStatusID] [int] IDENTITY(1,1) NOT NULL,
	[RequestedAnalysisID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
	[StatusDate] [datetime] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[Comment] [nvarchar](255) NULL,
 CONSTRAINT [PK_PatientRequestAnalysisStatus] PRIMARY KEY CLUSTERED 
(
	[RequestAnalysisStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientRequestPayment]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientRequestPayment](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[RequestID] [int] NOT NULL,
	[PaidAmount] [decimal](18, 0) NULL,
	[PaymentDate] [datetime] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[Comment] [text] NULL,
 CONSTRAINT [PK_RequestedAnalyzes] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientRequestStatus]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientRequestStatus](
	[RequestStatusID] [int] IDENTITY(1,1) NOT NULL,
	[RequestID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
	[StatusDate] [datetime] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[Comment] [varchar](255) NULL,
 CONSTRAINT [PK_PatientRequestStatus] PRIMARY KEY CLUSTERED 
(
	[RequestStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Permission]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permission](
	[EntityID] [int] NOT NULL,
	[ActionID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[InsertionDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Permission] PRIMARY KEY CLUSTERED 
(
	[EntityID] ASC,
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlanNumber]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanNumber](
	[PlanNum] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Priority]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Priority](
	[PriorityID] [int] IDENTITY(1,1) NOT NULL,
	[PriorityCode] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Priorities] PRIMARY KEY CLUSTERED 
(
	[PriorityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Province]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Province](
	[ProvinceID] [int] IDENTITY(1,1) NOT NULL,
	[CountryID] [int] NOT NULL,
	[ProvinceName] [nchar](20) NOT NULL,
 CONSTRAINT [PK_Province] PRIMARY KEY CLUSTERED 
(
	[ProvinceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RejectedAnalysis]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RejectedAnalysis](
	[RejectedId] [int] IDENTITY(1,1) NOT NULL,
	[RequestedAnalysisId] [int] NOT NULL,
	[RejectionDate] [datetime] NOT NULL,
	[ReasonId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
 CONSTRAINT [PK_RejectedAnalysis] PRIMARY KEY CLUSTERED 
(
	[RejectedId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RejectionReason]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RejectionReason](
	[ErrorId] [int] IDENTITY(1,1) NOT NULL,
	[ErrorMessage] [varchar](255) NOT NULL,
 CONSTRAINT [PK_RejectionMessage] PRIMARY KEY CLUSTERED 
(
	[ErrorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RequestedAnalysisResult]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RequestedAnalysisResult](
	[RequestedAnalysisResultId] [int] IDENTITY(1,1) NOT NULL,
	[RequestedAnalysisId] [int] NOT NULL,
	[ResultDate] [datetime] NOT NULL,
	[ResultValue] [varchar](50) NOT NULL,
	[DoctorResultValue] [varchar](50) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[EditedByQC] [bit] NOT NULL,
	[AnalysisDetailId] [int] NULL,
 CONSTRAINT [PK_RequestedAnalysisResult] PRIMARY KEY CLUSTERED 
(
	[RequestedAnalysisResultId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RequestNumber]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RequestNumber](
	[Prefix] [varchar](5) NOT NULL,
	[Number] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](30) NOT NULL,
	[RoleDescription] [nvarchar](255) NULL,
	[InsertionDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RunNumber]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RunNumber](
	[RunNum] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SampleSeparation]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SampleSeparation](
	[SeparatedSampleId] [int] IDENTITY(1,1) NOT NULL,
	[SeparatedSampleName] [varchar](50) NOT NULL,
	[SampleId] [int] NOT NULL,
 CONSTRAINT [PK_SampleSeparation] PRIMARY KEY CLUSTERED 
(
	[SeparatedSampleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SampleType]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SampleType](
	[SampleTypeID] [int] IDENTITY(1,1) NOT NULL,
	[SampleType] [varchar](20) NOT NULL,
 CONSTRAINT [PK_SampleType] PRIMARY KEY CLUSTERED 
(
	[SampleTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Status]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusIdentifier] [nvarchar](50) NOT NULL,
	[StatusName] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Unit]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Unit](
	[UnitId] [int] IDENTITY(1,1) NOT NULL,
	[UnitName] [varchar](50) NOT NULL,
	[UnitDescription] [nvarchar](255) NULL,
 CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[UnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UnitDevice]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitDevice](
	[UnitId] [int] NOT NULL,
	[DeviceId] [int] NOT NULL,
	[SeparatedSampleId] [int] NOT NULL,
	[IsDefaultDevice] [bit] NOT NULL,
 CONSTRAINT [PK_UnitDevice] PRIMARY KEY CLUSTERED 
(
	[UnitId] ASC,
	[DeviceId] ASC,
	[SeparatedSampleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[UserPassword] [nvarchar](50) NOT NULL,
	[LastLoginDate] [datetime] NOT NULL,
	[IsAdmin] [bit] NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[Analysis_Unit_Sample]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Analysis_Unit_Sample]
AS
SELECT        dbo.Analysis.AnalysisID, dbo.Analysis.AnalysisCode, dbo.Analysis.AnalysisName, dbo.Analysis.CostPrice, dbo.SampleType.SampleTypeID, dbo.SampleType.SampleType, dbo.Unit.UnitId, dbo.Unit.UnitName, 
                         dbo.Unit.UnitDescription
FROM            dbo.Analysis INNER JOIN
                         dbo.SampleType ON dbo.Analysis.SampleTypeID = dbo.SampleType.SampleTypeID INNER JOIN
                         dbo.Unit ON dbo.Analysis.UnitId = dbo.Unit.UnitId


GO
/****** Object:  View [dbo].[AnalysisResult_Details]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AnalysisResult_Details]
AS
SELECT        dbo.AnalysisResultDetails.AnalysisDetailId, dbo.AnalysisResultDetails.ResultTitle, dbo.AnalysisResultDetails.Description, dbo.AnalysisResultDetails.UnitOfMeasure, dbo.AnalysisResultDetails.MinimumValue, 
                         dbo.AnalysisResultDetails.MaximumValue, dbo.AnalysisResultDetails.MaleNormalRange, dbo.AnalysisResultDetails.FemaleNormalRange, dbo.AnalysisResultDetails.DataType, 
                         dbo.AnalysisResultDetails.SectionTitle, dbo.RequestedAnalysisResult.RequestedAnalysisResultId, dbo.RequestedAnalysisResult.RequestedAnalysisId, dbo.RequestedAnalysisResult.ResultDate, 
                         dbo.RequestedAnalysisResult.ResultValue, dbo.RequestedAnalysisResult.DoctorResultValue, dbo.RequestedAnalysisResult.EmployeeId, dbo.RequestedAnalysisResult.EditedByQC, dbo.Analysis.AnalysisID, 
                         dbo.Analysis.AnalysisCode, dbo.Analysis.AnalysisName, dbo.Analysis.CostPrice, dbo.Analysis.UnitId, dbo.Analysis.SampleTypeID
FROM            dbo.AnalysisResultDetails INNER JOIN
                         dbo.RequestedAnalysisResult ON dbo.AnalysisResultDetails.AnalysisDetailId = dbo.RequestedAnalysisResult.AnalysisDetailId INNER JOIN
                         dbo.Analysis ON dbo.AnalysisResultDetails.AnalysisId = dbo.Analysis.AnalysisID


GO
/****** Object:  View [dbo].[Patient_PatientRequest]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Patient_PatientRequest]
AS
SELECT        dbo.Patient.FirstName, dbo.Patient.MiddleName, dbo.Patient.LastName, dbo.Patient.Gender, dbo.Patient.Address, dbo.Patient.CityID, dbo.Patient.NationalID, dbo.Patient.BirthDate, dbo.Patient.Mobile, 
                         dbo.Patient.Phone, dbo.Patient.Email, dbo.Patient.ReferenceID, dbo.Patient.RegisteredDate, dbo.Patient.LastDataModified, dbo.PatientRequest.RequestID, dbo.PatientRequest.RequestDate, 
                         dbo.PatientRequest.EmployeeID, dbo.PatientRequest.Comment, dbo.PatientRequest.DoctorRefID, dbo.PatientRequest.Priority, dbo.PatientRequest.RequestedRefID, dbo.PatientRequest.AttachmentSession, 
                         dbo.PatientRequest.PatientID, dbo.PatientRequest.ExtraDiscount, dbo.PatientRequest.ExtraCost, dbo.PatientRequest.TotalPatientCost, dbo.PatientRequest.TotalOrganizationCost, 
                         dbo.PatientRequest.RequestNumber, dbo.Organization.OrganizationID, dbo.Organization.OrganizationName, dbo.Organization.InsertionDate, dbo.Organization.PatientCanReceiveResult, dbo.Package.PackageID, 
                         dbo.Package.PackageName, dbo.Package.PackageDiscription, dbo.CategoryType.CategoryTypeID, dbo.CategoryType.CategoryTypeName
FROM            dbo.Patient INNER JOIN
                         dbo.PatientRequest ON dbo.Patient.PatientID = dbo.PatientRequest.PatientID INNER JOIN
                         dbo.Organization ON dbo.PatientRequest.OrganizationID = dbo.Organization.OrganizationID INNER JOIN
                         dbo.Package ON dbo.Organization.PackageID = dbo.Package.PackageID INNER JOIN
                         dbo.CategoryType ON dbo.Package.CategoryTypeID = dbo.CategoryType.CategoryTypeID


GO
/****** Object:  View [dbo].[Patient_PatientRequest_AllStatuses]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Patient_PatientRequest_AllStatuses]
AS
SELECT        dbo.PatientRequest.RequestDate, dbo.PatientRequest.EmployeeID AS PatientRequestEmployeeID, dbo.PatientRequest.Comment AS PatientRequestComment, dbo.PatientRequest.DoctorRefID, 
                         dbo.PatientRequest.Priority, dbo.PatientRequest.RequestedRefID, dbo.PatientRequest.AttachmentSession, dbo.PatientRequestStatus.RequestStatusID, dbo.PatientRequestStatus.RequestID, 
                         dbo.PatientRequestStatus.StatusDate, dbo.PatientRequestStatus.EmployeeID AS PatientRequestStatusEmployeeID, dbo.PatientRequestStatus.Comment AS PatientRequestStatusComment, 
                         dbo.Status.StatusIdentifier, dbo.Status.StatusName, dbo.Status.Description, dbo.Status.StatusID AS PatientRequestStatusID, dbo.Patient.PatientID, dbo.Patient.FirstName, dbo.Patient.MiddleName, 
                         dbo.Patient.LastName, dbo.Patient.Gender, dbo.Patient.Address, dbo.Patient.CityID, dbo.Patient.NationalID, dbo.Patient.BirthDate, dbo.Patient.Mobile, dbo.Patient.Phone, dbo.Patient.Email, 
                         dbo.Patient.ReferenceID, dbo.Patient.RegisteredDate, dbo.Patient.LastDataModified, dbo.PatientRequest.ExtraDiscount, dbo.PatientRequest.ExtraCost, dbo.PatientRequest.TotalPatientCost, 
                         dbo.PatientRequest.TotalOrganizationCost, dbo.PatientRequest.RequestNumber, dbo.CategoryType.CategoryTypeID, dbo.CategoryType.CategoryTypeName, dbo.Package.PackageID, dbo.Package.PackageName, 
                         dbo.Package.PackageDiscription, dbo.Organization.OrganizationName, dbo.Organization.InsertionDate, dbo.Organization.PatientCanReceiveResult
FROM            dbo.PatientRequest INNER JOIN
                         dbo.PatientRequestStatus ON dbo.PatientRequest.RequestID = dbo.PatientRequestStatus.RequestID INNER JOIN
                         dbo.Status ON dbo.PatientRequestStatus.StatusID = dbo.Status.StatusID INNER JOIN
                         dbo.Patient ON dbo.PatientRequest.PatientID = dbo.Patient.PatientID INNER JOIN
                         dbo.Organization ON dbo.PatientRequest.OrganizationID = dbo.Organization.OrganizationID INNER JOIN
                         dbo.Package ON dbo.Organization.PackageID = dbo.Package.PackageID INNER JOIN
                         dbo.CategoryType ON dbo.Package.CategoryTypeID = dbo.CategoryType.CategoryTypeID


GO
/****** Object:  View [dbo].[Patient_PatientRequest_LastStatus]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Patient_PatientRequest_LastStatus]
AS
SELECT        dbo.PatientRequest.RequestDate, dbo.PatientRequest.EmployeeID AS PatientRequestEmployeeID, dbo.PatientRequest.Comment AS PatientRequestComment, dbo.PatientRequest.DoctorRefID, 
                         dbo.PatientRequest.Priority, dbo.PatientRequest.RequestedRefID, dbo.PatientRequest.AttachmentSession, dbo.PatientRequestStatus.RequestStatusID, dbo.PatientRequestStatus.RequestID, 
                         dbo.PatientRequestStatus.StatusDate, dbo.PatientRequestStatus.EmployeeID AS PatientRequestStatusEmployeeID, dbo.PatientRequestStatus.Comment AS PatientRequestStatusComment, 
                         dbo.Status.StatusIdentifier, dbo.Status.StatusName, dbo.Status.Description, dbo.Status.StatusID AS PatientRequestStatusID, dbo.Patient.PatientID, dbo.Patient.FirstName, dbo.Patient.MiddleName, 
                         dbo.Patient.LastName, dbo.Patient.Gender, dbo.Patient.Address, dbo.Patient.CityID, dbo.Patient.NationalID, dbo.Patient.BirthDate, dbo.Patient.Mobile, dbo.Patient.Phone, dbo.Patient.Email, 
                         dbo.Patient.ReferenceID, dbo.Patient.RegisteredDate, dbo.Patient.LastDataModified, dbo.PatientRequest.ExtraDiscount, dbo.PatientRequest.ExtraCost, dbo.PatientRequest.TotalPatientCost, 
                         dbo.PatientRequest.TotalOrganizationCost, dbo.PatientRequest.RequestNumber, dbo.Package.PackageID, dbo.Package.PackageName, dbo.Package.PackageDiscription, dbo.CategoryType.CategoryTypeID, 
                         dbo.CategoryType.CategoryTypeName, dbo.Organization.OrganizationID, dbo.Organization.OrganizationName, dbo.Organization.InsertionDate, dbo.Organization.PatientCanReceiveResult
FROM            dbo.PatientRequest INNER JOIN
                         dbo.PatientRequestStatus ON dbo.PatientRequest.RequestID = dbo.PatientRequestStatus.RequestID INNER JOIN
                             (SELECT        RequestID, MAX(RequestStatusID) AS LastStausID
                               FROM            dbo.PatientRequestStatus AS PatientRequestStatus_1
                               GROUP BY RequestID) AS LS ON LS.RequestID = dbo.PatientRequestStatus.RequestID AND LS.LastStausID = dbo.PatientRequestStatus.RequestStatusID INNER JOIN
                         dbo.Status ON dbo.PatientRequestStatus.StatusID = dbo.Status.StatusID INNER JOIN
                         dbo.Patient ON dbo.PatientRequest.PatientID = dbo.Patient.PatientID INNER JOIN
                         dbo.Organization ON dbo.PatientRequest.OrganizationID = dbo.Organization.OrganizationID INNER JOIN
                         dbo.Package ON dbo.Organization.PackageID = dbo.Package.PackageID INNER JOIN
                         dbo.CategoryType ON dbo.Package.CategoryTypeID = dbo.CategoryType.CategoryTypeID


GO
/****** Object:  View [dbo].[Patient_PatientRequest_PatientRequestAnalysis_AllStatuses]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Patient_PatientRequest_PatientRequestAnalysis_AllStatuses]
AS
SELECT        dbo.PatientRequestAnalysis.RequestID, dbo.PatientRequestAnalysis.AnalysisID, dbo.PatientRequestAnalysis.EmployeeID, dbo.PatientRequestAnalysis.RunNumber, dbo.Status.StatusIdentifier, 
                         dbo.Status.StatusName, dbo.Status.Description, dbo.PatientRequestAnalysisStatus.StatusID, dbo.PatientRequestAnalysisStatus.StatusDate, 
                         dbo.PatientRequestAnalysisStatus.EmployeeID AS PatientRequestAnalysisStatusEmployeeId, dbo.PatientRequestAnalysisStatus.Comment AS PatientRequestAnalysisStatusComment, 
                         dbo.PatientRequestAnalysisStatus.RequestAnalysisStatusID, dbo.PatientRequestAnalysisStatus.RequestedAnalysisID, dbo.Analysis.AnalysisCode, dbo.Analysis.AnalysisName, dbo.Analysis.SampleTypeID, 
                         dbo.Analysis.CostPrice, dbo.PatientRequest.RequestDate, dbo.PatientRequest.DoctorRefID, dbo.PatientRequest.Priority, dbo.PatientRequest.RequestedRefID, dbo.PatientRequest.AttachmentSession, 
                         dbo.PatientRequest.ExtraDiscount, dbo.PatientRequest.ExtraCost, dbo.PatientRequest.TotalPatientCost, dbo.PatientRequest.TotalOrganizationCost, dbo.PatientRequest.RequestNumber, 
                         dbo.SampleType.SampleType, dbo.Patient.PatientID, dbo.Patient.FirstName, dbo.Patient.MiddleName, dbo.Patient.LastName, dbo.Patient.Gender, dbo.Patient.Address, dbo.Patient.NationalID, 
                         dbo.Patient.BirthDate, dbo.Patient.Mobile, dbo.Patient.Phone, dbo.Patient.Email, dbo.Patient.CityID, dbo.Patient.ReferenceID, dbo.Patient.RegisteredDate, dbo.Patient.LastDataModified, dbo.Unit.UnitId, 
                         dbo.Unit.UnitName, dbo.Unit.UnitDescription, dbo.Organization.OrganizationID, dbo.Organization.OrganizationName, dbo.Organization.InsertionDate, dbo.Organization.PatientCanReceiveResult, 
                         dbo.CategoryType.CategoryTypeID, dbo.CategoryType.CategoryTypeName, dbo.Package.PackageID, dbo.Package.PackageName, dbo.Package.PackageDiscription
FROM            dbo.PatientRequestAnalysis INNER JOIN
                         dbo.PatientRequestAnalysisStatus ON dbo.PatientRequestAnalysis.RequestedAnalysisID = dbo.PatientRequestAnalysisStatus.RequestedAnalysisID INNER JOIN
                         dbo.Status ON dbo.PatientRequestAnalysisStatus.StatusID = dbo.Status.StatusID INNER JOIN
                         dbo.Analysis ON dbo.PatientRequestAnalysis.AnalysisID = dbo.Analysis.AnalysisID INNER JOIN
                         dbo.PatientRequest ON dbo.PatientRequestAnalysis.RequestID = dbo.PatientRequest.RequestID INNER JOIN
                         dbo.SampleType ON dbo.Analysis.SampleTypeID = dbo.SampleType.SampleTypeID INNER JOIN
                         dbo.Patient ON dbo.PatientRequest.PatientID = dbo.Patient.PatientID INNER JOIN
                         dbo.Unit ON dbo.Analysis.UnitId = dbo.Unit.UnitId INNER JOIN
                         dbo.Organization ON dbo.PatientRequest.OrganizationID = dbo.Organization.OrganizationID INNER JOIN
                         dbo.Package ON dbo.Organization.PackageID = dbo.Package.PackageID INNER JOIN
                         dbo.CategoryType ON dbo.Package.CategoryTypeID = dbo.CategoryType.CategoryTypeID


GO
/****** Object:  View [dbo].[Patient_PatientRequest_PatientRequestAnalysis_LastStatus]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Patient_PatientRequest_PatientRequestAnalysis_LastStatus]
AS
SELECT        dbo.PatientRequestAnalysis.RequestID, dbo.PatientRequestAnalysis.AnalysisID, dbo.PatientRequestAnalysis.EmployeeID, dbo.PatientRequestAnalysis.RunNumber, dbo.Status.StatusIdentifier, 
                         dbo.Status.StatusName, dbo.Status.Description, dbo.PatientRequestAnalysisStatus.StatusID, dbo.PatientRequestAnalysisStatus.StatusDate, 
                         dbo.PatientRequestAnalysisStatus.EmployeeID AS PatientRequestAnalysisStatusEmployeeId, dbo.PatientRequestAnalysisStatus.Comment AS PatientRequestAnalysisStatusComment, 
                         dbo.PatientRequestAnalysisStatus.RequestAnalysisStatusID, dbo.PatientRequestAnalysisStatus.RequestedAnalysisID, dbo.Analysis.AnalysisCode, dbo.Analysis.AnalysisName, dbo.Analysis.SampleTypeID, 
                         dbo.Analysis.CostPrice, dbo.PatientRequest.RequestDate, dbo.PatientRequest.DoctorRefID, dbo.PatientRequest.Priority, dbo.PatientRequest.RequestedRefID, dbo.PatientRequest.AttachmentSession, 
                         dbo.PatientRequest.ExtraDiscount, dbo.PatientRequest.ExtraCost, dbo.PatientRequest.TotalPatientCost, dbo.PatientRequest.TotalOrganizationCost, dbo.PatientRequest.RequestNumber, 
                         dbo.SampleType.SampleType, dbo.Patient.PatientID, dbo.Patient.MiddleName, dbo.Patient.FirstName, dbo.Patient.LastName, dbo.Patient.Gender, dbo.Patient.Address, dbo.Patient.NationalID, 
                         dbo.Patient.BirthDate, dbo.Patient.Mobile, dbo.Patient.Phone, dbo.Patient.Email, dbo.Patient.RegisteredDate, dbo.Patient.LastDataModified, dbo.Patient.ReferenceID, dbo.Patient.CityID, dbo.Unit.UnitId, 
                         dbo.Unit.UnitName, dbo.Unit.UnitDescription, dbo.Organization.OrganizationID, dbo.Organization.OrganizationName, dbo.Organization.InsertionDate, dbo.Organization.PatientCanReceiveResult, 
                         dbo.Package.PackageID, dbo.Package.PackageName, dbo.Package.PackageDiscription, dbo.CategoryType.CategoryTypeID, dbo.CategoryType.CategoryTypeName
FROM            dbo.PatientRequestAnalysis INNER JOIN
                         dbo.PatientRequestAnalysisStatus ON dbo.PatientRequestAnalysis.RequestedAnalysisID = dbo.PatientRequestAnalysisStatus.RequestedAnalysisID INNER JOIN
                             (SELECT        RequestedAnalysisID, MAX(RequestAnalysisStatusID) AS LastStausID
                               FROM            dbo.PatientRequestAnalysisStatus AS PatientRequestStatus_1
                               GROUP BY RequestedAnalysisID) AS LS ON LS.RequestedAnalysisID = dbo.PatientRequestAnalysisStatus.RequestedAnalysisID AND 
                         LS.LastStausID = dbo.PatientRequestAnalysisStatus.RequestAnalysisStatusID INNER JOIN
                         dbo.Status ON dbo.PatientRequestAnalysisStatus.StatusID = dbo.Status.StatusID INNER JOIN
                         dbo.Analysis ON dbo.PatientRequestAnalysis.AnalysisID = dbo.Analysis.AnalysisID INNER JOIN
                         dbo.PatientRequest ON dbo.PatientRequestAnalysis.RequestID = dbo.PatientRequest.RequestID INNER JOIN
                         dbo.SampleType ON dbo.Analysis.SampleTypeID = dbo.SampleType.SampleTypeID INNER JOIN
                         dbo.Patient ON dbo.PatientRequest.PatientID = dbo.Patient.PatientID INNER JOIN
                         dbo.Unit ON dbo.Analysis.UnitId = dbo.Unit.UnitId INNER JOIN
                         dbo.Organization ON dbo.PatientRequest.OrganizationID = dbo.Organization.OrganizationID INNER JOIN
                         dbo.Package ON dbo.Organization.PackageID = dbo.Package.PackageID INNER JOIN
                         dbo.CategoryType ON dbo.Package.CategoryTypeID = dbo.CategoryType.CategoryTypeID


GO
/****** Object:  View [dbo].[Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device]
AS
SELECT        dbo.PatientRequestAnalysis.RequestID, dbo.PatientRequestAnalysis.AnalysisID, dbo.PatientRequestAnalysis.EmployeeID, dbo.PatientRequestAnalysis.RunNumber, dbo.Status.StatusIdentifier, 
                         dbo.Status.StatusName, dbo.Status.Description, dbo.PatientRequestAnalysisStatus.StatusID, dbo.PatientRequestAnalysisStatus.StatusDate, 
                         dbo.PatientRequestAnalysisStatus.EmployeeID AS PatientRequestAnalysisStatusEmployeeId, dbo.PatientRequestAnalysisStatus.Comment AS PatientRequestAnalysisStatusComment, 
                         dbo.PatientRequestAnalysisStatus.RequestAnalysisStatusID, dbo.PatientRequestAnalysisStatus.RequestedAnalysisID, dbo.Analysis.AnalysisCode, dbo.Analysis.AnalysisName, dbo.Analysis.SampleTypeID, 
                         dbo.Analysis.CostPrice, dbo.PatientRequest.RequestDate, dbo.PatientRequest.DoctorRefID, dbo.PatientRequest.Priority, dbo.PatientRequest.RequestedRefID, dbo.PatientRequest.AttachmentSession, 
                         dbo.PatientRequest.ExtraDiscount, dbo.PatientRequest.ExtraCost, dbo.PatientRequest.TotalPatientCost, dbo.PatientRequest.TotalOrganizationCost, dbo.PatientRequest.RequestNumber, 
                         dbo.SampleType.SampleType, dbo.Patient.PatientID, dbo.Patient.MiddleName, dbo.Patient.FirstName, dbo.Patient.LastName, dbo.Patient.Gender, dbo.Patient.Address, dbo.Patient.NationalID, 
                         dbo.Patient.BirthDate, dbo.Patient.Mobile, dbo.Patient.Phone, dbo.Patient.Email, dbo.Patient.RegisteredDate, dbo.Patient.LastDataModified, dbo.Patient.ReferenceID, dbo.Patient.CityID, dbo.Unit.UnitId, 
                         dbo.Unit.UnitName, dbo.Unit.UnitDescription, dbo.DeviceAnalysis.DeviceAnalysisId, dbo.DeviceAnalysis.ReceiveDate, dbo.DeviceAnalysis.RakeNumber, dbo.DevicePlan.PlanId, dbo.DevicePlan.PlanNumber, 
                         dbo.DevicePlan.TestDate, dbo.DevicePlan.EmployeeId AS DoctorAnalyticEmployeeId, dbo.Device.DeviceName, dbo.Device.DeviceCode, dbo.Device.DeviceDescription, dbo.Device.Capacity, dbo.Device.DeviceId,
                          dbo.Organization.OrganizationID, dbo.Organization.OrganizationName, dbo.Organization.InsertionDate, dbo.Organization.PatientCanReceiveResult, dbo.CategoryType.CategoryTypeID, 
                         dbo.CategoryType.CategoryTypeName, dbo.Package.PackageID, dbo.Package.PackageName, dbo.Package.PackageDiscription
FROM            dbo.PatientRequestAnalysis INNER JOIN
                         dbo.PatientRequestAnalysisStatus ON dbo.PatientRequestAnalysis.RequestedAnalysisID = dbo.PatientRequestAnalysisStatus.RequestedAnalysisID INNER JOIN
                             (SELECT        RequestedAnalysisID, MAX(RequestAnalysisStatusID) AS LastStausID
                               FROM            dbo.PatientRequestAnalysisStatus AS PatientRequestStatus_1
                               GROUP BY RequestedAnalysisID) AS LS ON LS.RequestedAnalysisID = dbo.PatientRequestAnalysisStatus.RequestedAnalysisID AND 
                         LS.LastStausID = dbo.PatientRequestAnalysisStatus.RequestAnalysisStatusID INNER JOIN
                         dbo.Status ON dbo.PatientRequestAnalysisStatus.StatusID = dbo.Status.StatusID INNER JOIN
                         dbo.Analysis ON dbo.PatientRequestAnalysis.AnalysisID = dbo.Analysis.AnalysisID INNER JOIN
                         dbo.PatientRequest ON dbo.PatientRequestAnalysis.RequestID = dbo.PatientRequest.RequestID INNER JOIN
                         dbo.SampleType ON dbo.Analysis.SampleTypeID = dbo.SampleType.SampleTypeID INNER JOIN
                         dbo.Patient ON dbo.PatientRequest.PatientID = dbo.Patient.PatientID INNER JOIN
                         dbo.Unit ON dbo.Analysis.UnitId = dbo.Unit.UnitId INNER JOIN
                         dbo.DeviceAnalysis ON dbo.PatientRequestAnalysis.RequestedAnalysisID = dbo.DeviceAnalysis.RequestedAnalysisId INNER JOIN
                         dbo.DevicePlan ON dbo.DeviceAnalysis.PlanId = dbo.DevicePlan.PlanId INNER JOIN
                         dbo.Device ON dbo.DevicePlan.DeviceId = dbo.Device.DeviceId INNER JOIN
                         dbo.Organization ON dbo.PatientRequest.OrganizationID = dbo.Organization.OrganizationID INNER JOIN
                         dbo.Package ON dbo.Organization.PackageID = dbo.Package.PackageID INNER JOIN
                         dbo.CategoryType ON dbo.Package.CategoryTypeID = dbo.CategoryType.CategoryTypeID


GO
/****** Object:  View [dbo].[PatientRequest_Analysis]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PatientRequest_Analysis]
AS
SELECT        dbo.PatientRequest.RequestDate, dbo.PatientRequest.PatientID, dbo.PatientRequest.EmployeeID, dbo.PatientRequest.Comment, dbo.PatientRequest.DoctorRefID, dbo.PatientRequest.Priority, 
                         dbo.PatientRequest.OrganizationID, dbo.PatientRequest.RequestedRefID, dbo.PatientRequest.AttachmentSession, dbo.PatientRequestAnalysis.RequestedAnalysisID, dbo.PatientRequestAnalysis.RequestID, 
                         dbo.PatientRequestAnalysis.AnalysisID, dbo.PatientRequestAnalysis.RequestDate AS AnalysisRequestDate, dbo.PatientRequestAnalysis.EmployeeID AS RequestAnalysisEmployeeID, 
                         dbo.PatientRequestAnalysis.RunNumber, dbo.Analysis.AnalysisCode, dbo.Analysis.AnalysisName, dbo.Analysis.SampleTypeID, dbo.Analysis.CostPrice, dbo.PatientRequest.ExtraDiscount, 
                         dbo.PatientRequest.ExtraCost, dbo.PatientRequest.TotalPatientCost, dbo.PatientRequest.TotalOrganizationCost, dbo.PatientRequest.RequestNumber, dbo.SampleType.SampleType
FROM            dbo.PatientRequest INNER JOIN
                         dbo.PatientRequestAnalysis ON dbo.PatientRequest.RequestID = dbo.PatientRequestAnalysis.RequestID INNER JOIN
                         dbo.Analysis ON dbo.PatientRequestAnalysis.AnalysisID = dbo.Analysis.AnalysisID INNER JOIN
                         dbo.SampleType ON dbo.Analysis.SampleTypeID = dbo.SampleType.SampleTypeID


GO
/****** Object:  View [dbo].[PatientRequest_Payment]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PatientRequest_Payment]
AS
SELECT        dbo.PatientRequest.PatientID, dbo.PatientRequest.RequestDate, dbo.PatientRequest.EmployeeID AS PatientRequestEmployeeID, dbo.PatientRequest.Comment AS RequestComment, 
                         dbo.PatientRequest.DoctorRefID, dbo.PatientRequest.Priority, dbo.PatientRequest.OrganizationID, dbo.PatientRequest.RequestedRefID, dbo.PatientRequest.AttachmentSession, 
                         dbo.PatientRequest.ExtraDiscount, dbo.PatientRequest.ExtraCost, dbo.PatientRequest.TotalPatientCost, dbo.PatientRequest.TotalOrganizationCost, dbo.PatientRequestPayment.PaymentID, 
                         dbo.PatientRequestPayment.RequestID, dbo.PatientRequestPayment.PaidAmount, dbo.PatientRequestPayment.PaymentDate, dbo.PatientRequestPayment.EmployeeID AS PaymentEmployeeID, 
                         dbo.PatientRequestPayment.Comment AS PaymentComment, dbo.PatientRequest.RequestNumber
FROM            dbo.PatientRequest INNER JOIN
                         dbo.PatientRequestPayment ON dbo.PatientRequest.RequestID = dbo.PatientRequestPayment.RequestID


GO
/****** Object:  View [dbo].[PatientRequestAnalysis_AllStatuses]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PatientRequestAnalysis_AllStatuses]
AS
SELECT        dbo.PatientRequestAnalysis.RequestID, dbo.PatientRequestAnalysis.AnalysisID, dbo.PatientRequestAnalysis.EmployeeID, dbo.PatientRequestAnalysis.RunNumber, dbo.Status.StatusIdentifier, 
                         dbo.Status.StatusName, dbo.Status.Description, dbo.PatientRequestAnalysisStatus.StatusID, dbo.PatientRequestAnalysisStatus.StatusDate, 
                         dbo.PatientRequestAnalysisStatus.EmployeeID AS PatientRequestAnalysisStatusEmployeeId, dbo.PatientRequestAnalysisStatus.Comment AS PatientRequestAnalysisStatusComment, 
                         dbo.PatientRequestAnalysisStatus.RequestAnalysisStatusID, dbo.PatientRequestAnalysisStatus.RequestedAnalysisID, dbo.Analysis.AnalysisCode, dbo.Analysis.AnalysisName, dbo.Analysis.SampleTypeID, 
                         dbo.Analysis.CostPrice, dbo.PatientRequest.PatientID, dbo.PatientRequest.RequestDate, dbo.PatientRequest.DoctorRefID, dbo.PatientRequest.Priority, dbo.PatientRequest.OrganizationID, 
                         dbo.PatientRequest.RequestedRefID, dbo.PatientRequest.AttachmentSession, dbo.PatientRequest.ExtraDiscount, dbo.PatientRequest.ExtraCost, dbo.PatientRequest.TotalPatientCost, 
                         dbo.PatientRequest.TotalOrganizationCost, dbo.PatientRequest.RequestNumber, dbo.SampleType.SampleType
FROM            dbo.PatientRequestAnalysis INNER JOIN
                         dbo.PatientRequestAnalysisStatus ON dbo.PatientRequestAnalysis.RequestedAnalysisID = dbo.PatientRequestAnalysisStatus.RequestedAnalysisID INNER JOIN
                         dbo.Status ON dbo.PatientRequestAnalysisStatus.StatusID = dbo.Status.StatusID INNER JOIN
                         dbo.Analysis ON dbo.PatientRequestAnalysis.AnalysisID = dbo.Analysis.AnalysisID INNER JOIN
                         dbo.PatientRequest ON dbo.PatientRequestAnalysis.RequestID = dbo.PatientRequest.RequestID INNER JOIN
                         dbo.SampleType ON dbo.Analysis.SampleTypeID = dbo.SampleType.SampleTypeID


GO
/****** Object:  View [dbo].[PatientRequestAnalysis_LastStatus]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PatientRequestAnalysis_LastStatus]
AS
SELECT        dbo.PatientRequestAnalysis.RequestID, dbo.PatientRequestAnalysis.AnalysisID, dbo.PatientRequestAnalysis.EmployeeID, dbo.PatientRequestAnalysis.RunNumber, dbo.Status.StatusIdentifier, 
                         dbo.Status.StatusName, dbo.Status.Description, dbo.PatientRequestAnalysisStatus.StatusID, dbo.PatientRequestAnalysisStatus.StatusDate, 
                         dbo.PatientRequestAnalysisStatus.EmployeeID AS PatientRequestAnalysisStatusEmployeeId, dbo.PatientRequestAnalysisStatus.Comment AS PatientRequestAnalysisStatusComment, 
                         dbo.PatientRequestAnalysisStatus.RequestAnalysisStatusID, dbo.PatientRequestAnalysisStatus.RequestedAnalysisID, dbo.Analysis.AnalysisCode, dbo.Analysis.AnalysisName, dbo.Analysis.SampleTypeID, 
                         dbo.Analysis.CostPrice, dbo.PatientRequest.PatientID, dbo.PatientRequest.RequestDate, dbo.PatientRequest.DoctorRefID, dbo.PatientRequest.Priority, dbo.PatientRequest.OrganizationID, 
                         dbo.PatientRequest.RequestedRefID, dbo.PatientRequest.AttachmentSession, dbo.PatientRequest.ExtraDiscount, dbo.PatientRequest.ExtraCost, dbo.PatientRequest.TotalPatientCost, 
                         dbo.PatientRequest.TotalOrganizationCost, dbo.PatientRequest.RequestNumber, dbo.SampleType.SampleType
FROM            dbo.PatientRequestAnalysis INNER JOIN
                         dbo.PatientRequestAnalysisStatus ON dbo.PatientRequestAnalysis.RequestedAnalysisID = dbo.PatientRequestAnalysisStatus.RequestedAnalysisID INNER JOIN
                             (SELECT        RequestedAnalysisID, MAX(RequestAnalysisStatusID) AS LastStausID
                               FROM            dbo.PatientRequestAnalysisStatus AS PatientRequestStatus_1
                               GROUP BY RequestedAnalysisID) AS LS ON LS.RequestedAnalysisID = dbo.PatientRequestAnalysisStatus.RequestedAnalysisID AND 
                         LS.LastStausID = dbo.PatientRequestAnalysisStatus.RequestAnalysisStatusID INNER JOIN
                         dbo.Status ON dbo.PatientRequestAnalysisStatus.StatusID = dbo.Status.StatusID INNER JOIN
                         dbo.Analysis ON dbo.PatientRequestAnalysis.AnalysisID = dbo.Analysis.AnalysisID INNER JOIN
                         dbo.PatientRequest ON dbo.PatientRequestAnalysis.RequestID = dbo.PatientRequest.RequestID INNER JOIN
                         dbo.SampleType ON dbo.Analysis.SampleTypeID = dbo.SampleType.SampleTypeID


GO
/****** Object:  View [dbo].[Plan_Device_Unit]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Plan_Device_Unit]
AS
SELECT        dbo.DevicePlan.PlanId, dbo.DevicePlan.PlanNumber, dbo.DevicePlan.TestDate, dbo.Device.DeviceId, dbo.Device.DeviceName, dbo.Device.DeviceCode, dbo.Device.DeviceDescription, dbo.Device.Capacity, 
                         dbo.Unit.UnitId, dbo.Unit.UnitName, dbo.Unit.UnitDescription, dbo.Employee.EmployeeID, dbo.Employee.FirstName, dbo.Employee.LastName, dbo.Employee.JobDate, dbo.Employee.Address, 
                         dbo.Employee.BirthDay, dbo.Employee.Phone, dbo.Employee.CurrentBranchID, dbo.Employee.JobTitleID
FROM            dbo.Unit INNER JOIN
                         dbo.DevicePlan ON dbo.DevicePlan.UnitId = dbo.Unit.UnitId INNER JOIN
                         dbo.Device ON dbo.DevicePlan.DeviceId = dbo.Device.DeviceId INNER JOIN
                         dbo.Employee ON dbo.DevicePlan.EmployeeId = dbo.Employee.EmployeeID


GO
/****** Object:  View [dbo].[Unit_Device]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Unit_Device]
AS
SELECT        dbo.Device.DeviceId, dbo.Device.DeviceName, dbo.Device.DeviceCode, dbo.Device.Capacity, dbo.Device.DeviceDescription, dbo.Unit.UnitId, dbo.Unit.UnitName, dbo.Unit.UnitDescription, 
                         GroupUnitDevice.IsDefaultDevice
FROM            dbo.Device INNER JOIN
                             (SELECT        UnitId, DeviceId, IsDefaultDevice
                               FROM            dbo.UnitDevice
                               GROUP BY DeviceId, UnitId, IsDefaultDevice) AS GroupUnitDevice ON dbo.Device.DeviceId = GroupUnitDevice.DeviceId INNER JOIN
                         dbo.Unit ON GroupUnitDevice.UnitId = dbo.Unit.UnitId


GO
/****** Object:  View [dbo].[Unit_Device_SeparatedSample]    Script Date: 8/15/2016 11:28:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Unit_Device_SeparatedSample]
AS
SELECT        dbo.Device.DeviceId, dbo.Device.DeviceName, dbo.Device.DeviceCode, dbo.Device.DeviceDescription, dbo.Device.Capacity, dbo.UnitDevice.IsDefaultDevice, dbo.Unit.UnitId, dbo.Unit.UnitName, 
                         dbo.Unit.UnitDescription, dbo.SampleType.SampleTypeID, dbo.SampleType.SampleType, dbo.SampleSeparation.SeparatedSampleName, dbo.SampleSeparation.SeparatedSampleId
FROM            dbo.Device INNER JOIN
                         dbo.UnitDevice ON dbo.Device.DeviceId = dbo.UnitDevice.DeviceId INNER JOIN
                         dbo.Unit ON dbo.Unit.UnitId = dbo.UnitDevice.UnitId INNER JOIN
                         dbo.SampleSeparation ON dbo.UnitDevice.SeparatedSampleId = dbo.SampleSeparation.SeparatedSampleId INNER JOIN
                         dbo.SampleType ON dbo.SampleSeparation.SampleId = dbo.SampleType.SampleTypeID


GO
SET IDENTITY_INSERT [dbo].[Analysis] ON 

INSERT [dbo].[Analysis] ([AnalysisID], [AnalysisCode], [AnalysisName], [SampleTypeID], [CostPrice], [UnitId]) VALUES (1, N'S.Creatinine', N'S.Creatinine', 1, CAST(10 AS Decimal(18, 0)), 1)
INSERT [dbo].[Analysis] ([AnalysisID], [AnalysisCode], [AnalysisName], [SampleTypeID], [CostPrice], [UnitId]) VALUES (2, N'S.UricAcid', N'S.Uric Acid', 1, CAST(15 AS Decimal(18, 0)), 1)
INSERT [dbo].[Analysis] ([AnalysisID], [AnalysisCode], [AnalysisName], [SampleTypeID], [CostPrice], [UnitId]) VALUES (3, N'Coagulation', N'Coagulation Assay', 1, CAST(17 AS Decimal(18, 0)), 2)
INSERT [dbo].[Analysis] ([AnalysisID], [AnalysisCode], [AnalysisName], [SampleTypeID], [CostPrice], [UnitId]) VALUES (4, N'BloodPicture', N'Complete Blood Picture', 1, CAST(16 AS Decimal(18, 0)), 1)
INSERT [dbo].[Analysis] ([AnalysisID], [AnalysisCode], [AnalysisName], [SampleTypeID], [CostPrice], [UnitId]) VALUES (5, N'Brucella', N'Brucella test
( Slide agglutination )', 1, CAST(12 AS Decimal(18, 0)), 1)
INSERT [dbo].[Analysis] ([AnalysisID], [AnalysisCode], [AnalysisName], [SampleTypeID], [CostPrice], [UnitId]) VALUES (6, N'CompleteUrine', N'Total protein in urine
', 2, CAST(17 AS Decimal(18, 0)), 1)
SET IDENTITY_INSERT [dbo].[Analysis] OFF
SET IDENTITY_INSERT [dbo].[AnalysisResultDetails] ON 

INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (2, 1, N'', NULL, N'', N'1', N'5', N'10-20', N'8-20', N'Float', N'')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (3, 2, N'', NULL, N'', N'1', N'4', N'1-5', N'1-5', N'Float', N'')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (7, 6, N'Epithelical Cells', NULL, N'', N'0', N'0', N'Absent', N'Absent', N'String', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (8, 6, N'Pus Cells', NULL, N'/HPF', N'0', N'0', N'Absent', N'Absent', N'String', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (9, 6, N'Red Blood Cells', NULL, N'/HPF', N'0', N'0', N'Absent', N'Absent', N'String', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (10, 6, N'Parasites', NULL, N'', N'0', N'0', N'Absent', N'Absent', N'String', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (11, 6, N'Casts', NULL, N'', N'0', N'0', N'Absent', N'Absent', N'String', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (12, 6, N'Crystals', NULL, N'', N'0', N'0', N'Absent', N'Absent', N'String', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (13, 6, N'Amorphous Sedments', NULL, N'', N'0', N'0', N'Absent', N'Absent', N'String', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (14, 6, N'pH', NULL, N'', N'0', N'0', N'Absent', N'Absent', N'String', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (15, 6, N'Specifix Gravity', NULL, N'', N'1015', N'1030', N'1015-1030', N'1015-1030', N'Int', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (16, 6, N'Protein', NULL, N'', N'0', N'1', N'Absent', N'Absent', N'String', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (17, 6, N'Colour', NULL, N'', N'0', N'0', N'Amber Yellow', N'Amber Yellow', N'String', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (18, 6, N'Appererance', NULL, N'', N'0', N'0', N'Clear', N'Clear', N'String', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (19, 6, N'Urobilnogen', NULL, N'', N'0', N'0', N'Trace', N'Trace', N'String', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (20, 6, N'Fats', NULL, N'', N'0', N'0', N'Absent', N'Absent', N'String', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (21, 6, N'Ketone Bodies', NULL, N'', N'0', N'0', N'Absent', N'Absent', N'String', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (22, 6, N'BDrudin', NULL, N'', N'0', N'0', N'Absent', N'Absent', N'String', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (23, 6, N'Suger', NULL, N'', N'0', N'0', N'Absent', N'Absent', N'String', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (24, 6, N'Reaction', NULL, N'', N'0', N'0', N'acdic', N'acdic', N'String', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (25, 5, N'Brucella Melitensis', NULL, N'', N'0', N'0', N'No suggestion', N'No suggestion', N'String', N'')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (26, 5, N'Brucella Abortus', NULL, N'', N'0', N'0', N'No suggestion', N'No suggestion', N'String', N'')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (27, 4, N'Haemoglogbin', NULL, N'g/dl', N'12', N'16', N'12-16', N'12-16', N'Float', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (29, 4, N'RBC''s * 10^6', NULL, N'mm', N'3.7', N'5.2', N'3.7-5.2', N'3.7-5.2', N'Float', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (30, 4, N'WBC''s * 10^3', NULL, N'mm', N'4.0', N'11.0', N'4.0-11.0', N'4.0-11.0', N'Float', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (31, 4, N'Haematocrit (PCV)', NULL, N'%', N'33', N'48', N'33-48', N'33-48', N'Float', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (32, 4, N'Platelets* 10^3', NULL, N'mm', N'150', N'450', N'150-450', N'150-450', N'Int', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (33, 4, N'M.C.V', NULL, N'', N'76', N'96', N'76-96', N'76-96', N'Float', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (34, 4, N'M.C.H', NULL, N'', N'27', N'32', N'27-32', N'27-32', N'Float', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (35, 4, N'M.C.H.C', NULL, N'', N'40', N'70', N'40-70', N'40-70', N'Float', N'Microscopic Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (36, 4, N'Segmented', NULL, N'', N'40', N'70', N'40-70', N'40-70', N'Float', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (37, 4, N'Staff', NULL, N'', N'0', N'5', N'0-5', N'0-5', N'Float', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (38, 4, N'Monocytes', NULL, N'', N'2', N'8', N'2-8', N'2-8', N'Float', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (39, 4, N'Eosinophills', NULL, N'', N'1', N'5', N'1-5', N'1-5', N'Float', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (40, 4, N'Basonphills', NULL, N'', N'0', N'2', N'0-2', N'0-2', N'Float', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (41, 4, N'Lymphocytes', NULL, N'', N'20', N'40', N'20-40', N'20-40', N'Float', N'Physical Exam')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (42, 3, N'Patient time', NULL, N'Seconds', N'0', N'0', N'', N'', N'Float', N'')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (43, 3, N'Control time', NULL, N'Seconds', N'0', N'0', N'', N'', N'Float', N'')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (44, 3, N'Patient Concentration', NULL, N'%', N'70', N'100', N'70-100', N'70-100', N'Float', N'')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (45, 3, N'INR', NULL, N'', N'1', N'1.3', N'1.0-1.3', N'1.0-1.3', N'Float', N'')
INSERT [dbo].[AnalysisResultDetails] ([AnalysisDetailId], [AnalysisId], [ResultTitle], [Description], [UnitOfMeasure], [MinimumValue], [MaximumValue], [MaleNormalRange], [FemaleNormalRange], [DataType], [SectionTitle]) VALUES (46, 3, N'Ratio', NULL, N'', N'0', N'0', N'', N'', N'Float', N'')
SET IDENTITY_INSERT [dbo].[AnalysisResultDetails] OFF
SET IDENTITY_INSERT [dbo].[CategoryType] ON 

INSERT [dbo].[CategoryType] ([CategoryTypeID], [CategoryTypeName]) VALUES (1, N'Individual')
INSERT [dbo].[CategoryType] ([CategoryTypeID], [CategoryTypeName]) VALUES (2, N'Contract')
INSERT [dbo].[CategoryType] ([CategoryTypeID], [CategoryTypeName]) VALUES (3, N'LabToLab')
SET IDENTITY_INSERT [dbo].[CategoryType] OFF
SET IDENTITY_INSERT [dbo].[City] ON 

INSERT [dbo].[City] ([CityID], [ProvinceID], [CityName]) VALUES (1, 1, N'Nasr City           ')
INSERT [dbo].[City] ([CityID], [ProvinceID], [CityName]) VALUES (2, 1, N'New Cairo           ')
INSERT [dbo].[City] ([CityID], [ProvinceID], [CityName]) VALUES (3, 4, N'Shoper')
INSERT [dbo].[City] ([CityID], [ProvinceID], [CityName]) VALUES (4, 4, N'Kafr Masoud')
INSERT [dbo].[City] ([CityID], [ProvinceID], [CityName]) VALUES (5, 4, N'Berma')
INSERT [dbo].[City] ([CityID], [ProvinceID], [CityName]) VALUES (6, 5, N'El Sahel')
INSERT [dbo].[City] ([CityID], [ProvinceID], [CityName]) VALUES (9, 5, N'El agamy')
INSERT [dbo].[City] ([CityID], [ProvinceID], [CityName]) VALUES (10, 5, N'Sedy Beshr')
SET IDENTITY_INSERT [dbo].[City] OFF
SET IDENTITY_INSERT [dbo].[Device] ON 

INSERT [dbo].[Device] ([DeviceId], [DeviceName], [DeviceCode], [DeviceDescription], [Capacity]) VALUES (2, N'Bs200
', N'Bs200
', N'First device', 5)
INSERT [dbo].[Device] ([DeviceId], [DeviceName], [DeviceCode], [DeviceDescription], [Capacity]) VALUES (4, N'immulit
', N'immulit
', N'Second Device', 4)
INSERT [dbo].[Device] ([DeviceId], [DeviceName], [DeviceCode], [DeviceDescription], [Capacity]) VALUES (5, N'Erba
', N'Erba
', N'Third Device', 4)
INSERT [dbo].[Device] ([DeviceId], [DeviceName], [DeviceCode], [DeviceDescription], [Capacity]) VALUES (6, N'STAT FAX
', N'STAT FAX
', N'forth device', 2)
INSERT [dbo].[Device] ([DeviceId], [DeviceName], [DeviceCode], [DeviceDescription], [Capacity]) VALUES (7, N'NS BIO TECH
', N'NS BIO TECH
', N'Fivth device', 1)
INSERT [dbo].[Device] ([DeviceId], [DeviceName], [DeviceCode], [DeviceDescription], [Capacity]) VALUES (8, N'TRBI QUIK
', N'TRBI QUIK
', N'sixth device', 2)
INSERT [dbo].[Device] ([DeviceId], [DeviceName], [DeviceCode], [DeviceDescription], [Capacity]) VALUES (9, N'MAGLIUM
', N'MAGLIUM
', N'7th device', 4)
INSERT [dbo].[Device] ([DeviceId], [DeviceName], [DeviceCode], [DeviceDescription], [Capacity]) VALUES (10, N'LINE GENE
', N'LINE GENE
', N'8th device', 6)
INSERT [dbo].[Device] ([DeviceId], [DeviceName], [DeviceCode], [DeviceDescription], [Capacity]) VALUES (11, N'MINI MY GO
', N'MINI MY GO
', N'9th device', 8)
INSERT [dbo].[Device] ([DeviceId], [DeviceName], [DeviceCode], [DeviceDescription], [Capacity]) VALUES (12, N'HEMAX 1000
', N'HEMAX 1000
', N'10th device', 5)
INSERT [dbo].[Device] ([DeviceId], [DeviceName], [DeviceCode], [DeviceDescription], [Capacity]) VALUES (13, N'M B
', N'M B
', N'11th device', 8)
INSERT [dbo].[Device] ([DeviceId], [DeviceName], [DeviceCode], [DeviceDescription], [Capacity]) VALUES (14, N'Micro
', N'Micro
', N'12th device', 4)
INSERT [dbo].[Device] ([DeviceId], [DeviceName], [DeviceCode], [DeviceDescription], [Capacity]) VALUES (19, N'Para
', N'Para
', N'13th device', 4)
SET IDENTITY_INSERT [dbo].[Device] OFF
SET IDENTITY_INSERT [dbo].[DoctorRef] ON 

INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (1, N'Mohamed Khaled', 11, NULL, N'al maadi', N'011111111111', N'02254896', CAST(0x0000A63900FBC086 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (2, N'Ghada', 6, NULL, N'Sakr Korash', N'01222222222', N'0222547315', CAST(0x0000A63900FE0E6B AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (3, N'amr aly', 7, NULL, N'Giza', N'01054789632', N'02365478', CAST(0x0000A63900FF63C7 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (4, N'Ahmed Aly', 1, NULL, NULL, NULL, NULL, CAST(0x0000A63A00D10E79 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (5, N'Gamal', 7, NULL, NULL, NULL, NULL, CAST(0x0000A63A00F82A8E AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (6, N'Mostafe', 11, NULL, NULL, NULL, NULL, CAST(0x0000A63A00F8A59D AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (7, N'Farouk', 10, NULL, NULL, NULL, NULL, CAST(0x0000A63A00FA0150 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (8, N'Saaid', 6, NULL, NULL, NULL, NULL, CAST(0x0000A63A00FA683B AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (9, N'Salma', 2, NULL, NULL, NULL, NULL, CAST(0x0000A63F01097AF7 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (10, N'Said', 3, NULL, NULL, NULL, NULL, CAST(0x0000A64100D1C02A AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (11, N'Tamer', 3, NULL, NULL, NULL, NULL, CAST(0x0000A64100E986B3 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (12, N'Ahmed yesssin', 4, NULL, NULL, NULL, NULL, CAST(0x0000A64300A547B8 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (13, N'saaaaid', 5, NULL, NULL, NULL, NULL, CAST(0x0000A64300A62F7B AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (14, N'Mourad', 3, NULL, NULL, NULL, NULL, CAST(0x0000A64300B24113 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (15, N'Gamal Al8i', 1, NULL, N'fdzf', N'45455', N'01251', CAST(0x0000A64300F1D08E AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (16, N'Tamer Said', 3, 2, NULL, NULL, NULL, CAST(0x0000A6430116B81C AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (17, N'Helmy', 2, 2, N'citadel', N'0147852369', N'0220301040', CAST(0x0000A64301182398 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (18, N'Ahmed Kamal', 1, 1, NULL, N'01117248357', N'0210305040', CAST(0x0000A64600B249AF AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (19, N'Hany', 3, 2, NULL, NULL, NULL, CAST(0x0000A64600B9A9CA AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (20, N'Ibrahim', 3, 2, NULL, NULL, NULL, CAST(0x0000A64600CAD8DF AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (21, N'Hitham', 2, 1, NULL, NULL, NULL, CAST(0x0000A64600E19BAE AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (22, N'Nasr', 3, 2, NULL, NULL, NULL, CAST(0x0000A64600E35706 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (23, N'Emad', 3, 2, NULL, NULL, NULL, CAST(0x0000A64600ED7BB2 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (24, N'Hamdy', 8, 1, NULL, NULL, NULL, CAST(0x0000A64600FFF314 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (25, N'Hamda', 9, 10, NULL, NULL, NULL, CAST(0x0000A646010322AB AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (26, N'Ahmed Faourk', 5, 6, NULL, NULL, NULL, CAST(0x0000A646011D34F2 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (27, N'AbdelAllah', 3, 10, NULL, NULL, NULL, CAST(0x0000A646011EC4C2 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (28, N'ahmed Fahmy', 5, 9, NULL, NULL, NULL, CAST(0x0000A6460120690B AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (29, N'Galal', 4, 4, NULL, NULL, NULL, CAST(0x0000A647009A266B AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (30, N'Mostafe Mansour', 2, 10, NULL, NULL, NULL, CAST(0x0000A64700BE8F99 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (31, N'el Sayed', 2, 2, NULL, NULL, NULL, CAST(0x0000A64A00E1E955 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (32, N'ahmed sayed', 2, 5, NULL, NULL, NULL, CAST(0x0000A64A00F3045B AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (1018, N'ahmmed', 3, 4, NULL, NULL, NULL, CAST(0x0000A64A0117FABA AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (1019, N'Ahmed Aly Mohamed', 1, 4, NULL, NULL, NULL, CAST(0x0000A66300AC2CB0 AS DateTime))
INSERT [dbo].[DoctorRef] ([DoctorRefID], [DoctorName], [SpecialID], [CityID], [Address], [Mobile], [Phone], [InsertionDate]) VALUES (1020, N'Yousef', 5, NULL, NULL, NULL, NULL, CAST(0x0000A66300AD0D83 AS DateTime))
SET IDENTITY_INSERT [dbo].[DoctorRef] OFF
SET IDENTITY_INSERT [dbo].[DoctorSpecialization] ON 

INSERT [dbo].[DoctorSpecialization] ([SpecialID], [SpecialName]) VALUES (1, N'Cardiologist')
INSERT [dbo].[DoctorSpecialization] ([SpecialID], [SpecialName]) VALUES (2, N'Endocrinologist')
INSERT [dbo].[DoctorSpecialization] ([SpecialID], [SpecialName]) VALUES (3, N'Ophthalmologist')
INSERT [dbo].[DoctorSpecialization] ([SpecialID], [SpecialName]) VALUES (4, N'Pulmonologist')
INSERT [dbo].[DoctorSpecialization] ([SpecialID], [SpecialName]) VALUES (5, N'Dermatologist')
INSERT [dbo].[DoctorSpecialization] ([SpecialID], [SpecialName]) VALUES (6, N'Gynecologist')
INSERT [dbo].[DoctorSpecialization] ([SpecialID], [SpecialName]) VALUES (7, N'Neurologist')
INSERT [dbo].[DoctorSpecialization] ([SpecialID], [SpecialName]) VALUES (8, N'Urologist')
INSERT [dbo].[DoctorSpecialization] ([SpecialID], [SpecialName]) VALUES (9, N'Rheumatologist')
INSERT [dbo].[DoctorSpecialization] ([SpecialID], [SpecialName]) VALUES (10, N'Hematologist')
INSERT [dbo].[DoctorSpecialization] ([SpecialID], [SpecialName]) VALUES (11, N'Pediatrist')
SET IDENTITY_INSERT [dbo].[DoctorSpecialization] OFF
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [JobDate], [Address], [CityID], [BirthDay], [Phone], [CurrentBranchID], [JobTitleID]) VALUES (1, N'Mohamed', N'Fawzy', CAST(0x0000A61800000000 AS DateTime), N'el sayda Asha', 1, CAST(0x20100B00 AS Date), N'01117224826', 1, 5)
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [JobDate], [Address], [CityID], [BirthDay], [Phone], [CurrentBranchID], [JobTitleID]) VALUES (2, N'Taha', N'Farid', CAST(0x0000A5E900000000 AS DateTime), N'Tanta', 1, CAST(0x0B160B00 AS Date), N'', 1, 5)
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [JobDate], [Address], [CityID], [BirthDay], [Phone], [CurrentBranchID], [JobTitleID]) VALUES (6, N'Amr', N'Ali', CAST(0x0000A66300BA23F9 AS DateTime), N'Helwan', 1, CAST(0x11060B00 AS Date), N'01111111111', 1, 5)
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [JobDate], [Address], [CityID], [BirthDay], [Phone], [CurrentBranchID], [JobTitleID]) VALUES (7, N'Modather', N'Ahmed', CAST(0x0000A66300BA23F9 AS DateTime), N'Giza', 1, CAST(0x11060B00 AS Date), N'01111111111', 1, 5)
SET IDENTITY_INSERT [dbo].[Employee] OFF
SET IDENTITY_INSERT [dbo].[Entity] ON 

INSERT [dbo].[Entity] ([EntityID], [EntityName], [EntityDescription]) VALUES (1, N'CustomerCare', N'Add new patient request analyzes for existing patient and non existing patient')
SET IDENTITY_INSERT [dbo].[Entity] OFF
SET IDENTITY_INSERT [dbo].[EntityAction] ON 

INSERT [dbo].[EntityAction] ([ActionID], [ActionName], [ActionDescription]) VALUES (1, N'Add', N'Add')
SET IDENTITY_INSERT [dbo].[EntityAction] OFF
SET IDENTITY_INSERT [dbo].[JobTitle] ON 

INSERT [dbo].[JobTitle] ([JobTitleID], [JobCode], [JobTitle]) VALUES (1, N'CS', N'Customer Care')
INSERT [dbo].[JobTitle] ([JobTitleID], [JobCode], [JobTitle]) VALUES (2, N'Chemist', N'Chemist')
INSERT [dbo].[JobTitle] ([JobTitleID], [JobCode], [JobTitle]) VALUES (3, N'DoctorAnalytic', N'Doctor Analytic')
INSERT [dbo].[JobTitle] ([JobTitleID], [JobCode], [JobTitle]) VALUES (4, N'DoctorApply', N'Doctor Apply')
INSERT [dbo].[JobTitle] ([JobTitleID], [JobCode], [JobTitle]) VALUES (5, N'Admin', N'Administrator')
SET IDENTITY_INSERT [dbo].[JobTitle] OFF
SET IDENTITY_INSERT [dbo].[LabBranch] ON 

INSERT [dbo].[LabBranch] ([BranchID], [BranchName], [Address], [CityID], [Phone], [EstablishedDate]) VALUES (1, N'Nasr City Lab', N'47 Zakr Hessin', 1, N'0123456789', CAST(0x823B0B00 AS Date))
INSERT [dbo].[LabBranch] ([BranchID], [BranchName], [Address], [CityID], [Phone], [EstablishedDate]) VALUES (2, N'New Cairo Lab', N'New Cairo ', 1, N'0111111111', CAST(0x823B0B00 AS Date))
SET IDENTITY_INSERT [dbo].[LabBranch] OFF
SET IDENTITY_INSERT [dbo].[NotDeliveredReason] ON 

INSERT [dbo].[NotDeliveredReason] ([ErrorId], [ErrorMessage]) VALUES (1, N'Not around')
INSERT [dbo].[NotDeliveredReason] ([ErrorId], [ErrorMessage]) VALUES (2, N'Delayed')
SET IDENTITY_INSERT [dbo].[NotDeliveredReason] OFF
SET IDENTITY_INSERT [dbo].[Organization] ON 

INSERT [dbo].[Organization] ([OrganizationID], [OrganizationName], [PackageID], [InsertionDate], [EmployeeID], [PatientCanReceiveResult]) VALUES (2, N'Individual', 2, CAST(0x0000A62700E364F8 AS DateTime), 1, 1)
INSERT [dbo].[Organization] ([OrganizationID], [OrganizationName], [PackageID], [InsertionDate], [EmployeeID], [PatientCanReceiveResult]) VALUES (3, N'Sugar Company', 3, CAST(0x0000A64600FE2946 AS DateTime), 1, 1)
INSERT [dbo].[Organization] ([OrganizationID], [OrganizationName], [PackageID], [InsertionDate], [EmployeeID], [PatientCanReceiveResult]) VALUES (4, N'Steel Company', 3, CAST(0x0000A64600FE7490 AS DateTime), 1, 1)
INSERT [dbo].[Organization] ([OrganizationID], [OrganizationName], [PackageID], [InsertionDate], [EmployeeID], [PatientCanReceiveResult]) VALUES (5, N'El borg', 4, CAST(0x0000A64600FE9460 AS DateTime), 1, 1)
INSERT [dbo].[Organization] ([OrganizationID], [OrganizationName], [PackageID], [InsertionDate], [EmployeeID], [PatientCanReceiveResult]) VALUES (6, N'El mokhtabr', 4, CAST(0x0000A64600FEB0E0 AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[Organization] OFF
SET IDENTITY_INSERT [dbo].[Package] ON 

INSERT [dbo].[Package] ([PackageID], [PackageName], [PackageDiscription], [CategoryTypeID]) VALUES (2, N'Individual', N'Normal with original prices', 1)
INSERT [dbo].[Package] ([PackageID], [PackageName], [PackageDiscription], [CategoryTypeID]) VALUES (3, N'Contract', N'Small company discount', 2)
INSERT [dbo].[Package] ([PackageID], [PackageName], [PackageDiscription], [CategoryTypeID]) VALUES (4, N'LabToLab', N'Medium company discount', 3)
SET IDENTITY_INSERT [dbo].[Package] OFF
INSERT [dbo].[PackageCostList] ([PackageID], [AnalysisID], [CurrentAnalysisDiscountRate], [NewAnalysisDiscountRate]) VALUES (2, 1, CAST(0 AS Decimal(18, 0)), NULL)
INSERT [dbo].[PackageCostList] ([PackageID], [AnalysisID], [CurrentAnalysisDiscountRate], [NewAnalysisDiscountRate]) VALUES (2, 2, CAST(0 AS Decimal(18, 0)), NULL)
INSERT [dbo].[PackageCostList] ([PackageID], [AnalysisID], [CurrentAnalysisDiscountRate], [NewAnalysisDiscountRate]) VALUES (2, 3, CAST(0 AS Decimal(18, 0)), NULL)
INSERT [dbo].[PackageCostList] ([PackageID], [AnalysisID], [CurrentAnalysisDiscountRate], [NewAnalysisDiscountRate]) VALUES (2, 4, CAST(0 AS Decimal(18, 0)), NULL)
INSERT [dbo].[PackageCostList] ([PackageID], [AnalysisID], [CurrentAnalysisDiscountRate], [NewAnalysisDiscountRate]) VALUES (2, 5, CAST(0 AS Decimal(18, 0)), NULL)
INSERT [dbo].[PackageCostList] ([PackageID], [AnalysisID], [CurrentAnalysisDiscountRate], [NewAnalysisDiscountRate]) VALUES (2, 6, CAST(0 AS Decimal(18, 0)), NULL)
INSERT [dbo].[PatientRefID] ([LastPatientRefID]) VALUES (1)
INSERT [dbo].[Permission] ([EntityID], [ActionID], [RoleID], [InsertionDate]) VALUES (1, 1, 1, CAST(0x0000A638009E5354 AS DateTime))
INSERT [dbo].[PlanNumber] ([PlanNum]) VALUES (1)
SET IDENTITY_INSERT [dbo].[Priority] ON 

INSERT [dbo].[Priority] ([PriorityID], [PriorityCode]) VALUES (1, N'Low       ')
INSERT [dbo].[Priority] ([PriorityID], [PriorityCode]) VALUES (2, N'Medium    ')
INSERT [dbo].[Priority] ([PriorityID], [PriorityCode]) VALUES (3, N'High      ')
SET IDENTITY_INSERT [dbo].[Priority] OFF
SET IDENTITY_INSERT [dbo].[Province] ON 

INSERT [dbo].[Province] ([ProvinceID], [CountryID], [ProvinceName]) VALUES (1, 1, N'Cairo               ')
INSERT [dbo].[Province] ([ProvinceID], [CountryID], [ProvinceName]) VALUES (4, 1, N'Tanta               ')
INSERT [dbo].[Province] ([ProvinceID], [CountryID], [ProvinceName]) VALUES (5, 1, N'Alexandria          ')
SET IDENTITY_INSERT [dbo].[Province] OFF
SET IDENTITY_INSERT [dbo].[RejectionReason] ON 

INSERT [dbo].[RejectionReason] ([ErrorId], [ErrorMessage]) VALUES (1, N'Broken')
INSERT [dbo].[RejectionReason] ([ErrorId], [ErrorMessage]) VALUES (2, N'Expired')
INSERT [dbo].[RejectionReason] ([ErrorId], [ErrorMessage]) VALUES (3, N'Suspect')
SET IDENTITY_INSERT [dbo].[RejectionReason] OFF
INSERT [dbo].[RequestNumber] ([Prefix], [Number]) VALUES (N'AA', 1)
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [RoleName], [RoleDescription], [InsertionDate]) VALUES (1, N'CS', N'Manage CS pages', CAST(0x0000A62A00ECB5D6 AS DateTime))
INSERT [dbo].[Role] ([RoleID], [RoleName], [RoleDescription], [InsertionDate]) VALUES (2, N'Chemist', N'Manage Sampling and preservation pages', CAST(0x0000A62A00ECD4CF AS DateTime))
INSERT [dbo].[Role] ([RoleID], [RoleName], [RoleDescription], [InsertionDate]) VALUES (3, N'DoctorAnalytic', N'Manage analyzes pages', CAST(0x0000A62A00ED341A AS DateTime))
INSERT [dbo].[Role] ([RoleID], [RoleName], [RoleDescription], [InsertionDate]) VALUES (4, N'DoctorApply', N'Manage analyzes results pagae', CAST(0x0000A62A00ED51A1 AS DateTime))
INSERT [dbo].[Role] ([RoleID], [RoleName], [RoleDescription], [InsertionDate]) VALUES (5, N'Admin', N'The system admin', CAST(0x0000A64D00CB8FC8 AS DateTime))
SET IDENTITY_INSERT [dbo].[Role] OFF
INSERT [dbo].[RunNumber] ([RunNum]) VALUES (1)
SET IDENTITY_INSERT [dbo].[SampleSeparation] ON 

INSERT [dbo].[SampleSeparation] ([SeparatedSampleId], [SeparatedSampleName], [SampleId]) VALUES (1, N'Serum', 1)
INSERT [dbo].[SampleSeparation] ([SeparatedSampleId], [SeparatedSampleName], [SampleId]) VALUES (2, N'Edeta
', 1)
INSERT [dbo].[SampleSeparation] ([SeparatedSampleId], [SeparatedSampleName], [SampleId]) VALUES (3, N'Citrata Na 
', 1)
INSERT [dbo].[SampleSeparation] ([SeparatedSampleId], [SeparatedSampleName], [SampleId]) VALUES (4, N'Heparen
', 1)
INSERT [dbo].[SampleSeparation] ([SeparatedSampleId], [SeparatedSampleName], [SampleId]) VALUES (5, N'Urine
', 2)
INSERT [dbo].[SampleSeparation] ([SeparatedSampleId], [SeparatedSampleName], [SampleId]) VALUES (6, N'Fluid
', 3)
INSERT [dbo].[SampleSeparation] ([SeparatedSampleId], [SeparatedSampleName], [SampleId]) VALUES (7, N'Cytology
', 4)
INSERT [dbo].[SampleSeparation] ([SeparatedSampleId], [SeparatedSampleName], [SampleId]) VALUES (9, N'Biobsy
', 4)
SET IDENTITY_INSERT [dbo].[SampleSeparation] OFF
SET IDENTITY_INSERT [dbo].[SampleType] ON 

INSERT [dbo].[SampleType] ([SampleTypeID], [SampleType]) VALUES (1, N'Blood')
INSERT [dbo].[SampleType] ([SampleTypeID], [SampleType]) VALUES (2, N'Urine
')
INSERT [dbo].[SampleType] ([SampleTypeID], [SampleType]) VALUES (3, N'Fluid')
INSERT [dbo].[SampleType] ([SampleTypeID], [SampleType]) VALUES (4, N'Biobsy')
SET IDENTITY_INSERT [dbo].[SampleType] OFF
SET IDENTITY_INSERT [dbo].[Status] ON 

INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (1, N'PendingForSampling', N'PendingForSampling', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (2, N'ReceivedForSampling', N'ReceivedForSampling', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (5, N'SavedByChemist', N'SavedByChemist', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (6, N'TransferredByChemist', N'TransferredByChemist', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (7, N'PendingForAnalysising', N'PendingForAnalysising', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (8, N'ReceivedForAnalysising', N'ReceivedForAnalysising', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (9, N'UnderTesting', N'UnderTesting', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (10, N'CaptureResult', N'CaptureResult', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (11, N'RejectedByLab', N'RejectedByLab', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (12, N'NotDeliveredByLab', N'NotDeliveredByLab', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (13, N'PendingForReporting', N'PendingForReporting', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (19, N'ReceivedForReporting', N'ReceivedForReporting', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (20, N'RecycledByQC', N'RecycledByQC', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (21, N'EditedByQC', N'EditedByQC', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (22, N'ApprovedByQC', N'ApprovedByQC', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (24, N'Printed', N'Printed', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (25, N'Finished', N'Finished', NULL)
SET IDENTITY_INSERT [dbo].[Status] OFF
SET IDENTITY_INSERT [dbo].[Unit] ON 

INSERT [dbo].[Unit] ([UnitId], [UnitName], [UnitDescription]) VALUES (1, N'Chemical', N'وحده الكيمياء الاكلينيكيه')
INSERT [dbo].[Unit] ([UnitId], [UnitName], [UnitDescription]) VALUES (2, N'Hermony', N'وحده الهرمونات')
INSERT [dbo].[Unit] ([UnitId], [UnitName], [UnitDescription]) VALUES (3, N'Torch', N'')
INSERT [dbo].[Unit] ([UnitId], [UnitName], [UnitDescription]) VALUES (4, N'Routine', N'')
INSERT [dbo].[Unit] ([UnitId], [UnitName], [UnitDescription]) VALUES (7, N'Biology', N'')
INSERT [dbo].[Unit] ([UnitId], [UnitName], [UnitDescription]) VALUES (8, N'Hematology
', N'وحده الدم')
INSERT [dbo].[Unit] ([UnitId], [UnitName], [UnitDescription]) VALUES (9, N'Immunity
', N'وحده المناعة')
INSERT [dbo].[Unit] ([UnitId], [UnitName], [UnitDescription]) VALUES (10, N'Micro Biology
', N'وحده البيولوجيا الجزيئية')
INSERT [dbo].[Unit] ([UnitId], [UnitName], [UnitDescription]) VALUES (11, N'Para
', NULL)
SET IDENTITY_INSERT [dbo].[Unit] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [EmployeeID], [UserName], [UserPassword], [LastLoginDate], [IsAdmin], [RoleID]) VALUES (1, 1, N'Mohamed', N'123', CAST(0x0000A62A00D26E07 AS DateTime), 1, 5)
INSERT [dbo].[User] ([UserID], [EmployeeID], [UserName], [UserPassword], [LastLoginDate], [IsAdmin], [RoleID]) VALUES (2, 2, N'Taha', N'123', CAST(0x0000A66300BC164C AS DateTime), 1, 5)
INSERT [dbo].[User] ([UserID], [EmployeeID], [UserName], [UserPassword], [LastLoginDate], [IsAdmin], [RoleID]) VALUES (3, 6, N'Amr', N'123', CAST(0x0000A66300BC41A1 AS DateTime), 1, 5)
INSERT [dbo].[User] ([UserID], [EmployeeID], [UserName], [UserPassword], [LastLoginDate], [IsAdmin], [RoleID]) VALUES (4, 7, N'Modather', N'123', CAST(0x0000A66300BC508D AS DateTime), 1, 5)
SET IDENTITY_INSERT [dbo].[User] OFF
/****** Object:  Index [IX_Analysis_SampleTypeID]    Script Date: 8/15/2016 11:28:25 AM ******/
CREATE NONCLUSTERED INDEX [IX_Analysis_SampleTypeID] ON [dbo].[Analysis]
(
	[SampleTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AnalysisResultDetails] ADD  CONSTRAINT [DF_AnalysisDetails_UnitOfMeasure]  DEFAULT ('') FOR [UnitOfMeasure]
GO
ALTER TABLE [dbo].[AnalysisResultDetails] ADD  CONSTRAINT [DF_AnalysisDetails_DataType]  DEFAULT ('String') FOR [DataType]
GO
ALTER TABLE [dbo].[AnalysisResultDetails] ADD  CONSTRAINT [DF_AnalysisDetails_GroupTitle]  DEFAULT ('') FOR [SectionTitle]
GO
ALTER TABLE [dbo].[DeviceAnalysis] ADD  CONSTRAINT [DF_DeviceAnalysis_ReceiveDate]  DEFAULT (getdate()) FOR [ReceiveDate]
GO
ALTER TABLE [dbo].[DevicePlan] ADD  CONSTRAINT [DF_DevicePlan_TestDate]  DEFAULT (getdate()) FOR [TestDate]
GO
ALTER TABLE [dbo].[DoctorRef] ADD  CONSTRAINT [DF_DoctorRef_InsertionDate]  DEFAULT (getdate()) FOR [InsertionDate]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_JobDate]  DEFAULT (getdate()) FOR [JobDate]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_CityID]  DEFAULT (NULL) FOR [CityID]
GO
ALTER TABLE [dbo].[LabBranch] ADD  CONSTRAINT [DF_LabBranch_EstablishedDate]  DEFAULT (getdate()) FOR [EstablishedDate]
GO
ALTER TABLE [dbo].[NotDeliveredAnalysis] ADD  CONSTRAINT [DF_NotDeliveredAnalysis_NotDeliveredDate]  DEFAULT (getdate()) FOR [NotDeliveredDate]
GO
ALTER TABLE [dbo].[Organization] ADD  CONSTRAINT [DF_Organization_InsertionDate]  DEFAULT (getdate()) FOR [InsertionDate]
GO
ALTER TABLE [dbo].[PackageCostList] ADD  CONSTRAINT [DF_PackageCostList_CurrentAnalysisDiscountRate]  DEFAULT ((0)) FOR [CurrentAnalysisDiscountRate]
GO
ALTER TABLE [dbo].[Patient] ADD  CONSTRAINT [DF_Patient_RegisteredDate]  DEFAULT (getdate()) FOR [RegisteredDate]
GO
ALTER TABLE [dbo].[Patient] ADD  CONSTRAINT [DF_Patient_LastDataModified]  DEFAULT (getdate()) FOR [LastDataModified]
GO
ALTER TABLE [dbo].[PatientRequest] ADD  CONSTRAINT [DF_PatientRequest_RequestDate]  DEFAULT (getdate()) FOR [RequestDate]
GO
ALTER TABLE [dbo].[PatientRequestAnalysis] ADD  CONSTRAINT [DF_PatientRequestAnalysis_RequestDate]  DEFAULT (getdate()) FOR [RequestDate]
GO
ALTER TABLE [dbo].[PatientRequestAnalysisStatus] ADD  CONSTRAINT [DF_PatientRequestAnalysisStatus_StatusDate]  DEFAULT (getdate()) FOR [StatusDate]
GO
ALTER TABLE [dbo].[PatientRequestPayment] ADD  CONSTRAINT [DF_PatientRequestSummary_PaymentDate]  DEFAULT (getdate()) FOR [PaymentDate]
GO
ALTER TABLE [dbo].[PatientRequestStatus] ADD  CONSTRAINT [DF_PatientRequestStatus_StatusDate]  DEFAULT (getdate()) FOR [StatusDate]
GO
ALTER TABLE [dbo].[Permission] ADD  CONSTRAINT [DF_Permission_InsertionDate]  DEFAULT (getdate()) FOR [InsertionDate]
GO
ALTER TABLE [dbo].[RejectedAnalysis] ADD  CONSTRAINT [DF_RejectedAnalysis_RejectionDate]  DEFAULT (getdate()) FOR [RejectionDate]
GO
ALTER TABLE [dbo].[RequestedAnalysisResult] ADD  CONSTRAINT [DF_RequestedAnalysisResult_ResultDate]  DEFAULT (getdate()) FOR [ResultDate]
GO
ALTER TABLE [dbo].[RequestedAnalysisResult] ADD  CONSTRAINT [DF_RequestedAnalysisResult_ResultValue]  DEFAULT ('') FOR [ResultValue]
GO
ALTER TABLE [dbo].[RequestedAnalysisResult] ADD  CONSTRAINT [DF_RequestedAnalysisResult_EditedByQC]  DEFAULT ((0)) FOR [EditedByQC]
GO
ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [DF_Role_InsertionDate]  DEFAULT (getdate()) FOR [InsertionDate]
GO
ALTER TABLE [dbo].[UnitDevice] ADD  CONSTRAINT [DF_UnitDevice_IsDefaultDevice]  DEFAULT ((0)) FOR [IsDefaultDevice]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_LastLoginDate]  DEFAULT (getdate()) FOR [LastLoginDate]
GO
ALTER TABLE [dbo].[Analysis]  WITH CHECK ADD  CONSTRAINT [FK_Analysis_SampleType] FOREIGN KEY([SampleTypeID])
REFERENCES [dbo].[SampleType] ([SampleTypeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Analysis] CHECK CONSTRAINT [FK_Analysis_SampleType]
GO
ALTER TABLE [dbo].[Analysis]  WITH CHECK ADD  CONSTRAINT [FK_Analysis_Unit] FOREIGN KEY([UnitId])
REFERENCES [dbo].[Unit] ([UnitId])
GO
ALTER TABLE [dbo].[Analysis] CHECK CONSTRAINT [FK_Analysis_Unit]
GO
ALTER TABLE [dbo].[AnalysisResultDetails]  WITH CHECK ADD  CONSTRAINT [FK_AnalysisResultDetails_Analysis] FOREIGN KEY([AnalysisId])
REFERENCES [dbo].[Analysis] ([AnalysisID])
GO
ALTER TABLE [dbo].[AnalysisResultDetails] CHECK CONSTRAINT [FK_AnalysisResultDetails_Analysis]
GO
ALTER TABLE [dbo].[City]  WITH CHECK ADD  CONSTRAINT [FK_City_Province] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Province] ([ProvinceID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[City] CHECK CONSTRAINT [FK_City_Province]
GO
ALTER TABLE [dbo].[DeviceAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_DeviceAnalysis_DevicePlan] FOREIGN KEY([PlanId])
REFERENCES [dbo].[DevicePlan] ([PlanId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DeviceAnalysis] CHECK CONSTRAINT [FK_DeviceAnalysis_DevicePlan]
GO
ALTER TABLE [dbo].[DeviceAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_DeviceAnalysis_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[DeviceAnalysis] CHECK CONSTRAINT [FK_DeviceAnalysis_Employee]
GO
ALTER TABLE [dbo].[DeviceAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_DeviceAnalysis_PatientRequestAnalysis] FOREIGN KEY([RequestedAnalysisId])
REFERENCES [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID])
GO
ALTER TABLE [dbo].[DeviceAnalysis] CHECK CONSTRAINT [FK_DeviceAnalysis_PatientRequestAnalysis]
GO
ALTER TABLE [dbo].[DevicePlan]  WITH CHECK ADD  CONSTRAINT [FK_DevicePlan_Device] FOREIGN KEY([DeviceId])
REFERENCES [dbo].[Device] ([DeviceId])
GO
ALTER TABLE [dbo].[DevicePlan] CHECK CONSTRAINT [FK_DevicePlan_Device]
GO
ALTER TABLE [dbo].[DevicePlan]  WITH CHECK ADD  CONSTRAINT [FK_DevicePlan_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[DevicePlan] CHECK CONSTRAINT [FK_DevicePlan_Employee]
GO
ALTER TABLE [dbo].[DevicePlan]  WITH CHECK ADD  CONSTRAINT [FK_DevicePlan_Unit] FOREIGN KEY([UnitId])
REFERENCES [dbo].[Unit] ([UnitId])
GO
ALTER TABLE [dbo].[DevicePlan] CHECK CONSTRAINT [FK_DevicePlan_Unit]
GO
ALTER TABLE [dbo].[DoctorRef]  WITH CHECK ADD  CONSTRAINT [FK_DoctorRef_City] FOREIGN KEY([CityID])
REFERENCES [dbo].[City] ([CityID])
GO
ALTER TABLE [dbo].[DoctorRef] CHECK CONSTRAINT [FK_DoctorRef_City]
GO
ALTER TABLE [dbo].[DoctorRef]  WITH CHECK ADD  CONSTRAINT [FK_DoctorRef_DoctorSpecialization] FOREIGN KEY([SpecialID])
REFERENCES [dbo].[DoctorSpecialization] ([SpecialID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DoctorRef] CHECK CONSTRAINT [FK_DoctorRef_DoctorSpecialization]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_City] FOREIGN KEY([JobTitleID])
REFERENCES [dbo].[JobTitle] ([JobTitleID])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_City]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_LabBranch] FOREIGN KEY([CurrentBranchID])
REFERENCES [dbo].[LabBranch] ([BranchID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_LabBranch]
GO
ALTER TABLE [dbo].[LabBranch]  WITH CHECK ADD  CONSTRAINT [FK_LabBranch_City] FOREIGN KEY([CityID])
REFERENCES [dbo].[City] ([CityID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LabBranch] CHECK CONSTRAINT [FK_LabBranch_City]
GO
ALTER TABLE [dbo].[NotDeliveredAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_NotDeliveredAnalysis_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[NotDeliveredAnalysis] CHECK CONSTRAINT [FK_NotDeliveredAnalysis_Employee]
GO
ALTER TABLE [dbo].[NotDeliveredAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_NotDeliveredAnalysis_NotDeliveredReason] FOREIGN KEY([ReasonId])
REFERENCES [dbo].[NotDeliveredReason] ([ErrorId])
GO
ALTER TABLE [dbo].[NotDeliveredAnalysis] CHECK CONSTRAINT [FK_NotDeliveredAnalysis_NotDeliveredReason]
GO
ALTER TABLE [dbo].[NotDeliveredAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_NotDeliveredAnalysis_PatientRequestAnalysis] FOREIGN KEY([RequestedAnalysisId])
REFERENCES [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID])
GO
ALTER TABLE [dbo].[NotDeliveredAnalysis] CHECK CONSTRAINT [FK_NotDeliveredAnalysis_PatientRequestAnalysis]
GO
ALTER TABLE [dbo].[Organization]  WITH CHECK ADD  CONSTRAINT [FK_Organization_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_Organization_Employee]
GO
ALTER TABLE [dbo].[Organization]  WITH CHECK ADD  CONSTRAINT [FK_Organization_Package] FOREIGN KEY([PackageID])
REFERENCES [dbo].[Package] ([PackageID])
GO
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_Organization_Package]
GO
ALTER TABLE [dbo].[OrganizationCondition]  WITH CHECK ADD  CONSTRAINT [FK_OrganizationCondition_Condition] FOREIGN KEY([ConditionID])
REFERENCES [dbo].[Condition] ([ConditionID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrganizationCondition] CHECK CONSTRAINT [FK_OrganizationCondition_Condition]
GO
ALTER TABLE [dbo].[OrganizationCondition]  WITH CHECK ADD  CONSTRAINT [FK_OrganizationCondition_Organization] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
GO
ALTER TABLE [dbo].[OrganizationCondition] CHECK CONSTRAINT [FK_OrganizationCondition_Organization]
GO
ALTER TABLE [dbo].[OrganizationInfo]  WITH CHECK ADD  CONSTRAINT [FK_OrganizationInfo_City] FOREIGN KEY([CityID])
REFERENCES [dbo].[City] ([CityID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[OrganizationInfo] CHECK CONSTRAINT [FK_OrganizationInfo_City]
GO
ALTER TABLE [dbo].[OrganizationInfo]  WITH CHECK ADD  CONSTRAINT [FK_OrganizationInfo_Organization] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
GO
ALTER TABLE [dbo].[OrganizationInfo] CHECK CONSTRAINT [FK_OrganizationInfo_Organization]
GO
ALTER TABLE [dbo].[Package]  WITH CHECK ADD  CONSTRAINT [FK_Package_CategoryType] FOREIGN KEY([CategoryTypeID])
REFERENCES [dbo].[CategoryType] ([CategoryTypeID])
GO
ALTER TABLE [dbo].[Package] CHECK CONSTRAINT [FK_Package_CategoryType]
GO
ALTER TABLE [dbo].[PackageCostList]  WITH CHECK ADD  CONSTRAINT [FK_PackageCostList_Analysis] FOREIGN KEY([AnalysisID])
REFERENCES [dbo].[Analysis] ([AnalysisID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PackageCostList] CHECK CONSTRAINT [FK_PackageCostList_Analysis]
GO
ALTER TABLE [dbo].[PackageCostList]  WITH CHECK ADD  CONSTRAINT [FK_PackageCostList_Package] FOREIGN KEY([PackageID])
REFERENCES [dbo].[Package] ([PackageID])
GO
ALTER TABLE [dbo].[PackageCostList] CHECK CONSTRAINT [FK_PackageCostList_Package]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_City] FOREIGN KEY([CityID])
REFERENCES [dbo].[City] ([CityID])
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_City]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_Employee]
GO
ALTER TABLE [dbo].[PatientRequest]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequest_DoctorRef] FOREIGN KEY([DoctorRefID])
REFERENCES [dbo].[DoctorRef] ([DoctorRefID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PatientRequest] CHECK CONSTRAINT [FK_PatientRequest_DoctorRef]
GO
ALTER TABLE [dbo].[PatientRequest]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequest_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PatientRequest] CHECK CONSTRAINT [FK_PatientRequest_Employee]
GO
ALTER TABLE [dbo].[PatientRequest]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequest_Organization] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
GO
ALTER TABLE [dbo].[PatientRequest] CHECK CONSTRAINT [FK_PatientRequest_Organization]
GO
ALTER TABLE [dbo].[PatientRequest]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequest_Patient] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[PatientRequest] CHECK CONSTRAINT [FK_PatientRequest_Patient]
GO
ALTER TABLE [dbo].[PatientRequestAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequestAnalysis_Analysis] FOREIGN KEY([AnalysisID])
REFERENCES [dbo].[Analysis] ([AnalysisID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientRequestAnalysis] CHECK CONSTRAINT [FK_PatientRequestAnalysis_Analysis]
GO
ALTER TABLE [dbo].[PatientRequestAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequestAnalysis_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PatientRequestAnalysis] CHECK CONSTRAINT [FK_PatientRequestAnalysis_Employee]
GO
ALTER TABLE [dbo].[PatientRequestAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequestAnalysis_PatientRequest] FOREIGN KEY([RequestID])
REFERENCES [dbo].[PatientRequest] ([RequestID])
GO
ALTER TABLE [dbo].[PatientRequestAnalysis] CHECK CONSTRAINT [FK_PatientRequestAnalysis_PatientRequest]
GO
ALTER TABLE [dbo].[PatientRequestAnalysisStatus]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequestAnalysisStatus_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PatientRequestAnalysisStatus] CHECK CONSTRAINT [FK_PatientRequestAnalysisStatus_Employee]
GO
ALTER TABLE [dbo].[PatientRequestAnalysisStatus]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequestAnalysisStatus_PatientRequestAnalysis] FOREIGN KEY([RequestedAnalysisID])
REFERENCES [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID])
GO
ALTER TABLE [dbo].[PatientRequestAnalysisStatus] CHECK CONSTRAINT [FK_PatientRequestAnalysisStatus_PatientRequestAnalysis]
GO
ALTER TABLE [dbo].[PatientRequestAnalysisStatus]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequestAnalysisStatus_Status] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[PatientRequestAnalysisStatus] CHECK CONSTRAINT [FK_PatientRequestAnalysisStatus_Status]
GO
ALTER TABLE [dbo].[PatientRequestPayment]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequestPayment_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[PatientRequestPayment] CHECK CONSTRAINT [FK_PatientRequestPayment_Employee]
GO
ALTER TABLE [dbo].[PatientRequestPayment]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequestPayment_PatientRequest] FOREIGN KEY([RequestID])
REFERENCES [dbo].[PatientRequest] ([RequestID])
GO
ALTER TABLE [dbo].[PatientRequestPayment] CHECK CONSTRAINT [FK_PatientRequestPayment_PatientRequest]
GO
ALTER TABLE [dbo].[PatientRequestStatus]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequestStatus_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PatientRequestStatus] CHECK CONSTRAINT [FK_PatientRequestStatus_Employee]
GO
ALTER TABLE [dbo].[PatientRequestStatus]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequestStatus_PatientRequest] FOREIGN KEY([RequestID])
REFERENCES [dbo].[PatientRequest] ([RequestID])
GO
ALTER TABLE [dbo].[PatientRequestStatus] CHECK CONSTRAINT [FK_PatientRequestStatus_PatientRequest]
GO
ALTER TABLE [dbo].[PatientRequestStatus]  WITH CHECK ADD  CONSTRAINT [FK_PatientRequestStatus_Status] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[PatientRequestStatus] CHECK CONSTRAINT [FK_PatientRequestStatus_Status]
GO
ALTER TABLE [dbo].[Permission]  WITH CHECK ADD  CONSTRAINT [FK_Permission_Entity] FOREIGN KEY([EntityID])
REFERENCES [dbo].[Entity] ([EntityID])
GO
ALTER TABLE [dbo].[Permission] CHECK CONSTRAINT [FK_Permission_Entity]
GO
ALTER TABLE [dbo].[Permission]  WITH CHECK ADD  CONSTRAINT [FK_Permission_EntityAction] FOREIGN KEY([ActionID])
REFERENCES [dbo].[EntityAction] ([ActionID])
GO
ALTER TABLE [dbo].[Permission] CHECK CONSTRAINT [FK_Permission_EntityAction]
GO
ALTER TABLE [dbo].[Permission]  WITH CHECK ADD  CONSTRAINT [FK_Permission_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[Permission] CHECK CONSTRAINT [FK_Permission_Role]
GO
ALTER TABLE [dbo].[RejectedAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_RejectedAnalysis_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[RejectedAnalysis] CHECK CONSTRAINT [FK_RejectedAnalysis_Employee]
GO
ALTER TABLE [dbo].[RejectedAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_RejectedAnalysis_PatientRequestAnalysis] FOREIGN KEY([RequestedAnalysisId])
REFERENCES [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID])
GO
ALTER TABLE [dbo].[RejectedAnalysis] CHECK CONSTRAINT [FK_RejectedAnalysis_PatientRequestAnalysis]
GO
ALTER TABLE [dbo].[RejectedAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_RejectedAnalysis_RejectionReason] FOREIGN KEY([ReasonId])
REFERENCES [dbo].[RejectionReason] ([ErrorId])
GO
ALTER TABLE [dbo].[RejectedAnalysis] CHECK CONSTRAINT [FK_RejectedAnalysis_RejectionReason]
GO
ALTER TABLE [dbo].[RejectionReason]  WITH CHECK ADD  CONSTRAINT [FK_RejectionResson_RejectionReason] FOREIGN KEY([ErrorId])
REFERENCES [dbo].[RejectionReason] ([ErrorId])
GO
ALTER TABLE [dbo].[RejectionReason] CHECK CONSTRAINT [FK_RejectionResson_RejectionReason]
GO
ALTER TABLE [dbo].[RequestedAnalysisResult]  WITH CHECK ADD  CONSTRAINT [FK_RequestedAnalysisResult_AnalysisResultDetails] FOREIGN KEY([AnalysisDetailId])
REFERENCES [dbo].[AnalysisResultDetails] ([AnalysisDetailId])
GO
ALTER TABLE [dbo].[RequestedAnalysisResult] CHECK CONSTRAINT [FK_RequestedAnalysisResult_AnalysisResultDetails]
GO
ALTER TABLE [dbo].[RequestedAnalysisResult]  WITH CHECK ADD  CONSTRAINT [FK_RequestedAnalysisResult_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[RequestedAnalysisResult] CHECK CONSTRAINT [FK_RequestedAnalysisResult_Employee]
GO
ALTER TABLE [dbo].[RequestedAnalysisResult]  WITH CHECK ADD  CONSTRAINT [FK_RequestedAnalysisResult_PatientRequestAnalysis] FOREIGN KEY([RequestedAnalysisId])
REFERENCES [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID])
GO
ALTER TABLE [dbo].[RequestedAnalysisResult] CHECK CONSTRAINT [FK_RequestedAnalysisResult_PatientRequestAnalysis]
GO
ALTER TABLE [dbo].[SampleSeparation]  WITH CHECK ADD  CONSTRAINT [FK_SampleSeparation_SampleType] FOREIGN KEY([SampleId])
REFERENCES [dbo].[SampleType] ([SampleTypeID])
GO
ALTER TABLE [dbo].[SampleSeparation] CHECK CONSTRAINT [FK_SampleSeparation_SampleType]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Employee]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[23] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Analysis"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SampleType"
            Begin Extent = 
               Top = 6
               Left = 478
               Bottom = 102
               Right = 648
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Unit"
            Begin Extent = 
               Top = 6
               Left = 686
               Bottom = 119
               Right = 857
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Analysis_Unit_Sample'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Analysis_Unit_Sample'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[38] 4[4] 2[23] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "RequestedAnalysisResult"
            Begin Extent = 
               Top = 6
               Left = 276
               Bottom = 136
               Right = 505
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "Analysis"
            Begin Extent = 
               Top = 6
               Left = 543
               Bottom = 136
               Right = 713
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "AnalysisResultDetails"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 25
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortO' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AnalysisResult_Details'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'rder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AnalysisResult_Details'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AnalysisResult_Details'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[4] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Patient"
            Begin Extent = 
               Top = 13
               Left = 654
               Bottom = 261
               Right = 836
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PatientRequest"
            Begin Extent = 
               Top = 0
               Left = 357
               Bottom = 130
               Right = 611
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "Organization"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 257
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Package"
            Begin Extent = 
               Top = 139
               Left = 422
               Bottom = 269
               Right = 612
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategoryType"
            Begin Extent = 
               Top = 158
               Left = 183
               Bottom = 254
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 34
         Width = 284
         Width = 2040
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2250
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PatientRequest"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "PatientRequestStatus"
            Begin Extent = 
               Top = 6
               Left = 284
               Bottom = 136
               Right = 458
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Status"
            Begin Extent = 
               Top = 6
               Left = 496
               Bottom = 136
               Right = 666
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Patient"
            Begin Extent = 
               Top = 6
               Left = 704
               Bottom = 136
               Right = 886
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategoryType"
            Begin Extent = 
               Top = 153
               Left = 27
               Bottom = 249
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Organization"
            Begin Extent = 
               Top = 138
               Left = 271
               Bottom = 268
               Right = 490
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Package"
            Begin Extent = 
               Top = 152
               Left = 613
               Bottom = 282
               Right = 803
            End
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_AllStatuses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'       DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_AllStatuses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_AllStatuses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PatientRequest"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 229
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "PatientRequestStatus"
            Begin Extent = 
               Top = 6
               Left = 267
               Bottom = 136
               Right = 441
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "LS"
            Begin Extent = 
               Top = 6
               Left = 479
               Bottom = 102
               Right = 649
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Status"
            Begin Extent = 
               Top = 102
               Left = 479
               Bottom = 232
               Right = 649
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Patient"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "CategoryType"
            Begin Extent = 
               Top = 138
               Left = 258
               Bottom = 234
               Right = 453
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Organization"
            Begin Extent = 
               Top = 234
               Left = 258
               Bottom = 364
               Right = 477
            End
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_LastStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Package"
            Begin Extent = 
               Top = 135
               Left = 683
               Bottom = 265
               Right = 873
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 46
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_LastStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_LastStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[51] 4[11] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -192
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PatientRequestAnalysis"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "PatientRequestAnalysisStatus"
            Begin Extent = 
               Top = 6
               Left = 274
               Bottom = 136
               Right = 491
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Status"
            Begin Extent = 
               Top = 6
               Left = 529
               Bottom = 136
               Right = 699
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Analysis"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "PatientRequest"
            Begin Extent = 
               Top = 138
               Left = 248
               Bottom = 268
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "SampleType"
            Begin Extent = 
               Top = 149
               Left = 550
               Bottom = 245
               Right = 720
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Patient"
            Begin Extent = 
               Top = 246
               Left = 494
               Bottom = 376
               Right = 676
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_PatientRequestAnalysis_AllStatuses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Unit"
            Begin Extent = 
               Top = 246
               Left = 714
               Bottom = 359
               Right = 885
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategoryType"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 366
               Right = 233
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Organization"
            Begin Extent = 
               Top = 270
               Left = 271
               Bottom = 400
               Right = 490
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Package"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 496
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_PatientRequestAnalysis_AllStatuses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_PatientRequestAnalysis_AllStatuses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[11] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PatientRequestAnalysis"
            Begin Extent = 
               Top = 5
               Left = 247
               Bottom = 211
               Right = 459
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PatientRequestAnalysisStatus"
            Begin Extent = 
               Top = 0
               Left = 457
               Bottom = 180
               Right = 708
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LS"
            Begin Extent = 
               Top = 129
               Left = 840
               Bottom = 225
               Right = 1038
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Status"
            Begin Extent = 
               Top = 1
               Left = 806
               Bottom = 131
               Right = 976
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Analysis"
            Begin Extent = 
               Top = 182
               Left = 649
               Bottom = 312
               Right = 821
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "PatientRequest"
            Begin Extent = 
               Top = 22
               Left = 16
               Bottom = 251
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "SampleType"
            Begin Extent = 
               Top = 212
               Left = 503
               Bottom = 308
               Right = 673
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_PatientRequestAnalysis_LastStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'        End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Patient"
            Begin Extent = 
               Top = 301
               Left = 74
               Bottom = 431
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 10
         End
         Begin Table = "Unit"
            Begin Extent = 
               Top = 294
               Left = 294
               Bottom = 407
               Right = 465
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategoryType"
            Begin Extent = 
               Top = 312
               Left = 503
               Bottom = 408
               Right = 698
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Organization"
            Begin Extent = 
               Top = 408
               Left = 294
               Bottom = 538
               Right = 513
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Package"
            Begin Extent = 
               Top = 408
               Left = 551
               Bottom = 538
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 31
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_PatientRequestAnalysis_LastStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_PatientRequestAnalysis_LastStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[4] 2[31] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PatientRequestAnalysis"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PatientRequestAnalysisStatus"
            Begin Extent = 
               Top = 6
               Left = 274
               Bottom = 136
               Right = 491
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LS"
            Begin Extent = 
               Top = 6
               Left = 529
               Bottom = 102
               Right = 727
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Status"
            Begin Extent = 
               Top = 102
               Left = 529
               Bottom = 232
               Right = 699
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Analysis"
            Begin Extent = 
               Top = 102
               Left = 737
               Bottom = 232
               Right = 909
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PatientRequest"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "SampleType"
            Begin Extent = 
               Top = 138
               Left = 284
               Bottom = 234
               Right = 454
      ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Patient"
            Begin Extent = 
               Top = 234
               Left = 284
               Bottom = 364
               Right = 466
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Unit"
            Begin Extent = 
               Top = 279
               Left = 38
               Bottom = 392
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DeviceAnalysis"
            Begin Extent = 
               Top = 250
               Left = 498
               Bottom = 380
               Right = 695
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "DevicePlan"
            Begin Extent = 
               Top = 366
               Left = 247
               Bottom = 496
               Right = 417
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Device"
            Begin Extent = 
               Top = 350
               Left = 728
               Bottom = 480
               Right = 912
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "CategoryType"
            Begin Extent = 
               Top = 384
               Left = 455
               Bottom = 480
               Right = 650
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Organization"
            Begin Extent = 
               Top = 480
               Left = 455
               Bottom = 610
               Right = 674
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Package"
            Begin Extent = 
               Top = 396
               Left = 38
               Bottom = 526
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 61
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 150' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane3', @value=N'0
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=3 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_PatientRequestAnalysis_LastStatus_Device'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[5] 2[25] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PatientRequest"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 257
               Right = 229
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "PatientRequestAnalysis"
            Begin Extent = 
               Top = 6
               Left = 267
               Bottom = 136
               Right = 476
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Analysis"
            Begin Extent = 
               Top = 6
               Left = 503
               Bottom = 136
               Right = 675
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "SampleType"
            Begin Extent = 
               Top = 89
               Left = 720
               Bottom = 185
               Right = 890
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 29
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientRequest_Analysis'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'        Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientRequest_Analysis'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientRequest_Analysis'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PatientRequest"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 253
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "PatientRequestPayment"
            Begin Extent = 
               Top = 6
               Left = 284
               Bottom = 136
               Right = 454
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientRequest_Payment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientRequest_Payment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PatientRequestAnalysis"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "PatientRequestAnalysisStatus"
            Begin Extent = 
               Top = 3
               Left = 347
               Bottom = 133
               Right = 661
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Status"
            Begin Extent = 
               Top = 4
               Left = 712
               Bottom = 134
               Right = 882
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Analysis"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PatientRequest"
            Begin Extent = 
               Top = 138
               Left = 248
               Bottom = 268
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SampleType"
            Begin Extent = 
               Top = 177
               Left = 543
               Bottom = 273
               Right = 713
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
      ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientRequestAnalysis_AllStatuses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'   Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientRequestAnalysis_AllStatuses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientRequestAnalysis_AllStatuses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[11] 2[22] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PatientRequestAnalysis"
            Begin Extent = 
               Top = 3
               Left = 233
               Bottom = 209
               Right = 445
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "PatientRequestAnalysisStatus"
            Begin Extent = 
               Top = 0
               Left = 455
               Bottom = 180
               Right = 706
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LS"
            Begin Extent = 
               Top = 129
               Left = 840
               Bottom = 225
               Right = 1038
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Status"
            Begin Extent = 
               Top = 1
               Left = 806
               Bottom = 131
               Right = 976
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Analysis"
            Begin Extent = 
               Top = 215
               Left = 250
               Bottom = 345
               Right = 422
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "PatientRequest"
            Begin Extent = 
               Top = 4
               Left = 4
               Bottom = 233
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "SampleType"
            Begin Extent = 
               Top = 213
               Left = 524
               Bottom = 309
               Right = 694
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientRequestAnalysis_LastStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 33
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientRequestAnalysis_LastStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientRequestAnalysis_LastStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[4] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DevicePlan"
            Begin Extent = 
               Top = 13
               Left = 375
               Bottom = 143
               Right = 545
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Unit"
            Begin Extent = 
               Top = 6
               Left = 676
               Bottom = 119
               Right = 847
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Device"
            Begin Extent = 
               Top = 14
               Left = 46
               Bottom = 144
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Employee"
            Begin Extent = 
               Top = 166
               Left = 598
               Bottom = 296
               Right = 775
            End
            DisplayFlags = 280
            TopColumn = 6
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 16
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         Sort' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Plan_Device_Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'Type = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Plan_Device_Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Plan_Device_Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[27] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Device"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Unit"
            Begin Extent = 
               Top = 18
               Left = 544
               Bottom = 131
               Right = 715
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GroupUnitDevice"
            Begin Extent = 
               Top = 132
               Left = 522
               Bottom = 245
               Right = 692
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Unit_Device'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Unit_Device'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[7] 2[19] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Device"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Unit"
            Begin Extent = 
               Top = 4
               Left = 480
               Bottom = 117
               Right = 651
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UnitDevice"
            Begin Extent = 
               Top = 5
               Left = 260
               Bottom = 135
               Right = 450
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SampleSeparation"
            Begin Extent = 
               Top = 45
               Left = 728
               Bottom = 158
               Right = 940
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SampleType"
            Begin Extent = 
               Top = 140
               Left = 407
               Bottom = 236
               Right = 577
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Unit_Device_SeparatedSample'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Unit_Device_SeparatedSample'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Unit_Device_SeparatedSample'
GO
USE [master]
GO
ALTER DATABASE [DemoMisrLab_V1] SET  READ_WRITE 
GO
