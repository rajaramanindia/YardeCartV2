using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using YardeCartServiceApp;
using YardeCartCommon;

namespace YardeCartV2
{
    public partial class BankInfo : System.Web.UI.UserControl
    {
        string strUserid = string.Empty;
        YardeCartServiceApp.YardeCartServices oy = new YardeCartServices();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
                Session.Add("UserId", Request.Cookies["UserId"].Value.ToString());

            LoadUserInfo();
        }

        void LoadUserInfo()
        {
            YardeCartData.UserDetails ud = new YardeCartData.UserDetails();
            ud.UserId = Convert.ToInt32(Session["UserId"].ToString());
            DataTable dt = oy.SelectUserProfile(ud);
            if (dt.Rows.Count > 0)
            {
                lblBankName.Text = dt.Rows[0]["BankName"].ToString();
                lblCardHoldername.Text = dt.Rows[0]["CardHolderName"].ToString();
                lblCardNumber.Text = dt.Rows[0]["CreditCardNumber"].ToString();
                lblCVCNumber.Text = dt.Rows[0]["CVCNumber"].ToString();
            }
        }

    }
}