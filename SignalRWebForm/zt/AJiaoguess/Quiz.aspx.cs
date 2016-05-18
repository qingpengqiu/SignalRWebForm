using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Data;
using Utils;
using System.Text.RegularExpressions;
public partial class zt_AJiaoguess_Quiz : PageBase
{
    public int uId = 0;
    public int jfd = 0;
    public int isout = 0;
    public int cid = 0;
    public string str = string.Empty;
    public string jf1 = string.Empty;
    public string jf2 = string.Empty;
    public string jf3 = string.Empty;
    public string jf4 = string.Empty;
    public string jf11 = string.Empty;
    public string jf22 = string.Empty;
    public string jf33 = string.Empty;
    public string jf44 = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            uId = 0;
            return;
        }
        else
        {
            uId = CurrentUser.uId;
        }
        if (DateTime.Now < DateTime.Parse("2015-08-31") || DateTime.Now > DateTime.Parse("2015-09-13"))
        {
            str = "timeout";
            //return;
        }
        isout = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId);
        if (!IsPostBack)
        {
            DataSet mod = new DB5.tblQuiz().GetList(" idUser =" + CurrentUser.uId);
            if (mod.Tables[0].Rows.Count > 0)
            {
                
                jfd = TypeChangeDefault.NullToInt(mod.Tables[0].Rows[0]["iAmount"], 0);
                cid = TypeChangeDefault.NullToInt(mod.Tables[0].Rows[0]["idMin"], 0);
                switch (cid.ToString())
                {
                    case "1":
                        jf1 = jfd.ToString();
                        jf11 = "this";
                        break;
                    case"2":
                        jf2 = jfd.ToString();
                        jf22 = "this";
                        break;
                    case"3":
                        jf3 = jfd.ToString();
                        jf33 = "this";
                        break;
                    case"4":
                        jf4 = jfd.ToString();
                        jf44 = "this";
                        break;
                    default:
                        break;
                }
                str = "timeout";
            }
        }
    }
    //public void add()
    //{
    //    if (CurrentUser == null)
    //    {
    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
    //        return;
    //    }
    //    Regex digitregex = new Regex(@"^[0-9]\d*[.]?\d*$");//初始化正则表达式
    //    isout = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId);
    //    //if()
    //    if (digitregex.IsMatch("") == true)
    //    { }
    //    else
    //    {
    //        AlertHelper.JQAlertGo("只能输入0-9数字", "", false);
    //        return;
    //    }
    //    DBM5.tblQuiz modlquiz = new DBM5.tblQuiz();
    //    modlquiz.idUser = uId;
    //    modlquiz.idItem = 1;
    //    modlquiz.idMin = 2;
    //    modlquiz.iAmount = 3;
    //    modlquiz.cItemName = "北马备战成绩竞猜";
    //    modlquiz.cMinName = "";
    //    modlquiz.dCreate = DateTime.Now;
    //    int i = new DB5.tblQuiz().Add(modlquiz);
    //    if (i == 1)
    //    {
    //        AlertHelper.JQAlertGo("竞猜成功！", "/zt/AJiaoguess/Quiz.aspx", true);
    //        return;
    //    }
    //    else
    //    {
    //        AlertHelper.JQAlertGo("竞猜失败,请重新竞猜！", "/zt/AJiaoguess/Quiz.aspx", false);
    //        return;
    //    }
    //}
   

}