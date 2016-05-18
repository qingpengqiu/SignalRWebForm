using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_WritePrc : System.Web.UI.Page
{
    public string PageUser = "";
    public string PageResult = "";
    public string PageList = "";
    public UserInfo u;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region 身份确认
        Member m = new Member();
        if (m.Default == null)
        {
            Response.Redirect("/Member/");
            return;
        }
        #endregion

        if (Prison.Find(m.Default.id))
        {
            Response.Redirect("/Member/Logout.aspx");
            return;
        }

        u = Users.Find(m.Default.id);
        if (u == null)
        {
            Response.Redirect("/Member/");
            return;
        }

        int page_count = 0;

        int idBlog = 0;
        string blogTitle = "";

        if (Request.Form.Count > 0)
        {
            // 来源判别
            if (!Me.HostRequired)
            {
                Response.Redirect("/Member/");
                return;
            }

            #region 添加博客信息

            BlogInfo record = new BlogInfo();
            record.idUser = u.id;
            record.cLoginName = u.cLoginName;

            int finishedFieldCount = 0;
            if (Request.Form["idPersonGroup"] != null)
            {
                try
                {
                    record.idPersonGroup = Int32.Parse(XString.PureNumber(Request.Form["idPersonGroup"].ToString()));
                }
                catch (Exception ex)
                {
                    PageResult = "数据(个人分组)格式错误[" + ex.Message + "]！请检查！";
                    //return;
                }
                finishedFieldCount++;
            }
            if (Request.Form["cTitle"] != null)
            {
                try
                {
                    record.cTitle = XString.SqlSafe(Request.Form["cTitle"].ToString());
                    blogTitle = record.cTitle;
                    if (record.cTitle.Length < 2 || record.cTitle.Length > 128)
                    {
                        PageResult = "(标题)数据长度超出允许范围！请检查！";
                        //return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "数据(标题)格式错误[" + ex.Message + "]！请检查！";
                    //return;
                }

                if (GCommon.BadContent(record.cTitle))
                {
                    PageResult = "非法标题！";
                    //return;
                }

                finishedFieldCount++;
            }
            if (Request.Form["cContent"] != null)
            {
                try
                {
                    record.cContent = XString.SqlSafe(Request.Form["cContent"].ToString());
                    if (record.cContent.Length < 16)
                    {
                        PageResult = "(内容)数据长度超出允许范围！请检查！";
                        //return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "数据(内容)格式错误[" + ex.Message + "]！请检查！";
                    //return;
                }

                if (GCommon.BadContent(record.cTitle))
                {
                    PageResult = "非法内容！";
                    //return;
                }

                finishedFieldCount++;
            }

            // 数据检查完成！添加记录！
            if (finishedFieldCount >= 0 && PageResult.Length == 0)
            {
                Blog table = new Blog();
                int recordIndex = 0;
                if (table.Insert(record, out recordIndex))
                {
                    idBlog = recordIndex;

                    #region 积分:发表博客
                    MemberHistory history = new MemberHistory();
                    history.Insert(record.idUser, 100800107, 1);
                    #endregion

                    if (Request.Form["from"] != null)
                    {
                        int from = Int32.Parse(Request.Form["from"].ToString());
                        BlogLinks blinks = new BlogLinks();
                        BlogLinksInfo binfo = new BlogLinksInfo();
                        binfo.idBlog = from;
                        binfo.idInfo = idBlog;
                        int b_result = 0;
                        blinks.Insert(binfo, out b_result);

                        TCache.Clear("CACHE_PAGE_SUBJECTS_" + from);

                        // 刷新首页及各栏目相应的列表缓存
                        BlogPublish bp = new BlogPublish();
                        List<BlogPublishInfo> bexist = bp.PageList(1, 100, "WHERE idInfo=" + from, "ORDER BY id DESC", out b_result);
                        if (b_result > 0)
                        {
                            foreach (BlogPublishInfo bu in bexist)
                            {
                                TCache.Clear("CACHE_OF_HOTS_" + bu.idPosition);
                            }
                        }
                    }

                    #region 清除相应内存数据库信息
                    Users.Blogs(record.idUser, 1);
                    TCache.Clear("CACHE_PAGE_MEMBER_" + record.idUser);
                    TCache.Clear("CACHE_PAGE_MEMBER_ME_" + record.idUser);
                    CacheHelper.Clear("CACHE_RECENT_BLOGS");
                    #endregion

                    PageResult = "博客添加成功！继续输入数据或访问其他页面！";
                }
                else
                {
                    PageResult = "系统错误：" + table._err;
                }
            }
            #endregion

            #region 附加信息

            if (Request.Form["blogStyle"] != null)
            {

                finishedFieldCount = 0;
                PageResult = "";

                #region 添加约跑信息

                if (Request.Form["blogStyle"].ToString() == "Activity")
                {
                    //PageResult += " add Activity ... ";
                    RaceActivityInfo activity = new RaceActivityInfo();

                    if (Request.Form["idRoadStyle"] != null)
                    {
                        try
                        {
                            activity.idRoadStyle = Int32.Parse(XString.PureNumber(Request.Form["idRoadStyle"].ToString()));
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(活动类别)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["idCity"] != null)
                    {
                        try
                        {
                            activity.idCity = Int32.Parse(XString.PureNumber(Request.Form["idCity"].ToString()));
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(城市ID)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["cCityname"] != null)
                    {
                        try
                        {
                            activity.cCityname = XString.SqlSafe(Request.Form["cCityname"].ToString());
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(城市)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["dOpen"] != null && Request.Form["dOpenHours"] != null && Request.Form["dOpenMinutes"] != null)
                    {
                        try
                        {
                            activity.dOpen = DateTime.Parse(Request.Form["dOpen"].ToString() + " " + Request.Form["dOpenHours"].ToString() + ":" + Request.Form["dOpenMinutes"].ToString() + ":00");
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(活动时间)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["dJoinBegin"] != null && Request.Form["dJoinBeginHours"] != null)
                    {
                        try
                        {
                            activity.dJoinBegin = DateTime.Parse(Request.Form["dJoinBegin"].ToString() + " " + Request.Form["dJoinBeginHours"].ToString() + ":00:00");
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(报名开始时间)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["dJoinEnd"] != null && Request.Form["dJoinEndHours"] != null)
                    {
                        try
                        {
                            activity.dJoinEnd = DateTime.Parse(Request.Form["dJoinEnd"].ToString() + " " + Request.Form["dJoinEndHours"].ToString() + ":00:00");
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(报名截止时间)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["iDistance"] != null)
                    {
                        try
                        {
                            activity.iDistance = Int32.Parse(XString.PureNumber(Request.Form["iDistance"].ToString()));
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(距离KM)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["iFee"] != null)
                    {
                        try
                        {
                            activity.iFee = Int32.Parse(XString.PureNumber(Request.Form["iFee"].ToString()));
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(费用)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["iWinner"] != null)
                    {
                        try
                        {
                            activity.iWinner = Int32.Parse(XString.PureNumber(Request.Form["iWinner"].ToString()));
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(奖励)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["iLimit"] != null)
                    {
                        try
                        {
                            activity.iLimit = Int32.Parse(XString.PureNumber(Request.Form["iLimit"].ToString()));
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(人数限制)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }

                    // 数据检查完成！添加记录！
                    if (finishedFieldCount >= 0 && PageResult.Length == 0)
                    {
                        // 博客ID
                        activity.idBlog = idBlog;

                        RaceActivity race = new RaceActivity();
                        int idActivity = 0;
                        if (race.Insert(activity, out idActivity))
                        {
                            // 修改博客关联信息ID
                            Blog blog = new Blog();
                            blog.UpdateByCommand(idBlog, "idHref=" + idActivity);

                            #region 积分:发布约跑信息
                            MemberHistory history2 = new MemberHistory();
                            history2.Insert(u.id, 100800113, 1);
                            #endregion

                            PageResult = "约跑添加成功！继续输入数据或访问其他页面！";
                            //PageResult += "<script language=\"javascript\">document.form1.reset();</script>";
                        }
                        else
                        {
                            PageResult = "系统错误";
                        }
                    }
                    else
                    {
                        PageResult = "finishedFieldCount=" + finishedFieldCount + " " + PageResult;
                    }
                }
                #endregion

                #region 添加俱乐部信息

                if (Request.Form["blogStyle"].ToString() == "Club")
                {

                    RaceClubInfo club = new RaceClubInfo();
                    club.idUser = u.id;
                    club.cLoginName = u.cLoginName;

                    if (Request.Form["idCity"] != null)
                    {
                        try
                        {
                            club.idCity = Int32.Parse(XString.PureNumber(Request.Form["idCity"].ToString()));
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(城市ID)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["cCityname"] != null)
                    {
                        try
                        {
                            club.cCityname = XString.SqlSafe(Request.Form["cCityname"].ToString());
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(城市)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["iMemberLimit"] != null)
                    {
                        try
                        {
                            club.iMemberLimit = Int32.Parse(XString.PureNumber(Request.Form["iMemberLimit"].ToString()));
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(会员数量限制)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }

                    // 数据检查完成！添加记录！
                    if (finishedFieldCount >= 0 && PageResult.Length == 0)
                    {
                        // 博客ID
                        club.idBlog = idBlog;

                        RaceClub table = new RaceClub();
                        int recordIndex = 0;
                        if (table.Insert(club, out recordIndex))
                        {
                            // 修改博客关联信息ID
                            Blog blog = new Blog();
                            blog.UpdateByCommand(idBlog, "idHref=" + recordIndex);

                            PageResult = "俱乐部添加成功！继续输入数据或访问其他页面！";
                            //PageResult += "<script language=\"javascript\">document.form1.reset();</script>";
                        }
                        else
                        {
                            PageResult = "系统错误：" + table._err;
                        }
                    }
                }
                #endregion

                #region 添加赛事信息

                if (Request.Form["blogStyle"].ToString() == "Competetion")
                {

                    // 接收数据并处理（保存）
                    RaceCompetetionInfo comp = new RaceCompetetionInfo();

                    if (Request.Form["idCompeteStyle"] != null)
                    {
                        try
                        {
                            comp.idCompeteStyle = Int32.Parse(XString.PureNumber(Request.Form["idCompeteStyle"].ToString()));
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(竞赛类型)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["idCity"] != null)
                    {
                        try
                        {
                            comp.idCity = Int32.Parse(XString.PureNumber(Request.Form["idCity"].ToString()));
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(城市ID)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["cCityname"] != null)
                    {
                        try
                        {
                            comp.cCityname = XString.SqlSafe(Request.Form["cCityname"].ToString());
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(城市)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["dRaceBegin"] != null)
                    {
                        try
                        {
                            comp.dRaceBegin = DateTime.Parse(Request.Form["dRaceBegin"].ToString());
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(赛事开始)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["dRaceEnd"] != null)
                    {
                        try
                        {
                            comp.dRaceEnd = DateTime.Parse(Request.Form["dRaceEnd"].ToString());
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(赛事结束)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["dJoinBegin"] != null)
                    {
                        try
                        {
                            comp.dJoinBegin = DateTime.Parse(Request.Form["dJoinBegin"].ToString());
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(报名开始)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["dJoinEnd"] != null)
                    {
                        try
                        {
                            comp.dJoinEnd = DateTime.Parse(Request.Form["dJoinEnd"].ToString());
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(报名结束)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }

                    // 数据检查完成！添加记录！
                    if (finishedFieldCount >= 0 && PageResult.Length == 0)
                    {
                        // 博客ID
                        comp.idBlog = idBlog;

                        RaceCompetetion table = new RaceCompetetion();
                        int recordIndex = 0;
                        if (table.Insert(comp, out recordIndex))
                        {
                            // 修改博客关联信息ID
                            Blog blog = new Blog();
                            blog.UpdateByCommand(idBlog, "idHref=" + recordIndex);

                            // 清除相应日期的缓存
                            TCache.Clear("CACHE_COMPETETION" + String.Format("{0:D2}{1:D2}", comp.dRaceBegin.Year, comp.dRaceBegin.Month));

                            PageResult = "赛事添加成功！继续输入数据或访问其他页面！";
                            //PageResult += "<script language=\"javascript\">document.form1.reset();</script>";
                        }
                        else
                        {
                            PageResult = "系统错误：" + table._err;
                        }
                    }
                }
                #endregion

                #region 添加装备信息

                if (Request.Form["blogStyle"].ToString() == "Products")
                {
                    ProductsInfo prd = new ProductsInfo();

                    if (Request.Form["idGroup"] != null)
                    {
                        try
                        {
                            prd.idGroup = Int32.Parse(XString.PureNumber(Request.Form["idGroup"].ToString()));
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(分类ID)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["idBrand"] != null)
                    {
                        try
                        {
                            prd.idBrand = Int32.Parse(XString.PureNumber(Request.Form["idBrand"].ToString()));
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(品牌ID)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }
                    if (Request.Form["fPrice"] != null)
                    {
                        try
                        {
                            prd.fPrice = Double.Parse(Request.Form["fPrice"].ToString());
                        }
                        catch (Exception ex)
                        {
                            PageResult = "数据(产品价格)格式错误[" + ex.Message + "]！请检查！";
                            //return;
                        }
                        finishedFieldCount++;
                    }

                    // 数据检查完成！添加记录！
                    if (finishedFieldCount >= 0 && PageResult.Length == 0)
                    {
                        // 博客ID
                        prd.idBlog = idBlog;

                        Products table = new Products();
                        int recordIndex = 0;
                        if (table.Insert(prd, out recordIndex))
                        {
                            // 修改博客关联信息ID
                            Blog blog = new Blog();
                            blog.UpdateByCommand(idBlog, "idHref=" + recordIndex);
                            PageResult = "数据添加成功！";
                        }
                        else
                        {
                            PageResult = "系统错误：" + table._err;
                        }
                    }
                }

                #endregion

            }
            #endregion

            int idImage = 0;
            if (Request.Form["idImage"] != null)
            {
                /*
                idImage = Int32.Parse("0" + Request.Form["idImage"].ToString());
                if (idImage > 0)
                {
                    Images imgs = new Images();
                    imgs.UpdateByCommand(idImage, "idInfo=" + idBlog);
                }
                */
                Images imgs = new Images();
                string[] midx = Request.Form["idImage"].ToString().Split(',');
                for (int i = 0; i < midx.Length; i++)
                {
                    if (midx[i].Length > 0)
                    {
                        imgs.UpdateByCommand(Int32.Parse("0" + midx[i]), "idInfo=" + idBlog);
                    }
                }
            }
            if (idBlog > 0)
            {
                if (Request.Form["from"] != null)
                {
                    Response.Redirect(UrlHelper.SubjectsUrl(Int32.Parse(Request.Form["from"].ToString())));
                }
                Response.Redirect(UrlHelper.BlogUrl(idBlog));
            }
            Response.Redirect("/Utility/Write.aspx?opr=ok");
        }

        Response.Redirect("/Utility/Write.aspx?opr=failed&err=" + PageResult);
    }
}
