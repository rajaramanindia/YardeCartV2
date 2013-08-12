using System;
using System.Collections.Generic;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

namespace YardeCartDataAccess
{
    public class DALComponent
    {
        SqlCommand sqlCommand = null;
        ConnectionEstablish connectionEstablish = null;
        SqlDataAdapter sqlDataAdapter = null;
        SqlParameter sqlParameter = null;
        DataSet ds = null;
        public DALComponent()
        {
            sqlCommand = new SqlCommand();
            connectionEstablish = new ConnectionEstablish();
            sqlDataAdapter = new SqlDataAdapter();
            sqlParameter = new SqlParameter();
        }

        private string sqlCommandType;

        private string SqlCommandType
        {
            get { return sqlCommandType; }
            set { sqlCommandType = value; }
        }
        private string sqlCommandText;

        public string SqlCommandText
        {
            get { return sqlCommandText; }
            set { sqlCommandText = value; }
        }

        public void SetParameters(string paramColumn, SqlDbType dbFieldType, int dbFieldSize, object fieldValue)
        {
            sqlCommand.Parameters.Add(paramColumn, dbFieldType, dbFieldSize).Value = fieldValue;
        }

        public void GetParameters(string paramColumn, SqlDbType dbFieldType, int dbFieldSize, object fieldValue)
        {
            sqlParameter = sqlCommand.Parameters.Add("paramColumn", dbFieldType, dbFieldSize);
            sqlParameter.Direction = ParameterDirection.ReturnValue;
        }

        private void SetConnection()
        {
            sqlCommand.CommandText = sqlCommandText;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Connection = connectionEstablish.OpenConnection();
        }

        public void SetParameters(string paramColumn, SqlDbType dbFieldType, bool isOutputValue)
        {
            if (isOutputValue)
            {
                sqlParameter.ParameterName = paramColumn;
                sqlParameter.SqlDbType = dbFieldType;
                sqlParameter.Direction = ParameterDirection.Output;
                sqlCommand.Parameters.Add(sqlParameter);
            }
        }

        public object GetParameters(string paramColumn)
        {
            return sqlCommand.Parameters[paramColumn].Value;
        }

        public int CreateRecord()
        {
            try
            {

                SetConnection();
                return sqlCommand.ExecuteNonQuery();
                //else
                //{
                //    sqlCommand.ExecuteNonQuery();
                //    object obj=sqlCommand.ParametersParameters("paramColumn").value;
                //    return obj;
                //}
            }
            catch (Exception ex)
            {

                throw ex;
            }
            //return 0;
        }

        public int UpdateRecord()
        {
            try
            {
                SetConnection();
                int y = sqlCommand.ExecuteNonQuery();
                return y;

            }
            catch (Exception ex)
            {

                throw ex;
            }
            // return 0;
        }

        public int DeleteRecord()
        {
            try
            {
                SetConnection();
                int y = sqlCommand.ExecuteNonQuery();
                return y;

            }
            catch (Exception ex)
            {

                throw ex;
            }
            // return 0;
        }

        public DataTable SelectRecord()
        {
            try
            {
                SetConnection();

                sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                ds = new DataSet();
                sqlDataAdapter.Fill(ds);
                return ds.Tables[0];

            }
            catch (Exception ex)
            {
                throw ex;
            }
            //return null;
        }

        public DataSet SelectRecordSet()
        {
            try
            {
                SetConnection();

                sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                ds = new DataSet();
                sqlDataAdapter.Fill(ds);
                return ds;

            }
            catch (Exception ex)
            {

                throw ex;
            }
            //return null;
        }

        public object SelectRecordValue()
        {
            try
            {
                SetConnection();
                return sqlCommand.ExecuteScalar();

            }
            catch (Exception ex)
            {

                throw ex;
            }
            //return null;
        }

    }
}
