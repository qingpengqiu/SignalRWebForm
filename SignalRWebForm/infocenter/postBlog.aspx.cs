using System;
using System.Collections.Generic;
using System.Data;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Erun360.BLL;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DBM1 = Erun360.Model.DB1;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using Utils;
public partial class infocenter_postBlog : PageBase
{
    private int bId = 0;
    public int uId = 0;
    public string eidtblog = "0";
    private int idRace = 0;
    protected int pergroupid = 0;
    protected string clubs = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) { PopupShowdl();StatusCheck();});</script>");
            return;
        }
        uId = CurrentUser.uId;
        
        if (Request.QueryString["bId"] != null)
        {
            eidtblog = "1";
            bId = int.Parse(Request.QueryString["bId"].ToString());
        }
        if (Request.QueryString["from"] != null)
        {
            idRace = Convert.ToInt32((Request.QueryString["from"].ToString()));
            DBM4.tblRACE_ACTIVITY activity = new DB4.tblRACE_ACTIVITY().GetModel(idRace);
            if (activity != null)
            {
                if (!new DB4.tblRACE_JOIN().Exists(idRace, uId))
                {
                    AlertHelper.JQAlertGo("您还没加入该活动，不能进行博文分享", UrlHelper.MemberUrl(CurrentUser.uId), false);
                }
            }
            else
            {
                AlertHelper.JQAlertGo("该活动已被删除！！！", UrlHelper.MemberUrl(CurrentUser.uId), false);
            }
        }
        if (!IsPostBack)
        {
            if (CurrentUser != null)
            {
                //BlogGroupBind();
                //ClubBind();
                if (0 != bId)
                {
                    DBM2.tblBLOG model = new DB2.tblBLOG().GetModel(bId);
                    if (model != null)
                    {
                        title.Value = model.cTitle;
                        content.Value = model.cContent.Replace("[IMG]", "<img src=\"").Replace("[/IMG]", "\"/>");
                        //blogtype.SelectedValue = model.idPersonGroup.ToString();
                        pergroupid = model.idPersonGroup ?? 0;
                        DB4.tblRACE_CLUB_MEMBER bClub = new DB4.tblRACE_CLUB_MEMBER();
                        DataTable dt = bClub.GetList(" iStates=2 and idUser=" + CurrentUser.uId, " idClub desc ").Tables[0];
                        if (dt.Rows.Count > 0)
                        {
                            //Idclub.Visible = true;
                            DB4.tblRACE_LINKS uLinks = new DB4.tblRACE_LINKS();
                            for (int i = 0; i < dt.Rows.Count; i++)//给CheckBoxList选中的复选框 赋值
                            {
                                DataTable dtlink = uLinks.GetList(" idSlave=" + bId + " and idUser=" + CurrentUser.uId).Tables[0];
                                for (int j = 0; j < dtlink.Rows.Count; j++)
                                {
                                    if (dt.Rows[i]["idClub"].ToString() == dtlink.Rows[j]["idMaster"].ToString())
                                    {
                                        //club.Items[i].Selected = true;
                                        clubs += dt.Rows[i]["idClub"].ToString()+",";
                                    }
                                }
                            }
                            if (clubs.Length>0)
                            {
                                clubs = clubs.Substring(0, clubs.Length - 1);
                            }
                        }
                        else
                        {
                            //Idclub.Visible = false;
                        }


                    }
                    else
                    {
                        AlertHelper.JQAlertGo("该博文不存在或者已删除,不能进行编辑", UrlHelper.MemberUrl(CurrentUser.uId), false);
                    }
                }
                DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(CurrentUser.uId);
                if (0 > user.idMemberStyle)
                {
                    AlertHelper.JQAlertGo("你的账号已被限制！！！", "/Member/Logout.aspx", false);
                    return;
                }
            }
        }

        this.page_Title ="发布博文-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";

        //if (!Me.HostRequired)
        //{
        //    AlertHelper.JQAlertGo("你的账号已被限制！！！", "/Member/Logout.aspx", false);
        //    return;
        //}

    }
    //绑定博客组
    private void BlogGroupBind()
    {
        DB2.tblBLOG_GROUP bGroup = new DB2.tblBLOG_GROUP();
        DataTable dt = bGroup.GetList(" idUser=" + CurrentUser.uId).Tables[0];
        //blogtype.DataSource = dt;
        //blogtype.DataTextField = "cTitle"; //dropdownlist的Text的字段
        //blogtype.DataValueField = "id";//dropdownlist的Value的字段
        //blogtype.DataBind();
    }
    /// <summary>
    /// 根据用户id绑定用户所参与的俱乐部
    /// </summary>
    private void ClubBind()
    {
        DB4.tblRACE_CLUB_MEMBER bClub = new DB4.tblRACE_CLUB_MEMBER();
        DataTable dt = bClub.GetList(" iStates=2 and idUser=" + CurrentUser.uId, " idClub desc ").Tables[0];
        //club.DataSource = dt;
        if (dt.Rows.Count > 0)
        {
            //Idclub.Visible = true;
            //club.DataTextField = "cClubName"; //dropdownlist的Text的字段
            //club.DataValueField = "idClub";//dropdownlist的Value的字段
            //club.DataBind();
        }
        else
        {
        }
    }

    public string[] GetHtmlImageUrlList(string sHtmlText)
    {
        // 定义正则表达式用来匹配 img 标签
        Regex regImg = new Regex(@"<img\b[^<>]*?\bsrc[\s\t\r\n]*=[\s\t\r\n]*[""']?[\s\t\r\n]*(?<imgUrl>[^\s\t\r\n""'<>]*)[^<>]*?/?[\s\t\r\n]*>", RegexOptions.IgnoreCase);
        // 搜索匹配的字符串
        MatchCollection matches = regImg.Matches(sHtmlText);
        int i = 0;
        string[] sUrlList = new string[matches.Count];
        // 取得匹配项列表
        foreach (Match match in matches)
            sUrlList[i++] = match.Groups["imgUrl"].Value;

        return sUrlList;
    }
}