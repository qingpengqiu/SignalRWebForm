using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using Erun360.BLL;

public partial class infocenter_Photo : PageBase
{
    public string pageCount = string.Empty; //总条目数
    private int uId = 0;//通过参数传递过来的用户id
    public string PhotoList = string.Empty;
    private int cId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uId"] != null)
        {
            uId = int.Parse(Request.QueryString["uId"].ToString());
        }
        ScriptManager.RegisterStartupScript(UpdatePanel2, this.GetType(), "alert", "<script type=\"text/javascript\"> $('.group2').colorbox({ rel: 'group2', transition: 'fade' });</script>", false);
        ScriptManager.RegisterStartupScript(UpdatePanel2, this.GetType(), "alert1", "<script type=\"text/javascript\"> $(function(){waterfall('.group2')});</script>", false);
        //$('.group2').colorbox({ rel: 'group2', transition: 'fade' });

        if (!IsPostBack)
        {
            if (CurrentUser != null)
            {
                cId = CurrentUser.uId;
                DB3.tblIMAGES uImg = new DB3.tblIMAGES();
                pager.RecordCount = uImg.GetRecordCount("idUser =" + uId);
                Bind();
                //PhotoInfo uPhoto = new PhotoInfo();
                //PhotoList = uPhoto.Photolist(PageBase.cId, uId, 10, 1);
            }
            else
            {
                pager.RecordCount = new DB3.tblIMAGES().GetRecordCount("idUser =" + uId);
                Bind();
            }
        }
    }
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        Bind();
    }
    private void Bind()
    {

        int pagesize = pager.PageSize;
        int pageindex = pager.CurrentPageIndex;
        PhotoInfo uPhoto = new PhotoInfo();
        PhotoList = uPhoto.Photolist(cId, uId, pagesize, pageindex);
    }
}