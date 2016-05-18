using System;
using System.Data;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using ERUN360.Entity;
using System.Configuration;
using DB1 = Erun360.BLL.DB1;
public partial class _Member_Login : System.Web.UI.Page
{
    public string PageResult = "";
   
    //private static string connectionString = @"DATA SOURCE=192.168.1.36;UID=YPADMIN;PWD=Xe#data_adm_yp1;DATABASE=YP_DB_1";
    //private WYX.Dataport.Dataport dp = new WYX.Dataport.Dataport(connectionString);
    private static string connectionString = ConfigurationManager.AppSettings["USER"];
    private WYX.Dataport.Dataport dp = new WYX.Dataport.Dataport(connectionString);

    protected void Page_Load(object sender, EventArgs e)
    {

        #region ���ȷ��
        Member m = new Member();
        MemberInfo u = m.Default;
        if (u != null)
        {
            //Response.Redirect("/member/success.aspx");
            Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(u.id);
            Response.Redirect(UrlHelper.MemberUrl(u.id));
            return;
        }
        #endregion

        if (Request.Form.Count > 0)
        {
            #region ��Դ�б�
            if (!Me.HostRequired)
            {
                Response.Redirect("/");
            }
            #endregion

            string cLoginName = "";
            string cPassword = "";

            int finishedFieldCount = 0;
            if (Request.Form["cLoginName"] != null)
            {
                try
                {
                    cLoginName = XString.NickSafe(Request.Form["cLoginName"].ToString());
                    if (cLoginName.Length < 2 || cLoginName.Length > 32)
                    {
                        PageResult = "(��¼��)���ݳ��ȳ�������Χ�����飡";
                        return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "����(��¼��)��ʽ����[" + ex.Message + "]�����飡";
                    return;
                }
                finishedFieldCount++;
            }
            else
            {
                PageResult = "������������(��¼��)��";
            }

            if (Request.Form["cPassword"] != null)
            {
                try
                {
                    cPassword = XString.SqlSafe(Request.Form["cPassword"].ToString());
                    if (cPassword.Length < 6 || cPassword.Length > 32)
                    {
                        PageResult = "(����)���ݳ��ȳ�������Χ�����飡"; return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
                    return;
                }
                finishedFieldCount++;
            }
            else
            {
                PageResult = "������������(��¼��)��";
            }

            // ���ݼ����ɣ���Ӽ�¼��
            if (finishedFieldCount >= 2 && PageResult.Length == 0)
            {
                m.Login(cLoginName, cPassword);
                if (m.Default != null)
                {
                   
                    #region ����:��¼:24Сʱ֮�ڽ���һ��

                    //MemberHistory history = new MemberHistory();
                    //if (history.Duplicate(m.Default.id, 100800103, " AND dCreate>'" + DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd HH:mm:ss") + "'") == false)
                    //{
                    //    history.Insert(m.Default.id, 100800103, 1);
                    //}
                    //DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
                    //if (uMember_History.GetDailyCount(200810001, m.Default.id)>1)
                    //{
                    //    new DB1.tblIntegral().InsertScore(m.Default.id, 200810001, 1, 0, 1);
                    //    //uMember_History.Insert(m.Default.id, 1, 200800101, 0);
                    //}
                    new DB1.tblIntegral().InsertScore(m.Default.id, 200810001, 1, 0);
                    MemberSummary ms = new MemberSummary();
                    ms.UpdateByCommand(m.Default.id, "iLoginTimes=iLoginTimes+1");
                    Users.LoginTimes(m.Default.id, 1);

                    #endregion
                    Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(m.Default.id);
                    //��ע���û�

                    //TCache.SaveString("Cache_GetNewUser", GetNewUser(), 5);
                    //TCache.SaveString("Cache_GetMatch", GetMatch(), 5);
                    //TCache.SaveString("Cache_GetRunning", GetRunning(), 5);
                    //TCache.SaveString("Cache_GetMileage", GetMileage(), 5);
                    //TCache.SaveString("Cache_GetNewBlog", GetNewBlog(), 5);

                    string url = Request.UrlReferrer.Query.Replace("?url=","");
                    if (url.Trim().Length == 0)
                    {
                        Response.Redirect(UrlHelper.MemberUrl(m.Default.id));
                    }
                    else
                    {
                        Response.Redirect(url+"#text");
                    }
                }
                else
                {
                    PageResult = "��¼�����������" + m._err;
                }
            }
        }
    }
    /// <summary>
    /// ���Ǹոռ�������
    /// </summary>
    /// <returns></returns>
    public string GetNewUser()
    {
        string NewUser = string.Empty;//��ע���û�
        string sql = "SELECT top 9 [id],[cLoginname],[cAvatar],[cNickName] FROM [YP_DB_1].[dbo].[tblMEMBER]  order by id desc";
        DataTable dt = dp.GetDataSet(sql).Tables[0];
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                NewUser += "<li><a href=\"" + UrlHelper.MemberUrl(Int32.Parse(dt.Rows[i]["id"].ToString())) + "\" target=\"_blank\"><img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\" width=\"50px\" height=\"50px\">" + dt.Rows[i]["cNickName"].ToString() + "</a></li>";
            }
        }
       
        return NewUser;
    }
    //���¿��
    public string GetMatch()
    {
        string race = string.Empty;
        string sql = " SELECT top 3 blog.cTitle,race.dRaceBegin ,blog.id   FROM [YP_DB_2].[dbo].[tblBLOG] as blog,[YP_DB_4].[dbo].[tblRACE_COMPETETION] as race  where blog.id=race.idBlog and race.dRaceBegin>GETDATE()    order by race.dRaceBegin ";
        DataTable dt = dp.GetDataSet(sql).Tables[0];
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                race += "<li><a href=\"" + UrlHelper.BlogUrl(Int32.Parse(dt.Rows[i]["id"].ToString())) + "\" target=\"_blank\">" + XString.ContentTrunc(dt.Rows[i]["cTitle"].ToString(), 26) + "..." + DateTime.Parse(dt.Rows[i]["dRaceBegin"].ToString()).GetDateTimeFormats('M')[0].ToString() + "���ܣ������ע��</a></li>";
            }
        }
        else
        { race = "<li><em>������</em> <a href=\"\">�������£������ע��</a> </li>"; }
        return race;
    }
    //Լ��
    public string GetRunning()
    {
        string run = string.Empty;
        string sql = "SELECT top 4 act.id, blog.cTitle,act.dOpen ,act.iDistance,act.cCityname,blog.cLoginname FROM [YP_DB_2].[dbo].[tblBLOG] as blog,[YP_DB_4].[dbo].[tblRACE_ACTIVITY] as act where blog.id=act.idBlog  and act.dOpen>GETDATE()  order by act.dOpen  ";
        DataTable dt = dp.GetDataSet(sql).Tables[0];
        if (dt.Rows.Count>0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                run += "<li><em>" + dt.Rows[i]["cLoginname"].ToString() + "</em><a href=\"" + UrlHelper.RaceUrl(Int32.Parse(dt.Rows[i]["id"].ToString())) + "\" target=\"_blank\">" + DateTime.Parse(dt.Rows[i]["dOpen"].ToString()).GetDateTimeFormats('M')[0].ToString() + "  " + dt.Rows[i]["cCityname"].ToString() + "  " + dt.Rows[i]["iDistance"].ToString() + "KMԼ��</a></li>";

                //race += "<li><em>" + dt.Rows[i]["cLoginname"].ToString() + "</em><a href=\"" + UrlHelper.BlogUrl(Int32.Parse(dt.Rows[i]["id"].ToString())) + "\" target=\"_blank\">" + DateTime.Parse(dt.Rows[i]["dOpen"].ToString()).GetDateTimeFormats('M')[0].ToString() + dt.Rows[i]["cCityname"].ToString() + dt.Rows[i]["iDistance"].ToString() + "����Լ��" + dt.Rows[i]["cTitle"].ToString() + "</a></li>";
            }
        }
        else
        { run = "<li><em>������</em> <a href=\"\">����Լ�ܣ������ע��</a> </li>"; }
        return run;
    }
    //��������
    public string GetMileage()
    {
        Random rnd = new Random();
        string milelage = string.Empty;
        string sql = "SELECT TOP 10 [idUser],[cName],[iDistance],[dCreate] FROM [YP_DB_4].[dbo].[tblRACE_HISTORY_" + rnd.Next(10) + "] where iDistance>0 order by dCreate desc";
        DataTable dt = dp.GetDataSet(sql).Tables[0];
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                milelage += "<a href=\"" + UrlHelper.ScoreUrl(Int32.Parse(dt.Rows[i]["idUser"].ToString())) + "\" target=\"_blank\">" +dt.Rows[i]["cName"].ToString() + ":<font>" + dt.Rows[i]["iDistance"].ToString() + "KM</font></a>|";
            }
        }

        return milelage;
    }
    //���²���
    public string GetNewBlog()
    {      
        string blog = string.Empty;
        string sql = "SELECT TOP 3 blog.id,blog.cTitle,blog.idUser,users.cAvatar  FROM [YP_DB_2].[dbo].[tblBLOG] as blog,[YP_DB_1].[dbo].[tblMEMBER] as users where blog.idHref=0 and  blog.idUser=users.id  order by blog.dCreate desc";
        DataTable dt = dp.GetDataSet(sql).Tables[0];
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                blog += "<li><a href=\"" + UrlHelper.MemberUrl(Int32.Parse(dt.Rows[i]["idUser"].ToString())) + "\" target=\"_blank\"><img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\" width=\"50px\" height=\"50px\"></a><a href=\"" + UrlHelper.BlogUrl(Int32.Parse(dt.Rows[i]["id"].ToString())) + "\" target=\"_blank\">" +      XString.TruncBreak(dt.Rows[i]["cTitle"].ToString(),46,1) + "</a></li>";
            }
        }
        
        return blog;
    }
}
