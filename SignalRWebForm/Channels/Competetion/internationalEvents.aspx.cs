using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using Erun360.Common;
using System.Data;
using System.Text.RegularExpressions;
using System.Text;
public partial class Channels_Competetion_internationalEvents : System.Web.UI.Page
{
    public int id = 0;
    public string idArea = string.Empty;
    public string area = string.Empty;
    DB4.tblRACE_COMPETETION bllcompetetion = new DB4.tblRACE_COMPETETION();
    protected void Page_Load(object sender, EventArgs e)
    {
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        idArea = TypeChangeDefault.NullToString(Request.QueryString["cityid"], "0");

        if (!IsPostBack)
        {
            DBM2.tblBLOG model = new DB2.tblBLOG().GetModel(200215291);
            if (model != null)
            {
                ltlhot.Text = model.cContent.Replace("&lt;", "<").Replace("&gt;", ">").Replace("<p>", "").Replace("</p>", "");
            }
            bind();
        }
    }
    private void bind()
    {
        int TotalCount = 0;//总记录数
        int TotalPage = 1; //总页数

        DataTable dataSource = bllcompetetion.GetAllSignupByCache();
        DataRow[] datarows = dataSource.Select("dJoinEnd>='" + DateTime.Now + "'and idCity>='3501'");

        string input = string.Empty;
        area = "<option value=\"0\">所有</option>";

       
        foreach (DataRow row in datarows)
        {
            input += row["idCity"].ToString().Substring(0, 2) + ",";
        }
       
        string[] stringArray = input.TrimEnd(',').Split(',');
        //List用于存储从数组里取出来的不相同的元素
        List<string> listString = new List<string>();
        foreach (string eachString in stringArray)
        {
            if (!listString.Contains(eachString))
                listString.Add(eachString);
        }
        //最后从List里取出各个字符串进行操作
        foreach (string eachString in listString)
        {
            area += "<option value=\"" + eachString + "\">" + eachString + "</option>";
        }


        DataView dv = new DataView(dataSource);
        StringBuilder sb = new StringBuilder();
        sb.Append("dJoinEnd>='" + DateTime.Now + "'and idCity>='3501'");
        if (0 != id)
        {
            if (id >10)
            {
                sb.Append(" and dRaceBegin>='" + DateTime.Now.AddMonths(6) + "'");
            }
            else
                sb.Append(" and dRaceBegin>='" + DateTime.Now + "'and dRaceBegin<='" + DateTime.Now.AddMonths(id) + "'");

        }

        if ("0" != idArea)
        {
            sb.Append(" and idCity>='" + idArea + "01'  and idCity<='" + idArea + "99' ");
        }
        dv.RowFilter = sb.ToString();
        PagedDataSource PDS = new PagedDataSource();
        TotalCount = dv.Count;
        PDS.DataSource = dv;

        PDS.AllowPaging = true;
        PDS.PageSize = 20;
        int CurPage;
        if (Request.QueryString["Page"] != null)
            CurPage = Convert.ToInt32(Request.QueryString["Page"]);
        else
            CurPage = 1;

        if (TotalCount == 0)
            TotalPage = 1;
        else
        {
            if (TotalCount % PDS.PageSize == 0)
                TotalPage = TotalCount / PDS.PageSize;
            else
                TotalPage = TotalCount / PDS.PageSize + 1;
        }

        if (TotalPage > 1)
        { apage.Visible = true; }
        PDS.CurrentPageIndex = CurPage - 1;
        lblCurrentPage.Text = "共" + TotalCount.ToString() + "条记录 当前页：" + CurPage.ToString() + "/" + TotalPage;

        lnkFrist.NavigateUrl = Request.CurrentExecutionFilePath + "?id=" + id + "&Page=1";
        if (!PDS.IsFirstPage)
            lnkPrev.NavigateUrl = Request.CurrentExecutionFilePath + "?id=" + id + "&Page=" + Convert.ToString(CurPage - 1);

        if (!PDS.IsLastPage)
            lnkNext.NavigateUrl = Request.CurrentExecutionFilePath + "?id=" + id + "&Page=" + Convert.ToString(CurPage + 1);
        lnkEnd.NavigateUrl = Request.CurrentExecutionFilePath + "?id=" + id + "&Page=" + TotalPage;

        rptrunrecord.DataSource = PDS;
        rptrunrecord.DataBind();
    }
    private void BindData()
    {
        //ds 填充代码
        DataView dv = bllcompetetion.GetAllSignupByCache().DefaultView;
        PagedDataSource Pds = new PagedDataSource();
        Pds.DataSource = dv;
        Pds.AllowPaging = true;
        Pds.PageSize = 10;
        int TotalCount = Pds.PageCount;
        int CurrPage;
        //这里就可以通过各种方式递交页面索引(需要转换一下)
        CurrPage = TypeChangeDefault.NullToInt(Request.QueryString["Page"], 1);
        //设置当前显示第几页,注意:是从第 0 页开始
        Pds.CurrentPageIndex = CurrPage;
        //最后再绑定
        //DataList 和 Repeater 都可
        rptrunrecord.DataSource = Pds;
        rptrunrecord.DataBind();
    }
    /// <summary>
    /// DataTable分页
    /// </summary>
    /// <param name="dt">DataTable</param>
    /// <param name="PageIndex">页索引,注意：从1开始</param>
    /// <param name="PageSize">每页大小</param>
    /// <returns>分好页的DataTable数据</returns>              第1页        每页10条
    public static DataTable GetPagedTable(DataTable dt, int PageIndex, int PageSize)
    {
        if (PageIndex == 0) { return dt; }
        DataTable newdt = dt.Copy();
        newdt.Clear();
        int rowbegin = (PageIndex - 1) * PageSize;
        int rowend = PageIndex * PageSize;

        if (rowbegin >= dt.Rows.Count)
        { return newdt; }

        if (rowend > dt.Rows.Count)
        { rowend = dt.Rows.Count; }
        for (int i = rowbegin; i <= rowend - 1; i++)
        {
            DataRow newdr = newdt.NewRow();
            DataRow dr = dt.Rows[i];
            foreach (DataColumn column in dt.Columns)
            {
                newdr[column.ColumnName] = dr[column.ColumnName];
            }
            newdt.Rows.Add(newdr);
        }
        return newdt;
    }

    /// <summary>
    /// 返回分页的页数
    /// </summary>
    /// <param name="count">总条数</param>
    /// <param name="pageye">每页显示多少条</param>
    /// <returns>如果 结尾为0：则返回1</returns>
    public static int PageCount(int count, int pageye)
    {
        int page = 0;
        int sesepage = pageye;
        if (count % sesepage == 0) { page = count / sesepage; }
        else { page = (count / sesepage) + 1; }
        if (page == 0) { page += 1; }
        return page;
    }
    protected void rptrunrecord_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        //判断里层repeater处于外层repeater的哪个位置（ AlternatingItemTemplate，FooterTemplate，

        //HeaderTemplate，，ItemTemplate，SeparatorTemplate）
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater rep = e.Item.FindControl("rpquestionlist") as Repeater;//找到里层的repeater对象
            DataRowView rowv = (DataRowView)e.Item.DataItem;//找到分类Repeater关联的数据项 
            int typeid = Convert.ToInt32(rowv["id"]); //获取填充子类的id 
            rep.DataSource = bllcompetetion.Getstringbyid(typeid.ToString());
            rep.DataBind();
        }
    }
}