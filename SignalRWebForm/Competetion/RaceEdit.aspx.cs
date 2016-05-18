using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using Utils;
using System.Data;
using System.Text;
using System.Collections.Specialized;
public partial class Competetion_RaceEdit : PageBase
{
    public string portrait = string.Empty;
    public int idCompete = 0;//赛事id
    public int id = 0;
    public string items = string.Empty;
    public string cnName = string.Empty;
    public string enName = string.Empty;
    public string sales_field = string.Empty;
    public int data_type = 0;
    public string cnTip = string.Empty;
    public string enTip = string.Empty;
    public int idequstm = 0;
    DataTable dt = new DataTable();
    public string title = string.Empty;
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
            idCompete = TypeChangeDefault.NullToInt(Request.QueryString["sid"].ToString(), 0);
        }
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition comp = new DB6.tblRace_Competition().GetModel(TypeChangeDefault.NullToInt(idCompete, 0));
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
            DBM6.tblRace_Competition mCompetetion = new DB6.tblRace_Competition().GetModel(idCompete);
            if (mCompetetion != null)
            {
                //ssmc.Value = mCompetetion.cTitle;
                //time.Value = Convert.ToDateTime(mCompetetion.dJoinEnd).ToString("yyyy-MM-dd");
            }
            if (id != 0)
            {
                DBM6.tblRace_Item mSignup = new DB6.tblRace_Item().GetModel(id);
                if (mSignup != null)
                {
                    //time.Value = Convert.ToDateTime(mSignup.dJoinEnd).ToString("yyyy-MM-dd");
                    //ssmc.Value = 
                    item.Value = mSignup.cItemName;
                    price.Value = (mSignup.iCost ?? 0).ToString();
                    number.Value = mSignup.iLimit.ToString();
                    bz.Value = mSignup.cComment;
                    rdbfz.SelectedValue = mSignup.iCloth.ToString();
                    rdbpx.SelectedValue = mSignup.iShoe.ToString();
                    rdbhgz.SelectedValue = mSignup.ihealth.ToString();
                    rdbsh.SelectedValue = mSignup.iAudit.ToString();
                    dJoinBegin.Value = mSignup.dJoinBegin.ToString();
                    dJoinEnd.Value = mSignup.dJoinEnd.ToString();
                    //portrait = mSignup.cURL;
                    if (mSignup.iType == 3)
                    {
                        idNum.Visible = true;
                        idNumber.Value = mSignup.iNum.ToString();
                    }
                    rdbType.SelectedValue = mSignup.iType.ToString();
                    iScore.Value = mSignup.iScore.ToString();
                    iMoney.Value = mSignup.iMoney.ToString();
                    //portrait = mSignup.cURL;
                }
            }
            BindExt();
            BindFscp();
            xgdfs();
        }
    }
    protected void Btnsubmit_Click(object sender, EventArgs e)
    {
        if (idCompete == 0)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "RaceCom.aspx?sid=" + idCompete + "", false);
        }
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DBM6.tblRace_Item mSignup = new DBM6.tblRace_Item();
        DBM6.tblRace_Competition mCompetetion = new DB6.tblRace_Competition().GetModel(idCompete);
        if (Convert.ToDateTime(dJoinBegin.Value.Trim()) > Convert.ToDateTime(dJoinEnd.Value.Trim()))
        {
            AlertHelper.JQAlert("开始时间不能大于结束时间！", false);
            return;
        }
        if (dJoinBegin.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择开始报名时间！", false);
            return;
        }
        if (dJoinEnd.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择结束报名时间！", false);
            return;
        }
        if (Convert.ToDateTime(dJoinBegin.Value.Trim()) < mCompetetion.dJoinBegin)
        {
            AlertHelper.JQAlert("开始时间不能小于赛事报名开始时间！", false);
            return;
        }
        if (Convert.ToDateTime(dJoinEnd.Value.Trim()) > mCompetetion.dJoinEnd)
        {
            AlertHelper.JQAlert("结束时间不能大于赛事报名结束时间！", false);
            return;
        }
        mSignup.dJoinBegin = Convert.ToDateTime(dJoinBegin.Value.Trim());
        mSignup.dJoinEnd = Convert.ToDateTime(dJoinEnd.Value.Trim());
        if (mCompetetion != null)
        {
            mSignup.cTitle = mCompetetion.cTitle;
            //mSignup.idBlog = mCompetetion.idBlog;
            mSignup.idCompete = mCompetetion.id;
            mSignup.idCity = mCompetetion.idCity;
            mSignup.cCityname = mCompetetion.cCityname;
        }

        if (item.Value.Trim().Length <= 0 || item.Value.Trim().Length > 60)
        {
            AlertHelper.JQAlert("请填写项目名称！", false);
            return;
        }
        mSignup.cItemName = item.Value.Trim();
        if (price.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写项目费用！", false);
            return;
        }

        mSignup.iCost = TypeChangeDefault.NullToDecimal(price.Value.Trim(), 0);

        mSignup.iLimit = TypeChangeDefault.NullToInt(number.Value.Trim(), 0);
        mSignup.cComment = bz.Value.Trim();
        mSignup.iCloth = TypeChangeDefault.NullToInt(rdbfz.SelectedValue, 0);
        mSignup.iShoe = TypeChangeDefault.NullToInt(rdbpx.SelectedValue, 0);
        mSignup.ihealth = TypeChangeDefault.NullToInt(rdbhgz.SelectedValue, 0);
        mSignup.iAudit = TypeChangeDefault.NullToInt(rdbsh.SelectedValue, 0);
        mSignup.iType = TypeChangeDefault.NullToInt(rdbType.SelectedValue, 0);
        if (idNum.Visible)
        {
            if (idNumber.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert("请填写组队人数！", false);
                return;
            }
        }
        else
            idNumber.Value = "0";
        mSignup.iNum = TypeChangeDefault.NullToInt(idNumber.Value.Trim(), 0);

        if (iScore.Value.Trim().Length <= 0)
        {
            mSignup.iScore = 0;
        }
        else
        {
            mSignup.iScore = TypeChangeDefault.NullToInt(iScore.Value.Trim(), 0);
        }
        if (iMoney.Value.Trim().Length <= 0)
        {
            mSignup.iMoney = 0;
        }
        else
        {
            mSignup.iMoney = TypeChangeDefault.NullToInt(iMoney.Value.Trim(), 0);
        }
        double dsta = TypeChangeDefault.NullToDouble(iMoney.Value.Trim(), 0);
        double dstb = TypeChangeDefault.NullToDouble(price.Value.Trim(), 0);
        //iMoney.Value.Trim().eq(price.Value.Trim());        
        if (dsta > dstb)
        {
            AlertHelper.JQAlert("积分兑换值不能大于项目费用！", false);
            return;
        }

        if (id != 0)
        {
            idequstm = id;
        }
        else
        {
            idequstm = new DB6.tblRace_Item_ext().GetMaxId();
        }
        #region 动态加载控件
        //if (!IsPostBack)
        //{            
            dt.Columns.Add("sales");
        //}
        StringBuilder sb = new StringBuilder();
        //string[] strsaled = "";
            //NameValueCollection FieldVars = new NameValueCollection();
            for (int i = 0; i < 1000; i++)
            {//动态验证
                cnName = TypeChangeDefault.NullToString(Request.Form["cnName" + i.ToString()], "");
                enName = TypeChangeDefault.NullToString(Request.Form["enName" + i.ToString()], "");
                sales_field = TypeChangeDefault.NullToString(Request.Form["ddlfield" + i.ToString()], "");
                data_type = TypeChangeDefault.NullToInt(Request.Form["ddlType" + i.ToString()], 0);
                cnTip = TypeChangeDefault.NullToString(Request.Form["tipcnName" + i.ToString()], "");
                enTip = TypeChangeDefault.NullToString(Request.Form["tipenName" + i.ToString()], "");


                //sb.AppendLine(sales_field);
                //sb.AppendLine(",");

                if (cnName != string.Empty && enName != string.Empty)
                {
                    if (cnName.Length <= 0 || cnName.Length > 32)
                    {
                        AlertHelper.JQAlert("中文扩展说明！", false);
                        return;
                    }
                    if (enName.Trim().Length <= 0 || enName.Trim().Length > 32)
                    {
                        AlertHelper.JQAlert("英文扩展说明！", false);
                        return;
                    }
                    int count = new DB6.tblRace_Item_ext().GetRecordCount("iditem=" + idequstm + " and sales_field='" + sales_field + "' and id!=0");
                    if (count > 0)
                    {
                        AlertHelper.JQAlert("存放位置已存在，请重新选择！", false);
                        return;
                    }
                    if(sb.ToString().IndexOf(sales_field)>-1)
                    {
                        AlertHelper.JQAlert("存放位置已存在，请重新选择！", false);
                        return;
                    }
                    sb.AppendLine(sales_field);
                    sb.AppendLine(",");
                    if (cnTip.Trim().Length > 32)
                    {
                        AlertHelper.JQAlert("中文备注长度超过限制！", false);
                        return;
                    }
                    if (enTip.Trim().Length > 32)
                    {
                        AlertHelper.JQAlert("英文备注长度超过限制！", false);
                        return;
                    }
                }
            }
        #endregion
        //dt.Reset();
        DBM6.tblRace_Item_ext model = new DBM6.tblRace_Item_ext();
        if (id != 0)
        {
            mSignup.id = id;
            if (new DB6.tblRace_Item().Update(mSignup))
            {
                #region 获取动态加载数据
                //if (cnName != string.Empty && enName != string.Empty)
                //{
                for (int i = 0; i < 1000; i++)
                {
                    cnName = TypeChangeDefault.NullToString(Request.Form["cnName" + i.ToString()], "");
                    enName = TypeChangeDefault.NullToString(Request.Form["enName" + i.ToString()], "");
                    sales_field = TypeChangeDefault.NullToString(Request.Form["ddlfield" + i.ToString()], "");
                    data_type = TypeChangeDefault.NullToInt(Request.Form["ddlType" + i.ToString()], 0);
                    cnTip = TypeChangeDefault.NullToString(Request.Form["tipcnName" + i.ToString()], "");
                    enTip = TypeChangeDefault.NullToString(Request.Form["tipenName" + i.ToString()], "");
                    if (cnName != string.Empty && enName != string.Empty)
                    {
                        model.iditem = TypeChangeDefault.NullToInt(id, 0);
                        model.data_type = TypeChangeDefault.NullToInt(data_type, 0);
                        model.cnName = cnName.Trim();
                        if (!cnName.EndsWith("："))
                        {
                            model.cnName = cnName.Trim() + "：";
                        }
                        model.enName = enName.Trim();
                        if (!enName.Trim().EndsWith("："))
                        {
                            model.enName = enName.Trim() + "：";
                        }
                        model.sales_field = TypeChangeDefault.NullToString(sales_field, "");
                        model.cnTip = cnTip.Trim();
                        model.enTip = enTip.Trim();
                        model.dCreate = DateTime.Now;
                        model.idUser = CurrentUser.uId;
                        new DB6.tblRace_Item_ext().Add(model);
                    }
                }
                //}
                #endregion
                AlertHelper.JQAlertGo("修改成功！", "RaceCom.aspx?sid=" + idCompete, true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            //mSignup.dJoinEnd = mCompetetion.dJoinEnd;
            mSignup.dCreate = DateTime.Now;
            //mSignup.cURL = "/Html/images/up.png";
            if (new DB6.tblRace_Item().Add(mSignup) > 0)
            {
                #region 获取动态加载数据
                //动态添加款式
                
                for (int i = 0; i < 1000; i++)
                {
                    cnName = TypeChangeDefault.NullToString(Request.Form["cnName" + i.ToString()], "");
                    enName = TypeChangeDefault.NullToString(Request.Form["enName" + i.ToString()], "");
                    sales_field = TypeChangeDefault.NullToString(Request.Form["ddlfield" + i.ToString()], "");
                    data_type = TypeChangeDefault.NullToInt(Request.Form["ddlType" + i.ToString()], 0);
                    cnTip = TypeChangeDefault.NullToString(Request.Form["tipcnName" + i.ToString()], "");
                    enTip = TypeChangeDefault.NullToString(Request.Form["tipenName" + i.ToString()], "");
                    if (cnName != string.Empty && enName != string.Empty)
                    {
                        model.iditem = TypeChangeDefault.NullToInt(new DB6.tblRace_Item().GetMaxId()-1, 0);
                        model.data_type = TypeChangeDefault.NullToInt(data_type, 0);
                        model.cnName = cnName.Trim();
                        if (!cnName.EndsWith("："))
                        {
                            model.cnName = cnName.Trim() + "：";
                        }
                        model.enName = enName.Trim();
                        if (!enName.Trim().EndsWith("："))
                        {
                            model.enName = enName.Trim() + "：";
                        }
                        model.sales_field = sales_field;
                        model.cnTip = cnTip.Trim();
                        model.enTip = enTip.Trim();
                        model.dCreate = DateTime.Now;
                        model.idUser = CurrentUser.uId;
                        new DB6.tblRace_Item_ext().Add(model);
                    }
                }
                #endregion
                AlertHelper.JQAlertGo("添加成功！", "RaceCom.aspx?sid=" + idCompete, true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }
        }
    }

    protected void rdbType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rdbType.SelectedValue == "3")
        {
            idNum.Visible = true;
        }
        else
        {
            idNum.Visible = false;
        }
    }
    public void BindExt()
    {
        DataSet ds = new DB6.tblRace_Item_ext().GetList("iditem=" + id);
        rptExt.DataSource = ds;
        rptExt.DataBind();
    }
    protected void BindFscp()
    {
        //DataSet ds = new DB6.tblAnnex().GetList("iState>0 and iNum>0 and idCompete ='" + idCompete + "' or iGlobal = 0");
        //cbxFscp.DataSource = ds;
        //cbxFscp.DataTextField = "cName";
        //cbxFscp.DataValueField = "id";
        //cbxFscp.DataBind();
        
    }
    public void xgdfs()
    {
        //DataSet ds = new DB6.tblRace_Item().GetList(" id=" + id);
        
        //if (ds.Tables[0].Rows.Count > 0)
        //{            
        //    items = ds.Tables[0].Rows[0]["cItem"].ToString();
        //    string[] ca = items.Split(',');
        //    DataTable dt = new DB6.tblAnnex().GetList("iState>0 and iNum>0 and idCompete ='" + idCompete + "' or iGlobal = 0").Tables[0];
        //    for (int i = 0; i < dt.Rows.Count; i++)//给CheckBoxList选中的复选框 赋值                  
        //    {
        //        for (int j = 0; j < ca.Length; j++)
        //        {
        //            //cbxFscp.Items[i].Selected = false;
        //            if (dt.Rows[i]["id"].ToString() == ca[j])
        //            {
        //                cbxFscp.Items[i].Selected = true;
        //            }
        //        }
        //    }
        //}
    }

}