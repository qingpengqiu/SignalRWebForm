using System;
using System.IO;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Data;
using System.Text;
using ERUN360.Entity;
public partial class _Home_Default : PageBase
{
    public ADRight addgg = new ADRight();
    DB1.tblTour tourBll = new DB1.tblTour();
    int ModelCache = 10;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title = "������-�й����ȵ��ܲ��Ż���վ-ERUN360.COM";
        this.page_Keywords = "�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������";
        this.page_Description = "�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�";
        if (!IsPostBack)
        {
            #region ����ͼ
            string KeyFocus = "IndexFocusmap";
            object Focusmap = Erun360.Common.DataCache.GetCache(KeyFocus);
            if (Focusmap == null)
            {
                Focusmap = new Erun360.BLL.DB2.tblFocusmap().GetList(6, "idChannel=30000 and iStatus =1", "dCreate desc,id desc").Tables[0];
                if (Focusmap != null)
                {
                    //int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(KeyFocus, Focusmap, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            DataTable dtFocus = Focusmap as DataTable;
            for (int i = 0; i < dtFocus.Rows.Count; i++)
            {
                if (i == 0)
                {
                    ltljdt.Text += "<li class=\"tm\"><a class=\"imgTop\" href=\"" + dtFocus.Rows[i]["cLink"].ToString() + "\" target=\"_blank\"><img data-echo=\"" + dtFocus.Rows[i]["cImageUrl"].ToString().Replace(HostInfo.imgName, HostInfo.imgCDN) + "\" src=\"/Html/images/blank.gif\" /></a><div class=\"imgCen\">" + dtFocus.Rows[i]["cTitle"].ToString() + "</div></li>";
                }
                else
                {
                    ltljdt.Text += "<li><a class=\"imgTop\" href=\"" + dtFocus.Rows[i]["cLink"].ToString() + "\" target=\"_blank\"><img data-echo=\"" + dtFocus.Rows[i]["cImageUrl"].ToString().Replace(HostInfo.imgName, HostInfo.imgCDN) + "\" src=\"/Html/images/blank.gif\" /></a><div class=\"imgCen\">" + dtFocus.Rows[i]["cTitle"].ToString() + "</div></li>";
                }
            }
            #endregion
            #region �����б�
            string KeyArticle = "IndexArticle";
            object Article = Erun360.Common.DataCache.GetCache(KeyArticle);
            if (Article == null)
            {
                DBM2.tblChannel model = new DB2.tblChannel().GetModel(30000);
                DB2.tblPush bll = new DB2.tblPush();
                Article = bll.GetList(model.iMaxPageSize ?? 0, "dPush <=GETDATE()", "dPush desc").Tables[0];
                if (Article != null)
                {
                    //int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(KeyArticle, Article, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            string KeyFlow = "indexADFlow";
            object Flow = Erun360.Common.DataCache.GetCache(KeyFlow);
            if (Flow == null)
            {
                DB2.tblADFlow flow = new DB2.tblADFlow();
                Flow = flow.GetList("GETDATE() between dBegintime and dEndtime and idChannel = 30000 and iPage=1").Tables[0];
                if (Flow != null)
                {
                    //int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(KeyFlow, Flow, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            DataTable dt = Article as DataTable;
            StringBuilder sb = new StringBuilder();
            DataTable dtflow = Flow as DataTable;

            if (dt != null)
            {
                int count = dt.Rows.Count;
                for (int i = 0; i < count; i++)
                {
                    if (dtflow != null)
                    {
                        DataRow[] dr = dtflow.Select("iIndex=" + i);
                        if (dr.Length > 0)
                        {
                            sb.Append(dr[0]["cHtml"].ToString());
                            if ("2" == dr[0]["iShow"].ToString())
                            {
                                sb.Append("<div class=\"V3Consulth V3Consulthm\"></div>");
                            }
                        }
                        else
                        {
                            sb.Append("<div class=\"V3Consulth\"></div>");
                        }
                    }
                    sb.Append("<div class=\"V3Consult\">");
                    sb.Append("<a class=\"V3TopTip\" target=\"_blank\" href=\"/Channels/list.aspx?id=" + dt.Rows[i]["idClass"].ToString() + "\">" + dt.Rows[i]["cClassName"].ToString() + "</a>");
                    sb.Append("<a target=\"_blank\" href=\"" + dt.Rows[i]["cLinkUrl"].ToString() + "\">");
                    sb.Append("<img src=\"/Html/images/blank.gif\" data-echo=\"" + dt.Rows[i]["cImageUrl"].ToString().Replace(HostInfo.imgName, HostInfo.imgCDN) + "\">");
                    sb.Append("<h3>" + dt.Rows[i]["cTitle"].ToString() + "</h3>");
                    sb.Append("</a>");
                    if (dt.Rows[i]["iType"].ToString() == "1")//����
                    {
                        sb.Append("<em>by: <a target=\"_blank\" class=\"listusername\" href=\"/user/" + dt.Rows[i]["idUser"].ToString() + ".aspx\">" + dt.Rows[i]["cNickName"].ToString() + "</a></em>" + DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)) + "");
                        sb.Append("<p>" + dt.Rows[i]["cBio"].ToString() + "</p>");
                    }
                    else if (dt.Rows[i]["iType"].ToString() == "2")//���±���
                    {
                        sb.Append(DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)));
                        sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString());
                        if ("1" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/projects.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=2\">��������</a>");
                        }
                        else if ("2" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/result.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=6\">�ɼ���ѯ</a>");
                        }
                        else if ("3" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/gallery.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=11\">�鿴���</a>");
                        }
                        else if ("4" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/hotel.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=4\">�鿴�Ƶ�</a>");
                        }
                        else if ("5" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/equipment.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=8\">�鿴װ��</a>");
                        }
                        sb.Append("</p>");

                        //sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString() + "<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/projects.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=2\">��������</a></p>");
                    }
                    else if (dt.Rows[i]["iType"].ToString() == "3")//Լ��
                    {
                        sb.Append(DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)));
                        sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString() + "<a class=\"V3ConsultButtom\" target=\"_blank\" href=\"" + dt.Rows[i]["cLinkUrl"].ToString() + "\">��������</a></p>");
                    }
                    else if (dt.Rows[i]["iType"].ToString() == "4")//ƴ��
                    {
                        sb.Append(DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)));
                        sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString() + "<a class=\"V3ConsultButtom\" target=\"_blank\" href=\"\">����ƴ��</a></p>");
                    }
                    sb.Append("</div>");
                    //if (i != dt.Rows.Count-1)
                    //    sb.Append("<div class=\"V3Consulth\"></div>");
                }
            }
            ltlBlog.Text = sb.ToString();
            #endregion
            #region �Ƽ��û�
            //string KeyUser = "IndexUser";
            //object UserList = Erun360.Common.DataCache.GetCache(KeyUser);
            //if (UserList == null)
            //{
            //    DB3.tblRecom bll = new DB3.tblRecom();
            //    UserList = bll.GetList(15, "cState=1", " NEWID()").Tables[0];
            //    if (Article != null)
            //    {
            //        int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
            //        Erun360.Common.DataCache.SetCache(KeyUser, UserList, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
            //    }
            //}
            //DataTable dtUser = UserList as DataTable;
            //for (int i = 0; i < dtUser.Rows.Count; i++)
            //{
            //    DBM1.tblMEMBER model = new DB1.tblMEMBER().GetModel(TypeChangeDefault.NullToInt(dtUser.Rows[i]["idUser"], 0));
            //    if (model != null)
            //    {
            //        ltlUser.Text += "<div class=\"V3HotUser\"><i>" + UserStyle(TypeChangeDefault.NullToInt(dtUser.Rows[i]["cType"], 0)) + "</i><a href=\"/user/" + dtUser.Rows[i]["idUser"].ToString() + ".aspx\"><img src=\"" + model.cAvatar + "\"><span>" + model.cNickName + "</span></a><p>" + dtUser.Rows[i]["cBio"].ToString() + "</p><em data-id=\"" + dtUser.Rows[i]["idUser"].ToString() + "\">��עTA</em></div>";
            //    }
            //}
            #endregion
            #region �Ҳ�ƴ�Ų�Ʒ
            DB1.tblGoods Bll = new DB1.tblGoods();
            DataTable dttour = Bll.GetList(3, "iState=1 and iType =2 and  dEndTime>GETDATE()", "id desc").Tables[0];
            for (int i = 0; i < dttour.Rows.Count; i++)
            {
                int idGood = TypeChange.NullToInt(dttour.Rows[i]["id"].ToString(), 0);
                ltlTour.Text += " <div class=\"V3RiP\">";
                ltlTour.Text += " <a target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + dttour.Rows[i]["id"].ToString() + "\">" + Getems(idGood.ToString()) + dttour.Rows[i]["cName"].ToString() + GetScore(dttour.Rows[i]["fScore"].ToString()) + "</a> <br>";
                //ltlTour.Text += " <a href=\"/GroupBuy/Group.aspx?id=" + dttour.Rows[i]["id"].ToString() + "\">������ɱ��" + dttour.Rows[i]["cName"].ToString() + " <span>���ֵֿ�</span></a> <br>";
                ltlTour.Text += "ƴ�żۣ�<em>��" + GetTour(idGood.ToString()) + "<i>(" + Getzk(idGood.ToString(), dttour.Rows[i]["fMarketPrice"].ToString()) + "��)</i></em>";
                ltlTour.Text += "<a target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + idGood + "\"><img src=\"/Html/images/blank.gif\" data-echo=\"" + dttour.Rows[i]["cImage"].ToString().Replace(HostInfo.imgName, HostInfo.imgCDN) + "\"></a>";
                ltlTour.Text += "<a class=\"V3RiPB\" target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + idGood + "\">����ƴ��</a>";
                ltlTour.Text += "</div>";
            }
            #endregion
        }
    }
    #region ƴ��
    //ƴ����ͼ۸�
    public string GetScore(string fScore)
    {
        if (fScore == "1")
            return "<span>���ֵֿ�</span>";
        return "";
    }
    //ƴ����ͼ۸�
    public string GetTour(string idGood)
    {
        DataTable dt = tourBll.GetList(1, "idGood=" + idGood, "fBuyPrice").Tables[0];
        if (dt.Rows.Count == 0)
            return "";
        return dt.Rows[0]["fBuyPrice"].ToString();
    }
    //����ɱ
    public string Getems(string idGood)
    {
        int ems = tourBll.GetRecordCount("idGood=" + idGood);
        if (ems == 1)
            return "������ɱ��";
        return "";
    }
    //�ۿ�
    public string Getzk(string idGood, string MarketPrice)
    {
        DataTable dt = tourBll.GetList(1, "idGood=" + idGood, "fBuyPrice").Tables[0];
        if (dt.Rows.Count == 0)
            return "";
        decimal mp = TypeChangeDefault.NullToDecimal(MarketPrice, 1);
        if (mp == 0)
        {
            mp = 1;
        }

        return (TypeChangeDefault.NullToDecimal(dt.Rows[0]["fBuyPrice"], 0) / mp * 10).ToString("f");
    }
    #endregion

    //ʹ��C#�ѷ����ʱ���Ϊ������,����ǰ,��Сʱǰ,������ǰ,����ǰ
    public string DateStringFromNow(DateTime dt)
    {
        TimeSpan span = DateTime.Now - dt;
        if (span.TotalDays > 60)
        {
            return Convert.ToDateTime(dt).ToString("yyyy-MM-dd");
        }
        else
        {
            if (span.TotalDays > 30)
            {
                return
                "1����ǰ";
            }
            else
            {
                if (span.TotalDays > 14)
                {
                    return
                    "2��ǰ";
                }
                else
                {
                    if (span.TotalDays > 7)
                    {
                        return
                        "1��ǰ";
                    }
                    else
                    {
                        if (span.TotalDays > 1)
                        {
                            return
                            string.Format("{0}��ǰ", (int)Math.Floor(span.TotalDays));
                        }
                        else
                        {
                            if (span.TotalHours > 1)
                            {
                                return
                                string.Format("{0}Сʱǰ", (int)Math.Floor(span.TotalHours));
                            }
                            else
                            {
                                if (span.TotalMinutes > 1)
                                {
                                    return
                                    string.Format("{0}����ǰ", (int)Math.Floor(span.TotalMinutes));
                                }
                                else
                                {
                                    if (span.TotalSeconds >= 1)
                                    {
                                        return
                                        string.Format("{0}��ǰ", (int)Math.Floor(span.TotalSeconds));
                                    }
                                    else
                                    {
                                        return
                                        "1��ǰ";
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    private string UserStyle(int cType)
    {
        string Style = string.Empty;
        switch (cType)
        {
            case 1: Style = "��Լר��"; break;
            case 2: Style = "��������"; break;
            case 3: Style = "��������"; break;
            case 4: Style = "��������"; break;
        }
        return Style;
    }
}