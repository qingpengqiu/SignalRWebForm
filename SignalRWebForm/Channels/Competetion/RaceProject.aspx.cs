using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DBM4 = Erun360.Model.DB4;
using Erun360.Common;
using DB4 = Erun360.BLL.DB4;
using System.Xml.Linq;
using Utils;

public partial class Channels_Competetion_RaceProject : PageBase
{
    public int id = 0;//赛事id
    public string la = string.Empty;
    public string xz = string.Empty;
    public string item = string.Empty;
    public string idblog = "/";
    public int iScore = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        id = TypeChangeDefault.NullToInt(Request.QueryString["idcompete"], 0);
        if (id == 0)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "/Channels/Competetion/RaceList.aspx", false);
            return;
        }
        la = TypeChangeDefault.NullToString(Request.QueryString["la"], "cn");
        la = la == "en" ? "en" : "cn";
        if (!IsPostBack)
        {
            Dictionary<string, string> dict = Getcn_en(la);
            ltlHeader.Text = dict.FirstOrDefault(d => d.Key == "1").Value;
            ltlProject.Text = dict.FirstOrDefault(d => d.Key == "2").Value;
            ltlFxcp.Text = dict.FirstOrDefault(d => d.Key == "3").Value;
            ltlbsxz.Text = dict.FirstOrDefault(d => d.Key == "4").Value;
            DataTable dt = new DB4.tblRACE_SIGNUP().GetList(0, "idCompete=" + id, " iType,id ").Tables[0];
            if (dt.Rows.Count > 0)
            {
                ltlTitle.Text = dt.Rows[0]["cTitle"].ToString();
                idblog = "/blog/" + dt.Rows[0]["idBlog"].ToString() + ".aspx";
                if (dt.Rows[0]["cItem"].ToString().Length > 0)
                {
                    string fscp = dt.Rows[0]["cItem"].ToString();
                    StringBuilder sbshu = new StringBuilder();

                    DataTable dt1 = new DB4.tblAnnex().GetList("iState>0 and iNum>0 and id in(" + fscp + ")").Tables[0];
                    for (int i = 0; i < dt1.Rows.Count; i++)
                    {
                        sbshu.AppendLine("<li><input type=\"checkbox\" name=\"projectother\" id=\"projectother" + i + "\" value=\"" + dt1.Rows[i]["id"] + "\"><label for=\"projectother" + i + "\">" + dt1.Rows[i]["cName"] + "：￥" + dt1.Rows[i]["fPrice"] + "元</label></li>");
                    }
                    xz = sbshu.ToString();
                }
            }
            int Itype = 0;
            int j = 0, k = 0, l = 0;
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                int count = new DB4.tblRACE_SALES().GetRecordCount(" iState>-1 and idSignUp=" + dt.Rows[i]["id"].ToString());
                Itype = TypeChangeDefault.NullToInt(dt.Rows[i]["iType"], 0);
                if (Itype == 1)
                {
                    if (count >= TypeChangeDefault.NullToInt(dt.Rows[i]["iLimit"], 0))
                    {
                        sb.AppendLine("<li><input type=\"radio\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + dt.Rows[i]["iScore"] + "\" disabled name=\"project\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\" class=\"projectover\">" + dt.Rows[i]["cType"] + "：<em>￥" + dt.Rows[i]["iCost"] + "元</em><span>（报名已满）</span></label></li>");
                    }
                    else
                    {
                        if (dt.Rows[i]["cComment"].ToString().Length > 0)
                        {
                            sb.AppendLine("<li><input type=\"radio\" name=\"project\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + dt.Rows[i]["iScore"] + "\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\">" + dt.Rows[i]["cType"] + "：<em>￥" + dt.Rows[i]["iCost"] + "元</em><div class=\"projecttips\"><em></em>" + dt.Rows[i]["cComment"] + "</div></label></li>");
                        }
                        else
                        {
                            sb.AppendLine("<li><input type=\"radio\" name=\"project\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + dt.Rows[i]["iScore"] + "\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\">" + dt.Rows[i]["cType"] + "：<em>￥" + dt.Rows[i]["iCost"] + "元</em></label></li>");
                        }
                    }
                    continue;
                }
                if (Itype == 2)
                {
                    if (j == 0)
                    {
                        sb.AppendLine("<li class=\"mprojectx\"></li>");
                    }
                    j++;
                    if (count >= TypeChangeDefault.NullToInt(dt.Rows[i]["iLimit"], 0))
                    {
                        sb.AppendLine("<li class=\"pout\"><input type=\"radio\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + dt.Rows[i]["iScore"] + "\" disabled name=\"project\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\" class=\"projectover\">" + dt.Rows[i]["cType"] + "：<em>￥" + dt.Rows[i]["iCost"] + "元</em><span>（报名已满）</span></label></li>");
                    }
                    else
                    {
                        if (dt.Rows[i]["cComment"].ToString().Length > 0)
                        {
                            sb.AppendLine("<li class=\"pout\"><input type=\"radio\" name=\"project\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + dt.Rows[i]["iScore"] + "\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\">" + dt.Rows[i]["cType"] + "：<em>￥" + dt.Rows[i]["iCost"] + "元</em><div class=\"projecttips\"><em></em>" + dt.Rows[i]["cComment"] + "</div></label></li>");
                        }
                        else
                        {
                            sb.AppendLine("<li class=\"pout\"><input type=\"radio\" name=\"project\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + dt.Rows[i]["iScore"] + "\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\">" + dt.Rows[i]["cType"] + "：<em>￥" + dt.Rows[i]["iCost"] + "元</em></label></li>");
                        }
                    }
                    continue;
                }
                if (Itype == 3)
                {
                    if (k == 0)
                    {
                        sb.AppendLine("<li class=\"mprojectx\"></li>");
                    }
                    k++;
                    if (count >= TypeChangeDefault.NullToInt(dt.Rows[i]["iLimit"], 0))
                    {
                        sb.AppendLine("<li class=\"pout3\"><input type=\"radio\" disabled name=\"project\" data-jifen=\"" + dt.Rows[i]["iScore"] + "\" data-jiage=\"" + dt.Rows[i]["iMoney"] + "\"  id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\" class=\"projectover\">" + dt.Rows[i]["cType"] + "(" + dt.Rows[i]["iNum"] + "人)：<em>￥" + dt.Rows[i]["iCost"] + "元</em><span>（报名已满）</span></label></li>");
                    }
                    else
                    {
                        if (dt.Rows[i]["cComment"].ToString().Length > 0)
                        {
                            sb.AppendLine("<li class=\"pout3\"><input type=\"radio\" name=\"project\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + dt.Rows[i]["iScore"] + "\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\">" + dt.Rows[i]["cType"] + "(" + dt.Rows[i]["iNum"] + "人)：<em>￥" + dt.Rows[i]["iCost"] + "元</em><div class=\"projecttips\"><em></em>" + dt.Rows[i]["cComment"] + "</div></label></li>");
                        }
                        else
                        {
                            sb.AppendLine("<li class=\"pout3\"><input type=\"radio\" name=\"project\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + dt.Rows[i]["iScore"] + "\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\">" + dt.Rows[i]["cType"] + "(" + dt.Rows[i]["iNum"] + "人)：<em>￥" + dt.Rows[i]["iCost"] + "元</em></label></li>");
                        }
                    }
                    continue;
                }
                if (Itype == 4)
                {
                    if (l == 0)
                    {
                        sb.AppendLine("<li class=\"mprojectx\"></li>");
                    }
                    l++;
                    if (count >= TypeChangeDefault.NullToInt(dt.Rows[i]["iLimit"], 0))
                    {
                        sb.AppendLine("<li class=\"pout4\"><input type=\"radio\" disabled name=\"project\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + dt.Rows[i]["iScore"] + "\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\" class=\"projectover\">" + dt.Rows[i]["cType"] + "：<em>￥" + dt.Rows[i]["iCost"] + "元</em><span>（报名已满）</span></label></li>");
                    }
                    else
                    {
                        if (dt.Rows[i]["cComment"].ToString().Length > 0)
                        {
                            sb.AppendLine("<li class=\"pout4\"><input type=\"radio\" name=\"project\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + dt.Rows[i]["iScore"] + "\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\">" + dt.Rows[i]["cType"] + "：<em>￥" + dt.Rows[i]["iCost"] + "元</em><div class=\"projecttips\"><em></em>" + dt.Rows[i]["cComment"] + "</div></label></li>");
                        }
                        else
                        {
                            sb.AppendLine("<li class=\"pout4\"><input type=\"radio\" name=\"project\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + dt.Rows[i]["iScore"] + "\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\">" + dt.Rows[i]["cType"] + "：<em>￥" + dt.Rows[i]["iCost"] + "元</em></label></li>");
                        }
                    }
                    continue;
                }
            }
            item = sb.ToString();
            if (CurrentUser == null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
                return;
            }
            iScore = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId);
            DBM4.tblRACE_SIGNUP model = new DB4.tblRACE_SIGNUP().GetCompeteModel(id);
            if (model == null)
            {
                AlertHelper.JQAlertGo("该赛事不存在！", "/user/" + CurrentUser.uId.ToString() + ".aspx", false);
                return;
            }
            if (DateTime.Compare(DateTime.Now, TypeChangeDefault.NullToDateTime(model.dJoinEnd, DateTime.Now.AddDays(-1))) > 0)
            {
                AlertHelper.JQAlertGo("报名已过期请,选择其他的赛事！", "/Channels/Competetion/RaceList.aspx", false);
                return;
            }
            int state = new DB4.tblRACE_SALES().GetState(CurrentUser.uId, id);
            if (0 == state)
            {
                AlertHelper.JQAlertGo("正在审核中,请审核通过后付款！", "/blog/" + model.idBlog + ".aspx", false);
                return;
            }
            else if (1 == state)
            {
                DBM4.tblRACE_SALES mSale = new DB4.tblRACE_SALES().GetModel(id, CurrentUser.uId);
                if (mSale != null)
                {
                    Response.Redirect("/Channels/Competetion/RacePay.aspx?orderid=" + mSale.idOrder);
                }
                else
                {
                    AlertHelper.JQAlertGo("出错了，请重新报名！", "/blog/" + model.idBlog + ".aspx", false);
                    return;
                }
            }
            else if (2 == state)
            {
                AlertHelper.JQAlertGo("您已报名！", "/user/" + CurrentUser.uId.ToString() + ".aspx", false);
                return;
            }
            else if (3 == state)
            {
                AlertHelper.JQAlertGo("您已组队！", "/infocenter/Competition.aspx?uId=" + CurrentUser.uId.ToString(), false);
                return;
            }
        }
    }

    /// <summary>
    /// 获取中英文对照字典
    /// </summary>
    public static Dictionary<string, string> Getcn_en(string en)
    {
        string CacheKey = "GetVersion-" + en;
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);      
        if (objModel == null)
        {
            try
            {
                Dictionary<string, string> version = new Dictionary<string, string>();
                string xmlPath = HttpContext.Current.Server.MapPath("/XML/Race.xml");
                XDocument doc = XDocument.Load(xmlPath);
                var language = en;
                var tipList = doc.Descendants("text");
                foreach (var item in tipList)
                {
                    version.Add(item.Element("id").Value, HTMLHelper.ZipHtml(item.Element(language).Value));
                }
                objModel = version;
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch { }
        }
        return (Dictionary<string, string>)objModel;
    }
}