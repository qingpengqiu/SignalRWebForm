using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
public partial class Admin_ShoesEdit : PageBase
{
    private int id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.idMemberStyle < 13 && CurrentUser.uId != 100002818)
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
                DBM5.tblShoes mShoe = new DB5.tblShoes().GetModel(id);
                if (mShoe != null)
                {
                    mc.Value = mShoe.cName;
                    xb.SelectedValue = mShoe.idGender.ToString();
                    pp.Value = mShoe.cBrand;
                    xl.Value = mShoe.cSeries;
                    sj.Value = mShoe.fPrice.ToString();
                    ShoeType.Value = mShoe.cType;
                    td.Value = mShoe.cfeature;
                    zl.Value = mShoe.fWeight.ToString();
                    hgg.Value = mShoe.fHeel.ToString();
                    qgg.Value = mShoe.fForefeet.ToString();
                    fileurl.Text = mShoe.cImage;
                    tbry.Value = mShoe.cHonour;
                    yd.Value = mShoe.cSum;
                    dp.Value = mShoe.cReview;
                    pc.Value = mShoe.cTester;
                    sssj.Value = mShoe.dTimetm.ToString();
                    splj.Value = mShoe.cVideo;
                    vzl.Value = mShoe.rWeight.ToString();
                    vgd.Value = mShoe.rHeight.ToString();

                    vhgjz.Value = mShoe.rHeel.ToString();
                    vqjzjz.Value = mShoe.rForefeet.ToString();
                    vyd.Value = mShoe.rStiffness.ToString();
                    vwdx.Value = mShoe.rStability.ToString();
                }
            }
        }
    }
    protected void Btnsubmit_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.idMemberStyle < 13 && CurrentUser.uId != 100002818)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        DBM5.tblShoes mShoe = new DBM5.tblShoes();
        if (mc.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写名称！", false);
            return;
        }
        else if (mc.Value.Trim().Length > 128)
        {
            AlertHelper.JQAlert("名称超过128个汉字的限制！", false);
            return;
        }
        mShoe.cName = mc.Value.Trim();
        mShoe.idGender = TypeChangeDefault.NullToInt(xb.SelectedValue, 0);
        //if (pp.Value.Trim().Length <= 0)
        //{
        //    AlertHelper.JQAlert("请填写品牌！", false);
        //    return;
        //}
        //else if (pp.Value.Trim().Length > 64)
        //{
        //    AlertHelper.JQAlert("品牌超过64个汉字的限制！", false);
        //    return;
        //}
        mShoe.cBrand = pp.Value.Trim();
        //if (pp.Value.Trim().Length <= 0)
        //{
        //    AlertHelper.JQAlert("请填写系列！", false);
        //    return;
        //}
        //else if (pp.Value.Trim().Length > 64)
        //{
        //    AlertHelper.JQAlert("系列超过64个汉字的限制！", false);
        //    return;
        //}
        mShoe.cSeries = xl.Value.Trim();
        mShoe.fPrice = decimal.Parse(sj.Value.Trim());
        //if (lx.Value.Trim().Length <= 0)
        //{
        //    AlertHelper.JQAlert("请填写系列！", false);
        //    return;
        //}
        //else if (lx.Value.Trim().Length > 64)
        //{
        //    AlertHelper.JQAlert("系列超过64个汉字的限制！", false);
        //    return;
        //}
        mShoe.cType = ShoeType.Value.Trim();
        //if (td.Value.Trim().Length <= 0)
        //{
        //    AlertHelper.JQAlert("请填写特点！", false);
        //    return;
        //}
        //else if (td.Value.Trim().Length > 64)
        //{
        //    AlertHelper.JQAlert("特点超过64个汉字的限制！", false);
        //    return;
        //}
        mShoe.cfeature = td.Value.Trim();
        mShoe.fWeight = decimal.Parse(zl.Value.Trim());

        mShoe.fHeel = decimal.Parse(hgg.Value.Trim());
        mShoe.fForefeet = decimal.Parse(qgg.Value.Trim());
        //if (ttlj.Value.Trim().Length <= 0)
        //{
        //    AlertHelper.JQAlert("请填写图片链接！", false);
        //    return;
        //}
        //else if (ttlj.Value.Trim().Length > 256)
        //{
        //    AlertHelper.JQAlert("图片链接超过256个字符的限制！", false);
        //    return;
        //}
        if (FileUpload1.HasFile)
        {
            string filename = FileUpload1.FileName;
            string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

            if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
            {
                HttpPostedFile file = FileUpload1.PostedFile;
                if (file.ContentLength > 51200000)
                {
                    AlertHelper.JQAlert("文件大小请不要超过5M！", false);
                    return;
                }
                if (UpPhotoSaveAs(file, "", filename))
                {
                    mShoe.cImage = HostInfo.imgName + "/shoe/" + filename;
                }
                else
                {
                    AlertHelper.JQAlert("上传失败，请重新上传！", false);
                    return;
                }
            }
            else
            {
                AlertHelper.JQAlert("上传格式错误，请按要求重新上传！", false);
                return;
            }
        }
        //if (tbry.Value.Trim().Length <= 0)
        //{
        //    AlertHelper.JQAlert("请填写特别荣誉！", false);
        //    return;
        //}
        //else if (tbry.Value.Trim().Length > 64)
        //{
        //    AlertHelper.JQAlert("特别荣誉超过64个字符的限制！", false);
        //    return;
        //}
        mShoe.cHonour = tbry.Value.Trim();
        //if (yd.Value.Trim().Length <= 0)
        //{
        //    AlertHelper.JQAlert("请填写要点！", false);
        //    return;
        //}
        //else if (yd.Value.Trim().Length > 128)
        //{
        //    AlertHelper.JQAlert("要点超过128个汉字的限制！", false);
        //    return;
        //}
        mShoe.cSum = yd.Value.Trim();
        //if (dp.Value.Trim().Length <= 0)
        //{
        //    AlertHelper.JQAlert("请填写点评！", false);
        //    return;
        //}
        //else if (dp.Value.Trim().Length > 1000)
        //{
        //    AlertHelper.JQAlert("点评超过1000个汉字的限制！", false);
        //    return;
        //}
        mShoe.cReview = dp.Value.Trim();
        //if (pc.Value.Trim().Length <= 0)
        //{
        //    AlertHelper.JQAlert("请填写评测！", false);
        //    return;
        //}
        //else if (pc.Value.Trim().Length > 1000)
        //{
        //    AlertHelper.JQAlert("评测超过1000个汉字的限制！", false);
        //    return;
        //}
        mShoe.cTester = pc.Value.Trim();
        mShoe.dTimetm = sssj.Value;
        //if (splj.Value.Trim().Length <= 0)
        //{
        //    AlertHelper.JQAlert("请填写视频链接！", false);
        //    return;
        //}
        //else if (splj.Value.Trim().Length > 256)
        //{
        //    AlertHelper.JQAlert("视频链接超过256个汉字的限制！", false);
        //    return;
        //}
        mShoe.cVideo = splj.Value.Trim();
        mShoe.rWeight = TypeChangeDefault.NullToInt(vzl.Value.Trim(), 0);
        mShoe.rHeight = TypeChangeDefault.NullToInt(vgd.Value.Trim(), 0);
        mShoe.rHeel = TypeChangeDefault.NullToInt(vhgjz.Value.Trim(), 0);
        mShoe.rForefeet = TypeChangeDefault.NullToInt(vqjzjz.Value.Trim(), 0);
        mShoe.rStiffness = TypeChangeDefault.NullToInt(vyd.Value.Trim(), 0);
        mShoe.rStability = TypeChangeDefault.NullToInt(vwdx.Value.Trim(), 0);
        if (id != 0)
        {
            mShoe.id = id;
            mShoe.dCreate = DateTime.Now;
            if (new DB5.tblShoes().Update(mShoe))
            {
                AlertHelper.JQAlertGo("修改成功！", "ShoesList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            if (new DB5.tblShoes().Add(mShoe) > 0)
            {
                AlertHelper.JQAlertGo("添加成功！", "ShoesList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }
        }
    }
    private bool UpPhotoSaveAs(HttpPostedFile uploadFile, string Path, string FileName)
    {
        HttpPostedFile face = uploadFile;
        //FileSaveAs picWebService = new FileSaveAs();

        SaveFile.FileSaveAsSoapClient picWebService = new SaveFile.FileSaveAsSoapClient();
        int upPhotoLength = face.ContentLength;
        byte[] PhotoArray = new Byte[upPhotoLength];
        Stream PhotoStream = face.InputStream;
        PhotoStream.Read(PhotoArray, 0, upPhotoLength);
        bool flag = picWebService.UploadShoe(PhotoArray, Path, FileName);
        face.InputStream.Close();
        return flag;
    }
}