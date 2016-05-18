<%@ WebHandler Language="C#" Class="Team" %>

using System;
using System.Web;
using System.Web.SessionState;
using Erun360.Model;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using System.Data;
using System.Collections;
using System.Collections.Generic;

using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json.Linq;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
public class Team : IHttpHandler, IReadOnlySessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        if (context.Request["m"] != null)
        {
            string command = context.Request["m"].ToString();
            System.Reflection.MethodInfo method = this.GetType().GetMethod(command);
            if (method != null)
            {
                method.Invoke(this, new object[] { context });
            }
        }
    }
    /// <summary>
    /// 获取该赛事中组队列表
    /// </summary>
    /// <param name="context"></param>
    public void team(HttpContext context)
    {
        int idItem = TypeChangeDefault.NullToInt(context.Request["id"], 0);//项目id
        int op = TypeChangeDefault.NullToInt(context.Request["op"], 1);//操作，1未满，2已满

        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);
        int Pagesize = 18;
        int recordCount = 0;
        DataTable dt = new DB4.tblTeam_Group().GetListByPage("iState=" + op + " and idItem=" + idItem, "iSNo", pageIndex, Pagesize, out recordCount).Tables[0];
        Hashtable Team = null;
        List<Hashtable> TeamList = new List<Hashtable>();        
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            Team = new Hashtable();
            Team.Add("iSNo", dt.Rows[i]["iSNo"].ToString());
            Team.Add("iTotal", dt.Rows[i]["iTotal"].ToString());
            Team.Add("iNum", dt.Rows[i]["iNum"].ToString());           
            Team.Add("isOpen", dt.Rows[i]["isOpen"].ToString());
            Team.Add("iState", dt.Rows[i]["iState"].ToString());
            Team.Add("Group", new DB4.tblTeam().GetList("IdTeam=" + dt.Rows[i]["iSNo"].ToString() + " and iState=1", "iType desc").Tables[0]);
            //Team.Add("recordCount", recordCount);
            TeamList.Add(Team);
        }
        IsoDateTimeConverter iso = new IsoDateTimeConverter();
        iso.DateTimeFormat = "yyyy-MM-dd HH:mm";
        context.Response.Write(JsonConvert.SerializeObject(TeamList, iso));
    }
    /// <summary>
    /// 加入团队
    /// </summary>
    /// <param name="context"></param>
    public void Join(HttpContext context)
    {
        int tag = -1;//-1未登录，-2队伍不存在，-3该队已删除，-4该队已满-5已加入过其他队伍-6您未报名,-7不是组队类型，-8过期，0创建失败，1创建成功       
        int idTeam = TypeChangeDefault.NullToInt(context.Request["id"], 0);//团队id
        string PassWord = TypeChangeDefault.NullToString(context.Request["psd"], "");//密钥
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            DBM4.tblTeam_Group mGroup = new DB4.tblTeam_Group().GetModel(idTeam);
            if (mGroup != null)
            {
                if (mGroup.iState == -1)
                {
                    tag = -3;//该队已删除
                    context.Response.Write(tag);
                    return;
                }
                else if (mGroup.iState == 2)
                {
                    tag = -4;//该队已满
                    context.Response.Write(tag);
                    return;
                }
                else if (mGroup.iState == 1)
                {
                    DBM4.tblRACE_SIGNUP mSign = new DB4.tblRACE_SIGNUP().GetModel(mGroup.idItem ?? 0);
                    if (mSign != null)
                    {
                        if (DateTime.Now.AddDays(-3) > mSign.dJoinEnd)
                        {
                            tag = -8;
                            context.Response.Write(tag);//赛事过期
                            return;
                        }
                        if (mSign.iType != 3)
                        {
                            tag = -7;
                            context.Response.Write(tag);//不是组队类型
                            return;
                        }
                        int count = new DB4.tblTeam().GetRecordCount("idItem=" + mGroup.idItem + " and IdUser=" + model.uId + " and iState=1");
                        if (count > 0)
                        {
                            tag = -5;//-5已加入过该赛事的其他队伍
                            context.Response.Write(tag);
                            return;
                        }
                        int Resoult = new DB4.tblRACE_SALES().GetRecordCount("idSignUp=" + mGroup.idItem + " and IdUser=" + model.uId + " and iState=2");
                        if (Resoult == 0)
                        {
                            tag = -6;//-6您未报名
                            context.Response.Write(tag);
                            return;
                        }
                        int TeamResoult = new DB4.tblRACE_SALES().GetRecordCount("idSignUp=" + mGroup.idItem + " and IdUser=" + model.uId + " and iState=3");
                        if (TeamResoult > 0)
                        {
                            tag = -5;//-5已加入过该赛事的其他队伍
                            context.Response.Write(tag);
                            return;
                        }
                        int myItem = new DB4.tblRACE_SALES().GetItem(model.uId, mSign.idCompete ?? 0);//我报名的项目
                        DBM4.tblRACE_SIGNUP mySign = new DB4.tblRACE_SIGNUP().GetModel(myItem);
                        if (mySign.iType != 3)
                        {
                            tag = -7;
                            context.Response.Write(tag);//不是组队类型 
                            return;
                        }
                        if (myItem != mGroup.idItem)
                        {
                            tag = -8;
                            context.Response.Write(tag);//-8报名项目与加入项目不一致
                            return;
                        }
                        //混合双人组//广州龙洞越野赛
                        if (mGroup.idItem == 119)
                        {
                            DataTable dtOther = new DB4.tblRACE_SALES().GetList("idSignUp=" + mGroup.idItem + " and IdUser=" + mGroup.idUser + " and iState=3").Tables[0];
                            int OtheridGender = TypeChangeDefault.NullToInt(dtOther.Rows[0]["idGender"], -1);//团队id 

                            if (OtheridGender == -1)
                            {
                                tag = -9;
                                context.Response.Write(tag);//-9队长不存在
                                return;
                            }
                            DataTable dtmy = new DB4.tblRACE_SALES().GetList("idSignUp=" + mGroup.idItem + " and IdUser=" + model.uId + " and iState=2").Tables[0];
                         
                            int myidGender = TypeChangeDefault.NullToInt(dtmy.Rows[0]["idGender"], -1);//团队id
                            if (myidGender == -1)
                            {
                                tag = -9;
                                context.Response.Write(tag);//-9队长不存在
                                return;
                            }
                            if (myidGender == OtheridGender)
                            {
                                tag = -10;
                                context.Response.Write(tag);//-10不是混合组队
                                return;
                            }
                        }
                        
                        if (mGroup.isOpen == 0)
                        {
                            if (PassWord != mGroup.cPsd)
                            {
                                tag = -11;
                                context.Response.Write(tag);//-11密码不正确
                                return;
                            }
                        }
                        
                        if (mGroup.iNum + 1 >= mGroup.iTotal)
                        {
                            mGroup.iState = 2;
                        }
                        mGroup.iNum = mGroup.iNum + 1;
                        mGroup.id = idTeam;
                        if (new DB4.tblTeam_Group().Update(mGroup))
                        {
                            DBM4.tblTeam mTeam = new DBM4.tblTeam();
                            mTeam.idItem = mGroup.idItem;
                            mTeam.IdTeam = idTeam;
                            mTeam.iSNo = mGroup.id;
                            mTeam.iState = 1;
                            mTeam.iType = 0;
                            mTeam.IdUser = model.uId;
                            mTeam.cName = model.cNickName;
                            mTeam.cAvatar = model.cAvatar;
                            mTeam.cBio = model.cBio;
                            mTeam.dCreate = DateTime.Now;
                            new DB4.tblTeam().Add(mTeam);
                            new DB4.tblRACE_SALES().UpdateSignState(mGroup.idItem ?? 0, model.uId);
                            //添加留言
                            DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                            DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                            disModel.cContent = "恭喜您已加入" + mGroup.id + "号队伍！（此队伍号码仅供益跑网组队使用，便于检索、查阅和招募队友。与实际比赛队伍号码无关）";
                            disModel.idInfo = model.uId;
                            disModel.idUser = 100001183;
                            disModel.cLoginname = "益跑赛事";
                            // disModel.dCreate = DateTime.Now;
                            int imessage = disBll.Add(disModel);
                            if (imessage > 0)
                            {
                                DBM3.tblMessage mMessage = new DBM3.tblMessage();
                                mMessage.cId = 100001183;
                                mMessage.uId = model.uId;
                                mMessage.itype = 31;
                                mMessage.idcode = imessage;
                                int test = new DB3.tblMessage().Add(mMessage);
                            }
                            DBM2.tblActivity mActivity = new DBM2.tblActivity();
                            mActivity.idUser = model.uId;
                            mActivity.cNickName = model.cNickName;
                            mActivity.cAvatar = model.cAvatar;
                            mActivity.idBlog = imessage;
                            mActivity.idGroup = "44";
                            mActivity.cTitle = "在《<a target=\"_blank\" href=\"/blog/" + mSign.idBlog + ".aspx\">" + mSign.cTitle + "</a>》中加入了" + mGroup.id + "号队伍！赶快去<a target=\"_blank\" href=\"/Channels/Competetion/Team.aspx?p=" + mSign.id + "\">[加入]</a>吧";
                            mActivity.cBio = "";
                            mActivity.dCreate = DateTime.Now;
                            new DB2.tblActivity().Add(mActivity);
                            tag = 1;
                            context.Response.Write(tag);//创建成功
                        }
                        else
                        {
                            tag = 0;
                            context.Response.Write(tag);//创建失败
                        }
                    }
                }

            }
            else
            {
                tag = -2;//队伍不存在
                context.Response.Write(tag);
            }
        }
        else
        {
            tag = -1;
            context.Response.Write(tag);
        }
    }
    /// <summary>
    /// 我要组队(创建队伍)
    /// </summary>
    /// <param name="context"></param>
    public void Create(HttpContext context)
    {
        int tag = -1;//-1未登录，-2已存在，-3不是组队类型，-4不存在赛事-5赛事过期-6已加入过该赛事的其他队伍，0创建失败，1创建成功
        int idItem = TypeChangeDefault.NullToInt(context.Request["id"], 0);//项目id
        int op = TypeChangeDefault.NullToInt(context.Request["op"], 0);//是否开放1开放0 不开放
        string PassWord = TypeChangeDefault.NullToString(context.Request["psd"], "");//密钥

        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;

            DataTable dt = new DB4.tblTeam_Group().GetList(" iState>0 and idUser=" + model.uId + " and idItem=" + idItem).Tables[0];

            if (dt.Rows.Count > 0)
            {
                tag = -2;
                context.Response.Write(tag);//已存在
            }
            else
            {
                int count = new DB4.tblTeam().GetRecordCount("idItem=" + idItem + " and IdUser=" + model.uId + " and iState=1");
                if (count > 0)
                {
                    tag = -6;//-6已加入过该赛事的其他队伍
                    context.Response.Write(tag);
                    return;
                }
                DBM4.tblRACE_SIGNUP mSign = new DB4.tblRACE_SIGNUP().GetModel(idItem);
                if (mSign != null)
                {
                    if (DateTime.Now.AddDays(-3) > mSign.dJoinEnd)
                    {
                        tag = -5;
                        context.Response.Write(tag);//赛事过期
                        return;
                    }
                    if (mSign.iType == 3)
                    {
                        int Resoult = new DB4.tblRACE_SALES().GetRecordCount("idSignUp=" + idItem + " and IdUser=" + model.uId + " and iState=2");
                        if (Resoult == 0)
                        {
                            tag = -7;//-7您未报名
                            context.Response.Write(tag);
                            return;
                        }
                        int TeamResoult = new DB4.tblRACE_SALES().GetRecordCount("idSignUp=" + idItem + " and IdUser=" + model.uId + " and iState=3");
                        if (TeamResoult > 0)
                        {
                            tag = -5;//-5已加入过该赛事的其他队伍
                            context.Response.Write(tag);
                            return;
                        }
                        int myItem = new DB4.tblRACE_SALES().GetItem(model.uId, mSign.idCompete ?? 0);
                        DBM4.tblRACE_SIGNUP mySign = new DB4.tblRACE_SIGNUP().GetModel(myItem);
                        if (mySign.iType != 3)
                        {
                            tag = -7;
                            context.Response.Write(tag);//不是组队类型 
                            return;
                        }
                        if (myItem != idItem)
                        {
                            tag = -8;
                            context.Response.Write(tag);//-8报名项目与加入项目不一致
                            return;
                        }
                        DBM4.tblTeam_Group mGroup = new DBM4.tblTeam_Group();
                        if (op == 0)
                        {
                            mGroup.isOpen = 0;
                            if (PassWord.Trim().Length > 0)//如果不输入密码
                            {
                                mGroup.cPsd = PassWord.Trim();
                            }
                            else
                            {
                                mGroup.isOpen = 1;
                                mGroup.cPsd = "";
                            }
                        }
                        else
                        {
                            mGroup.isOpen = 1;
                            mGroup.cPsd = "";
                        }
                        mGroup.idUser = model.uId;
                        mGroup.idCompete = mSign.idCompete;
                        mGroup.cName = mSign.cTitle;
                        mGroup.idItem = mSign.id;
                        mGroup.cItemName = mSign.cType;
                        mGroup.iState = 1;
                        mGroup.iTotal = mSign.iNum;
                        mGroup.iNum = 1;
                        mGroup.dCreate = DateTime.Now;
                        int Reault = new DB4.tblTeam_Group().Add(mGroup);
                        if (Reault > 0)
                        {
                            mGroup.id = Reault;
                            mGroup.iSNo = Reault;
                            new DB4.tblTeam_Group().Update(mGroup);
                            DBM4.tblTeam mTeam = new DBM4.tblTeam();
                            mTeam.idItem = idItem;
                            mTeam.IdTeam = Reault;
                            mTeam.iSNo = Reault;
                            mTeam.iState = 1;
                            mTeam.iType = 1;
                            mTeam.IdUser = model.uId;
                            mTeam.cName = model.cNickName;
                            mTeam.cAvatar = model.cAvatar;
                            mTeam.cBio = model.cBio;
                            mTeam.dCreate = DateTime.Now;
                            new DB4.tblTeam().Add(mTeam);
                            new DB4.tblRACE_SALES().UpdateSignState(mGroup.idItem ?? 0, model.uId);
                            ////添加留言添加feed                            
                            DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                            DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                            disModel.cContent = "恭喜您已创建并加入" + Reault + "号队伍！（此队伍号码仅供益跑网组队使用，便于检索、查阅和招募队友。与实际比赛队伍号码无关）";
                            disModel.idInfo = model.uId;
                            disModel.idUser = 100001183;
                            disModel.cLoginname = "益跑赛事";
                            int imessage = disBll.Add(disModel);
                            if (imessage > 0)
                            {
                                DBM3.tblMessage mMessage = new DBM3.tblMessage();
                                mMessage.cId = 100001183;
                                mMessage.uId = model.uId;
                                mMessage.itype = 31;
                                mMessage.idcode = imessage;
                                int test = new DB3.tblMessage().Add(mMessage);
                            }
                            DBM2.tblActivity mActivity = new DBM2.tblActivity();
                            mActivity.idUser = model.uId;
                            mActivity.cNickName = model.cNickName;
                            mActivity.cAvatar = model.cAvatar;
                            mActivity.idBlog = imessage;
                            mActivity.idGroup = "44";
                            mActivity.cTitle = "恭喜" + model.cNickName + "在《<a target=\"_blank\" href=\"/blog/" + mSign.idBlog + ".aspx\">" + mSign.cTitle + "</a>》中加入了" + Reault + "号队伍！赶快去<a target=\"_blank\" href=\"/Channels/Competetion/Team.aspx?p=" + mSign.id + "\">[加入]</a>吧";
                            mActivity.cBio = "";
                            mActivity.dCreate = DateTime.Now;
                            new DB2.tblActivity().Add(mActivity);
                            tag = 1;
                            context.Response.Write(tag);//创建成功
                        }
                        else
                        {
                            tag = 0;
                            context.Response.Write(tag);//创建失败
                        }
                    }
                    else
                    {
                        tag = -3;
                        context.Response.Write(tag);//不是组队类型
                    }
                }
                else
                {
                    tag = -4;
                    context.Response.Write(tag);//不存在赛事
                }
            }
        }
        else
        {
            tag = -1;
            context.Response.Write(tag);//未登录
        }
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}