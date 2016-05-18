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
        sb.AppendLine("原地跑步减肥");
        sb.AppendLine("尽管有些5公里参赛者完全不在乎输赢，但是速度的训练依然很重要，它能让你在赛场上发挥出最佳水平。最近，我与波特兰跑步教练珍妮弗·伯宁罕交谈过，请教她如何练就5公里完美速度，以及跑步新手如何避免速度训练中一些常见的错误。");
        sb.AppendLine("[IMG]http://img.erun360.com/utility/uploads/2012-09-26/100000004_150403.gif[/IMG]");
        sb.AppendLine("必须保证速度吗？");
        sb.AppendLine("速度训练不只是强调快，还要充分利用5公里训练项目的分分秒秒。伯宁罕说：速度训练让运动员变得更强壮、更迅速、更高效。很不幸，许多长跑运动员都忽视时速结合，总是处理不好间隔距离和恢复时间的问题。 ");
        sb.AppendLine("禁止事项");
        sb.AppendLine("许多的跑步者总在间隔上犯错。例如，有些参加5公里训练的人，以英里为间隔单位，这实在是太长了，很难训练出比赛要求的速度。”同样的道理，一位马拉松参赛者不会因为他两百米短跑很快，就信心满满地去跑马拉松。休息不充分是第二个易犯的错误。伯宁罕说：“他们在间歇期间，并未好好休息，体力还没完全恢复就要开始下一轮训练，这样很容易受伤。”");
        sb.AppendLine("五公里完美速度训练。");
        sb.AppendLine("[IMG]http://img.erun360.com/utility/uploads/2012-10-08/100000004_111322.jpg[/IMG]");
        sb.AppendLine("伯宁罕推荐的速度训练方案是什么？她训练运动员的方法叫“阶梯法”。如果跑5公里，先跑一次800米、400米、200米，再跑一次200米、400米、800米，先下梯子再爬梯子，总路程已超过了1.5英里，非常适合5公里速度训练。伯宁罕喜欢这种阶梯训练方式，它不仅同时强化了速度跟耐力，而且间隔变化多样，让你独自训练时不再无聊。");
        sb.AppendLine("恢复体力很重要。");
        sb.AppendLine("这种训练的强度要求很大，尽量隔一两周进行一次，根据运动员的年龄来确定具体的间隔时间。珍妮弗·伯宁罕特别嘱咐：如果你过去不经常进行速度训练，一开始可能会出现肌肉酸痛。训练过后，最好进行一次短距离的慢跑。第三天不要做任何运动，好好休息让身体恢复过来 。");
        sb.AppendLine("[IMG]http://img.erun360.com/utility/uploads/2012-09-26/100000004_150112.jpg[/IMG]");

        //PageBuffer = UBB.ToHtml(sb.ToString());
        PageBuffer = UBB.Clear(sb.ToString());
        

        //StringBuilder sb = new StringBuilder();
        //sb.AppendLine("[MOOD=15][MOOD=13]");
        //PageBuffer = UBB.MoodToHtml(sb.ToString());
    }
}
