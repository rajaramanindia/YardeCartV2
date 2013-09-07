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
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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

    }
}