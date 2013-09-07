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
    public class JQCategory : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            YardeCartServiceApp.YardeCartServices objYard = new YardeCartServices();

            System.Collections.Specialized.NameValueCollection forms = context.Request.Form;
            string strOperation = forms.Get("oper");
            if (strOperation == null)
            {
                string s = objYard.SelectAllCategory();
                context.Response.Write(s);//jsonSerializer.Serialize(collectionEmployee.AsQueryable<Employee>().ToList<Employee>()));

            }
            else if (strOperation == "add")
            {
                string strOut = string.Empty;
                YardeCartData.CategoryDetails datac = new YardeCartData.CategoryDetails();

                datac.CategoryId = 0;
                datac.CategoryName = forms.Get("CategoryName");
                datac.CategoryGroupId = Convert.ToInt32(forms.Get("CategoryGroupName"));

                int id = objYard.AddCategory(datac);
                strOut = "Category record successfully updated";
                context.Response.Write(strOut);
            }
            else if (strOperation == "del")
            {
                var gid = forms.Get("CategoryId").ToString();
                objYard.CategoryDelete(Convert.ToInt32(gid));
                string strResponse = "Category record successfully removed";
                context.Response.Write(strResponse);
            }
            else
            {
                string strOut = string.Empty;

                YardeCartData.CategoryDetails datac = new YardeCartData.CategoryDetails();

                datac.CategoryId = Convert.ToInt32(forms.Get("CategoryId").ToString()); ;
                datac.CategoryName = forms.Get("CategoryName").ToString();
                datac.CategoryGroupId = Convert.ToInt32(forms.Get("CategoryGroupName"));

                int id = objYard.AddCategory(datac);
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