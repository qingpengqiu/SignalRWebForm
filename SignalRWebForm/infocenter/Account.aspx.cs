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
using Erun360.Common;
using Utils;


public partial class infocenter_Account : PageBase
{
    DB1.tblMEMBER_SIZE BLLMemberSize = new DB1.tblMEMBER_SIZE();
    DB1.tblMEMBER bll = new DB1.tblMEMBER();
    DB1.tblRACERECORD bllrecord = new DB1.tblRACERECORD();
    DB1.tblRUNINTRO bllinto = new DB1.tblRUNINTRO();
    Erun360.BLL.DB6.tblPassenger tblpas = new Erun360.BLL.DB6.tblPassenger();
    public DBM1.tblMEMBER model = new DBM1.tblMEMBER();
    public int racenum = 1;
    public int uId = 0;
    public string imghead = string.Empty;
    public string imgtjzm = string.Empty;
    public string iCity = string.Empty;
    public string iArea = string.Empty;
    DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
    public int Year = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title ="修改个人信息-益跑网个人中心-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
        if (CurrentUser == null)
        {
            Response.Redirect("/Member/Logout.aspx");
        }
        int seed = -1;
        if (Request.QueryString["uId"] != null && int.TryParse(Request.QueryString["uId"],out seed))
        {
            uId = int.Parse(Request.QueryString["uId"].ToString());
        }
        if (CurrentUser.uId != uId)
        {
            Response.Redirect(UrlHelper.MemberUrl(CurrentUser.uId));
        }
        Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().UpdateUserModel(uId);
        if (CurrentUser.cAvatar == null)
        {
            imghead = @"/Html/images/wl/2.png";
        }
        else
        {
            imghead = CurrentUser.cAvatar + "?t=" + DateTime.Now.ToString();
        }
        if (!IsPostBack)
        {
            BindDDLFriends();
            PreLoadInfo();
            Cycontact();
        }
    }
    protected void Cycontact()
    {
        DataSet ds = tblpas.GetList(0, "idUser=" + CurrentUser.uId + "", "dBirthday desc");
         //== "IN" ? "身份证": DataBinder.Eval(Container.DataItem, "IdType").ToString() == "PP"?"护照" : DataBinder.Eval(Container.DataItem, "IdType") == "GA" ? "港澳通行证" : DataBinder.Eval(Container.DataItem, "IdType") == "TW" ? "台湾通行证" : DataBinder.Eval(Container.DataItem, "IdType").ToString() == "TB" ? "台胞证" : DataBinder.Eval(Container.DataItem, "IdType").ToString() == "HX" ? "回乡证" : DataBinder.Eval(Container.DataItem, "IdType").ToString() == "HY" ? "国际海员证" : " "
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            if (ds.Tables[0].Rows[i]["IdType"].ToString() == "IN")
            {
                ds.Tables[0].Rows[i]["IdType"] = "身份证";
            }
            if (ds.Tables[0].Rows[i]["IdType"].ToString() == "PP")
            {
                ds.Tables[0].Rows[i]["IdType"] = "护照";
            }
            if (ds.Tables[0].Rows[i]["IdType"].ToString() == "GA")
            {
                ds.Tables[0].Rows[i]["IdType"] = "港澳通行证";
            }
            if (ds.Tables[0].Rows[i]["IdType"].ToString() == "TW")
            {
                ds.Tables[0].Rows[i]["IdType"] = "台湾通行证";
            }
            if (ds.Tables[0].Rows[i]["IdType"].ToString() == "TB")
            {
                ds.Tables[0].Rows[i]["IdType"] = "台胞证";
            }
            if (ds.Tables[0].Rows[i]["IdType"].ToString() == "HX")
            {
                ds.Tables[0].Rows[i]["IdType"] = "回乡证";
            }
            if (ds.Tables[0].Rows[i]["IdType"].ToString() == "HY")
            {
                ds.Tables[0].Rows[i]["IdType"] = "国际海员证";
            }
        }
        Cyuser.DataSource = ds;
        Cyuser.DataBind();
    }
   
    protected void Button_Size_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }        
        DBM1.tblMEMBER_SIZE ModelMemberSize = new DBM1.tblMEMBER_SIZE();
        ModelMemberSize.iBodyHeight = TypeChangeDefault.NullToInt(height.Value, 0);
        ModelMemberSize.iBodyWeight = TypeChangeDefault.NullToInt(weight.Value, 0);
        ModelMemberSize.iChestSize = TypeChangeDefault.NullToInt(chest.Value, 0);
        ModelMemberSize.iFootLength = TypeChangeDefault.NullToInt(feetlong.Value, 0);
        ModelMemberSize.iFootWidth = TypeChangeDefault.NullToInt(feetwide.Value, 0);
        ModelMemberSize.iHipSize = TypeChangeDefault.NullToInt(hips.Value, 0);
        ModelMemberSize.iWaistSize = TypeChangeDefault.NullToInt(waistline.Value, 0);
        ModelMemberSize.dCreate = DateTime.Now;
        ModelMemberSize.idUser = CurrentUser.uId;
        if (BLLMemberSize.Exists(CurrentUser.uId))
        {
            BLLMemberSize.Update(ModelMemberSize);
        }
        else
        {            
            BLLMemberSize.Add(ModelMemberSize);
        }
        if (!uMember_History.Exists(200810008, CurrentUser.uId))
        {
            new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810008, 1, 0, 1);
        }
        AlertHelper.JQAlertGo("保存成功", "/infocenter/account.aspx?uId=" + CurrentUser.uId + "&page=2", true);
    }
    protected void PreLoadInfo()
    {
        DataSet ds = bll.GetList(" id=" + CurrentUser.uId);
        cnickame.Value = ds.Tables[0].Rows[0]["cLoginname"].ToString().Trim();
        name.Value = ds.Tables[0].Rows[0]["cName"].ToString().Trim();
        if (ds.Tables[0].Rows[0]["idGender"].ToString().Trim() == "0")
        {
            gendera.Checked = true;
            genderb.Checked = false;
        }
        if (ds.Tables[0].Rows[0]["idGender"].ToString().Trim() == "1")
        {
            gendera.Checked = false;
            genderb.Checked = true;
        }
        if (ds.Tables[0].Rows[0]["idBlood"].ToString().Trim() == "0")
        {
            blooda.Checked = true;
        }
        if (ds.Tables[0].Rows[0]["idBlood"].ToString().Trim() == "1")
        {
            bloodb.Checked = true;
        }
        if (ds.Tables[0].Rows[0]["idBlood"].ToString().Trim() == "3")
        {
            bloodab.Checked = true;
        }
        if (ds.Tables[0].Rows[0]["idBlood"].ToString().Trim() == "2")
        {
            bloodo.Checked = true;
        }
        if (ds.Tables[0].Rows[0]["idBlood"].ToString().Trim() == "4")
        {
            bloodother.Checked = true;
        }
        birday.Value = Convert.ToDateTime(ds.Tables[0].Rows[0]["dBirthday"]).GetDateTimeFormats('s')[0].ToString().Trim().Substring(0, 10);
        education.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["idEducation"].ToString().Trim());
        idOccupation.SelectedValue = ds.Tables[0].Rows[0]["idOccupation"].ToString().Trim();
        idCard.SelectedIndex = TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["idNationIDType"].ToString().Trim(),0);
        prependedDropdown.Value = ds.Tables[0].Rows[0]["cNationID"].ToString().Trim();
        mobile.Value = ds.Tables[0].Rows[0]["cMobile"].ToString().Trim();
        email.Value = ds.Tables[0].Rows[0]["cMail"].ToString().Trim();
        //city.Value = ds.Tables[0].Rows[0]["cCityname"].ToString().Trim();
        if (ds.Tables[0].Rows[0]["idCity"].ToString().Trim().Length == 3)
        {
            iCity = ds.Tables[0].Rows[0]["idCity"].ToString().Trim().Substring(0, 1);
            iArea = ds.Tables[0].Rows[0]["idCity"].ToString().Trim().Substring(1, 2);
        }
        else if (ds.Tables[0].Rows[0]["idCity"].ToString().Trim().Length == 4)
        {
            iCity = ds.Tables[0].Rows[0]["idCity"].ToString().Trim().Substring(0, 2);
            iArea = ds.Tables[0].Rows[0]["idCity"].ToString().Trim().Substring(2, 2);
        }
         else
        {
            iCity = "1";
            iArea = "01";
        }
        cCityname.Value = ds.Tables[0].Rows[0]["cCityname"].ToString().Trim();
        idCity.Value = ds.Tables[0].Rows[0]["idCity"].ToString().Trim();
        address.Value = ds.Tables[0].Rows[0]["cAddress"].ToString().Trim();
        zipcode.Value = ds.Tables[0].Rows[0]["cZipcode"].ToString().Trim();
        emerger.Value = ds.Tables[0].Rows[0]["cEmergerContact"].ToString().Trim().Split('|')[0];
        try
        {
            emermobile.Value = ds.Tables[0].Rows[0]["cEmergerContact"].ToString().Trim().Split('|')[1];
        }
        catch
        {
            emermobile.Value = "";
        }
        if (ds.Tables[0].Rows[0]["cHealthUrl"].ToString() != "")
        {
            tjzmt.HRef=HostInfo.imgName + @"/utility/uploads/" + ds.Tables[0].Rows[0]["cHealthUrl"].ToString().Trim();
                
        }
        else
        {
            tjzmt.Visible = false;
        }
        //---------------
        DataSet ds1 = BLLMemberSize.GetList(" idUser=" + CurrentUser.uId);
        height.Value = ds1.Tables[0].Rows[0]["iBodyHeight"].ToString().Trim();
        weight.Value = ds1.Tables[0].Rows[0]["iBodyWeight"].ToString().Trim();
        chest.Value = ds1.Tables[0].Rows[0]["iChestSize"].ToString().Trim();
        waistline.Value = ds1.Tables[0].Rows[0]["iWaistSize"].ToString().Trim();
        hips.Value = ds1.Tables[0].Rows[0]["iHipSize"].ToString().Trim();
        feetwide.Value = ds1.Tables[0].Rows[0]["iFootWidth"].ToString().Trim();
        feetlong.Value = ds1.Tables[0].Rows[0]["iFootLength"].ToString().Trim();
        //---------------
        DataSet ds2 = bllrecord.GetList(" idUser=" + CurrentUser.uId);
        if (ds2.Tables[0].Rows.Count == 0)
        {
            DataRow dr = ds2.Tables[0].NewRow();
            dr["iYear"] = DateTime.Now.Year;
            dr["cRacename"] = "";
            dr["tTime"] = "00:00:00";
            ds2.Tables[0].Rows.Add(dr);
        }
        DataSet dsrecord = new DataSet();
        dsrecord.Tables.Add();
        DataColumn myDataColumn;
        myDataColumn = new DataColumn();
        myDataColumn.DataType = System.Type.GetType("System.String");
        myDataColumn.ColumnName = "inner";
        dsrecord.Tables[0].Columns.Add(myDataColumn);
        racenum = ds2.Tables[0].Rows.Count;
        for (int i = 0; i < ds2.Tables[0].Rows.Count; i++)
        {
            DataRow drrecord = dsrecord.Tables[0].NewRow();
            drrecord["inner"] = "<div class=\"tr\"><div class=\"td\"><input class='input-mini record record" + i.ToString() + "'type='text' name='record" + i.ToString() + "' id='record" + i.ToString() + "' value='" + ds2.Tables[0].Rows[i]["iYear"].ToString() + "'></div><div class=\"td\"><input type='text' class='input-large' name='Text1" + i.ToString() + "' id='Text1" + i.ToString() + "' value='" + ds2.Tables[0].Rows[i]["cRacename"].ToString() + "' tabindex='1' ></div><div class=\"td\"><input type='text' class='input-mini' name='Text2" + i.ToString() + "'   id='Text2" + i.ToString() + "' value='" + ds2.Tables[0].Rows[i]["tTime"].ToString() + "' tabindex='1' /></div></div>";
            //drrecord["inner"] = "<select name='record" + i.ToString() + "' id='record" + i.ToString() + "' tabindex='1' class='input-mini record record" + i.ToString() + "' data-yeaval='" + ds2.Tables[0].Rows[i]["iYear"].ToString() + "'></select><label for='results'>年</label><input type='text' class='input-large' name='Text1" + i.ToString() + "' id='Text1" + i.ToString() + "' value='" + ds2.Tables[0].Rows[i]["cRacename"].ToString() + "' tabindex='1' ><label for='results'>成绩</label><input type='text' class='input-mini' name='Text2" + i.ToString() + "'   id='Text2" + i.ToString() + "' value='" + ds2.Tables[0].Rows[i]["tTime"].ToString() + "' tabindex='1' />";
            dsrecord.Tables[0].Rows.Add(drrecord);
        }
        this.rptrunrecord.DataSource = dsrecord.Tables[0];
        this.rptrunrecord.DataBind();

        DBM1.tblRUNINTRO modelInto = bllinto.GetModelByidUser(CurrentUser.uId);
        if (modelInto != null)
        {
            Year = modelInto.iRunyear ?? 0;
            marathonnum.Value = modelInto.iMarathon.ToString();
            countrynum.Value = modelInto.iTrail.ToString();
            marathonbest.Value = modelInto.iMarathontype.ToString();
            results.Value = modelInto.tMarathontime;
            onegame.Value = modelInto.cBio;
        }

        //DataSet ds3 = bllinto.GetList(" idUser=" + CurrentUser.uId);
        //if (ds3.Tables[0].Rows.Count > 0)
        //{
        //    runyear.Value = ds3.Tables[0].Rows[0]["iRunyear"].ToString();
        //    marathonnum.Value = ds3.Tables[0].Rows[0]["iMarathon"].ToString().Trim();
        //    countrynum.Value = ds3.Tables[0].Rows[0]["iTrail"].ToString().Trim();
        //    marathonbest.Value = ds3.Tables[0].Rows[0]["iMarathontype"].ToString().Trim();
        //    results.Value = ds3.Tables[0].Rows[0]["tMarathontime"].ToString().Trim();
        //    onegame.Value = ds3.Tables[0].Rows[0]["cBio"].ToString().Trim();
        //}

    }
    protected void BindDDLFriends()
    {
        string path = Server.MapPath("/XML/Strings.xml");
        DataSet ds = new DataSet();
        ds.ReadXml(path);
        string CacheKey = "idOccupation";
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
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
        idOccupation.DataSource = ((DataSet)objModel).Tables["idOccupation"];
        idOccupation.DataTextField = "TextField";
        idOccupation.DataValueField = "ValueField";
        idOccupation.DataBind();
    }
    protected string Validation()
    {
        string returnvalue = string.Empty;
        if (!Erun360.Common.PageValidate.IsPhone(mobile.Value.Trim()) && mobile.Value.Trim() != "")
        {
            returnvalue += "电话格式错误,";
        }
        if (!Erun360.Common.PageValidate.IsEmail(email.Value.Trim()) && email.Value.Trim() != "")
        {
            returnvalue += "邮件格式错误,";
        }
        if (idCard.SelectedIndex == 0)
        {
            returnvalue += "请选择证件类型,";
        }
        else
        {
            if (idCard.SelectedIndex == 1)
            {
                if (prependedDropdown.Value.Trim().Length != 18)
                {
                    returnvalue += "身份证格式错误,";
                }
                else
                {
                    if (!Erun360.Common.PageValidate.IsNumber(prependedDropdown.Value.Trim().Substring(0, 17)))
                    {
                        returnvalue += "身份证格式错误,";
                    }
                }
            }
        }
        if (idCity.Value.Trim() == "0")
        {
            returnvalue += "请选择居住城市,";
        }
        if (string.IsNullOrEmpty(cCityname.Value.Trim()))
        {
            returnvalue += "请选择居住城市,";
        }
        return returnvalue.Trim(',');
    }

    protected void Button_Application_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        string returnvalue = Validation();
        if (returnvalue != "")
        {
            AlertHelper.JQAlertGo(returnvalue, "/infocenter/account.aspx?uId=" + CurrentUser.uId + "&page=1", false);
            return;
        }
        model.cName = name.Value.Trim();
        //性别
        if (gendera.Checked)
            model.idGender = 0;
        if (genderb.Checked)
            model.idGender = 1;
        //血型
        if (blooda.Checked)
            model.idBlood = 0;
        if (bloodb.Checked)
            model.idBlood = 1;
        if (bloodab.Checked)
            model.idBlood = 3;
        if (bloodo.Checked)
            model.idBlood = 2;
        if (bloodother.Checked)
            model.idBlood = 4;
        model.dBirthday = DateTime.Parse(birday.Value.Trim());
        model.idEducation = education.SelectedIndex;//学历
        model.idOccupation = Convert.ToInt32(idOccupation.SelectedValue);//职业
        model.idNationIDType = idCard.SelectedIndex;//证件类型
        model.cNationID = prependedDropdown.Value.Trim();
        model.cMobile = mobile.Value.Trim();
        model.cMail = email.Value.Trim();
        model.idCity = TypeChangeDefault.NullToInt(idCity.Value, 0);
        model.cCityname = cCityname.Value.Trim();
        //model.cCityname = city.Value.Trim();
        model.cAddress = address.Value.Trim();
        model.cZipcode = zipcode.Value;
        model.cEmergerContact = emerger.Value + "|" + emermobile.Value;
        model.iChecksum = Convert.ToInt32(bll.GetList(" id=" + CurrentUser.uId.ToString()).Tables[0].Rows[0]["iChecksum"]);
        model.id = CurrentUser.uId;
        if (tjzm.HasFile)
        {
            string filename = tjzm.FileName;
            string type = filename.Substring(filename.LastIndexOf(".") + 1);    //获取文件类型

            if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
            {
                string fileShort = "/" + CurrentUser.uId + "_zs." + type;
                HttpPostedFile file = tjzm.PostedFile;
                if (UpPhotoSaveAs(file, GetDir(CurrentUser.uId.ToString()), fileShort))
                {                   
                    model.cHealthUrl = GetDir(CurrentUser.uId.ToString()) + fileShort;
                }
                else
                {
                    AlertHelper.JQAlert("上传错误，请重新上传！",false);
                    return;
                }
            }
            else
            {
                AlertHelper.JQAlert("图片类型错误正确格式为jpg/gif/bmp/png",false);
                return;
            }
        }
        if (bll.Update(model))
        {
            Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().UpdateUserModel(CurrentUser.uId);
            if (!uMember_History.Exists(200810007, CurrentUser.uId))
            {
                new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810007, 1, 0, 1);
            }
            AlertHelper.JQAlertGo("保存成功", "/infocenter/account.aspx?uId=" + CurrentUser.uId + "&page=1", true);
        }
        else
        {
            AlertHelper.JQAlertGo("保存失败", "/infocenter/account.aspx?uId=" + CurrentUser.uId + "&page=1", false);
        }
    }
    protected void Button_Reg_Click(object sender, EventArgs e)
    {
        if (CheckOldPass())
        {
            if (newpass.Value.Trim().Length==0)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('请填写新密码！','','false');});</script>");
            }
            model.cPassword = XString.MD5(newpass.Value.Trim().ToLower());
            //model.cNickName = cnickame.Value.Trim();
            model.iChecksum = Convert.ToInt32(bll.GetList(" id=" + CurrentUser.uId.ToString()).Tables[0].Rows[0]["iChecksum"]);
            model.id = CurrentUser.uId;
            try
            {
                if (newpass.Value.Trim() != newpassagain.Value.Trim())
                {
                    //提示到前端
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('两次密码输入的不一致！','','false');});</script>");
                }
                else
                {
                    bll.Update(model);
                    Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(CurrentUser.uId);
                    AlertHelper.JQAlertGo("保存成功", "/infocenter/account.aspx?uId=" + CurrentUser.uId + "&page=4", true);
                }
            }
            catch { }
        }
        else
        {
            //提示到前端
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('密码与原密码不符！','','false');});</script>");
        }
    }
    public bool CheckOldPass()
    {
        int recordcount = bll.GetRecordCount(" id=" + CurrentUser.uId + " and cPassword='" + XString.MD5(XString.SqlSafe(orgpass.Value.Trim().ToLower())) + "'");
        if (recordcount > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    protected bool checktime(string time)
    {
        bool returnvalue = true;
        if (time.Length < 7)
        {
            returnvalue = false;
        }
        else
        {
            if (time.Substring(time.Length - 3, 1) != ":" && time.Substring(time.Length - 6, 1) != ":")
            {
                returnvalue = false;
            }
            if (!Erun360.Common.PageValidate.IsNumber(time.Substring(time.Length - 5, 2)) || !Erun360.Common.PageValidate.IsNumber(time.Substring(time.Length - 2, 2)) || !Erun360.Common.PageValidate.IsNumber(time.Substring(0, time.Length - 6)))
            {
                returnvalue = false;
            }
        }
        return returnvalue;
    }
    protected void Button_Intro_Click(object sender, EventArgs e)
    {
        DBM1.tblRACERECORD ModelRACERECORD = new DBM1.tblRACERECORD();
        DBM1.tblRUNINTRO ModelRunintronew = new DBM1.tblRUNINTRO();
        if (checktime(results.Value.Trim()) || results.Value.Trim() == "")
        {
           
            bllinto.DeleteInto(CurrentUser.uId);
            //bllinto.Delete(CurrentUser.uId);
            try
            {
                ModelRunintronew.cBio = onegame.Value.Trim();
                ModelRunintronew.dCreate = DateTime.Now;
                ModelRunintronew.idUser = CurrentUser.uId;
                ModelRunintronew.iMarathon = Convert.ToInt32(marathonnum.Value.Trim());
                ModelRunintronew.iMarathontype = Convert.ToInt32(marathonbest.Value.Trim());
                ModelRunintronew.iRunyear = Convert.ToInt32(Request.Form["runyear"]);
                ModelRunintronew.iTrail = Convert.ToInt32(countrynum.Value.Trim());
                ModelRunintronew.tMarathontime = results.Value.Trim();
                bllinto.Add(ModelRunintronew);
                
                if (!uMember_History.Exists(200810009, CurrentUser.uId))
                {
                    new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810009, 1, 0, 1);                   
                }
            }
            catch (Exception ex)
            {
                //提示到前端
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('请输入正确的格式！','','false');});</script>");
            }
        }
        else
        {
            //提示到前端
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('成绩格式为XX:XX:XX！','','false');});</script>");
        }
        bool recordyearreturn = true;
        bool recordreturn = true;
        for (int i = 0; i < 1000; i++)
        {
            string iYear = Convert.ToString(Request.Form["record" + i.ToString()]);
            string tTime = Convert.ToString(Request.Form["Text2" + i.ToString()]);
            if (iYear != null)
            {
                if ((iYear.Length != 4 || !Erun360.Common.PageValidate.IsNumber(iYear)) && iYear.Trim().Length > 0)
                {
                    recordyearreturn = false;
                }
                if (!checktime(tTime.Trim()) && tTime.Trim().Length > 0)
                {
                    recordreturn = false;
                }
            }
            else
            {
                break;
            }

        }
        if (!recordreturn)
        {
            //提示到前端
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('成绩格式为XX:XX:XX！','','false');});</script>");
        }
        else
        {
            if (!recordyearreturn)
            {
                //提示到前端
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('年份格式错误！','','false');});</script>");
            }
            else
            {
                /////////////////保存record
                bllrecord.Delete(CurrentUser.uId);

                for (int i = 0; i < 1000; i++)
                {
                    string iYear = Convert.ToString(Request.Form["record" + i.ToString()]);
                    string cRacename = Convert.ToString(Request.Form["Text1" + i.ToString()]);
                    string tTime = Convert.ToString(Request.Form["Text2" + i.ToString()]);
                    if (iYear != null)
                    {
                        if (iYear != "" && cRacename != "" && tTime != "")
                        {
                            try
                            {
                                ModelRACERECORD.idUser = CurrentUser.uId;
                                ModelRACERECORD.iYear = Convert.ToInt32(iYear.Substring(0, 4));
                                ModelRACERECORD.cRacename = cRacename;
                                ModelRACERECORD.tTime = tTime;
                                ModelRACERECORD.dCreate = DateTime.Now;

                                bllrecord.Add(ModelRACERECORD);
                            }
                            catch (Exception ex)
                            {
                                //提示到前端
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('请输入正确的格式！','','false');});</script>");
                            }
                        }
                    }
                    else
                    {
                        break;
                    }

                }
                //提示到前端
                AlertHelper.JQAlertGo("保存成功", "/infocenter/account.aspx?uId=" + CurrentUser.uId, true);
            }
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        //if (avatarurl.Value.Trim().Length > 0)
        //        {
        //            model.id = CurrentUser.uId;
        //            model.iChecksum = Convert.ToInt32(bll.GetList(" id=" + CurrentUser.uId.ToString()).Tables[0].Rows[0]["iChecksum"]);
        //            model.cAvatar = avatarurl.Value;
        //            model.dBirthday = null;
        //            model.idNationIDType = null;
        //            model.idGender = null;
        //            bll.Update(model);
        //            Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().UpdateUserModel(uId);
        //            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('保存成功！','/infocenter/account.aspx?uId=" + CurrentUser.uId + "&t=" + DateTime.Now.ToString() + "#3','true');});</script>");
        //        }
        //        else
        //        {
        //            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('请上传头像！','/infocenter/account.aspx?uId=" + CurrentUser.uId + "&t=" + DateTime.Now.ToString() + "#3','false');});</script>");
        //        }
    }
    private bool UpPhotoSaveAs(HttpPostedFile uploadFile, string Path, string FileName)
    {
        HttpPostedFile face = uploadFile;
        //FileSaveAs picWebService = new FileSaveAs();

        SaveFile.FileSaveAsSoapClient picWebService = new SaveFile.FileSaveAsSoapClient();
        int upPhotoLength = face.ContentLength;
        byte[] PhotoArray = new Byte[upPhotoLength];
        Stream PhotoStream = face.InputStream;
        PhotoStream.Read(PhotoArray, 0, upPhotoLength);
        bool flag = picWebService.UploadFile(PhotoArray, Path, FileName);
        face.InputStream.Close();
        return flag;
    }
}