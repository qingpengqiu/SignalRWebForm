<%@ WebHandler Language="C#" Class="GetPhotoList" %>

using System;
using System.Web;
using System.Web.SessionState;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using System.Text;
using System.Data;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;

public class GetPhotoList : IHttpHandler, IReadOnlySessionState
{
    
    public void ProcessRequest (HttpContext context) {
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
    public void upimg(HttpContext context)
    {
        
        string url = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["img"]), "");
        if (url.Trim().Length > 0)
        {
            if (context.Session["CurrentUser"] != null)
            {
                UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
                DBM1.tblMEMBER mMember = new DBM1.tblMEMBER();
                DB1.tblMEMBER bll = new DB1.tblMEMBER();
                mMember.id = model.uId;
                //mMember.iChecksum = Convert.ToInt32(bll.GetList(" id=" + model.uId.ToString()).Tables[0].Rows[0]["iChecksum"]);
                mMember.cAvatar = url.Trim();
                //mMember.dBirthday = null;
                bll.Update(mMember);
                string CacheKey = "tblMEMBERModel-" + model.uId;
                Erun360.Common.DataCache.GetCache(CacheKey);
                context.Response.Write("1");
            }
            else
            {
                context.Response.Write("-1");
            }
        }
        else
        {
            context.Response.Write("0");
        }

    }
    /// <summary>
    /// 获取个人首页好友博客内容
    /// </summary>
    /// <param name="context"></param>
    public void Photolist(HttpContext context)
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
        int uId = 0;
        if (context.Request["uId"] != null)
        {
            uId = int.Parse(context.Request["uId"].ToString());
        }
        DB3.tblIMAGES uImg = new DB3.tblIMAGES();
        DataTable dt = uImg.GetListByPage("idUser =" + uId , "dCreate desc", pageIndex, Pagesize).Tables[0];

        StringBuilder sb = new StringBuilder();
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (model.uId == uId)
            {
                sb.Append("<div class=\"blog-top\">我的全部相片 <span>(1221)</span><a class=\"photo-up\" href=\"\">上传照片</a></div>");
            }
            else
            {
                sb.Append("<div class=\"blog-top\">TA的全部相片 <span>(1221)</span></div>");
            }
            sb.Append("<ul class=\"album\">");
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (model.uId == uId)
                    {
                        //sb.Append("<li class=\"group2\" href=\"" + dt.Rows[i]["cImageUrl"].ToString() + "\"><img src=\"" + dt.Rows[i]["cImageUrl"].ToString() + "\"><a href=\"\"></a></li>");
                        sb.Append("<li class=\"group2\" href=\"" + dt.Rows[i]["cImageUrl"].ToString() + "\"><img src=\"" + dt.Rows[i]["cImageUrl"].ToString() + "\"></a></li>");
                    }
                    else
                    {
                        sb.Append("<li class=\"group2\" href=\"" + dt.Rows[i]["cImageUrl"].ToString() + "\"><img src=\"" + dt.Rows[i]["cImageUrl"].ToString() + "\"></li>");
                    }
                }
            }
            sb.Append("</ul>");
        }
        context.Response.Write(sb.ToString());
        /*
        <li class="group2" href="../Html/images/wl/2.png"><img src="../Html/images/wl/2.png"><a href=""></a></li>
         **/
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}