using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Utility_RaceCompetetion_Update : System.Web.UI.Page
{
    // ҳ�淴����Ϣ

    public string PageResult = "";
    public RaceCompetetionInfo record = new RaceCompetetionInfo();

    protected void Page_Load(object sender, EventArgs e)
    {
        #region ���ȷ��
        Member m = new Member();
        MemberInfo u = m.Default;
        if (u == null)
        {
            PageResult = "û�в���Ȩ�ޣ�";
            return;
        }
        #endregion

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

        RaceCompetetion table = new RaceCompetetion();

        record = table.Load(recordIndex, "", "");
        if (record == null)
        {
            PageResult = "���ݴ���(Index error)��";
            return;
        }

        // ����Ϣ�����߲����޸�
        //if (record.idUser != u.id)
        //{
        //    Response.Redirect("/");
        //}

        if (Request.Form.Count > 0)
        {
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
                    TCache.Clear("CACHE_COMPETETION" + String.Format("{0:D4}{1:D2}", record.dRaceBegin.Year, record.dRaceBegin.Month));
                    PageResult = "�����޸ĳɹ���";
                }
                else
                {
                    PageResult = "ϵͳ����" + table._err;
                }
            }
            #endregion
        }
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-17 09:18 */

