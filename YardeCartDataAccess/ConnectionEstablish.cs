using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;
using System.Web;

namespace YardeCartDataAccess
{
    public class ConnectionEstablish
    {
        SqlConnection sqlCon = null;

        public ConnectionEstablish()
        {
            sqlCon = new SqlConnection();
        }

        public SqlConnection OpenConnection()
        {
            try
            {
                if (sqlCon.State == ConnectionState.Open)
                    sqlCon.Close();
                sqlCon.ConnectionString = ConfigurationManager.AppSettings["SQLConnection"];
            }
            catch (Exception ex)
            {
                throw ex;
            }
            sqlCon.Open();

            return sqlCon;

        }

    }
}