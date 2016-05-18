using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
public partial class Admin_pushdel : PageBase
{
    private int id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Response.Write("您没登录，请登录！");
            return;
        }
        if ((CurrentUser.uId != 100001183 && CurrentUser.uId != 100055041) && CurrentUser.idMemberStyle != 99 && CurrentUser.idMemberStyle < 13)
        {
            Response.Write("您没有权限！");
            return;
        }
        
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);

        DB2.tblPush bll = new DB2.tblPush();
        DBM2.tblPush model = bll.GetModel(id);
        if (model == null)
        { Response.Write("系统错误"); return; }
        if (bll.Delete(id))
        {
            Erun360.Common.DataCache.RemoveAllCache("IndexArticle");
            Erun360.Common.DataCache.RemoveAllCache("cnArticle" + model.idClass);
            Erun360.Common.DataCache.RemoveAllCache("wzArticle" + model.idClass);
            Response.Write("OK");
        }
        else
        {
            Response.Write("系统错误");
        }
    }
}