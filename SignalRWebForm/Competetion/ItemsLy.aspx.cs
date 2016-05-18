using System;
using System.Data;
using System.Web.UI;
using Erun360.BLL;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DB3 = Erun360.BLL.DB3;
using DB5 = Erun360.BLL.DB5;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DBM5 = Erun360.Model.DB5;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using Utils;
using System.Web.UI.WebControls;
using System.Text;
using System.Web;
using System.IO;
using System.Text.RegularExpressions;

public partial class Competetion_ItemsLy : PageBase
{
    public string port = string.Empty;
    public string portrait = string.Empty;
    public int idcompete = 0;
    private int id = 0;
    public string title = string.Empty;
    public string kj = string.Empty;

    public int racenum = 1;

    StringBuilder sb = new StringBuilder();
    public static StringBuilder sbb = new StringBuilder();

    
    public DateTime Begintime = DateTime.Now;
    public DateTime endtime = DateTime.Now;
    public string Color = string.Empty;
    public string Size = string.Empty;
    public int Limit = 0;
    public Decimal MarketPrice = 0;
    public Decimal SellPrice = 0;
    public int Score = 0;
    public int Money = 0;
    public string vatarurl = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        if (Request.QueryString["sid"] != null)
        {
            idcompete = Convert.ToInt32(Request.QueryString["sid"].ToString());
        }
        if (!IsPostBack)
        {
            //BindGoods();
            DBM6.tblRace_Competition comp = new DB6.tblRace_Competition().GetModel(TypeChangeDefault.NullToInt(idcompete, 0));
            if (CurrentUser.idMemberStyle != 99)
            {
                if (CurrentUser.uId != comp.idUser)
                {
                    AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
                    return;
                }
            }
            ltlbanner.Text = comp.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + comp.cBanner + "\" height=\"256\" width=\"1200\" alt=\"\"/>";
            title = comp.cTitle;
            this.page_Title = title+"赛事管理";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            if (id != 0)
            {
                DBM6.tbltour model = new DB6.tbltour().GetModel(id);
                //DBM6.
                if (model != null)
                {
                    //idGood.SelectedValue = model.idCompete.ToString();
                    Cname.Value = model.cName.ToString();
                    //iTotal.Value = model.iTotal.ToString();
                    iBuyMax.Value = model.iBuyMax.ToString();
                    dRaceBegin.Value = Convert.ToDateTime(model.dBeginTime).ToString("yyyy-MM-dd");
                    dRaceEnd.Value = Convert.ToDateTime(model.dEndTime).ToString("yyyy-MM-dd");
                    cLink.Value = model.cLink.ToString();
                    //lbtt.Text = model.cImage;
                    Text1.Value = model.cBio.Replace("[IMG]", "<img src=\"").Replace("[/IMG]", "\"/>");
                    Text2.Value = model.cReason.Replace("[IMG]", "<img src=\"").Replace("[/IMG]", "\"/>");
                    Text3.Value = model.cNorm.Replace("[IMG]", "<img src=\"").Replace("[/IMG]", "\"/>");
                    iState.Value = model.iStatus.ToString();
                    px.Value = model.iSort.ToString();
                    //iGlobal.Value = model.iGlobal.ToString();
                    hdtt.Value = model.cImage;
                    Bding();
                }
            }
            else
            {
                //idGood.SelectedValue = idcompete.ToString();
                
            }
        }
    }
    public void Bding()
    {
        DataSet ds = null;
        ds = new DB6.tbltour_Item().GetList("idEquipment=" + id + "");
        sb.AppendLine("<div class=\"fblil\"><label>旅游列表：</label></div><div class=\"fblir hoteltype\"><ul>");
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            sb.AppendLine("<li>" + ds.Tables[0].Rows[i]["cItemName"] + "<img width=\"50\" height=\"50\" src=\"" + ds.Tables[0].Rows[i]["cURL"] + "\"><label>" + ds.Tables[0].Rows[i]["cColor"] + "</label><label>" + ds.Tables[0].Rows[i]["cSize"] + "</label>/<label>" + ds.Tables[0].Rows[i]["iLimit"] + "</label><a href='ItemsLyAdd.aspx?sid=" + idcompete + "&itemid=" + id + "&id=" + ds.Tables[0].Rows[i]["id"] + "'> 编辑</a><br></li>");
        }
        sb.AppendLine("</ul></div>");
        port = sb.ToString();

        //GridView1.DataSource = new DB6.tblEquipment_Item().GetList("idEquipment=" + id + "");
        //GridView1.DataBind();
    }
    protected void but_save_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.uId != 100055041 && CurrentUser.uId != 100001183 && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        if (Cname.Value == string.Empty)
        {
            AlertHelper.JQAlertGo("请填写旅游名称！", "", false);
            return;
        }
        if (dRaceBegin.Value == string.Empty || dRaceEnd.Value == string.Empty)
        {
            AlertHelper.JQAlertGo("请填时间！", "", false);
            return;
        }

        DBM6.tbltour modl = new DBM6.tbltour();
        modl.idCompete = TypeChangeDefault.NullToInt(idcompete, 0);
        modl.cName = Cname.Value;


       
        modl.iBuyMax = TypeChangeDefault.NullToInt(iBuyMax.Value, 0);
        modl.dBeginTime = TypeChangeDefault.NullToDateTime(dRaceBegin.Value, DateTime.Now);
        modl.dEndTime = TypeChangeDefault.NullToDateTime(dRaceEnd.Value, DateTime.Now);
        modl.cLink = cLink.Value;
        
        modl.cImage = hdtt.Value;
        modl.cBio = Text1.Value;
        modl.cReason = Text2.Value;
        modl.cNorm = Text3.Value;
        modl.iStatus = TypeChangeDefault.NullToInt(iState.Value, 0);
        modl.iGlobal = 1;//TypeChangeDefault.NullToInt(iGlobal.Value, 0);
        Regex digitregex = new Regex(@"^[0-9]\d*[.]?\d*$");//初始化正则表达式
        if (digitregex.IsMatch(px.Value.ToString()) == true)
        {
            if (TypeChangeDefault.NullToInt(px.Value, 0) > 99)
            {
                AlertHelper.JQAlertGo("超出规定范围（0-99）值！", "", false);
                return;
            }
            else
            {
                modl.iSort = TypeChangeDefault.NullToInt(px.Value, 0);
            }
        }
        else
        {
            AlertHelper.JQAlertGo("请输入（0-9）数字！", "", false);
            return;
        }
        #region 动态验证
        int numid = 0;
        int sumn = 0;
        for (int i = 0; i < 1000; i++)
        {
            Begintime = TypeChangeDefault.NullToDateTime(Request.Form["dRaceBegin" + i.ToString()], DateTime.Now);
            endtime = TypeChangeDefault.NullToDateTime(Request.Form["dRaceEnd" + i.ToString()], DateTime.Now);
            Color = TypeChangeDefault.NullToString(Request.Form["cColor" + i.ToString()], "");
            Size = TypeChangeDefault.NullToString(Request.Form["cSize" + i.ToString()], "");
            Limit = TypeChangeDefault.NullToInt(Request.Form["iLimit" + i.ToString()], 0);
            MarketPrice = TypeChangeDefault.NullToDecimal(Request.Form["fMarketPrice" + i.ToString()], 0);
            SellPrice = TypeChangeDefault.NullToDecimal(Request.Form["fSellPrice" + i.ToString()], 0);
            Score = TypeChangeDefault.NullToInt(Request.Form["iScore" + i.ToString()], 0);
            Money = TypeChangeDefault.NullToInt(Request.Form["iMoney" + i.ToString()], 0);
            vatarurl = TypeChangeDefault.NullToString(Request.Form["avatarurl" + i.ToString()], "");
            if (Limit.ToString()!=string.Empty && Color != string.Empty && Size != string.Empty)
            {
                if (endtime < Begintime)
                {
                    AlertHelper.JQAlertGo("开始时间不能大于结束时间！", "", false);
                    return;
                }
                if (Color == string.Empty)
                {
                    AlertHelper.JQAlertGo("请填写类型！", "", false);
                    return;
                }
                if (Size == string.Empty)
                {
                    AlertHelper.JQAlertGo("请填写项目！", "", false);
                    return;
                }
                sumn = sumn + Limit;
                numid++;
            }
        }
        
        #endregion
        int inum = 0;
        DataSet ds = new DB6.tbltour_Item().GetList("idEquipment=" + id + "");
        for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
        {
            inum = inum + TypeChangeDefault.NullToInt(ds.Tables[0].Rows[j]["iLimit"].ToString(), 0);
        }
        modl.iTotal = sumn + inum;
        modl.idUser = CurrentUser.uId;
        if (id == 0)
        {
            if (numid == 0)
            {
                AlertHelper.JQAlertGo("请填加旅游！", "", false);
                return;
            }
            
            modl.dCreate = DateTime.Now;
            //int idceom = new DB6.tblEquipment().GetMaxId();
            int t = new DB6.tbltour().Add(modl);
            if (t > 0)
            {
                
                #region 获取动态加载数据

                if (0 == new DB6.tbltour().GetMaxId())
                {
                    dtsave(1);
                }
                else
                {
                    dtsave(new DB6.tbltour().GetMaxId() - 1);
                } 
                #endregion
                AlertHelper.JQAlertGo("添加成功！", "ItemsLylb.aspx?sid=" + idcompete + "", true);
                return;
            }
            else
            {
                AlertHelper.JQAlertGo("添加失败，请重试！", "", false);
                return;
            }
        }
        else
        {
            modl.id = id;
            bool tt = new DB6.tbltour().Update(modl);
            if (tt)
            {
                #region 获取动态加载数据
                dtsave(id);
                #endregion
                AlertHelper.JQAlertGo("修改成功！", "ItemsLylb.aspx?sid=" + idcompete + "", true);
                return;
            }
            else
            {
                AlertHelper.JQAlertGo("修改失败，请重试！", "", false);
                return;
            }

        }

    }
    public bool UpPhotoSaveAs(HttpPostedFile uploadFile, string Path, string FileName)
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

    public void dtsave(int idequstm)
    {//动态添加款式        

        for (int i = 0; i < 1000; i++)
        {
            Begintime = TypeChangeDefault.NullToDateTime(Request.Form["dRaceBegin" + i.ToString()], DateTime.Now);
            endtime = TypeChangeDefault.NullToDateTime(Request.Form["dRaceEnd" + i.ToString()], DateTime.Now);
            Color = TypeChangeDefault.NullToString(Request.Form["cColor" + i.ToString()], "");
            Size = TypeChangeDefault.NullToString(Request.Form["cSize" + i.ToString()], "");
            Limit = TypeChangeDefault.NullToInt(Request.Form["iLimit" + i.ToString()], 0);
            MarketPrice = TypeChangeDefault.NullToDecimal(Request.Form["fMarketPrice" + i.ToString()], 0);
            SellPrice = TypeChangeDefault.NullToDecimal(Request.Form["fSellPrice" + i.ToString()], 0);
            Score = TypeChangeDefault.NullToInt(Request.Form["iScore" + i.ToString()], 0);
            Money = TypeChangeDefault.NullToInt(Request.Form["iMoney" + i.ToString()], 0);
            vatarurl = TypeChangeDefault.NullToString(Request.Form["avatarurl" + i.ToString()], "");
            
            if (Color != string.Empty && Size != string.Empty && Limit.ToString()!=string.Empty)
            {
                DBM6.tbltour_Item mod = new DBM6.tbltour_Item();
                mod.cColor = Color;
                mod.cEquipmentName = Cname.Value.ToString();
                mod.cItemName = Cname.Value.ToString();
                mod.cSize = Size;
                mod.cURL = vatarurl.ToString();
                mod.dBeginTime = Begintime;
                mod.dEndTime = endtime;
                mod.fMarketPrice = MarketPrice;
                mod.fSellPrice = SellPrice;
                mod.iScore = Score;
                mod.iMoney = Money;
                mod.iLimit = Limit;
                mod.idUser = CurrentUser.uId;
                mod.idEquipment = idequstm;
                mod.dCreate = DateTime.Now;
                new DB6.tbltour_Item().Add(mod);
            }
        }
    }
}