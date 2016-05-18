using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ThoughtWorks.QRCode.Codec;

public partial class Competetion_payment_QRcode : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //weixin://wxpay/bizpayurl?pr=mXBnlZJ
        string parm = TypeChangeDefault.NullToString(Request.QueryString["parm"], "");
        if (parm.Trim().Length != 0)
        {
            CreateImageOnPage(parm, this.Context);        // 输出图片
        }
    }
    /// <summary>
    /// 生成二维码，如果有Logo，则在二维码中添加Logo
    /// </summary>
    /// <param name="content"></param>
    /// <returns></returns>
    public Bitmap CreateQRCode(string content)
    {
        QRCodeEncoder qrEncoder = new QRCodeEncoder();
        qrEncoder.QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.BYTE;
        qrEncoder.QRCodeScale = 6;//Convert.ToInt32(txtSize.Text);
        qrEncoder.QRCodeVersion = 7;//Convert.ToInt32(cboVersion.SelectedValue);
        qrEncoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.M;
        try
        {
            Bitmap qrcode = qrEncoder.Encode(content, Encoding.UTF8);
            Graphics g = Graphics.FromImage(qrcode);
            Bitmap bitmapLogo = new Bitmap(Server.MapPath("/Competetion/payment/logo108.png"));
            int logoSize = 30;//Convert.ToInt32(txtLogoSize.Text);
            bitmapLogo = new Bitmap(bitmapLogo, new System.Drawing.Size(logoSize, logoSize));
            PointF point = new PointF(qrcode.Width / 2 - logoSize / 2, qrcode.Height / 2 - logoSize / 2);
            g.DrawImage(bitmapLogo, point);
            return qrcode;
        }
        catch (IndexOutOfRangeException ex)
        {
            //MessageBox.Show("超出当前二维码版本的容量上限，请选择更高的二维码版本！", "系统提示");
            return new Bitmap(100, 100);
        }
        catch (Exception ex)
        {
            //MessageBox.Show("生成二维码出错！", "系统提示");
            return new Bitmap(100, 100);
        }
    }
    #region 将创建好的图片输出到页面
    public void CreateImageOnPage(string content, HttpContext context)
    {
        System.IO.MemoryStream ms = new System.IO.MemoryStream();
        Bitmap image = this.CreateQRCode(content);

        image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);

        context.Response.ClearContent();
        context.Response.ContentType = "image/Jpeg";
        context.Response.BinaryWrite(ms.GetBuffer());

        ms.Close();
        ms = null;
        image.Dispose();
        image = null;
    }
    #endregion
}