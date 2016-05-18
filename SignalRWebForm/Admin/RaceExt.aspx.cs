using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using Utils;
using System.Data;

public partial class Admin_RaceExt : PageBase
{
    public int idCompete = 0;//赛事id
    public int iditem = 0;//项目id
    public int id = 0;//记录id
    protected void Page_Load(object sender, EventArgs e)
    {
        idCompete = TypeChangeDefault.NullToInt(Request.QueryString["idCompete"], 0);
        iditem = TypeChangeDefault.NullToInt(Request.QueryString["iditem"], 0);
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (!IsPostBack)
        {
            DBM4.tblRACE_SIGNUP mSignup = new DB4.tblRACE_SIGNUP().GetModel(iditem);
            if (mSignup != null)
            {
                ssmc.Value = mSignup.cTitle;
                item.Value = mSignup.cType;
            }
            else
            {
                AlertHelper.JQAlertGo("请选择赛事！", "RaceCom.aspx", false);
            }
            if (id != 0)
            {
                DBM4.tblRace_SignUp_ext model = new DB4.tblRace_SignUp_ext().GetModel(id);
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
        DBM4.tblRace_SignUp_ext model = new DBM4.tblRace_SignUp_ext();
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
            if (new DB4.tblRace_SignUp_ext().Update(model))
            {
                //UpdateField(iditem);
                string CacheKey = "GetField-" + iditem;
                Erun360.Common.DataCache.RemoveAllCache(CacheKey);
                AlertHelper.JQAlertGo("修改成功！", "RaceEdit.aspx?id="+iditem+"&idCompete=" + idCompete, true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            model.idUser = CurrentUser.uId;
            if (new DB4.tblRace_SignUp_ext().Add(model) > 0)
            {
                AlertHelper.JQAlertGo("添加成功！", "RaceEdit.aspx?id=" + iditem + "&idCompete=" + idCompete, true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }
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
                DataTable dtfileurl = new DB4.tblRace_SignUp_ext().GetList(5, "iditem=" + idItem, "data_type,sales_field").Tables[0];
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