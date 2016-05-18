using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using Erun360.BLL;

public partial class infocenter_ClubSearch : PageBase
{
    public string cityid = string.Empty;
    public string areaid = string.Empty;
    public string time = string.Empty;
    public string game = string.Empty;
    public string level = string.Empty;
    public string km = string.Empty;
    public string features = string.Empty;
    public string key = string.Empty;

    //private int cId = 0;
    public int gId = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser != null)
        {
            gId = CurrentUser.uId;
        }
        //if (CurrentUser != null)
        //{
        //    cId = CurrentUser.uId;
        //}
        //city=北京&cityid=1&key=ee&areaid=1&time=0&game=0&level=0&km=0&features=0
        StringBuilder sb = new StringBuilder();

        if (Request.QueryString["cityid"] != null)
        {
            cityid = Request.QueryString["cityid"].ToString();//PadLeft(6,'0');
        }
        if (Request.QueryString["areaid"] != null)
        {
            areaid = Request.QueryString["areaid"].ToString();
            if (areaid == "0")
            {
                sb.Append(" idCity like '" + cityid + "%'");
            }
            else
            {
                sb.Append(" idCity = '" + cityid + areaid.PadLeft(2, '0') + "'");
            }

        }
        if (Request.QueryString["time"] != null)
        {
            time = Request.QueryString["time"].ToString();
            sb.Append(" datediff(week,dOpen,getdate())=0 ");//本周内
        }
        if (Request.QueryString["game"] != null)
        {
            game = Request.QueryString["game"].ToString();
            if (game != "0")
            {
                sb.Append(" idRoadStyle = '" + game + "'");
            }
        }
        if (Request.QueryString["level"] != null)
        {
            level = Request.QueryString["level"].ToString();
            if (level != "0")
            {
                sb.Append(" iStrength = '" + level + "'");
            }
        }
        if (Request.QueryString["km"] != null)
        {
            km = Request.QueryString["km"].ToString();
            if ("0" != km)
            {
                switch (km)
                {
                    case "0": sb.Append(" iDistance = '" + km + "'"); break;
                    case "1": break;
                    case "2": break;
                    case "3": break;
                }
            }

        }
        if (Request.QueryString["features"] != null)
        {
            features = Request.QueryString["features"].ToString();
            if ("100" != features)
            {
                sb.Append(" iWinner = '" + features + "'");
            }
        }
        if (Request.QueryString["key"] != null)
        {
            //key = Request.QueryString["key"].ToString();
            key = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(Request.QueryString["key"].ToString()), "");
            if (key.Trim().Length > 0)
            {
                sb.Append(" cContent like '%" + key + "%'");
                sb.Append(" cTitle like '%" + key + "%'");
            }
        }
        
         
    }
}