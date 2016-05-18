using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using System.Text;
public partial class infocenter_Plaza : PageBase
{
    private static string connectionString = ConfigurationManager.AppSettings["USER"];
    private WYX.Dataport.Dataport dp = new WYX.Dataport.Dataport(connectionString);

    public string strBolg = string.Empty;
    public string strDiscuss = string.Empty;
    public string strAmount = string.Empty;
    public string strRace = string.Empty;
    public string strUser = string.Empty;
    public string strIssue = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetNewBlog();
            GetDiscuss();
            GetAmount();
            GetRunning();
            GetNewUser();
            GetIssue();
        }
    }
    //最新博文
    public string GetNewBlog()
    {
        string sql = "SELECT TOP 6 blog.id,blog.cTitle,blog.idUser,users.cAvatar,users.cNickName  FROM [YP_DB_2].[dbo].[tblBLOG] as blog,[YP_DB_1].[dbo].[tblMEMBER] as users where blog.idHref=0 and  blog.idUser=users.id  order by blog.dCreate desc";
        DataTable dt = dp.GetDataSet(sql).Tables[0];
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                strBolg += "<li><a href=\"" + UrlHelper.MemberUrl(Int32.Parse(dt.Rows[i]["idUser"].ToString())) + "\" target=\"_blank\"><img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\"><span>" + dt.Rows[i]["cNickName"].ToString() + "</span></a> : <a href=\"" + UrlHelper.BlogUrl(Int32.Parse(dt.Rows[i]["id"].ToString())) + "\" target=\"_blank\">" + dt.Rows[i]["cTitle"].ToString() + "</a></li>";
            }
        }

        return strBolg;
    }
    //最新评论
    public string GetDiscuss()
    {
        Random rnd = new Random();
        string sql = "SELECT TOP (6) d.id, d.idInfo, d.idUser,d.cLoginname, d.cContent,  m.cNickName, m.cAvatar FROM YP_DB_3.dbo.tblDISCUSS_" + rnd.Next(10) + " AS d INNER JOIN YP_DB_1.dbo.tblMEMBER AS m ON d.idUser = m.id where left(idInfo,1)=2 and idUser !=100001183 ORDER BY d.id DESC";
        DataTable dt = dp.GetDataSet(sql).Tables[0];
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                strDiscuss += "<li><a href=\"" + UrlHelper.MemberUrl(Int32.Parse(dt.Rows[i]["idUser"].ToString())) + "\" target=\"_blank\"><img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\"><span>" + dt.Rows[i]["cNickName"].ToString() + "</span></a> : <a href=\"" + UrlHelper.BlogUrl(Int32.Parse(dt.Rows[i]["idInfo"].ToString())) + "\" target=\"_blank\">" + dt.Rows[i]["cContent"].ToString() + "</a></li>";
            }
        }

        return strDiscuss;
    }
    //最新跑量
    public string GetAmount()
    {
        Random rnd = new Random();
        StringBuilder sb = new StringBuilder();
        sb.Append("SELECT TOP 6 r.id, r.idUser, r.cName, r.dExpectTime,r.idRoadStyle, r.iDistance,m.cAvatar ");
        sb.Append("FROM YP_DB_4.dbo.tblRACE_HISTORY_" + rnd.Next(10) + " AS r INNER JOIN ");
        sb.Append("YP_DB_1.dbo.tblMEMBER AS m ON r.idUser = m.id ");
        sb.Append(" where iDistance>0 ");
        sb.Append("order by dExpectTime desc");

        //string sql = "SELECT TOP 6 [idUser],[cName],[iDistance],[dCreate] FROM [YP_DB_4].[dbo].[tblRACE_HISTORY_" + rnd.Next(10) + "] where iDistance>0 order by dCreate desc";
        DataTable dt = dp.GetDataSet(sb.ToString()).Tables[0];
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                strAmount += "<li><a href=\"" + UrlHelper.ScoreUrl(Int32.Parse(dt.Rows[i]["idUser"].ToString())) + "\" target=\"_blank\"><img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\"><span>" + dt.Rows[i]["cName"].ToString() + "</span></a> : 跑了 <span>" + dt.Rows[i]["iDistance"].ToString() + "KM</span> <br>地点：" + EnumRoad(TypeChangeDefault.NullToInt(dt.Rows[i]["idRoadStyle"].ToString(), 5)) + "</li>";
            }
        }
        return strAmount;
    }
    private string EnumRoad(int idRoadStyle)
    {
        string Road = string.Empty;
        switch (idRoadStyle)
        {
            case 0: Road = "公园"; break;//a
            case 1: Road = "田径场"; break;//b
            case 2: Road = "公路"; break;//o
            case 3: Road = "山路"; break;//ab
            case 4: Road = "跑步机"; break;//其他
            case 5: Road = "其它"; break;//其他
            default:
                break;
        }
        return Road;
    }
    //约跑
    public string GetRunning()
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("SELECT TOP (6) r.id,r.dOpen, r.iDistance, r.cAddress,r.idUser, m.cNickName, m.cAvatar ");
        sb.Append("FROM YP_DB_4.dbo.tblRACE_ACTIVITY AS r INNER JOIN ");
        sb.Append("YP_DB_1.dbo.tblMEMBER AS m ON r.idUser = m.id ");
        sb.Append("where iDistance>0 ");
        sb.Append("order by dOpen desc ");        
        DataTable dt = dp.GetDataSet(sb.ToString()).Tables[0];
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                strRace += "<li><a href=\"" + UrlHelper.MemberUrl(Int32.Parse(dt.Rows[i]["idUser"].ToString())) + "\" target=\"_blank\"><img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\"><span>" + dt.Rows[i]["cNickName"].ToString() + "</span></a> : " + Convert.ToDateTime(dt.Rows[i]["dOpen"].ToString()).ToString("M月dd日 HH:mm") + " <a href=\"" + UrlHelper.RaceUrl(Int32.Parse(dt.Rows[i]["id"].ToString())) + "\" target=\"_blank\">" + dt.Rows[i]["cAddress"].ToString() + dt.Rows[i]["iDistance"].ToString() + "KM约跑</a></li>";
                //strRace = "<a href=""><img src="/Html/images/cAvatar.png" alt=""><span>马拉松Sean :</span> </a>12月5日 9:00 ";
                //strRace = "<a href="">奥森南园 LSD 20KM约跑</a>";
               
                
            }
        }       
        return strRace;
    }
    //加入益跑
    public string GetNewUser()
    {
        string where=string.Empty;
        if (CurrentUser != null)
            where = "and id!= "+CurrentUser.uId;
        string sql = "SELECT top 12 [id],[cLoginname],[cAvatar],[cNickName] FROM [YP_DB_1].[dbo].[tblMEMBER] where idMemberStyle=0 " + where + "  order by id desc";
        DataTable dt = dp.GetDataSet(sql).Tables[0];
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                strUser += "<li><a href=\"" + UrlHelper.MemberUrl(Int32.Parse(dt.Rows[i]["id"].ToString())) + "\" target=\"_blank\"><img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\">" + dt.Rows[i]["cNickName"].ToString() + "</a></li>";
            }
        }

        return strUser;
    }
    //推荐博文
    public string GetIssue()
    {
        /*去掉以下几个账号发布的文章--编辑部 100000097
  --益跑天下 100000807
  --益跑赛事 100001183
  --转载中心 100000094
  --新闻中心100000093*/
        string sql = "SELECT TOP 8 p.id,p.idInfo,b.idUser, b.cTitle, m.cAvatar, m.cNickName FROM YP_DB_2.dbo.tblBLOG_PUBLISH AS p INNER JOIN YP_DB_2.dbo.tblBLOG AS b ON p.idInfo = b.id INNER JOIN YP_DB_1.dbo.tblMEMBER AS m ON b.idUser = m.id where left(p.idPosition,3)=300 and b.idUser not in(100000097,100000807,100001183,100000094,100000093)  order by p.id  desc";
        DataTable dt = dp.GetDataSet(sql).Tables[0];
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                strIssue += "<li><a href=\"" + UrlHelper.MemberUrl(Int32.Parse(dt.Rows[i]["idUser"].ToString())) + "\" target=\"_blank\"><img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\"><span>" + dt.Rows[i]["cNickName"].ToString() + "</span></a> : <a href=\"" + UrlHelper.BlogUrl(Int32.Parse(dt.Rows[i]["idInfo"].ToString())) + "\" target=\"_blank\">" + dt.Rows[i]["cTitle"].ToString() + "</a></li>";
            }
        }

        return strIssue;
    }
}