<%@ WebHandler Language="C#" Class="HandlerEquip" %>
using Erun360.BLL;
using Erun360.Model;
using System;
using System.Data;
using System.Web.UI;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DB3 = Erun360.BLL.DB3;
using DB5 = Erun360.BLL.DB5;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DBM5 = Erun360.Model.DB5;
using DBM1 = Erun360.Model.DB1;
using System.Web.SessionState;
using System.Web;

public class HandlerEquip : IHttpHandler, IRequiresSessionState
{
    public UserInfoModel CurrentUser;
    public string result;
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        string operation = string.Empty;
        if (!string.IsNullOrEmpty(context.Request["op"]))
        {
            operation = context.Request["op"].Trim().ToLower();
        }
        switch (operation)
        {
            case "saveequipinfo":
                SaveEquipInfo(context);
                break;
            case "deleteequip":
                DeleteEquip(context);
                break;
            default:
                break;
        }
    }
    protected void SaveEquipInfo(HttpContext context)
    {
        int bId = int.Parse(context.Request["bid"]);
        if (context.Session["CurrentUser"] != null)
        {
            CurrentUser = (UserInfoModel)context.Session["CurrentUser"];
        }
        if (CurrentUser == null)
        {
            result = "{\"msg\":\"您还没有登录！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(CurrentUser.uId);
        if (0 > user.idMemberStyle)
        {
            //AlertHelper.JQAlertGo("你的账号已被限制！！！", "/Member/Logout.aspx", false);
            result = "{\"msg\":\"你的账号已被限制！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (CurrentUser.idMemberStyle < 6)
        {
            int count = new DB5.tblPRODUCTS().GetRecordCount("idUser=" + CurrentUser.uId + " and DateDiff(dd,dCreate,getdate())=0");
            if (count >= 10)
            {
                result = "{\"msg\":\"每天最多只能发10篇哦！\",\"status\":\"0\"}";
                ResponseEnd(context, result);
            }
        }
        if (string.IsNullOrEmpty(context.Request.Form["title"]))
        {
            result = "{\"msg\":\"装备名称不能为空！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else if (context.Request.Form["title"].Trim().Length == 0)
        {
            result = "{\"msg\":\"装备名称不能为空！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else if (context.Request.Form["title"].Trim().Length > 60)
        {
            result = "{\"msg\":\"装备名称超过60个汉字的限制！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (string.IsNullOrEmpty(context.Request.Form["price"]))
        {
            result = "{\"msg\":\"请输入价格！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else if (context.Request.Form["price"].Trim().Length == 0)
        {
            result = "{\"msg\":\"请输入价格！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (string.IsNullOrEmpty(context.Request.Form["content"]))
        {
            result = "{\"msg\":\"装备简介不能为空！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else if (context.Request.Form["content"].Trim().Length == 0)
        {
            result = "{\"msg\":\"装备简介不能为空！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else if (context.Request.Form["content"].Trim().Length > 4000)
        {
            result = "{\"msg\":\"装备简介不能超过4000字！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (string.IsNullOrEmpty(context.Request.Form["group"]))
        {
            result = "{\"msg\":\"分类信息不能为空！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else if (context.Request.Form["group"].Trim().Length == 0)
        {
            result = "{\"msg\":\"分类信息不能为空！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (string.IsNullOrEmpty(context.Request.Form["brand"]))
        {
            result = "{\"msg\":\"品牌信息不能为空！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else if (context.Request.Form["brand"].Trim().Length == 0)
        {
            result = "{\"msg\":\"品牌信息不能为空！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (string.IsNullOrEmpty(context.Request.Form["buytime"]))
        {
            result = "{\"msg\":\"购买时间不能为空！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else if (context.Request.Form["buytime"].Trim().Length == 0)
        {
            result = "{\"msg\":\"购买时间不能为空！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }

        //插入博客
        DBM2.tblBLOG bModel = new DBM2.tblBLOG();
        bModel.idUser = CurrentUser.uId;
        bModel.cLoginname = CurrentUser.cNickName;
        bModel.idHref = 0;
        bModel.cTitle = context.Request.Form["title"].Trim();
        bModel.cContent = context.Request.Form["content"].Trim();
        BlogInfo uBlog = new BlogInfo();

        EquipInfo uProduct = new EquipInfo();
        DBM5.tblPRODUCTS mProduct = new DBM5.tblPRODUCTS();

        mProduct.cTitle = context.Request.Form["title"].Trim();
        mProduct.idGroup = int.Parse(context.Request.Form["group"].Trim());
        mProduct.idBrand = int.Parse(context.Request.Form["brand"].Trim());
        mProduct.fPrice = decimal.Parse(context.Request.Form["price"].Trim().ToString());
        mProduct.idUser = CurrentUser.uId;
        mProduct.dBuytime = TypeChangeDefault.NullToDateTime(context.Request.Form["buytime"].Trim(), DateTime.Now);
        if (0 == bId)
        {
            //bModel.idUser = PageBase.cId;
            // bId = ublog.Insert(bModel);
            bId = uBlog.Add(bModel);
            //插入积分
            //DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
            //uMember_History.Insert(bModel.idUser, 100800119, 1);
            new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810011, 1, 0, 1);
            //插入装备            

            mProduct.idBlog = bId;
            uProduct.Add(mProduct);
        }
        else
        {
            DB2.tblBLOG ublog = new DB2.tblBLOG();
            bModel.id = bId;
            ublog.Update(bModel);
            //更新装备
            bModel = ublog.GetModel(bId);
            mProduct.id = (int)bModel.idHref;
            mProduct.idBlog = bId;
            uProduct.Update(mProduct);
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

        if (!new DB2.tblActivity().Exists(CurrentUser.uId, bId))
        {
            //2013-08-19 1关注11用户/12博文/13赛事/14装备，2发布22博文/23赛事/24装备/25训练，3评论31留言/32博文/33赛事/34/装备
            DBM2.tblActivity mActivity = new DBM2.tblActivity();
            mActivity.idUser = bModel.idUser;
            mActivity.cNickName = bModel.cLoginname;
            mActivity.cAvatar = CurrentUser.cAvatar;
            mActivity.idBlog = bId;
            mActivity.idGroup = "24";
            mActivity.cTitle = bModel.cTitle;
            mActivity.cBio = XString.ContentTrunc(HTMLHelper.NoHTML(bModel.cContent), 250).Trim();
            mActivity.cImageUrl = thumbnail;
            new DB2.tblActivity().Add(mActivity);
        }
        result = "{\"msg\":\"发布成功！\",\"status\":\"" + bId + "\"}";
        ResponseEnd(context, result);
    }
    /// <summary>
    /// 根据博客id删除装备
    /// </summary>
    /// <param name="context"></param>
    public void DeleteEquip(HttpContext context)
    {
        int bId = 0;
        if (context.Request["bId"] != null)
        {
            bId = int.Parse(context.Request["bId"].ToString());
            BlogInfo uBlog = new BlogInfo();
            if (context.Session["CurrentUser"] != null)
            {
                UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
                if (uBlog.Delete(model.uId, bId))
                {
                    DB5.tblPRODUCTS uProduct = new DB5.tblPRODUCTS();
                    uProduct.Delete(bId);

                    new DB1.tblIntegral().InsertScore(model.uId, 200810026, 1, 0);
                    result = "{\"msg\":\"删除成功！\",\"status\":\"1\"}";
                    ResponseEnd(context, result);
                }
            }
            else
            {
                result = "{\"msg\":\"删除失败！\",\"status\":\"0\"}";
                ResponseEnd(context, result);
            }
        }
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