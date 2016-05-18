<%@ WebHandler Language="C#" Class="getRemoteImage" %>
/**
 * Created by visual studio 2010
 * User: xuheng
 * Date: 12-3-8
 * Time: ����13:33
 * To get the Remote image.
 */
using System;
using System.Web;
using System.Collections;
using System.Text.RegularExpressions;
using System.Net;
using System.IO;

public class getRemoteImage : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        string savePath = context.Server.MapPath("upload/");       //�����ļ���ַ
        string[] filetype = { ".gif", ".png", ".jpg", ".jpeg", ".bmp" };             //�ļ������ʽ
        int fileSize = 3000;                                                        //�ļ���С���ƣ���λkb

        string uri = context.Server.HtmlEncode(context.Request["upfile"]);
        uri = uri.Replace("&amp;", "&");
        string[] imgUrls = Regex.Split(uri, "ue_separate_ue", RegexOptions.IgnoreCase);

        ArrayList tmpNames = new ArrayList();
        WebClient wc = new WebClient();
        HttpWebResponse res;
        String tmpName = String.Empty;
        String imgUrl = String.Empty;
        String currentType = String.Empty;

        try
        {
            for (int i = 0, len = imgUrls.Length; i < len; i++)
            {
                imgUrl = imgUrls[i];

                if (imgUrl.Substring(0, 7) != "http://")
                {
                    tmpNames.Add("error!");
                    continue;
                }

                //��ʽ��֤
                int temp = imgUrl.LastIndexOf('.');
                currentType = imgUrl.Substring(temp).ToLower();
                if (Array.IndexOf(filetype, currentType) == -1)
                {
                    tmpNames.Add("error!");
                    continue;
                }

                res = (HttpWebResponse)WebRequest.Create(imgUrl).GetResponse();
                //http���
                if (res.ResponseUri.Scheme.ToLower().Trim() != "http")
                {
                    tmpNames.Add("error!");
                    continue;
                }
                //��С��֤
                if (res.ContentLength > fileSize * 1024)
                {
                    tmpNames.Add("error!");
                    continue;
                }
                //������֤
                if (res.StatusCode != HttpStatusCode.OK)
                {
                    tmpNames.Add("error!");
                    continue;
                }
                //���mime����
                if (res.ContentType.IndexOf("image") == -1)
                {
                    tmpNames.Add("error!");
                    continue;
                }
                res.Close();

                //��������λ��
                if (!Directory.Exists(savePath))
                {
                    Directory.CreateDirectory(savePath);
                }

                //д���ļ�
                tmpName = DateTime.Now.ToString("yyyy-MM-dd") + "/" + System.Guid.NewGuid() + currentType;
                wc.DownloadFile(imgUrl, savePath + tmpName);
                tmpNames.Add("upload/" + tmpName);
            }
        }
        catch (Exception)
        {
            tmpNames.Add("error!");
        }
        finally
        {
            wc.Dispose();
        }
        context.Response.Write("{url:'" + converToString(tmpNames) + "',tip:'Զ��ͼƬץȡ�ɹ���',srcUrl:'" + uri + "'}");
    }

    //����ת���ַ���
    private string converToString(ArrayList tmpNames)
    {
        String str = String.Empty;
        for (int i = 0, len = tmpNames.Count; i < len; i++)
        {
            str += tmpNames[i] + "ue_separate_ue";
            if (i == tmpNames.Count - 1)
                str += tmpNames[i];
        }
        return str;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}