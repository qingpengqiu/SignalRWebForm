using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using System.Collections;
using System.Web.SessionState;
using Erun360.Model;

/// <summary>
/// UEditor�༭��ͨ���ϴ���
/// </summary>
public class Uploader : IReadOnlySessionState
{
    string state = "SUCCESS";

    string URL = null;
    string currentType = null;
    string uploadpath = null;
    string filename = null;
    string originalName = null;
    HttpPostedFile uploadFile = null;

    /**
  * �ϴ��ļ�����������
  * @param HttpContext
  * @param string
  * @param  string[]
  *@param int
  * @return Hashtable
  */
    public Hashtable upFile(HttpContext cxt, string pathbase, string[] filetype, int size)
    {
        //pathbase = pathbase + DateTime.Now.ToString("yyyy-MM-dd") + "/";
        //uploadpath = cxt.Server.MapPath(pathbase);//��ȡ�ļ��ϴ�·��
        pathbase = DateTime.Now.ToString("yyyy-MM-dd") + "/";
        uploadpath = cxt.Server.MapPath(pathbase);//��ȡ�ļ��ϴ�·��
        try
        {
            uploadFile = cxt.Request.Files[0];
            originalName = uploadFile.FileName;

            //Ŀ¼����
            //createFolder();

            //��ʽ��֤
            if (checkType(filetype))
            {
                state = "��������ļ�����";
            }
            //��С��֤
            if (checkSize(size))
            {
                state = "�ļ���С������վ����";
            }
            //����ͼƬ
            if (state == "SUCCESS")
            {
                filename = reName();
                //uploadFile.SaveAs(uploadpath + filename);
                UpPhotoSaveAs(uploadFile, pathbase, filename);
                URL = pathbase + filename;
            }
        }
        catch (Exception e)
        {
            state = "δ֪����";
            URL = "";
        }
        return getUploadInfo();
    }
    private void UpPhotoSaveAs(HttpPostedFile uploadFile, string Path, string FileName)
    {
        HttpPostedFile face = uploadFile;
        //FileSaveAs picWebService = new FileSaveAs();
        //SaveFile.WebServiceSoapClient picWebService = new SaveFile.WebServiceSoapClient();
        // SaveFile.WebServiceSoapClient picWebService = new SaveFile.WebServiceSoapClient();
        SaveFile.FileSaveAsSoapClient picWebService = new SaveFile.FileSaveAsSoapClient();
        int upPhotoLength = face.ContentLength;
        byte[] PhotoArray = new Byte[upPhotoLength];
        Stream PhotoStream = face.InputStream;
        PhotoStream.Read(PhotoArray, 0, upPhotoLength);
        bool flag = picWebService.UploadFile(PhotoArray, Path, FileName);
        face.InputStream.Close();
    }
    /**
 * �ϴ�Ϳѻ����������
  * @param HttpContext
  * @param string
  * @param  string[]
  *@param string
  * @return Hashtable
 */
    public Hashtable upScrawl(HttpContext cxt, string pathbase, string tmppath, string base64Data)
    {
        pathbase = pathbase + DateTime.Now.ToString("yyyy-MM-dd") + "/";
        uploadpath = cxt.Server.MapPath(pathbase);//��ȡ�ļ��ϴ�·��
        FileStream fs = null;
        try
        {
            //����Ŀ¼
            createFolder();
            //����ͼƬ           
            filename = System.Guid.NewGuid() + ".png";
            fs = File.Create(uploadpath + filename);
            byte[] bytes = Convert.FromBase64String(base64Data);
            fs.Write(bytes, 0, bytes.Length);

            URL = pathbase + filename;
        }
        catch (Exception e)
        {
            state = "δ֪����";
            URL = "";
        }
        finally
        {
            fs.Close();
            deleteFolder(cxt.Server.MapPath(tmppath));
        }
        return getUploadInfo();
    }

    /**
* ��ȡ�ļ���Ϣ
* @param context
* @param string
* @return string
*/
    public string getOtherInfo(HttpContext cxt, string field)
    {
        string info = null;
        if (cxt.Request.Form[field] != null && !String.IsNullOrEmpty(cxt.Request.Form[field]))
        {
            info = field == "fileName" ? cxt.Request.Form[field].Split(',')[1] : cxt.Request.Form[field];
        }
        return info;
    }

    /**
     * ��ȡ�ϴ���Ϣ
     * @return Hashtable
     */
    private Hashtable getUploadInfo()
    {
        Hashtable infoList = new Hashtable();

        infoList.Add("state", state);
        infoList.Add("url", URL);

        if (currentType != null)
            infoList.Add("currentType", currentType);
        if (originalName != null)
            infoList.Add("originalName", originalName);
        return infoList;
    }

    /**
     * �������ļ�
     * @return string
     */
    private string reName()
    {
        return System.Guid.NewGuid() + getFileExt();       
    }

    /**
     * �ļ����ͼ��
     * @return bool
     */
    private bool checkType(string[] filetype)
    {
        currentType = getFileExt();
        return Array.IndexOf(filetype, currentType) == -1;
    }

    /**
     * �ļ���С���
     * @param int
     * @return bool
     */
    private bool checkSize(int size)
    {
        return uploadFile.ContentLength >= (size * 1024 * 1024);
    }

    /**
     * ��ȡ�ļ���չ��
     * @return string
     */
    private string getFileExt()
    {
        string[] temp = uploadFile.FileName.Split('.');
        return "." + temp[temp.Length - 1].ToLower();
    }

    /**
     * ���������Զ������洢�ļ���
     */
    private void createFolder()
    {
        if (!Directory.Exists(uploadpath))
        {
            Directory.CreateDirectory(uploadpath);
        }
    }

    /**
     * ɾ���洢�ļ���
     * @param string
     */
    public void deleteFolder(string path)
    {
        //if (Directory.Exists(path))
        //{
        //    Directory.Delete(path, true);
        //}
    }
}