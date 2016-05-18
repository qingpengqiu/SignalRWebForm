using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
public partial class Member_Register4 : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Response.Redirect("/Member/Login.aspx");
        }
    }
    protected void renext_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Response.Redirect("/Member/Login.aspx");
        }
        DB1.tblMEMBER_SIZE Bll = new DB1.tblMEMBER_SIZE();
        DBM1.tblMEMBER_SIZE model = Bll.GetModel(CurrentUser.uId);
        model.iBodyHeight = TypeChangeDefault.NullToInt(height.Value, 0);
        model.iBodyWeight = TypeChangeDefault.NullToInt(weight.Value, 0);
        model.iChestSize = TypeChangeDefault.NullToInt(chest.Value, 0);
        model.iFootLength = TypeChangeDefault.NullToInt(feetlong.Value, 0);
        model.iFootWidth = TypeChangeDefault.NullToInt(feetwide.Value, 0);
        model.iHipSize = TypeChangeDefault.NullToInt(hips.Value, 0);
        model.iWaistSize = TypeChangeDefault.NullToInt(waistline.Value, 0);
        Bll.Update(model);
        DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
        //if (!uMember_History.Exists(100800105, CurrentUser.uId))
        //{
        //    uMember_History.Insert(CurrentUser.uId, 100800105, 10);
        //}
        if (!uMember_History.Exists(100800105, CurrentUser.uId))
        {
            if (!uMember_History.Exists(200810008, CurrentUser.uId))
            {
                new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810008, 1, 0, 1);
                //uMember_History.Insert(CurrentUser.uId, 1, 200800116, 0);
            }
        }
        //DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
        //uMember_History.Insert(CurrentUser.uId, 100800105, 10);
        Response.Redirect("Register5.aspx");
    }
}