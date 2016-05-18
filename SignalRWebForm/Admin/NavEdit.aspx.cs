using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DBM2 = Erun360.Model.DB2;
using DB2 = Erun360.BLL.DB2;
using System.Data;
public partial class Admin_NavEdit : PageBase
{
    private int id = 0;
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
            return;
        }
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (!IsPostBack)
        {
            BindClass();
            if (id != 0)
            {
                DBM2.tblChannel mChannel = new DB2.tblChannel().GetModel(id);
                if (mChannel != null)
                {
                    name.Value = mChannel.cName;
                    iNum.Value = mChannel.iSort.ToString();
                    maxpage.Value = mChannel.iMaxPageSize.ToString();
                    state.Value = mChannel.iStatus.ToString();
                    string[] ca = mChannel.cRight.Split(',');
                    for (int j = 0; j < ca.Length; j++)
                    {
                        foreach (ListItem li in cbxClass.Items)
                        {
                            if (li.Value.Equals(ca[j]))    //如果li.Value值等于某值,就钩选
                            {
                                li.Selected = true;                    //等于true就表示钩选啦.
                                break;
                            }
                        }
                    }
                    //首页全部显示，不用勾选分类
                    if (id == 30000)
                    {
                        cbxClass.Visible = false;
                    }
                }
            }
            else
            {
                iNum.Value = "99";
                maxpage.Value = "20";
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
            return;
        }
        DBM2.tblChannel mChannel = new DBM2.tblChannel();
        if (name.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填频道名称！", false);
            return;
        }
        else if (name.Value.Trim().Length > 128)
        {
            AlertHelper.JQAlert("频道名称超出限制！", false);
            return;
        }
        mChannel.cName = TypeChangeDefault.NullToString(name.Value.Trim(), "");
        mChannel.iSort = TypeChangeDefault.NullToInt(iNum.Value.Trim(), 0);
        mChannel.iMaxPageSize = TypeChangeDefault.NullToInt(maxpage.Value.Trim(), 0);
        mChannel.iStatus = TypeChangeDefault.NullToInt(state.Value.Trim(), 0);
        string strClass = string.Empty;//分类
        foreach (ListItem li in cbxClass.Items)
        {
            if (li.Selected)    //表示某一项被选中了
            {
                strClass += li.Value + ",";
            }
        }
        mChannel.cRight = strClass.TrimEnd(',');
        if (id != 0)
        {
            mChannel.id = id;
            mChannel.dModifyTime = DateTime.Now;
            if (new DB2.tblChannel().Update(mChannel))
            {
                AlertHelper.JQAlertGo("修改成功！", "NavList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            mChannel.dCreateTime = DateTime.Now;
            mChannel.dModifyTime = DateTime.Now;
            if (new DB2.tblChannel().Add(mChannel) > 0)
            {
                AlertHelper.JQAlertGo("添加成功！", "NavList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }

        }
    }

    protected void BindClass()
    {
        DataSet ds = new DB2.tblClass().GetList(0, "iStatus>=1", "iSort desc");
        cbxClass.DataSource = ds;
        cbxClass.DataTextField = "cName";
        cbxClass.DataValueField = "id";
        cbxClass.DataBind();
    }

}