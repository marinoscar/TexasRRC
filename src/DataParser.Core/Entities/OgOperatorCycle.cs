using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class OgOperatorCycle : IRecordScript
    {
        public string OperatorNo { get; set; }          // Index 0 (N, varchar(6))
        public string CycleYear { get; set; }           // Index 1 (N, char(4))
        public string CycleMonth { get; set; }          // Index 2 (N, char(2))
        public string CycleYearMonth { get; set; }      // Index 3 (Y, varchar(6))
        public string OperatorName { get; set; }        // Index 4 (Y, varchar(50))
        public int? OperOilProdVol { get; set; }        // Index 5 (Y, NUMBER(9))
        public int? OperGasProdVol { get; set; }        // Index 6 (Y, NUMBER(9))
        public int? OperCondProdVol { get; set; }       // Index 7 (Y, NUMBER(9))
        public int? OperCsgdProdVol { get; set; }       // Index 8 (Y, NUMBER(9))

        /// <summary>
        /// Creates a new OgOperatorCycle instance by splitting the input text using the provided separator (default '}').
        /// Expected order of fields (9 total):
        ///   0 - OPERATOR_NO
        ///   1 - CYCLE_YEAR
        ///   2 - CYCLE_MONTH
        ///   3 - CYCLE_YEAR_MONTH
        ///   4 - OPERATOR_NAME
        ///   5 - OPER_OIL_PROD_VOL
        ///   6 - OPER_GAS_PROD_VOL
        ///   7 - OPER_COND_PROD_VOL
        ///   8 - OPER_CSGD_PROD_VOL
        /// </summary>
        public static OgOperatorCycle CreateFromText(string text, string separator = "}")
        {
            if (string.IsNullOrEmpty(text))
                throw new System.ArgumentNullException(nameof(text), "Input text cannot be null or empty.");

            var parts = text.Split(new[] { separator }, System.StringSplitOptions.None);
            if (parts.Length < 9)
            {
                throw new System.ArgumentException(
                    $"Insufficient fields in input text. Expected at least 9 fields separated by '{separator}'.");
            }

            for (int i = 0; i < parts.Length; i++)
            {
                parts[i] = parts[i].Trim();
            }

            return new OgOperatorCycle
            {
                OperatorNo = parts[0],
                CycleYear = parts[1],
                CycleMonth = parts[2],
                CycleYearMonth = parts[3],
                OperatorName = parts[4],
                OperOilProdVol = ParseInt(parts[5]),
                OperGasProdVol = ParseInt(parts[6]),
                OperCondProdVol = ParseInt(parts[7]),
                OperCsgdProdVol = ParseInt(parts[8])
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the OG_OPERATOR_CYCLE table using the current property values.
        /// </summary>
        public string ToSqlInsert()
        {
            string valOperOilProdVol = FormatInt(OperOilProdVol);
            string valOperGasProdVol = FormatInt(OperGasProdVol);
            string valOperCondProdVol = FormatInt(OperCondProdVol);
            string valOperCsgdProdVol = FormatInt(OperCsgdProdVol);

            return $@"
INSERT INTO OG_OPERATOR_CYCLE
(
    OPERATOR_NO,
    CYCLE_YEAR,
    CYCLE_MONTH,
    CYCLE_YEAR_MONTH,
    OPERATOR_NAME,
    OPER_OIL_PROD_VOL,
    OPER_GAS_PROD_VOL,
    OPER_COND_PROD_VOL,
    OPER_CSGD_PROD_VOL
)
VALUES
(
    '{OperatorNo}',
    '{CycleYear}',
    '{CycleMonth}',
    '{CycleYearMonth}',
    '{OperatorName}',
    {valOperOilProdVol},
    {valOperGasProdVol},
    {valOperCondProdVol},
    {valOperCsgdProdVol}
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
