<%@ WebHandler Language="C#" Class="Crop" %>

using System;
using System.Collections.Generic;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Web;
using SD = System.Drawing;

public class Crop : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string img = context.Server.MapPath(context.Request.Form["filepath"]);
        int w = Convert.ToInt32(context.Request.Form["w"]);
        int h = Convert.ToInt32(context.Request.Form["h"]);
        int x = Convert.ToInt32(context.Request.Form["x"]);
        int y = Convert.ToInt32(context.Request.Form["y"]);
        byte[] CropImage = CropImg(img, w, h, x, y);
        //using (MemoryStream ms = new MemoryStream(CropImage, 0, CropImage.Length))
        //{
        //    ms.Write(CropImage, 0, CropImage.Length);
        //    using (SD.Image CroppedImage = SD.Image.FromStream(ms, true))
        //    {
        //        string saveTo = string.Format("images/crop/{0}.jpg", Guid.NewGuid().ToString().Replace("-", ""));
        //        CroppedImage.Save(context.Server.MapPath(saveTo), CroppedImage.RawFormat);
        //        context.Response.Write(saveTo);
        //    }
        //}



        String pathbase = DateTime.Now.ToString("yyyy-MM-dd") + "/";
        string filename = System.Guid.NewGuid() + ".jpg";
        //SaveFile.FileSaveAsSoapClient picWebService = new SaveFile.FileSaveAsSoapClient();
        FileSaveAs picWebService = new FileSaveAs();
        bool flag = picWebService.UploadFile(CropImage, pathbase, filename);
        string URL = pathbase + filename;
        context.Response.Write(URL);

    }
    static byte[] CropImg(string img, int width, int height, int x, int y)
    {
        try
        {
            using (SD.Image OriginalImage = SD.Image.FromFile(img))
            {
                using (SD.Bitmap bmp = new SD.Bitmap(width, height))
                {
                    bmp.SetResolution(OriginalImage.HorizontalResolution, OriginalImage.VerticalResolution);
                    using (SD.Graphics graphic = SD.Graphics.FromImage(bmp))
                    {
                        graphic.SmoothingMode = SmoothingMode.AntiAlias;
                        graphic.InterpolationMode = InterpolationMode.HighQualityBicubic;
                        graphic.PixelOffsetMode = PixelOffsetMode.HighQuality;
                        graphic.DrawImage(OriginalImage, new SD.Rectangle(0, 0, width, height), x, y, width, height, SD.GraphicsUnit.Pixel);
                        MemoryStream ms = new MemoryStream();
                        bmp.Save(ms, OriginalImage.RawFormat);
                        return ms.GetBuffer();
                    }
                }
            }
        }
        catch (Exception Ex)
        {
            throw (Ex);
        }
    }
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}