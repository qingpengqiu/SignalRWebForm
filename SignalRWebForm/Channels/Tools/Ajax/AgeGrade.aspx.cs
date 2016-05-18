using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Channels_Tools_Ajax_AgeGrade : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

        Hashtable hash = Tools.AgeGrade();

        #region �������

        string gender = "male";
        if (Request.QueryString["gender"] != null)
        {
            gender = Request.QueryString["gender"].ToString().ToLower();
        }

        string style = "5km";
        if (Request.QueryString["style"] != null)
        {
            style = Request.QueryString["style"].ToString().ToLower();
        }

        int age = 25;
        if (Request.QueryString["age"] != null)
        {
            age = Int32.Parse(Request.QueryString["age"].ToString());
            if (age < 10) age = 10;
            if (age > 100) age = 100;
        }

        int seconds = 1;
        if (Request.QueryString["seconds"] != null)
        {
            seconds = Int32.Parse(Request.QueryString["seconds"].ToString());
            if (seconds < 1) seconds = 1;
            if (seconds > 57600) seconds = 57600;
        }

        if (hash[gender + style] != null)
        {
            string values = (string)hash[gender + style];
            string[] va = values.Split(',');
            // ��òο�ϵ��
            double fact = Double.Parse(va[age - 3]);
            // 25����ĳɼ�
            double best_seconds = Double.Parse(va[1]);
            // ��������ĳɼ�
            double group_seconds = best_seconds / fact;
            // �ٷֱ�
            double percent = 100.0 * group_seconds / seconds;

            string desc = "����ˮƽ";
            if (percent >= 100.0) desc = "�����¼ˮƽ";
            else if (percent >= 90.0) desc = "����ˮƽ";
            else if (percent >= 80.0) desc = "ȫ��ˮƽ";
            else if (percent >= 70.0) desc = "����ˮƽ";
            else if (percent >= 60.0) desc = "����ˮƽ";
            else desc = "����ˮƽ";

            Response.Write("������(" + age + "����)�ĵȼ���ʱ�ǣ�" + SecondsToHms(100.0 * group_seconds * fact / percent) + "<br>");
            Response.Write("��������ȼ��÷��ǣ�" + String.Format("{0:F2}", percent) + " % ���ڣ�" + desc + "<br>");
            Response.Write("Ҫʵ�������¼(100%)������ʱ��" + SecondsToHms(group_seconds) + " ���٣�" + String.Format("{0:F2}", 3600.0 * Double.Parse(va[0]) / group_seconds) + " Km/h(" + SecondsToHms(group_seconds / Double.Parse(va[0])) + "/����)<br>");
            //Response.Write("Ҫʵ�ֵ���ˮƽ(60%)������ʱ��" + SecondsToHms(group_seconds / 0.6) + " ���٣�" + String.Format("{0:F2}", 0.6 * 3600.0 * Double.Parse(va[0]) / group_seconds) + " Km/h(" + SecondsToHms(group_seconds * 0.6 / Double.Parse(va[0])) + "/����)<br>");
        }
        else
        {
            Response.Write("ϵͳ����");
        }

        #endregion
    }

    /// <summary>
    /// �����롱ת��Ϊ��?��?�롱
    /// </summary>
    /// <param name="local_seconds"></param>
    /// <returns></returns>
    private string SecondsToHms(double local_seconds)
    {
        int hours = (int)Math.Floor(local_seconds / 60.0 / 60.0);
        int minutes = (int)Math.Floor((local_seconds - hours * 3600.0) / 60.0);
        int seconds = (int)Math.Floor(local_seconds - hours * 3600.0 - minutes * 60.0);

        if(hours<1) return String.Format("{0}��{1}��", hours * 60 + minutes, seconds);
        return String.Format("{0}Сʱ{1}��{2}��", hours,minutes, seconds);
    }
}
