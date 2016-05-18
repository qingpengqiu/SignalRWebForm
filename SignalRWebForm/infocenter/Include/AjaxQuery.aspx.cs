using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Data;
using DBM2 = Erun360.Model.DB2;
using DB2 = Erun360.BLL.DB2;

public partial class infocenter_Include_AjaxQuery : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["method"] != null)
            {
                if (Request["method"].Trim() == "trained")
                {
                    Response.Write(trainedMethod());
                }
                if (Request["method"].Trim() == "nick")
                {
                    Response.Write(UpdateNick());
                }
                if (Request["method"].Trim() == "bio")
                {
                    Response.Write(UpdateBio());
                }
            }
        }
    }
    protected int trainedMethod()
    {
        try
        {
            DBM4.tblRACE_HISTORY mRace_History = new DBM4.tblRACE_HISTORY();
            mRace_History.dExpectTime = DateTime.Now;
            if (Request["idRoadStyle"] != null)
            {
                mRace_History.idRoadStyle = Int32.Parse(Request["idroadstyle"].ToString());
            }
            if (Request["idistance"] != null)
            {
                mRace_History.iDistance = decimal.Parse(Request["idistance"].ToString());
            }
            if (Request["time"] != null)
            {
                mRace_History.dRunTime = DateTime.Parse("2001-01-01 " + Request["time"].ToString());
            }
            //DB1.tblMEMBER uMember = new DB1.tblMEMBER();
            //DBM1.tblMEMBER mMember = uMember.GetModel(CurrentUser.uId);
            if (CurrentUser != null)
            {
                mRace_History.idUser = CurrentUser.uId;
                mRace_History.cName = CurrentUser.cNickName;
                DB4.tblRACE_HISTORY uRace_History = new DB4.tblRACE_HISTORY();
                int Raceid = uRace_History.Add(mRace_History);
                if (Raceid > 0)
                {
                    #region 积分:发表训练记录
                    DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
                    uMember_History.Insert(CurrentUser.uId, 100800116, 1);

                    #endregion
                    //2013-08-19 11关注11用户/12博文/13赛事/14装备，2发布22博文/23赛事/24装备/25训练，3评论31留言/32博文/33赛事/34/装备
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
                }
                return 1;
            }
            return 0;
        }
        catch
        {
            return 0;
        }
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
                break;
        }
        return Road;
    }
    protected string UpdateNick()
    {
        string nick = HttpUtility.UrlDecode(Request["nick"].ToString().Trim());
        
        DB1.tblMEMBER bll = new DB1.tblMEMBER();
        DBM1.tblMEMBER model = new DBM1.tblMEMBER();
        if (nick.Trim().Length == 0 || nick.Trim().Length > 30)
        {
            return "fail";
        }
        else
        {
            if (CurrentUser != null)
            {

                model.cNickName = HttpUtility.UrlDecode(Request["nick"].Trim());
                if (GCommon.BadLoginname(model.cNickName))
                {
                    return "fail";
                }
                if (!bll.ExistNick(CurrentUser.uId, model.cNickName))
                {
                    model.id = CurrentUser.uId;
                    model.iChecksum = Convert.ToInt32(bll.GetList(" id=" + CurrentUser.uId.ToString()).Tables[0].Rows[0]["iChecksum"]);
                    model.dBirthday = null;
                    bll.Update(model);
                    Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().UpdateUserModel(model.id);
                }
                else
                {
                    return "fail";
                }
            }
        }     
        
        DataSet ds = bll.GetList(" id=" + CurrentUser.uId);
        return ds.Tables[0].Rows[0]["cNickName"].ToString().Trim();
    }
    protected string UpdateBio()
    {
        DB1.tblMEMBER bll = new DB1.tblMEMBER();
        DBM1.tblMEMBER model = new DBM1.tblMEMBER();
        try
        {
            model.cBio = HttpUtility.UrlDecode(Request["bio"].Trim());
            model.id = CurrentUser.uId;
            model.iChecksum = Convert.ToInt32(bll.GetList(" id=" + CurrentUser.uId.ToString()).Tables[0].Rows[0]["iChecksum"]);
            model.dBirthday = null;
            bll.Update(model);
            Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().UpdateUserModel(model.id);
        }
        catch
        {
        }
        DataSet ds = bll.GetList(" id=" + CurrentUser.uId);
        return ds.Tables[0].Rows[0]["cbio"].ToString().Trim();
    }
}