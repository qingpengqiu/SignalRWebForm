using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;
using DB1 = Erun360.BLL.DB1;
using ERUN360.Entity;

public partial class _Admin_BlogPublish_Create : System.Web.UI.Page
{

    // ҳ����Ϣ
    public string PageBuffer = "";
    public string BlogExt = "";
    public string BlogList = "";

    public BlogInfo record = new BlogInfo();
    public Groups groups = new Groups();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            PageBuffer = "û�в���Ȩ�ޣ�";
            return;
        }

        int id = 0;
        if (Request.QueryString["id"] != null)
        {
            id = Int32.Parse(Request.QueryString["id"].ToString());
        }
        int idBlog = 0;
        if (Request.Form["idBlog"] != null)
        {
            idBlog = Int32.Parse(Request.Form["idBlog"].ToString());
            id = idBlog;
        }

        string new_title = "";
        if (Request.Form["new_title"] != null)
        {
            new_title = Request.Form["new_title"].ToString();
        }

        Blog b = new Blog();
        record = b.Load(id, "", "");

        if (record.idHref >= 600000000) { BlogExt = " <font color=blue>[���ֲ�]</font>"; }
        if (record.idHref >= 500000000) { BlogExt = " <font color=blue>[װ��]</font>"; }
        if (record.idHref >= 400000000) { BlogExt = " <font color=blue>[Լ��]</font>"; }
        if (record.idHref >= 300000000) { BlogExt = " <font color=blue>[����]</font>"; }

        BlogPublish bp = new BlogPublish();

        if (Request.Form.Count > 0)
        {
            int idPosition = 0;
            if (Request.Form["idPosition"] != null)
            {
                idPosition = Int32.Parse(Request.Form["idPosition"].ToString());
            }
            if (idBlog > 0 && idPosition >= 300000000)
            {
                BlogPublishInfo ba = new BlogPublishInfo();
                ba.idInfo = idBlog;
                ba.idPosition = idPosition;
                ba.cTitle = new_title;

                int idImage = 0;
                if (Request.Form["idImage"] != null)
                {
                    idImage = Int32.Parse("0" + Request.Form["idImage"].ToString());
                    if (idImage > 0)
                    {
                        ba.idImage = idImage;
                    }
                }

                int result = 0;
                bp.Insert(ba, out result);
                if (result > 0)
                {
                    TCache.Clear("CACHE_OF_PAGE_" + ba.idPosition);
                    TCache.Clear("CACHE_PAGE_TOPICS_" + ba.idPosition);

                    #region ����:��������ҳ������ҳ��
                    MemberHistory history = new MemberHistory();
                    if (idPosition < 301000000)
                    {
                        // ��ҳ������֣�����ҳ�棬��ʱ���ӻ��֣�
                        if (!new DB1.tblMEMBER_HISTORY().Exists(200810018, record.idUser, record.id.ToString()))
                        {
                            new DB1.tblIntegral().InsertScore(record.idUser, 200810018, 1, 0, record.id.ToString());
                            //history.Insert(record.idUser, 100800112, 1);
                        }
                    }
                    else
                    {
                        // ����ҳ�� 
                        //history.Insert(record.idUser, 100800111, 1);
                    }
                    #endregion

                    PageBuffer = "�����ɹ�";
                }
                else
                {
                    PageBuffer = "����ʧ��";
                }
            }
        }

        Groups groups = new Groups();
        int page_count = 0;
        List<BlogPublishInfo> list = bp.PageList(1, 30, "idInfo=" + record.id, "ORDER BY id DESC", out page_count);
        if (list != null)
        {
            if (list.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.AppendLine("<font color=black style=\"font-size:12px;\">�������Ѿ��������ڣ�</font><br>");
                int pidx = 1;
                foreach (BlogPublishInfo la in list)
                {
                    GroupsInfo gp = groups.Find(la.idPosition);
                    GroupsInfo gr = groups.Find(Int32.Parse(la.idPosition.ToString().Substring(0, 3) + "100100"));
                    if (gp != null)
                    {
                        sb.AppendLine("<span id=\"trData_" + pidx + "\">" + pidx + ". " + gr.cTitle + " &gt; " + gp.cTitle + " ��Ŀ <font color=blue style=\"cursor:pointer;\" onclick=\"ItemDelete(" + la.id + "," + pidx + ",'" + XString.MD5(la.id.ToString()) + "')\">[ɾ��]</font><br></span>");
                        pidx++;
                    }
                }
                BlogList = sb.ToString();
            }
        }
    }
}
/* Powered by ������������������޹�˾ Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:40 */

