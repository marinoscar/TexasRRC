using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class OgLeaseCycle : IRecordScript
    {
        public string OilGasCode { get; set; }              // Index 0 (N, char(1))
        public string DistrictNo { get; set; }              // Index 1 (N, char(2))
        public string LeaseNo { get; set; }                 // Index 2 (N, varchar(6))
        public string CycleYear { get; set; }               // Index 3 (N, char(4))
        public string CycleMonth { get; set; }              // Index 4 (N, char(2))
        public string CycleYearMonth { get; set; }          // Index 5 (N, varchar(6))
        public long LeaseNoDistrictNo { get; set; }         // Index 6 (N, NUMBER(10))
        public string OperatorNo { get; set; }              // Index 7 (Y, varchar(6))
        public string FieldNo { get; set; }                 // Index 8 (Y, varchar(8))
        public string FieldType { get; set; }               // Index 9 (Y, char(2))
        public string GasWellNo { get; set; }               // Index 10 (Y, varchar(6))
        public string ProdReportFiledFlag { get; set; }     // Index 11 (Y, char(1))
        public int? LeaseOilProdVol { get; set; }           // Index 12 (Y, NUMBER(9))
        public int? LeaseOilAllow { get; set; }             // Index 13 (Y, NUMBER(9))
        public int? LeaseOilEndingBal { get; set; }         // Index 14 (Y, NUMBER(9))
        public int? LeaseGasProdVol { get; set; }           // Index 15 (Y, NUMBER(9))
        public int? LeaseGasAllow { get; set; }             // Index 16 (Y, NUMBER(9))
        public int? LeaseGasLiftInjVol { get; set; }        // Index 17 (Y, NUMBER(9))
        public int? LeaseCondProdVol { get; set; }          // Index 18 (Y, NUMBER(9))
        public int? LeaseCondLimit { get; set; }            // Index 19 (Y, NUMBER(9))
        public int? LeaseCondEndingBal { get; set; }        // Index 20 (Y, NUMBER(9))
        public int? LeaseCsgdProdVol { get; set; }          // Index 21 (Y, NUMBER(9))
        public int? LeaseCsgdLimit { get; set; }            // Index 22 (Y, NUMBER(9))
        public int? LeaseCsgdGasLift { get; set; }          // Index 23 (Y, NUMBER(9))
        public int? LeaseOilTotDisp { get; set; }           // Index 24 (Y, NUMBER(9))
        public int? LeaseGasTotDisp { get; set; }           // Index 25 (Y, NUMBER(9))
        public int? LeaseCondTotDisp { get; set; }          // Index 26 (Y, NUMBER(9))
        public int? LeaseCsgdTotDisp { get; set; }          // Index 27 (Y, NUMBER(9))
        public string DistrictName { get; set; }            // Index 28 (Y, char(2))
        public string LeaseName { get; set; }               // Index 29 (Y, varchar(50))
        public string OperatorName { get; set; }            // Index 30 (Y, varchar(50))
        public string FieldName { get; set; }               // Index 31 (Y, varchar(32))

        /// <summary>
        /// Creates a new OgLeaseCycle instance by splitting the input text using the provided separator (default '}').
        /// Expected total fields: 32, in the order described in these properties.
        /// </summary>
        public static OgLeaseCycle CreateFromText(string text, string separator = "}")
        {
            if (string.IsNullOrEmpty(text))
                throw new System.ArgumentNullException(nameof(text), "Input text cannot be null or empty.");

            var parts = text.Split(new[] { separator }, System.StringSplitOptions.None);
            if (parts.Length < 32)
            {
                throw new System.ArgumentException(
                    $"Insufficient fields in input text. Expected at least 32 fields separated by '{separator}'.");
            }

            for (int i = 0; i < parts.Length; i++)
            {
                parts[i] = parts[i].Trim();
            }

            return new OgLeaseCycle
            {
                OilGasCode = parts[0],
                DistrictNo = parts[1],
                LeaseNo = parts[2],
                CycleYear = parts[3],
                CycleMonth = parts[4],
                CycleYearMonth = parts[5],
                LeaseNoDistrictNo = ParseLongNotNull(parts[6]),
                OperatorNo = parts[7],
                FieldNo = parts[8],
                FieldType = parts[9],
                GasWellNo = parts[10],
                ProdReportFiledFlag = parts[11],
                LeaseOilProdVol = ParseInt(parts[12]),
                LeaseOilAllow = ParseInt(parts[13]),
                LeaseOilEndingBal = ParseInt(parts[14]),
                LeaseGasProdVol = ParseInt(parts[15]),
                LeaseGasAllow = ParseInt(parts[16]),
                LeaseGasLiftInjVol = ParseInt(parts[17]),
                LeaseCondProdVol = ParseInt(parts[18]),
                LeaseCondLimit = ParseInt(parts[19]),
                LeaseCondEndingBal = ParseInt(parts[20]),
                LeaseCsgdProdVol = ParseInt(parts[21]),
                LeaseCsgdLimit = ParseInt(parts[22]),
                LeaseCsgdGasLift = ParseInt(parts[23]),
                LeaseOilTotDisp = ParseInt(parts[24]),
                LeaseGasTotDisp = ParseInt(parts[25]),
                LeaseCondTotDisp = ParseInt(parts[26]),
                LeaseCsgdTotDisp = ParseInt(parts[27]),
                DistrictName = parts[28],
                LeaseName = parts[29],
                OperatorName = parts[30],
                FieldName = parts[31]
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the OG_LEASE_CYCLE table using current property values.
        /// </summary>
        public string ToSqlInsert()
        {
            string valLeaseOilProdVol = FormatInt(LeaseOilProdVol);
            string valLeaseOilAllow = FormatInt(LeaseOilAllow);
            string valLeaseOilEndingBal = FormatInt(LeaseOilEndingBal);
            string valLeaseGasProdVol = FormatInt(LeaseGasProdVol);
            string valLeaseGasAllow = FormatInt(LeaseGasAllow);
            string valLeaseGasLiftInjVol = FormatInt(LeaseGasLiftInjVol);
            string valLeaseCondProdVol = FormatInt(LeaseCondProdVol);
            string valLeaseCondLimit = FormatInt(LeaseCondLimit);
            string valLeaseCondEndingBal = FormatInt(LeaseCondEndingBal);
            string valLeaseCsgdProdVol = FormatInt(LeaseCsgdProdVol);
            string valLeaseCsgdLimit = FormatInt(LeaseCsgdLimit);
            string valLeaseCsgdGasLift = FormatInt(LeaseCsgdGasLift);
            string valLeaseOilTotDisp = FormatInt(LeaseOilTotDisp);
            string valLeaseGasTotDisp = FormatInt(LeaseGasTotDisp);
            string valLeaseCondTotDisp = FormatInt(LeaseCondTotDisp);
            string valLeaseCsgdTotDisp = FormatInt(LeaseCsgdTotDisp);

            return $@"
INSERT INTO OG_LEASE_CYCLE
(
    OIL_GAS_CODE,
    DISTRICT_NO,
    LEASE_NO,
    CYCLE_YEAR,
    CYCLE_MONTH,
    CYCLE_YEAR_MONTH,
    LEASE_NO_DISTRICT_NO,
    OPERATOR_NO,
    FIELD_NO,
    FIELD_TYPE,
    GAS_WELL_NO,
    PROD_REPORT_FILED_FLAG,
    LEASE_OIL_PROD_VOL,
    LEASE_OIL_ALLOW,
    LEASE_OIL_ENDING_BAL,
    LEASE_GAS_PROD_VOL,
    LEASE_GAS_ALLOW,
    LEASE_GAS_LIFT_INJ_VOL,
    LEASE_COND_PROD_VOL,
    LEASE_COND_LIMIT,
    LEASE_COND_ENDING_BAL,
    LEASE_CSGD_PROD_VOL,
    LEASE_CSGD_LIMIT,
    LEASE_CSGD_GAS_LIFT,
    LEASE_OIL_TOT_DISP,
    LEASE_GAS_TOT_DISP,
    LEASE_COND_TOT_DISP,
    LEASE_CSGD_TOT_DISP,
    DISTRICT_NAME,
    LEASE_NAME,
    OPERATOR_NAME,
    FIELD_NAME
)
VALUES
(
    '{OilGasCode}',
    '{DistrictNo}',
    '{LeaseNo}',
    '{CycleYear}',
    '{CycleMonth}',
    '{CycleYearMonth}',
    {LeaseNoDistrictNo},
    '{OperatorNo}',
    '{FieldNo}',
    '{FieldType}',
    '{GasWellNo}',
    '{ProdReportFiledFlag}',
    {valLeaseOilProdVol},
    {valLeaseOilAllow},
    {valLeaseOilEndingBal},
    {valLeaseGasProdVol},
    {valLeaseGasAllow},
    {valLeaseGasLiftInjVol},
    {valLeaseCondProdVol},
    {valLeaseCondLimit},
    {valLeaseCondEndingBal},
    {valLeaseCsgdProdVol},
    {valLeaseCsgdLimit},
    {valLeaseCsgdGasLift},
    {valLeaseOilTotDisp},
    {valLeaseGasTotDisp},
    {valLeaseCondTotDisp},
    {valLeaseCsgdTotDisp},
    '{DistrictName}',
    '{LeaseName}',
    '{OperatorName}',
    '{FieldName}'
);
";
        }

        private static long ParseLongNotNull(string s)
        {
            if (long.TryParse(s, out var val))
                return val;

            throw new System.ArgumentException(
                $"Could not parse a non-nullable long value from '{s}'.");
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
