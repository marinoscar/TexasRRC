using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Data;
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
        private readonly ImporterFactory _importerFactory;

        public Importer(string connectionString, string sourceFilePath, ILogger logger)
        {
            _connectionString = connectionString ?? throw new ArgumentNullException(nameof(connectionString));
            _sourceFilePath = sourceFilePath ?? throw new ArgumentNullException(nameof(sourceFilePath));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _importerFactory = new ImporterFactory();
        }

        /// <summary>
        /// Executes the import process by reading the source file and running SQL commands.
        /// </summary>
        public void Execute()
        {
            try
            {
                var file = new FileInfo(_sourceFilePath);
                if (!file.Exists)
                {
                    _logger.LogError($"File not found: {_sourceFilePath}");
                    return;
                }

                var action = _importerFactory.Get(file.Name);
                var reader = new FlatFileReader(_logger);
                var sb = new StringBuilder();
                var counter = 0;

                using (var conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                    reader.WhileReadingLine(file, line =>
                    {
                        sb.AppendLine(action(line));
                        counter++;
                        if (counter > 10)
                        {
                            RunSql(sb.ToString(), conn);
                            counter = 0;
                            sb.Clear();
                        }
                    });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred during the import process.");
                throw;
            }
        }

        /// <summary>
        /// Executes the given SQL command using the provided database connection.
        /// </summary>
        /// <param name="command">The SQL command to execute.</param>
        /// <param name="connection">The database connection to use.</param>
        private void RunSql(string command, IDbConnection connection)
        {
            try
            {
                using (var cmd = connection.CreateCommand())
                {
                    cmd.CommandText = command;
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while executing the SQL command.");
                throw;
            }
        }
    }
}
