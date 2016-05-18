using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DBM1 = Erun360.Model.DB1;
using DB1 = Erun360.BLL.DB1;
using System.Data;
public partial class Admin_ScoreEdit : PageBase
{
    private int id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        if (!IsPostBack)
        {
            if (id != 0)
            {
                DBM1.tblIntegral model = new DB1.tblIntegral().GetModel(id);
                if (model != null)
                {
                    //ddlType.SelectedValue = model.cTypeName;

                    ddlType.SelectedValue = TypeChangeDefault.NullToString(model.iType, "1");
                    idCode.Value = model.idCode.ToString();
                    ChildTypeName.Value = model.cTitle;
                    fScore.Value = model.fScore.ToString();
                    iCycle.Value = model.iCycle.ToString();
                    iTotal.Value = model.iTotal.ToString();
                    iMax.Value = model.iMax.ToString();
                    cDescription.Value = model.cDescription;
                    state.Value = model.iStatus.ToString();
                    ddlType.Enabled = false;
                }
            }
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.idMemberStyle < 12)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        DB1.tblIntegral BLL = new DB1.tblIntegral();
        DBM1.tblIntegral model = new DBM1.tblIntegral();
       
        model.cTypeName =ddlType.SelectedItem.Text ;
        model.iType = TypeChangeDefault.NullToInt(ddlType.SelectedValue, 0);
        if (ChildTypeName.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填积分名称！", false);
            return;
        }
        else if (ChildTypeName.Value.Trim().Length > 128)
        {
            AlertHelper.JQAlert("积分名称超出限制！", false);
            return;
        }
        int idCode1 = TypeChangeDefault.NullToInt(idCode.Value, 0);
        //if (BLL.Exists(idCode1, ChildTypeName.Value.Trim()))
        //{
        //    AlertHelper.JQAlert("积分名称已存在！", false);
        //    return;
        //}
        
        model.cTitle=ChildTypeName.Value.Trim() ;        
        
        model.fScore = TypeChangeDefault.NullToDecimal(fScore.Value.Trim(), 0);
        //fScore.Value = model.fScore;
        model.iCycle = TypeChangeDefault.NullToInt(iCycle.Value.Trim(), 0);
        model.iTotal = TypeChangeDefault.NullToInt(iTotal.Value.Trim(), 0);
        model.iMax = TypeChangeDefault.NullToInt(iMax.Value.Trim(), 0);
        model.cDescription = cDescription.Value.Trim();  
        model.iStatus = TypeChangeDefault.NullToInt(state.Value.Trim(), 0);
        if (id != 0)
        {
            model.id = id;
            model.idCode = idCode1;
            model.dUpdate = DateTime.Now;
            model.dUpdateName = CurrentUser.cLoginname;
            if (BLL.Update(model))
            {
                GetScoreReList();
                AlertHelper.JQAlertGo("修改成功！", "ScoreList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            //model.id = BLL.GetMaxIdType(TypeChangeDefault.NullToInt(ddlType.SelectedValue, 1));
            model.idCode = BLL.GetMaxIdByType(ddlType.SelectedValue);
            model.dUpdate = DateTime.Now;
            model.dUpdateName = CurrentUser.cLoginname;
            if (BLL.Add(model)>0)
            {
                AlertHelper.JQAlertGo("添加成功！", "ScoreList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }

        }
       
    }
    public static Dictionary<int, DBM1.tblIntegral> GetScoreReList()
    {
        string CacheKey = "tblIntegral";
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        objModel = null;
        if (objModel == null)
        {
            try
            {
                Dictionary<int, DBM1.tblIntegral> dict = new Dictionary<int, DBM1.tblIntegral>();
                List<DBM1.tblIntegral> adList = new DB1.tblIntegral().GetModelList(" iStatus>0");
                foreach (DBM1.tblIntegral model in adList)
                {
                    dict.Add(model.idCode, model);
                }
                objModel = dict;
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch { }
        }
        return (Dictionary<int, DBM1.tblIntegral>)objModel;
    }
}