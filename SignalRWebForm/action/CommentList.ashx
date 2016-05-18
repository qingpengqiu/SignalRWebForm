<%@ WebHandler Language="C#" Class="CommentList" %>

using System;
using System.Web;
using Erun360.BLL;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DBM3 = Erun360.Model.DB3;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using System.Data;
using System.Text;
using Erun360.Model;
using System.Web.SessionState;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
public class CommentList : IHttpHandler, IReadOnlySessionState
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
    /// 新收到的评论
    /// </summary>
    /// <param name="context"></param>
    public void discuss(HttpContext context)
    {

        //具体的页面数
        int pageIndex;
        int.TryParse(context.Request["pageIndex"], out pageIndex);
        //页面显示条数
        int Pagesize = Convert.ToInt32(context.Request["pageSize"]);

        string idGroup = context.Request["group"];
        if (pageIndex == 0)
        {
            pageIndex = 1;
        }
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;

            string StrWhere = " and uId =" + model.uId;
            DataTable dt = new DB3.tblMessage().GetDiscussList(StrWhere).Tables[0];
            StringBuilder sb = new StringBuilder();
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    int idBlog = TypeChangeDefault.NullToInt(dt.Rows[i]["bId"].ToString(), 0);
                    if (0 != idBlog)
                    {
                        sb.AppendLine("<li>");
                        DBM2.tblBLOG mBlog = new DB2.tblBLOG().GetModelByCache(idBlog);
                        if (dt.Rows[i]["itype"].ToString() == "40")//新版赛事咨询，
                        {
                            DBM6.tblRace_Competition modelrace = new DB6.tblRace_Competition().GetModel(idBlog);

                            sb.AppendLine("<a href=\"/Competetion/Forum.aspx?sid=" + idBlog + "&nav=12&t=1#text\" class=\"comments-title\"  target=\"_blank\">有人在赛事《" + modelrace.cTitle + "》中咨询，快去查看~</a>");
                            string dCreate = new DB3.tblMessage().GetDate(idBlog.ToString(), model.uId.ToString(), dt.Rows[i]["itype"].ToString());
                            sb.AppendLine("<span>" + Convert.ToDateTime(dCreate).ToString("yyyy-MM-dd HH:mm") + "<a href=\"/Competetion/Forum.aspx?sid=" + idBlog + "&nav=12&t=1#text\" class=\"reply\"  target=\"_blank\">查看咨询</a></span>");
                            int count = Convert.ToInt32(new DB3.tblMessage().GetRecordCount(" uId=" + model.uId + " and bId=" + idBlog + " and itype=40"));
                            if (count > 0)
                            {
                                sb.Append("<div class=\"pnewtip\">" + count + "</div>");
                            }
                        }
                        else if (dt.Rows[i]["itype"].ToString() == "41")//新版赛事，讨论组回复
                        {
                            DBM6.tblRace_Competition modelrace = new DB6.tblRace_Competition().GetModel(idBlog);

                            sb.AppendLine("<a href=\"/Competetion/Forum.aspx?sid=" + idBlog + "&nav=12&t=2#text\" class=\"comments-title\"  target=\"_blank\">有人在赛事《" + modelrace.cTitle + "》中回复了您的评论，快去查看~</a>");
                            string dCreate = new DB3.tblMessage().GetDate(idBlog.ToString(), model.uId.ToString(), dt.Rows[i]["itype"].ToString());
                            sb.AppendLine("<span>" + Convert.ToDateTime(dCreate).ToString("yyyy-MM-dd HH:mm") + "<a href=\"/Competetion/Forum.aspx?sid=" + idBlog + "&nav=12&t=2#text\" class=\"reply\"  target=\"_blank\">查看评论</a></span>");
                            int count = Convert.ToInt32(new DB3.tblMessage().GetRecordCount(" uId=" + model.uId + " and bId=" + idBlog + " and itype=41"));
                            if (count > 0)
                            {
                                sb.Append("<div class=\"pnewtip\">" + count + "</div>");
                            }
                        }
                        else if (dt.Rows[i]["itype"].ToString() == "38")
                        {
                            DBM5.tblShoes mShoe = new DB5.tblShoes().GetModel(idBlog);

                            sb.AppendLine("<a href=\"" + UrlHelper.ShoeUrl(mShoe.id) + "#text\" class=\"comments-title\"  target=\"_blank\">有人在博文《" + mShoe.cName + "》中回复了您的评论，快去查看~</a>");
                            string dCreate = new DB3.tblMessage().GetDate(mShoe.id.ToString(), model.uId.ToString(), dt.Rows[i]["itype"].ToString());
                            sb.AppendLine("<span>" + Convert.ToDateTime(dCreate).ToString("yyyy-MM-dd HH:mm") + "<a href=\"" + UrlHelper.ShoeUrl(mShoe.id) + "#text\" class=\"reply\"  target=\"_blank\">查看评论</a></span>");
                            int count = Convert.ToInt32(new DB3.tblMessage().GetRecordCount(" uId=" + model.uId + " and bId=" + dt.Rows[i]["bId"].ToString() + " and itype=38"));
                            if (count > 0)
                            {
                                sb.Append("<div class=\"pnewtip\">" + count + "</div>");
                            }
                        }
                        else if (dt.Rows[i]["itype"].ToString() == "37")
                        {
                            sb.AppendLine("<a href=\"" + UrlHelper.BlogUrl(mBlog.id) + "#text\" class=\"comments-title\"  target=\"_blank\">有人在博文《" + mBlog.cTitle + "》中回复了您的评论，快去查看~</a>");
                            string dCreate = new DB3.tblMessage().GetDate(mBlog.id.ToString(), model.uId.ToString(), dt.Rows[i]["itype"].ToString());
                            sb.AppendLine("<span>" + Convert.ToDateTime(dCreate).ToString("yyyy-MM-dd HH:mm") + "<a href=\"" + UrlHelper.BlogUrl(mBlog.id) + "#text\" class=\"reply\"  target=\"_blank\">查看评论</a></span>");
                            int count = Convert.ToInt32(new DB3.tblMessage().GetRecordCount(" uId=" + model.uId + " and bId=" + dt.Rows[i]["bId"].ToString() + " and itype=37"));
                            if (count > 0)
                            {
                                sb.Append("<div class=\"pnewtip\">" + count + "</div>");
                            }
                        }
                        else
                        {
                            sb.AppendLine("<a href=\"" + UrlHelper.BlogUrl(mBlog.id) + "#text\" class=\"comments-title\"  target=\"_blank\">有人评论了您的博文《" + mBlog.cTitle + "》，快去查看~</a>");
                            string dCreate = new DB3.tblMessage().GetDate(mBlog.id.ToString(), model.uId.ToString(), dt.Rows[i]["itype"].ToString());
                            sb.AppendLine("<span>" + Convert.ToDateTime(dCreate).ToString("yyyy-MM-dd HH:mm") + "<a href=\"" + UrlHelper.BlogUrl(mBlog.id) + "#text\" class=\"reply\"  target=\"_blank\">查看评论</a></span>");
                            int count = Convert.ToInt32(new DB3.tblMessage().GetRecordCount(" uId=" + model.uId + " and bId=" + dt.Rows[i]["bId"].ToString() + " and itype<>37"));
                            if (count > 0)
                            {
                                sb.Append("<div class=\"pnewtip\">" + count + "</div>");
                            }
                        }


                        sb.AppendLine(" </li>");
                    }
                }
            }
            else
            {
                sb.AppendLine("<li>暂无新评论</li>");
            }
            context.Response.Write(sb.ToString());
        }
        else
        {
            context.Response.Write("您未登录!");
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