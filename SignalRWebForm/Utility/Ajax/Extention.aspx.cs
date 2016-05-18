using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Ajax_Extention : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        Member m = new Member();
        UserInfo u = null;
        if (m.Default != null)
        {
            u = Users.Find(m.Default.id);
        }

        Response.ContentType = "text/html;charset=GB2312";

        StringBuilder sb = new StringBuilder();

        int id = 0;
        if (Request.QueryString["id"] != null)
        {
            id = Int32.Parse(Request.QueryString["id"].ToString());
        }

        Blog blog = new Blog();
        BlogInfo binfo;

        int page_count = 0;
        switch (Int32.Parse(id.ToString().Substring(0, 1)))
        {
            // 赛事
            case 3:
                RaceCompetetion rp = new RaceCompetetion();
                RaceCompetetionInfo rf = rp.Load(id, "", "");
                if (rf != null)
                {
                    binfo = blog.Load(rf.idBlog, "", "");

                    sb.AppendLine("所在城市：" + rf.cCityname + "<br>");
                    sb.AppendLine("竞赛类型：" + GCommon.FindValue("idCompeteStyle", rf.idCompeteStyle.ToString()) + "<br>");

                    if (rf.dRaceBegin.AddMinutes(1) > rf.dRaceEnd)
                    {
                        //sb.AppendLine("赛事时间(开始)：不详!<br>");
                        sb.AppendLine("赛事时间：" + rf.dRaceBegin.ToString("yyyy-MM-dd") + "<br>");
                    }
                    else
                    {
                        sb.AppendLine("赛事时间(开始)：" + rf.dRaceBegin.ToString("yyyy-MM-dd HH:mm") + "<br>");
                        sb.AppendLine("赛事时间(结束)：" + rf.dRaceEnd.ToString("yyyy-MM-dd HH:mm") + "<br>");
                    }

                    sb.AppendLine("报名时间(开始)：" + rf.dJoinBegin.ToString("yyyy-MM-dd HH:mm") + "<br>");
                    sb.AppendLine("报名时间(结束)：" + rf.dJoinEnd.ToString("yyyy-MM-dd HH:mm") + "<br>");
                    sb.AppendLine("<br>");

                    RaceJoin rj1 = new RaceJoin();

                    int jnum1 = 0;
                    List<RaceJoinInfo> rt = rj1.PageList(1, 10, "WHERE idActivity=" + rf.id, "", out jnum1);
                    if (DateTime.Now < rf.dJoinEnd)
                    {
                        if (u != null)
                        {
                            List<RaceJoinInfo> rs = rj1.PageList(1, 10, "WHERE idActivity=" + rf.id + " AND idUser=" + u.id, "", out page_count);
                            if (page_count > 0)
                            {
                                sb.AppendLine("<div class=\"v1a\">您已经参与</div>");
                            }
                            else
                            {
                                sb.AppendLine("<div id=\"join_info\" class=\"v1a\" onclick=\"JoinCreate(" + binfo.idUser + "," + id + ")\" style=\"width:120px;\">+ 立即参与(" + jnum1 + ")</div>");
                            }
                        }
                    }
                    else
                    {
                        sb.AppendLine("此项赛事已经截止报名");
                    }

                    //sb.AppendLine(" <a href=\"/Utility/Join.aspx?id=" + rf.id + "\" title=\"看看都谁参加了？\">已经有 " + page_count + " 人报名参赛...</a>");
                }
                break;

            // 约跑
            case 4:
                RaceActivity rb = new RaceActivity();
                RaceActivityInfo ra = rb.Load(id, "", "");
                if (ra != null)
                {
                    binfo = blog.Load(ra.idBlog, "", "");

                    sb.AppendLine("所在城市：" + ra.cCityname + "<br>");
                    sb.AppendLine("活动时间：" + ra.dOpen.ToString("yyyy-MM-dd HH:mm") + "<br>");
                    sb.AppendLine("报名时间：" + ra.dJoinBegin.ToString("yyyy-MM-dd HH:mm") + " - " + ra.dJoinEnd.ToString("yyyy-MM-dd HH:mm") + "<br>");
                    sb.AppendLine("距离：" + GCommon.FindValue("idRoadStyle", ra.idRoadStyle.ToString()) + " " + ra.iDistance + " KM<br>");
                    sb.AppendLine("费用：" + ra.iFee + " 元 ");
                    sb.AppendLine("奖励：" + ra.iWinner + " ");
                    sb.AppendLine("人数限制：" + ra.iLimit + "<br>");
                    sb.AppendLine("<br>");

                    RaceJoin rj2 = new RaceJoin();
                    int jnum2 = 0;
                    List<RaceJoinInfo> ru = rj2.PageList(1, 10, "WHERE idActivity=" + ra.id, "", out jnum2);
                    if (DateTime.Now < ra.dJoinEnd)
                    {
                        if (u != null)
                        {
                            List<RaceJoinInfo> rs = rj2.PageList(1, 10, "WHERE idActivity=" + ra.id + " AND idUser=" + u.id, "", out page_count);
                            if (page_count > 0)
                            {
                                sb.AppendLine("<div class=\"v1a\">您已经关注</div>");
                            }
                            else
                            {
                                sb.AppendLine("<div id=\"join_info\" class=\"v1a\" onclick=\"JoinCreate(" + binfo.idUser + "," + id + ")\" style=\"width:120px;\">+ 立即关注(" + jnum2 + ")</div>");
                            }
                        }
                    }
                    else
                    {
                        sb.AppendLine("此项活动已经截止报名");
                    }

                    //sb.AppendLine(" <a href=\"/Utility/Join.aspx?id=" + ra.id + "\" title=\"看看都谁参加了？\">已经有 " + page_count + " 人报名参加...</a>");
                }
                break;

            // 装备
            case 5:
                Groups groups = new Groups();
                Products prd = new Products();
                ProductsInfo r8 = prd.Load(id, "", "");
                if (r8 != null)
                {
                    GroupsInfo pa = groups.Find(r8.idGroup);
                    sb.AppendLine("类别：" + pa.cTitle + "<br>");
                    pa = groups.Find(r8.idBrand);
                    sb.AppendLine("品牌：" + pa.cTitle + "<br>");
                    sb.AppendLine("价格：" + String.Format("{0:F2}", r8.fPrice) + " 元<br>");
                }
                break;

            // 俱乐部
            case 6:
                RaceClub rc = new RaceClub();
                RaceClubInfo rg = rc.Load(id, "", "");

                RaceJoin rj3 = new RaceJoin();
                int jnum3 = 0;
                List<RaceJoinInfo> rv = rj3.PageList(1, 10, "WHERE idActivity=" + rg.id, "", out jnum3);
                if (rg != null)
                {
                    binfo = blog.Load(rg.idBlog, "", "");

                    sb.AppendLine("人数限制：" + rg.iMemberLimit + "<br>");
                    sb.AppendLine("<br>");
                    if (u != null)
                    {
                        List<RaceJoinInfo> rs = rj3.PageList(1, 10, "WHERE idActivity=" + rg.id + " AND idUser=" + u.id, "", out page_count);
                        if (page_count > 0)
                        {
                            sb.AppendLine("<div class=\"v1a\">您已经关注</div>");
                        }
                        else
                        {
                            sb.AppendLine("<div id=\"join_info\" class=\"v1a\" onclick=\"JoinCreate(" + binfo.idUser + "," + id + ")\" style=\"width:120px;\">+ 立即关注(" + jnum3 + ")</div>");
                        }
                    }
                }

                //sb.AppendLine(" <a href=\"/Utility/Join.aspx?id=" + rg.id + "\" title=\"看看都谁参加了？\">已经有 " + page_count + " 人报名参加...</a>");
                break;
        }

        Response.Write(sb.ToString());
    }
}
