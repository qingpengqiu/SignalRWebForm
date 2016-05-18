<%@ WebHandler Language="C#" Class="PlanInfo" %>

using System;
using System.Web;
using System.Web.SessionState;
using Erun360.Model;
using Erun360.Common;
using Erun360.DBUtility;
using DB5_Model = Erun360.Model.DB5;
using DB5_DAL = Erun360.DAL.DB5;
using DB5_BLL = Erun360.BLL.DB5;

public class PlanInfo : IHttpHandler, IReadOnlySessionState {
    
    public void ProcessRequest (HttpContext context) {
        string[] FrequencyDistance = new string[] { "3_5", "3_10", "3_21", "4_42", "5_42" };
        int freqdist = int.Parse(context.Request.Form["freqdist"]);
        int frequency = 0;
        int distance = 0;
        frequency = int.Parse(FrequencyDistance[freqdist].Split('_')[0]);
        distance = int.Parse(FrequencyDistance[freqdist].Split('_')[1]);
        int level = int.Parse(context.Request.Form["level"]);
        int period = int.Parse(context.Request.Form["period"]);

        string birthday = context.Request.Form["birthday"];
        decimal height = int.Parse(context.Request.Form["height"]);
        decimal weight = int.Parse(context.Request.Form["weight"]);
        int morningpulse = int.Parse(context.Request.Form["morningpulse"]);
        if (string.IsNullOrEmpty(context.Request.Form["birthday"]) || string.IsNullOrEmpty(context.Request.Form["height"]) || string.IsNullOrEmpty(context.Request.Form["weight"]) || string.IsNullOrEmpty(context.Request.Form["morningpulse"]))
        {
            context.Response.Write("-1");//请输入完整的个人信息;
            context.Response.End();
        }
        string RangeGR = "";
        string RangeGE = "";
        string RangeOR = "";
        string RangeRO = "";

        decimal heightform = height / 100;
        decimal BMI = weight / (heightform * heightform);
        if (BMI>25&&level==102)
        {
            level = 101;
        }
        int Age = CalculateAgeCorrect(DateTime.Parse(birthday), DateTime.Now);
        int ratevalue_first = (int)((220 - Age - morningpulse) * 0.6 + morningpulse);
        int ratevalue_second = (int)((220 - Age - morningpulse) * 0.7 + morningpulse);
        int ratevalue_third = (int)((220 - Age - morningpulse) * 0.8 + morningpulse);
        int ratevalue_fourth = (int)((220 - Age - morningpulse) * 0.9 + morningpulse);
        int ratevalue_fifth = (int)((220 - Age - morningpulse) * 0.95 + morningpulse);
        RangeGR = ratevalue_first + "~" + ratevalue_second;
        RangeGE = ratevalue_second + "~" + ratevalue_third;
        RangeOR = ratevalue_third + "~" + ratevalue_fourth;
        RangeRO = ratevalue_fourth + "~" + ratevalue_fifth;
        
        UserInfoModel CurrentUser = context.Session["CurrentUser"] as UserInfoModel;
        if (CurrentUser==null)
        {
            context.Response.Write("0");//没有登录
        }
        else
        {
            try
            {
                var planperson = new DB5_Model.tblPlan_Person();
                planperson.idUser = CurrentUser.uId;
                planperson.dStart = CalculateFirstDateOfNexWeek(DateTime.Parse(DateTime.Now.ToShortDateString()));
                planperson.iLevel = level;
                planperson.iWeek = period;
                planperson.iTimes = frequency;
                planperson.idistance = distance;
                planperson.iHeight = height;
                planperson.iWeight = weight;
                planperson.dbirthday = DateTime.Parse(birthday);
                planperson.iMhr = morningpulse;
                planperson.RangeGR = RangeGR;
                planperson.RangeGE = RangeGE;
                planperson.RangeOR = RangeOR;
                planperson.RangeRO = RangeRO;
                planperson.dCreate = DateTime.Now;
                planperson.currweek = 1;
                planperson.currmondayofdate = CalculateFirstDateOfNexWeek(DateTime.Parse(DateTime.Now.ToShortDateString()));
                planperson.currweekstate = 0;

                int mark = new DB5_BLL.tblPlan_Person().Add(planperson);
                if (mark>=0)
                {
                    context.Response.Write("1");//插入数据成功！
                }
                else
                {
                    context.Response.Write("2");//插入数据失败！
                }
            }
            catch (Exception ex)
            {
                context.Response.Write("2");//插入数据失败！
            }
        }
    }
    public int CalculateAgeCorrect(DateTime birthDate, DateTime now)
    {
        int age = now.Year - birthDate.Year;
        if (now.Month < birthDate.Month || (now.Month == birthDate.Month && now.Day < birthDate.Day)) 
            age--;
        return age;
    }
    /// 计算下周起始日期（礼拜一的日期,如果当前是礼拜一，则直接返回当前礼拜一的日期，否则返回下周礼拜一的日期）
    /// </summary>
    /// <param name="someDate">该周中任意一天</param>
    /// <returns>返回下礼拜一日期，后面的具体时、分、秒和传入值相等</returns>
    public static DateTime CalculateFirstDateOfNexWeek(DateTime someDate)
    {
        if (someDate.DayOfWeek - DayOfWeek.Monday == 0)
        {
            return someDate;
        }
        else
        {
            int i = someDate.DayOfWeek - DayOfWeek.Monday;
            if (i == -1) i = 6;// i值 > = 0 ，因为枚举原因，Sunday排在最前，此时Sunday-Monday=-1，必须+7=6。
            TimeSpan ts = new TimeSpan(i, 0, 0, 0);
            return someDate.Subtract(ts).AddDays(7);
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}