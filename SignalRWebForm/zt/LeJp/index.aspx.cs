using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Data;
using Utils;
using System.Text.RegularExpressions;
public partial class zt_LeNy_index : PageBase
{
    public int uId = 0;
    public int jfd = 0;
    public int isout = 0;
    public int cid = 0;
    public string status_1 = string.Empty;
    public string status_2 = string.Empty;
    public string jf3_1 = string.Empty;
    public string jf3_2 = string.Empty;
    public string jf3_3 = string.Empty;
    public string jf3_4 = string.Empty;
    public string jf3_11 = string.Empty;
    public string jf3_22 = string.Empty;
    public string jf3_33 = string.Empty;
    public string jf3_44 = string.Empty;

    public string jf4_1 = string.Empty;
    public string jf4_2 = string.Empty;
    public string jf4_3 = string.Empty;
    public string jf4_4 = string.Empty;
    public string jf4_11 = string.Empty;
    public string jf4_22 = string.Empty;
    public string jf4_33 = string.Empty;
    public string jf4_44 = string.Empty;
    public string over = string.Empty;
    public string quiz_1 = "1";//男
    public string quiz_2 = "1";
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title = "益跑乐视东京马拉松竞猜赢手机-益跑网-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
        
        if (DateTime.Now > DateTime.Parse("2016-2-27 22:10"))
        {
            over = "over";
            quiz_1 = "0";
            quiz_2 = "0";
        }
        if (CurrentUser == null)
        {
            uId = 0;
            return;
        }
        else
        {
            uId = CurrentUser.uId;
        }

        isout = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId);
        if (!IsPostBack)
        {
            if (isout > 2000)
            {
                isout = 2000;
            }
            DataSet mod = new DB5.tblQuiz().GetList("idItem=3 and idUser =" + CurrentUser.uId);
            if (mod.Tables[0].Rows.Count > 0)
            {

                jfd = TypeChangeDefault.NullToInt(mod.Tables[0].Rows[0]["iAmount"], 0);
                cid = TypeChangeDefault.NullToInt(mod.Tables[0].Rows[0]["idMin"], 0);
                switch (cid.ToString())
                {
                    case "1":
                        jf3_1 = jfd.ToString();
                        jf3_11 = "this";
                        break;
                    case "2":
                        jf3_2 = jfd.ToString();
                        jf3_22 = "this";
                        break;
                    case "3":
                        jf3_3 = jfd.ToString();
                        jf3_33 = "this";
                        break;
                    case "4":
                        jf3_4 = jfd.ToString();
                        jf3_44 = "this";
                        break;
                    default:
                        break;
                }
                status_1 = "timeout";
                quiz_1 = "0";
                if (cid == 3)
                {
                    ltltesult.Text = "恭喜您,男子组竞猜成功，所获积分将在2-3个工作日转入您帐户。";
                }
                else
                {
                    ltltesult.Text = "很遗憾您没有竞猜成功。";
                }
            }
            DataSet tokyowoman = new DB5.tblQuiz().GetList("idItem=4 and idUser =" + CurrentUser.uId);
            if (tokyowoman.Tables[0].Rows.Count > 0)
            {

                jfd = TypeChangeDefault.NullToInt(tokyowoman.Tables[0].Rows[0]["iAmount"], 0);
                cid = TypeChangeDefault.NullToInt(tokyowoman.Tables[0].Rows[0]["idMin"], 0);
                switch (cid.ToString())
                {
                    case "1":
                        jf4_1 = jfd.ToString();
                        jf4_11 = "this";
                        break;
                    case "2":
                        jf4_2 = jfd.ToString();
                        jf4_22 = "this";
                        break;
                    case "3":
                        jf4_3 = jfd.ToString();
                        jf4_33 = "this";
                        break;
                    case "4":
                        jf4_4 = jfd.ToString();
                        jf4_44 = "this";
                        break;
                    default:
                        break;
                }
                status_2 = "timeout";
                quiz_2 = "0";
                if (cid == 4)
                {
                    ltltesult.Text = "恭喜您,女子组竞猜成功，所获积分将在2-3个工作日转入您帐户。";
                }
                else
                {
                    ltltesult.Text = "很遗憾您没有竞猜成功。";
                }
            }
        }
    }
}