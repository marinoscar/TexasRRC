using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataParser.Core
{
    public static class Extensions
    {
        public static string ToSql(this string s)
        {
            return s.Replace("'", "''");
        }
    }
}
