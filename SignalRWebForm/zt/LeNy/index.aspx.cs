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
public partial class zt_LeNy_index : PageBase
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
    public string over = string.Empty;
    public string js = "1";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (DateTime.Now > DateTime.Parse("2015-11-01 22:10"))
        {
            //str = "timeout";
            over = "over";
            js = "0";
            //return;
        }
        if (CurrentUser == null)
        {
            uId = 0;
            return;
        }
        else
        {
            uId = CurrentUser.uId;
        }

        isout = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId);
        if (!IsPostBack)
        {
            if (isout > 2000)
            {
                isout = 2000;
            }
            DataSet mod = new DB5.tblQuiz().GetList("idItem=2 and idUser =" + CurrentUser.uId);
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
                    case "2":
                        jf2 = jfd.ToString();
                        jf22 = "this";
                        break;
                    case "3":
                        jf3 = jfd.ToString();
                        jf33 = "this";
                        break;
                    case "4":
                        jf4 = jfd.ToString();
                        jf44 = "this";
                        break;
                    default:
                        break;
                }
                str = "timeout";
                js = "0";
                if (cid == 3)
                {
                    ltltesult.Text = "恭喜您竞猜成功，所获积分将在2-3个工作日转入您帐户。";
                }
                else
                {
                    ltltesult.Text = "很遗憾您没有竞猜成功。";
                }
            }
        }
    }
}