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

public partial class Admin_RaceExt : PageBase
{
    public int idCompete = 0;//赛事id
    public int iditem = 0;//项目id
    public int id = 0;//记录id
    public string title = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        idCompete = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        iditem = TypeChangeDefault.NullToInt(Request.QueryString["iditem"], 0);
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition comp = new DB6.tblRace_Competition().GetModel(TypeChangeDefault.NullToInt(idCompete, 0));
            ltlbanner.Text = comp.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + comp.cBanner + "\" height=\"256\" width=\"1200\" alt=\"\"/>";
            title = comp.cTitle;
            this.page_Title = title+"-扩展字段-益跑网赛事报名";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            DBM6.tblRace_Item mSignup = new DB6.tblRace_Item().GetModel(iditem);
            if (mSignup != null)
            {
                ssmc.Value = mSignup.cTitle;
                item.Value = mSignup.cItemName;
            }
            else
            {
                AlertHelper.JQAlertGo("请先添加项目！", "RaceEdit.aspx?id=" + id + "&sid=" + idCompete + "", false);
                return;
            }
            if (id != 0)
            {
                DBM6.tblRace_Item_ext model = new DB6.tblRace_Item_ext().GetModel(id);
                if (model != null)
                {
                    ddlType.SelectedValue = model.data_type.ToString();
                    cnName.Value = model.cnName;
                    enName.Value = model.enName;
                    ddlfield.SelectedValue = model.sales_field;
                    tipcnName.Value = model.cnTip;
                    tipenName.Value = model.enTip;
                }
            }
        }
    }
    protected void Btnsubmit_Click(object sender, EventArgs e)
    {
        DBM6.tblRace_Item_ext model = new DBM6.tblRace_Item_ext();
        model.iditem = TypeChangeDefault.NullToInt(Request.QueryString["iditem"], 0);
        model.data_type = TypeChangeDefault.NullToInt(ddlType.SelectedValue, 0);
        if (cnName.Value.Trim().Length <= 0 || cnName.Value.Trim().Length > 32)
        {
            AlertHelper.JQAlert("中文扩展说明！", false);
            return;
        }
        model.cnName = cnName.Value.Trim();
        if (!cnName.Value.Trim().EndsWith("："))
        {
            model.cnName = cnName.Value.Trim() + "：";
        }
       
        if (enName.Value.Trim().Length <= 0 || enName.Value.Trim().Length > 32)
        {
            AlertHelper.JQAlert("英文扩展说明！", false);
            return;
        }
        model.enName = enName.Value.Trim();
        if (!enName.Value.Trim().EndsWith("："))
        {
            model.enName = enName.Value.Trim() + "：";
        }
        model.sales_field = TypeChangeDefault.NullToString(ddlfield.SelectedValue, "");
        int count = new DB4.tblRace_SignUp_ext().GetRecordCount("iditem=" + iditem + " and sales_field='" + ddlfield.SelectedValue + "' and id!=" + id + "");
        if (count > 0)
        {
            AlertHelper.JQAlert("存放位置已存在，请重新选择！", false);
            return;
        }
        if (tipcnName.Value.Trim().Length > 32)
        {
            AlertHelper.JQAlert("中文备注长度超过限制！", false);
            return;
        }
        model.cnTip = tipcnName.Value.Trim();
        if (tipenName.Value.Trim().Length > 32)
        {
            AlertHelper.JQAlert("英文备注长度超过限制！", false);
            return;
        }
        model.enTip = tipenName.Value.Trim();        
        model.dCreate = DateTime.Now;
        if (id != 0)
        {
            model.id = id;
            model.mark = CurrentUser.uId.ToString();
            if (new DB6.tblRace_Item_ext().Update(model))
            {
                //UpdateField(iditem);
                string CacheKey = "GetField-" + iditem;
                Erun360.Common.DataCache.RemoveAllCache(CacheKey);
                AlertHelper.JQAlertGo("修改成功！", "RaceEdit.aspx?id="+iditem+"&sid=" + idCompete, true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            //model.idUser = CurrentUser.uId;
            //if (new DB6.tblRace_Item_ext().Add(model) > 0)
            //{
            //    AlertHelper.JQAlertGo("添加成功！", "RaceEdit.aspx?id=" + iditem + "&idCompete=" + idCompete, true);
            //}
            //else
            //{
            //    AlertHelper.JQAlert("添加失败，请重试！", false);
            //}
        }
    }
    public static Dictionary<string, string> UpdateField(int idItem)
    {
        string CacheKey = "GetField-" + idItem;
        Erun360.Common.DataCache.RemoveAllCache(CacheKey);
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
            try
            {
                Dictionary<string, string> vers = new Dictionary<string, string>();
                DataTable dtfileurl = new DB6.tblRace_Item_ext().GetList(5, "iditem=" + idItem, "data_type,sales_field").Tables[0];
                if (dtfileurl.Rows.Count > 0)
                {
                    int fcount = 0, bcount = 0, rcount = 0;
                    for (int i = 0; i < dtfileurl.Rows.Count; i++)
                    {
                        if (dtfileurl.Rows[i]["data_type"].ToString() == "1")//附件上传
                        {
                            switch (fcount)
                            {
                                case 0:
                                    vers.Add("fileurl1", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                                case 1:
                                    vers.Add("fileurl2", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                                case 2:
                                    vers.Add("fileurl3", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                            }
                            fcount++;
                        }
                        else if (dtfileurl.Rows[i]["data_type"].ToString() == "2")//文本字段
                        {
                            switch (bcount)
                            {
                                case 0:
                                    vers.Add("bzfield1", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                                case 1:
                                    vers.Add("bzfield2", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                                case 2:
                                    vers.Add("bzfield3", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                            }
                            bcount++;
                        }
                        else if (dtfileurl.Rows[i]["data_type"].ToString() == "3")//是否字段
                        {
                            switch (rcount)
                            {
                                case 0: vers.Add("rbyes1", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                                case 1: vers.Add("rbyes2", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                                case 2: vers.Add("rbyes3", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                            }
                            rcount++;

                        }
                    }
                }
                objModel = vers;
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch { }
        }
        return (Dictionary<string, string>)objModel;
    }
}