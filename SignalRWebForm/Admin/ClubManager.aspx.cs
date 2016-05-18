using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using Utils;
public partial class Admin_ClubManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataSet ds = new DB4.tblRACE_CLUB().GetAllList();
        
      
        if (!IsPostBack)
        {
            
        }
    }
    //private void bind()
    //{
    //    int TotalCount = 0;//总记录数
    //    int TotalPage = 1; //总页数

    //    SqlConnection conn = new SqlConnection(ConnStr);
    //    conn.Open();
    //    SqlDataAdapter da = new SqlDataAdapter("select CustomerID,CompanyName,ContactName,ContactTitle,Address from Customers order by CustomerID desc", conn);
    //    DataSet ds = new DataSet();
    //    da.Fill(ds, "Customers");
    //    DataView dv = ds.Tables[0].DefaultView;

    //    TotalCount = dv.Count;
    //    PDS.DataSource = dv;
    //    conn.Close();
    //    PDS.AllowPaging = true;
    //    PDS.PageSize = 20;
    //    int CurPage;
    //    if (Request.QueryString["Page"] != null)
    //        CurPage = Convert.ToInt32(Request.QueryString["Page"]);
    //    else
    //        CurPage = 1;

    //    if (TotalCount == 0)
    //        TotalPage = 1;
    //    else
    //    {
    //        if (TotalCount % PDS.PageSize == 0)
    //            TotalPage = TotalCount / PDS.PageSize;
    //        else
    //            TotalPage = TotalCount / PDS.PageSize + 1;
    //    }

    //    PDS.CurrentPageIndex = CurPage - 1;
    //    lblCurrentPage.Text = "共" + TotalCount.ToString() + "条记录 当前页：" + CurPage.ToString() + "/" + TotalPage;

    //    lnkFrist.NavigateUrl = Request.CurrentExecutionFilePath + "?Page=1";
    //    if (!PDS.IsFirstPage)
    //        lnkPrev.NavigateUrl = Request.CurrentExecutionFilePath + "?Page=" + Convert.ToString(CurPage - 1);

    //    if (!PDS.IsLastPage)
    //        lnkNext.NavigateUrl = Request.CurrentExecutionFilePath + "?Page=" + Convert.ToString(CurPage + 1);
    //    lnkEnd.NavigateUrl = Request.CurrentExecutionFilePath + "?Page=" + TotalPage;

    //    Repeater1.DataSource = PDS;
    //    Repeater1.DataBind();
    //}
    //protected void btnDel_Click(object sender, EventArgs e)
    //{
    //    string ID = "";

    //    for (int i = 0; i < this.Repeater1.Items.Count; i++)
    //    {
    //        CheckBox cbox = (CheckBox)this.Repeater1.Items[i].FindControl("chkItem");
    //        if (cbox.Checked == true)
    //        {
    //            if (ID == "")
    //            {
    //                ID = "'" + ((Label)this.Repeater1.Items[i].FindControl("lblID")).Text + "'";
    //            }
    //            else
    //            {
    //                ID += "," + "'" + ((Label)this.Repeater1.Items[i].FindControl("lblID")).Text + "'";
    //            }
    //        }
    //    }
    //    //strsql = "delete from Customers where CustomerID in (" + ID + ")";
    //    //try
    //    //{
    //    //    SqlConnection conn = new SqlConnection(ConnStr);
    //    //    SqlCommand comm = new SqlCommand(strsql, conn);
    //    //    comm.Connection.Open();
    //    //    comm.ExecuteNonQuery();
    //    //    comm.Connection.Close();
    //    //    System.Web.HttpContext.Current.Response.Write("<script language='javascript'>alert('刪除成功!');</script>");
    //    //}
    //    //catch (System.Data.SqlClient.SqlException E)
    //    //{
    //    //    throw new Exception(E.Message);
    //    //}
    //    //finally
    //    //{
    //    //    if (conn.State == ConnectionState.Open)
    //    //        conn.Close();
    //    //}
    //    //this.bind();
    //}
}