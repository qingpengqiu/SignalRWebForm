using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using Utils;
using System.Data;
using System.Text;
public partial class Admin_ClubEdit : PageBase
{
    public DBM4.tblRACE_CLUB mClub = new DBM4.tblRACE_CLUB();
    public StringBuilder tempModel = new StringBuilder();
    private int id;
    public string iCity = string.Empty;
    public string iArea = string.Empty;
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
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
           
            //DataSet ds = new DB4.tblRACE_CLUB().GetList("id=" + Request.QueryString["id"].ToString());
        }
        if (!IsPostBack)
        {
            mClub = new DB4.tblRACE_CLUB().GetModel(id);
            if (mClub != null)
            {
                name.Value = mClub.cTitle;
                if (mClub.idCity.ToString().Length == 3)
                {
                    iCity = mClub.idCity.ToString().Substring(0, 1);
                    iArea = mClub.idCity.ToString().Substring(1, 2);
                }
                else if (mClub.idCity.ToString().Length == 4)
                {
                    iCity = mClub.idCity.ToString().Substring(0, 2);
                    iArea = mClub.idCity.ToString().Substring(2, 2);
                }
                cCityname.Value = mClub.cCityname;
                idCity.Value = mClub.idCity.ToString();
                Style.SelectedIndex = mClub.iStyle??0;
                Idmsg.Value = mClub.cDescription;
                idNum.Value = mClub.iMemberLimit.ToString();
                for (int i = 1; i <= 6; i++)
                {
                    if (mClub.cBackground == "v" + i)
                    {
                        tempModel.AppendLine("<li><label for=\"temp" + i + "\"><img src=\"/Html/images/v" + i + "s.jpg\" alt=\"模版" + i + "\" /></label><input value=\"v" + i + "\" name=\"temp\" id=\"temp" + i + "\" type=\"radio\" checked/></li>");
                    }
                    else
                    {
                        tempModel.AppendLine("<li><label for=\"temp" + i + "\"><img src=\"/Html/images/v" + i + "s.jpg\" alt=\"模版" + i + "\" /></label><input value=\"v" + i + "\" name=\"temp\" id=\"temp" + i + "\" type=\"radio\" /></li>");
                    }
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
        DBM4.tblRACE_CLUB mClub = new DBM4.tblRACE_CLUB();
        if (name.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写俱乐部名称！", false);
            return;
        }
        else if (name.Value.Trim().Length >60)
        {
            AlertHelper.JQAlert("俱乐部名称最多只能输入60个汉字！", false);
            return;
        }
        mClub.cTitle = name.Value.Trim();
        if (idCity.Value.Trim() == "0")
        {
            AlertHelper.JQAlert("请选择城市！", false);
            return;
        }
        mClub.idCity = TypeChangeDefault.NullToInt(idCity.Value, 0);
        if (string.IsNullOrEmpty(cCityname.Value.Trim()))
        {
            AlertHelper.JQAlert("请选择城市！", false);
            return;
        }
        mClub.cCityname = cCityname.Value.Trim();
       
        mClub.iStyle = Style.SelectedIndex;
        if (Idmsg.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写俱乐部简介！", false);
            return;
        }
        else if (Idmsg.Value.Trim().Length > 256)
        {
            AlertHelper.JQAlert("俱乐部简介最多只能输入256个汉字！", false);
            return;
        }
        mClub.cDescription = Idmsg.Value.Trim();
       
        mClub.cBackground = radiotemp.Value;
        mClub.iMemberLimit=Convert.ToInt32(idNum.Value);
        //mClub.cBackground = "/Html/css/themes-club-v1.css";

        mClub.iMemberLimit = Convert.ToInt32(idNum.Value);
        //mClub.iAudit = 0;
        //mClub.iLevel = 1;
        //mClub.iStates=0;
        mClub.id = id;
        if (new DB4.tblRACE_CLUB().Update(mClub))
        {
            AlertHelper.JQAlertGo("提交成功！", "ClubList.aspx", true);
        }
        else
        {
            AlertHelper.JQAlert("提交失败，请重试！", false);
        }

    }
}