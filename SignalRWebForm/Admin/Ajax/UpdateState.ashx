<%@ WebHandler Language="C#" Class="UpdateState" %>

using System;
using System.Web;

public class UpdateState : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        string id = context.Request.Form["id"];
        string state = context.Request.Form["state"];
        if (context.Request.UrlReferrer==null)
        {
            ResponseEnd("非法访问!");
        }
        if (string.IsNullOrEmpty(id) && string.IsNullOrEmpty(state))
        {
            ResponseEnd("-1");//非法操作；
        }
        else
        {
            if (new Erun360.BLL.DB6.tblCooperation().UpdateState(int.Parse(id),int.Parse(state))>0)
            {
                ResponseEnd("1");//更新成功
            }
        }
    }
    public void ResponseEnd(string returnvalue)
    {
        HttpContext.Current.Response.Write(returnvalue);
        HttpContext.Current.Response.End();
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}