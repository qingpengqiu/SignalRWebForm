using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB5_Model = Erun360.Model.DB5;
using DB5_DAL = Erun360.DAL.DB5;
using DB5_BLL = Erun360.BLL.DB5;
using System.Text;

public partial class TrainingPlan_TrainingPlan : PageBase
{
    protected string PlanCode;
    protected int? currentweek;
    protected string strcurrentweek;
    protected DateTime? currmondayofdate;
    protected int Plan_Person_Id;
    string RangeGR ;
    string RangeGE;
    string RangeOR;
    string RangeRO;
    protected void Page_Load(object sender, EventArgs e)
    {
        var PlanPerson_BLL = new DB5_BLL.tblPlan_Person();
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
        }
        else
        {
            Plan_Person_Id = PlanPerson_BLL.GetGoingPlanPersonIdByUId(CurrentUser.uId);
            var PlanPersonModel = PlanPerson_BLL.GetModel(Plan_Person_Id);
            if (PlanPersonModel != null)
            {
                PlanCode = PlanPersonModel.iLevel + "_" + PlanPersonModel.iWeek + "_" + PlanPersonModel.iTimes + "_" + PlanPersonModel.idistance;
                currentweek = PlanPersonModel.currweek;
                TimeSpan timespan = DateTime.Parse(PlanPersonModel.currmondayofdate.ToString()) - DateTime.Parse(PlanPersonModel.dStart.ToString());
                int days = timespan.Days;
                int weeks = days / 7 + 1;
                strcurrentweek = weeks.ToString();
                currmondayofdate = PlanPersonModel.currmondayofdate;

                RangeGR = PlanPersonModel.RangeGR;
                RangeGE = PlanPersonModel.RangeGE;
                RangeOR = PlanPersonModel.RangeOR;
                RangeRO = PlanPersonModel.RangeRO;
                DataTable dtCurrentWeekPlan = new DB5_BLL.tblPlan().GetListOfCurrentWeek(PlanCode, (int)currentweek).Tables[0];
                StringBuilder returnhtml = new StringBuilder();
                for (int i = 1; i <= 7; i++)
                {
                    int outPlanType = 0;
                    string PlanContentOfDay = GetPlanContentOfDay(dtCurrentWeekPlan, i, "iOrder", ref outPlanType);
                    string FeedbackOfDay = string.Empty;
                    if (outPlanType != 3)
                    {
                        FeedbackOfDay = GetFeedbackOfDay(Plan_Person_Id, CurrentUser.uId, PlanPersonModel.currweek, i, PlanPersonModel.currmondayofdate);
                    }
                    returnhtml.AppendFormat("<div class=\"plantr\">" +
                        "<div class=\"plantd\">周{0}</div>" +
                        "<div class=\"plantd\">{1}</div>" +
                        "<div class=\"plantd\"><input type=\"hidden\" class=\"weekday\" value=\"{2}\" />{3}</div>" +
                    "</div>", GetDayByNo(i), PlanContentOfDay, i, FeedbackOfDay);
                }
                litWeekPlan.Text = returnhtml.ToString();
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

    public string GetPlanContentOfDay(DataTable dtPlan, int Day,string orderField, ref int planType)
    {
        StringBuilder printer = new StringBuilder();
        DataRow[] drDayInfo = dtPlan.Select("iDay=" + Day, orderField);
        foreach (var dr in drDayInfo)
        {
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
                    printer.AppendFormat("【心率区间:{0}】<br/>", RangeGR);
                    break;
                case 2:
                    printer.AppendFormat("【心率区间:{0}】<br/>", RangeGE);
                    break;
                case 3:
                    printer.AppendFormat("【心率区间:{0}】<br/>", RangeOR);
                    break;
                case 4:
                    printer.AppendFormat("【心率区间:{0}】<br/>", RangeRO);
                    break;
                default:
                    printer.Append("<br/>");
                    break;
            }
        }
        return printer.ToString();
    }

    public string GetFeedbackOfDay(int PlanPersonId,int UserId,int? Week,int Day,DateTime? DateTimeOfMonday)
    {
        StringBuilder printer = new StringBuilder();
        DataSet dsDayContent = new DB5_BLL.tblPlan_Feedback().GetDayContentOfPlan(PlanPersonId, UserId, Week, Day, DateTimeOfMonday);

        if (dsDayContent != null && dsDayContent.Tables.Count > 0 && dsDayContent.Tables[0].Rows.Count>0)
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
            if (int.Parse(drDayContent["iResult"].ToString())==0)
            {
                printer.Append("未完成");
            }
            else
            {
                printer.AppendFormat("{0} | 状态：{1} | 时间：{2} 分钟 | 平均心率：{3} 次/分钟 | 距离：{4} 公里", resultstateinfo, fatigueinfo, drDayContent["dTime"].ToString(), drDayContent["iAvghr"].ToString(), drDayContent["iDistance"].ToString());
            }
        }
        else
        {
            printer.Append("<div class=\"planbuttom plany\">已完成</div><div class=\"planbuttom planw\">未完成</div><div class=\"planbuttom planb\">补完成</div>");
        }
        return printer.ToString();
    }
}