using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class OgLeaseCycleDisp : IRecordScript
    {
        public string OilGasCode { get; set; }             // Index 0
        public string DistrictNo { get; set; }             // Index 1
        public string LeaseNo { get; set; }                // Index 2
        public string CycleYear { get; set; }              // Index 3
        public string CycleMonth { get; set; }             // Index 4
        public string OperatorNo { get; set; }             // Index 5
        public string FieldNo { get; set; }                // Index 6
        public string CycleYearMonth { get; set; }         // Index 7

        public int? LeaseOilDispcd00Vol { get; set; }      // Index 8
        public int? LeaseOilDispcd01Vol { get; set; }      // Index 9
        public int? LeaseOilDispcd02Vol { get; set; }      // Index 10
        public int? LeaseOilDispcd03Vol { get; set; }      // Index 11
        public int? LeaseOilDispcd04Vol { get; set; }      // Index 12
        public int? LeaseOilDispcd05Vol { get; set; }      // Index 13
        public int? LeaseOilDispcd06Vol { get; set; }      // Index 14
        public int? LeaseOilDispcd07Vol { get; set; }      // Index 15
        public int? LeaseOilDispcd08Vol { get; set; }      // Index 16
        public int? LeaseOilDispcd09Vol { get; set; }      // Index 17
        public int? LeaseOilDispcd99Vol { get; set; }      // Index 18

        public int? LeaseGasDispcd01Vol { get; set; }      // Index 19
        public int? LeaseGasDispcd02Vol { get; set; }      // Index 20
        public int? LeaseGasDispcd03Vol { get; set; }      // Index 21
        public int? LeaseGasDispcd04Vol { get; set; }      // Index 22
        public int? LeaseGasDispcd05Vol { get; set; }      // Index 23
        public int? LeaseGasDispcd06Vol { get; set; }      // Index 24
        public int? LeaseGasDispcd07Vol { get; set; }      // Index 25
        public int? LeaseGasDispcd08Vol { get; set; }      // Index 26
        public int? LeaseGasDispcd09Vol { get; set; }      // Index 27
        public int? LeaseGasDispcd99Vol { get; set; }      // Index 28

        public int? LeaseCondDispcd00Vol { get; set; }     // Index 29
        public int? LeaseCondDispcd01Vol { get; set; }     // Index 30
        public int? LeaseCondDispcd02Vol { get; set; }     // Index 31
        public int? LeaseCondDispcd03Vol { get; set; }     // Index 32
        public int? LeaseCondDispcd04Vol { get; set; }     // Index 33
        public int? LeaseCondDispcd05Vol { get; set; }     // Index 34
        public int? LeaseCondDispcd06Vol { get; set; }     // Index 35
        public int? LeaseCondDispcd07Vol { get; set; }     // Index 36
        public int? LeaseCondDispcd08Vol { get; set; }     // Index 37
        public int? LeaseCondDispcd99Vol { get; set; }     // Index 38

        public int? LeaseCsgdDispcde01Vol { get; set; }    // Index 39
        public int? LeaseCsgdDispcde02Vol { get; set; }    // Index 40
        public int? LeaseCsgdDispcde03Vol { get; set; }    // Index 41
        public int? LeaseCsgdDispcde04Vol { get; set; }    // Index 42
        public int? LeaseCsgdDispcde05Vol { get; set; }    // Index 43
        public int? LeaseCsgdDispcde06Vol { get; set; }    // Index 44
        public int? LeaseCsgdDispcde07Vol { get; set; }    // Index 45
        public int? LeaseCsgdDispcde08Vol { get; set; }    // Index 46
        public int? LeaseCsgdDispcde99Vol { get; set; }    // Index 47

        public string DistrictName { get; set; }           // Index 48
        public string LeaseName { get; set; }              // Index 49
        public string OperatorName { get; set; }           // Index 50
        public string FieldName { get; set; }              // Index 51

        /// <summary>
        /// Creates a new OgLeaseCycleDisp instance by splitting the input text using the provided separator.
        /// The default separator is '}'.
        /// Expected fields: 52 (indexes 0..51).
        /// </summary>
        public static OgLeaseCycleDisp CreateFromText(string text, string separator = "}")
        {
            if (string.IsNullOrEmpty(text))
                throw new System.ArgumentNullException(nameof(text), "Input text cannot be null or empty.");

            var parts = text.Split(new[] { separator }, System.StringSplitOptions.None);
            if (parts.Length < 52)
            {
                throw new System.ArgumentException(
                    $"Insufficient fields in input text. Expected at least 52 fields separated by '{separator}'.");
            }

            for (int i = 0; i < parts.Length; i++)
            {
                parts[i] = parts[i].Trim();
            }

            return new OgLeaseCycleDisp
            {
                OilGasCode = parts[0],
                DistrictNo = parts[1],
                LeaseNo = parts[2],
                CycleYear = parts[3],
                CycleMonth = parts[4],
                OperatorNo = parts[5],
                FieldNo = parts[6],
                CycleYearMonth = parts[7],
                LeaseOilDispcd00Vol = ParseInt(parts[8]),
                LeaseOilDispcd01Vol = ParseInt(parts[9]),
                LeaseOilDispcd02Vol = ParseInt(parts[10]),
                LeaseOilDispcd03Vol = ParseInt(parts[11]),
                LeaseOilDispcd04Vol = ParseInt(parts[12]),
                LeaseOilDispcd05Vol = ParseInt(parts[13]),
                LeaseOilDispcd06Vol = ParseInt(parts[14]),
                LeaseOilDispcd07Vol = ParseInt(parts[15]),
                LeaseOilDispcd08Vol = ParseInt(parts[16]),
                LeaseOilDispcd09Vol = ParseInt(parts[17]),
                LeaseOilDispcd99Vol = ParseInt(parts[18]),
                LeaseGasDispcd01Vol = ParseInt(parts[19]),
                LeaseGasDispcd02Vol = ParseInt(parts[20]),
                LeaseGasDispcd03Vol = ParseInt(parts[21]),
                LeaseGasDispcd04Vol = ParseInt(parts[22]),
                LeaseGasDispcd05Vol = ParseInt(parts[23]),
                LeaseGasDispcd06Vol = ParseInt(parts[24]),
                LeaseGasDispcd07Vol = ParseInt(parts[25]),
                LeaseGasDispcd08Vol = ParseInt(parts[26]),
                LeaseGasDispcd09Vol = ParseInt(parts[27]),
                LeaseGasDispcd99Vol = ParseInt(parts[28]),
                LeaseCondDispcd00Vol = ParseInt(parts[29]),
                LeaseCondDispcd01Vol = ParseInt(parts[30]),
                LeaseCondDispcd02Vol = ParseInt(parts[31]),
                LeaseCondDispcd03Vol = ParseInt(parts[32]),
                LeaseCondDispcd04Vol = ParseInt(parts[33]),
                LeaseCondDispcd05Vol = ParseInt(parts[34]),
                LeaseCondDispcd06Vol = ParseInt(parts[35]),
                LeaseCondDispcd07Vol = ParseInt(parts[36]),
                LeaseCondDispcd08Vol = ParseInt(parts[37]),
                LeaseCondDispcd99Vol = ParseInt(parts[38]),
                LeaseCsgdDispcde01Vol = ParseInt(parts[39]),
                LeaseCsgdDispcde02Vol = ParseInt(parts[40]),
                LeaseCsgdDispcde03Vol = ParseInt(parts[41]),
                LeaseCsgdDispcde04Vol = ParseInt(parts[42]),
                LeaseCsgdDispcde05Vol = ParseInt(parts[43]),
                LeaseCsgdDispcde06Vol = ParseInt(parts[44]),
                LeaseCsgdDispcde07Vol = ParseInt(parts[45]),
                LeaseCsgdDispcde08Vol = ParseInt(parts[46]),
                LeaseCsgdDispcde99Vol = ParseInt(parts[47]),
                DistrictName = parts[48],
                LeaseName = parts[49],
                OperatorName = parts[50],
                FieldName = parts[51]
            };
        }

        /// <summary>
        /// Builds an INSERT statement for the OG_LEASE_CYCLE_DISP table using current property values.
        /// </summary>
        public string ToSqlInsert()
        {
            string valLeaseOilDispcd00Vol = FormatInt(LeaseOilDispcd00Vol);
            string valLeaseOilDispcd01Vol = FormatInt(LeaseOilDispcd01Vol);
            string valLeaseOilDispcd02Vol = FormatInt(LeaseOilDispcd02Vol);
            string valLeaseOilDispcd03Vol = FormatInt(LeaseOilDispcd03Vol);
            string valLeaseOilDispcd04Vol = FormatInt(LeaseOilDispcd04Vol);
            string valLeaseOilDispcd05Vol = FormatInt(LeaseOilDispcd05Vol);
            string valLeaseOilDispcd06Vol = FormatInt(LeaseOilDispcd06Vol);
            string valLeaseOilDispcd07Vol = FormatInt(LeaseOilDispcd07Vol);
            string valLeaseOilDispcd08Vol = FormatInt(LeaseOilDispcd08Vol);
            string valLeaseOilDispcd09Vol = FormatInt(LeaseOilDispcd09Vol);
            string valLeaseOilDispcd99Vol = FormatInt(LeaseOilDispcd99Vol);
            string valLeaseGasDispcd01Vol = FormatInt(LeaseGasDispcd01Vol);
            string valLeaseGasDispcd02Vol = FormatInt(LeaseGasDispcd02Vol);
            string valLeaseGasDispcd03Vol = FormatInt(LeaseGasDispcd03Vol);
            string valLeaseGasDispcd04Vol = FormatInt(LeaseGasDispcd04Vol);
            string valLeaseGasDispcd05Vol = FormatInt(LeaseGasDispcd05Vol);
            string valLeaseGasDispcd06Vol = FormatInt(LeaseGasDispcd06Vol);
            string valLeaseGasDispcd07Vol = FormatInt(LeaseGasDispcd07Vol);
            string valLeaseGasDispcd08Vol = FormatInt(LeaseGasDispcd08Vol);
            string valLeaseGasDispcd09Vol = FormatInt(LeaseGasDispcd09Vol);
            string valLeaseGasDispcd99Vol = FormatInt(LeaseGasDispcd99Vol);
            string valLeaseCondDispcd00Vol = FormatInt(LeaseCondDispcd00Vol);
            string valLeaseCondDispcd01Vol = FormatInt(LeaseCondDispcd01Vol);
            string valLeaseCondDispcd02Vol = FormatInt(LeaseCondDispcd02Vol);
            string valLeaseCondDispcd03Vol = FormatInt(LeaseCondDispcd03Vol);
            string valLeaseCondDispcd04Vol = FormatInt(LeaseCondDispcd04Vol);
            string valLeaseCondDispcd05Vol = FormatInt(LeaseCondDispcd05Vol);
            string valLeaseCondDispcd06Vol = FormatInt(LeaseCondDispcd06Vol);
            string valLeaseCondDispcd07Vol = FormatInt(LeaseCondDispcd07Vol);
            string valLeaseCondDispcd08Vol = FormatInt(LeaseCondDispcd08Vol);
            string valLeaseCondDispcd99Vol = FormatInt(LeaseCondDispcd99Vol);
            string valLeaseCsgdDispcde01Vol = FormatInt(LeaseCsgdDispcde01Vol);
            string valLeaseCsgdDispcde02Vol = FormatInt(LeaseCsgdDispcde02Vol);
            string valLeaseCsgdDispcde03Vol = FormatInt(LeaseCsgdDispcde03Vol);
            string valLeaseCsgdDispcde04Vol = FormatInt(LeaseCsgdDispcde04Vol);
            string valLeaseCsgdDispcde05Vol = FormatInt(LeaseCsgdDispcde05Vol);
            string valLeaseCsgdDispcde06Vol = FormatInt(LeaseCsgdDispcde06Vol);
            string valLeaseCsgdDispcde07Vol = FormatInt(LeaseCsgdDispcde07Vol);
            string valLeaseCsgdDispcde08Vol = FormatInt(LeaseCsgdDispcde08Vol);
            string valLeaseCsgdDispcde99Vol = FormatInt(LeaseCsgdDispcde99Vol);

            return $@"
INSERT INTO OG_LEASE_CYCLE_DISP
(
    OIL_GAS_CODE,
    DISTRICT_NO,
    LEASE_NO,
    CYCLE_YEAR,
    CYCLE_MONTH,
    OPERATOR_NO,
    FIELD_NO,
    CYCLE_YEAR_MONTH,
    LEASE_OIL_DISPCD00_VOL,
    LEASE_OIL_DISPCD01_VOL,
    LEASE_OIL_DISPCD02_VOL,
    LEASE_OIL_DISPCD03_VOL,
    LEASE_OIL_DISPCD04_VOL,
    LEASE_OIL_DISPCD05_VOL,
    LEASE_OIL_DISPCD06_VOL,
    LEASE_OIL_DISPCD07_VOL,
    LEASE_OIL_DISPCD08_VOL,
    LEASE_OIL_DISPCD09_VOL,
    LEASE_OIL_DISPCD99_VOL,
    LEASE_GAS_DISPCD01_VOL,
    LEASE_GAS_DISPCD02_VOL,
    LEASE_GAS_DISPCD03_VOL,
    LEASE_GAS_DISPCD04_VOL,
    LEASE_GAS_DISPCD05_VOL,
    LEASE_GAS_DISPCD06_VOL,
    LEASE_GAS_DISPCD07_VOL,
    LEASE_GAS_DISPCD08_VOL,
    LEASE_GAS_DISPCD09_VOL,
    LEASE_GAS_DISPCD99_VOL,
    LEASE_COND_DISPCD00_VOL,
    LEASE_COND_DISPCD01_VOL,
    LEASE_COND_DISPCD02_VOL,
    LEASE_COND_DISPCD03_VOL,
    LEASE_COND_DISPCD04_VOL,
    LEASE_COND_DISPCD05_VOL,
    LEASE_COND_DISPCD06_VOL,
    LEASE_COND_DISPCD07_VOL,
    LEASE_COND_DISPCD08_VOL,
    LEASE_COND_DISPCD99_VOL,
    LEASE_CSGD_DISPCDE01_VOL,
    LEASE_CSGD_DISPCDE02_VOL,
    LEASE_CSGD_DISPCDE03_VOL,
    LEASE_CSGD_DISPCDE04_VOL,
    LEASE_CSGD_DISPCDE05_VOL,
    LEASE_CSGD_DISPCDE06_VOL,
    LEASE_CSGD_DISPCDE07_VOL,
    LEASE_CSGD_DISPCDE08_VOL,
    LEASE_CSGD_DISPCDE99_VOL,
    DISTRICT_NAME,
    LEASE_NAME,
    OPERATOR_NAME,
    FIELD_NAME
)
VALUES
(
    '{OilGasCode}',
    '{DistrictNo}',
    '{LeaseNo}',
    '{CycleYear}',
    '{CycleMonth}',
    '{OperatorNo}',
    '{FieldNo}',
    '{CycleYearMonth}',
    {valLeaseOilDispcd00Vol},
    {valLeaseOilDispcd01Vol},
    {valLeaseOilDispcd02Vol},
    {valLeaseOilDispcd03Vol},
    {valLeaseOilDispcd04Vol},
    {valLeaseOilDispcd05Vol},
    {valLeaseOilDispcd06Vol},
    {valLeaseOilDispcd07Vol},
    {valLeaseOilDispcd08Vol},
    {valLeaseOilDispcd09Vol},
    {valLeaseOilDispcd99Vol},
    {valLeaseGasDispcd01Vol},
    {valLeaseGasDispcd02Vol},
    {valLeaseGasDispcd03Vol},
    {valLeaseGasDispcd04Vol},
    {valLeaseGasDispcd05Vol},
    {valLeaseGasDispcd06Vol},
    {valLeaseGasDispcd07Vol},
    {valLeaseGasDispcd08Vol},
    {valLeaseGasDispcd09Vol},
    {valLeaseGasDispcd99Vol},
    {valLeaseCondDispcd00Vol},
    {valLeaseCondDispcd01Vol},
    {valLeaseCondDispcd02Vol},
    {valLeaseCondDispcd03Vol},
    {valLeaseCondDispcd04Vol},
    {valLeaseCondDispcd05Vol},
    {valLeaseCondDispcd06Vol},
    {valLeaseCondDispcd07Vol},
    {valLeaseCondDispcd08Vol},
    {valLeaseCondDispcd99Vol},
    {valLeaseCsgdDispcde01Vol},
    {valLeaseCsgdDispcde02Vol},
    {valLeaseCsgdDispcde03Vol},
    {valLeaseCsgdDispcde04Vol},
    {valLeaseCsgdDispcde05Vol},
    {valLeaseCsgdDispcde06Vol},
    {valLeaseCsgdDispcde07Vol},
    {valLeaseCsgdDispcde08Vol},
    {valLeaseCsgdDispcde99Vol},
    '{DistrictName}',
    '{LeaseName}',
    '{OperatorName}',
    '{FieldName}'
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
