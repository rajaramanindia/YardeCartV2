using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YardeCartServiceApp;

namespace YardeCartV2
{
    public partial class ActivateUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString.Count == 1)
            {
                string s = Request.QueryString["uid"].ToString();
                s = s.Replace(" ", "+");

                YardeCartData.UserAct ua = new YardeCartData.UserAct();
                ua.strUserid = s;

                YardeCartServiceApp.YardeCartServices oy = new YardeCartServices();
                oy.UpdateActivation(ua);

            }
        }
    }
}