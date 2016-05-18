using System;
using System.Collections.Generic;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using System.Data;
using System.Text;
using System.Collections;
using Newtonsoft.Json;
using DB1 = Erun360.BLL.DB1;
public partial class Competetion_tourinfo : PageBase
{
    public int sid = 0;
    public string title = string.Empty;
    public int id = 0;
    public string subtitle = string.Empty;
    public int idUser = 0;
    public string colorjson = string.Empty;
    public string sizejson = string.Empty;
    public int iBuyMax = 0;
    public int iScore = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition model = new DB6.tblRace_Competition().GetModel(sid);
            if (model == null)
            {
                AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
                return;
            }
            if (CurrentUser != null)
            {
                idUser = CurrentUser.uId;
            }
            if (model.idUser != idUser || idUser != 100000002)
            {
                if (1 != model.iStatus)
                {
                    AlertHelper.JQAlertGo("该赛事已关闭！", "/Competetion/SearchEvent.aspx", false);
                    return;
                }
            }
            iScore = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + idUser, idUser);
            title = model.cTitle;
            ltlbanner.Text = model.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + model.cBanner + "\"  alt=\"\"/>";
            if (id == 0)
            {
                AlertHelper.JQAlertGo("该装备不存在！", "/Competetion/tour.aspx?sid=" + sid + "&nav=8", false);
                return;
            }
            DB6.tbltour bll = new DB6.tbltour();
            DBM6.tbltour modelEquip = bll.GetModel(id);
            DB6.tbltour_Item bllitem = new DB6.tbltour_Item();
            StringBuilder sb = new StringBuilder();
           
            if (modelEquip != null)
            {
                subtitle = modelEquip.cName;
                ltltu.Text = "<h1>" + modelEquip.cName + "</h1><img src=\"" + modelEquip.cImage + "\" class=\"eqinbigthumb\" >";
                DataTable dt = bllitem.GetList("idEquipment=" + id).Tables[0];
                Hashtable size = null;
                List<Hashtable> sizeList = new List<Hashtable>();
                Hashtable color = null;
                List<Hashtable> colorList = new List<Hashtable>();
                Dictionary<String, String> pColor = new Dictionary<String, String>();
                Dictionary<String, String> pSize = new Dictionary<String, String>();
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (pColor.ContainsKey(dt.Rows[i]["cColor"].ToString()) == false)
                        {
                            pColor.Add(dt.Rows[i]["cColor"].ToString(), dt.Rows[i]["cColor"].ToString());
                            color = new Hashtable();
                            color.Add("Color", dt.Rows[i]["cColor"].ToString());
                            color.Add("cURL", dt.Rows[i]["cURL"].ToString());
                            color.Add("cSize", bllitem.GetSizeByColor("cColor = '" + dt.Rows[i]["cColor"].ToString() + "' and idEquipment=" + id, "id").Tables[0]);
                            colorList.Add(color);
                        }
                        if (pSize.ContainsKey(dt.Rows[i]["cSize"].ToString()) == false)
                        {
                            pSize.Add(dt.Rows[i]["cSize"].ToString(), dt.Rows[i]["cSize"].ToString());
                            size = new Hashtable();
                            size.Add("cSize", dt.Rows[i]["cSize"].ToString());
                            size.Add("cColor", bllitem.GetColorBySize("cSize = '" + dt.Rows[i]["cSize"].ToString() + "' and idEquipment=" + id, "id").Tables[0]);
                            sizeList.Add(size);
                        }
                    }
                }
                colorjson = JsonConvert.SerializeObject(colorList);
                sizejson = JsonConvert.SerializeObject(sizeList);
                ltlprice.Text = "市场价格：<i>&yen;" + TypeChangeDefault.NullToInt(bllitem.MaxPrice(id), 0) + "</i> 益跑价格：<em>&yen;" + bllitem.MinPrice(id) + "</em>";
                iBuyMax = modelEquip.iBuyMax ?? 0;
                if (modelEquip.cBio.Length > 0)
                    ltljs.Text = "<h4>产品介绍</h4>" + modelEquip.cBio + "<hr>";
                if (modelEquip.cReason.Length > 0)
                    ltlyy.Text = "<h4>推荐原因</h4>" + modelEquip.cReason + "<hr>";
                if (modelEquip.cNorm.Length > 0)
                    ltltd.Text = "<h4>特点</h4>" + modelEquip.cNorm + "<hr>";

                DataTable dtuser = new DB6.tblPassenger().GetList("idUser=" + idUser).Tables[0];
                StringBuilder sbUser = new StringBuilder();
                if (dtuser.Rows.Count > 0)
                {
                    for (int g = 0; g < dtuser.Rows.Count; g++)
                    {
                        if (g == 0)
                        {
                            sbUser.AppendLine("<div class=\"equipop\">选择常用联系人： <br>");
                        }

                        sbUser.AppendLine("<label><input type=\"radio\" data-id=\"" + dtuser.Rows[g]["id"].ToString() + "\" data-fristname=\"" + dtuser.Rows[g]["csurname"].ToString() + "\" data-lastname=\"" + dtuser.Rows[g]["cname"].ToString() + "\" data-tel=\"" + dtuser.Rows[g]["Phone"].ToString() + "\" data-add=\"" + dtuser.Rows[g]["cAddress"].ToString() + "\" name=\"lxr\"> " + dtuser.Rows[g]["cFullname"].ToString() + "</label>");
                        if (g == dtuser.Rows.Count - 1)
                        {
                            sbUser.AppendLine("</div>");
                        }
                    }
                }
                ltlInfo.Text = sbUser.ToString();
            }
        }
    }
}
