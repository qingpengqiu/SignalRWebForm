using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using Erun360.BLL;
public partial class Member_Register1 : PageBase
{
    public int idUser = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Response.Redirect("/Member/Login.aspx");
        }
        
        if(!IsPostBack)
        {
            idUser = CurrentUser.uId;
            //cAvatar.Value = @"/Html/images/uicon1.jpg";
        }
    }
    protected void renext_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Response.Redirect("/Member/Login.aspx");
        }

        DBM1.tblMEMBER model = new DB1.tblMEMBER().GetModel(CurrentUser.uId);
        if (gendera.Checked)
        {
            model.idGender = 0;
        }
        if (genderb.Checked)
        {
            model.idGender = 1;
        }
        model.cAvatar = cAvatar.Value;
        model.dBirthday = TypeChangeDefault.NullToDateTime(birthday.Value, DateTime.Now);
        //model.id = CurrentUser.uId;
        if (new DB1.tblMEMBER().Update(model))
        {
            DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
            //if (!uMember_History.Exists(100800102, CurrentUser.uId))
            //{
            //    uMember_History.Insert(CurrentUser.uId, 1, 200800112, 0);
            //    //uMember_History.Insert(CurrentUser.uId, 100800102, 5);
            //}
            if (!uMember_History.Exists(100800102, CurrentUser.uId))
            {
                if (!uMember_History.Exists(200810006, CurrentUser.uId))
                {
                    new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810006, 1, 0, 1);
                    //new IntegralInfo().InsertScore(CurrentUser.uId, 200810006, 1, 0, 1);

                    //uMember_History.Insert(CurrentUser.uId, 1, 200810006, 0);
                    //DBM1.tblMEMBER_SUMMARY mSummary = new DBM1.tblMEMBER_SUMMARY();
                    //mSummary.idUser = idUser;
                    //mSummary.iScore = new DB1.tblIntegral().FindScore(200810006);
                    //new DB1.tblMEMBER_SUMMARY().Add(mSummary);
                }
            }
            Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().UpdateUserModel(CurrentUser.uId);
            Response.Redirect("Register2.aspx");
        }
        else
        {
            AlertHelper.JQAlert("保存失败", false);
            Response.Redirect("Login.aspx");           
        }
    }
}