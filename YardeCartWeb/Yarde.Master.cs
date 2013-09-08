using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Security;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using WorldDomination.Net;
using System.Net;
using Hammock;
using Hammock.Web;
using System.Web.Script.Serialization;
using YardeCartServiceApp;
//using Newtonsoft.Json;

namespace YardeCartV2
{
    public partial class Yarde : MasterPage
    {
        public string isShowHideControl = string.Empty;
        public string strServicePath = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            strServicePath = ConfigurationManager.AppSettings["ServicePath"].ToString();
            if (Request.Cookies["UserType"] != null)
            {
                Session.Add("UserType", Request.Cookies["UserType"].Value.ToString());
            }
            if (Request.QueryString.Count == 1)
            {
                //if (this.Page.Title.Contains("Activa") == false)
                {
                    //if (Session["UserId"] == null)
                        //Session.Add("UserId", Request.QueryString["uid"].ToString());
                }
            }
            else if (Request.Cookies["UserId"] != null)
            {
                Session.Add("UserId", Request.Cookies["UserId"].Value.ToString());
            }


            if ((Session["UserId"] != null && Session["UserType"] != null && Session["UserType"].ToString() == "2"))
            {
                welcomeMessage.InnerText = "Welcome Admin";
                isShowHideControl = "2";
            }
            else if (Session["UserId"] == null)
            {
                welcomeMessage.InnerText = "Welcome Guest";
                isShowHideControl = "0";
            }
            else
            {
                YardeCartServiceApp.YardeCartServices ySer=new YardeCartServices();

                YardeCartData.UserDetails yData = new YardeCartData.UserDetails();
                yData.UserId = Convert.ToInt32(Session["UserId"].ToString());
                //DataTable dt = ySer.SelectUserProfile(yData);
                //Array[] user = JsonConvert.DeserializeObject<Array[]>(dt);
                //if (dt.Rows.Count > 0)
                {
                   // welcomeMessage.InnerText = "Welcome " + dt.Rows[0]["UserName"].ToString();
                }
                isShowHideControl = "1";
            }
        }
    }
}