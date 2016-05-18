using ImageProcess;
using System.IO;
using System.Web.Services;

/// <summary>
/// FileSaveAs 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
// [System.Web.Script.Services.ScriptService]
public class FileSaveAs : System.Web.Services.WebService
{

    public FileSaveAs()
    {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }
    /// <summary>
    /// 图片上传并生成自定义大小缩略图
    /// </summary>
    /// <param name="fs">上传文件字节数（fileBytes）</param>
    /// <param name="SavePath">存储路径</param>
    /// <param name="FileName">上传文件名称（10000.jpg）</param>
    /// <param name="thumName">缩略图尺寸（也是缩略图名称10000_300.jpg）</param>
    /// <param name="Thumbnail">是否生成缩略图</param>
    /// <param name="width">缩略图宽度</param>
    /// <param name="height">缩略图高度</param>
    /// <param name="mode">按什么方式截取</param>   
    /// <returns></returns>  public bool UploadFile(byte[] fs, string SavePath, string FileName, string thumName, bool Thumbnail = false, int width = 0, int height = 0, string mode = "Cut")
    [WebMethod(Description = "Web 服务提供的方法，返回是否文件上载,图片截取成功与否。")]
    public bool UploadFileAndThumbnail(byte[] fs, string SavePath, string FileName, string thumName, bool Thumbnail, int width, int height, string mode)
    {
        try
        {
            string path = System.Configuration.ConfigurationManager.AppSettings["imgPath"];
            string fullPath = path + "\\" + SavePath;
            if (!File.Exists(fullPath))   //如果/ImageUpload/images不存在，则创建/ImageUpload/images，用于存放源图片
            {
                System.IO.Directory.CreateDirectory(fullPath);
            }
            //string fileType = FileName.Substring(FileName.LastIndexOf(".") + 1, FileName.Length).ToLower();
            string fileType = FileName.Substring(FileName.LastIndexOf("."), FileName.Length - FileName.LastIndexOf(".")).ToLower();
            if (IsImage(fileType))
            {
                ///定义并实例化一个内存流，以存放提交上来的字节数组。  
                MemoryStream m = new MemoryStream(fs);
                ///定义实际文件对象，保存上载的文件。  
                FileStream f = new FileStream(fullPath + "\\" + FileName, FileMode.OpenOrCreate);
                ///把内内存里的数据写入物理文件  
                m.WriteTo(f);
                m.Close();
                f.Close();
                f = null;
                m = null;
                if (Thumbnail)
                {
                    string webFilePath = fullPath + "\\" + FileName;          // 服务器端文件路径
                    string thumFileName = FileName.Insert(FileName.LastIndexOf('.'), thumName);
                    string webFilePath_s = fullPath + "\\" + thumFileName;　　  // 服务器端缩略图路径
                    ImageThumbnail.MakeThumbnail(webFilePath, webFilePath_s, width, height, mode);
                    return true;
                }
                return true;
            }
            else
            { return false; }
        }
        catch
        {
            return false;
        }
    }

    /// <summary>
    /// 验证是否指定的图片格式
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public bool IsImage(string str)
    {
        bool isimage = false;
        string thestr = str.ToLower();
        //限定只能上传jpg和gif图片
        string[] allowExtension = { ".jpg", ".gif", ".bmp", ".png", ".jpeg" };
        //对上传的文件的类型进行一个个匹对
        for (int i = 0; i < allowExtension.Length; i++)
        {
            if (thestr == allowExtension[i])
            {
                isimage = true;
                break;
            }
        }
        return isimage;
    }

    [WebMethod(Description = "Web 服务提供的方法，返回是否文件上载成功与否。")]
    public bool UploadFile(byte[] fs, string SavePath, string FileName)
    {

        //string path = @"D:\test4\ueditor\net\";//System.Configuration.ConfigurationSettings.AppSettings["PicPath"].ToString();
        string path = System.Configuration.ConfigurationManager.AppSettings["imgPath"];
        try
        {
            //判断类型  
            string picName = FileName;
            string fileType = "";
            fileType = picName.Substring(picName.LastIndexOf("."), picName.Length - picName.LastIndexOf(".")).ToLower();
            if (fileType != ".jpg" && fileType != ".gif" && fileType != ".jpeg" && fileType != ".png")
            {
                return false;
            }

            string fullPath = path + "\\" + SavePath;

            if (!System.IO.Directory.Exists(fullPath))
                System.IO.Directory.CreateDirectory(fullPath);


            ///定义并实例化一个内存流，以存放提交上来的字节数组。  
            MemoryStream m = new MemoryStream(fs);

            ///定义实际文件对象，保存上载的文件。  
            FileStream f = new FileStream(fullPath + "\\" + FileName, FileMode.Create);

            ///把内内存里的数据写入物理文件  
            m.WriteTo(f);
            m.Close();
            f.Close();
            f = null;
            m = null;
            return true;
        }
        catch
        {
            return false;
        }
    }
    [WebMethod(Description = "Web 服务提供的方法，返回是否文件上载成功与否。")]
    public bool UploadShoe(byte[] fs, string SavePath, string FileName)
    {

        //string path = @"D:\test4\ueditor\net\";//System.Configuration.ConfigurationSettings.AppSettings["PicPath"].ToString();
        string path = System.Configuration.ConfigurationManager.AppSettings["shoeimgPath"];
        try
        {
            //判断类型  
            string picName = FileName;
            string fileType = "";
            fileType = picName.Substring(picName.LastIndexOf("."), picName.Length - picName.LastIndexOf(".")).ToLower();
            if (fileType != ".jpg" && fileType != ".gif" && fileType != ".jpeg" && fileType != ".png")
            {
                return false;
            }

            string fullPath = path + "\\" + SavePath;

            if (!System.IO.Directory.Exists(fullPath))
                System.IO.Directory.CreateDirectory(fullPath);


            ///定义并实例化一个内存流，以存放提交上来的字节数组。  
            MemoryStream m = new MemoryStream(fs);

            ///定义实际文件对象，保存上载的文件。  
            FileStream f = new FileStream(fullPath + "\\" + FileName, FileMode.Create);

            ///把内内存里的数据写入物理文件  
            m.WriteTo(f);
            m.Close();
            f.Close();
            f = null;
            m = null;
            return true;
        }
        catch
        {
            return false;
        }
    }
}
