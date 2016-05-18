using System;   
using System.Text;
using System.Text.RegularExpressions;

/// <summary>   
/// UBB处理类   
/// </summary>   
public static class UBB
{
    /// <summary> 
    /// UBB代码处理函数 
    /// 支持的标记有:
    /// NOW,A,MAIL,B,U,I,COLOR,IMG,FLY,FLASH,FL,LEFT,CENTER,RIGHT,FC,FR,
    /// F12,F14,F16,F20,SIZE,TAB
    /// </summary> 
    /// <returns>输出字符串</returns> 
    public static string ToHtml(string s)
    {
        Regex r;
        Match m;

        #region 时间
        r = new Regex(@"(\[NOW\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), System.DateTime.Now.ToString());
        }
        #endregion

        #region 链接类
        // [A][/A]
        r = new Regex(@"(\[a\])(.+)(\[\/a\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<a href=\"" + m.Groups[2].ToString() + "\" style=\"color:#0000AA;\" target=\"_blank\">" + m.Groups[2].ToString() + "</a>");
        }

        // [MAIL][/MAIL]
        r = new Regex(@"(\[mail\])(.+)(\[\/mail\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<A href=\"mailto:" + m.Groups[2].ToString() + "\" style=\"color:#0000AA;\" target=\"_blank\">" + m.Groups[2].ToString() + "</A>");
        }
        #endregion

        #region 文字修饰类
        // [B][/B]
        r = new Regex(@"(\[b\])(.+)(\[\/b\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<b>" + m.Groups[2].ToString() + "</b>");
        }

        // [U][/U]
        r = new Regex(@"(\[u\])(.+)(\[\/u\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<u>" + m.Groups[2].ToString() + "</u>");
        }

        // [I][/I]
        r = new Regex(@"(\[i\])(.+)(\[\/i\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<i>" + m.Groups[2].ToString() + "</i>");
        }

        // [COLOR=][/COLOR] 
        r = new Regex(@"(\[color=(.+)\])(.+)(\[\/color\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<font color=\"" + m.Groups[2].ToString() + "\">" + m.Groups[3].ToString() + "</font>");
        }
        #endregion

        #region 多媒体类

        // [IMG][/IMG]
        r = new Regex(@"(\[img\])(.+)(\[\/img\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "\r\n<img src=\"" + m.Groups[2].ToString() + "\" border=0 onload=\"imageResize(this)\">\r\n");
        }

        // [ZIP][/ZIP]
        r = new Regex(@"(\[zip\])(.+)(\[\/zip\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<a href=\"" + m.Groups[2].ToString() + "\">点击下载:" + m.Groups[2].ToString() + "</a>");
        }

        // [FLY][/FLY]
        r = new Regex(@"(\[FLY\])(.+)(\[\/FLY\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<marquee width=\"100%\" behavior=alternate scrollamount=3>" + m.Groups[2].ToString() + "</marquee>");
        }

        // [FLASH=][/FLASH]
        //r = new Regex(@"(\[flash=)(\d*?),(\d*?)\](.+)(\[\/flash\])", RegexOptions.IgnoreCase);
        //for (m = r.Match(s); m.Success; m = m.NextMatch())
        //{
        //    s = s.Replace(m.Groups[0].ToString(), "<OBJECT codeBase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0 classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000 width=" + m.Groups[2].ToString() + " height=" + m.Groups[3].ToString() + "><PARAM NAME=movie VALUE=" + m.Groups[4].ToString() + "><PARAM NAME=quality VALUE=high><param name=menu value=false><embed src=" + m.Groups[4].ToString() + " quality=high menu=false pluginspage=http://www.macromedia.com/go/getflashplayer type=application/x-shockwave-flash width=" + m.Groups[2].ToString() + " height=" + m.Groups[3].ToString() + ">" + m.Groups[4].ToString() + "</embed></OBJECT>");
        //}
        r = new Regex(@"(\[flash\])(.+)(\[\/flash\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "\r\n<OBJECT codeBase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000 width=600 height=400><PARAM NAME=movie VALUE=" + m.Groups[2].ToString() + "><PARAM NAME=quality VALUE=high><param name=menu value=false><embed src=" + m.Groups[2].ToString() + " quality=high menu=false pluginspage=http://www.macromedia.com/go/getflashplayer type=application/x-shockwave-flash width=600 height=400></embed></OBJECT>\r\n");
        }

        //// [URL=][/URL]
        //r = new Regex(@"(\[url=)(.+)(\[\/url\])", RegexOptions.IgnoreCase);
        //for (m = r.Match(s); m.Success; m = m.NextMatch())
        //{
        //    s = s.Replace(m.Groups[0].ToString(), "<a href=\"" + m.Groups[2].ToString() + "\"></a>");
        //}
        #endregion

        #region 字体对齐方式
        // [FL][/FL]
        r = new Regex(@"(\[FL\])(.+)(\[\/FL\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<div align=left>" + m.Groups[2].ToString() + "</div>");
        }
        // [LEFT][/LEFT]
        r = new Regex(@"(\[LEFT\])(.+)(\[\/LEFT\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<div align=left>" + m.Groups[2].ToString() + "</div>");
        }
        // [FC][/FC]
        r = new Regex(@"(\[FC\])(.+)(\[\/FC\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<center>" + m.Groups[2].ToString() + "</center>");
        }
        // [CENTER][/CENTER]
        r = new Regex(@"(\[CENTER\])(.+)(\[\/CENTER\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<center>" + m.Groups[2].ToString() + "</center>");
        }
        // [FR][/FR]
        r = new Regex(@"(\[FR\])(.+)(\[\/FR\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<div align=right>" + m.Groups[2].ToString() + "</div>");
        }
        // [RIGHT][/RRIGHT]
        r = new Regex(@"(\[RIGHT\])(.+)(\[\/RIGHT\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<div align=right>" + m.Groups[2].ToString() + "</div>");
        }
        #endregion

        #region 字体大小
        // [F12][/F12]
        r = new Regex(@"(\[F12\])(.+)(\[\/F12\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<font style=\"font-size:12px;\">" + m.Groups[2].ToString() + "</font>");
        }
        // [F14][/F14]
        r = new Regex(@"(\[F14\])(.+)(\[\/F14\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<font style=\"font-size:14px;\">" + m.Groups[2].ToString() + "</font>");
        }
        // [F16][/F16]
        r = new Regex(@"(\[F16\])(.+)(\[\/F16\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<font style=\"font-size:16px;\">" + m.Groups[2].ToString() + "</font>");
        }
        // [F20][/F20]
        r = new Regex(@"(\[F20\])(.+)(\[\/F20\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<font style=\"font-size:20px;font-family:黑体;\">" + m.Groups[2].ToString() + "</font>");
        }
        // [SIZE=][/SIZE]
        r = new Regex(@"(\[size=(\d{2})\])(.+)(\[\/size\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<font style=\"font-size:" + m.Groups[2].ToString() + "px;\">" + m.Groups[3].ToString() + "</font>");
        }
        // [FAMILY=][/FAMILY]
        r = new Regex(@"(\[family=(.+)\])(.+)(\[\/family\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<font style=\"font-family:" + m.Groups[2].ToString() + ";\">" + m.Groups[3].ToString() + "</font>");
        }
        #endregion

        return s;
    }

    public static string Clear(string s)
    {
        Regex r;
        Match m;

        r = new Regex(@"(\[(.+)\])(.+)(\[\/(.+)\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "");
            //s = s.Replace(m.Groups[1].ToString(), " ");
            //s = s.Replace(m.Groups[2].ToString(), "");
        }

        return s;
    }

    public static string MoodToHtml(string s)
    {
        Regex r;
        Match m;

        r = new Regex(@"(\[MOOD=(\d{2})\])", RegexOptions.IgnoreCase);
        for (m = r.Match(s); m.Success; m = m.NextMatch())
        {
            s = s.Replace(m.Groups[0].ToString(), "<img src=\"/images/emotion/" + m.Groups[2].ToString() + ".gif\" style=\"margin-left:3px;margin-right:3px;margin-bottom:-3px;\">");
        }
        return s;
    }
}
