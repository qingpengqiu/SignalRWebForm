
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

public class GControlInfo
{
    public string Name = "";
    public string Value = "";
    public string Caption = "";
}

public static class GCommon
{
    private static List<GControlInfo> Items;
    private static Hashtable hash;
    private static int Index;

    #region 数据初始化 

    private static GControlInfo Append(string n, string v, string c)
    {
        GControlInfo r = new GControlInfo();
        r.Name = n;
        r.Value = v;
        if (v.Length < 1) r.Value = Index.ToString();
        r.Caption = c;

        hash.Add(n.ToLower() + ":" + r.Value.ToLower(), r);
        Index++;
        return r;
    }

    /// <summary>
    /// 列表与哈希数据初始化
    /// </summary>
    private static void Initialize()
    {
        if (!CacheHelper.Get("CACHE_COMMON_CONTROLS", out Items))
        {
            Items = new List<GControlInfo>();
            hash = new Hashtable();

            // 性别
            Index = 0;
            Items.Add(Append("idGender", "", "男"));
            Items.Add(Append("idGender", "", "女"));

            // 证件类型
            Index = 0;
            Items.Add(Append("idNationIdType", "", "身份证"));
            Items.Add(Append("idNationIdType", "", "护照"));
            Items.Add(Append("idNationIdType", "", "军官证"));
            Items.Add(Append("idNationIdType", "", "其它证件"));
            
            // 血型
            Index = 0;
            Items.Add(Append("idBlood", "", "A型"));
            Items.Add(Append("idBlood", "", "B型"));
            Items.Add(Append("idBlood", "", "O型"));
            Items.Add(Append("idBlood", "", "AB型"));
            Items.Add(Append("idBlood", "", "其它"));

            // 最高学历
            Index = 0;
            Items.Add(Append("idEducation", "", "大学"));
            Items.Add(Append("idEducation", "", "硕士"));
            Items.Add(Append("idEducation", "", "博士"));
            Items.Add(Append("idEducation", "", "大专/专职"));
            Items.Add(Append("idEducation", "", "中专/中技"));
            Items.Add(Append("idEducation", "", "中学"));
            Items.Add(Append("idEducation", "", "小学"));

            // 密码问题
            Index = 0;
            Items.Add(Append("idQuestion", "", "我手机号码的后6位"));
            Items.Add(Append("idQuestion", "", "我母亲的生日"));
            Items.Add(Append("idQuestion", "", "我父亲的生日"));
            Items.Add(Append("idQuestion", "", "我的跑步格言"));
            Items.Add(Append("idQuestion", "", "我第一次马拉松成绩"));
            Items.Add(Append("idQuestion", "", "我第一次参加马拉松的时间"));
            Items.Add(Append("idQuestion", "", "我第一次参加马拉松的名称"));
            Items.Add(Append("idQuestion", "", "我最喜爱的跑鞋型号"));
            Items.Add(Append("idQuestion", "", "我最喜爱的跑步歌曲"));
            Items.Add(Append("idQuestion", "", "我最喜爱的跑步地点"));
            Items.Add(Append("idQuestion", "", "我最喜欢的小说"));

            // 从事职业
            Index = 0;
            Items.Add(Append("idOccupation", "", "农牧业"));
            Items.Add(Append("idOccupation", "", "渔业"));
            Items.Add(Append("idOccupation", "", "木材森林业"));
            Items.Add(Append("idOccupation", "", "矿业采掘业"));
            Items.Add(Append("idOccupation", "", "交通运输业"));
            Items.Add(Append("idOccupation", "", "餐饮旅游业"));
            Items.Add(Append("idOccupation", "", "建筑工程"));
            Items.Add(Append("idOccupation", "", "制造加工维修业"));
            Items.Add(Append("idOccupation", "", "出版广告业"));
            Items.Add(Append("idOccupation", "", "医药卫生保健"));
            Items.Add(Append("idOccupation", "", "娱乐业"));
            Items.Add(Append("idOccupation", "", "文教机构"));
            Items.Add(Append("idOccupation", "", "宗教机构"));
            Items.Add(Append("idOccupation", "", "公共事业"));
            Items.Add(Append("idOccupation", "", "一般买卖"));
            Items.Add(Append("idOccupation", "", "服务业"));
            Items.Add(Append("idOccupation", "", "家庭管理"));
            Items.Add(Append("idOccupation", "", "公检法"));
            Items.Add(Append("idOccupation", "", "军人"));
            Items.Add(Append("idOccupation", "", "IT业"));
            Items.Add(Append("idOccupation", "", "职业运动员"));
            Items.Add(Append("idOccupation", "", "其它职业"));
            Items.Add(Append("idOccupation", "", "无职业"));

            // 竞赛类型
            Index = 0;
            Items.Add(Append("idCompeteStyle", "", "U超级马拉松"));
            Items.Add(Append("idCompeteStyle", "", "M全程马拉松"));
            Items.Add(Append("idCompeteStyle", "", "H半程马拉松"));
            Items.Add(Append("idCompeteStyle", "", "R路跑"));
            Items.Add(Append("idCompeteStyle", "", "C越野跑"));
            Items.Add(Append("idCompeteStyle", "", "T其它"));

            // 约跑道路类型
            Index = 0;
            Items.Add(Append("idRoadStyle", "", "公园"));
            Items.Add(Append("idRoadStyle", "", "田径场"));
            Items.Add(Append("idRoadStyle", "", "公路"));
            Items.Add(Append("idRoadStyle", "", "山路"));
            Items.Add(Append("idRoadStyle", "", "跑步机"));
            Items.Add(Append("idRoadStyle", "", "其它"));

            // 会员类型
            Index = 0;
            Items.Add(Append("idMemberStyle", "", "会员"));
            Items.Add(Append("idMemberStyle", "", "VIP会员"));
            Items.Add(Append("idMemberStyle", "", "企业会员"));
            Items.Add(Append("idMemberStyle", "", "专家"));
            Items.Add(Append("idMemberStyle", "", "教练"));
            Items.Add(Append("idMemberStyle", "", "俱乐部发起者"));

            // 管理员类型
            Items.Add(Append("idAdminStyle", "11", "编辑"));
            Items.Add(Append("idAdminStyle", "12", "总编"));
            Items.Add(Append("idAdminStyle", "13", "信息管理员"));
            //Items.Add(Append("idAdminStyle", "99", "超级管理员"));
            
            // 当前你跑
             Index = 0;
            Items.Add(Append("cRunNow", "", "1.6公里"));
            Items.Add(Append("cRunNow", "", "5公里"));
            Items.Add(Append("cRunNow", "", "8公里"));
            Items.Add(Append("cRunNow", "", "10公里"));
            Items.Add(Append("cRunNow", "", "15公里"));
            Items.Add(Append("cRunNow", "", "20公里"));
            Items.Add(Append("cRunNow", "", "半程马拉松"));
            Items.Add(Append("cRunNow", "", "全程马拉松"));

            // 训练目标
             Index = 0;
            Items.Add(Append("cRunDestination", "", "1.6公里"));
            Items.Add(Append("cRunDestination", "", "5公里"));
            Items.Add(Append("cRunDestination", "", "8公里"));
            Items.Add(Append("cRunDestination", "", "10公里"));
            Items.Add(Append("cRunDestination", "", "15公里"));
            Items.Add(Append("cRunDestination", "", "20公里"));
            Items.Add(Append("cRunDestination", "", "半程马拉松"));
            Items.Add(Append("cRunDestination", "", "全程马拉松"));

            // 训练强度
            Index = 0;
            Items.Add(Append("cTrainStyle", "", "维持现状"));
            Items.Add(Append("cTrainStyle", "", "稳步提高"));
            Items.Add(Append("cTrainStyle", "", "快速提高"));
            Items.Add(Append("cTrainStyle", "", "急速提高"));

            // 每周跑量
            Index = 0;
            Items.Add(Append("cRunWeek", "", "10-18公里"));
            Items.Add(Append("cRunWeek", "", "18-26公里"));
            Items.Add(Append("cRunWeek", "", "26-34公里"));
            Items.Add(Append("cRunWeek", "", "34-42公里"));
            Items.Add(Append("cRunWeek", "", "42-50公里"));
            Items.Add(Append("cRunWeek", "", "50-58公里"));
            Items.Add(Append("cRunWeek", "", "58-66公里"));
            Items.Add(Append("cRunWeek", "", "66-74公里"));
            Items.Add(Append("cRunWeek", "", "74-82公里"));
            Items.Add(Append("cRunWeek", "", "82-90公里"));
            Items.Add(Append("cRunWeek", "", "90-98公里"));
            Items.Add(Append("cRunWeek", "", "98-106公里"));
            Items.Add(Append("cRunWeek", "", "106-114公里"));
            Items.Add(Append("cRunWeek", "", "114-122公里"));
            Items.Add(Append("cRunWeek", "", "122-130公里"));

            CacheHelper.Save("CACHE_COMMON_CONTROLS", Items);
        }
    }

    #endregion

    /// <summary>
    /// 按字段名显示为页面控件(SELECT,RADIO,CHECKBOX)
    /// </summary>
    /// <param name="Caption">保留</param>
    /// <param name="controlStyle">控件类型</param>
    /// <param name="controlName">控件ID</param>
    /// <param name="defaultValue">默认值</param>
    /// <returns></returns>
    public static string Controls(string Caption, string controlStyle, string controlName, string defaultValue)
    {
        Initialize();

        StringBuilder sb = new StringBuilder();
        if (controlStyle == "radio" || controlStyle == "checkbox")
        {
            int idx = 0;
            foreach (GControlInfo gc in Items)
            {
                if (gc.Name == controlName)
                {
                    if (defaultValue == gc.Value || (idx == 0 && defaultValue.Length < 1))
                    {
                        sb.AppendLine(((idx == 0) ? "" : "\t\t\t") + "<input type=\"" + controlStyle + "\" id=\"" + controlName + "\" name=\"" + controlName + "\" value=\"" + gc.Value + "\" checked>" + gc.Caption);
                    }
                    else
                    {
                        sb.AppendLine(((idx == 0) ? "" : "\t\t\t") + "<input type=\"" + controlStyle + "\" id=\"" + controlName + "\" name=\"" + controlName + "\" value=\"" + gc.Value + "\">" + gc.Caption);
                    }
                    idx++;
                }
            }
            return sb.ToString();
        }

        if (controlStyle == "select")
        {
            sb.AppendLine("<select id=\"" + controlName + "\" name=\"" + controlName + "\" onchange=\"UpdateHistory(this)\">");
            int idx = 0;
            foreach (GControlInfo gc in Items)
            {
                if (gc.Name == controlName)
                {
                    if (defaultValue == gc.Value || (idx == 0 && defaultValue.Length < 1))
                    {
                        sb.AppendLine("\t\t\t\t<option value=\"" + gc.Value + "\" selected>" + gc.Caption + "</option>");
                    }
                    else
                    {
                        sb.AppendLine("\t\t\t\t<option value=\"" + gc.Value + "\">" + gc.Caption + "</option>");
                    }
                    idx++;
                }
            }
            sb.AppendLine("\t\t\t</select>");
            return sb.ToString();
        }
        return "";
    }

    /// <summary>
    /// 按字段名+字段数值快速查找类别信息
    /// </summary>
    /// <param name="n"></param>
    /// <param name="v"></param>
    /// <returns></returns>
    public static GControlInfo Find(string n, string v)
    {
        Initialize();
        string hidx = n.ToLower() + ":" + v.ToLower();
        if (hash[hidx] != null) return (GControlInfo)hash[hidx];
        return null;
    }

    public static string FindValue(string n, string v)
    {
        Initialize();
        string hidx = n.ToLower() + ":" + v.ToLower();
        if (hash[hidx] != null)
        {
            return ((GControlInfo)hash[hidx]).Caption;
        }
        return "";
    }
public static bool BadTitle(string login)
    {
        string w = "法轮,他妈,混蛋,鸡巴,操你,奸,王八,婊,共产党,大法,性交,阴道,阳具,性生活,性福,本站,本网,李宏志,你妈,http,sex,www,fuck,特殊按摩一条龙服务,小妹服务好,小妹上门服务,小妹可以包夜服务,月子中心,大保健, 美女找,叫卖淫女,叫美女,叫大学生,找鸡,找美女,找小妹,找全套,找色女,找按摩,找外围女,找服务,找上门,扑克,变 牌,变牌,麻将,牌九,推筒子,程序机,发电机,出轨,开房,窃听,雀斑,黄褐斑,长斑,起斑,去斑,GAY,援交,楼凤,约炮,嫖娼,婊子,妓女,鸡店,鸡婆,鸡 婆,小 姐,一夜情,学生妹,狂躁症,躁狂症,伤笆婆,发廊妹,站街女,同志电话服务,美女包夜, 拍肩粉,迷药卖,迷烟卖,迷幻药,迷情药,催情药,卖迷药,卖迷烟,卖听话水,成人奶妈,女用春药,上门按摩,酒店按摩, 信用卡套现,信用卡代还,信用卡取现,信用卡垫还,交友会所,恋足会所,丝足会所,女王调教,女奴调教,行业显示, 迷晕的药,电话是多少,通话记录,通话清单,电话清单,微信记录,酒店记录,开房记录,开放记录,开放房记录,历史记录,登记记录,入住记录,住宿记录,住宿清单,第三方斯蒂芬,驗血看男女,验血看男女,抽血看男女,抽血验男女,看胎儿性别,代开发票,小姐化合物,师范这个,中国这个,科技这个,航空这个,肾结石,胆结石,治结石,肾囊肿,肾积水,做碎石,看结石,打结石,胆囊结石,胆管结石,胆总管结石,多发性结石,结石病医院,体外碎石,激光碎石,治疗结石,结石医院,保胆医院,保胆取石,胆囊堵塞,胆囊息肉治疗,最好的医院,碎石价格,冲击波碎石,兼职小妹,找小姐,小妹全,小妹找全,刷票,密码忘,聊天记录,外推,卵泡发育,孕激素,不排卵,输卵管,子宫息肉,子宫内膜,宫腔黏连,青春痘,百度收录,微信聊天,微信已删除,恢复手机,删除手机,微信怎么盗,QQ密码,QQ密保,QQ号码,QQ聊天,QQ好友,qq被偷,QQ号被盗,老公的qq,女朋友的QQ,总部QQ,陌陌聊天,盗号,网密码,偷偷查看,定位一个人,定位别人,手机通讯,手机清单,话费清单,偷看他人记录,打电话如何才能偷听,在跟谁聊天,别人冒用,信息记录,老公的小三,与陌生女孩聊天";
        string[] wa = w.Split(',');
        foreach (string wu in wa)
        {
            if (login.ToLower().Contains(wu))
            {
                return true;
            }
        }
        return false;
    }
    public static bool BadLoginname(string login)
    {
        string w = "admin,江泽民,胡锦涛,温家宝,毛泽东,周恩来,朱德,&,习近平,益跑网,法轮,死,屎,他妈,混蛋,傻,屁,鸡巴,操你,奸,王八,婊,蠢,党,大法,性交,阴道,阳具,性生活,性福,本站,本网,李宏志,网站,董事长,总裁,经理,你妈,http,sex,www,fuck,益跑，erun360";
        string[] wa = w.Split(',');
        foreach (string wu in wa)
        {
            if (login.ToLower().Contains(wu))
            {
                return true;
            }
        }
        return false;
    }

    public static bool BadContent(string login)
    {
        string w = "法轮,鸡巴,操你,大法,性交,阴道,阳具,性生活,性福,李宏志";
        string[] wa = w.Split(',');
        foreach (string wu in wa)
        {
            if (login.ToLower().Contains(wu))
            {
                return true;
            }
        }
        return false;
    }

    /// <summary>
    /// 时分秒页面控件
    /// </summary>
    /// <param name="controlName"></param>
    /// <param name="s"></param>
    /// <param name="e"></param>
    /// <param name="d"></param>
    /// <returns></returns>
    public static string HMS(string controlName, int s, int e, int d)
    {
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("<select id=\"slt_" + controlName + "\" name=\"slt_" + controlName + "\" onchange=\"document.getElementById('" + controlName + "').value=this.options[this.selectedIndex].value;\">");
        for (int i = s; i <= e; i++)
        {
            if (i == d)
            {
                sb.AppendLine("\t\t\t\t<option value=\"" + i + "\" selected>" + i + "</option>");
            }
            else
            {
                sb.AppendLine("\t\t\t\t<option value=\"" + i + "\">" + i + "</option>");
            }
        }
        sb.AppendLine("\t\t\t</select>");
        sb.AppendLine("\t\t\t<input type=\"hidden\" id=\"" + controlName + "\" name=\"" + controlName + "\" value=\"" + d + "\">");
        return sb.ToString();
    }


    public static string FacePanel(int iduser, int idbrowse)
    {
        StringBuilder sb = new StringBuilder();

        if (iduser == idbrowse)
        {
            sb.AppendLine("<div style=\"float:right;width:950px;height:13px;padding-top:1px;\">");
            sb.AppendLine("\t\t\t<div id=\"blog_icon\" style=\"background-color:#DDECCD;\" onclick=\"changeBack(1)\"></div>");
            sb.AppendLine("\t\t\t<div id=\"blog_icon\" style=\"background-color:#B5A583;\" onclick=\"changeBack(2)\"></div>");
            sb.AppendLine("\t\t\t<div id=\"blog_icon\" style=\"background-color:#6145AB;\" onclick=\"changeBack(3)\"></div>");
            sb.AppendLine("\t\t\t<div id=\"blog_icon\" style=\"background-color:#2D62AE;\" onclick=\"changeBack(4)\"></div>");
            sb.AppendLine("\t\t</div>");
        }

        sb.AppendLine("<script language=\"javascript\">");
        sb.AppendLine("$.get(\"/Utility/Ajax/FaceLoad.aspx\", { id : " + iduser + "}, function(result) {");
        sb.AppendLine("\tif(result.length > 0) {");
        sb.AppendLine("\t\tchangeBackAction(parseInt(result));");
        sb.AppendLine("\t}");
        sb.AppendLine("});");
        sb.AppendLine("</script>");

        return sb.ToString();
    }
}

public static class SpeedHelper
{
    public static string Format(float distance, DateTime time)
    {
        StringBuilder sb = new StringBuilder();
        double speed = distance * 60.0 / (time.Hour * 60.0 + time.Minute + time.Second / 60.0);
        sb.AppendLine("" + String.Format("{0:F2}", speed) + " km/h ");
        if (speed > 22.0) sb.AppendLine("<img src=\"/images/afraid.gif\" style=\"margin-bottom:-2px;\" title=\"您的速度太恐怖了！\">");
        else if (speed > 12.0) sb.AppendLine("<img src=\"/images/star.gif\" style=\"margin-bottom:-2px;\"><img src=\"/images/star.gif\" style=\"margin-bottom:-2px;\"><img src=\"/images/star.gif\" style=\"margin-bottom:-2px;\">");
        else if (speed > 7.0) sb.AppendLine("<img src=\"/images/star.gif\" style=\"margin-bottom:-2px;\"><img src=\"/images/star.gif\" style=\"margin-bottom:-2px;\">");
        else if (speed > 4.0) sb.AppendLine("<img src=\"/images/star.gif\" style=\"margin-bottom:-2px;\">");
        else sb.AppendLine("<img src=\"/images/slow.gif\" style=\"margin-bottom:-2px;\" title=\"好慢啊\">");

        return sb.ToString();
    }
}
