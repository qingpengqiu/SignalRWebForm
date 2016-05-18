
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    public partial class Groups : SQLHelper
    {
        private ArrayList cmds = new ArrayList();
        Random rnd = new Random();

        #region ��������(��ɾ��)
		
        private void Append(int id, string title, int score)
        {
            GroupsInfo g = new GroupsInfo();
            g.id = id;
            g.cTitle = title;
            g.iScore = score;

            if (id > 100000000 && id < 200000000) g.cDescription = "���ֱ���";
            if (id > 200000000 && id < 300000000) g.cDescription = "װ���������";
            if (id > 300000000 && id < 400000000) g.cDescription = "��Ŀ����";
            if (id > 600000000 && id < 700000000) g.cDescription = "װ��Ʒ�Ʊ���";

            cmds.Add(InsertSql(g));
        }

        private void Initialize()
        {
            cmds.Clear();
            cmds.Add("DELETE FROM " + Database + ";");

            Append(300100100, "��ҳ", 0);
            Append(300101100, "�л�����", 0);
            Append(300102100, "�Ҳ�ר��", 0);
            Append(300102110, "�Ҳ�ר��1", 0);
            Append(300102120, "�Ҳ�ר��2", 0);
            Append(300102130, "�Ҳ�ר��3", 0);
            Append(300102140, "�Ҳ�ר��4", 0);
            Append(300111100, "ѵ��", 0);
            Append(300112100, "Ь��װ��", 0);
            Append(300113100, "�������", 0);
            Append(300114100, "Ӫ��������", 0);
            Append(300115100, "��������", 0);
            Append(300116100, "�ܲ�����", 0);
            Append(300117100, "���¡�����", 0);
            Append(300118100, "�������ָ�", 0);
            Append(300130100, "������Ƶ", 0);
            Append(300140100, "����ͼƬ", 0);

            Append(301100100, "ѵ��", 0);
            Append(301101100, "�л�����", 0);
            Append(301102100, "�Ҳ�ר��", 0);
            Append(301102110, "�Ҳ�ר��1", 0);
            Append(301102120, "�Ҳ�ר��2", 0);
            Append(301102130, "�Ҳ�ר��3", 0);
            Append(301111100, "5/10KM", 0);
            Append(301112100, "ԽҰ��", 0);
            Append(301113100, "���������", 0);
            Append(301114100, "ȫ��������", 0);
            Append(301115100, "�ܲ�����", 0);
            Append(301116100, "ר��ѵ��", 0);

            Append(302100100, "���¡�����", 0);
            Append(302101100, "�л�����", 0);
            Append(302102100, "�Ҳ�ר��", 0);
            Append(302102110, "�Ҳ�ר��1", 0);
            Append(302102120, "�Ҳ�ר��2", 0);
            Append(302102130, "�Ҳ�ר��3", 0);
            Append(302111100, "��������", 0);
            Append(302112100, "��������", 0);
            Append(302113100, "ԽҰ����", 0);
            Append(302114100, "���ڸ���", 0);

            Append(303100100, "Ь��װ��", 0);
            Append(303101100, "�л�����", 0);
            Append(303102100, "�Ҳ�ר��", 0);
            Append(303102110, "�Ҳ�ר��1", 0);
            Append(303102120, "�Ҳ�ר��2", 0);
            Append(303102130, "�Ҳ�ר��3", 0);
            Append(303111100, "��·��Ь", 0);
            Append(303112100, "ԽҰ��Ь", 0);
            Append(303113100, "��װ", 0);
            Append(303114100, "���", 0);

            Append(304100100, "Ӫ��������", 0);
            Append(304101100, "�л�����", 0);
            Append(304102100, "�Ҳ�ר��", 0);
            Append(304102110, "�Ҳ�ר��1", 0);
            Append(304102120, "�Ҳ�ר��2", 0);
            Append(304102130, "�Ҳ�ר��3", 0);
            Append(304111100, "��ʳ", 0);
            Append(304112100, "����", 0);

            Append(305100100, "�������ָ�", 0);
            Append(305101100, "�л�����", 0);
            Append(305102100, "�Ҳ�ר��", 0);
            Append(305102110, "�Ҳ�ר��1", 0);
            Append(305102120, "�Ҳ�ר��2", 0);
            Append(305102130, "�Ҳ�ר��3", 0);
            Append(305111100, "�����ܲ�", 0);
            Append(305112100, "�˲��ָ�", 0);
            Append(305113100, "�������", 0);
            Append(305114100, "����", 0);

            Append(311100100, "��������", 0);
            Append(311101100, "�л�����", 0);
            Append(311102100, "�Ҳ�ר��", 0);
            Append(311102110, "�Ҳ�ר��1", 0);
            Append(311102120, "�Ҳ�ר��2", 0);
            Append(311102130, "�Ҳ�ר��3", 0);
            Append(311111100, "Ϊʲô��", 0);
            Append(311112100, "��ο�ʼ", 0);
            Append(311113100, "��һ�α���", 0);
            Append(311114100, "��������", 0);

            Append(312100100, "�������", 0);
            Append(312101100, "�л�����", 0);
            Append(312102100, "�Ҳ�ר��", 0);
            Append(312102110, "�Ҳ�ר��1", 0);
            Append(312102120, "�Ҳ�ר��2", 0);
            Append(312102130, "�Ҳ�ר��3", 0);
            Append(312111100, "��������", 0);
            Append(312112100, "ר��װ��", 0);
            Append(312113100, "ѵ������", 0);
            Append(312114100, "��������", 0);

            Append(313100100, "�ܲ�����", 0);
            Append(313101100, "�л�����", 0);
            Append(313102100, "�Ҳ�ר��", 0);
            Append(313102110, "�Ҳ�ר��1", 0);
            Append(313102120, "�Ҳ�ר��2", 0);
            Append(313102130, "�Ҳ�ר��3", 0);
            Append(313111100, "��������", 0);
            Append(313112100, "�ܲ�Ӣ��", 0);
            Append(313113100, "�ܲ����", 0);
            Append(313114100, "����", 0);

            Append(321100100, "����ר��", 0);
            Append(321111100, "����ר��", 0);
            Append(321112100, "ѵ��ר��", 0);
            Append(321113100, "�˲�ר��", 0);
            Append(321114100, "Ӫ��ר��", 0);
            Append(322100100, "����", 0);

            //Append(200000000, "װ��", 0);
            Append(201000000, "Ь", 0);
            Append(201100000, "�ﾶ����", 0);
            Append(201101000, "�ﾶ����", 0);
            Append(201102000, "��·��", 0);
            Append(201103000, "ԽҰ��", 0);
            Append(202000000, "��װ", 0);
            Append(202100000, "���䡤����", 0);
            Append(202101000, "����", 0);
            Append(202102000, "����", 0);
            Append(202103000, "�̿�", 0);
            Append(202104000, "���ӡ������", 0);
            Append(202105000, "�пˡ����", 0);
            Append(202106000, "����", 0);
            Append(202107000, "���ӡ�Ь��", 0);
            Append(202108000, "ѹ�����ָ�", 0);
            Append(203000000, "���", 0);
            Append(203100000, "���Ӳ�Ʒ", 0);
            Append(203100100, "GPS", 0);
            Append(203100101, "����", 0);
            Append(203100102, "�ֱ�", 0);
            Append(203101000, "����", 0);
            Append(203101100, "����������Ƭ", 0);
            Append(203101101, "��Ʒ����Һ", 0);
            Append(203101102, "������", 0);
            Append(203102000, "���ס�����", 0);
            Append(203103000, "����������", 0);
            Append(203104000, "�顤DVD", 0);
            Append(203105000, "����", 0);
            Append(203106000, "ñ�ӡ�ͷ��", 0);
            Append(203107000, "��ˮϵͳ", 0);
            Append(203108000, "���⡤����", 0);
            Append(203109000, "��������", 0);
            Append(203110000, "Ь��", 0);
            Append(203111000, "�˶���", 0);
            Append(203112000, "̫����", 0);

            Append(100800100, "ע��", 20);                  //�����Σ�
            Append(100800101, "�ϴ�ͷ��", 5);               //�����Σ�
            Append(100800102, "��������", 10);              //�����Σ�
            Append(100800103, "ÿ�յ�¼", 1);               //��ÿ�죩
            Append(100800104, "��д������Ϣ", 5);           //�����Σ�
            Append(100800105, "��д���/����", 5);          //�����Σ�
            //Append(100800106, "��д���ͣ����Σ�", 5);     //
            Append(100800107, "������", 5);               //��ÿƪ��
            Append(100800108, "���ı�ɾ��", -25);           //��ÿƪ��
            Append(100800109, "��������/�ظ�", 1);          //��ÿ�Σ�
            Append(100800110, "���۱�ɾ��", -5);            //��ÿ�Σ�
            Append(100800111, "���µ���Ŀ", 20);            //��ÿ�Σ�
            Append(100800112, "���µ���ҳ", 50);            //��ÿ�Σ�
            Append(100800113, "����Լ��", 5);               //��ÿ�Σ�
            Append(100800114, "Լ�ܳɹ��ٰ�", 2);           //��ÿ����һ�˷����߽���һ�Σ�
            Append(100800115, "���������μӣ�Լ��", 3);     //��ÿ�Σ�
            Append(100800116, "�ϴ�ѵ������", 1);           //��ÿ�Σ�
            Append(100800117, "������������", 5);           //��ÿ�Σ�
            Append(100800118, "�����������£�", 5);         //��ÿ��
            Append(100800119, "�ϴ��Լ���װ��", 1);         //��ÿ�Σ�
            Append(100800120, "����װ��", 50);              //��ÿ����
            Append(100800121, "��ע����", 1);               //��ÿ�ˣ�
            Append(100800122, "�����ѹ�ע", 1);             //��ÿ�ˣ�
            Append(100800123, "��ע���¡�������", 1);       //��ÿ�Σ�

            Append(600201000, "ASICS ��ɪʿ", 0);
            Append(600202000, "ADIDAS ���ϴ�˹", 0);
            Append(600203000, "BROOKS ��³��˹", 0);
            Append(600204000, "CAMELBAK �շ�", 0);
            Append(600205000, "COLOMBIA ���ױ���", 0);
            Append(600206000, "CW-X", 0);
            Append(600207000, "ECCO ����", 0);
            Append(600208000, "GARMIN ����", 0);
            Append(600209000, "INOV-8", 0);
            Append(600210000, "JACK WOLFSKIN ��צ", 0);
            Append(600211000, "LA SPORTIVIA", 0);
            Append(600212000, "LAFUMA �ַ�Ҷ", 0);
            Append(600213000, "MIZUNO ����Ũ", 0);
            Append(600214000, "MONTRAIL", 0);
            Append(600215000, "MOUNTAINHARDWARE ɽ��", 0);
            Append(600216000, "NATHAN", 0);
            Append(600217000, "NIKE �Ϳ�", 0);
            Append(600218000, "NEW BALANCE �°���", 0);
            Append(600219000, "NEWTON", 0);
            Append(600220000, "OAKLEY �¿���", 0);
            Append(600221000, "PEARL IZUMI", 0);
            Append(600222000, "REEBOK ��", 0);
            Append(600223000, "RUDY PROJECT ±��", 0);
            Append(600224000, "SALOMON ������", 0);
            Append(600225000, "SAUCONY ������", 0);
            Append(600226000, "SKECHERS ˹����", 0);
            Append(600227000, "SKINS ˼��˼", 0);
            Append(600228000, "SUUNTO ����", 0);
            Append(600229000, "TECNICA ̩�Ῠ", 0);
            Append(600230000, "TIMEX ����ʱ", 0);
            Append(600231000, "THE NORTH FACE ����", 0);
            Append(600232000, "UNDER AMOR ������", 0);
            Append(600233000, "VFF Ρ��Ȼ", 0);
            Append(600234000, "X-BIONIC", 0);
            Append(600235000, "ZOOT", 0);
            Append(600236000, "2XU", 0);

            SQLHelper.ExecuteSqlTran(cmds);
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
        public string Controls(string controlName, int start, int defaultValue)
        {
            if (Items == null) return _err;

            StringBuilder sb = new StringBuilder();

            sb.AppendLine("<select id=\"" + controlName + "\" name=\"" + controlName + "\" onchange=\"UpdateHistory(this)\">");
            int idx = 0;
            foreach (GroupsInfo gc in Items)
            {
                if (gc.id >= start && gc.id < (start + 100000000))
                {
                    string space = "";
                    if (start == 200000000)
                    {
                        if (gc.id.ToString().Substring(3, 3) != "000") space = "����";
                    }
                    if (start == 300000000)
                    {
                        if (gc.id.ToString().Substring(3, 3) != "100") space = "����";
                    }

                    string caption = "";
                    if (gc.id.ToString().Substring(3, 6) == "102100" || gc.id.ToString().Substring(3, 6) == "100100")
                    {
                        caption = "(��ѡ)";
                    }

                    if (defaultValue == gc.id || (idx == 0 && defaultValue < 1))
                    {
                        sb.AppendLine("\t\t\t\t<option value=\"" + gc.id + "\" selected>" + space + gc.cTitle + caption + "</option>");
                    }
                    else
                    {
                        sb.AppendLine("\t\t\t\t<option value=\"" + gc.id + "\">" + space + gc.cTitle + caption + "</option>");
                    }
                    idx++;
                }
            }
            sb.AppendLine("\t\t\t</select>");
            return sb.ToString();
        }
    }
}
