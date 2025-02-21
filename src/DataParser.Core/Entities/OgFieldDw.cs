using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class OgFieldDw
    {
        public string FieldNo { get; set; }
        public string FieldName { get; set; }
        public string DistrictNo { get; set; }
        public string DistrictName { get; set; }
        public string FieldClass { get; set; }
        public string FieldH2sFlag { get; set; }
        public string FieldManualRevFlag { get; set; }
        public string WildcatFlag { get; set; }
        public string ODerivedRuleTypeCode { get; set; }
        public string GDerivedRuleTypeCode { get; set; }
        public System.DateTime? ORescindDt { get; set; }
        public string GRescindDt { get; set; }
        public string OSaltDomeFlag { get; set; }
        public string GSaltDomeFlag { get; set; }
        public string OOffshoreCode { get; set; }
        public string GOffshoreCode { get; set; }
        public string ODontPermit { get; set; }
        public string GDontPermit { get; set; }
        public string ONoaManRevRule { get; set; }
        public string GNoaManRevRule { get; set; }
        public string OCountyNo { get; set; }
        public string GCountyNo { get; set; }
        public System.DateTime? ODiscoveryDt { get; set; }
        public System.DateTime? GDiscoveryDt { get; set; }
        public string OSchedRemarks { get; set; }
        public string GSchedRemarks { get; set; }
        public string OComments { get; set; }
        public string GComments { get; set; }
        public string CreateBy { get; set; }
        public System.DateTime? CreateDt { get; set; }
        public string ModifyBy { get; set; }
        public System.DateTime? ModifyDt { get; set; }

        /// <summary>
        /// Creates a new OgFieldDw instance by splitting the input text using the provided separator.
        /// The default separator is '}'.
        /// Expected order of fields (32 total):
        ///   0  - FIELD_NO
        ///   1  - FIELD_NAME
        ///   2  - DISTRICT_NO
        ///   3  - DISTRICT_NAME
        ///   4  - FIELD_CLASS
        ///   5  - FIELD_H2S_FLAG
        ///   6  - FIELD_MANUAL_REV_FLAG
        ///   7  - WILDCAT_FLAG
        ///   8  - O_DERIVED_RULE_TYPE_CODE
        ///   9  - G_DERIVED_RULE_TYPE_CODE
        ///   10 - O_RESCIND_DT (date)
        ///   11 - G_RESCIND_DT (string)
        ///   12 - O_SALT_DOME_FLAG
        ///   13 - G_SALT_DOME_FLAG
        ///   14 - O_OFFSHORE_CODE
        ///   15 - G_OFFSHORE_CODE
        ///   16 - O_DONT_PERMIT
        ///   17 - G_DONT_PERMIT
        ///   18 - O_NOA_MAN_REV_RULE
        ///   19 - G_NOA_MAN_REV_RULE
        ///   20 - O_COUNTY_NO
        ///   21 - G_COUNTY_NO
        ///   22 - O_DISCOVERY_DT (date)
        ///   23 - G_DISCOVERY_DT (date)
        ///   24 - O_SCHED_REMARKS
        ///   25 - G_SCHED_REMARKS
        ///   26 - O_COMMENTS
        ///   27 - G_COMMENTS
        ///   28 - CREATE_BY
        ///   29 - CREATE_DT (date)
        ///   30 - MODIFY_BY
        ///   31 - MODIFY_DT (date)
        /// </summary>
        public static OgFieldDw CreateFromText(string text, string separator = "}")
        {
            if (string.IsNullOrEmpty(text))
                throw new System.ArgumentNullException(nameof(text), "Input text cannot be null or empty.");

            var parts = text.Split(new[] { separator }, System.StringSplitOptions.None);
            if (parts.Length < 32)
            {
                throw new System.ArgumentException(
                    $"Insufficient fields in input text. Expected at least 32 fields separated by '{separator}'.");
            }

            for (int i = 0; i < parts.Length; i++)
            {
                parts[i] = parts[i].Trim();
            }

            return new OgFieldDw
            {
                FieldNo = parts[0],
                FieldName = parts[1],
                DistrictNo = parts[2],
                DistrictName = parts[3],
                FieldClass = parts[4],
                FieldH2sFlag = parts[5],
                FieldManualRevFlag = parts[6],
                WildcatFlag = parts[7],
                ODerivedRuleTypeCode = parts[8],
                GDerivedRuleTypeCode = parts[9],
                ORescindDt = ParseDate(parts[10]),
                GRescindDt = parts[11],
                OSaltDomeFlag = parts[12],
                GSaltDomeFlag = parts[13],
                OOffshoreCode = parts[14],
                GOffshoreCode = parts[15],
                ODontPermit = parts[16],
                GDontPermit = parts[17],
                ONoaManRevRule = parts[18],
                GNoaManRevRule = parts[19],
                OCountyNo = parts[20],
                GCountyNo = parts[21],
                ODiscoveryDt = ParseDate(parts[22]),
                GDiscoveryDt = ParseDate(parts[23]),
                OSchedRemarks = parts[24],
                GSchedRemarks = parts[25],
                OComments = parts[26],
                GComments = parts[27],
                CreateBy = parts[28],
                CreateDt = ParseDate(parts[29]),
                ModifyBy = parts[30],
                ModifyDt = ParseDate(parts[31])
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the OG_FIELD_DW table using the current property values.
        /// </summary>
        public string ToSqlInsert()
        {
            string valORescindDt = FormatDate(ORescindDt);
            string valODiscoveryDt = FormatDate(ODiscoveryDt);
            string valGDiscoveryDt = FormatDate(GDiscoveryDt);
            string valCreateDt = FormatDate(CreateDt);
            string valModifyDt = FormatDate(ModifyDt);

            return $@"
INSERT INTO OG_FIELD_DW
(
    FIELD_NO,
    FIELD_NAME,
    DISTRICT_NO,
    DISTRICT_NAME,
    FIELD_CLASS,
    FIELD_H2S_FLAG,
    FIELD_MANUAL_REV_FLAG,
    WILDCAT_FLAG,
    O_DERIVED_RULE_TYPE_CODE,
    G_DERIVED_RULE_TYPE_CODE,
    O_RESCIND_DT,
    G_RESCIND_DT,
    O_SALT_DOME_FLAG,
    G_SALT_DOME_FLAG,
    O_OFFSHORE_CODE,
    G_OFFSHORE_CODE,
    O_DONT_PERMIT,
    G_DONT_PERMIT,
    O_NOA_MAN_REV_RULE,
    G_NOA_MAN_REV_RULE,
    O_COUNTY_NO,
    G_COUNTY_NO,
    O_DISCOVERY_DT,
    G_DISCOVERY_DT,
    O_SCHED_REMARKS,
    G_SCHED_REMARKS,
    O_COMMENTS,
    G_COMMENTS,
    CREATE_BY,
    CREATE_DT,
    MODIFY_BY,
    MODIFY_DT
)
VALUES
(
    '{FieldNo}',
    '{FieldName}',
    '{DistrictNo}',
    '{DistrictName}',
    '{FieldClass}',
    '{FieldH2sFlag}',
    '{FieldManualRevFlag}',
    '{WildcatFlag}',
    '{ODerivedRuleTypeCode}',
    '{GDerivedRuleTypeCode}',
    {valORescindDt},
    '{GRescindDt}',
    '{OSaltDomeFlag}',
    '{GSaltDomeFlag}',
    '{OOffshoreCode}',
    '{GOffshoreCode}',
    '{ODontPermit}',
    '{GDontPermit}',
    '{ONoaManRevRule}',
    '{GNoaManRevRule}',
    '{OCountyNo}',
    '{GCountyNo}',
    {valODiscoveryDt},
    {valGDiscoveryDt},
    '{OSchedRemarks}',
    '{GSchedRemarks}',
    '{OComments}',
    '{GComments}',
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
