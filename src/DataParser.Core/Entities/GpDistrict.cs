using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class GpDistrict
    {
        public string DistrictNo { get; set; }
        public string DistrictName { get; set; }
        public string OfficePhoneNo { get; set; }
        public string OfficeLocation { get; set; }

        /// <summary>
        /// Creates a new GpDistrict instance by splitting the input text using the provided separator.
        /// The default separator is '}'.
        /// Expected order of fields:
        ///   0 - DISTRICT_NO
        ///   1 - DISTRICT_NAME
        ///   2 - OFFICE_PHONE_NO
        ///   3 - OFFICE_LOCATION
        /// </summary>
        public static GpDistrict CreateFromText(string text, string separator = "}")
        {
            if (string.IsNullOrEmpty(text))
                throw new System.ArgumentNullException(nameof(text), "Input text cannot be null or empty.");

            var parts = text.Split(new[] { separator }, System.StringSplitOptions.None);
            if (parts.Length < 4)
            {
                throw new System.ArgumentException(
                    $"Insufficient fields in input text. Expected at least 4 fields separated by '{separator}'.");
            }

            for (int i = 0; i < parts.Length; i++)
            {
                parts[i] = parts[i].Trim();
            }

            return new GpDistrict
            {
                DistrictNo = parts[0],
                DistrictName = parts[1],
                OfficePhoneNo = parts[2],
                OfficeLocation = parts[3]
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the GP_DISTRICT table using the current property values.
        /// </summary>
        public string ToSqlInsert()
        {
            return $@"
INSERT INTO GP_DISTRICT
    (DISTRICT_NO, DISTRICT_NAME, OFFICE_PHONE_NO, OFFICE_LOCATION)
VALUES
    ('{DistrictNo}', '{DistrictName}', '{OfficePhoneNo}', '{OfficeLocation}');
";
        }
    }

}
