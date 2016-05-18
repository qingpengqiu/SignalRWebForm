
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    public partial class BlogGroup : SQLHelper
    {
        public string UserSelect(int iduser, int defaultValue)
        {
            int page_count = 0;
            List<BlogGroupInfo> list = PageList(1, 100, "WHERE idUser=" + iduser, "ORDER BY cTitle", out page_count);
            if (page_count == 0) return "";

            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<select id=\"idPersonGroup\" name=\"idPersonGroup\" onchange=\"UpdateHistory(this)\">");
            foreach (BlogGroupInfo bv in list)
            {
                if (defaultValue == bv.id)
                {
                    sb.AppendLine("<option selected value=\"" + bv.id + "\">" + bv.cTitle + "</option>");
                }
                else
                {
                    sb.AppendLine("<option value=\"" + bv.id + "\">" + bv.cTitle + "</option>");
                }
            }
            sb.AppendLine("</select>");
            return sb.ToString();
        }
    }
}
