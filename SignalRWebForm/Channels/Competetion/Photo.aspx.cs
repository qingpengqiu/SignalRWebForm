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

public partial class Channels_Competetion_Photo : PageBase
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
                fid = mPhoto.idparent??0;
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
        this.page_Title =pName+"-"+fName+"-益跑网个人中心-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";

    }
    public void ListBind()
    {
        //FileSaveAs picWebService = new FileSaveAs();
        PhotoService.PhotoServerSoapClient imgClient = new PhotoService.PhotoServerSoapClient();
        DataSet ds = imgClient.GetImgs(bfolder, sfolder, CurrentPage, PageSize);
        DataView dv = new DataView();
        dv.Table = ds.Tables[0];
        dv.Sort = "Name"; 
        this.DataList1.DataSource = dv;
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
                                             200,
                                             200,
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