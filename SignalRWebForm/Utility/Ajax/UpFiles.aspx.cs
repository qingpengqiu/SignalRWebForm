using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Ajax_UpFiles : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        #region 身份确认
        Member m = new Member();
        if (m.Default == null)
        {
            Response.Redirect("/member/");
            return;
        }
        #endregion

        string PageBuffer = "";
        int pageCount = 0;
        Images img = new Images();
        List<ImagesInfo> list = img.PageList(1, 10, "WHERE idUser=" + m.Default.id + " AND LEN(cThumbUrl)<1 AND dCreate>'" + DateTime.Now.AddMinutes(-10) + "'", "ORDER BY id DESC", out pageCount);
        if (pageCount > 0)
        {
            list.Sort(delegate(ImagesInfo a, ImagesInfo b) { return a.id - b.id; });

            foreach (ImagesInfo mv in list)
            {
                if (mv.cThumbUrl.Length == 0)
                {
                    img.UpdateBy(mv, "cThumbUrl", "0");
                    Response.Write(mv.id + "|" + mv.cImageUrl + ",");
                    //return;
                }
            }
        }
        Response.Write("");
    }
}
