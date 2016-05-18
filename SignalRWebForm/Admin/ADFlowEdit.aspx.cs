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
public partial class Admin_ADFlowEdit : PageBase
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
            if (id != 0)
            {
                DBM2.tblADFlow mAD = new DB2.tblADFlow().GetModel(id);
                if (mAD != null)
                {
                    ddltype.SelectedValue = mAD.iType.ToString();
                    ddltype.Enabled = false;
                    name.Value = mAD.cName;
                    ddlChannel.SelectedValue = mAD.idChannel.ToString();
                    ipage.Value = mAD.iPage.ToString();
                    iindex.Value = mAD.iIndex.ToString();
                    if (mAD.iType == 1)
                    {
                        chtml.Visible = false;
                        idImg.Visible = true;
                        idLink.Visible = true;
                        ltlHtml.Visible = true;
                        ltlHtml.Text = mAD.cHtml;

                    }
                    else if (mAD.iType == 2)
                    {
                        idLink.Visible = false;
                        chtml.Visible = false;
                        idImg.Visible = true;
                        ltlHtml.Visible = true;
                        ltlHtml.Text = mAD.cHtml;
                    }
                    else if (mAD.iType == 3)
                    {
                        chtml.Visible = true;
                        ltlHtml.Visible = false;
                        idImg.Visible = false;
                        idLink.Visible = false;
                        chtml.Text = mAD.cHtml;
                    }
                    shebei.SelectedValue = mAD.iShow.ToString();
                    shebei.Enabled = false;
                    dbegin.Value = Convert.ToDateTime(mAD.dBegintime).ToString("yyyy-MM-dd HH:mm");
                    dend.Value = Convert.ToDateTime(mAD.dEndtime).ToString("yyyy-MM-dd HH:mm");
                }
            }
            else
            {
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
        DBM2.tblADFlow mAD = new DBM2.tblADFlow();
        mAD.iType = TypeChangeDefault.NullToInt(ddltype.SelectedValue, 1);
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
        mAD.cName = TypeChangeDefault.NullToString(name.Value.Trim(), "");
        mAD.idChannel = TypeChangeDefault.NullToInt(ddlChannel.SelectedValue, 3000);

        mAD.iPage = TypeChangeDefault.NullToInt(ipage.Value, 9999);

        mAD.iIndex = TypeChangeDefault.NullToInt(iindex.Value, 19);
        mAD.iShow = TypeChangeDefault.NullToInt(shebei.SelectedValue.Trim(), 0);
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
                strhtml = "<div class=\"ggimg" + mAD.iShow + "\"> <a  target=\"_blank\" href=\"" + linkurl.Value.Trim() + "\"><img src=\"/Html/images/blank.gif\" data-echo=\"" + imgurl.Value.Trim() + "\"></a></div>";
            }
            else if (ddltype.SelectedValue == "2")
            {
                if (imgurl.Value.Trim().Length == 0)
                {
                    AlertHelper.JQAlert("请上传flash！", false);
                    return;
                }
                strhtml = "<div class=\"ggflash" + mAD.iShow + "\"><embed src=\"" + imgurl.Value.Trim() + "\" ></div>";
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
            mAD.cHtml = strhtml;
        }
        else
        {
            if (ddltype.SelectedValue == "1")
            {
                if (imgurl.Value.Trim().Length > 0 || linkurl.Value.Trim().Length > 0)
                {
                    strhtml = "<div class=\"ggimg" + mAD.iShow + "\"> <a  target=\"_blank\" href=\"" + linkurl.Value.Trim() + "\"><img src=\"/Html/images/blank.gif\" data-echo=\"" + imgurl.Value.Trim() + "\"></a></div>";
                    mAD.cHtml = strhtml;
                }
              
            }
            else if (ddltype.SelectedValue == "2")
            {
                if (imgurl.Value.Trim().Length >0)
                {
                    strhtml = "<div class=\"ggflash" + mAD.iShow + "\"><embed src=\"" + imgurl.Value.Trim() + "\" ></div>";
                    mAD.cHtml = strhtml;
                }
               
            }
            else if (ddltype.SelectedValue == "3")
            {
                if (chtml.Text.Trim().Length == 0)
                {
                    strhtml = chtml.Text.Trim();
                    mAD.cHtml = strhtml;
                }
            }
        }
        DB2.tblADFlow bll = new DB2.tblADFlow();
        int count = bll.GetRecordCount("GETDATE() between dBegintime and dEndtime and idChannel = " + mAD.idChannel + " and iPage=" + mAD.iPage + " and iIndex=" + mAD.iIndex + "and id !=" + id);
        if (count > 0)
        {
            AlertHelper.JQAlert("当前位置已存在广告！", false);
            return;
        }

        mAD.dBegintime = TypeChangeDefault.NullToDateTime(dbegin.Value, DateTime.Now);
        mAD.dEndtime = TypeChangeDefault.NullToDateTime(dend.Value, DateTime.Now);
        if (mAD.dBegintime > mAD.dEndtime)
        {
            AlertHelper.JQAlert("开始时间不能大于结束时间！", false);
            return;
        }

        mAD.idUser = CurrentUser.uId;
        mAD.dCreate = DateTime.Now;
        if (id != 0)
        {
            mAD.id = id;
            if (new DB2.tblADFlow().Update(mAD))
            {
                Erun360.Common.DataCache.RemoveAllCache("indexADFlow");
                Erun360.Common.DataCache.RemoveAllCache("cnADFlow" + id);
                Erun360.Common.DataCache.RemoveAllCache("wzADFlow" + id);
                AlertHelper.JQAlertGo("修改成功！", "ADFlow.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            id = new DB2.tblADFlow().Add(mAD);
            if (id > 0)
            {
                Erun360.Common.DataCache.RemoveAllCache("indexADFlow");
                Erun360.Common.DataCache.RemoveAllCache("cnADFlow" + id);
                Erun360.Common.DataCache.RemoveAllCache("wzADFlow" + id);
                AlertHelper.JQAlertGo("添加成功！", "ADFlow.aspx", true);
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
}