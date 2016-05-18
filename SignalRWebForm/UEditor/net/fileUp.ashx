<%@ WebHandler Language="C#" Class="fileUp" %>
<%@ Assembly Src="Uploader.cs" %>
/**
 * Created by visual studio 2010
 * User: xuheng
 * Date: 12-3-9
 * Time: ����13:53
 * To change this template use File | Settings | File Templates.
 */
using System;
using System.Web;
using System.IO;
using System.Collections;

public class fileUp : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        //�ϴ�����
        String pathbase = "upload/";                                      //����·��
        string[] filetype = { ".rar", ".doc", ".docx", ".zip", ".pdf", ".txt", ".swf", ".wmv" };    //�ļ������ʽ
        int size = 100;   //�ļ���С����,��λMB,ͬʱ��web.config�����û���Ĭ��Ϊ100MB


        //�ϴ��ļ�
        Hashtable info = new Hashtable();
        Uploader up = new Uploader();
        info = up.upFile(context, pathbase,  filetype, size); //��ȡ�ϴ�״̬
       
        context.Response.Write("{'state':'" + info["state"] + "','url':'" + info["url"] + "','fileType':'" + info["currentType"] + "','original':'" + info["originalName"] + "'}"); //���������������json����
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}