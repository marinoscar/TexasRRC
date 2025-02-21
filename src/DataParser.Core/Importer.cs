using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core
{
    public class Importer
    {
        private readonly string _connectionString;
        private readonly ILogger _logger;
        private readonly string _sourceFilePath;

        public Importer(string connectionString, string sourceFilePath, ILogger logger)
        {
            _connectionString = connectionString ?? throw new ArgumentNullException(nameof(connectionString));
            _sourceFilePath = sourceFilePath ?? throw new ArgumentNullException(nameof(sourceFilePath));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }


        private void Execute()
        {
            var file = new FileInfo(_sourceFilePath);
            if (!file.Exists)
            {
                _logger.LogError($"File not found: {_sourceFilePath}");
                return;
            }
            var reader = new FlatFileReader(_logger);
            reader.WhileReadingLine(file, line =>
            {
                var district = GpDistrict.CreateFromText(string.Join("}", parts));
                var sql = district.ToSqlInsert();
                ExecuteSql(sql);
            });

        }
}
