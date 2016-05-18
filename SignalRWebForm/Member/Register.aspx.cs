using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using Erun360.Common.DEncrypt;
using System.Text.RegularExpressions;

public partial class Member_Register : System.Web.UI.Page
{
    private int m_idUser = 0;//邀请者
    protected void Page_Load(object sender, EventArgs e)
    {
        m_idUser = TypeChangeDefault.NullToInt(Request.QueryString["u"], 0);
        if (!IsPostBack)
        { 
            //string ip = HttpContext.Current.Request.UserHostAddress;
            //Session["ip"] = ip;
        }
    }

   
    //private static Regex RegPhone = new Regex("^1\\d{10}$");
    //private static Regex RegEmail = new Regex(@"^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$");
    //public static bool IsPhone(string inputData)
    //{
    //    Match m = RegPhone.Match(inputData);
    //    return m.Success;
    //}
    //public static bool IsEmail(string inputData)
    //{
    //    Match m = RegEmail.Match(inputData);
    //    return m.Success;
    //}
   
    //protected void imgbtn_Click(object sender, ImageClickEventArgs e)
    //{
    //    DBM1.tblMEMBER model = new DBM1.tblMEMBER();
    //    DB1.tblMEMBER BLL = new DB1.tblMEMBER();
    //    string cLoginname = XString.SqlSafe(txtLogin.Value.Trim());
    //    if (cLoginname.Length == 0)
    //    {
    //        AlertHelper.JQAlert("请填写登陆名称！", false);
    //        return;
    //    }
    //    if (cLoginname.Length > 32)
    //    {
    //        AlertHelper.JQAlert("登录名超过限制！", false);
    //        return;
    //    }
    //    if (BLL.Exists(cLoginname))
    //    {
    //        AlertHelper.JQAlert("该账号已存在，请重新输入！", false);
    //        return;
    //    }
    //    if (GCommon.BadLoginname(cLoginname))
    //    {
    //        AlertHelper.JQAlert("非法登录名！", false);
    //        return;
    //    }
    //    if (!(IsPhone(cLoginname) || IsEmail(cLoginname)))
    //    {
    //        AlertHelper.JQAlert("请检查邮箱或者手机号的格式！", false);
    //        return;
    //    }
    //    if (this.txtCode.Value.Trim().ToLower() != Session["loginCode"].ToString().ToLower())
    //    {
    //        AlertHelper.JQAlert("验证码输入错误！", false);
    //        return;
    //    }
    //    model.cLoginname = cLoginname;
    //    string PassWord = XString.SqlSafe(txtPassWord.Text.Trim());
    //    if (PassWord.Length == 0)
    //    {
    //        AlertHelper.JQAlert("请填写密码！", false);
    //        return;
    //    }
    //    if (PassWord.Length > 64)
    //    {
    //        AlertHelper.JQAlert("密码超过限制！", false);
    //        return;
    //    }
    //    string RePassWord = XString.SqlSafe(txtRePassWord.Text.Trim());
    //    if (RePassWord != PassWord)
    //    {
    //        AlertHelper.JQAlert("两次密码不一致，请重新输入！", false);
    //        return;
    //    }
    //    model.cPassword = XString.MD5(PassWord.ToLower());
    //    string cNickName = XString.SqlSafe(txtNick.Text.Trim());
    //    if (cNickName.Length == 0)
    //    {
    //        AlertHelper.JQAlert("请填写益跑昵称！", false);
    //        return;
    //    }
    //    if (cNickName.Length > 64)
    //    {
    //        AlertHelper.JQAlert("益跑昵称超过限制！", false);
    //        return;
    //    }
    //    if (GCommon.BadLoginname(cNickName))
    //    {
    //        AlertHelper.JQAlert("非法登录名！", false);
    //        return;
    //    }
    //    int countNick = new DB1.tblMEMBER().GetRecordCount("cNickName='" + cNickName + "'");
    //    if (countNick > 0)
    //    {
    //        AlertHelper.JQAlert("该昵称已存在，请重新输入！", false);
    //        return;
    //    }
    //    model.cNickName = cNickName;
    //    model.idQuestion = idQuestion.SelectedIndex;
    //    string cAnswer = XString.SqlSafe(txtAsk.Text.Trim());
    //    if (cAnswer.Length == 0)
    //    {
    //        AlertHelper.JQAlert("请填写答案！", false);
    //        return;
    //    }
    //    if (cAnswer.Length > 32)
    //    {
    //        AlertHelper.JQAlert("答案超过限制！", false);
    //        return;
    //    }
    //    model.cAnswer = XString.MD5(cAnswer);
    //    if (!agree.Checked)
    //    {
    //        AlertHelper.JQAlert("请选择接受益跑协议！", false);
    //        return;
    //    }
    //    model.iChecksum = BLL.GetCheckSum(cLoginname);
    //    //后台附加字段
    //    model.idCity = 0;
    //    model.idBlood = 0;
    //    model.idEducation = 0;
    //    model.idOccupation = 0;
    //    model.cAvatar = @"/Html/images/iscardr.png";
    //    int idUser = BLL.Add(model);
    //    if (idUser > 0)
    //    {
    //        //插入积分数据，并更新积分200            
    //        DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
    //        if (!uMember_History.Exists(200810005, idUser))
    //        {
    //            new DB1.tblIntegral().InsertScore(idUser, 200810005, 1, 0, 1);
    //            //uMember_History.Insert(idUser, 1, 200810005, 0);
    //            DBM1.tblMEMBER_SUMMARY mSummary = new DB1.tblMEMBER_SUMMARY().GetModel(idUser);// new DBM1.tblMEMBER_SUMMARY();
    //            mSummary.idUser = idUser;
    //            mSummary.iLoginTimes = mSummary.iLoginTimes + 1;
    //            new DB1.tblMEMBER_SUMMARY().Update(mSummary);
    //            //uMember_History.Insert(idUser, 100800100, 10);
    //        }
    //        //插入身体数据
    //        DBM1.tblMEMBER_SIZE mSize = new DBM1.tblMEMBER_SIZE();
    //        mSize.idUser = idUser;
    //        new DB1.tblMEMBER_SIZE().Add(mSize);
    //        //插入博客分类
    //        DBM2.tblBLOG_GROUP mGroup = new DBM2.tblBLOG_GROUP();
    //        mGroup.idUser = idUser;
    //        mGroup.iChecksum = 603286181;//未分类
    //        mGroup.cTitle = "未分类";
    //        new DB2.tblBLOG_GROUP().Add(mGroup);
    //        Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(idUser);
    //        //邀请者送积分
    //        if (m_idUser != 0)
    //        {
    //            new DB1.tblIntegral().InsertScore(m_idUser, 200810002, 1, 0, idUser.ToString());
    //        }
    //        AlertHelper.JQAlertGo("账号创建成功", "Register1.aspx", true);
    //        return;
    //    }
    //    else
    //    {
    //        AlertHelper.JQAlert("账号创建失败！", false);
    //        return;
    //    }
    //}
}