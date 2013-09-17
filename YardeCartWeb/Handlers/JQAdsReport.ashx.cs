using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using YardeCartServiceApp;

namespace YardeCartV2.Handlers
{
    /// <summary>
    /// Summary description for JQAdsReport
    /// </summary>
    public class JQAdsReport : IHttpHandler
    {
        string sFromDate = string.Empty;
        string sToDate = string.Empty;
        string sData = string.Empty;

        public void ProcessRequest(HttpContext context)
        {
            YardeCartServiceApp.YardeCartServices objYard = new YardeCartServices();
            if (context.Request.QueryString["dtf"] != null)
            {
                sFromDate = context.Request.QueryString["dtf"].ToString();
                sToDate = context.Request.QueryString["dtt"].ToString();
                sData = objYard.SelectReportsByDate(sFromDate, sToDate);
            }
            else if (context.Request.QueryString["reg"] != null)
            {
                sData = objYard.SelectReportsByCity(context.Request.QueryString["reg"].ToString());
            }

            context.Response.Write(sData);
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