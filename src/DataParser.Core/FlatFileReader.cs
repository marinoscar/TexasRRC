using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core
{
    /// <summary>
    /// Class responsible for reading flat files.
    /// </summary>
    public class FlatFileReader
    {
        private readonly ILogger _logger;

        /// <summary>
        /// Initializes a new instance of the <see cref="FlatFileReader"/> class.
        /// </summary>
        /// <param name="logger">The logger instance.</param>
        /// <exception cref="ArgumentNullException">Thrown when logger is null.</exception>
        public FlatFileReader(ILogger logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        /// <summary>
        /// Reads a file line by line and performs an action on each line.
        /// </summary>
        /// <param name="file">The file to read.</param>
        /// <param name="onLineRead">The action to perform on each line.</param>
        public void WhileReadingLine(FileInfo file, Action<string> onLineRead, bool firstIsHeader = true)
        {
            try
            {
                var isFirst = true;
                using (var reader = new StreamReader(file.FullName))
                {
                    string? line;
                    while ((line = reader.ReadLine()) != null)
                    {
                        if (string.IsNullOrEmpty(line))
                        {
                            _logger.LogWarning("Empty line found in file: {FileName}", file.FullName);
                            continue;
                        }
                        if (isFirst && firstIsHeader)
                            isFirst = false;
                        else
                            onLineRead(line);
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while reading the file line by line.");
                throw;
            }
        }

        /// <summary>
        /// Reads a file record by record, splitting each line by the specified separator, and performs an action on each record.
        /// </summary>
        /// <param name="file">The file to read.</param>
        /// <param name="separator">The separator to use for splitting each line into records.</param>
        /// <param name="onRecordRead">The action to perform on each record.</param>
        public void WhileReadingRecord(FileInfo file, string separator, Action<IEnumerable<string>> onRecordRead)
        {
            try
            {
                WhileReadingLine(file, line =>
                {
                    var record = line.Split(separator);
                    onRecordRead(record);
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while reading the file record by record.");
                throw;
            }
        }
    }
}
