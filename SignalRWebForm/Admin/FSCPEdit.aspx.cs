using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using System.Data;
public partial class Admin_FSCPEdit : PageBase
{
    private int id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.uId != 100001183 && CurrentUser.idMemberStyle != 99)
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
                DBM4.tblAnnex mAnnex = new DB4.tblAnnex().GetModel(id);
                if (mAnnex != null)
                {
                    name.Value = mAnnex.cName;
                    clink.Value = mAnnex.cLink;
                    fPrice.Value = mAnnex.fPrice.ToString();
                    iNum.Value = mAnnex.iNum.ToString();
                    state.Value = mAnnex.iState.ToString();
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

        if (CurrentUser.uId != 100001183 && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        DBM4.tblAnnex mAnnex = new DBM4.tblAnnex();
        if (name.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填附属产品名称！", false);
            return;
        }
        else if (name.Value.Trim().Length > 128)
        {
            AlertHelper.JQAlert("品牌名称超出限制！", false);
            return;
        }
        mAnnex.cName = TypeChangeDefault.NullToString(name.Value.Trim(), "");
        if (clink.Value.Trim().Length > 1024)
        {
            AlertHelper.JQAlert("链接超出限制！", false);
            return;
        }
        mAnnex.cLink = TypeChangeDefault.NullToString(clink.Value.Trim(), "");
        if (fPrice.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写价格！", false);
            return;
        }
        mAnnex.fPrice = TypeChangeDefault.NullToDecimal(fPrice.Value.Trim(), 0);

        if (iNum.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写分词！", false);
            return;
        }

        mAnnex.iNum = TypeChangeDefault.NullToInt(iNum.Value.Trim(), 0);

        mAnnex.iState = TypeChangeDefault.NullToInt(state.Value.Trim(), 0);

        if (id != 0)
        {
            mAnnex.id = id;
            if (new DB4.tblAnnex().Update(mAnnex))
            {
                AlertHelper.JQAlertGo("修改成功！", "FSCP.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            if (new DB4.tblAnnex().Add(mAnnex) > 0)
            {
                AlertHelper.JQAlertGo("添加成功！", "FSCP.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }

        }
    }
}