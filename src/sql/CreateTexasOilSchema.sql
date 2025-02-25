USE [master];
GO

IF NOT EXISTS (
    SELECT name 
    FROM sys.databases 
    WHERE name = N'TexasOil'
)
BEGIN
    CREATE DATABASE [TexasOil];
END;
GO

USE [TexasOil];
GO

--------------------------------------------------------------------------------
-- Check existence and recreate GP_COUNTY
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.GP_COUNTY', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.GP_COUNTY;
END
GO

--------------------------------------------------------------------------------
-- Create Table: GP_COUNTY
--------------------------------------------------------------------------------
CREATE TABLE dbo.GP_COUNTY (
    COUNTY_NO              CHAR(3)     NOT NULL,
    COUNTY_FIPS_CODE       CHAR(3)     NULL,
    COUNTY_NAME            VARCHAR(50) NULL,
    DISTRICT_NO            CHAR(2)     NOT NULL,
    DISTRICT_NAME          CHAR(2)     NULL,
    ON_SHORE_FLAG          CHAR(1)     NULL,
    ONSHORE_ASSC_CNTY_FLAG CHAR(1)     NULL
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'General purpose table that stores county information.', 
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_COUNTY';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'3-digit county code, assigned by RRC/API.', 
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_COUNTY',
    @level2type = N'COLUMN', @level2name = N'COUNTY_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'FIPS county code (3 chars).', 
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_COUNTY',
    @level2type = N'COLUMN', @level2name = N'COUNTY_FIPS_CODE';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'County name (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_COUNTY',
    @level2type = N'COLUMN', @level2name = N'COUNTY_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'RRC district code (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_COUNTY',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'District name/identifier (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_COUNTY',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Flag indicating onshore (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_COUNTY',
    @level2type = N'COLUMN', @level2name = N'ON_SHORE_FLAG';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Flag indicating associated onshore county (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_COUNTY',
    @level2type = N'COLUMN', @level2name = N'ONSHORE_ASSC_CNTY_FLAG';
GO



--------------------------------------------------------------------------------
-- Check existence and recreate GP_DATE_RANGE_CYCLE
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.GP_DATE_RANGE_CYCLE', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.GP_DATE_RANGE_CYCLE;
END
GO

--------------------------------------------------------------------------------
-- Create Table: GP_DATE_RANGE_CYCLE
--------------------------------------------------------------------------------
CREATE TABLE dbo.GP_DATE_RANGE_CYCLE (
    OLDEST_PROD_CYCLE_YEAR_MONTH  VARCHAR(6) NOT NULL,
    NEWEST_PROD_CYCLE_YEAR_MONTH  VARCHAR(6) NOT NULL,
    NEWEST_SCHED_CYCLE_YEAR_MONTH VARCHAR(6) NOT NULL,
    GAS_EXTRACT_DATE              DATE       NULL,
    OIL_EXTRACT_DATE              DATE       NULL
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'General purpose table of PDQ data range (Jan. 1993 - current production report month/year).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_DATE_RANGE_CYCLE';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Oldest production cycle in YYYYMM format.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_DATE_RANGE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OLDEST_PROD_CYCLE_YEAR_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Newest production cycle in YYYYMM format.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_DATE_RANGE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'NEWEST_PROD_CYCLE_YEAR_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Newest proration schedule cycle in YYYYMM format.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_DATE_RANGE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'NEWEST_SCHED_CYCLE_YEAR_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Date on which gas data was extracted from the database.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_DATE_RANGE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'GAS_EXTRACT_DATE';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Date on which oil data was extracted from the database.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_DATE_RANGE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OIL_EXTRACT_DATE';
GO

--------------------------------------------------------------------------------
-- Check existence and recreate GP_DISTRICT
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.GP_DISTRICT', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.GP_DISTRICT;
END
GO

--------------------------------------------------------------------------------
-- Create Table: GP_DISTRICT
--------------------------------------------------------------------------------
CREATE TABLE dbo.GP_DISTRICT (
    DISTRICT_NO     CHAR(2)     NOT NULL,
    DISTRICT_NAME   CHAR(2)     NULL,
    OFFICE_PHONE_NO VARCHAR(10) NULL,
    OFFICE_LOCATION VARCHAR(50) NULL
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'General purpose table that contains district information.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_DISTRICT';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC district code (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_DISTRICT',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'District name short identifier (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_DISTRICT',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC office phone number (10 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_DISTRICT',
    @level2type = N'COLUMN', @level2name = N'OFFICE_PHONE_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC office location (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'GP_DISTRICT',
    @level2type = N'COLUMN', @level2name = N'OFFICE_LOCATION';
GO

--------------------------------------------------------------------------------
-- Check existence and recreate OG_COUNTY_CYCLE
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.OG_COUNTY_CYCLE', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.OG_COUNTY_CYCLE;
END
GO

--------------------------------------------------------------------------------
-- Create Table: OG_COUNTY_CYCLE
--   Contains monthly production data aggregated by the county.
--   Estimated, based on allowables and potentials.
--------------------------------------------------------------------------------
CREATE TABLE dbo.OG_COUNTY_CYCLE (
    COUNTY_NO             CHAR(3)     NOT NULL,  -- 3-digit county code
    DISTRICT_NO           CHAR(2)     NOT NULL,  -- RRC district code
    CYCLE_YEAR            CHAR(4)     NOT NULL,  -- YYYY
    CYCLE_MONTH           CHAR(2)     NOT NULL,  -- MM
    CYCLE_YEAR_MONTH      VARCHAR(6)  NULL,      -- YYYYMM
    CNTY_OIL_PROD_VOL     BIGINT      NULL,      -- Number(11) => BIGINT
    CNTY_OIL_ALLOW        BIGINT      NULL,
    CNTY_OIL_ENDING_BAL   BIGINT      NULL,
    CNTY_GAS_PROD_VOL     BIGINT      NULL,
    CNTY_GAS_ALLOW        BIGINT      NULL,
    CNTY_GAS_LIFT_INJ_VOL BIGINT      NULL,
    CNTY_COND_PROD_VOL    BIGINT      NULL,
    CNTY_COND_LIMIT       BIGINT      NULL,
    CNTY_COND_ENDING_BAL  BIGINT      NULL,
    CNTY_CSGD_PROD_VOL    BIGINT      NULL,
    CNTY_CSGD_LIMIT       BIGINT      NULL,
    CNTY_CSGD_GAS_LIFT    BIGINT      NULL,
    CNTY_OIL_TOT_DISP     BIGINT      NULL,
    CNTY_GAS_TOT_DISP     BIGINT      NULL,
    CNTY_COND_TOT_DISP    BIGINT      NULL,
    CNTY_CSGD_TOT_DISP    BIGINT      NULL,
    COUNTY_NAME           VARCHAR(50) NULL,
    DISTRICT_NAME         VARCHAR(50) NULL,
    OIL_GAS_CODE          CHAR(1)     NULL
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Contains monthly production aggregated by county (estimated values).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'3-digit county code (RRC/API).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'COUNTY_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC district code (2-digit).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Production year (YYYY).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Production month (MM).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Production cycle in YYYYMM format.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Oil production volume in BBL by county (estimated).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_OIL_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Sum of oil well allowables for the county in the cycle.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_OIL_ALLOW';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Oil ending balance (stock on hand) for the county.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_OIL_ENDING_BAL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Gas production volume in MCF by county (estimated).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_GAS_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Sum of gas well allowables for the county in the cycle.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_GAS_ALLOW';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Gas used/given/sold for gas lift (county level).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_GAS_LIFT_INJ_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Condensate production volume in BBL (estimated).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_COND_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Sum of condensate limit daily amounts for the county.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_COND_LIMIT';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Condensate ending balance (stock on hand).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_COND_ENDING_BAL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Casinghead gas production volume (MCF).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_CSGD_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Sum of casinghead gas limit daily amounts for the county.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_CSGD_LIMIT';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Casinghead gas used for gas lift (county level).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_CSGD_GAS_LIFT';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total oil disposed (BBL) for the county.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_OIL_TOT_DISP';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total gas disposed (MCF) for the county.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_GAS_TOT_DISP';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total condensate disposed (BBL) for the county.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_COND_TOT_DISP';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total casinghead gas disposed (MCF) for the county.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_CSGD_TOT_DISP';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Name of the county (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'COUNTY_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Name of the RRC district (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Indicates oil or gas (O/G). Possibly null.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OIL_GAS_CODE';
GO




--------------------------------------------------------------------------------
-- Check existence and recreate OG_COUNTY_LEASE_CYCLE
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.OG_COUNTY_LEASE_CYCLE', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.OG_COUNTY_LEASE_CYCLE;
END
GO

--------------------------------------------------------------------------------
-- Create Table: OG_COUNTY_LEASE_CYCLE
--   Contains production report data reported by lease and month (YYYYMM),
--   aggregated by lease and county. Estimates only based on allowables/potentials.
--------------------------------------------------------------------------------
CREATE TABLE dbo.OG_COUNTY_LEASE_CYCLE (
    OIL_GAS_CODE             CHAR(1)     NOT NULL,  -- (N)
    DISTRICT_NO              CHAR(2)     NOT NULL,  -- (N)
    LEASE_NO                 VARCHAR(6)  NOT NULL,  -- (N)
    CYCLE_YEAR               CHAR(4)     NOT NULL,  -- (N) YYYY
    CYCLE_MONTH              CHAR(2)     NOT NULL,  -- (N) MM
    COUNTY_NO                CHAR(3)     NOT NULL,  -- (N)
    OPERATOR_NO              VARCHAR(6)  NULL,      -- (Y)
    FIELD_NO                 VARCHAR(8)  NULL,      -- (Y)
    CYCLE_YEAR_MONTH         VARCHAR(6)  NULL,      -- (Y) YYYYMM
    FIELD_TYPE               CHAR(2)     NULL,      -- (Y)
    GAS_WELL_NO              VARCHAR(6)  NULL,      -- (Y)
    PROD_REPORT_FILED_FLAG   CHAR(1)     NULL,      -- (Y)
    CNTY_LSE_OIL_PROD_VOL    INT         NULL,      -- (Y)
    CNTY_LSE_OIL_ALLOW       INT         NULL,      
    CNTY_LSE_OIL_ENDING_BAL  INT         NULL,
    CNTY_LSE_GAS_PROD_VOL    INT         NULL,
    CNTY_LSE_GAS_ALLOW       INT         NULL,
    CNTY_LSE_GAS_LIFT_INJ_VOL INT        NULL,
    CNTY_LSE_COND_PROD_VOL   INT         NULL,
    CNTY_LSE_COND_LIMIT      INT         NULL,
    CNTY_LSE_COND_ENDING_BAL INT         NULL,
    CNTY_LSE_CSGD_PROD_VOL   INT         NULL,
    CNTY_LSE_CSGD_LIMIT      INT         NULL,
    CNTY_LSE_CSGD_GAS_LIFT   INT         NULL,
    CNTY_LSE_OIL_TOT_DISP    INT         NULL,
    CNTY_LSE_GAS_TOT_DISP    INT         NULL,
    CNTY_LSE_COND_TOT_DISP   INT         NULL,
    CNTY_LSE_CSGD_TOT_DISP   INT         NULL,
    DISTRICT_NAME            CHAR(2)     NULL,
    LEASE_NAME               VARCHAR(50) NULL,
    OPERATOR_NAME            VARCHAR(50) NULL,
    FIELD_NAME               VARCHAR(32) NULL,
    COUNTY_NAME              VARCHAR(50) NULL
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Contains monthly production by lease and county (estimated).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Code indicating Oil (O) or Gas (G).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OIL_GAS_CODE';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC district code (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Lease number assigned by RRC (unique within district).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Production year (YYYY).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Production month (MM).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'3-digit county code (RRC/API).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'COUNTY_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC operator number (6 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Field number (8 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'FIELD_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Cycle in YYYYMM format.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Type of field (e.g., PR, EX, etc.).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'FIELD_TYPE';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Gas well number (6 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'GAS_WELL_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Flag indicating if the production report was filed (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'PROD_REPORT_FILED_FLAG';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Oil production volume in BBL by county & lease (est.).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_OIL_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Oil well allowables for all wells in the lease & county.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_OIL_ALLOW';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Oil ending balance (stock on hand) for county & lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_OIL_ENDING_BAL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Gas production volume in MCF by county & lease (est.).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_GAS_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Gas allowables for all wells in the county & lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_GAS_ALLOW';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Gas used/given/sold for gas lift in the county & lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_GAS_LIFT_INJ_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Condensate production volume in BBL for the county & lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_COND_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Sum of condensate limit daily amounts for the county & lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_COND_LIMIT';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Condensate ending balance for the county & lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_COND_ENDING_BAL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Casinghead gas production volume (MCF) for county & lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_CSGD_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Casinghead gas limit daily amounts for the county & lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_CSGD_LIMIT';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Casinghead gas used/given/sold for gas lift in the county & lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_CSGD_GAS_LIFT';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total oil dispositions (BBL) for the county & lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_OIL_TOT_DISP';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total gas dispositions (MCF) for the county & lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_GAS_TOT_DISP';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total condensate dispositions (BBL) for county & lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_COND_TOT_DISP';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total casinghead gas dispositions (MCF) for county & lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CNTY_LSE_CSGD_TOT_DISP';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC district name (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Lease name (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Operator name (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Field name (up to 32 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'FIELD_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'County name (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_COUNTY_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'COUNTY_NAME';
GO


--------------------------------------------------------------------------------
-- Check existence and recreate OG_DISTRICT_CYCLE
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.OG_DISTRICT_CYCLE', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.OG_DISTRICT_CYCLE;
END
GO

--------------------------------------------------------------------------------
-- Create Table: OG_DISTRICT_CYCLE
--   Contains production report data reported by lease/month, aggregated by RRC district.
--------------------------------------------------------------------------------
CREATE TABLE dbo.OG_DISTRICT_CYCLE (
    DISTRICT_NO         CHAR(2)    NOT NULL,  -- e.g., '01'
    CYCLE_YEAR          CHAR(4)    NOT NULL,  -- e.g., '2023'
    CYCLE_MONTH         CHAR(2)    NOT NULL,  -- e.g., '01'..'12'
    CYCLE_YEAR_MONTH    VARCHAR(6) NULL,      -- e.g., '202301'
    DISTRICT_NAME       CHAR(2)    NULL,
    DIST_OIL_PROD_VOL   INT        NULL,      -- NUMBER(9)
    DIST_GAS_PROD_VOL   INT        NULL,      -- NUMBER(9)
    DIST_COND_PROD_VOL  INT        NULL,      -- NUMBER(9)
    DIST_CSGD_PROD_VOL  INT        NULL       -- NUMBER(9)
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Contains monthly production data aggregated by RRC district (lease-month roll-up).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_DISTRICT_CYCLE';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC district code (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_DISTRICT_CYCLE',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Year of production (YYYY).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_DISTRICT_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Month of production (MM).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_DISTRICT_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Concatenated year+month in YYYYMM format.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_DISTRICT_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'District name short identifier (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_DISTRICT_CYCLE',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total oil production volume (BBL) aggregated by district for the cycle.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_DISTRICT_CYCLE',
    @level2type = N'COLUMN', @level2name = N'DIST_OIL_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total gas production volume (MCF) aggregated by district for the cycle.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_DISTRICT_CYCLE',
    @level2type = N'COLUMN', @level2name = N'DIST_GAS_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total condensate production volume (BBL) aggregated by district for the cycle.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_DISTRICT_CYCLE',
    @level2type = N'COLUMN', @level2name = N'DIST_COND_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total casinghead gas production volume (MCF) aggregated by district for the cycle.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_DISTRICT_CYCLE',
    @level2type = N'COLUMN', @level2name = N'DIST_CSGD_PROD_VOL';
GO


--------------------------------------------------------------------------------
-- Check existence and recreate OG_FIELD_CYCLE
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.OG_FIELD_CYCLE', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.OG_FIELD_CYCLE;
END
GO

--------------------------------------------------------------------------------
-- Create Table: OG_FIELD_CYCLE
--   Contains monthly production data by field (oil, gas, condensate, casinghead gas).
--------------------------------------------------------------------------------
CREATE TABLE dbo.OG_FIELD_CYCLE (
    DISTRICT_NO         CHAR(2)     NOT NULL,  -- e.g., '01'
    FIELD_NO            VARCHAR(8)  NOT NULL,  -- e.g., '12345'
    CYCLE_YEAR          CHAR(4)     NOT NULL,  -- YYYY
    CYCLE_MONTH         CHAR(2)     NOT NULL,  -- MM
    CYCLE_YEAR_MONTH    VARCHAR(6)  NULL,      -- YYYYMM
    DISTRICT_NAME       CHAR(2)     NULL,
    FIELD_NAME          VARCHAR(32) NULL,
    FIELD_OIL_PROD_VOL  INT         NULL,      -- NUMBER(9)
    FIELD_GAS_PROD_VOL  INT         NULL,      -- NUMBER(9)
    FIELD_COND_PROD_VOL INT         NULL,      -- NUMBER(9)
    FIELD_CSGD_PROD_VOL INT         NULL       -- NUMBER(9)
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Contains production report data by field and month (YYYYMM).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_CYCLE';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC district code (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_CYCLE',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Field number assigned by RRC (8 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_CYCLE',
    @level2type = N'COLUMN', @level2name = N'FIELD_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Production year (YYYY).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Production month (MM).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Concatenated year+month in YYYYMM format.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'District name short identifier (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_CYCLE',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Field name (up to 32 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_CYCLE',
    @level2type = N'COLUMN', @level2name = N'FIELD_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total oil production volume (BBL) for this field in the cycle.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_CYCLE',
    @level2type = N'COLUMN', @level2name = N'FIELD_OIL_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total gas production volume (MCF) for this field in the cycle.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_CYCLE',
    @level2type = N'COLUMN', @level2name = N'FIELD_GAS_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total condensate (BBL) for this field in the cycle.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_CYCLE',
    @level2type = N'COLUMN', @level2name = N'FIELD_COND_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total casinghead gas (MCF) for this field in the cycle.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_CYCLE',
    @level2type = N'COLUMN', @level2name = N'FIELD_CSGD_PROD_VOL';
GO


--------------------------------------------------------------------------------
-- Check existence and recreate OG_FIELD_DW
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.OG_FIELD_DW', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.OG_FIELD_DW;
END
GO

--------------------------------------------------------------------------------
-- Create Table: OG_FIELD_DW
--   Table of field identifying data (e.g., classification, H2S flag, salt dome, discovery date, etc.).
--------------------------------------------------------------------------------
CREATE TABLE dbo.OG_FIELD_DW (
    FIELD_NO                 VARCHAR(8)   NOT NULL,  -- (N)
    FIELD_NAME               VARCHAR(32)  NOT NULL,  -- (N)
    DISTRICT_NO              CHAR(2)      NOT NULL,  -- (N)
    DISTRICT_NAME            CHAR(2)      NULL,      -- (Y)
    FIELD_CLASS              CHAR(1)      NULL,      -- (Y)
    FIELD_H2S_FLAG           CHAR(1)      NULL,      -- (Y)
    FIELD_MANUAL_REV_FLAG    CHAR(1)      NULL,      -- (Y)
    WILDCAT_FLAG             CHAR(1)      NULL,      -- (Y)
    O_DERIVED_RULE_TYPE_CODE CHAR(2)      NULL,      -- (Y)
    G_DERIVED_RULE_TYPE_CODE CHAR(2)      NULL,      -- (Y)
    O_RESCIND_DT             DATE         NULL,      -- (Y)
    G_RESCIND_DT             VARCHAR(20)  NULL,      -- (Y)
    O_SALT_DOME_FLAG         CHAR(1)      NULL,      -- (Y)
    G_SALT_DOME_FLAG         CHAR(1)      NULL,      -- (Y)
    O_OFFSHORE_CODE          CHAR(2)      NULL,      -- (Y)
    G_OFFSHORE_CODE          CHAR(2)      NULL,      -- (Y)
    O_DONT_PERMIT            CHAR(1)      NULL,      -- (Y)
    G_DONT_PERMIT            CHAR(1)      NULL,      -- (Y)
    O_NOA_MAN_REV_RULE       VARCHAR(2000) NULL,     -- (Y)
    G_NOA_MAN_REV_RULE       VARCHAR(2000) NULL,     -- (Y)
    O_COUNTY_NO              CHAR(3)      NULL,      -- (Y)
    G_COUNTY_NO              CHAR(3)      NULL,      -- (Y)
    O_DISCOVERY_DT           DATE         NULL,      -- (Y)
    G_DISCOVERY_DT           DATE         NULL,      -- (Y)
    O_SCHED_REMARKS          VARCHAR(66)  NULL,      -- (Y)
    G_SCHED_REMARKS          VARCHAR(66)  NULL,      -- (Y)
    O_COMMENTS               VARCHAR(66)  NULL,      -- (Y)
    G_COMMENTS               VARCHAR(66)  NULL,      -- (Y)
    CREATE_BY                VARCHAR(30)  NULL,      -- (Y)
    CREATE_DT                DATE         NULL,      -- (Y)
    MODIFY_BY                VARCHAR(30)  NULL,      -- (Y)
    MODIFY_DT                DATE         NULL       -- (Y)
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Table of field identifying data (classification, flags, discovery dates, etc.).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Field number assigned by the Field Designation section (8 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'FIELD_NO';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Official field name (up to 32 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'FIELD_NAME';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'District code (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NO';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Short identifier for district name (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NAME';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Indicates field classification (O=oil, G=gas, B=both).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'FIELD_CLASS';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'H2S presence indicator (Y, N, or E).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'FIELD_H2S_FLAG';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Flag indicating if manual review of field rules is required (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'FIELD_MANUAL_REV_FLAG';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Flag indicating a wildcat field (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'WILDCAT_FLAG';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Derived rule type code for oil portion of field (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'O_DERIVED_RULE_TYPE_CODE';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Derived rule type code for gas portion of field (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'G_DERIVED_RULE_TYPE_CODE';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Date field rules were rescinded for oil portion (DATE).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'O_RESCIND_DT';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Date field rules were rescinded for gas portion (up to 20 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'G_RESCIND_DT';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Flag that indicates a salt dome classification for the oil portion (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'O_SALT_DOME_FLAG';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Flag that indicates a salt dome classification for the gas portion (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'G_SALT_DOME_FLAG';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Offshore code for the oil portion (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'O_OFFSHORE_CODE';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Offshore code for the gas portion (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'G_OFFSHORE_CODE';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Flag indicating whether permits can be granted for oil portion (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'O_DONT_PERMIT';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Flag indicating whether permits can be granted for gas portion (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'G_DONT_PERMIT';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Notice of Application Manual Review Rule for oil portion (up to 2000 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'O_NOA_MAN_REV_RULE';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Notice of Application Manual Review Rule for gas portion (up to 2000 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'G_NOA_MAN_REV_RULE';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'County number for oil portion (3-digit).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'O_COUNTY_NO';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'County number for gas portion (3-digit).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'G_COUNTY_NO';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Discovery date of the first well in the oil field (DATE).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'O_DISCOVERY_DT';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Discovery date of the first well in the gas field (DATE).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'G_DISCOVERY_DT';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Remarks printed on the oil proration schedule (66 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'O_SCHED_REMARKS';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Remarks printed on the gas proration schedule (66 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'G_SCHED_REMARKS';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Comments for the oil portion (66 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'O_COMMENTS';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Comments for the gas portion (66 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'G_COMMENTS';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'For reference by RRC staff (created by).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'CREATE_BY';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Creation datetime record for RRC reference.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'CREATE_DT';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'For reference by RRC staff (last modified by).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'MODIFY_BY';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Date record last modified for RRC reference.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_FIELD_DW',
    @level2type = N'COLUMN', @level2name = N'MODIFY_DT';
GO


--------------------------------------------------------------------------------
-- Check existence and recreate OG_LEASE_CYCLE
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.OG_LEASE_CYCLE', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.OG_LEASE_CYCLE;
END
GO

--------------------------------------------------------------------------------
-- Create Table: OG_LEASE_CYCLE
--   Contains production report data by lease and month (YYYYMM).
--------------------------------------------------------------------------------
CREATE TABLE dbo.OG_LEASE_CYCLE (
    OIL_GAS_CODE             CHAR(1)     NOT NULL,  -- (N) O=Oil or G=Gas
    DISTRICT_NO              CHAR(2)     NOT NULL,  -- (N) RRC district code
    LEASE_NO                 VARCHAR(6)  NOT NULL,  -- (N) Lease number
    CYCLE_YEAR               CHAR(4)     NOT NULL,  -- (N) YYYY
    CYCLE_MONTH              CHAR(2)     NOT NULL,  -- (N) MM
    CYCLE_YEAR_MONTH         VARCHAR(6)  NOT NULL,  -- (N) YYYYMM
    LEASE_NO_DISTRICT_NO     BIGINT      NOT NULL,  -- (N) Possibly a combined key
    OPERATOR_NO              VARCHAR(6)  NULL,      -- (Y)
    FIELD_NO                 VARCHAR(8)  NULL,      -- (Y)
    FIELD_TYPE               CHAR(2)     NULL,      -- (Y)
    GAS_WELL_NO              VARCHAR(6)  NULL,      -- (Y)
    PROD_REPORT_FILED_FLAG   CHAR(1)     NULL,      -- (Y)
    LEASE_OIL_PROD_VOL       INT         NULL,      -- (Y)
    LEASE_OIL_ALLOW          INT         NULL,      
    LEASE_OIL_ENDING_BAL     INT         NULL,
    LEASE_GAS_PROD_VOL       INT         NULL,
    LEASE_GAS_ALLOW          INT         NULL,
    LEASE_GAS_LIFT_INJ_VOL   INT         NULL,
    LEASE_COND_PROD_VOL      INT         NULL,
    LEASE_COND_LIMIT         INT         NULL,
    LEASE_COND_ENDING_BAL    INT         NULL,
    LEASE_CSGD_PROD_VOL      INT         NULL,
    LEASE_CSGD_LIMIT         INT         NULL,
    LEASE_CSGD_GAS_LIFT      INT         NULL,
    LEASE_OIL_TOT_DISP       INT         NULL,
    LEASE_GAS_TOT_DISP       INT         NULL,
    LEASE_COND_TOT_DISP      INT         NULL,
    LEASE_CSGD_TOT_DISP      INT         NULL,
    DISTRICT_NAME            CHAR(2)     NULL,
    LEASE_NAME               VARCHAR(50) NULL,
    OPERATOR_NAME            VARCHAR(50) NULL,
    FIELD_NAME               VARCHAR(32) NULL
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Contains monthly production report data (oil/gas/condensate) by lease and month (YYYYMM).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Denotes whether the lease is oil (O) or gas (G).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OIL_GAS_CODE';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC district code (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Lease number (6 chars), unique within district.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Production year (YYYY).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Production month (MM).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Production cycle in YYYYMM format.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Combined numeric key, possibly district + lease or other.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_NO_DISTRICT_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC operator number (6 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Field number (8 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'FIELD_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Field type (e.g., PR, EX, ST, etc.).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'FIELD_TYPE';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Gas well number (6 chars), if applicable.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'GAS_WELL_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Flag indicating if the production report was filed (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'PROD_REPORT_FILED_FLAG';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Monthly oil production volume (BBL) on this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_OIL_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total oil allowables for wells in this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_OIL_ALLOW';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Oil ending balance (stock on hand) for this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_OIL_ENDING_BAL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Monthly gas production volume (MCF) on this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_GAS_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total gas allowables for wells in this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_GAS_ALLOW';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Gas used, given, or sold for gas lift for this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_GAS_LIFT_INJ_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Monthly condensate production (BBL) for this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_COND_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Condensate limit daily amounts for this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_COND_LIMIT';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Condensate ending balance (stock on hand) for this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_COND_ENDING_BAL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Casinghead gas production volume (MCF) for this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_CSGD_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Casinghead gas limit daily amounts for this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_CSGD_LIMIT';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Casinghead gas used, given, or sold for gas lift on this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_CSGD_GAS_LIFT';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total oil dispositions (BBL) for this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_OIL_TOT_DISP';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total gas dispositions (MCF) for this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_GAS_TOT_DISP';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total condensate dispositions (BBL) for this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_COND_TOT_DISP';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total casinghead gas dispositions (MCF) for this lease.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_CSGD_TOT_DISP';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'District name short identifier (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Lease name (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'LEASE_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Operator name (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Field name (up to 32 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE',
    @level2type = N'COLUMN', @level2name = N'FIELD_NAME';
GO


--------------------------------------------------------------------------------
-- Check existence and recreate OG_LEASE_CYCLE_DISP
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.OG_LEASE_CYCLE_DISP', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.OG_LEASE_CYCLE_DISP;
END
GO

--------------------------------------------------------------------------------
-- Create Table: OG_LEASE_CYCLE_DISP
--   Contains production report disposition data by lease and month (YYYYMM).
--------------------------------------------------------------------------------
CREATE TABLE dbo.OG_LEASE_CYCLE_DISP (
    OIL_GAS_CODE              CHAR(1)    NOT NULL,  -- N
    DISTRICT_NO               CHAR(2)    NOT NULL,  -- N
    LEASE_NO                  VARCHAR(6) NOT NULL,  -- N
    CYCLE_YEAR                CHAR(4)    NOT NULL,  -- N (YYYY)
    CYCLE_MONTH               CHAR(2)    NOT NULL,  -- N (MM)
    OPERATOR_NO               VARCHAR(6) NULL,      -- Y
    FIELD_NO                  VARCHAR(8) NULL,      -- Y
    CYCLE_YEAR_MONTH          VARCHAR(6) NULL,      -- Y (YYYYMM)

    -- Oil Disposition Codes (00..09, 99)
    LEASE_OIL_DISPCD00_VOL    INT        NULL,  -- Y
    LEASE_OIL_DISPCD01_VOL    INT        NULL,  -- Y
    LEASE_OIL_DISPCD02_VOL    INT        NULL,  -- Y
    LEASE_OIL_DISPCD03_VOL    INT        NULL,  -- Y
    LEASE_OIL_DISPCD04_VOL    INT        NULL,  -- Y
    LEASE_OIL_DISPCD05_VOL    INT        NULL,  -- Y
    LEASE_OIL_DISPCD06_VOL    INT        NULL,  -- Y
    LEASE_OIL_DISPCD07_VOL    INT        NULL,  -- Y
    LEASE_OIL_DISPCD08_VOL    INT        NULL,  -- Y
    LEASE_OIL_DISPCD09_VOL    INT        NULL,  -- Y
    LEASE_OIL_DISPCD99_VOL    INT        NULL,  -- Y

    -- Gas Disposition Codes (01..09, 99)
    LEASE_GAS_DISPCD01_VOL    INT        NULL,  -- Y
    LEASE_GAS_DISPCD02_VOL    INT        NULL,  -- Y
    LEASE_GAS_DISPCD03_VOL    INT        NULL,  -- Y
    LEASE_GAS_DISPCD04_VOL    INT        NULL,  -- Y
    LEASE_GAS_DISPCD05_VOL    INT        NULL,  -- Y
    LEASE_GAS_DISPCD06_VOL    INT        NULL,  -- Y
    LEASE_GAS_DISPCD07_VOL    INT        NULL,  -- Y
    LEASE_GAS_DISPCD08_VOL    INT        NULL,  -- Y
    LEASE_GAS_DISPCD09_VOL    INT        NULL,  -- Y
    LEASE_GAS_DISPCD99_VOL    INT        NULL,  -- Y

    -- Condensate Disposition Codes (00..08, 99)
    LEASE_COND_DISPCD00_VOL   INT        NULL,  -- Y
    LEASE_COND_DISPCD01_VOL   INT        NULL,
    LEASE_COND_DISPCD02_VOL   INT        NULL,
    LEASE_COND_DISPCD03_VOL   INT        NULL,
    LEASE_COND_DISPCD04_VOL   INT        NULL,
    LEASE_COND_DISPCD05_VOL   INT        NULL,
    LEASE_COND_DISPCD06_VOL   INT        NULL,
    LEASE_COND_DISPCD07_VOL   INT        NULL,
    LEASE_COND_DISPCD08_VOL   INT        NULL,
    LEASE_COND_DISPCD99_VOL   INT        NULL,

    -- Casinghead Gas Disposition Codes (E01..E08, E99)
    LEASE_CSGD_DISPCDE01_VOL  INT        NULL,
    LEASE_CSGD_DISPCDE02_VOL  INT        NULL,
    LEASE_CSGD_DISPCDE03_VOL  INT        NULL,
    LEASE_CSGD_DISPCDE04_VOL  INT        NULL,
    LEASE_CSGD_DISPCDE05_VOL  INT        NULL,
    LEASE_CSGD_DISPCDE06_VOL  INT        NULL,
    LEASE_CSGD_DISPCDE07_VOL  INT        NULL,
    LEASE_CSGD_DISPCDE08_VOL  INT        NULL,
    LEASE_CSGD_DISPCDE99_VOL  INT        NULL,

    DISTRICT_NAME             CHAR(2)    NULL,  -- Y
    LEASE_NAME                VARCHAR(50) NULL, -- Y
    OPERATOR_NAME             VARCHAR(50) NULL, -- Y
    FIELD_NAME                VARCHAR(32) NULL  -- Y
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Contains production report disposition data by lease and month (YYYYMM).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Indicates Oil (O) or Gas (G).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'OIL_GAS_CODE';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'RRC district code (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NO';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Lease number (up to 6 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'LEASE_NO';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Production year (YYYY).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Production month (MM).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'CYCLE_MONTH';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Operator number (up to 6 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NO';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Field number (up to 8 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'FIELD_NO';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Production cycle in YYYYMM format.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR_MONTH';
GO

-- Oil Disposition Columns (00..09, 99)
EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Volume of oil disposition code 00 (pipeline) in BBL.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'LEASE_OIL_DISPCD00_VOL';
GO

-- You would repeat the above pattern for LEASE_OIL_DISPCD01_VOL through LEASE_OIL_DISPCD09_VOL,
-- and LEASE_OIL_DISPCD99_VOL, each describing the relevant disposition code usage.
-- For brevity, here's just one or two more as examples:
EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Volume of oil disposition code 01 (truck) in BBL.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'LEASE_OIL_DISPCD01_VOL';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Volume of oil disposition code 99 (no code reported) in BBL.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'LEASE_OIL_DISPCD99_VOL';
GO

-- Gas Disposition Columns (01..09, 99)
EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Gas disposition code 01 (used for field ops) in MCF.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'LEASE_GAS_DISPCD01_VOL';
GO

-- etc. up through 09 and 99...

-- Condensate Disposition Columns (00..08, 99)
EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Condensate disposition code 00 (pipeline) in BBL.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'LEASE_COND_DISPCD00_VOL';
GO

-- etc. up through 08 and 99...

-- Casinghead Gas Disposition Columns (E01..E08, E99)
EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Casinghead gas disposition code E01 (gas used/given for field ops).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'LEASE_CSGD_DISPCDE01_VOL';
GO

-- etc. up through E08 and E99...

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'District name short identifier (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NAME';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Lease name (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'LEASE_NAME';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Operator name (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NAME';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Field name (up to 32 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_LEASE_CYCLE_DISP',
    @level2type = N'COLUMN', @level2name = N'FIELD_NAME';
GO


--------------------------------------------------------------------------------
-- Check existence and recreate OG_OPERATOR_CYCLE
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.OG_OPERATOR_CYCLE', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.OG_OPERATOR_CYCLE;
END
GO

--------------------------------------------------------------------------------
-- Create Table: OG_OPERATOR_CYCLE
--   Contains production report data reported by lease and month (YYYYMM),
--   aggregated by the operator of the lease.
--------------------------------------------------------------------------------
CREATE TABLE dbo.OG_OPERATOR_CYCLE (
    OPERATOR_NO         VARCHAR(6)  NOT NULL,  -- (N)
    CYCLE_YEAR          CHAR(4)     NOT NULL,  -- (N) YYYY
    CYCLE_MONTH         CHAR(2)     NOT NULL,  -- (N) MM
    CYCLE_YEAR_MONTH    VARCHAR(6)  NULL,      -- (Y) YYYYMM
    OPERATOR_NAME       VARCHAR(50) NULL,      -- (Y)
    OPER_OIL_PROD_VOL   INT         NULL,      -- (Y)
    OPER_GAS_PROD_VOL   INT         NULL,      -- (Y)
    OPER_COND_PROD_VOL  INT         NULL,      -- (Y)
    OPER_CSGD_PROD_VOL  INT         NULL       -- (Y)
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Contains monthly production data aggregated by the operator.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_CYCLE';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC operator number (6 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Production year (YYYY).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Production month (MM).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Year and month concatenated in YYYYMM format.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_CYCLE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR_MONTH';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Name of the operator (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total oil production volume (BBL) for this operator in the cycle.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OPER_OIL_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total gas production volume (MCF) for this operator in the cycle.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OPER_GAS_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total condensate production volume (BBL) for this operator in the cycle.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OPER_COND_PROD_VOL';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Total casinghead gas production volume (MCF) for this operator in the cycle.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_CYCLE',
    @level2type = N'COLUMN', @level2name = N'OPER_CSGD_PROD_VOL';
GO


--------------------------------------------------------------------------------
-- Check existence and recreate OG_OPERATOR_DW
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.OG_OPERATOR_DW', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.OG_OPERATOR_DW;
END
GO

--------------------------------------------------------------------------------
-- Create Table: OG_OPERATOR_DW
--   Contains identifying operator information (P5 status, tax cert flags, etc.).
--------------------------------------------------------------------------------
CREATE TABLE dbo.OG_OPERATOR_DW (
    OPERATOR_NO            VARCHAR(6)  NOT NULL, -- (N)
    OPERATOR_NAME          VARCHAR(50) NULL,     -- (Y)
    P5_STATUS_CODE         CHAR(4)     NULL,     -- (Y)
    P5_LAST_FILED_DT       VARCHAR(8)  NULL,     -- (Y)
    OPERATOR_TAX_CERT_FLAG CHAR(1)     NULL,     -- (Y)
    OPERATOR_SB639_FLAG    CHAR(1)     NULL,     -- (Y)
    FA_OPTION_CODE         CHAR(2)     NULL,     -- (Y)
    RECORD_STATUS_CODE     CHAR(1)     NULL,     -- (Y)
    EFILE_STATUS_CODE      CHAR(4)     NULL,     -- (Y)
    EFILE_EFFECTIVE_DT     DATE        NULL,     -- (Y)
    CREATE_BY              VARCHAR(30) NULL,     -- (Y)
    CREATE_DT              DATE        NULL,     -- (Y)
    MODIFY_BY              VARCHAR(30) NULL,     -- (Y)
    MODIFY_DT              DATE        NULL      -- (Y)
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Contains identifying operator info: P5 status, flags, filing dates, etc.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC operator ID number (6 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Name of the operator (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'P5 status code (4 chars) representing the organization status.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW',
    @level2type = N'COLUMN', @level2name = N'P5_STATUS_CODE';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Date of last P-5 filing (YYYYMMDD or similar), up to 8 chars.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW',
    @level2type = N'COLUMN', @level2name = N'P5_LAST_FILED_DT';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Flag indicating receipt of operator tax certificate (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_TAX_CERT_FLAG';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Flag indicating the SB639 status of the operator (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_SB639_FLAG';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Financial Assurance option code (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW',
    @level2type = N'COLUMN', @level2name = N'FA_OPTION_CODE';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Record status code (1 char) for internal use.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW',
    @level2type = N'COLUMN', @level2name = N'RECORD_STATUS_CODE';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'E-filing status code (4 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW',
    @level2type = N'COLUMN', @level2name = N'EFILE_STATUS_CODE';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'E-filing effective date.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW',
    @level2type = N'COLUMN', @level2name = N'EFILE_EFFECTIVE_DT';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'User or process that created this record (RRC staff).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW',
    @level2type = N'COLUMN', @level2name = N'CREATE_BY';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Date/time the record was created, for RRC reference.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW',
    @level2type = N'COLUMN', @level2name = N'CREATE_DT';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'User or process that last modified this record.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW',
    @level2type = N'COLUMN', @level2name = N'MODIFY_BY';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Date/time the record was last modified.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_OPERATOR_DW',
    @level2type = N'COLUMN', @level2name = N'MODIFY_DT';
GO



--------------------------------------------------------------------------------
-- Check existence and recreate OG_REGULATORY_LEASE_DW
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.OG_REGULATORY_LEASE_DW', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.OG_REGULATORY_LEASE_DW;
END
GO

--------------------------------------------------------------------------------
-- Create Table: OG_REGULATORY_LEASE_DW
--   This table contains identifying lease information (oil/gas code, well #,
--   severance/off-sched flags, operator/district/field references, etc.).
--------------------------------------------------------------------------------
CREATE TABLE dbo.OG_REGULATORY_LEASE_DW (
    OIL_GAS_CODE           CHAR(1)     NOT NULL, -- (N) O=Oil, G=Gas
    DISTRICT_NO            CHAR(2)     NOT NULL, -- (N) RRC district code
    LEASE_NO               VARCHAR(6)  NOT NULL, -- (N) Lease number
    DISTRICT_NAME          CHAR(2)     NULL,     -- (Y)
    LEASE_NAME             VARCHAR(50) NULL,     -- (Y)
    OPERATOR_NO            VARCHAR(6)  NOT NULL, -- (N) Operator ID
    OPERATOR_NAME          VARCHAR(50) NULL,     -- (Y)
    FIELD_NO               VARCHAR(8)  NOT NULL, -- (N) Field number
    FIELD_NAME             VARCHAR(32) NULL,     -- (Y)
    WELL_NO                VARCHAR(6)  NULL,     -- (Y)
    LEASE_OFF_SCHED_FLAG   CHAR(1)     NOT NULL, -- (N) Off-schedule flag
    LEASE_SEVERANCE_FLAG   CHAR(1)     NOT NULL  -- (N) Severance flag
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Contains identifying lease information, including severance/off-schedule flags, operator details, and well number.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_REGULATORY_LEASE_DW';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Denotes Oil (O) or Gas (G).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_REGULATORY_LEASE_DW',
    @level2type = N'COLUMN', @level2name = N'OIL_GAS_CODE';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC district code (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_REGULATORY_LEASE_DW',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Lease number (up to 6 chars), unique within district.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_REGULATORY_LEASE_DW',
    @level2type = N'COLUMN', @level2name = N'LEASE_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Short identifier for the RRC district (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_REGULATORY_LEASE_DW',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Lease name (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_REGULATORY_LEASE_DW',
    @level2type = N'COLUMN', @level2name = N'LEASE_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC operator ID number (6 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_REGULATORY_LEASE_DW',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Name of the operator (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_REGULATORY_LEASE_DW',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Field number assigned by RRC (up to 8 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_REGULATORY_LEASE_DW',
    @level2type = N'COLUMN', @level2name = N'FIELD_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Field name (up to 32 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_REGULATORY_LEASE_DW',
    @level2type = N'COLUMN', @level2name = N'FIELD_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Well number (up to 6 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_REGULATORY_LEASE_DW',
    @level2type = N'COLUMN', @level2name = N'WELL_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Flag indicating the lease is off schedule (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_REGULATORY_LEASE_DW',
    @level2type = N'COLUMN', @level2name = N'LEASE_OFF_SCHED_FLAG';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Flag indicating a P-4 Severance is in effect (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_REGULATORY_LEASE_DW',
    @level2type = N'COLUMN', @level2name = N'LEASE_SEVERANCE_FLAG';
GO




--------------------------------------------------------------------------------
-- Check existence and recreate OG_SUMMARY_MASTER_LARGE
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.OG_SUMMARY_MASTER_LARGE', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.OG_SUMMARY_MASTER_LARGE;
END
GO

--------------------------------------------------------------------------------
-- Create Table: OG_SUMMARY_MASTER_LARGE
--   Summary table at the operator level (often used for queries).
--------------------------------------------------------------------------------
CREATE TABLE dbo.OG_SUMMARY_MASTER_LARGE (
    OIL_GAS_CODE           CHAR(1)    NOT NULL, -- (N) O=Oil or G=Gas
    DISTRICT_NO            CHAR(2)    NOT NULL, -- (N) RRC district
    LEASE_NO               VARCHAR(6) NOT NULL, -- (N)
    OPERATOR_NO            VARCHAR(6) NOT NULL, -- (N)
    FIELD_NO               VARCHAR(8) NOT NULL, -- (N)
    CYCLE_YEAR_MONTH_MIN   INT        NOT NULL, -- (N) Earliest YYYYMM
    CYCLE_YEAR_MONTH_MAX   INT        NOT NULL, -- (N) Latest YYYYMM
    DISTRICT_NAME          CHAR(2)    NULL,     -- (Y)
    LEASE_NAME             VARCHAR(50) NULL,    -- (Y)
    OPERATOR_NAME          VARCHAR(50) NULL,    -- (Y)
    FIELD_NAME             VARCHAR(32) NULL     -- (Y)
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name  = N'MS_Description',
    @value = N'Summary table used for queries at the operator level; tracks min/max cycle years plus basic lease/operator/field info.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_MASTER_LARGE';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Indicates Oil (O) or Gas (G).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_MASTER_LARGE',
    @level2type = N'COLUMN', @level2name = N'OIL_GAS_CODE';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC district code (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_MASTER_LARGE',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Lease number (6 chars), unique within district.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_MASTER_LARGE',
    @level2type = N'COLUMN', @level2name = N'LEASE_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC operator ID (6 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_MASTER_LARGE',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Field number (8 chars) assigned by RRC.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_MASTER_LARGE',
    @level2type = N'COLUMN', @level2name = N'FIELD_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Earliest production cycle (YYYYMM) found for this lease/operator/field.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_MASTER_LARGE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR_MONTH_MIN';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Latest production cycle (YYYYMM) found for this lease/operator/field.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_MASTER_LARGE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR_MONTH_MAX';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'District name short identifier (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_MASTER_LARGE',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Name of the lease (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_MASTER_LARGE',
    @level2type = N'COLUMN', @level2name = N'LEASE_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Name of the operator (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_MASTER_LARGE',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Name of the field (up to 32 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_MASTER_LARGE',
    @level2type = N'COLUMN', @level2name = N'FIELD_NAME';
GO



--------------------------------------------------------------------------------
-- Check existence and recreate OG_SUMMARY_ONSHORE_LEASE
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.OG_SUMMARY_ONSHORE_LEASE', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.OG_SUMMARY_ONSHORE_LEASE;
END
GO

--------------------------------------------------------------------------------
-- Create Table: OG_SUMMARY_ONSHORE_LEASE
--   Summary table used for onshore leases only.
--------------------------------------------------------------------------------
CREATE TABLE dbo.OG_SUMMARY_ONSHORE_LEASE (
    OIL_GAS_CODE           CHAR(1)    NOT NULL, -- (N) O=Oil, G=Gas
    DISTRICT_NO            CHAR(2)    NOT NULL, -- (N) RRC district
    LEASE_NO               VARCHAR(6) NOT NULL, -- (N)
    OPERATOR_NO            VARCHAR(6) NOT NULL, -- (N)
    FIELD_NO               VARCHAR(8) NOT NULL, -- (N)
    CYCLE_YEAR_MONTH_MIN   INT        NOT NULL, -- (N) Earliest YYYYMM
    CYCLE_YEAR_MONTH_MAX   INT        NOT NULL, -- (N) Latest YYYYMM
    LEASE_NAME             VARCHAR(50) NULL,    -- (Y)
    OPERATOR_NAME          VARCHAR(50) NULL,    -- (Y)
    FIELD_NAME             VARCHAR(32) NULL     -- (Y)
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name  = N'MS_Description',
    @value = N'Summary table for onshore leases only, storing min/max cycles plus identifying details.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_ONSHORE_LEASE';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Indicates Oil (O) or Gas (G).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_ONSHORE_LEASE',
    @level2type = N'COLUMN', @level2name = N'OIL_GAS_CODE';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC district code (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_ONSHORE_LEASE',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Lease number (6 chars), unique within district.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_ONSHORE_LEASE',
    @level2type = N'COLUMN', @level2name = N'LEASE_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'RRC operator ID (6 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_ONSHORE_LEASE',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Field number (8 chars) assigned by RRC.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_ONSHORE_LEASE',
    @level2type = N'COLUMN', @level2name = N'FIELD_NO';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Earliest production cycle (YYYYMM) for the onshore lease/operator/field.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_ONSHORE_LEASE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR_MONTH_MIN';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Latest production cycle (YYYYMM) for the onshore lease/operator/field.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_ONSHORE_LEASE',
    @level2type = N'COLUMN', @level2name = N'CYCLE_YEAR_MONTH_MAX';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Lease name (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_ONSHORE_LEASE',
    @level2type = N'COLUMN', @level2name = N'LEASE_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Operator name (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_ONSHORE_LEASE',
    @level2type = N'COLUMN', @level2name = N'OPERATOR_NAME';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Field name (up to 32 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_SUMMARY_ONSHORE_LEASE',
    @level2type = N'COLUMN', @level2name = N'FIELD_NAME';
GO



--------------------------------------------------------------------------------
-- Check existence and recreate OG_WELL_COMPLETION
--------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.OG_WELL_COMPLETION', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.OG_WELL_COMPLETION;
END
GO

--------------------------------------------------------------------------------
-- Create Table: OG_WELL_COMPLETION
--   Contains identifying well completion information: API codes, location,
--   shut-in dates, etc.
--------------------------------------------------------------------------------
CREATE TABLE dbo.OG_WELL_COMPLETION (
    OIL_GAS_CODE           CHAR(1)     NOT NULL, -- (N) O=Oil, G=Gas
    DISTRICT_NO            CHAR(2)     NOT NULL, -- (N) RRC district
    LEASE_NO               VARCHAR(6)  NOT NULL, -- (N) Lease number
    WELL_NO                VARCHAR(6)  NOT NULL, -- (N) Well ID
    API_COUNTY_CODE        CHAR(3)     NOT NULL, -- (N) 3-digit code
    API_UNIQUE_NO          VARCHAR(5)  NOT NULL, -- (N) 5-digit unique
    ONSHORE_ASSC_CNTY      CHAR(3)     NULL,     -- (Y)
    DISTRICT_NAME          CHAR(2)     NULL,     -- (Y)
    COUNTY_NAME            VARCHAR(50) NULL,     -- (Y)
    OIL_WELL_UNIT_NO       VARCHAR(6)  NULL,     -- (Y)
    WELL_ROOT_NO           VARCHAR(8)  NULL,     -- (Y)
    WELLBORE_SHUTIN_DT     VARCHAR(6)  NULL,     -- (Y) YYYYMM
    WELL_SHUTIN_DT         VARCHAR(6)  NULL,     -- (Y) YYYYMM
    WELL_14B2_STATUS_CODE  CHAR(1)     NULL,     -- (Y)
    WELL_SUBJECT_14B2_FLAG CHAR(1)     NULL,     -- (Y)
    WELLBORE_LOCATION_CODE CHAR(1)     NULL      -- (Y) L=Land, O=Offshore, etc.
);
GO

--------------------------------------------------------------------------------
-- Add Table-Level Extended Property
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'Contains well completion info: API county codes, unique well number, onshore/offshore flags, shut-in dates, etc.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION';
GO

--------------------------------------------------------------------------------
-- Add Column-Level Extended Properties
--------------------------------------------------------------------------------
EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Oil (O) or Gas (G) code.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'OIL_GAS_CODE';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'RRC district code (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NO';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Lease number (6 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'LEASE_NO';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Well number (6 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'WELL_NO';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'3-digit county code (API-based) for onshore/offshore classification.',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'API_COUNTY_CODE';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Unique 5-digit API well ID portion (no duplication).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'API_UNIQUE_NO';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Onshore associated county code (3 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'ONSHORE_ASSC_CNTY';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'District name short identifier (2 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'DISTRICT_NAME';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'County name (up to 50 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'COUNTY_NAME';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Oil well unit number (up to 6 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'OIL_WELL_UNIT_NO';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Root number used internally by the system for the well (8 chars).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'WELL_ROOT_NO';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Wellbore shut-in date (YYYYMM format).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'WELLBORE_SHUTIN_DT';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Well shut-in date (YYYYMM).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'WELL_SHUTIN_DT';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Well’s Statewide Rule 14(b)(2) extension status code (Y/N).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'WELL_14B2_STATUS_CODE';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Flag indicating whether the well is subject to Rule 14(b)(2). (Y/N)',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'WELL_SUBJECT_14B2_FLAG';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Location code for the wellbore (L=Land, O=Offshore, I=Inland waterway, B=Bay/Estuary).',
    @level0type = N'SCHEMA', @level0name = dbo,
    @level1type = N'TABLE',  @level1name = N'OG_WELL_COMPLETION',
    @level2type = N'COLUMN', @level2name = N'WELLBORE_LOCATION_CODE';
GO

-------------------------------------------------------------------------------
-- 1) DROP TABLE IF IT EXISTS
-------------------------------------------------------------------------------
IF OBJECT_ID('dbo.OG_WELLBORE_EWA', 'U') IS NOT NULL
    DROP TABLE dbo.OG_WELLBORE_EWA;
GO

-------------------------------------------------------------------------------
-- 2) CREATE TABLE
-------------------------------------------------------------------------------
CREATE TABLE [dbo].[OG_WELLBORE_EWA]
(
    DISTRICT_CODE                SMALLINT,         -- (1) DISTRICT (a.k.a. DISTRICT_CODE)
    COUNTY_CODE                  SMALLINT,         -- (2) COUNTY_CODE
    API_NO                       VARCHAR(8),       -- (3) API_NO (8-digit number stored by RRC)
    COUNTY_NAME                  VARCHAR(50),      -- (4) COUNTY_NAME
    OIL_GAS_CODE                 CHAR(1),          -- (5) OIL_GAS_CODE
    LEASE_NAME                   VARCHAR(32),      -- (6) LEASE_NAME
    FIELD_NUMBER                 VARCHAR(8),       -- (7) FIELD_NUMBER
    FIELD_NAME                   VARCHAR(64),      -- (8) FIELD_NAME
    LEASE_NUMBER                 VARCHAR(10),      -- (9) LEASE_NUMBER
    WELL_NO_DISPLAY              VARCHAR(25),      -- (10) WELL_NO_DISPLAY
    OIL_UNIT_NUMBER              VARCHAR(20),      -- (11) OIL_UNIT_NUMBER
    OPERATOR_NAME                VARCHAR(80),      -- (12) OPERATOR_NAME
    OPERATOR_NUMBER              CHAR(6),          -- (13) OPERATOR_NUMBER
    WB_WATER_LAND_CODE           CHAR(1),          -- (14) WB_WATER_LAND_CODE
    MULTI_COMP_FLAG              CHAR(1),          -- (15) MULTI_COMP_FLAG
    API_DEPTH                    NUMERIC(9,2),     -- (16) API_DEPTH
    WB_SHUT_IN_DATE              DATE,             -- (17) WB_SHUT_IN_DATE
    WB_14B2_FLAG                 CHAR(1),          -- (18) WB_14B2_FLAG
    WELL_TYPE_NAME               VARCHAR(50),      -- (19) WELL_TYPE_NAME
    WL_SHUT_IN_DATE              DATE,             -- (20) WL_SHUT_IN_DATE
    PLUG_DATE                    DATE,             -- (21) PLUG_DATE
    PLUG_LEASE_NAME              VARCHAR(32),      -- (22) PLUG_LEASE_NAME
    PLUG_OPERATOR_NAME           VARCHAR(80),      -- (23) PLUG_OPERATOR_NAME
    RECENT_PERMIT                VARCHAR(10),      -- (24) RECENT_PERMIT
    RECENT_PERMIT_LEASE_NAME     VARCHAR(32),      -- (25) RECENT_PERMIT_LEASE_NAME
    RECENT_PERMIT_OPERATOR_NO    CHAR(6),          -- (26) RECENT_PERMIT_OPERATOR_NO
    ON_SCHEDULE                  CHAR(1),          -- (27) ON_SCHEDULE
    OG_WELLBORE_EWA_ID           INT,              -- (28) OG_WELLBORE_EWA_ID
    W2_G1_FILED_DATE             DATE,             -- (29) W2-G1_FILED_DATE
    W2_G1_DATE                   DATE,             -- (30) W2_G1_DATE
    COMPLETION_DATE              DATE,             -- (31) COMPLETION_DATE
    W3_FILE_DATE                 DATE,             -- (32) W3_FILE_DATE
    CREATED_BY                   VARCHAR(32),      -- (33) CREATED_BY
    CREATED_DT                   DATETIME,         -- (34) CREATED_DT
    MODIFIED_BY                  VARCHAR(32),      -- (35) MODIFIED_BY
    MODIFIED_DT                  DATETIME,         -- (36) MODIFIED_DT
    WELL_NO                      VARCHAR(25),      -- (37) WELL_NO
    P5_RENEWAL_MONTH             TINYINT,          -- (38) P5_RENEWAL_MONTH
    P5_RENEWAL_YEAR              SMALLINT,         -- (39) P5_RENEWAL_YEAR
    P5_ORG_STATUS                CHAR(1),          -- (40) P5_ORG_STATUS (A, D, X, etc.)
    CURR_INACT_YRS               INT,              -- (41) CURR_INACT_YRS
    CURR_INACT_MOS               INT,              -- (42) CURR_INACT_MOS
    WL_14B2_EXT_STATUS           CHAR(1),          -- (43) WL_14B2_EXT_STATUS
    WL_14B2_MECH_INTEG           CHAR(1),          -- (44) WL_14B2_MECH_INTEG
    WL_14B2_PLG_ORD_SF           CHAR(1),          -- (45) WL_14B2_PLG_ORD_SF
    WL_14B2_POLLUTION            CHAR(1),          -- (46) WL_14B2_POLLUTION
    WL_14B2_FLDOPS_HOLD          CHAR(1),          -- (47) WL_14B2_FLDOPS_HOLD
    WL_14B2_H15_PROB             CHAR(1),          -- (48) WL_14B2_H15_PROB
    WL_14B2_H15_DELQ             CHAR(1),          -- (49) WL_14B2_H15_DELQ
    WL_14B2_OPER_DELQ            CHAR(1),          -- (50) WL_14B2_OPER_DELQ
    WL_14B2_DIST_SFP             CHAR(1),          -- (51) WL_14B2_DIST_SFP
    WL_14B2_DIST_SF_CLNUP        CHAR(1),          -- (52) WL_14B2_DIST_SF_CLNUP
    WL_14B2_DIST_ST_PLG          CHAR(1),          -- (53) WL_14B2_DIST_ST_PLG
    WL_14B2_GOOD_FAITH           CHAR(1),          -- (54) WL_14B2_GOOD_FAITH
    WL_14B2_WELL_OTHER           CHAR(1),          -- (55) WL_14B2_WELL_OTHER
    SURF_EQP_VIOL                CHAR(1),          -- (56) SURF_EQP_VIOL
    W3X_VIOL                     CHAR(1),          -- (57) W3X_VIOL
    H15_STATUS_CODE              CHAR(1),          -- (58) H15_STATUS_CODE
    ORIG_COMPLETION_DT           DATE              -- (59) ORIG_COMPLETION_DT
);
GO

-------------------------------------------------------------------------------
-- 3) ADD EXTENDED PROPERTIES
--    Table-level description
-------------------------------------------------------------------------------
EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'OG_WELLBORE_EWA: Table containing Oil & Gas wellbore data from the RRC Online Wellbore Query',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA';
GO

-------------------------------------------------------------------------------
-- Column-level descriptions
-- Each column uses the "Data Field Name" (and short summary) from the PDF
-------------------------------------------------------------------------------
EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(1) RRC District number',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'DISTRICT_CODE';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(2) Unique ID assigned to the county',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'COUNTY_CODE';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(3) 8-digit API well number (RRC-stored)',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'API_NO';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(4) Name of the county where well is located',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'COUNTY_NAME';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(5) Code indicating Oil (O) or Gas (G)',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'OIL_GAS_CODE';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(6) Lease name (up to 32 chars)',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'LEASE_NAME';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(7) RRC Field number (8-digit)',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'FIELD_NUMBER';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(8) Name of the field where well is located',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'FIELD_NAME';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(9) Lease number (oil lease# or gas well ID)',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'LEASE_NUMBER';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(10) Display version of the well number',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WELL_NO_DISPLAY';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(11) Oil unit number for a multi-well group',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'OIL_UNIT_NUMBER';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(12) Operator of record name',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'OPERATOR_NAME';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(13) Operator number (6-digit)',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'OPERATOR_NUMBER';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(14) Code defining water/land location (L, O, B, etc.)',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WB_WATER_LAND_CODE';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(15) Multi Completion Flag (indicates >1 completion)',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'MULTI_COMP_FLAG';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(16) Total well depth',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'API_DEPTH';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(17) Date wellbore became shut in',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WB_SHUT_IN_DATE';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(18) Flag if well is inactive (subject to 14B2)',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WB_14B2_FLAG';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(19) Current well type (e.g., PRODUCING, SHUT IN)',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WELL_TYPE_NAME';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(20) Year/month well is no longer producing',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WL_SHUT_IN_DATE';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(21) Date well is plugged',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'PLUG_DATE';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(22) Lease name at time of plugging',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'PLUG_LEASE_NAME';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(23) Operator name at time of plugging',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'PLUG_OPERATOR_NAME';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(24) Most recent drilling permit number',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'RECENT_PERMIT';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(25) Lease name from most recent drilling permit',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'RECENT_PERMIT_LEASE_NAME';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(26) Operator number from most recent drilling permit',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'RECENT_PERMIT_OPERATOR_NO';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(27) On or off proration schedule',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'ON_SCHEDULE';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(28) Unique row identifier',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'OG_WELLBORE_EWA_ID';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(29) Date the W-2/G-1 was filed',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'W2_G1_FILED_DATE';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(30) Date the W-2 or G-1 was received',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'W2_G1_DATE';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(31) Most recent date completion forms (W-2/G-1) completed',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'COMPLETION_DATE';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(32) Date the W-3 Plugging Report was filed',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'W3_FILE_DATE';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(33) Last user or process that created the row (e.g., EWA Wellbore Ld)',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'CREATED_BY';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(34) Date/time the row was created',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'CREATED_DT';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(35) Last user or process that modified the row',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'MODIFIED_BY';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(36) Date/time the row was last modified',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'MODIFIED_DT';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(37) Alphanumeric well number',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WELL_NO';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(38) The P5 renewal month',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'P5_RENEWAL_MONTH';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(39) The P5 renewal year',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'P5_RENEWAL_YEAR';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(40) The status of the P5 organization (A, D, X, etc.)',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'P5_ORG_STATUS';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(41) Years the well has been inactive',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'CURR_INACT_YRS';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(42) Months the well has been inactive',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'CURR_INACT_MOS';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(43) Status of a Rule 14(B)(2) extension',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WL_14B2_EXT_STATUS';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(44) Mechanical integrity violation indicator',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WL_14B2_MECH_INTEG';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(45) Plugging order SF hold violation indicator',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WL_14B2_PLG_ORD_SF';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(46) Pollution violation indicator',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WL_14B2_POLLUTION';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(47) Field operations hold violation indicator',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WL_14B2_FLDOPS_HOLD';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(48) H15 form problem indicator',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WL_14B2_H15_PROB';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(49) H15 form delinquency indicator',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WL_14B2_H15_DELQ';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(50) Operator delinquency indicator',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WL_14B2_OPER_DELQ';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(51) District SFP hold violation indicator',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WL_14B2_DIST_SFP';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(52) District SF Cleanup violation indicator',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WL_14B2_DIST_SF_CLNUP';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(53) District state plugging violation indicator',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WL_14B2_DIST_ST_PLG';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(54) Good Faith violation indicator',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WL_14B2_GOOD_FAITH';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(55) Other well violation indicator',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'WL_14B2_WELL_OTHER';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(56) Surface equipment removal violation (W-3C)',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'SURF_EQP_VIOL';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(57) Plugging violation (W-3X) indicator',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'W3X_VIOL';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(58) Status code for H15 form (e.g., A, C, D, N)',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'H15_STATUS_CODE';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'(59) Oldest completion date on file, if recorded',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table',  @level1name = 'OG_WELLBORE_EWA',
    @level2type = N'Column', @level2name = 'ORIG_COMPLETION_DT';

GO

-- Drop the table if it already exists
IF OBJECT_ID('dbo.ImportProgress', 'U') IS NOT NULL
    DROP TABLE dbo.ImportProgress;
GO

-- Create the table with ID as the primary key and an index on (SessionID, FileName)
CREATE TABLE ImportProgress (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    SessionID VARCHAR(50) NOT NULL,
    FileName NVARCHAR(255) NOT NULL,
    Status NVARCHAR(50) CHECK (Status IN ('Pending', 'In Progress', 'Completed', 'Failed')) NOT NULL,
    Progress DECIMAL(5,2) CHECK (Progress BETWEEN 0 AND 100) NOT NULL DEFAULT 0,
    StartTime DATETIME2 NULL,
    EndTime DATETIME2 NULL,
    CreatedAt DATETIME2 DEFAULT SYSDATETIME(),
    UpdatedAt DATETIME2 DEFAULT SYSDATETIME()
);

-- Create a composite index on SessionID and FileName
CREATE INDEX IDX_ImportProgress_SessionID_FileName ON ImportProgress(SessionID, FileName);


-- Drop the view if it already exists
IF OBJECT_ID('dbo.VW_ImportProgress', 'V') IS NOT NULL
    DROP VIEW dbo.VW_ImportProgress;
GO

-- Create the view
CREATE VIEW dbo.VW_ImportProgress AS
SELECT 
    [ID],
    [SessionID],
    [FileName],
    [Progress],
    DATEDIFF(MINUTE, StartTime, ISNULL(EndTime, UpdatedAt)) AS DurationInMinutes,
    
    -- Predict Completion Time
    CASE 
        WHEN Progress > 0 THEN DATEADD(SECOND, 
                DATEDIFF(SECOND, StartTime, ISNULL(EndTime, UpdatedAt)) * (100 - Progress) / Progress, 
                ISNULL(EndTime, UpdatedAt))
        ELSE NULL 
    END AS EstimatedCompletionTime,
    
    [Status],
    [StartTime],
    [EndTime],
    [CreatedAt],
    [UpdatedAt]
FROM 
    [dbo].[ImportProgress];
GO




-- ==============================================================================================
-- END OF SCRIPT
-- ==============================================================================================
