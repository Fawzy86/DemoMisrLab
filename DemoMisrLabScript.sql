USE [master]
GO
/****** Object:  Database [DemoMisrInt]    Script Date: 7/21/2016 6:00:18 PM ******/
CREATE DATABASE [DemoMisrInt]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Lab', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Lab.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Lab_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Lab_log.ldf' , SIZE = 12352KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DemoMisrInt] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DemoMisrInt].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DemoMisrInt] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DemoMisrInt] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DemoMisrInt] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DemoMisrInt] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DemoMisrInt] SET ARITHABORT OFF 
GO
ALTER DATABASE [DemoMisrInt] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DemoMisrInt] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [DemoMisrInt] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DemoMisrInt] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DemoMisrInt] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DemoMisrInt] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DemoMisrInt] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DemoMisrInt] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DemoMisrInt] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DemoMisrInt] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DemoMisrInt] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DemoMisrInt] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DemoMisrInt] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DemoMisrInt] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DemoMisrInt] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DemoMisrInt] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DemoMisrInt] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DemoMisrInt] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DemoMisrInt] SET RECOVERY FULL 
GO
ALTER DATABASE [DemoMisrInt] SET  MULTI_USER 
GO
ALTER DATABASE [DemoMisrInt] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DemoMisrInt] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DemoMisrInt] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DemoMisrInt] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [DemoMisrInt]
GO
/****** Object:  StoredProcedure [dbo].[GetAnalysisRunNumber]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetPatientRefID]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[Analysis]    Script Date: 7/21/2016 6:00:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Analysis](
	[AnalysisID] [int] IDENTITY(1,1) NOT NULL,
	[AnalysisCode] [nchar](20) NOT NULL,
	[AnalysisName] [nvarchar](50) NOT NULL,
	[NormalRange] [nvarchar](50) NULL,
	[SampleTypeID] [int] NOT NULL,
	[MinimumValue] [decimal](18, 0) NOT NULL,
	[MaximumValue] [decimal](18, 0) NOT NULL,
	[CostPrice] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_Analysis] PRIMARY KEY CLUSTERED 
(
	[AnalysisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AnalysisResult]    Script Date: 7/21/2016 6:00:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AnalysisResult](
	[AnalysisResultID] [int] NOT NULL,
	[RquestedAnalysisID] [int] NOT NULL,
	[Result] [varchar](50) NOT NULL,
	[ExamineByEmployeeID] [int] NOT NULL,
	[ExamineDate] [datetime] NOT NULL,
	[IsApproved] [bit] NULL,
 CONSTRAINT [PK_AnalysisValue] PRIMARY KEY CLUSTERED 
(
	[AnalysisResultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AnalysisResultStatus]    Script Date: 7/21/2016 6:00:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AnalysisResultStatus](
	[AnalysisResultStatusID] [int] NOT NULL,
	[AnalysisResultID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
	[StatusDate] [datetime] NOT NULL,
	[Comment] [nvarchar](255) NULL,
 CONSTRAINT [PK_AnalysisResultStatus] PRIMARY KEY CLUSTERED 
(
	[AnalysisResultStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoryType]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[City]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[Condition]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[DoctorRef]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[DoctorSpecialization]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[Employee]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[Entity]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[EntityAction]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[JobTitle]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[LabBranch]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[Organization]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[OrganizationCondition]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[OrganizationConsuming]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[OrganizationInfo]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[Package]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[PackageCostList]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[Patient]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[PatientRefID]    Script Date: 7/21/2016 6:00:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientRefID](
	[LastPatientRefID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientRequest]    Script Date: 7/21/2016 6:00:18 PM ******/
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
 CONSTRAINT [PK_PatientRequest] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientRequestAnalysis]    Script Date: 7/21/2016 6:00:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientRequestAnalysis](
	[RequestedAnalysisID] [int] IDENTITY(1,1) NOT NULL,
	[RequestID] [int] NOT NULL,
	[AnalysisID] [int] NOT NULL,
	[RequestDate] [datetime] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[RunNumber] [int] NULL,
 CONSTRAINT [PK_PatientRequests] PRIMARY KEY CLUSTERED 
(
	[RequestedAnalysisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientRequestAnalysisStatus]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[PatientRequestPayment]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[PatientRequestStatus]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[Permission]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[Priority]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[Province]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[RunNumber]    Script Date: 7/21/2016 6:00:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RunNumber](
	[RunNum] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SampleType]    Script Date: 7/21/2016 6:00:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SampleType](
	[SampleTypeID] [int] IDENTITY(1,1) NOT NULL,
	[SampleType] [nchar](20) NULL,
 CONSTRAINT [PK_SampleType] PRIMARY KEY CLUSTERED 
(
	[SampleTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Status]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 7/21/2016 6:00:18 PM ******/
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
/****** Object:  View [dbo].[Patient_PatientRequest]    Script Date: 7/21/2016 6:00:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Patient_PatientRequest]
AS
SELECT        dbo.Patient.FirstName, dbo.Patient.MiddleName, dbo.Patient.LastName, dbo.Patient.Gender, dbo.Patient.Address, dbo.Patient.CityID, dbo.Patient.NationalID, dbo.Patient.BirthDate, dbo.Patient.Mobile, 
                         dbo.Patient.Phone, dbo.Patient.Email, dbo.Patient.ReferenceID, dbo.Patient.RegisteredDate, dbo.Patient.LastDataModified, dbo.PatientRequest.RequestID, dbo.PatientRequest.RequestDate, 
                         dbo.PatientRequest.EmployeeID, dbo.PatientRequest.Comment, dbo.PatientRequest.DoctorRefID, dbo.PatientRequest.Priority, dbo.PatientRequest.OrganizationID, dbo.PatientRequest.RequestedRefID, 
                         dbo.PatientRequest.AttachmentSession, dbo.PatientRequest.PatientID, dbo.PatientRequest.ExtraDiscount, dbo.PatientRequest.ExtraCost, dbo.PatientRequest.TotalPatientCost, 
                         dbo.PatientRequest.TotalOrganizationCost
FROM            dbo.Patient INNER JOIN
                         dbo.PatientRequest ON dbo.Patient.PatientID = dbo.PatientRequest.PatientID

GO
/****** Object:  View [dbo].[Patient_PatientRequest_LastStatus]    Script Date: 7/21/2016 6:00:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Patient_PatientRequest_LastStatus]
AS
SELECT        dbo.PatientRequest.RequestDate, dbo.PatientRequest.EmployeeID AS PatientRequestEmployeeID, dbo.PatientRequest.Comment AS PatientRequestComment, dbo.PatientRequest.DoctorRefID, 
                         dbo.PatientRequest.Priority, dbo.PatientRequest.OrganizationID, dbo.PatientRequest.RequestedRefID, dbo.PatientRequest.AttachmentSession, dbo.PatientRequestStatus.RequestStatusID, 
                         dbo.PatientRequestStatus.RequestID, dbo.PatientRequestStatus.StatusDate, dbo.PatientRequestStatus.EmployeeID AS PatientRequestStatusEmployeeID, 
                         dbo.PatientRequestStatus.Comment AS PatientRequestStatusComment, dbo.Status.StatusIdentifier, dbo.Status.StatusName, dbo.Status.Description, dbo.Status.StatusID AS PatientRequestStatusID, 
                         dbo.Patient.PatientID, dbo.Patient.FirstName, dbo.Patient.MiddleName, dbo.Patient.LastName, dbo.Patient.Gender, dbo.Patient.Address, dbo.Patient.CityID, dbo.Patient.NationalID, dbo.Patient.BirthDate, 
                         dbo.Patient.Mobile, dbo.Patient.Phone, dbo.Patient.Email, dbo.Patient.ReferenceID, dbo.Patient.RegisteredDate, dbo.Patient.LastDataModified, dbo.PatientRequest.ExtraDiscount, dbo.PatientRequest.ExtraCost, 
                         dbo.PatientRequest.TotalPatientCost, dbo.PatientRequest.TotalOrganizationCost
FROM            dbo.PatientRequest INNER JOIN
                         dbo.PatientRequestStatus ON dbo.PatientRequest.RequestID = dbo.PatientRequestStatus.RequestID INNER JOIN
                             (SELECT        RequestID, MAX(RequestStatusID) AS LastStausID
                               FROM            dbo.PatientRequestStatus AS PatientRequestStatus_1
                               GROUP BY RequestID) AS LS ON LS.RequestID = dbo.PatientRequestStatus.RequestID AND LS.LastStausID = dbo.PatientRequestStatus.RequestStatusID INNER JOIN
                         dbo.Status ON dbo.PatientRequestStatus.StatusID = dbo.Status.StatusID INNER JOIN
                         dbo.Patient ON dbo.PatientRequest.PatientID = dbo.Patient.PatientID

GO
/****** Object:  View [dbo].[PatientRequest_Analysis]    Script Date: 7/21/2016 6:00:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PatientRequest_Analysis]
AS
SELECT        dbo.PatientRequest.RequestDate, dbo.PatientRequest.PatientID, dbo.PatientRequest.EmployeeID, dbo.PatientRequest.Comment, dbo.PatientRequest.DoctorRefID, dbo.PatientRequest.Priority, 
                         dbo.PatientRequest.OrganizationID, dbo.PatientRequest.RequestedRefID, dbo.PatientRequest.AttachmentSession, dbo.PatientRequestAnalysis.RequestedAnalysisID, dbo.PatientRequestAnalysis.RequestID, 
                         dbo.PatientRequestAnalysis.AnalysisID, dbo.PatientRequestAnalysis.RequestDate AS AnalysisRequestDate, dbo.PatientRequestAnalysis.EmployeeID AS RequestAnalysisEmployeeID, 
                         dbo.PatientRequestAnalysis.RunNumber, dbo.Analysis.AnalysisCode, dbo.Analysis.AnalysisName, dbo.Analysis.NormalRange, dbo.Analysis.SampleTypeID, dbo.Analysis.MinimumValue, 
                         dbo.Analysis.MaximumValue, dbo.Analysis.CostPrice, dbo.PatientRequest.ExtraDiscount, dbo.PatientRequest.ExtraCost, dbo.PatientRequest.TotalPatientCost, dbo.PatientRequest.TotalOrganizationCost
FROM            dbo.PatientRequest INNER JOIN
                         dbo.PatientRequestAnalysis ON dbo.PatientRequest.RequestID = dbo.PatientRequestAnalysis.RequestID INNER JOIN
                         dbo.Analysis ON dbo.PatientRequestAnalysis.AnalysisID = dbo.Analysis.AnalysisID

GO
/****** Object:  View [dbo].[PatientRequest_Payment]    Script Date: 7/21/2016 6:00:18 PM ******/
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
                         dbo.PatientRequestPayment.Comment AS PaymentComment
FROM            dbo.PatientRequest INNER JOIN
                         dbo.PatientRequestPayment ON dbo.PatientRequest.RequestID = dbo.PatientRequestPayment.RequestID

GO
SET IDENTITY_INSERT [dbo].[Analysis] ON 

INSERT [dbo].[Analysis] ([AnalysisID], [AnalysisCode], [AnalysisName], [NormalRange], [SampleTypeID], [MinimumValue], [MaximumValue], [CostPrice]) VALUES (1, N'S.Creatinine        ', N'S.Creatinine', N'10-20', 1, CAST(5 AS Decimal(18, 0)), CAST(25 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)))
INSERT [dbo].[Analysis] ([AnalysisID], [AnalysisCode], [AnalysisName], [NormalRange], [SampleTypeID], [MinimumValue], [MaximumValue], [CostPrice]) VALUES (2, N'S.UricAcid          ', N'S.Uric Acid', N'1-5', 1, CAST(1 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)), CAST(15 AS Decimal(18, 0)))
INSERT [dbo].[Analysis] ([AnalysisID], [AnalysisCode], [AnalysisName], [NormalRange], [SampleTypeID], [MinimumValue], [MaximumValue], [CostPrice]) VALUES (3, N'SGOT                ', N'SGOT/AST', N'2-6', 1, CAST(1 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)), CAST(17 AS Decimal(18, 0)))
INSERT [dbo].[Analysis] ([AnalysisID], [AnalysisCode], [AnalysisName], [NormalRange], [SampleTypeID], [MinimumValue], [MaximumValue], [CostPrice]) VALUES (4, N'SGPT                ', N'SGPT/ALT', N'5-9', 2, CAST(3 AS Decimal(18, 0)), CAST(15 AS Decimal(18, 0)), CAST(16 AS Decimal(18, 0)))
INSERT [dbo].[Analysis] ([AnalysisID], [AnalysisCode], [AnalysisName], [NormalRange], [SampleTypeID], [MinimumValue], [MaximumValue], [CostPrice]) VALUES (5, N'Sodium              ', N'Sodium (Na)', N'4-58', 3, CAST(3 AS Decimal(18, 0)), CAST(60 AS Decimal(18, 0)), CAST(12 AS Decimal(18, 0)))
INSERT [dbo].[Analysis] ([AnalysisID], [AnalysisCode], [AnalysisName], [NormalRange], [SampleTypeID], [MinimumValue], [MaximumValue], [CostPrice]) VALUES (6, N'Urine               ', N'Urine', N'3-9', 2, CAST(2 AS Decimal(18, 0)), CAST(16 AS Decimal(18, 0)), CAST(17 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Analysis] OFF
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

INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [JobDate], [Address], [CityID], [BirthDay], [Phone], [CurrentBranchID], [JobTitleID]) VALUES (1, N'Mohamed', N'Fawzy', CAST(0x0000A61800000000 AS DateTime), N'el sayda Asha', 1, CAST(0x20100B00 AS Date), N'01117224826', 1, 1)
INSERT [dbo].[Employee] ([EmployeeID], [FirstName], [LastName], [JobDate], [Address], [CityID], [BirthDay], [Phone], [CurrentBranchID], [JobTitleID]) VALUES (2, N'Ahmed', N'Tawfik', CAST(0x0000A5E900000000 AS DateTime), N'Tahrir', 1, CAST(0x0B160B00 AS Date), N'01011111111', 1, 2)
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
INSERT [dbo].[JobTitle] ([JobTitleID], [JobCode], [JobTitle]) VALUES (3, N'AnalysisDoc', N'Analysis Doctor')
SET IDENTITY_INSERT [dbo].[JobTitle] OFF
SET IDENTITY_INSERT [dbo].[LabBranch] ON 

INSERT [dbo].[LabBranch] ([BranchID], [BranchName], [Address], [CityID], [Phone], [EstablishedDate]) VALUES (1, N'Nasr City Lab', N'47 Zakr Hessin', 1, N'0123456789', CAST(0x823B0B00 AS Date))
INSERT [dbo].[LabBranch] ([BranchID], [BranchName], [Address], [CityID], [Phone], [EstablishedDate]) VALUES (2, N'New Cairo Lab', N'New Cairo ', 1, N'0111111111', CAST(0x823B0B00 AS Date))
SET IDENTITY_INSERT [dbo].[LabBranch] OFF
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
SET IDENTITY_INSERT [dbo].[Patient] ON 

INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (2, N'ahmed', NULL, NULL, N'Male', N'citadel', 1, NULL, CAST(0x0000794600000000 AS DateTime), N'01020305040', N'0203060507', N'm@yahoo.com', 1, 1, CAST(0x0000A62700000000 AS DateTime), CAST(0x0000A64100C3B6E3 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (4, N'Ahmed', N'Mansour', N'Farouk', N'Male', N'street 9', NULL, NULL, CAST(0x00006DDC00000000 AS DateTime), N'01111111111', N'02145879', N'ahmed@yahoo.com', 1, 2, CAST(0x0000A63200F7F9D5 AS DateTime), CAST(0x0000A63200F7F9D5 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (5, N'Mohamed', N'Fawzy', N'Ahmed', N'Male', NULL, 1, NULL, CAST(0x00007AB300000000 AS DateTime), N'0123654789', N'02365478', N'mohamed@yahoo.com', 1, 3, CAST(0x0000A64000C5E23A AS DateTime), CAST(0x0000A64000C5E23A AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (6, N'Mansour', N'Mostafa', NULL, N'Male', NULL, 2, NULL, CAST(0x0000878A00000000 AS DateTime), N'010203040', NULL, NULL, 1, 4, CAST(0x0000A64000D01AD0 AS DateTime), CAST(0x0000A64000D01ACF AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (7, N'Farouk', N'Ahmed', NULL, N'Male', NULL, 2, NULL, CAST(0x0000722300000000 AS DateTime), N'010309080', NULL, NULL, 1, 5, CAST(0x0000A64000D31540 AS DateTime), CAST(0x0000A64000D31540 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (8, N'Khaled', N'Ahmed', NULL, N'Male', NULL, 2, NULL, CAST(0x000077D800000000 AS DateTime), N'0119137546', NULL, NULL, 1, 6, CAST(0x0000A64000D48B8C AS DateTime), CAST(0x0000A64000D48B8C AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (9, N'Yaseen', N'ahmed', NULL, N'Male', NULL, 2, NULL, CAST(0x0000834200000000 AS DateTime), N'013698742', NULL, NULL, 1, 7, CAST(0x0000A64000DBF0E5 AS DateTime), CAST(0x0000A64000DBF0E5 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (10, N'Gama', N'Ahmed', NULL, N'Male', NULL, 2, NULL, CAST(0x0000699400000000 AS DateTime), N'01478965', NULL, NULL, 1, 8, CAST(0x0000A64000DF9ACC AS DateTime), CAST(0x0000A64000DF9ACC AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (11, N'Tarek', N'Ahmed', NULL, N'Male', NULL, 1, NULL, CAST(0x0000901A00000000 AS DateTime), N'01647895', NULL, NULL, 1, 9, CAST(0x0000A64000E0738B AS DateTime), CAST(0x0000A64000E0738B AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (12, N'Mousa', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 10, CAST(0x0000A64000E168C0 AS DateTime), CAST(0x0000A64000E168C0 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (13, N'Sad', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 11, CAST(0x0000A64000E1D706 AS DateTime), CAST(0x0000A64000E1D701 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (14, N'alaa', NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 1, 12, CAST(0x0000A64000E23052 AS DateTime), CAST(0x0000A64000E23052 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (15, N'lobna', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 13, CAST(0x0000A64000E2A312 AS DateTime), CAST(0x0000A64000E2A312 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (16, N'Tawfik', NULL, NULL, N'Male', NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 14, CAST(0x0000A64000E9B400 AS DateTime), CAST(0x0000A64000E9B400 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (17, N'emaad', NULL, NULL, N'Male', NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 15, CAST(0x0000A64000EAA52B AS DateTime), CAST(0x0000A64000EAA526 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (18, N'Fouad', NULL, NULL, N'Male', NULL, 2, NULL, NULL, NULL, NULL, NULL, 1, 16, CAST(0x0000A64000ECFB90 AS DateTime), CAST(0x0000A64000ECFB90 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (19, N'dd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 17, CAST(0x0000A64000EFE618 AS DateTime), CAST(0x0000A64000EFE618 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (20, N'aa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 18, CAST(0x0000A64000F16599 AS DateTime), CAST(0x0000A64000F16595 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (21, N'rrr', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 19, CAST(0x0000A64000F3E069 AS DateTime), CAST(0x0000A64000F3E069 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (22, N'Ahmed', NULL, NULL, N'Male', NULL, 2, NULL, CAST(0x0000766B00000000 AS DateTime), N'012365478915', NULL, NULL, 1, 20, CAST(0x0000A64000FD4096 AS DateTime), CAST(0x0000A64000FE0569 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (23, N'ii', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 21, CAST(0x0000A64000FF8DE3 AS DateTime), CAST(0x0000A64000FF8DE3 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (24, N'mm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 22, CAST(0x0000A6400100A0D4 AS DateTime), CAST(0x0000A6400100A0D4 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (25, N'22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 23, CAST(0x0000A6400106798C AS DateTime), CAST(0x0000A6400106798C AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (26, N'sss', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 24, CAST(0x0000A6400106DA7D AS DateTime), CAST(0x0000A6400106DA7D AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (27, N'qaq', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 25, CAST(0x0000A64001071C51 AS DateTime), CAST(0x0000A64001071C51 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (28, N'rbf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 26, CAST(0x0000A64001099C59 AS DateTime), CAST(0x0000A64001099C59 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (29, N'ff', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 27, CAST(0x0000A640010E749F AS DateTime), CAST(0x0000A640010E749F AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (30, N'gggg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 28, CAST(0x0000A640010F45A4 AS DateTime), CAST(0x0000A640010F45A3 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (31, N'hghhg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 29, CAST(0x0000A640010F5FA7 AS DateTime), CAST(0x0000A640010F5FA7 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (32, N'ghjghg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 30, CAST(0x0000A64001103D11 AS DateTime), CAST(0x0000A64001103D11 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (33, N'fgdfgd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 31, CAST(0x0000A640011122EF AS DateTime), CAST(0x0000A640011122EF AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (34, N'fgfgfd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 32, CAST(0x0000A6400113368F AS DateTime), CAST(0x0000A6400113368E AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (35, N'dfdsf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 33, CAST(0x0000A64001137D00 AS DateTime), CAST(0x0000A64001137D00 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (36, N'dfs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 34, CAST(0x0000A6400114117B AS DateTime), CAST(0x0000A6400114117A AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (37, N'dsfdsf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 35, CAST(0x0000A64001160D22 AS DateTime), CAST(0x0000A64001160D22 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (38, N'plokij', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 36, CAST(0x0000A6400116D48B AS DateTime), CAST(0x0000A6400116D48B AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (39, N'sdsghghj', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 37, CAST(0x0000A6400117489B AS DateTime), CAST(0x0000A6400117489B AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (40, N'umlo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 38, CAST(0x0000A64001181747 AS DateTime), CAST(0x0000A64001181747 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (41, N'dsfdsfs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 39, CAST(0x0000A6400119C6FC AS DateTime), CAST(0x0000A6400119C6FC AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (42, N'dfdsfdfdsf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 40, CAST(0x0000A640011A815A AS DateTime), CAST(0x0000A640011A815A AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (43, N'juygrd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 41, CAST(0x0000A640011B72C8 AS DateTime), CAST(0x0000A640011B72C7 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (44, N'qxhy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 42, CAST(0x0000A640011BBCA0 AS DateTime), CAST(0x0000A640011BBC9F AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (45, N'q,o', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 43, CAST(0x0000A640011C2D68 AS DateTime), CAST(0x0000A640011C2D68 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (46, N'Taha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 44, CAST(0x0000A640011FB990 AS DateTime), CAST(0x0000A640011FB990 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (47, N'dskjdsalkjf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 45, CAST(0x0000A640011FFEA0 AS DateTime), CAST(0x0000A640011FFEA0 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (48, N'ftghtokrtphor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 46, CAST(0x0000A64001201AEF AS DateTime), CAST(0x0000A64001201AEF AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (49, N'jnig,houjhl;fg;l', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 47, CAST(0x0000A6400122188D AS DateTime), CAST(0x0000A6400122188D AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (50, N'ffg;lhjkrp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 48, CAST(0x0000A64001226C59 AS DateTime), CAST(0x0000A64001226C59 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (51, N'tbumoz', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 49, CAST(0x0000A64100A24F73 AS DateTime), CAST(0x0000A64100A24F73 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (52, N'yntvrcw', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 50, CAST(0x0000A64100A2D54D AS DateTime), CAST(0x0000A64100A2D54D AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (53, N'qzrvum', NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 1, 51, CAST(0x0000A64100A59EEA AS DateTime), CAST(0x0000A64100A59EEA AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (54, N'azns', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 52, CAST(0x0000A64100A8447D AS DateTime), CAST(0x0000A64100A8447D AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (55, N'ynrve', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 53, CAST(0x0000A64100A8A57D AS DateTime), CAST(0x0000A64100A8A57D AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (56, N'zmakqu', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 54, CAST(0x0000A64100AA916F AS DateTime), CAST(0x0000A64100AA916F AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (57, N'ac,w', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 55, CAST(0x0000A64100AC2870 AS DateTime), CAST(0x0000A64100AC2870 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (58, N'zb,qw', NULL, NULL, N'Male', NULL, 2, NULL, NULL, NULL, NULL, NULL, 1, 56, CAST(0x0000A64100AD3120 AS DateTime), CAST(0x0000A64100AD3120 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (59, N'qzvae', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 57, CAST(0x0000A64100AE06C5 AS DateTime), CAST(0x0000A64100AE06C5 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (60, N'bajw', NULL, NULL, N'Male', NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 58, CAST(0x0000A64100AEB9EE AS DateTime), CAST(0x0000A64100AEB9EE AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (61, N'zacdevq', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 59, CAST(0x0000A64100AF8488 AS DateTime), CAST(0x0000A64100AF8488 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (62, N'zaqcswbr', NULL, NULL, N'Male', NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 60, CAST(0x0000A64100AFF899 AS DateTime), CAST(0x0000A64100AFF899 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (63, N'canqjt', NULL, NULL, N'Female', NULL, 2, NULL, NULL, NULL, NULL, NULL, 1, 61, CAST(0x0000A64100B1B591 AS DateTime), CAST(0x0000A64100B1B591 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (64, N'ntgtntht', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 62, CAST(0x0000A64100B25A1E AS DateTime), CAST(0x0000A64100B25A1E AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (65, N'dsfsdfdsafhgtrh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 63, CAST(0x0000A64100B2FCA3 AS DateTime), CAST(0x0000A64100B2FCA3 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (66, N'dfdsegthy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 64, CAST(0x0000A64100B3D16E AS DateTime), CAST(0x0000A64100B3D16E AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (67, N'qwerty', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 65, CAST(0x0000A64100B58821 AS DateTime), CAST(0x0000A64100B58821 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (68, N'qwertnfvcs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 66, CAST(0x0000A64100B6FBFD AS DateTime), CAST(0x0000A64100B6FBFD AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (69, N'dsftrrgr', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 67, CAST(0x0000A64100B7FE97 AS DateTime), CAST(0x0000A64100B7FE97 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (70, N'bagw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 68, CAST(0x0000A64100B8B819 AS DateTime), CAST(0x0000A64100B8B819 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (71, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'33333333333', NULL, NULL, 1, 69, CAST(0x0000A64100C737F6 AS DateTime), CAST(0x0000A64100D61FAD AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (72, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'999999999999', NULL, NULL, 1, 70, CAST(0x0000A64100D6763F AS DateTime), CAST(0x0000A64100D6763F AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (73, N'dehbrnki', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 71, CAST(0x0000A64200DCB1E4 AS DateTime), CAST(0x0000A64200DCB1E4 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (74, N'afdferh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 72, CAST(0x0000A642010D9755 AS DateTime), CAST(0x0000A642010D9755 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (75, N'frnbrh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 73, CAST(0x0000A6420113DE4C AS DateTime), CAST(0x0000A6420113DE4C AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (76, N'dfsdgdg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 74, CAST(0x0000A642011646DF AS DateTime), CAST(0x0000A642011646DE AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (77, N'dfdsfdsf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 75, CAST(0x0000A64201168047 AS DateTime), CAST(0x0000A64201168047 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (78, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 76, CAST(0x0000A642012905B1 AS DateTime), CAST(0x0000A642012905B1 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (79, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'000000000000', NULL, 1, 77, CAST(0x0000A6420129D482 AS DateTime), CAST(0x0000A6420129D482 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (80, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'000000000000', NULL, 1, 78, CAST(0x0000A642012A5D8B AS DateTime), CAST(0x0000A642012A5D8B AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (81, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 79, CAST(0x0000A642012AD377 AS DateTime), CAST(0x0000A642012AD377 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (82, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 80, CAST(0x0000A642012BD7D3 AS DateTime), CAST(0x0000A642012BD7D3 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (83, N'qcamyvw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 83, CAST(0x0000A64300C348EE AS DateTime), CAST(0x0000A64300C348DC AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (84, N'qcamyvw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 84, CAST(0x0000A64300C386A9 AS DateTime), CAST(0x0000A64300C37A6C AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (85, N'qcamyvw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 85, CAST(0x0000A64300C3B14F AS DateTime), CAST(0x0000A64300C3AD3C AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (86, N'qcamyvw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 86, CAST(0x0000A64300C47DC8 AS DateTime), CAST(0x0000A64300C47899 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (87, N'qnake', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 87, CAST(0x0000A64300C4F64A AS DateTime), CAST(0x0000A64300C4F63B AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (88, N'mmmmmcccc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 88, CAST(0x0000A64300C572BF AS DateTime), CAST(0x0000A64300C572B9 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (89, N'vvvvxxxxaaajyr', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 89, CAST(0x0000A64300C5F10E AS DateTime), CAST(0x0000A64300C5F0FF AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (90, N'ahmed', N'said', N'Mohamed', N'Male', N'citadel', 1, NULL, CAST(0x0000794600000000 AS DateTime), N'0111423571', N'0214585555', NULL, 1, 90, CAST(0x0000A64300C6561E AS DateTime), CAST(0x0000A64300C65617 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (91, N'Ahmed', NULL, NULL, N'Male', NULL, 2, NULL, CAST(0x000077D800000000 AS DateTime), NULL, NULL, NULL, 1, 91, CAST(0x0000A64300C69D0B AS DateTime), CAST(0x0000A64300C69D04 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (92, N'Ahmed', NULL, NULL, N'Male', N'Citadel', 2, NULL, CAST(0x000077D800000000 AS DateTime), N'01111111', NULL, NULL, 1, 92, CAST(0x0000A64300C71AEC AS DateTime), CAST(0x0000A64300C71AE6 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (93, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 93, CAST(0x0000A64300C8223C AS DateTime), CAST(0x0000A64300C82236 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (94, N'ahmed', NULL, NULL, N'Male', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 94, CAST(0x0000A64300C9BC52 AS DateTime), CAST(0x0000A64300C9BC40 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (95, N'ahmed', NULL, NULL, N'Male', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 95, CAST(0x0000A64300CA2683 AS DateTime), CAST(0x0000A64300CA267C AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (96, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 96, CAST(0x0000A64300CA44DA AS DateTime), CAST(0x0000A64300CA44D3 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (97, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 97, CAST(0x0000A64300CA8289 AS DateTime), CAST(0x0000A64300CA8283 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (98, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 98, CAST(0x0000A64300CAFAAC AS DateTime), CAST(0x0000A64300CAFA9B AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (99, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 99, CAST(0x0000A64300CC7589 AS DateTime), CAST(0x0000A64300CC7579 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (100, N'ahmed', NULL, NULL, N'Female', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 100, CAST(0x0000A64300CD415B AS DateTime), CAST(0x0000A64300CD414A AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (101, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 101, CAST(0x0000A64300CDCCFD AS DateTime), CAST(0x0000A64300CDCCF7 AS DateTime))
GO
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (102, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 102, CAST(0x0000A64300CEBE8C AS DateTime), CAST(0x0000A64300CEBE86 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (103, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 103, CAST(0x0000A64300CF3316 AS DateTime), CAST(0x0000A64300CF3305 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (104, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 104, CAST(0x0000A64300CF5DE2 AS DateTime), CAST(0x0000A64300CF5DDC AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (105, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 105, CAST(0x0000A64300D0F3D1 AS DateTime), CAST(0x0000A64300D0F3CB AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (106, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 106, CAST(0x0000A64300D17907 AS DateTime), CAST(0x0000A64300D17901 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (107, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 107, CAST(0x0000A64300D1CBAD AS DateTime), CAST(0x0000A64300D1CBA6 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (108, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 108, CAST(0x0000A64300D21D72 AS DateTime), CAST(0x0000A64300D21D62 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (109, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 109, CAST(0x0000A64300D2EAB2 AS DateTime), CAST(0x0000A64300D2EAAA AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (110, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 110, CAST(0x0000A64300D3E147 AS DateTime), CAST(0x0000A64300D3E13F AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (111, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 111, CAST(0x0000A64300D432C1 AS DateTime), CAST(0x0000A64300D432BB AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (112, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 112, CAST(0x0000A64300D47B08 AS DateTime), CAST(0x0000A64300D47AFA AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (113, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 113, CAST(0x0000A64300D4D712 AS DateTime), CAST(0x0000A64300D4D70B AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (114, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 114, CAST(0x0000A64300D55DBC AS DateTime), CAST(0x0000A64300D55DAC AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (115, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 115, CAST(0x0000A64300D5E4D6 AS DateTime), CAST(0x0000A64300D5E4C5 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (116, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 116, CAST(0x0000A64300D68F5F AS DateTime), CAST(0x0000A64300D68F57 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (117, N'ahmed', NULL, NULL, N'Male', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, CAST(0x0000A64300D6E9C9 AS DateTime), CAST(0x0000A64300D70E84 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (118, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 118, CAST(0x0000A64300D72904 AS DateTime), CAST(0x0000A64300D728FD AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (119, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 119, CAST(0x0000A64300DBDB09 AS DateTime), CAST(0x0000A64300DBDAF9 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (120, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 120, CAST(0x0000A64300DFAEE8 AS DateTime), CAST(0x0000A64300DFAED9 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (121, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 121, CAST(0x0000A64300E4063D AS DateTime), CAST(0x0000A64300E4062E AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (122, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 122, CAST(0x0000A64300E695A6 AS DateTime), CAST(0x0000A64300E69597 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (123, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 123, CAST(0x0000A64300E819D4 AS DateTime), CAST(0x0000A64300E819C4 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (124, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 124, CAST(0x0000A64300E83B7C AS DateTime), CAST(0x0000A64300E83B72 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (125, N'ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 125, CAST(0x0000A64300E960B8 AS DateTime), CAST(0x0000A64300E960A6 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (126, N'Mohamed', NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000794600000000 AS DateTime), NULL, NULL, NULL, 1, 126, CAST(0x0000A64300E9DE6C AS DateTime), CAST(0x0000A64300E9DE66 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (127, N'Mohamed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 127, CAST(0x0000A64300EA3C30 AS DateTime), CAST(0x0000A64300EA3C2A AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (128, N'mohamed', NULL, NULL, N'Male', NULL, 1, NULL, CAST(0x0000794600000000 AS DateTime), NULL, NULL, NULL, 1, 3, CAST(0x0000A64300EEB898 AS DateTime), CAST(0x0000A64300EED418 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (129, N'ghytgrfthtr', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 129, CAST(0x0000A64300EF3C7A AS DateTime), CAST(0x0000A64300EF3C74 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (130, N'hythjtphjsbjneroi', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 130, CAST(0x0000A64300EF767E AS DateTime), CAST(0x0000A64300EF7677 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (131, N'mohamed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 3, CAST(0x0000A64300EFBB3B AS DateTime), CAST(0x0000A64300F00977 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (132, N'mohamed', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 3, CAST(0x0000A64300F06EA8 AS DateTime), CAST(0x0000A64300F0828B AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (133, N'amr ', N'ali ', N'mahmoud', N'Male', N'ffhdskf', 1, NULL, CAST(0x0000739100000000 AS DateTime), N'01063123337', N'025508655', N'amr@tekegy.com', 1, 133, CAST(0x0000A64300F2D80A AS DateTime), CAST(0x0000A64300F2D7FF AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (134, N'amr', N'ali', N'mahmoud', N'Male', NULL, 1, NULL, CAST(0x0000739100000000 AS DateTime), N'01063123337', N'025508655', N'amr@tekegy.com', 1, 134, CAST(0x0000A64300F3558E AS DateTime), CAST(0x0000A64300F3558C AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (135, N'ali', N'ali', N'mahmoud', N'Male', N'd', 1, NULL, CAST(0x0000739100000000 AS DateTime), N'01063123337', NULL, NULL, 1, 133, CAST(0x0000A64300F4DA3E AS DateTime), CAST(0x0000A64300F55245 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (136, N'amr', N'ali', NULL, N'Male', N'qar', 1, NULL, CAST(0x0000739100000000 AS DateTime), N'01064528954', NULL, NULL, 1, 134, CAST(0x0000A64300F7F3E3 AS DateTime), CAST(0x0000A64300F860E8 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (137, N'mohamed', NULL, N'ahmed', N'Male', NULL, NULL, NULL, CAST(0x0000878A00000000 AS DateTime), NULL, NULL, NULL, 1, 137, CAST(0x0000A643010EEA5B AS DateTime), CAST(0x0000A643010EEA4D AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (138, N'mohamed', NULL, N'fa', N'Male', NULL, NULL, NULL, CAST(0x0000878A00000000 AS DateTime), NULL, NULL, NULL, 1, 138, CAST(0x0000A643010F7BD4 AS DateTime), CAST(0x0000A643010F7BC6 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (139, N'mohamed', NULL, N'fa', N'Male', NULL, NULL, NULL, CAST(0x0000878A00000000 AS DateTime), NULL, NULL, NULL, 1, 139, CAST(0x0000A643010F9741 AS DateTime), CAST(0x0000A643010F973B AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (140, N'mohamed', NULL, N'fa', N'Male', NULL, NULL, NULL, CAST(0x0000794600000000 AS DateTime), N'0147852369', N'20608070', NULL, 1, 140, CAST(0x0000A643010FD8FA AS DateTime), CAST(0x0000A643010FD8F5 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (141, N'mohamed', NULL, N'fawzy', N'Male', NULL, NULL, NULL, CAST(0x000081D500000000 AS DateTime), NULL, NULL, NULL, 1, 141, CAST(0x0000A643011008A9 AS DateTime), CAST(0x0000A643011008A4 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (142, N'mohamed', NULL, N'fawzy', N'Male', NULL, NULL, NULL, CAST(0x0000559A00000000 AS DateTime), NULL, NULL, NULL, 1, 142, CAST(0x0000A6430110201B AS DateTime), CAST(0x0000A64301102016 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (143, N'Mohamed', N'Fawzy', N'Ahmed', N'Male', NULL, 1, NULL, CAST(0x0000794600000000 AS DateTime), N'01117224826', NULL, NULL, 1, 3, CAST(0x0000A64600B2AEDD AS DateTime), CAST(0x0000A64600B2C08B AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (144, N'Mohamed', N'Fawzy', N'Basuony', N'Male', NULL, 1, NULL, CAST(0x0000878A00000000 AS DateTime), NULL, NULL, NULL, 1, 144, CAST(0x0000A64600B75CB7 AS DateTime), CAST(0x0000A64600B75CA8 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (145, N'Mohamed', N'Fawzy', N'ah', N'Male', NULL, 1, NULL, CAST(0x000077D800000000 AS DateTime), NULL, NULL, NULL, 1, 3, CAST(0x0000A64600B78DDB AS DateTime), CAST(0x0000A64600B7CFDD AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (146, N'Moahmed', N'Fawzy', N'Ahmed', N'Baby', NULL, 3, NULL, CAST(0x000084B000000000 AS DateTime), NULL, NULL, NULL, 1, 146, CAST(0x0000A6460103BC2C AS DateTime), CAST(0x0000A6460103BC18 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (147, N'ahmed', NULL, N'el sayed', N'Male', NULL, 4, NULL, CAST(0x0000654C00000000 AS DateTime), NULL, NULL, NULL, 1, 147, CAST(0x0000A64601216619 AS DateTime), CAST(0x0000A64601216601 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (148, N'ahmed', NULL, N'mohamed', N'Male', NULL, 9, NULL, CAST(0x000084B000000000 AS DateTime), NULL, NULL, NULL, 1, 148, CAST(0x0000A64601299E38 AS DateTime), CAST(0x0000A64601299E29 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (149, N'ahmed', NULL, N'Mohamed', N'Male', NULL, 2, NULL, CAST(0x000081D500000000 AS DateTime), NULL, NULL, NULL, 1, 149, CAST(0x0000A646012AD04E AS DateTime), CAST(0x0000A646012AD048 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (150, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, 9, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 150, CAST(0x0000A646012B44FC AS DateTime), CAST(0x0000A646012B44F6 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (151, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, 5, NULL, CAST(0x0000654C00000000 AS DateTime), NULL, NULL, NULL, 1, 151, CAST(0x0000A646012BCAAF AS DateTime), CAST(0x0000A646012BCAAA AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (152, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, 4, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 152, CAST(0x0000A646012C78D1 AS DateTime), CAST(0x0000A646012C78CC AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (153, N'ahmed', NULL, N'Mohamed', N'Male', NULL, 2, NULL, CAST(0x000084B000000000 AS DateTime), NULL, NULL, NULL, 1, 153, CAST(0x0000A646012CF9CC AS DateTime), CAST(0x0000A646012CF9C6 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (154, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 154, CAST(0x0000A6460131942B AS DateTime), CAST(0x0000A64601319425 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (155, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 155, CAST(0x0000A6460131CDE5 AS DateTime), CAST(0x0000A6460131CDDF AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (156, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 156, CAST(0x0000A64601321AC3 AS DateTime), CAST(0x0000A64601321ABD AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (157, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 157, CAST(0x0000A6460132B5A3 AS DateTime), CAST(0x0000A6460132B59C AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (158, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 158, CAST(0x0000A6460132DD55 AS DateTime), CAST(0x0000A6460132DD4F AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (159, N'ahmed', NULL, N'mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 159, CAST(0x0000A64601335FF8 AS DateTime), CAST(0x0000A64601335FF2 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (160, N'ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 160, CAST(0x0000A6460133FF2C AS DateTime), CAST(0x0000A6460133FF25 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (161, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x000081D500000000 AS DateTime), NULL, NULL, NULL, 1, 90, CAST(0x0000A6460134424C AS DateTime), CAST(0x0000A646013468C5 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (162, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x000081D500000000 AS DateTime), NULL, NULL, NULL, 1, 90, CAST(0x0000A64601350391 AS DateTime), CAST(0x0000A64601350C02 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (163, N'ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 90, CAST(0x0000A6460135706D AS DateTime), CAST(0x0000A64601357BBF AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (164, N'ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 90, CAST(0x0000A6460135A616 AS DateTime), CAST(0x0000A6460135B2D9 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (165, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 90, CAST(0x0000A647009952CD AS DateTime), CAST(0x0000A64700997907 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (166, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 148, CAST(0x0000A647009A5B4D AS DateTime), CAST(0x0000A647009A739C AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (167, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000806800000000 AS DateTime), NULL, NULL, NULL, 1, 90, CAST(0x0000A64700A0341C AS DateTime), CAST(0x0000A64700A04B4E AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (168, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x00007D8D00000000 AS DateTime), NULL, NULL, NULL, 1, 168, CAST(0x0000A64700A20108 AS DateTime), CAST(0x0000A64700A200F8 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (169, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 169, CAST(0x0000A64700A2EC2D AS DateTime), CAST(0x0000A64700A2EC27 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (170, N'ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000184100000000 AS DateTime), NULL, NULL, NULL, 1, 170, CAST(0x0000A64700A33A24 AS DateTime), CAST(0x0000A64700A33A1E AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (171, N'ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x00007EFB00000000 AS DateTime), NULL, NULL, NULL, 1, 171, CAST(0x0000A64700A50119 AS DateTime), CAST(0x0000A64700A50113 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (172, N'ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x00007D8D00000000 AS DateTime), NULL, NULL, NULL, 1, 172, CAST(0x0000A64700A618EC AS DateTime), CAST(0x0000A64700A618E6 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (173, N'ahmed', NULL, N'mohamed', N'Male', NULL, NULL, NULL, CAST(0x00007D8D00000000 AS DateTime), NULL, NULL, NULL, 1, 173, CAST(0x0000A64700A683DB AS DateTime), CAST(0x0000A64700A683D5 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (174, N'ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 174, CAST(0x0000A64700A890C1 AS DateTime), CAST(0x0000A64700A890BB AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (175, N'Ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x00007D8D00000000 AS DateTime), NULL, NULL, NULL, 1, 90, CAST(0x0000A64700B2719B AS DateTime), CAST(0x0000A64700B27BBC AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (176, N'ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000834200000000 AS DateTime), NULL, NULL, NULL, 1, 90, CAST(0x0000A64700B5B21E AS DateTime), CAST(0x0000A64700B5BF15 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (177, N'ahmed', NULL, N'mohamed', N'Male', NULL, NULL, NULL, CAST(0x000074FE00000000 AS DateTime), NULL, NULL, NULL, 1, 154, CAST(0x0000A64700B5E6A9 AS DateTime), CAST(0x0000A64700B6CFF0 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (178, N'ahmed', NULL, N'Mohamed', N'Male', NULL, NULL, NULL, CAST(0x000074FE00000000 AS DateTime), NULL, NULL, NULL, 1, 178, CAST(0x0000A64700B71559 AS DateTime), CAST(0x0000A64700B71554 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (179, N'Ahmed', NULL, N'sayed', N'Male', NULL, NULL, NULL, CAST(0x000084B000000000 AS DateTime), NULL, NULL, NULL, 1, 179, CAST(0x0000A64700BE5799 AS DateTime), CAST(0x0000A64700BE578A AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (180, N'Ahmed', NULL, N'mohamed', N'Male', NULL, 9, NULL, CAST(0x00006DDC00000000 AS DateTime), NULL, NULL, NULL, 1, 90, CAST(0x0000A64700BEA8BC AS DateTime), CAST(0x0000A64700BEBB82 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (181, N'Mohamed', N'fawzy', N'ahmed', N'Male', NULL, 2, NULL, CAST(0x000081D500000000 AS DateTime), NULL, NULL, NULL, 1, 3, CAST(0x0000A64A00E48E9D AS DateTime), CAST(0x0000A64A00E4A4E0 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (182, N'mohamed ', NULL, N'Fawzy', N'Male', NULL, 2, NULL, CAST(0x0000946100000000 AS DateTime), NULL, NULL, NULL, 1, 141, CAST(0x0000A64A00F9E0BD AS DateTime), CAST(0x0000A64A00F9EB17 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (183, N'ahmed', NULL, N'mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000766B00000000 AS DateTime), NULL, NULL, NULL, 1, 90, CAST(0x0000A64A00FA3178 AS DateTime), CAST(0x0000A64A00FA3AE9 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (184, N'ahmed', NULL, N'mo', N'Male', NULL, 2, NULL, CAST(0x000084B000000000 AS DateTime), NULL, NULL, NULL, 1, 90, CAST(0x0000A64A00FD3A47 AS DateTime), CAST(0x0000A64A00FD487F AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (1143, N'ahmed', NULL, N'mohamed', N'Male', NULL, NULL, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 148, CAST(0x0000A64A010EB77A AS DateTime), CAST(0x0000A64A010EBC46 AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (1144, N'mohamed', NULL, N'ahmed', N'Male', NULL, 2, NULL, CAST(0x000048C300000000 AS DateTime), NULL, NULL, NULL, 1, 3, CAST(0x0000A64A0112DF1D AS DateTime), CAST(0x0000A64A0112E58D AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (1145, N'ahmed', NULL, N'mohamed', N'Male', NULL, 2, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 90, CAST(0x0000A64A01153EA8 AS DateTime), CAST(0x0000A64A0115442F AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (1146, N'Mohamed', NULL, N'ahmed', N'Male', NULL, 5, NULL, CAST(0x0000861D00000000 AS DateTime), NULL, NULL, NULL, 1, 3, CAST(0x0000A64A01168D54 AS DateTime), CAST(0x0000A64A011692DD AS DateTime))
INSERT [dbo].[Patient] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [Address], [CityID], [NationalID], [BirthDate], [Mobile], [Phone], [Email], [EmployeeID], [ReferenceID], [RegisteredDate], [LastDataModified]) VALUES (1147, N'sayed', NULL, N'ahmed', N'Male', NULL, 1, NULL, CAST(0x0000861D00000000 AS DateTime), N'01117224826', NULL, NULL, 1, 189, CAST(0x0000A64A0118316C AS DateTime), CAST(0x0000A64A0118315D AS DateTime))
SET IDENTITY_INSERT [dbo].[Patient] OFF
INSERT [dbo].[PatientRefID] ([LastPatientRefID]) VALUES (190)
SET IDENTITY_INSERT [dbo].[PatientRequest] ON 

INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (2, 2, CAST(0x0000A62700000000 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/001', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (3, 5, CAST(0x0000A64000C601B3 AS DateTime), 1, NULL, 1, N'Low', 2, N'000/000/000/002', NULL, NULL, NULL, CAST(29 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (4, 6, CAST(0x0000A64000D02EF7 AS DateTime), 1, NULL, 1, N'Low', 2, N'000/000/000/003', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (5, 7, CAST(0x0000A64000D32971 AS DateTime), 1, NULL, 4, NULL, 2, N'000/000/000/004', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (6, 8, CAST(0x0000A64000D48BE0 AS DateTime), 1, NULL, 3, NULL, 2, N'000/000/000/005', NULL, NULL, NULL, CAST(58 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (7, 9, CAST(0x0000A64000DBF136 AS DateTime), 1, NULL, 5, N'Low', 2, N'000/000/000/006', NULL, NULL, NULL, CAST(45 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (8, 10, CAST(0x0000A64000DF9B1B AS DateTime), 1, NULL, 8, N'Low', 2, N'000/000/000/007', NULL, NULL, NULL, CAST(47 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (9, 11, CAST(0x0000A64000E073DC AS DateTime), 1, NULL, 7, N'Low', 2, N'000/000/000/008', NULL, NULL, NULL, CAST(50 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (10, 13, CAST(0x0000A64000E1D757 AS DateTime), 1, NULL, 3, NULL, 2, N'000/000/000/009', NULL, NULL, NULL, CAST(29 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (11, 14, CAST(0x0000A64000E2309D AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/010', NULL, NULL, NULL, CAST(33 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (12, 15, CAST(0x0000A64000E2A35D AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/011', NULL, NULL, NULL, CAST(27 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (13, 16, CAST(0x0000A64000E9B448 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/000/012', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (14, 17, CAST(0x0000A64000EAA572 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/013', NULL, NULL, NULL, CAST(27 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (15, 18, CAST(0x0000A64000ECFBE5 AS DateTime), 1, NULL, 1, NULL, 2, N'000/000/000/014', NULL, NULL, NULL, CAST(48 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (16, 19, CAST(0x0000A64000EFE65F AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/015', NULL, NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (17, 20, CAST(0x0000A64000F165EA AS DateTime), 1, NULL, 1, NULL, 2, N'000/000/000/016', NULL, NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (18, 21, CAST(0x0000A64000F3E0B7 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/017', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (19, 22, CAST(0x0000A64000FD40E6 AS DateTime), 1, NULL, 3, NULL, 2, N'000/000/000/018', NULL, NULL, NULL, CAST(50 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (20, 22, CAST(0x0000A64000FE0586 AS DateTime), 1, NULL, 2, N'Low', 2, N'000/000/000/019', NULL, NULL, NULL, CAST(37 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (21, 23, CAST(0x0000A64000FF8E2C AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/020', NULL, NULL, NULL, CAST(27 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (22, 24, CAST(0x0000A6400100A122 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/021', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (23, 25, CAST(0x0000A640010679DB AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/022', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (24, 26, CAST(0x0000A6400106DA91 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/023', NULL, NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (25, 27, CAST(0x0000A64001071C66 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/024', NULL, NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (26, 28, CAST(0x0000A64001099CA7 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/025', NULL, NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (27, 29, CAST(0x0000A640010E74EE AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/026', NULL, NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (28, 30, CAST(0x0000A640010F45F2 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/027', NULL, NULL, NULL, CAST(10 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (29, 31, CAST(0x0000A640010F5FBE AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/028', NULL, NULL, NULL, CAST(10 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (30, 32, CAST(0x0000A64001103D5E AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/029', NULL, NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (31, 33, CAST(0x0000A6400111233A AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/030', NULL, NULL, NULL, CAST(16 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (32, 34, CAST(0x0000A640011336DC AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/031', NULL, NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (33, 35, CAST(0x0000A64001137D48 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/032', NULL, NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (34, 36, CAST(0x0000A640011411C3 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/033', NULL, NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (35, 37, CAST(0x0000A64001160D6B AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/034', NULL, NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (36, 38, CAST(0x0000A6400116D4D7 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/035', NULL, NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (37, 39, CAST(0x0000A640011748E4 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/036', NULL, NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (38, 40, CAST(0x0000A64001181791 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/037', NULL, NULL, NULL, CAST(10 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (39, 41, CAST(0x0000A6400119C747 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/038', NULL, NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (40, 42, CAST(0x0000A640011A81A1 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/039', NULL, NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (41, 43, CAST(0x0000A640011B7313 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/040', NULL, NULL, NULL, CAST(16 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (42, 44, CAST(0x0000A640011BBCEF AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/041', NULL, NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (43, 45, CAST(0x0000A640011C2DB2 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/042', NULL, NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (44, 46, CAST(0x0000A640011FB9A5 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/043', NULL, NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (45, 47, CAST(0x0000A640011FFEB3 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/044', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (46, 48, CAST(0x0000A64001201B01 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/045', NULL, NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (47, 49, CAST(0x0000A640012218D7 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/046', NULL, NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (48, 50, CAST(0x0000A64001226CBB AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/047', NULL, NULL, NULL, CAST(16 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (49, 51, CAST(0x0000A64100A24FC4 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/048', NULL, NULL, NULL, CAST(27 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (50, 52, CAST(0x0000A64100A2D560 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/049', NULL, NULL, NULL, CAST(29 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (51, 53, CAST(0x0000A64100A59F36 AS DateTime), 1, NULL, 1, NULL, 2, N'000/000/000/050', NULL, NULL, NULL, CAST(26 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (52, 54, CAST(0x0000A64100A844C9 AS DateTime), 1, NULL, 2, NULL, 2, N'000/000/000/051', NULL, NULL, NULL, CAST(22 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (53, 55, CAST(0x0000A64100A8A591 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/052', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (54, 56, CAST(0x0000A64100AA91BE AS DateTime), 1, NULL, 2, NULL, 2, N'000/000/000/053', NULL, NULL, NULL, CAST(44 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (55, 57, CAST(0x0000A64100AC28C4 AS DateTime), 1, NULL, 1, NULL, 2, N'000/000/000/054', NULL, NULL, NULL, CAST(45 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (56, 58, CAST(0x0000A64100AD317F AS DateTime), 1, NULL, 2, N'Low', 2, N'000/000/000/055', NULL, NULL, NULL, CAST(35 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (57, 59, CAST(0x0000A64100AE071B AS DateTime), 1, NULL, 2, NULL, 2, N'000/000/000/056', NULL, NULL, NULL, CAST(22 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (58, 60, CAST(0x0000A64100AEBA3E AS DateTime), 1, NULL, 2, N'Low', 2, N'000/000/000/057', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (59, 61, CAST(0x0000A64100AF84D9 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/058', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (60, 62, CAST(0x0000A64100AFF8EF AS DateTime), 1, NULL, 1, NULL, 2, N'000/000/000/059', NULL, NULL, NULL, CAST(34 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (61, 63, CAST(0x0000A64100B1B5E5 AS DateTime), 1, NULL, 2, N'High', 2, N'000/000/000/060', NULL, NULL, NULL, CAST(27 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (62, 64, CAST(0x0000A64100B25A73 AS DateTime), 1, NULL, 2, NULL, 2, N'000/000/000/061', NULL, NULL, NULL, CAST(39 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (63, 65, CAST(0x0000A64100B2FCEA AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/062', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (64, 66, CAST(0x0000A64100B3D1BA AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/063', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (65, 67, CAST(0x0000A64100B58877 AS DateTime), 1, NULL, 1, NULL, 2, N'000/000/000/064', NULL, NULL, NULL, CAST(32 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (66, 68, CAST(0x0000A64100B6FC52 AS DateTime), 1, NULL, 1, NULL, 2, N'000/000/000/065', NULL, NULL, NULL, CAST(22 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (67, 69, CAST(0x0000A64100B7FEE8 AS DateTime), 1, NULL, 1, NULL, 2, N'000/000/000/066', NULL, NULL, NULL, CAST(27 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (68, 70, CAST(0x0000A64100B8B86B AS DateTime), 1, NULL, 1, NULL, 2, N'000/000/000/067', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (69, 2, CAST(0x0000A64100BB778B AS DateTime), 1, NULL, 1, N'Low', 2, N'000/000/000/068', NULL, NULL, NULL, CAST(44 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (70, 2, CAST(0x0000A64100C3B72D AS DateTime), 1, NULL, 1, N'Medium', 2, N'000/000/000/069', NULL, NULL, NULL, CAST(49 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (71, 71, CAST(0x0000A64100C73940 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/070', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (72, 71, CAST(0x0000A64100D61FE1 AS DateTime), 1, NULL, 2, NULL, 2, N'000/000/000/071', NULL, NULL, NULL, CAST(33 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (73, 72, CAST(0x0000A64100D67641 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/072', NULL, NULL, NULL, CAST(16 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (74, 73, CAST(0x0000A64200DCB230 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/073', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (75, 74, CAST(0x0000A642010D97A1 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/074', NULL, NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (76, 75, CAST(0x0000A6420113DE96 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/075', NULL, NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (77, 76, CAST(0x0000A6420116472E AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/076', NULL, NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (78, 77, CAST(0x0000A6420116805B AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/077', NULL, NULL, NULL, CAST(16 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (79, 78, CAST(0x0000A64201290C86 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/078', NULL, NULL, NULL, CAST(29 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (80, 79, CAST(0x0000A6420129D499 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/079', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (81, 80, CAST(0x0000A642012A5DA2 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/080', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (82, 81, CAST(0x0000A642012AD38B AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/081', NULL, NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (83, 82, CAST(0x0000A642012BD7E7 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/000/082', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (84, 83, CAST(0x0000A64300C3494C AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/900/741', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (85, 84, CAST(0x0000A64300C3A1F7 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/869/351', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (86, 85, CAST(0x0000A64300C41215 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/481/118', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (87, 86, CAST(0x0000A64300C47DE0 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/114/135', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (88, 87, CAST(0x0000A64300C4F69A AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/757/610', NULL, NULL, NULL, CAST(29 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (89, 88, CAST(0x0000A64300C572D8 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/200/672', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (90, 89, CAST(0x0000A64300C5F15B AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/938/777', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (91, 90, CAST(0x0000A64300C6563C AS DateTime), 1, NULL, 11, N'Low', 2, N'000/000/265/674', NULL, NULL, NULL, CAST(33 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (92, 91, CAST(0x0000A64300C69D29 AS DateTime), 1, NULL, 13, N'Medium', 2, N'000/000/192/603', NULL, NULL, NULL, CAST(27 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (93, 92, CAST(0x0000A64300C71B09 AS DateTime), 1, NULL, 12, N'High', 2, N'000/000/804/530', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (94, 93, CAST(0x0000A64300C82251 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/145/482', NULL, NULL, NULL, CAST(27 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (95, 94, CAST(0x0000A64300C9BCA2 AS DateTime), 1, NULL, NULL, N'Medium', 2, N'000/000/308/659', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (96, 95, CAST(0x0000A64300CA2698 AS DateTime), 1, NULL, NULL, N'Medium', 2, N'000/000/050/200', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (97, 96, CAST(0x0000A64300CA44F0 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/164/110', NULL, NULL, NULL, CAST(32 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (98, 97, CAST(0x0000A64300CA829F AS DateTime), 1, NULL, NULL, N'Medium', 2, N'000/000/632/619', NULL, NULL, NULL, CAST(32 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (99, 98, CAST(0x0000A64300CAFAFF AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/638/314', NULL, NULL, NULL, CAST(27 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (100, 99, CAST(0x0000A64300CC75D7 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/816/922', NULL, NULL, NULL, CAST(32 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
GO
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (101, 100, CAST(0x0000A64300CD41A9 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/072/879', NULL, NULL, NULL, CAST(32 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (102, 101, CAST(0x0000A64300CDCD14 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/489/622', NULL, NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (103, 102, CAST(0x0000A64300CEBEA1 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/407/542', NULL, NULL, NULL, CAST(27 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (104, 103, CAST(0x0000A64300CF336A AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/224/474', NULL, NULL, NULL, CAST(32 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (105, 104, CAST(0x0000A64300CF5DF9 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/890/759', NULL, NULL, NULL, CAST(32 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (106, 105, CAST(0x0000A64300D0F3E8 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/318/364', NULL, NULL, NULL, CAST(26 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (107, 106, CAST(0x0000A64300D1791C AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/448/804', NULL, NULL, NULL, CAST(33 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (108, 107, CAST(0x0000A64300D1CBC2 AS DateTime), 1, NULL, NULL, N'Medium', 2, N'000/000/628/904', NULL, NULL, NULL, CAST(34 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (109, 108, CAST(0x0000A64300D21DBE AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/845/458', NULL, NULL, NULL, CAST(28 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (110, 109, CAST(0x0000A64300D2EAC9 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/081/606', NULL, NULL, NULL, CAST(29 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (111, 110, CAST(0x0000A64300D3E161 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/860/361', NULL, NULL, NULL, CAST(27 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (112, 111, CAST(0x0000A64300D432D6 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/778/625', NULL, NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (113, 112, CAST(0x0000A64300D47B52 AS DateTime), 1, NULL, NULL, N'Medium', 2, N'000/000/127/522', NULL, NULL, NULL, CAST(33 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (114, 113, CAST(0x0000A64300D4D728 AS DateTime), 1, NULL, NULL, N'Medium', 2, N'000/000/211/233', NULL, NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (115, 114, CAST(0x0000A64300D55E0D AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/589/615', NULL, NULL, NULL, CAST(33 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (116, 115, CAST(0x0000A64300D5E525 AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/302/241', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (117, 116, CAST(0x0000A64300D68F78 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/686/823', NULL, NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (118, 117, CAST(0x0000A64300D6EA19 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/791/342', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (119, 118, CAST(0x0000A64300D7291B AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/987/939', NULL, NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (120, 119, CAST(0x0000A64300DBDB56 AS DateTime), 1, NULL, NULL, N'Medium', 2, N'000/000/774/219', N'486c473c0ff5464598f0d91af717a9e3', NULL, NULL, CAST(33 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (121, 120, CAST(0x0000A64300DFAF38 AS DateTime), 1, NULL, NULL, N'Medium', 2, N'000/000/195/615', N'c2ea78cc81434549a3766250b68840a2', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (122, 121, CAST(0x0000A64300E4068C AS DateTime), 1, NULL, NULL, NULL, 2, N'000/000/748/698', N'55cd1a6d9bf149ac9f09e2aabbbe84f8', NULL, NULL, CAST(29 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (123, 122, CAST(0x0000A64300E695F4 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/300/202', N'77a259eb29ae44219cf84fcb7b5c3cb8', NULL, NULL, CAST(33 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (124, 123, CAST(0x0000A64300E81A23 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/685/126', N'2ab1010db5364750ba3b8ddd963ccb78', NULL, NULL, CAST(32 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (125, 124, CAST(0x0000A64300E83B92 AS DateTime), 1, NULL, NULL, N'Medium', 2, N'000/000/003/608', N'080be85e7a23475880bdcc5627ddf003', NULL, NULL, CAST(33 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (126, 125, CAST(0x0000A64300E9610D AS DateTime), 1, NULL, NULL, N'Medium', 2, N'000/000/153/765', N'15a70d2c631f401780d00baf308eb4ff', NULL, NULL, CAST(29 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (127, 126, CAST(0x0000A64300E9DE80 AS DateTime), 1, NULL, NULL, N'High', 2, N'000/000/216/383', N'8593c2da4d3d41358eb99a68c62d7f98', NULL, NULL, CAST(29 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (128, 127, CAST(0x0000A64300EA3C44 AS DateTime), 1, NULL, NULL, N'High', 2, N'000/000/077/283', N'8c39855daf7f4912922cb31eb10ba951', NULL, NULL, CAST(16 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (129, 128, CAST(0x0000A64300EEB8F8 AS DateTime), 1, NULL, 12, N'Medium', 2, N'000/000/655/465', N'bae5cbe13c1747b6b0280cc6bcbc42d2', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (130, 129, CAST(0x0000A64300EF3C8D AS DateTime), 1, NULL, NULL, N'Medium', 2, N'000/000/092/772', N'e5103b1961314a3db4676eda6522fb88', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (131, 130, CAST(0x0000A64300EF769A AS DateTime), 1, NULL, 13, N'Medium', 2, N'000/000/340/148', N'622959b10a4b48dd914f94dee1eb8036', NULL, NULL, CAST(29 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (132, 131, CAST(0x0000A64300EFBB5E AS DateTime), 1, NULL, 12, NULL, 2, N'000/000/437/287', N'96b19e0cca8a42af88d0162587e5ae32', NULL, NULL, CAST(32 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (133, 132, CAST(0x0000A64300F06F02 AS DateTime), 1, NULL, 11, N'Medium', 2, N'000/000/311/743', N'b12eaa49c846491c9c0ec53a909f9e75', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (134, 133, CAST(0x0000A64300F2D814 AS DateTime), 1, NULL, 15, N'High', 2, N'000/000/988/550', N'e9eaba6642e549a2808a96a8cba4f374', NULL, NULL, CAST(42 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (135, 134, CAST(0x0000A64300F35591 AS DateTime), 1, NULL, 15, N'Low', 2, N'000/000/246/256', N'13b7974209294b29aaf5f6df96f1e4f6', NULL, NULL, CAST(32 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (136, 135, CAST(0x0000A64300F4DA4A AS DateTime), 1, NULL, 15, N'Low', 2, N'000/000/649/742', N'30e81b895cd043579d59fd31c3223024', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (137, 136, CAST(0x0000A64300F7F3E6 AS DateTime), 1, NULL, 13, N'Low', 2, N'000/000/639/712', N'49b458ebcbce44a3ac5d89333eee0960', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (138, 137, CAST(0x0000A643010EEA9F AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/586/886', N'8a94bdf6d8204a42898db8e1ecdfabab', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (139, 138, CAST(0x0000A643010F7C1C AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/465/874', N'cfb17c6cac6d4730987b28660d78e68c', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (140, 139, CAST(0x0000A643010F9754 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/018/491', N'ce09bf49a60b4e0db1a6851d1504371a', NULL, NULL, CAST(10 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (141, 140, CAST(0x0000A643010FD915 AS DateTime), 1, NULL, 14, N'Low', 2, N'000/000/779/881', N'561d046c61994af284152d7789e1aa74', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (142, 141, CAST(0x0000A643011008C4 AS DateTime), 1, NULL, 7, N'Low', 2, N'000/000/698/261', N'5f3c0a31274e41bbac5cf2afdbc71cf9', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (143, 142, CAST(0x0000A64301102035 AS DateTime), 1, NULL, 5, N'Low', 2, N'000/000/204/602', N'2e903889d38a4781a11d7429bcc88821', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (144, 143, CAST(0x0000A64600B2AF00 AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/837/827', N'9c1f426fcecd43f4b629de7c3133f3fb', NULL, NULL, CAST(52 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (145, 144, CAST(0x0000A64600B75D06 AS DateTime), 1, NULL, 17, N'Low', 2, N'000/000/505/254', N'fe43ce5de0e84b1290b63820468a3262', NULL, NULL, CAST(33 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (146, 145, CAST(0x0000A64600B78DF4 AS DateTime), 1, NULL, 15, N'Low', 2, N'000/000/762/462', N'28b685580c2c41748aa07b60d3f9bbf4', NULL, NULL, CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (147, 146, CAST(0x0000A6460103BC55 AS DateTime), 1, NULL, 25, N'Low', 2, N'000/000/036/214', N'3d0c85a58f2b438a9935fe77a5e58920', NULL, NULL, CAST(27 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (148, 147, CAST(0x0000A646012166FA AS DateTime), 1, NULL, 28, N'Low', 2, N'000/000/250/581', N'23e7c961036e47768063c5d78e312843', NULL, NULL, CAST(30 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (149, 148, CAST(0x0000A64601299F2A AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/292/874', N'032282cbc7724a43bfa1a781d2c05cfa', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (150, 149, CAST(0x0000A646012AD075 AS DateTime), 1, NULL, 19, N'Low', 2, N'000/000/803/818', N'85fdb41a40214acabf11dcf8186f3975', NULL, NULL, CAST(10 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (151, 150, CAST(0x0000A646012B451E AS DateTime), 1, NULL, 16, N'Low', 2, N'000/000/676/766', N'a03b2af9de0e4a04aca52c7c3bf57134', NULL, NULL, CAST(29 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (152, 151, CAST(0x0000A646012BCAD1 AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/747/775', N'b5f39a75250241aab2007b0499b23fec', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (153, 152, CAST(0x0000A646012C78F4 AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/015/086', N'0b555c0e0db744ec95449814e8969a88', NULL, NULL, CAST(10 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (154, 153, CAST(0x0000A646012CF9EE AS DateTime), 1, NULL, 15, N'Low', 2, N'000/000/712/574', N'a51b8e60c9e640a78988fde9ae8f6dcf', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (155, 154, CAST(0x0000A6460131944D AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/561/131', N'd532a463b38540cabb1978600a862277', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (156, 155, CAST(0x0000A6460131CE09 AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/844/376', N'd532a463b38540cabb1978600a862277', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (157, 156, CAST(0x0000A64601321AE4 AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/810/834', N'd532a463b38540cabb1978600a862277', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (158, 157, CAST(0x0000A6460132B5C6 AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/450/863', N'd532a463b38540cabb1978600a862277', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (159, 158, CAST(0x0000A6460132DD78 AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/607/456', N'd532a463b38540cabb1978600a862277', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (160, 159, CAST(0x0000A64601336014 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/998/162', N'2bb3d55df89341ecb43e68e6d0309808', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (161, 160, CAST(0x0000A6460133FF4E AS DateTime), 1, NULL, 17, N'Low', 2, N'000/000/538/395', N'63a32e3ef7e34252a0ec50a598020eda', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (162, 161, CAST(0x0000A6460134426E AS DateTime), 1, NULL, 17, N'Low', 2, N'000/000/582/680', N'e353578f09b240f894750c4cda0c1b3b', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (163, 162, CAST(0x0000A646013503B4 AS DateTime), 1, NULL, 17, N'Low', 2, N'000/000/846/302', N'e353578f09b240f894750c4cda0c1b3b', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (164, 163, CAST(0x0000A6460135708F AS DateTime), 1, NULL, 3, N'Low', 2, N'000/000/098/534', N'38cad010e1164cbfa228739e171beed3', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (165, 164, CAST(0x0000A6460135A63A AS DateTime), 1, NULL, 3, N'Low', 2, N'000/000/968/889', N'38cad010e1164cbfa228739e171beed3', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (166, 165, CAST(0x0000A64700995335 AS DateTime), 1, NULL, 12, N'Low', 2, N'000/000/098/515', N'3f56c9837ddd45d7a3e862e398021559', NULL, NULL, CAST(33 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (167, 166, CAST(0x0000A647009A5B70 AS DateTime), 1, NULL, 29, N'Low', 2, N'000/000/647/701', N'd72f4cef3fb94c528dbad2511aa6af5f', NULL, NULL, CAST(28 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (168, 167, CAST(0x0000A64700A03480 AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/628/326', N'218402e277494b2496a0d4e04a61724c', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (169, 168, CAST(0x0000A64700A20171 AS DateTime), 1, NULL, 16, N'Low', 2, N'000/000/490/740', N'842ca4a49f6e496fb5e14e29452db891', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (170, 169, CAST(0x0000A64700A2EC47 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/821/237', N'2c60b711685a4ae0a4d3e5310d9f0a65', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (171, 170, CAST(0x0000A64700A33A47 AS DateTime), 1, NULL, 15, N'Low', 2, N'000/000/495/722', N'de8e2bc5d5d9450b890a73af52ce79dd', NULL, NULL, CAST(16 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (172, 171, CAST(0x0000A64700A50136 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/570/710', N'd5442337c33249dbbd4e9f23fe4ccbb0', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (173, 172, CAST(0x0000A64700A6190E AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/526/875', N'189476d146d84fd9b2ba5b399a4714da', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (174, 173, CAST(0x0000A64700A683F6 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/641/283', N'f437edd369824de78012051625b92609', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (175, 174, CAST(0x0000A64700A890E3 AS DateTime), 1, NULL, 15, N'Low', 2, N'000/000/269/334', N'3854346e059d4775b71675697d9377f3', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (176, 175, CAST(0x0000A64700B271FA AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/595/471', N'63b1971233644b03a7dc458ad00828cb', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (177, 176, CAST(0x0000A64700B5B282 AS DateTime), 1, NULL, 14, N'Low', 2, N'000/000/032/509', N'b4c091ba684247c3b7af908b72b47033', NULL, NULL, CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (178, 177, CAST(0x0000A64700B5E6CA AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/262/331', N'26d111dc1e3d4e51a35e9f940ca04603', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (179, 178, CAST(0x0000A64700B7157A AS DateTime), 1, NULL, 17, N'Low', 2, N'000/000/317/100', N'c45e2b5f9eb04b8293088fd5b3a98372', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (180, 179, CAST(0x0000A64700BE57F1 AS DateTime), 1, NULL, 16, N'Low', 2, N'000/000/398/696', N'41b62f7b46bf46a0a4e20974e2a87900', NULL, NULL, CAST(26 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (181, 180, CAST(0x0000A64700BEA8E9 AS DateTime), 1, NULL, 30, N'Low', 2, N'000/000/852/207', N'590260ffc50e4ca38a9f55a103abf7e0', NULL, NULL, CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (182, 181, CAST(0x0000A64A00E48ED0 AS DateTime), 1, NULL, 19, N'Low', 2, N'000/000/450/185', N'7526f3222f4045a885a628de16dd1d44', CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(35 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (183, 182, CAST(0x0000A64A00F9E112 AS DateTime), 1, NULL, 3, N'Low', 2, N'000/000/762/615', N'152e746436234ff887f1d6fd989cc380', CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(42 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (184, 183, CAST(0x0000A64A00FA31A5 AS DateTime), 1, NULL, 2, N'Low', 2, N'000/000/503/185', N'e608961506674ef585663ce5e441400c', CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (185, 184, CAST(0x0000A64A00FD3AA1 AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/681/770', N'e47677859a7d46fc9bfc581c4177539c', CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(33 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (1182, 1143, CAST(0x0000A64A010EB7E6 AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/365/466', N'a8478fec88c2418987604de29e78856e', CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(17 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (1183, 1144, CAST(0x0000A64A0112DF72 AS DateTime), 1, NULL, 18, N'Low', 2, N'000/000/251/357', N'dca58e1dc7aa4d40806739c7f515fda1', CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(53 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (1184, 1145, CAST(0x0000A64A01153EF5 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/668/331', N'4abaa4276d7f4f58b561d434c92d28e1', CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(48 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (1185, 1146, CAST(0x0000A64A01168DA2 AS DateTime), 1, NULL, NULL, N'Low', 2, N'000/000/203/877', N'9652f671f40b4f709792bdeb65b4d079', CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(31 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[PatientRequest] ([RequestID], [PatientID], [RequestDate], [EmployeeID], [Comment], [DoctorRefID], [Priority], [OrganizationID], [RequestedRefID], [AttachmentSession], [ExtraDiscount], [ExtraCost], [TotalPatientCost], [TotalOrganizationCost]) VALUES (1186, 1147, CAST(0x0000A64A01183196 AS DateTime), 1, NULL, 1018, N'Low', 2, N'000/000/017/148', N'4e47887e5c214370a06eb0b281074f12', CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[PatientRequest] OFF
SET IDENTITY_INSERT [dbo].[PatientRequestAnalysis] ON 

INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (1, 2, 1, CAST(0x0000A62700E6A4E0 AS DateTime), 1, 1)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (2, 2, 2, CAST(0x0000A62700E6BA57 AS DateTime), 1, 2)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (3, 2, 4, CAST(0x0000A62700E6D4B4 AS DateTime), 1, 3)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (4, 2, 5, CAST(0x0000A62700E6DFBA AS DateTime), 1, 4)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (5, 3, 1, CAST(0x0000A64000C60E92 AS DateTime), 1, -1)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (6, 3, 4, CAST(0x0000A64000C62495 AS DateTime), 1, -1)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (7, 3, 5, CAST(0x0000A64000C629CB AS DateTime), 1, -1)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (8, 5, 2, CAST(0x0000A64000D337BA AS DateTime), 1, 9)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (9, 5, 3, CAST(0x0000A64000D33920 AS DateTime), 1, 10)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (10, 5, 5, CAST(0x0000A64000D33929 AS DateTime), 1, 11)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (11, 6, 2, CAST(0x0000A64000D48C11 AS DateTime), 1, 12)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (12, 6, 5, CAST(0x0000A64000D48C21 AS DateTime), 1, 13)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (13, 6, 6, CAST(0x0000A64000D48C2F AS DateTime), 1, 14)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (14, 7, 2, CAST(0x0000A64000DBF167 AS DateTime), 1, 15)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (15, 7, 4, CAST(0x0000A64000DBF172 AS DateTime), 1, 16)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (16, 7, 6, CAST(0x0000A64000DBF17C AS DateTime), 1, 17)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (17, 8, 3, CAST(0x0000A64000DF9B4D AS DateTime), 1, 18)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (18, 8, 5, CAST(0x0000A64000DF9B5E AS DateTime), 1, 19)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (19, 8, 6, CAST(0x0000A64000DF9B67 AS DateTime), 1, 20)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (20, 9, 3, CAST(0x0000A64000E07412 AS DateTime), 1, 21)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (21, 9, 4, CAST(0x0000A64000E0741D AS DateTime), 1, 22)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (22, 9, 6, CAST(0x0000A64000E0742B AS DateTime), 1, 23)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (23, 10, 3, CAST(0x0000A64000E1D788 AS DateTime), 1, 24)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (24, 10, 5, CAST(0x0000A64000E1D798 AS DateTime), 1, 25)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (25, 11, 3, CAST(0x0000A64000E230CE AS DateTime), 1, 26)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (26, 11, 4, CAST(0x0000A64000E230DA AS DateTime), 1, 27)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (27, 12, 2, CAST(0x0000A64000E2A390 AS DateTime), 1, 28)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (28, 12, 5, CAST(0x0000A64000E2A39E AS DateTime), 1, 29)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (29, 13, 2, CAST(0x0000A64000E9B479 AS DateTime), 1, 30)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (30, 13, 4, CAST(0x0000A64000E9B484 AS DateTime), 1, 31)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (31, 14, 2, CAST(0x0000A64000EAA5A9 AS DateTime), 1, 32)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (32, 14, 5, CAST(0x0000A64000EAA5B8 AS DateTime), 1, 33)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (33, 15, 2, CAST(0x0000A64000ECFC1B AS DateTime), 1, 34)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (34, 15, 4, CAST(0x0000A64000ECFC26 AS DateTime), 1, 35)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (35, 15, 6, CAST(0x0000A64000ECFC30 AS DateTime), 1, 36)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (36, 16, 2, CAST(0x0000A64000EFE690 AS DateTime), 1, 37)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (37, 17, 2, CAST(0x0000A64000F16616 AS DateTime), 1, 38)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (38, 18, 2, CAST(0x0000A64000F3E0EE AS DateTime), 1, 39)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (39, 18, 4, CAST(0x0000A64000F3E0FF AS DateTime), 1, 40)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (40, 19, 3, CAST(0x0000A64000FD411C AS DateTime), 1, 41)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (41, 19, 4, CAST(0x0000A64000FD4129 AS DateTime), 1, 42)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (42, 19, 6, CAST(0x0000A64000FD4136 AS DateTime), 1, 43)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (43, 20, 2, CAST(0x0000A64000FE05A0 AS DateTime), 1, 44)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (44, 21, 1, CAST(0x0000A64000FF8E5E AS DateTime), 1, 45)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (45, 21, 3, CAST(0x0000A64000FF8E6B AS DateTime), 1, 46)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (46, 22, 2, CAST(0x0000A6400100A156 AS DateTime), 1, 47)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (47, 22, 4, CAST(0x0000A6400100A165 AS DateTime), 1, 48)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (48, 23, 2, CAST(0x0000A64001067A13 AS DateTime), 1, 49)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (49, 23, 4, CAST(0x0000A64001067A23 AS DateTime), 1, 50)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (50, 24, 6, CAST(0x0000A6400106DAAD AS DateTime), 1, 51)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (51, 25, 3, CAST(0x0000A64001071C82 AS DateTime), 1, 52)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (52, 26, 2, CAST(0x0000A64001099CDE AS DateTime), 1, 53)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (53, 27, 3, CAST(0x0000A640010E7531 AS DateTime), 1, 54)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (54, 28, 1, CAST(0x0000A640010F4627 AS DateTime), 1, 55)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (55, 29, 1, CAST(0x0000A640010F5FDB AS DateTime), 1, 56)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (56, 30, 2, CAST(0x0000A64001103D92 AS DateTime), 1, 57)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (57, 31, 4, CAST(0x0000A64001112369 AS DateTime), 1, 58)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (58, 32, 3, CAST(0x0000A6400113370D AS DateTime), 1, 59)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (59, 33, 2, CAST(0x0000A64001137D85 AS DateTime), 1, 60)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (60, 34, 3, CAST(0x0000A64001141202 AS DateTime), 1, 61)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (61, 35, 2, CAST(0x0000A64001160D9E AS DateTime), 1, 62)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (62, 36, 2, CAST(0x0000A6400116D50A AS DateTime), 1, 63)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (63, 37, 2, CAST(0x0000A64001174919 AS DateTime), 1, 64)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (64, 38, 1, CAST(0x0000A640011817C2 AS DateTime), 1, 65)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (65, 39, 2, CAST(0x0000A6400119C77A AS DateTime), 1, 66)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (66, 40, 3, CAST(0x0000A640011A81D7 AS DateTime), 1, 67)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (67, 41, 4, CAST(0x0000A640011B734F AS DateTime), 1, 68)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (68, 42, 3, CAST(0x0000A640011BBD23 AS DateTime), 1, 69)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (69, 43, 3, CAST(0x0000A640011C2DE3 AS DateTime), 1, 70)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (70, 44, 2, CAST(0x0000A640011FB9C0 AS DateTime), 1, 71)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (71, 46, 3, CAST(0x0000A64001201B1B AS DateTime), 1, 72)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (72, 47, 3, CAST(0x0000A64001221908 AS DateTime), 1, 73)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (73, 48, 4, CAST(0x0000A64001226CED AS DateTime), 1, 74)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (74, 49, 2, CAST(0x0000A64100A2500B AS DateTime), 1, 75)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (75, 49, 5, CAST(0x0000A64100A2501F AS DateTime), 1, 76)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (76, 50, 3, CAST(0x0000A64100A2D57A AS DateTime), 1, 77)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (77, 50, 5, CAST(0x0000A64100A2D589 AS DateTime), 1, 78)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (78, 51, 1, CAST(0x0000A64100A59F67 AS DateTime), 1, 79)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (79, 51, 4, CAST(0x0000A64100A59F77 AS DateTime), 1, 80)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (80, 52, 1, CAST(0x0000A64100A844FF AS DateTime), 1, 81)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (81, 52, 5, CAST(0x0000A64100A8450E AS DateTime), 1, 82)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (82, 54, 2, CAST(0x0000A64100AA91F1 AS DateTime), 1, 83)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (83, 54, 4, CAST(0x0000A64100AA91FA AS DateTime), 1, 84)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (84, 54, 5, CAST(0x0000A64100AA920A AS DateTime), 1, 85)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (85, 55, 2, CAST(0x0000A64100AC28F1 AS DateTime), 1, 86)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (86, 55, 3, CAST(0x0000A64100AC2901 AS DateTime), 1, 87)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (87, 55, 5, CAST(0x0000A64100AC290B AS DateTime), 1, 88)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (88, 56, 3, CAST(0x0000A64100AD31B2 AS DateTime), 1, 89)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (89, 56, 6, CAST(0x0000A64100AD31C0 AS DateTime), 1, 90)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (90, 57, 1, CAST(0x0000A64100AE074C AS DateTime), 1, 91)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (91, 57, 5, CAST(0x0000A64100AE0757 AS DateTime), 1, 92)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (92, 58, 2, CAST(0x0000A64100AEBA6B AS DateTime), 1, 93)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (93, 58, 4, CAST(0x0000A64100AEBA7A AS DateTime), 1, 94)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (94, 59, 2, CAST(0x0000A64100AF850C AS DateTime), 1, 95)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (95, 59, 4, CAST(0x0000A64100AF8515 AS DateTime), 1, 96)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (96, 60, 3, CAST(0x0000A64100AFF922 AS DateTime), 1, 97)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (97, 60, 6, CAST(0x0000A64100AFF930 AS DateTime), 1, 98)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (98, 61, 2, CAST(0x0000A64100B1B621 AS DateTime), 1, 99)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (99, 61, 5, CAST(0x0000A64100B1B631 AS DateTime), 1, 100)
GO
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (100, 62, 1, CAST(0x0000A64100B25AA2 AS DateTime), 1, 101)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (101, 62, 3, CAST(0x0000A64100B25AB0 AS DateTime), 1, 102)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (102, 62, 5, CAST(0x0000A64100B25AC0 AS DateTime), 1, 103)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (103, 63, 2, CAST(0x0000A64100B2FD20 AS DateTime), 1, 104)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (104, 63, 4, CAST(0x0000A64100B2FD2B AS DateTime), 1, 105)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (105, 64, 2, CAST(0x0000A64100B3D1EB AS DateTime), 1, 106)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (106, 64, 4, CAST(0x0000A64100B3D200 AS DateTime), 1, 107)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (107, 65, 2, CAST(0x0000A64100B588A6 AS DateTime), 1, 108)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (108, 65, 6, CAST(0x0000A64100B588B4 AS DateTime), 1, 109)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (109, 66, 1, CAST(0x0000A64100B6FC84 AS DateTime), 1, 110)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (110, 66, 5, CAST(0x0000A64100B6FC94 AS DateTime), 1, 111)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (111, 67, 2, CAST(0x0000A64100B7FF1D AS DateTime), 1, 112)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (112, 67, 5, CAST(0x0000A64100B7FF29 AS DateTime), 1, 113)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (113, 68, 2, CAST(0x0000A64100B8B8A2 AS DateTime), 1, 114)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (114, 68, 4, CAST(0x0000A64100B8B8AC AS DateTime), 1, 115)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (115, 69, 2, CAST(0x0000A64100BB77C2 AS DateTime), 1, 116)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (116, 70, 2, CAST(0x0000A64100C3B769 AS DateTime), 1, 117)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (117, 70, 3, CAST(0x0000A64100C3B774 AS DateTime), 1, 118)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (118, 70, 4, CAST(0x0000A64100C3B783 AS DateTime), 1, 119)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (119, 71, 2, CAST(0x0000A64100C73973 AS DateTime), 1, 120)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (120, 71, 4, CAST(0x0000A64100C7397C AS DateTime), 1, 121)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (121, 72, 3, CAST(0x0000A64100D6200B AS DateTime), 1, 122)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (122, 72, 4, CAST(0x0000A64100D6200D AS DateTime), 1, 123)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (123, 73, 4, CAST(0x0000A64100D67645 AS DateTime), 1, 124)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (124, 74, 2, CAST(0x0000A64200DCB26B AS DateTime), 1, 125)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (125, 74, 4, CAST(0x0000A64200DCB2A5 AS DateTime), 1, 126)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (126, 75, 3, CAST(0x0000A642010D97D1 AS DateTime), 1, 127)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (127, 76, 2, CAST(0x0000A6420113DECA AS DateTime), 1, 128)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (128, 77, 3, CAST(0x0000A64201164764 AS DateTime), 1, 129)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (129, 78, 4, CAST(0x0000A64201168075 AS DateTime), 1, 130)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (130, 79, 3, CAST(0x0000A64201290CB8 AS DateTime), 1, 131)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (131, 79, 5, CAST(0x0000A64201290CC5 AS DateTime), 1, 132)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (132, 80, 2, CAST(0x0000A6420129D4B4 AS DateTime), 1, 133)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (133, 80, 4, CAST(0x0000A6420129D4C1 AS DateTime), 1, 134)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (134, 81, 2, CAST(0x0000A642012A5DCA AS DateTime), 1, 135)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (135, 81, 4, CAST(0x0000A642012A5DD8 AS DateTime), 1, 136)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (136, 82, 3, CAST(0x0000A642012AD3A6 AS DateTime), 1, 137)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (137, 83, 2, CAST(0x0000A642012BD802 AS DateTime), 1, 138)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (138, 83, 4, CAST(0x0000A642012BD80F AS DateTime), 1, 139)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (139, 88, 3, CAST(0x0000A64300C4FCF5 AS DateTime), 1, 140)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (140, 88, 5, CAST(0x0000A64300C50D88 AS DateTime), 1, 141)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (141, 89, 2, CAST(0x0000A64300C576CF AS DateTime), 1, 142)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (142, 89, 4, CAST(0x0000A64300C576DF AS DateTime), 1, 143)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (143, 90, 2, CAST(0x0000A64300C5F188 AS DateTime), 1, 144)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (144, 90, 4, CAST(0x0000A64300C5F197 AS DateTime), 1, 145)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (145, 91, 3, CAST(0x0000A64300C6565B AS DateTime), 1, 146)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (146, 91, 4, CAST(0x0000A64300C65669 AS DateTime), 1, 147)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (147, 92, 2, CAST(0x0000A64300C69D48 AS DateTime), 1, 148)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (148, 92, 5, CAST(0x0000A64300C69D57 AS DateTime), 1, 149)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (149, 93, 2, CAST(0x0000A64300C71B2B AS DateTime), 1, 150)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (150, 93, 4, CAST(0x0000A64300C71B3A AS DateTime), 1, 151)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (151, 94, 2, CAST(0x0000A64300C8226F AS DateTime), 1, 152)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (152, 94, 5, CAST(0x0000A64300C8227C AS DateTime), 1, 153)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (153, 95, 2, CAST(0x0000A64300C9BCCF AS DateTime), 1, 154)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (154, 95, 4, CAST(0x0000A64300C9BCDE AS DateTime), 1, 155)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (155, 96, 2, CAST(0x0000A64300CA26B6 AS DateTime), 1, 156)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (156, 96, 4, CAST(0x0000A64300CA26C3 AS DateTime), 1, 157)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (157, 97, 2, CAST(0x0000A64300CA450E AS DateTime), 1, 158)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (158, 97, 3, CAST(0x0000A64300CA451C AS DateTime), 1, 159)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (159, 98, 2, CAST(0x0000A64300CA82BC AS DateTime), 1, 160)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (160, 98, 3, CAST(0x0000A64300CA82C9 AS DateTime), 1, 161)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (161, 99, 2, CAST(0x0000A64300CAFB2B AS DateTime), 1, 162)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (162, 99, 5, CAST(0x0000A64300CAFB3A AS DateTime), 1, 163)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (163, 100, 2, CAST(0x0000A64300CC760D AS DateTime), 1, 164)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (164, 100, 3, CAST(0x0000A64300CC761C AS DateTime), 1, 165)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (165, 101, 2, CAST(0x0000A64300CD41DF AS DateTime), 1, 166)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (166, 101, 3, CAST(0x0000A64300CD41F5 AS DateTime), 1, 167)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (167, 102, 2, CAST(0x0000A64300CDCD33 AS DateTime), 1, 168)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (168, 103, 2, CAST(0x0000A64300CEBEBD AS DateTime), 1, 169)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (169, 103, 5, CAST(0x0000A64300CEBECA AS DateTime), 1, 170)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (170, 104, 2, CAST(0x0000A64300CF339A AS DateTime), 1, 171)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (171, 104, 3, CAST(0x0000A64300CF33A8 AS DateTime), 1, 172)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (172, 105, 2, CAST(0x0000A64300CF5E17 AS DateTime), 1, 173)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (173, 105, 3, CAST(0x0000A64300CF5E25 AS DateTime), 1, 174)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (174, 106, 1, CAST(0x0000A64300D0F410 AS DateTime), 1, 175)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (175, 106, 4, CAST(0x0000A64300D0F421 AS DateTime), 1, 176)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (176, 107, 3, CAST(0x0000A64300D17938 AS DateTime), 1, 177)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (177, 107, 4, CAST(0x0000A64300D17946 AS DateTime), 1, 178)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (178, 108, 3, CAST(0x0000A64300D1CBDE AS DateTime), 1, 179)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (179, 108, 6, CAST(0x0000A64300D1CBEC AS DateTime), 1, 180)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (180, 109, 4, CAST(0x0000A64300D21DEB AS DateTime), 1, 181)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (181, 109, 5, CAST(0x0000A64300D21DF9 AS DateTime), 1, 182)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (182, 110, 3, CAST(0x0000A64300D2EAE9 AS DateTime), 1, 183)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (183, 110, 5, CAST(0x0000A64300D2EAF8 AS DateTime), 1, 184)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (184, 111, 1, CAST(0x0000A64300D3E184 AS DateTime), 1, 185)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (185, 111, 3, CAST(0x0000A64300D3E196 AS DateTime), 1, 186)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (186, 112, 2, CAST(0x0000A64300D432F3 AS DateTime), 1, 187)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (187, 113, 3, CAST(0x0000A64300D47B7E AS DateTime), 1, 188)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (188, 113, 4, CAST(0x0000A64300D47B8D AS DateTime), 1, 189)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (189, 114, 2, CAST(0x0000A64300D4D745 AS DateTime), 1, 190)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (190, 115, 3, CAST(0x0000A64300D55E3B AS DateTime), 1, 191)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (191, 115, 4, CAST(0x0000A64300D55E50 AS DateTime), 1, 192)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (192, 116, 2, CAST(0x0000A64300D5E551 AS DateTime), 1, 193)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (193, 116, 4, CAST(0x0000A64300D5E55F AS DateTime), 1, 194)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (194, 117, 3, CAST(0x0000A64300D68F9A AS DateTime), 1, 195)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (195, 118, 2, CAST(0x0000A64300D6EA46 AS DateTime), 1, 196)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (196, 118, 4, CAST(0x0000A64300D6EA54 AS DateTime), 1, 197)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (197, 119, 2, CAST(0x0000A64300D7293B AS DateTime), 1, 198)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (198, 119, 4, CAST(0x0000A64300D72949 AS DateTime), 1, 199)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (199, 120, 3, CAST(0x0000A64300DBDB81 AS DateTime), 1, 200)
GO
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (200, 120, 4, CAST(0x0000A64300DBDB8F AS DateTime), 1, 201)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (201, 121, 2, CAST(0x0000A64300DFAF68 AS DateTime), 1, 202)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (202, 122, 3, CAST(0x0000A64300E406BB AS DateTime), 1, 203)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (203, 122, 5, CAST(0x0000A64300E406C9 AS DateTime), 1, 204)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (204, 123, 3, CAST(0x0000A64300E69620 AS DateTime), 1, 205)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (205, 123, 4, CAST(0x0000A64300E6962E AS DateTime), 1, 206)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (206, 124, 2, CAST(0x0000A64300E81A4E AS DateTime), 1, 207)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (207, 124, 3, CAST(0x0000A64300E81A5D AS DateTime), 1, 208)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (208, 125, 3, CAST(0x0000A64300E83BB8 AS DateTime), 1, 209)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (209, 125, 4, CAST(0x0000A64300E83BC5 AS DateTime), 1, 210)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (210, 126, 3, CAST(0x0000A64300E96141 AS DateTime), 1, 211)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (211, 126, 5, CAST(0x0000A64300E96151 AS DateTime), 1, 212)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (212, 127, 3, CAST(0x0000A64300E9DEAA AS DateTime), 1, 213)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (213, 127, 5, CAST(0x0000A64300E9DEB8 AS DateTime), 1, 214)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (214, 128, 4, CAST(0x0000A64300EA3C5F AS DateTime), 1, 215)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (215, 129, 3, CAST(0x0000A64300EEB92A AS DateTime), 1, 216)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (216, 130, 3, CAST(0x0000A64300EF3CAB AS DateTime), 1, 217)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (217, 131, 3, CAST(0x0000A64300EF76B6 AS DateTime), 1, 218)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (218, 131, 5, CAST(0x0000A64300EF76C4 AS DateTime), 1, 219)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (219, 132, 2, CAST(0x0000A64300EFBB8C AS DateTime), 1, 220)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (220, 132, 3, CAST(0x0000A64300EFBB9A AS DateTime), 1, 221)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (221, 133, 2, CAST(0x0000A64300F06F4C AS DateTime), 1, 222)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (222, 134, 3, CAST(0x0000A64300F2D827 AS DateTime), 1, 223)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (223, 134, 4, CAST(0x0000A64300F2D82A AS DateTime), 1, 224)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (224, 135, 2, CAST(0x0000A64300F355AB AS DateTime), 1, 225)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (225, 135, 3, CAST(0x0000A64300F355BF AS DateTime), 1, 226)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (226, 136, 2, CAST(0x0000A64300F4DA5B AS DateTime), 1, 227)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (227, 137, 3, CAST(0x0000A64300F7F3E9 AS DateTime), 1, 228)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (228, 138, 2, CAST(0x0000A643010EEAC7 AS DateTime), 1, 229)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (229, 139, 3, CAST(0x0000A643010F7C46 AS DateTime), 1, 230)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (230, 140, 1, CAST(0x0000A643010F976C AS DateTime), 1, 231)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (231, 141, 3, CAST(0x0000A643010FD930 AS DateTime), 1, 232)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (232, 142, 3, CAST(0x0000A643011008DE AS DateTime), 1, 233)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (233, 143, 3, CAST(0x0000A6430110204F AS DateTime), 1, 234)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (234, 144, 3, CAST(0x0000A64600B2AF2E AS DateTime), 1, 235)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (235, 144, 4, CAST(0x0000A64600B2AF3C AS DateTime), 1, 236)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (236, 144, 6, CAST(0x0000A64600B2AF47 AS DateTime), 1, 237)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (237, 145, 3, CAST(0x0000A64600B75D2D AS DateTime), 1, 238)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (238, 145, 4, CAST(0x0000A64600B75D3A AS DateTime), 1, 239)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (239, 146, 2, CAST(0x0000A64600B78E0D AS DateTime), 1, 240)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (240, 146, 4, CAST(0x0000A64600B78E19 AS DateTime), 1, 241)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (241, 147, 2, CAST(0x0000A6460103BC9B AS DateTime), 1, 242)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (242, 147, 5, CAST(0x0000A6460103BCA7 AS DateTime), 1, 243)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (243, 148, 1, CAST(0x0000A64601216728 AS DateTime), 1, 244)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (244, 148, 6, CAST(0x0000A64601216736 AS DateTime), 1, 245)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (245, 149, 2, CAST(0x0000A64601299F53 AS DateTime), 1, 246)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (246, 150, 1, CAST(0x0000A646012AD091 AS DateTime), 1, 247)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (247, 151, 3, CAST(0x0000A646012B4539 AS DateTime), 1, 248)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (248, 151, 5, CAST(0x0000A646012B4546 AS DateTime), 1, 249)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (249, 152, 2, CAST(0x0000A646012BCAEC AS DateTime), 1, 250)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (250, 153, 1, CAST(0x0000A646012C790E AS DateTime), 1, 251)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (251, 154, 2, CAST(0x0000A646012CFA09 AS DateTime), 1, 252)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (252, 155, 2, CAST(0x0000A6460131946A AS DateTime), 1, 253)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (253, 156, 2, CAST(0x0000A6460131CE25 AS DateTime), 1, 254)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (254, 157, 2, CAST(0x0000A64601321B01 AS DateTime), 1, 255)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (255, 158, 2, CAST(0x0000A6460132B5E5 AS DateTime), 1, 256)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (256, 159, 2, CAST(0x0000A6460132DD90 AS DateTime), 1, 257)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (257, 160, 3, CAST(0x0000A64601336030 AS DateTime), 1, 258)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (258, 161, 3, CAST(0x0000A6460133FF68 AS DateTime), 1, 259)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (259, 162, 2, CAST(0x0000A6460134428A AS DateTime), 1, 260)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (260, 163, 2, CAST(0x0000A646013503D0 AS DateTime), 1, 261)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (261, 164, 3, CAST(0x0000A646013570AD AS DateTime), 1, 262)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (262, 165, 3, CAST(0x0000A6460135A657 AS DateTime), 1, 263)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (263, 166, 3, CAST(0x0000A64700995363 AS DateTime), 1, 264)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (264, 166, 4, CAST(0x0000A64700995372 AS DateTime), 1, 265)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (265, 167, 2, CAST(0x0000A647009A5B89 AS DateTime), 1, 266)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (266, 167, 5, CAST(0x0000A647009A5B97 AS DateTime), 1, 267)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (267, 168, 3, CAST(0x0000A64700A034AB AS DateTime), 1, 268)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (268, 169, 2, CAST(0x0000A64700A2019B AS DateTime), 1, 269)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (269, 170, 3, CAST(0x0000A64700A2EC63 AS DateTime), 1, 270)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (270, 171, 4, CAST(0x0000A64700A33A64 AS DateTime), 1, 271)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (271, 172, 3, CAST(0x0000A64700A50150 AS DateTime), 1, 272)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (272, 173, 2, CAST(0x0000A64700A61929 AS DateTime), 1, 273)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (273, 174, 3, CAST(0x0000A64700A68411 AS DateTime), 1, 274)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (274, 175, 2, CAST(0x0000A64700A890FE AS DateTime), 1, 275)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (275, 176, 2, CAST(0x0000A64700B27222 AS DateTime), 1, 276)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (276, 177, 2, CAST(0x0000A64700B5B2AB AS DateTime), 1, 277)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (277, 178, 3, CAST(0x0000A64700B5E6F3 AS DateTime), 1, 278)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (278, 179, 3, CAST(0x0000A64700B715A5 AS DateTime), 1, 279)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (279, 180, 2, CAST(0x0000A64700BE581D AS DateTime), 1, 280)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (280, 180, 4, CAST(0x0000A64700BE582A AS DateTime), 1, 281)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (281, 181, 3, CAST(0x0000A64700BEA906 AS DateTime), 1, 282)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (282, 182, 3, CAST(0x0000A64A00E48F01 AS DateTime), 1, 283)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (283, 182, 6, CAST(0x0000A64A00E48F10 AS DateTime), 1, 284)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (284, 183, 2, CAST(0x0000A64A00F9E13B AS DateTime), 1, 285)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (285, 183, 3, CAST(0x0000A64A00F9E14D AS DateTime), 1, 286)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (286, 184, 2, CAST(0x0000A64A00FA31C3 AS DateTime), 1, 287)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (287, 184, 4, CAST(0x0000A64A00FA31D0 AS DateTime), 1, 288)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (288, 185, 3, CAST(0x0000A64A00FD3ACA AS DateTime), 1, 289)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (289, 185, 4, CAST(0x0000A64A00FD3AD8 AS DateTime), 1, 290)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (1234, 1182, 3, CAST(0x0000A64A010EB815 AS DateTime), 1, 291)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (1235, 1183, 2, CAST(0x0000A64A0112DF98 AS DateTime), 1, 292)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (1236, 1183, 4, CAST(0x0000A64A0112DFA5 AS DateTime), 1, 293)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (1237, 1183, 5, CAST(0x0000A64A0112DFB1 AS DateTime), 1, 294)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (1238, 1184, 2, CAST(0x0000A64A01153F1C AS DateTime), 1, 295)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (1239, 1184, 3, CAST(0x0000A64A01153F2A AS DateTime), 1, 296)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (1240, 1184, 4, CAST(0x0000A64A01153F3A AS DateTime), 1, 297)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (1241, 1185, 2, CAST(0x0000A64A01168DC9 AS DateTime), 1, 298)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (1242, 1185, 4, CAST(0x0000A64A01168DD6 AS DateTime), 1, 299)
INSERT [dbo].[PatientRequestAnalysis] ([RequestedAnalysisID], [RequestID], [AnalysisID], [RequestDate], [EmployeeID], [RunNumber]) VALUES (1243, 1186, 2, CAST(0x0000A64A011831BF AS DateTime), 1, 300)
GO
SET IDENTITY_INSERT [dbo].[PatientRequestAnalysis] OFF
SET IDENTITY_INSERT [dbo].[PatientRequestAnalysisStatus] ON 

INSERT [dbo].[PatientRequestAnalysisStatus] ([RequestAnalysisStatusID], [RequestedAnalysisID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (19, 1, 1, CAST(0x0000A62A00A49203 AS DateTime), 2, N'Patient requested analyzes is pending for sampling by Ahmed ')
INSERT [dbo].[PatientRequestAnalysisStatus] ([RequestAnalysisStatusID], [RequestedAnalysisID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (20, 2, 1, CAST(0x0000A62A00A49203 AS DateTime), 2, N'Patient requested analyzes is pending for sampling by Ahmed ')
INSERT [dbo].[PatientRequestAnalysisStatus] ([RequestAnalysisStatusID], [RequestedAnalysisID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (21, 3, 1, CAST(0x0000A62A00A49203 AS DateTime), 2, N'Patient requested analyzes is pending for sampling by Ahmed ')
INSERT [dbo].[PatientRequestAnalysisStatus] ([RequestAnalysisStatusID], [RequestedAnalysisID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (22, 4, 1, CAST(0x0000A62A00A49203 AS DateTime), 2, N'Patient requested analyzes is pending for sampling by Ahmed ')
INSERT [dbo].[PatientRequestAnalysisStatus] ([RequestAnalysisStatusID], [RequestedAnalysisID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (23, 1, 2, CAST(0x0000A62A00A4A0A7 AS DateTime), 2, N'Requested analysis is sampled by Ahmed ')
INSERT [dbo].[PatientRequestAnalysisStatus] ([RequestAnalysisStatusID], [RequestedAnalysisID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (24, 2, 2, CAST(0x0000A62A00A4A0C0 AS DateTime), 2, N'Requested analysis is sampled by Ahmed ')
SET IDENTITY_INSERT [dbo].[PatientRequestAnalysisStatus] OFF
SET IDENTITY_INSERT [dbo].[PatientRequestPayment] ON 

INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (0, 3, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000C62F75 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (1, 6, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000D48C34 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (2, 7, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000DBF185 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (3, 8, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000DF9B6B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (4, 9, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000E07431 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (5, 10, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000E1D79C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (6, 11, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000E230E3 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (7, 12, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000E2A3A9 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (8, 13, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000E9B48D AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (9, 14, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000EAA5BC AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (10, 15, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000ECFC3B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (11, 16, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000EFE69B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (12, 17, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000F16622 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (13, 18, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000F3E105 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (14, 19, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000FD413C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (15, 20, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000FE05A9 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (16, 21, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64000FF8E74 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (17, 22, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6400100A16C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (18, 23, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64001067A2A AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (19, 24, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6400106DAB4 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (20, 25, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64001071C89 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (21, 26, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64001099CE6 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (22, 27, CAST(0 AS Decimal(18, 0)), CAST(0x0000A640010E7540 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (23, 28, CAST(0 AS Decimal(18, 0)), CAST(0x0000A640010F4630 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (24, 29, CAST(0 AS Decimal(18, 0)), CAST(0x0000A640010F5FE3 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (25, 30, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64001103D9E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (26, 31, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64001112372 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (27, 32, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64001133715 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (28, 33, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64001137D8F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (29, 34, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6400114120A AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (30, 35, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64001160DA6 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (31, 36, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6400116D513 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (32, 37, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64001174923 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (33, 38, CAST(0 AS Decimal(18, 0)), CAST(0x0000A640011817CA AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (34, 39, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6400119C782 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (35, 40, CAST(0 AS Decimal(18, 0)), CAST(0x0000A640011A81E0 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (36, 41, CAST(0 AS Decimal(18, 0)), CAST(0x0000A640011B7359 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (37, 42, CAST(0 AS Decimal(18, 0)), CAST(0x0000A640011BBD2C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (38, 43, CAST(0 AS Decimal(18, 0)), CAST(0x0000A640011C2DED AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (39, 44, CAST(0 AS Decimal(18, 0)), CAST(0x0000A640011FB9C7 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (40, 46, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64001201B22 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (41, 47, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64001221910 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (42, 48, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64001226CF4 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (43, 49, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100A25025 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (44, 50, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100A2D58E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (45, 51, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100A59F7B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (46, 52, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100A84512 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (47, 54, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100AA920F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (48, 55, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100AC290F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (49, 56, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100AD31C6 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (50, 57, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100AE075C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (51, 58, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100AEBA85 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (52, 59, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100AF851E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (53, 60, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100AFF937 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (54, 61, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100B1B636 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (55, 62, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100B25AC4 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (56, 63, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100B2FD35 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (57, 64, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100B3D20A AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (58, 65, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100B588BB AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (59, 66, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100B6FC99 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (60, 67, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100B7FF2E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (61, 68, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100B8B8B1 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (62, 69, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100BB77CC AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (63, 70, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100C3B787 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (64, 71, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100C73986 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (65, 72, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100D6200E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (66, 73, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64100D67646 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (67, 74, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64200DCB2AD AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (68, 75, CAST(0 AS Decimal(18, 0)), CAST(0x0000A642010D97DA AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (69, 76, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6420113DED2 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (70, 77, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6420116476D AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (71, 78, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6420116807C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (72, 79, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64201290CCB AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (73, 80, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6420129D4C7 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (74, 81, CAST(0 AS Decimal(18, 0)), CAST(0x0000A642012A5DDF AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (75, 82, CAST(0 AS Decimal(18, 0)), CAST(0x0000A642012AD3AD AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (76, 83, CAST(0 AS Decimal(18, 0)), CAST(0x0000A642012BD816 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (77, 88, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300C50D91 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (78, 89, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300C576E7 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (79, 90, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300C5F19F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (80, 91, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300C6566F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (81, 92, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300C69D66 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (82, 93, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300C71B42 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (83, 94, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300C82282 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (84, 95, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300C9BCE5 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (85, 96, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300CA26CA AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (86, 97, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300CA4523 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (87, 98, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300CA82D0 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (88, 99, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300CAFB41 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (89, 100, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300CC7623 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (90, 101, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300CD41FD AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (91, 102, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300CDCD3B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (92, 103, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300CEBED1 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (93, 104, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300CF33B0 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (94, 105, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300CF5E2C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (95, 106, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300D0F42A AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (96, 107, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300D1794E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (97, 108, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300D1CBF4 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (98, 109, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300D21E00 AS DateTime), 1, NULL)
GO
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (99, 110, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300D2EAFF AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (100, 111, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300D3E19E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (101, 112, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300D432FA AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (102, 113, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300D47B94 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (103, 114, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300D4D74C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (104, 115, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300D55E59 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (105, 116, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300D5E566 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (106, 117, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300D68FA2 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (107, 118, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300D6EA5C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (108, 119, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300D72950 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (109, 120, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300DBDB96 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (110, 121, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300DFAF71 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (111, 122, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300E406D0 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (112, 123, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300E69635 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (113, 124, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300E81A65 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (114, 125, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300E83BCD AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (115, 126, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300E96158 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (116, 127, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300E9DEBF AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (117, 128, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300EA3C67 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (118, 129, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300EEB936 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (119, 130, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300EF3CB3 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (120, 131, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300EF76CB AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (121, 132, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300EFBBA1 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (122, 133, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300F06F54 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (123, 134, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300F2D82A AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (124, 135, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300F355C0 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (125, 136, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300F4DA5C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (126, 137, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64300F7F3EB AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (127, 138, CAST(0 AS Decimal(18, 0)), CAST(0x0000A643010EEACF AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (128, 139, CAST(0 AS Decimal(18, 0)), CAST(0x0000A643010F7C4F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (129, 140, CAST(0 AS Decimal(18, 0)), CAST(0x0000A643010F9773 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (130, 141, CAST(0 AS Decimal(18, 0)), CAST(0x0000A643010FD937 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (131, 142, CAST(0 AS Decimal(18, 0)), CAST(0x0000A643011008E5 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (132, 143, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64301102056 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (133, 144, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64600B2AF4C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (134, 145, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64600B75D41 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (135, 146, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64600B78E20 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (136, 147, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6460103BCAE AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (137, 148, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6460121673C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (138, 149, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64601299F5B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (139, 150, CAST(0 AS Decimal(18, 0)), CAST(0x0000A646012AD098 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (140, 151, CAST(0 AS Decimal(18, 0)), CAST(0x0000A646012B454C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (141, 152, CAST(0 AS Decimal(18, 0)), CAST(0x0000A646012BCAF3 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (142, 153, CAST(0 AS Decimal(18, 0)), CAST(0x0000A646012C7916 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (143, 154, CAST(0 AS Decimal(18, 0)), CAST(0x0000A646012CFA10 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (144, 155, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64601319471 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (145, 156, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6460131CE2E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (146, 157, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64601321B08 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (147, 158, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6460132B5ED AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (148, 159, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6460132DD96 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (149, 160, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64601336037 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (150, 161, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6460133FF6F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (151, 162, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64601344293 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (152, 163, CAST(0 AS Decimal(18, 0)), CAST(0x0000A646013503D7 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (153, 164, CAST(0 AS Decimal(18, 0)), CAST(0x0000A646013570B4 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (154, 165, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6460135A65F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (155, 166, CAST(0 AS Decimal(18, 0)), CAST(0x0000A6470099537D AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (156, 167, CAST(0 AS Decimal(18, 0)), CAST(0x0000A647009A5B9E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (157, 168, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64700A034B5 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (158, 169, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64700A201A3 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (159, 170, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64700A2EC6A AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (160, 171, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64700A33A6C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (161, 172, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64700A50157 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (162, 173, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64700A61930 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (163, 174, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64700A68418 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (164, 175, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64700A8910E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (165, 176, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64700B2722A AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (166, 177, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64700B5B2B4 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (167, 178, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64700B5E6FA AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (168, 179, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64700B715AD AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (169, 180, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64700BE5831 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (170, 181, CAST(0 AS Decimal(18, 0)), CAST(0x0000A64700BEA90E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (171, 182, CAST(7 AS Decimal(18, 0)), CAST(0x0000A64A00E48F18 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (172, 183, CAST(30 AS Decimal(18, 0)), CAST(0x0000A64A00F9E154 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestPayment] ([PaymentID], [RequestID], [PaidAmount], [PaymentDate], [EmployeeID], [Comment]) VALUES (1171, 1183, CAST(30 AS Decimal(18, 0)), CAST(0x0000A64A0112DFB8 AS DateTime), 1, NULL)
SET IDENTITY_INSERT [dbo].[PatientRequestPayment] OFF
SET IDENTITY_INSERT [dbo].[PatientRequestStatus] ON 

INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1, 2, 3, CAST(0x0000A62700E7ACF7 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (5, 2, 4, CAST(0x0000A62A00A491F5 AS DateTime), 2, N'Patient request is received by Ahmed ')
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1002, 3, 3, CAST(0x0000A64000C60870 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1003, 4, 3, CAST(0x0000A64000D034E4 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1004, 5, 3, CAST(0x0000A64000D32F68 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1005, 6, 3, CAST(0x0000A64000D48BFE AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1006, 7, 3, CAST(0x0000A64000DBF14E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1007, 8, 3, CAST(0x0000A64000DF9B34 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1008, 9, 3, CAST(0x0000A64000E073F5 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1009, 10, 3, CAST(0x0000A64000E1D76E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1010, 11, 3, CAST(0x0000A64000E230B5 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1011, 12, 3, CAST(0x0000A64000E2A37B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1012, 13, 3, CAST(0x0000A64000E9B45F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1013, 14, 3, CAST(0x0000A64000EAA58C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1014, 15, 3, CAST(0x0000A64000ECFBFF AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1015, 16, 3, CAST(0x0000A64000EFE679 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1016, 17, 3, CAST(0x0000A64000F165FF AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1017, 18, 3, CAST(0x0000A64000F3E0D3 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1018, 19, 3, CAST(0x0000A64000FD4101 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1019, 20, 3, CAST(0x0000A64000FE0593 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1020, 21, 3, CAST(0x0000A64000FF8E46 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1021, 22, 3, CAST(0x0000A6400100A13C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1022, 23, 3, CAST(0x0000A640010679F9 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1023, 24, 3, CAST(0x0000A6400106DA9F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1024, 25, 3, CAST(0x0000A64001071C74 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1025, 26, 3, CAST(0x0000A64001099CC4 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1026, 27, 3, CAST(0x0000A640010E750A AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1027, 28, 3, CAST(0x0000A640010F460E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1028, 29, 3, CAST(0x0000A640010F5FCB AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1029, 30, 3, CAST(0x0000A64001103D79 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1030, 31, 3, CAST(0x0000A64001112352 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1031, 32, 3, CAST(0x0000A640011336F4 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1032, 33, 3, CAST(0x0000A64001137D63 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1033, 34, 3, CAST(0x0000A640011411DE AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1034, 35, 3, CAST(0x0000A64001160D87 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1035, 36, 3, CAST(0x0000A6400116D4F0 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1036, 37, 3, CAST(0x0000A64001174900 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1037, 38, 3, CAST(0x0000A640011817AA AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1038, 39, 3, CAST(0x0000A6400119C762 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1039, 40, 3, CAST(0x0000A640011A81BA AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1040, 41, 3, CAST(0x0000A640011B7335 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1041, 42, 3, CAST(0x0000A640011BBD0B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1042, 43, 3, CAST(0x0000A640011C2DCB AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1043, 44, 3, CAST(0x0000A640011FB9B2 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1044, 45, 3, CAST(0x0000A640011FFEC1 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1045, 46, 3, CAST(0x0000A64001201B0F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1046, 47, 3, CAST(0x0000A640012218F0 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1047, 48, 3, CAST(0x0000A64001226CD4 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1048, 49, 3, CAST(0x0000A64100A24FEB AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1049, 50, 3, CAST(0x0000A64100A2D56B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1050, 51, 3, CAST(0x0000A64100A59F53 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1051, 52, 3, CAST(0x0000A64100A844E7 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1052, 53, 3, CAST(0x0000A64100A8A59B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1053, 54, 3, CAST(0x0000A64100AA91D7 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1054, 55, 3, CAST(0x0000A64100AC28DD AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1055, 56, 3, CAST(0x0000A64100AD3198 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1056, 57, 3, CAST(0x0000A64100AE0732 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1057, 58, 3, CAST(0x0000A64100AEBA52 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1058, 59, 3, CAST(0x0000A64100AF84EE AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1059, 60, 3, CAST(0x0000A64100AFF909 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1060, 61, 3, CAST(0x0000A64100B1B609 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1061, 62, 3, CAST(0x0000A64100B25A8D AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1062, 63, 3, CAST(0x0000A64100B2FD04 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1063, 64, 3, CAST(0x0000A64100B3D1D1 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1064, 65, 3, CAST(0x0000A64100B5888F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1065, 66, 3, CAST(0x0000A64100B6FC6B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1066, 67, 3, CAST(0x0000A64100B7FF05 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1067, 68, 3, CAST(0x0000A64100B8B884 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1068, 69, 3, CAST(0x0000A64100BB77A9 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1069, 70, 3, CAST(0x0000A64100C3B750 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1070, 71, 3, CAST(0x0000A64100C7395A AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1071, 72, 3, CAST(0x0000A64100D61FFA AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1072, 73, 3, CAST(0x0000A64100D67643 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1073, 74, 3, CAST(0x0000A64200DCB24E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1074, 75, 3, CAST(0x0000A642010D97BA AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1075, 76, 3, CAST(0x0000A6420113DEB1 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1076, 77, 3, CAST(0x0000A64201164749 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1077, 78, 3, CAST(0x0000A64201168069 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1078, 79, 3, CAST(0x0000A64201290CA0 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1079, 80, 3, CAST(0x0000A6420129D4A7 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1080, 81, 3, CAST(0x0000A642012A5DB2 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1081, 82, 3, CAST(0x0000A642012AD398 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1082, 83, 3, CAST(0x0000A642012BD7F4 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1083, 84, 3, CAST(0x0000A64300C3496E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1084, 85, 3, CAST(0x0000A64300C3A208 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1085, 86, 3, CAST(0x0000A64300C43888 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1086, 87, 3, CAST(0x0000A64300C47DEE AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1087, 88, 3, CAST(0x0000A64300C4F6B6 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1088, 89, 3, CAST(0x0000A64300C572E8 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1089, 90, 3, CAST(0x0000A64300C5F175 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1090, 91, 3, CAST(0x0000A64300C6564C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1091, 92, 3, CAST(0x0000A64300C69D38 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1092, 93, 3, CAST(0x0000A64300C71B1C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1093, 94, 3, CAST(0x0000A64300C8225F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1094, 95, 3, CAST(0x0000A64300C9BCBD AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1095, 96, 3, CAST(0x0000A64300CA26A7 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1096, 97, 3, CAST(0x0000A64300CA4501 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1097, 98, 3, CAST(0x0000A64300CA82AE AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1098, 99, 3, CAST(0x0000A64300CAFB1A AS DateTime), 1, NULL)
GO
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1099, 100, 3, CAST(0x0000A64300CC75FB AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1100, 101, 3, CAST(0x0000A64300CD41C5 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1101, 102, 3, CAST(0x0000A64300CDCD24 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1102, 103, 3, CAST(0x0000A64300CEBEAF AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1103, 104, 3, CAST(0x0000A64300CF3388 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1104, 105, 3, CAST(0x0000A64300CF5E08 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1105, 106, 3, CAST(0x0000A64300D0F3FB AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1106, 107, 3, CAST(0x0000A64300D1792A AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1107, 108, 3, CAST(0x0000A64300D1CBD1 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1108, 109, 3, CAST(0x0000A64300D21DDB AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1109, 110, 3, CAST(0x0000A64300D2EADA AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1110, 111, 3, CAST(0x0000A64300D3E173 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1111, 112, 3, CAST(0x0000A64300D432E6 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1112, 113, 3, CAST(0x0000A64300D47B6E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1113, 114, 3, CAST(0x0000A64300D4D737 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1114, 115, 3, CAST(0x0000A64300D55E29 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1115, 116, 3, CAST(0x0000A64300D5E540 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1116, 117, 3, CAST(0x0000A64300D68F88 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1117, 118, 3, CAST(0x0000A64300D6EA34 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1118, 119, 3, CAST(0x0000A64300D7292D AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1119, 120, 3, CAST(0x0000A64300DBDB71 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1120, 121, 3, CAST(0x0000A64300DFAF54 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1121, 122, 3, CAST(0x0000A64300E406A9 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1122, 123, 3, CAST(0x0000A64300E6960F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1123, 124, 3, CAST(0x0000A64300E81A3E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1124, 125, 3, CAST(0x0000A64300E83BA0 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1125, 126, 3, CAST(0x0000A64300E9612C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1126, 127, 3, CAST(0x0000A64300E9DE9C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1127, 128, 3, CAST(0x0000A64300EA3C52 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1128, 129, 3, CAST(0x0000A64300EEB91A AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1129, 130, 3, CAST(0x0000A64300EF3C9B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1130, 131, 3, CAST(0x0000A64300EF76A8 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1131, 132, 3, CAST(0x0000A64300EFBB71 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1132, 133, 3, CAST(0x0000A64300F06F20 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1133, 134, 3, CAST(0x0000A64300F2D823 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1134, 135, 3, CAST(0x0000A64300F35594 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1135, 136, 3, CAST(0x0000A64300F4DA53 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1136, 137, 3, CAST(0x0000A64300F7F3E8 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1137, 138, 3, CAST(0x0000A643010EEAB7 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1138, 139, 3, CAST(0x0000A643010F7C37 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1139, 140, 3, CAST(0x0000A643010F9760 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1140, 141, 3, CAST(0x0000A643010FD923 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1141, 142, 3, CAST(0x0000A643011008D2 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1142, 143, 3, CAST(0x0000A64301102043 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1143, 144, 3, CAST(0x0000A64600B2AF19 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1144, 145, 3, CAST(0x0000A64600B75D1F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1145, 146, 3, CAST(0x0000A64600B78E01 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1146, 147, 3, CAST(0x0000A6460103BC8A AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1147, 148, 3, CAST(0x0000A64601216718 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1148, 149, 3, CAST(0x0000A64601299F42 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1149, 150, 3, CAST(0x0000A646012AD082 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1150, 151, 3, CAST(0x0000A646012B452B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1151, 152, 3, CAST(0x0000A646012BCADF AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1152, 153, 3, CAST(0x0000A646012C7901 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1153, 154, 3, CAST(0x0000A646012CF9FB AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1154, 155, 3, CAST(0x0000A6460131945C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1155, 156, 3, CAST(0x0000A6460131CE17 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1156, 157, 3, CAST(0x0000A64601321AF2 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1157, 158, 3, CAST(0x0000A6460132B5D4 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1158, 159, 3, CAST(0x0000A6460132DD84 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1159, 160, 3, CAST(0x0000A64601336023 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1160, 161, 3, CAST(0x0000A6460133FF5B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1161, 162, 3, CAST(0x0000A6460134427C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1162, 163, 3, CAST(0x0000A646013503C3 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1163, 164, 3, CAST(0x0000A646013570A0 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1164, 165, 3, CAST(0x0000A6460135A649 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1165, 166, 3, CAST(0x0000A6470099534F AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1166, 167, 3, CAST(0x0000A647009A5B7E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1167, 168, 3, CAST(0x0000A64700A03499 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1168, 169, 3, CAST(0x0000A64700A2018B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1169, 170, 3, CAST(0x0000A64700A2EC56 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1170, 171, 3, CAST(0x0000A64700A33A56 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1171, 172, 3, CAST(0x0000A64700A50143 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1172, 173, 3, CAST(0x0000A64700A6191C AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1173, 174, 3, CAST(0x0000A64700A68404 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1174, 175, 3, CAST(0x0000A64700A890F1 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1175, 176, 3, CAST(0x0000A64700B27212 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1176, 177, 3, CAST(0x0000A64700B5B29B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1177, 178, 3, CAST(0x0000A64700B5E6E2 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1178, 179, 3, CAST(0x0000A64700B71593 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1179, 180, 3, CAST(0x0000A64700BE580E AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1180, 181, 3, CAST(0x0000A64700BEA8F9 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1181, 181, 4, CAST(0x0000A64700BEA8F9 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1182, 182, 3, CAST(0x0000A64A00E48EE9 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1183, 183, 3, CAST(0x0000A64A00F9E12B AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1184, 184, 3, CAST(0x0000A64A00FA31B4 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (1185, 185, 3, CAST(0x0000A64A00FD3AB9 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (2143, 1182, 3, CAST(0x0000A64A010EB801 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (2144, 1183, 3, CAST(0x0000A64A0112DF8A AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (2145, 1184, 3, CAST(0x0000A64A01153F0D AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (2146, 1185, 3, CAST(0x0000A64A01168DB9 AS DateTime), 1, NULL)
INSERT [dbo].[PatientRequestStatus] ([RequestStatusID], [RequestID], [StatusID], [StatusDate], [EmployeeID], [Comment]) VALUES (2147, 1186, 3, CAST(0x0000A64A011831AE AS DateTime), 1, NULL)
SET IDENTITY_INSERT [dbo].[PatientRequestStatus] OFF
INSERT [dbo].[Permission] ([EntityID], [ActionID], [RoleID], [InsertionDate]) VALUES (1, 1, 1, CAST(0x0000A638009E5354 AS DateTime))
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
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [RoleName], [RoleDescription], [InsertionDate]) VALUES (1, N'CS', N'Manage CS pages', CAST(0x0000A62A00ECB5D6 AS DateTime))
INSERT [dbo].[Role] ([RoleID], [RoleName], [RoleDescription], [InsertionDate]) VALUES (2, N'Chemist', N'Manage Sampling and preservation pages', CAST(0x0000A62A00ECD4CF AS DateTime))
INSERT [dbo].[Role] ([RoleID], [RoleName], [RoleDescription], [InsertionDate]) VALUES (3, N'DoctorAnalytic', N'Manage analyzes pages', CAST(0x0000A62A00ED341A AS DateTime))
INSERT [dbo].[Role] ([RoleID], [RoleName], [RoleDescription], [InsertionDate]) VALUES (4, N'DoctorApply', N'Manage analyzes results pagae', CAST(0x0000A62A00ED51A1 AS DateTime))
SET IDENTITY_INSERT [dbo].[Role] OFF
INSERT [dbo].[RunNumber] ([RunNum]) VALUES (301)
SET IDENTITY_INSERT [dbo].[SampleType] ON 

INSERT [dbo].[SampleType] ([SampleTypeID], [SampleType]) VALUES (1, N'Blood               ')
INSERT [dbo].[SampleType] ([SampleTypeID], [SampleType]) VALUES (2, N'Urine               ')
INSERT [dbo].[SampleType] ([SampleTypeID], [SampleType]) VALUES (3, N'f                   ')
INSERT [dbo].[SampleType] ([SampleTypeID], [SampleType]) VALUES (4, N'c                   ')
SET IDENTITY_INSERT [dbo].[SampleType] OFF
SET IDENTITY_INSERT [dbo].[Status] ON 

INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (1, N'AnalysisPendingForSampling', N'Analysis Pending For Sampling', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (2, N'AnalysisSampled', N'Analysis Sampled', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (3, N'PatientRequestPending', N'Patient Request Pending', NULL)
INSERT [dbo].[Status] ([StatusID], [StatusIdentifier], [StatusName], [Description]) VALUES (4, N'PatientRequestReceivedForSampling', N'Patient Request Received For Sampling', NULL)
SET IDENTITY_INSERT [dbo].[Status] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [EmployeeID], [UserName], [UserPassword], [LastLoginDate], [IsAdmin], [RoleID]) VALUES (1, 1, N'admin', N'123', CAST(0x0000A62A00D26E07 AS DateTime), 0, 1)
SET IDENTITY_INSERT [dbo].[User] OFF
/****** Object:  Index [IX_Analysis_SampleTypeID]    Script Date: 7/21/2016 6:00:18 PM ******/
CREATE NONCLUSTERED INDEX [IX_Analysis_SampleTypeID] ON [dbo].[Analysis]
(
	[SampleTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DoctorRef] ADD  CONSTRAINT [DF_DoctorRef_InsertionDate]  DEFAULT (getdate()) FOR [InsertionDate]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_JobDate]  DEFAULT (getdate()) FOR [JobDate]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_CityID]  DEFAULT (NULL) FOR [CityID]
GO
ALTER TABLE [dbo].[LabBranch] ADD  CONSTRAINT [DF_LabBranch_EstablishedDate]  DEFAULT (getdate()) FOR [EstablishedDate]
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
ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [DF_Role_InsertionDate]  DEFAULT (getdate()) FOR [InsertionDate]
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
ALTER TABLE [dbo].[AnalysisResult]  WITH CHECK ADD  CONSTRAINT [FK_AnalysisResult_ExaminedEmployee] FOREIGN KEY([ExamineByEmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[AnalysisResult] CHECK CONSTRAINT [FK_AnalysisResult_ExaminedEmployee]
GO
ALTER TABLE [dbo].[AnalysisResultStatus]  WITH CHECK ADD  CONSTRAINT [FK_AnalysisResultStatus_AnalysisResult] FOREIGN KEY([AnalysisResultID])
REFERENCES [dbo].[AnalysisResult] ([AnalysisResultID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AnalysisResultStatus] CHECK CONSTRAINT [FK_AnalysisResultStatus_AnalysisResult]
GO
ALTER TABLE [dbo].[AnalysisResultStatus]  WITH CHECK ADD  CONSTRAINT [FK_AnalysisResultStatus_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[AnalysisResultStatus] CHECK CONSTRAINT [FK_AnalysisResultStatus_Employee]
GO
ALTER TABLE [dbo].[AnalysisResultStatus]  WITH CHECK ADD  CONSTRAINT [FK_AnalysisResultStatus_Status] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Status] ([StatusID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AnalysisResultStatus] CHECK CONSTRAINT [FK_AnalysisResultStatus_Status]
GO
ALTER TABLE [dbo].[City]  WITH CHECK ADD  CONSTRAINT [FK_City_Province] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Province] ([ProvinceID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[City] CHECK CONSTRAINT [FK_City_Province]
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
         Begin Table = "Patient"
            Begin Extent = 
               Top = 6
               Left = 253
               Bottom = 254
               Right = 435
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PatientRequest"
            Begin Extent = 
               Top = 6
               Left = 473
               Bottom = 136
               Right = 727
            End
            DisplayFlags = 280
            TopColumn = 10
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest'
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
            TopColumn = 10
         End
         Begin Table = "PatientRequestStatus"
            Begin Extent = 
               Top = 6
               Left = 267
               Bottom = 136
               Right = 441
            End
            DisplayFlags = 280
            TopColumn = 0
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
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 37
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
 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Patient_PatientRequest_LastStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'        Width = 1500
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
            TopColumn = 3
         End
         Begin Table = "PatientRequestAnalysis"
            Begin Extent = 
               Top = 6
               Left = 267
               Bottom = 136
               Right = 465
            End
            DisplayFlags = 280
            TopColumn = 2
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientRequest_Analysis'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientRequest_Analysis'
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
            TopColumn = 3
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
USE [master]
GO
ALTER DATABASE [DemoMisrInt] SET  READ_WRITE 
GO
