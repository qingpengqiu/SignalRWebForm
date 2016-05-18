using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using DB5_Model = Erun360.Model.DB5;
using DB5_DAL = Erun360.DAL.DB5;
using DB5_BLL = Erun360.BLL.DB5;

public partial class TrainingPlan_HistoryPlanInfo : PageBase
{
    protected string PlanCode;
    protected int Plan_Person_Id = 0;
    protected int WeekIndex;

    DB5_Model.tblPlan_Person PlanPersonModel;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["ppid"]))
            Plan_Person_Id = int.Parse(Request.QueryString["ppid"]);
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
        }
        else if (Plan_Person_Id != 0)
        {
            PlanPersonModel = new DB5_BLL.tblPlan_Person().GetModel(Plan_Person_Id);
            if (!IsPostBack)
            {
                BindDDListWeeks(PlanPersonModel);
                WeekIndex = 1;//默认显示第一周训练反馈信息
                litWeekPlan.Text = GetFeekbackOfWeek(WeekIndex, PlanPersonModel);
            }
        }
        else if (Plan_Person_Id == 0)
        {
            Response.Write("<script language='javascript'>alert('非法访问');window.location.href='/TrainingPlan/PlanIndex.aspx';</script>");
        }
    }
    public void BindDDListWeeks(DB5_Model.tblPlan_Person PlanPersonModel)
    {
        int WeekCount = 0;
        DateTime? MaxFeedbackCreateDate = new DB5_BLL.tblPlan_Feedback().GetMaxCreateDateOfFeedbackByPPId(Plan_Person_Id);
        if (MaxFeedbackCreateDate != null && PlanPersonModel.dStart != null)
        {
            TimeSpan timespan = DateTime.Parse(MaxFeedbackCreateDate.ToString()).Subtract(DateTime.Parse(PlanPersonModel.dStart.ToString()));
            if (timespan.Days % 7 == 0)
            {
                WeekCount = timespan.Days / 7;
            }
            else
            {
                WeekCount = timespan.Days / 7 + 1;
            }
            for (int i = 1; i <= WeekCount; i++)
            {
                ListItem item = new ListItem(i.ToString(), i.ToString());
                this.ddlistWeeks.Items.Add(item);
            }
        }
    }
    public string GetDayByNo(int? No)
    {
        string returnvalue = string.Empty;
        switch (No)
        {
            case 1:
                returnvalue = "一";
                break;
            case 2:
                returnvalue = "二";
                break;
            case 3:
                returnvalue = "三";
                break;
            case 4:
                returnvalue = "四";
                break;
            case 5:
                returnvalue = "五";
                break;
            case 6:
                returnvalue = "六";
                break;
            case 7:
                returnvalue = "日";
                break;
            default:
                break;
        }
        return returnvalue;
    }
    public string GetPlanContentOfDay(DataTable dtPlan, int Day, string orderField, ref int planType)
    {
        StringBuilder printer = new StringBuilder();
        DataRow[] drDayInfo = dtPlan.Select("iDay=" + Day, orderField);
        foreach (var dr in drDayInfo)
        {
            string RangeGR = string.Empty;
            string RangeGE = string.Empty;
            string RangeOR = string.Empty;
            string RangeRO = string.Empty;
            RangeGR = PlanPersonModel.RangeGR;
            RangeGE = PlanPersonModel.RangeGE;
            RangeOR = PlanPersonModel.RangeOR;
            RangeRO = PlanPersonModel.RangeRO;
            int iType = TypeChangeDefault.NullToInt(dr["iType"].ToString(), 0);
            planType = iType;
            int iStrong = TypeChangeDefault.NullToInt(dr["iStrong"].ToString(), 0);
            switch (iType)
            {
                case 1:
                    printer.Append(dr["iTime"].ToString() + " min");
                    break;
                case 2:
                    printer.Append(dr["cspace"].ToString());
                    break;
                case 3:
                    printer.Append("休息");
                    break;
                case 4:
                    printer.Append(dr["iTime"].ToString());
                    break;
                default:
                    break;
            }
            switch (iStrong)
            {
                case 1:
                    printer.AppendFormat("(心率区间:{0})<br/>", RangeGR);
                    break;
                case 2:
                    printer.AppendFormat("(心率区间:{0})<br/>", RangeGE);
                    break;
                case 3:
                    printer.AppendFormat("(心率区间:{0})<br/>", RangeOR);
                    break;
                case 4:
                    printer.AppendFormat("(心率区间:{0})<br/>", RangeRO);
                    break;
                default:
                    printer.Append("<br/>");
                    break;
            }
        }
        return printer.ToString();
    }
    public string GetFeedbackOfDay(int PlanPersonId, int UserId, int? Week, int Day, DateTime? DateTimeOfMonday)
    {
        StringBuilder printer = new StringBuilder();
        DataSet dsDayContent = new DB5_BLL.tblPlan_Feedback().GetDayContentOfPlan(PlanPersonId, UserId, Week, Day, DateTimeOfMonday);

        if (dsDayContent != null && dsDayContent.Tables.Count > 0 && dsDayContent.Tables[0].Rows.Count > 0)
        {
            DataRow drDayContent = dsDayContent.Tables[0].Rows[0];

            string resultstateinfo = string.Empty;
            switch (int.Parse(drDayContent["iResult"].ToString()))
            {
                case 0:
                    resultstateinfo = "未完成";
                    break;
                case 1:
                    resultstateinfo = "已完成";
                    break;
                case 2:
                    resultstateinfo = "补完成";
                    break;
                default:
                    break;
            }
            string fatigueinfo = string.Empty;
            switch (int.Parse(drDayContent["iFatigue"].ToString()))
            {
                case 0:
                    fatigueinfo = "不疲劳";
                    break;
                case 1:
                    fatigueinfo = "轻度疲劳";
                    break;
                case 2:
                    fatigueinfo = "很疲劳";
                    break;
                default:
                    break;
            }
            if (int.Parse(drDayContent["iResult"].ToString()) == 0)
            {
                printer.Append("未完成");
            }
            else
            {
                printer.AppendFormat("{0} | 状态：{1} | 时间：{2} 分钟 | 平均心率：{3} 次/分钟 | 距离：{4} 公里", resultstateinfo, fatigueinfo, drDayContent["dTime"].ToString(), drDayContent["iAvghr"].ToString(), drDayContent["iDistance"].ToString());
            }
        }
        return printer.ToString();
    }
    public string GetFeekbackOfWeek(int WeekIndex, DB5_Model.tblPlan_Person PlanPersonModel)
    {
        StringBuilder returnhtml = new StringBuilder();
        if (PlanPersonModel.dStart != null)
        {
            int WeekNo = 0;
            PlanCode = PlanPersonModel.iLevel + "_" + PlanPersonModel.iWeek + "_" + PlanPersonModel.iTimes + "_" + PlanPersonModel.idistance;
            DateTime StartDate = (DateTime)PlanPersonModel.dStart;
            TimeSpan tsStart = new TimeSpan((WeekIndex - 1) * 7, 0, 0, 0);
            TimeSpan tsEnd = new TimeSpan(WeekIndex * 7, 0, 0, 0);
            DateTime StartOfWeek = StartDate.Add(tsStart);
            DateTime EndOfWeek = StartDate.Add(tsEnd);
            WeekNo = new DB5_BLL.tblPlan_Feedback().GetWeekNo(Plan_Person_Id, StartOfWeek, EndOfWeek);
            
            if (WeekNo != 0)
            {
                DataTable dtCurrentWeekPlan = new DB5_BLL.tblPlan().GetListOfCurrentWeek(PlanCode, WeekNo).Tables[0];
                for (int i = 1; i <= 7; i++)
                {
                    int outPlanType = 0;
                    string PlanContentOfDay = GetPlanContentOfDay(dtCurrentWeekPlan, i, "iOrder", ref outPlanType);
                    string FeedbackOfDay = string.Empty;
                    if (outPlanType != 3)
                    {
                        FeedbackOfDay = GetFeedbackOfDay(Plan_Person_Id, CurrentUser.uId, WeekNo, i, StartOfWeek);
                    }
                    returnhtml.AppendFormat("<div class=\"plantr\">" +
                        "<div class=\"plantd\">周{0}</div>" +
                        "<div class=\"plantd\">{1}</div>" +
                        "<div class=\"plantd\"><input type=\"hidden\" class=\"weekday\" value=\"{2}\" />{3}</div>" +
                    "</div>", GetDayByNo(i), PlanContentOfDay, i, FeedbackOfDay);
                }
            }
            else
                returnhtml.Append("<div style='font-size:16px;color:red;'>本周没有填写任何反馈信息!</div>");
        }
        return returnhtml.ToString();
    }
    protected void ddlistWeeks_SelectedIndexChanged(object sender, EventArgs e)
    {
        int index = (((System.Web.UI.WebControls.DropDownList)(sender))).SelectedIndex;
        WeekIndex = int.Parse((((System.Web.UI.WebControls.DropDownList)(sender))).Items[index].Value);
        litWeekPlan.Text = GetFeekbackOfWeek(WeekIndex,PlanPersonModel);
    }
}