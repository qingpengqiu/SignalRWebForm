using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
public partial class Admin_PlanEdit : PageBase
{
    public int id = 0;//记录id
    DB5.tblPlan BLL = new DB5.tblPlan();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle < 13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (!IsPostBack)
        {
            BindDDL();
            if (id != 0)
            {
                DBM5.tblPlan model = BLL.GetModel(id);
                if (model != null)
                {
                    ddlCode.SelectedValue = model.cPanCode;
                    week.Value = model.iweek.ToString();
                    day.Value = model.iDay.ToString();
                    memo.Value = model.cMemo;
                    rbType.SelectedValue = model.iType.ToString();
                    time.Value = model.iTime.ToString();
                    rbStrong.SelectedValue = model.iStrong.ToString();
                    space.Value = model.cspace;
                    Mark.Value = model.cMark;
                    order.Value = model.iOrder.ToString();
                }

            }
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle < 13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        DBM5.tblPlan model = new DBM5.tblPlan();
        model.cPanCode = ddlCode.SelectedValue;
        if (week.Value.Trim().Length == 0)
        {
            AlertHelper.JQAlert("请填写周数！", false);
            return;
        }
        model.iweek = TypeChangeDefault.NullToInt(week.Value.Trim(), 0);
        if (day.Value.Trim().Length == 0)
        {
            AlertHelper.JQAlert("请填写日！", false);
            return;
        }
        model.iDay = TypeChangeDefault.NullToInt(day.Value.Trim(), 0);
        if (memo.Value.Trim().Length != 0)
        {
            model.cMemo = memo.Value.Trim();
        }
        if (rbType.SelectedValue != "")
        {
            model.iType = TypeChangeDefault.NullToInt(rbType.SelectedValue, 0);
        }
        if (time.Value.Trim().Length != 0)
        {
            model.iTime = TypeChangeDefault.NullToInt(time.Value.Trim(), 0);
        }       
        if (rbStrong.SelectedValue != "")
        {
            model.iStrong = TypeChangeDefault.NullToInt(rbStrong.SelectedValue, 0);
        }
        if (space.Value.Trim().Length != 0)
        {
            model.cspace = space.Value.Trim();
        }

        if (Mark.Value.Trim().Length != 0)
        {
            model.cMark = Mark.Value.Trim();
        }
        if (order.Value.Trim().Length != 0)
        {
            model.iOrder = TypeChangeDefault.NullToInt(order.Value.Trim(), 0);
        }        
        if (id != 0)
        {
            model.id = id;
            if(BLL.Update(model))
            {
                AlertHelper.JQAlertGo("保存成功！", "Plan.aspx?idplan=" + ddlCode.SelectedValue + "#a" + id, true);
            }
            else
                AlertHelper.JQAlertGo("保存失败！", "Plan.aspx", false);

        }
        else
        {
            int idx=BLL.Add(model);
            if (idx > 0)
            {
                AlertHelper.JQAlertGo("保存成功！", "Plan.aspx?idplan=" + ddlCode.SelectedValue + "#a" + idx, true);
            }
            else
                AlertHelper.JQAlertGo("保存失败！", "Plan.aspx", false);
        }
    }
    protected void BindDDL()
    {
        DataSet ds = BLL.GetPlan("cPanCode");
        ddlCode.DataSource = ds;
        ddlCode.DataTextField = "cPanCode";
        ddlCode.DataValueField = "cPanCode";
        ddlCode.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("Plan.aspx?idplan=" + ddlCode.SelectedValue + "#a" + id, true);
    }
}