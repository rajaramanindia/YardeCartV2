using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Web;

namespace YardeCartV2
{
    /// <summary>
    /// Summary description for UploadFile
    /// </summary>
    public class UploadFile : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
    {
        string strUserid = string.Empty;

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                if (context.Session["UserId"] != null)
                strUserid = context.Session["UserId"].ToString();
        
                //Uploaded File Deletion
                if (context.Request.QueryString.Count > 0)
                {
                    string filePath = HttpContext.Current.Server.MapPath("../Data/TS_" + strUserid + "/Images/") + "//" + context.Request.QueryString[0].ToString();
                    if (File.Exists(filePath))
                        File.Delete(filePath);
                }
                else
                {// Upload file

                    if (context.Request.Files[0].ContentLength < 1048576)
                    {
                    var ext = System.IO.Path.GetExtension(context.Request.Files[0].FileName);
                    var fileName = Path.GetFileName(context.Request.Files[0].FileName);

                    if (context.Request.Files[0].FileName.LastIndexOf("\\") != -1)
                    {
                        fileName = context.Request.Files[0].FileName.Remove(0, context.Request.Files[0].FileName.LastIndexOf("\\")).ToLower();
                    }



                    fileName = GetUniqueFileName(fileName, HttpContext.Current.Server.MapPath("../Data/TS_" + strUserid + "/Images/"), ext).ToLower();
                    string savepath = HttpContext.Current.Server.MapPath("../Data/TS_" + strUserid + "/Images/");

                    if (!Directory.Exists(savepath))
                        Directory.CreateDirectory(savepath);


                    string location = HttpContext.Current.Server.MapPath("../Data/TS_" + strUserid + "/Images/") + fileName + ext;
                    context.Request.Files[0].SaveAs(location);
                    context.Response.Write(fileName + ext);
                    }
                    else
                    {
                        context.Response.Write("Image size cannot exceeded 1 MB");
                    }
                    //string sUserid = context.Session["UserId"].ToString();
                    //HttpPostedFile postedFile = context.Request.Files["file"];
                    //var sFilename = Path.GetFileName(postedFile.FileName);

                    //savepath = savepath + "/" + sFilename;
                    //postedFile.SaveAs(savepath);
                    //string finalPath = Path.Combine(savepath, sFilename);
                    //context.Response.Write(finalPath);
                }           
            }
            catch (Exception ex)
            {
                context.Response.Write("Error: " + ex.Message);
            }
        }

        public static string GetUniqueFileName(string name, string savePath, string ext)
        {

            name = name.Replace(ext, "").Replace(" ", "_");
            name = System.Text.RegularExpressions.Regex.Replace(name, @"[^\w\s]", "");

            var newName = name;
            var i = 0;
            if (System.IO.File.Exists(savePath + newName + ext))
            {

                do
                {
                    i++;
                    newName = name + "_" + i;

                }
                while (System.IO.File.Exists(savePath + newName + ext));

            }

            return newName;


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