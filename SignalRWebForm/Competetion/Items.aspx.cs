using System;
using System.Data;
using System.Web.UI;
using Erun360.BLL;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DB3 = Erun360.BLL.DB3;
using DB5 = Erun360.BLL.DB5;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DBM5 = Erun360.Model.DB5;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using Utils;
using System.Web.UI.WebControls;

public partial class Competetion_Items : PageBase
{
    public string portrait = string.Empty;
    public int idcompete = 0;
    private int id = 0;
    protected void Page_Load(object sender, EventArgs e)
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
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        if (!IsPostBack)
        {
            BindGoods();
            if (id != 0)
            {
                DBM6.tblEquipment model = new DB6.tblEquipment().GetModel(id);
                if (model != null)
                {
                    idGood.SelectedValue = model.idCompete.ToString();
                    Cname.Value = model.cName.ToString();
                    iTotal.Value = model.iTotal.ToString();
                    iBuyMax.Value = model.iBuyMax.ToString();
                    //dRaceBegin.Value = Convert.ToDateTime(model.dBeginTime).ToString("yyyy-MM-dd");
                    //dRaceEnd.Value = Convert.ToDateTime(model.dEndTime).ToString("yyyy-MM-dd");
                    cLink.Value = model.cLink.ToString();
                    portrait = model.cImage.ToString();
                    Text1.Value = model.cBio.Replace("[IMG]", "<img src=\"").Replace("[/IMG]", "\"/>");
                    Text2.Value = model.cReason.Replace("[IMG]", "<img src=\"").Replace("[/IMG]", "\"/>");
                    Text3.Value = model.cNorm.Replace("[IMG]", "<img src=\"").Replace("[/IMG]", "\"/>");
                    iState.Value = model.iStatus.ToString();
                    //iGlobal.Value = model.iGlobal.ToString();
                }
            }
            else
            {
                //idGood.SelectedValue = idcompete.ToString();
                //dRaceBegin.Value = string.Format("{0:yyyy-MM-dd}", DateTime.Now);
                //dRaceEnd.Value = string.Format("{0:yyyy-MM-dd}", DateTime.Now);
            }
        }
    }
    protected void BindGoods()
    {
        DataSet ds = new DB6.tblRace_Competition().GetList("iStatus>0 ");
        idGood.DataSource = ds.Tables[0];
        idGood.DataTextField = "cTitle";
        idGood.DataValueField = "id";
        idGood.DataBind();
        idGood.Items.Insert(0, new ListItem("--所有--", "0"));
    }
    protected void but_save_Click(object sender, EventArgs e)
    {
        if (idGood.SelectedValue == string.Empty)
        {
            AlertHelper.JQAlertGo("暂无赛事！", "Equipment.aspx", false);
            return;
        }
        if (Cname.Value == string.Empty)
        {
            AlertHelper.JQAlertGo("请填写酒店名称！", "", false);
            return;
        }
        if (dRaceBegin.Value == string.Empty || dRaceEnd.Value == string.Empty)
        {
            AlertHelper.JQAlertGo("请填时间！", "", false);
            return;
        }

        DBM6.tblEquipment modl = new DBM6.tblEquipment();
        modl.idCompete = TypeChangeDefault.NullToInt(idGood.SelectedValue, 0);
        modl.cName = Cname.Value;
        modl.iTotal = TypeChangeDefault.NullToInt(iTotal.Value, 0);
        modl.iBuyMax = TypeChangeDefault.NullToInt(iBuyMax.Value, 0);
        modl.dBeginTime = TypeChangeDefault.NullToDateTime(dRaceBegin.Value, DateTime.Now);
        modl.dEndTime = TypeChangeDefault.NullToDateTime(dRaceEnd.Value, DateTime.Now);
        modl.cLink = cLink.Value;
        modl.cImage = avatarurl.Value;
        modl.cBio = Text1.Value;
        modl.cReason = Text2.Value;
        modl.cNorm = Text3.Value;
        modl.iStatus = TypeChangeDefault.NullToInt(iState.Value, 0);
        if (TypeChangeDefault.NullToInt(idGood.SelectedValue, 0) == 0)
        {
            modl.iGlobal = 0;
        }
        else
        {
            modl.iGlobal = 1;
        }
        modl.dCreate = DateTime.Now;
        modl.idUser = CurrentUser.uId;
        if (modl.dBeginTime > modl.dEndTime)
        {
            AlertHelper.JQAlertGo("开始时间不能大于结束时间！", "", false);
            return;
        }
        if (id == 0)
        {
            int i = new DB6.tblEquipment().Add(modl);
            if (i > 0)
            {
                //DB3.tblIMAGES imgBll = new DB3.tblIMAGES();
                //DBM3.tblIMAGES imgModel = new DBM3.tblIMAGES();
                ////删除原来博客图片
                //imgBll.DeleteByIdBlog(TypeChangeDefault.NullToInt(idGood.SelectedValue, 0));
                //BlogInfo ucBlog = new BlogInfo();
                ////插入图片
                //string thumbnail = string.Empty;//缩略图

                //string[] ImgList = ucBlog.GetHtmlImageUrlList(modl.cNorm + modl.cReason + modl.cBio);
                //if (ImgList.Length > 0)
                //{
                //    thumbnail = ImgList[0];
                //    for (int j = 0; j < ImgList.Length; j++)
                //    {
                //        imgModel.idUser = CurrentUser.uId;
                //        imgModel.idInfo = TypeChangeDefault.NullToInt(idGood.SelectedValue, 0);
                //        imgModel.cImageUrl = ImgList[j];
                //        imgModel.cThumbUrl = ImgList[j];
                //        imgModel.dCreate = DateTime.Now;
                //        imgBll.Add(imgModel);
                //    }
                //}
                AlertHelper.JQAlertGo("添加成功！", "Equipment.aspx", true);
                return;
            }
            else
            {
                AlertHelper.JQAlertGo("添加失败！", "Equipment.aspx", false);
                return;
            }
        }
        else
        {
            modl.id = id;
            bool cout = new DB6.tblEquipment().Update(modl);
            if (cout)
            {
                AlertHelper.JQAlertGo("修改成功！", "Equipment.aspx", true);
                return;
            }
            else
            {
                AlertHelper.JQAlertGo("修改失败！", "Equipment.aspx", false);
                return;
            }

        }
    }
}