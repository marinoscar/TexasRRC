using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class OgSummaryMasterLarge
    {
        public string OilGasCode { get; set; }          // Index 0 (N, char(1))
        public string DistrictNo { get; set; }          // Index 1 (N, char(2))
        public string LeaseNo { get; set; }             // Index 2 (N, varchar(6))
        public string OperatorNo { get; set; }          // Index 3 (N, varchar(6))
        public string FieldNo { get; set; }             // Index 4 (N, varchar(8))
        public int? CycleYearMonthMin { get; set; }     // Index 5 (N, number(9))
        public int? CycleYearMonthMax { get; set; }     // Index 6 (N, number(9))
        public string DistrictName { get; set; }        // Index 7 (Y, char(2))
        public string LeaseName { get; set; }           // Index 8 (Y, varchar(50))
        public string OperatorName { get; set; }        // Index 9 (Y, varchar(50))
        public string FieldName { get; set; }           // Index 10 (Y, varchar(32))

        /// <summary>
        /// Creates a new OgSummaryMasterLarge instance by splitting the input text using the provided separator (default '}').
        /// Expected order of fields (11 total):
        ///   0  - OIL_GAS_CODE
        ///   1  - DISTRICT_NO
        ///   2  - LEASE_NO
        ///   3  - OPERATOR_NO
        ///   4  - FIELD_NO
        ///   5  - CYCLE_YEAR_MONTH_MIN
        ///   6  - CYCLE_YEAR_MONTH_MAX
        ///   7  - DISTRICT_NAME
        ///   8  - LEASE_NAME
        ///   9  - OPERATOR_NAME
        ///   10 - FIELD_NAME
        /// </summary>
        public static OgSummaryMasterLarge CreateFromText(string text, string separator = "}")
        {
            if (string.IsNullOrEmpty(text))
                throw new System.ArgumentNullException(nameof(text), "Input text cannot be null or empty.");

            var parts = text.Split(new[] { separator }, System.StringSplitOptions.None);
            if (parts.Length < 11)
            {
                throw new System.ArgumentException(
                    $"Insufficient fields in input text. Expected at least 11 fields separated by '{separator}'.");
            }

            for (int i = 0; i < parts.Length; i++)
            {
                parts[i] = parts[i].Trim();
            }

            return new OgSummaryMasterLarge
            {
                OilGasCode = parts[0],
                DistrictNo = parts[1],
                LeaseNo = parts[2],
                OperatorNo = parts[3],
                FieldNo = parts[4],
                CycleYearMonthMin = ParseInt(parts[5]),
                CycleYearMonthMax = ParseInt(parts[6]),
                DistrictName = parts[7],
                LeaseName = parts[8],
                OperatorName = parts[9],
                FieldName = parts[10]
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the OG_SUMMARY_MASTER_LARGE table using the current property values.
        /// </summary>
        public string ToSqlInsert()
        {
            string valCycleYearMonthMin = FormatInt(CycleYearMonthMin);
            string valCycleYearMonthMax = FormatInt(CycleYearMonthMax);

            return $@"
INSERT INTO OG_SUMMARY_MASTER_LARGE
(
    OIL_GAS_CODE,
    DISTRICT_NO,
    LEASE_NO,
    OPERATOR_NO,
    FIELD_NO,
    CYCLE_YEAR_MONTH_MIN,
    CYCLE_YEAR_MONTH_MAX,
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
    '{OperatorNo}',
    '{FieldNo}',
    {valCycleYearMonthMin},
    {valCycleYearMonthMax},
    '{DistrictName}',
    '{LeaseName}',
    '{OperatorName}',
    '{FieldName}'
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
