<%@ WebHandler Language="C#" Class="GetHomeInfo" %>

using System;
using System.Web;
using System.Web.SessionState;
using Erun360.BLL;
using System.Collections.Generic;

using System.Data;
using System.Text;
using DBM1 = Erun360.Model.DB1;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DB3 = Erun360.BLL.DB3;
using Erun360.Model;
public class GetHomeInfo : IHttpHandler, IReadOnlySessionState
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        if (context.Request["command"] != null)
        {
            string command = context.Request["command"].ToString();
            System.Reflection.MethodInfo method = this.GetType().GetMethod(command);
            if (method != null)
            {
                method.Invoke(this, new object[] { context });
            }
        }
    }
    /// <summary>
    /// 获取个人首页好友博客内容
    /// </summary>
    /// <param name="context"></param>
    public void Bolglist(HttpContext context)
    {
        //具体的页面数
        int pageIndex;
        int.TryParse(context.Request["pageIndex"], out pageIndex);
        //页面显示条数
        int Pagesize = Convert.ToInt32(context.Request["pageSize"]);
        if (pageIndex == 0)
        {
            pageIndex = 1;
        }
        HomeInfo blog = new HomeInfo();
        //string sBlog = blog.GetHomeBolgList(PageBase.cId, Pagesize, pageIndex);
        //context.Response.Write(sBlog);
        DB3.tblATTENTION uAttention = new DB3.tblATTENTION();
        DB2.tblBLOG uBolg = new DB2.tblBLOG();
        StringBuilder sb = new StringBuilder();
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;

            //关注用户
            DataTable dt = uBolg.GetPageListByIdUser(uAttention.GetAttentionIdList(model.uId, 1, 1), Pagesize, pageIndex).Tables[0];
           
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    sb.Append("<li><a href=\"/user/" + dt.Rows[i]["idUser"].ToString() + ".aspx\" class=\"user-head\">");
                    sb.Append(blog.GetHeadImgByidUser(model.uId, int.Parse(dt.Rows[i]["idUser"].ToString())));
                    sb.Append("<a href=\"/user/" + dt.Rows[i]["idUser"].ToString() + ".aspx\">" + dt.Rows[i]["cLoginname"].ToString() + "</a> 发布博文：<a href=\" /infocenter/Blog.aspx?uId=" + dt.Rows[i]["id"].ToString() + "\">" + dt.Rows[i]["cTitle"].ToString() + "</a>");
                    sb.Append("<p>");
                    sb.Append("" + XString.ContentTrunc(dt.Rows[i]["cContent"].ToString(), 400) + "");
                    //图片缩略图
                    sb.Append(blog.GetImgByidBolg(int.Parse(dt.Rows[i]["id"].ToString())));
                    sb.Append("</p>");
                    sb.Append("<div class=\"relevance\">");
                    sb.Append("" + Convert.ToDateTime(dt.Rows[i]["dCreate"]).ToString("yyyy-MM-dd HH:mm") + "");
                    sb.Append(blog.GetSummaryByidBlog(int.Parse(dt.Rows[i]["id"].ToString())));
                    sb.Append("</div>");
                    sb.Append("</li>");
                }
            }
        }
        context.Response.Write(sb.ToString());
        /*
         <li><a href="/" class="user-head">
                            <img src="../Html/images/wl/2.png" alt=""></a>
                            <a href="/">马拉松Sean</a> 发布博文：<a href="/">《倾其所有》一名马拉松运动员、一位真正男人的不朽遗赠</a>
                            <p>
                                那么今天小编就告诉大家该如何正确的对待跑步，跑步的五要素只要记住了，你一定能跑出一个健康的体魄出来。以下要素是针对慢跑而言，不是竞技跑哦。如果你有仔细观察过他人跑步，你会发现，很多人都是全脚掌着地，落地时的声音也比较
				<img src="../Html/images/wl/2.png" alt="">
                            </p>
                            <div class="relevance">
                                2012-12-12  15:12:50
						<span>阅读(333) 关注(1) 顶(5) 评论(5) </span>
                            </div>
                        </li>
         **/
    }    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}