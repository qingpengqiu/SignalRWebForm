using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Text;
using DB2 = Erun360.BLL.DB2;
using DB3 = Erun360.BLL.DB3;
public partial class Member_Register5 : PageBase
{
    public string StrRecom = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Response.Redirect("/Member/Login.aspx");
        }
        if (!IsPostBack)
        {
            StrRecom = ReCom();
        }
    }
    protected string ReCom()
    {
        string where = " SELECT top 8 r.idUser, r.cBio, r.cType, r.dUpdate, r.cLoginname, r.cState, m.cNickName, m.cAvatar, r.id FROM  YP_DB_3.dbo.tblRecom AS r INNER JOIN YP_DB_1.dbo.tblMEMBER AS m ON r.idUser = m.id order by NEWID()";
        DataTable dt = new DB2.ViewHomeList().QueryBySql(where).Tables[0];
        StringBuilder sb1 = new StringBuilder();
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                sb1.Append("<li>");
                sb1.Append("<a href=\"/user/" + dt.Rows[i]["idUser"].ToString() + ".aspx\" target=\"_blank\">");
                sb1.Append("<img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\">");
                sb1.Append(dt.Rows[i]["cNickName"].ToString());
                sb1.Append("</a>");
                sb1.Append("<p>" + dt.Rows[i]["cBio"].ToString() + "</p>");
                if (new DB3.tblATTENTION().Exists("idInfo=" + dt.Rows[i]["idUser"].ToString() + " and idUser=" + CurrentUser.uId))
                {
                    if (new DB3.tblATTENTION().Exists("idInfo=" + CurrentUser.uId + " and idUser=" + dt.Rows[i]["idUser"].ToString()))
                    {
                        sb1.Append("<a class=\"registxhgz\">相互关注</a>");
                    }
                    else
                    {
                        sb1.Append("<a class=\"registygz\">已关注</a>");
                    }
                }
                else
                {
                    sb1.Append("<a href=\"javascript:\" class=\"registfoucs  focus" + i.ToString() + "\" onclick=\"iFocus(" + dt.Rows[i]["idUser"].ToString() + ",'focus" + i.ToString() + "')\">关注TA</a>");
                }
                sb1.Append("<a href=\"/infocenter/PostMessage.aspx?uId=" + dt.Rows[i]["idUser"].ToString() + "\" class=\"registly\">给TA留言</a>");
                sb1.Append("</li>");
            }
        }
        return sb1.ToString();
    }
    protected void renext_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Response.Redirect("/Member/Login.aspx");
        }
        Response.Redirect(UrlHelper.MemberUrl(CurrentUser.uId));
    }
}