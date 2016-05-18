<%@ WebHandler Language="C#" Class="HandlerJoin" %>
using Erun360.BLL;
using Erun360.Model;
using System;
using System.Data;
using System.Web.UI;
using Utils;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using System.IO;
using System.Web.SessionState;
using System.Web;

public class HandlerJoin : IHttpHandler, IRequiresSessionState
{
    public UserInfoModel CurrentUser;
    public string result;
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        string operation = context.Request["op"];
        switch (operation)
        {
            case "savejoininfo":
                SaveJoinInfo(context);
                break;
            default:
                break;
        }
    }
    protected void SaveJoinInfo(HttpContext context)
    {
        int bId = 0;
        if (!string.IsNullOrEmpty(context.Request["bId"]))
        {
            bId = int.Parse(context.Request["bId"]);
        }
        if (context.Session["CurrentUser"] != null)
        {
            CurrentUser = (UserInfoModel)context.Session["CurrentUser"];
        }
        if (CurrentUser != null)
        {
            if (CurrentUser.cName.Length <= 0 || CurrentUser.cMobile.Length <= 0 || CurrentUser.cNationID == null)
            {
                result="{\"msg\":\"您的信息不完善，请完善信息后发布约跑！\",\"status\":\"0\"}";
                ResponseEnd(context, result);
            }
        }
        else
        {
            result="{\"msg\":\"您还没有登录！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(CurrentUser.uId);
        if (0 > user.idMemberStyle)
        {
            result="{\"msg\":\"你的账号已被限制！！！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        DBM4.tblRACE_ACTIVITY mRaceActivity = new DBM4.tblRACE_ACTIVITY();
        if (string.IsNullOrEmpty(context.Request["hdtitle"]))
        {
            result="{\"msg\":\"活动标题不能为空！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else if (context.Request["hdtitle"].Trim().Length > 60)
        {
            result="{\"msg\":\"活动标题超出限制！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        mRaceActivity.cTitle = context.Request["hdtitle"].Trim();

        if (string.IsNullOrEmpty(context.Request["hdtype"]))
        {
            result="{\"msg\":\"请选择活动类型！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        mRaceActivity.idRoadStyle = TypeChange.NullToInt(context.Request["hdtype"],0);

        if (string.IsNullOrEmpty(context.Request["hdtime"]))
        {
            result="{\"msg\":\"请选择活动时间！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        mRaceActivity.dOpen = Convert.ToDateTime(context.Request["hdtime"]);

        if (string.IsNullOrEmpty(context.Request["idCity"]))
        {
            result="{\"msg\":\"请选择活动地点！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        mRaceActivity.idCity = TypeChangeDefault.NullToInt(context.Request["idCity"], 0);
        mRaceActivity.cCityname = context.Request["cCityname"];

        if (string.IsNullOrEmpty(context.Request["hdadd"]))
        {
            result="{\"msg\":\"请填写活动详细地址！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }

        mRaceActivity.cAddress = context.Request["hdadd"];

        if (string.IsNullOrEmpty(context.Request["hdjime"]))
        {
            result="{\"msg\":\"请选择集合时间！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        mRaceActivity.dCollect = Convert.ToDateTime(context.Request["hdjime"]);

        if (string.IsNullOrEmpty(context.Request["hdjadd"]))
        {
            result="{\"msg\":\"请填写集合详细地址！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        mRaceActivity.cCollectAddress = context.Request["hdjadd"];
        mRaceActivity.cPoints = context.Request["coordinates"];

        if (string.IsNullOrEmpty(context.Request["hdatime"]))
        {
            result="{\"msg\":\"选择报名开始时间！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        mRaceActivity.dJoinBegin = Convert.ToDateTime(context.Request["hdatime"]);

        if (string.IsNullOrEmpty(context.Request["hdbtime"]))
        {
            result="{\"msg\":\"选择报名结束时间！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        mRaceActivity.dJoinEnd = Convert.ToDateTime(context.Request["hdbtime"]);

        if (Convert.ToDateTime(context.Request["hdatime"]) > Convert.ToDateTime(context.Request["hdbtime"]))
        {
            result="{\"msg\":\"报名开始时间不能小于报名结束时间！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (Convert.ToDateTime(context.Request["hdtime"]) < Convert.ToDateTime(context.Request["hdatime"]) || Convert.ToDateTime(context.Request["hdtime"]) < Convert.ToDateTime(context.Request["hdbtime"]))
        {
            result="{\"msg\":\"活动时间不能小于报名开始时间和报名结束时间！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }

        if (string.IsNullOrEmpty(context.Request["hdqd"]))
        {
            result="{\"msg\":\"请选择活动强度！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        mRaceActivity.iStrength = TypeChangeDefault.NullToInt(context.Request["hdqd"], 0);

        try
        {
            Convert.ToDecimal(context.Request["hdallkm"]);
        }
        catch (Exception)
        {
            result="{\"msg\":\"总里程输入错误，请重新输入！！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        mRaceActivity.iDistance = Convert.ToDecimal(context.Request["hdallkm"]);
        try
        {
            Convert.ToInt16(context.Request["hdrmb"]);
        }
        catch (Exception)
        {
            result="{\"msg\":\"活动经费输入错误，请重新输入！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (CurrentUser.idMemberStyle < 6)
        {
            mRaceActivity.iFee = 0;
        }
        else
            mRaceActivity.iFee = Convert.ToInt16(context.Request["hdrmb"]);

        if (string.IsNullOrEmpty(context.Request["hdts"]))
        {
            result="{\"msg\":\"请选择活动特色！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        mRaceActivity.iWinner = TypeChangeDefault.NullToInt(context.Request["hdts"], 0);

        try
        {
            Convert.ToInt16(context.Request["hdpeople"]);
            if (Convert.ToInt16(context.Request["hdpeople"]) < 2)
            {
                result="{\"msg\":\"报名人数至少2人！\",\"status\":\"0\"}";
                ResponseEnd(context, result);
            }
        }
        catch (Exception)
        {
            result="{\"msg\":\"报名人数输入错误，请重新输入！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        mRaceActivity.iLimit = Convert.ToInt16(context.Request["hdpeople"]);

        if (string.IsNullOrEmpty(context.Request["hdtt"]))
        {
            mRaceActivity.cImage = @"/Html/images/ypimg.png";
        }
        else
        {
            mRaceActivity.cImage = context.Request["hdtt"];
        }

        mRaceActivity.idUser = CurrentUser.uId;

        if (string.IsNullOrEmpty(context.Request["cContentUEditor"]))
        {
            result="{\"msg\":\"请填约跑内容!\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        DB4.tblRACE_ACTIVITY uActivety = new DB4.tblRACE_ACTIVITY();
        //插入博客
        DBM2.tblBLOG bModel = new DBM2.tblBLOG();
        bModel.idUser = CurrentUser.uId;
        bModel.cLoginname = CurrentUser.cNickName;
        bModel.cTitle = context.Request["hdtitle"].Trim();
        bModel.cContent = context.Request["cContentUEditor"].Trim();
        BlogInfo uBlog = new BlogInfo();
        int iRaceActivity = 0;
        int idRace = 0;
        if (0 == bId)
        {
            bId = uBlog.Add(bModel);
            mRaceActivity.idBlog = bId;
            iRaceActivity = uActivety.Add(mRaceActivity);//插入约跑
            idRace = iRaceActivity;
            if (iRaceActivity > 0)
            {
                bModel.idHref = iRaceActivity;
                bModel.id = bId;
                //更新约跑id到博客idhref
                uBlog.Update(bModel);
            }
            //插入积分
            //DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
            //uMember_History.Insert(bModel.idUser, 100800113, 1);
            new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810012, 1, 0);

            DBM4.tblRACE_JOIN join = new DBM4.tblRACE_JOIN();
            join.idOnwer = CurrentUser.uId;
            join.idActivity = iRaceActivity;
            join.idUser = CurrentUser.uId;
            join.cLoginname = CurrentUser.cNickName;
            join.cName = CurrentUser.cName;
            join.cTel = CurrentUser.cMobile;
            join.iStatus = 2;
            new DB4.tblRACE_JOIN().Add(join);

        }
        else
        {
            iRaceActivity = idRace;
            DB2.tblBLOG ublog = new DB2.tblBLOG();
            bModel.id = bId;
            ublog.Update(bModel);
            //更新竞赛
            bModel = ublog.GetModel(bId);
            idRace = (int)bModel.idHref;
            mRaceActivity.id = (int)bModel.idHref;
            mRaceActivity.idBlog = bId;
            uActivety.Update(mRaceActivity);

        }
        DB3.tblIMAGES imgBll = new DB3.tblIMAGES();
        DBM3.tblIMAGES imgModel = new DBM3.tblIMAGES();
        //删除原来博客图片
        imgBll.DeleteByIdBlog(bId);
        BlogInfo ucBlog = new BlogInfo();
        //插入图片
        string thumbnail = string.Empty;//缩略图

        string[] ImgList = ucBlog.GetHtmlImageUrlList(bModel.cContent);
        if (ImgList.Length > 0)
        {
            thumbnail = ImgList[0];
            for (int i = 0; i < ImgList.Length; i++)
            {
                imgModel.idUser = CurrentUser.uId;
                imgModel.idInfo = bId;
                imgModel.cImageUrl = ImgList[i];
                imgModel.cThumbUrl = ImgList[i];
                imgModel.dCreate = DateTime.Now;
                imgBll.Add(imgModel);
            }
        }
        if (!new DB2.tblActivity().Exists(CurrentUser.uId, iRaceActivity))
        {
            //2013-08-19 1关注11用户/12博文/13赛事/14装备，2发布22博文/23赛事/24装备/25训练/26约跑，3评论31留言/32博文/33赛事/34装备/35训练/36约跑
            DBM2.tblActivity mActivity = new DBM2.tblActivity();
            mActivity.idUser = CurrentUser.uId;
            mActivity.cNickName = CurrentUser.cNickName;
            mActivity.cAvatar = CurrentUser.cAvatar;
            mActivity.idBlog = iRaceActivity;
            mActivity.idGroup = "26";
            mActivity.cTitle = bModel.cTitle;
            mActivity.cBio = XString.ContentTrunc(HTMLHelper.NoHTML(bModel.cContent), 250).Trim();
            mActivity.cImageUrl = thumbnail;
            new DB2.tblActivity().Add(mActivity);
        }
        result="{\"msg\":\"发布成功！\",\"status\":\"" + idRace + "\"}";
        ResponseEnd(context, result);
    }
    protected void ResponseEnd(HttpContext context, string result)
    {
        context.Response.Write(result);
        context.Response.End();
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}