<%@ WebHandler Language="C#" Class="GetBlogList" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Text;
using Erun360.BLL;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DBM1 = Erun360.Model.DB1;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using DB4 = Erun360.BLL.DB4;

public class GetBlogList : IHttpHandler, IReadOnlySessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
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
    /// 取消关注博客
    /// </summary>
    /// <param name="context"></param>
    public void qxgz(HttpContext context)
    {
        int idBlog = TypeChangeDefault.NullToInt(context.Request["b"], 0);//当前用户id

        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            context.Response.Write(new FocusLand().AttentionState(model.uId, idBlog, 0, 2));
        }
    }
    /// <summary>
    /// 添加博客
    /// </summary>
    /// <param name="context"></param>
    public void Ding(HttpContext context)
    {
        BlogInfo uBlog = new BlogInfo();
        string ding = string.Empty;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (context.Request["bId"] != null)
                ding = uBlog.cDing(int.Parse(context.Request["bId"].ToString()), model.uId);
        }
        else
        {
            ding = "<em>您未注册</em>";
        }
        context.Response.Write(ding);
        
    }
    /// <summary>
    /// 收藏/关注博客
    /// </summary>
    /// <param name="context"></param>
    public void iHouse(HttpContext context)
    {
        int bId = 0;
        if (context.Request["bId"] != null)
        {
            bId = int.Parse(context.Request["bId"].ToString());
        }
        string result = string.Empty;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            result = new FocusLand().AttentionState(model.uId, bId, 1, 2);
        }
        else
        {
            result = "您未注册";
        }
        //UserInfoBll uClient = new UserInfoBll();
       
        
        context.Response.Write(result);
        
        //BlogInfo uBlog = new BlogInfo();
        //string House = string.Empty;
        //if (context.Request["bId"] != null)
        //    House = uBlog.cDing(int.Parse(context.Request["bId"].ToString()), PageBase.cId);
        //context.Response.Write(House);
    }
    
    /// <summary>
    /// 根据博客id删除博客相关信息
    /// </summary>
    /// <param name="context"></param>
    public void DeleteBlog(HttpContext context)
    {
        int bId = 0;
        if (context.Request["bId"] != null)
        {
            bId = int.Parse(context.Request["bId"].ToString());
            BlogInfo uBlog = new BlogInfo();
            if (context.Session["CurrentUser"] != null)
            {
                UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
                if (uBlog.Delete(model.uId, bId))
                {
                    //删除俱乐部里对应的博文
                    new DB4.tblRACE_LINKS().DeleteBlog(bId);
                    //修改博客缓存数量和积分数
                    //UserInfoBll uClient = new UserInfoBll();
                    //UserInfoModel model = uClient.Find(PageBase.cId);
                    //if (model != null)
                    //{
                    //    model.iBlogCount += -1;
                    //    model.iScore = model.iScore * (-1);
                    //}
                    //博客数量-1
                    DB1.tblMEMBER_SUMMARY uMember_Summary = new DB1.tblMEMBER_SUMMARY();
                    DBM1.tblMEMBER_SUMMARY mBlog = new DBM1.tblMEMBER_SUMMARY();
                    mBlog = uMember_Summary.GetModel(model.uId);
                    mBlog.iBlogCount = mBlog.iBlogCount - 1;//博客数量-1
                    mBlog.idUser = model.uId;
                    uMember_Summary.Update(mBlog);
                    new DB1.tblIntegral().InsertScore(model.uId, 200810021, 1, 0);
                    context.Response.Write("ok,Blog.aspx");
                }
            }
        }
        else
        {
            context.Response.Write("出错了，稍后在试吧！！");
        }
    }
    /// <summary>
    /// 根据博客id删除装备
    /// </summary>
    /// <param name="context"></param>
    public void DeleteEquip(HttpContext context)
    {
        int bId = 0;
        if (context.Request["bId"] != null)
        {
            bId = int.Parse(context.Request["bId"].ToString());
            BlogInfo uBlog = new BlogInfo();
            if (context.Session["CurrentUser"] != null)
            {
                UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
                if (uBlog.Delete(model.uId, bId))
                {
                    DB5.tblPRODUCTS uProduct = new DB5.tblPRODUCTS();
                    uProduct.Delete(bId);

                    //修改博客缓存数量和积分数
                    //UserInfoBll uClient = new UserInfoBll();
                    //UserInfoModel model = uClient.Find(PageBase.cId);
                    ////if (model != null)
                    ////{
                    ////    model.iBlogCount += -1;
                    ////    model.iScore = model.iScore * (-1);
                    ////}
                    new DB1.tblIntegral().InsertScore(model.uId, 200810026, 1, 0);
                    context.Response.Write("ok,Equip.aspx");
                }
            }
            else
            {
                context.Response.Write("出错了，稍后在试吧！！");
            }
        }
    }
    /// <summary>
    /// 根据博客id删除赛事
    /// </summary>
    /// <param name="context"></param>
    public void delCompetition(HttpContext context)
    {
        int bId = 0;
        if (context.Request["bId"] != null)
        {
            bId = int.Parse(context.Request["bId"].ToString());
            BlogInfo uBlog = new BlogInfo();
            if (context.Session["CurrentUser"] != null)
            {
                UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
                if (uBlog.Delete(model.uId, bId))
                {
                    DB4.tblRACE_COMPETETION uCompetetion = new DB4.tblRACE_COMPETETION();
                    uCompetetion.Delete(bId);
                    //修改博客缓存数量和积分数
                    //UserInfoBll uClient = new UserInfoBll();
                    //UserInfoModel model = uClient.Find(PageBase.cId);
                    //if (model != null)
                    //{
                    //    model.iBlogCount += -1;
                    //    model.iScore = model.iScore * (-1);
                    //}
                    new DB1.tblIntegral().InsertScore(model.uId, 200810026, 1, 0);
                    context.Response.Write("ok,Competition.aspx");
                }
            }
        }
        else
        {
            context.Response.Write("出错了，稍后在试吧！！");
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}