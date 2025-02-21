using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class OgWellCompletion : IRecordScript
    {
        public string OilGasCode { get; set; }            // Index 0 (N, CHAR(1))
        public string DistrictNo { get; set; }            // Index 1 (N, CHAR(2))
        public string LeaseNo { get; set; }               // Index 2 (N, VARCHAR(6))
        public string WellNo { get; set; }                // Index 3 (N, VARCHAR(6))
        public string ApiCountyCode { get; set; }         // Index 4 (N, CHAR(3))
        public string ApiUniqueNo { get; set; }           // Index 5 (N, VARCHAR(5))
        public string OnshoreAsscCnty { get; set; }       // Index 6 (Y, CHAR(3))
        public string DistrictName { get; set; }          // Index 7 (Y, CHAR(2))
        public string CountyName { get; set; }            // Index 8 (Y, VARCHAR(50))
        public string OilWellUnitNo { get; set; }         // Index 9 (Y, VARCHAR(6))
        public string WellRootNo { get; set; }            // Index 10 (Y, VARCHAR(8))
        public string WellboreShutinDt { get; set; }      // Index 11 (Y, VARCHAR(6))
        public string WellShutinDt { get; set; }          // Index 12 (Y, VARCHAR(6))
        public string Well14b2StatusCode { get; set; }    // Index 13 (Y, CHAR(1))
        public string WellSubject14b2Flag { get; set; }   // Index 14 (Y, CHAR(1))
        public string WellboreLocationCode { get; set; }  // Index 15 (Y, CHAR(1))

        /// <summary>
        /// Creates a new OgWellCompletion instance by splitting the input text using the provided separator (default '}').
        /// Expected order of fields (16 total):
        ///   0  - OIL_GAS_CODE
        ///   1  - DISTRICT_NO
        ///   2  - LEASE_NO
        ///   3  - WELL_NO
        ///   4  - API_COUNTY_CODE
        ///   5  - API_UNIQUE_NO
        ///   6  - ONSHORE_ASSC_CNTY
        ///   7  - DISTRICT_NAME
        ///   8  - COUNTY_NAME
        ///   9  - OIL_WELL_UNIT_NO
        ///   10 - WELL_ROOT_NO
        ///   11 - WELLBORE_SHUTIN_DT
        ///   12 - WELL_SHUTIN_DT
        ///   13 - WELL_14B2_STATUS_CODE
        ///   14 - WELL_SUBJECT_14B2_FLAG
        ///   15 - WELLBORE_LOCATION_CODE
        /// </summary>
        public static OgWellCompletion CreateFromText(string text, string separator = "}")
        {
            if (string.IsNullOrEmpty(text))
                throw new System.ArgumentNullException(nameof(text), "Input text cannot be null or empty.");

            var parts = text.Split(new[] { separator }, System.StringSplitOptions.None);
            if (parts.Length < 16)
            {
                throw new System.ArgumentException(
                    $"Insufficient fields in input text. Expected at least 16 fields separated by '{separator}'.");
            }

            for (int i = 0; i < parts.Length; i++)
            {
                parts[i] = parts[i].Trim();
            }

            return new OgWellCompletion
            {
                OilGasCode = parts[0],
                DistrictNo = parts[1],
                LeaseNo = parts[2],
                WellNo = parts[3],
                ApiCountyCode = parts[4],
                ApiUniqueNo = parts[5],
                OnshoreAsscCnty = parts[6],
                DistrictName = parts[7],
                CountyName = parts[8],
                OilWellUnitNo = parts[9],
                WellRootNo = parts[10],
                WellboreShutinDt = parts[11],
                WellShutinDt = parts[12],
                Well14b2StatusCode = parts[13],
                WellSubject14b2Flag = parts[14],
                WellboreLocationCode = parts[15]
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the OG_WELL_COMPLETION table using the current property values.
        /// </summary>
        public string ToSqlInsert()
        {
            return $@"
INSERT INTO OG_WELL_COMPLETION
(
    OIL_GAS_CODE,
    DISTRICT_NO,
    LEASE_NO,
    WELL_NO,
    API_COUNTY_CODE,
    API_UNIQUE_NO,
    ONSHORE_ASSC_CNTY,
    DISTRICT_NAME,
    COUNTY_NAME,
    OIL_WELL_UNIT_NO,
    WELL_ROOT_NO,
    WELLBORE_SHUTIN_DT,
    WELL_SHUTIN_DT,
    WELL_14B2_STATUS_CODE,
    WELL_SUBJECT_14B2_FLAG,
    WELLBORE_LOCATION_CODE
)
VALUES
(
    '{OilGasCode}',
    '{DistrictNo}',
    '{LeaseNo}',
    '{WellNo}',
    '{ApiCountyCode}',
    '{ApiUniqueNo}',
    '{OnshoreAsscCnty}',
    '{DistrictName}',
    '{CountyName}',
    '{OilWellUnitNo}',
    '{WellRootNo}',
    '{WellboreShutinDt}',
    '{WellShutinDt}',
    '{Well14b2StatusCode}',
    '{WellSubject14b2Flag}',
    '{WellboreLocationCode}'
);
";
        }
    }

}
