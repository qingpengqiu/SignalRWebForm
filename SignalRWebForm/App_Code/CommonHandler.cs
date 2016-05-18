using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;
using DB1 = Erun360.BLL.DB1;

/// <summary>
/// CommanHandler 的摘要说明
/// </summary>
public class CommonHandler
{
    DB1.tblMEMBER bll = new DB1.tblMEMBER();
    public CommonHandler()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
    //验证账号输入密码是否正确
    public bool CheckPassword(int uid,string pwd)
    {
        int recordcount = bll.GetRecordCount(" id=" + uid + " and cPassword='" + XString.MD5(XString.SqlSafe(pwd.Trim().ToLower())) + "'");
        if (recordcount > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}