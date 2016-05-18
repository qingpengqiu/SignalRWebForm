using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_BlogUpdate : System.Web.UI.Page
{
    public string PageResult = "";
    public string PageGroups = "";
    public string PageExt = "";

    public BlogInfo record = new BlogInfo();
    public UserInfo u;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region ���ȷ��
        Member m = new Member();
        if (m.Default == null)
        {
            //PageResult = "û�в���Ȩ�ޣ�";
            return;
        }
        #endregion

        u = Users.Find(m.Default.id);

        // ��ȡ����(id)
        int recordIndex = 0;
        if (Request["id"] != null)
        {
            recordIndex = Int32.Parse(XString.PureNumber(Request["id"].ToString()));
        }
        else
        {
            PageResult = "���ݴ���(Request[id] is null)��";
            return;
        }

        Blog table = new Blog();

        record = table.Load(recordIndex, "", "");
        if (record == null)
        {
            PageResult = "���ݴ���(Index error)��";
            return;
        }

        if (record.idHref > 0)
        {
            if (record.idHref >= 300000000 && record.idHref < 400000000)
                PageExt = "<a href=\"javascript:\" onclick=\"PopupShow(640,380,'�༭������Ϣ','/utility/include/RaceCompetetionUpdate.aspx?id=" + record.idHref + "')\">�༭������Ϣ</a>";
            if (record.idHref >= 400000000 && record.idHref < 500000000)
                PageExt = "<a href=\"javascript:\" onclick=\"PopupShow(640,480,'�༭Լ����Ϣ','/utility/include/RaceActivityUpdate.aspx?id=" + record.idHref + "')\">�༭Լ����Ϣ</a>";
            if (record.idHref >= 500000000 && record.idHref < 600000000)
                PageExt = "<a href=\"javascript:\" onclick=\"PopupShow(640,280,'�༭װ����Ϣ','/utility/include/ProductsUpdate.aspx?id=" + record.idHref + "')\">�༭װ����Ϣ</a>";
        }

        #region ����Ϣ�����߲����޸�

        if (record.idUser != u.id)
        {
            Response.Redirect("/");
        }

        #endregion

        if (Request.Form.Count > 0)
        {
            // ��Դ�б�
            if (!Me.HostRequired)
            {
                Response.Redirect("/Member/");
            }

            record.idUser = u.id;
            record.cLoginName = u.cLoginName;

            #region �����ֶε��޸�
            if (Request.Form["UpdatedFields"] != null)
            {
                string[] fa = Request.Form["UpdatedFields"].ToString().Split(';');
                StringBuilder cmd = new StringBuilder();
                foreach (string fv in fa)
                {
                    if (fv.Trim().Length < 1) continue;
                    if (Request.Form[fv] != null)
                    {
                        cmd.Append(XString.SqlSafe(fv) + "='" + XString.SqlSafe(Request.Form[fv].ToString()) + "',");
                    }
                }
                if (table.UpdateByCommand(recordIndex, cmd.ToString()))
                {
                    record = table.Load(recordIndex, "", "");
                    PageResult = "�����޸ĳɹ���";
                }
                else
                {
                    PageResult = "ϵͳ����" + table._err;
                }
            }
            #endregion

            TCache.Clear("CACHE_PAGE_MEMBER_" + record.idUser);
            TCache.Clear("CACHE_PAGE_MEMBER_ME_" + record.idUser);

            int idImage = 0;
            if (Request.Form["idImage"] != null)
            {
                /*
                idImage = Int32.Parse("0" + Request.Form["idImage"].ToString());
                if (idImage > 0)
                {
                    Images imgs = new Images();
                    imgs.UpdateByCommand(idImage, "idInfo=" + recordIndex);
                }
                */
                Images imgs = new Images();
                string[] midx = Request.Form["idImage"].ToString().Split(',');
                for (int i = 0; i < midx.Length; i++)
                {
                    if (midx[i].Length > 0)
                    {
                        imgs.UpdateByCommand(Int32.Parse("0" + midx[i]), "idInfo=" + recordIndex);
                    }
                }
            }

            Response.Redirect(UrlHelper.BlogUrl(recordIndex));

        }

        #region ���ͷ�����ʾΪ����ѡ���б�
        BlogGroup bg = new BlogGroup();
        PageGroups = bg.UserSelect(m.Default.id, record.idPersonGroup);
        #endregion
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-17 09:17 */

