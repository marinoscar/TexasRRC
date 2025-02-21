using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core
{
    public interface IRecordScript
    {
        string ToSqlInsert();
    }
}
