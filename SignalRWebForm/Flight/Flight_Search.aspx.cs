using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM6 = Erun360.Model.DB6;
using DB6 = Erun360.BLL.DB6;
using System.IO;
using System.Text;
using System.Runtime.Serialization.Json;
using Erun360.Common;
using System.Net;
using System.Data;
using DB1 = Erun360.BLL.DB1;
using System.Xml;
using Com.Alipay;
using Utils;
public partial class Flight_Flight_Search : PageBase
{
    protected string Action = "";
    public int iScore = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {            
            if (CurrentUser != null)
            {
                iScore = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId);
                DataTable dt = new DB6.tblPassenger().GetList("idUser=" + CurrentUser.uId).Tables[0];
                foreach (DataRow dr in dt.Rows)
                {
                    ltlInfo.Text += "<label><input type=\"checkbox\" data-fristname=\"" + dr["csurname"].ToString() + "\" data-lastname=\"" + dr["cname"].ToString() + "\" data-idtype=\"" + dr["IdType"].ToString() + "\" data-IdNo=\"" + dr["IdNo"].ToString() + "\" data-Phone=\"" + dr["Phone"].ToString() + "\" >" + dr["csurname"].ToString() + dr["cname"].ToString() + "</label>";
                }
                ltlcontactName.Text = "<input type=\"text\" name=\"contactName\" class=\"contactName\"  value=\"" + CurrentUser.cName + "\">";
                ltlcontactTel.Text = "<input type=\"text\" name=\"contactTel\" class=\"contactTel\"  value=\"" + CurrentUser.cMobile + "\">";
                ltlemail.Text = "<input type=\"text\" name=\"email\" class=\"email\"  value=\"" + CurrentUser.cMail + "\">";
                ltlcontactAdd.Text = "<input type=\"text\" name=\"contactAdd\" class=\"contactAdd\"  value=\"" + CurrentUser.cAddress + "\">"; 
            }            
        }
    }
   
}
