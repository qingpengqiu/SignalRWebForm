using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Member_Include_Upload : System.Web.UI.Page
{
    public string PageEcho = "<img src=\"/images/noname.gif\" style=\"border:solid 3px #7E7E7E;\">";
    public string PageResult = "<script langauge=\"javascript\">document.getElementById('submit_info').innerHTML = '您还没有登录';</script>";
    public string PageBuffer = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        #region 身份确认
        Member m = new Member();
        if (m.Default == null)
        {
            //Response.Redirect(HostInfo.wwwName + "/member/");
            return;
        }
        PageResult = "";
        #endregion

        //if (Prison.Find(m.Default.id))
        //{
        //    Response.Redirect(HostInfo.wwwName + "/Member/Logout.aspx");
        //}

        if (IsPostBack)
        {
            foreach (string f in Request.Files.AllKeys)
            {
                HttpPostedFile file = Request.Files[f];
                string fname = file.FileName.ToLower();
                fname = fname.Replace("\\", "/");
                int lsub = fname.LastIndexOf("/");
                if (lsub >= 0)
                {
                    fname = fname.Substring(lsub + 1, fname.Length - lsub - 1);
                }

                string[] fa_ext = fname.Split('.');
                if (fa_ext.Length > 1)
                {
                    //string f_pre = fa_ext[fa_ext.Length - 2];
                    //f_pre = f_pre + "(" + DateTime.Now.ToString("yyyyMMddHHmmss") + ")";
                    string f_ext = fa_ext[fa_ext.Length - 1];
                    
                    if (f_ext == "gif" || f_ext == "jpg" || f_ext == "jpeg" || f_ext == "png")
                    {
                        //string pathFile = "/member/uploads/" + m.Default.id.ToString().Substring(6) + "/";
                        string pathFile = "/member/uploads/" + DateTime.Now.ToString("yyyy-MM-dd") + "/";
                        string pathUrl = HostInfo.imgName + pathFile;
                        string pathReal = Server.MapPath(pathFile);

                        string fileShort = "/" + m.Default.id + "." + f_ext;
                        string fileReal = RealUrl(pathReal + fileShort);
                        string fileUrl = RealUrl(pathUrl + fileShort);
                        string fileLocal = RealUrl(pathFile + fileShort);

                        if (!Directory.Exists(pathReal))
                        {
                            Directory.CreateDirectory(pathReal);
                        }

                        file.SaveAs(fileReal);

                        #region 缩略图与积分
                        Thumbs tm = new Thumbs();
                        tm.ToThumbnail(fileLocal, fileLocal, 150, 150);
                        m.UpdateByCommand(m.Default.id, "cAvatar='" + fileUrl + "'");

                        MemberHistory history = new MemberHistory();
                        if (history.Duplicate(m.Default.id, 100800101, "") == false)
                        {
                            history.Insert(m.Default.id, 100800101, 1);
                        }
                        #endregion

                        PageBuffer = "您的头像修改! ";

                        #region 修改内存数据库信息
                        Users.Avatar(m.Default.id, fileUrl);
                        //PageBuffer += "<script language=\"javascript\">RemoteFresh('avatar'," + m.Default.id + ")</script>";
                        #endregion
                    }
                }
            }
        }

        //Random rnd = new Random();
        UserInfo u = Users.Find(m.Default.id);
        if (u != null)
        {
            PageEcho = "<img src=\"" + u.cAvatar + "\" width=\"150\" height=\"150\" style=\"padding:1px;border:solid 3px #FFFBD6;\">";
        }
        else
        {
            PageEcho = "<img src=\"/images/noname.gif\" width=\"150\" height=\"150\" style=\"padding:1px;border:solid 3px #FFFBD6;\">";
        }
    }

    private string RealUrl(string s)
    {
        return s.Replace("//", "/").Replace("http:/", "http://");
    }
}
