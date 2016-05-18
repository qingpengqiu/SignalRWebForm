using Erun360.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB1 = Erun360.BLL.DB1;
using DB3 = Erun360.BLL.DB3;
public partial class infocenter_SearchUser : PageBase
{
    private string searchname = string.Empty;
    public string UserList = string.Empty;
    public string strWhere = string.Empty;
    public string searchTip = string.Empty;
    private int uId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser != null)
        {
            uId = CurrentUser.uId;
        }
        if (Request.QueryString["searchname"] != null)
        {
            searchname = Request.QueryString["searchname"].ToString();
            taword.Value = searchname;
            strWhere = " cNickName like '%" + searchname + "%'";
        }
        pager.RecordCount = new DB1.tblMEMBER().GetRecordCount(strWhere);
        if (searchname.Trim().Length > 0)
        {
            searchTip = "搜索到“<span>" + searchname + "</span>”相关的用户 " + pager.RecordCount + "条 结果";
        }
        else
        {
            searchTip = string.Empty;
        }
        Bind();
    }
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        Bind();
    }
    private void Bind()
    {
        int pagesize = pager.PageSize;
        int pageindex = pager.CurrentPageIndex;
        
        if (searchname.Trim().Length > 0)
        {
            UserList = new Homeland().FindUser(0, uId, strWhere, " id ", pageindex, pagesize);
        }
        else
        {
            UserList = new Homeland().FindUser(12, uId, strWhere, " newid() ", pageindex, pagesize);
            pager.Visible = false;
        }
    }
}