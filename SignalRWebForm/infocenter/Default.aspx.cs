using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Erun360.BLL;
using Erun360.Model;
using System.Collections;
using ERUN360.Entity;
using DB3 = Erun360.BLL.DB3;
using DBM1 = Erun360.Model.DB1;
using System.Data;
using DB1 = Erun360.BLL.DB1;
using System.Text;
using DB2 = Erun360.BLL.DB2;
using DB4 = Erun360.BLL.DB4;

using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json.Linq;
public partial class infocenter_Default : PageBase
{
    public int uId = 0;//规定当前用户id为cId
    public string AllList = string.Empty;
    public string BolgList = string.Empty;
    public string ActiveList = string.Empty;
    public string GameList = string.Empty;
    public string FriendList = string.Empty;
    public string NewCharts = string.Empty;
    public string weekData = string.Empty;
    public string iMarathon = string.Empty;
    public string iRunyear = string.Empty;
    public string iTrail = string.Empty;
    public int iMarathontype = 0;
    public string tMarathontime = string.Empty;
    public string cBio = string.Empty;
    public string cRacename = string.Empty;
    public int cId = 0;
    public DrillInfo drill = new DrillInfo();
    public int pageCount = 50; //总条目数
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uId"] == null)
        {
            Response.Redirect("/404.html");
        }
        uId = int.Parse(Request.QueryString["uId"].ToString());
        if (!new DB1.tblMEMBER().Exists(uId))
        {
            Response.Redirect("/404.html");
        }
        if (CurrentUser != null)
        {
            cId = CurrentUser.uId;
        }
        if (!IsPostBack)
        {
            if (CurrentUser != null)
            {
                //---------2013-08-15处理url重新 用户没有登录情况-----------
                //cId = CurrentUser.uId;               
                //--------------------

                string CharData = string.Empty;
                DataTable dt = new DB4.tblRACE_HISTORY().GetWeekData(CurrentUser.uId).Tables[0];
                int col = dt.Columns.Count;
                int num = 1;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    CharData +=  dt.Rows[i]["total"] + ",";
                    //CharData += "[" + dt.Rows[i]["weeks"] + "," + dt.Rows[i]["total"] + "],";
                    num++;
                }
                //[[4, 10], [5, 18], [6, 25], [7, 31],[8, 10], [9, 18]]

                weekData = "[" + CharData.TrimEnd(',') + "]";

                NewCharts = drill.GetChartXML(cId);
            }
            else
            {
                weekData = "[]";
            }
            if ((uId != 0) && uId != cId)
            {
                PreLoadInfo(uId);
            }
        }
        DBM1.tblMEMBER model = new DB1.tblMEMBER().GetModel(uId);
        if (model != null)
            this.page_Title = model.cNickName + "的个人中心-中国领先的跑步门户网站-ERUN360.COM";
        else
            this.page_Title = "个人中心-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";

    }
    protected void PreLoadInfo(int cid)
    {
        int count = new DB1.tblMEMBER().GetRecordCount("id=" + cid + " and idMemberStyle>=0");
        if (count == 0)
        {
            Response.Redirect("/", true);
        }
        DB1.tblRACERECORD bllrecord = new DB1.tblRACERECORD();
        DB1.tblRUNINTRO bllinto = new DB1.tblRUNINTRO();
        DataSet ds2 = bllrecord.GetList(" idUser=" + cid.ToString());
        for (int i = 0; i < ds2.Tables[0].Rows.Count; i++)
        {
            cRacename += ds2.Tables[0].Rows[i]["cRacename"].ToString() + " | ";
        }
        cRacename = cRacename.Trim();
        cRacename = cRacename.Trim('|');

        DataSet ds3 = bllinto.GetList(" idUser=" + cid.ToString());
        if (ds3.Tables[0].Rows.Count > 0)
        {
            iRunyear = ds3.Tables[0].Rows[0]["iRunyear"].ToString().Trim();
            iMarathon = ds3.Tables[0].Rows[0]["iMarathon"].ToString().Trim();
            iTrail = ds3.Tables[0].Rows[0]["iTrail"].ToString().Trim();
            iMarathontype = Convert.ToInt32(ds3.Tables[0].Rows[0]["iMarathontype"].ToString().Trim());
            tMarathontime = getnewtime(ds3.Tables[0].Rows[0]["tMarathontime"].ToString().Trim());
            cBio = ds3.Tables[0].Rows[0]["cBio"].ToString().Trim();

        }

    }
    protected string getnewtime(string time)
    {
        if (time.Trim().Length == 0 || time.Trim().Length <= 5)
        {
            return "";
        }

        string returnvalue = time.Substring(0, time.Length - 6) + "小时";
        if (time.Substring(time.Length - 5, 2) != "00")
        {
            returnvalue += time.Substring(time.Length - 5, 2) + "分";
        }
        if (time.Substring(time.Length - 2, 2) != "00")
        {
            returnvalue += time.Substring(time.Length - 2, 2) + "秒";
        }
        return returnvalue;
    }
}