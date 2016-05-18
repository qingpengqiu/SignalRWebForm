using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6_BLL = Erun360.BLL.DB6;
using DB6_Model = Erun360.Model.DB6;

public partial class Admin_CooperationManager : PageBase
{
    protected string exeJs = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle < 12)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        if (!Page.IsPostBack)
        {
            GetList();
        }
    }
    private void GetList()
    {
        string sqlWhere = "1=1";
        string coopname = txtname.Value;
        if (!string.IsNullOrEmpty(coopname))
        {
            sqlWhere += " and name like '%" + coopname + "%'";
        }
        string orderField = "createtime desc";
        int pagesize=10;
        int recordcount = 0;
        DataSet dSetofCooperation = new DB6_BLL.tblCooperation().GetListByPage(sqlWhere, orderField, AspNetPager1.CurrentPageIndex, pagesize,out recordcount);
        AspNetPager1.RecordCount = recordcount;
        AspNetPager1.PageSize = pagesize;
        if (dSetofCooperation != null && dSetofCooperation.Tables.Count > 0 && dSetofCooperation.Tables[0].Rows.Count > 0)
        {
            StringBuilder strHtml = new StringBuilder();
            foreach (DataRow item in dSetofCooperation.Tables[0].Rows)
            {
                string actionhref = string.Empty;
                switch (item["ostate"].ToString())
                {
                    case "1":
                        actionhref = string.Format("<a href='javascript:void(0)'  onclick='UpdateState(this,{0},0)'>禁用</a>", item["id"].ToString());
                        break;
                    case "0":
                        actionhref = string.Format("<a href='javascript:void(0)'  onclick='UpdateState(this,{0},1)'>启用</a>", item["id"].ToString());
                        break;
                    default:
                        break;
                }

                strHtml.AppendFormat("<tr><td><a href='' target='_blank'>" + item["name"].ToString() + "</a></td>"
                    + "<td>" + item["org"].ToString() + "</td>"
                    + "<td>" + item["type"].ToString() + "</td>"
                    + "<td>" + DateTime.Parse(item["createtime"].ToString()).ToShortDateString() + "</td>"
                    + "<td>" + actionhref + "</td>"
                    + "</tr>");
            }
            ltlList.Text = strHtml.ToString();
        }
    }

    protected void AspNetPager1_PageChanged(object sender, EventArgs e)
    {
        GetList();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        AspNetPager1.CurrentPageIndex = 1;
        GetList();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
        }
        if (CurrentUser.idMemberStyle < 12)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        string name = Request.Form["name"];
        string org = Request.Form["org"];
        string type = Request.Form["type"];
        if (string.IsNullOrEmpty(name))
        {
            Response.Write("<script>alert('请输入合作客户！');history.back();</script>");
            Response.End();
        }
        if (string.IsNullOrEmpty(org))
        {
            Response.Write("<script>alert('请输入合作标记！');history.back();</script>");
            Response.End();
        }
        else
        {
            if (new DB6_BLL.tblCooperation().IsExistsOrg(org))
            {
                Response.Write("<script>alert('合作标记已经存在,请重新输入!');history.back();</script>");
                Response.End();
            }
        }
        if (string.IsNullOrEmpty(type))
        {
            Response.Write("<script>alert('请输入类型！');history.back();</script>");
            Response.End();
        }
        DB6_Model.tblCooperation cooperationModel = new DB6_Model.tblCooperation();
        cooperationModel.name = name;
        cooperationModel.org = org;
        cooperationModel.type = type;
        cooperationModel.creator = CurrentUser.uId.ToString();
        int intidentity = new DB6_BLL.tblCooperation().Add(cooperationModel);
        if (intidentity>0)
            exeJs = "alert('添加成功！')";
        else
            exeJs = "alert('添加失败！')";
        AspNetPager1.CurrentPageIndex = 1;
        GetList();
    }
}