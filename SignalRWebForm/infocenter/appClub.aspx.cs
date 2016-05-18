using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using DBM1 = Erun360.Model.DB1;
using DB1 = Erun360.BLL.DB1;
using Utils;
using System.Text;

public partial class infocenter_appClub : PageBase
{
    public StringBuilder tempModel = new StringBuilder();
    public string iCity = string.Empty;
    public string iArea = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title ="创建俱乐部-益跑网个人中心-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";

        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (!IsPostBack)
        {
            if (new DB4.tblRACE_CLUB().GetRecordCount(" iAudit=1 and idUser=" + CurrentUser.uId) > 0)
            {

                ViewState["idClubtmp"] = new DB4.tblRACE_CLUB().GetIdClub(CurrentUser.uId);
                DBM4.tblRACE_CLUB mClub = new DB4.tblRACE_CLUB().GetModel(TypeChangeDefault.NullToInt(ViewState["idClubtmp"].ToString(), 0));
                if (mClub != null)
                {
                    name.Value = mClub.cTitle;
                    Style.SelectedIndex = mClub.iStyle ?? 0;
                    Idmsg.Value = mClub.cDescription;
                    radiotemp.Value = mClub.cBackground;
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
                    int tmp = TypeChangeDefault.NullToInt(mClub.cBackground.ToString().Replace("v", ""), 0);
                    for (int i = 1; i <= 6; i++)
                    {
                        if (i == tmp)
                        {
                            tempModel.AppendLine("<li><label for=\"temp" + i + "\"><img src=\"/Html/images/v" + i + "s.jpg\" alt=\"模版" + i + "\" /></label><input value=\"v" + i + "\" name=\"temp\" id=\"temp" + i + "\" type=\"radio\" checked/></li>");
                        }
                        else
                        {
                            tempModel.AppendLine("<li><label for=\"temp" + i + "\"><img src=\"/Html/images/v" + i + "s.jpg\" alt=\"模版" + i + "\" /></label><input value=\"v" + i + "\" name=\"temp\" id=\"temp" + i + "\" type=\"radio\" /></li>");
                        }
                    }
                }

                AlertHelper.JQAlert("审核未通过请完善俱乐部", false);
                return;
            }
            else if (new DB4.tblRACE_CLUB().GetRecordCount(" iAudit>2 and idUser=" + CurrentUser.uId) > 0)
            {
                AlertHelper.JQAlertGo("亲，您已创建了俱乐部", UrlHelper.MemberUrl(CurrentUser.uId), false);
            }
            else if (new DB4.tblRACE_CLUB().GetRecordCount(" iAudit<=2 and idUser=" + CurrentUser.uId) > 0)
            {
                AlertHelper.JQAlertGo("您已申请，请等待审核！", UrlHelper.MemberUrl(CurrentUser.uId), false);
            }

            if (ViewState["idClubtmp"] == null)
            {
                for (int i = 1; i <= 6; i++)
                {
                    if (i == 1)
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
        
        DBM4.tblRACE_CLUB mClub = new DBM4.tblRACE_CLUB();
        if (name.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写俱乐部名称！", false);
            return;
        }
        else if (name.Value.Trim().Length > 60)
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
        //mClub.cBackground = "/Html/css/themes-club-v1.css";
        mClub.idUser = CurrentUser.uId;
        mClub.cUserName = CurrentUser.cNickName;
        mClub.iMemberLimit = 50;
        mClub.iAudit = 5;
        mClub.iLevel = 1;
        mClub.iStates = 0;

        if (ViewState["idClubtmp"] != null)
        {
            mClub.id = TypeChangeDefault.NullToInt(ViewState["idClubtmp"].ToString(), 0);
            if (new DB4.tblRACE_CLUB().Update(mClub))
            {
                DBM1.tblMEMBER mMember = new DBM1.tblMEMBER();
                mMember.idMemberStyle = 2;
                mMember.id = CurrentUser.uId;
                new DB1.tblMEMBER().Update(mMember);
                Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().UpdateUserModel(CurrentUser.uId);
                AlertHelper.JQAlertGo("申请俱乐部成功！", UrlHelper.ClubUrl(mClub.id), true);
            }
            else
            {
                AlertHelper.JQAlert("提交失败，请重试！", false);
            }
        }
        else
        {
            int idClub = new DB4.tblRACE_CLUB().Add(mClub);
            if (idClub > 0)
            {
                DBM1.tblMEMBER mMember = new DBM1.tblMEMBER();
                mMember.idMemberStyle = 2;
                mMember.id = CurrentUser.uId;
                new DB1.tblMEMBER().Update(mMember);
                Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().UpdateUserModel(CurrentUser.uId);
                AlertHelper.JQAlertGo("申请俱乐部成功！", UrlHelper.ClubUrl(idClub), true);
            }
            else
            {
                AlertHelper.JQAlert("提交失败，请重试！", false);
            }
        }
        //创建俱乐部积分
        DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
        if (!uMember_History.Exists(200810019, CurrentUser.uId))
        {
            new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810019, 1, 0);           
        }
    }
}