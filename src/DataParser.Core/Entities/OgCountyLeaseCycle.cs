using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class OgCountyLeaseCycle
    {
        public string OilGasCode { get; set; }
        public string DistrictNo { get; set; }
        public string LeaseNo { get; set; }
        public string CycleYear { get; set; }
        public string CycleMonth { get; set; }
        public string CountyNo { get; set; }
        public string OperatorNo { get; set; }
        public string FieldNo { get; set; }
        public string CycleYearMonth { get; set; }
        public string FieldType { get; set; }
        public string GasWellNo { get; set; }
        public string ProdReportFiledFlag { get; set; }
        public int? CntyLseOilProdVol { get; set; }
        public int? CntyLseOilAllow { get; set; }
        public int? CntyLseOilEndingBal { get; set; }
        public int? CntyLseGasProdVol { get; set; }
        public int? CntyLseGasAllow { get; set; }
        public int? CntyLseGasLiftInjVol { get; set; }
        public int? CntyLseCondProdVol { get; set; }
        public int? CntyLseCondLimit { get; set; }
        public int? CntyLseCondEndingBal { get; set; }
        public int? CntyLseCsgdProdVol { get; set; }
        public int? CntyLseCsgdLimit { get; set; }
        public int? CntyLseCsgdGasLift { get; set; }
        public int? CntyLseOilTotDisp { get; set; }
        public int? CntyLseGasTotDisp { get; set; }
        public int? CntyLseCondTotDisp { get; set; }
        public int? CntyLseCsgdTotDisp { get; set; }
        public string DistrictName { get; set; }
        public string LeaseName { get; set; }
        public string OperatorName { get; set; }
        public string FieldName { get; set; }
        public string CountyName { get; set; }

        /// <summary>
        /// Creates a new OgCountyLeaseCycle instance by splitting the input text using the provided separator.
        /// The default separator is '}'.
        /// Expected order of fields (33 total):
        ///  0  - OIL_GAS_CODE
        ///  1  - DISTRICT_NO
        ///  2  - LEASE_NO
        ///  3  - CYCLE_YEAR
        ///  4  - CYCLE_MONTH
        ///  5  - COUNTY_NO
        ///  6  - OPERATOR_NO
        ///  7  - FIELD_NO
        ///  8  - CYCLE_YEAR_MONTH
        ///  9  - FIELD_TYPE
        /// 10  - GAS_WELL_NO
        /// 11  - PROD_REPORT_FILED_FLAG
        /// 12  - CNTY_LSE_OIL_PROD_VOL
        /// 13  - CNTY_LSE_OIL_ALLOW
        /// 14  - CNTY_LSE_OIL_ENDING_BAL
        /// 15  - CNTY_LSE_GAS_PROD_VOL
        /// 16  - CNTY_LSE_GAS_ALLOW
        /// 17  - CNTY_LSE_GAS_LIFT_INJ_VOL
        /// 18  - CNTY_LSE_COND_PROD_VOL
        /// 19  - CNTY_LSE_COND_LIMIT
        /// 20  - CNTY_LSE_COND_ENDING_BAL
        /// 21  - CNTY_LSE_CSGD_PROD_VOL
        /// 22  - CNTY_LSE_CSGD_LIMIT
        /// 23  - CNTY_LSE_CSGD_GAS_LIFT
        /// 24  - CNTY_LSE_OIL_TOT_DISP
        /// 25  - CNTY_LSE_GAS_TOT_DISP
        /// 26  - CNTY_LSE_COND_TOT_DISP
        /// 27  - CNTY_LSE_CSGD_TOT_DISP
        /// 28  - DISTRICT_NAME
        /// 29  - LEASE_NAME
        /// 30  - OPERATOR_NAME
        /// 31  - FIELD_NAME
        /// 32  - COUNTY_NAME
        /// </summary>
        public static OgCountyLeaseCycle CreateFromText(string text, string separator = "}")
        {
            if (string.IsNullOrEmpty(text))
                throw new System.ArgumentNullException(nameof(text), "Input text cannot be null or empty.");

            var parts = text.Split(new[] { separator }, System.StringSplitOptions.None);
            if (parts.Length < 33)
            {
                throw new System.ArgumentException(
                    $"Insufficient fields in input text. Expected at least 33 fields separated by '{separator}'.");
            }

            for (int i = 0; i < parts.Length; i++)
            {
                parts[i] = parts[i].Trim();
            }

            return new OgCountyLeaseCycle
            {
                OilGasCode = parts[0],
                DistrictNo = parts[1],
                LeaseNo = parts[2],
                CycleYear = parts[3],
                CycleMonth = parts[4],
                CountyNo = parts[5],
                OperatorNo = parts[6],
                FieldNo = parts[7],
                CycleYearMonth = parts[8],
                FieldType = parts[9],
                GasWellNo = parts[10],
                ProdReportFiledFlag = parts[11],
                CntyLseOilProdVol = ParseInt(parts[12]),
                CntyLseOilAllow = ParseInt(parts[13]),
                CntyLseOilEndingBal = ParseInt(parts[14]),
                CntyLseGasProdVol = ParseInt(parts[15]),
                CntyLseGasAllow = ParseInt(parts[16]),
                CntyLseGasLiftInjVol = ParseInt(parts[17]),
                CntyLseCondProdVol = ParseInt(parts[18]),
                CntyLseCondLimit = ParseInt(parts[19]),
                CntyLseCondEndingBal = ParseInt(parts[20]),
                CntyLseCsgdProdVol = ParseInt(parts[21]),
                CntyLseCsgdLimit = ParseInt(parts[22]),
                CntyLseCsgdGasLift = ParseInt(parts[23]),
                CntyLseOilTotDisp = ParseInt(parts[24]),
                CntyLseGasTotDisp = ParseInt(parts[25]),
                CntyLseCondTotDisp = ParseInt(parts[26]),
                CntyLseCsgdTotDisp = ParseInt(parts[27]),
                DistrictName = parts[28],
                LeaseName = parts[29],
                OperatorName = parts[30],
                FieldName = parts[31],
                CountyName = parts[32]
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the OG_COUNTY_LEASE_CYCLE table using the current property values.
        /// </summary>
        public string ToSqlInsert()
        {
            string valOilProdVol = FormatInt(CntyLseOilProdVol);
            string valOilAllow = FormatInt(CntyLseOilAllow);
            string valOilEndingBal = FormatInt(CntyLseOilEndingBal);
            string valGasProdVol = FormatInt(CntyLseGasProdVol);
            string valGasAllow = FormatInt(CntyLseGasAllow);
            string valGasLiftInjVol = FormatInt(CntyLseGasLiftInjVol);
            string valCondProdVol = FormatInt(CntyLseCondProdVol);
            string valCondLimit = FormatInt(CntyLseCondLimit);
            string valCondEndingBal = FormatInt(CntyLseCondEndingBal);
            string valCsgdProdVol = FormatInt(CntyLseCsgdProdVol);
            string valCsgdLimit = FormatInt(CntyLseCsgdLimit);
            string valCsgdGasLift = FormatInt(CntyLseCsgdGasLift);
            string valOilTotDisp = FormatInt(CntyLseOilTotDisp);
            string valGasTotDisp = FormatInt(CntyLseGasTotDisp);
            string valCondTotDisp = FormatInt(CntyLseCondTotDisp);
            string valCsgdTotDisp = FormatInt(CntyLseCsgdTotDisp);

            return $@"
INSERT INTO OG_COUNTY_LEASE_CYCLE
(
    OIL_GAS_CODE,
    DISTRICT_NO,
    LEASE_NO,
    CYCLE_YEAR,
    CYCLE_MONTH,
    COUNTY_NO,
    OPERATOR_NO,
    FIELD_NO,
    CYCLE_YEAR_MONTH,
    FIELD_TYPE,
    GAS_WELL_NO,
    PROD_REPORT_FILED_FLAG,
    CNTY_LSE_OIL_PROD_VOL,
    CNTY_LSE_OIL_ALLOW,
    CNTY_LSE_OIL_ENDING_BAL,
    CNTY_LSE_GAS_PROD_VOL,
    CNTY_LSE_GAS_ALLOW,
    CNTY_LSE_GAS_LIFT_INJ_VOL,
    CNTY_LSE_COND_PROD_VOL,
    CNTY_LSE_COND_LIMIT,
    CNTY_LSE_COND_ENDING_BAL,
    CNTY_LSE_CSGD_PROD_VOL,
    CNTY_LSE_CSGD_LIMIT,
    CNTY_LSE_CSGD_GAS_LIFT,
    CNTY_LSE_OIL_TOT_DISP,
    CNTY_LSE_GAS_TOT_DISP,
    CNTY_LSE_COND_TOT_DISP,
    CNTY_LSE_CSGD_TOT_DISP,
    DISTRICT_NAME,
    LEASE_NAME,
    OPERATOR_NAME,
    FIELD_NAME,
    COUNTY_NAME
)
VALUES
(
    '{OilGasCode}',
    '{DistrictNo}',
    '{LeaseNo}',
    '{CycleYear}',
    '{CycleMonth}',
    '{CountyNo}',
    '{OperatorNo}',
    '{FieldNo}',
    '{CycleYearMonth}',
    '{FieldType}',
    '{GasWellNo}',
    '{ProdReportFiledFlag}',
    {valOilProdVol},
    {valOilAllow},
    {valOilEndingBal},
    {valGasProdVol},
    {valGasAllow},
    {valGasLiftInjVol},
    {valCondProdVol},
    {valCondLimit},
    {valCondEndingBal},
    {valCsgdProdVol},
    {valCsgdLimit},
    {valCsgdGasLift},
    {valOilTotDisp},
    {valGasTotDisp},
    {valCondTotDisp},
    {valCsgdTotDisp},
    '{DistrictName}',
    '{LeaseName}',
    '{OperatorName}',
    '{FieldName}',
    '{CountyName}'
);
";
        }

        private static int? ParseInt(string s)
        {
            if (int.TryParse(s, out var val))
                return val;
            return null;
        }

        private static string FormatInt(int? value)
        {
            return value.HasValue ? value.Value.ToString() : "NULL";
        }
    }

}
