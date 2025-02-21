using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class GpDateRangeCycle : IRecordScript
    {
        public string OldestProdCycleYearMonth { get; set; }
        public string NewestProdCycleYearMonth { get; set; }
        public string NewestSchedCycleYearMonth { get; set; }
        public System.DateTime? GasExtractDate { get; set; }
        public System.DateTime? OilExtractDate { get; set; }

        /// <summary>
        /// Creates a new GpDateRangeCycle instance by splitting the input text using the provided separator.
        /// The default separator is '}'.
        /// Expected order of fields:
        ///   0 - OLDEST_PROD_CYCLE_YEAR_MONTH
        ///   1 - NEWEST_PROD_CYCLE_YEAR_MONTH
        ///   2 - NEWEST_SCHED_CYCLE_YEAR_MONTH
        ///   3 - GAS_EXTRACT_DATE
        ///   4 - OIL_EXTRACT_DATE
        /// </summary>
        public static GpDateRangeCycle CreateFromText(string text, string separator = "}")
        {
            if (string.IsNullOrEmpty(text))
                throw new System.ArgumentNullException(nameof(text), "Input text cannot be null or empty.");

            var parts = text.Split(new[] { separator }, System.StringSplitOptions.None);
            if (parts.Length < 5)
            {
                throw new System.ArgumentException(
                    $"Insufficient fields in input text. Expected at least 5 fields separated by '{separator}'.");
            }

            for (int i = 0; i < parts.Length; i++)
            {
                parts[i] = parts[i].Trim();
            }

            // Parse dates if possible
            System.DateTime? gasDate = null;
            if (!string.IsNullOrEmpty(parts[3]))
            {
                if (System.DateTime.TryParse(parts[3], out var parsedGas))
                    gasDate = parsedGas;
            }

            System.DateTime? oilDate = null;
            if (!string.IsNullOrEmpty(parts[4]))
            {
                if (System.DateTime.TryParse(parts[4], out var parsedOil))
                    oilDate = parsedOil;
            }

            return new GpDateRangeCycle
            {
                OldestProdCycleYearMonth = parts[0],
                NewestProdCycleYearMonth = parts[1],
                NewestSchedCycleYearMonth = parts[2],
                GasExtractDate = gasDate,
                OilExtractDate = oilDate
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the GP_DATE_RANGE_CYCLE table using the current property values.
        /// </summary>
        public string ToSqlInsert()
        {
            // For date columns, produce either 'YYYY-MM-DD' or NULL if no value
            string gasValue = GasExtractDate.HasValue
                ? $"'{GasExtractDate.Value:yyyy-MM-dd}'"
                : "NULL";

            string oilValue = OilExtractDate.HasValue
                ? $"'{OilExtractDate.Value:yyyy-MM-dd}'"
                : "NULL";

            return $@"
INSERT INTO GP_DATE_RANGE_CYCLE
    (OLDEST_PROD_CYCLE_YEAR_MONTH, NEWEST_PROD_CYCLE_YEAR_MONTH, NEWEST_SCHED_CYCLE_YEAR_MONTH, GAS_EXTRACT_DATE, OIL_EXTRACT_DATE)
VALUES
    ('{OldestProdCycleYearMonth}', '{NewestProdCycleYearMonth}', '{NewestSchedCycleYearMonth}', {gasValue}, {oilValue});
";
        }
    }

}
