using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core
{
    /// <summary>
    /// Class responsible for loading batch data from files in a specified directory.
    /// </summary>
    public class BatchLoader
    {
        private readonly ILogger _logger;
        private readonly string _connectionString;
        private readonly List<Task> _tasks = new List<Task>();

        /// <summary>
        /// Initializes a new instance of the <see cref="BatchLoader"/> class.
        /// </summary>
        /// <param name="connectionString">The connection string to the database.</param>
        /// <param name="logger">The logger instance for logging information.</param>
        /// <exception cref="ArgumentNullException">Thrown when connectionString or logger is null.</exception>
        public BatchLoader(string connectionString, ILogger logger)
        {
            _connectionString = connectionString ?? throw new ArgumentNullException(nameof(connectionString));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        /// <summary>
        /// Loads data from files in the specified folder.
        /// </summary>
        /// <param name="folderName">The name of the folder containing the files.</param>
        /// <param name="filter">The file filter to apply when searching for files. Default is "*.dsv".</param>
        /// <exception cref="DirectoryNotFoundException">Thrown when the specified directory does not exist.</param>
        public void LoadData(string folderName, string filter = "*.dsv")
        {
            try
            {
                var sessionId = Guid.NewGuid().ToString();
                var sw = new Stopwatch();
                sw.Start();
                _logger.LogInformation("Starting data load from folder: {FolderName}", folderName);

                var directory = new DirectoryInfo(folderName);
                if (!directory.Exists)
                {
                    _logger.LogError("Directory not found: {FolderName}", folderName);
                    throw new DirectoryNotFoundException($"Directory not found: {folderName}");
                }

                var files = directory.GetFiles("*.dsv", SearchOption.AllDirectories).ToList();
                var wellFile = GetWellFile(directory);
                if(wellFile != null)
                {
                    files.Insert(0, wellFile);

                }
                foreach (var file in files)
                {
                    _tasks.Add(Task.Run(() => LoadFile(file, sessionId)));
                }
                Task.WaitAll(_tasks.ToArray());
                _logger.LogInformation("Data load completed successfully.");
                sw.Stop();
                _logger.LogInformation("Elapsed time: {Elapsed}", sw.Elapsed);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while loading data.");
                throw;
            }
        }

        private FileInfo GetWellFile(DirectoryInfo directory)
        {
            return directory.GetFiles("*.csv").OrderByDescending(f => f.LastWriteTime).FirstOrDefault();
        }

        private void LoadFile(FileInfo file, string sessionId)
        {
            _logger.LogInformation("Processing file: {FileName}", file.FullName);
            var importer = new Importer(_connectionString, file.FullName, _logger);
            importer.Execute(sessionId);
        }
    }
}
