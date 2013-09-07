using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.UI.WebControls;

namespace YardeCartV2
{
    /// <summary>
    /// Summary description for UserSession
    /// </summary>
    public class UserSession : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        public void ProcessRequest(HttpContext context)
        {
            string s= context.Request["uid"].ToString();
            if (context.Session["UserId"] == null)
                context.Session.Add("UserId", s);
            context.Response.Write(context.Session["UserId"].ToString());

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