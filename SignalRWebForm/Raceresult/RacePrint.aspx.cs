using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
public partial class Raceresult_RacePrint : System.Web.UI.Page
{
    public string name = string.Empty;

    private int id = 0;
    private string vers = string.Empty;
    private int itype = 0;
    public string FilePath = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        name = TypeChangeDefault.NullToString(unicode_1(Request.QueryString["n"]), "");
        vers = TypeChangeDefault.NullToString(Request.QueryString["p"], "");
        itype = TypeChangeDefault.NullToInt(Request.QueryString["t"], 0);
        if (id == 0)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "RaceQuery.aspx", false);
            return;
        }
        if (name.Trim().Length == 0)
        {
            AlertHelper.JQAlertGo("请填写名称！", "RaceQuery.aspx", false);
            return;
        }
        if (vers.Trim().Length == 0)
        {
            AlertHelper.JQAlertGo("请填写号码！", "RaceQuery.aspx", false);
            return;
        }
        if (!IsPostBack)
        {
            DBM4.tblEvent model = new DB4.tblEvent().GetModel(id);
            if (model == null)
            {
                AlertHelper.JQAlertGo("请选择赛事！", "RaceQuery.aspx", false);
                return;
            }
            if (model.iDoc != 1)
            {
                AlertHelper.JQAlertGo("该赛事没有证书哦！", "RaceQuery.aspx", false);
                return;
            }
            if (itype != model.istyle)
            {
                AlertHelper.JQAlertGo("赛事不匹配，请重新选择！", "RaceQuery.aspx", false);
                return;
            }
            DataTable dt = new DataTable();
            if (itype == 1)
            {
                dt = new DB4.tblEventTotal().GetCardResult(id, name, vers).Tables[0];
            }
            else if (itype == 2)
            {
                dt = new DB4.tblEventTotal().GetBibResult(id, name, vers).Tables[0];
            }
            if (dt.Rows.Count > 0)
            {
                string result = dt.Rows[0]["cResult"].ToString();
                if (result.Trim().Length == 0)
                {
                    AlertHelper.JQAlertGo("您的成绩不存在！", "RaceQuery.aspx", false);
                    return;
                }
                string FileDir = "/zs/" + model.id + "/";
                CreateDirectory(Server.MapPath(FileDir));

                FilePath = FileDir + dt.Rows[0]["cBib"].ToString() + ".pdf";
                //File.Delete(Server.MapPath(FilePath));
                //判断文件是否存在
                if (!File.Exists(Server.MapPath(FilePath)))
                {
                    string[] ca = result.Split(':');
                    if (ca.Length > 2)
                    {
                        DataTable dtGoup = new DB4.tblEventTotal().GetUserName(id, dt.Rows[0]["cBib"].ToString()).Tables[0];
                        if (dtGoup.Rows.Count > 0)
                        {
                            string nameGoup = string.Empty;
                            for (int i = 0; i < dtGoup.Rows.Count; i++)
                            {
                                nameGoup += dtGoup.Rows[i]["cName"].ToString() + " ";
                            }
                            if (nameGoup.Trim().Length == 0)
                            {
                                AlertHelper.JQAlertGo("该用户不存在！", "RaceQuery.aspx", false);
                                return;
                            }
                            if (model.id == 1 || model.id == 16 || model.id == 19 || model.id == 21)//2014福建乡村越野跑-五夫站
                            {
                                DownLoadFdf1(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["Km"].ToString(), dt.Rows[0]["cGroupName"].ToString(), ca);
                            }
                            else if (model.id == 2)//益跑华南区主办「广州之巅挑战赛」
                            {
                                DownLoadFdf2(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["iRank"].ToString(), ca);
                            }
                            else if (model.id == 3)//益跑网华南区「跑赢世界杯」主题夜跑
                            {
                                DownLoadFdf3(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["iRank"].ToString(), ca);
                            }
                            else if (model.id == 4)//2014首届滕州微山湖湿地马拉松赛
                            {
                                DownLoadFdf4(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iRank"].ToString(), ca);
                            }
                            else if (model.id == 6 || model.id == 7 || model.id == 8 || model.id == 18)//2014中国健身名山登山赛--甘肃崆峒山赛区
                            {
                                DownLoadFdf5(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), result);
                            }
                            else if (model.id == 11)//益跑网华南区主办珠海板樟山越野赛
                            {
                                DownLoadFdf6(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["iRank"].ToString(), ca);
                            }
                            else if (model.id == 13)//2014兰陵国际半程马拉松
                            {
                                DownLoadFdf7(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), result);
                            }
                            else if (model.id == 14)//2014英德仙湖山地马拉松
                            {
                                DownLoadFdf8(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["Km"].ToString(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["iRank"].ToString(), ca);
                            }
                            else if (model.id == 15)//2014广东狮子会岭南杯广州大学城环岛长跑挑战赛 统一模版
                            {
                                DownLoadFdf9(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["Km"].ToString(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["iRank"].ToString(), ca);
                            }
                            else if (model.id == 17)//益跑网统一模版-2014凤凰岭北京冬季城市越野赛 
                            {
                                DownLoadFdf10(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["Km"].ToString(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["iRank"].ToString(), ca);
                            }
                            else if (model.id == 20)//贝熙业之旅暨2015北京西山国际越野挑战赛
                            {
                                DownLoadFdf11(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["Km"].ToString(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["iRank"].ToString(), ca);
                                return;
                            }
                            else if (model.id == 22)//2015广州龙洞越野赛
                            {
                                DownLoadFdf12(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["Km"].ToString(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["cBib"].ToString(), result);
                                return;
                            }
                            else if (model.id == 23)//极致酷跑 2015Jeep全地形4X4接力挑战赛
                            {
                                DownLoadFdf13(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["Km"].ToString(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["idCart"].ToString(), ca);
                                return;
                            }
                            else if (model.id == 24)//2015首届滕州微山湖湿地马拉松赛
                            {
                                string NetResult = dt.Rows[0]["cNetResult"].ToString();//净成绩
                                string[] cNetResult = NetResult.Split(':');
                                DownLoadFdf4(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), cNetResult);
                            }
                            else if (model.id == 26)//2015武广印象—NORTHLAND杯绿色环湖跑暨运动摄影大赛
                            {
                                DownLoadFdf14(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["cBib"].ToString(), result);
                            }
                            else if (model.id == 27)//福特完赛证书
                            {
                                DownLoadFdf15(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["cBib"].ToString(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["iRank"].ToString(), dt.Rows[0]["cNetResult"].ToString());
                            }
                            else if (model.id == 29)//2015北京西山山地马拉松
                            {
                                DownLoadFdf29(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), result, dt.Rows[0]["KM"].ToString());
                            }
                            else if (model.id == 31)//2015心愿马拉松
                            {
                                DownLoadFdf31(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), result, dt.Rows[0]["KM"].ToString());
                            }
                            else if (model.id == 33)//烟台市第一届欣和杯金沙滩马拉松赛
                            {
                                DownLoadFdf33(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["cBib"].ToString(), dt.Rows[0]["KM"].ToString(), result);
                            }
                            else if (model.id == 34)//2016北京春季城市越野赛
                            {
                                DownLoadFdf34(model.cModel, FilePath, nameGoup.Trim(), dt.Rows[0]["cGroupName"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["iRank"].ToString(), dt.Rows[0]["KM"].ToString(), ca);
                            }
                            else
                            {
                                AlertHelper.JQAlertGo("该赛事暂无证书！", "RaceQuery.aspx", false);
                                return;
                            }
                        }
                        else
                        {
                            AlertHelper.JQAlertGo("您查询的用户不存在！", "RaceQuery.aspx", false);
                            return;
                        }
                    }
                }
            }
            else
            {
                AlertHelper.JQAlertGo("您查询的用户证书不存在！", "RaceQuery.aspx", false);
                return;
            }
        }
    }
    /// <summary>  
    /// 创建指定目录  
    /// </summary>  
    /// <param name="targetDir"></param>  
    public static void CreateDirectory(string targetDir)
    {
        DirectoryInfo dir = new DirectoryInfo(targetDir);
        if (!dir.Exists)
            dir.Create();
    }
    #region 2016
    //2016北京春季城市越野赛
    private void DownLoadFdf34(string img, string Path, string cName, string cGroup, string iGroupRank, string iRank, string KM, string[] cResult)
    {
        Document document = new Document(PageSize.A4, 10, 10, 10, 10);//左右上下        
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(23.1f);//将图片按%大小显示。         
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_LEFT;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑         
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            //自定义字体
            BaseFont bfChinese = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            BaseColor bfColor = new BaseColor(0, 0, 0);
            Font font = new Font(bfChinese, 16, Font.NORMAL, bfColor);

            column.SetSimpleColumn(new Phrase(cName, font), 400, 100, 190, 520, 16, Element.ALIGN_CENTER);//第三个数控制（小）左（大）右，第四个数字控制上下
            column.Go();

            column.SetSimpleColumn(new Phrase(cGroup, font), 800, 100, 260, 420, 16, Element.ALIGN_LEFT);//第三个数控制（小）左（大）右，第四个数字控制上下
            column.Go();

            column.SetSimpleColumn(new Phrase(KM, font), 800, 100, 260, 397, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();

            column.SetSimpleColumn(new Phrase(iRank, font), 800, 100, 270, 375, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();

            column.SetSimpleColumn(new Phrase(iGroupRank, font), 800, 100, 285, 350, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[0], Font_SimHei), 800, 100, 220, 280, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[1], Font_SimHei), 800, 100, 280, 280, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[2], Font_SimHei), 800, 100, 340, 280, 16, Element.ALIGN_LEFT);
            column.Go();

        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }

        document.Close();
    }
    //2015北京西山山地马拉松
    private void DownLoadFdf33(string img, string Path, string cName, string cGroup, string iGroupRank, string cBio, string KM, string cResult)
    {
        //Document document = new Document(PageSize.A4, 10, 10, 10, 10);//左右上下
        Document document = new Document(PageSize.A4.Rotate(), 10, 10, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            //jpeg.ScalePercent(32.3f, 64.3f);//将图片按%大小显示。
            jpeg.ScalePercent(46f,45f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_LEFT;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑         
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            //自定义字体
            BaseFont bfChinese = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            BaseColor bfColor = new BaseColor(0, 0, 0);
            Font font = new Font(bfChinese, 16, Font.NORMAL, bfColor);

            column.SetSimpleColumn(new Phrase(cName, font), 420, 100, 730, 425, 16, Element.ALIGN_CENTER);//380控制上下
            column.Go();

            column.SetSimpleColumn(new Phrase(cBio, font), 800, 100, 580, 380, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();

            column.SetSimpleColumn(new Phrase(cGroup, font), 800, 100, 550, 335, 16, Element.ALIGN_LEFT);//第三个数控制（小）左（大）右，第四个数字控制上下
            column.Go();

            column.SetSimpleColumn(new Phrase(KM, font), 800, 100, 550, 290, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();

            column.SetSimpleColumn(new Phrase(cResult, font), 800, 100, 550, 247, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();

            column.SetSimpleColumn(new Phrase(iGroupRank, font), 800, 100, 580, 203, 16, Element.ALIGN_LEFT);
            column.Go();
            
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }

        document.Close();
    }
    #endregion        

    #region 2015
    //2015心愿马拉松
    private void DownLoadFdf31(string img, string Path, string cName, string cGroup, string iGroupRank, string cResult, string KM)
    {
        Document document = new Document(PageSize.A4, 10, 10, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(46.3f, 46.8f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_LEFT;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑         
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            //自定义字体
            BaseFont bfChinese = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            BaseColor bfColor = new BaseColor(0, 0, 0);
            Font font = new Font(bfChinese, 16, Font.NORMAL, bfColor);

            column.SetSimpleColumn(new Phrase(cName, font), 500, 100, 200, 410, 16, Element.ALIGN_CENTER);//380控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, font), 600, 100, 330, 338, 16, Element.ALIGN_LEFT);//第三个数控制（小）左（大）右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(iGroupRank, font), 440, 100, 330, 310, 16, Element.ALIGN_LEFT);
            column.Go();
            string[] Result = cResult.Split(':');
            if (Result.Length > 2)
            {
                column.SetSimpleColumn(new Phrase(Result[0], font), 440, 100, 275, 235, 16, Element.ALIGN_LEFT);
                column.Go();
                column.SetSimpleColumn(new Phrase(Result[1], font), 440, 100, 335, 235, 16, Element.ALIGN_LEFT);
                column.Go();
                column.SetSimpleColumn(new Phrase(Result[2], font), 440, 100, 395, 235, 16, Element.ALIGN_LEFT);
                column.Go();
            }
            //column.SetSimpleColumn(new Phrase(cResult, font), 440, 100, 345, 245, 16, Element.ALIGN_LEFT);//时
            //column.Go();
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }

        document.Close();
    }
    //2015北京西山山地马拉松
    private void DownLoadFdf29(string img, string Path, string cName, string cGroup, string iGroupRank, string cResult, string KM)
    {
        Document document = new Document(PageSize.A4, 10, 10, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(46.3f, 46.8f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_LEFT;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑         
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            //自定义字体
            BaseFont bfChinese = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            BaseColor bfColor = new BaseColor(0, 0, 0);
            Font font = new Font(bfChinese, 16, Font.NORMAL, bfColor);

            column.SetSimpleColumn(new Phrase(cName, font), 420, 100, 200, 440, 16, Element.ALIGN_CENTER);//380控制上下
            column.Go();

            //column.SetSimpleColumn(new Phrase(cName, font), 600, 100, 200, 440, 16, Element.ALIGN_LEFT);//380控制上下
            //column.Go();

            column.SetSimpleColumn(new Phrase(KM, font), 600, 100, 255, 345, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, font), 600, 100, 255, 324, 16, Element.ALIGN_LEFT);//第三个数控制（小）左（大）右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(iGroupRank, font), 440, 100, 280, 298, 16, Element.ALIGN_LEFT);
            column.Go();
            string[] Result = cResult.Split(':');
            if (Result.Length > 2)
            {
                column.SetSimpleColumn(new Phrase(Result[0], font), 440, 100, 220, 230, 16, Element.ALIGN_LEFT);
                column.Go();
                column.SetSimpleColumn(new Phrase(Result[1], font), 440, 100, 285, 230, 16, Element.ALIGN_LEFT);
                column.Go();
                column.SetSimpleColumn(new Phrase(Result[2], font), 440, 100, 345, 230, 16, Element.ALIGN_LEFT);
                column.Go();
            }
            //column.SetSimpleColumn(new Phrase(cResult, font), 440, 100, 345, 245, 16, Element.ALIGN_LEFT);//时
            //column.Go();
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }

        document.Close();
    }
    private void DownLoadFdf15(string img, string Path, string cName, string Bio, string cGroup, string iGroupRank, string iRank, string cResult)
    {
        Document document = new Document(PageSize.A4.Rotate(), 0, 0, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(35f, 34.8f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_MIDDLE;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑         
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);

            //自定义字体
            BaseFont bfChinese = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            BaseColor bfColor = new BaseColor(0, 0, 0);
            Font font = new Font(bfChinese, 18, Font.NORMAL, bfColor);

            column.SetSimpleColumn(new Phrase(cName, font), 450, 100, 270, 255, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(Bio, font), 800, 100, 640, 252, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, font), 450, 10, 280, 222, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(iGroupRank + "名", font), 600, 100, 485, 160, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(iRank + "名", font), 600, 100, 485, 190, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult, font), 800, 100, 660, 222, 16, Element.ALIGN_LEFT);
            column.Go();

        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }
        document.Close();
    }
    #endregion
    #region 2014
    //2014福建乡村越野跑-五夫站
    private void DownLoadFdf1(string img, string Path, string cName, string Km, string cGroup, string[] cResult)
    {
        Document document = new Document(PageSize.A4.Rotate(), 0, 0, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(23.2f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_MIDDLE;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            Font Font_SimHei = new Font(BFont_SimHei);
            BaseFont BFont = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            Font Font = new Font(BFont, 20, Font.BOLD, BaseColor.BLUE);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            column.SetSimpleColumn(new Phrase(cName, Font_SimHei), 400, 100, 270, 400, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(Km, Font), 450, 10, 360, 205, 16, Element.ALIGN_LEFT);//380控制上下
            //column.SetSimpleColumn(new Phrase(iRank, Font), 450, 10, 360, 205, 16, Element.ALIGN_LEFT);//380控制上下
            //column.SetSimpleColumn(new Phrase(Km, Font_SimHei), 600, 100, 500, 205, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, Font_SimHei), 600, 100, 500, 205, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[0], Font_SimHei), 450, 100, 360, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[1], Font_SimHei), 500, 100, 430, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[2], Font_SimHei), 600, 100, 490, 150, 16, Element.ALIGN_LEFT);
            column.Go();
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }
        document.Close();
    }
    //益跑华南区主办「广州之巅挑战赛」
    private void DownLoadFdf2(string img, string Path, string cName, string cGroup, string iGroupRank, string iRank, string[] cResult)
    {
        Document document = new Document(PageSize.A4.Rotate(), 0, 0, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(23.2f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_MIDDLE;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            column.SetSimpleColumn(new Phrase(cName, Font_SimHei), 400, 100, 270, 430, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, Font_SimHei), 450, 10, 325, 210, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(iGroupRank, Font_SimHei), 600, 100, 480, 210, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(iRank, Font_SimHei), 700, 100, 610, 210, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[0], Font_SimHei), 450, 100, 340, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[1], Font_SimHei), 500, 100, 410, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[2], Font_SimHei), 600, 100, 480, 150, 16, Element.ALIGN_LEFT);
            column.Go();
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }
        document.Close();
    }
    //益跑网华南区「跑赢世界杯」主题夜跑
    private void DownLoadFdf3(string img, string Path, string cName, string cGroup, string iGroupRank, string iRank, string[] cResult)
    {
        Document document = new Document(PageSize.A4.Rotate(), 0, 0, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(23.2f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_MIDDLE;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            column.SetSimpleColumn(new Phrase(cName, Font_SimHei), 400, 100, 270, 410, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, Font_SimHei), 450, 10, 320, 210, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(iGroupRank, Font_SimHei), 600, 100, 470, 210, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(iRank, Font_SimHei), 700, 100, 600, 210, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[0], Font_SimHei), 450, 100, 340, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[1], Font_SimHei), 500, 100, 410, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[2], Font_SimHei), 600, 100, 480, 150, 16, Element.ALIGN_LEFT);
            column.Go();
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }
        document.Close();
    }
    //滕州证书
    private void DownLoadFdf4(string img, string Path, string cName, string cGroup, string iRank, string[] cResult)
    {
        Document document = new Document(PageSize.A4, 10, 10, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(23.5f, 23.5f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_MIDDLE;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            column.SetSimpleColumn(new Phrase(cName, Font_SimHei), 340, 100, 150, 455, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, Font_SimHei), 300, 100, 150, 375, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(iRank, Font_SimHei), 340, 100, 270, 375, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[0], Font_SimHei), 340, 100, 180, 295, 16, Element.ALIGN_LEFT);//时
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[1], Font_SimHei), 340, 100, 300, 295, 16, Element.ALIGN_LEFT);//分
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[2], Font_SimHei), 440, 200, 420, 295, 16, Element.ALIGN_LEFT);//秒
            column.Go();
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }

        document.Close();
    }
    //2014中国健身名山登山赛
    private void DownLoadFdf5(string img, string Path, string cName, string cGroup, string iRank, string cResult)
    {
        Document document = new Document(PageSize.A4, 10, 10, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(23.5f, 23.5f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_MIDDLE;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            column.SetSimpleColumn(new Phrase(cName, Font_SimHei), 600, 100, 370, 464, 16, Element.ALIGN_LEFT);//第三个数控制（小）左（大）右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, Font_SimHei), 600, 100, 220, 463, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(iRank, Font_SimHei), 440, 100, 230, 420, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult, Font_SimHei), 440, 100, 370, 420, 16, Element.ALIGN_LEFT);//时
            column.Go();
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }

        document.Close();
    }
    //益跑网华南区主办珠海板樟山越野赛
    private void DownLoadFdf6(string img, string Path, string cName, string cGroup, string iGroupRank, string iRank, string[] cResult)
    {
        Document document = new Document(PageSize.A4.Rotate(), 0, 0, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(23.2f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_MIDDLE;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            column.SetSimpleColumn(new Phrase(cName, Font_SimHei), 400, 100, 270, 430, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            //column.SetSimpleColumn(new Phrase(cGroup, Font_SimHei), 450, 100, 325, 222, 16, Element.ALIGN_LEFT);//380控制上下
            column.SetSimpleColumn(new Phrase(cGroup, Font_SimHei), 600, 100, 325, 222, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(iRank, Font_SimHei), 600, 100, 800, 222, 16, Element.ALIGN_LEFT);
            column.Go();
            //column.SetSimpleColumn(new Phrase(iRank, Font_SimHei), 700, 100, 610, 222, 16, Element.ALIGN_LEFT);
            column.SetSimpleColumn(new Phrase(iGroupRank, Font_SimHei), 600, 100, 480, 222, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[0], Font_SimHei), 450, 100, 340, 162, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[1], Font_SimHei), 500, 100, 410, 162, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[2], Font_SimHei), 600, 100, 480, 162, 16, Element.ALIGN_LEFT);
            column.Go();
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }
        document.Close();
    }
    //2014兰陵国际半程马拉松
    private void DownLoadFdf7(string img, string Path, string cName, string cGroup, string iGroupRank, string cResult)
    {
        Document document = new Document(PageSize.A4, 5, 5, 5, 5);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(59f, 62f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_MIDDLE;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            column.SetSimpleColumn(new Phrase(cName, Font_SimHei), 600, 10, 220, 485, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, Font_SimHei), 600, 100, 350, 420, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(iGroupRank, Font_SimHei), 600, 100, 370, 357, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult, Font_SimHei), 600, 100, 180, 357, 16, Element.ALIGN_LEFT);//时
            column.Go();
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }

        document.Close();
    }
    //2014兰陵国际半程马拉松
    private void DownLoadFdf8(string img, string Path, string cName, string KM, string cGroup, string iGroupRank, string iRank, string[] cResult)
    {
        Document document = new Document(PageSize.A4.Rotate(), 0, 0, 8, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(20f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_MIDDLE;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            column.SetSimpleColumn(new Phrase(cName, Font_SimHei), 400, 100, 270, 362, 16, Element.ALIGN_LEFT);//第三个数控制左右(左小右大)，第四个数字控制上下（下小上大）
            column.Go();
            column.SetSimpleColumn(new Phrase(KM, Font_SimHei), 600, 100, 200, 202, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, Font_SimHei), 600, 100, 335, 202, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(iRank, Font_SimHei), 800, 100, 680, 202, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(iGroupRank, Font_SimHei), 600, 100, 550, 202, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[0], Font_SimHei), 450, 100, 360, 137, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[1], Font_SimHei), 500, 100, 430, 137, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[2], Font_SimHei), 600, 100, 500, 137, 16, Element.ALIGN_LEFT);
            column.Go();
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }
        document.Close();
    }
    //华南益跑统一模版-2014广东狮子会岭南杯广州大学城环岛长跑挑战赛 
    private void DownLoadFdf9(string img, string Path, string cName, string KM, string cGroup, string iGroupRank, string iRank, string[] cResult)
    {
        Document document = new Document(PageSize.A4.Rotate(), 0, 0, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(23.2f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_MIDDLE;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑         
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);

            //自定义字体
            BaseFont bfChinese = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            BaseColor bfColor = new BaseColor(241, 89, 42);
            Font font = new Font(bfChinese, 24, Font.BOLD, bfColor);


            column.SetSimpleColumn(new Phrase(cName, font), 400, 100, 270, 400, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(KM, font), 600, 100, 195, 215, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, font), 450, 10, 320, 217, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(iGroupRank, font), 600, 100, 540, 215, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(iRank, font), 700, 100, 600, 210, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[0], font), 450, 100, 340, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[1], font), 500, 100, 410, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[2], font), 600, 100, 480, 150, 16, Element.ALIGN_LEFT);
            column.Go();
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }
        document.Close();
    }
    //益跑网统一模版-2014凤凰岭北京冬季城市越野赛 
    private void DownLoadFdf10(string img, string Path, string cName, string KM, string cGroup, string iGroupRank, string iRank, string[] cResult)
    {
        Document document = new Document(PageSize.A4, 10, 10, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(57.6f, 58f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_LEFT;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑         
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);

            //自定义字体
            BaseFont bfChinese = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            BaseColor bfColor = new BaseColor(0, 0, 0);
            Font font = new Font(bfChinese, 26, Font.BOLD, bfColor);
            Font font1 = new Font(bfChinese, 20, Font.BOLD, bfColor);
            column.SetSimpleColumn(new Phrase(cName, font), 600, 100, 260, 440, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(KM, font), 600, 100, 293, 365, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            //column.SetSimpleColumn(new Phrase(cGroup, font), 450, 10, 320, 217, 16, Element.ALIGN_LEFT);//380控制上下
            //column.Go();
            //column.SetSimpleColumn(new Phrase(iGroupRank, font), 600, 100, 540, 215, 16, Element.ALIGN_LEFT);
            //column.Go();
            //column.SetSimpleColumn(new Phrase(iRank, font), 700, 100, 600, 210, 16, Element.ALIGN_LEFT);
            //column.Go();
            column.SetSimpleColumn(new Phrase(cResult[0], font1), 450, 100, 200, 285, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[1], font1), 500, 100, 300, 285, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[2], font1), 600, 100, 400, 285, 16, Element.ALIGN_LEFT);
            column.Go();
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }
        document.Close();
    }
    //贝熙业之旅暨2015北京西山国际越野挑战赛
    private void DownLoadFdf11(string img, string Path, string cName, string KM, string cGroup, string iGroupRank, string iRank, string[] cResult)
    {
        Document document = new Document(PageSize.A4, 10, 10, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(23.2f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_LEFT;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑         
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);

            //自定义字体
            BaseFont bfChinese = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            BaseColor bfColor = new BaseColor(0, 0, 0);
            Font font = new Font(bfChinese, 26, Font.BOLD, bfColor);
            Font font1 = new Font(bfChinese, 20, Font.BOLD, bfColor);
            column.SetSimpleColumn(new Phrase(cName, font), 400, 100, 250, 405, 16, Element.ALIGN_LEFT);//第三个数控制左(小)右(大)，第四个数字控制上(大)下(小)
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, font1), 600, 100, 320, 305, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            //column.SetSimpleColumn(new Phrase(cGroup, font), 450, 10, 320, 217, 16, Element.ALIGN_LEFT);//380控制上下
            //column.Go();
            column.SetSimpleColumn(new Phrase(iGroupRank, font1), 450, 100, 200, 170, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[0], font1), 450, 100, 220, 260, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[1], font1), 500, 100, 320, 260, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[2], font1), 600, 100, 420, 260, 16, Element.ALIGN_LEFT);
            column.Go();
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }
        document.Close();
    }
    //2015广州龙洞越野赛
    private void DownLoadFdf12(string img, string Path, string cName, string KM, string cGroup, string iGroupRank, string cBib, string cResult)
    {
        Document document = new Document(PageSize.A4, 10, 10, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(57.5f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_LEFT;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑         
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);

            //自定义字体
            BaseFont bfChinese = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            BaseColor bfColor = new BaseColor(255, 255, 255);
            Font font = new Font(bfChinese, 30, Font.BOLD, bfColor);
            Font font1 = new Font(bfChinese, 14, Font.BOLD, bfColor);
            column.SetSimpleColumn(new Phrase(cBib, font), 400, 100, 180, 270, 16, Element.ALIGN_LEFT);//第三个数控制左(小)右(大)，第四个数字控制上(大)下(小)
            column.Go();
            column.SetSimpleColumn(new Phrase(cName, font1), 600, 100, 310, 280, 16, Element.ALIGN_LEFT);//第三个数控制左(小)右(大)，第四个数字控制上(大)下(小)            
            column.Go();
            column.SetSimpleColumn(new Phrase(KM, font1), 450, 100, 270, 205, 16, Element.ALIGN_LEFT);
            column.Go();
            if (cGroup.Contains("全程"))
            {
                column.SetSimpleColumn(new Phrase("2400m", font1), 450, 100, 370, 205, 16, Element.ALIGN_LEFT);
                column.Go();
            }
            else
            {
                column.SetSimpleColumn(new Phrase("1200m", font1), 450, 100, 370, 205, 16, Element.ALIGN_LEFT);
                column.Go();
            }
            column.SetSimpleColumn(new Phrase(cGroup, font1), 600, 100, 310, 185, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(iGroupRank, font1), 600, 100, 310, 165, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();

            column.SetSimpleColumn(new Phrase(cResult, font), 400, 100, 220, 118, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            //column.SetSimpleColumn(new Phrase(cResult, font), 450, 100, 220, 260, 16, Element.ALIGN_LEFT);
            //column.Go();

        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }
        document.Close();
    }
    //极致酷跑 2015Jeep全地形4X4接力挑战赛
    private void DownLoadFdf13(string img, string Path, string cName, string KM, string cGroup, string iGroupRank, string FullName, string[] cResult)
    {
        Document document = new Document(PageSize.A4, 10, 10, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(39.3f, 39.8f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_LEFT;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑         
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);

            //自定义字体
            BaseFont bfChinese = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            BaseColor bfColor = new BaseColor(0, 0, 0);
            Font font = new Font(bfChinese, 24, Font.NORMAL, bfColor);
            Font font1 = new Font(bfChinese, 18, Font.NORMAL, bfColor);
            column.SetSimpleColumn(new Phrase(FullName, font), 800, 100, 170, 505, 16, Element.ALIGN_LEFT);//第三个数控制左(小)右(大)，第四个数字控制上(大)下(小)
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, font), 400, 100, 230, 460, 16, Element.ALIGN_LEFT);
            column.Go();

            column.SetSimpleColumn(new Phrase(iGroupRank, font), 600, 100, 316, 345, 16, Element.ALIGN_LEFT);
            column.Go();
            //column.SetSimpleColumn(new Phrase(cName, font1), 600, 100, 310, 280, 16, Element.ALIGN_LEFT);//第三个数控制左(小)右(大)，第四个数字控制上(大)下(小)            
            //column.Go();

            column.SetSimpleColumn(new Phrase(cResult[0], font1), 450, 100, 242, 415, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[1], font1), 500, 100, 311, 415, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult[2], font1), 600, 100, 358, 415, 16, Element.ALIGN_LEFT);
            column.Go();

        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }
        document.Close();
    }

    //2015武广印象—NORTHLAND杯绿色环湖跑暨运动摄影大赛
    private void DownLoadFdf14(string img, string Path, string cName, string cGroup, string cBib, string cResult)
    {
        Document document = new Document(PageSize.A4, 10, 10, 10, 10);//左右上下
        MemoryStream ms = new MemoryStream();
        try
        {
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath(Path), FileMode.Create));
            document.Open();
            iTextSharp.text.Image jpeg = iTextSharp.text.Image.GetInstance(Server.MapPath(img));
            jpeg.ScalePercent(46.3f, 46.8f);//将图片按%大小显示。
            jpeg.Alignment = iTextSharp.text.Image.ALIGN_LEFT;//设置图片的对其方式。
            document.Add(jpeg);
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑         
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            //自定义字体
            BaseFont bfChinese = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            BaseColor bfColor = new BaseColor(0, 0, 0);
            Font font = new Font(bfChinese, 18, Font.NORMAL, bfColor);

            column.SetSimpleColumn(new Phrase(cName, font), 600, 100, 200, 324, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, font), 600, 100, 345, 324, 16, Element.ALIGN_LEFT);//第三个数控制（小）左（大）右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(cBib, font), 440, 100, 200, 245, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cResult, font), 440, 100, 345, 245, 16, Element.ALIGN_LEFT);//时
            column.Go();
        }
        catch (Exception ex)
        {
            document.Close();
            AlertHelper.JQAlertGo("证书生成失败！", "RaceResult.aspx?id=" + id + "&n=" + name + "&p=" + vers + "&t=" + itype + "", false);
            return;
        }

        document.Close();
    }


    // <summary>
    /// 中文转unicode
    /// </summary>
    /// <returns></returns>
    public static string unicode_0(string str)
    {
        string outStr = "";
        if (!string.IsNullOrEmpty(str))
        {
            for (int i = 0; i < str.Length; i++)
            {
                outStr += "/u" + ((int)str[i]).ToString("x");
            }
        }
        return outStr;
    }
    /// <summary>
    /// unicode转中文
    /// </summary>
    /// <returns></returns>
    public static string unicode_1(string str)
    {
        string outStr = "";
        if (!string.IsNullOrEmpty(str))
        {
            string[] strlist = str.Replace("/", "").Split('u');
            try
            {
                for (int i = 1; i < strlist.Length; i++)
                {
                    //将unicode字符转为10进制整数，然后转为char中文字符  
                    outStr += (char)int.Parse(strlist[i], System.Globalization.NumberStyles.HexNumber);
                }
            }
            catch (FormatException ex)
            {
                outStr = ex.Message;
            }
        }
        return outStr;

    }
    #endregion
}