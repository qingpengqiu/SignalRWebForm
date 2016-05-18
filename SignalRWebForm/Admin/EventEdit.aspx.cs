using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;

public partial class Admin_EventEdit : PageBase
{
    public int id = 0;
    public int idRace = 0;//赛事id
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
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["idRace"], 0);
        if (!IsPostBack)
        {
            BindDDL();
            if (id != 0)
            {
                DBM4.tblEvent model = new DB4.tblEvent().GetModel(id);
                if (model != null)
                {
                    if (model.idRace == 0)
                    {
                        iserun.SelectedValue = "0";
                        txtrun.Visible = true;
                        dllrun.Visible = false;
                        cname.Value = model.idRaceTitle;
                    }
                    else
                    {
                        iserun.SelectedValue = "1";
                        dllrun.Visible = true;
                        txtrun.Visible = false;
                        if (idRace > 0)
                        {
                            DDLRace.Value = idRace.ToString();
                        }
                        else
                        {
                            DDLRace.Value = model.idRace.ToString();
                            //DDLRace.Items.FindByValue(model.idRace.ToString()).Selected = true;
                        }
                        //DDLRace.Enabled = false;
                        iserun.Enabled = false;
                    }
                    rdoEntry.SelectedValue = model.istyle.ToString();
                    lbtt.Text = model.cImage;
                    idoc.SelectedValue = model.iDoc.ToString();
                    lbmb.Text = model.cModel;
                    iStatus.Value = model.iStatus.ToString();
                    iserun.Enabled = false;
                    txtMark.Text = model.cMark;
                }
            }
            else
            {
                DDLRace.Value = idRace.ToString();
                dllrun.Visible = true;
                txtrun.Visible = false;
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

        if (CurrentUser.uId != 100001183 && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (idRace == 0)
        {
            idRace = TypeChangeDefault.NullToInt(DDLRace.Value, 0); 
        }
        DBM4.tblEvent model = new DBM4.tblEvent();
        if (iserun.SelectedValue == "1")
        {
            DBM6.tblRace_Competition mRace = new DB6.tblRace_Competition().GetModel(idRace);
            if (mRace != null)
            {
                model.idRace = idRace;
                model.idRaceTitle = mRace.cTitle;
            }
            else
            {
                model.idRace = idRace;
                model.idRaceTitle = DDLRace.Value;
            }
        }
        else
        {
            if (cname.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert("请填赛事名称！", false);
                return;
            }
            model.idRace = 0;
            model.idRaceTitle = cname.Value.Trim();
        }
        model.istyle = TypeChangeDefault.NullToInt(rdoEntry.SelectedValue, 1);
        string FileDir = "/zs/zsImg/";
        CreateDirectory(Server.MapPath(FileDir));
        if (hdtt.HasFile)
        {
            string filename = hdtt.FileName;
            string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

            if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
            {
                string Rename = DateTime.Now.ToString("yyyyMMddHHmmss") + "." + type;

                hdtt.PostedFile.SaveAs(Server.MapPath(FileDir + Rename));
                model.cImage = FileDir + Rename;
            }
            else
            {
                AlertHelper.JQAlert("头图上传错误，请按要求重新上传！", false);
                return;
            }
        }
        else
        {
            if (lbtt.Text.Length > 0)
            {
                model.cImage = lbtt.Text;
            }
            else
                model.cImage = "";
        }
        model.iDoc = TypeChangeDefault.NullToInt(idoc.SelectedValue, 0);
        if (zsmb.HasFile)
        {
            string filename = zsmb.FileName;
            string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

            if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
            {
                string Rename = DateTime.Now.ToString("yyyyMMddHHmmssffffff") + "." + type;
                zsmb.PostedFile.SaveAs(Server.MapPath(FileDir + Rename));
                model.cModel = FileDir + Rename;
            }
            else
            {
                AlertHelper.JQAlert("上传错误，请按要求重新上传！", false);
                return;
            }
        }
        else
        {
            if (lbmb.Text.Length > 0)
            {
                model.cModel = lbmb.Text;
            }
            else
                model.cModel = "";
        }
        model.cMark = txtMark.Text.Trim();
        model.iStatus = TypeChangeDefault.NullToInt(iStatus.Value.Trim(), -1);
        model.idUser = CurrentUser.uId;
        model.dCreate = DateTime.Now;
        if (id != 0)
        {
            model.id = id;
            if (new DB4.tblEvent().Update(model))
            {
                //new DB4.tblEventTotal().UpdateRace(model.idRace ?? 0, model.idRaceTitle, id);
                AlertHelper.JQAlertGo("修改成功！", "Event.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            if (new DB4.tblEvent().Add(model) > 0)
            {
                AlertHelper.JQAlertGo("添加成功！", "Event.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }

        }
    }
    protected void BindDDL()
    {
        //DataSet ds = new DB4.tblRACE_COMPETETION().GetSignupcompete();
        DataSet ds = new DB6.tblRace_Competition().GetList(0, "iStatus=1", "id desc");
        DDLRace.DataSource = ds;
        DDLRace.DataTextField = "cTitle";
        DDLRace.DataValueField = "id";
        DDLRace.DataBind();
    }
    protected void iserun_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (id != 0)
        //{
        //    iserun.Enabled = false;
        //}
        if (iserun.SelectedValue == "1")
        {
            dllrun.Visible = true;
            txtrun.Visible = false;
            
        }
        else
        {
            txtrun.Visible = true;
            dllrun.Visible = false;
        }
    }
    public bool UpPhotoSaveAs(HttpPostedFile uploadFile, string Path, string FileName)
    {
        HttpPostedFile face = uploadFile;
        SaveFile.FileSaveAsSoapClient picWebService = new SaveFile.FileSaveAsSoapClient();
        int upPhotoLength = face.ContentLength;
        byte[] PhotoArray = new Byte[upPhotoLength];
        Stream PhotoStream = face.InputStream;
        PhotoStream.Read(PhotoArray, 0, upPhotoLength);
        bool flag = picWebService.UploadFile(PhotoArray, Path, FileName);
        face.InputStream.Close();
        return flag;
    }
    /// <summary>  
    /// 创建指定目录  
    /// </summary>  
    /// <param name="targetDir"></param>  
    public static void CreateDirectory(string targetDir)
    {
        DirectoryInfo dir = new DirectoryInfo(targetDir);
        if (!dir.Exists)
            dir.Create();
    }
}