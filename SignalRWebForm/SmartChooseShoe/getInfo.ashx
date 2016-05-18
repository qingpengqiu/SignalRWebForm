<%@ WebHandler Language="C#" Class="getInfo" %>

using System;
using System.Web;
using Bll_DB5 = Erun360.BLL.DB5;
using System.Data;
using System.Text;

public class getInfo : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        string strtype = context.Request.Form["type"];
        if (!string.IsNullOrEmpty(strtype))
        {
            if (strtype == "modeinfo")
            {
                getModelinfo(context);
            }
            if (strtype=="manufacturerinfo")
            {
                getManufacturerinfo(context);
            }
        }
    }
    protected void getModelinfo(HttpContext context)
    {
        StringBuilder sbuilder = new StringBuilder();
        int gender = int.Parse(context.Request.Form["gender"]);
        string manufacturer = context.Request.Form["manufacturer"];
        DataSet dsModel = new Bll_DB5.tblShoes().GetSeries(gender, manufacturer);
        if (dsModel != null && dsModel.Tables.Count > 0 && dsModel.Tables[0].Rows.Count > 0)
        {
            sbuilder.AppendFormat("<option value=\"\">请选择</option> ");
            foreach (DataRow item in dsModel.Tables[0].Rows)
            {
                sbuilder.AppendFormat("<option value=\"{0}\">{0}</option>",item["cSeries"]);
            }
        }
        context.Response.Write(sbuilder.ToString());

    }
    protected void getManufacturerinfo(HttpContext context)
    {
        StringBuilder sbuilder = new StringBuilder();
        DataSet dsManuf = new Bll_DB5.tblShoes().GetBrand();
        if (dsManuf != null && dsManuf.Tables.Count > 0 && dsManuf.Tables[0].Rows.Count > 0)
        {
            sbuilder.AppendFormat("<option value=\"\">请选择</option> ");
            foreach (DataRow item in dsManuf.Tables[0].Rows)
            {
                sbuilder.AppendFormat("<option value=\"{0}\">{0}</option>",item["cBrand"]);
            }
        }
        context.Response.Write(sbuilder.ToString());
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}