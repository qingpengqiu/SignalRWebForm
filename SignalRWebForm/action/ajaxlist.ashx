<%@ WebHandler Language="C#" Class="ajaxlist" %>

using System;
using System.Web;
using System.Data;
using System.Text;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
public class ajaxlist : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        if (context.Request["op"] != null)
        {
            string command = context.Request["op"].ToString();
            System.Reflection.MethodInfo method = this.GetType().GetMethod(command);
            if (method != null)
            {
                method.Invoke(this, new object[] { context });
            }
        }
    }
    /// <summary>
    /// 获取列表页列表
    /// </summary>
    /// <param name="context"></param>
    public void cnlist(HttpContext context)
    {
        string result = string.Empty;
        int id = TypeChangeDefault.NullToInt(context.Request["code"], 1000);//当前页数

        DBM2.tblClass model = new DB2.tblClass().GetModel(id);
        DB2.tblPush bll = new DB2.tblPush();
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);//当前页数
        int Pagesize = 20;//显示条数
        DataTable dt = bll.GetListByPage("idClass=" + id + " and dPush <=GETDATE()", "dPush desc", pageIndex, Pagesize).Tables[0];

        DB2.tblADFlow flow = new DB2.tblADFlow();
        DataTable dtflow = flow.GetList("GETDATE() between dBegintime and dEndtime and idChannel =" + id + " and iPage=" + pageIndex).Tables[0];
        StringBuilder sb = new StringBuilder();
        if (dt != null)
            {
                int count = dt.Rows.Count;
                if (count == 0)
                {
                    result = "";
                    context.Response.Write(result);
                    return;
                }
                for (int i = 0; i < count; i++)
                {
                    if (dtflow != null)
                    {
                        DataRow[] dr = dtflow.Select("iIndex=" + i);
                        if (dr.Length > 0)
                        {
                            sb.Append(dr[0]["cHtml"].ToString());
                            if ("2" == dr[0]["iShow"].ToString())
                            {
                                sb.Append("<div class=\"V3Consulth V3Consulthm\"></div>");
                            }
                        }
                        else
                        {
                            sb.Append("<div class=\"V3Consulth\"></div>");
                        }
                    }
                    sb.Append("<div class=\"V3Consult\">");
                    //sb.Append("<a class=\"V3TopTip\" target=\"_blank\" href=\"/Channels/list.aspx?id=" + dt.Rows[i]["idClass"].ToString() + "\">" + dt.Rows[i]["cClassName"].ToString() + "</a>");
                    sb.Append("<a target=\"_blank\" href=\"" + dt.Rows[i]["cLinkUrl"].ToString() + "\">");
                    sb.Append("<img src=\"" + dt.Rows[i]["cImageUrl"].ToString() + "\">");
                    sb.Append("<h3>" + dt.Rows[i]["cTitle"].ToString() + "</h3>");
                    sb.Append("</a>");
                    if (dt.Rows[i]["iType"].ToString() == "1")//文章
                    {
                        sb.Append("<em>by: <a target=\"_blank\" class=\"listusername\" href=\"/user/" + dt.Rows[i]["idUser"].ToString() + ".aspx\">" + dt.Rows[i]["cNickName"].ToString() + "</a></em>" + DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)) + "");
                        sb.Append("<p>" + dt.Rows[i]["cBio"].ToString() + "</p>");
                    }
                    else if (dt.Rows[i]["iType"].ToString() == "2")//赛事报名
                    {
                        sb.Append(DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)));
                        sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString());
                        if ("1" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/projects.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=2\">立即报名</a>");
                        }
                        else if ("2" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/result.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=6\">成绩查询</a>");
                        }
                        else if ("3" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/gallery.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=11\">查看相册</a>");
                        }
                        else if ("4" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/hotel.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=4\">查看酒店</a>");
                        }
                        else if ("5" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/equipment.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=8\">查看装备</a>");
                        }
                        sb.Append("</p>");

                        //sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString() + "<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/projects.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=2\">立即报名</a></p>");
                    }
                    else if (dt.Rows[i]["iType"].ToString() == "3")//约跑
                    {
                        sb.Append(DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)));
                        sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString() + "<a class=\"V3ConsultButtom\" target=\"_blank\" href=\"" + dt.Rows[i]["cLinkUrl"].ToString() + "\">立即报名</a></p>");
                    }
                    else if (dt.Rows[i]["iType"].ToString() == "4")//拼团
                    {
                        sb.Append(DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)));
                        sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString() + "<a class=\"V3ConsultButtom\" target=\"_blank\" href=\"\">立即拼团</a></p>");
                    }
                    sb.Append("</div>");
                    //if (i != dt.Rows.Count-1)
                    //    sb.Append("<div class=\"V3Consulth\"></div>");
                }
        }

        context.Response.Write(sb.ToString());
    }
    /// <summary>
    /// 获取频道页列表
    /// </summary>
    /// <param name="context"></param>
    public void list(HttpContext context)
    {
        string result = string.Empty;
        int idcode = TypeChangeDefault.NullToInt(context.Request["code"], 30000);//默认为首页
        DBM2.tblChannel model = new DB2.tblChannel().GetModel(idcode);
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);//当前页数
        int Pagesize = model.iMaxPageSize ?? 20;//显示条数        
        string right = "0";
        if (model.cRight.Trim().Length > 0)
        {
            right = model.cRight;
        }
        StringBuilder sb = new StringBuilder();
        DB2.tblPush bll = new DB2.tblPush();
        DataTable dt = new DataTable();
        if (idcode == 30000)
        {
            dt = bll.GetListByPage("dPush <=GETDATE()", "dPush desc", pageIndex, Pagesize).Tables[0];
        }
        else
        {
            dt = bll.GetListByPage("idClass in(" + right + ") and dPush <=GETDATE()", "dPush desc", pageIndex, Pagesize).Tables[0];
        }
        DB2.tblADFlow flow = new DB2.tblADFlow();
        DataTable dtflow = flow.GetList("GETDATE() between dBegintime and dEndtime and idChannel =" + idcode + " and iPage=" + pageIndex).Tables[0];
        if (dt != null)
        {
            int count = dt.Rows.Count;
            if (count == 0)
            {
                result = "";
                context.Response.Write(result);
                return;
            }
            for (int i = 0; i < count; i++)
            {
                if (dtflow != null)
                {
                    DataRow[] dr = dtflow.Select("iIndex=" + i);
                    if (dr.Length > 0)
                    {
                        sb.Append(dr[0]["cHtml"].ToString());
                        if ("2" == dr[0]["iShow"].ToString())
                        {
                            sb.Append("<div class=\"V3Consulth V3Consulthm\"></div>");
                        }
                    }
                    else
                    {
                        sb.Append("<div class=\"V3Consulth\"></div>");
                    }
                }
                sb.Append("<div class=\"V3Consult\">");
                sb.Append("<a class=\"V3TopTip\" target=\"_blank\" href=\"/Channels/list.aspx?id=" + dt.Rows[i]["idClass"].ToString() + "\">" + dt.Rows[i]["cClassName"].ToString() + "</a>");
                sb.Append("<a target=\"_blank\" href=\"" + dt.Rows[i]["cLinkUrl"].ToString() + "\">");
                sb.Append("<img src=\"" + dt.Rows[i]["cImageUrl"].ToString() + "\">");
                sb.Append("<h3>" + dt.Rows[i]["cTitle"].ToString() + "</h3>");
                sb.Append("</a>");
                if (dt.Rows[i]["iType"].ToString() == "1")//文章
                {
                    sb.Append("<em>by: <a target=\"_blank\" class=\"listusername\" href=\"/user/" + dt.Rows[i]["idUser"].ToString() + ".aspx\">" + dt.Rows[i]["cNickName"].ToString() + "</a></em>" + DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)) + "");
                    sb.Append("<p>" + dt.Rows[i]["cBio"].ToString() + "</p>");
                }
                else if (dt.Rows[i]["iType"].ToString() == "2")//赛事报名
                {
                    sb.Append(DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)));
                    sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString());
                    if ("1" == dt.Rows[i]["cMark"].ToString())
                    {
                        sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/projects.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=2\">立即报名</a>");
                    }
                    else if ("2" == dt.Rows[i]["cMark"].ToString())
                    {
                        sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/result.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=6\">成绩查询</a>");
                    }
                    else if ("3" == dt.Rows[i]["cMark"].ToString())
                    {
                        sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/gallery.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=11\">查看相册</a>");
                    }
                    else if ("4" == dt.Rows[i]["cMark"].ToString())
                    {
                        sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/hotel.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=4\">查看酒店</a>");
                    }
                    else if ("5" == dt.Rows[i]["cMark"].ToString())
                    {
                        sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/equipment.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=8\">查看装备</a>");
                    }
                    sb.Append("</p>");
                }
                else if (dt.Rows[i]["iType"].ToString() == "3")//约跑
                {
                    sb.Append(DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)));
                    sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString() + "<a class=\"V3ConsultButtom\" target=\"_blank\" href=\"" + dt.Rows[i]["cLinkUrl"].ToString() + "\">立即报名</a></p>");
                }
                else if (dt.Rows[i]["iType"].ToString() == "4")//拼团
                {
                    sb.Append(DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)));
                    sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString() + "<a class=\"V3ConsultButtom\" target=\"_blank\" href=\"\">立即拼团</a></p>");
                }
                sb.Append("</div>");
            }
        }

        context.Response.Write(sb.ToString());
    }
    public string DateStringFromNow(DateTime dt)
    {
        TimeSpan span = DateTime.Now - dt;
        if (span.TotalDays > 60)
        {
            return Convert.ToDateTime(dt).ToString("yyyy-MM-dd");
        }
        else
        {
            if (span.TotalDays > 30)
            {
                return
                "1个月前";
            }
            else
            {
                if (span.TotalDays > 14)
                {
                    return
                    "2周前";
                }
                else
                {
                    if (span.TotalDays > 7)
                    {
                        return
                        "1周前";
                    }
                    else
                    {
                        if (span.TotalDays > 1)
                        {
                            return
                            string.Format("{0}天前", (int)Math.Floor(span.TotalDays));
                        }
                        else
                        {
                            if (span.TotalHours > 1)
                            {
                                return
                                string.Format("{0}小时前", (int)Math.Floor(span.TotalHours));
                            }
                            else
                            {
                                if (span.TotalMinutes > 1)
                                {
                                    return
                                    string.Format("{0}分钟前", (int)Math.Floor(span.TotalMinutes));
                                }
                                else
                                {
                                    if (span.TotalSeconds >= 1)
                                    {
                                        return
                                        string.Format("{0}秒前", (int)Math.Floor(span.TotalSeconds));
                                    }
                                    else
                                    {
                                        return
                                        "1秒前";
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}