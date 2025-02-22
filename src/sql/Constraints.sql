BEGIN TRANSACTION;

--------------------------------------------------------------------------------
-- 1) Define (or Alter) PRIMARY KEYS on Dimension / Lookup tables
--------------------------------------------------------------------------------

-- Example PK on GP_COUNTY
IF NOT EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'PK_GP_COUNTY'
      AND object_id = OBJECT_ID('dbo.GP_COUNTY')
)
BEGIN
    ALTER TABLE dbo.GP_COUNTY
    ADD CONSTRAINT PK_GP_COUNTY
        PRIMARY KEY (COUNTY_NO);
END;

-- Example PK on GP_DISTRICT
IF NOT EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'PK_GP_DISTRICT'
      AND object_id = OBJECT_ID('dbo.GP_DISTRICT')
)
BEGIN
    ALTER TABLE dbo.GP_DISTRICT
    ADD CONSTRAINT PK_GP_DISTRICT
        PRIMARY KEY (DISTRICT_NO);
END;

-- Example PK on OG_OPERATOR_DW
IF NOT EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'PK_OG_OPERATOR_DW'
      AND object_id = OBJECT_ID('dbo.OG_OPERATOR_DW')
)
BEGIN
    ALTER TABLE dbo.OG_OPERATOR_DW
    ADD CONSTRAINT PK_OG_OPERATOR_DW
        PRIMARY KEY (OPERATOR_NO);
END;

-- Example PK on OG_FIELD_DW
IF NOT EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'PK_OG_FIELD_DW'
      AND object_id = OBJECT_ID('dbo.OG_FIELD_DW')
)
BEGIN
    ALTER TABLE dbo.OG_FIELD_DW
    ADD CONSTRAINT PK_OG_FIELD_DW
        PRIMARY KEY (FIELD_NO);
END;

-- Example PK on OG_REGULATORY_LEASE_DW (composite: OIL_GAS_CODE + DISTRICT_NO + LEASE_NO)
IF NOT EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'PK_OG_REG_LEASE'
      AND object_id = OBJECT_ID('dbo.OG_REGULATORY_LEASE_DW')
)
BEGIN
    ALTER TABLE dbo.OG_REGULATORY_LEASE_DW
    ADD CONSTRAINT PK_OG_REG_LEASE
        PRIMARY KEY (OIL_GAS_CODE, DISTRICT_NO, LEASE_NO);
END;

--------------------------------------------------------------------------------
-- 2) Add FOREIGN KEY Constraints to Fact / Transaction Tables
--------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- 2.1 OG_COUNTY_CYCLE
-------------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_COUNTY_CYCLE_COUNTY'
      AND parent_object_id = OBJECT_ID('dbo.OG_COUNTY_CYCLE')
)
BEGIN
    ALTER TABLE dbo.OG_COUNTY_CYCLE
    ADD CONSTRAINT FK_OG_COUNTY_CYCLE_COUNTY
        FOREIGN KEY (COUNTY_NO)
        REFERENCES dbo.GP_COUNTY (COUNTY_NO);
END;

IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_COUNTY_CYCLE_DISTRICT'
      AND parent_object_id = OBJECT_ID('dbo.OG_COUNTY_CYCLE')
)
BEGIN
    ALTER TABLE dbo.OG_COUNTY_CYCLE
    ADD CONSTRAINT FK_OG_COUNTY_CYCLE_DISTRICT
        FOREIGN KEY (DISTRICT_NO)
        REFERENCES dbo.GP_DISTRICT (DISTRICT_NO);
END;

-------------------------------------------------------------------------------
-- 2.2 OG_COUNTY_LEASE_CYCLE
-------------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_CTY_LSE_CYCLE_COUNTY'
      AND parent_object_id = OBJECT_ID('dbo.OG_COUNTY_LEASE_CYCLE')
)
BEGIN
    ALTER TABLE dbo.OG_COUNTY_LEASE_CYCLE
    ADD CONSTRAINT FK_OG_CTY_LSE_CYCLE_COUNTY
        FOREIGN KEY (COUNTY_NO)
        REFERENCES dbo.GP_COUNTY (COUNTY_NO);
END;

IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_CTY_LSE_CYCLE_DISTRICT'
      AND parent_object_id = OBJECT_ID('dbo.OG_COUNTY_LEASE_CYCLE')
)
BEGIN
    ALTER TABLE dbo.OG_COUNTY_LEASE_CYCLE
    ADD CONSTRAINT FK_OG_CTY_LSE_CYCLE_DISTRICT
        FOREIGN KEY (DISTRICT_NO)
        REFERENCES dbo.GP_DISTRICT (DISTRICT_NO);
END;

-- Tie to the lease dimension (composite key)
IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_CTY_LSE_CYCLE_REG_LEASE'
      AND parent_object_id = OBJECT_ID('dbo.OG_COUNTY_LEASE_CYCLE')
)
BEGIN
    ALTER TABLE dbo.OG_COUNTY_LEASE_CYCLE
    ADD CONSTRAINT FK_OG_CTY_LSE_CYCLE_REG_LEASE
        FOREIGN KEY (OIL_GAS_CODE, DISTRICT_NO, LEASE_NO)
        REFERENCES dbo.OG_REGULATORY_LEASE_DW (OIL_GAS_CODE, DISTRICT_NO, LEASE_NO);
END;

-------------------------------------------------------------------------------
-- 2.3 OG_DISTRICT_CYCLE
-------------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_DISTRICT_CYCLE_DISTRICT'
      AND parent_object_id = OBJECT_ID('dbo.OG_DISTRICT_CYCLE')
)
BEGIN
    ALTER TABLE dbo.OG_DISTRICT_CYCLE
    ADD CONSTRAINT FK_OG_DISTRICT_CYCLE_DISTRICT
        FOREIGN KEY (DISTRICT_NO)
        REFERENCES dbo.GP_DISTRICT (DISTRICT_NO);
END;

-------------------------------------------------------------------------------
-- 2.4 OG_FIELD_CYCLE
-------------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_FIELD_CYCLE_DISTRICT'
      AND parent_object_id = OBJECT_ID('dbo.OG_FIELD_CYCLE')
)
BEGIN
    ALTER TABLE dbo.OG_FIELD_CYCLE
    ADD CONSTRAINT FK_OG_FIELD_CYCLE_DISTRICT
        FOREIGN KEY (DISTRICT_NO)
        REFERENCES dbo.GP_DISTRICT (DISTRICT_NO);
END;

IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_FIELD_CYCLE_FIELD'
      AND parent_object_id = OBJECT_ID('dbo.OG_FIELD_CYCLE')
)
BEGIN
    ALTER TABLE dbo.OG_FIELD_CYCLE
    ADD CONSTRAINT FK_OG_FIELD_CYCLE_FIELD
        FOREIGN KEY (FIELD_NO)
        REFERENCES dbo.OG_FIELD_DW (FIELD_NO);
END;

-------------------------------------------------------------------------------
-- 2.5 OG_LEASE_CYCLE
-------------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_LEASE_CYCLE_DISTRICT'
      AND parent_object_id = OBJECT_ID('dbo.OG_LEASE_CYCLE')
)
BEGIN
    ALTER TABLE dbo.OG_LEASE_CYCLE
    ADD CONSTRAINT FK_OG_LEASE_CYCLE_DISTRICT
        FOREIGN KEY (DISTRICT_NO)
        REFERENCES dbo.GP_DISTRICT (DISTRICT_NO);
END;

IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_LEASE_CYCLE_REG_LEASE'
      AND parent_object_id = OBJECT_ID('dbo.OG_LEASE_CYCLE')
)
BEGIN
    ALTER TABLE dbo.OG_LEASE_CYCLE
    ADD CONSTRAINT FK_OG_LEASE_CYCLE_REG_LEASE
        FOREIGN KEY (OIL_GAS_CODE, DISTRICT_NO, LEASE_NO)
        REFERENCES dbo.OG_REGULATORY_LEASE_DW (OIL_GAS_CODE, DISTRICT_NO, LEASE_NO);
END;

IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_LEASE_CYCLE_OPERATOR'
      AND parent_object_id = OBJECT_ID('dbo.OG_LEASE_CYCLE')
)
BEGIN
    ALTER TABLE dbo.OG_LEASE_CYCLE
    ADD CONSTRAINT FK_OG_LEASE_CYCLE_OPERATOR
        FOREIGN KEY (OPERATOR_NO)
        REFERENCES dbo.OG_OPERATOR_DW (OPERATOR_NO);
END;

IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_LEASE_CYCLE_FIELD'
      AND parent_object_id = OBJECT_ID('dbo.OG_LEASE_CYCLE')
)
BEGIN
    ALTER TABLE dbo.OG_LEASE_CYCLE
    ADD CONSTRAINT FK_OG_LEASE_CYCLE_FIELD
        FOREIGN KEY (FIELD_NO)
        REFERENCES dbo.OG_FIELD_DW (FIELD_NO);
END;

-------------------------------------------------------------------------------
-- 2.6 OG_LEASE_CYCLE_DISP
-------------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_LEASE_CYCLE_DISP_DISTRICT'
      AND parent_object_id = OBJECT_ID('dbo.OG_LEASE_CYCLE_DISP')
)
BEGIN
    ALTER TABLE dbo.OG_LEASE_CYCLE_DISP
    ADD CONSTRAINT FK_OG_LEASE_CYCLE_DISP_DISTRICT
        FOREIGN KEY (DISTRICT_NO)
        REFERENCES dbo.GP_DISTRICT (DISTRICT_NO);
END;

IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_LEASE_CYCLE_DISP_REG_LEASE'
      AND parent_object_id = OBJECT_ID('dbo.OG_LEASE_CYCLE_DISP')
)
BEGIN
    ALTER TABLE dbo.OG_LEASE_CYCLE_DISP
    ADD CONSTRAINT FK_OG_LEASE_CYCLE_DISP_REG_LEASE
        FOREIGN KEY (OIL_GAS_CODE, DISTRICT_NO, LEASE_NO)
        REFERENCES dbo.OG_REGULATORY_LEASE_DW (OIL_GAS_CODE, DISTRICT_NO, LEASE_NO);
END;

-------------------------------------------------------------------------------
-- 2.7 OG_OPERATOR_CYCLE
-------------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_OPERATOR_CYCLE_OPERATOR'
      AND parent_object_id = OBJECT_ID('dbo.OG_OPERATOR_CYCLE')
)
BEGIN
    ALTER TABLE dbo.OG_OPERATOR_CYCLE
    ADD CONSTRAINT FK_OG_OPERATOR_CYCLE_OPERATOR
        FOREIGN KEY (OPERATOR_NO)
        REFERENCES dbo.OG_OPERATOR_DW (OPERATOR_NO);
END;

-------------------------------------------------------------------------------
-- 2.8 OG_SUMMARY_MASTER_LARGE
-------------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_SUMMLG_DISTRICT'
      AND parent_object_id = OBJECT_ID('dbo.OG_SUMMARY_MASTER_LARGE')
)
BEGIN
    ALTER TABLE dbo.OG_SUMMARY_MASTER_LARGE
    ADD CONSTRAINT FK_OG_SUMMLG_DISTRICT
        FOREIGN KEY (DISTRICT_NO)
        REFERENCES dbo.GP_DISTRICT (DISTRICT_NO);
END;

IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_SUMMLG_REG_LEASE'
      AND parent_object_id = OBJECT_ID('dbo.OG_SUMMARY_MASTER_LARGE')
)
BEGIN
    ALTER TABLE dbo.OG_SUMMARY_MASTER_LARGE
    ADD CONSTRAINT FK_OG_SUMMLG_REG_LEASE
        FOREIGN KEY (OIL_GAS_CODE, DISTRICT_NO, LEASE_NO)
        REFERENCES dbo.OG_REGULATORY_LEASE_DW (OIL_GAS_CODE, DISTRICT_NO, LEASE_NO);
END;

IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_SUMMLG_OPERATOR'
      AND parent_object_id = OBJECT_ID('dbo.OG_SUMMARY_MASTER_LARGE')
)
BEGIN
    ALTER TABLE dbo.OG_SUMMARY_MASTER_LARGE
    ADD CONSTRAINT FK_OG_SUMMLG_OPERATOR
        FOREIGN KEY (OPERATOR_NO)
        REFERENCES dbo.OG_OPERATOR_DW (OPERATOR_NO);
END;

IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_SUMMLG_FIELD'
      AND parent_object_id = OBJECT_ID('dbo.OG_SUMMARY_MASTER_LARGE')
)
BEGIN
    ALTER TABLE dbo.OG_SUMMARY_MASTER_LARGE
    ADD CONSTRAINT FK_OG_SUMMLG_FIELD
        FOREIGN KEY (FIELD_NO)
        REFERENCES dbo.OG_FIELD_DW (FIELD_NO);
END;

-------------------------------------------------------------------------------
-- 2.9 OG_SUMMARY_ONSHORE_LEASE
-------------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_SUMMONSHR_DISTRICT'
      AND parent_object_id = OBJECT_ID('dbo.OG_SUMMARY_ONSHORE_LEASE')
)
BEGIN
    ALTER TABLE dbo.OG_SUMMARY_ONSHORE_LEASE
    ADD CONSTRAINT FK_OG_SUMMONSHR_DISTRICT
        FOREIGN KEY (DISTRICT_NO)
        REFERENCES dbo.GP_DISTRICT (DISTRICT_NO);
END;

IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_SUMMONSHR_REG_LEASE'
      AND parent_object_id = OBJECT_ID('dbo.OG_SUMMARY_ONSHORE_LEASE')
)
BEGIN
    ALTER TABLE dbo.OG_SUMMARY_ONSHORE_LEASE
    ADD CONSTRAINT FK_OG_SUMMONSHR_REG_LEASE
        FOREIGN KEY (OIL_GAS_CODE, DISTRICT_NO, LEASE_NO)
        REFERENCES dbo.OG_REGULATORY_LEASE_DW (OIL_GAS_CODE, DISTRICT_NO, LEASE_NO);
END;

IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_SUMMONSHR_OPERATOR'
      AND parent_object_id = OBJECT_ID('dbo.OG_SUMMARY_ONSHORE_LEASE')
)
BEGIN
    ALTER TABLE dbo.OG_SUMMARY_ONSHORE_LEASE
    ADD CONSTRAINT FK_OG_SUMMONSHR_OPERATOR
        FOREIGN KEY (OPERATOR_NO)
        REFERENCES dbo.OG_OPERATOR_DW (OPERATOR_NO);
END;

IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_SUMMONSHR_FIELD'
      AND parent_object_id = OBJECT_ID('dbo.OG_SUMMARY_ONSHORE_LEASE')
)
BEGIN
    ALTER TABLE dbo.OG_SUMMARY_ONSHORE_LEASE
    ADD CONSTRAINT FK_OG_SUMMONSHR_FIELD
        FOREIGN KEY (FIELD_NO)
        REFERENCES dbo.OG_FIELD_DW (FIELD_NO);
END;

-------------------------------------------------------------------------------
-- 2.10 OG_WELL_COMPLETION
-------------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_OG_WELL_COMPLETION_DISTRICT'
      AND parent_object_id = OBJECT_ID('dbo.OG_WELL_COMPLETION')
)
BEGIN
    ALTER TABLE dbo.OG_WELL_COMPLETION
    ADD CONSTRAINT FK_OG_WELL_COMPLETION_DISTRICT
        FOREIGN KEY (DISTRICT_NO)
        REFERENCES dbo.GP_DISTRICT (DISTRICT_NO);
END;

-- Optionally link well completions to county or regulatory lease dimension
-- (Uncomment if relevant; note that the county reference must align with the columns used.)
/*
ALTER TABLE dbo.OG_WELL_COMPLETION
ADD CONSTRAINT FK_OG_WELL_COMPLETION_COUNTY
    FOREIGN KEY (API_COUNTY_CODE)
    REFERENCES dbo.GP_COUNTY (COUNTY_NO);

ALTER TABLE dbo.OG_WELL_COMPLETION
ADD CONSTRAINT FK_OG_WELL_COMPLETION_REG_LEASE
    FOREIGN KEY (OIL_GAS_CODE, DISTRICT_NO, LEASE_NO)
    REFERENCES dbo.OG_REGULATORY_LEASE_DW (OIL_GAS_CODE, DISTRICT_NO, LEASE_NO);
*/

COMMIT TRANSACTION;
