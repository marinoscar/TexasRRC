using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{

    public class OGWellboreEwa : IRecordScript
    {
        // --------------------------------------------------------------------
        // 1) Properties corresponding to table columns
        // --------------------------------------------------------------------

        public short DistrictCode { get; set; }              // (1)
        public short CountyCode { get; set; }                // (2)
        public string ApiNo { get; set; }                    // (3)
        public string CountyName { get; set; }               // (4)
        public string OilGasCode { get; set; }               // (5)
        public string LeaseName { get; set; }                // (6)
        public string FieldNumber { get; set; }              // (7)
        public string FieldName { get; set; }                // (8)
        public string LeaseNumber { get; set; }              // (9)
        public string WellNoDisplay { get; set; }            // (10)
        public string OilUnitNumber { get; set; }            // (11)
        public string OperatorName { get; set; }             // (12)
        public string OperatorNumber { get; set; }           // (13)
        public string WbWaterLandCode { get; set; }          // (14)
        public string MultiCompFlag { get; set; }            // (15)
        public decimal ApiDepth { get; set; }                // (16)
        public DateTime? WbShutInDate { get; set; }          // (17)
        public string Wb14B2Flag { get; set; }               // (18)
        public string WellTypeName { get; set; }             // (19)
        public DateTime? WlShutInDate { get; set; }          // (20)
        public DateTime? PlugDate { get; set; }              // (21)
        public string PlugLeaseName { get; set; }            // (22)
        public string PlugOperatorName { get; set; }         // (23)
        public string RecentPermit { get; set; }             // (24)
        public string RecentPermitLeaseName { get; set; }    // (25)
        public string RecentPermitOperatorNo { get; set; }   // (26)
        public string OnSchedule { get; set; }               // (27)
        public int OgWellboreEwaId { get; set; }             // (28) Not an identity in this version
        public DateTime? W2G1FiledDate { get; set; }         // (29)
        public DateTime? W2G1Date { get; set; }              // (30)
        public DateTime? CompletionDate { get; set; }        // (31)
        public DateTime? W3FileDate { get; set; }            // (32)
        public string CreatedBy { get; set; }                // (33)
        public DateTime? CreatedDt { get; set; }             // (34)
        public string ModifiedBy { get; set; }               // (35)
        public DateTime? ModifiedDt { get; set; }            // (36)
        public string WellNo { get; set; }                   // (37)
        public byte P5RenewalMonth { get; set; }             // (38)
        public short P5RenewalYear { get; set; }             // (39)
        public string P5OrgStatus { get; set; }              // (40)
        public int CurrInactYrs { get; set; }                // (41)
        public int CurrInactMos { get; set; }                // (42)
        public string Wl14B2ExtStatus { get; set; }          // (43)
        public string Wl14B2MechInteg { get; set; }          // (44)
        public string Wl14B2PlgOrdSf { get; set; }           // (45)
        public string Wl14B2Pollution { get; set; }          // (46)
        public string Wl14B2FldopsHold { get; set; }         // (47)
        public string Wl14B2H15Prob { get; set; }            // (48)
        public string Wl14B2H15Delq { get; set; }            // (49)
        public string Wl14B2OperDelq { get; set; }           // (50)
        public string Wl14B2DistSfp { get; set; }            // (51)
        public string Wl14B2DistSfClnup { get; set; }        // (52)
        public string Wl14B2DistStPlg { get; set; }          // (53)
        public string Wl14B2GoodFaith { get; set; }          // (54)
        public string Wl14B2WellOther { get; set; }          // (55)
        public string SurfEqpViol { get; set; }              // (56)
        public string W3XViol { get; set; }                  // (57)
        public string H15StatusCode { get; set; }            // (58)
        public DateTime? OrigCompletionDate { get; set; }    // (59)

        // --------------------------------------------------------------------
        // 2) CreateFromText: builds an instance from a CSV line
        // --------------------------------------------------------------------
        public static OGWellboreEwa CreateFromText(string text, string separator = ",")
        {
            if (string.IsNullOrEmpty(text))
                throw new ArgumentNullException(nameof(text), "Input CSV line cannot be null or empty.");

            // Split by the chosen separator
            string[] tokens = text.Split(new[] { separator }, StringSplitOptions.None)
                .Select(i => i.Trim().ToSql().Replace(@"""", "")).ToArray();

            // We expect 59 fields
            if (tokens.Length < 59)
            {
                throw new ArgumentException($"Expected 59 columns in the CSV line, but got {tokens.Length}.");
            }

            var entity = new OGWellboreEwa
            {
                DistrictCode = ParseShort(tokens[0]),
                CountyCode = ParseShort(tokens[1]),
                ApiNo = tokens[2],
                CountyName = tokens[3],
                OilGasCode = tokens[4],
                LeaseName = tokens[5],
                FieldNumber = tokens[6],
                FieldName = tokens[7],
                LeaseNumber = tokens[8],
                WellNoDisplay = tokens[9],
                OilUnitNumber = tokens[10],
                OperatorName = tokens[11],
                OperatorNumber = tokens[12],
                WbWaterLandCode = tokens[13],
                MultiCompFlag = tokens[14],
                ApiDepth = ParseDecimal(tokens[15]),
                WbShutInDate = ParseDateTime(tokens[16]),
                Wb14B2Flag = tokens[17],
                WellTypeName = tokens[18],
                WlShutInDate = ParseDateTime(tokens[19]),
                PlugDate = ParseDateTime(tokens[20]),
                PlugLeaseName = tokens[21],
                PlugOperatorName = tokens[22],
                RecentPermit = tokens[23],
                RecentPermitLeaseName = tokens[24],
                RecentPermitOperatorNo = tokens[25],
                OnSchedule = tokens[26],
                OgWellboreEwaId = ParseInt(tokens[27]),
                W2G1FiledDate = ParseDateTime(tokens[28]),
                W2G1Date = ParseDateTime(tokens[29]),
                CompletionDate = ParseDateTime(tokens[30]),
                W3FileDate = ParseDateTime(tokens[31]),
                CreatedBy = tokens[32],
                CreatedDt = ParseDateTime(tokens[33]),
                ModifiedBy = tokens[34],
                ModifiedDt = ParseDateTime(tokens[35]),
                WellNo = tokens[36],
                P5RenewalMonth = ParseByte(tokens[37]),
                P5RenewalYear = ParseShort(tokens[38]),
                P5OrgStatus = tokens[39],
                CurrInactYrs = ParseInt(tokens[40]),
                CurrInactMos = ParseInt(tokens[41]),
                Wl14B2ExtStatus = tokens[42],
                Wl14B2MechInteg = tokens[43],
                Wl14B2PlgOrdSf = tokens[44],
                Wl14B2Pollution = tokens[45],
                Wl14B2FldopsHold = tokens[46],
                Wl14B2H15Prob = tokens[47],
                Wl14B2H15Delq = tokens[48],
                Wl14B2OperDelq = tokens[49],
                Wl14B2DistSfp = tokens[50],
                Wl14B2DistSfClnup = tokens[51],
                Wl14B2DistStPlg = tokens[52],
                Wl14B2GoodFaith = tokens[53],
                Wl14B2WellOther = tokens[54],
                SurfEqpViol = tokens[55],
                W3XViol = tokens[56],
                H15StatusCode = tokens[57],
                OrigCompletionDate = ParseDateTime(tokens[58])
            };

            return entity;
        }

        // --------------------------------------------------------------------
        // 3) ToSqlInsert: returns an INSERT statement for the table
        //    Now includes inline comments referencing CSV index + property name
        // --------------------------------------------------------------------
        public string ToSqlInsert()
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("INSERT INTO [dbo].[OG_WELLBORE_EWA] (");
            sb.AppendLine("    DISTRICT_CODE,");
            sb.AppendLine("    COUNTY_CODE,");
            sb.AppendLine("    API_NO,");
            sb.AppendLine("    COUNTY_NAME,");
            sb.AppendLine("    OIL_GAS_CODE,");
            sb.AppendLine("    LEASE_NAME,");
            sb.AppendLine("    FIELD_NUMBER,");
            sb.AppendLine("    FIELD_NAME,");
            sb.AppendLine("    LEASE_NUMBER,");
            sb.AppendLine("    WELL_NO_DISPLAY,");
            sb.AppendLine("    OIL_UNIT_NUMBER,");
            sb.AppendLine("    OPERATOR_NAME,");
            sb.AppendLine("    OPERATOR_NUMBER,");
            sb.AppendLine("    WB_WATER_LAND_CODE,");
            sb.AppendLine("    MULTI_COMP_FLAG,");
            sb.AppendLine("    API_DEPTH,");
            sb.AppendLine("    WB_SHUT_IN_DATE,");
            sb.AppendLine("    WB_14B2_FLAG,");
            sb.AppendLine("    WELL_TYPE_NAME,");
            sb.AppendLine("    WL_SHUT_IN_DATE,");
            sb.AppendLine("    PLUG_DATE,");
            sb.AppendLine("    PLUG_LEASE_NAME,");
            sb.AppendLine("    PLUG_OPERATOR_NAME,");
            sb.AppendLine("    RECENT_PERMIT,");
            sb.AppendLine("    RECENT_PERMIT_LEASE_NAME,");
            sb.AppendLine("    RECENT_PERMIT_OPERATOR_NO,");
            sb.AppendLine("    ON_SCHEDULE,");
            sb.AppendLine("    OG_WELLBORE_EWA_ID,");
            sb.AppendLine("    W2_G1_FILED_DATE,");
            sb.AppendLine("    W2_G1_DATE,");
            sb.AppendLine("    COMPLETION_DATE,");
            sb.AppendLine("    W3_FILE_DATE,");
            sb.AppendLine("    CREATED_BY,");
            sb.AppendLine("    CREATED_DT,");
            sb.AppendLine("    MODIFIED_BY,");
            sb.AppendLine("    MODIFIED_DT,");
            sb.AppendLine("    WELL_NO,");
            sb.AppendLine("    P5_RENEWAL_MONTH,");
            sb.AppendLine("    P5_RENEWAL_YEAR,");
            sb.AppendLine("    P5_ORG_STATUS,");
            sb.AppendLine("    CURR_INACT_YRS,");
            sb.AppendLine("    CURR_INACT_MOS,");
            sb.AppendLine("    WL_14B2_EXT_STATUS,");
            sb.AppendLine("    WL_14B2_MECH_INTEG,");
            sb.AppendLine("    WL_14B2_PLG_ORD_SF,");
            sb.AppendLine("    WL_14B2_POLLUTION,");
            sb.AppendLine("    WL_14B2_FLDOPS_HOLD,");
            sb.AppendLine("    WL_14B2_H15_PROB,");
            sb.AppendLine("    WL_14B2_H15_DELQ,");
            sb.AppendLine("    WL_14B2_OPER_DELQ,");
            sb.AppendLine("    WL_14B2_DIST_SFP,");
            sb.AppendLine("    WL_14B2_DIST_SF_CLNUP,");
            sb.AppendLine("    WL_14B2_DIST_ST_PLG,");
            sb.AppendLine("    WL_14B2_GOOD_FAITH,");
            sb.AppendLine("    WL_14B2_WELL_OTHER,");
            sb.AppendLine("    SURF_EQP_VIOL,");
            sb.AppendLine("    W3X_VIOL,");
            sb.AppendLine("    H15_STATUS_CODE,");
            sb.AppendLine("    ORIG_COMPLETION_DT");
            sb.AppendLine(") VALUES (");

            // Each line includes a trailing comma (except the last) plus a comment
            // referencing CSV index + property name.

            sb.AppendLine($"    {FormatShort(DistrictCode)},  -- CSV[0] DistrictCode");
            sb.AppendLine($"    {FormatShort(CountyCode)},   -- CSV[1] CountyCode");
            sb.AppendLine($"    {FormatString(ApiNo)},       -- CSV[2] ApiNo");
            sb.AppendLine($"    {FormatString(CountyName)},  -- CSV[3] CountyName");
            sb.AppendLine($"    {FormatString(OilGasCode)},  -- CSV[4] OilGasCode");
            sb.AppendLine($"    {FormatString(LeaseName)},   -- CSV[5] LeaseName");
            sb.AppendLine($"    {FormatString(FieldNumber)}, -- CSV[6] FieldNumber");
            sb.AppendLine($"    {FormatString(FieldName)},   -- CSV[7] FieldName");
            sb.AppendLine($"    {FormatString(LeaseNumber)}, -- CSV[8] LeaseNumber");
            sb.AppendLine($"    {FormatString(WellNoDisplay)}, -- CSV[9] WellNoDisplay");
            sb.AppendLine($"    {FormatString(OilUnitNumber)}, -- CSV[10] OilUnitNumber");
            sb.AppendLine($"    {FormatString(OperatorName)}, -- CSV[11] OperatorName");
            sb.AppendLine($"    {FormatString(OperatorNumber)}, -- CSV[12] OperatorNumber");
            sb.AppendLine($"    {FormatString(WbWaterLandCode)}, -- CSV[13] WbWaterLandCode");
            sb.AppendLine($"    {FormatString(MultiCompFlag)}, -- CSV[14] MultiCompFlag");
            sb.AppendLine($"    {FormatDecimal(ApiDepth)},   -- CSV[15] ApiDepth");
            sb.AppendLine($"    {FormatDate(WbShutInDate)},  -- CSV[16] WbShutInDate");
            sb.AppendLine($"    {FormatString(Wb14B2Flag)},  -- CSV[17] Wb14B2Flag");
            sb.AppendLine($"    {FormatString(WellTypeName)}, -- CSV[18] WellTypeName");
            sb.AppendLine($"    {FormatDate(WlShutInDate)},  -- CSV[19] WlShutInDate");
            sb.AppendLine($"    {FormatDate(PlugDate)},      -- CSV[20] PlugDate");
            sb.AppendLine($"    {FormatString(PlugLeaseName)}, -- CSV[21] PlugLeaseName");
            sb.AppendLine($"    {FormatString(PlugOperatorName)}, -- CSV[22] PlugOperatorName");
            sb.AppendLine($"    {FormatString(RecentPermit)}, -- CSV[23] RecentPermit");
            sb.AppendLine($"    {FormatString(RecentPermitLeaseName)}, -- CSV[24] RecentPermitLeaseName");
            sb.AppendLine($"    {FormatString(RecentPermitOperatorNo)}, -- CSV[25] RecentPermitOperatorNo");
            sb.AppendLine($"    {FormatString(OnSchedule)},  -- CSV[26] OnSchedule");
            sb.AppendLine($"    {FormatInt(OgWellboreEwaId)}, -- CSV[27] OgWellboreEwaId");
            sb.AppendLine($"    {FormatDate(W2G1FiledDate)}, -- CSV[28] W2G1FiledDate");
            sb.AppendLine($"    {FormatDate(W2G1Date)},      -- CSV[29] W2G1Date");
            sb.AppendLine($"    {FormatDate(CompletionDate)}, -- CSV[30] CompletionDate");
            sb.AppendLine($"    {FormatDate(W3FileDate)},    -- CSV[31] W3FileDate");
            sb.AppendLine($"    {FormatString(CreatedBy)},   -- CSV[32] CreatedBy");
            sb.AppendLine($"    {FormatDateTime(CreatedDt)}, -- CSV[33] CreatedDt");
            sb.AppendLine($"    {FormatString(ModifiedBy)},  -- CSV[34] ModifiedBy");
            sb.AppendLine($"    {FormatDateTime(ModifiedDt)}, -- CSV[35] ModifiedDt");
            sb.AppendLine($"    {FormatString(WellNo)},      -- CSV[36] WellNo");
            sb.AppendLine($"    {FormatByte(P5RenewalMonth)}, -- CSV[37] P5RenewalMonth");
            sb.AppendLine($"    {FormatShort(P5RenewalYear)}, -- CSV[38] P5RenewalYear");
            sb.AppendLine($"    {FormatString(P5OrgStatus)}, -- CSV[39] P5OrgStatus");
            sb.AppendLine($"    {FormatInt(CurrInactYrs)},   -- CSV[40] CurrInactYrs");
            sb.AppendLine($"    {FormatInt(CurrInactMos)},   -- CSV[41] CurrInactMos");
            sb.AppendLine($"    {FormatString(Wl14B2ExtStatus)}, -- CSV[42] Wl14B2ExtStatus");
            sb.AppendLine($"    {FormatString(Wl14B2MechInteg)}, -- CSV[43] Wl14B2MechInteg");
            sb.AppendLine($"    {FormatString(Wl14B2PlgOrdSf)}, -- CSV[44] Wl14B2PlgOrdSf");
            sb.AppendLine($"    {FormatString(Wl14B2Pollution)}, -- CSV[45] Wl14B2Pollution");
            sb.AppendLine($"    {FormatString(Wl14B2FldopsHold)}, -- CSV[46] Wl14B2FldopsHold");
            sb.AppendLine($"    {FormatString(Wl14B2H15Prob)}, -- CSV[47] Wl14B2H15Prob");
            sb.AppendLine($"    {FormatString(Wl14B2H15Delq)}, -- CSV[48] Wl14B2H15Delq");
            sb.AppendLine($"    {FormatString(Wl14B2OperDelq)}, -- CSV[49] Wl14B2OperDelq");
            sb.AppendLine($"    {FormatString(Wl14B2DistSfp)}, -- CSV[50] Wl14B2DistSfp");
            sb.AppendLine($"    {FormatString(Wl14B2DistSfClnup)}, -- CSV[51] Wl14B2DistSfClnup");
            sb.AppendLine($"    {FormatString(Wl14B2DistStPlg)}, -- CSV[52] Wl14B2DistStPlg");
            sb.AppendLine($"    {FormatString(Wl14B2GoodFaith)}, -- CSV[53] Wl14B2GoodFaith");
            sb.AppendLine($"    {FormatString(Wl14B2WellOther)}, -- CSV[54] Wl14B2WellOther");
            sb.AppendLine($"    {FormatString(SurfEqpViol)},   -- CSV[55] SurfEqpViol");
            sb.AppendLine($"    {FormatString(W3XViol)},       -- CSV[56] W3XViol");
            sb.AppendLine($"    {FormatString(H15StatusCode)}, -- CSV[57] H15StatusCode");
            // No trailing comma on the very last line
            sb.AppendLine($"    {FormatDate(OrigCompletionDate)} -- CSV[58] OrigCompletionDate");
            sb.AppendLine(");");

            return sb.ToString();
        }

        // --------------------------------------------------------------------
        // Helper Parsing methods
        // --------------------------------------------------------------------
        private static short ParseShort(string s)
        {
            return short.TryParse(s, out short val) ? val : (short)0;
        }

        private static int ParseInt(string s)
        {
            return int.TryParse(s, out int val) ? val : 0;
        }

        private static decimal ParseDecimal(string s)
        {
            return decimal.TryParse(s, out decimal val) ? val : 0m;
        }

        private static DateTime? ParseDateTime(string s)
        {
            return DateTime.TryParse(s, out DateTime dt) ? dt : (DateTime?)null;
        }

        private static byte ParseByte(string s)
        {
            return byte.TryParse(s, out byte val) ? val : (byte)0;
        }

        // --------------------------------------------------------------------
        // Formatting helpers for the INSERT statement
        // --------------------------------------------------------------------
        private static string FormatShort(short value)
        {
            // If you consider 0 a valid value, remove or alter the "NULL" fallback.
            return value == 0 ? "NULL" : value.ToString();
        }

        private static string FormatInt(int value)
        {
            return value == 0 ? "NULL" : value.ToString();
        }

        private static string FormatByte(byte value)
        {
            return value == 0 ? "NULL" : value.ToString();
        }

        private static string FormatDecimal(decimal value)
        {
            // Adjust if 0.0 is valid. 
            // Currently just outputs the numeric value as "0.##"
            // If you want 0 => "NULL", do: return value == 0m ? "NULL" : value.ToString("0.##");
            return value.ToString("0.##");
        }

        private static string FormatString(string s)
        {
            if (string.IsNullOrEmpty(s))
                return "NULL";
            // Escape single quotes
            s = s.Replace("'", "''");
            return $"'{s}'";
        }

        private static string FormatDate(DateTime? dt)
        {
            if (!dt.HasValue) return "NULL";
            return $"'{dt.Value:yyyy-MM-dd}'";
        }

        private static string FormatDateTime(DateTime? dt)
        {
            if (!dt.HasValue) return "NULL";
            return $"'{dt.Value:yyyy-MM-dd HH:mm:ss}'";
        }
    }
}


