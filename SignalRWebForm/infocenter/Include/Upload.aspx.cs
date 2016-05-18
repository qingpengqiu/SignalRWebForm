using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class infocenter_Include_Upload : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public override void ProcessRequest(HttpContext context)
    {

        String pic = context.Request.Form["pic"];
        String pic1 = context.Request.Form["pic1"];
        String pic2 = context.Request.Form["pic2"];
        String pic3 = context.Request.Form["pic3"];
        byte[] bytesurl = Encoding.ASCII.GetBytes(CurrentUser.uId.ToString());
        byte[] hashValue = ((System.Security.Cryptography.HashAlgorithm)System.Security.Cryptography.CryptoConfig.CreateFromName("MD5")).ComputeHash(bytesurl);
        string hashurl = hashValue[0].ToString("x4");
        string pathFile = "/" +hashurl.Substring(0,2)+"/"+hashurl.Substring(2,2)+"/"+ CurrentUser.uId.ToString() + "/Head";
        string pathUrl = HostInfo.imgName + pathFile;
        string pathReal = Server.MapPath(pathFile);

        string fileShort = "/" + CurrentUser.uId.ToString() + ".png";
        string fileReal = RealUrl(pathReal + fileShort);
        string fileUrl = RealUrl(pathUrl + fileShort);
        string fileLocal = RealUrl(pathFile + fileShort);

        if (!Directory.Exists(pathReal))
        {
            Directory.CreateDirectory(pathReal);
        }
        //原图
        if (pic.Length == 0)
        {
        }
        else
        {
            byte[] bytes = Convert.FromBase64String(pic);  //将2进制编码转换为8位无符号整数数组

            string url = fileReal;
            FileStream fs = new FileStream(context.Server.MapPath(url), System.IO.FileMode.Create);
            fs.Write(bytes, 0, bytes.Length);
            fs.Close();
        }

        //byte[] bytes1 = Convert.FromBase64String(pic1);  //将2进制编码转换为8位无符号整数数组.
        //byte[] bytes2 = Convert.FromBase64String(pic2);  //将2进制编码转换为8位无符号整数数组.
        //byte[] bytes3 = Convert.FromBase64String(pic3);  //将2进制编码转换为8位无符号整数数组.



        ////图1，
        //string url1 = "./1.png";//需要修改图片保存地址，否则每次都是1.png，第二次会覆盖，为避免重名，可以使用guid：string fileLoadName =Guid.NewGuid().ToString() + ".png";
        //FileStream fs1 = new FileStream(context.Server.MapPath(url1), System.IO.FileMode.Create);
        //fs1.Write(bytes1, 0, bytes1.Length);
        //fs1.Close();

        ////图2
        //string url2 = "./2.png";
        //FileStream fs2 = new FileStream(context.Server.MapPath(url2), System.IO.FileMode.Create);
        //fs2.Write(bytes2, 0, bytes2.Length);
        //fs2.Close();

        ////图3
        //string url3 = "./3.png";
        //FileStream fs3 = new FileStream(context.Server.MapPath(url3), System.IO.FileMode.Create);
        //fs3.Write(bytes3, 0, bytes3.Length);
        //fs3.Close();
        //这里响应的是1，前台接收到json数组{status:1}，如果返回图片地址，如改为context.Response.Write("{\"status\":"+url1+"}");则前台页面无法执行uploadevent方法，只能按固定格式{\"status\":1}。
        //如果想返回图片路径，可以用静态类或session等方式。
        context.Response.Write("{\"status\":1}");

    }
    private string RealUrl(string s)
    {
        return s.Replace("//", "/").Replace("http:/", "http://");
    }
}