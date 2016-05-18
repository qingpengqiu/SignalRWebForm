using System;   
using System.Data;   
using System.Data.SqlClient;   
using System.Configuration;   
using System.Web;   
using System.Web.Security;   
using System.Web.UI;   
using System.Web.UI.WebControls;   
using System.Web.UI.WebControls.WebParts;   
using System.Web.UI.HtmlControls;   
using System.Text;   
using System.Text.RegularExpressions;   
using System.Drawing;   
using System.Drawing.Imaging;   
using System.Collections;   
using System.ComponentModel;

/// <summary>   
/// 制作缩略图类 Thumbs 的摘要说明   
/// </summary>   
public class Thumbs
{
    public Color tBackground;
    public Color tBorder;
    public Color tShadow;
    public int tQuality;
    public string markPosition;

    /// <summary>   
    /// 图片参数预定义   
    /// </summary>   
    static Hashtable htmimes = new Hashtable();
    internal readonly string AllowExt = ".jpe|.jpeg|.jpg|.png|.tif|.tiff|.bmp|.gif";

    public Thumbs()
    {
        tBackground = Color.White; //Color.Transparent;
        tBorder = Color.LightGray; // Color.Transparent;
        tShadow = Color.Transparent;
        tQuality = 100;
        markPosition = "左下角";
        #region 图片类型预定义
        htmimes[".jpe"] = "image/jpeg";
        htmimes[".jpeg"] = "image/jpeg";
        htmimes[".jpg"] = "image/jpeg";
        htmimes[".png"] = "image/png";
        htmimes[".tif"] = "image/tiff";
        htmimes[".tiff"] = "image/tiff";
        htmimes[".bmp"] = "image/bmp";
        htmimes[".gif"] = "image/gif";
        #endregion
    }

    #region C#自动生成缩略图

    /// <summary>   
    /// 按给定名字确定颜色   
    /// </summary>   
    /// <param name="name"></param>   
    /// <returns></returns>   
    private Color ToColor(string name)
    {
        if (name == "白色") return Color.White;
        if (name == "红色") return Color.Red;
        if (name == "蓝色") return Color.Blue;
        if (name == "绿色") return Color.Green;
        if (name == "黑色") return Color.Black;
        if (name == "灰色") return Color.DarkGray;
        if (name == "黄色") return Color.Yellow;
        if (name == "紫色") return Color.Cyan;
        if (name == "无色") return Color.Transparent;
        return Color.Transparent;
    }

    /// <summary>   
    /// 按名字设置各种颜色，可以自行扩充:)   
    /// </summary>   
    /// <param name="name"></param>   
    /// <returns></returns>   
    private int ToQuality(string name)
    {
        return Int32.Parse(name.Replace("%", ""));
    }

    /// <summary>    
    /// 获取图像编码解码器的所有相关信息    
    /// </summary>    
    /// <param name="mimeType">包含编码解码器的多用途网际邮件扩充协议 (MIME) 类型的字符串</param>    
    /// <returns>返回图像编码解码器的所有相关信息</returns>    
    private static ImageCodecInfo GetCodecInfo(string mimeType)
    {
        ImageCodecInfo[] CodecInfo = ImageCodecInfo.GetImageEncoders();
        foreach (ImageCodecInfo ici in CodecInfo)
        {
            if (ici.MimeType == mimeType) return ici;
        }
        return null;
    }

    /// <summary>    
    /// 检测扩展名的有效性    
    /// </summary>    
    /// <param name="sExt">文件名扩展名</param>    
    /// <returns>如果扩展名有效,返回true,否则返回false.</returns>    
    private bool CheckValidExt(string sExt)
    {
        bool flag = false;
        string[] aExt = AllowExt.Split('|');
        foreach (string filetype in aExt)
        {
            if (filetype.ToLower() == sExt)
            {
                flag = true;
                break;
            }
        }
        return flag;
    }

    /// <summary>    
    /// 保存图片    
    /// </summary>    
    /// <param name="image">Image 对象</param>    
    /// <param name="savePath">保存路径</param>    
    /// <param name="ici">指定格式的编解码参数</param>    
    private void SaveImage(System.Drawing.Image image, string savePath, ImageCodecInfo ici)
    {
        //设置 原图片 对象的 EncoderParameters 对象    
        EncoderParameters parameters = new EncoderParameters(1);
        parameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, ((long)tQuality));
        image.Save(savePath, ici, parameters);
        parameters.Dispose();
    }

    /// <summary>    
    /// 生成缩略图    
    /// </summary>    
    /// <param name="sourceImagePath">原图片路径(相对路径)</param>    
    /// <param name="thumbnailImagePath">生成的缩略图路径,如果为空则保存为原图片路径(相对路径)</param>    
    /// <param name="thumbnailImageWidth">缩略图的宽度（高度与按源图片比例自动生成）</param>    
    public void ToThumbnail(string sourceImagePath, string thumbnailImagePath, int thumbnailImageWidth, int thumbnailImageHeight)
    {
        // 1.先检查图片格式等信息   
        string ThumbnailImagePath = thumbnailImagePath;
        string SourceImagePath = sourceImagePath;
        string sExt = SourceImagePath.Substring(SourceImagePath.LastIndexOf(".")).ToLower();
        if (SourceImagePath.ToString() == System.String.Empty)
        {
            throw new NullReferenceException("SourceImagePath is null!");
        }
        if (!CheckValidExt(sExt))
        {
            throw new ArgumentException("原图片文件格式不正确,支持的格式有[ " + AllowExt + " ]", "SourceImagePath");
        }
        // 从原图片创建 Image 对象    
        System.Drawing.Image image = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath(SourceImagePath));
        // 2.计算图片的位置、尺寸等信息   
        int tWidth, tHeight, tLeft, tTop;
        double fScale = (double)thumbnailImageHeight / (double)thumbnailImageWidth; // 高度宽度比   
        if (((double)image.Width * fScale) > (double)image.Height) // 如果原图比较宽   
        {
            tWidth = thumbnailImageWidth;
            tHeight = (int)((double)image.Height * (double)tWidth / (double)image.Width);
            tLeft = 0;
            tTop = (thumbnailImageHeight - tHeight) / 2;
        }
        else
        {
            tHeight = thumbnailImageHeight;
            tWidth = (int)((double)image.Width * (double)tHeight / (double)image.Height);
            tLeft = (thumbnailImageWidth - tWidth) / 2;
            tTop = 0;
        }
        if (tLeft < 0) tLeft = 0;
        if (tTop < 0) tTop = 0;
        if (tBorder != Color.Transparent)
        {
            tWidth -= 2;
            tHeight -= 2;
            tLeft++;
            tTop++;
        }
        if (tShadow != Color.Transparent)
        {
            tWidth -= 1;
            tHeight -= 1;
        }
        //用指定的大小和格式初始化 Bitmap 类的新实例    
        //Bitmap bitmap = new Bitmap(ThumbnailImageWidth, num, PixelFormat.Format32bppArgb);   
        Bitmap bitmap = new Bitmap(thumbnailImageWidth, thumbnailImageHeight, PixelFormat.Format32bppArgb);
        //从指定的 Image 对象创建新 Graphics 对象    
        Graphics graphics = Graphics.FromImage(bitmap);
        //清除整个绘图面并以透明背景色填充   
        if (tBackground != Color.Transparent)
        {
            graphics.Clear(tBackground);
        }
        else
        {
            graphics.Clear(Color.Transparent);
        }
        // 添加阴影   
        if (tShadow != Color.Transparent)
        {
            Pen shPen = new Pen(tShadow);
            graphics.DrawLine(shPen, new Point(1, thumbnailImageHeight - 1), new Point(thumbnailImageWidth - 1, thumbnailImageHeight - 1));
            graphics.DrawLine(shPen, new Point(thumbnailImageWidth - 1, 1), new Point(thumbnailImageWidth - 1, thumbnailImageHeight - 1));
        }
        // 添加边框   
        if (tBorder != Color.Transparent)
        {
            Pen bdPen = new Pen(tBorder);
            if (tShadow != Color.Transparent)
            {
                graphics.DrawRectangle(bdPen, new Rectangle(0, 0, thumbnailImageWidth - 2, thumbnailImageHeight - 2));
            }
            else
            {
                graphics.DrawRectangle(bdPen, new Rectangle(0, 0, thumbnailImageWidth - 1, thumbnailImageHeight - 1));
            }
        }
        //在指定位置并且按指定大小绘制 原图片 对象    
        graphics.DrawImage(image, new Rectangle(tLeft, tTop, tWidth, tHeight));
        image.Dispose();
        try
        {
            //将此 原图片 以指定格式并用指定的编解码参数保存到指定文件    
            string savepath = (ThumbnailImagePath == null ? SourceImagePath : ThumbnailImagePath);
            SaveImage(bitmap, HttpContext.Current.Server.MapPath(savepath), GetCodecInfo((string)htmimes[sExt]));
        }
        catch (System.Exception e)
        {
            throw e;
        }
        finally
        {
            bitmap.Dispose();
            graphics.Dispose();
        }
    }
    #endregion
}
