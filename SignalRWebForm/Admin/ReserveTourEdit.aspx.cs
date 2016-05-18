using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;

public partial class Admin_ReserveTourEdit : PageBase
{
    private int id = 0;
    private int idgood = 0;
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
        if (Request.QueryString["idgood"] != null)
        {
            idgood = Convert.ToInt32(Request.QueryString["idgood"].ToString());
        }
        if (!IsPostBack)
        {
            BindGoods();
            if (id != 0)
            {
                DBM1.tblReserve model = new DB1.tblReserve().GetModel(id);
                if (model != null)
                {
                    idGood.SelectedValue = model.idGood.ToString();
                    cSize.Value = model.cSize;
                    cColor.Value = model.cColor;
                    iTotal.Value = model.iReserve.ToString();
                    lbtt.Text = model.cImage;
                }
            }
            else
            {
                if (idgood != 0)
                {
                    idGood.SelectedValue = idgood.ToString();
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
        if (cSize.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填尺码！", false);
            return;
        }
        else if (cSize.Value.Trim().Length > 256)
        {
            AlertHelper.JQAlert("尺码超出限制！", false);
            return;
        }

        if (cColor.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填颜色！", false);
            return;
        }
        else if (cColor.Value.Trim().Length > 256)
        {
            AlertHelper.JQAlert("颜色超出限制！", false);
            return;
        }

        DBM1.tblReserve model = new DBM1.tblReserve();
        model.idGood = TypeChangeDefault.NullToInt(idGood.SelectedItem.Value, 0);
        DBM1.tblGoods good = new DB1.tblGoods().GetModel(model.idGood ?? 0);
        if (good != null)
            model.iType = good.iType;
        else
        {
            AlertHelper.JQAlertGo("该物品不存在", "GoodShopList.aspx", false);
            return;
        }
        //if (new DB1.tblReserve().SizeExists(id, TypeChangeDefault.NullToInt(idGood.SelectedItem.Value, 0), cSize.Value.Trim()))
        //{
        //    AlertHelper.JQAlert("尺码已存在！", false);
        //    return;
        //}
        //if (new DB1.tblReserve().ColorExists(id, TypeChangeDefault.NullToInt(idGood.SelectedItem.Value, 0),cColor.Value.Trim()))
        //{
        //    AlertHelper.JQAlert("颜色已存在！", false);
        //    return;
        //}      
        model.cName = idGood.SelectedItem.Text;
        model.cSize = cSize.Value.Trim();
        model.cColor = cColor.Value.Trim();
        model.iReserve = TypeChangeDefault.NullToInt(iTotal.Value.Trim(), 0);
        if (good.iEntity == 0)
        {
            int CodeCount = new DB5.tblCode().GetRecordCount("iValid=0");
            int ReserveCount = new DB1.tblReserve().GetReserveCount("idGood in(SELECT  [id]  FROM [YP_DB_1].[dbo].[tblGoods] where iEntity=0)");
            if (ReserveCount + model.iReserve > CodeCount)
            {
                AlertHelper.JQAlert("兑换码数量不足，请联系技术部", false);
                return;
            }
        }
        if (hdtt.HasFile)
        {
            string filename = hdtt.FileName;
            string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

            if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
            {
                string f_pre = DateTime.Now.ToString("HHmmssfff");
                string fileShort = "/" + CurrentUser.uId + "_" + f_pre + "." + type;
                string path = DateTime.Now.ToString("yyyy") + "/" + DateTime.Now.ToString("MM") + "/" + DateTime.Now.ToString("dd");
                HttpPostedFile file = hdtt.PostedFile;
                if (file.ContentLength > 1048576)
                {
                    AlertHelper.JQAlert("文件大小请不要超过1M！", false);
                    return;
                }
                if (UpPhotoSaveAs(file, path, fileShort))
                {
                    string URL = path + fileShort;
                    model.cImage = HostInfo.imgName + "/utility/uploads/" + URL;
                }
                else
                {
                    AlertHelper.JQAlert("上传失败，请重新上传！", false);
                    return;
                }
            }
            else
            {
                AlertHelper.JQAlert("上传错误，请按要求重新上传！", false);
                return;
            }
        }
        else
        {
            if (lbtt.Text.Length > 0)
            {
                model.cImage = lbtt.Text;
            }
        }
        model.idUser = CurrentUser.uId;
        model.dCreate = DateTime.Now;
        if (id != 0)
        {
            model.id = id;
            if (new DB1.tblReserve().Update(model))
            {
                AlertHelper.JQAlertGo("修改成功！", "ReserveTourList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            model.iTotal = 0;
            if (new DB1.tblReserve().Add(model) > 0)
            {
                AlertHelper.JQAlertGo("添加成功！", "ReserveTourList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }

        }
    }
    protected void BindGoods()
    {
        DataSet ds = new DB1.tblGoods().GetList(" iState>=0 and fReserve=1 and iType=2");
        idGood.DataSource = ds.Tables[0];
        idGood.DataTextField = "cName";
        idGood.DataValueField = "id";
        idGood.DataBind();
    }
    public bool UpPhotoSaveAs(HttpPostedFile uploadFile, string Path, string FileName)
    {
        HttpPostedFile face = uploadFile;
        //FileSaveAs picWebService = new FileSaveAs();

        SaveFile.FileSaveAsSoapClient picWebService = new SaveFile.FileSaveAsSoapClient();
        int upPhotoLength = face.ContentLength;
        byte[] PhotoArray = new Byte[upPhotoLength];
        Stream PhotoStream = face.InputStream;
        PhotoStream.Read(PhotoArray, 0, upPhotoLength);
        bool flag = picWebService.UploadFile(PhotoArray, Path, FileName);
        face.InputStream.Close();
        return flag;
    }
}