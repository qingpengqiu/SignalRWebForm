
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

    #region ���ݳ�ʼ�� 

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
    /// �б����ϣ���ݳ�ʼ��
    /// </summary>
    private static void Initialize()
    {
        if (!CacheHelper.Get("CACHE_COMMON_CONTROLS", out Items))
        {
            Items = new List<GControlInfo>();
            hash = new Hashtable();

            // �Ա�
            Index = 0;
            Items.Add(Append("idGender", "", "��"));
            Items.Add(Append("idGender", "", "Ů"));

            // ֤������
            Index = 0;
            Items.Add(Append("idNationIdType", "", "���֤"));
            Items.Add(Append("idNationIdType", "", "����"));
            Items.Add(Append("idNationIdType", "", "����֤"));
            Items.Add(Append("idNationIdType", "", "����֤��"));
            
            // Ѫ��
            Index = 0;
            Items.Add(Append("idBlood", "", "A��"));
            Items.Add(Append("idBlood", "", "B��"));
            Items.Add(Append("idBlood", "", "O��"));
            Items.Add(Append("idBlood", "", "AB��"));
            Items.Add(Append("idBlood", "", "����"));

            // ���ѧ��
            Index = 0;
            Items.Add(Append("idEducation", "", "��ѧ"));
            Items.Add(Append("idEducation", "", "˶ʿ"));
            Items.Add(Append("idEducation", "", "��ʿ"));
            Items.Add(Append("idEducation", "", "��ר/רְ"));
            Items.Add(Append("idEducation", "", "��ר/�м�"));
            Items.Add(Append("idEducation", "", "��ѧ"));
            Items.Add(Append("idEducation", "", "Сѧ"));

            // ��������
            Index = 0;
            Items.Add(Append("idQuestion", "", "���ֻ�����ĺ�6λ"));
            Items.Add(Append("idQuestion", "", "��ĸ�׵�����"));
            Items.Add(Append("idQuestion", "", "�Ҹ��׵�����"));
            Items.Add(Append("idQuestion", "", "�ҵ��ܲ�����"));
            Items.Add(Append("idQuestion", "", "�ҵ�һ�������ɳɼ�"));
            Items.Add(Append("idQuestion", "", "�ҵ�һ�βμ������ɵ�ʱ��"));
            Items.Add(Append("idQuestion", "", "�ҵ�һ�βμ������ɵ�����"));
            Items.Add(Append("idQuestion", "", "����ϲ������Ь�ͺ�"));
            Items.Add(Append("idQuestion", "", "����ϲ�����ܲ�����"));
            Items.Add(Append("idQuestion", "", "����ϲ�����ܲ��ص�"));
            Items.Add(Append("idQuestion", "", "����ϲ����С˵"));

            // ����ְҵ
            Index = 0;
            Items.Add(Append("idOccupation", "", "ũ��ҵ"));
            Items.Add(Append("idOccupation", "", "��ҵ"));
            Items.Add(Append("idOccupation", "", "ľ��ɭ��ҵ"));
            Items.Add(Append("idOccupation", "", "��ҵ�ɾ�ҵ"));
            Items.Add(Append("idOccupation", "", "��ͨ����ҵ"));
            Items.Add(Append("idOccupation", "", "��������ҵ"));
            Items.Add(Append("idOccupation", "", "��������"));
            Items.Add(Append("idOccupation", "", "����ӹ�ά��ҵ"));
            Items.Add(Append("idOccupation", "", "������ҵ"));
            Items.Add(Append("idOccupation", "", "ҽҩ��������"));
            Items.Add(Append("idOccupation", "", "����ҵ"));
            Items.Add(Append("idOccupation", "", "�Ľ̻���"));
            Items.Add(Append("idOccupation", "", "�ڽ̻���"));
            Items.Add(Append("idOccupation", "", "������ҵ"));
            Items.Add(Append("idOccupation", "", "һ������"));
            Items.Add(Append("idOccupation", "", "����ҵ"));
            Items.Add(Append("idOccupation", "", "��ͥ����"));
            Items.Add(Append("idOccupation", "", "���취"));
            Items.Add(Append("idOccupation", "", "����"));
            Items.Add(Append("idOccupation", "", "ITҵ"));
            Items.Add(Append("idOccupation", "", "ְҵ�˶�Ա"));
            Items.Add(Append("idOccupation", "", "����ְҵ"));
            Items.Add(Append("idOccupation", "", "��ְҵ"));

            // ��������
            Index = 0;
            Items.Add(Append("idCompeteStyle", "", "U����������"));
            Items.Add(Append("idCompeteStyle", "", "Mȫ��������"));
            Items.Add(Append("idCompeteStyle", "", "H���������"));
            Items.Add(Append("idCompeteStyle", "", "R·��"));
            Items.Add(Append("idCompeteStyle", "", "CԽҰ��"));
            Items.Add(Append("idCompeteStyle", "", "T����"));

            // Լ�ܵ�·����
            Index = 0;
            Items.Add(Append("idRoadStyle", "", "��԰"));
            Items.Add(Append("idRoadStyle", "", "�ﾶ��"));
            Items.Add(Append("idRoadStyle", "", "��·"));
            Items.Add(Append("idRoadStyle", "", "ɽ·"));
            Items.Add(Append("idRoadStyle", "", "�ܲ���"));
            Items.Add(Append("idRoadStyle", "", "����"));

            // ��Ա����
            Index = 0;
            Items.Add(Append("idMemberStyle", "", "��Ա"));
            Items.Add(Append("idMemberStyle", "", "VIP��Ա"));
            Items.Add(Append("idMemberStyle", "", "��ҵ��Ա"));
            Items.Add(Append("idMemberStyle", "", "ר��"));
            Items.Add(Append("idMemberStyle", "", "����"));
            Items.Add(Append("idMemberStyle", "", "���ֲ�������"));

            // ����Ա����
            Items.Add(Append("idAdminStyle", "11", "�༭"));
            Items.Add(Append("idAdminStyle", "12", "�ܱ�"));
            Items.Add(Append("idAdminStyle", "13", "��Ϣ����Ա"));
            //Items.Add(Append("idAdminStyle", "99", "��������Ա"));
            
            // ��ǰ����
             Index = 0;
            Items.Add(Append("cRunNow", "", "1.6����"));
            Items.Add(Append("cRunNow", "", "5����"));
            Items.Add(Append("cRunNow", "", "8����"));
            Items.Add(Append("cRunNow", "", "10����"));
            Items.Add(Append("cRunNow", "", "15����"));
            Items.Add(Append("cRunNow", "", "20����"));
            Items.Add(Append("cRunNow", "", "���������"));
            Items.Add(Append("cRunNow", "", "ȫ��������"));

            // ѵ��Ŀ��
             Index = 0;
            Items.Add(Append("cRunDestination", "", "1.6����"));
            Items.Add(Append("cRunDestination", "", "5����"));
            Items.Add(Append("cRunDestination", "", "8����"));
            Items.Add(Append("cRunDestination", "", "10����"));
            Items.Add(Append("cRunDestination", "", "15����"));
            Items.Add(Append("cRunDestination", "", "20����"));
            Items.Add(Append("cRunDestination", "", "���������"));
            Items.Add(Append("cRunDestination", "", "ȫ��������"));

            // ѵ��ǿ��
            Index = 0;
            Items.Add(Append("cTrainStyle", "", "ά����״"));
            Items.Add(Append("cTrainStyle", "", "�Ȳ����"));
            Items.Add(Append("cTrainStyle", "", "�������"));
            Items.Add(Append("cTrainStyle", "", "�������"));

            // ÿ������
            Index = 0;
            Items.Add(Append("cRunWeek", "", "10-18����"));
            Items.Add(Append("cRunWeek", "", "18-26����"));
            Items.Add(Append("cRunWeek", "", "26-34����"));
            Items.Add(Append("cRunWeek", "", "34-42����"));
            Items.Add(Append("cRunWeek", "", "42-50����"));
            Items.Add(Append("cRunWeek", "", "50-58����"));
            Items.Add(Append("cRunWeek", "", "58-66����"));
            Items.Add(Append("cRunWeek", "", "66-74����"));
            Items.Add(Append("cRunWeek", "", "74-82����"));
            Items.Add(Append("cRunWeek", "", "82-90����"));
            Items.Add(Append("cRunWeek", "", "90-98����"));
            Items.Add(Append("cRunWeek", "", "98-106����"));
            Items.Add(Append("cRunWeek", "", "106-114����"));
            Items.Add(Append("cRunWeek", "", "114-122����"));
            Items.Add(Append("cRunWeek", "", "122-130����"));

            CacheHelper.Save("CACHE_COMMON_CONTROLS", Items);
        }
    }

    #endregion

    /// <summary>
    /// ���ֶ�����ʾΪҳ��ؼ�(SELECT,RADIO,CHECKBOX)
    /// </summary>
    /// <param name="Caption">����</param>
    /// <param name="controlStyle">�ؼ�����</param>
    /// <param name="controlName">�ؼ�ID</param>
    /// <param name="defaultValue">Ĭ��ֵ</param>
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
    /// ���ֶ���+�ֶ���ֵ���ٲ��������Ϣ
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
        string w = "����,����,�쵰,����,����,��,����,�,������,��,�Խ�,����,����,������,�Ը�,��վ,����,���־,����,http,sex,www,fuck,���ⰴĦһ��������,С�÷����,С�����ŷ���,С�ÿ��԰�ҹ����,��������,�󱣽�, ��Ů��,������Ů,����Ů,�д�ѧ��,�Ҽ�,����Ů,��С��,��ȫ��,��ɫŮ,�Ұ�Ħ,����ΧŮ,�ҷ���,������,�˿�,�� ��,����,�齫,�ƾ�,��Ͳ��,�����,�����,����,����,����,ȸ��,�ƺְ�,����,���,ȥ��,GAY,Ԯ��,¥��,Լ��,���,���,��Ů,����,����,�� ��,С ��,һҹ��,ѧ����,����֢,���֢,�˰���,������,վ��Ů,ͬ־�绰����,��Ů��ҹ, �ļ��,��ҩ��,������,�Ի�ҩ,����ҩ,����ҩ,����ҩ,������,������ˮ,��������,Ů�ô�ҩ,���Ű�Ħ,�Ƶ갴Ħ, ���ÿ�����,���ÿ�����,���ÿ�ȡ��,���ÿ��滹,���ѻ���,�������,˿�����,Ů������,Ůū����,��ҵ��ʾ, ���ε�ҩ,�绰�Ƕ���,ͨ����¼,ͨ���嵥,�绰�嵥,΢�ż�¼,�Ƶ��¼,������¼,���ż�¼,���ŷ���¼,��ʷ��¼,�ǼǼ�¼,��ס��¼,ס�޼�¼,ס���嵥,������˹�ٷ�,�Ѫ����Ů,��Ѫ����Ů,��Ѫ����Ů,��Ѫ����Ů,��̥���Ա�,������Ʊ,С�㻯����,ʦ�����,�й����,�Ƽ����,�������,����ʯ,����ʯ,�ν�ʯ,������,����ˮ,����ʯ,����ʯ,���ʯ,���ҽ�ʯ,���ܽ�ʯ,���ܹܽ�ʯ,�෢�Խ�ʯ,��ʯ��ҽԺ,������ʯ,������ʯ,���ƽ�ʯ,��ʯҽԺ,����ҽԺ,����ȡʯ,���Ҷ���,����Ϣ������,��õ�ҽԺ,��ʯ�۸�,�������ʯ,��ְС��,��С��,С��ȫ,С����ȫ,ˢƱ,������,�����¼,����,���ݷ���,�м���,������,���ѹ�,�ӹ�Ϣ��,�ӹ���Ĥ,��ǻ���,�ഺ��,�ٶ���¼,΢������,΢����ɾ��,�ָ��ֻ�,ɾ���ֻ�,΢����ô��,QQ����,QQ�ܱ�,QQ����,QQ����,QQ����,qq��͵,QQ�ű���,�Ϲ���qq,Ů���ѵ�QQ,�ܲ�QQ,İİ����,����,������,͵͵�鿴,��λһ����,��λ����,�ֻ�ͨѶ,�ֻ��嵥,�����嵥,͵�����˼�¼,��绰��β���͵��,�ڸ�˭����,����ð��,��Ϣ��¼,�Ϲ���С��,��İ��Ů������";
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
        string w = "admin,������,������,�¼ұ�,ë��,�ܶ���,���,&,ϰ��ƽ,������,����,��,ʺ,����,�쵰,ɵ,ƨ,����,����,��,����,�,��,��,��,�Խ�,����,����,������,�Ը�,��վ,����,���־,��վ,���³�,�ܲ�,����,����,http,sex,www,fuck,���ܣ�erun360";
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
        string w = "����,����,����,��,�Խ�,����,����,������,�Ը�,���־";
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
    /// ʱ����ҳ��ؼ�
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
        if (speed > 22.0) sb.AppendLine("<img src=\"/images/afraid.gif\" style=\"margin-bottom:-2px;\" title=\"�����ٶ�̫�ֲ��ˣ�\">");
        else if (speed > 12.0) sb.AppendLine("<img src=\"/images/star.gif\" style=\"margin-bottom:-2px;\"><img src=\"/images/star.gif\" style=\"margin-bottom:-2px;\"><img src=\"/images/star.gif\" style=\"margin-bottom:-2px;\">");
        else if (speed > 7.0) sb.AppendLine("<img src=\"/images/star.gif\" style=\"margin-bottom:-2px;\"><img src=\"/images/star.gif\" style=\"margin-bottom:-2px;\">");
        else if (speed > 4.0) sb.AppendLine("<img src=\"/images/star.gif\" style=\"margin-bottom:-2px;\">");
        else sb.AppendLine("<img src=\"/images/slow.gif\" style=\"margin-bottom:-2px;\" title=\"������\">");

        return sb.ToString();
    }
}
