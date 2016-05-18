<%@ WebHandler Language="C#" Class="Cycontact" %>

using System;
using System.Web;
using System.Web.SessionState;
using Erun360.Model.DB6;
using System.IO;
using System.Text;
using System.Runtime.Serialization.Json;
using Erun360.Common;
using System.Net;
using System.Collections.Generic;
using Erun360.Model;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using System.Collections;
using System.Collections.Specialized;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using DB1 = Erun360.BLL.DB1;
using System.Data;

public class Cycontact : IHttpHandler,IReadOnlySessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        if (context.Request["op"] != null)
        {
            string command = context.Request["op"].ToString();
            System.Reflection.MethodInfo method = this.GetType().GetMethod(command);
            if (method != null)
            {
                method.Invoke(this, new object[] { context });
            }
        }
    }
    public void del(HttpContext context)
    {//删除常用联系人
        string result = string.Empty;
        
        DB6.tblPassenger tblpas = new DB6.tblPassenger();
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel CurrentUser = context.Session["CurrentUser"] as UserInfoModel;
        //DB6.tblPassenger iduser = new DB6.tblPassenger();
        
        //int id = TypeChangeDefault.NullToInt(tblpas.GetModel(CurrentUser.uId),0);

        //if (id != 0)
        //{
            if (tblpas.Delete(TypeChangeDefault.NullToInt(context.Request["id"], 0)))
            {
                //context.Response.Write("删除成功！");
                result = "{\"msg\":\"删除成功\",\"status\":\"10\"}";
                context.Response.Write(result);
            }
            else
            {
                //context.Response.Write("删除失败！");
                result = "{\"msg\":\"删除失败\",\"status\":\"11\"}";
                context.Response.Write(result);
            }
        //}
    }
    public void upbind(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        List<Hashtable> flightInfoList = new List<Hashtable>();
        DataSet ds = new DB6.tblPassenger().GetList("id = "+context.Request["id"].ToString()+"");
        Hashtable flight = new Hashtable();
        if (ds.Tables[0].Rows.Count == 0)
        {
            result = "{\"msg\":\"请选择数据！\",\"status\":\"12\"}";
            context.Response.Write(result);
            return;
        }
        flight.Add("csurname", ds.Tables[0].Rows[0]["csurname"]);
        flight.Add("Nationality", ds.Tables[0].Rows[0]["Nationality"]);
        flight.Add("cname", ds.Tables[0].Rows[0]["cname"]);
        flight.Add("IdType", ds.Tables[0].Rows[0]["IdType"]);
        flight.Add("IdNo", ds.Tables[0].Rows[0]["IdNo"]);
        flight.Add("cGender", ds.Tables[0].Rows[0]["cGender"]);
        flight.Add("cMail", ds.Tables[0].Rows[0]["cMail"]);
        flight.Add("Phone", ds.Tables[0].Rows[0]["Phone"]);
        if (ds.Tables[0].Rows[0]["cValidity"].ToString() != string.Empty)
        {
            flight.Add("cValidity", ds.Tables[0].Rows[0]["cValidity"].ToString().Substring(0, 10));
        }
        else
        {
            flight.Add("cValidity", DateTime.Now.ToShortDateString());
        }
        if (ds.Tables[0].Rows[0]["dBirthday"].ToString() != string.Empty)
        {
            flight.Add("dBirthday", ds.Tables[0].Rows[0]["dBirthday"].ToString().Substring(0, 10));
        }
        else
        {
            flight.Add("dBirthday", DateTime.Now.Date.ToShortDateString());
        }
        
        //flight.Add("cValidity", ds.Tables[0].Rows[0]["cValidity"].ToString().Substring(0,10));
        flight.Add("cAddress", ds.Tables[0].Rows[0]["cAddress"]);
        flight.Add("cIssued", ds.Tables[0].Rows[0]["cIssued"]);
        flightInfoList.Add(flight);
        context.Response.Write(JsonConvert.SerializeObject(flightInfoList));
    }
    
    //判断是否为汉字
    public bool IsChinese(string CString)
    {
        return System.Text.RegularExpressions.Regex.IsMatch(CString, @"^[\u4e00-\u9fa5]+$");
    }
    /// <summary>
    /// 验证字符串是否是中文。
    /// </summary>
    /// <param name="checkedStr">需验证的字符串。</param>
    /// <param name="allMatch">是否完全匹配。当值为true时，全部是中文；当值为false时，仅含有中文。</param>
    /// <returns></returns>
    public static bool IsChinese(string checkedStr, bool allMatch)
    {
        string pattern;
        if (allMatch)
            pattern = @"^[\u4e00-\u9fa5]+$";
        else
            pattern = @"[\u4e00-\u9fa5]";
        if (System.Text.RegularExpressions.Regex.IsMatch(checkedStr, pattern))
            return true;
        else
            return false;
    }
    private static bool IsEnglish(string input)
    {
        System.Text.RegularExpressions.Regex regex = new System.Text.RegularExpressions.Regex(@"^[A-Za-z]+$");
        return regex.IsMatch(input);
    }
    public void SaveAddUp(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        int id = TypeChangeDefault.NullToInt(context.Request["id"], 0);//id
        
        //string idUser = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["idUser"]), "");//创建人
        string csurname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["csurname"]), "");//姓
        string cname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cname"]), "");//名
        string cFullname = "";//姓名
        string Nationality = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["Nationality"]), "");//国籍
        //string idCity = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["idCity"]), "");//城市号
        //string cCityname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cCityname"]), "");//城市名
        string IdType = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["IdType"]), "");//证件类型
        string IdNo = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["IdNo"]), "");//证件号码
        string Phone = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["Phone"]), "");//手机
        string dCreate = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["dCreate"]), "");//创建时间
        string cGender = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cGender"]), "");//性别
        string dBirthday = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["dBirthday"]), "");//出生日期
        string cMail = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cMail"]), "");//邮箱
        string cValidity = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cValidity"]), "");//护照有效期
        string cAddress = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cAddress"]), "");//地址
        string cIssued = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cIssued"]), "");//签发地
        
        if (IsChinese(cname) && IsChinese(csurname))
            {
                cFullname = csurname + cname;
            }
            else if (IsEnglish(cname) && IsEnglish(csurname))
            {
                cFullname = csurname + "/" + cname;
            }
        if (cname.Trim().Length == 0 || csurname.Trim().Length == 0 || IdNo.Trim().Length == 0 || Phone.Trim().Length == 0 ||cMail.Trim().Length == 0)
        {
            result = "{\"msg\":\"常用联系人基本信息不能为空！\",\"status\":\"2\"}";
            context.Response.Write(result);
            return;
        }
        
        //身份证验证
        if (IdType == "IN")
        {
            if (!CheckIDCard(IdNo))
            {
                result = "{\"msg\":\"身份证不正确！\",\"status\":\"3\"}";
                context.Response.Write(result);
                return;
            }
        }
        else
        {
            if (IdType == "PP")
            if (cValidity.Trim().Length == 0 || cIssued.Trim().Length == 0)
            {
                result = "{\"msg\":\"常用联系人基本信息不能为空！\",\"status\":\"2\"}";
                context.Response.Write(result);
                return;
            }
        }
        //手机验证
        if (!System.Text.RegularExpressions.Regex.IsMatch(Phone.Trim(), @"^1\d{10}$"))
        {
            result = "{\"msg\":\"手机号码填写不正确！\",\"status\":\"4\"}";
            context.Response.Write(result);
            return;
        }
        //邮箱验证
        if (!System.Text.RegularExpressions.Regex.IsMatch(cMail.Trim().ToString(), @"^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"))
        {
            result = "{\"msg\":\"邮箱格式不正确！\",\"status\":\"5\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel CurrentUser = context.Session["CurrentUser"] as UserInfoModel;
        
            
        //DB6.tblPassenger iduser = new DB6.tblPassenger();
        int puser = new DB6.tblPassenger().GetRecordCount("idUser='" + CurrentUser.uId + "' and cname='" + cname + "' and Phone='" + Phone + "' and IdType='" + IdType + "'");

        if (puser == 0 && id==0)//添加常用联系人
        {
            tblPassenger m_user = new tblPassenger();
            m_user.Nationality = Nationality;
            m_user.idUser = CurrentUser.uId;
            m_user.csurname = csurname;
            m_user.cname = cname;
            m_user.cGender = cGender;
            m_user.cFullname = cFullname;
            m_user.dCreate = DateTime.Now;
            if (dBirthday != string.Empty)
            {
                m_user.dBirthday = DateTime.Parse(dBirthday);
            }
            m_user.cMail = cMail;
            m_user.cAddress = cAddress;
            m_user.IdType = IdType;
            m_user.IdNo = IdNo;
            m_user.Phone = Phone;
            if(cValidity!=string.Empty)
            {
                m_user.cValidity = DateTime.Parse(cValidity);
            }
            m_user.cIssued = cIssued;
            
            int i = new DB6.tblPassenger().Add(m_user);
            if (i == 0)
            {
                result = "{\"msg\":\"添加失败\",\"status\":\"6\"}";
                context.Response.Write(result);
            }
            else
            {
                result = "{\"msg\":\"添加成功\",\"status\":\"7\"}";
                context.Response.Write(result);
            }
        }
        else
        {
            //修改常用联系人
            if (id == 0)
            {
                result = "{\"msg\":\"此用户已存在\",\"status\":\"13\"}";
                context.Response.Write(result);
                return;
            }
            tblPassenger m_userr  = new DB6.tblPassenger().GetModel(id);
            if (m_userr.idUser != CurrentUser.uId)
            {
                result = "{\"msg\":\"此用户不是当前用户，无权限此操作\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }

            tblPassenger m_user = new tblPassenger();
            m_user.id = id;
            m_user.csurname = csurname;
            m_user.cname = cname;
            m_user.cFullname = csurname + cname;
            m_user.cGender = cGender;
            //m_user.dCreate = DateTime.Parse(dCreate);           
            if (dBirthday != string.Empty)
            {
                m_user.dBirthday = DateTime.Parse(dBirthday);
            }
            m_user.cMail = cMail;
            m_user.cAddress = cAddress;
            m_user.IdType = IdType;
            m_user.IdNo = IdNo;
            m_user.Phone = Phone;
            if (cValidity != string.Empty)
            {
                m_user.cValidity = DateTime.Parse(cValidity);
            }
            m_user.cIssued = cIssued;
            
            bool i = new DB6.tblPassenger().Update(m_user);
            if (i)
            {
                result = "{\"msg\":\"修改成功\",\"status\":\"8\"}";
                context.Response.Write(result);
            }
            else
            {
                result = "{\"msg\":\"修改失败\",\"status\":\"9\"}";
                context.Response.Write(result);
            }
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }
    /// <summary>  
    /// 验证身份证合理性  
    /// </summary>  
    /// <param name="Id"></param>  
    /// <returns></returns>  
    public bool CheckIDCard(string idNumber)
    {
        if (idNumber.Length == 18)
        {
            bool check = CheckIDCard18(idNumber);
            return check;
        }
        else if (idNumber.Length == 15)
        {
            bool check = CheckIDCard15(idNumber);
            return check;
        }
        else
        {
            return false;
        }
    }


    /// <summary>  
    /// 18位身份证号码验证  
    /// </summary>  
    private bool CheckIDCard18(string idNumber)
    {
        long n = 0;
        if (long.TryParse(idNumber.Remove(17), out n) == false
            || n < Math.Pow(10, 16) || long.TryParse(idNumber.Replace('x', '0').Replace('X', '0'), out n) == false)
        {
            return false;//数字验证  
        }
        string address = "11x22x35x44x53x12x23x36x45x54x13x31x37x46x61x14x32x41x50x62x15x33x42x51x63x21x34x43x52x64x65x71x81x82x91";
        if (address.IndexOf(idNumber.Remove(2)) == -1)
        {
            return false;//省份验证  
        }
        string birth = idNumber.Substring(6, 8).Insert(6, "-").Insert(4, "-");
        DateTime time = new DateTime();
        if (DateTime.TryParse(birth, out time) == false)
        {
            return false;//生日验证  
        }
        string[] arrVarifyCode = ("1,0,x,9,8,7,6,5,4,3,2").Split(',');
        string[] Wi = ("7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2").Split(',');
        char[] Ai = idNumber.Remove(17).ToCharArray();
        int sum = 0;
        for (int i = 0; i < 17; i++)
        {
            sum += int.Parse(Wi[i]) * int.Parse(Ai[i].ToString());
        }
        int y = -1;
        Math.DivRem(sum, 11, out y);
        if (arrVarifyCode[y] != idNumber.Substring(17, 1).ToLower())
        {
            return false;//校验码验证  
        }
        return true;//符合GB11643-1999标准  
    }


    /// <summary>  
    /// 16位身份证号码验证  
    /// </summary>  
    private bool CheckIDCard15(string idNumber)
    {
        long n = 0;
        if (long.TryParse(idNumber, out n) == false || n < Math.Pow(10, 14))
        {
            return false;//数字验证  
        }
        string address = "11x22x35x44x53x12x23x36x45x54x13x31x37x46x61x14x32x41x50x62x15x33x42x51x63x21x34x43x52x64x65x71x81x82x91";
        if (address.IndexOf(idNumber.Remove(2)) == -1)
        {
            return false;//省份验证  
        }
        string birth = idNumber.Substring(6, 6).Insert(4, "-").Insert(2, "-");
        DateTime time = new DateTime();
        if (DateTime.TryParse(birth, out time) == false)
        {
            return false;//生日验证  
        }
        return true;
    }   

}