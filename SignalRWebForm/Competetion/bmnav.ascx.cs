using Erun360.BLL;
using Erun360.Model;
using ERUN360.Entity;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM6 = Erun360.Model.DB6;
using DB6 = Erun360.BLL.DB6;
using System.Data;

public partial class Controls_bmnav : PageBaseCtrl
{
    public int idRace = 0;
    private int nav = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        nav = TypeChangeDefault.NullToInt(Request.QueryString["nav"], 0);
        if (!IsPostBack)
        {
            //DBM6.tblRace_Competition cmodel = new DB6.tblRace_Competition().GetModel(idRace);
            //if (cmodel != null)
            //{
            //    ltlbanner.Text = " <h1>"+cmodel.cTitle+"</h1>";
            //    ltlbanner.Text += cmodel.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + cmodel.cBanner + "\" alt=\"\"/>";
            //}
            string rights = "1,2,12";
            DBM6.tblRace_Nav model = new DB6.tblRace_Nav().GetModel(idRace);
            if (model != null)
            {
                if (model.cRight.Length != 0)
                {
                    rights = model.cRight;
                }
            }
          
            DataTable dt = new DB6.tblRace_Nav_Config().GetList(0, "(iAuto =1) or id in(" + rights + ") ", "iSort").Tables[0];
            for (int j = 0; j < dt.Rows.Count; j++)
            {
                if (nav == TypeChangeDefault.NullToInt(dt.Rows[j]["id"].ToString().Trim(), 0))
                {
                    ltlNav.Text += "<a  class=\"this\" href=\"" + dt.Rows[j]["cLinkUrl"].ToString().Trim() + idRace + "&nav=" + dt.Rows[j]["id"].ToString() + "\">" + dt.Rows[j]["cName"].ToString().Trim() + "</a>";
                }
                else
                {
                    ltlNav.Text += "<a href=\"" + dt.Rows[j]["cLinkUrl"].ToString().Trim() + idRace + "&nav=" + dt.Rows[j]["id"].ToString() + "\">" + dt.Rows[j]["cName"].ToString().Trim() + "</a>";
                }
            }
            DBM6.tblRace_Competition modelrace = new DB6.tblRace_Competition().GetModel(idRace);
            if (modelrace != null)
            {
                int idUser = 0;
                if (CurrentUser != null)
                {
                    idUser = CurrentUser.uId;
                }
                if (idUser == 100000002 || idUser == modelrace.idUser)
                {
                    if (nav == 99)
                    {
                        ltladmin.Text = "<a  class=\"this\" href=\"/Competetion/RaceCom.aspx?sid=" + idRace + "&nav=99\">赛事管理</a>";
                    }
                    else
                    {
                        ltladmin.Text = "<a href=\"/Competetion/RaceCom.aspx?sid=" + idRace + "&nav=99\">赛事管理</a>";
                    }
                    LitOrder.Text = "<a href=\"/Admin/RaceJion.aspx?idRace=" + idRace + " \" target=\"_blank\">报名记录</a>";
                }
            }
        }
    }
}