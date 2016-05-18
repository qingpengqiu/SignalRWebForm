using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using System.Text.RegularExpressions;
public partial class Admin_PushRun : PageBase
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
            DBM4.tblRACE_ACTIVITY model = new DB4.tblRACE_ACTIVITY().GetModel(id);
            if (model != null)
            {
                lbid.Text = id.ToString();
                DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(model.idUser ?? 0);
                if (user == null)
                { AlertHelper.JQAlert("用户不存在！", false, false); };
                lbNickName.Text = user.cNickName;
                lbTitle.Text = model.cTitle;
                string bio = model.iFee > 0 ? model.iFee + "元" : "免费";
                txtBio.Text = " 活动时间：" + Convert.ToDateTime(model.dOpen).ToString("yyyy-MM-dd HH:mm") + "<br>活动经费：" + bio + "<br>总里程：" + model.iDistance + "KM<br>活动地点：" + model.cCityname + model.cAddress;
            }
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<font color=black style=\"font-size:12px;\">本约跑已经被发布于：</font><br>");
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
        DBM4.tblRACE_ACTIVITY modelRun = new DB4.tblRACE_ACTIVITY().GetModel(id);
        if (modelRun != null)
        {
            DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(modelRun.idUser ?? 0);
            if (user == null)
            { AlertHelper.JQAlert("用户不存在！", false, false); };
            DBM2.tblPush model = new DBM2.tblPush();
            model.idInfo = id;
            model.idUser = modelRun.idUser;
            model.cNickName = user.cLoginname;
            model.iType = 3;//约跑
            model.idClass = TypeChangeDefault.NullToInt(ddlClass.SelectedValue, 0);
            model.cClassName = TypeChangeDefault.NullToString(ddlClass.SelectedItem.Text, "");
            if (string.IsNullOrWhiteSpace(new_title.Value.Trim()))
            {
                model.cTitle = modelRun.cTitle.Trim();
            }
            else
            {
                model.cTitle = new_title.Value.Trim();
            }
            if (GetStringLengthWithChinlish(model.cTitle) > 20)
            {
                AlertHelper.JQAlert("标题超过20字限制！", false);
                return;
            }
            if (jdtp.Value.Trim().Length == 0)
            {
                AlertHelper.JQAlert("请上传图片！",false);
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
            model.cLinkUrl = "/race/" + id + ".aspx";
            if (new DB2.tblPush().Add(model) > 0)
            {
                Erun360.Common.DataCache.RemoveAllCache("IndexArticle");
                Erun360.Common.DataCache.RemoveAllCache("cnArticle" + model.idClass);
                Erun360.Common.DataCache.RemoveAllCache("wzArticle" + model.idClass);
                AlertHelper.JQAlertGo("推送成功！", "PushRun.aspx?id=" + id, true);
            }
            else
            {
                AlertHelper.JQAlertGo("推送失败！", "PushRun.aspx?id=" + id, true);
            }
        }
    }
    protected void BindClass()
    {
        DataSet ds = new DB2.tblClass().GetList(0, "iStatus=3", "iSort desc");
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