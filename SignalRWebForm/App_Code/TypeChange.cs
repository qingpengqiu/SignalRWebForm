//类型转换类
/////////////////////////////

using System;

/// <summary>
/// TypeChange 的摘要说明。
/// </summary>
public class TypeChangeDefault

{
    public TypeChangeDefault()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }

    /// <summary>
    /// 把控值转换成相对应的浮点值，如果非空转换成相对应的数值
    /// </summary>
    /// <param name="Value"></param>
    /// <param name="iResult">空值时要返回的值</param>
    /// <returns></returns>
    public static Double NullToDouble(object Value, Double iResult)
    {
        try
        {
            if (Value == null)
                return iResult;
            Convert.ToDouble(Value);
        }
        catch (Exception)
        {
            return iResult;
        }

        return Convert.ToDouble(Value);
    }
    /// <summary>
    /// 把控值转换成相对应的浮点值，如果非空转换成相对应的数值
    /// </summary>
    /// <param name="Value"></param>
    /// <param name="iResult">空值时要返回的值</param>
    /// <returns></returns>
    public static Decimal NullToDecimal(object Value, Decimal iResult)
    {
        try
        {
            if (Value == null)
                return iResult;
            Convert.ToDecimal(Value);
        }
        catch (Exception)
        {
            return iResult;
        }

        return Convert.ToDecimal(Value);
    }
    /// <summary>
    /// 把控值转换成相对应的整型值，如果非空转换成相对应的数值
    /// </summary>
    /// <param name="Value"></param>
    /// <param name="iResult">空值时要返回的值</param>
    /// <returns></returns>
    public static int NullToInt(object Value, int iResult)
    {
        try
        {
            if (Value == null)
                return iResult;
            Convert.ToInt32(Value);
        }
        catch (Exception)
        {
            return iResult;
        }

        return Convert.ToInt32(Value);

    }

    /// <summary>
    /// 把控值转换成相对应的字符串，如果非空转换成相对应的数值
    /// </summary>
    /// <param name="Value"></param>
    /// <param name="iResult">空值时要返回的值</param>
    /// <returns></returns>
    public static string NullToString(object Value, string iResult)
    {
        try
        {
            if (Value == null)
                return iResult;
            Convert.ToString(Value);
        }
        catch (Exception)
        {
            return iResult;
        }

        return Convert.ToString(Value);

    }
    /// <summary>
    /// 把控值转换成相对应的时间值，如果非空转换成相对应的数值
    /// </summary>
    /// <param name="Value"></param>
    /// <param name="iResult">空值时要返回的值</param>
    /// <returns></returns>
    public static DateTime NullToDateTime(object Value, DateTime iResult)
    {
        try
        {
            if (Value == null)
                return iResult;
            Convert.ToDateTime(Value);
        }
        catch (Exception)
        {
            return iResult;
        }

        return Convert.ToDateTime(Value);

    }
    /// <summary>
    /// 把控值转换成相对应的时间值，如果非空转换成相对应的数值
    /// </summary>
    /// <param name="Value"></param>
    /// <param name="iResult">空值时要返回的值</param>
    /// <returns></returns>
    public static bool NullToBool(object Value, bool fResult)
    {
        try
        {
            if (Value == null)
                return fResult;
            Convert.ToBoolean(Value);
        }
        catch (Exception)
        {
            return fResult;
        }

        return Convert.ToBoolean(Value);

    }

}
