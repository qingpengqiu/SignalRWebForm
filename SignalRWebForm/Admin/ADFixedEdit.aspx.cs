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
public partial class Admin_ADFixedEdit : PageBase
{
    private int id = 0;
    public string cImg = string.Empty;
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
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        if (!IsPostBack)
        {
            BindChannel();
            //BindClass();
            BindPositionl("0");
            if (id != 0)
            {
                DBM2.tblADFixed mADFixed = new DB2.tblADFixed().GetModel(id);
                if (mADFixed != null)
                {

                    rdobtnADtype.SelectedValue = mADFixed.iADType.ToString();
                    rdobtnADtype.Enabled = false;
                    if (mADFixed.iADType == 1)
                    {
                        ddlChannel.Visible = true;
                        ddlChannel.Enabled = false;
                        ddlClass.Visible = false;
                        ddllist.Visible = false;
                        ddlChannel.SelectedValue = mADFixed.idCode.ToString();

                    }
                    else if (mADFixed.iADType == 2)
                    {
                        ddlChannel.Visible = false;
                        ddlClass.Visible = true;
                        ddlChannel.Enabled = false;
                        ddllist.Visible = false;
                        ddlClass.SelectedValue = mADFixed.idCode.ToString();
                    }
                    else if (mADFixed.iADType == 3)
                    {
                        ddlChannel.Visible = false;
                        ddlClass.Visible = false;
                        ddlChannel.Enabled = false;
                        ddllist.Visible = true;
                        ddlClass.SelectedValue = mADFixed.idCode.ToString();
                    }
                    ddlPosition.SelectedValue = mADFixed.idPosition.ToString();
                    name.Value = mADFixed.cName;
                    if (mADFixed.iType == 1)
                    {
                        chtml.Visible = false;
                        idImg.Visible = true;
                        idLink.Visible = true;
                        ltlHtml.Visible = true;
                        ltlHtml.Text = mADFixed.cHtml;

                    }
                    else if (mADFixed.iType == 2)
                    {
                        idLink.Visible = false;
                        chtml.Visible = false;
                        idImg.Visible = true;
                        ltlHtml.Visible = true;
                        ltlHtml.Text = mADFixed.cHtml;
                    }
                    else if (mADFixed.iType == 3)
                    {
                        chtml.Visible = true;
                        ltlHtml.Visible = false;
                        idImg.Visible = false;
                        idLink.Visible = false;
                        chtml.Text = mADFixed.cHtml;
                    }
                    ddltype.SelectedValue = mADFixed.iType.ToString();
                    ddltype.Enabled = false;
                    shebei.SelectedValue = mADFixed.iShow.ToString();
                    shebei.Enabled = false;
                    dbegin.Value = Convert.ToDateTime(mADFixed.dBegintime).ToString("yyyy-MM-dd HH:mm");
                    dend.Value = Convert.ToDateTime(mADFixed.dEndtime).ToString("yyyy-MM-dd HH:mm");
                }
            }
            else
            {
                rdobtnADtype.SelectedValue = "1";
                ddlChannel.Visible = true;
                ddlClass.Visible = false;
                ddllist.Visible = false;
                chtml.Visible = false;
                idImg.Visible = true;
                idLink.Visible = true;
                ltlHtml.Visible = true;
                dbegin.Value = string.Format("{0:yyyy-MM-dd HH:mm}", DateTime.Now);
                dend.Value = string.Format("{0:yyyy-MM-dd HH:mm}", DateTime.Now);
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
        DBM2.tblADFixed mADFixed = new DBM2.tblADFixed();
        mADFixed.iADType = TypeChangeDefault.NullToInt(rdobtnADtype.SelectedValue, 1);

        if (rdobtnADtype.SelectedValue == "1")
        {
            mADFixed.idCode = TypeChangeDefault.NullToInt(ddlChannel.SelectedValue, 0);
        }
        else if (rdobtnADtype.SelectedValue == "2")
        {
            mADFixed.idCode = TypeChangeDefault.NullToInt(ddlClass.SelectedValue, 0);
        }
        else if (rdobtnADtype.SelectedValue == "3")
        {
            mADFixed.idCode = TypeChangeDefault.NullToInt(ddllist.SelectedValue, 0);
        }
        if (ddlPosition.SelectedValue == "0")
        {
            AlertHelper.JQAlertGo("请添加广告位！", "ADPosition.aspx", false);
            return;
        }
        mADFixed.idPosition = TypeChangeDefault.NullToInt(ddlPosition.SelectedValue, 0);
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
        mADFixed.cName = TypeChangeDefault.NullToString(name.Value.Trim(), "");
        mADFixed.iType = TypeChangeDefault.NullToInt(ddltype.SelectedValue, 1);

        mADFixed.iShow = TypeChangeDefault.NullToInt(shebei.SelectedValue.Trim(), 0);
        string strhtml = string.Empty;
        if (id == 0)
        {
            if (ddltype.SelectedValue == "1")
            {
                if (imgurl.Value.Trim().Length == 0 || linkurl.Value.Trim().Length == 0)
                {
                    AlertHelper.JQAlert("请上传图片及填写链接！", false);
                    return;
                }
                strhtml = "<div class=\"V3G" + mADFixed.iShow + "\"> <a  target=\"_blank\" href=\"" + linkurl.Value.Trim() + "\"><img src=\"/Html/images/blank.gif\" data-echo=\"" + imgurl.Value.Trim() + "\"></a></div>";
            }
            else if (ddltype.SelectedValue == "2")
            {
                if (imgurl.Value.Trim().Length == 0)
                {
                    AlertHelper.JQAlert("请上传flash！", false);
                    return;
                }
                strhtml = "<div class=\"V3G" + mADFixed.iShow + "\"><embed src=\"" + imgurl.Value.Trim() + "\" ></div>";
            }
            else if (ddltype.SelectedValue == "3")
            {
                if (chtml.Text.Trim().Length == 0)
                {
                    AlertHelper.JQAlert("请填写html代码！", false);
                    return;
                }
                strhtml = chtml.Text.Trim();
            }
            mADFixed.cHtml = strhtml;
        }
        else
        {
            if (ddltype.SelectedValue == "1")
            {
                if (imgurl.Value.Trim().Length > 0 || linkurl.Value.Trim().Length > 0)
                {
                    strhtml = "<div class=\"V3G" + mADFixed.iShow + "\"> <a  target=\"_blank\" href=\"" + linkurl.Value.Trim() + "\"><img src=\"/Html/images/blank.gif\" data-echo=\"" + imgurl.Value.Trim() + "\" ></a></div>";
                    mADFixed.cHtml = strhtml;
                }

            }
            else if (ddltype.SelectedValue == "2")
            {
                if (imgurl.Value.Trim().Length > 0)
                {
                    strhtml = "<div class=\"V3G" + mADFixed.iShow + "\"><embed src=\"" + imgurl.Value.Trim() + "\" ></div>";
                    mADFixed.cHtml = strhtml;
                }

            }
            else if (ddltype.SelectedValue == "3")
            {
                if (chtml.Text.Trim().Length > 0)
                {
                    strhtml = chtml.Text.Trim();
                    mADFixed.cHtml = strhtml;
                }

            }

        }
        DB2.tblADFixed bll = new DB2.tblADFixed();
        int count = bll.GetRecordCount("GETDATE() between dBegintime and dEndtime and idCode=" + mADFixed.idCode + " and idPosition=" + mADFixed.idPosition + " and id !=" + id);
        if (count > 0)
        {
            AlertHelper.JQAlert("当前位置已存在广告！", false);
            return;
        }
        mADFixed.dBegintime = TypeChangeDefault.NullToDateTime(dbegin.Value, DateTime.Now);
        mADFixed.dEndtime = TypeChangeDefault.NullToDateTime(dend.Value, DateTime.Now);
        if (mADFixed.dBegintime > mADFixed.dEndtime)
        {
            AlertHelper.JQAlert("开始时间不能大于结束时间！", false);
            return;
        }

        mADFixed.idUser = CurrentUser.uId;
        mADFixed.dCreate = DateTime.Now;
        if (id != 0)
        {
            mADFixed.id = id;
            if (bll.Update(mADFixed))
            {
                Erun360.Common.DataCache.RemoveAllCache("ADFixed" + mADFixed.idCode);
                AlertHelper.JQAlertGo("修改成功！", "ADFixed.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            id = bll.Add(mADFixed);
            if (id > 0)
            {
                Erun360.Common.DataCache.RemoveAllCache("ADFixed" + mADFixed.idCode);
                AlertHelper.JQAlertGo("添加成功！", "ADFixed.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
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
    //protected void BindClass()
    //{
    //    DataTable dt = new DB2.tblClass().GetList(0, "iStatus=1", "iSort desc").Tables[0];
    //    ddlClass.DataSource = dt;
    //    ddlClass.DataTextField = "cName";
    //    ddlClass.DataValueField = "id";
    //    ddlClass.DataBind();
    //}
    protected void ddltype_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddltype.SelectedValue == "1")
        {
            chtml.Visible = false;
            idImg.Visible = true;
            idLink.Visible = true;
            ltlHtml.Visible = true;
        }
        else if (ddltype.SelectedValue == "2")
        {
            idLink.Visible = false;
            chtml.Visible = false;
            idImg.Visible = true;
            ltlHtml.Visible = true;
        }
        else if (ddltype.SelectedValue == "3")
        {
            chtml.Visible = true;
            ltlHtml.Visible = false;
            idImg.Visible = false;
            idLink.Visible = false;
        }
    }
    protected void BindPositionl(string idChannel)
    {
        ddlPosition.Items.Clear();
        DataTable dt = new DataTable();
        if (idChannel != "0")
        {
            dt = new DB2.tblADPosition().GetList(0, "idCode=" + idChannel + " and iStatus=1", "idPosition").Tables[0];
        }
        else
        {
            dt = new DB2.tblADPosition().GetList(0, "idCode=30000 and iStatus=1", "idPosition").Tables[0];
        }
        if (dt.Rows.Count > 0)
        {
            ddlPosition.DataSource = dt;
            ddlPosition.DataTextField = "cPositionName";
            ddlPosition.DataValueField = "idPosition";
            ddlPosition.DataBind();
        }
        else
        {
            ListItem list = new ListItem("--请选择--", "0");
            this.ddlPosition.Items.Add(list);
        }
    }
    protected void ddlChannel_SelectedIndexChanged(object sender, EventArgs e)
    {
        string idChannel = ddlChannel.SelectedValue;
        BindPositionl(idChannel);
    }
    protected void rdobtnADtype_SelectedIndexChanged(object sender, EventArgs e)
    {
        string idChannel = "0";
        if (rdobtnADtype.SelectedValue == "1")
        {
            ddlChannel.Visible = true;
            ddlClass.Visible = false;
            ddllist.Visible = false;
            idChannel = ddlChannel.SelectedValue;
        }
        else if (rdobtnADtype.SelectedValue == "2")
        {
            ddlChannel.Visible = false;
            ddlClass.Visible = true;
            ddllist.Visible = false;
            idChannel = ddlClass.SelectedValue;
        }
        else if (rdobtnADtype.SelectedValue == "3")
        {
            ddlChannel.Visible = false;
            ddlClass.Visible = false;
            ddllist.Visible = true;
            idChannel = ddllist.SelectedValue;
        }

        BindPositionl(idChannel);
    }
    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        string idChannel = ddlChannel.SelectedValue;
        BindPositionl(idChannel);
    }
    protected void ddllist_SelectedIndexChanged(object sender, EventArgs e)
    {
        string idChannel = ddlChannel.SelectedValue;
        BindPositionl(idChannel);
    }
}