using DataParser.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core
{
    public class ImporterFactory
    {
        private readonly Dictionary<string, Func<string, string>> _factory = [];

        public ImporterFactory()
        {
            Load();
        }

        public Func<string, string> Get(string fileName)
        {
            if (!_factory.ContainsKey(fileName))
            {
                throw new ArgumentException($"No importer found for file: {fileName}");
            }
            return _factory[fileName];
        }

        private void Load() {
            _factory.Add("GP_COUNTY_DATA_TABLE.dsv", (text) => GpCounty.CreateFromText(text).ToSqlInsert());
            _factory.Add("GP_DATE_RANGE_CYCLE_DATA_TABLE.dsv", (text) => GpDateRangeCycle.CreateFromText(text).ToSqlInsert());
            _factory.Add("GP_DISTRICT_DATA_TABLE.dsv", (text) => GpDistrict.CreateFromText(text).ToSqlInsert());
            _factory.Add("OG_COUNTY_CYCLE_DATA_TABLE.dsv", (text) => OgCountyCycle.CreateFromText(text).ToSqlInsert());
            _factory.Add("OG_COUNTY_LEASE_CYCLE_DATA_TABLE.dsv", (text) => OgCountyLeaseCycle.CreateFromText(text).ToSqlInsert());
            _factory.Add("OG_DISTRICT_CYCLE_DATA_TABLE.dsv", (text) => OgDistrictCycle.CreateFromText(text).ToSqlInsert());
            _factory.Add("OG_FIELD_CYCLE_DATA_TABLE.dsv", (text) => OgFieldCycle.CreateFromText(text).ToSqlInsert());
            _factory.Add("OG_FIELD_DW_DATA_TABLE.dsv", (text) => OgFieldDw.CreateFromText(text).ToSqlInsert());
            _factory.Add("OG_LEASE_CYCLE_DATA_TABLE.dsv", (text) => OgLeaseCycle.CreateFromText(text).ToSqlInsert());
            _factory.Add("OG_LEASE_CYCLE_DISP_DATA_TABLE.dsv", (text) => OgLeaseCycleDisp.CreateFromText(text).ToSqlInsert());
            _factory.Add("OG_OPERATOR_CYCLE_DATA_TABLE.dsv", (text) => OgOperatorCycle.CreateFromText(text).ToSqlInsert());
            _factory.Add("OG_OPERATOR_DW_DATA_TABLE.dsv", (text) => OgOperatorDw.CreateFromText(text).ToSqlInsert());
            _factory.Add("OG_REGULATORY_LEASE_DW_DATA_TABLE.dsv", (text) => OgRegulatoryLeaseDw.CreateFromText(text).ToSqlInsert());
            _factory.Add("OG_SUMMARY_MASTER_LARGE_DATA_TABLE.dsv", (text) => OgSummaryMasterLarge.CreateFromText(text).ToSqlInsert());
            _factory.Add("OG_SUMMARY_ONSHORE_LEASE_DATA_TABLE.dsv", (text) => OgSummaryOnshoreLease.CreateFromText(text).ToSqlInsert());
            _factory.Add("OG_WELL_COMPLETION_DATA_TABLE.dsv", (text) => OgWellCompletion.CreateFromText(text).ToSqlInsert());
        }
    }
}
