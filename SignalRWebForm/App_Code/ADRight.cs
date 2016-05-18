using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
/// <summary>
/// ADRight 的摘要说明
/// </summary>
public class ADRight
{
    public ADRight()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }

    public string ADList(int idCode, int idPosition, int multi)
    {
        StringBuilder sb = new StringBuilder();
        string KeyFixed = "ADFixed" + idCode;
        object ADFixed = Erun360.Common.DataCache.GetCache(KeyFixed);
        if (ADFixed == null)
        {
            DB2.tblADFixed bll = new DB2.tblADFixed();
            ADFixed = bll.GetList(multi, "idCode=" + idCode + " and idPosition in(SELECT idPosition FROM  tblADPosition WHERE idCode = " + idCode + " and iStatus =1) and GETDATE() between dBegintime and dEndtime", "idPosition").Tables[0];
            if (ADFixed != null)
            {
                int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                Erun360.Common.DataCache.SetCache(KeyFixed, ADFixed, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
            }
        }

        DataTable dt = ADFixed as DataTable;
        DataRow[] dRows = dt.Select(string.Format("idPosition={0}", idPosition));
        foreach (DataRow dr in dRows)
        {
            sb.Append(dr["cHtml"].ToString());
        }
        return sb.ToString();
    }
}