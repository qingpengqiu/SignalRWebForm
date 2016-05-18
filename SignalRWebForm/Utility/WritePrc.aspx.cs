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
        #region ���ȷ��
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
            // ��Դ�б�
            if (!Me.HostRequired)
            {
                Response.Redirect("/Member/");
                return;
            }

            #region ��Ӳ�����Ϣ

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
                    PageResult = "����(���˷���)��ʽ����[" + ex.Message + "]�����飡";
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
                        PageResult = "(����)���ݳ��ȳ�������Χ�����飡";
                        //return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
                    //return;
                }

                if (GCommon.BadContent(record.cTitle))
                {
                    PageResult = "�Ƿ����⣡";
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
                        PageResult = "(����)���ݳ��ȳ�������Χ�����飡";
                        //return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
                    //return;
                }

                if (GCommon.BadContent(record.cTitle))
                {
                    PageResult = "�Ƿ����ݣ�";
                    //return;
                }

                finishedFieldCount++;
            }

            // ���ݼ����ɣ���Ӽ�¼��
            if (finishedFieldCount >= 0 && PageResult.Length == 0)
            {
                Blog table = new Blog();
                int recordIndex = 0;
                if (table.Insert(record, out recordIndex))
                {
                    idBlog = recordIndex;

                    #region ����:������
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

                        // ˢ����ҳ������Ŀ��Ӧ���б���
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

                    #region �����Ӧ�ڴ����ݿ���Ϣ
                    Users.Blogs(record.idUser, 1);
                    TCache.Clear("CACHE_PAGE_MEMBER_" + record.idUser);
                    TCache.Clear("CACHE_PAGE_MEMBER_ME_" + record.idUser);
                    CacheHelper.Clear("CACHE_RECENT_BLOGS");
                    #endregion

                    PageResult = "������ӳɹ��������������ݻ��������ҳ�棡";
                }
                else
                {
                    PageResult = "ϵͳ����" + table._err;
                }
            }
            #endregion

            #region ������Ϣ

            if (Request.Form["blogStyle"] != null)
            {

                finishedFieldCount = 0;
                PageResult = "";

                #region ���Լ����Ϣ

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
                            PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(����ID)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(�ʱ��)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(������ʼʱ��)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(������ֹʱ��)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(����KM)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(��������)��ʽ����[" + ex.Message + "]�����飡";
                            //return;
                        }
                        finishedFieldCount++;
                    }

                    // ���ݼ����ɣ���Ӽ�¼��
                    if (finishedFieldCount >= 0 && PageResult.Length == 0)
                    {
                        // ����ID
                        activity.idBlog = idBlog;

                        RaceActivity race = new RaceActivity();
                        int idActivity = 0;
                        if (race.Insert(activity, out idActivity))
                        {
                            // �޸Ĳ��͹�����ϢID
                            Blog blog = new Blog();
                            blog.UpdateByCommand(idBlog, "idHref=" + idActivity);

                            #region ����:����Լ����Ϣ
                            MemberHistory history2 = new MemberHistory();
                            history2.Insert(u.id, 100800113, 1);
                            #endregion

                            PageResult = "Լ����ӳɹ��������������ݻ��������ҳ�棡";
                            //PageResult += "<script language=\"javascript\">document.form1.reset();</script>";
                        }
                        else
                        {
                            PageResult = "ϵͳ����";
                        }
                    }
                    else
                    {
                        PageResult = "finishedFieldCount=" + finishedFieldCount + " " + PageResult;
                    }
                }
                #endregion

                #region ��Ӿ��ֲ���Ϣ

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
                            PageResult = "����(����ID)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(��Ա��������)��ʽ����[" + ex.Message + "]�����飡";
                            //return;
                        }
                        finishedFieldCount++;
                    }

                    // ���ݼ����ɣ���Ӽ�¼��
                    if (finishedFieldCount >= 0 && PageResult.Length == 0)
                    {
                        // ����ID
                        club.idBlog = idBlog;

                        RaceClub table = new RaceClub();
                        int recordIndex = 0;
                        if (table.Insert(club, out recordIndex))
                        {
                            // �޸Ĳ��͹�����ϢID
                            Blog blog = new Blog();
                            blog.UpdateByCommand(idBlog, "idHref=" + recordIndex);

                            PageResult = "���ֲ���ӳɹ��������������ݻ��������ҳ�棡";
                            //PageResult += "<script language=\"javascript\">document.form1.reset();</script>";
                        }
                        else
                        {
                            PageResult = "ϵͳ����" + table._err;
                        }
                    }
                }
                #endregion

                #region ���������Ϣ

                if (Request.Form["blogStyle"].ToString() == "Competetion")
                {

                    // �������ݲ��������棩
                    RaceCompetetionInfo comp = new RaceCompetetionInfo();

                    if (Request.Form["idCompeteStyle"] != null)
                    {
                        try
                        {
                            comp.idCompeteStyle = Int32.Parse(XString.PureNumber(Request.Form["idCompeteStyle"].ToString()));
                        }
                        catch (Exception ex)
                        {
                            PageResult = "����(��������)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(����ID)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(���¿�ʼ)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(���½���)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(������ʼ)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(��������)��ʽ����[" + ex.Message + "]�����飡";
                            //return;
                        }
                        finishedFieldCount++;
                    }

                    // ���ݼ����ɣ���Ӽ�¼��
                    if (finishedFieldCount >= 0 && PageResult.Length == 0)
                    {
                        // ����ID
                        comp.idBlog = idBlog;

                        RaceCompetetion table = new RaceCompetetion();
                        int recordIndex = 0;
                        if (table.Insert(comp, out recordIndex))
                        {
                            // �޸Ĳ��͹�����ϢID
                            Blog blog = new Blog();
                            blog.UpdateByCommand(idBlog, "idHref=" + recordIndex);

                            // �����Ӧ���ڵĻ���
                            TCache.Clear("CACHE_COMPETETION" + String.Format("{0:D2}{1:D2}", comp.dRaceBegin.Year, comp.dRaceBegin.Month));

                            PageResult = "������ӳɹ��������������ݻ��������ҳ�棡";
                            //PageResult += "<script language=\"javascript\">document.form1.reset();</script>";
                        }
                        else
                        {
                            PageResult = "ϵͳ����" + table._err;
                        }
                    }
                }
                #endregion

                #region ���װ����Ϣ

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
                            PageResult = "����(����ID)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(Ʒ��ID)��ʽ����[" + ex.Message + "]�����飡";
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
                            PageResult = "����(��Ʒ�۸�)��ʽ����[" + ex.Message + "]�����飡";
                            //return;
                        }
                        finishedFieldCount++;
                    }

                    // ���ݼ����ɣ���Ӽ�¼��
                    if (finishedFieldCount >= 0 && PageResult.Length == 0)
                    {
                        // ����ID
                        prd.idBlog = idBlog;

                        Products table = new Products();
                        int recordIndex = 0;
                        if (table.Insert(prd, out recordIndex))
                        {
                            // �޸Ĳ��͹�����ϢID
                            Blog blog = new Blog();
                            blog.UpdateByCommand(idBlog, "idHref=" + recordIndex);
                            PageResult = "������ӳɹ���";
                        }
                        else
                        {
                            PageResult = "ϵͳ����" + table._err;
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
