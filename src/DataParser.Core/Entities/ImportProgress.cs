using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class ImportProgress
    {
        public int ID { get; set; }
        public string SessionID { get; set; }
        public string FileName { get; set; }
        public string Status { get; set; }
        public decimal Progress { get; set; }
        public long TotalBytes { get; set; }
        public DateTime? StartTime { get; set; }
        public DateTime? EndTime { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public DateTime UpdatedAt { get; set; } = DateTime.Now;

        public string ToSqlInsert()
        {
            return $@"
        INSERT INTO ImportProgress (SessionID, FileName, Status, Progress, TotalBytes, StartTime, EndTime, CreatedAt, UpdatedAt)
        VALUES ('{SessionID}', '{FileName}', '{Status}', {Progress}, {TotalBytes}, 
                {(StartTime.HasValue ? $"'{StartTime.Value:yyyy-MM-dd HH:mm:ss}'" : "NULL")}, 
                {(EndTime.HasValue ? $"'{EndTime.Value:yyyy-MM-dd HH:mm:ss}'" : "NULL")}, 
                '{CreatedAt:yyyy-MM-dd HH:mm:ss}', '{UpdatedAt:yyyy-MM-dd HH:mm:ss}');
        ";
        }

        public string ToSqlUpdate()
        {
            return $@"
        UPDATE ImportProgress
        SET Status = '{Status}', 
            Progress = {Progress}, 
            TotalBytes = {TotalBytes},
            StartTime = {(StartTime.HasValue ? $"'{StartTime.Value:yyyy-MM-dd HH:mm:ss}'" : "NULL")}, 
            EndTime = {(EndTime.HasValue ? $"'{EndTime.Value:yyyy-MM-dd HH:mm:ss}'" : "NULL")}, 
            UpdatedAt = '{DateTime.Now:yyyy-MM-dd HH:mm:ss}'
        WHERE SessionID = '{SessionID}' AND FileName = '{FileName}';
        ";
        }
    }
}
