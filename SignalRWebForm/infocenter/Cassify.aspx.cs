using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;

public partial class infocenter_Cassify : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
            return;
        if (!IsPostBack)
        {
            BindGroup();
        }
    }

    private void BindGroup()
    {
        DB2.tblBLOG_GROUP bGroup = new DB2.tblBLOG_GROUP();
        DataTable dt = bGroup.GetList(100, " idUser=" + CurrentUser.uId, " dCreate desc ").Tables[0];

        rptClassify.DataSource = dt;
        rptClassify.DataBind();
    }

    //添加组
    protected void btGroup_Click(object sender, EventArgs e)
    {
        DB2.tblBLOG_GROUP bGroup = new DB2.tblBLOG_GROUP();
        DBM2.tblBLOG_GROUP mGroup = new DBM2.tblBLOG_GROUP();
        if (bGroup.Exists(CurrentUser.uId, cTitle.Value.Trim()))
        {
            tipfl.InnerHtml = "分类已存在！";            
            return;
        }
              
        mGroup.cTitle = cTitle.Value.Trim();
        mGroup.idUser = CurrentUser.uId;
        mGroup.iNumber = 0;
        bGroup.Add(mGroup);        
        BindGroup();
        cTitle.Value = "";
        tipfl.InnerHtml = "";
    }
    //删除组
    protected void delete_Click(object sender, EventArgs e)
    {
        LinkButton delete = (LinkButton)sender;
        int idGroup = int.Parse(delete.CommandArgument.Trim());
        DB2.tblBLOG_GROUP bGroup = new DB2.tblBLOG_GROUP();
        DBM2.tblBLOG_GROUP model = bGroup.GetModel(idGroup);

        if (model.cTitle == "未分类")
        {
            tipfl.InnerHtml = "默认分类不允许删除！";
            return;
        }
       
        
        if (model.iNumber == 0)
        {
            bGroup.Delete(idGroup);
        }
        BindGroup();
    }
    protected void rptClassify_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        //if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        //{
        //    LinkButton delete = (LinkButton)sender;

        //    // 判断session的值显示或者隐藏删除评论的按钮  
        //    if (Session["admin"] != null && Session["admin"].ToString() == "niunan")
        //    {
        //        ((LinkButton)e.Item.FindControl("lbtnDelComment")).Visible = true;
        //    }
        //}

    }
}