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

public partial class Admin_NavClassEdit : PageBase
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
            if (id != 0)
            {
                DBM2.tblClass mClass = new DB2.tblClass().GetModel(id);
                if (mClass != null)
                {
                    if ( CurrentUser.idMemberStyle != 99)
                    {
                        if (mClass.iStatus > 1)
                        {
                            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
                            return;
                        }
                    }                    
                    name.Value = mClass.cName;
                    imgurl.Value = mClass.cLinkUrl;
                    iNum.Value = mClass.iSort.ToString();
                    state.Value = mClass.iStatus.ToString();

                }
            }
            else
            {
                iNum.Value = "99";
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
        DBM2.tblClass mClass = new DBM2.tblClass();
        if (name.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填分类名称！", false);
            return;
        }
        else if (name.Value.Trim().Length > 128)
        {
            AlertHelper.JQAlert("分类名称超出限制！", false);
            return;
        }
        mClass.cName = TypeChangeDefault.NullToString(name.Value.Trim(), "");
        if (imgurl.Value.Trim().Length == 0 )
        {
            AlertHelper.JQAlert("请上传图片！", false);
            return;
        }
        mClass.cLinkUrl = TypeChangeDefault.NullToString(imgurl.Value.Trim(), "");
        mClass.iSort = TypeChangeDefault.NullToInt(iNum.Value.Trim(), 0);

        mClass.iStatus = TypeChangeDefault.NullToInt(state.Value.Trim(), 0);
        
        if (id != 0)
        {
            mClass.id = id;
            mClass.dModifyTime = DateTime.Now;
            if (new DB2.tblClass().Update(mClass))
            {
                AlertHelper.JQAlertGo("修改成功！", "NavClasslist.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            mClass.dCreateTime = DateTime.Now;
            mClass.dModifyTime = DateTime.Now;
            if (new DB2.tblClass().Add(mClass) > 0)
            {
                AlertHelper.JQAlertGo("添加成功！", "NavClasslist.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }

        }
    }
}