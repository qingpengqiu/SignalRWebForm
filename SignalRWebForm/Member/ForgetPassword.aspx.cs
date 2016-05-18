using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using Erun360.Common;

public partial class infocenter_ForgetPassword : System.Web.UI.Page
{
    public DB1.tblMEMBER MemberBll = new DB1.tblMEMBER();
    protected string mobile;
    protected string loginame = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        //name=gggso
        string name = XString.SqlSafe(HttpUtility.UrlDecode(TypeChangeDefault.NullToString(Request["name"], "")));
        if (string.IsNullOrEmpty(name))
        {
            Response.Write("<script>alert('非法访问!');history.back();</script>");
            Response.End();
        }
        string strwhere = string.Format(" cLoginname='{0}' ", name);
        List<DBM1.tblMEMBER> ListOfMember = MemberBll.GetModelList(strwhere);
        if (ListOfMember.Count > 0)
        {
            DBM1.tblMEMBER membermodel = ListOfMember[0];
            if (PageValidate.IsPhone(membermodel.cMobile))
            {
                mobile = membermodel.cMobile.Insert(3, "****").Remove(7, 4);
            }
            if (membermodel.cLoginname == membermodel.cMobile)
            {
                loginame = membermodel.cMobile;
            }
        }
    }
}