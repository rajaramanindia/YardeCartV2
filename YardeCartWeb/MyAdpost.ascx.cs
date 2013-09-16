using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YardeCartV2
{
    public partial class MyAdpost : System.Web.UI.UserControl
    {
        public string strAbsPath = string.Empty;
        public string sDel = string.Empty;
        public string sAdid = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            strAbsPath = Request.Url.AbsolutePath.ToString();
            if (Request.QueryString["actad"] != null)
            {
                sDel = Request.QueryString["actad"].ToString();
            }
            if (Request.QueryString["aid"] != null)
            {
                sAdid = Request.QueryString["aid"].ToString();
            }
        }
    }
}