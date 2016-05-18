using Erun360.Model;
using System;
using System.Web;
using System.Web.UI;
using Erun360.BLL;
using ERUN360.Entity;
using System.Text;
using DB1 = Erun360.BLL.DB1;
/// <summary>
/// PageBase 的摘要说明
/// </summary>
public partial class PageBaseCtrl : System.Web.UI.UserControl
{
    private static string session_id = "SESSION_OF_ERUN360";

    private static string cookies_id = "COOKIES_OF_ERUN360";
    private static string cookies_id_p1 = "COOKIES_OF_ERUN360_ID";
    private static string cookies_id_p3 = "COOKIES_OF_ERUN360_ID_CERT";
    private static string cookies_domain = "ERUN360.COM";
    public MemberInfo Default = null;
    public PageBaseCtrl()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
    #region 身份验证
    /// <summary>
    ///　用户帐号
    /// </summary>
    protected UserInfoModel CurrentUser
    {
        get
        {
            if (Session["CurrentUser"] == null)
            {
                CookiesLoad();
                //this.CheckUserState();
            }

            return (UserInfoModel)Session["CurrentUser"];
        }
        set
        {
            Session["CurrentUser"] = value;

        }
    }
    /// <summary>
    /// 获取文件哈西目录
    /// </summary>
    /// <param name="uId"></param>
    /// <returns></returns>
    protected string GetDir(string uId)
    {
        string CacheKey = "FileDir-" + uId;
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
            try
            {
                //byte[] bytesurl = Encoding.ASCII.GetBytes(uId);
                //byte[] hashValue = ((System.Security.Cryptography.HashAlgorithm)System.Security.Cryptography.CryptoConfig.CreateFromName("MD5")).ComputeHash(bytesurl);
                //string hashurl = hashValue[0].ToString("x4");
                string hashurl = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(uId, "MD5");
                string FileDir = hashurl.Substring(0, 2) + "/" + hashurl.Substring(2, 2);
                objModel = FileDir;
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch
            {
                objModel = "";
            }
        }

        return objModel.ToString();
    }
    /// <summary>
    /// 保存Session信息(DES加密)
    /// </summary>
    private void SessionSave()
    {
        if (Default == null) return;
        HttpContext.Current.Session[session_id] = Default.id.ToString() + " " + Default.cLoginName.ToLower();
    }
    /// <summary>
    /// 读取COOKIES数值并进行MD5校验
    /// </summary>
    private void CookiesLoad()
    {
        int loc_id = 0;
        string loc_loginname = "";
        string loc_cert = "";
        HttpRequest Request = HttpContext.Current.Request;

        // 读取新的 Cookies 信息
        if (Request.Cookies[cookies_id] != null)
        {
            if (Request.Cookies[cookies_id][cookies_id_p1] != null)
            {
                string cs = XString.DESDecrypt(Request.Cookies[cookies_id][cookies_id_p1].ToString());
                string[] ca = cs.Split(' ');
                if (ca.Length > 1)
                {
                    loc_id = Int32.Parse("0" + XString.PureNumber(ca[0]));
                    loc_loginname = ca[1].ToLower();
                }
            }
            if (Request.Cookies[cookies_id][cookies_id_p3] != null)
            {
                loc_cert = Request.Cookies[cookies_id][cookies_id_p3];
            }
            if (loc_id > 0 && loc_cert.Length > 0)
            {
                if (loc_cert == XString.MD5(loc_id.ToString() + " " + loc_loginname))
                {
                    Default = new MemberInfo();
                    Default.id = loc_id;
                    Default.cLoginName = loc_loginname;
                    //每日登陆
                    new DB1.tblIntegral().InsertScore(Default.id, 200810001, 1, 0);
                    Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(Default.id);
                    SessionSave();
                }
            }
        }
    }
    /// <summary>
    /// 验证用户身份
    /// </summary>
    protected void CheckUserState()
    {
        if (Session["CurrentUser"] == null)
        {
            string url = Request.RawUrl;
            Response.Redirect(ReadRootUrl() + "Member/Logout.aspx", true);
        }
    }
    #endregion  
    /// <summary>
    /// 读取网站根目录
    /// </summary>
    /// <returns></returns>
    public string ReadRootUrl()
    {
        string url = System.Configuration.ConfigurationManager.AppSettings["rootUrl"];
        return url;
    }
}