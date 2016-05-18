using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
public static class HostInfo
{
      // WEB服务器HostName
    //public static string wwwName = "http://www.erun360.com";
    public static string wwwName = "http://114.247.234.229:8080";
    // 图片服务器HostName
    public static string imgName = "http://img.erun360.com";
    //public static string imgName = "http://114.247.234.229:8081";
    public static string imgCDN = "http://cdnimg.erun360.com";
    public static string wwwCDN = "http://cdnwww.erun360.com";
}

public abstract class SQLHelper
{
    private static string connectionString = ConfigurationManager.AppSettings["USER"];
    //private static string connectionString = @"DATA SOURCE=192.168.1.36;UID=YPADMIN;PWD=Xe#data_adm_yp1;DATABASE=YP_DB_1";
    //private static string connectionString = @"DATA SOURCE=(local);UID=YPADMIN;PWD=Xe#data_adm_yp1;DATABASE=SUPERWEIBO";
    //private static string connectionString = @"DATA SOURCE=(local);UID=YPADMIN;PWD=123456;DATABASE=YP_DB_1";

    public SQLHelper() { }

    #region  执行简单SQL语句(含Transation)

    /// <summary>   
    /// 执行SQL语句，返回影响的记录数   
    /// </summary>   
    /// <param name="SQLString">SQL语句</param>   
    /// <returns>影响的记录数</returns>   
    public static int ExecuteSql(string SQLString)
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(SQLString, connection))
            {
                try
                {
                    connection.Open();
                    // 这里可以设置查询的时间限制（毫秒）   
                    // cmd.CommandTimeout = 10;    
                    int rows = cmd.ExecuteNonQuery();
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException e)
                {
                    connection.Close();
                    throw e;
                }
            }
        }
    }

    /// <summary>   
    /// 执行查询语句，返回SqlDataReader ( 注意：调用该方法后，一定要对SqlDataReader进行Close )   
    /// </summary>   
    /// <param name="strSQL">查询语句</param>   
    /// <returns>SqlDataReader</returns>   
    public static SqlDataReader ExecuteReader(string strSQL)
    {
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand(strSQL, connection);
        try
        {
            connection.Open();
            //cmd.CommandTimeout = 1000*1000;
            SqlDataReader myReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            return myReader;
        }
        catch (System.Data.SqlClient.SqlException e)
        {
            throw e;
        }
    }

    /// <summary>
    /// 执行多条SQL语句，实现数据库事务。
    /// 这个方法的另外一个好处是可以大大加快执行速度!!
    /// </summary>
    /// <param name="SQLStringList">多条SQL语句</param>  
    public static void ExecuteSqlTran(ArrayList SQLStringList)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            SqlTransaction tx = conn.BeginTransaction();
            cmd.Transaction = tx;
            try
            {
                for (int n = 0; n < SQLStringList.Count; n++)
                {
                    string strsql = SQLStringList[n].ToString();
                    if (strsql.Trim().Length > 1)
                    {
                        cmd.CommandText = strsql;
                        cmd.ExecuteNonQuery();
                    }
                }
                tx.Commit();
            }
            catch (System.Data.SqlClient.SqlException E)
            {
                tx.Rollback();
                throw new Exception(E.Message);
            }
        }
    }

    #endregion
}
