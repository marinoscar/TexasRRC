using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class OgOperatorDw : IRecordScript
    {
        public string OperatorNo { get; set; }             // Index 0 (N)
        public string OperatorName { get; set; }           // Index 1 (Y)
        public string P5StatusCode { get; set; }           // Index 2 (Y)
        public string P5LastFiledDt { get; set; }          // Index 3 (Y)
        public string OperatorTaxCertFlag { get; set; }    // Index 4 (Y)
        public string OperatorSb639Flag { get; set; }      // Index 5 (Y)
        public string FaOptionCode { get; set; }           // Index 6 (Y)
        public string RecordStatusCode { get; set; }       // Index 7 (Y)
        public string EfileStatusCode { get; set; }        // Index 8 (Y)
        public System.DateTime? EfileEffectiveDt { get; set; }  // Index 9 (Y, DATE)
        public string CreateBy { get; set; }               // Index 10 (Y)
        public System.DateTime? CreateDt { get; set; }     // Index 11 (Y, DATE)
        public string ModifyBy { get; set; }               // Index 12 (Y)
        public System.DateTime? ModifyDt { get; set; }     // Index 13 (Y, DATE)

        /// <summary>
        /// Creates a new OgOperatorDw instance by splitting the input text using the provided separator.
        /// The default separator is '}'.
        /// Expected order of fields (14 total):
        ///   0  - OPERATOR_NO
        ///   1  - OPERATOR_NAME
        ///   2  - P5_STATUS_CODE
        ///   3  - P5_LAST_FILED_DT
        ///   4  - OPERATOR_TAX_CERT_FLAG
        ///   5  - OPERATOR_SB639_FLAG
        ///   6  - FA_OPTION_CODE
        ///   7  - RECORD_STATUS_CODE
        ///   8  - EFILE_STATUS_CODE
        ///   9  - EFILE_EFFECTIVE_DT
        ///   10 - CREATE_BY
        ///   11 - CREATE_DT
        ///   12 - MODIFY_BY
        ///   13 - MODIFY_DT
        /// </summary>
        public static OgOperatorDw CreateFromText(string text, string separator = "}")
        {
            if (string.IsNullOrEmpty(text))
                throw new System.ArgumentNullException(nameof(text), "Input text cannot be null or empty.");

            var parts = text.Split(new[] { separator }, System.StringSplitOptions.None);
            if (parts.Length < 14)
            {
                throw new System.ArgumentException(
                    $"Insufficient fields in input text. Expected at least 14 fields separated by '{separator}'.");
            }

            for (int i = 0; i < parts.Length; i++)
            {
                parts[i] = parts[i].Trim();
            }

            return new OgOperatorDw
            {
                OperatorNo = parts[0],
                OperatorName = parts[1],
                P5StatusCode = parts[2],
                P5LastFiledDt = parts[3],
                OperatorTaxCertFlag = parts[4],
                OperatorSb639Flag = parts[5],
                FaOptionCode = parts[6],
                RecordStatusCode = parts[7],
                EfileStatusCode = parts[8],
                EfileEffectiveDt = ParseDate(parts[9]),
                CreateBy = parts[10],
                CreateDt = ParseDate(parts[11]),
                ModifyBy = parts[12],
                ModifyDt = ParseDate(parts[13])
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the OG_OPERATOR_DW table using the current property values.
        /// </summary>
        public string ToSqlInsert()
        {
            string valEfileEffectiveDt = FormatDate(EfileEffectiveDt);
            string valCreateDt = FormatDate(CreateDt);
            string valModifyDt = FormatDate(ModifyDt);

            return $@"
INSERT INTO OG_OPERATOR_DW
(
    OPERATOR_NO,
    OPERATOR_NAME,
    P5_STATUS_CODE,
    P5_LAST_FILED_DT,
    OPERATOR_TAX_CERT_FLAG,
    OPERATOR_SB639_FLAG,
    FA_OPTION_CODE,
    RECORD_STATUS_CODE,
    EFILE_STATUS_CODE,
    EFILE_EFFECTIVE_DT,
    CREATE_BY,
    CREATE_DT,
    MODIFY_BY,
    MODIFY_DT
)
VALUES
(
    '{OperatorNo}',
    '{OperatorName}',
    '{P5StatusCode}',
    '{P5LastFiledDt}',
    '{OperatorTaxCertFlag}',
    '{OperatorSb639Flag}',
    '{FaOptionCode}',
    '{RecordStatusCode}',
    '{EfileStatusCode}',
    {valEfileEffectiveDt},
    '{CreateBy}',
    {valCreateDt},
    '{ModifyBy}',
    {valModifyDt}
);
";
        }

        private static System.DateTime? ParseDate(string s)
        {
            if (string.IsNullOrEmpty(s))
                return null;
            if (System.DateTime.TryParse(s, out var dt))
                return dt;
            return null;
        }

        private static string FormatDate(System.DateTime? dt)
        {
            return dt.HasValue ? $"'{dt.Value:yyyy-MM-dd}'" : "NULL";
        }
    }

}
