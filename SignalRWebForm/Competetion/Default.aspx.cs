using System;
using System.Data;
using System.Web.UI;
using Erun360.BLL;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DB3 = Erun360.BLL.DB3;
using DB4 = Erun360.BLL.DB4;
using DB5 = Erun360.BLL.DB5;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DBM4 = Erun360.Model.DB4;
using DBM5 = Erun360.Model.DB5;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using Utils;
using System.Collections;
using System.Collections.Generic;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json;
using System.Text;

public partial class Competetion_Default : PageBase
{
    private int fbid = 0;//发布赛事的用户id
    private int cid = 0;//赛事id
    public string CompetitionList = string.Empty;//全部赛事
    public string FoucsCompetitionList = string.Empty;//关注赛事
    public string MyCompetitionList = string.Empty;//关注赛事
    public string Result = string.Empty;
    public int uid = 0;//当前登录用户id
    StringBuilder stb = new StringBuilder();

    protected void Page_Load(object sender, EventArgs e)
    {//赛事介绍
        if (CurrentUser!= null)
        {
            uid = CurrentUser.uId;
        }
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (Request.QueryString["cid"] != null)
        {
            cid = TypeChangeDefault.NullToInt(Request.QueryString["cid"].ToString(), 0);
        }
        //if (!IsPostBack)
        //{
            DBM6.tblRace_Competition mCompetetion = new DB6.tblRace_Competition().GetModel(cid);
            DBM6.tblRace_Item mCion = new DB6.tblRace_Item().GetCompeteModel(cid);
            DataTable dt = new DB6.tblRace_Item().GetList(0, "idCompete=" + cid, " iType,id ").Tables[0];
           // DBM6.tblOrder zd = new DB6.tblOrder().GetModel();
            //string str = null;
            Hashtable good = new Hashtable();
            //Hashtable hht = null;
            StringBuilder sb = new StringBuilder();
            List<Hashtable> goodInfo = new List<Hashtable>();
            //List<Hashtable> hhtInfo = new List<Hashtable>();
            if (mCompetetion != null)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    sb.AppendLine(dt.Rows[i]["cItemName"] + ":" + "<i>￥" + dt.Rows[i]["iCost"] + "</i>"+ "<br>"); 
                }
                good.Add("ssfy", sb.ToString());                
                good.Add("cTitle", mCompetetion.cTitle);//赛事名字
                switch (mCompetetion.idCompeteStyle)
                {
                    case 0:
                        good.Add("idCompeteStyle", "U超级马拉");
                        break;
                    case 1:
                        good.Add("idCompeteStyle", "M全程马拉");
                        break;
                    case 2:
                        good.Add("idCompeteStyle", "H半程马拉");
                        break;
                    case 3:
                        good.Add("idCompeteStyle", "R路跑");
                        break;
                    case 4:
                        good.Add("idCompeteStyle", "C越野跑");
                        break;
                    
                    default:
                        good.Add("idCompeteStyle", "T其它");
                        break;
                }
                //赛事类型
                if (CurrentUser != null)
                {
                    good.Add("uid", CurrentUser.uId);//用户id
                }
                else
                {
                    good.Add("uid", "0");//用户id
                }
                good.Add("idcompete", mCompetetion.id);//赛事id
                //good.Add("p",0);
                good.Add("cCityname", mCompetetion.cCityname);//城市名字                
                good.Add("dRaceBegin", mCompetetion.dRaceBegin);//赛事开始时间
                good.Add("dRaceEnd", mCompetetion.dRaceEnd);//赛事结束时间
                good.Add("dJoinBegin", mCompetetion.dJoinBegin);//报名开始时间
                good.Add("dJoinEnd", mCompetetion.dJoinEnd);//报名结束时间
                good.Add("cContent", mCompetetion.cContent);//赛事介绍
                //good.Add("dCreate", mCompetetion.dCreate);//创建时间
                good.Add("iStatus", mCompetetion.iStatus);//状态
                //good.Add("idUser", mCompetetion.idUser);//创建人
                //good.Add("dSubmitCreate", mCompetetion.dSubmitCreate);//提交时间
                good.Add("Banner",mCompetetion.cBanner);//赛事头图
                good.Add("Pictures",mCompetetion.cPictures);//图片Url
                
                if (uid!= 0)
                {
                    DataTable tbod = new DB6.tblOrder().GetList("iTypeID="+ cid +" and idUser ="+ CurrentUser.uId +" and iFromTpye =2").Tables[0];
                    if (tbod.Rows.Count>0)
                    {
                        good.Add("cOrder_no", tbod.Rows[0]["cOrder_no"].ToString());//
                        good.Add("p", tbod.Rows[0]["iItemID"].ToString());
                        if (mCompetetion.dJoinEnd < DateTime.Now)
                        {
                            good.Add("bm", "5");
                        }
                        else if (DateTime.Now < mCompetetion.dJoinBegin)
                        {
                            good.Add("bm", "4");
                        }
                        else if (tbod.Rows[0]["iStatus"].ToString() == "0")
                        {
                            good.Add("bm", "0");
                        }
                        else if (tbod.Rows[0]["iStatus"].ToString() == "1")
                        {
                            good.Add("bm", "1");
                        }
                        else if (tbod.Rows[0]["iStatus"].ToString() == "2")
                        {

                            int cont = new DB6.tblRace_Item().GetRecordCount("id = " + tbod.Columns["iItemID"]);
                            if (cont > 0)
                            {
                                good.Add("bm","7");
                            }
                            else
                            {
                                good.Add("bm", "2");
                            }
                            
                        }
                        else if (tbod.Rows[0]["iStatus"].ToString() == "-1")
                        {
                            good.Add("bm", "6");
                        }
                        else if (tbod.Rows[0]["iStatus"].ToString() == "3")
                        {
                            good.Add("bm", "3");
                        }
                    }
                    else
                    {
                        good.Add("bm", "6");
                        good.Add("cOrder_no", "0");//
                        good.Add("p",0);
                    }
                    DB4.tblRACE_JOIN uRace_Join = new DB4.tblRACE_JOIN();
                    if (uRace_Join.Exists(mCompetetion.id, TypeChangeDefault.NullToInt(uid, 0)))
                    {
                        good.Add("gz", "1");
                    }
                    else
                    {
                        good.Add("gz", "0");
                    }
                    
                }
                else
                {
                    good.Add("bm", "5");
                    good.Add("gz", "0");
                    good.Add("cOrder_no","0");//
                    good.Add("p", 0);
                }
                
                
                goodInfo.Add(good);
                IsoDateTimeConverter iso = new IsoDateTimeConverter();
                iso.DateTimeFormat = "yyyy-MM-dd HH:mm";
                Result = JsonConvert.SerializeObject(goodInfo, iso);
                Result = Result.TrimEnd(']');
                Result = Result.TrimStart('[');
                //Response.Write(Result);
            }
            else
            {
                Result = "无赛事";
                //Response.Write("无赛事");
            }
        //}
    }
}