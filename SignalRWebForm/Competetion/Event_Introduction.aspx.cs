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

public partial class Competetion_Event_Introduction : PageBase
{
    private int fbid = 0;//发布赛事的用户id
    private int cid = 0;//赛事id
    public string CompetitionList = string.Empty;//全部赛事
    public string FoucsCompetitionList = string.Empty;//关注赛事
    public string MyCompetitionList = string.Empty;//关注赛事
    string Result = string.Empty;
    public int uid = 0;//当前登录用户id
    StringBuilder stb = new StringBuilder();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        //if (Request.QueryString["uId"] != null)
        //{
        //    fbid = TypeChangeDefault.NullToInt(Request.QueryString["uId"].ToString(), 0);
        //}
        if (Request.QueryString["cid"] != null)
        {
            cid = TypeChangeDefault.NullToInt(Request.QueryString["cid"].ToString(), 0);
        }
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition mCompetetion = new DB6.tblRace_Competition().GetModel(cid);

            //DataSet ds = new DB3.tblIMAGES().GetImgUrlList("idinfo ='"+ cid +"'");
            //int cout = new DB3.tblIMAGES().GetRecordCount("idinfo ='"+ uId +"'");
            
             Hashtable good = new Hashtable();
            List<Hashtable> goodInfo = new List<Hashtable>();
            if (mCompetetion != null)
            {
                //good.Add("cid",mCompetetion.id);//赛事id
                //good.Add("uid",CurrentUser.uId);//当前登录用户
                //good.Add("fbid", fbid);//赛事发布用户
                good.Add("cTitle", mCompetetion.cTitle);//赛事名字
                good.Add("idCompeteStyle", mCompetetion.idCompeteStyle);//赛事类型
                //good.Add("idCity",mCompetetion.idCity);//城市号
                good.Add("cCityname", mCompetetion.cCityname);//城市名字                
                good.Add("dRaceBegin", mCompetetion.dRaceBegin);//赛事开始时间
                good.Add("dRaceEnd", mCompetetion.dRaceEnd);//赛事结束时间
                good.Add("dJoinBegin", mCompetetion.dJoinBegin);//报名开始时间
                good.Add("dJoinEnd", mCompetetion.dJoinEnd);//报名结束时间
                good.Add("cContent", mCompetetion.cContent);//赛事介绍
                good.Add("dCreate", mCompetetion.dCreate);//创建时间
                good.Add("iStatus", mCompetetion.iStatus);//状态
                good.Add("idUser", mCompetetion.idUser);//创建人
                good.Add("dSubmitCreate", mCompetetion.dSubmitCreate);//提交时间
                if (DateTime.Now < mCompetetion.dJoinBegin || DateTime.Now > mCompetetion.dJoinEnd)
                {
                    good.Add("bm", false);
                }
                else
                {
                    good.Add("bm", true);
                }
                DB4.tblRACE_JOIN uRace_Join = new DB4.tblRACE_JOIN();
                if (uRace_Join.Exists(mCompetetion.id, TypeChangeDefault.NullToInt(mCompetetion.idUser,0)))
                {
                    good.Add("gz","已关注");
                }
                else
                {
                    good.Add("gz","立即关注");
                }
                DBM6.tblRace_Item mCion = new DB6.tblRace_Item().GetModel(cid);
                if (mCion != null)
                {
                    good.Add("bm", "赛事正在筹划中");
                }
                else 
                {
                    good.Add("bm", "开始报名");
                }
                if (mCompetetion.dJoinEnd < DateTime.Now)
                {
                    good.Add("bm","报名截止");
                }
                goodInfo.Add(good);
                IsoDateTimeConverter iso = new IsoDateTimeConverter();
                iso.DateTimeFormat = "yyyy-MM-dd HH:mm";
                Result = JsonConvert.SerializeObject(goodInfo, iso);
                Response.Write(Result);
            }
            else
            {
                Response.Write("无赛事");
            }
        }
    }
}