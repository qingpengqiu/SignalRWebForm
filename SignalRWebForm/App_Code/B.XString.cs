using System;
using System.Text;
using System.IO;
using System.Web;
using System.Security.Cryptography;
using System.Text.RegularExpressions;

/// <summary>
/// ��չ�ַ�����
/// </summary>
public static class XString
{
    /// <summary>
    /// Ĭ����Կ����
    /// </summary>
    private static byte[] Keys = { 0x12, 0x34, 0x56, 0x78, 0xA0, 0xAB, 0xCD, 0xEF };

    /// <summary>
    /// Ĭ��DES�����ַ���
    /// </summary>
    private static string _DefaultKey = "RUNER123";

    #region MD5,DES���ܺ���

    /// <summary>   
    /// ��ȡ�ַ�����MD5������(֧������)  
    /// </summary>   
    /// <param name="inputString">�����ı�</param>   
    /// <returns>MD5������</returns> 
    public static string MD5(string inputString)
    {
        System.Security.Cryptography.MD5 md5 = System.Security.Cryptography.MD5.Create();
        string encoded = BitConverter.ToString(md5.ComputeHash(Encoding.Default.GetBytes(inputString))).Replace("-", "");
        return encoded.ToLower();
    }

    /// <summary>
    /// DES�����ַ���
    /// </summary>
    /// <param name="encryptString">�����ܵ��ַ���</param>
    /// <param name="encryptKey">������Կ,Ҫ��Ϊ8λ</param>
    /// <returns>���ܳɹ����ؼ��ܺ���ַ�����ʧ�ܷ���Դ��</returns>
    public static string DESEncrypt(string encryptString, string encryptKey)
    {
        try
        {
            byte[] rgbKey = Encoding.UTF8.GetBytes(encryptKey.Substring(0, 8));
            byte[] rgbIV = Keys;
            byte[] inputByteArray = Encoding.UTF8.GetBytes(encryptString);
            DESCryptoServiceProvider dCSP = new DESCryptoServiceProvider();
            MemoryStream mStream = new MemoryStream();
            CryptoStream cStream = new CryptoStream(mStream, dCSP.CreateEncryptor(rgbKey, rgbIV), CryptoStreamMode.Write);
            cStream.Write(inputByteArray, 0, inputByteArray.Length);
            cStream.FlushFinalBlock();
            return Convert.ToBase64String(mStream.ToArray());
        }
        catch
        {
            return encryptString;
        }
    }

    /// <summary>
    /// ��Ĭ��DES�����ַ������ܣ�����DESEncrypt(,)
    /// </summary>
    /// <param name="encryptString">�����ܵ��ַ���</param>
    /// <returns>���ܳɹ����ؼ��ܺ���ַ�����ʧ�ܷ���Դ��</returns>
    public static string DESEncrypt(string encryptString)
    {
        return DESEncrypt(encryptString, _DefaultKey);
    }

    /// <summary>
    /// DES�����ַ���
    /// </summary>
    /// <param name="decryptString">�����ܵ��ַ���</param>
    /// <param name="decryptKey">������Կ,Ҫ��Ϊ8λ,�ͼ�����Կ��ͬ</param>
    /// <returns>���ܳɹ����ؽ��ܺ���ַ�����ʧ�ܷ�Դ��</returns>
    public static string DESDecrypt(string decryptString, string decryptKey)
    {
        try
        {
            byte[] rgbKey = Encoding.UTF8.GetBytes(decryptKey);
            byte[] rgbIV = Keys;
            byte[] inputByteArray = Convert.FromBase64String(decryptString);
            DESCryptoServiceProvider DCSP = new DESCryptoServiceProvider();
            MemoryStream mStream = new MemoryStream();
            CryptoStream cStream = new CryptoStream(mStream, DCSP.CreateDecryptor(rgbKey, rgbIV), CryptoStreamMode.Write);
            cStream.Write(inputByteArray, 0, inputByteArray.Length);
            cStream.FlushFinalBlock();
            return Encoding.UTF8.GetString(mStream.ToArray());
        }
        catch
        {
            return decryptString;
        }
    }

    /// <summary>
    /// ��Ĭ��DES�����ַ������ܣ�����DESDecrypt(,)
    /// </summary>
    /// <param name="decryptString">�����ܵ��ַ���</param>
    /// <returns>���ܳɹ����ؽ��ܺ���ַ�����ʧ�ܷ�Դ��</returns>
    public static string DESDecrypt(string decryptString)
    {
        return DESDecrypt(decryptString, _DefaultKey);
    }

    #endregion

    #region �ַ��������������

    /// <summary>
    /// ȷ���ǰ�ȫ�����ݣ��ַ�����
    /// </summary>
    /// <param name="v">��������ַ���</param>
    /// <returns>��ȫ���ַ���</returns>
    public static string SqlSafe(string v)
    {
        string rsl = v + "";
        if (v != "")
        {
            rsl = rsl.Replace(@"'", @"&#39;").Replace(@"<", @"&lt;").Replace(@">", @"&gt;");
        }
        return rsl;
    }

    public static string XmlSafe(string v)
    {
        string rsl = v + "";
        if (v != "")
        {
            rsl = rsl.Replace(@"<", @"&lt;").Replace(@">", @"&gt;");
        }
        return rsl;
    }

    public static string NickSafe(string v)
    {
        string rsl = v + "";
        if (v != "")
        {
            rsl = rsl.Replace(@"<", @"&lt;").Replace(@">", @"&gt;");
        }
        return rsl.Replace(" ", "").Replace("��", "").Trim();
    }

    public static string UnTail(string v)
    {
        if (v.EndsWith(",")) return v.Substring(0, v.Length - 1);
        return v;
    }
   
    /// <summary>      
    /// ȡ�̶����ȵ��ַ���(֧����Ӣ�Ļ���)   
    /// �Զ�ȥ��XML��������ַ�(0x00-0x1F)
    /// ��˳������RSS,XML���
    /// </summary>      
    /// <param name="inputData">��������ַ���</param>      
    /// <param name="width">���Ƶĳ��ȣ���Ӣ���ֽڼ��㣩</param>      
    /// <returns>������</returns>      
    public static string Trunc(string inputData, int len)
    {
        if (len <= 0) return inputData;
        ASCIIEncoding ascii = new ASCIIEncoding();
        int tempLen = 0;
        string tempString = "";
        byte[] s = ascii.GetBytes(inputData);
        for (int i = 0; i < s.Length; i++)
        {
            tempLen += ((int)s[i] == 63) ? 2 : 1;
            if ((int)s[i] > 0x1F) tempString += inputData.Substring(i, 1);
            if (tempLen > len) break;
        }
        return tempString;
    }

    /// <summary>      
    /// ȡ�̶����ȵ��ַ���(֧����Ӣ�Ļ���)   
    /// �Զ�ȥ��XML��������ַ�(0x00-0x1F)
    /// ��˳������RSS,XML���
    /// </summary>      
    /// <param name="inputData">��������ַ���</param>      
    /// <param name="width">���Ƶĳ��ȣ���Ӣ���ֽڼ��㣩</param>      
    /// <returns>������</returns>      
    public static string TruncBreak(string inputData, int width, int lines)
    {
        StringBuilder sb = new StringBuilder();
        int lnum = 0;
        int pos = 0;
        while (lnum < lines)
        {
            if (inputData.Length >= (pos + width))
            {
                sb.AppendLine(inputData.Substring(pos, width) + "<br>");
                pos += width;
            }
            else
            {
                sb.AppendLine(inputData.Substring(pos) + "<br>");
                break;
            }
            lnum++;
        }
        return sb.ToString();
    }
    
    /// <summary>
    /// ʹ���ַ��� v ֻ��������
    /// </summary>
    /// <param name="v"></param>
    /// <returns></returns>
    public static string PureNumber(string v)
    {
        return Regex.Replace(v, @"[^\d@]", "");
    }
    
    #endregion

    public static string ContentTrunc(string s, int len)
    {
        s = UBB.Clear(s);
        s = s.Replace("\n", "").Replace("\t", "").Replace("\t", "").Replace("��", "");
        return Trunc(s, len);
    }

    public static string PublishLine(string s)
    {
        StringBuilder sb = new StringBuilder();
        int len = s.Length;
        bool inmark = false;
        for (int i = 0; i < len; i++)
        {
            string s1 = s.Substring(i, 1);
            if (s1 == "<") { inmark = true; }
            if (s1 == ">") { inmark = false; }
            if (s1 == " ")
            {
                if (!inmark)
                {
                    sb.Append("&nbsp;");
                    continue;
                }
            }
            sb.Append(s1);
        }
        return sb.ToString();
    }

    public static string PublishContent(string s)
    {
        string[] sa = s.Split('\n');
        StringBuilder sb = new StringBuilder();
        int idx = 0;
        foreach (string sv in sa)
        {
            string sf = sv.Replace("\t", "").Replace("\r", "");
            if (sf.Length < 1) continue;
            if (idx > 0) sb.AppendLine("\t\t\t\t\t<div id=\"blog_content\">" + PublishLine(sf) + "</div>");
            else sb.AppendLine("<div id=\"blog_content\">" + PublishLine(sf) + "</div>");
            idx++;
        }
        return sb.ToString();
    }
}

