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
    /// Summary description for JQHandler
    /// </summary>
    public class JQHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            YardeCartServiceApp.YardeCartServices objYard = new YardeCartServices();

            System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
            string strOperation = forms.Get("oper");
            if (strOperation == null)
            {
                string s = objYard.SelectAllCategoryGroup();
                context.Response.Write(s);//jsonSerializer.Serialize(collectionEmployee.AsQueryable<Employee>().ToList<Employee>()));
                
            }
            else if (strOperation == "add")
            {
                string strOut = string.Empty;
                YardeCartData.CategoryGroupDetails datac = new YardeCartData.CategoryGroupDetails();

                datac.CategoryGroupId = 0;
                datac.CategoryGroupName = forms.Get("CategoryGroupName");

                int id = objYard.AddCategoryGroup(datac);
                strOut = "Category Group record successfully updated";
                context.Response.Write(strOut);
            }
            else if (strOperation == "del")
            {
                var gid = forms.Get("GroupId").ToString();
                objYard.CategoryGroupDelete(Convert.ToInt32(gid));
                string strResponse = "Category Group record successfully removed";
                context.Response.Write(strResponse);
            }
            else
            {
                string strOut = string.Empty;

                YardeCartData.CategoryGroupDetails datac = new YardeCartData.CategoryGroupDetails();

                datac.CategoryGroupId = Convert.ToInt32(forms.Get("GroupId").ToString()); ;
                datac.CategoryGroupName = forms.Get("CategoryGroupName").ToString();
                int id = objYard.AddCategoryGroup(datac);
                strOut = "Category Group record successfully updated";

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