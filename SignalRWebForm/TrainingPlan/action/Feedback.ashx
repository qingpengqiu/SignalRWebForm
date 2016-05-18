<%@ WebHandler Language="C#" Class="Feedback" %>

using System;
using System.Web;
using System.Web.SessionState;
using DB5_Model = Erun360.Model.DB5;
using DB5_DAL = Erun360.DAL.DB5;
using DB5_BLL = Erun360.BLL.DB5;
using Erun360.Model;
public class Feedback : IHttpHandler, IReadOnlySessionState
{
    string resmark = string.Empty;
    string resfeekbackInfo = string.Empty;
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            var type = context.Request.Form["type"];
            var planpersonid = 0;
            if (!string.IsNullOrEmpty(context.Request.Form["planpersonid"]))
                planpersonid = int.Parse(context.Request.Form["planpersonid"]);
            var currentweek = 0;
            if (!string.IsNullOrEmpty(context.Request.Form["currentweek"]))
                currentweek = int.Parse(context.Request.Form["currentweek"]);
            var currmondayofdate = context.Request.Form["currmondayofdate"];
            var resultstate = 0;
            if (!string.IsNullOrEmpty(context.Request.Form["resultstate"]))
                resultstate = int.Parse(context.Request.Form["resultstate"]);
            var currentday = 0;
            if (!string.IsNullOrEmpty(context.Request.Form["currentday"]))
                currentday = int.Parse(context.Request.Form["currentday"]);
            var fatigue = 0;
            if (!string.IsNullOrEmpty(context.Request.Form["fatigue"]))
                fatigue = int.Parse(context.Request.Form["fatigue"]);
            var time = 0;
            if (!string.IsNullOrEmpty(context.Request.Form["time"]))
                time = int.Parse(context.Request.Form["time"]);
            var avgheartrate = 0;
            if (!string.IsNullOrEmpty(context.Request.Form["avgheartrate"]))
                avgheartrate = int.Parse(context.Request.Form["avgheartrate"]);
            decimal km = 0.0m;
            if (!string.IsNullOrEmpty(context.Request.Form["km"]))
                km = decimal.Parse(context.Request.Form["km"].ToString());

            UserInfoModel CurrentUser = context.Session["CurrentUser"] as UserInfoModel;
            var PlanPersonModel = new DB5_BLL.tblPlan_Person().GetModel(planpersonid);

            if (DateTime.Now < DateTime.Parse(currmondayofdate))
            {
                resmark = "-1";//本周计划未开始，不允许填写本周训练计划的反馈信息
            }
            else if (DateTime.Now < DateTime.Parse(currmondayofdate).AddDays(currentday - 1))
            {
                resmark = "-2";//这一天的计划未开始
                resfeekbackInfo = DateTime.Parse(currmondayofdate).AddDays(currentday - 1).ToShortDateString();
            }
            else if (CurrentUser == null)
            {
                resmark = "0";//未登录状态;
            }
            else
            {
                try
                {
                    var Plan_BLL = new DB5_BLL.tblPlan();
                    var PlanPerson_BLL = new DB5_BLL.tblPlan_Person();
                    var Feedback_BLL = new DB5_BLL.tblPlan_Feedback();
                    var feedback = new DB5_Model.tblPlan_Feedback();
                    feedback.idUser = CurrentUser.uId;
                    feedback.iPpid = planpersonid;
                    feedback.iWeek = currentweek;
                    feedback.iDay = currentday;
                    feedback.dTime = time;
                    feedback.iAvghr = avgheartrate;
                    feedback.iResult = resultstate;
                    feedback.iFatigue = fatigue;
                    feedback.dCreate = DateTime.Parse(currmondayofdate).AddDays(currentday - 1);//DateTime.Now
                    feedback.iDistance = km;

                    int mark = new DB5_BLL.tblPlan_Feedback().Add(feedback);
                    if (mark > 0)
                    {
                        //置全部反馈状态--只在自然周五、六、日时才会执行
                        int NowDayOfWeek = (int)DateTime.Now.DayOfWeek;
                        if (NowDayOfWeek == 0 || NowDayOfWeek == 5 || NowDayOfWeek == 6)
                        {
                            if (new DB5_BLL.tblPlan_Feedback().GetFeedbackRecords(PlanPersonModel.id, currentweek, DateTime.Parse(currmondayofdate)) == PlanPersonModel.iTimes)
                            {
                                new DB5_BLL.tblPlan_Person().UpdateWeekFinishiStateById(PlanPersonModel.id);
                            }
                        }
                        if (resultstate > 0)//当天完成
                        {
                            if (fatigue > 0)//当天疲劳
                            {
                                //检查上次训练是否疲劳
                                string cPanCodeForPlan = PlanPerson_BLL.GetcPanCodeByPLanPerId(planpersonid);
                                string strFilter = string.Format(" and cPanCode='{2}' and iweek={1} and iType<>3 and iDay<{0} ", currentday, currentweek, cPanCodeForPlan);
                                var lastDayOfCurrentWeek = Plan_BLL.GetMaxDayinWeek(strFilter);
                                strFilter = string.Format(" and iPpid={3} and iWeek={1} and iDay={0} and dCreate>'{2}' ", currentday, currentweek, currmondayofdate, planpersonid);
                                var lastFatigue = Feedback_BLL.GetFatigueByFilter(strFilter);
                                if (lastDayOfCurrentWeek > 0)//上次也疲劳
                                {
                                    if (currentweek == 1)
                                    {
                                        PlanPerson_BLL.UpdateCurrWeekState(planpersonid, 2);//2:疲劳&第一周
                                    }
                                    else
                                    {
                                        PlanPerson_BLL.UpdateCurrWeekState(planpersonid, 3);//3:疲劳&非第一周
                                    }
                                }
                                else//上次不疲劳
                                {
                                    PlanPerson_BLL.UpdateCurrWeekState(planpersonid, 1);
                                }

                            }
                            else//当天不疲劳
                            {
                                PlanPerson_BLL.UpdateCurrWeekState(planpersonid, 1);
                            }
                        }
                        else//当天未完成
                        {
                            if (currentweek == 1)
                                PlanPerson_BLL.UpdateCurrWeekState(planpersonid, 1);
                            else
                            {
                                //检查上周是否是未完成状态
                                int weekrate = PlanPerson_BLL.GetWeekRateById(planpersonid);
                                int countIncompleteForlastweek = Feedback_BLL.GetCountOfIncompleteForLastWeek(planpersonid, currmondayofdate);
                                if (countIncompleteForlastweek == weekrate)//上周未完成
                                {
                                    PlanPerson_BLL.UpdateCurrWeekState(planpersonid, 4);//未完成&上周全未完成
                                }
                                else
                                    PlanPerson_BLL.UpdateCurrWeekState(planpersonid, 1);
                            }
                        }
                        resmark = "1";//成功
                        string resultstateinfo = string.Empty;
                        switch (resultstate)
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
                        switch (fatigue)
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
                        if (type == "index")
                        {
                            if (resultstate == 0)
                                resfeekbackInfo = "<i>未完成</i>";
                            else
                                resfeekbackInfo = string.Format("<i>{0} </i> <i>状态：{1} </i> <i>时间：{2} 分钟 </i> <i>平均心率：{3} 次/分钟 </i> <i>距离：{4} 公里</i>", resultstateinfo, fatigueinfo, time, avgheartrate, km);
                        }
                        else
                        {
                            if (resultstate == 0)
                                resfeekbackInfo = "未完成";
                            else
                                resfeekbackInfo = string.Format("{0} | 状态：{1} | 时间：{2} 分钟 | 平均心率：{3} 次/分钟 | 距离：{4} 公里", resultstateinfo, fatigueinfo, time, avgheartrate, km);
                        }
                        //处理补填上周的个人训练计划(只在周一执行)
                        int RecordsOfCurWeek = new DB5_BLL.tblPlan_Feedback().GetFeedbackRecords(PlanPersonModel.id, currentweek, DateTime.Parse(currmondayofdate));
                        if ((PlanPersonModel.weekfinishstate == 0 || PlanPersonModel.weekfinishstate == null) && (int)DateTime.Now.DayOfWeek == 1 && RecordsOfCurWeek == PlanPersonModel.iTimes)
                        {
                            int returnvalue = new DB5_BLL.tblPlan_Person().PushonPersonalPlanById(PlanPersonModel.id);
                            if (returnvalue > 0)
                            {
                                resmark = returnvalue.ToString();//2：训练计划被降档；3：本周联系两次疲劳，下周执行上一周的计划；4：连续两周没有完成，训练计划重新开始；9：训练计划完成
                            }
                        }
                    }
                    else
                    {
                        resmark = "-4";//失败
                    }
                }
                catch (Exception ex)
                {
                    throw;
                }
            }
        }
        catch (Exception ex)
        {
            resmark = "-3";
        }
        finally
        {
            ResponseEnd(resmark, resfeekbackInfo);
        }
        //string returnvalue = string.Format("[{0},\"{1}\"]", resmark, resfeekbackInfo);
        //context.Response.Write(returnvalue);
    }
    public void ResponseEnd(string first, string feekbackInfo)
    {
        string returnvalue = string.Format("[{0},\"{1}\"]", first, feekbackInfo);
        HttpContext.Current.Response.Write(returnvalue);
        HttpContext.Current.Response.End();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}