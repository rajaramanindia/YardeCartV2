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
    /// Summary description for JQBlockAdpost
    /// </summary>
    public class JQBlockAdpost : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string sopt = string.Empty;
            string skey = string.Empty;
            string sData = string.Empty;

            YardeCartServiceApp.YardeCartServices objYard = new YardeCartServices();

            System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
            string strOperation = forms.Get("oper");

            if (strOperation == null && context.Request.QueryString != null)
            {
                sopt = context.Request.QueryString["opt"].ToString();
                skey = context.Request.QueryString["str"].ToString();
                if (sopt == "1")
                    sData = objYard.SearchAdsByUsername(skey);
                else if (sopt == "2")
                    sData = objYard.SearchAdsByAdtitle(skey);

                context.Response.Write(sData);
            }
            else
            {

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