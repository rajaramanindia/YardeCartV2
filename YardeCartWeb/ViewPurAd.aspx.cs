﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YardeCartV2
{
    public partial class ViewPurAd : System.Web.UI.Page
    {
        public string AdpostId = string.Empty;
        public string AdUserId = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["uid"] != null)
            {
                AdUserId = Request.QueryString["uid"].ToString();
            }
            if (Request.QueryString["aid"] != null)
            {
                AdpostId = Request.QueryString["aid"].ToString();
            }

        }
    }
}