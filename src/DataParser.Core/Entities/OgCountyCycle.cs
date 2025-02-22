using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class OgCountyCycle : IRecordScript
    {
        public string CountyNo { get; set; }
        public string DistrictNo { get; set; }
        public string CycleYear { get; set; }
        public string CycleMonth { get; set; }
        public string CycleYearMonth { get; set; }
        public long? CntyOilProdVol { get; set; }
        public long? CntyOilAllow { get; set; }
        public long? CntyOilEndingBal { get; set; }
        public long? CntyGasProdVol { get; set; }
        public long? CntyGasAllow { get; set; }
        public long? CntyGasLiftInjVol { get; set; }
        public long? CntyCondProdVol { get; set; }
        public long? CntyCondLimit { get; set; }
        public long? CntyCondEndingBal { get; set; }
        public long? CntyCsgdProdVol { get; set; }
        public long? CntyCsgdLimit { get; set; }
        public long? CntyCsgdGasLift { get; set; }
        public long? CntyOilTotDisp { get; set; }
        public long? CntyGasTotDisp { get; set; }
        public long? CntyCondTotDisp { get; set; }
        public long? CntyCsgdTotDisp { get; set; }
        public string CountyName { get; set; }
        public string DistrictName { get; set; }
        public string OilGasCode { get; set; }

        /// <summary>
        /// Creates a new OgCountyCycle instance by splitting the input text using the provided separator.
        /// The default separator is '}'.
        /// Expected order of fields (24 total):
        ///   0  - COUNTY_NO
        ///   1  - DISTRICT_NO
        ///   2  - CYCLE_YEAR
        ///   3  - CYCLE_MONTH
        ///   4  - CYCLE_YEAR_MONTH
        ///   5  - CNTY_OIL_PROD_VOL
        ///   6  - CNTY_OIL_ALLOW
        ///   7  - CNTY_OIL_ENDING_BAL
        ///   8  - CNTY_GAS_PROD_VOL
        ///   9  - CNTY_GAS_ALLOW
        ///   10 - CNTY_GAS_LIFT_INJ_VOL
        ///   11 - CNTY_COND_PROD_VOL
        ///   12 - CNTY_COND_LIMIT
        ///   13 - CNTY_COND_ENDING_BAL
        ///   14 - CNTY_CSGD_PROD_VOL
        ///   15 - CNTY_CSGD_LIMIT
        ///   16 - CNTY_CSGD_GAS_LIFT
        ///   17 - CNTY_OIL_TOT_DISP
        ///   18 - CNTY_GAS_TOT_DISP
        ///   19 - CNTY_COND_TOT_DISP
        ///   20 - CNTY_CSGD_TOT_DISP
        ///   21 - COUNTY_NAME
        ///   22 - DISTRICT_NAME
        ///   23 - OIL_GAS_CODE
        /// </summary>
        public static OgCountyCycle CreateFromText(string text, string separator = "}")
        {
            if (string.IsNullOrEmpty(text))
                throw new System.ArgumentNullException(nameof(text), "Input text cannot be null or empty.");

            var parts = text.Split(new[] { separator }, System.StringSplitOptions.None);
            if (parts.Length < 24)
            {
                throw new System.ArgumentException(
                    $"Insufficient fields in input text. Expected at least 24 fields separated by '{separator}'.");
            }

            for (int i = 0; i < parts.Length; i++)
            {
                parts[i] = parts[i].Trim().ToSql();
            }

            return new OgCountyCycle
            {
                CountyNo = parts[0],
                DistrictNo = parts[1],
                CycleYear = parts[2],
                CycleMonth = parts[3],
                CycleYearMonth = parts[4],
                CntyOilProdVol = ParseLong(parts[5]),
                CntyOilAllow = ParseLong(parts[6]),
                CntyOilEndingBal = ParseLong(parts[7]),
                CntyGasProdVol = ParseLong(parts[8]),
                CntyGasAllow = ParseLong(parts[9]),
                CntyGasLiftInjVol = ParseLong(parts[10]),
                CntyCondProdVol = ParseLong(parts[11]),
                CntyCondLimit = ParseLong(parts[12]),
                CntyCondEndingBal = ParseLong(parts[13]),
                CntyCsgdProdVol = ParseLong(parts[14]),
                CntyCsgdLimit = ParseLong(parts[15]),
                CntyCsgdGasLift = ParseLong(parts[16]),
                CntyOilTotDisp = ParseLong(parts[17]),
                CntyGasTotDisp = ParseLong(parts[18]),
                CntyCondTotDisp = ParseLong(parts[19]),
                CntyCsgdTotDisp = ParseLong(parts[20]),
                CountyName = parts[21],
                DistrictName = parts[22],
                OilGasCode = parts[23]
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the OG_COUNTY_CYCLE table using the current property values.
        /// </summary>
        public string ToSqlInsert()
        {
            string valCntyOilProdVol = FormatLong(CntyOilProdVol);
            string valCntyOilAllow = FormatLong(CntyOilAllow);
            string valCntyOilEndingBal = FormatLong(CntyOilEndingBal);
            string valCntyGasProdVol = FormatLong(CntyGasProdVol);
            string valCntyGasAllow = FormatLong(CntyGasAllow);
            string valCntyGasLiftInj = FormatLong(CntyGasLiftInjVol);
            string valCntyCondProdVol = FormatLong(CntyCondProdVol);
            string valCntyCondLimit = FormatLong(CntyCondLimit);
            string valCntyCondEnding = FormatLong(CntyCondEndingBal);
            string valCntyCsgdProdVol = FormatLong(CntyCsgdProdVol);
            string valCntyCsgdLimit = FormatLong(CntyCsgdLimit);
            string valCntyCsgdGasLift = FormatLong(CntyCsgdGasLift);
            string valCntyOilTotDisp = FormatLong(CntyOilTotDisp);
            string valCntyGasTotDisp = FormatLong(CntyGasTotDisp);
            string valCntyCondTotDisp = FormatLong(CntyCondTotDisp);
            string valCntyCsgdTotDisp = FormatLong(CntyCsgdTotDisp);

            return $@"
INSERT INTO OG_COUNTY_CYCLE
(
    COUNTY_NO,
    DISTRICT_NO,
    CYCLE_YEAR,
    CYCLE_MONTH,
    CYCLE_YEAR_MONTH,
    CNTY_OIL_PROD_VOL,
    CNTY_OIL_ALLOW,
    CNTY_OIL_ENDING_BAL,
    CNTY_GAS_PROD_VOL,
    CNTY_GAS_ALLOW,
    CNTY_GAS_LIFT_INJ_VOL,
    CNTY_COND_PROD_VOL,
    CNTY_COND_LIMIT,
    CNTY_COND_ENDING_BAL,
    CNTY_CSGD_PROD_VOL,
    CNTY_CSGD_LIMIT,
    CNTY_CSGD_GAS_LIFT,
    CNTY_OIL_TOT_DISP,
    CNTY_GAS_TOT_DISP,
    CNTY_COND_TOT_DISP,
    CNTY_CSGD_TOT_DISP,
    COUNTY_NAME,
    DISTRICT_NAME,
    OIL_GAS_CODE
)
VALUES
(
    '{CountyNo}',
    '{DistrictNo}',
    '{CycleYear}',
    '{CycleMonth}',
    '{CycleYearMonth}',
    {valCntyOilProdVol},
    {valCntyOilAllow},
    {valCntyOilEndingBal},
    {valCntyGasProdVol},
    {valCntyGasAllow},
    {valCntyGasLiftInj},
    {valCntyCondProdVol},
    {valCntyCondLimit},
    {valCntyCondEnding},
    {valCntyCsgdProdVol},
    {valCntyCsgdLimit},
    {valCntyCsgdGasLift},
    {valCntyOilTotDisp},
    {valCntyGasTotDisp},
    {valCntyCondTotDisp},
    {valCntyCsgdTotDisp},
    '{CountyName}',
    '{DistrictName}',
    '{OilGasCode}'
);
";
        }

        static long? ParseLong(string s)
        {
            if (long.TryParse(s, out var val))
                return val;
            return null;
        }

        static string FormatLong(long? value)
        {
            return value.HasValue ? value.Value.ToString() : "NULL";
        }
    }

}
