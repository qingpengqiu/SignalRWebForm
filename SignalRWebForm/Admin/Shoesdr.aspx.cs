using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
public partial class Admin_Shoesdr : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.idMemberStyle < 13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //获取文件路径  

        InputExcel(@"D:\tt.xls");
        //string filePath = FileUpload1.FileName;// this.FileUpload1.PostedFile.FileName;
        string filePath = this.FileUpload1.PostedFile.FileName;
        if (filePath != "")
        {
            if (filePath.Contains("xls"))//判断文件是否存在  
            {
                InputExcel(filePath);
            }
            else
            {
                Response.Write("请检查您选择的文件是否为Excel文件！谢谢！");
            }
        }

        else
        {
            Response.Write("请先选择导入文件后，再执行导入！谢谢！");
        }
    }

    private void InputExcel(string pPath)
    {
        //string conn = "Provider = Microsoft.Jet.OLEDB.4.0 ; Data Source =" + pPath + ";Extended Properties='Excel 8.0;HDR=False;IMEX=1'";
        //string conn = "Provider=Microsoft.Ace.OleDb.12.0;Data Source=" + pPath + ";Extended Properties='Excel 12.0; HDR=Yes; IMEX=1'";
        string conn = "Provider = Microsoft.Jet.OLEDB.4.0 ; Data Source =" + pPath + ";Extended Properties='Excel 8.0;HDR=Yes;IMEX=1'";
        OleDbConnection oleCon = new OleDbConnection(conn);
        oleCon.Open();
        string Sql = "select * from [Sheet1$]";
        OleDbDataAdapter mycommand = new OleDbDataAdapter(Sql, oleCon);
        DataSet ds = new DataSet();
        mycommand.Fill(ds, "[Sheet1$]");
        oleCon.Close();
        int count = ds.Tables["[Sheet1$]"].Rows.Count;
        for (int i = 0; i < count; i++)
        {
            DBM5.tblShoes mShoe = new DBM5.tblShoes();
            mShoe.cName = ds.Tables["[Sheet1$]"].Rows[i]["名称"].ToString().Trim();
            mShoe.idGender = int.Parse(ds.Tables["[Sheet1$]"].Rows[i]["性别"].ToString().Trim());

            mShoe.cBrand = ds.Tables["[Sheet1$]"].Rows[i]["品牌"].ToString().Trim();
            mShoe.cSeries = ds.Tables["[Sheet1$]"].Rows[i]["系列"].ToString().Trim();            
            mShoe.fPrice = decimal.Parse(ds.Tables["[Sheet1$]"].Rows[i]["售价"].ToString().Trim());
            mShoe.cType = ds.Tables["[Sheet1$]"].Rows[i]["类型"].ToString().Trim();
           
            mShoe.cfeature = ds.Tables["[Sheet1$]"].Rows[i]["特点"].ToString().Trim();
            mShoe.fWeight = decimal.Parse(ds.Tables["[Sheet1$]"].Rows[i]["重量"].ToString().Trim());

            mShoe.fHeel = decimal.Parse(ds.Tables["[Sheet1$]"].Rows[i]["后跟高"].ToString().Trim());
            mShoe.fForefeet = decimal.Parse(ds.Tables["[Sheet1$]"].Rows[i]["前脚高"].ToString().Trim());
            mShoe.cImage = ds.Tables["[Sheet1$]"].Rows[i]["图片链接"].ToString().Trim();
            mShoe.cHonour = ds.Tables["[Sheet1$]"].Rows[i]["特别荣誉"].ToString().Trim();
            mShoe.cSum = ds.Tables["[Sheet1$]"].Rows[i]["要点"].ToString().Trim();
            mShoe.cReview = ds.Tables["[Sheet1$]"].Rows[i]["点评"].ToString().Trim();
            mShoe.cTester = ds.Tables["[Sheet1$]"].Rows[i]["评测"].ToString().Trim();
            mShoe.dTimetm =ds.Tables["[Sheet1$]"].Rows[i]["上市时间"].ToString().Trim();
            mShoe.cVideo = ds.Tables["[Sheet1$]"].Rows[i]["视频链接"].ToString().Trim();
            mShoe.rWeight = int.Parse(ds.Tables["[Sheet1$]"].Rows[i]["V重量"].ToString().Trim());
           
            mShoe.rHeight = int.Parse(ds.Tables["[Sheet1$]"].Rows[i]["V高度"].ToString().Trim());
            mShoe.rHeel = int.Parse(ds.Tables["[Sheet1$]"].Rows[i]["V后跟减震"].ToString().Trim());
            mShoe.rForefeet = int.Parse(ds.Tables["[Sheet1$]"].Rows[i]["V前脚掌减震"].ToString().Trim());
            mShoe.rStiffness = int.Parse(ds.Tables["[Sheet1$]"].Rows[i]["V硬度"].ToString().Trim());
            mShoe.rStability = int.Parse(ds.Tables["[Sheet1$]"].Rows[i]["V稳定性"].ToString().Trim());
            new DB5.tblShoes().Add(mShoe);
        }
    }
}