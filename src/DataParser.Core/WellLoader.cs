using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core
{
    public class WellLoader
    {
        private readonly string _connectionString;
        private readonly string _sourceFilePath;
        private readonly ILogger _logger;

        public WellLoader(string connectionString, string sourceFilePath, ILogger logger)
        {
            _connectionString = connectionString ?? throw new ArgumentNullException(nameof(connectionString));
            _sourceFilePath = sourceFilePath ?? throw new ArgumentNullException(nameof(sourceFilePath));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public void Load()
        {
            var importer = new Importer(_connectionString, _sourceFilePath, _logger);
            importer.Execute(Guid.NewGuid().ToString());
        }

    }
}
