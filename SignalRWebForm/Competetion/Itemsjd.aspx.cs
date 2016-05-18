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

public partial class Competetion_Itemsjd : PageBase
{
    public string port = string.Empty;
    public string portrait = string.Empty;
    public int idcompete = 0;
    private int id = 0;

    public string title = string.Empty;
    StringBuilder sb = new StringBuilder();
    public static StringBuilder sbb = new StringBuilder();

    public DateTime Begintime = DateTime.Now;
    public DateTime endtime = DateTime.Now;
    public string HotelName = string.Empty;
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
            BindGoods();
            DBM6.tblRace_Competition comp = new DB6.tblRace_Competition().GetModel(TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0));
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
            this.page_Title = title+"添加酒店";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            if (id != 0)
            {
                DBM6.tblHotel model = new DB6.tblHotel().GetModel(id);
                if (model != null)
                {
                    //idGood.SelectedValue = model.idCompete.ToString();
                    Cname.Value = model.cName.ToString();
                    //iTotal.Value = model.iTotal.ToString();
                    iBuyMax.Value = model.iBuyMax.ToString();
                    dRaceBegin.Value = Convert.ToDateTime(model.dBeginTime).ToString("yyyy-MM-dd");
                    dRaceEnd.Value = Convert.ToDateTime(model.dEndTime).ToString("yyyy-MM-dd");
                    cLink.Value = model.cLink.ToString();
                    //portrait = model.cImage.ToString();
                    Text1.Value = model.cBio.Replace("[IMG]", "<img src=\"").Replace("[/IMG]", "\"/>");
                    Text2.Value = model.cFit.Replace("[IMG]", "<img src=\"").Replace("[/IMG]", "\"/>");
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
                dRaceBegin.Value = string.Format("{0:yyyy-MM-dd}", DateTime.Now);
                dRaceEnd.Value = string.Format("{0:yyyy-MM-dd}", DateTime.Now);
            }
        }
    }
    public void Bding()
    {
        DataSet ds = null;
        ds = new DB6.tblHotel_Item().GetList("idHotel=" + id + "");
        //Repeater1.DataSource = ds;
        //Repeater1.DataBind();

        sb.AppendLine("<div class=\"fblil\"><label>房型列表：</label></div><div class=\"fblir hoteltype\"><ul>");
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            sb.AppendLine("<li>房型" + i + "<label>" + ds.Tables[0].Rows[i]["cItemName"] + "</label><a href='ItemsjdAdd.aspx?sid=" + idcompete + "&itemid=" + id + "&id=" + ds.Tables[0].Rows[i]["id"] + "'> 编辑</a><br></li>");
        }
        sb.AppendLine("</ul></div>");
        port = sb.ToString();
    }
    protected void but_save_Click(object sender, EventArgs e)
    {
        if (Cname.Value == string.Empty)
        {
            AlertHelper.JQAlertGo("请填写酒店名称！", "", false);
            return;
        }
        if (dRaceBegin.Value == string.Empty || dRaceEnd.Value == string.Empty)
        {
            AlertHelper.JQAlertGo("请填时间！", "", false);
            return;
        }
        DBM6.tblHotel modl = new DBM6.tblHotel();
        modl.idCompete = TypeChangeDefault.NullToInt(idcompete, 0);
        modl.cName = Cname.Value;
      
       
        modl.iBuyMax = TypeChangeDefault.NullToInt(iBuyMax.Value, 0);
        modl.dBeginTime = TypeChangeDefault.NullToDateTime(dRaceBegin.Value, DateTime.Now);
        modl.dEndTime = TypeChangeDefault.NullToDateTime(dRaceEnd.Value, DateTime.Now);
        modl.cLink = cLink.Value;
        
        modl.cImage = hdtt.Value;
        modl.cBio = Text1.Value;
        modl.cFit = Text2.Value;
        modl.cNorm = Text3.Value;
        modl.iStatus = TypeChangeDefault.NullToInt(iState.Value, 0);
        modl.iGlobal = 1;
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
        modl.dCreate = DateTime.Now;
        modl.idUser = CurrentUser.uId;
        if (modl.dBeginTime > modl.dEndTime)
        {
            AlertHelper.JQAlertGo("开始时间不能大于结束时间！", "", false);
            return;
        }
        #region 动态验证
        int numid = 0;
        int sumn = 0;
        for (int i = 0; i < 1000; i++)
        {
            Begintime = TypeChangeDefault.NullToDateTime(Request.Form["dRaceBegin" + i.ToString()], DateTime.Now);
            endtime = TypeChangeDefault.NullToDateTime(Request.Form["dRaceEnd" + i.ToString()], DateTime.Now);
            HotelName = TypeChangeDefault.NullToString(Request.Form["cHotelName" + i.ToString()], "");
            Limit = TypeChangeDefault.NullToInt(Request.Form["iLimit" + i.ToString()], 0);
            MarketPrice = TypeChangeDefault.NullToDecimal(Request.Form["fMarketPrice" + i.ToString()], 0);
            SellPrice = TypeChangeDefault.NullToDecimal(Request.Form["fSellPrice" + i.ToString()], 0);
            Score = TypeChangeDefault.NullToInt(Request.Form["iScore" + i.ToString()], 0);
            Money = TypeChangeDefault.NullToInt(Request.Form["iMoney" + i.ToString()], 0);
            vatarurl = TypeChangeDefault.NullToString(Request.Form["avatarurl" + i.ToString()], "");
            if (Limit.ToString() !=string.Empty && HotelName != string.Empty)
            {
                if (endtime < Begintime)
                {
                    AlertHelper.JQAlertGo("开始时间不能大于结束时间！", "", false);
                    return;
                }
                if (HotelName == string.Empty)
                {
                    AlertHelper.JQAlertGo("请填写房型！", "", false);
                    return;
                }
                sumn = sumn + Limit;
                numid++;
            }
        }
        int isum = 0;
        DataSet dhtm = new DB6.tblHotel_Item().GetList("idHotel=" + id + "");
        for (int j = 0; j < dhtm.Tables[0].Rows.Count; j++)
        {
            isum = isum + TypeChangeDefault.NullToInt(dhtm.Tables[0].Rows[j]["iLimit"].ToString(), 0);
        }
        modl.iTotal = sumn + isum;
        #endregion
        if (id == 0)
        {
            if (numid == 0)
            {
                AlertHelper.JQAlertGo("请填加房型！", "", false);
                return;
            }
            
            int i = new DB6.tblHotel().Add(modl);
            if (i > 0)
            {

                #region 获取动态加载数据
                if (0 == new DB6.tblHotel().GetMaxId())
                {
                    dtsave(1);
                }
                else
                {
                    dtsave(new DB6.tblHotel().GetMaxId() - 1);
                } 
                #endregion
                AlertHelper.JQAlertGo("添加成功！", "Itemsjdlb.aspx?sid=" + idcompete + "", true);
                return;
            }
            else
            {
                AlertHelper.JQAlertGo("添加失败！", "", false);
                return;
            }
        }
        else
        {
            modl.id = id;
            bool cout = new DB6.tblHotel().Update(modl);
            if (cout)
            {
                #region 获取动态加载数据
                dtsave(id);
                #endregion
                AlertHelper.JQAlertGo("修改成功！", "Itemsjdlb.aspx?sid=" + idcompete + "", true);
                return;
            }
            else
            {
                AlertHelper.JQAlertGo("修改失败！", "", false);
                return;
            }

        }

    }
    protected void BindGoods()
    {
        //DataSet ds = new DB6.tblRace_Competition().GetList("iStatus>0 ");
        //idGood.DataSource = ds.Tables[0];
        //idGood.DataTextField = "cTitle";
        //idGood.DataValueField = "id";
        //idGood.DataBind();
        //idGood.Items.Insert(0, new ListItem("--所有--", "0"));
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
        if (idequstm == 0)
        {
            idequstm = new DB6.tblHotel().GetMaxId();
        }

        for (int i = 0; i < 1000; i++)
        {
            Begintime = TypeChangeDefault.NullToDateTime(Request.Form["dRaceBegin" + i.ToString()], DateTime.Now);
            endtime = TypeChangeDefault.NullToDateTime(Request.Form["dRaceEnd" + i.ToString()], DateTime.Now);
            HotelName = TypeChangeDefault.NullToString(Request.Form["cHotelName" + i.ToString()], "");
            Limit = TypeChangeDefault.NullToInt(Request.Form["iLimit" + i.ToString()], 0);
            MarketPrice = TypeChangeDefault.NullToDecimal(Request.Form["fMarketPrice" + i.ToString()], 0);
            SellPrice = TypeChangeDefault.NullToDecimal(Request.Form["fSellPrice" + i.ToString()], 0);
            Score = TypeChangeDefault.NullToInt(Request.Form["iScore" + i.ToString()], 0);
            Money = TypeChangeDefault.NullToInt(Request.Form["iMoney" + i.ToString()], 0);
            vatarurl = TypeChangeDefault.NullToString(Request.Form["avatarurl" + i.ToString()], "");

            if (HotelName != string.Empty && Begintime != null && endtime!=null)
            {
                DBM6.tblHotel_Item mod = new DBM6.tblHotel_Item();
                mod.cHotelName = HotelName;
                mod.cItemName = HotelName;
                mod.cURL = vatarurl.ToString();
                mod.dBeginTime = Begintime;
                mod.dEndTime = endtime;
                mod.fMarketPrice = MarketPrice;
                mod.fSellPrice = SellPrice;
                mod.iScore = Score;
                mod.iMoney = Money;
                mod.iLimit = Limit;
                mod.idUser = CurrentUser.uId;
                mod.idHotel = idequstm;
                mod.dCreate = DateTime.Now;
                new DB6.tblHotel_Item().Add(mod);
            }
        }
    }
}