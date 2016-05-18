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
using System.Web;
using System.IO;
using System.Text;
using System.Drawing;
using System.Drawing.Imaging;

public partial class infocenter_PostEvent : PageBase
{
    private int uId = 0;
    public int bId = 0;
    public string iCity = string.Empty;
    public string iArea = string.Empty;
    public StringBuilder tempModel = new StringBuilder();
    public string sstt = string.Empty;
    public string sstt1 = string.Empty;
    public string jdtt = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title ="发布赛事-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";


        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if ((CurrentUser.uId != 100001183 && CurrentUser.uId != 100055041) && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        if ((CurrentUser.uId != 100001183 && CurrentUser.uId != 100055041) && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        if (Request.QueryString["sid"] != null)
        {
            bId = int.Parse(Request.QueryString["sid"].ToString());
        }
        uId = TypeChangeDefault.NullToInt(Request.QueryString["uId"], 0);
        if (!IsPostBack)
        {
            if (CurrentUser != null)
            {
                string str5 = string.Empty;
                string str6 = string.Empty;
                string str7 = string.Empty;
                string str8 = string.Empty;
                string str9 = string.Empty;
                if (0 != bId)
                {
                    DBM6.tblRace_Competition mCompetetion = new DB6.tblRace_Competition().GetModel(bId);
                    string str = string.Empty;
                    string str1 = string.Empty;
                    string str2 = string.Empty;
                    string str3 = string.Empty;
                    string str4 = string.Empty;

                    switch (mCompetetion.cBanner)
                    {
                        case "../Images/toutu/tu1.jpg":
                            str = "checked";
                            str5 = "class=\"this\"";
                            sstt = "../Images/toutu/tu1.jpg";
                            break;
                        case "../Images/toutu/tu2.jpg":
                            str1 = "checked";
                            str6 = "class=\"this\"";
                            sstt = "../Images/toutu/tu2.jpg";
                            break;
                        case "../Images/toutu/tu3.jpg":
                            str2 = "checked";
                            str7 = "class=\"this\"";
                            sstt = "../Images/toutu/tu3.jpg";
                            break;
                        case "../Images/toutu/tu4.jpg":
                            str3 = "checked";
                            str8 = "class=\"this\"";
                            sstt = "../Images/toutu/tu4.jpg";
                            break;
                        case "../Images/toutu/tu5.jpg":
                            str4 = "checked";
                            str9 = "class=\"this\"";
                            sstt = "../Images/toutu/tu5.jpg";
                            break;
                        default:
                            if (mCompetetion.cBanner == string.Empty)
                            {
                                str = "checked";
                                str5 = "class=\"this\"";
                                sstt = "../Images/toutu/tu1.jpg";

                            }
                            else
                            {
                                str = "checked";
                                str5 = "class=\"this\"";
                                sstt = mCompetetion.cBanner;
                            }
                            break;
                    }
                    tempModel.AppendLine("<label " + str5 + "><img id=\"v1\" src=\"/Images/toutu/tu1.jpg\" /><input value=\"/Images/toutu/tu1.jpg\" name=\"temp\" id=\"temp1\" type=\"radio\" " + str + "/></label><label " + str6 + "><img src=\"/Images/toutu/tu2.jpg\" /><input value=\"/Images/toutu/tu2.jpg\"  " + str1 + " name=\"temp\" id=\"temp2\" type=\"radio\"/></label><label " + str7 + "><img src=\"/Images/toutu/tu3.jpg\" /><input value=\"/Images/toutu/tu3.jpg\" name=\"temp\" id=\"temp3\" type=\"radio\" " + str2 + "/></label><label " + str8 + "><img src=\"/Images/toutu/tu4.jpg\" /><input value=\"/Images/toutu/tu4.jpg\" name=\"temp\" id=\"temp4\" type=\"radio\" " + str3 + " /></label><label " + str9 + "><img src=\"/Images/toutu/tu5.jpg\" /><input value=\"/Images/toutu/tu5.jpg\" name=\"temp\" id=\"temp5\" type=\"radio\" " + str4 + "/></label>");
                    //DBM2.tblBLOG model = new DB2.tblBLOG().GetModel(bId);
                    if (mCompetetion != null)
                    {
                        uId = mCompetetion.idUser ?? 0;
                        title.Value = mCompetetion.cTitle;
                        iType.Value = mCompetetion.iType.ToString();
                        idCompeteStyle.Value = mCompetetion.idCompeteStyle.ToString();
                        if (mCompetetion.idCity.ToString().Length == 3)
                        {
                            iCity = mCompetetion.idCity.ToString().Substring(0, 1);
                            iArea = mCompetetion.idCity.ToString().Substring(1, 2);
                        }
                        else if (mCompetetion.idCity.ToString().Length == 4)
                        {
                            iCity = mCompetetion.idCity.ToString().Substring(0, 2);
                            iArea = mCompetetion.idCity.ToString().Substring(2, 2);
                        }
                        idCity.Value = mCompetetion.idCity.ToString();
                        cCityname.Value = mCompetetion.cCityname;
                        dRaceBegin.Value = Convert.ToDateTime(mCompetetion.dRaceBegin).ToString("yyyy-MM-dd HH:mm");
                        dRaceEnd.Value = Convert.ToDateTime(mCompetetion.dRaceEnd).ToString("yyyy-MM-dd HH:mm");
                        dJoinBegin.Value = Convert.ToDateTime(mCompetetion.dJoinBegin).ToString("yyyy-MM-dd HH:mm");
                        dJoinEnd.Value = Convert.ToDateTime(mCompetetion.dJoinEnd).ToString("yyyy-MM-dd HH:mm");
                        iStatus.Value = mCompetetion.iStatus.ToString();
                        cContentUEditor.Value = mCompetetion.cContent.Replace("[IMG]", "<img src=\"").Replace("[/IMG]", "\"/>");
                        lbtt.Text = mCompetetion.cBanner;
                        jdtdz.Text = mCompetetion.cPictures;
                        //radiotemp.Value = mCompetetion.cBanner;
                        //sstt.ImageUrl = mCompetetion.cBanner;                       
                        if (mCompetetion.cPictures != string.Empty)
                        {
                            jdtt = mCompetetion.cPictures;
                            jd.HRef = mCompetetion.cPictures;
                        }
                        else
                        {
                            jd.Visible = false;
                        }
                        //jdtdz.Text = mCompetetion.cPictures;
                    }
                    else
                    {
                        AlertHelper.JQAlertGo("该赛事不存在或者已删除,不能进行编辑", UrlHelper.MemberUrl(CurrentUser.uId), false);
                    }
                }
                else
                {
                    tempModel.AppendLine("<label class=\"this\"><img id=\"v1\" src=\"/Images/toutu/tu1.jpg\" /><input value=\"/Images/toutu/tu1.jpg\" name=\"temp\" id=\"temp1\" type=\"radio\" checked/></label><label for=\"temp2\"><img src=\"/Images/toutu/tu2.jpg\" /><input value=\"/Images/toutu/tu2.jpg\" name=\"temp\" id=\"temp2\" type=\"radio\"/></label><label for=\"temp3\"><img src=\"/Images/toutu/tu3.jpg\" /><input value=\"/Images/toutu/tu3.jpg\" name=\"temp\" id=\"temp3\" type=\"radio\"/></label><label for=\"temp4\"><img src=\"/Images/toutu/tu4.jpg\" /><input value=\"/Images/toutu/tu4.jpg\" name=\"temp\" id=\"temp4\" type=\"radio\" /></label><label for=\"temp5\"><img src=\"/Images/toutu/tu5.jpg\" /><input value=\"/Images/toutu/tu5.jpg\" name=\"temp\" id=\"temp5\" type=\"radio\"/></label>");
                    idCity.Value = "0";
                    cCityname.Value = "";
                    dRaceBegin.Value = string.Format("{0:yyyy-MM-dd HH:mm}", DateTime.Now);
                    dRaceEnd.Value = string.Format("{0:yyyy-MM-dd HH:mm}", DateTime.Now);
                    dJoinBegin.Value = string.Format("{0:yyyy-MM-dd HH:mm}", DateTime.Now);
                    dJoinEnd.Value = string.Format("{0:yyyy-MM-dd HH:mm}", DateTime.Now);
                    sstt = "../Images/toutu/tu1.jpg";
                    jd.Visible = false;
                }
            }
            if (CurrentUser.idMemberStyle != 99)
            {
                if (CurrentUser.uId != uId)
                {
                    AlertHelper.JQAlertGo("您不能编辑Ta的赛事", UrlHelper.MemberUrl(CurrentUser.uId), false);
                    return;
                }
            }
        }

    }
    //保存装备
    protected void imgbtCompetetion_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if ((CurrentUser.uId != 100001183 && CurrentUser.uId != 100055041) && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        if (iType.Value == "all")
        {
            AlertHelper.JQAlert("请选择国内/国外/港澳台！", false);
            return;
        }
        DBM6.tblRace_Competition mCompetetion = new DBM6.tblRace_Competition();
        if (this.title.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("赛事名称不能为空！", false);
            return;
        }
        else if (this.title.Value.Trim().Length > 60)
        {
            AlertHelper.JQAlert("赛事名称超过30个汉字的限制！", false);
            return;
        }
        
        if (idCity.Value.Trim() == "0")
        {
            AlertHelper.JQAlert("请选择所在城市！", false);
            return;
        }
        if (string.IsNullOrEmpty(cCityname.Value.Trim()))
        {
            AlertHelper.JQAlert("请选择所在城市！", false);
            return;
        }
        if (dRaceBegin.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择赛事开始时间！", false);
            return;
        }
        if (dRaceEnd.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择赛事结束时间！", false);
            return;
        }
        if (Convert.ToDateTime(dRaceBegin.Value.Trim()) > Convert.ToDateTime(dRaceEnd.Value.Trim()))
        {
            AlertHelper.JQAlert("赛事开始时间不能大于结束时间！", false);
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
        if (Convert.ToDateTime(dJoinBegin.Value.Trim()) > Convert.ToDateTime(dJoinEnd.Value.Trim()))
        {
            AlertHelper.JQAlert("开始报名时间不能大于结束报名时间！", false);
            return;
        }
        if (Int64.Parse(Convert.ToDateTime(dJoinEnd.Value.Trim()).ToString("yyyyMMdd")) > Int64.Parse(Convert.ToDateTime(dRaceBegin.Value.Trim()).ToString("yyyyMMdd")))
        {
            AlertHelper.JQAlert("报名结束时间不能大于赛事开始时间！", false);
            return;
        }
        //if (string.Compare(Convert.ToDateTime(dJoinEnd.Value.Trim()).ToShortDateString(), Convert.ToDateTime(dRaceBegin.Value.Trim()).ToShortDateString()) > 0)
        //{
        //    AlertHelper.JQAlert("报名结束时间不能大于赛事开始时间！", false);
        //    return;
        //}
        //if (Convert.ToDateTime(dJoinEnd.Value.Trim())> Convert.ToDateTime(dRaceBegin.Value.Trim()))
        //{
        //    AlertHelper.JQAlert("报名结束时间不能大于赛事开始时间！", false);
        //    return;
        //}
        if (this.cContentUEditor.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("赛事简介不能为空！", false);
            return;
        }

        int path = 0;
        if (bId == 0)
        {
            path = new DB6.tblRace_Competition().GetMaxId();
        }
        else
        {
            path = bId;
        }
        //头图
        if (hdtt.HasFile)
        {
            string filename = hdtt.FileName;
            string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

            if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
            {
                string f_pre = DateTime.Now.ToString("HHmmssfff");
                string fileShort = CurrentUser.uId + "_" + f_pre + "." + type;
                //string path = DateTime.Now.ToString("yyyy") + "/" + DateTime.Now.ToString("MM") + "/" + DateTime.Now.ToString("dd") + "/";
                // hdtt.PostedFile.FileName;
                HttpPostedFile file = hdtt.PostedFile;
                if (file.ContentLength > 1048576)
                {
                    AlertHelper.JQAlert("文件大小请不要超过1M！", false);
                    return;
                }
                if (UpPhotoSaveAs(file, GetDir(path.ToString()), fileShort))
                {
                    string URL = GetDir(path.ToString()) + "/" + fileShort;

                    mCompetetion.cBanner = HostInfo.imgName + "/utility/uploads/" + URL;
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
                mCompetetion.cPictures = lbtt.Text;
            }
            else
            {
                mCompetetion.cBanner = radiotemp.Value;
            }
        }
        //焦点图
        if (jdt.HasFile)
        {
            string filename = jdt.FileName;
            string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

            if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
            {
                string f_pre = DateTime.Now.ToString("HHmmssfff");

                string fileShort = path + "_" + f_pre + "." + type;


                HttpPostedFile file = jdt.PostedFile;
                if (file.ContentLength > 1048576)
                {
                    AlertHelper.JQAlert("文件大小请不要超过1M！", false);
                    return;
                }
                if (UpPhotoSaveAs(file, GetDir(path.ToString()), fileShort, "_300", true, 300, 300, "Cut"))
                {
                    string URL = GetDir(path.ToString()) + "/" + fileShort;
                    mCompetetion.cPictures = HostInfo.imgName + "/utility/uploads/" + URL;
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
            if (jdtdz.Text.Length > 0)
            {
                mCompetetion.cPictures = jdtdz.Text;
            }
        }
        DBM6.tblRace_Competition mComp = new DB6.tblRace_Competition().GetModel(bId);
        mCompetetion.cTitle = this.title.Value.Trim().ToString();
        mCompetetion.idCompeteStyle = Convert.ToInt32(idCompeteStyle.Value);//赛事类型
        mCompetetion.dRaceBegin = Convert.ToDateTime(dRaceBegin.Value);//赛事开始时间
        mCompetetion.dRaceEnd = Convert.ToDateTime(dRaceEnd.Value);//赛事结束时间
        mCompetetion.dJoinBegin = Convert.ToDateTime(dJoinBegin.Value);//开始报名时间
        mCompetetion.dJoinEnd = Convert.ToDateTime(dJoinEnd.Value);//结束报名时间
        mCompetetion.cContent = cContentUEditor.Value.Trim();//赛事介绍
        mCompetetion.iType = TypeChangeDefault.NullToInt(iType.Value, 0);

        if (mComp == null)
        {
            mCompetetion.dCreate = DateTime.Now;//创建时间
        }
        else if (mComp.dCreate.ToString() == null)
        {
            mCompetetion.dCreate = DateTime.Now;//创建时间
        }
        mCompetetion.iStatus = Convert.ToInt32(iStatus.Value); ;//状态-1已删除，0草稿，1已发布
        mCompetetion.cCityname = XString.SqlSafe(TypeChangeDefault.NullToString(cCityname.Value.Trim(), ""));
        mCompetetion.idCity = TypeChangeDefault.NullToInt(idCity.Value, 0);
        mCompetetion.dSubmitCreate = DateTime.Now;
        mCompetetion.idUser = CurrentUser.uId;
        string result = string.Empty;

        if (bId == 0)
        {
            int i = new DB6.tblRace_Competition().Add(mCompetetion);
            //插入积分
            DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
            uMember_History.Insert(CurrentUser.uId, 100800119, 1);
            if (i == 0)
            {
                if (Convert.ToInt32(iStatus.Value) == 0)
                {

                    AlertHelper.JQAlertGo("草稿保存失败", "", false);
                    return;
                }
                else
                {
                    AlertHelper.JQAlertGo("发布失败", "", false);
                    return;
                }

            }
            else
            {
                DataSet idcom = new DB6.tblRace_Competition().GetList(1, "iStatus>0", "id desc");
                if (Convert.ToInt32(iStatus.Value) == 1)
                {

                    AlertHelper.JQAlertGo("发布成功", "/Competetion/EventDetails.aspx?sid=" + idcom.Tables[0].Rows[0]["id"] + "&nav=1", true);
                    Erun360.Common.DataCache.RemoveAllCache("SeachQr");
                }
                else
                {
                    AlertHelper.JQAlertGo("草稿保存成功", "/infocenter/Competition.aspx?uId=" + CurrentUser.uId + "", true);
                    Erun360.Common.DataCache.RemoveAllCache("SeachQr");
                }
            }
        }
        else
        {
            mCompetetion.id = bId;
            bool i = new DB6.tblRace_Competition().Update(mCompetetion);
            if (!i)
            {
                if (Convert.ToInt32(iStatus.Value) == 0)
                {

                    AlertHelper.JQAlertGo("草稿保存失败", "", false);
                    return;
                }
                else
                {
                    AlertHelper.JQAlertGo("发布失败", "", false);
                    return;
                }
            }
            else
            {
                if (Convert.ToInt32(iStatus.Value) == 1)
                {
                    AlertHelper.JQAlertGo("发布成功", "/Competetion/EventDetails.aspx?sid=" + bId + "&nav=1", true);
                    Erun360.Common.DataCache.RemoveAllCache("SeachQr");
                }
                else
                {
                    AlertHelper.JQAlertGo("草稿保存成功", "/infocenter/Competition.aspx?uId=" + CurrentUser.uId + "", true);
                    Erun360.Common.DataCache.RemoveAllCache("SeachQr");
                }
            }
        }
        //DB3.tblIMAGES imgBll = new DB3.tblIMAGES();
        //DBM3.tblIMAGES imgModel = new DBM3.tblIMAGES();
        ////删除原来博客图片
        //imgBll.DeleteByIdBlog(bId);
        //BlogInfo ucBlog = new BlogInfo();
        ////插入图片
        //string thumbnail = string.Empty;//缩略图

        //string[] ImgList = ucBlog.GetHtmlImageUrlList(mCompetetion.cContent);
        //if (ImgList.Length > 0)
        //{
        //    thumbnail = ImgList[0];
        //    for (int i = 0; i < ImgList.Length; i++)
        //    {
        //        imgModel.idUser = CurrentUser.uId;
        //        imgModel.idInfo = bId;
        //        imgModel.cImageUrl = ImgList[i];
        //        imgModel.cThumbUrl = ImgList[i];
        //        imgModel.dCreate = DateTime.Now;
        //        imgBll.Add(imgModel);
        //    }
        //}

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

    #region 等比缩放

    /// <summary>
    /// 图片等比缩放
    /// </summary>
    /// <remarks>吴剑 2012-08-08</remarks>
    /// <param name="fromFile">原图Stream对象</param>
    /// <param name="savePath">缩略图存放地址</param>
    /// <param name="targetWidth">指定的最大宽度</param>
    /// <param name="targetHeight">指定的最大高度</param>
    /// <param name="watermarkText">水印文字(为""表示不使用水印)</param>
    /// <param name="watermarkImage">水印图片路径(为""表示不使用水印)</param>
    public static void ZoomAuto(string fromFile, string savePath, System.Double targetWidth, System.Double targetHeight, string watermarkText, string watermarkImage)
    {
        //创建目录


        //原始图片（获取原始图片创建对象，并使用流中嵌入的颜色管理信息）
        System.Drawing.Image initImage = System.Drawing.Image.FromFile(fromFile);

        //原图宽高均小于模版，不作处理，直接保存
        if (initImage.Width <= targetWidth && initImage.Height <= targetHeight)
        {


            //保存
            initImage.Save(savePath, System.Drawing.Imaging.ImageFormat.Jpeg);
        }
        else
        {
            //缩略图宽、高计算
            double newWidth = initImage.Width;
            double newHeight = initImage.Height;

            //宽大于高或宽等于高（横图或正方）
            if (initImage.Width < initImage.Height || initImage.Width == initImage.Height)
            {
                //如果宽大于模版
                if (initImage.Width > targetWidth)
                {
                    //宽按模版，高按比例缩放
                    newWidth = targetWidth;
                    newHeight = initImage.Height * (targetWidth / initImage.Width);
                }
            }
            //高大于宽（竖图）
            else
            {
                //如果高大于模版
                if (initImage.Height > targetHeight)
                {
                    //高按模版，宽按比例缩放
                    newHeight = targetHeight;
                    newWidth = initImage.Width * (targetHeight / initImage.Height);
                }
            }

            //生成新图
            //新建一个bmp图片
            System.Drawing.Image newImage = new System.Drawing.Bitmap((int)newWidth, (int)newHeight);
            //新建一个画板
            System.Drawing.Graphics newG = System.Drawing.Graphics.FromImage(newImage);

            //设置质量
            newG.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            newG.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;

            //置背景色
            newG.Clear(Color.White);
            //画图
            newG.DrawImage(initImage, new System.Drawing.Rectangle(0, 0, newImage.Width, newImage.Height), new System.Drawing.Rectangle(0, 0, initImage.Width, initImage.Height), System.Drawing.GraphicsUnit.Pixel);

            //文字水印


            //保存缩略图
            newImage.Save(savePath, System.Drawing.Imaging.ImageFormat.Jpeg);

            //释放资源
            newG.Dispose();
            newImage.Dispose();
            initImage.Dispose();
        }
    }

    #endregion

    #region   截取图象

    ///   <summary>   
    ///   从图片中截取部分生成新图   
    ///   </summary>   
    ///   <param   name= "sFromFilePath "> 原始图片 </param>   
    ///   <param   name= "saveFilePath "> 生成新图 </param>   
    ///   <param   name= "width "> 截取图片宽度 </param>   
    ///   <param   name= "height "> 截取图片高度 </param>   
    ///   <param   name= "spaceX "> 截图图片X坐标 </param>   
    ///   <param   name= "spaceY "> 截取图片Y坐标 </param>   
    public static void CaptureImage(string sFromFilePath, string saveFilePath, int width, int height, int spaceX, int spaceY)
    {
        //获取原始图片  
        //System.Drawing.Image fromImage = System.Drawing.Image.FromFile(sFromFilePath);
        //载入底图   
        Image fromImage = Image.FromFile(sFromFilePath);
        int x = 0;   //截取X坐标   
        int y = 0;   //截取Y坐标   
        //原图宽与生成图片宽   之差       
        //当小于0(即原图宽小于要生成的图)时，新图宽度为较小者   即原图宽度   X坐标则为0     
        //当大于0(即原图宽大于要生成的图)时，新图宽度为设置值   即width         X坐标则为   sX与spaceX之间较小者   
        //Y方向同理   
        int sX = fromImage.Width - width;
        int sY = fromImage.Height - height;
        if (sX > 0)
        {
            x = sX > spaceX ? spaceX : sX;
        }
        else
        {
            width = fromImage.Width;
        }
        if (sY > 0)
        {
            y = sY > spaceY ? spaceY : sY;
        }
        else
        {
            height = fromImage.Height;
        }

        //创建新图位图   
        Bitmap bitmap = new Bitmap(width, height);
        //创建作图区域   
        Graphics graphic = Graphics.FromImage(bitmap);
        //截取原图相应区域写入作图区   
        graphic.DrawImage(fromImage, 0, 0, new Rectangle(x, y, width, height), GraphicsUnit.Pixel);
        //从作图区生成新图   
        Image saveImage = Image.FromHbitmap(bitmap.GetHbitmap());
        //保存图象   
        saveImage.Save(saveFilePath, ImageFormat.Jpeg);
        //释放资源   
        saveImage.Dispose();
        bitmap.Dispose();
        graphic.Dispose();
    }
    #endregion




    /// <summary>
    /// 图片上传并生成自定义大小缩略图
    /// </summary>
    /// <param name="uploadFile">上传文件控件</param>
    /// <param name="Path">文件相对存储路径（哈希路径：/AF/17/）</param>
    /// <param name="FileName">上传文件名称（10000.jpg）</param>
    /// <param name="thumName">缩略图尺寸（也是缩略图名称10000_300.jpg）</param>
    /// <param name="Thumbnail">是否生成缩略图</param>
    /// <param name="width">缩略图宽度</param>
    /// <param name="height">缩略图高度</param>
    /// <param name="mode">按什么方式截取</param> 
    /// <returns></returns>
    private bool UpPhotoSaveAs(HttpPostedFile uploadFile, string Path, string FileName, string thumName, bool Thumbnail = false, int width = 0, int height = 0, string mode = "Cut")
    {
        HttpPostedFile face = uploadFile;
        //FileSaveAs picWebService = new FileSaveAs();

        SaveFile.FileSaveAsSoapClient picWebService = new SaveFile.FileSaveAsSoapClient();
        int upPhotoLength = face.ContentLength;
        byte[] PhotoArray = new Byte[upPhotoLength];
        Stream PhotoStream = face.InputStream;
        PhotoStream.Read(PhotoArray, 0, upPhotoLength);
        bool flag = picWebService.UploadFileAndThumbnail(PhotoArray, Path, FileName, thumName, Thumbnail, width, height, mode);
        //bool flag = picWebService.UploadFileAndThumbnail(PhotoArray, Path, FileName, "_300", true, 300, 300, "Cut");
        face.InputStream.Close();
        return flag;
    }
}

