using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core.Entities
{
    public class SessionState
    {
        public string SessionId { get; set; } = Guid.NewGuid().ToString();
        public List<FileState> Files { get; set; } = new List<FileState>();

        public string Exception { get; set; } = string.Empty;
    }

    public class FileState
    {
        public string FileName { get; set; }

        public ulong RecordCount { get; set; } = 0;
        
        public bool HasHeader { get; set; } = true;

        public bool IsCompleted { get; set; } = false;
    }
}
