<%@ WebHandler Language="C#" Class="scrawlImgUp" %>
<%@ Assembly Src="Uploader.cs" %>

using System;
using System.Web;
using System.IO;
using System.Collections;

public class scrawlImgUp : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/html";
        string action = context.Request["action"];

        if (action == "tmpImg")
        {
            //�ϴ�����
            string pathbase = "tmp/";                                                          //����·��
            int size = 2;                     //�ļ���С����,��λmb                                                                                   //�ļ���С���ƣ���λKB
            string[] filetype = { ".gif", ".png", ".jpg", ".jpeg", ".bmp" };                    //�ļ������ʽ

            //�ϴ�ͼƬ
            Hashtable info = new Hashtable();
            Uploader up = new Uploader();
            info = up.upFile(context, pathbase, filetype, size); //��ȡ�ϴ�״̬

            HttpContext.Current.Response.Write("<script>parent.ue_callback('" + info["url"] + "','" + info["state"] + "')</script>");//�ص�����
        }
        else
        {
            string pathbase = "upload/";                                        //����·��
            string tmpPath = "tmp/";               //��ʱͼƬĿ¼       

            //�ϴ�ͼƬ
            Hashtable info = new Hashtable();
            Uploader up = new Uploader();
            info = up.upScrawl(context, pathbase, tmpPath, context.Request["content"]); //��ȡ�ϴ�״̬

            //�����������json����
            HttpContext.Current.Response.Write("{'url':'" + info["url"] + "',state:'" + info["state"] + "'}");
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