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
    /// Summary description for JQCharge
    /// </summary>
    public class JQCharge : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            YardeCartServiceApp.YardeCartServices objYard = new YardeCartServices();

            System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
            string strOperation = forms.Get("oper");
            if (strOperation == null)
            {
                string s = objYard.SelectChargeDetails();
                s = s.Replace("\"ChargeType\":0", "\"ChargeType\":\"Amount\"");
                s = s.Replace("\"ChargeType\":1", "\"ChargeType\":\"Percentage\"");
                context.Response.Write(s);//jsonSerializer.Serialize(collectionEmployee.AsQueryable<Employee>().ToList<Employee>()));

            }
            else if (strOperation == "add")
            {
                string strOut = string.Empty;
                YardeCartData.ChargeDetails datac = new YardeCartData.ChargeDetails();

                datac.ChargeId = 0;
                datac.ChargeName = forms.Get("ChargeName");
                datac.ChargeType = Convert.ToInt32(forms.Get("ChargeType"));
                datac.AmountOrPercent = forms.Get("AmountOrPercent").ToString();

                int id = objYard.AddChargeDetails(datac);
                strOut = "Category record successfully updated";
                context.Response.Write(strOut);
            }
            else if (strOperation == "del")
            {
                var gid = forms.Get("ChargeId").ToString();
                objYard.ChargeDetailsDelete(Convert.ToInt32(gid));
                string strResponse = "Category record successfully removed";
                context.Response.Write(strResponse);
            }
            else
            {
                string strOut = string.Empty;

                YardeCartData.ChargeDetails datac = new YardeCartData.ChargeDetails();

                datac.ChargeId = Convert.ToInt32(forms.Get("ChargeId").ToString()); ;
                datac.ChargeName = forms.Get("ChargeName");
                datac.ChargeType = Convert.ToInt32(forms.Get("ChargeType"));
                datac.AmountOrPercent = forms.Get("AmountOrPercent").ToString();

                int id = objYard.AddChargeDetails(datac);
                strOut = "Category record successfully updated";

                context.Response.Write(strOut);
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