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
public partial class Admin_RaceEdit : PageBase
{
    public string portrait = string.Empty;
    public int idCompete = 0;
    public int id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.uId != 100001183 && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        if (Request.QueryString["idCompete"] != null)
        {
            idCompete = TypeChangeDefault.NullToInt(Request.QueryString["idCompete"].ToString(), 0);
        }
        if (!IsPostBack)
        {
            DBM4.tblRACE_COMPETETION mCompetetion = new DB4.tblRACE_COMPETETION().GetModel(idCompete);
            if (mCompetetion != null)
            {
                ssmc.Value = mCompetetion.cTitle;
                //time.Value = Convert.ToDateTime(mCompetetion.dJoinEnd).ToString("yyyy-MM-dd");
            }
            if (id != 0)
            {
                DBM4.tblRACE_SIGNUP mSignup = new DB4.tblRACE_SIGNUP().GetModel(id);
                if (mSignup != null)
                {
                    //time.Value = Convert.ToDateTime(mSignup.dJoinEnd).ToString("yyyy-MM-dd");
                    item.Value = mSignup.cType;
                    price.Value = (mSignup.iCost ?? 0).ToString();
                    number.Value = mSignup.iLimit.ToString();
                    bz.Value = mSignup.cComment;
                    rdbfz.SelectedValue = mSignup.iCloth.ToString();
                    rdbpx.SelectedValue = mSignup.iShoe.ToString();
                    rdbhgz.SelectedValue = mSignup.ihealth.ToString();
                    rdbsh.SelectedValue = mSignup.iAudit.ToString();
                    portrait = mSignup.cURL;
                    if (mSignup.iType == 3)
                    {
                        idNum.Visible = true;
                        idNumber.Value = mSignup.iNum.ToString();
                    }
                    rdbType.SelectedValue = mSignup.iType.ToString();
                    iScore.Value = mSignup.iScore.ToString();
                    iMoney.Value = mSignup.iMoney.ToString();
                    //avatarurl.Value = mSignup.cURL;
                }
            }
            BindExt();
            //else
            //{
            //    portrait = "/Html/images/up.png";
            //    avatarurl.Value = "/Html/images/up.png";
            //}
        }
        //Response.Write(Session["idCompete"].ToString());
    }
    protected void Btnsubmit_Click(object sender, EventArgs e)
    {
        if (idCompete == 0)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "RaceCom.aspx", false);
        }
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DBM4.tblRACE_SIGNUP mSignup = new DBM4.tblRACE_SIGNUP();
        DBM4.tblRACE_COMPETETION mCompetetion = new DB4.tblRACE_COMPETETION().GetModel(idCompete);
        if (mCompetetion != null)
        {
            mSignup.cTitle = mCompetetion.cTitle;
            mSignup.idBlog = mCompetetion.idBlog;
            mSignup.idCompete = mCompetetion.id;
            mSignup.idCity = mCompetetion.idCity;
            mSignup.dJoinBegin = mCompetetion.dJoinBegin;           
        }
        //if (time.Value.Trim().Length <= 0)
        //{
        //    AlertHelper.JQAlert("请选择活动时间！", false);
        //    return;
        //}
        //mSignup.dJoinEnd = Convert.ToDateTime(time.Value);
        if (item.Value.Trim().Length <= 0 || item.Value.Trim().Length > 16)
        {
            AlertHelper.JQAlert("请填写项目名称！", false);
            return;
        }
        mSignup.cType = item.Value.Trim();
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
            AlertHelper.JQAlert("请填写积分值！", false);
            return;
        }
        mSignup.iScore = TypeChangeDefault.NullToInt(iScore.Value.Trim(), 0);
        if (iMoney.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写积分兑换价钱！", false);
            return;
        }
        mSignup.iMoney = TypeChangeDefault.NullToInt(iMoney.Value.Trim(), 0);

        
        double dsta = TypeChangeDefault.NullToDouble(iMoney.Value.Trim(), 0);
        double dstb = TypeChangeDefault.NullToDouble(price.Value.Trim(), 0);
        //iMoney.Value.Trim().eq(price.Value.Trim());        
        if (dsta > dstb)
        {
            AlertHelper.JQAlert("积分兑换值不能大于项目费用！", false);
            return;
        }
        //if (iMoney.Value.Trim().CompareTo(price.Value.Trim()) < 0)
        //{
        //    AlertHelper.JQAlert("积分兑换值不能大于项目费用！", false);
        //    return;
        //}

        //mSignup.cURL = avatarurl.Value;
        mSignup.dCreate = DateTime.Now;
        mSignup.istatus = 0;
        if (id != 0)
        {
            mSignup.id = Convert.ToInt32(id);
            if (new DB4.tblRACE_SIGNUP().Update(mSignup))
            {
                AlertHelper.JQAlertGo("修改成功！", "RaceCom.aspx?id=" + idCompete, true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            mSignup.dJoinEnd = mCompetetion.dJoinEnd;
            mSignup.cURL = "/Html/images/up.png";
            if (new DB4.tblRACE_SIGNUP().Add(mSignup) > 0)
            {
                AlertHelper.JQAlertGo("添加成功！", "RaceCom.aspx?id=" + idCompete, true);
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
        DataSet ds = new DB4.tblRace_SignUp_ext().GetList("iditem=" + id);
        rptExt.DataSource = ds;
        rptExt.DataBind();
    }
}