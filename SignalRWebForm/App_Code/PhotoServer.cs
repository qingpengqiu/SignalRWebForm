using ImageProcess;
using System;
using System.Data;
using System.IO;
using System.Web.Services;

/// <summary>
/// PhotoServer 的摘要说明
/// </summary>
[WebService(Namespace = "Erun360")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
// [System.Web.Script.Services.ScriptService]
public class PhotoServer : System.Web.Services.WebService {

    public PhotoServer () {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod(Description = "根据原图生产缩略图，并返回总文件数")]
    public int GetCount(string sfolder, string bfolder)
    {
        //    smallfoldername = Server.MapPath(sfolder);
        //    bigfoldername = Server.MapPath(bfolder); ;
        //生成小图目录
        //DirectoryInfo di_smallforder = Directory.CreateDirectory(smallfoldername);
        //取得大图目录信息
        DirectoryInfo imagesfile = new DirectoryInfo(Server.MapPath(bfolder));
        //取得大图目录所有JPG文件集合
        FileInfo[] fi = imagesfile.GetFiles("*.jpg");
        for (int i = 0; i < fi.Length; i++)
        {
            if (!File.Exists(Server.MapPath(sfolder) + "/" + fi[i].Name))
            {
                //生成缩略图文件
                ImageThumbnail.MakeThumbnail(
                                             Server.MapPath(bfolder) + "/" + fi[i].Name,
                                             Server.MapPath(sfolder) + "/" + fi[i].Name,
                                             156,
                                             156,
                                             "Cut"
                                             );
            }
        }
        return fi.Length;
    }
    [WebMethod(Description = "获取文件目录下的文件列表")]
    public DataSet GetImgs(string bfolder, string sfolder, int pIndex, int pSize)
    {
        //string sfolder = String.Empty;//缩略图
        //string bfolder = String.Empty;//大图
        int StartIndex;
        //设定导入的起终地址
        StartIndex = pIndex * pSize;
        //取得大图目录信息
        DirectoryInfo imagesfile = new DirectoryInfo(Server.MapPath(bfolder));
        //取得大图目录所有JPG文件集合
        FileInfo[] fi = imagesfile.GetFiles("*.jpg");
        //取得小图目录信息
        DirectoryInfo Smallimagesfile = new DirectoryInfo(Server.MapPath(sfolder));
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

        if (Sfi.Length - StartIndex < pSize)
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
            for (int i = 0; i < pSize; i++)
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
    [WebMethod(Description = "获取文件目录下所有文件名")]
    public DataTable GetFileNameByCache(string bigfoldername)
    {

        string CacheKey = "fold-" + bigfoldername;       
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
            try
            {
                DirectoryInfo imagesfile = new DirectoryInfo(Server.MapPath(bigfoldername));
                FileInfo[] fi = imagesfile.GetFiles("*.jpg");
                DataTable tblDatas = new DataTable("Files");
                tblDatas.Columns.Add("id", Type.GetType("System.Int32"));
                tblDatas.Columns.Add("prv", Type.GetType("System.String"));
                tblDatas.Columns.Add("name", Type.GetType("System.String"));
                tblDatas.Columns.Add("next", Type.GetType("System.String"));                
                for (int i = 0; i < fi.Length; i++)
                {
                    DataRow row = tblDatas.NewRow();
                    row["id"] = i;
                    if (i == 0)
                    {
                        row["prv"] = "";
                    }
                    else
                    {
                        row["prv"] = fi[i - 1].Name.ToLower();
                    }
                    row["name"] = fi[i].Name.ToLower();
                    if (i >= fi.Length-1)
                    {
                        row["next"] = "";
                    }
                    else
                    {
                        row["next"] = fi[i + 1].Name.ToLower();
                    }

                    tblDatas.Rows.Add(row);
                }
                objModel = tblDatas;
                if (objModel != null)
                {
                    int ModelCache = 30;
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch { }
        }
        return (DataTable)objModel;
    }
}
