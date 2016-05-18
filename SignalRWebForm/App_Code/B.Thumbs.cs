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
/// ��������ͼ�� Thumbs ��ժҪ˵��   
/// </summary>   
public class Thumbs
{
    public Color tBackground;
    public Color tBorder;
    public Color tShadow;
    public int tQuality;
    public string markPosition;

    /// <summary>   
    /// ͼƬ����Ԥ����   
    /// </summary>   
    static Hashtable htmimes = new Hashtable();
    internal readonly string AllowExt = ".jpe|.jpeg|.jpg|.png|.tif|.tiff|.bmp|.gif";

    public Thumbs()
    {
        tBackground = Color.White; //Color.Transparent;
        tBorder = Color.LightGray; // Color.Transparent;
        tShadow = Color.Transparent;
        tQuality = 100;
        markPosition = "���½�";
        #region ͼƬ����Ԥ����
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

    #region C#�Զ���������ͼ

    /// <summary>   
    /// ����������ȷ����ɫ   
    /// </summary>   
    /// <param name="name"></param>   
    /// <returns></returns>   
    private Color ToColor(string name)
    {
        if (name == "��ɫ") return Color.White;
        if (name == "��ɫ") return Color.Red;
        if (name == "��ɫ") return Color.Blue;
        if (name == "��ɫ") return Color.Green;
        if (name == "��ɫ") return Color.Black;
        if (name == "��ɫ") return Color.DarkGray;
        if (name == "��ɫ") return Color.Yellow;
        if (name == "��ɫ") return Color.Cyan;
        if (name == "��ɫ") return Color.Transparent;
        return Color.Transparent;
    }

    /// <summary>   
    /// ���������ø�����ɫ��������������:)   
    /// </summary>   
    /// <param name="name"></param>   
    /// <returns></returns>   
    private int ToQuality(string name)
    {
        return Int32.Parse(name.Replace("%", ""));
    }

    /// <summary>    
    /// ��ȡͼ���������������������Ϣ    
    /// </summary>    
    /// <param name="mimeType">��������������Ķ���;�����ʼ�����Э�� (MIME) ���͵��ַ���</param>    
    /// <returns>����ͼ���������������������Ϣ</returns>    
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
    /// �����չ������Ч��    
    /// </summary>    
    /// <param name="sExt">�ļ�����չ��</param>    
    /// <returns>�����չ����Ч,����true,���򷵻�false.</returns>    
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
    /// ����ͼƬ    
    /// </summary>    
    /// <param name="image">Image ����</param>    
    /// <param name="savePath">����·��</param>    
    /// <param name="ici">ָ����ʽ�ı�������</param>    
    private void SaveImage(System.Drawing.Image image, string savePath, ImageCodecInfo ici)
    {
        //���� ԭͼƬ ����� EncoderParameters ����    
        EncoderParameters parameters = new EncoderParameters(1);
        parameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, ((long)tQuality));
        image.Save(savePath, ici, parameters);
        parameters.Dispose();
    }

    /// <summary>    
    /// ��������ͼ    
    /// </summary>    
    /// <param name="sourceImagePath">ԭͼƬ·��(���·��)</param>    
    /// <param name="thumbnailImagePath">���ɵ�����ͼ·��,���Ϊ���򱣴�ΪԭͼƬ·��(���·��)</param>    
    /// <param name="thumbnailImageWidth">����ͼ�Ŀ�ȣ��߶��밴ԴͼƬ�����Զ����ɣ�</param>    
    public void ToThumbnail(string sourceImagePath, string thumbnailImagePath, int thumbnailImageWidth, int thumbnailImageHeight)
    {
        // 1.�ȼ��ͼƬ��ʽ����Ϣ   
        string ThumbnailImagePath = thumbnailImagePath;
        string SourceImagePath = sourceImagePath;
        string sExt = SourceImagePath.Substring(SourceImagePath.LastIndexOf(".")).ToLower();
        if (SourceImagePath.ToString() == System.String.Empty)
        {
            throw new NullReferenceException("SourceImagePath is null!");
        }
        if (!CheckValidExt(sExt))
        {
            throw new ArgumentException("ԭͼƬ�ļ���ʽ����ȷ,֧�ֵĸ�ʽ��[ " + AllowExt + " ]", "SourceImagePath");
        }
        // ��ԭͼƬ���� Image ����    
        System.Drawing.Image image = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath(SourceImagePath));
        // 2.����ͼƬ��λ�á��ߴ����Ϣ   
        int tWidth, tHeight, tLeft, tTop;
        double fScale = (double)thumbnailImageHeight / (double)thumbnailImageWidth; // �߶ȿ�ȱ�   
        if (((double)image.Width * fScale) > (double)image.Height) // ���ԭͼ�ȽϿ�   
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
        //��ָ���Ĵ�С�͸�ʽ��ʼ�� Bitmap �����ʵ��    
        //Bitmap bitmap = new Bitmap(ThumbnailImageWidth, num, PixelFormat.Format32bppArgb);   
        Bitmap bitmap = new Bitmap(thumbnailImageWidth, thumbnailImageHeight, PixelFormat.Format32bppArgb);
        //��ָ���� Image ���󴴽��� Graphics ����    
        Graphics graphics = Graphics.FromImage(bitmap);
        //���������ͼ�沢��͸������ɫ���   
        if (tBackground != Color.Transparent)
        {
            graphics.Clear(tBackground);
        }
        else
        {
            graphics.Clear(Color.Transparent);
        }
        // �����Ӱ   
        if (tShadow != Color.Transparent)
        {
            Pen shPen = new Pen(tShadow);
            graphics.DrawLine(shPen, new Point(1, thumbnailImageHeight - 1), new Point(thumbnailImageWidth - 1, thumbnailImageHeight - 1));
            graphics.DrawLine(shPen, new Point(thumbnailImageWidth - 1, 1), new Point(thumbnailImageWidth - 1, thumbnailImageHeight - 1));
        }
        // ��ӱ߿�   
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
        //��ָ��λ�ò��Ұ�ָ����С���� ԭͼƬ ����    
        graphics.DrawImage(image, new Rectangle(tLeft, tTop, tWidth, tHeight));
        image.Dispose();
        try
        {
            //���� ԭͼƬ ��ָ����ʽ����ָ���ı����������浽ָ���ļ�    
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
