using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
public partial class Admin_CodeList : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle < 12)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (!IsPostBack)
        {
            btUse.Visible = false;
            //hfId.Value = "0";
            //for (int i = 0; i < 1000; i++)
            //{
            //    Response.Write(RandomNumber() + "<br/>");
            //    //Response.Write(GenerateRandomNumber(12) + "<br/>");
            //    //Response.Write(GenerateStringID() + "<br/>");
            //    //Response.Write(GenerateIntID() + "<br/>");
            //}
        }
    }
    private static char[] constant1 =
{
'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
};
    public void RandomNumber(int Length)
    {
        Random rd = new Random();
        DBM5.tblCode model = new DBM5.tblCode();
        for (int i = 0; i < Length; i++)
        {
            string idCode = constant1[rd.Next(26)].ToString() + rd.Next(0, 9999).ToString().PadLeft(4, '0') + rd.Next(0, 9999).ToString().PadLeft(4, '0') + rd.Next(0, 9999).ToString().PadLeft(4, '0');
            model.idCode = idCode;
            model.iValid = 0;
            model.dValid = 0;
            try
            {
                new DB5.tblCode().Add(model);
            }
            catch { }
        }
        Response.Write("生成完成");
    }
    //参考网站http://www.cnblogs.com/jxsoft/archive/2011/03/15/1984509.html
    private static char[] constant =
{
'0','1','2','3','4','5','6','7','8','9',
'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
};
    public string GenerateRandomNumber(int Length)
    {
        System.Text.StringBuilder newRandom = new System.Text.StringBuilder(62);
        Random rd = new Random();
        for (int i = 0; i < Length; i++)
        {
            newRandom.Append(constant[rd.Next(62)]);
        }
        return newRandom.ToString();
    }
    //参考网站http://www.cnblogs.com/wifi/articles/2777154.html
    private string GenerateStringID()
    {

        long i = 1;

        foreach (byte b in Guid.NewGuid().ToByteArray())
        {

            i *= ((int)b + 1);

        }

        return string.Format("{0:x}", i - DateTime.Now.Ticks);

    }
    private long GenerateIntID()
    {

        byte[] buffer = Guid.NewGuid().ToByteArray();

        return BitConverter.ToInt64(buffer, 0);

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        RandomNumber(50000);
    }
    protected void btCode_Click(object sender, EventArgs e)
    {
        if (tbCode.Value.Trim().Length == 0)
        {
            AlertHelper.JQAlert("请填写兑换码！", false);
            return;
        }
        DataTable dt = new DB5.tblCode().GetList("iValid=1 and idCode='" + tbCode.Value.Trim() + "'").Tables[0];
        if (dt.Rows.Count > 0)
        {
            hfId.Value = dt.Rows[0]["id"].ToString();
            lbGood.Text = dt.Rows[0]["cGoodName"].ToString();
            lbValue.Text = dt.Rows[0]["cValue"].ToString();

            string iValid = dt.Rows[0]["iValid"].ToString();
            if (iValid == "1")
            {
                lbValid.Text = "有效";
            }
            else
            {
                lbValid.Text = "无效";
            }
            //lbValid.Text = dt.Rows[0]["iValid"].ToString();
            lbdValid.Text = dt.Rows[0]["dValid"].ToString();
            //lbUse.Text = dt.Rows[0]["isUse"].ToString();
            string isUse = dt.Rows[0]["isUse"].ToString();
            if (isUse == "1")
            {
                lbUse.Text = "已使用";
                btUse.Visible = false;
            }
            else
            {
                btUse.Visible = true;
                lbUse.Text = "未使用";
            }
        }
        else
        {
            AlertHelper.JQAlert("兑换码不存在！", false);
            return;
        }
    }
    protected void btUse_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DBM5.tblCode model = new DBM5.tblCode();
        int id = TypeChangeDefault.NullToInt(hfId.Value, 0);
        if (hfId.Value != "0" && id != 0)
        {
            model.id = id;
            model.isUse = 1;
            model.cUseWhere = "1";
            model.dUseTime = DateTime.Now;
            model.idPUser = CurrentUser.uId;
            new DB5.tblCode().Update(model);
            tbCode.Value = "";
            
            AlertHelper.JQAlert("操作成功！", true);
            return;
        }
        else
        {
            AlertHelper.JQAlert("操作失败！", false);
            return;
        }
        btUse.Visible = false;
    }
}