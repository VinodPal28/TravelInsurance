// ******************************************************************************************
// Author           : Manish Jha
// Description      : A class used for database connection using Enterprise Library
// Created On       : 26-Apr-2018
// For Travel Insurance Portal      
// *******************************************************************************************

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
//using Microsoft.Practices.EnterpriseLibrary.Common.Configuration.ContainerModel;
using System.Data;
using System.Data.Common;


//Connction to Sql Server
public class ConnectionToSql
{
    /// <summary>
    /// Create Database Connection
    /// </summary>
    /// <returns></returns>
    public static Database CreateDatabase(string constringname)
    {
        try
        {
            //string server = iniList[0];
            //string dbname = iniList[1];
            //string uid = iniList[2];
            //string pwd = iniList[3];
            //string constring = String.Format("Data source={0};Initial catalog={1};UId={2};Pwd={3};Integrated Security=false;", server, dbname, uid, pwd);  
            string constring= ConfigurationManager.ConnectionStrings[constringname].ConnectionString;
            Database pdb = new Microsoft.Practices.EnterpriseLibrary.Data.Sql.SqlDatabase(constring);
            return pdb; 
        }
        catch (Exception)
        {            
            throw;
        }
        
    }
    public  DataSet ExecuteReader(string constringname,String StoredProc,object [] obj)
    {
        Database db;
        db = CreateDatabase(constringname);
        DbCommand dbCommand = db.GetStoredProcCommand(StoredProc,obj);
        dbCommand.CommandTimeout = 0;
        DataSet ds = db.ExecuteDataSet(dbCommand);
        dbCommand.Connection.Close();
        dbCommand.Connection.Dispose();
        dbCommand.Dispose();
        return ds;
    }

    public DataTable ExecuteReaderDt(string constringname, String StoredProc, object[] obj)
    {
        Database db;
        DataTable dt;
        db = CreateDatabase(constringname);
        DbCommand dbCommand = db.GetStoredProcCommand(StoredProc, obj);
        dbCommand.CommandTimeout = 0;
        DataSet ds = db.ExecuteDataSet(dbCommand);
        dbCommand.Connection.Close();
        dbCommand.Connection.Dispose();
        dbCommand.Dispose();
        dt = ds.Tables[0];
        return dt;
    }


    /// <summary>
    /// Return the number of row Effected in The Record
    /// </summary>
    /// <param name="StoredProc">Name of The Stored Procedure</param>
    /// <param name="obj"></param>
    /// <returns>Number of the affected</returns>
    public int ExecuteNonQuery(string constringname,String StoredProc, object[] obj)
    {
        int num = 0;
        Database db = CreateDatabase(constringname);
        num = db.ExecuteNonQuery(StoredProc, obj);
        return num;
    }
    /// <summary>
    /// Return Number of Row Affected
    /// </summary>
    /// <param name="StoredProc"></param>
    /// <returns></returns>
    public int ExecuteNonQuery(string constringname,String StoredProc)
    {
        int num = 0;
        Database db = CreateDatabase(constringname);
        num = db.ExecuteNonQuery(StoredProc);
        return num;
    }

    /// <summary>
    /// Execute Stored Proc and return the return into DataSet
    /// </summary>
    /// <param name="StoredProc">Name of the Procedure</param>
    /// <returns>DataSet</returns>
    public DataSet ExecuteReader(string constringname,String StoredProc)
    {
        Database db;
        db = CreateDatabase(constringname);
        DbCommand dbCommand = db.GetStoredProcCommand(StoredProc);
        dbCommand.CommandTimeout = 0;
        DataSet ds = db.ExecuteDataSet(dbCommand);
        dbCommand.Connection.Close();
        dbCommand.Connection.Dispose();
        dbCommand.Dispose();
        return ds;
    }

    public object ExecuteScalar(string constringname,String StoredProc,object[] obj)
    {
        Database db;
        db = CreateDatabase(constringname);
        DbCommand dbCommand = db.GetStoredProcCommand(StoredProc,obj);
        dbCommand.CommandTimeout = 0;
        object response = db.ExecuteScalar(dbCommand);
        dbCommand.Connection.Close();
        dbCommand.Connection.Dispose();
        dbCommand.Dispose();
        return response;
    }

    public DataSet ExecuteQuery(string constringname,string query)
    {
        Database db;
        db = CreateDatabase(constringname);        
        DbCommand dbCommand = db.GetSqlStringCommand(query);        
        dbCommand.CommandTimeout = 0;
        DataSet ds = db.ExecuteDataSet(dbCommand);
        dbCommand.Connection.Close();
        dbCommand.Connection.Dispose();
        dbCommand.Dispose();
        return ds;
    }
}

