using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class OgDistrictCycle : IRecordScript
    {
        public string DistrictNo { get; set; }
        public string CycleYear { get; set; }
        public string CycleMonth { get; set; }
        public string CycleYearMonth { get; set; }
        public string DistrictName { get; set; }
        public int? DistOilProdVol { get; set; }
        public int? DistGasProdVol { get; set; }
        public int? DistCondProdVol { get; set; }
        public int? DistCsgdProdVol { get; set; }

        /// <summary>
        /// Creates a new OgDistrictCycle instance by splitting the input text using the provided separator.
        /// The default separator is '}'.
        /// Expected order of fields (9 total):
        ///   0 - DISTRICT_NO
        ///   1 - CYCLE_YEAR
        ///   2 - CYCLE_MONTH
        ///   3 - CYCLE_YEAR_MONTH
        ///   4 - DISTRICT_NAME
        ///   5 - DIST_OIL_PROD_VOL
        ///   6 - DIST_GAS_PROD_VOL
        ///   7 - DIST_COND_PROD_VOL
        ///   8 - DIST_CSGD_PROD_VOL
        /// </summary>
        public static OgDistrictCycle CreateFromText(string text, string separator = "}")
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
                parts[i] = parts[i].Trim().ToSql();
            }

            return new OgDistrictCycle
            {
                DistrictNo = parts[0],
                CycleYear = parts[1],
                CycleMonth = parts[2],
                CycleYearMonth = parts[3],
                DistrictName = parts[4],
                DistOilProdVol = ParseInt(parts[5]),
                DistGasProdVol = ParseInt(parts[6]),
                DistCondProdVol = ParseInt(parts[7]),
                DistCsgdProdVol = ParseInt(parts[8])
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the OG_DISTRICT_CYCLE table using the current property values.
        /// </summary>
        public string ToSqlInsert()
        {
            string valDistOilProdVol = FormatInt(DistOilProdVol);
            string valDistGasProdVol = FormatInt(DistGasProdVol);
            string valDistCondProdVol = FormatInt(DistCondProdVol);
            string valDistCsgdProdVol = FormatInt(DistCsgdProdVol);

            return $@"
INSERT INTO OG_DISTRICT_CYCLE
(
    DISTRICT_NO,
    CYCLE_YEAR,
    CYCLE_MONTH,
    CYCLE_YEAR_MONTH,
    DISTRICT_NAME,
    DIST_OIL_PROD_VOL,
    DIST_GAS_PROD_VOL,
    DIST_COND_PROD_VOL,
    DIST_CSGD_PROD_VOL
)
VALUES
(
    '{DistrictNo}',
    '{CycleYear}',
    '{CycleMonth}',
    '{CycleYearMonth}',
    '{DistrictName}',
    {valDistOilProdVol},
    {valDistGasProdVol},
    {valDistCondProdVol},
    {valDistCsgdProdVol}
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
