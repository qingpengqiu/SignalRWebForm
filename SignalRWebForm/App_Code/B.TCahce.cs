
using System;   
using System.Text;
using System.Web;
using System.Web.Caching;

/// <summary>
/// ��չ��Cache��
/// </summary>
public static class TCache
{
    #region ����Object����ʵ����Ļ��淽��

    public static void Save(string cacheName, object cacheValue)
    {
        Cache Item = HttpRuntime.Cache;
        Item[cacheName.ToUpper()] = cacheValue;
    }

    public static void Save(string cacheName, object cacheValue, int iMinuteSpan)
    {
        DateTime absExpireTime = DateTime.Now.AddMinutes(iMinuteSpan);
        HttpRuntime.Cache.Insert(cacheName, cacheValue, null, absExpireTime, TimeSpan.Zero);
    }

    public static object Load(string cacheName)
    {
        Cache Item = HttpRuntime.Cache;
        if (Item.Get(cacheName.ToUpper()) != null)
        {
            return Item[cacheName.ToUpper()];
        }
        else
        {
            return null;
        }
    }

    #endregion

    #region ����String��Ļ��淽��

    public static void SaveString(string cacheName, string cacheValue)
    {
        Cache Item = HttpRuntime.Cache;
        Item[cacheName.ToUpper()] = cacheValue;
    }

    public static void SaveString(string cacheName, string cacheValue, int iMinuteSpan)
    {
        DateTime absExpireTime = DateTime.Now.AddMinutes(iMinuteSpan);
        HttpRuntime.Cache.Insert(cacheName, cacheValue, null, absExpireTime, TimeSpan.Zero);
    }

    public static string LoadString(string cacheName)
    {
        Cache Item = HttpRuntime.Cache;
        if (Item.Get(cacheName.ToUpper()) != null)
        {
            return (string)Item[cacheName.ToUpper()];
        }
        else
        {
            return "";
        }
    }

    #endregion

    public static void Clear(string cacheName)
    {
        Cache Item = HttpRuntime.Cache;
        if (Item.Get(cacheName.ToUpper()) != null)
        {
            Item.Remove(cacheName.ToUpper());
        }
    }
}
