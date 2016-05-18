using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;

public partial class _Utility_Uploads_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

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
                    string f_pre = fa_ext[fa_ext.Length - 2];
                    //f_pre = f_pre + "(" + DateTime.Now.ToString("yyyyMMddHHmmss") + ")";
                    string f_ext = fa_ext[fa_ext.Length - 1];

                    if ( f_ext == "rar")
                    {
                        file.SaveAs(Server.MapPath("/utility/uploads/") + "/" + f_pre + "." + f_ext);
                    }
                }
            }
        }
    }
}
