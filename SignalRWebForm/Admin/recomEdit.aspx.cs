using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
public partial class Admin_recomEdit : PageBase
{
    private int id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.idMemberStyle <13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        if (!IsPostBack)
        {
            if (id != 0)
            {
                DBM3.tblRecom mRecom = new DB3.tblRecom().GetModel(id);
                if (mRecom != null)
                {
                    name.Value = mRecom.idUser.ToString();
                    Idmsg.Value = mRecom.cBio;
                    Style.Value = mRecom.cType.ToString();
                    //state.Value = mRecom.cState.ToString();
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
        DBM3.tblRecom mRecom = new DBM3.tblRecom();
        if (name.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填用户id！", false);
            return;
        }
        else if (name.Value.Trim().Length > 9)
        {
            AlertHelper.JQAlert("用户id最多只能输入9个数字！", false);
            return;
        }
        mRecom.idUser = TypeChangeDefault.NullToInt(name.Value.Trim(), 0);
        if (Idmsg.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写用户部简介！", false);
            return;
        }
        else if (Idmsg.Value.Trim().Length > 256)
        {
            AlertHelper.JQAlert("用户简介最多只能输入256个汉字！", false);
            return;
        }
        mRecom.cBio = Idmsg.Value.Trim();
        if (Style.SelectedIndex == 0)
        {
            AlertHelper.JQAlert("请选择用户类型！", false);
            return;
        }
        mRecom.cType = TypeChangeDefault.NullToInt(Style.SelectedIndex, 0);
        //if (state.SelectedIndex == 0)
        //{
        //    AlertHelper.JQAlert("请选择用户状态！", false);
        //    return;
        //}
        //mRecom.cState = TypeChangeDefault.NullToInt(state.Value.Trim(), 0);
        mRecom.cState = 1;
        if (id != 0)
        {
            mRecom.id = id;
            mRecom.dUpdate = DateTime.Now;
            mRecom.cLoginname = CurrentUser.uId.ToString();
            if (new DB3.tblRecom().Update(mRecom))
            {
                AlertHelper.JQAlertGo("修改成功！", "recomList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            if(new DB3.tblRecom().GetRecordCount(" idUser="+name.Value.Trim())>0)
            {
                AlertHelper.JQAlert("该用户已存在！", false);
                return;
            }
            mRecom.dUpdate = DateTime.Now;
            mRecom.cLoginname = CurrentUser.uId.ToString();
            if (new DB3.tblRecom().Add(mRecom) > 0)
            {
                AlertHelper.JQAlertGo("添加成功！", "recomList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }
        }
    }
}