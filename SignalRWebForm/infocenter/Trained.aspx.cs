using Erun360.BLL;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using System.Data;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DBM2 = Erun360.Model.DB2;
using DB2 = Erun360.BLL.DB2;
using System.IO;
using Utils;
public partial class infocenter_Trained : PageBase
{
    public string DrillList = string.Empty;
    public int uId = 0;
    public string NewCharts = string.Empty;
    public string NewMonthCharts = string.Empty;
    public string NewMonth = string.Empty;
    public DrillInfo drill = new DrillInfo();
    public int cId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uId"] != null)
        {
            uId = int.Parse(Request.QueryString["uId"].ToString());
        }
        if (CurrentUser != null)
        {
            cId = CurrentUser.uId;
        }
        if (!IsPostBack)
        {
            if (CurrentUser != null)
            {
                cId = CurrentUser.uId;
                DataTable dt = new DB4.tblRACE_HISTORY().GetWeekData(CurrentUser.uId).Tables[0];

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    NewCharts += dt.Rows[i]["total"] + ",";
                }
                NewCharts = "[" + NewCharts.TrimEnd(',') + "]";

                DataTable dtMonth = new DB4.tblRACE_HISTORY().GetMonthData(CurrentUser.uId).Tables[0];

                for (int i = 0; i < dtMonth.Rows.Count; i++)
                {
                    NewMonthCharts += dtMonth.Rows[i]["total"] + ",";
                    NewMonth += "'" + dtMonth.Rows[i]["Months"] + "',";
                }
                NewMonthCharts = "[" + NewMonthCharts.TrimEnd(',') + "]";
                NewMonth = "[" + NewMonth.TrimEnd(',') + "]";
                //NewCharts = drill.GetChartXML(cId);
                //NewMonthCharts = drill.NewMonthChartsXML(cId);

                BindEquipment(cId);
            }
            else
            {
                NewCharts = "[]";
                NewMonthCharts = "[]";
                NewMonth = "[]";
            }
           
        }
      
        this.page_Title = "训练成绩-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";

    }
  
    private void BindEquipment(int uid)
    {
        //DB1.tblGROUPS uGroup = new DB1.tblGROUPS();
        DB5.tblPRODUCTS uProduct = new DB5.tblPRODUCTS();
        DataTable dt = uProduct.GetList("idUser=" + uid).Tables[0];

    }
    protected void imgbtnRace_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        DBM4.tblRACE_HISTORY mRace_History = new DBM4.tblRACE_HISTORY();

        if (Request.Form["idRoadStyle"] != null)
        {
            mRace_History.idRoadStyle = Int32.Parse(Request.Form["idRoadStyle"].ToString());
        }
        if (Request.Form["iDistance"] != null)
        {
            decimal iDistance = decimal.Parse(Request.Form["iDistance"].ToString());
            if (iDistance.CompareTo(500) > 0)
            {
                AlertHelper.JQAlert("最大距离为500！", false);
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('最大距离为500！','','false');});</script>");
                return;
            }
            mRace_History.iDistance = decimal.Parse(Request.Form["iDistance"].ToString());
        }
        else
        {
            AlertHelper.JQAlert("填写距离！", false);
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('请填写距离！','','false');});</script>");
            return;
        }
        if (Request["roadtime"].ToString() != "选择时间")
        {
            mRace_History.dRunTime = DateTime.Parse("2001-01-01 " + Request["roadtime"].ToString());
        }
        else
        {
            AlertHelper.JQAlert("请选择时间！", false);
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('请选择时间！','','false');});</script>");
            return;
        }
        //if (Request.Form["iHours"] != null && Request.Form["iMinutes"] != null && Request.Form["iSeconds"] != null)
        //{
        //    mRace_History.dRunTime = DateTime.Parse("2001-01-01 " + Request.Form["iHours"].ToString() + ":" + Request.Form["iMinutes"].ToString() + ":" + Request.Form["iSeconds"].ToString());
        //}
        
        string cEquipment = string.Empty;
        string cEquipmentValue = string.Empty;


        if (cEquipment.Length > 0)
        {
            mRace_History.cEquipment = XString.SqlSafe(cEquipment.TrimEnd('|'));
            //mRace_History.cEquipment = XString.SqlSafe(Request.Form["cEquipment"].ToString());
            mRace_History.idProduct = cEquipmentValue.TrimEnd('|');
        }
        if (Request.Form["cMemo"] != null)
        {
            mRace_History.cMemo = XString.SqlSafe(Request.Form["cMemo"].ToString());
        }
        //DB1.tblMEMBER uMember = new DB1.tblMEMBER();
        //DBM1.tblMEMBER mMember = uMember.GetModel(CurrentUser.uId);

        mRace_History.idUser = CurrentUser.uId;
        mRace_History.cName = CurrentUser.cNickName;

        DB4.tblRACE_HISTORY uRace_History = new DB4.tblRACE_HISTORY();
        int Raceid = uRace_History.Add(mRace_History);
        if (Raceid > 0)
        {

            #region 积分:发表训练记录
            //DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
            //uMember_History.Insert(CurrentUser.uId, 100800116, 1);           
            new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810010, 1, 0, 1);
            #endregion
            //2013-08-19 1关注11用户/12博文/13赛事/14装备，2发布22博文/23赛事/24装备/25训练，3评论31留言/32博文/33赛事/34/装备
            DBM2.tblActivity mActivity = new DBM2.tblActivity();
            mActivity.idUser = CurrentUser.uId;
            mActivity.cNickName = CurrentUser.cNickName;
            mActivity.cAvatar = CurrentUser.cAvatar;
            mActivity.idBlog = Raceid;
            mActivity.idGroup = "25";
            mActivity.cTitle = Convert.ToDateTime(mRace_History.dExpectTime).ToString("yyyy-MM-dd") + "在 " + EnumRoad((int)mRace_History.idRoadStyle) + " 跑了 " + mRace_History.iDistance + "KM，用时 " + Convert.ToDateTime(mRace_History.dRunTime).ToString("HH小时mm分ss秒");
            mActivity.cBio = "";
            mActivity.dCreate = DateTime.Now;
            new DB2.tblActivity().Add(mActivity);
            if (mRace_History.idProduct != null)
            {
                string[] idProductUse = mRace_History.idProduct.Split('|');
                if (idProductUse.Length > 0)
                {
                    //DateTime dt = Convert.ToDateTime(mRace_History.dRunTime);
                    //int h = dt.Hour;
                    //int m = dt.Minute;
                    //int s = dt.Second;
                    //int ss = h * 3600 + m * 60 + s;

                    string time = Convert.ToDateTime(mRace_History.dRunTime).ToString("HH:mm:ss");
                    for (int i = 0; i < idProductUse.Length; i++)
                    {
                        DBM5.tblPRODUCTS_USE ProductUseModel = new DB5.tblPRODUCTS_USE().GetModelByidProduct(TypeChangeDefault.NullToInt(idProductUse[i], 0));
                        if (ProductUseModel != null)
                        {
                            DBM5.tblPRODUCTS_USE ProductUse = new DBM5.tblPRODUCTS_USE();
                            //ProductUse.idProduct = TypeChangeDefault.NullToInt(idProductUse[i], 0);
                            //ProductUse.idUser = CurrentUser.uId;
                            //ProductUse.dCreate = DateTime.Now;
                            ProductUse.total_time = ProductUseModel.total_time + Convert2Time(time);
                            ProductUse.fRunDistance = ProductUseModel.fRunDistance + mRace_History.iDistance;
                            ProductUse.last_time = DateTime.Now;
                            ProductUse.id = ProductUseModel.id;
                            new DB5.tblPRODUCTS_USE().Update(ProductUse);
                        }
                        else
                        {
                            DBM5.tblPRODUCTS_USE ProductUse = new DBM5.tblPRODUCTS_USE();
                            ProductUse.idProduct = TypeChangeDefault.NullToInt(idProductUse[i], 0);
                            ProductUse.idUser = CurrentUser.uId;
                            ProductUse.dCreate = DateTime.Now;
                            ProductUse.total_time = Convert2Time(time);
                            ProductUse.fRunDistance = mRace_History.iDistance;
                            ProductUse.last_time = DateTime.Now;
                            new DB5.tblPRODUCTS_USE().Add(ProductUse);
                        }
                    }
                }
            }
        }
        //DB4.tblRACE_HISTORY uRace_History = new DB4.tblRACE_HISTORY();
        //pager.RecordCount = uRace_History.GetRecordCount(" idUser =" + uId, uId);
        //if (uId != 0)
        //{
        //    Bind(cId, uId);
        //}
        //else
        //{
        //    Bind(cId, cId);
        //}
        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('提交成功！','/infocenter/Trained.aspx?uId=" + uId + "','true');});</script>");
    }
    private string EnumRoad(int idRoadStyle)
    {
        string Road = string.Empty;
        switch (idRoadStyle)
        {
            case 0: Road = "公园"; break;//a
            case 1: Road = "田径场"; break;//b
            case 2: Road = "公路"; break;//o
            case 3: Road = "山路"; break;//ab
            case 4: Road = "跑步机"; break;//其他
            case 5: Road = "其它"; break;//其他
            default:
                Road = "赛事App记录";
                break;
        }
        return Road;
    }
    public int Convert2Time(string time)
    {
        string[] _time = time.Split(':');
        int sec = Convert.ToInt32(_time[0]) * 3600;
        sec += Convert.ToInt32(_time[1]) * 60;
        sec += Convert.ToInt32(_time[2]);
        return sec;
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