using Erun360.Pay.Alipay.pc;
using Erun360.Pay.tenpayLib;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Xml;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
public partial class Competetion_payoffwx : PageBase
{
    public string parm = string.Empty;
    public int id = 0;//订单id  
    public string title = string.Empty;
    public string OrderNo = string.Empty;
    private int jpmin = 25;//机票过期时间（单位分钟）
    private int ssmin = 120;//赛事过期时间

    public int sid = 0;//赛事id  
    public string idItem = "0";//项目id  
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        OrderNo = TypeChangeDefault.NullToString(Request.QueryString["order"], "");
        parm = TypeChangeDefault.NullToString(Request.QueryString["parm"], "");        
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition modelrace = new DB6.tblRace_Competition().GetModel(sid);
            if (modelrace == null)
            {
                AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
                return;
            }
            int idUser = 0;
            if (CurrentUser != null)
            {
                idUser = CurrentUser.uId;
            }
            if (modelrace.idUser != idUser || idUser != 100000002)
            {
                if (1 != modelrace.iStatus)
                {
                    AlertHelper.JQAlertGo("该赛事已关闭！", "/Competetion/SearchEvent.aspx", false);
                    return;
                }
            }
            title = modelrace.cTitle;
            this.page_Title = title+"-订单支付-益跑赛事";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            ltlbanner.Text = modelrace.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + modelrace.cBanner + "\" alt=\"\"/>";
            DB6.tblOrder bll = new DB6.tblOrder();
            DBM6.tblOrder model = bll.GetModel(id);
            if (model == null)
            {
                AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            idItem = model.iItemID;
      
            if (model.iStatus >=2)
            {
                AlertHelper.JQAlertGo("您已付款成功!", "/Competetion/OrderDetails.aspx?sid=" + id + "&nav=2&orderid=" + model.cOrder_no, false);
                return;
            }
            else 
            {
                if (model.iStatus != 1)
                {
                    AlertHelper.JQAlertGo("该订单已过期，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                    return;
                }
            }

            if (model.cOrder_no != OrderNo)
            {
                AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }           
            ltlItem.Text = model.cItemName;
            ltlCost.Text = model.iCost.ToString();
            int min = 0;
            if (model.iFromTpye == 1)
            {
                DataTable dt = bll.GetList("cParentOrder='" + OrderNo + "' and idUser=" + CurrentUser.uId + " and iStatus=1 ").Tables[0];
                int count = dt.Rows.Count;
                if (count == 0)
                {
                    AlertHelper.JQAlertGo("该订单已过期，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                    return;
                }
                int[] intArray = new int[count];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    int iFromTpye = TypeChangeDefault.NullToInt(dt.Rows[i]["iFromTpye"], 0);
                    //单位分钟
                    if (iFromTpye == 3)//机票业务
                    {
                        intArray[i] = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[i]["dConfirmTime"], bll.GetTime(0)), jpmin);
                    }
                    else 
                    {
                        intArray[i] = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[i]["dConfirmTime"], bll.GetTime(0)), ssmin); 
                    }
                }
                ArrayList list = new ArrayList(intArray);
                list.Sort();
                min = Convert.ToInt32(list[0]);//取最小值

            }
            else
            {
                //单位分钟
                if (model.iFromTpye == 3)//机票业务
                {
                   
                    min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), jpmin);
                }
                else 
                {
                    min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), ssmin);

                }
            }
            if (min == 0)
            {
                AlertHelper.JQAlertGo("该订单已过期，请重新选择!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            if (min > 60)
            {
                //;
                //Convert.ToInt32(Math.Ceiling((decimal)((decimal)min / (decimal)60)));
                ltlMax.Text = Convert.ToString(Math.Floor(min / 60.0)) + "小时" + Convert.ToString(Math.Floor(min % 60.0)) + "分钟";
            }
            else
                ltlMax.Text = min.ToString() + "分钟";
        }
    }
    /// <summary>
    /// 过期时间
    /// </summary>
    /// <param name="date1"></param>
    /// <param name="max">默认过期最大值（单位分钟）</param>
    /// <returns></returns>
    protected int deadline(DateTime date1, int max)
    {
        //DateTime date1 = model.dConfirmTime ?? DateTime.Now;
        DateTime date2 = new DB6.tblOrder().GetTime(0);
        // todo: 时间初始化
        TimeSpan timeSpan = date2 - date1;
        double ts = Math.Floor(timeSpan.TotalMinutes);//取整数3.9=3;
        int mm = TypeChangeDefault.NullToInt(ts, 0);
        if (mm < 0 || mm > max)
        {
            return 0;
        }
        return max - mm;
    }
}