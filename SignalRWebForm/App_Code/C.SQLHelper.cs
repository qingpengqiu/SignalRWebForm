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
      // WEB������HostName
    //public static string wwwName = "http://www.erun360.com";
    public static string wwwName = "http://114.247.234.229:8080";
    // ͼƬ������HostName
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

    #region  ִ�м�SQL���(��Transation)

    /// <summary>   
    /// ִ��SQL��䣬����Ӱ��ļ�¼��   
    /// </summary>   
    /// <param name="SQLString">SQL���</param>   
    /// <returns>Ӱ��ļ�¼��</returns>   
    public static int ExecuteSql(string SQLString)
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(SQLString, connection))
            {
                try
                {
                    connection.Open();
                    // ����������ò�ѯ��ʱ�����ƣ����룩   
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
    /// ִ�в�ѯ��䣬����SqlDataReader ( ע�⣺���ø÷�����һ��Ҫ��SqlDataReader����Close )   
    /// </summary>   
    /// <param name="strSQL">��ѯ���</param>   
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
    /// ִ�ж���SQL��䣬ʵ�����ݿ�����
    /// �������������һ���ô��ǿ��Դ��ӿ�ִ���ٶ�!!
    /// </summary>
    /// <param name="SQLStringList">����SQL���</param>  
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
