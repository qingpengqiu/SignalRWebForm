using ImageProcess;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;

public partial class infocenter_PhotoAlbum : System.Web.UI.Page
{
    int PageSize = 15;
    int CurrentPage = 0;
    int PageCount = 0;
    int RecordCount = 0;

    string smallfoldername = String.Empty;//绝对路径
    string bigfoldername = String.Empty;
    string sfolder = String.Empty;//缩略图 相对路径
    string bfolder = String.Empty;//大图
    //
    public int id = 0;
    public int fid = 0;
    public string fName = "赛事相册";
    public string pName = "0";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
            DBM3.tblPhoto mPhoto = new DB3.tblPhoto().GetModel(id);
            if (mPhoto != null)
            {
                sfolder = mPhoto.cPath + "SmallPics/";
                bfolder = mPhoto.cPath + "NormalPics/";
                fName = mPhoto.cName;
                fid = mPhoto.idparent ?? 0;
                DBM3.tblPhoto fphoto = new DB3.tblPhoto().GetModel(fid);
                if (fphoto != null)
                {
                    pName = fphoto.cName;
                }
            }
        }
        //FileSaveAs picWebService = new FileSaveAs();
        PhotoService.PhotoServerSoapClient imgClient = new PhotoService.PhotoServerSoapClient();
        RecordCount = imgClient.GetCount(sfolder, bfolder);
        //设定PageSize
        int PageSize = 15;
        //第一次请求执行
        if (!Page.IsPostBack)
        {
            CurrentPage = 0;
            ViewState["PageIndex"] = 0;
            lbTotal.Text = "共" + RecordCount.ToString() + "张";
            //计算总共有多少页
            //PageCount = RecordCount / PageSize;
            PageCount = (RecordCount + PageSize - 1) / PageSize;
            //lblPageCount.Text = PageCount.ToString();
            ViewState["PageCount"] = PageCount;

            for (int i = 1; i <= PageCount; i++)
            {
                lstPage.Items.Add(i.ToString());
            }
            ListBind();
        }
    }
    DataSet CreateSource()
    {
        int StartIndex;
        //设定导入的起终地址
        StartIndex = CurrentPage * PageSize;
        //取得大图目录信息
        DirectoryInfo imagesfile = new DirectoryInfo(bigfoldername);
        //取得大图目录所有JPG文件集合
        FileInfo[] fi = imagesfile.GetFiles("*.jpg");
        //取得小图目录信息
        DirectoryInfo Smallimagesfile = new DirectoryInfo(smallfoldername);
        //取得小图目录所有JPG文件集合
        FileInfo[] Sfi = Smallimagesfile.GetFiles("*.jpg");
        //通过hashtable绑定小图路径和大图路径
        DataSet ds = new DataSet();
        DataTable tb = new DataTable();
        ds.Tables.Add(tb);

        DataColumn colSmall = new DataColumn("SmallPhoto");
        DataColumn colNormal = new DataColumn("NormalPhoto");
        DataColumn colName = new DataColumn("Name");
        ds.Tables[0].Columns.Add(colSmall);
        ds.Tables[0].Columns.Add(colNormal);
        ds.Tables[0].Columns.Add(colName);

        if (Sfi.Length - StartIndex < 15)
        {
            for (int i = 0; i < (Sfi.Length - StartIndex); i++)
            {
                DataRow row = ds.Tables[0].NewRow();
                row["SmallPhoto"] = sfolder + Sfi[i + StartIndex].Name;
                row["NormalPhoto"] = bfolder + Sfi[i + StartIndex].Name;
                row["Name"] = Sfi[i + StartIndex].Name.Substring(0, Sfi[i + StartIndex].Name.Length - 4);
                ds.Tables[0].Rows.Add(row);
            }
        }
        else
        {
            for (int i = 0; i < PageSize; i++)
            {
                DataRow row = ds.Tables[0].NewRow();
                row["SmallPhoto"] = sfolder + Sfi[i + StartIndex].Name;
                row["NormalPhoto"] = bfolder + Sfi[i + StartIndex].Name;
                row["Name"] = Sfi[i + StartIndex].Name.Substring(0, Sfi[i + StartIndex].Name.Length - 4);
                ds.Tables[0].Rows.Add(row);
            }
        }
        return ds;
    }
    public void ListBind()
    {
        //FileSaveAs picWebService = new FileSaveAs();
        PhotoService.PhotoServerSoapClient imgClient = new PhotoService.PhotoServerSoapClient();

        this.DataList1.DataSource = imgClient.GetImgs(bfolder, sfolder, CurrentPage, PageSize);
        this.DataList1.DataBind();

        lbnNextPage.Enabled = true;
        lbnPrevPage.Enabled = true;
        if (CurrentPage == ((int)ViewState["PageCount"] - 1)) lbnNextPage.Enabled = false;
        if (CurrentPage == 0) lbnPrevPage.Enabled = false;
        lbCurrentPage.Text = "   第" + (CurrentPage + 1).ToString() + "/" + ViewState["PageCount"].ToString() + "页   ";
    }

    public void Page_OnClick(Object sender, CommandEventArgs e)
    {
        CurrentPage = (int)ViewState["PageIndex"];
        PageCount = (int)ViewState["PageCount"];

        string cmd = e.CommandName;
        //判断cmd，以判定翻页方向
        switch (cmd)
        {
            case "next":
                if (CurrentPage < (PageCount - 1)) CurrentPage++;
                break;
            case "prev":
                if (CurrentPage > 0) CurrentPage--;
                break;
        }

        ViewState["PageIndex"] = CurrentPage;

        ListBind();

    }
    private int ProcessPhoto()
    {
        //生成小图目录
        //DirectoryInfo di_smallforder = Directory.CreateDirectory(smallfoldername);

        //取得大图目录信息
        DirectoryInfo imagesfile = new DirectoryInfo(bigfoldername);
        //取得大图目录所有JPG文件集合
        FileInfo[] fi = imagesfile.GetFiles("*.jpg");


        for (int i = 0; i < fi.Length; i++)
        {
            if (!File.Exists(smallfoldername + "/" + fi[i].Name))
            {
                //生成缩略图文件
                ImageThumbnail.MakeThumbnail(
                                             bigfoldername + "/" + fi[i].Name,
                                             smallfoldername + "/" + fi[i].Name,
                                             156,
                                             156,
                                             "Cut"
                                             );
            }
        }
        return fi.Length;
    }
    protected void lstPage_SelectedIndexChanged1(object sender, EventArgs e)
    {
        CurrentPage = lstPage.SelectedIndex;
        ViewState["PageIndex"] = CurrentPage;
        ListBind();
    }
}