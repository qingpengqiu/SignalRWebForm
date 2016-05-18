using Erun360.Model.DB6;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;

public partial class Admin_flightlist : PageBase
{
    DB6.tblOrder bll = new DB6.tblOrder();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.uId != 100001183 && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (!IsPostBack)
        {
            
            pager.RecordCount = bll.GetRecordCount("iFromTpye=3");
            BindAllGV();
        }
    }
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        BindAllGV();
    }
    protected void BindAllGV()
    {
        int pagesize = pager.PageSize;
        int pageindex = pager.CurrentPageIndex;
        //DataSet ds = new DB1.tblShopping().GetListByPage("iState=2", "dPay desc", pageindex, pagesize);
        DataSet ds = bll.GetListByPage("iFromTpye=3", "dPayTime desc", pageindex, pagesize);
        GVmain.DataSource = ds;
        GVmain.DataBind();
    }
    protected string bx(string json)
    {
        string bxname = string.Empty;
        List<LinkMan> userlist = JsonDeserialize<List<LinkMan>>(json); //乘客信息集合json 格式   
        foreach (LinkMan p in userlist)
        {
            //缺少判断单个用户是否购买保险
            if (p.Insurance == "1")
                bxname += p.Name + "&nbsp;&nbsp;";
        }

        return bxname;
    }
    #region 序列化JSON序列化和反序列化辅助类
    /// <summary>
    /// JSON序列化
    /// </summary>
    public static string JsonSerializer<T>(T t)
    {
        DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
        MemoryStream ms = new MemoryStream();
        ser.WriteObject(ms, t);
        string jsonString = Encoding.UTF8.GetString(ms.ToArray());
        ms.Close();
        return jsonString;
    }
    /// <summary>
    /// JSON反序列化
    /// </summary>
    public static T JsonDeserialize<T>(string jsonString)
    {
        DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(jsonString));
        T obj = (T)ser.ReadObject(ms);
        return obj;
    }
    #endregion
}