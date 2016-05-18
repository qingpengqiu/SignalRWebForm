using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using iTextSharp;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
using Utils;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using System.Collections.Generic;
using System.Xml.Linq;
public partial class Channels_Competetion_RacePrint : System.Web.UI.Page
{
    private int idRace = 0;
    private string name = string.Empty;
    private string idcard = string.Empty;

    public string FilePath = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["opt"], 0);
        name = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(Request.QueryString["name"]), "");
        idcard = TypeChangeDefault.NullToString(Request.QueryString["idcard"], "");
        Dictionary<string, string> dict = GetRacePath(idRace);
        if (idRace == 0)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "/Channels/Competetion/RaceQuery.aspx", false);
            return;
        }
        if (name.Trim().Length == 0)
        {
            AlertHelper.JQAlertGo("请填写名称！", "/Channels/Competetion/RaceQuery.aspx", false);
            return;
        }
        if (idcard.Trim().Length == 0)
        {
            AlertHelper.JQAlertGo("请填写证件号码！", "/Channels/Competetion/RaceQuery.aspx", false);
            return;
        }
        if (!IsPostBack)
        {
            DataTable dt = new DB4.tblRaceResult().GetResult(idRace.ToString(), name.Trim(), idcard.Trim()).Tables[0];
            if (dt.Rows.Count > 0)
            {
                string result = dt.Rows[0]["cResult"].ToString();
                if (result.Trim().Length == 0)
                {
                    AlertHelper.JQAlertGo("您的成绩不存在！", "/Channels/Competetion/RaceQuery.aspx", false);
                    return;
                }
                else
                {
                    FilePath = dict.FirstOrDefault(d => d.Key == idRace.ToString()).Value + dt.Rows[0]["cBib"].ToString() + ".pdf";
                    string img = dict.FirstOrDefault(d => d.Key == idRace.ToString()).Value + idRace.ToString() + ".jpg";

                    //测试数据
                    ////FilePath = "../Competetion/zs/2014/gzrdyys/" + dt.Rows[0]["cBib"].ToString() + ".pdf";
                    ////string img = "../Competetion/zs/2014/gzrdyys/300000454.jpg";
                    //string[] ca = result.Split(':');
                    //if (ca.Length > 2)
                    //{
                    //    YPDownLoadFdf(img, FilePath, "张广星张广星", dt.Rows[0]["cGroup"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["iRank"].ToString(), ca[0], ca[1], ca[2]);
                    //}

                    ////判断文件是否存在
                    if (!File.Exists(Server.MapPath(FilePath)))
                    {
                        string[] ca = result.Split(':');
                        if (ca.Length > 2)
                        {
                            if (idRace == 300000459) //滕州证书
                                tzDownLoadFdf(img, FilePath, name.Trim(), dt.Rows[0]["cGroup"].ToString(), dt.Rows[0]["iRank"].ToString(), ca[0], ca[1], ca[2]);
                            else if (idRace == 300000454 || idRace == 300000465) //「益跑网华南区」主办「广州龙洞越野赛」和「益跑网华南区」主办「广州首届接力马拉松」
                                DownLoadFdf(img, FilePath, name.Trim(), dt.Rows[0]["cGroup"].ToString(), dt.Rows[0]["iRank"].ToString(), ca[0], ca[1], ca[2]);
                            else if (idRace == 300000434)//广州大学城<环湖10K挑战赛>
                                hh10kDownLoadFdf(img, FilePath, name.Trim(), dt.Rows[0]["cGroup"].ToString(), dt.Rows[0]["iRank"].ToString(), ca[0], ca[1], ca[2]);
                            else if (idRace == 300000485)//益跑网华南区「跑赢世界杯」主题夜跑
                            {
                                if (dt.Rows[0]["cGroup"].ToString() == "接力组")
                                {
                                    DataTable dtGoup = new DB4.tblRaceResult().GetList("idRace=" + idRace + " and cBib='" + dt.Rows[0]["cBib"].ToString() + "'").Tables[0];
                                    if (dtGoup.Rows.Count > 0)
                                    {
                                        string nameGoup = string.Empty;
                                        for (int i = 0; i < dtGoup.Rows.Count; i++)
                                        {
                                            nameGoup += dtGoup.Rows[i]["cName"].ToString() + " ";
                                        }
                                        YPDownLoadFdf(img, FilePath, nameGoup.Trim(), dt.Rows[0]["cGroup"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["iRank"].ToString(), ca[0], ca[1], ca[2]);
                                    }
                                    else
                                    {
                                        AlertHelper.JQAlertGo("您查询的接力组不存在！", "/Channels/Competetion/RaceQuery.aspx", false);
                                        return;
                                    }     
                                }
                                else
                                {
                                    YPDownLoadFdf(img, FilePath, name.Trim(), dt.Rows[0]["cGroup"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), dt.Rows[0]["iRank"].ToString(), ca[0], ca[1], ca[2]);
                                }
                            }
                            else if (idRace == 300000490)//2014福建乡村越野跑-五夫站
                                wj2014DownLoadFdf(img, FilePath, name.Trim(), dt.Rows[0]["cGroup"].ToString(), dt.Rows[0]["cGroupName"].ToString(), ca[0], ca[1], ca[2]);
                            else if (idRace == 300000491) //益跑华南区主办「广州之巅挑战赛」
                                gzzd2014DownLoadFdf(img, FilePath, name.Trim(), dt.Rows[0]["cGroup"].ToString(), dt.Rows[0]["iRank"].ToString(), dt.Rows[0]["iGroupRank"].ToString(), ca[0], ca[1], ca[2]);
                        }
                    }
                }
            }
            else
            {
                AlertHelper.JQAlertGo("您查询的用户不存在！", "/Channels/Competetion/RaceQuery.aspx", false);
                return;
            }
        }

    }
    //益跑华南区主办「广州之巅挑战赛」
    private void gzzd2014DownLoadFdf(string img, string Path, string cName, string cGroup, string iRank,string iGroupRank, string HH, string MM, string SS)
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
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("../Competetion/zs/msyh.ttc,0");
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
            column.SetSimpleColumn(new Phrase(HH, Font_SimHei), 450, 100, 340, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(MM, Font_SimHei), 500, 100, 410, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(SS, Font_SimHei), 600, 100, 480, 150, 16, Element.ALIGN_LEFT);
            column.Go();
        }
        catch (DocumentException de)
        {
            //Response.Write(de.Message);
        }
        catch (IOException ioe)
        {
            //Response.Write(ioe.Message);
        }

        // step 5: we close the document
        document.Close();
    }
    //2014福建乡村越野跑-五夫站
    private void wj2014DownLoadFdf(string img, string Path, string cName, string cGroup, string iRank, string HH, string MM, string SS)
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
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("../Competetion/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            Font Font_SimHei = new Font(BFont_SimHei);
            BaseFont BFont = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            Font Font = new Font(BFont,20,Font.BOLD, BaseColor.BLUE);
            //Font.Color = BaseColor.BLUE;
            //Font.BOLD = 20;

            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            column.SetSimpleColumn(new Phrase(cName, Font_SimHei), 400, 100, 270, 400, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(iRank, Font), 450, 10, 360, 205, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, Font_SimHei), 600, 100, 500, 205, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(HH, Font_SimHei), 450, 100, 360, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(MM, Font_SimHei), 500, 100, 430, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(SS, Font_SimHei), 600, 100, 490, 150, 16, Element.ALIGN_LEFT);
            column.Go();
        }
        catch (DocumentException de)
        {
            //Response.Write(de.Message);
        }
        catch (IOException ioe)
        {
            //Response.Write(ioe.Message);
        }

        // step 5: we close the document
        document.Close();
    }
    /// <summary>
    /// 获取赛事证书路径
    public static Dictionary<string, string> GetRacePath(int idRace)
    {
        string CacheKey = "GetRacePath";
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        objModel = null;
        if (objModel == null)
        {
            try
            {
                Dictionary<string, string> version = new Dictionary<string, string>();
                string xmlPath = HttpContext.Current.Server.MapPath("/XML/RaceConfig.xml");
                XDocument doc = XDocument.Load(xmlPath);
                var language = "Path";
                var tipList = doc.Descendants("text");
                foreach (var item in tipList)
                {
                    version.Add(item.Element("id").Value, HTMLHelper.ZipHtml(item.Element(language).Value));
                }
                objModel = version;
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch { }
        }
        return (Dictionary<string, string>)objModel;
    }
    //益跑网华南区「跑赢世界杯」主题夜跑
    private void YPDownLoadFdf(string img, string Path, string cName, string cGroup, string iGroupRank,string iRank, string HH, string MM, string SS)
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
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("../Competetion/zs/msyh.ttc,0");
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
            column.SetSimpleColumn(new Phrase(HH, Font_SimHei), 450, 100, 340, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(MM, Font_SimHei), 500, 100, 410, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(SS, Font_SimHei), 600, 100, 480, 150, 16, Element.ALIGN_LEFT);
            column.Go();
        }
        catch (DocumentException de)
        {
            //Response.Write(de.Message);
        }
        catch (IOException ioe)
        {
            //Response.Write(ioe.Message);
        }

        // step 5: we close the document
        document.Close();
    }
    //「益跑网华南区」主办「广州龙洞越野赛」和「益跑网华南区」主办「广州首届接力马拉松」
    private void DownLoadFdf(string img, string Path, string cName, string cGroup, string iRank, string HH, string MM, string SS)
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
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("../Competetion/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            column.SetSimpleColumn(new Phrase(cName, Font_SimHei), 400, 100, 270, 410, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, Font_SimHei), 450, 10, 350, 210, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(iRank, Font_SimHei), 600, 100, 500, 210, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(HH, Font_SimHei), 450, 100, 360, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(MM, Font_SimHei), 500, 100, 430, 150, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(SS, Font_SimHei), 600, 100, 500, 150, 16, Element.ALIGN_LEFT);
            column.Go();
        }
        catch (DocumentException de)
        {
            //Response.Write(de.Message);
        }
        catch (IOException ioe)
        {
            //Response.Write(ioe.Message);
        }

        // step 5: we close the document
        document.Close();
    }
    //广州大学城<环湖10K挑战赛>
    private void hh10kDownLoadFdf(string img, string Path, string cName, string cGroup, string iRank, string HH, string MM, string SS)
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
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("../Competetion/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            column.SetSimpleColumn(new Phrase(cName, Font_SimHei), 400, 100, 270, 410, 16, Element.ALIGN_LEFT);//第三个数控制左右，第四个数字控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, Font_SimHei), 450, 10, 370, 220, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();
            //column.SetSimpleColumn(new Phrase(iRank, Font_SimHei), 340, 100, 270, 375, 16, Element.ALIGN_LEFT);
            //column.Go();
            column.SetSimpleColumn(new Phrase(HH, Font_SimHei), 450, 100, 360, 170, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(MM, Font_SimHei), 500, 100, 440, 170, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(SS, Font_SimHei), 600, 100, 500, 170, 16, Element.ALIGN_LEFT);
            column.Go();
        }
        catch (DocumentException de)
        {
            //Response.Write(de.Message);
        }
        catch (IOException ioe)
        {
            //Response.Write(ioe.Message);
        }

        // step 5: we close the document
        document.Close();
    }
    //滕州证书
    private void tzDownLoadFdf(string img, string Path, string cName, string cGroup, string iRank, string HH, string MM, string SS)
    {
        //Document document = new Document(PageSize.A4, 0, 0, 0, 0);//左右上下
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
            string ServerPathsong = System.Web.HttpContext.Current.Server.MapPath("../Competetion/zs/msyh.ttc,0");
            BaseFont BFont_SimHei = BaseFont.CreateFont(ServerPathsong, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); //微软雅黑
            Font Font_SimHei = new Font(BFont_SimHei);
            PdfContentByte CByte_Up = writer.DirectContent;
            ColumnText column = new ColumnText(CByte_Up);
            column.SetSimpleColumn(new Phrase(cName, Font_SimHei), 340, 100, 150, 455, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(cGroup, Font_SimHei), 300, 100, 150, 375, 16, Element.ALIGN_LEFT);//380控制上下
            column.Go();
            column.SetSimpleColumn(new Phrase(iRank, Font_SimHei), 340, 100, 270, 375, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(HH, Font_SimHei), 340, 100, 180, 295, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(MM, Font_SimHei), 340, 100, 300, 295, 16, Element.ALIGN_LEFT);
            column.Go();
            column.SetSimpleColumn(new Phrase(SS, Font_SimHei), 440, 200, 420, 295, 16, Element.ALIGN_LEFT);
            column.Go();
        }
        catch (DocumentException de)
        {
            //Response.Write(de.Message);
        }
        catch (IOException ioe)
        {
            //Response.Write(ioe.Message);
        }

        // step 5: we close the document
        document.Close();
    }
}