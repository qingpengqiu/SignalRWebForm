using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Utility_Include_Image : System.Web.UI.Page
{
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
                    string f_pre = DateTime.Now.ToString("HHmmss");
                    string f_ext = fa_ext[fa_ext.Length - 1];

                    if (f_ext == "gif" || f_ext == "jpg" || f_ext == "jpeg" || f_ext == "png")
                    {
                        string pathFile = "/utility/uploads/" + DateTime.Now.ToString("yyyy-MM-dd") + "/";
                        string pathUrl = HostInfo.imgName + pathFile;
                        string pathReal = Server.MapPath(pathFile);

                        string fileShort = "/" + m.Default.id + "_" + f_pre + "." + f_ext;
                        string fileReal = RealUrl(pathReal + fileShort);
                        string fileUrl = RealUrl(pathUrl + fileShort);
                        string fileLocal = RealUrl(pathFile + fileShort);

                        if (!Directory.Exists(pathReal))
                        {
                            Directory.CreateDirectory(pathReal);
                        }

                        file.SaveAs(fileReal);

                        Images imgs = new Images();
                        ImagesInfo img = new ImagesInfo();
                        img.idUser = m.Default.id;
                        img.idInfo = 0;
                        img.cImageUrl = fileUrl;

                        int result = 0;
                        if (imgs.Insert(img, out result))
                        {
                            PageBuffer = "成功上传图片，请关闭窗口！";
                        }
                    }
                }
            }
        }
    }

    private string RealUrl(string s)
    {
        return s.Replace("//", "/").Replace("http:/", "http://");
    }
}
