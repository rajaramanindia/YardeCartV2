using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using YardeCartServiceApp;
using YardeCartCommon;
//using Newtonsoft.Json;

namespace YardeCartV2
{
    public partial class MyCart : System.Web.UI.UserControl
    {

        public string strAbsPath = string.Empty;
        public string sDel = string.Empty;
        public string sCartid = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            strAbsPath = Request.Url.AbsolutePath.ToString();
            if (Request.QueryString["act"] != null)
            {
                sDel = Request.QueryString["act"].ToString();
            }
            if (Request.QueryString["cid"] != null)
            {
                sCartid = Request.QueryString["cid"].ToString();
            } 
        }
    }
}