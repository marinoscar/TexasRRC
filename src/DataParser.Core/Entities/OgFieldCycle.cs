using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class OgFieldCycle
    {
        public string DistrictNo { get; set; }
        public string FieldNo { get; set; }
        public string CycleYear { get; set; }
        public string CycleMonth { get; set; }
        public string CycleYearMonth { get; set; }
        public string DistrictName { get; set; }
        public string FieldName { get; set; }
        public int? FieldOilProdVol { get; set; }
        public int? FieldGasProdVol { get; set; }
        public int? FieldCondProdVol { get; set; }
        public int? FieldCsgdProdVol { get; set; }

        /// <summary>
        /// Creates a new OgFieldCycle instance by splitting the input text using the provided separator.
        /// The default separator is '}'.
        /// Expected order of fields (11 total):
        ///   0 - DISTRICT_NO
        ///   1 - FIELD_NO
        ///   2 - CYCLE_YEAR
        ///   3 - CYCLE_MONTH
        ///   4 - CYCLE_YEAR_MONTH
        ///   5 - DISTRICT_NAME
        ///   6 - FIELD_NAME
        ///   7 - FIELD_OIL_PROD_VOL
        ///   8 - FIELD_GAS_PROD_VOL
        ///   9 - FIELD_COND_PROD_VOL
        ///   10 - FIELD_CSGD_PROD_VOL
        /// </summary>
        public static OgFieldCycle CreateFromText(string text, string separator = "}")
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

            return new OgFieldCycle
            {
                DistrictNo = parts[0],
                FieldNo = parts[1],
                CycleYear = parts[2],
                CycleMonth = parts[3],
                CycleYearMonth = parts[4],
                DistrictName = parts[5],
                FieldName = parts[6],
                FieldOilProdVol = ParseInt(parts[7]),
                FieldGasProdVol = ParseInt(parts[8]),
                FieldCondProdVol = ParseInt(parts[9]),
                FieldCsgdProdVol = ParseInt(parts[10])
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the OG_FIELD_CYCLE table using the current property values.
        /// </summary>
        public string ToSqlInsert()
        {
            string valFieldOilProdVol = FormatInt(FieldOilProdVol);
            string valFieldGasProdVol = FormatInt(FieldGasProdVol);
            string valFieldCondProdVol = FormatInt(FieldCondProdVol);
            string valFieldCsgdProdVol = FormatInt(FieldCsgdProdVol);

            return $@"
INSERT INTO OG_FIELD_CYCLE
(
    DISTRICT_NO,
    FIELD_NO,
    CYCLE_YEAR,
    CYCLE_MONTH,
    CYCLE_YEAR_MONTH,
    DISTRICT_NAME,
    FIELD_NAME,
    FIELD_OIL_PROD_VOL,
    FIELD_GAS_PROD_VOL,
    FIELD_COND_PROD_VOL,
    FIELD_CSGD_PROD_VOL
)
VALUES
(
    '{DistrictNo}',
    '{FieldNo}',
    '{CycleYear}',
    '{CycleMonth}',
    '{CycleYearMonth}',
    '{DistrictName}',
    '{FieldName}',
    {valFieldOilProdVol},
    {valFieldGasProdVol},
    {valFieldCondProdVol},
    {valFieldCsgdProdVol}
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
