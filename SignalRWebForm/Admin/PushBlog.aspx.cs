using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
public partial class Admin_PushBlog : PageBase
{
    private int id = 0;
    public string BlogList = "";
    DB2.tblPush bll = new DB2.tblPush();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle < 13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (!IsPostBack)
        {
            BindClass();
            DBM2.tblBLOG model = new DB2.tblBLOG().GetModel(id);
            if (model != null)
            {
                lbid.Text = id.ToString();
                lbNickName.Text = model.cLoginname;
                lbTitle.Text = model.cTitle;
                txtBio.Text = SubStrAddSuffix(HTMLHelper.NoHTML(model.cContent), 190, "");
            }
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<font color=black style=\"font-size:12px;\">本博客已经被发布于：</font><br>");
            int pidx = 1;
            DataTable dt = bll.GetList(30, "idInfo=" + id, "dPush desc").Tables[0];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                sb.AppendLine("<span id=\"trData_" + pidx + "\">" + pidx + ". " + dt.Rows[i]["dPush"].ToString() + " &gt; " + dt.Rows[i]["cClassName"].ToString() + " 栏目 <font color=blue style=\"cursor:pointer;\" onclick=\"ItemDelete(" + dt.Rows[i]["id"].ToString() + "," + pidx + ")\">[删除]</font><br></span>");
                pidx++;
            }
            BlogList = sb.ToString();
            pushtime.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
        }
    }
    protected void imgbtn_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle < 13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        DBM2.tblBLOG modelblog = new DB2.tblBLOG().GetModel(id);
        if (modelblog != null)
        {
            DBM2.tblPush model = new DBM2.tblPush();
            model.idInfo = id;
            model.idUser = modelblog.idUser;
            model.cNickName = modelblog.cLoginname;
            model.iType = 1;//博客
            model.idClass = TypeChangeDefault.NullToInt(ddlClass.SelectedValue, 0);
            model.cClassName = TypeChangeDefault.NullToString(ddlClass.SelectedItem.Text, "");
            if (string.IsNullOrWhiteSpace(new_title.Value.Trim()))
            {
                model.cTitle = modelblog.cTitle;
            }
            else
            {
                model.cTitle = new_title.Value;
            }
         
            if (GetStringLengthWithChinlish(model.cTitle) > 20)
            {
                AlertHelper.JQAlert("标题超过20字限制！", false);
                return;
            }
            if (jdtp.Value.Trim().Length == 0)
            {
                AlertHelper.JQAlert("请上传图片！", false);
                return;
            }
            model.cImageUrl = jdtp.Value;
            if (txtBio.Text.Trim().Length > 191)
            {
                AlertHelper.JQAlert("摘要内容超过191字限制！");
                return;
            }
            model.cBio = txtBio.Text.Trim();
            model.dPush = TypeChangeDefault.NullToDateTime(pushtime.Value, DateTime.Now);
            model.cCreator = CurrentUser.uId;
            model.cLinkUrl = "/blog/" + id + ".aspx";
            if (new DB2.tblPush().Add(model) > 0)
            {
                // 一篇文章只能加入一次积分
                if (!new DB1.tblMEMBER_HISTORY().Exists(200810018, modelblog.idUser, modelblog.id.ToString()))
                {
                    new DB1.tblIntegral().InsertScore(model.idUser ?? 0, 200810018, 1, 0, model.idInfo.ToString());
                }
                
                Erun360.Common.DataCache.RemoveAllCache("IndexArticle");
                Erun360.Common.DataCache.RemoveAllCache("cnArticle" + model.idClass);
                Erun360.Common.DataCache.RemoveAllCache("wzArticle" + model.idClass);
                AlertHelper.JQAlertGo("推送成功！", "PushBlog.aspx?id=" + id, true);
                return;
            }
            else
            {
                AlertHelper.JQAlertGo("推送失败！", "PushBlog.aspx?id=" + id, true);
                return;
            }
        }
    }
    protected void BindClass()
    {
        DataSet ds = new DB2.tblClass().GetList(0, "iStatus=1", "iSort desc");
        ddlClass.DataSource = ds;
        ddlClass.DataTextField = "cName";
        ddlClass.DataValueField = "id";
        ddlClass.DataBind();
    }
    /// <summary>
    /// 截取字符串长度，超出部分使用后缀suffix代替，比如abcdevfddd取前3位，后面使用...代替
    /// </summary>
    /// <param name="orginStr"></param>
    /// <param name="length"></param>
    /// <param name="suffix"></param>
    /// <returns></returns>
    public static string SubStrAddSuffix(string orginStr, int length, string suffix)
    {
        string ret = orginStr;
        if (orginStr.Length > length)
        {
            ret = orginStr.Substring(0, length) + suffix;
        }
        return ret;
    }
    
    /// <summary>
    /// 检查中英文混合字符长度（英文字符算0.5，中文算1）例如：我是admin 长度4.5
    /// </summary>
    /// <param name="source"></param>
    /// <returns></returns>
    private float GetStringLengthWithChinlish(string source)
    {
        Regex r = new Regex(@"[\u4E00-\u9fa5]");//中文
        float len = 0.0F;
        char[] stringChar = source.ToCharArray();
        foreach (char chr in stringChar)
        {
            //Console.Write(chr.ToString());
            if (r.IsMatch(chr.ToString()))
            {
                len += 1;
            }
            else
            {
                len += 0.5F;
            }
        }

        return len;
    }
}