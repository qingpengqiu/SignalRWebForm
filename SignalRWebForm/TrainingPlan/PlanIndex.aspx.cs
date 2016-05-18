using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB5_Model = Erun360.Model.DB5;
using DB5_DAL = Erun360.DAL.DB5;
using DB5_BLL = Erun360.BLL.DB5;
using System.Text;
using System.Data;

public partial class TrainingPlan_PlanIndex : PageBase
{
    protected string PlanCode;
    protected int? currentweek;
    protected int currentDay;
    protected string strcurrentweek;
    protected DateTime? currmondayofdate;
    protected int Plan_Person_Id;
    string RangeGR;
    string RangeGE;
    string RangeOR;
    string RangeRO;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
        }
        else
        {
            var PlanPerson_BLL = new DB5_BLL.tblPlan_Person();
            Plan_Person_Id = PlanPerson_BLL.GetLastPlanPersonIdByUId(CurrentUser.uId);
            var PlanPersonModel = PlanPerson_BLL.GetModel(Plan_Person_Id);
            if (PlanPersonModel != null)
            {
                if (PlanPersonModel.isfinish==0)
                {
                    if (DateTime.Now > PlanPersonModel.currmondayofdate && DateTime.Now < DateTime.Parse(PlanPersonModel.currmondayofdate.ToString()).AddDays(7))
                    {
                        PlanCode = PlanPersonModel.iLevel + "_" + PlanPersonModel.iWeek + "_" + PlanPersonModel.iTimes + "_" + PlanPersonModel.idistance;
                        currentweek = PlanPersonModel.currweek;
                        currentDay = (int)DateTime.Now.DayOfWeek == 0 ? 7 : (int)DateTime.Now.DayOfWeek;
                        currmondayofdate = PlanPersonModel.currmondayofdate;
                        DataTable dtCurrentWeekPlan = new DB5_BLL.tblPlan().GetListOfCurrentWeek(PlanCode, (int)currentweek).Tables[0];
                        this.litCurrentDayPlaninfo.Text = GetCurrentDayPlanInfo(PlanPersonModel, currentDay, dtCurrentWeekPlan);
                        this.litCreatePlan.Text = "<div style=\"margin:30px 1px;\"></div>";
                    }
                    else if (DateTime.Now > DateTime.Parse(PlanPersonModel.currmondayofdate.ToString()).AddDays(7) && DateTime.Now < DateTime.Parse(PlanPersonModel.currmondayofdate.ToString()).AddDays(10))
                    {
                        this.litCurrentDayPlaninfo.Text = string.Format("<div class=\"thisplan\"><h2>您上周有部分训练没有反馈信息，请在今天补填上周的反馈信息，否则系统会视为缺勤，继续给出下一周的训练计划；<br/><br/>请点击下方链接进行补填！</h2><a href=\"/TrainingPlan/TrainingPlan.aspx\" target=\"_blank\">补填上周训练计划反馈信息</a></div>");
                        this.litCreatePlan.Text = "<div style=\"margin:30px 1px;\"></div>";
                    }
                    else if (DateTime.Now < PlanPersonModel.currmondayofdate)
                    {
                        TimeSpan timespan = DateTime.Parse(PlanPersonModel.currmondayofdate.ToString()) - DateTime.Parse(PlanPersonModel.dStart.ToString());
                        int days = timespan.Days;
                        int weeks = days / 7 + 1;
                        this.litCurrentDayPlaninfo.Text = string.Format("<div class=\"thisplan\"><h2>{0}公里{2}{3}周训练计划 [第{5}周]<br/> <br/> 开始时间:{1}</h2></div>", PlanPersonModel.idistance, PlanPersonModel.currmondayofdate == null ? "" : DateTime.Parse(PlanPersonModel.currmondayofdate.ToString()).ToShortDateString(), PlanPersonModel.iLevel == 101 ? "初级" : "高级", PlanPersonModel.iWeek, PlanPersonModel.currweek, weeks);
                        this.litCreatePlan.Text = "<div style=\"margin:30px 1px;\"></div>";
                    }                    
                }
                else
                {
                    this.litCreatePlan.Text = "<div class=\"goplanbuttom\"><a href=\"/TrainingPlan/StepFirst.aspx\" style=\"text-decoration:none; text-decoration-style:none;\" target=\"_blank\">创建训练计划</a></div>";
                    this.litCurrentDayPlaninfo.Text = "<div class=\"thisplan\">暂无个人训练计划</div>";
                }

            }
            else
            {
                this.litCreatePlan.Text = "<div class=\"goplanbuttom\"><a href=\"/TrainingPlan/StepFirst.aspx\" style=\"text-decoration:none; text-decoration-style:none;\" target=\"_blank\">创建训练计划</a></div>";
                this.litCurrentDayPlaninfo.Text = "<div class=\"thisplan\">暂无个人训练计划</div>";
            }
            litHistoryPlans.Text = GetHistoryPlans();
        }
    }

    public string GetCurrentDayPlanInfo(DB5_Model.tblPlan_Person PlanPersonModel, int DayOfWeek, DataTable dtCurrentWeekPlan)
    {
        StringBuilder printer = new StringBuilder();
        RangeGR = PlanPersonModel.RangeGR;
        RangeGE = PlanPersonModel.RangeGE;
        RangeOR = PlanPersonModel.RangeOR;
        RangeRO = PlanPersonModel.RangeRO;
        TimeSpan timespan = DateTime.Now - DateTime.Parse(PlanPersonModel.dStart.ToString());
        int days = timespan.Days;
        int weeks = days / 7 + 1;
        int outPlanType = 0;
        string PlanContentOfDay = GetPlanContentOfDay(dtCurrentWeekPlan, DayOfWeek == 0 ? 7 : DayOfWeek, "iOrder", ref outPlanType);
        string FeedbackOfDay = string.Empty;
        printer.AppendFormat("<div class=\"thisplan\"><h2>{1}公里{3}{4}周训练计划 [第{5}周~周{0}]</h2><div id=\"plancontentofday\" >", GetDayByNo(DayOfWeek), PlanPersonModel.idistance, PlanPersonModel.currweek, PlanPersonModel.iLevel == 101 ? "初级" : "高级", PlanPersonModel.iWeek, weeks);
        if (outPlanType != 3)
        {
            FeedbackOfDay = GetFeedbackOfDay(Plan_Person_Id, CurrentUser.uId, PlanPersonModel.currweek, DayOfWeek == 0 ? 7 : DayOfWeek, PlanPersonModel.currmondayofdate);
            if (FeedbackOfDay.Contains("<i>"))
            {
                printer.Append(FeedbackOfDay);
            }
            else
            {
                printer.Append(PlanContentOfDay);
                printer.Append(FeedbackOfDay);
            }

        }
        else
        {
            printer.AppendFormat("<i>休息</i><div class=\"planiaction\"></div>");
        }
        printer.AppendFormat("</div><a href=\"/TrainingPlan/TrainingPlan.aspx\" target=\"_blank\">查看本周训练计划</a></div>");

        return printer.ToString();
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
            case 0:
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
            int iType = TypeChangeDefault.NullToInt(dr["iType"].ToString(), 0);
            planType = iType;
            int iStrong = TypeChangeDefault.NullToInt(dr["iStrong"].ToString(), 0);
            switch (iType)
            {
                case 1:
                    printer.Append("<i>" + dr["iTime"].ToString() + " min");
                    break;
                case 2:
                    printer.Append("<i>" + dr["cspace"].ToString());
                    break;
                case 3:
                    printer.Append("<i>休息");
                    break;
                case 4:
                    printer.Append("<i>" + dr["iTime"].ToString());
                    break;
                default:
                    break;
            }
            switch (iStrong)
            {
                case 1:
                    printer.AppendFormat("【心率区间:{0}】</i>", RangeGR);
                    break;
                case 2:
                    printer.AppendFormat("【心率区间:{0}】</i>", RangeGE);
                    break;
                case 3:
                    printer.AppendFormat("【心率区间:{0}】</i>", RangeOR);
                    break;
                case 4:
                    printer.AppendFormat("【心率区间:{0}】</i>", RangeRO);
                    break;
                default:
                    printer.Append("</i>");
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
                printer.Append("<i>未完成</i><div class=\"planiaction\"></div>");
            }
            else
            {
                printer.AppendFormat("<i>{0} </i> <i>状态：{1} </i> <i>时间：{2} 分钟 </i> <i>平均心率：{3} 次/分钟 </i> <i>距离：{4} 公里</i><div class=\"planiaction\"></div>", resultstateinfo, fatigueinfo, drDayContent["dTime"].ToString(), drDayContent["iAvghr"].ToString(), drDayContent["iDistance"].ToString());
            }
        }
        else
        {
            printer.Append("<div class=\"planiaction\"><em class=\"plany\">已完成</em><em class=\"planw\">未完成</em></div>");//<em class=\"planb\">补完成</em>
        }
        return printer.ToString();
    }

    public string GetHistoryPlans()
    {
        StringBuilder printer = new StringBuilder();
        DataSet dsHistoryPlans = new DB5_BLL.tblPlan_Person().GetFinishedPlansByUId(CurrentUser.uId);
        if (dsHistoryPlans != null && dsHistoryPlans.Tables.Count > 0 && dsHistoryPlans.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow drHistoryPlan in dsHistoryPlans.Tables[0].Rows)
            {
                printer.AppendFormat("<a href=\"/TrainingPlan/HistoryPlanInfo.aspx?ppid={0}\">{1}公里{2}训练计划</a>", drHistoryPlan["id"].ToString(), drHistoryPlan["idistance"].ToString(), drHistoryPlan["iLevel"].ToString() == "101" ? "初级" : "高级");
            }
        }
        else
        {
            printer.AppendFormat("<div class=\"thisplan\">暂无历史训练计划</div>");
        }
        return printer.ToString();
    }

}