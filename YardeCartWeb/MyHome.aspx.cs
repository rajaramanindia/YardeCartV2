using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using WorldDomination.Net;
using System.Net;
using Hammock;
using Hammock.Web;
using System.Web.Script.Serialization;

namespace YardeCartV2
{
    public partial class MyHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["page"] != null)
            {
                switch (Request.QueryString["page"].ToString())
                {
                    case "profile":
                        Placeholder1.Controls.Clear();
                        ViewProfile objViewProfile = (ViewProfile)Page.LoadControl("ViewProfile.ascx");
                        Placeholder1.Controls.Add(objViewProfile);
                        break;
                    case "bank":
                        Placeholder1.Controls.Clear();
                        BankInfo objBankInfo = (BankInfo)Page.LoadControl("BankInfo.ascx");
                        Placeholder1.Controls.Add(objBankInfo);
                        break;
                    case "cart":
                        Placeholder1.Controls.Clear();
                        MyCart objMyCart = (MyCart)Page.LoadControl("MyCart.ascx");
                        Placeholder1.Controls.Add(objMyCart);
                        break;
                    case "purchase":
                        Placeholder1.Controls.Clear();
                        MyPuchase objMyPuchase = (MyPuchase)Page.LoadControl("MyPuchase.ascx");
                        Placeholder1.Controls.Add(objMyPuchase);
                        break;
                    case "adpost":
                        Placeholder1.Controls.Clear();
                        MyAdpost objMyAdpost = (MyAdpost)Page.LoadControl("MyAdpost.ascx");
                        Placeholder1.Controls.Add(objMyAdpost);
                        break;
                }
            }
            //// To find IP address of a machine behind LAN you can use this code
            //string strHostName = Dns.GetHostName();
            //IPHostEntry ipEntry = Dns.GetHostEntry(strHostName);


            ////lblIPAddress.Text = Convert.ToString(ipEntry.AddressList[1]);
            ////lblHostName.Text = Convert.ToString(ipEntry.HostName);

            ////string clientIPLocation = string.Empty;


            //Find IP Address Behind Proxy Or Client Machine In ASP.NET
            string IPAdd = string.Empty;
            IPAdd = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];


            if (string.IsNullOrEmpty(IPAdd))
            {
                IPAdd = Request.ServerVariables["REMOTE_ADDR"];
                //lblIPBehindProxy.Text = IPAdd;
            }

            string JSON = GetLocation(IPAdd);
            if (!string.IsNullOrWhiteSpace(JSON))
            {
                JavaScriptSerializer Serializer = new JavaScriptSerializer();
                dynamic dynamicResult = Serializer.Deserialize<dynamic>(JSON);

                //Response.Write(dynamicResult["countryName"].ToString());
                //Response.Write(dynamicResult["countryCode"].ToString());
                //Response.Write(dynamicResult["city"].ToString());
                //Response.Write(dynamicResult["region"].ToString());
                //Response.Write(dynamicResult["latitude"].ToString());
                //Response.Write(dynamicResult["longitude"].ToString());

                currentLocation.InnerText = string.Format(" / Country: {0}/{1}, City: {2}/{3} ",
                    dynamicResult["countryName"].ToString(), dynamicResult["countryCode"].ToString(), dynamicResult["city"].ToString(),
                    dynamicResult["region"].ToString());
                if (Session["Location"] == null)
                    Session.Add("Location", dynamicResult["city"].ToString());

                //Session.Add("Location", "wyoming");
            }
            else
            {
                string userHostIpAddress = IPAdd; // "117.197.193.243";
                IPAddress ipAddress;
                //Response.Write("<script>alert('"+userHostIpAddress+"')</Script>");
                if (userHostIpAddress == "::1")
                {
                    userHostIpAddress = "117.197.193.243";
                }
                if (IPAddress.TryParse(userHostIpAddress, out ipAddress))
                {

                    string country = ipAddress.Country(); // return value: UNITED STATES
                    string iso3166TwoLetterCode = ipAddress.Iso3166TwoLetterCode(); // return value: US
                    currentLocation.InnerText = string.Format("Country: {0} / Location: {1} ", country, iso3166TwoLetterCode);

                    if (Session["Location"] == null)
                        Session.Add("Location", iso3166TwoLetterCode);
                    //Session.Add("Location", "wyoming");

                    //Label1.Text = country;
                }
            }
        }

        protected void myadpostid_Click(object sender, EventArgs e)
        {
            //PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            //Placeholder1.Controls.Clear();
            //MyAdpost homeHead = (MyAdpost)Page.LoadControl("MyAdpost.ascx");
            //Placeholder1.Controls.Add(homeHead);

            Response.Redirect("MyHome.aspx?page=adpost");
        }
    
        private string GetLocation(string ipAd)
        {
            try
            {
                string ipadd = string.Format("http://smart-ip.net/geoip-json/{0}", ipAd);
                var client = new RestClient
                {
                    Authority = ipadd,
                    Method = WebMethod.Get
                };
                var request = new RestRequest();

                var res = client.Request(request);
                if (res.StatusCode != HttpStatusCode.OK) return null;

                return res.Content;
            }
            catch
            {
                return null;
            }

        }

        protected void viewprofileid_Click(object sender, EventArgs e)
        {
            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            ViewProfile homeHead = (ViewProfile)Page.LoadControl("ViewProfile.ascx");
            Placeholder1.Controls.Add(homeHead);

        }

        protected void mypurchaseid_Click(object sender, EventArgs e)
        {
            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            MyPuchase homeHead = (MyPuchase)Page.LoadControl("MyPuchase.ascx");
            Placeholder1.Controls.Add(homeHead);


        }

        protected void mycartid_Click(object sender, EventArgs e)
        {

            Response.Redirect("MyHome.aspx?page=cart");


            //Placeholder1.Controls.Clear();
            //MyCart homeHead = (MyCart)Page.LoadControl("MyCart.ascx");
            //Placeholder1.Controls.Add(homeHead);

        }

        protected void bankinfoid_Click(object sender, EventArgs e)
        {
            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            BankInfo homeHead = (BankInfo)Page.LoadControl("BankInfo.ascx");
            Placeholder1.Controls.Add(homeHead);


        }

        protected void editbankinfoid_Click(object sender, EventArgs e)
        {

            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            EditBankInfo homeHead = (EditBankInfo)Page.LoadControl("EditBankInfo.ascx");
            Placeholder1.Controls.Add(homeHead);

        }

        protected void editprofileid_Click(object sender, EventArgs e)
        {

            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            EditProfile homeHead = (EditProfile)Page.LoadControl("EditProfile.ascx");
            Placeholder1.Controls.Add(homeHead);

        }

        protected void changepasswordid_Click(object sender, EventArgs e)
        {

            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            ChangePassword homeHead = (ChangePassword)Page.LoadControl("ChangePassword.ascx");
            Placeholder1.Controls.Add(homeHead);

        }

    }
}