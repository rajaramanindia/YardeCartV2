using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YardeCartV2
{
    /// <summary>
    /// Summary description for GetSession
    /// </summary>
    public class GetSession : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.Write(context.Session["UserType"] + "/" + context.Session["UserId"]);
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