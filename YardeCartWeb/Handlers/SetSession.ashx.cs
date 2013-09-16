using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using YardeCartServiceApp;

namespace YardeCartV2
{
    /// <summary>
    /// Summary description for SetSession
    /// </summary>
    public class SetSession : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string s = context.Request.QueryString["uid"].ToString();
            string sRem = context.Request.QueryString["rem"].ToString();
            //if (context.Session["UserId"] == null)
            context.Session.RemoveAll();
            context.Session.Add("UserId", s);
            YardeCartData.UserDetails ou= new YardeCartData.UserDetails();
            ou.UserId=Convert.ToInt32(s);
            YardeCartServiceApp.YardeCartServices oy = new YardeCartServices();
            DataTable dt = oy.SelectUserProfile(ou);
            string stype = "";
            string UserName = "";
            string Password = "";
            if (dt.Rows.Count > 0)
            {
                stype = dt.Rows[0]["UserStatus"].ToString();
                UserName = dt.Rows[0]["UserName"].ToString();
                Password = dt.Rows[0]["UserPassword"].ToString();
            }
            context.Session.Add("UserType", stype);

            HttpCookie cUserId = new HttpCookie("UserId", s.ToString().Trim());
            HttpCookie cUsertype = new HttpCookie("UserType", stype);
            cUserId.Expires = DateTime.Now.AddDays(5);
            cUsertype.Expires = DateTime.Now.AddDays(5);
            context.Response.Cookies.Add(cUserId);
            context.Response.Cookies.Add(cUsertype);

            if (sRem == "true")
            {
                //Response.Cookies.Clear();
                HttpCookie cUsername = new HttpCookie("UserName", UserName.ToString().Trim());
                HttpCookie cPassword = new HttpCookie("Password", Password.ToString().Trim());
                cUsername.Expires = DateTime.Now.AddDays(5);
                cPassword.Expires = DateTime.Now.AddDays(5);

                context.Response.Cookies.Add(cUsername);
                context.Response.Cookies.Add(cPassword);
            }
            else
            {
                context.Request.Cookies.Remove("UserName");
                context.Request.Cookies.Remove("Password");
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}