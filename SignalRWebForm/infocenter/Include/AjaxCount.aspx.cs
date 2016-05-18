using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB3 = Erun360.BLL.DB3;

public partial class infocenter_Include_AjaxCount : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "application/json; charset=utf-8";
        string jsonCount = "{'count':'0', 'msgcount':'0', dcscount:'0',hea:'0'}";
        if (CurrentUser != null)
        {
            int count = new DB3.tblMessage().GetRecordCount(" cId<>" + CurrentUser.uId + "and uId=" + CurrentUser.uId + " and itype=31");
            int dcscount = new DB3.tblMessage().GetRecordCount(" cId<>" + CurrentUser.uId + " and uId=" + CurrentUser.uId + " and itype>31");
            int hea = new DB3.tblMessage().GetRecordCount(" cId<>" + CurrentUser.uId + "and  uId=" + CurrentUser.uId + " and itype>=31");
            int msgcount = new DB3.tblMessage().GetRecordCount(" cId<>" + CurrentUser.uId + " and uId=" + CurrentUser.uId + " and itype=11");
            jsonCount = "{'count':'" + count + "', 'msgcount':'" + msgcount + "', dcscount:'" + dcscount + "',hea:'"+hea+"'}";
        }
        Response.Write(JsonConvert.DeserializeObject(jsonCount));

    }
}