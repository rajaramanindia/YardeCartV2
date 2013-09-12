using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using YardeCartServiceApp;

namespace YardeCartV2
{
    /// <summary>
    /// Summary description for JQCategory
    /// </summary>
    public class JQBlockUsers : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            YardeCartServiceApp.YardeCartServices objYard = new YardeCartServices();

            System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
            string strOperation = forms.Get("oper");
            if (strOperation == null)
            {
                string s = objYard.SelectAllProfile();
                context.Response.Write(s);
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