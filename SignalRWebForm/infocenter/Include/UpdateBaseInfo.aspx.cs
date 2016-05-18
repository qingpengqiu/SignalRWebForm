using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Data;



public partial class infocenter_Include_UpdateBaseInfo : PageBase
{
    DB1.tblMEMBER bll = new DB1.tblMEMBER();
    DBM1.tblMEMBER model = new DBM1.tblMEMBER();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            try
            {
                if (Request["nick"].Trim() != "")
                {
                    model.cNickName = HttpUtility.UrlDecode(Request["nick"].Trim());
                }
                if (Request["cbio"].Trim() != "")
                {
                    model.cBio = HttpUtility.UrlDecode(Request["cbio"].Trim());
                }
                model.id = CurrentUser.uId;
                model.iChecksum = Convert.ToInt32(bll.GetList(" id=" + CurrentUser.uId.ToString()).Tables[0].Rows[0]["iChecksum"]);
                model.dBirthday = null;
                bll.Update(model);
                Response.Write(getreturn());
            }
            catch {
                Response.Write(getreturn());
            }
        }
    }
    protected string getreturn()
    {
        string returnvalue = "";
        DataSet ds = bll.GetList(" id=" + CurrentUser.uId);
        if (Request["nick"].Trim() != "")
        {
            returnvalue = ds.Tables[0].Rows[0]["cNickName"].ToString().Trim();
        }
        if (Request["cbio"].Trim() != "")
        {
            returnvalue = ds.Tables[0].Rows[0]["cBio"].ToString().Trim();
        }
        return returnvalue;
    }
}