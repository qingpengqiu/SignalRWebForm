using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using System.Data;
using Utils;
public partial class Channels_Competetion_Team : PageBase
{
    public int idItem = 0;//项目id   
    public int id = 0;//赛事id
    public int isShow = 0;//0 不显示加入团队，1显示加入团队（是否报名，是否创建退伍，是否登陆 ）
    protected void Page_Load(object sender, EventArgs e)
    {
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        idItem = TypeChangeDefault.NullToInt(Request.QueryString["p"], 0);
        DBM4.tblRACE_SIGNUP mSign = new DB4.tblRACE_SIGNUP().GetModel(idItem);
        if (mSign != null)
        {
            //判断是否过期
            if (DateTime.Now.AddDays(-3) > mSign.dJoinEnd)//报名截止3天以后不允许组队
            {
                isShow = 0;
                //AlertHelper.JQAlertGo("赛事已过期！", "/Channels/Competetion/RaceList.aspx", true);
            }
            ltlTitle.Text = mSign.cTitle + "(" + mSign.cType + ")";

            if (CurrentUser == null)
            {
                isShow = 0;
                ltlTeam.Text = "<div class=\"ktime\" onclick=\"PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();\">我要组队</div>";
            }
            else
            {
                isShow = 1;
                int Resoult = new DB4.tblRACE_SALES().GetRecordCount("idSignUp=" + idItem + " and IdUser=" + CurrentUser.uId + " and iState>1");
                if (Resoult == 0)
                {
                    isShow = 0;
                    //Response.Redirect("/");
                    //AlertHelper.JQAlertGo("您没报名！", "/Channels/Competetion/RaceList.aspx", true);
                }
                else
                {
                    isShow = 1;
                }
                DataTable dt = new DB4.tblTeam_Group().GetList("idUser=" + CurrentUser.uId + " and idItem=" + idItem).Tables[0];
                if (dt.Rows.Count > 0)
                {
                    isShow = 0;
                    if (dt.Rows[0]["isOpen"].ToString() == "0")
                    {
                        ltlTeam.Text = "<div class=\"mypasswd\" >您是[" + dt.Rows[0]["iSNo"].ToString() + "]队队长，队伍密码是：" + dt.Rows[0]["cPsd"].ToString() + "</div>";
                    }
                    else 
                    {
                        ltlTeam.Text = "<div class=\"mypasswd\" >您是[" + dt.Rows[0]["iSNo"].ToString() + "]队队长</div>";
                    }
                }
                else
                {
                    isShow = 1;
                    DataTable dtteam = new DB4.tblTeam().GetList("idItem=" + idItem + " and IdUser=" + CurrentUser.uId + " and iState=1").Tables[0];
                    if (dtteam.Rows.Count > 0)
                    {
                        isShow = 0;
                        ltlTeam.Text = "<div class=\"mypasswd\" >已加入[" + dtteam.Rows[0]["iSNo"].ToString() + "]队</div>";
                    }
                    else
                    {
                        isShow = 1;
                        ltlTeam.Text = "<div class=\"ktime\" onclick=\"newteam();\">我要组队</div>";
                    }
                }
            }
        }
    }
}