using System;
using System.Web;
using System.Web.Caching;

public static class CacheHelper
{
    public static void Save<T>(string key, T o)
    {
        Cache Item = HttpRuntime.Cache;
        Item[key.ToUpper()] = o;
    }

    public static void Clear(string key)
    {
        HttpContext.Current.Cache.Remove(key);
    }

    public static bool Exists(string key)
    {
        return HttpContext.Current.Cache[key] != null;
    }
    
    public static bool Get<T>(string key, out T value)
    {
        try
        {
            if (!Exists(key))
            {
                value = default(T);
                return false;
            }
            value = (T)HttpContext.Current.Cache[key];
        }
        catch
        {
            value = default(T);
            return false;
        }
        return true;
    }
}
