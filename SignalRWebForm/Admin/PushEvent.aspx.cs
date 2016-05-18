using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Text;
using System.Text.RegularExpressions;
public partial class Admin_PushEvent : PageBase
{
    public int idRace = 0;//赛事id

    DB6.tblRace_Competition bllRace = new DB6.tblRace_Competition();
    public string BlogList = "";
    DB2.tblPush bll = new DB2.tblPush();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if ((CurrentUser.uId != 100001183 && CurrentUser.uId != 100055041) && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (!IsPostBack)
        {
            BindRace();
            BindClass();
            if (idRace == 0)
            {
                idRace = TypeChangeDefault.NullToInt(DDLRace.Value, 0);
            }
            DDLRace.Value = idRace.ToString();
            pushtime.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
            DBM6.tblRace_Competition model = bllRace.GetModel(idRace);
            if (model != null)
            {
                txtNewTitle.Text = model.cTitle;
                txtBio.Text = " 所在城市：" + model.cCityname + "<br>竞赛类型：" + CompeteStyle(model.idCompeteStyle ?? 5) + "<br>赛事时间：" + Convert.ToDateTime(model.dRaceBegin).ToString("yyyy-MM-dd") + "<br>报名时间：" + Convert.ToDateTime(model.dJoinBegin).ToString("yyyy-MM-dd HH:mm") + "(开始) 至 " + Convert.ToDateTime(model.dJoinEnd).ToString("yyyy-MM-dd HH:mm") + "(结束) ";
                //if (model.iType == 2)
                //{
                //    ddltype.Items.Clear();
                //    ddltype.Items.Add(new ListItem("赛事报名", "1"));
                //}
                //else
                //{
                //    ddltype.Items.Clear();
                //    ddltype.Items.Add(new ListItem("赛事报名", "1"));
                //    ddltype.Items.Add(new ListItem("成绩查询", "2"));
                //    ddltype.Items.Add(new ListItem("比赛图库", "3"));
                //    ddltype.Items.Add(new ListItem("赛事酒店", "4"));
                //    ddltype.Items.Add(new ListItem("赛事装备", "5"));
                //}
                ddltype.Items.Clear();
                ddltype.Items.Add(new ListItem("赛事报名", "1"));
                ddltype.Items.Add(new ListItem("成绩查询", "2"));
                ddltype.Items.Add(new ListItem("比赛图库", "3"));
                ddltype.Items.Add(new ListItem("赛事酒店", "4"));
                ddltype.Items.Add(new ListItem("赛事装备", "5"));
            }
            else
            {
                ddltype.Items.Clear();
                ddltype.Items.Add(new ListItem("赛事报名", "1"));
                ddltype.Items.Add(new ListItem("成绩查询", "2"));
                ddltype.Items.Add(new ListItem("比赛图库", "3"));
                ddltype.Items.Add(new ListItem("赛事酒店", "4"));
                ddltype.Items.Add(new ListItem("赛事装备", "5"));
            }
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<font color=black style=\"font-size:12px;\">本赛事已经被发布于：</font><br>");
            int pidx = 1;
            DataTable dt = bll.GetList(30, "idInfo=" + idRace, "dPush desc").Tables[0];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                sb.AppendLine("<span id=\"trData_" + pidx + "\">" + pidx + ". " + dt.Rows[i]["dPush"].ToString() + " &gt; ");
                sb.AppendLine(dt.Rows[i]["cClassName"].ToString());
                if ("1" == dt.Rows[i]["cMark"].ToString())
                {
                    sb.Append(">立即报名");
                }
                else if ("2" == dt.Rows[i]["cMark"].ToString())
                {
                    sb.Append(">成绩查询");
                }
                else if ("3" == dt.Rows[i]["cMark"].ToString())
                {
                    sb.Append(">比赛图库");
                }
                else if ("4" == dt.Rows[i]["cMark"].ToString())
                {
                    sb.Append(">赛事酒店");
                }
                else if ("5" == dt.Rows[i]["cMark"].ToString())
                {
                    sb.Append(">赛事装备");
                }
                sb.AppendLine(" 栏目 <font color=blue style=\"cursor:pointer;\" onclick=\"ItemDelete(" + dt.Rows[i]["id"].ToString() + "," + pidx + ")\">[删除]</font><font color=blue style=\"cursor:pointer;\" onclick=\"Itempush(" + dt.Rows[i]["id"].ToString() + "," + pidx + ")\">[再推]</font><br></span>");

                //sb.AppendLine("<span id=\"trData_" + pidx + "\">" + pidx + ". " + dt.Rows[i]["dPush"].ToString() + " &gt; " + dt.Rows[i]["cClassName"].ToString() + " 栏目 <font color=blue style=\"cursor:pointer;\" onclick=\"ItemDelete(" + dt.Rows[i]["id"].ToString() + "," + pidx + ")\">[删除]</font><br></span>");
                pidx++;
            }

            BlogList = sb.ToString();
        }
    }

    //绑定赛事
    private void BindRace()
    {
        DataTable dt = bllRace.GetList(0, "iStatus=1 and dRaceEnd>'" + DateTime.Now.AddMonths(-1) + "'", "id desc").Tables[0];
        DDLRace.DataSource = dt;
        DDLRace.DataTextField = "cTitle";
        DDLRace.DataValueField = "id";
        DDLRace.DataBind();
    }
    protected void BindClass()
    {
        DataSet ds = new DB2.tblClass().GetList(0, "iStatus=2", "iSort desc");
        ddlClass.DataSource = ds;
        ddlClass.DataTextField = "cName";
        ddlClass.DataValueField = "id";
        ddlClass.DataBind();
    }
    protected void imgbtn_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if ((CurrentUser.uId != 100001183 && CurrentUser.uId != 100055041) && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        if (idRace == 0)
        {
            idRace = TypeChangeDefault.NullToInt(DDLRace.Value, 0);
        }
        DBM6.tblRace_Competition modelEvent = new DB6.tblRace_Competition().GetModel(idRace);
        if (modelEvent != null)
        {
            DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(modelEvent.idUser ?? 0);
            if (user == null)
            {
                AlertHelper.JQAlert("用户不存在！", false);
                return;
            };
            DBM2.tblPush model = new DBM2.tblPush();
            model.idInfo = idRace;
            model.idUser = modelEvent.idUser;
            model.cNickName = user.cNickName;
            model.iType = 2;//赛事
            if (ddlClass.SelectedValue == "0")
            {
                AlertHelper.JQAlert("请选择发布位置！", false);
                return;
            }
            model.idClass = TypeChangeDefault.NullToInt(ddlClass.SelectedValue, 0);
            model.cClassName = TypeChangeDefault.NullToString(ddlClass.SelectedItem.Text, "");
            if (string.IsNullOrWhiteSpace(txtNewTitle.Text.Trim()))
            {
                model.cTitle = modelEvent.cTitle;
            }
            else
            {
                model.cTitle = txtNewTitle.Text.Trim();
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
                AlertHelper.JQAlert("摘要内容超过191字限制！", false);
                return;
            }
            model.cBio = txtBio.Text.Trim();
            model.dPush = TypeChangeDefault.NullToDateTime(pushtime.Value, DateTime.Now);
            model.cCreator = CurrentUser.uId;
            model.cMark = TypeChangeDefault.NullToString(ddltype.SelectedValue, "");
            model.cLinkUrl = "/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1";

            if (new DB2.tblPush().Add(model) > 0)
            {
                Erun360.Common.DataCache.RemoveAllCache("IndexArticle");
                Erun360.Common.DataCache.RemoveAllCache("cnArticle" + model.idClass);
                Erun360.Common.DataCache.RemoveAllCache("wzArticle" + model.idClass);
                AlertHelper.JQAlertGo("推送成功！", "PushEvent.aspx?id=" + idRace, true);
            }
            else
            {
                AlertHelper.JQAlertGo("推送失败！", "PushEvent.aspx?id=" + idRace, false);
            }
        }
        else
        {
            AlertHelper.JQAlert("赛事不存在！", false, false);
            return;
        }
    }

    private string CompeteStyle(int idCompeteStyle)
    {
        string Style = string.Empty;
        switch (idCompeteStyle)
        {
            case 0: Style = "U超级马拉松"; break;
            case 1: Style = "M全程马拉松"; break;
            case 2: Style = "H半程马拉松"; break;
            case 3: Style = "R路跑"; break;
            case 4: Style = "C越野跑"; break;
            case 5: Style = "T其它"; break;
        }
        return Style;
    }
    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddltype.Items.Clear();
        ddltype.Items.Add(new ListItem("赛事报名", "1"));
        ddltype.Items.Add(new ListItem("成绩查询", "2"));
        ddltype.Items.Add(new ListItem("比赛图库", "3"));
        ddltype.Items.Add(new ListItem("赛事酒店", "4"));
        ddltype.Items.Add(new ListItem("赛事装备", "5"));
        //if (ddlClass.SelectedValue == "1000" || ddlClass.SelectedValue == "1001")
        //{
        //    ddltype.Items.Clear();
        //    ddltype.Items.Add(new ListItem("赛事报名", "1"));
        //    ddltype.Items.Add(new ListItem("成绩查询", "2"));
        //    ddltype.Items.Add(new ListItem("比赛图库", "3"));
        //    ddltype.Items.Add(new ListItem("赛事酒店", "4"));
        //    ddltype.Items.Add(new ListItem("赛事装备", "5"));
        //}
        //else
        //{
        //    ddltype.Items.Clear();
        //    ddltype.Items.Add(new ListItem("赛事报名", "1"));
        //}
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