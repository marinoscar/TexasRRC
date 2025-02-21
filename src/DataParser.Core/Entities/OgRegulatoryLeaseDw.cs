using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class OgRegulatoryLeaseDw : IRecordScript
    {
        public string OilGasCode { get; set; }         // Index 0 (N, CHAR(1))
        public string DistrictNo { get; set; }         // Index 1 (N, CHAR(2))
        public string LeaseNo { get; set; }           // Index 2 (N, VARCHAR(6))
        public string DistrictName { get; set; }       // Index 3 (Y, CHAR(2))
        public string LeaseName { get; set; }          // Index 4 (Y, VARCHAR(50))
        public string OperatorNo { get; set; }         // Index 5 (N, VARCHAR(6))
        public string OperatorName { get; set; }       // Index 6 (Y, VARCHAR(50))
        public string FieldNo { get; set; }            // Index 7 (N, VARCHAR(8))
        public string FieldName { get; set; }          // Index 8 (Y, VARCHAR(32))
        public string WellNo { get; set; }             // Index 9 (Y, VARCHAR(6))
        public string LeaseOffSchedFlag { get; set; }  // Index 10 (N, CHAR(1))
        public string LeaseSeveranceFlag { get; set; } // Index 11 (N, CHAR(1))

        /// <summary>
        /// Creates a new OgRegulatoryLeaseDw instance by splitting the input text using the provided separator (default '}').
        /// Expected order of fields (12 total):
        ///   0  - OIL_GAS_CODE
        ///   1  - DISTRICT_NO
        ///   2  - LEASE_NO
        ///   3  - DISTRICT_NAME
        ///   4  - LEASE_NAME
        ///   5  - OPERATOR_NO
        ///   6  - OPERATOR_NAME
        ///   7  - FIELD_NO
        ///   8  - FIELD_NAME
        ///   9  - WELL_NO
        ///   10 - LEASE_OFF_SCHED_FLAG
        ///   11 - LEASE_SEVERANCE_FLAG
        /// </summary>
        public static OgRegulatoryLeaseDw CreateFromText(string text, string separator = "}")
        {
            if (string.IsNullOrEmpty(text))
                throw new System.ArgumentNullException(nameof(text), "Input text cannot be null or empty.");

            var parts = text.Split(new[] { separator }, System.StringSplitOptions.None);
            if (parts.Length < 12)
            {
                throw new System.ArgumentException(
                    $"Insufficient fields in input text. Expected at least 12 fields separated by '{separator}'.");
            }

            for (int i = 0; i < parts.Length; i++)
            {
                parts[i] = parts[i].Trim();
            }

            return new OgRegulatoryLeaseDw
            {
                OilGasCode = parts[0],
                DistrictNo = parts[1],
                LeaseNo = parts[2],
                DistrictName = parts[3],
                LeaseName = parts[4],
                OperatorNo = parts[5],
                OperatorName = parts[6],
                FieldNo = parts[7],
                FieldName = parts[8],
                WellNo = parts[9],
                LeaseOffSchedFlag = parts[10],
                LeaseSeveranceFlag = parts[11]
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the OG_REGULATORY_LEASE_DW table using the current property values.
        /// </summary>
        public string ToSqlInsert()
        {
            return $@"
INSERT INTO OG_REGULATORY_LEASE_DW
(
    OIL_GAS_CODE,
    DISTRICT_NO,
    LEASE_NO,
    DISTRICT_NAME,
    LEASE_NAME,
    OPERATOR_NO,
    OPERATOR_NAME,
    FIELD_NO,
    FIELD_NAME,
    WELL_NO,
    LEASE_OFF_SCHED_FLAG,
    LEASE_SEVERANCE_FLAG
)
VALUES
(
    '{OilGasCode}',
    '{DistrictNo}',
    '{LeaseNo}',
    '{DistrictName}',
    '{LeaseName}',
    '{OperatorNo}',
    '{OperatorName}',
    '{FieldNo}',
    '{FieldName}',
    '{WellNo}',
    '{LeaseOffSchedFlag}',
    '{LeaseSeveranceFlag}'
);
";
        }
    }

}
