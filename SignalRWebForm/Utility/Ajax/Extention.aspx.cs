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
            // ����
            case 3:
                RaceCompetetion rp = new RaceCompetetion();
                RaceCompetetionInfo rf = rp.Load(id, "", "");
                if (rf != null)
                {
                    binfo = blog.Load(rf.idBlog, "", "");

                    sb.AppendLine("���ڳ��У�" + rf.cCityname + "<br>");
                    sb.AppendLine("�������ͣ�" + GCommon.FindValue("idCompeteStyle", rf.idCompeteStyle.ToString()) + "<br>");

                    if (rf.dRaceBegin.AddMinutes(1) > rf.dRaceEnd)
                    {
                        //sb.AppendLine("����ʱ��(��ʼ)������!<br>");
                        sb.AppendLine("����ʱ�䣺" + rf.dRaceBegin.ToString("yyyy-MM-dd") + "<br>");
                    }
                    else
                    {
                        sb.AppendLine("����ʱ��(��ʼ)��" + rf.dRaceBegin.ToString("yyyy-MM-dd HH:mm") + "<br>");
                        sb.AppendLine("����ʱ��(����)��" + rf.dRaceEnd.ToString("yyyy-MM-dd HH:mm") + "<br>");
                    }

                    sb.AppendLine("����ʱ��(��ʼ)��" + rf.dJoinBegin.ToString("yyyy-MM-dd HH:mm") + "<br>");
                    sb.AppendLine("����ʱ��(����)��" + rf.dJoinEnd.ToString("yyyy-MM-dd HH:mm") + "<br>");
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
                                sb.AppendLine("<div class=\"v1a\">���Ѿ�����</div>");
                            }
                            else
                            {
                                sb.AppendLine("<div id=\"join_info\" class=\"v1a\" onclick=\"JoinCreate(" + binfo.idUser + "," + id + ")\" style=\"width:120px;\">+ ��������(" + jnum1 + ")</div>");
                            }
                        }
                    }
                    else
                    {
                        sb.AppendLine("���������Ѿ���ֹ����");
                    }

                    //sb.AppendLine(" <a href=\"/Utility/Join.aspx?id=" + rf.id + "\" title=\"������˭�μ��ˣ�\">�Ѿ��� " + page_count + " �˱�������...</a>");
                }
                break;

            // Լ��
            case 4:
                RaceActivity rb = new RaceActivity();
                RaceActivityInfo ra = rb.Load(id, "", "");
                if (ra != null)
                {
                    binfo = blog.Load(ra.idBlog, "", "");

                    sb.AppendLine("���ڳ��У�" + ra.cCityname + "<br>");
                    sb.AppendLine("�ʱ�䣺" + ra.dOpen.ToString("yyyy-MM-dd HH:mm") + "<br>");
                    sb.AppendLine("����ʱ�䣺" + ra.dJoinBegin.ToString("yyyy-MM-dd HH:mm") + " - " + ra.dJoinEnd.ToString("yyyy-MM-dd HH:mm") + "<br>");
                    sb.AppendLine("���룺" + GCommon.FindValue("idRoadStyle", ra.idRoadStyle.ToString()) + " " + ra.iDistance + " KM<br>");
                    sb.AppendLine("���ã�" + ra.iFee + " Ԫ ");
                    sb.AppendLine("������" + ra.iWinner + " ");
                    sb.AppendLine("�������ƣ�" + ra.iLimit + "<br>");
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
                                sb.AppendLine("<div class=\"v1a\">���Ѿ���ע</div>");
                            }
                            else
                            {
                                sb.AppendLine("<div id=\"join_info\" class=\"v1a\" onclick=\"JoinCreate(" + binfo.idUser + "," + id + ")\" style=\"width:120px;\">+ ������ע(" + jnum2 + ")</div>");
                            }
                        }
                    }
                    else
                    {
                        sb.AppendLine("�����Ѿ���ֹ����");
                    }

                    //sb.AppendLine(" <a href=\"/Utility/Join.aspx?id=" + ra.id + "\" title=\"������˭�μ��ˣ�\">�Ѿ��� " + page_count + " �˱����μ�...</a>");
                }
                break;

            // װ��
            case 5:
                Groups groups = new Groups();
                Products prd = new Products();
                ProductsInfo r8 = prd.Load(id, "", "");
                if (r8 != null)
                {
                    GroupsInfo pa = groups.Find(r8.idGroup);
                    sb.AppendLine("���" + pa.cTitle + "<br>");
                    pa = groups.Find(r8.idBrand);
                    sb.AppendLine("Ʒ�ƣ�" + pa.cTitle + "<br>");
                    sb.AppendLine("�۸�" + String.Format("{0:F2}", r8.fPrice) + " Ԫ<br>");
                }
                break;

            // ���ֲ�
            case 6:
                RaceClub rc = new RaceClub();
                RaceClubInfo rg = rc.Load(id, "", "");

                RaceJoin rj3 = new RaceJoin();
                int jnum3 = 0;
                List<RaceJoinInfo> rv = rj3.PageList(1, 10, "WHERE idActivity=" + rg.id, "", out jnum3);
                if (rg != null)
                {
                    binfo = blog.Load(rg.idBlog, "", "");

                    sb.AppendLine("�������ƣ�" + rg.iMemberLimit + "<br>");
                    sb.AppendLine("<br>");
                    if (u != null)
                    {
                        List<RaceJoinInfo> rs = rj3.PageList(1, 10, "WHERE idActivity=" + rg.id + " AND idUser=" + u.id, "", out page_count);
                        if (page_count > 0)
                        {
                            sb.AppendLine("<div class=\"v1a\">���Ѿ���ע</div>");
                        }
                        else
                        {
                            sb.AppendLine("<div id=\"join_info\" class=\"v1a\" onclick=\"JoinCreate(" + binfo.idUser + "," + id + ")\" style=\"width:120px;\">+ ������ע(" + jnum3 + ")</div>");
                        }
                    }
                }

                //sb.AppendLine(" <a href=\"/Utility/Join.aspx?id=" + rg.id + "\" title=\"������˭�μ��ˣ�\">�Ѿ��� " + page_count + " �˱����μ�...</a>");
                break;
        }

        Response.Write(sb.ToString());
    }
}
