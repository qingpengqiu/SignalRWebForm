using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using System.Collections;
using System.Collections.Generic;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json;
using System.Text;
using System.Data;

public partial class Competetion_tblAnnexLog : PageBase
{
    public int id = 0;
    public string Result = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (id == 0)
        {
            return;
        }
        Hashtable good = new Hashtable();
        //Hashtable hht = null;
        StringBuilder sb = new StringBuilder();
        List<Hashtable> goodInfo = new List<Hashtable>();
        int state = new DB6.tblOrder().GetState(CurrentUser.uId, id, 2);
        DataTable dt = new DB6.tblAnnex().GetList(0, "iState > 1 and iNum>0 and idCompete=" + id + " or iGlobal=0", "dCreate").Tables[0];
        if (state > 0)
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {//序列化
                    sb.AppendLine(dt.Rows[i]["id"].ToString());//附属品id
                    sb.AppendLine(dt.Rows[i]["idCompete"].ToString());//赛事id
                    sb.AppendLine(dt.Rows[i]["cName"].ToString());//附属品名字
                    sb.AppendLine(dt.Rows[i]["cLink"].ToString());//链接
                    sb.AppendLine(dt.Rows[i]["cImg"].ToString());//图片
                    sb.AppendLine(dt.Rows[i]["fPrice"].ToString());//单价
                    sb.AppendLine(dt.Rows[i]["iNum"].ToString());//数量
                    sb.AppendLine(dt.Rows[i]["iState"].ToString());//状态
                    sb.AppendLine(dt.Rows[i]["iBuyNum"].ToString());//限购数量
                    sb.AppendLine(dt.Rows[i]["iGlobal"].ToString());//显示状态
                    sb.AppendLine(dt.Rows[i]["dCreate"].ToString());//创建时间
                    sb.AppendLine(dt.Rows[i]["idUser"].ToString());//创建人
                }

                //Result = sb.ToString();
                IsoDateTimeConverter iso = new IsoDateTimeConverter();
                iso.DateTimeFormat = "yyyy-MM-dd HH:mm";
                Result = JsonConvert.SerializeObject(sb, iso);//传json串
                //Response.Write(Result);
            }
            else
            {
                Result = "{\"msg\":\"暂无匹配的附属产品，请耐心等候！\",\"status\":\"2\"}";
            }
        }
        else
        {
            Result = "{\"msg\":\"您没有报名，请报名！\",\"status\":\"1\"}";
        }
    }
}