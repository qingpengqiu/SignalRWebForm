using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Caching;
using System.Web.UI;
using System.Xml.Linq;

namespace Utils
{
    /// <summary>
    /// 功能：       弹框帮助类
    /// 创建人：  Wilson
    /// 时间：       2013-08-07
    /// 描述：       添加 System.Web  引用
    /// </summary>
    public class AlertHelper
    {
        //提示信息字典
        private static Dictionary<string, string> tipDic = null;

        //提示XML文件
        private const string tipXmlPath = "xml/tip.xml";

        #region## Windows弹框
        /// <summary>
        /// 功能：Windows弹框
        /// </summary>
        /// <param name="content">提示正文</param>
        public static void Alert(string content)
        {
            AlertBase(content, null, null);
        }

        /// <summary>
        /// 功能：Windows弹框,从XML中得到提示信息
        /// </summary>
        /// <param name="tipId">XML文件中ID节点值</param>
        public static void AlertXml(string tipId)
        {
            AlertBase(GetTipDic(tipXmlPath, tipId), null, null);
        }

        /// <summary>
        /// 功能：弹框并跳转
        /// </summary>
        /// <param name="content">提示正文</param>
        /// <param name="url">跳转的URL</param>
        public static void AlertGo(string content, string url)
        {
            AlertBase(content, url, null);
        }

        /// <summary>
        /// 功能：弹框并跳转,从XML中得到提示信息
        /// </summary>
        /// <param name="tipId">XML文件中ID节点值</param>
        /// <param name="url">跳转的URL</param>
        public static void AlertGoXml(string tipId, string url)
        {
            AlertBase(GetTipDic(tipXmlPath, tipId), url, null);
        }

        /// <summary>
        ///  功能：Windows弹框
        /// </summary>
        /// <param name="alertContext">提示正文</param>
        /// <param name="url">跳转跳径</param>
        /// <param name="otherScripts">脚本</param>
        private static void AlertBase(string alertContext, string url, string otherScripts)
        {
            Page page = HttpContext.Current.Handler as Page;

            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            if (!string.IsNullOrEmpty(alertContext))
            {
                sb.AppendFormat("alert(\"{0}\");", alertContext);
            }

            if (!string.IsNullOrEmpty(url))
            {
                sb.AppendFormat("location.href=\"{0}\";", url);
            }

            if (!string.IsNullOrEmpty(otherScripts))
            {
                sb.AppendFormat("{0};", otherScripts);
            }

            page.ClientScript.RegisterStartupScript(page.GetType(), "", sb.ToString(), true);
        }
        #endregion

        #region## Jquery弹框 (BlockUI）
        /// <summary>
        /// 功能:Jquery插件弹框
        /// </summary>
        /// <param name="alertContext">提示正文</param>
        public static void JQAlert(string alertContext)
        {
            JQAlertBase(alertContext, null);
        }

        /// <summary>
        /// 功能：Jquery插件弹框，从XML中得到提示信息
        /// </summary>
        /// <param name="tipId">XML文件中ID节点值</param>
        public static void JQAlertXml(string tipId)
        {
            JQAlert(GetTipDic(tipXmlPath, tipId));
        }

        /// <summary>
        /// 功能:Jquery插件弹框并跳转
        /// </summary>
        /// <param name="alertContext">提示正文</param>
        /// <param name="url">跳转URL</param>
        public static void JQAlertGo(string alertContext, string url)
        {
            JQAlertBase(alertContext, url);
        }       
        /// <summary>
        /// 功能:Jquery插件弹框并跳转，从XML中得到提示信息
        /// </summary>             
        /// <param name="tipId">XML文件中ID节点值</param>
        /// <param name="url">跳转URL</param>
        public static void JQAlertGoXml(string tipId, string url)
        {
            JQAlertGo(GetTipDic(tipXmlPath, tipId), url);
        }

        /// <summary>
        /// 功能:Jquery插件弹出
        /// </summary>
        /// <param name="alertContext">提示正文</param>
        /// <param name="url">跳转URL</param>
        private static void JQAlertBase(string alertContext, string url)
        {
            Page page = HttpContext.Current.Handler as Page;

            StringBuilder sb = new StringBuilder();

            sb.Append("$(function(){{");

            if (!string.IsNullOrEmpty(alertContext))
            {
                sb.AppendFormat(@"$.blockUI({{ message: '<br/><h1>{0}</h1><br/>',css: {{ width: ""600px"" }}, timeout: 2000 }});", alertContext);
            }

            if (!string.IsNullOrEmpty(url))
            {
                sb.AppendFormat("setTimeout(function() {{ $.unblockUI({{onUnblock: function(){{ location.href='{0}';}}  }}); }}, 2000);", url);
            }

            sb.Append("}});");

            page.ClientScript.RegisterStartupScript(page.GetType(), "", sb.ToString(), true);

        }
        
        #endregion
        #region## Jquery弹框 (BlockUI）提示带图标
        /// <summary>
        /// 功能:Jquery插件弹框
        /// </summary>
        /// <param name="alertContext">提示正文</param>
        public static void JQAlert(string alertContext, bool imgname)
        {
            JQAlertBase(alertContext, null, imgname);
        }

        /// <summary>
        /// 功能：Jquery插件弹框，从XML中得到提示信息
        /// </summary>
        /// <param name="tipId">XML文件中ID节点值</param>
        public static void JQAlertXml(string tipId, bool imgname)
        {
            JQAlert(GetTipDic(tipXmlPath, tipId), imgname);
        }
       
        /// <summary>
        /// 功能:Jquery插件弹框并跳转
        /// </summary>
        /// <param name="alertContext">提示正文</param>
        /// <param name="url">跳转URL</param>
        public static void JQAlertGo(string alertContext, string url, bool imgname)
        {
            JQAlertBase(alertContext, url, imgname);
        }
        /// <summary>
        /// 功能:Jquery插件弹框并跳转，从XML中得到提示信息
        /// </summary>             
        /// <param name="tipId">XML文件中ID节点值</param>
        /// <param name="url">跳转URL</param>
        public static void JQAlertGoXml(string tipId, string url, bool imgname)
        {
            JQAlertGo(GetTipDic(tipXmlPath, tipId), url, imgname);
        }
        /// <summary>
        /// 功能:Jquery插件弹出
        /// </summary>
        /// <param name="alertContext">提示正文</param>
        /// <param name="url">跳转URL</param>
        private static void JQAlertBase(string alertContext, string url, bool imgname)
        {
            Page page = HttpContext.Current.Handler as Page;

            StringBuilder sb = new StringBuilder();

            sb.Append("$(function(){{");

            if (!string.IsNullOrEmpty(alertContext))
            {
                //sb.AppendFormat(@"$.blockUI({{ message: '<img src=""/Html/images/" + imgname + .png">{0}',css: {{ width: ""234px"",height:""110px"",left:""40%"",""line-height"":""110px"",""text-align"":""center"",""font-size"":""14px"" }}, timeout: 200000 }});", alertContext);
                sb.AppendFormat(@"$.blockUI({{ message: '<img src=\""/Html/images/{1}.png\"" />{0}<br/>',css: {{ width: ""234px"",height:""110px"",left:""40%"",""line-height"":""110px"",""text-align"":""center"",""font-size"":""14px"" }},timeout: 2000 }});", alertContext, imgname);
            }

            if (!string.IsNullOrEmpty(url))
            {
                sb.AppendFormat("setTimeout(function() {{ $.unblockUI({{onUnblock: function(){{ location.href='{0}';}}  }}); }}, 2000);", url);
            }

            sb.Append("}});");

            page.ClientScript.RegisterStartupScript(page.GetType(), "", sb.ToString(), true);

        }
        #endregion
        #region## Jquery弹框 (BlockUI）提示带图标 弹出关闭当前页面
        /// <summary>
        /// 功能:Jquery插件弹框
        /// </summary>
        /// <param name="alertContext">提示正文</param>
        public static void JQAlert(string alertContext, bool imgname, bool show)
        {
            JQAlertBase(alertContext, null, imgname, show);
        }
        /// <summary>
        /// 功能：Jquery插件弹框，从XML中得到提示信息
        /// </summary>
        /// <param name="tipId">XML文件中ID节点值</param>
        public static void JQAlertXml(string tipId, bool imgname, bool show)
        {
            JQAlert(GetTipDic(tipXmlPath, tipId), imgname, show);
        }
        /// <summary>
        /// 功能:Jquery插件弹框并跳转
        /// </summary>
        /// <param name="alertContext">提示正文</param>
        /// <param name="url">跳转URL</param>
        public static void JQAlertGo(string alertContext, string url, bool imgname, bool show)
        {
            JQAlertBase(alertContext, url, imgname, show);
        }
        /// <summary>
        /// 功能:Jquery插件弹框并跳转，从XML中得到提示信息
        /// </summary>             
        /// <param name="tipId">XML文件中ID节点值</param>
        /// <param name="url">跳转URL</param>
        public static void JQAlertGoXml(string tipId, string url, bool imgname, bool show)
        {
            JQAlertGo(GetTipDic(tipXmlPath, tipId), url, imgname);
        }
        private static void JQAlertBase(string alertContext, string url, bool imgname, bool show)
        {
            Page page = HttpContext.Current.Handler as Page;

            StringBuilder sb = new StringBuilder();

            sb.Append("$(function(){{");

            if (!string.IsNullOrEmpty(alertContext))
            {
                //sb.AppendFormat(@"$.blockUI({{ message: '<img src=""/Html/images/" + imgname + .png">{0}',css: {{ width: ""234px"",height:""110px"",left:""40%"",""line-height"":""110px"",""text-align"":""center"",""font-size"":""14px"" }}, timeout: 200000 }});", alertContext);
                sb.AppendFormat(@"$.blockUI({{ message: '<img src=\""/Html/images/{1}.png\"" />{0}<br/>',css: {{ width: ""234px"",height:""110px"",left:""40%"",""line-height"":""110px"",""text-align"":""center"",""font-size"":""14px"" }},timeout: 2000 }});", alertContext, imgname);
            }


            if (!string.IsNullOrEmpty(url))
            {
                sb.AppendFormat("setTimeout(function() {{ $.unblockUI({{onUnblock: function(){{ location.href='{0}';}}  }}); }}, 2000);", url);
            }
            if (show)
            {
                sb.AppendFormat("setTimeout(\"window.close();\",2000);");
            }
            sb.Append("}});");

            page.ClientScript.RegisterStartupScript(page.GetType(), "", sb.ToString(), true);

        }
        #endregion
        #region## 根据ID从XML文件中获取提示信息
        /// <summary>
        ///  根据ID从XML文件中获取提示信息
        ///  进行XML文件依赖缓存
        /// </summary>
        /// <param name="filePath">XML提示文件路径</param>
        /// <param name="tipId">XML文件中ID节点</param>
        /// <returns>提示信息</returns>
        private static string GetTipDic(string filePath, string tipId)
        {
            string tipStr = string.Empty;

            if (HttpRuntime.Cache["TipCache"] == null)
            {
                tipDic = new Dictionary<string, string>();

                string xmlPath = HttpContext.Current.Server.MapPath(filePath);
                XDocument doc = XDocument.Load(xmlPath);

                var language = doc.Descendants("language").First().Element("value").Value;

                var tipList = doc.Descendants("alerttip");

                foreach (var item in tipList)
                {
                    string id = item.Element("id").Value;
                    if (!tipDic.ContainsKey(id))
                    {
                        tipDic.Add(id, item.Element(language).Value);
                    }
                }

                CacheDependency dep = new CacheDependency(xmlPath);
                HttpRuntime.Cache.Insert("TipCache", tipDic, dep, System.Web.Caching.Cache.NoAbsoluteExpiration, System.Web.Caching.Cache.NoSlidingExpiration);
            }
            else
            {
                tipDic = HttpRuntime.Cache["TipCache"] as Dictionary<string, string>;
            }

            if (tipDic.ContainsKey(tipId))
            {
                tipStr = tipDic[tipId];
            }

            return tipStr;
        }
        #endregion
    }
}
