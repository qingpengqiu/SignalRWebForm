﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;

public partial class Admin_GoodEdit :PageBase
{
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
            if (id != 0)
            {
                
                DBM1.tblGoods model = new DB1.tblGoods().GetModel(id);
                if (model != null)
                {
                    itpye.Value = model.iType.ToString();
                    cname.Value = model.cName;
                    rdoEntry.SelectedValue = model.iEntity.ToString();
                    dbegintime.Value = TypeChangeDefault.NullToDateTime(model.dBeginTime, DateTime.Now).ToString("yyyy-MM-dd HH:mm");
                    dendtime.Value = TypeChangeDefault.NullToDateTime(model.dEndTime, DateTime.Now).ToString("yyyy-MM-dd HH:mm");
                    fMarketPrice.Value = model.fMarketPrice.ToString();                   
                    iScore.Value = model.iScore.ToString();                                  
                    fSellPrice.Value = model.fSellPrice.ToString();   
                    lbtt.Text = model.cImage;
                    cLink.Value = model.cLink;
                    cBio.Value = model.cBio;
                    cNorm.Value = model.cNorm;
                    iTotal.Value = model.iTotal.ToString();
                    state.Value = model.iState.ToString();
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
        if (cname.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填商品名称！", false);
            return;
        }
        else if (cname.Value.Trim().Length > 256)
        {
            AlertHelper.JQAlert("商品名称超出限制！", false);
            return;
        }
        if (new DB1.tblGoods().Exists(id, cname.Value.Trim()))
        {
            AlertHelper.JQAlert("商品名称已存在！", false);
            return;
        }       
        DBM1.tblGoods model = new DBM1.tblGoods();
        model.iType = TypeChangeDefault.NullToInt(itpye.Value.Trim(), 0);
        model.cName = cname.Value.Trim();
        model.iEntity = TypeChangeDefault.NullToInt(rdoEntry.SelectedValue, 0);
        model.dBeginTime = TypeChangeDefault.NullToDateTime(dbegintime.Value.Trim(), DateTime.Now);
        model.dEndTime = TypeChangeDefault.NullToDateTime(dendtime.Value.Trim(), DateTime.Now);
        model.fMarketPrice = TypeChangeDefault.NullToDecimal(fMarketPrice.Value.Trim(),0);        
        model.iScore=TypeChangeDefault.NullToInt(iScore.Value.Trim(),0);        
        model.fSellPrice = TypeChangeDefault.NullToDecimal(fSellPrice.Value.Trim(), 0);
        model.iTotal = TypeChangeDefault.NullToInt(iTotal.Value.Trim(), 0);//排序
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
                    string URL =path + fileShort;
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
            //else
            //    model.cImage = @"/Html/images/ypimg.png";
        }

        model.cLink = cLink.Value.Trim();
        model.cBio = cBio.Value.Trim();
        model.cNorm = cNorm.Value.Trim();
        model.iState = TypeChangeDefault.NullToInt(state.Value.Trim(), 0);

        model.idUser = CurrentUser.uId;
        model.dCreate = DateTime.Now;
        
        if (id != 0)
        {            
            model.id = id;
            if (new DB1.tblGoods().Update(model))
            {
                AlertHelper.JQAlertGo("修改成功！", "GoodList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            model.iBuyNum = 0;
            model.iReserve = 0;            
            model.fReserve = 1;
            model.idTour = 0;//是否拼团
            model.fScore = 1;
            model.iMoney = 0;
            model.iQuantity = 0;
            if (new DB1.tblGoods().Add(model) > 0)
            {
                AlertHelper.JQAlertGo("添加成功！", "GoodList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }

        }
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