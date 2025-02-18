CREATE OR REPLACE PROCEDURE SP_LOAD_GOLD_DIMENSIONS()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    -- Load Gold Calendar Dimension
    INSERT INTO GOLD.CALENDAR_DIM
    SELECT
        CAL_DT,
        CAL_TYPE_DESC AS CAL_TYPE_NAME,
        DAY_OF_WK_NUM,
        YR_NUM AS YEAR_NUM,
        WK_NUM AS WEEK_NUM,
        YR_WK_NUM AS YEAR_WK_NUM,
        MNTH_NUM AS MONTH_NUM,
        YR_MNTH_NUM AS YEAR_MONTH_NUM,
        QTR_NUM,
        YR_QTR_NUM,
        CURRENT_TIMESTAMP() AS DW_CREATED_AT
    FROM SILVER.CALENDAR_DIM;
    -- Load Gold Store Dimension
    INSERT INTO GOLD.STORE_DIM
    SELECT
        STORE_KEY,
        STORE_NUM,
        STORE_DESC,
        ADDR,
        CITY,
        REGION,
        CNTRY_CD,
        CNTRY_NM,
        POSTAL_ZIP_CD,
        PROV_STATE_DESC AS PROV_NAME,    -- renaming column here
        PROV_STATE_CD AS PROV_CODE,      -- renaming column here
        STORE_TYPE_CD,
        STORE_TYPE_DESC,
        MARKET_KEY,
        MARKET_NAME,
        SUBMARKET_KEY,
        SUBMARKET_NAME,
        LATITUDE,
        LONGITUDE,
        CURRENT_TIMESTAMP() AS DW_CREATED_AT
    FROM SILVER.STORE_DIM;
    -- Load Gold Product Dimension
    INSERT INTO GOLD.PRODUCT_DIM
    SELECT
        PROD_KEY,
        PROD_NAME,
        VOLUME,       -- same name in source and target (Silver column VOLUME becomes target VOLUME)
        WEIGHT,       -- same for WEIGHT
        BRAND_NAME,
        STATUS_CODE,
        STATUS_CODE_NAME,
        CATEGORY_KEY,
        CATEGORY_NAME,
        SUBCATEGORY_KEY,
        SUBCATEGORY_NAME,
        CURRENT_TIMESTAMP() AS DW_CREATED_AT
    FROM SILVER.PRODUCT_DIM;
    RETURN 'Gold Dimensions Loaded Successfully';
END;
$$;