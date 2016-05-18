using System;
using System.Text;
using System.Web;
using System.Net;
using System.Collections;
using System.Collections.Specialized;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls; 

/// <summary>
/// ����ҳ������ࣨ����Class��
/// </summary>
public static class Me
{
    /// <summary>
    /// ��ǰRequest����
    /// </summary>
    public static HttpRequest Request
    {
        get { return HttpContext.Current.Request; }
    }

    /// <summary>
    /// ��ǰResponse����
    /// </summary>
    public static HttpResponse Response
    {
        get { return HttpContext.Current.Response; }
    }

    public static HttpServerUtility Server
    {
        get { return HttpContext.Current.Server; }
    }

    /// <summary>
    /// ����ǲ��Ǳ�������
    /// </summary>
    public static bool HostRequired
    {
        get
        {
            if (Request.ServerVariables["HTTP_REFERER"] == null) return false;
            string path = Request.ServerVariables["HTTP_REFERER"].ToString().ToLower();
            string[] pary = path.Split('/');
            string hostname = Request.ServerVariables["HTTP_HOST"].ToString().ToLower();
            return (hostname == pary[2]) ? true : false;
        }
    }

    public static string Hostname
    {
        get
        {
            return Request.ServerVariables["HTTP_HOST"].ToString().ToLower();
        }
    }

    /// <summary>
    /// ����û�����ʵ IP
    /// </summary>
    /// <returns></returns>
    public static string remoteIP
    {
        get
        {
            string ip = "127.0.0.1";
            if (Request.ServerVariables["HTTP_VIA"] != null)
            {
                ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString().Split(',')[0].Trim();
            }
            else
            {
                ip = Request.UserHostAddress;
            }
            return ip;
        }
    }
    
    /// <summary>
    /// ��ǰ������
    /// </summary>
    /// <returns></returns>
    public static string ScriptName
    {
        get
        {
            return Request.ServerVariables["SCRIPT_NAME"].ToString().ToLower();
        }
    }
}
