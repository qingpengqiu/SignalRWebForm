<%@ WebHandler Language="C#" Class="EventService" %>

using System;
using System.Web;
using System.Web.SessionState;
using Newtonsoft.Json;
using Erun360.Model;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using System.Data;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Collections;
using System.Text;
using Newtonsoft.Json.Converters;
public class EventService : IHttpHandler, IReadOnlySessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        if (context.Request["op"] != null)
        {
            string command = context.Request["op"].ToString();
            System.Reflection.MethodInfo method = this.GetType().GetMethod(command);
            if (method != null)
            {
                method.Invoke(this, new object[] { context });
            }
        }
    }
    //删除订单（置过期）
    public void qxdd(HttpContext context)
    {
        int sid = TypeChangeDefault.NullToInt(context.Request["sid"], 0);//赛事id
        int id = TypeChangeDefault.NullToInt(context.Request["id"], 0);//订单id
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
        DB6.tblOrder bll = new DB6.tblOrder();
        DBM6.tblOrder model = bll.GetModel(id);
        if (model == null)
        {
            result = "{\"msg\":\"订单不存在！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (model.iStatus != 1)
        {
            result = "{\"msg\":\"订单不存在！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (user.uId != model.idUser)
        {
            result = "{\"msg\":\"订单不存在！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (sid != model.cFromToID)
        {
            result = "{\"msg\":\"订单不存在！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (bll.UpdateStatusById(id, -1))
        {
            if (model.iFromTpye == 2)
            {
                DBM6.tblRace_Item racemodel = new DB6.tblRace_Item().GetModel(TypeChangeDefault.NullToInt(model.iItemID, 0));
                //racemodel.id = TypeChangeDefault.NullToInt(model.iItemID, 0);
                racemodel.iLimit = racemodel.iLimit + model.iBuyNum;
                new DB6.tblRace_Item().Update(racemodel);
            }
            else if (model.iFromTpye == 4)
            {
                DBM6.tblHotel_Item racemodel = new DB6.tblHotel_Item().GetModel(TypeChangeDefault.NullToInt(model.iItemID, 0));
                //racemodel.id = TypeChangeDefault.NullToInt(model.iItemID, 0);
                racemodel.iLimit = racemodel.iLimit + model.iBuyNum;
                new DB6.tblHotel_Item().Update(racemodel);
            }
            else if (model.iFromTpye == 8)
            {
                DBM6.tblEquipment_Item racemodel = new DB6.tblEquipment_Item().GetModel(TypeChangeDefault.NullToInt(model.iItemID, 0));
                //racemodel.id = TypeChangeDefault.NullToInt(model.iItemID, 0);
                racemodel.iLimit = racemodel.iLimit + model.iBuyNum;
                new DB6.tblEquipment_Item().Update(racemodel);
            }
            else if (model.iFromTpye == 9)
            {
                DBM6.tblAnnex racemodel = new DB6.tblAnnex().GetModel(TypeChangeDefault.NullToInt(model.iItemID, 0));
                //racemodel.id = TypeChangeDefault.NullToInt(model.iItemID, 0);
                racemodel.iNum = racemodel.iNum + model.iBuyNum;
                new DB6.tblAnnex().Update(racemodel);
            }
            //未付款退还积分
            if (model.iScore > 0)
            {
                new DB1.tblIntegral().InsertScore(model.idUser ?? 0, 200830003, 3, model.iScore ?? 0, "没付款返还积分值订单号：" + model.cOrder_no);
            }
            DBM6.tblOrder child = bll.GetModel(TypeChangeDefault.NullToInt(id, 0));
            if (child != null)
            {
                if (child.cParentOrder.Trim().Length != 0)
                {
                    bll.UpdateStatusByOrder(child.cParentOrder);
                }
            }
            result = "{\"msg\":\"订单删除成功！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"订单删除失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    //购物车
    public void icart(HttpContext context)
    {
        string result = string.Empty;
        int sid = TypeChangeDefault.NullToInt(context.Request["sid"], 0);//赛事id
        int idUser = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
            idUser = user.uId;
        }

        Hashtable game = new Hashtable();
        List<Hashtable> itemList = new List<Hashtable>();
        DB6.tblOrder bll = new DB6.tblOrder();
        DataTable dt = bll.GetList("iFromTpye<>1 and iStatus=1 and idUser=" + idUser + " and cFromToID=" + sid + "").Tables[0];
        int count = dt.Rows.Count;
        game.Add("Total", bll.GetSumPrice("iFromTpye<>1 and iStatus=1 and idUser=" + idUser + " and cFromToID=" + sid + ""));
        game.Add("count", count);
        Hashtable item = null;
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            item = new Hashtable();
            item.Add("id", dt.Rows[i]["ID"].ToString());
            item.Add("iTpye", dt.Rows[i]["iFromTpye"].ToString());
            if (dt.Rows[i]["cItemName"].ToString().Trim().Length > 15)
            {
                item.Add("Name", XString.ContentTrunc(dt.Rows[i]["cItemName"].ToString(), 15) + "...");
            }
            else
            {
                item.Add("Name", XString.ContentTrunc(dt.Rows[i]["cItemName"].ToString(), 15));
            }
            item.Add("Price", dt.Rows[i]["iCost"].ToString());
            item.Add("num", dt.Rows[i]["iBuyNum"].ToString());
            itemList.Add(item);
        }
        game.Add("cart", itemList);
        context.Response.Write(JsonConvert.SerializeObject(game));
    }
    //微信支付，同步获取订单状态
    public void wxpay(HttpContext context)
    {
        int sid = TypeChangeDefault.NullToInt(context.Request["sid"], 0);//赛事id
        int id = TypeChangeDefault.NullToInt(context.Request["id"], 0);//订单id
        string idItem = TypeChangeDefault.NullToString(context.Request["p"], "0");//项目id
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
        DBM6.tblOrder model = new DB6.tblOrder().GetModel(id);
        if (model == null)
        {
            result = "{\"msg\":\"非法操作！\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        if (user.uId != model.idUser)
        {
            result = "{\"msg\":\"非法操作！\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        if (model.cFromToID != sid)
        {
            result = "{\"msg\":\"非法操作！\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        if (model.iItemID != idItem)
        {
            result = "{\"msg\":\"非法操作！\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        if (model.iStatus == 2)
        {
            result = "{\"msg\":\"支付成功！\",\"id\":\"" + model.ID + "\",\"orderid\":\"" + model.cOrder_no + "\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
    }
    public static DataTable SplitDataTable(DataTable dt, int PageIndex, int PageSize)
    {
        if (PageIndex == 0)
            return dt;
        DataTable newdt = dt.Clone();
        //newdt.Clear();
        int rowbegin = (PageIndex - 1) * PageSize;
        int rowend = PageIndex * PageSize;

        if (rowbegin >= dt.Rows.Count)
            return newdt;

        if (rowend > dt.Rows.Count)
            rowend = dt.Rows.Count;
        for (int i = rowbegin; i <= rowend - 1; i++)
        {
            DataRow newdr = newdt.NewRow();
            DataRow dr = dt.Rows[i];
            foreach (DataColumn column in dt.Columns)
            {
                newdr[column.ColumnName] = dr[column.ColumnName];
            }
            newdt.Rows.Add(newdr);
        }

        return newdt;
    }


    //搜索赛事
    public void seach(HttpContext context)
    {
        //Erun360.Common.DataCache.RemoveAllCache("SeachQr");
        string sql = @" SELECT id, idBlog, idCompeteStyle, idCity, cCityname, cTitle
,case  when idCity>3500 then 2 WHEN idCity > 3200 AND idCity < 3500  THEN 3 else 1 end as iType, dRaceBegin, dRaceEnd
, dJoinBegin, dJoinEnd, dCreate
,cPictures=(select top 1 cURL from YP_DB_4.dbo.tblRACE_SIGNUP where idCompete=a.id)
,item=stuff((select ','+isnull(cType,'')+Convert(nvarchar(128), iCost)+'元' from YP_DB_4.dbo.tblRACE_SIGNUP 
                        where idCompete=a.id for xml path('')),1,1,'')
FROM YP_DB_4.dbo.tblRACE_COMPETETION a
where id in(select idCompete from YP_DB_4.dbo.tblRACE_SIGNUP)
union all
SELECT id, '0' idBlog,idCompeteStyle, idCity, cCityname, cTitle,iType, dRaceBegin, dRaceEnd, dJoinBegin
, dJoinEnd, dCreate ,cPictures
,item=stuff((select ','+isnull(cItemName,'')+Convert(nvarchar(128), iCost)+'元' from YP_DB_6.dbo.tblRace_Item 
                        where idCompete=b.id for xml path('')),1,1,'')
                                           
FROM YP_DB_6.dbo.tblRace_Competition b
 where iStatus =1";

        //(" dRaceBegin >='" + DateTime.Now + "'").Tables[0];
        string CacheKey = "SeachQr";
        DataTable hc = new DataTable();
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
            DataTable sydt = new DB6.tblRace_Competition().QueryByPage(sql, "", "dRaceBegin ", 1, 10000).Tables[0];
            objModel = sydt;
            if (objModel != null)
            {
                int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
            }
        }
        hc = (DataTable)objModel;
        StringBuilder sb = new StringBuilder();
        StringBuilder odlsb = new StringBuilder();
        //sb.Append(" iStatus=1 ");

        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);
        int Pagesize = 10;
        int iType = TypeChangeDefault.NullToInt(context.Request["g"], 0);//类型
        if (0 != iType)
        {

            if (iType == 1)
            {
                sb.Append(" iType <> 2 ");
                //sb.Append("idCity < 3501 ");
                //odlsb.Append("b.idCity < 3501");
            }
            if (iType == 2)
            {
                sb.Append(" iType = " + iType);
                //sb.Append(" idCity >= 3501 ");
                //odlsb.Append("b.idCity >= 3501");
            }
        }
        else
        {
            sb.Append(" iType > 0");
            //odlsb.Append("b.idCity like '%%'"); 
        }
        string key = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["key"]), "");//赛事名称查找  
        int time = TypeChangeDefault.NullToInt(context.Request["t"], 0);//时间  
        if (key.Trim().Length > 0)
        {
            sb.Append(" and cTitle  like '%" + key + "%'");
        }
        else
        {

            if (0 != time)
            {
                if (time == 4)
                {
                    sb.Append(" and dRaceBegin>='" + DateTime.Now.AddMonths(6) + "'");
                    sb.Append(" and dJoinEnd >='" + DateTime.Now + "'");
                }
                else if (time == 1)
                {
                    sb.Append(" and dRaceBegin>='" + DateTime.Now + "'and dRaceBegin<='" + DateTime.Now.AddMonths(1) + "'");
                    sb.Append(" and dJoinEnd >='" + DateTime.Now + "'");
                }
                else if (time == 2)
                {
                    sb.Append(" and dRaceBegin>='" + DateTime.Now.AddMonths(1) + "'and dRaceBegin<='" + DateTime.Now.AddMonths(3) + "'");
                    sb.Append(" and dJoinEnd >='" + DateTime.Now + "'");
                }
                else if (time == 3)
                {
                    sb.Append(" and dRaceBegin>='" + DateTime.Now.AddMonths(3) + "'and dRaceBegin<='" + DateTime.Now.AddMonths(6) + "'");
                    sb.Append(" and dJoinEnd >='" + DateTime.Now + "'");
                }
                else if (time == 5)
                {
                    sb.Append(" and '" + DateTime.Now + "'>=dJoinEnd");
                }
            }
            else
            {
                sb.Append(" and dJoinEnd >='" + DateTime.Now + "'");
                odlsb.Append(" and dRaceBegin>='" + DateTime.Now + "'");
            }
            int iStyle = TypeChangeDefault.NullToInt(context.Request["lx"], 99);//赛事类型      
            if (99 != iStyle)
            {
                sb.Append(" and idCompeteStyle = " + iStyle);
                odlsb.Append(" and idCompeteStyle = " + iStyle);
            }
        }
        Hashtable game = null;
        List<Hashtable> gameList = new List<Hashtable>();
        DB6.tblRace_Competition bll = new DB6.tblRace_Competition();
        DB6.tblRace_Item bllItem = new DB6.tblRace_Item();
        DB4.tblRACE_JOIN bllJoin = new DB4.tblRACE_JOIN();
        DB6.tblRace_Detail blldetail = new DB6.tblRace_Detail();
        int idUser = 0;
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
        if (user != null)
        {
            idUser = user.uId;
        }
        DataTable dtt = new DataTable();
        if (time == 5 || key.Trim().Length > 0)
        {
            DataRow[] drs = hc.Select(sb.ToString(), "dRaceBegin desc");
            if (drs.Length > 0)
            {//判断是否存在符合的数据、为下面copy，不然报错
                dtt = drs.CopyToDataTable();
            }
        }
        else
        {
            DataRow[] drs = hc.Select(sb.ToString(), "dRaceBegin");
            if (drs.Length > 0)
            {//判断是否存在符合的数据、为下面copy，不然报错
                dtt = drs.CopyToDataTable();
            }
        }
        dtt = SplitDataTable(dtt, pageIndex, Pagesize);
        //dtt = hc.Clone();

        //bll.GetListByPage(sb.ToString(), "dRaceBegin", pageIndex, Pagesize).Tables[0];
        //dt.Columns.Add("idBlog");

        //DataTable odldt = new DB4.tblRACE_COMPETETION().GetListByPageh(odlsb.ToString(), "dRaceBegin", pageIndex, Pagesize).Tables[0];

        for (int i = 0; i < dtt.Rows.Count; i++)
        {
            game = new Hashtable();
            if (dtt.Rows[i]["idBlog"].ToString() != "0")
            {

                game.Add("bid", dtt.Rows[i]["idBlog"].ToString());
                game.Add("id", dtt.Rows[i]["id"].ToString());
                game.Add("cTitle", dtt.Rows[i]["cTitle"].ToString());
                game.Add("dRaceBegin", Convert.ToDateTime(dtt.Rows[i]["dRaceBegin"].ToString()).ToString("yyyy-MM-dd"));
                game.Add("dJoinBegin", Convert.ToDateTime(dtt.Rows[i]["dJoinBegin"].ToString()).ToString("yyyy-MM-dd HH:mm"));
                game.Add("dJoinEnd", Convert.ToDateTime(dtt.Rows[i]["dJoinEnd"].ToString()).ToString("yyyy-MM-dd HH:mm"));


                game.Add("cPictures", dtt.Rows[i]["cPictures"].ToString());
                if (dtt.Rows[i]["item"].ToString().Length > 150)
                {
                    game.Add("item", dtt.Rows[i]["item"].ToString().Remove(0, 150));//比赛项目及费用
                }
                else
                {
                    game.Add("item", dtt.Rows[i]["item"].ToString());
                }


                game.Add("gzrs", bllJoin.GetRecordCount("idActivity=" + dtt.Rows[i]["id"].ToString()));
                game.Add("bmrs", new DB4.tblRACE_SALES().GetRecordCount("idSignUp in (select id from dbo.tblRACE_SIGNUP where idCompete=" + dtt.Rows[i]["id"].ToString() + ") and iState>=2"));

                int gz = bllJoin.GetRecordCount("idActivity=" + dtt.Rows[i]["id"].ToString() + " and idUser=" + idUser);
                game.Add("gz", gz);//0未关注，1关注
                //报名状态state:['已报名','未付款','已付款','报名截止','报名未开始','开始报名'],
                //"statename":['待审核','去付款','已报名','已组队','报名未开始','报名截止','立即报名','去组队'],
                DataTable dttbm = new DB4.tblRACE_SALES().GetList("idSignUp in (select id from dbo.tblRACE_SIGNUP where idCompete=" + dtt.Rows[i]["id"].ToString() + ") and idUser=" + idUser + " and iState>=0").Tables[0];
                if (Convert.ToDateTime(dtt.Rows[i]["dJoinBegin"].ToString()) > DateTime.Now)
                {
                    game.Add("state", "4");
                    game.Add("link", "<a class=\"arbm bmwks\" href=\"javascript:void(0)\">报名未开始</a>");
                }
                else if (DateTime.Now > Convert.ToDateTime(dtt.Rows[i]["dJoinEnd"].ToString()))
                {
                    game.Add("state", "5");
                    game.Add("link", "<a class=\"arbm bmjz\" href=\"javascript:void(0)\">报名已截止</a>");
                }
                else
                {
                    if (dttbm.Rows.Count == 0)
                    {
                        game.Add("state", "6");
                        game.Add("link", " <a class=\"arbm bmyfk\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + dtt.Rows[i]["id"].ToString() + "\"  target=\"_blank\">立即报名</a>");
                    }
                    else
                    {
                        if (dttbm.Rows[0]["iState"].ToString() == "0")
                        {
                            game.Add("state", "0");
                            game.Add("link", "<a class=\"arbm bmwfk\" href=\"javascript:void(0)\" >待审核</a>");
                        }
                        else if (dttbm.Rows[0]["iState"].ToString() == "1")
                        {
                            game.Add("state", "1");
                            game.Add("link", "<a class=\"arbm bmwfk\" href=\"/Channels/Competetion/RacePay.aspx?orderid=" + TypeChangeDefault.NullToString(dttbm.Rows[0]["idOrder"], "") + "\" target=\"_blank\">去付款</a>");
                        }
                        else if (dttbm.Rows[0]["iState"].ToString() == "2")
                        {
                            int iItemID = TypeChangeDefault.NullToInt(dttbm.Rows[0]["id"], 0);
                            DBM4.tblRACE_SIGNUP modelItem = new DB4.tblRACE_SIGNUP().GetModel(iItemID);
                            if (modelItem != null)
                            {
                                if (modelItem.iType == 3)
                                {
                                    game.Add("state", "7");
                                    game.Add("link", "<a class=\"arbm bmwfk\" href=\"/Channels/Competetion/Team.aspx?p=" + iItemID + "\" target=\"_blank\">去组队</a>");
                                }
                                else
                                {
                                    game.Add("state", "2");
                                    game.Add("link", "<a class=\"arbm bmy\" href=\"javascript:void(0)\">已报名</a>");
                                }
                            }
                            else
                            {
                                game.Add("state", "2");
                                game.Add("link", "<a class=\"arbm bmy\" href=\"javascript:void(0)\">已报名</a>");
                            }
                        }
                        else if (dttbm.Rows[0]["iState"].ToString() == "3")
                        {
                            game.Add("state", "3");
                            game.Add("link", "<a class=\"arbm bmy\">已组队</a>");
                        }
                        else
                        {
                            game.Add("state", "6");
                            game.Add("link", " <a class=\"arbm bmyfk\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + dtt.Rows[i]["id"].ToString() + "&nav=2\" target=\"_blank\">立即报名</a>");
                        }
                    }
                }
            }
            else
            {

                game.Add("id", dtt.Rows[i]["id"].ToString());
                game.Add("cTitle", dtt.Rows[i]["cTitle"].ToString());
                game.Add("dRaceBegin", Convert.ToDateTime(dtt.Rows[i]["dRaceBegin"].ToString()).ToString("yyyy-MM-dd"));
                game.Add("dJoinBegin", Convert.ToDateTime(dtt.Rows[i]["dJoinBegin"].ToString()).ToString("yyyy-MM-dd HH:mm"));
                game.Add("dJoinEnd", Convert.ToDateTime(dtt.Rows[i]["dJoinEnd"].ToString()).ToString("yyyy-MM-dd HH:mm"));

                string img = dtt.Rows[i]["cPictures"].ToString();
                if (img.Length > 0)
                {
                    // 找到最后一个【.】点的位置，然后插入你想插入的字符
                    string result = img.Insert(img.LastIndexOf('.'), "_300");
                    game.Add("cPictures", result);
                }
                else
                {
                    game.Add("cPictures", dtt.Rows[i]["cPictures"].ToString());
                }



                if (dtt.Rows[i]["item"].ToString().Length > 150)
                {
                    game.Add("item", dtt.Rows[i]["item"].ToString().Remove(0, 150));//比赛项目及费用
                }
                else
                {
                    game.Add("item", dtt.Rows[i]["item"].ToString());
                }

                game.Add("gzrs", bllJoin.GetRecordCount("idActivity=" + dtt.Rows[i]["id"].ToString()));
                game.Add("bmrs", blldetail.GetRecordCount("idCompete=" + dtt.Rows[i]["id"].ToString()));

                int gz = bllJoin.GetRecordCount("idActivity=" + dtt.Rows[i]["id"].ToString() + " and idUser=" + idUser);
                game.Add("gz", gz);//0未关注，1关注
                //报名状态state:['已报名','未付款','已付款','报名截止','报名未开始','开始报名'],
                //"statename":['待审核','去付款','已报名','已组队','报名未开始','报名截止','立即报名','去组队'],
                DataTable dttbm = new DB6.tblOrder().GetList("cFromToID=" + dtt.Rows[i]["id"].ToString() + " and iTypeID=" + dtt.Rows[i]["id"].ToString() + " and idUser =" + idUser + " and iFromTpye =2 and iStatus>=0").Tables[0];
                if (Convert.ToDateTime(dtt.Rows[i]["dJoinBegin"].ToString()) > DateTime.Now)
                {
                    game.Add("state", "4");
                    game.Add("link", "<a class=\"arbm bmwks\" href=\"javascript:void(0)\">报名未开始</a>");
                }
                else if (DateTime.Now > Convert.ToDateTime(dtt.Rows[i]["dJoinEnd"].ToString()))
                {
                    game.Add("state", "5");
                    game.Add("link", "<a class=\"arbm bmjz\" href=\"javascript:void(0)\">报名已截止</a>");
                }
                else
                {
                    if (dttbm.Rows.Count == 0)
                    {
                        game.Add("state", "6");
                        game.Add("link", " <a class=\"arbm bmyfk\" href=\"/Competetion/projects.aspx?sid=" + dtt.Rows[i]["id"].ToString() + "&nav=2\" target=\"_blank\">立即报名</a>");
                    }
                    else
                    {
                        if (dttbm.Rows[0]["iStatus"].ToString() == "0")
                        {
                            game.Add("state", "0");
                            game.Add("link", "<a class=\"arbm bmwfk\" href=\"javascript:void(0)\">待审核</a>");
                        }
                        else if (dttbm.Rows[0]["iStatus"].ToString() == "1")
                        {
                            game.Add("state", "1");
                            game.Add("link", "<a class=\"arbm bmwfk\" href=\"/Competetion/payoff.aspx?sid=" + dtt.Rows[i]["id"].ToString() + "&id=" + dttbm.Rows[0]["ID"] + "&nav=2&order=" + TypeChangeDefault.NullToString(dttbm.Rows[0]["cOrder_no"], "") + "\" target=\"_blank\">去付款</a>");
                        }
                        else if (dttbm.Rows[0]["iStatus"].ToString() == "2")
                        {
                            int iItemID = TypeChangeDefault.NullToInt(dttbm.Rows[0]["iItemID"], 0);
                            DBM6.tblRace_Item modelItem = new DB6.tblRace_Item().GetModel(iItemID);
                            if (modelItem != null)
                            {
                                if (modelItem.iType == 3)
                                {
                                    game.Add("state", "7");
                                    game.Add("link", "<a class=\"arbm bmwfk\" href=\"/Competetion/Team.aspx?sid=" + dtt.Rows[i]["id"].ToString() + "&p=" + iItemID + "\" target=\"_blank\">去组队</a>");
                                }
                                else
                                {
                                    game.Add("state", "2");
                                    game.Add("link", "<a class=\"arbm bmy\" href=\"javascript:void(0)\">已报名</a>");
                                }
                            }
                            else
                            {
                                game.Add("state", "2");
                                game.Add("link", "<a class=\"arbm bmy\" href=\"javascript:void(0)\">已报名</a>");
                            }
                        }
                        else if (dttbm.Rows[0]["iStatus"].ToString() == "3")
                        {
                            game.Add("state", "3");
                            game.Add("link", "<a class=\"arbm bmy\">已组队</a>");
                        }
                        else
                        {
                            game.Add("state", "6");
                            game.Add("link", " <a class=\"arbm bmyfk\" href=\"/Competetion/projects.aspx?sid=" + dtt.Rows[i]["id"].ToString() + "&nav=2\" target=\"_blank\">立即报名</a>");
                        }
                    }
                }
            }
            gameList.Add(game);
        }

        IsoDateTimeConverter iso = new IsoDateTimeConverter();
        iso.DateTimeFormat = "yyyy-MM-dd HH:mm";

        context.Response.Write(JsonConvert.SerializeObject(gameList, iso));


        //context.Response.Write(objModel);
    }
    //赛记
    public void blog(HttpContext context)
    {
        string result = string.Empty;
        //具体的页面数     
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 0);
        //页面显示条数
        int Pagesize = 20;
        int sid = TypeChangeDefault.NullToInt(context.Request["sid"], 0);//赛事id
        DB6.tblRace_Competition bllRace = new DB6.tblRace_Competition();
        DBM6.tblRace_Competition modelRace = bllRace.GetModel(sid);
        if (modelRace == null)
        {
            result = "{\"msg\":\"赛事不存在\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        DB2.tblBLOG_LINKS bll = new DB2.tblBLOG_LINKS();

        DataTable dt = bll.GetListByPage("idBlog =" + sid, "dCreate desc", pageIndex, Pagesize).Tables[0];
        int recordCount = dt.Rows.Count;
        if (recordCount == 0)
        {
            result = "{\"msg\":\"暂无赛记！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        Hashtable blog = null;

        List<Hashtable> blogList = new List<Hashtable>();
        DB2.tblBLOG bllBolg = new DB2.tblBLOG();
        DB3.tblIMAGES img = new DB3.tblIMAGES();
        DB2.tblBLOG_SUMMARY summary = new DB2.tblBLOG_SUMMARY();
        for (int i = 0; i < recordCount; i++)
        {
            int idBolg = TypeChangeDefault.NullToInt(dt.Rows[i]["idInfo"], 0);
            DBM2.tblBLOG model = bllBolg.GetModel(idBolg);
            if (model == null)
                continue;
            blog = new Hashtable();
            blog.Add("id", model.id);
            blog.Add("idUser", model.idUser);
            blog.Add("cLoginname", model.cLoginname);
            blog.Add("cTitle", model.cTitle);
            blog.Add("dCreate", Convert.ToDateTime(model.dCreate).ToString("yyyy-MM-dd HH:mm"));
            DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(model.idUser);
            if (user != null)
            {
                blog.Add("cAvatar", user.cAvatar);
            }
            else
            {
                blog.Add("cAvatar", "/Html/images/uicon1.jpg");
            }

            blog.Add("cContent", XString.ContentTrunc(HTMLHelper.NoHTML(model.cContent), 400));

            DBM3.tblIMAGES imgModel = img.GetModelByidBolg(idBolg);
            if (imgModel != null)
            {
                blog.Add("Thumbnails", imgModel.cImageUrl);
            }
            else
            {
                blog.Add("Thumbnails", "/Html/images/mrsj.jpg ");
            }

            DBM2.tblBLOG_SUMMARY summaryModel = summary.GetModelByCache(idBolg);
            if (summaryModel != null)
            {
                blog.Add("iShowTimes", summaryModel.iShowTimes);//阅读
                blog.Add("iFocus", summaryModel.iFocus);//关注
                blog.Add("iDing", summaryModel.iDing);//顶
                blog.Add("iDiscuss", summaryModel.iDiscuss);//评论                
            }
            else
            {
                blog.Add("iShowTimes", 0);//阅读
                blog.Add("iFocus", 0);//关注
                blog.Add("iDing", 0);//顶
                blog.Add("iDiscuss", 0);//评论       
            }
            blogList.Add(blog);
        }
        IsoDateTimeConverter iso = new IsoDateTimeConverter();
        iso.DateTimeFormat = "yyyy-MM-dd HH:mm";
        context.Response.Write(JsonConvert.SerializeObject(blogList, iso));
    }
    //提交旅游订单  
    public void tjlv(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;

        int sid = TypeChangeDefault.NullToInt(context.Request["sid"], 0);//赛事id
        DB6.tblRace_Competition bllRace = new DB6.tblRace_Competition();
        DBM6.tblRace_Competition modelRace = bllRace.GetModel(sid);
        if (modelRace == null)
        {
            result = "{\"msg\":\"赛事不存在\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (modelRace.iStatus != 1)
        {
            result = "{\"msg\":\"赛事已关闭\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int Item = TypeChangeDefault.NullToInt(context.Request["id"], 0);//装备id
        int IdItem = TypeChangeDefault.NullToInt(context.Request["zbid"], 0);//装备项目id
        DB6.tbltour_Item bllItem = new DB6.tbltour_Item();
        DBM6.tbltour_Item modelItem = bllItem.GetModel(IdItem);
        if (modelItem == null)
        {
            result = "{\"msg\":\"该装备不存在！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int idEquipment = modelItem.idEquipment ?? 0;//装备id
        DB6.tbltour bllEquipment = new DB6.tbltour();
        DBM6.tbltour modelEquipment = bllEquipment.GetModel(idEquipment);
        if (modelEquipment == null)
        {
            result = "{\"msg\":\"该装备不存在！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (modelEquipment.idCompete != sid)
        {
            result = "{\"msg\":\"非法操作！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (idEquipment != Item)
        {
            result = "{\"msg\":\"非法操作！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        if (modelItem.iLimit <= 0)
        {
            result = "{\"msg\":\"旅游产品已售罄！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int iBuyNum = TypeChangeDefault.NullToInt(context.Request["num"], 0);//购买数量
        if (iBuyNum <= 0)
        {
            result = "{\"msg\":\"请选择购买数量！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        DB6.tblOrder bll = new DB6.tblOrder();
        //已购买量
        int countbuy = bll.GetSumCount("iFromTpye =8 and iStatus>-1 and iTypeID='" + modelEquipment.id + "'  and cFromToID=" + sid + " and idUser=" + user.uId);
        if (modelEquipment.iBuyMax > 0)
        {
            if (iBuyNum > modelEquipment.iBuyMax)
            {
                result = "{\"msg\":\"购买数量超过最大限额（" + modelEquipment.iBuyMax + "）！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }

            if (countbuy + iBuyNum > modelEquipment.iBuyMax)
            {
                result = "{\"msg\":\"购买数量超过最大限额（" + modelEquipment.iBuyMax + "）！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
        }
        //最大购买量为0即为不限制购买
        if (iBuyNum > modelItem.iLimit)
        {
            result = "{\"msg\":\"旅游产品剩余数量不足！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        //联系人信息
        string fname = TypeChangeDefault.NullToString(context.Request["fristname"], "");
        if (fname.Trim().Length == 0 || fname.Trim().Length > 32)
        {
            result = "{\"msg\":\"请填写姓氏称或者姓氏超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string lname = TypeChangeDefault.NullToString(context.Request["lastname"], "");
        if (lname.Trim().Length == 0 || lname.Trim().Length > 32)
        {
            result = "{\"msg\":\"请填写名称或者名称超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string linkname = fname + lname;
        string linkmobile = TypeChangeDefault.NullToString(context.Request["tel"], "");
        if (linkmobile.Trim().Length == 0 || linkmobile.Trim().Length > 22)
        {
            result = "{\"msg\":\"请填写联系人手机或者手机超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string linkeadd = TypeChangeDefault.NullToString(context.Request["add"], "");
        if (linkeadd.Trim().Length == 0 || linkeadd.Trim().Length > 128)
        {
            result = "{\"msg\":\"请填写地址或者地址超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        //备注用字段2cMake2
        string beizhu = TypeChangeDefault.NullToString(context.Request["beizhu"], "");
        if (beizhu.Trim().Length > 1024)
        {
            result = "{\"msg\":\"备注长度超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string cFrom = string.Empty;
        if (context.Session["org"] != null)
        {
            cFrom = context.Session["org"].ToString();
        }
        DBM1.tblMEMBER modelUser = new DB1.tblMEMBER().GetModel(user.uId);
        DBM6.tblOrder model = new DBM6.tblOrder
        {
            cFromToID = sid,
            cFromToName = modelRace.cTitle,
            idUser = user.uId,
            cNickName = user.cNickName,
            iFromTpye = 5,
            iTypeID = modelEquipment.id,
            iTypeName = modelEquipment.cName,
            iItemID = IdItem.ToString(),
            cItemName = modelItem.cItemName,
            iBuyNum = iBuyNum,
            cParentOrder = "",
            iCount = 0,
            iReceipt = 0,
            dCreateTime = bll.GetTime(0),
            dConfirmTime = bll.GetTime(0),
            FlightDate = "",//
            cName = modelUser.cName,//当前用户信息
            IdType = TypeChangeDefault.NullToString(modelUser.idNationIDType, ""),
            IdNo = modelUser.cNationID,
            cMobile = modelUser.cMobile,
            cMail = modelUser.cMail,
            idCity = modelUser.idCity,
            cCityname = modelUser.cCityname,
            cAddress = modelUser.cAddress,
            iScore = 0,
            iMoney = 0,
            fPrice = modelItem.fSellPrice,
            iCost = modelItem.fSellPrice,
            iStatus = 1,
            cFrom = cFrom
        };
        string JF = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["jf"]), "");//积分
        if (JF == "on")
        {
            int iScore = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + user.uId, user.uId);
            if (iScore < modelItem.iScore)
            {
                result = "{\"msg\":\"您的积分不足，无法使用积分！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }

            model.iScore = modelItem.iScore;
            model.iMoney = modelItem.iMoney;
            model.fPrice = modelItem.fSellPrice * iBuyNum;
            model.iCost = model.fPrice - modelItem.iMoney;
        }
        else
        {
            model.iScore = 0;
            model.iMoney = 0;
            model.fPrice = modelItem.fSellPrice * iBuyNum;
            model.iCost = modelItem.fSellPrice * iBuyNum;
        }
        string orderid = bll.GetMaxOrderId("LV");
        if (orderid == "")
        {
            orderid = "LV" + DateTime.Now.ToString("yyyyMMdd") + "000001";
        }

        else
        {
            orderid = "LV" + DateTime.Now.ToString("yyyyMMdd") + (Convert.ToInt32(orderid.Substring(orderid.Length - 6, 6)) + 1).ToString().PadLeft(6, '0');
        }
        model.cOrder_no = orderid;
        DBM6.tbltour_Detail userInfo = new DBM6.tbltour_Detail
        {
            idCompete = sid,
            cCompetitionName = modelRace.cTitle,
            idItem = IdItem,
            cItemName = modelItem.cItemName,
            cFullname = linkname,
            idUser = user.uId,
            //cGender = modelUser.idGender.ToString(),
            //idBlood = modelUser.idBlood.ToString(),
            //dBirthday = modelUser.dBirthday,
            //IdType = modelUser.idNationIDType.ToString(),
            //IdNo = modelUser.cNationID,
            //cNational = "",
            cMobile = linkmobile,// modelUser.cMobile,
            //cMail = modelUser.cMail,
            //idCity = modelUser.idCity,
            //cCityname = modelUser.cCityname,
            cAddress = linkeadd,//modelUser.cAddress,
            //cZipcode = modelUser.cZipcode,
            cOrder_no = orderid,
            cMake2 = beizhu
        };

        model.passenger = JsonConvert.SerializeObject(userInfo);
        model.cItems = JsonConvert.SerializeObject(modelItem);
        int RowCount = bll.Add(model);
        if (RowCount > 0)
        {
            DB6.tblPassenger bllLink = new DB6.tblPassenger();
            int idLink = TypeChangeDefault.NullToInt(context.Request["linkid"], 0);//常用联系人id

            DBM6.tblPassenger linkinfo = new DBM6.tblPassenger
            {
                //id = idLink,
                idUser = user.uId,
                csurname = fname,
                cname = lname,
                cFullname = linkname,
                //IdType,
                //IdNo = idCart,
                Phone = linkmobile,
                dCreate = bll.GetTime(0),
                //cGender,
                //dBirthday,
                //idCity,
                //cCityname,
                cAddress = linkeadd,
                //cMail,
                //cValidity,
                //cIssued,
                //Nationality
            };
            int usercount = bllLink.GetRecordCount("idUser=" + user.uId + " and csurname='" + fname + "' and cname ='" + lname + "' and Phone='" + linkmobile + "'");
            if (idLink > 0)
            {
                DBM6.tblPassenger linkuser = bllLink.GetModel(idLink);
                if (linkuser != null)
                {
                    if (linkuser.csurname != fname || linkuser.cname != lname || linkuser.Phone != linkmobile)
                    {
                        linkinfo.id = idLink;
                        bllLink.Update(linkinfo);
                    }
                    else
                    {
                        bllLink.Add(linkinfo);
                    }
                }
                else
                {
                    if (usercount == 0)
                    {
                        bllLink.Add(linkinfo);
                    }
                }
            }
            else
            {
                if (usercount == 0)
                {
                    bllLink.Add(linkinfo);
                }

            }

            modelItem.id = IdItem;
            modelItem.iLimit = modelItem.iLimit - iBuyNum;
            bllItem.Update(modelItem);
            if (JF == "on")
            {
                int idFlag = new DB1.tblIntegral().InsertScore(user.uId, 200840004, 4, TypeChangeDefault.NullToDecimal(modelItem.iScore, 0), "购买旅游花费积分订单号：" + orderid);
                DBM6.tblOrder modelflag = new DBM6.tblOrder();
                modelflag.ID = RowCount;
                modelflag.cMake1 = idFlag.ToString();
                bll.Update(modelflag);//更新积分id
            }
            result = "{\"msg\":\"提交订单成功！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"提交" + modelItem.cItemName + "订单失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    //提交装备订单  
    public void tjzb(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;

        int sid = TypeChangeDefault.NullToInt(context.Request["sid"], 0);//赛事id
        DB6.tblRace_Competition bllRace = new DB6.tblRace_Competition();
        DBM6.tblRace_Competition modelRace = bllRace.GetModel(sid);
        if (modelRace == null)
        {
            result = "{\"msg\":\"赛事不存在\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (modelRace.iStatus != 1)
        {
            result = "{\"msg\":\"赛事已关闭\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int Item = TypeChangeDefault.NullToInt(context.Request["id"], 0);//装备id
        int IdItem = TypeChangeDefault.NullToInt(context.Request["zbid"], 0);//装备项目id
        DB6.tblEquipment_Item bllItem = new DB6.tblEquipment_Item();
        DBM6.tblEquipment_Item modelItem = bllItem.GetModel(IdItem);
        if (modelItem == null)
        {
            result = "{\"msg\":\"该装备不存在！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int idEquipment = modelItem.idEquipment ?? 0;//装备id
        DB6.tblEquipment bllEquipment = new DB6.tblEquipment();
        DBM6.tblEquipment modelEquipment = bllEquipment.GetModel(idEquipment);
        if (modelEquipment == null)
        {
            result = "{\"msg\":\"该装备不存在！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (modelEquipment.idCompete != sid)
        {
            result = "{\"msg\":\"非法操作！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (idEquipment != Item)
        {
            result = "{\"msg\":\"非法操作！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        if (modelItem.iLimit <= 0)
        {
            result = "{\"msg\":\"装备已售罄！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int iBuyNum = TypeChangeDefault.NullToInt(context.Request["num"], 0);//购买数量
        if (iBuyNum <= 0)
        {
            result = "{\"msg\":\"请选择购买数量！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        DB6.tblOrder bll = new DB6.tblOrder();
        if (modelEquipment.iBuyMax > 0)
        {
            if (iBuyNum > modelEquipment.iBuyMax)
            {
                result = "{\"msg\":\"购买数量超过最大限额（" + modelEquipment.iBuyMax + "）！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            //已购买量
            int countbuy = bll.GetSumCount("iFromTpye =8 and iStatus>-1 and iTypeID='" + modelEquipment.id + "'  and cFromToID=" + sid + " and idUser=" + user.uId);
            if (countbuy + iBuyNum > modelEquipment.iBuyMax)
            {
                result = "{\"msg\":\"购买数量超过最大限额（" + modelEquipment.iBuyMax + "）！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
        }
        //最大购买量为0即为不限制购买
        if (iBuyNum > modelItem.iLimit)
        {
            result = "{\"msg\":\"装备剩余数量不足！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        //联系人信息
        string fname = TypeChangeDefault.NullToString(context.Request["fristname"], "");
        if (fname.Trim().Length == 0 || fname.Trim().Length > 32)
        {
            result = "{\"msg\":\"请填写姓氏称或者姓氏超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string lname = TypeChangeDefault.NullToString(context.Request["lastname"], "");
        if (lname.Trim().Length == 0 || lname.Trim().Length > 32)
        {
            result = "{\"msg\":\"请填写名称或者名称超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string linkname = fname + lname;
        string linkmobile = TypeChangeDefault.NullToString(context.Request["tel"], "");
        if (linkmobile.Trim().Length == 0 || linkmobile.Trim().Length > 22)
        {
            result = "{\"msg\":\"请填写联系人手机或者手机超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string linkeadd = TypeChangeDefault.NullToString(context.Request["add"], "");
        if (linkeadd.Trim().Length == 0 || linkeadd.Trim().Length > 128)
        {
            result = "{\"msg\":\"请填写地址或者地址超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        //备注用字段2cMake2
        string beizhu = TypeChangeDefault.NullToString(context.Request["beizhu"], "");
        if (beizhu.Trim().Length > 1024)
        {
            result = "{\"msg\":\"备注长度超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string cFrom = string.Empty;
        if (context.Session["org"] != null)
        {
            cFrom = context.Session["org"].ToString();
        }
        DBM1.tblMEMBER modelUser = new DB1.tblMEMBER().GetModel(user.uId);
        DBM6.tblOrder model = new DBM6.tblOrder
        {
            cFromToID = sid,
            cFromToName = modelRace.cTitle,
            idUser = user.uId,
            cNickName = user.cNickName,
            iFromTpye = 8,
            iTypeID = modelEquipment.id,
            iTypeName = modelEquipment.cName,
            iItemID = IdItem.ToString(),
            cItemName = modelItem.cItemName,
            iBuyNum = iBuyNum,
            cParentOrder = "",
            iCount = 0,
            iReceipt = 0,
            dCreateTime = bll.GetTime(0),
            dConfirmTime = bll.GetTime(0),
            FlightDate = "",//
            cName = modelUser.cName,//当前用户信息
            IdType = TypeChangeDefault.NullToString(modelUser.idNationIDType, ""),
            IdNo = modelUser.cNationID,
            cMobile = modelUser.cMobile,
            cMail = modelUser.cMail,
            idCity = modelUser.idCity,
            cCityname = modelUser.cCityname,
            cAddress = modelUser.cAddress,
            iScore = 0,
            iMoney = 0,
            fPrice = modelItem.fSellPrice,
            iCost = modelItem.fSellPrice,
            iStatus = 1,
            cFrom = cFrom
        };
        string JF = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["jf"]), "");//积分
        if (JF == "on")
        {
            int iScore = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + user.uId, user.uId);
            if (iScore < modelItem.iScore)
            {
                result = "{\"msg\":\"您的积分不足，无法使用积分！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }

            model.iScore = modelItem.iScore;
            model.iMoney = modelItem.iMoney;
            model.fPrice = modelItem.fSellPrice * iBuyNum;
            model.iCost = model.fPrice - modelItem.iMoney;
        }
        else
        {
            model.iScore = 0;
            model.iMoney = 0;
            model.fPrice = modelItem.fSellPrice * iBuyNum;
            model.iCost = modelItem.fSellPrice * iBuyNum;
        }
        string orderid = bll.GetMaxOrderId("ZB");
        if (orderid == "")
        {
            orderid = "ZB" + DateTime.Now.ToString("yyyyMMdd") + "000001";
        }

        else
        {
            orderid = "ZB" + DateTime.Now.ToString("yyyyMMdd") + (Convert.ToInt32(orderid.Substring(orderid.Length - 6, 6)) + 1).ToString().PadLeft(6, '0');
        }
        model.cOrder_no = orderid;
        DBM6.tblEquipment_Detail userInfo = new DBM6.tblEquipment_Detail
        {
            idCompete = sid,
            cCompetitionName = modelRace.cTitle,
            idItem = IdItem,
            cItemName = modelItem.cItemName,
            cFullname = linkname,
            idUser = modelUser.id,
            //cGender = modelUser.idGender.ToString(),
            //idBlood = modelUser.idBlood.ToString(),
            //dBirthday = modelUser.dBirthday,
            //IdType = modelUser.idNationIDType.ToString(),
            //IdNo = modelUser.cNationID,
            //cNational = "",
            cMobile = linkmobile,// modelUser.cMobile,
            //cMail = modelUser.cMail,
            //idCity = modelUser.idCity,
            //cCityname = modelUser.cCityname,
            cAddress = linkeadd,//modelUser.cAddress,
            //cZipcode = modelUser.cZipcode,
            cOrder_no = orderid,
            cMake2 = beizhu
        };

        model.passenger = JsonConvert.SerializeObject(userInfo);
        model.cItems = JsonConvert.SerializeObject(modelItem);
        int RowCount = bll.Add(model);
        if (RowCount > 0)
        {
            DB6.tblPassenger bllLink = new DB6.tblPassenger();
            int idLink = TypeChangeDefault.NullToInt(context.Request["linkid"], 0);//常用联系人id

            DBM6.tblPassenger linkinfo = new DBM6.tblPassenger
            {
                //id = idLink,
                idUser = user.uId,
                csurname = fname,
                cname = lname,
                cFullname = linkname,
                //IdType,
                //IdNo = idCart,
                Phone = linkmobile,
                dCreate = bll.GetTime(0),
                //cGender,
                //dBirthday,
                //idCity,
                //cCityname,
                cAddress = linkeadd,
                //cMail,
                //cValidity,
                //cIssued,
                //Nationality
            };
            int usercount = bllLink.GetRecordCount("idUser=" + user.uId + " and csurname='" + fname + "' and cname ='" + lname + "' and Phone='" + linkmobile + "'");
            if (idLink == 0)
            {
                if (usercount == 0)
                    bllLink.Add(linkinfo);
            }
            else
            {
                DBM6.tblPassenger linkuser = bllLink.GetModel(idLink);
                if (linkuser != null)
                {
                    linkinfo.id = idLink;
                    if (linkuser.csurname != fname || linkuser.cname != lname || linkuser.Phone != linkmobile)
                    {
                        bllLink.Update(linkinfo);
                    }
                }
                else
                {
                    if (usercount == 0)
                        bllLink.Add(linkinfo);
                }
            }
            modelItem.id = IdItem;
            modelItem.iLimit = modelItem.iLimit - iBuyNum;
            bllItem.Update(modelItem);
            if (JF == "on")
            {
                int idFlag = new DB1.tblIntegral().InsertScore(user.uId, 200840004, 4, TypeChangeDefault.NullToDecimal(modelItem.iScore, 0), "购买装备花费积分订单号：" + orderid);
                DBM6.tblOrder modelflag = new DBM6.tblOrder();
                modelflag.ID = RowCount;
                modelflag.cMake1 = idFlag.ToString();
                bll.Update(modelflag);//更新积分id
            }
            result = "{\"msg\":\"提交订单成功！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"提交" + modelItem.cItemName + "订单失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    //提交酒店订单
    public void tjHotel(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;

        int sid = TypeChangeDefault.NullToInt(context.Request["sid"], 0);//赛事id 
        DB6.tblRace_Competition bllRace = new DB6.tblRace_Competition();
        DBM6.tblRace_Competition modelRace = bllRace.GetModel(sid);
        if (modelRace == null)
        {
            result = "{\"msg\":\"赛事不存在\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (modelRace.iStatus != 1)
        {
            result = "{\"msg\":\"赛事已关闭\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int IdItem = TypeChangeDefault.NullToInt(context.Request["fid"], 0);//酒店项目id
        DB6.tblHotel_Item bllItem = new DB6.tblHotel_Item();
        DBM6.tblHotel_Item modelItem = bllItem.GetModel(IdItem);
        if (modelItem == null)
        {
            result = "{\"msg\":\"该酒店项目不存在！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int idHotel = modelItem.idHotel ?? 0;//酒店id
        int jdid = TypeChangeDefault.NullToInt(context.Request["hid"], 0);//酒店编码id
        if (jdid != idHotel)
        {
            result = "{\"msg\":\"该酒店不存在！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        DB6.tblOrder bll = new DB6.tblOrder();
        DB6.tblHotel bllHotel = new DB6.tblHotel();
        DBM6.tblHotel modelHotel = bllHotel.GetModel(idHotel);
        if (modelHotel == null)
        {
            result = "{\"msg\":\"该酒店不存在！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (modelItem.iLimit <= 0)
        {
            result = "{\"msg\":\"酒店房间已售罄！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int iBuyNum = TypeChangeDefault.NullToInt(context.Request["num"], 0);//购买数量
        if (iBuyNum <= 0)
        {
            result = "{\"msg\":\"请选择购买数量！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (modelHotel.iBuyMax > 0)
        {
            if (iBuyNum > modelHotel.iBuyMax)
            {
                result = "{\"msg\":\"购买数量超过最大限额（" + modelHotel.iBuyMax + "）！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            //已购买量
            int countbuy = bll.GetSumCount("iFromTpye =8 and iStatus>-1 and iTypeID='" + modelHotel.id + "'  and cFromToID=" + sid + " and idUser=" + user.uId);
            if (countbuy + iBuyNum > modelHotel.iBuyMax)
            {
                result = "{\"msg\":\"购买数量超过最大限额（" + modelHotel.iBuyMax + "）！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
        }
        //最大购买量为0即为不限制购买
        if (iBuyNum > modelItem.iLimit)
        {
            result = "{\"msg\":\"装备剩余数量不足！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        for (int i = 0; i < iBuyNum; i++)
        {
            string fname = TypeChangeDefault.NullToString(context.Request["fname" + i], "");
            if (fname.Trim().Length == 0 || fname.Trim().Length > 32)
            {
                result = "{\"msg\":\"请填写姓氏称或者姓氏超过限制！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            string lname = TypeChangeDefault.NullToString(context.Request["lname" + i], "");
            if (lname.Trim().Length == 0 || lname.Trim().Length > 32)
            {
                result = "{\"msg\":\"请填写名称或者名称超过限制！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            string idCart = TypeChangeDefault.NullToString(context.Request["idcard" + i], "");
            if (idCart.Trim().Length == 0 || idCart.Trim().Length > 32)
            {
                result = "{\"msg\":\"请填写用户证件或者用户证件超过限制！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
        }
        //联系人信息
        string linkname = TypeChangeDefault.NullToString(context.Request["linkname"], "");
        if (linkname.Trim().Length == 0 || linkname.Trim().Length > 32)
        {
            result = "{\"msg\":\"请填写联系人名称或者名称超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string linkmobile = TypeChangeDefault.NullToString(context.Request["mobile"], "");
        if (linkmobile.Trim().Length == 0 || linkmobile.Trim().Length > 22)
        {
            result = "{\"msg\":\"请填写联系人手机或者手机超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string linkemail = TypeChangeDefault.NullToString(context.Request["email"], "");
        if (linkemail.Trim().Length == 0 || linkemail.Trim().Length > 128)
        {
            result = "{\"msg\":\"请填写联系人邮箱或者邮箱超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        //备注用字段2cMake2
        string beizhu = TypeChangeDefault.NullToString(context.Request["beizhu"], "");
        if (beizhu.Trim().Length > 1024)
        {
            result = "{\"msg\":\"备注长度超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string cFrom = string.Empty;
        if (context.Session["org"] != null)
        {
            cFrom = context.Session["org"].ToString();
        }
        DBM1.tblMEMBER modelUser = new DB1.tblMEMBER().GetModel(user.uId);
        DBM6.tblOrder model = new DBM6.tblOrder
        {
            cFromToID = sid,
            cFromToName = modelRace.cTitle,
            idUser = user.uId,
            cNickName = user.cNickName,
            iFromTpye = 4,
            iTypeID = modelHotel.id,
            iTypeName = modelHotel.cName,
            iItemID = IdItem.ToString(),
            cItemName = modelItem.cItemName,
            iBuyNum = iBuyNum,
            cParentOrder = "",
            iCount = 0,
            iReceipt = 0,
            dCreateTime = bll.GetTime(0),
            dConfirmTime = bll.GetTime(0),
            FlightDate = "",//Convert.ToDateTime(modelHotel.dBeginTime).ToString("yyyy-MM-dd"),//入住时间
            cName = linkname,//modelUser.cName,//当前用户信息
            IdType = TypeChangeDefault.NullToString(modelUser.idNationIDType, ""),
            IdNo = modelUser.cNationID,
            cMobile = linkmobile,// modelUser.cMobile,
            cMail = linkemail,//modelUser.cMail,
            idCity = modelUser.idCity,
            cCityname = modelUser.cCityname,
            cAddress = modelUser.cAddress,
            iScore = 0,
            iMoney = 0,
            fPrice = modelItem.fSellPrice,
            iCost = modelItem.fSellPrice,
            iStatus = 1,
            cMake2 = beizhu,
            cFrom = cFrom
        };
        string JF = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["jf"]), "");//积分
        if (JF == "on")
        {
            int iScore = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + user.uId, user.uId);
            if (iScore < modelItem.iScore)
            {
                result = "{\"msg\":\"您的积分不足，无法使用积分！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }

            model.iScore = modelItem.iScore;
            model.iMoney = modelItem.iMoney;
            model.fPrice = modelItem.fSellPrice * iBuyNum;
            model.iCost = model.fPrice - modelItem.iMoney;
        }
        else
        {
            model.iScore = 0;
            model.iMoney = 0;
            model.fPrice = modelItem.fSellPrice * iBuyNum;
            model.iCost = modelItem.fSellPrice * iBuyNum;
        }
        string orderid = bll.GetMaxOrderId("JD");
        if (orderid == "")
        {
            orderid = "JD" + DateTime.Now.ToString("yyyyMMdd") + "000001";
        }

        else
        {
            orderid = "JD" + DateTime.Now.ToString("yyyyMMdd") + (Convert.ToInt32(orderid.Substring(orderid.Length - 6, 6)) + 1).ToString().PadLeft(6, '0');
        }
        model.cOrder_no = orderid;

        List<DBM6.tblHotel_Detail> userList = new List<DBM6.tblHotel_Detail>();
        for (int i = 0; i < iBuyNum; i++)
        {
            string fname = TypeChangeDefault.NullToString(context.Request["fname" + i], "");
            if (fname.Trim().Length == 0 || fname.Trim().Length > 32)
            {
                result = "{\"msg\":\"请填写姓氏称或者姓氏超过限制！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            string lname = TypeChangeDefault.NullToString(context.Request["lname" + i], "");
            if (lname.Trim().Length == 0 || lname.Trim().Length > 32)
            {
                result = "{\"msg\":\"请填写名称或者名称超过限制！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            string idCart = TypeChangeDefault.NullToString(context.Request["idcard" + i], "");
            if (idCart.Trim().Length == 0 || idCart.Trim().Length > 32)
            {
                result = "{\"msg\":\"请填写用户证件或者用户证件超过限制！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            DBM6.tblHotel_Detail userInfo = new DBM6.tblHotel_Detail
            {
                idCompete = sid,
                cCompetitionName = modelRace.cTitle,
                idItem = IdItem,
                cItemName = modelItem.cItemName,
                cFullname = fname + lname,
                idUser = modelUser.id,
                //cGender = modelUser.idGender.ToString(),
                //idBlood = modelUser.idBlood.ToString(),
                //dBirthday = modelUser.dBirthday,
                //IdType = modelUser.idNationIDType.ToString(),
                IdNo = idCart,
                //cNational = "",
                //cMobile = modelUser.cMobile,
                //cMail = modelUser.cMail,
                //idCity = modelUser.idCity,
                //cCityname = modelUser.cCityname,
                //cAddress = modelUser.cAddress,
                //cZipcode = modelUser.cZipcode,
                cOrder_no = orderid,
                dCreate = bll.GetTime(0),
                //cMake2 = beizhu
            };
            userList.Add(userInfo);

        }
        model.passenger = JsonConvert.SerializeObject(userList);
        model.cItems = JsonConvert.SerializeObject(modelItem);
        int RowCount = bll.Add(model);
        if (RowCount > 0)
        {
            DB6.tblPassenger bllLink = new DB6.tblPassenger();
            for (int i = 0; i < iBuyNum; i++)
            {
                string fname = TypeChangeDefault.NullToString(context.Request["fname" + i], "");
                string lname = TypeChangeDefault.NullToString(context.Request["lname" + i], "");
                string idCart = TypeChangeDefault.NullToString(context.Request["idcard" + i], "");
                int idLink = TypeChangeDefault.NullToInt(context.Request["id" + i], 0);//常用联系人id
                DBM6.tblPassenger linkinfo = new DBM6.tblPassenger
                {
                    //id = idLink,
                    idUser = user.uId,
                    csurname = fname,
                    cname = lname,
                    cFullname = fname + lname,
                    //IdType,
                    IdNo = idCart,
                    //Phone,
                    dCreate = bll.GetTime(0),
                    //cGender,
                    //dBirthday,
                    //idCity,
                    //cCityname,
                    //cAddress,
                    //cMail,
                    //cValidity,
                    //cIssued,
                    //Nationality
                };
                int usercount = bllLink.GetRecordCount("idUser=" + user.uId + " and csurname='" + fname + "' and cname ='" + lname + "' and IdNo='" + idCart + "'");
                if (idLink == 0)
                {
                    if (usercount == 0)
                        bllLink.Add(linkinfo);
                }
                else
                {
                    DBM6.tblPassenger linkuser = bllLink.GetModel(idLink);
                    if (linkuser != null)
                    {
                        linkinfo.id = idLink;
                        if (linkuser.csurname != fname || linkuser.cname != lname || user.cNationID != idCart)
                        {
                            bllLink.Update(linkinfo);
                        }
                    }
                    else
                    {
                        if (usercount == 0)
                            bllLink.Add(linkinfo);
                    }
                }

            }
            modelItem.id = IdItem;
            modelItem.iLimit = modelItem.iLimit - iBuyNum;
            bllItem.Update(modelItem);
            if (JF == "on")
            {
                int idFlag = new DB1.tblIntegral().InsertScore(user.uId, 200840004, 4, TypeChangeDefault.NullToDecimal(modelItem.iScore, 0), "购买酒店花费积分订单号：" + orderid);
                DBM6.tblOrder modelflag = new DBM6.tblOrder();
                modelflag.ID = RowCount;
                modelflag.cMake1 = idFlag.ToString();
                bll.Update(modelflag);//更新积分id
            }
            result = "{\"msg\":\"提交订单成功！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"提交" + modelItem.cItemName + "订单失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }

    //提交附属产品订单
    public void tjannex(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;

        int sid = TypeChangeDefault.NullToInt(context.Request["sid"], 0);//赛事id
        DB6.tblRace_Competition bllRace = new DB6.tblRace_Competition();
        DBM6.tblRace_Competition modelRace = bllRace.GetModel(sid);
        if (modelRace == null)
        {
            result = "{\"msg\":\"赛事不存在\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        DB6.tblAnnex bllAnnex = new DB6.tblAnnex();
        int count = bllAnnex.GetRecordCount("((idCompete = " + sid + " and iGlobal=1 )or iGlobal=0 )and iState =2");
        if (count == 0)
        {
            result = "{\"msg\":\"赛事配套产品不存在\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int Row = 0;
        DB6.tblOrder bll = new DB6.tblOrder();
        Dictionary<int, int> pList = new Dictionary<int, int>();
        for (int i = 0; i < count; i++)
        {
            int Idannex = TypeChangeDefault.NullToInt(context.Request["annex" + i], 0);
            if (Idannex == 0)
                continue;
            int annexnum = TypeChangeDefault.NullToInt(context.Request["annexnum" + i], 0);
            DBM6.tblAnnex modelAnnex = bllAnnex.GetModel(Idannex);
            if (modelAnnex == null)
            {
                result = "{\"msg\":\"请选择赛事配套产品！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            if (modelAnnex.dBegionTime > DateTime.Now)
            {
                result = "{\"msg\":\"活动未开始,无法购买！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            if (DateTime.Now > modelAnnex.dEndTime)
            {
                result = "{\"msg\":\"活动已结束\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            if (modelAnnex.iNum <= 0)
            {
                result = "{\"msg\":\"" + modelAnnex.cName + "已售罄！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            if (modelAnnex.iNum < annexnum)
            {
                result = "{\"msg\":\"" + modelAnnex.cName + "数量不足！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            //已购买数量
            if (modelAnnex.iBuyNum > 0)
            {
                int buynum = bll.GetSumCount("iFromTpye =9 and iStatus>-1 and iItemID='" + Idannex + "' and cFromToID='" + sid + "' and idUser=" + user.uId);
                if (buynum + annexnum > modelAnnex.iBuyNum)
                {
                    result = "{\"msg\":\"您已超过购买最大限额(" + modelAnnex.iBuyNum + ")！\",\"status\":\"0\"}";
                    context.Response.Write(result);
                    return;
                }
                if (buynum + annexnum > modelAnnex.iNum)
                {
                    result = "{\"msg\":\"您已超过购买最大限额(" + modelAnnex.iBuyNum + ")！\",\"status\":\"0\"}";
                    context.Response.Write(result);
                    return;
                }
            }
            ////最大购买量为0即为不限制购买
            //if (iBuyNum > modelItem.iLimit)
            //{
            //    result = "{\"msg\":\"装备剩余数量不足！\",\"status\":\"0\"}";
            //    context.Response.Write(result);
            //    return;
            //}
            pList.Add(Idannex, annexnum);
        }
        if (pList.Count == 0)
        {
            result = "{\"msg\":\"请选择赛事配套产品！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string cFrom = string.Empty;
        if (context.Session["org"] != null)
        {
            cFrom = context.Session["org"].ToString();
        }
        DBM1.tblMEMBER modelUser = new DB1.tblMEMBER().GetModel(user.uId);
        if (modelUser.cName.Length == 0)
        {
            result = "{\"msg\":\"请完善信息！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (modelUser.cMobile.Length == 0)
        {
            result = "{\"msg\":\"请完善信息！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        foreach (var dic in pList)
        {
            int Idannex = dic.Key;
            int annexnum = dic.Value;
            DBM6.tblAnnex modelAnnex = bllAnnex.GetModel(Idannex);
            DBM6.tblOrder model = new DBM6.tblOrder
            {
                cFromToID = sid,
                cFromToName = modelRace.cTitle,
                idUser = user.uId,
                cNickName = user.cNickName,
                iFromTpye = 9,
                iTypeID = sid,
                iTypeName = modelRace.cTitle,
                iItemID = Idannex.ToString(),
                cItemName = modelAnnex.cName,
                iBuyNum = annexnum,
                cParentOrder = "",
                iCount = 0,
                iReceipt = 0,
                dCreateTime = DateTime.Now,
                dConfirmTime = DateTime.Now,
                FlightDate = Convert.ToDateTime(modelRace.dRaceBegin).ToString("yyyy-MM-dd"),
                cName = modelUser.cName,//当前用户信息
                IdType = TypeChangeDefault.NullToString(modelUser.idNationIDType, ""),
                IdNo = modelUser.cNationID,
                cMobile = modelUser.cMobile,
                cMail = modelUser.cMail,
                idCity = modelUser.idCity,
                cCityname = modelUser.cCityname,
                cAddress = modelUser.cAddress,
                iScore = 0,
                iMoney = 0,
                fPrice = modelAnnex.fPrice * annexnum,
                iCost = modelAnnex.fPrice * annexnum,
                iStatus = 1,
                cFrom = cFrom
            };
            string orderid = bll.GetMaxOrderId("FS");
            if (orderid == "")
            {
                orderid = "FS" + DateTime.Now.ToString("yyyyMMdd") + "000001";
            }

            else
            {
                orderid = "FS" + DateTime.Now.ToString("yyyyMMdd") + (Convert.ToInt32(orderid.Substring(orderid.Length - 6, 6)) + 1).ToString().PadLeft(6, '0');
            }
            model.cOrder_no = orderid;

            DBM6.tblAnnex_Detail userInfo = new DBM6.tblAnnex_Detail
            {
                idCompete = sid,
                cCompetitionName = modelRace.cTitle,
                idItem = Idannex,
                cItemName = modelAnnex.cName,
                idUser = modelUser.id,
                cFullname = modelUser.cName,
                cGender = modelUser.idGender.ToString(),
                idBlood = modelUser.idBlood.ToString(),
                dBirthday = modelUser.dBirthday,
                IdType = modelUser.idNationIDType.ToString(),
                IdNo = modelUser.cNationID,
                cNational = "",
                cMobile = modelUser.cMobile,
                cMail = modelUser.cMail,
                idCity = modelUser.idCity,
                cCityname = modelUser.cCityname,
                cAddress = modelUser.cAddress,
                cZipcode = modelUser.cZipcode,
                cOrder_no = orderid

            };

            model.passenger = JsonConvert.SerializeObject(userInfo);
            model.cItems = JsonConvert.SerializeObject(modelAnnex);
            int RowCount = bll.Add(model);
            if (RowCount > 0)
            {
                //20150708 更改库存数量（有从订单查询改为从库存中判断）edit
                modelAnnex.id = Idannex;
                modelAnnex.iNum = modelAnnex.iNum - annexnum;
                bllAnnex.Update(modelAnnex);
                Row++;
            }
        }
        if (Row > 0)
        {
            result = "{\"msg\":\"提交订单成功！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"提交订单失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    //提交赛事报名订单
    public void tjdd(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;

        int sid = TypeChangeDefault.NullToInt(context.Request["sid"], 0);//赛事id
        int idItem = TypeChangeDefault.NullToInt(context.Request["p"], 0);//项目id
        int iFlag = TypeChangeDefault.NullToInt(context.Request["jf"], 0);//是否使用积分

        //20160310
        int jfz = TypeChangeDefault.NullToInt(context.Request["jfz"], 0);//最高可使用积分

        DB6.tblRace_Competition bllRace = new DB6.tblRace_Competition();
        DBM6.tblRace_Competition modelRace = bllRace.GetModel(sid);
        if (modelRace == null)
        {
            result = "{\"msg\":\"赛事不存在\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (modelRace.dJoinBegin > DateTime.Now)
        {
            result = "{\"msg\":\"赛事报名未开始,敬请关注！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (DateTime.Now > modelRace.dJoinEnd)
        {
            result = "{\"msg\":\"赛事报名已过期,请选择其他的赛事！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        DB6.tblRace_Item bllItem = new DB6.tblRace_Item();
        DBM6.tblRace_Item modelItem = bllItem.GetModel(idItem);
        if (modelItem == null)
        {
            result = "{\"msg\":\"赛事项目不存在\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (modelItem.idCompete != sid)
        {
            result = "{\"msg\":\"非法操作，系统已记录！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (modelItem.dJoinBegin > DateTime.Now)
        {
            result = "{\"msg\":\"项目报名未开始,敬请关注！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (DateTime.Now > modelItem.dJoinEnd)
        {
            result = "{\"msg\":\"报名已截止！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        if (modelItem.iScore == 0)
        {
            if (iFlag == 1)
            {
                result = "{\"msg\":\"赛事项目不允许使用积分\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
        }
        DataTable ItemExt = new DB6.tblRace_Item_ext().GetList(5, "iditem=" + idItem, "id,data_type desc,sales_field").Tables[0];
        int ExtCount = ItemExt.Rows.Count;
        DB6.tblOrder bll = new DB6.tblOrder();
        //20150708 更改库存数量（有从订单查询改为从库存中判断）edit
        //int count = new DB6.tblOrder().GetRecordCount("iFromTpye =2 and iStatus>-1 and idUser=" + user.uId + "  and iItemID='" + idItem + "' and iTypeID='" + sid + "'");
        //if (count >= modelItem.iLimit)
        //{
        //    result = "{\"msg\":\"报名已满！\",\"status\":\"0\"}";
        //    context.Response.Write(result);
        //    return;
        //}
        //20150708 更改库存数量（有从订单查询改为从库存中判断）edit
        //int? count = modelItem.iLimit;
        if (modelItem.iLimit <= 0)
        {
            result = "{\"msg\":\"报名已满！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int countNum = new DB6.tblOrder().GetRecordCount("iFromTpye =2 and iStatus>-1 and iTypeID='" + sid + "' and idUser=" + user.uId);
        if (countNum > 0)
        {
            result = "{\"msg\":\"您已报名或未付款或等待审核！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string csurname = string.Empty;
        string cname = string.Empty;
        string cFullname = string.Empty;
        string cPlace = string.Empty;
        string dIssue = string.Empty;
        string dExpiry = string.Empty;
        if (modelRace.iType == 1)
        {
            cFullname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["name"]), "");//姓名
            if (cFullname.Length <= 0 || cFullname.Length > 32)
            {
                result = "{\"msg\":\"姓名为空或超过限制！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
        }
        else if (modelRace.iType >= 2)
        {
            csurname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["csurname"]), "");//姓
            if (csurname.Length <= 0 || csurname.Length > 32)
            {
                result = "{\"msg\":\"姓(拼音)为空或超过限制！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            cname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["name"]), "");//名
            if (cname.Length <= 0 || cname.Length > 32)
            {
                result = "{\"msg\":\"名(拼音)为空或超过限制！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            cPlace = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["Placeofissue"]), "");//签发地
            if (cPlace.Length <= 0 || cPlace.Length > 32)
            {
                result = "{\"msg\":\"护照签发地为空或超过限制！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            dIssue = TypeChangeDefault.NullToString(context.Request["Dateofissue"], "");//护照签发日期   
            dExpiry = TypeChangeDefault.NullToString(context.Request["Dateofexpiry"], "");//护照有效期
        }


        string cGender = TypeChangeDefault.NullToString(context.Request["cGender"], "");//性别
        string idBlood = TypeChangeDefault.NullToString(context.Request["idBlood"], "");//血型
        string dBirthday = TypeChangeDefault.NullToString(context.Request["dBirthday"], "");//出生日期
        string idEducation = TypeChangeDefault.NullToString(context.Request["idEducation"], "");//学历
        string idOccupation = TypeChangeDefault.NullToString(context.Request["idOccupation"], "");//职业
        string cNational = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cNational"]), "");//国籍
        if (cNational.Length <= 0)
        {
            result = "{\"msg\":\"请填写国籍！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string IdType = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["IdType"]), "");//证件类型
        string IdNo = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["IdNo"]), "");//证件号码
        if (IdType == "1")
        {
            if (IdNo.Length != 18 || !Erun360.Common.PageValidate.IsNumber(IdNo.Substring(0, 17)))
            {
                result = "{\"msg\":\"身份证格式错误！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
        }
        string cMobile = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cMobile"]), "");//手机
        if (cMobile.Length <= 0 || !Erun360.Common.PageValidate.IsPhone(cMobile))
        {
            result = "{\"msg\":\"电话为空或格式错误！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string cMail = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cMail"]), "");//邮箱
        if (cMail.Length <= 0 || !Erun360.Common.PageValidate.IsEmail(cMail))
        {
            result = "{\"msg\":\"邮箱为空或邮箱格式错误！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int idCity = TypeChangeDefault.NullToInt(context.Request["idCity"], 0);//城市号
        string cCityname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cCityname"]), "");//城市名
        if (idCity == 0)
        {
            result = "{\"msg\":\"请选择居住城市！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (string.IsNullOrEmpty(cCityname))
        {
            result = "{\"msg\":\"请选择居住城市！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string cAddress = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["address"]), "");//地址
        if (cAddress.Length <= 0)
        {
            result = "{\"msg\":\"请填写地址！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string zipcode = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cZipcode"]), "");//邮编
        if (zipcode.Length <= 0)
        {
            result = "{\"msg\":\"请填写邮编！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string emerger = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["emerger"]), "");//紧急联系人
        string emermobile = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["emermobile"]), "");//紧急联系人电话
        if (emerger.Length <= 0 || emermobile.Length <= 0)
        {
            result = "{\"msg\":\"请填写紧急联系人及联系电话！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        //审核字段
        string cHealthUrl = string.Empty;
        if (modelItem.ihealth == 1)
        {
            cHealthUrl = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cHealthUrl"]), "");
            //体检证明 HttpPostedFile file = context.Request.Files["cHealthUrl"];
            if (cHealthUrl.Length <= 0)
            {
                result = "{\"msg\":\"请上传体检证明！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
        }
        string cCloth = string.Empty;
        if (modelItem.iCloth == 1)
        {
            cCloth = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cCloth"]), "");//衣服号
            if (cCloth.Length <= 0)
            {
                result = "{\"msg\":\"请选择衣服尺码！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
        }
        string cShoe = string.Empty;
        if (modelItem.iShoe == 1)
        {
            cShoe = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cShoe"]), "");//鞋号
            if (cShoe.Length <= 0)
            {
                result = "{\"msg\":\"请填写鞋号！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            if (TypeChangeDefault.NullToInt(cShoe, 0) == 0)
            {
                result = "{\"msg\":\"请填写鞋号！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            if (cShoe.Length >= 4)
            {
                result = "{\"msg\":\"鞋号长度超过限制！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
        }
        NameValueCollection ItemExtCol = new NameValueCollection();
        //扩展字段接收值
        if (ExtCount > 0)
        {
            string field = string.Empty;
            for (int i = 0; i < ExtCount; i++)
            {
                field = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request[ItemExt.Rows[i]["sales_field"].ToString()]), "");
                if (field.Length <= 0)
                {
                    if (ItemExt.Rows[i]["data_type"].ToString() == "1")
                        result = "{\"msg\":\"请上传" + ItemExt.Rows[i]["sales_field"].ToString().TrimEnd(':') + "！\",\"status\":\"0\"}";
                    else
                        result = "{\"msg\":\"请填写" + ItemExt.Rows[i]["sales_field"].ToString().TrimEnd(':') + "！\",\"status\":\"0\"}";
                    context.Response.Write(result);
                    return;
                }
                ItemExtCol.Add(ItemExt.Rows[i]["sales_field"].ToString(), field);
            }
        }
        string cFrom = string.Empty;
        if (context.Session["org"] != null)
        {
            cFrom = context.Session["org"].ToString();
        }
        DBM6.tblOrder model = new DBM6.tblOrder
        {
            cFromToID = sid,
            cFromToName = modelRace.cTitle,
            idUser = user.uId,
            cNickName = user.cNickName,
            iFromTpye = 2,
            iTypeID = sid,
            iTypeName = modelRace.cTitle,
            iItemID = idItem.ToString(),
            cItemName = modelItem.cItemName,
            iBuyNum = 1,
            cParentOrder = "",
            iCount = 0,
            iReceipt = 0,
            dCreateTime = DateTime.Now,

            FlightDate = Convert.ToDateTime(modelRace.dRaceBegin).ToString("yyyy-MM-dd"),
            //cName = cFullname,//当前用户信息
            //IdType = IdType,
            IdNo = IdNo,
            cMobile = cMobile,
            cMail = cMail,
            idCity = idCity,
            cCityname = cCityname,
            cAddress = cAddress,
            cFrom = cFrom
        };
        if (modelRace.iType == 1)
        {
            model.cName = user.cName.Length == 0 ? cFullname : user.cName; ;//当前用户信息
            model.IdType = IdType;
        }
        else if (modelRace.iType >= 2)
        {
            model.cName = user.cName.Length == 0 ? csurname + cname : user.cName;
            model.IdType = "4";
        }

        if (iFlag == 1)
        {
            int iScore = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + user.uId, user.uId);
            if (modelItem.iScore > 0 && modelItem.iMoney == 0)
            {
                if (jfz > iScore)
                {
                    result = "{\"msg\":\"您输入的积分超过限制！\",\"status\":\"0\"}";
                    context.Response.Write(result);
                    return;
                }
                if (jfz <= 0)
                {
                    result = "{\"msg\":\"请输入大于0的积分值！\",\"status\":\"0\"}";
                    context.Response.Write(result);
                    return;
                }
                decimal dd = (decimal)(jfz * 0.01);
                model.iScore = jfz;
                model.iMoney = 0;
                model.fPrice = modelItem.iCost;
                model.iCost = modelItem.iCost - dd;
            }
            else
            {
                if (iScore < modelItem.iScore)
                {
                    result = "{\"msg\":\"您的积分不足，无法使用积分！\",\"status\":\"0\"}";
                    context.Response.Write(result);
                    return;
                }

                model.iScore = modelItem.iScore;
                model.iMoney = modelItem.iMoney;
                model.fPrice = modelItem.iCost;
                model.iCost = modelItem.iCost - modelItem.iMoney;
            }
        }
        else
        {
            model.iScore = 0;
            model.iMoney = 0;
            model.fPrice = modelItem.iCost;
            model.iCost = modelItem.iCost;
        }
        //string orderid = bll.GetMaxOrderId("s");
        //if (orderid == "")
        //{
        //    orderid = DateTime.Now.ToString("yyyyMMdd") + "00001";
        //}
        //else
        //{
        //    orderid = DateTime.Now.ToString("yyyyMMdd") + (Convert.ToInt32(orderid.Substring(8, 5)) + 1).ToString().PadLeft(5, '0');
        //}
        string orderid = bll.GetMaxOrderId("BM");
        if (orderid == "")
        {
            orderid = "BM" + DateTime.Now.ToString("yyyyMMdd") + "000001";
        }

        else
        {
            orderid = "BM" + DateTime.Now.ToString("yyyyMMdd") + (Convert.ToInt32(orderid.Substring(orderid.Length - 6, 6)) + 1).ToString().PadLeft(6, '0');
        }
        model.cOrder_no = orderid;
        if (1 == modelItem.iAudit)
        {
            model.iStatus = 0;
        }
        else
        {
            if (model.iCost == 0)
            {
                model.iStatus = 2;
                //model.dPayTime = bll.GetTime(0);
                //model.cTrade_no = orderid;
            }
            else
            {
                model.iStatus = 1;
            }
            model.dConfirmTime = bll.GetTime(0);
        }

        DBM6.tblRace_Detail userInfo = new DBM6.tblRace_Detail
        {
            idCompete = sid,
            cCompetitionName = modelRace.cTitle,
            idItem = idItem,
            cItemName = modelItem.cItemName,
            idUser = user.uId,
            csurname = csurname,
            cname = cname,
            cFullname = cFullname,
            cGender = cGender,
            idBlood = idBlood,
            dBirthday = TypeChangeDefault.NullToDateTime(dBirthday, bll.GetTime(0)),
            IdType = IdType,
            IdNo = IdNo,
            cNational = cNational,
            cMobile = cMobile,
            cMail = cMail,
            idCity = idCity,
            cCityname = cCityname,
            cAddress = cAddress,
            cZipcode = zipcode,

            idEducation = TypeChangeDefault.NullToInt(idEducation, 0),
            idOccupation = TypeChangeDefault.NullToInt(idOccupation, 0),
            cEmergerContact = emerger + "|" + emermobile,

            cPlace = cPlace,
            dIssue = TypeChangeDefault.NullToDateTime(dIssue, bll.GetTime(0)),
            dExpiry = TypeChangeDefault.NullToDateTime(dExpiry, bll.GetTime(0)),
            //cFirst=
            cCloth = cCloth,
            cHealthUrl = cHealthUrl,
            cShoe = cShoe,
            cOrder_no = orderid,
            dCreate = bll.GetTime(0)
            //cFirst,
            //cresult, 
            //cECG,
            //cFinished,
            //cMake,
            //cParentOrder,
            //cOrder_no,
            //cMake1 = sid,
            //cMake2,
            //cMake3,
            //cMake4
        };
        if (modelRace.iType == 1)
        {
            userInfo.cFullname = cFullname;
        }
        else if (modelRace.iType >= 2)
        {
            userInfo.cFullname = csurname + "-" + cname;
        }
        foreach (string str in ItemExtCol)
        {
            switch (str)
            {
                case "cECG": userInfo.cECG = ItemExtCol[str]; break;
                case "cFinished": userInfo.cFinished = ItemExtCol[str]; break;
                case "cMake1": userInfo.cMake1 = ItemExtCol[str]; break;
                case "cMake2": userInfo.cMake2 = ItemExtCol[str]; break;
                case "cMake3": userInfo.cMake3 = ItemExtCol[str]; break;
                case "cMake": userInfo.cMake = ItemExtCol[str]; break;
            }
        }

        model.passenger = JsonConvert.SerializeObject(userInfo);
        model.cItems = JsonConvert.SerializeObject(modelItem);
        int RowCount = bll.Add(model);

        if (RowCount > 0)
        {
            if (modelRace.iType == 1)
            {
                DBM1.tblMEMBER modelUser = new DBM1.tblMEMBER
                {
                    cName = cFullname,
                    idGender = TypeChangeDefault.NullToInt(cGender, 0),
                    idBlood = TypeChangeDefault.NullToInt(idBlood, 0),
                    dBirthday = TypeChangeDefault.NullToDateTime(dBirthday, bll.GetTime(0)),
                    idNationIDType = TypeChangeDefault.NullToInt(IdType, 1),
                    cNationID = IdNo,
                    //cNational = cNational,
                    cMobile = cMobile,
                    cMail = cMail,
                    idCity = idCity,
                    cCityname = cCityname,
                    cAddress = cAddress,
                    cZipcode = zipcode,
                    idEducation = TypeChangeDefault.NullToInt(idEducation, 0),
                    idOccupation = TypeChangeDefault.NullToInt(idOccupation, 0),
                    cEmergerContact = emerger + "|" + emermobile,
                    id = user.uId
                };
                if (user.cName != cFullname || user.cMail != cMail || user.cNationID != IdNo)
                {
                    new DB1.tblMEMBER().Update(modelUser);
                }
            }
            else if (modelRace.iType == 2)
            {
                //国际
                DBM1.tblMember_Partner modelUser = new DBM1.tblMember_Partner
                {
                    csurname = csurname,
                    cname = cname,
                    cFullname = csurname + "-" + cname,
                    idGender = TypeChangeDefault.NullToInt(cGender, 0),
                    idBlood = TypeChangeDefault.NullToInt(idBlood, 0),
                    dBirthday = TypeChangeDefault.NullToDateTime(dBirthday, bll.GetTime(0)),
                    idEducation = TypeChangeDefault.NullToInt(idEducation, 0),
                    cNational = cNational,
                    idNationIDType = 4,
                    cNationID = IdNo,
                    cPlace = cPlace,
                    dIssue = TypeChangeDefault.NullToDateTime(dIssue, bll.GetTime(0)),
                    dExpiry = TypeChangeDefault.NullToDateTime(dExpiry, bll.GetTime(0)),
                    cCloth = cCloth,
                    cMobile = cMobile,
                    cMail = cMail,
                    idCity = TypeChangeDefault.NullToInt(idCity, 0),
                    cCityname = cCityname,
                    cAddress = cAddress,
                    cZipcode = zipcode,
                    cEmergerContact = emerger + "|" + emermobile,
                    cHealthUrl = cHealthUrl,
                    idOccupation = TypeChangeDefault.NullToInt(idOccupation, 0),
                    idUser = user.uId
                };
                if (new DB1.tblMember_Partner().Exists(user.uId))
                {
                    new DB1.tblMember_Partner().Update(modelUser);
                }
                else
                {
                    new DB1.tblMember_Partner().Add(modelUser);
                }
                //if (user.cName != cFullname || user.cMail != cMail || user.cNationID != IdNo)
                //{
                //    new DB1.tblMember_Partner().Update(modelUser);
                //}

            }
            //20150708 更改库存数量（有从订单查询改为从库存中判断）edit
            //20160427 如果是审核项目，提交时不扣除库存数量
            if (1 != modelItem.iAudit)
            {                
                modelItem.id = idItem;
                modelItem.iLimit = modelItem.iLimit - 1;
                bllItem.Update(modelItem);
            }
            if (iFlag == 1)
            {
                int idFlag = 0;
                if (modelItem.iScore > 0 && modelItem.iMoney == 0)
                {
                    idFlag = new DB1.tblIntegral().InsertScore(user.uId, 200840002, 4, TypeChangeDefault.NullToDecimal(jfz, 0), "报名赛事花费积分订单号：" + orderid);
                }
                else
                {
                    idFlag = new DB1.tblIntegral().InsertScore(user.uId, 200840002, 4, TypeChangeDefault.NullToDecimal(modelItem.iScore, 0), "报名赛事花费积分订单号：" + orderid);
                }

                DBM6.tblOrder modelflag = new DBM6.tblOrder();
                modelflag.ID = RowCount;
                modelflag.cMake1 = idFlag.ToString();
                bll.Update(modelflag);//更新积分id

            }
            if (0 == modelItem.iAudit)
            {
                if (model.iCost == 0)
                {
                    new DB6.tblRace_Detail().Add(userInfo);
                }
            }


            result = "{\"msg\":\"提交报名材料成功！\",\"id\":\"" + RowCount + "\",\"orderid\":\"" + orderid + "\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"提交报名材料失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    /// <summary>
    /// 关注赛事
    /// </summary>
    /// <param name="context"></param>
    public void gzss(HttpContext context)
    {//关注
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
        int idRace = TypeChangeDefault.NullToInt(context.Request["id"], 0);
        //int uId = user.uId;
        DB4.tblRACE_JOIN uRace_Join = new DB4.tblRACE_JOIN();
        if (uRace_Join.Exists(idRace, user.uId))
        {
            result = "{\"msg\":\"关注成功\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        int idUser = 0;
        string cTitle = string.Empty;
        if (idRace >= 300002000)
        {
            DBM6.tblRace_Competition model = new DB6.tblRace_Competition().GetModel(idRace);
            if (model == null)
            {
                result = "{\"msg\":\"赛事不存在\",\"status\":\"-2\"}";
                context.Response.Write(result);
                return;
            }
            idUser = model.idUser ?? 0;
            cTitle = model.cTitle;
        }
        else
        {
            DBM4.tblRACE_COMPETETION model = new DB4.tblRACE_COMPETETION().GetModel(idRace);
            if (model == null)
            {
                result = "{\"msg\":\"赛事不存在\",\"status\":\"-2\"}";
                context.Response.Write(result);
                return;
            }
            DBM2.tblBLOG blog = new DB2.tblBLOG().GetModel(model.idBlog ?? 0);
            if (blog == null)
            {
                result = "{\"msg\":\"赛事不存在\",\"status\":\"-2\"}";
                context.Response.Write(result);
                return;
            }
            idUser = blog.idUser;
            cTitle = model.cTitle;
        }

        DBM4.tblRACE_JOIN modelJoin = new DBM4.tblRACE_JOIN();
        //int cout = new DB4.tblRACE_JOIN().GetRecordCount("idActivity =" + cid + " and idUser=" + uId);
        modelJoin.idOnwer = idUser;
        modelJoin.idActivity = idRace;
        modelJoin.idUser = user.uId;
        modelJoin.cLoginname = user.cNickName;
        if (uRace_Join.Add(modelJoin) > 0)
        {
            new DB1.tblIntegral().InsertScore(user.uId, 200810015, 1, 0);
            //1关注11用户/12博文/13赛事/14装备，2发布21博文/22赛事/23装备/24训练，3评论31留言/32博文/33赛事/34/装备
            DBM2.tblActivity mActivity = new DBM2.tblActivity();
            mActivity.idUser = user.uId;
            mActivity.cNickName = user.cNickName;
            mActivity.cAvatar = user.cAvatar;
            mActivity.idBlog = idRace;
            mActivity.idGroup = "13";
            mActivity.cTitle = cTitle;
            new DB2.tblActivity().Add(mActivity);
            result = "{\"msg\":\"关注成功\",\"status\":\"1\"}";
            context.Response.Write(result);
        }
        else
        {
            result = "{\"msg\":\"关注失败\",\"status\":\"-1\"}";
            context.Response.Write(result);
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