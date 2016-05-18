using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
public partial class Member_Register3 : PageBase
{
    private int id = 0;
    public int num = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(100006104);
        if (CurrentUser == null)
        {
            Response.Redirect("/Member/Login.aspx");
        }
        if (!IsPostBack)
        {
           // ShowInfo(CurrentUser.uId);
        }
    }
   
    protected void renext_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Response.Redirect("/Member/Login.aspx");
        }
        DBM1.tblRUNINTRO modelInfo = new DB1.tblRUNINTRO().GetModelByidUser(CurrentUser.uId);
        if (modelInfo != null)
        {
            id = modelInfo.id;
        }
        DBM1.tblRUNINTRO model = new DBM1.tblRUNINTRO();
        model.idUser = TypeChangeDefault.NullToInt(CurrentUser.uId, 0);
        model.iRunyear = TypeChangeDefault.NullToInt(runyear.Value.Trim(), 0);
        model.iMarathon = TypeChangeDefault.NullToInt(marathonnum.Value.Trim(), 0);
        model.iTrail = TypeChangeDefault.NullToInt(countrynum.Value.Trim(), 0);
        model.iMarathontype = TypeChangeDefault.NullToInt(marathonbest.Value.Trim(), 0);
        model.tMarathontime = TypeChangeDefault.NullToString(results.Value.Trim(), "00:00:00");
        model.cBio = TypeChangeDefault.NullToString(onegame.Value.Trim(), "");
        if (id == 0)
        {
            new DB1.tblRUNINTRO().Add(model);
        }
        else
        {
            model.id = id;
            new DB1.tblRUNINTRO().Update(model);
        }
        int RecordNum = TypeChangeDefault.NullToInt(iRecord.Value, 0);
        AddRecord(RecordNum);
        DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
        //if (!uMember_History.Exists(100800124, CurrentUser.uId))
        //{
        //    uMember_History.Insert(CurrentUser.uId, 100800124, 1);
        //}
        if (!uMember_History.Exists(100800124, CurrentUser.uId))
        {
            if (!uMember_History.Exists(200810009, CurrentUser.uId))
            {
                new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810009, 1, 0, 1);
                //uMember_History.Insert(CurrentUser.uId, 1, 200800117, 0);               
            }
        }

        Response.Redirect("Register4.aspx");
    }
    //添加赛事记录
    private void AddRecord(int RecordNum)
    {
        DBM1.tblRACERECORD recordModel = new DBM1.tblRACERECORD();
        DB1.tblRACERECORD recordBLL = new DB1.tblRACERECORD();
        recordBLL.Delete(CurrentUser.uId);
        for (int i = 1; i <= RecordNum; i++)
        {
            recordModel.idUser = CurrentUser.uId;
            recordModel.iYear = TypeChangeDefault.NullToInt(Request.Form["iYear" + i.ToString()], 2008);
            recordModel.cRacename = TypeChangeDefault.NullToString(Request.Form["cName" + i.ToString()], "");
            if (recordModel.cRacename.Trim().Length == 0)
            {
                AlertHelper.JQAlertGo("请填写赛事名称！","Register3.aspx", false);
                return;
            }
            recordModel.tTime = TypeChangeDefault.NullToString(Request.Form["dTime" + i.ToString()], "00:00:00");
            recordBLL.Add(recordModel);
        }
    }
}