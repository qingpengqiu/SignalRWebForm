using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Temp_List : System.Web.UI.Page
{
    public string PageBuffer = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        /*
        int pc = 0;
        Images images = new Images();
        Blog blogs = new Blog();
        List<BlogInfo> list = blogs.PageList(0, 1, "", "", out pc);
        StringBuilder sb = new StringBuilder();
        foreach(BlogInfo bu in list)
        {
            if(bu.cContent.Contains("[IMG]"))
            {
                string ct = bu.cContent.Replace("[IMG]", "\n[IMG]http://img.erun360.com").Replace("/Uploads/","/uploads/2012-09-24/");
                
                string[] ca = ct.Split('\n');
                foreach(string cv in ca)
                {
                    if(cv.StartsWith("[IMG]"))
                    {
                        string url = cv.Replace("[IMG]","").Replace("[/IMG]","").ToLower();
                        sb.AppendLine("<b>ADD IMAGES " + url + "</b><br>" );

                        ImagesInfo img = new ImagesInfo();
                        img.idUser = bu.idUser;
                        img.idInfo = bu.id;
                        img.cImageUrl = url;
                        int result = 0;
                        //images.Insert(img, out result);
                    }
                }

                sb.AppendLine( bu.id + " " + bu.idUser + " " + bu.cTitle + "<br>" + ct + "<br><br>");

                //blogs.UpdateByCommand(bu.id, "cContent='" + ct + "'");

            }
        }
        PageBuffer = sb.ToString();
        */

        
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("[FLASH]http://player.youku.com/player.php/sid/XMjIxMzkxMzc2/v.swf[/FLASH]");
        sb.AppendLine("ԭ���ܲ�����");
        sb.AppendLine("������Щ5�����������ȫ���ں���Ӯ�������ٶȵ�ѵ����Ȼ����Ҫ�����������������Ϸ��ӳ����ˮƽ����������벨�����ܲ��������ݸ�����������̸����������������5���������ٶȣ��Լ��ܲ�������α����ٶ�ѵ����һЩ�����Ĵ���");
        sb.AppendLine("[IMG]http://img.erun360.com/utility/uploads/2012-09-26/100000004_150403.gif[/IMG]");
        sb.AppendLine("���뱣֤�ٶ���");
        sb.AppendLine("�ٶ�ѵ����ֻ��ǿ���죬��Ҫ�������5����ѵ����Ŀ�ķַ����롣������˵���ٶ�ѵ�����˶�Ա��ø�ǿ׳����Ѹ�١�����Ч���ܲ��ң���೤���˶�Ա������ʱ�ٽ�ϣ����Ǵ����ü������ͻָ�ʱ������⡣ ");
        sb.AppendLine("��ֹ����");
        sb.AppendLine("�����ܲ������ڼ���Ϸ������磬��Щ�μ�5����ѵ�����ˣ���Ӣ��Ϊ�����λ����ʵ����̫���ˣ�����ѵ��������Ҫ����ٶȡ���ͬ���ĵ���һλ�����ɲ����߲�����Ϊ�������׶��ܺܿ죬������������ȥ�������ɡ���Ϣ������ǵڶ����׷��Ĵ��󡣲�����˵���������ڼ�Ъ�ڼ䣬��δ�ú���Ϣ��������û��ȫ�ָ���Ҫ��ʼ��һ��ѵ�����������������ˡ���");
        sb.AppendLine("�幫�������ٶ�ѵ����");
        sb.AppendLine("[IMG]http://img.erun360.com/utility/uploads/2012-10-08/100000004_111322.jpg[/IMG]");
        sb.AppendLine("�������Ƽ����ٶ�ѵ��������ʲô����ѵ���˶�Ա�ķ����С����ݷ����������5�������һ��800�ס�400�ס�200�ף�����һ��200�ס�400�ס�800�ף����������������ӣ���·���ѳ�����1.5Ӣ��ǳ��ʺ�5�����ٶ�ѵ����������ϲ�����ֽ���ѵ����ʽ��������ͬʱǿ�����ٶȸ����������Ҽ���仯�������������ѵ��ʱ�������ġ�");
        sb.AppendLine("�ָ���������Ҫ��");
        sb.AppendLine("����ѵ����ǿ��Ҫ��ܴ󣬾�����һ���ܽ���һ�Σ������˶�Ա��������ȷ������ļ��ʱ�䡣���ݸ����������ر�������������ȥ�����������ٶ�ѵ����һ��ʼ���ܻ���ּ�����ʹ��ѵ��������ý���һ�ζ̾�������ܡ������첻Ҫ���κ��˶����ú���Ϣ������ָ����� ��");
        sb.AppendLine("[IMG]http://img.erun360.com/utility/uploads/2012-09-26/100000004_150112.jpg[/IMG]");

        //PageBuffer = UBB.ToHtml(sb.ToString());
        PageBuffer = UBB.Clear(sb.ToString());
        

        //StringBuilder sb = new StringBuilder();
        //sb.AppendLine("[MOOD=15][MOOD=13]");
        //PageBuffer = UBB.MoodToHtml(sb.ToString());
    }
}
