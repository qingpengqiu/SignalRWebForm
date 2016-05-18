using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Xml.Linq;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using System.Collections;

public partial class Competetion_projects2 : PageBase
{
    public int idItem = 0;//项目id
    public int sid = 0;//赛事id
    public string la = string.Empty;//语言
    public int iFlag = 0;//是否使用积分1使用
    public string iCity = string.Empty;//
    public string iArea = string.Empty;
    public string Result = string.Empty;
    public string title = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        idItem = TypeChangeDefault.NullToInt(Request.QueryString["p"], 0);
        la = TypeChangeDefault.NullToString(Request.QueryString["la"], "cn");
        iFlag = TypeChangeDefault.NullToInt(Request.QueryString["jf"], 0);
        la = la == "en" ? "en" : "cn";
        if (sid == 0)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
            return;
        }
        if (idItem == 0)
        {
            AlertHelper.JQAlertGo("请选择比赛项目！", "/Competetion/projects.aspx?sid=" + sid + "&nav=2&la=" + la, false);
            return;
        }
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
            //AlertHelper.JQAlertGo("您无权访问此页！", "/Competetion/projects.aspx?sid=" + sid + "&nav=2&la=" + la, false);
            //return;
        }
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition model = new DB6.tblRace_Competition().GetModel(sid);
            if (model == null)
            {
                AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
                return;
            }
            if (model.dJoinBegin > DateTime.Now)
            {
                AlertHelper.JQAlertGo("赛事报名未开始,敬请关注！！", "/Competetion/projects.aspx?sid=" + sid + "&nav=2&la=" + la, false);
                return;
            }
            if (DateTime.Now > model.dJoinEnd)
            {
                AlertHelper.JQAlertGo("赛事报名已过期！", "/Competetion/projects.aspx?sid=" + sid + "&nav=2&la=" + la, false);
                return;
            }
            int idUser = 0;
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
            title = model.cTitle;
            this.page_Title = title+"-赛事介绍-益跑网赛事报名";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            ltlbanner.Text = model.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + model.cBanner + "\" alt=\"\"/>";
            ////国内赛事
            if (model.iType == 1)
            {
                Initialize(la, 1);
            }
            else if (model.iType >= 2)
            {
                Initialize(la, 2);
            }
            if (model.iStatus != 1)
            {
                AlertHelper.JQAlertGo("该赛事已关闭！", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            //if (DateTime.Compare(DateTime.Now, TypeChangeDefault.NullToDateTime(model.dJoinBegin, DateTime.Now.AddDays(-1))) < 0)
            //{
            //    AlertHelper.JQAlertGo("报名还没开始,敬请关注！", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            //    return;
            //}
            //if (DateTime.Compare(DateTime.Now, TypeChangeDefault.NullToDateTime(model.dJoinEnd, DateTime.Now.AddDays(-1))) > 0)
            //{
            //    AlertHelper.JQAlertGo("报名已过期！", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            //    return;
            //}
            DB6.tblRace_Item bllItem = new DB6.tblRace_Item();
            DBM6.tblRace_Item modelItem = bllItem.GetModel(idItem);
            if (modelItem == null)
            {
                AlertHelper.JQAlertGo("赛事项目不存在！", "/Competetion/projects.aspx?sid=" + sid + "&nav=2&la=" + la, false);
                return;
            }
            if (modelItem.idCompete != sid)
            {
                AlertHelper.JQAlertGo("非法操作，系统已记录！", "/Competetion/projects.aspx?sid=" + sid + "&nav=2&la=" + la, false);
                return;
            }
            if (modelItem.dJoinBegin > DateTime.Now)
            {
                AlertHelper.JQAlertGo("报名还没开始,敬请关注!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            if (DateTime.Now > modelItem.dJoinEnd)
            {
                AlertHelper.JQAlertGo("报名已截止!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            //20150708 更改库存数量（有从订单查询改为从库存中判断）add
            if (modelItem.iLimit <= 0)
            {
                AlertHelper.JQAlertGo("报名已满，请选择其他项目！", "/Competetion/projects.aspx?sid=" + sid + "&nav=2&la=" + la, false);
                return;
            }
            int countNum = new DB6.tblOrder().GetRecordCount("iFromTpye =2 and iStatus>-1 and iItemID='" + idItem + "' and iTypeID='" + sid + "' and idUser=" + CurrentUser.uId);
            if (countNum > 0)
            {
                AlertHelper.JQAlertGo("您已报名或未付款或等待审核！", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;

            }
        }

    }
    protected void Initialize(string la, int type)
    {
        string cHealthUrl = string.Empty;
        Dictionary<string, string> dict = Getcn_en(la);
        StringBuilder sb = new StringBuilder();
        if (type == 1)
        {
            #region 国内赛事用户报名信息
            DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(CurrentUser.uId);
            
            string[] Contact = TypeChangeDefault.NullToString(user.cEmergerContact, "").Trim().Split('|');
            string emerger = string.Empty;
            string emermobile = string.Empty;
            if (Contact.Length > 1)
            {
                emerger = Contact[0];
                emermobile = Contact[1];
            }
            cHealthUrl = TypeChangeDefault.NullToString(user.cHealthUrl, "");
            //姓名
            sb.AppendLine("<div class=\"bmtd\"><span><label for=\"name\">" + dict.FirstOrDefault(d => d.Key == "name").Value + "</label></span> <em> <input type=\"text\"   value=\"" + user.cName + "\" maxlength=\"16\" id=\"name\" name=\"name\" datatype=\"*1-30\" errormsg=\"请填写真实姓名\" nullmsg=\"请填写真实姓名\" /><div class=\"Validform_checktip\"></div></em></div>");

            sb.AppendLine(cGender(dict.FirstOrDefault(d => d.Key == "idGender").Value, user.idGender ?? 0)); //性别
            sb.AppendLine(idBlood(dict.FirstOrDefault(d => d.Key == "idBlood").Value, user.idBlood ?? 0));//血型
            //出生日期
            sb.AppendLine("<div class=\"bmtd\"> <span><label for=\"dBirthday\">" + dict.FirstOrDefault(d => d.Key == "dBirthday").Value + "</label></span> <em><input type=\"text\" name=\"dBirthday\" id=\"dBirthday\" value=\"" + TypeChangeDefault.NullToDateTime(user.dBirthday, DateTime.Now).ToString("yyyy-MM-dd") + "\" onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'" + DateTime.Now.AddYears(-100).ToString("yyyy-MM-dd") + "',maxDate:'" + DateTime.Now.ToString("yyyy-MM-dd") + "'})\" /></em></div>");
            //学历
            sb.AppendLine(Education(dict.FirstOrDefault(d => d.Key == "idEducation").Value, user.idEducation ?? 0));//学历
            //职业类型
            sb.AppendLine(BindIdOccupation(la, dict.FirstOrDefault(d => d.Key == "idOccupation").Value, user.idOccupation ?? 0));//职业类型


            //证件类型
            sb.AppendLine(IdType(dict.FirstOrDefault(d => d.Key == "IdType").Value, user.idNationIDType ?? 0));//证件类型
            sb.AppendLine(" <input type=\"text\"  id=\"IdNo\" name=\"IdNo\"  maxlength=\"24\"  value=\"" + user.cNationID + "\" />");
            sb.AppendLine("<div class=\"Validform_checktip\"></div></em></div>");

            //国籍
            sb.AppendLine("<div class=\"bmtd\"><span><label for=\"cNational\">" + dict.FirstOrDefault(d => d.Key == "cNational").Value + "</label></span><em><input type=\"text\" name=\"cNational\" id=\"cNational\" value=\"中国\" /> <div class=\"Validform_checktip\"></div></em>  </div>");
            //手机号
            sb.AppendLine("<div class=\"bmtd\"> <span><label for=\"cMobile\">" + dict.FirstOrDefault(d => d.Key == "cMobile").Value + "</label> </span> <em> <input type=\"text\" name=\"cMobile\" id=\"cMobile\" value=\"" + user.cMobile + "\"   maxlength=\"11\" /> <div class=\"Validform_checktip\"></div>  </em></div>");

            //邮箱
            sb.AppendLine("<div class=\"bmtd\"> <span><label for=\"cMail\">" + dict.FirstOrDefault(d => d.Key == "cMail").Value + "</label></span> <em> <input type=\"text\" name=\"cMail\" id=\"cMail\" value=\"" + user.cMail + "\" maxlength=\"64\" /><div class=\"Validform_checktip\"></div></em></div>");

            //地址
            if (TypeChangeDefault.NullToString(user.idCity, "0").Length == 3)
            {
                iCity = TypeChangeDefault.NullToString(user.idCity, "0").Trim().Substring(0, 1);
                iArea = TypeChangeDefault.NullToString(user.idCity, "0").Substring(1, 2);
            }
            else if (TypeChangeDefault.NullToString(user.idCity, "0").Length == 4)
            {
                iCity = TypeChangeDefault.NullToString(user.idCity, "0").Trim().Substring(0, 2);
                iArea = TypeChangeDefault.NullToString(user.idCity, "0").Substring(2, 2);
            }
            sb.AppendLine("<div class=\"bmtd addressw\"><span><label for=\"cAddress\">" + dict.FirstOrDefault(d => d.Key == "cAddress").Value + "</label></span><em>");
            sb.AppendLine("<select name=\"ddlProvince\" id=\"ddlProvince\" onchange=\"selectMoreCity(this)\"></select>");
            sb.AppendLine("<select name=\"ddlCity\" id=\"ddlCity\" onchange=\"selectOneCity(this)\"></select>");
            sb.AppendLine("<script type=\"text/javascript\"> BindProvince(\"北京\");</script>");
            sb.AppendLine("<input type=\"hidden\" id=\"idCity\" name=\"idCity\" size=\"5\" style=\"width: 30px\" value=\"" + TypeChangeDefault.NullToString(user.idCity, "") + "\" />");
            sb.AppendLine("<input type=\"text\" value=\"\" style=\"display: none\" size=\"15\" id=\"cCityname\" name=\"cCityname\" value=\"" + TypeChangeDefault.NullToString(user.cCityname, "") + "\"  />");
            sb.AppendLine("<input type=\"hidden\" id=\"UpdatedFields\" name=\"UpdatedFields\" value=\"\" />");
            sb.AppendLine("<input type=\"text\" name=\"address\" id=\"address\" value=\"" + user.cAddress + "\" maxlength=\"128\" />");
            sb.AppendLine("<div class=\"Validform_checktip\"></div></em></div>");
            

            //邮编
            sb.AppendLine("<div class=\"bmtd\"><span><label for=\"cZipcode\">" + dict.FirstOrDefault(d => d.Key == "cZipcode").Value + "</label></span><em><input type=\"text\" name=\"cZipcode\" id=\"cZipcode\" value=\"" + user.cZipcode + "\"  maxlength=\"6\" /><div class=\"Validform_checktip\"></div></em>");

            //紧急联系人
            sb.AppendLine("</div><div class=\"bmtd\"><span><label for=\"emerger\">" + dict.FirstOrDefault(d => d.Key == "emerger").Value + "</label></span><em><input type=\"text\" name=\"emerger\" id=\"emerger\" value=\"" + emerger + "\"  maxlength=\"30\" /><div class=\"Validform_checktip\"></div> </em></div>");

            //紧急联系人手机
            sb.AppendLine("<div class=\"bmtd\"><span class=\"sosp\"><label for=\"emermobile\">" + dict.FirstOrDefault(d => d.Key == "emermobile").Value + "</label></span><em><input type=\"text\" name=\"emermobile\" id=\"emermobile\" value=\"" + emermobile + "\"  maxlength=\"30\" /><div class=\"Validform_checktip\"></div></em></div>");
            #endregion
        }
        else 
        {
            #region 国外赛事用户报名信息
            DBM1.tblMember_Partner user = new DB1.tblMember_Partner().GetModel(CurrentUser.uId);
            if (user != null)
            {
                string[] Contact = TypeChangeDefault.NullToString(user.cEmergerContact, "").Trim().Split('|');
                string emerger = string.Empty;
                string emermobile = string.Empty;
                if (Contact.Length > 1)
                {
                    emerger = Contact[0];
                    emermobile = Contact[1];
                }
                cHealthUrl = TypeChangeDefault.NullToString(user.cHealthUrl, "");
                sb.Append("<div class=\"bmtd\"><span><label for=\"name\">" + dict.FirstOrDefault(d => d.Key == "xing").Value + "</label></span> <em> <input type=\"text\"   value=\"" + user.csurname + "\" maxlength=\"16\" id=\"csurname\" name=\"csurname\" datatype=\"*1-30\" errormsg=\"请填写真实姓名\" nullmsg=\"请填写真实姓名\" /><div class=\"Validform_checktip\"></div></em></div>");
                sb.Append("<div class=\"bmtd\"><span><label for=\"name\">" + dict.FirstOrDefault(d => d.Key == "ming").Value + "</label></span> <em> <input type=\"text\"   value=\"" + user.cname + "\" maxlength=\"16\" id=\"name\" name=\"name\" datatype=\"*1-30\" errormsg=\"请填写真实姓名\" nullmsg=\"请填写真实姓名\" /><div class=\"Validform_checktip\"></div></em></div>");

                sb.AppendLine(cGender(dict.FirstOrDefault(d => d.Key == "idGender").Value, user.idGender ?? 0)); //性别
                sb.AppendLine(idBlood(dict.FirstOrDefault(d => d.Key == "idBlood").Value, user.idBlood ?? 0));//血型
                //出生日期
                sb.AppendLine("<div class=\"bmtd\"> <span><label for=\"dBirthday\">" + dict.FirstOrDefault(d => d.Key == "dBirthday").Value + "</label></span> <em><input type=\"text\" name=\"dBirthday\" id=\"dBirthday\" value=\"" + TypeChangeDefault.NullToDateTime(user.dBirthday, DateTime.Now).ToString("yyyy-MM-dd") + "\" onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'" + DateTime.Now.AddYears(-100).ToString("yyyy-MM-dd") + "',maxDate:'" + DateTime.Now.ToString("yyyy-MM-dd") + "'})\" /></em></div>");
                //学历
                sb.AppendLine(Education(dict.FirstOrDefault(d => d.Key == "idEducation").Value, user.idEducation ?? 0));//学历

                //国籍
                sb.AppendLine("<div class=\"bmtd\"><span><label for=\"cNational\">" + dict.FirstOrDefault(d => d.Key == "cNational").Value + "</label></span><em><input type=\"text\" name=\"cNational\" id=\"cNational\" value=\"中国\"/> <div class=\"Validform_checktip\"></div></em>  </div>");

                //证件类型
                sb.AppendLine("<div class=\"bmtd\"><span><label for=\"idtype\">" + dict.FirstOrDefault(d => d.Key == "huzhao").Value + "</label></span><em>");
                sb.AppendLine(" <input type=\"text\"   name=\"IdNo\"  id=\"IdNo\" class=\"span2\" maxlength=\"24\"  value=\"" + user.cNationID + "\" />");
                sb.AppendLine("<div class=\"Validform_checktip\"></div></em></div>");

                // 护照签发地点：
                sb.AppendLine("<div class=\"bmtd\"><span><label for=\"Placeofissue\">" + dict.FirstOrDefault(d => d.Key == "Placeissue").Value + "</label></span><em>");
                sb.AppendLine(" <input type=\"text\"  name=\"Placeofissue\" id=\"Placeofissue\" class=\"span2\" maxlength=\"24\"  value=\"" + user.cPlace + "\" />");
                //sb.AppendLine("<input type=\"text\" name=\"Placeofissue\" id=\"Placeofissue\" datatype=\"*\" errormsg=\"护照签发地点必填\" nullmsg=\"护照签发地点必填\"/>");
                sb.AppendLine("<div class=\"Validform_checktip\"></div></em></div>");

                //护照签发日期：
                sb.AppendLine("<div class=\"bmtd\"><span><label for=\"Dateofissue\">" + dict.FirstOrDefault(d => d.Key == "Dateissue").Value + "</label></span><em>");
                sb.AppendLine("<input type=\"text\" name=\"Dateofissue\" id=\"Dateofissue\" value=\"" + TypeChangeDefault.NullToDateTime(user.dIssue, DateTime.Now).ToString("yyyy-MM-dd") + "\" onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'" + DateTime.Now.AddYears(-10).ToString("yyyy-MM-dd") + "',maxDate:'" + DateTime.Now.ToString("yyyy-MM-dd") + "'})\" />");
                sb.AppendLine("<div class=\"Validform_checktip\"></div></em></div>");

                //有效期至：：
                sb.AppendLine("<div class=\"bmtd\"><span><label for=\"Dateofexpiry\">" + dict.FirstOrDefault(d => d.Key == "Dateexpiry").Value + "</label></span><em>");
                sb.AppendLine("<input type=\"text\" name=\"Dateofexpiry\" id=\"Dateofexpiry\" value=\"" + TypeChangeDefault.NullToDateTime(user.dExpiry, DateTime.Now).ToString("yyyy-MM-dd") + "\" onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'" + DateTime.Now.ToString("yyyy-MM-dd") + "',maxDate:'" + DateTime.Now.AddYears(10).ToString("yyyy-MM-dd") + "'})\" />");
                //minDate:'2006-09-10',maxDate:'2008-12-20'}  onclick=\"WdatePicker()\"
                sb.AppendLine("<div class=\"Validform_checktip\"></div></em></div>");

                //手机号
                sb.AppendLine("<div class=\"bmtd\"> <span><label for=\"cMobile\">" + dict.FirstOrDefault(d => d.Key == "cMobile").Value + "</label> </span> <em> <input type=\"text\" name=\"cMobile\" id=\"cMobile\" value=\"" + user.cMobile + "\" maxlength=\"11\" /> <div class=\"Validform_checktip\"></div>  </em></div>");

                //邮箱
                sb.AppendLine("<div class=\"bmtd\"> <span><label for=\"cMail\">" + dict.FirstOrDefault(d => d.Key == "cMail").Value + "</label></span> <em> <input type=\"text\" name=\"cMail\" id=\"cMail\" value=\"" + user.cMail + "\"  maxlength=\"64\" /><div class=\"Validform_checktip\"></div></em></div>");

                //职业类型
                sb.AppendLine(BindIdOccupation(la, dict.FirstOrDefault(d => d.Key == "idOccupation").Value, user.idOccupation ?? 0));//职业类型

                //地址
                if (TypeChangeDefault.NullToString(user.idCity, "0").Length == 3)
                {
                    iCity = TypeChangeDefault.NullToString(user.idCity, "0").Trim().Substring(0, 1);
                    iArea = TypeChangeDefault.NullToString(user.idCity, "0").Substring(1, 2);
                }
                else if (TypeChangeDefault.NullToString(user.idCity, "0").Length == 4)
                {
                    iCity = TypeChangeDefault.NullToString(user.idCity, "0").Trim().Substring(0, 2);
                    iArea = TypeChangeDefault.NullToString(user.idCity, "0").Substring(2, 2);
                }
                sb.AppendLine("<div class=\"bmtd addressw\"><span><label for=\"cAddress\">" + dict.FirstOrDefault(d => d.Key == "cAddress").Value + "</label></span><em>");
                sb.AppendLine("<select name=\"ddlProvince\" id=\"ddlProvince\" onchange=\"selectMoreCity(this)\"></select>");
                sb.AppendLine("<select name=\"ddlCity\" id=\"ddlCity\" onchange=\"selectOneCity(this)\"></select>");
                sb.AppendLine("<script type=\"text/javascript\"> BindProvince(\"北京\");</script>");
                sb.AppendLine("<input type=\"hidden\" id=\"idCity\" name=\"idCity\" size=\"5\" style=\"width: 30px\"  value=\"" + TypeChangeDefault.NullToString(user.idCity, "") + "\" />");
                sb.AppendLine("<input type=\"text\" value=\"\" style=\"display: none\" size=\"15\" id=\"cCityname\" name=\"cCityname\" value=\"" + TypeChangeDefault.NullToString(user.cCityname, "") + "\" />");
                sb.AppendLine("<input type=\"hidden\" id=\"UpdatedFields\" name=\"UpdatedFields\" value=\"\" />");
                sb.AppendLine("<input type=\"text\" name=\"address\" id=\"address\" value=\"" + user.cAddress + "\" maxlength=\"128\" />");
                sb.AppendLine("<div class=\"Validform_checktip\"></div></em></div>");

                //邮编
                sb.AppendLine("<div class=\"bmtd\"><span><label for=\"cZipcode\">" + dict.FirstOrDefault(d => d.Key == "cZipcode").Value + "</label></span><em><input type=\"text\" name=\"cZipcode\" id=\"cZipcode\" value=\"" + user.cZipcode + "\"  maxlength=\"6\" /><div class=\"Validform_checktip\"></div></em>");

                //紧急联系人
                sb.AppendLine("</div><div class=\"bmtd\"><span><label for=\"emerger\">" + dict.FirstOrDefault(d => d.Key == "emerger").Value + "</label></span><em><input type=\"text\" name=\"emerger\" id=\"emerger\" value=\"" + emerger + "\" maxlength=\"30\" /><div class=\"Validform_checktip\"></div> </em></div>");

                //紧急联系人手机
                sb.AppendLine("<div class=\"bmtd\"><span class=\"sosp\"><label for=\"emermobile\">" + dict.FirstOrDefault(d => d.Key == "emermobile").Value + "</label></span><em><input type=\"text\" name=\"emermobile\" id=\"emermobile\" value=\"" + emermobile + "\"  maxlength=\"30\" /><div class=\"Validform_checktip\"></div></em></div>");
            }
            else
            {
                sb.Append("<div class=\"bmtd\"><span><label for=\"name\">" + dict.FirstOrDefault(d => d.Key == "xing").Value + "</span> <em> <input type=\"text\"   value=\"\" maxlength=\"16\" id=\"csurname\" name=\"csurname\" datatype=\"*1-30\" errormsg=\"请填写真实姓名\" nullmsg=\"请填写真实姓名\" /><div class=\"Validform_checktip\"></div></em></div>");
                sb.Append("<div class=\"bmtd\"><span><label for=\"name\">" + dict.FirstOrDefault(d => d.Key == "ming").Value + "</span> <em> <input type=\"text\"   value=\"\" maxlength=\"16\" id=\"name\" name=\"name\" datatype=\"*1-30\" errormsg=\"请填写真实姓名\" nullmsg=\"请填写真实姓名\" /><div class=\"Validform_checktip\"></div></em></div>");

                sb.AppendLine(cGender(dict.FirstOrDefault(d => d.Key == "idGender").Value, 0)); //性别
                sb.AppendLine(idBlood(dict.FirstOrDefault(d => d.Key == "idBlood").Value, 0));//血型
                //出生日期            
                sb.AppendLine("<div class=\"bmtd\"> <span><label for=\"dBirthday\">" + dict.FirstOrDefault(d => d.Key == "dBirthday").Value + "</label></span> <em><input type=\"text\" name=\"dBirthday\" id=\"dBirthday\" value=\"" + DateTime.Now.ToString("yyyy-MM-dd") + "\" onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'" + DateTime.Now.AddYears(-100).ToString("yyyy-MM-dd") + "',maxDate:'" + DateTime.Now.ToString("yyyy-MM-dd") + "'})\" /></em></div>");
                //学历
                sb.AppendLine(Education(dict.FirstOrDefault(d => d.Key == "idEducation").Value, 0));//学历

                //国籍
                sb.AppendLine("<div class=\"bmtd\"><span><label for=\"cNational\">" + dict.FirstOrDefault(d => d.Key == "cNational").Value + "</label></span><em><input type=\"text\" name=\"cNational\" id=\"cNational\" value=\"中国\" /> <div class=\"Validform_checktip\"></div></em>  </div>");

                //证件类型
                sb.AppendLine("<div class=\"bmtd\"><span><label for=\"idtype\">" + dict.FirstOrDefault(d => d.Key == "huzhao").Value + "</label></span><em>");
                sb.AppendLine(" <input type=\"text\" name=\"IdNo\"  id=\"IdNo\" class=\"span2\" maxlength=\"24\"  value=\"\" />");
                sb.AppendLine("<div class=\"Validform_checktip\"></div></em></div>");

                // 护照签发地点：
                sb.AppendLine("<div class=\"bmtd\"><span><label for=\"Placeofissue\">" + dict.FirstOrDefault(d => d.Key == "Placeissue").Value + "</label></span><em>");
                sb.AppendLine(" <input type=\"text\" name=\"Placeofissue\" id=\"Placeofissue\" class=\"span2\" maxlength=\"24\"  value=\"\" />");
                //sb.AppendLine("<input type=\"text\" name=\"Placeofissue\" id=\"Placeofissue\" datatype=\"*\" errormsg=\"护照签发地点必填\" nullmsg=\"护照签发地点必填\"/>");
                sb.AppendLine("<div class=\"Validform_checktip\"></div></em></div>");

                //护照签发日期：
                sb.AppendLine("<div class=\"bmtd\"><span><label for=\"Dateofissue\">" + dict.FirstOrDefault(d => d.Key == "Dateissue").Value + "</label></span><em>");
                sb.AppendLine("<input type=\"text\" name=\"Dateofissue\" id=\"Dateofissue\" value=\"" + DateTime.Now.ToString("yyyy-MM-dd") + "\" onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'" + DateTime.Now.AddYears(-10).ToString("yyyy-MM-dd") + "',maxDate:'" + DateTime.Now.ToString("yyyy-MM-dd") + "'})\" />");
                sb.AppendLine("<div class=\"Validform_checktip\"></div></em></div>");

                //有效期至：：
                sb.AppendLine("<div class=\"bmtd\"><span><label for=\"Dateofexpiry\">" + dict.FirstOrDefault(d => d.Key == "Dateexpiry").Value + "</label></span><em>");
                sb.AppendLine("<input type=\"text\" name=\"Dateofexpiry\" id=\"Dateofexpiry\" value=\"" + DateTime.Now.ToString("yyyy-MM-dd") + "\" onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'" + DateTime.Now.ToString("yyyy-MM-dd") + "',maxDate:'" + DateTime.Now.AddYears(10).ToString("yyyy-MM-dd") + "'})\" />");
                sb.AppendLine("<div class=\"Validform_checktip\"></div></em></div>");

                //手机号
                sb.AppendLine("<div class=\"bmtd\"> <span><label for=\"cMobile\">" + dict.FirstOrDefault(d => d.Key == "cMobile").Value + "</label> </span> <em> <input type=\"text\" name=\"cMobile\" id=\"cMobile\" value=\"\" maxlength=\"11\" /> <div class=\"Validform_checktip\"></div>  </em></div>");

                //邮箱
                sb.AppendLine("<div class=\"bmtd\"> <span><label for=\"cMail\">" + dict.FirstOrDefault(d => d.Key == "cMail").Value + "</label></span> <em> <input type=\"text\" name=\"cMail\" id=\"cMail\" value=\"\"  maxlength=\"64\" /><div class=\"Validform_checktip\"></div></em></div>");

                //职业类型
                sb.AppendLine(BindIdOccupation(la, dict.FirstOrDefault(d => d.Key == "idOccupation").Value, 0));//职业类型

                //地址
                sb.AppendLine("<div class=\"bmtd addressw\"><span><label for=\"cAddress\">" + dict.FirstOrDefault(d => d.Key == "cAddress").Value + "</label></span><em>");
                sb.AppendLine("<select  name=\"ddlProvince\" id=\"ddlProvince\" onchange=\"selectMoreCity(this)\"></select>");
                sb.AppendLine("<select name=\"ddlCity\" id=\"ddlCity\" onchange=\"selectOneCity(this)\"></select>");
                sb.AppendLine("<script type=\"text/javascript\"> BindProvince(\"北京\");</script>");
                sb.AppendLine("<input type=\"hidden\" id=\"idCity\" name=\"idCity\" size=\"5\" style=\"width: 30px\" />");
                sb.AppendLine("<input type=\"text\" value=\"\" style=\"display: none\" size=\"15\" id=\"cCityname\" name=\"cCityname\">");
                sb.AppendLine("<input type=\"hidden\" id=\"UpdatedFields\" name=\"UpdatedFields\" value=\"\" />");
                sb.AppendLine("<input type=\"text\" name=\"address\" id=\"address\" value=\"\"  maxlength=\"128\" />");
                sb.AppendLine("<div class=\"Validform_checktip\"></div></em></div>");

                //邮编
                sb.AppendLine("<div class=\"bmtd\"><span><label for=\"cZipcode\">" + dict.FirstOrDefault(d => d.Key == "cZipcode").Value + "</label></span><em><input type=\"text\" name=\"cZipcode\" id=\"cZipcode\" value=\"\"   maxlength=\"6\" /><div class=\"Validform_checktip\"></div></em>");

                //紧急联系人
                sb.AppendLine("</div><div class=\"bmtd\"><span><label for=\"emerger\">" + dict.FirstOrDefault(d => d.Key == "emerger").Value + "</label></span><em><input type=\"text\" name=\"emerger\" id=\"emerger\" value=\"\" maxlength=\"30\" /><div class=\"Validform_checktip\"></div> </em></div>");

                //紧急联系人手机
                sb.AppendLine("<div class=\"bmtd\"><span class=\"sosp\"><label for=\"emermobile\">" + dict.FirstOrDefault(d => d.Key == "emermobile").Value + "</label></span><em><input type=\"text\" name=\"emermobile\" id=\"emermobile\" value=\"\" maxlength=\"30\" /><div class=\"Validform_checktip\"></div></em></div>");
            }
            #endregion
        }
        DBM6.tblRace_Item modelItem = new DB6.tblRace_Item().GetModel(idItem);
        if (modelItem == null)
        {
            AlertHelper.JQAlertGo("赛事不存在！", "/Competetion/SearchEvent.aspx", false);
            return;
        }
        //衣服尺码
        if (1 == modelItem.iCloth)
        {
            sb.AppendLine(iCloth(dict.FirstOrDefault(d => d.Key == "shirt").Value, ""));
        }
        // 鞋号
        if (1 == modelItem.iShoe)
        {
            sb.AppendLine("<div class=\"bmtd\"><span><label for=\"cShoe\">" + dict.FirstOrDefault(d => d.Key == "shoe").Value + "</label></span><em>");
            sb.AppendLine("<input type=\"text\" name=\"cShoe\" maxlength=\"3\" id=\"cShoe\" value=\"\" />");
            sb.AppendLine("<div class=\"Validform_checktip\"></div></em></div>");
        }
        // 体检证明
        if (1 == modelItem.ihealth)
        {
            // <input type="file"  value="" class="fileupload" /><input type="hidden" name="cHealthUrl" id="cHealthUrl" value="" />
            sb.AppendLine("<div class=\"bmtd\"><span><label for=\"health\">" + dict.FirstOrDefault(d => d.Key == "health").Value + "</label></span><em>");
            sb.AppendLine("<input type=\"file\" class=\"fileupload\" value=\"\" /><input type=\"hidden\" name=\"cHealthUrl\" id=\"cHealthUrl\" value=\"" + cHealthUrl + "\" />");
            if (cHealthUrl.Length > 0)
            {
                if (cHealthUrl.Contains(GetDir(CurrentUser.uId.ToString())))
                {
                    sb.AppendFormat("<a target='_blank' href='" + @"http://img.erun360.com/Utility/Uploads/" + cHealthUrl + "'><img src='/Html/images/img_icon.png'/></a>");
                }
                else
                {
                    sb.AppendLine("<a target=\"_blank\" href=\"" + cHealthUrl + "\"><img src=\"/Html/images/img_icon.png\"></a>");
                }
            }
            //sb.AppendLine("<input type=\"file\" name=\"cHealthUrl\" id=\"cHealthUrl\" value=\"\" />");
            //sb.AppendLine("<strong>格式为.jpg/.gif/.bmp/.png</strong>");
            sb.AppendLine("<div class=\"Validform_checktip\"></div></em></div>");
        }
        DataTable dtfileurl = new DB6.tblRace_Item_ext().GetList(5, "iditem=" + idItem, "id,data_type desc,sales_field").Tables[0];
        if (dtfileurl.Rows.Count > 0)
        {
            StringBuilder xx = new StringBuilder();
            for (int i = 0; i < dtfileurl.Rows.Count; i++)
            {
                string tip = la == "en" ? dtfileurl.Rows[i]["enTip"].ToString() : dtfileurl.Rows[i]["cnTip"].ToString();
                string name = la == "en" ? dtfileurl.Rows[i]["enName"].ToString() : dtfileurl.Rows[i]["cnName"].ToString();
                int data_type = TypeChangeDefault.NullToInt(dtfileurl.Rows[i]["data_type"], 0);
                switch (data_type)
                {
                    case 1://附件上传
                        sb.AppendLine("<div class=\"bmtd\"><span><label for=\"" + dtfileurl.Rows[i]["sales_field"].ToString() + "\">" + name + "</label></span><em>");

                        sb.AppendLine("<input type=\"file\" class=\"fileupload\" value=\"\" /><input type=\"hidden\" name=\"" + dtfileurl.Rows[i]["sales_field"].ToString() + "\" id=\"" + dtfileurl.Rows[i]["sales_field"].ToString() + "\" value=\"\" />");
                        //sb.AppendLine("<input type=\"file\" name=\"" + dtfileurl.Rows[i]["sales_field"].ToString() + "\" id=\"" + dtfileurl.Rows[i]["sales_field"].ToString() + "\" value=\"\" />");
                        //sb.AppendLine("<strong>格式为.jpg/.gif/.bmp/.png</strong>");
                        sb.AppendLine("<div class=\"Validform_checktip\">" + tip + "</div></em></div>");
                        break;
                    case 2://文本字段
                        sb.AppendLine("<div class=\"bmtd\"><span><label for=\"" + dtfileurl.Rows[i]["sales_field"].ToString() + "\">" + name + "</label></span><em>");
                        sb.AppendLine("<input type=\"text\" name=\"" + dtfileurl.Rows[i]["sales_field"].ToString() + "\" id=\"" + dtfileurl.Rows[i]["sales_field"].ToString() + "\" value=\"\" />");
                        sb.AppendLine("<div class=\"Validform_checktip\">" + tip + "</div></em></div>");
                        break;
                    case 3: //单选框是否字段

                        string rbtipyes = la == "en" ? "yes" : "是";
                        string rbtipno = la == "en" ? "no" : "否";
                        sb.AppendLine("<div class=\"bmtd bmcolspan tdlabele\"><span><label for=\"" + dtfileurl.Rows[i]["sales_field"].ToString() + "\">");
                        sb.AppendLine(name);
                        sb.AppendLine("</label></span> <em>");
                        sb.AppendLine(" <ul id=\"" + dtfileurl.Rows[i]["sales_field"].ToString() + "\">");
                        sb.AppendLine("<li><input type=\"radio\" name=\"" + dtfileurl.Rows[i]["sales_field"].ToString() + "\"  value=\"1\" id=\"rbyes" + i.ToString() + "_0\"><label for=\"rbyes" + i.ToString() + "_0\">" + rbtipyes + "</label></li>");
                        sb.AppendLine("<li><input type=\"radio\" checked=\"checked\" value=\"0\" name=\"" + dtfileurl.Rows[i]["sales_field"].ToString() + "\" id=\"rbyes" + i.ToString() + "_1\"><label for=\"rbyes" + i.ToString() + "_1\">" + rbtipno + "</label></li>");
                        sb.AppendLine("</ul></em></div>");
                        break;
                }

            }
        }
        Result = sb.ToString();
        //20150708 更改库存数量（有从订单查询改为从库存中判断）del
        //int count = new DB6.tblOrder().GetRecordCount("iFromTpye =2 and iStatus>-1 and iItemID='" + idItem + "' and iTypeID='" + sid + "'");
        //if (count >= modelItem.iLimit)
        //{
        //    AlertHelper.JQAlertGo("报名已满，请选择其他项目！", "/Competetion/projects.aspx?sid=" + sid + "&nav=2&la=" + la, false);
        //    return;
        //}
    }
    //衣服尺码
    private string iCloth(string name, string iCloth)
    {
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("<div class=\"bmtd\"> <span><label for=\"blood\">" + name + "</label></span><em> <select name=\"cCloth\" id=\"cCloth\" >	");
        sb.AppendLine(iCloth == "S" ? "<option selected=\"selected\" value=\"S\">S</option>" : "<option value=\"S\">S</option>");
        sb.AppendLine(iCloth == "M" ? "<option selected=\"selected\" value=\"M\">M</option>" : "<option value=\"M\">M</option>	");
        sb.AppendLine(iCloth == "L" ? "<option selected=\"selected\" value=\"L\">L</option>" : "<option value=\"L\">L</option>");
        sb.AppendLine(iCloth == "XL" ? "<option selected=\"selected\" value=\"XL\">XL</option>" : "<option value=\"XL\">XL</option>");
        sb.AppendLine(iCloth == "XXL" ? "<option selected=\"selected\" value=\"XXL\">XXL</option>" : "<option value=\"XXL\">XXL</option>");
        sb.AppendLine(iCloth == "XXXL" ? "<option selected=\"selected\" value=\"XXXL\">XXXL</option>" : "<option value=\"XXXL\">XXXL</option>");
        sb.AppendLine("</select></em></div>");
        return sb.ToString();
    }
    //证件类型
    private string IdType(string name, int IdType)
    {
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("<div class=\"bmtd\"> <span><label for=\"idtype\">" + name + "</label></span><em> <select class=\"card\" id=\"IdType\" name=\"IdType\">");
        sb.AppendLine(IdType == 1 ? "<option selected=\"selected\" value=\"1\">身份证</option>" : "<option value=\"1\">身份证</option>");
        sb.AppendLine(IdType == 2 ? "<option selected=\"selected\" value=\"2\">军官证</option>" : "<option value=\"2\">军官证</option>");
        sb.AppendLine(IdType == 3 ? "<option selected=\"selected\" value=\"3\">户口本</option>" : "<option  value=\"3\">户口本</option>");
        sb.AppendLine(IdType == 4 ? "<option selected=\"selected\" value=\"4\">护照</option>" : "<option value=\"4\">护照</option>");
        sb.AppendLine(IdType == 5 ? "<option selected=\"selected\" value=\"5\">其它</option>" : "<option value=\"5\">其它</option>");
        sb.AppendLine("</select>");

        return sb.ToString();
    }
    //性别
    private string cGender(string name, int idGender)
    {
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("<div class=\"bmtd tdlabel\"><span><label for=\"gendera\">" + name + "</label></span><ul id=\"cGender\">");
        sb.AppendLine(idGender == 0 ? "<li><input id=\"idgender_0\" type=\"radio\" name=\"cGender\" value=\"0\" checked=\"checked\"  /><label for=\"idgender_0\">男</label></li>" : "<li><input id=\"idgender_0\" type=\"radio\" name=\"cGender\" value=\"0\" /><label for=\"idgender_0\">男</label></li>");
        sb.AppendLine(idGender == 1 ? "<li><input id=\"idgender_1\" type=\"radio\" name=\"cGender\" value=\"1\"  checked=\"checked\"  /><label for=\"idgender_1\">女</label></li>" : "<li><input id=\"idgender_1\" type=\"radio\" name=\"cGender\" value=\"1\" /><label for=\"idgender_1\">女</label></li>");


        sb.AppendLine("</ul><div class=\"Validform_checktip\"></div></div>");
        return sb.ToString();
    }
    //血型
    private string idBlood(string name, int blood)
    {
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("<div class=\"bmtd xuexing\"> <span><label for=\"blood\">" + name + "</label></span><em> <select name=\"idBlood\" id=\"idBlood\" >	");
        sb.AppendLine(blood == 0 ? "<option selected=\"selected\" value=\"0\">A</option>" : "<option value=\"0\">A</option>");
        sb.AppendLine(blood == 1 ? "<option selected=\"selected\" value=\"1\">B</option>" : "<option value=\"1\">B</option>	");
        sb.AppendLine(blood == 3 ? "<option selected=\"selected\" value=\"3\">AB</option>" : "<option value=\"3\">AB</option>");
        sb.AppendLine(blood == 2 ? "<option selected=\"selected\" value=\"2\">O</option>" : "<option value=\"2\">O</option>");
        sb.AppendLine(blood == 4 ? "<option selected=\"selected\" value=\"4\">其他</option>" : "<option value=\"4\">其他</option>");
        sb.AppendLine("</select></em></div>");
        return sb.ToString();
    }
    //学历
    private string Education(string name, int idEducation)
    {
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("<div class=\"bmtd xuexing\"> <span><label for=\"idEducation\">" + name + "</label></span><em> <select name=\"idEducation\" id=\"idEducation\" >");
        sb.AppendLine(idEducation == 0 ? "<option selected=\"selected\" value=\"0\">其他</option>" : "<option value=\"0\">其他</option>");
        sb.AppendLine(idEducation == 1 ? "<option selected=\"selected\" value=\"1\">大专</option>" : "<option value=\"1\">大专</option>");
        sb.AppendLine(idEducation == 3 ? "<option selected=\"selected\" value=\"2\">本科</option>" : "<option value=\"2\">本科</option>");
        sb.AppendLine(idEducation == 2 ? "<option selected=\"selected\" value=\"3\">研究生</option>" : "<option  value=\"3\">研究生</option>");
        sb.AppendLine(idEducation == 4 ? "<option selected=\"selected\" value=\"4\">博士</option>" : "<option value=\"4\">博士</option>");
        sb.AppendLine(idEducation == 5 ? "<option selected=\"selected\" value=\"5\">硕士</option>" : "<option value=\"5\">硕士</option>");
        sb.AppendLine("</select></em></div>");
        return sb.ToString();
    }
    /// <summary>
    /// 获取中英文对照字典
    /// </summary>
    public static Dictionary<string, string> Getcn_en(string en)
    {
        string CacheKey = "GetVersionxb-" + en;
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        objModel = null;
        if (objModel == null)
        {
            try
            {
                Dictionary<string, string> version = new Dictionary<string, string>();
                string xmlPath = HttpContext.Current.Server.MapPath("/XML/event.xml");
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
    ///绑定职业
    protected string BindIdOccupation(string la, string name, int idOccupation)
    {
        string CacheKey = "idOccupation-" + la;
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        objModel = null;
        if (objModel == null)
        {
            string path = string.Empty;
            if (la == "en")
                path = Server.MapPath("/XML/Stringsen.xml");
            else
                path = Server.MapPath("/XML/Strings.xml");
            DataSet ds = new DataSet();
            ds.ReadXml(path);
            try
            {
                objModel = ds;
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch { }
        }
        StringBuilder sb = new StringBuilder();
        sb.Append("<div class=\"bmtd\"><span><label for=\"occupation\">" + name + "</label></span> <em><select name=\"idOccupation\" id=\"idOccupation\" >");
        for (int i = 0; i < ((DataSet)objModel).Tables["idOccupation"].Rows.Count; i++)
        {
            if (((DataSet)objModel).Tables["idOccupation"].Rows[i]["ValueField"].ToString() == idOccupation.ToString())
            {
                sb.Append("<option  selected =\"selected\" value=\"" + ((DataSet)objModel).Tables["idOccupation"].Rows[i]["ValueField"] + "\">" + ((DataSet)objModel).Tables["idOccupation"].Rows[i]["TextField"] + "</option>");
            }
            else
            {
                sb.Append("<option value=\"" + ((DataSet)objModel).Tables["idOccupation"].Rows[i]["ValueField"] + "\">" + ((DataSet)objModel).Tables["idOccupation"].Rows[i]["TextField"] + "</option>");
            }
        }
        sb.Append("</select></em></div>");

        return sb.ToString();
    }

}