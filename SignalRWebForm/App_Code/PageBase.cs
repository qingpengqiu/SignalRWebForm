using Erun360.Model;
using System;
using System.Web;
using System.Web.UI;
using Erun360.BLL;
using ERUN360.Entity;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB6 = Erun360.BLL.DB6;
using System.Text;
/// <summary>
/// PageBase 的摘要说明
/// </summary>
public partial class PageBase : System.Web.UI.Page
{
    public string page_Title = string.Empty;
    public string page_Keywords = string.Empty;
    public string page_Description = string.Empty;
    private static string session_id = "SESSION_OF_ERUN360";

    private static string cookies_id = "COOKIES_OF_ERUN360";
    private static string cookies_id_p1 = "COOKIES_OF_ERUN360_ID";
    private static string cookies_id_p3 = "COOKIES_OF_ERUN360_ID_CERT";
    private static string cookies_domain = "ERUN360.COM";
    public MemberInfo Default = null;
    public PageBase()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
        this.PreInit += new EventHandler(Base_PreInit);

    }
    protected void Base_PreInit(object sender, EventArgs e)
    {
        //合作伙伴验证
        if (!string.IsNullOrEmpty(Request.QueryString["org"]))
        {
            if (new DB6.tblCooperation().IsCooperator(HttpContext.Current.Request.QueryString["org"]))
            {
                Session["org"] = HttpContext.Current.Request.QueryString["org"];
            }
            else
            {
                Session["org"] = null;
            }
        }
        //App内嵌网页自动登录
        if (!string.IsNullOrEmpty(Request["loginkey"]))
        {
            string decryptstr = Erun360.Common.DEncrypt.DESEncrypt.Decrypt(Request["loginkey"].ToString(), "erun_360");
            int index = decryptstr.IndexOf("ERUNOFFICIAL");
            string LoginName = decryptstr.Substring(0, index);
            string pwd = decryptstr.Substring(index + 12);
            DBM1.tblMEMBER membermodel = new DB1.tblMEMBER().GetLogin(LoginName.Trim(), XString.MD5(pwd.Trim().ToLower()));
            if (membermodel != null)
            {
                Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(membermodel.id);
                Member m = new Member();
                m.Login(LoginName, pwd);
            }
        }
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
    /// 保存Session信息(DES加密)
    /// </summary>
    private void SessionSave()
    {
        if (Default == null) return;
        HttpContext.Current.Session[session_id] = Default.id.ToString() + " " + Default.cLoginName.ToLower();
    }
    /// <summary>
    /// 验证用户身份
    /// </summary>
    protected void CheckUserState()
    {
        CookiesLoad();
        //if (Session["CurrentUser"] == null)
        //{
        //    string url = Request.RawUrl;
        //    Response.Redirect(ReadRootUrl() + "Member/Logout.aspx", true);
        //}
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
    public DateTime CurrentTime()
    {
        return new DB6.tblOrder().GetTime(0);
    }
}