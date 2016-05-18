using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
public partial class Admin_ADPositionEdit : PageBase
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
        }

        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (!IsPostBack)
        {
            BindChannel();
            BindClass();
            if (id != 0)
            {
                DBM2.tblADPosition mPosition = new DB2.tblADPosition().GetModel(id);
                if (mPosition != null)
                {

                    if (mPosition.iADType == 1)
                    {
                        ddlChannel.Visible = true;
                        ddlClass.Visible = false;
                        ddlChannel.SelectedValue = mPosition.idCode.ToString();

                    }
                    else if (mPosition.iADType == 1)
                    {
                        ddlChannel.Visible = false;
                        ddlClass.Visible = true;
                        ddlClass.SelectedValue = mPosition.idCode.ToString();
                    }
                    rdobtnADtype.SelectedValue = mPosition.iADType.ToString();
                    name.Value = mPosition.cPositionName;
                    iWidth.Value = mPosition.iWidth.ToString();
                    iHeight.Value = mPosition.iHeight.ToString();
                    iStatus.Value = mPosition.iStatus.ToString();
                    hdidPosition.Value = mPosition.idPosition.ToString();
                }
            }
            else
            {
                rdobtnADtype.SelectedValue = "1";
                ddlChannel.Visible = true;
                ddlClass.Visible = false;

            }
           
        }
    }
    protected void BindChannel()
    {
        DataTable dt = new DB2.tblChannel().GetList(0, "iStatus=1", "iSort desc").Tables[0];
        ddlChannel.DataSource = dt;
        ddlChannel.DataTextField = "cName";
        ddlChannel.DataValueField = "id";
        ddlChannel.DataBind();
    }
    protected void BindClass()
    {
        DataTable dt = new DB2.tblClass().GetList(0, "iStatus=1", "iSort desc").Tables[0];
        ddlClass.DataSource = dt;
        ddlClass.DataTextField = "cName";
        ddlClass.DataValueField = "id";
        ddlClass.DataBind();
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
        DBM2.tblADPosition mPosition = new DBM2.tblADPosition();
        mPosition.iADType = TypeChangeDefault.NullToInt(rdobtnADtype.SelectedValue, 1);
        if (rdobtnADtype.SelectedValue == "1")
        {
            mPosition.idCode = TypeChangeDefault.NullToInt(ddlChannel.SelectedValue, 3000);
            mPosition.cCodeName = TypeChangeDefault.NullToString(ddlChannel.SelectedItem.Text, "");
        }
        else if (rdobtnADtype.SelectedValue == "2")
        {
            mPosition.idCode = TypeChangeDefault.NullToInt(ddlClass.SelectedValue, 1000);
            mPosition.cCodeName = TypeChangeDefault.NullToString(ddlClass.SelectedItem.Text, "");
        }

        if (name.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请广告名称！", false);
            return;
        }
        else if (name.Value.Trim().Length > 64)
        {
            AlertHelper.JQAlert("广告名称超出64汉字限制！", false);
            return;
        }
        mPosition.cPositionName = TypeChangeDefault.NullToString(name.Value.Trim(), "");
        mPosition.iWidth = TypeChangeDefault.NullToInt(iWidth.Value, 300);
        mPosition.iHeight = TypeChangeDefault.NullToInt(iHeight.Value, 120);
        mPosition.iStatus = TypeChangeDefault.NullToInt(iStatus.Value.Trim(), 0);

        DB2.tblADPosition bll = new DB2.tblADPosition();
        if (id > 0)
        {
            int count = bll.GetRecordCount(" idCode = " + mPosition.idCode + " and idPosition=" + hdidPosition.Value + " and iStatus=1 and id !=" + id);
            if (count > 0)
            {
                AlertHelper.JQAlert("当前位置已存在广告！", false);
                return;
            }
        }
        mPosition.idUser = CurrentUser.uId;
        mPosition.dCreate = DateTime.Now;
        if (id != 0)
        {
            mPosition.id = id;
            mPosition.idPosition = TypeChangeDefault.NullToInt(hdidPosition.Value, 0);
            if (bll.Update(mPosition))
            {
                Erun360.Common.DataCache.RemoveAllCache("ADFixed" + mPosition.idCode);
                AlertHelper.JQAlertGo("修改成功！", "ADPosition.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            int idPosition = bll.GetMaxPositionId(TypeChangeDefault.NullToInt(mPosition.idCode, 0));

            mPosition.idPosition = idPosition + 1; ;
            if (bll.Add(mPosition) > 0)
            {
                AlertHelper.JQAlertGo("添加成功！", "ADPosition.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }
        }
    }
    protected void rdobtnADtype_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rdobtnADtype.SelectedValue == "1")
        {
            ddlChannel.Visible = true;
            ddlClass.Visible = false;
        }
        else if (rdobtnADtype.SelectedValue == "2")
        {
            ddlChannel.Visible = false;
            ddlClass.Visible = true;
        }
    }
}