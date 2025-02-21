using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class GpCounty : IRecordScript
    {
        public string CountyNo { get; set; }
        public string CountyFipsCode { get; set; }
        public string CountyName { get; set; }
        public string DistrictNo { get; set; }
        public string DistrictName { get; set; }
        public string OnShoreFlag { get; set; }
        public string OnshoreAsscCntyFlag { get; set; }

        /// <summary>
        /// Creates a new GpCounty instance by splitting the input text using the provided separator.
        /// The default separator is '}'.
        /// Expected order of fields:
        ///   0 - COUNTY_NO
        ///   1 - COUNTY_FIPS_CODE
        ///   2 - COUNTY_NAME
        ///   3 - DISTRICT_NO
        ///   4 - DISTRICT_NAME
        ///   5 - ON_SHORE_FLAG
        ///   6 - ONSHORE_ASSC_CNTY_FLAG
        /// </summary>
        /// <param name="text">A single line of data representing a GP_COUNTY record.</param>
        /// <param name="separator">The delimiter used to split fields (defaults to '}').</param>
        /// <returns>A GpCounty instance populated from the split fields.</returns>
        public static GpCounty CreateFromText(string text, string separator = "}")
        {
            if (string.IsNullOrEmpty(text))
                throw new System.ArgumentNullException(nameof(text), "Input text cannot be null or empty.");

            var parts = text.Split(new[] { separator }, System.StringSplitOptions.None);

            if (parts.Length < 7)
            {
                throw new System.ArgumentException(
                    $"Insufficient fields in input text. Expected at least 7 fields separated by '{separator}'.");
            }

            for (int i = 0; i < parts.Length; i++)
            {
                parts[i] = parts[i].Trim();
            }

            return new GpCounty
            {
                CountyNo = parts[0],
                CountyFipsCode = parts[1],
                CountyName = parts[2],
                DistrictNo = parts[3],
                DistrictName = parts[4],
                OnShoreFlag = parts[5],
                OnshoreAsscCntyFlag = parts[6]
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the GP_COUNTY table using the current property values.
        /// </summary>
        /// <returns>A SQL INSERT statement as a string.</returns>
        public string ToSqlInsert()
        {
            return $@"
INSERT INTO GP_COUNTY 
    (COUNTY_NO, COUNTY_FIPS_CODE, COUNTY_NAME, DISTRICT_NO, DISTRICT_NAME, ON_SHORE_FLAG, ONSHORE_ASSC_CNTY_FLAG)
VALUES
    ('{CountyNo}', '{CountyFipsCode}', '{CountyName}', '{DistrictNo}', '{DistrictName}', '{OnShoreFlag}', '{OnshoreAsscCntyFlag}');
";
        }
    }

}
