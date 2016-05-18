using Erun360.BLL;
using Erun360.Model;
using ERUN360.Entity;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using Model_DB2 = Erun360.Model.DB2;
using BLL_DB2 = Erun360.BLL.DB2;
using System.Data;
using System.Text;

public partial class Controls_headerv3 : PageBaseCtrl
{
    //public int uId = 0;//通过参数传递过来的用户id
    public int cId = 0;
    public string cName = string.Empty;
    public string admin = string.Empty;
    public string club = string.Empty;
    protected string NavigatorMenu = string.Empty;
    protected PageBase PBase;
    protected void Page_Load(object sender, EventArgs e)
    {
        PBase = this.Page as PageBase;
        NavigatorMenu = GetNavigator();
        //    //通过参数传递过来的用户id：uId
        //    if (Request.QueryString["uId"] != null)
        //    {
        //        uId = int.Parse(Request.QueryString["uId"].ToString());
        //    }
        if (CurrentUser == null)
        {
            return;
        }
        else
        {
            cId = CurrentUser.uId;
            cName = CurrentUser.cNickName;
            if (Admin.IsAdmin())
            {
                admin = "<dt><a href=\"/Admin/\">管理入口</a></dt>";
            }
            if (CurrentUser.uId == 100001183 || CurrentUser.idMemberStyle == 99)
            {
                admin += "<dt><a href=\"/Admin/RaceList.aspx\">赛事管理</a></dt>";
            }
            if (new DB4.tblRACE_CLUB().GetRecordCount(" iAudit>2 and idUser =" + CurrentUser.uId) > 0)
            {
                club += "<dt><a href=\"" + UrlHelper.ClubUrl(Convert.ToInt32(new DB4.tblRACE_CLUB().GetIdClub(CurrentUser.uId))) + "\">管理俱乐部</a></dt>";
            }
            else
            {
                club += "<dt><a href=\"/infocenter/appClub.aspx\">创建俱乐部</a></dt>";
            }
        }
       
    }
    protected string GetNavigator()
    {
        StringBuilder strBuilder = new StringBuilder();

        string strwhere = " id<>30000 ";
        List < Model_DB2.tblChannel > ListOfChannel = new BLL_DB2.tblChannel().GetModelList(strwhere);
        strBuilder.AppendFormat("<a href=' / ' class='nava'>首页</a>");
        foreach (Model_DB2.tblChannel Channelitem in ListOfChannel)
        {
            if (!string.IsNullOrEmpty(Channelitem.cRight))
            {
                strBuilder.AppendFormat("<div class='nava'>{0}{1}</div>", Channelitem.cName, GetChildrenMenu(Channelitem.cRight));
            }
            else
                strBuilder.AppendFormat("<a class=\"nava\" href=\"{0}\">{1}</a>", Channelitem.cLinkUrl, Channelitem.cName);
         
        }
        return strBuilder.ToString();
    }
    protected string GetChildrenMenu(string Ids)
    {
        StringBuilder strBuilder = new StringBuilder();
        if (!string.IsNullOrEmpty(Ids))
        {
            string strWhere = string.Format(" id in({0})", Ids);
            List<Model_DB2.tblClass> ListOfClass = new BLL_DB2.tblClass().GetModelList(strWhere);
            strBuilder.AppendFormat("<dl>");
            foreach (Model_DB2.tblClass Classitem in ListOfClass)
            {
                strBuilder.AppendFormat("<dt>+ <a href=\"{0}\">{1}</a></dt>", Classitem.cLinkUrl, Classitem.cName);
            }
            strBuilder.AppendFormat("</dl>");

        }
        return strBuilder.ToString();
    }
}