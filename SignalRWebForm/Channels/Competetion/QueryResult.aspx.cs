using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using Utils;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;

public partial class Channels_Competetion_QueryResult : System.Web.UI.Page
{
    public int idRace = 0;
    public string name = string.Empty;
    private string idcard = string.Empty;
    public string RaceName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["opt"], 0);
        name = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(Request.QueryString["name"]), "");
        idcard = TypeChangeDefault.NullToString(Request.QueryString["idcard"], "");
        Dictionary<string, string> dict = GetRaceImg(idRace);
        ltlImg.Text = "<img src=\"" + dict.FirstOrDefault(d => d.Key == idRace.ToString()).Value + "\"/>";
        if (idRace == 0)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "/Channels/Competetion/RaceQuery.aspx", false);
            return;
        }
        if (name.Trim().Length == 0)
        {
            AlertHelper.JQAlertGo("请填写名称！", "/Channels/Competetion/RaceQuery.aspx", false);
            return;
        }
        if (idcard.Trim().Length == 0)
        {
            AlertHelper.JQAlertGo("请填写证件号码！", "/Channels/Competetion/RaceQuery.aspx", false);
            return;
        }
        if (!IsPostBack)
        {
            DataTable dt = new DB4.tblRaceResult().GetResult(idRace.ToString(), name.Trim(), idcard.Trim()).Tables[0];
            if (dt.Rows.Count > 0)
            {
                RaceName = dt.Rows[0]["cTitle"].ToString();
                ltlName.Text = dt.Rows[0]["cName"].ToString();
                ltlTime.Text = dt.Rows[0]["cResult"].ToString();
                ltlItem.Text = dt.Rows[0]["cGroup"].ToString();
                ltlRank.Text = dt.Rows[0]["iRank"].ToString();
                ltlBib.Text = dt.Rows[0]["cBib"].ToString();
                ltlGroupRank.Text = dt.Rows[0]["iGroupRank"].ToString();

                string result = dt.Rows[0]["cResult"].ToString();
                DataTable dtgroup = new DB4.RaceItemResult().GetResult(idRace.ToString(), ltlBib.Text.Trim(), " cBib ").Tables[0];
                if (dtgroup.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                        ltlResult.Text += "<li>" + dtgroup.Rows[0]["cItem"].ToString() + "</li><li>" + dtgroup.Rows[0]["cResult"].ToString() + "</li>";
                }
                if (idRace == 300000459)//2014首届滕州微山湖湿地马拉松赛
                {
                    ltlResult.Text += "<li>42KM</li><li>" + dt.Rows[0]["cResult"].ToString() + "</li>";
                }
                else if (idRace == 300000485)//益跑网华南区「跑赢世界杯」主题夜跑
                {
                    ltlResult.Text += "<li>21.2KM</li><li>" + dt.Rows[0]["cResult"].ToString() + "</li>";
                }               
                else if (idRace == 300000490)//2014福建乡村越野跑-五夫站
                {
                    ltlResult.Text += "<li>" + dt.Rows[0]["cGroupName"].ToString() + "</li><li>" + dt.Rows[0]["cResult"].ToString() + "</li>";
                }
                else if (idRace == 300000491)//益跑华南区主办「广州之巅挑战赛」
                {
                    ltlResult.Text += "<li>" + dt.Rows[0]["cGroupName"].ToString() + "</li><li>" + dt.Rows[0]["cResult"].ToString() + "</li>";
                }
            }
            else
            {
                AlertHelper.JQAlertGo("您查询的用户不存在！", "/Channels/Competetion/RaceQuery.aspx", false);
                return;
            }
        }
    }
    /// <summary>
    /// 获取赛事图片路径
    public static Dictionary<string, string> GetRaceImg(int idRace)
    {
        string CacheKey = "GetRaceimg";
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        objModel = null;
        if (objModel == null)
        {
            try
            {
                Dictionary<string, string> version = new Dictionary<string, string>();
                string xmlPath = HttpContext.Current.Server.MapPath("/XML/RaceConfig.xml");
                XDocument doc = XDocument.Load(xmlPath);
                var language = "Img";
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