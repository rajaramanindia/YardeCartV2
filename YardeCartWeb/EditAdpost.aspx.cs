using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Globalization;
using YardeCartServiceApp;
using YardeCartCommon;

namespace YardeCartV2
{
    public partial class EditAdpost : System.Web.UI.Page
    {
        YardeCartServiceApp.YardeCartServices objYser = new YardeCartServices();
        public static string strAdpostId = "";
        public static string strUserId = "";
        DataTable dt = null;
        public string[] strImagePath = new string[5];
        public static string strImageId = "";
        public static string strAllImgPath = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            errFile1.Visible = false;
            ErrCategory.Visible = false;

            if (Request.QueryString["aid"] != null)
                strAdpostId = Request.QueryString["aid"].ToString();
            if (Request.QueryString["uid"] != null)
                strUserId = Request.QueryString["uid"].ToString();

            if (!IsPostBack)
            {
                LoadCategory();
                LoadAdPost();
            }
        }

        void LoadAdPost()
        {
            YardeCartData.UserAdpost ad = new YardeCartData.UserAdpost();
            ad.AdPostId=Convert.ToInt32(strAdpostId);
            ad.UserId=Convert.ToInt32(strUserId);
            dt = objYser.GetAdDetailsDT(ad);
            if (dt.Rows.Count > 0)
            {
                txtTitle.Text = dt.Rows[0]["AdPostTitle"].ToString();
                txtDesc.Text = dt.Rows[0]["Description"].ToString();
                txtKeywords.Text = dt.Rows[0]["Keywords"].ToString();
                txtPrice.Text = dt.Rows[0]["Price"].ToString();
                txtVidolink.Text = dt.Rows[0]["VideoLink"].ToString();
                //strImagePath = dt.Rows[0]["ImagePath"].ToString().Split(':');
                strAllImgPath = dt.Rows[0]["ImagePath"].ToString();
                strImageId = dt.Rows[0]["ImageId"].ToString();

                for (int i = 0; i < ddlCategory.Items.Count; i++)
                {
                    if (ddlCategory.Items[i].Text == dt.Rows[0]["CategoryName"].ToString())
                        ddlCategory.SelectedIndex = i;
                }
                txtShowDate.Value = Convert.ToDateTime(dt.Rows[0]["AdTillDate"].ToString()).ToString();
                //HtmlGenericControl spnHtml = (HtmlGenericControl)this.Page.FindControl("spnAdImag");
                //if (spnHtml == null)
                //    return;

                BindUrl();
                //img1.Src = strImagePath[0];
                //remove1.Attributes.Add("imgpath", strImagePath[0]);
                //fileuploadImg = strImagePath[0];
            }
        }

        public void BindUrl()
        {
            VisibleNoImage();
            string sImageHtml = "";
            string appPath = ConfigurationManager.AppSettings["ApplicationPath"].ToString().Trim();
            YardeCartData.UserAdpost objad = new YardeCartData.UserAdpost();
            objad.AdPostId = Convert.ToInt32(strAdpostId);
            objad.UserId = Convert.ToInt32(strUserId);
            dt = objYser.GetAdDetailsDT(objad);
            if (dt.Rows.Count > 0)
            {
                strAllImgPath = dt.Rows[0]["ImagePath"].ToString();
                if (strAllImgPath.Trim() != "")
                    strImagePath = dt.Rows[0]["ImagePath"].ToString().Split(':');
            }
            if (strImagePath.Length >= 1 && strImagePath[0] != null && strImagePath[0] != "")
            {
                img1.Src = strImagePath[0];
                img1.Visible = true;
                remove1.Visible = true;
                remove1.Attributes.Add("imgpath", strImagePath[0]);
            }
            if (strImagePath.Length >= 2 && strImagePath[1] != null)
            {
                img2.Src = strImagePath[1];
                img2.Visible = true;
                remove2.Visible = true;

                remove2.Attributes.Add("imgpath", strImagePath[1]);

            }
            if (strImagePath.Length >= 3 && strImagePath[2] != null)
            {
                img3.Src = strImagePath[2];
                img3.Visible = true;
                remove3.Visible = true;

                remove3.Attributes.Add("imgpath", strImagePath[2]);

            }
            if (strImagePath.Length >= 4 && strImagePath[3] != null)
            {
                img4.Src = strImagePath[3];
                img4.Visible = true;
                remove4.Visible = true;

                remove4.Attributes.Add("imgpath", strImagePath[3]);

            }
            if (strImagePath.Length >= 5 && strImagePath[4] != null)
            {
                img5.Src = strImagePath[4];
                img5.Visible = true;
                remove5.Visible = true;

                remove5.Attributes.Add("imgpath", strImagePath[4]);

            }

            //sImageHtml = "<table height='100px' width='500px'><tr><td>";
            //for (int i = 0; i < strImgPath.Length; i++)
            //{
            //    sImageHtml += "<img src='" + strImgPath[i] + "' height='60px' width='50px'><a id='remImg" + i.ToString() + "' href='#' onclick=''>Remove</a>";
            //}
            //sImageHtml += "</td></tr><table>";
            //return sImageHtml;
        }

        #region .. LOAD COMBO BOX ..

        void LoadCategory()
        {
            Category cnt = new Category();
            ddlCategory.Items.Clear();
            DataTable dt1 = objYser.SelectAllCategoryDT();
            ListItem listItem = new ListItem();
            listItem.Text = "";
            listItem.Value = "0";
            //listItem.Attributes.Add("style", "background-Black:white;color:White");
            ddlCategory.Items.Add(listItem);
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                listItem = new ListItem();
                listItem.Text = dt1.Rows[i]["CategoryName"].ToString();
                listItem.Value = dt1.Rows[i]["CategoryId"].ToString();
                //listItem.Attributes.Add("style", "background-color:Black;color:white");
                ddlCategory.Items.Add(listItem);
            }
            //ddlCountry.SelectedIndex = 0;
        }

        #endregion

        protected void btnSaveAd_Click(object sender, EventArgs e)
        {
            //string str = fileuploadImg.PostedFile.FileName;
            HttpFileCollection fileCollection = Request.Files;
            for (int i = 0; i < fileCollection.Count; i++)
            {
                HttpPostedFile uploadfile = fileCollection[i];
                string fileName = Path.GetFileName(uploadfile.FileName);
            }
            YardeCartData.UserDetails usr = new YardeCartData.UserDetails();
            usr.UserId = Convert.ToInt32(strUserId);
            dt = objYser.SelectUserProfile(usr); // userid
            try
            {

                #region .. CREATE AD POST ..
                YardeCartData.AdPostDetails ad = new YardeCartData.AdPostDetails();
                ad.AdPostId = Convert.ToInt32(strAdpostId);
                ad.AdPostTitle = txtTitle.Text.ToString();
                ad.Description = txtDesc.Text.ToString();
                ad.Keywords = txtKeywords.Text.ToString();
                ad.UserId = Convert.ToInt32(strUserId);
                ad.CategoryId = Convert.ToInt32(ddlCategory.SelectedItem.Value.ToString());
                ad.Price = txtPrice.Text.ToString();
                ad.StateId = Convert.ToInt32(dt.Rows[0]["StateId"].ToString());
                ad.CityId = Convert.ToInt32(dt.Rows[0]["CityId"].ToString());
                ad.CountryId = Convert.ToInt32(dt.Rows[0]["CountryId"].ToString());
                ad.ZipCode = dt.Rows[0]["ZipCode"].ToString();
                ad.AdTillDate = txtShowDate.Value;
                ad.AdStatus = "NEW";
                ad.PaidStatus = 0;
                int intAdpostId = objYser.AddAdPost(ad);
                    
                #endregion

                YardeCartData.AdImageDetails adimg=new YardeCartData.AdImageDetails();
                adimg.AdPostId=Convert.ToInt32(strAdpostId);
                adimg.ImageId= Convert.ToInt32(strImageId);
                adimg.ImagePath=strAllImgPath;
                adimg.VideoLink = txtVidolink.Text.ToString();
                objYser.AddAdImageDetails(adimg);

                if (dt.Rows[0]["UserStatus"].ToString()=="1")
                    Response.Redirect("MyHome.aspx?page=adpost");
                else if (dt.Rows[0]["UserStatus"].ToString() == "2")
                    Response.Redirect("MyAdminHome.aspx?page=adpost");

            }
            catch (System.Threading.ThreadAbortException th)
            {
            }
            catch (Exception ex)
            {
            }
        }

        protected void remove1_Click(object sender, EventArgs e)
        {
            string sourcepath = string.Empty;
            DirectoryInfo dirInfo = null;
            string Path1 = remove1.Attributes["imgpath"].ToString();
            sourcepath = Server.MapPath("~" + Path1);

            FileInfo g = new FileInfo(sourcepath);
            if (g.Exists)
                g.Delete();

            int index = strAllImgPath.IndexOf(Path1);
            int leng = Path1.Length;
            int newlength = 0;
            int newindex = 0;

            if (index + leng == strAllImgPath.Length && index == 0)
            {
                newindex = index;
                newlength = leng;
            }
            else if (index + leng == strAllImgPath.Length && index != 0)
            {
                newindex = index - 1;
                newlength = leng + 1;
            }
            else
            {
                newindex = index;
                newlength = leng + 1;
            }

            YardeCartData.AdImageDetails adimg = new YardeCartData.AdImageDetails();
            adimg.ImageId = Convert.ToInt32(strImageId);
            adimg.ImagePath = strAllImgPath.Remove(newindex, newlength);
            objYser.UpdateAdImagePath(adimg);
            BindUrl();
        }
        protected void remove2_Click(object sender, EventArgs e)
        {
            string sourcepath = string.Empty;
            DirectoryInfo dirInfo = null;
            string Path1 = remove2.Attributes["imgpath"].ToString();
            sourcepath = Server.MapPath("~" + Path1);

            FileInfo g = new FileInfo(sourcepath);
            if (g.Exists)
                g.Delete();

            int index = strAllImgPath.IndexOf(Path1);
            int leng = Path1.Length;
            int newlength = 0;
            int newindex = 0;

            if (index + leng == strAllImgPath.Length && index == 0)
            {
                newindex = index;
                newlength = leng;
            }
            else if (index + leng == strAllImgPath.Length && index != 0)
            {
                newindex = index - 1;
                newlength = leng + 1;
            }
            else
            {
                newindex = index;
                newlength = leng + 1;
            }


            YardeCartData.AdImageDetails adimg = new YardeCartData.AdImageDetails();
            adimg.ImageId = Convert.ToInt32(strImageId);
            adimg.ImagePath = strAllImgPath.Remove(newindex, newlength);
            objYser.UpdateAdImagePath(adimg);
            
            BindUrl();
        }
        protected void remove3_Click(object sender, EventArgs e)
        {
            string sourcepath = string.Empty;
            DirectoryInfo dirInfo = null;
            string Path1 = remove3.Attributes["imgpath"].ToString();
            sourcepath = Server.MapPath("~" + Path1);


            FileInfo g = new FileInfo(sourcepath);
            if (g.Exists)
                g.Delete();

            int index = strAllImgPath.IndexOf(Path1);
            int leng = Path1.Length;
            int newlength = 0;
            int newindex = 0;

            if (index + leng == strAllImgPath.Length && index == 0)
            {
                newindex = index;
                newlength = leng;
            }
            else if (index + leng == strAllImgPath.Length && index != 0)
            {
                newindex = index - 1;
                newlength = leng + 1;
            }
            else
            {
                newindex = index;
                newlength = leng + 1;
            }

            YardeCartData.AdImageDetails adimg = new YardeCartData.AdImageDetails();
            adimg.ImageId = Convert.ToInt32(strImageId);
            adimg.ImagePath = strAllImgPath.Remove(newindex, newlength);
            objYser.UpdateAdImagePath(adimg);
            BindUrl();
        }
        protected void remove4_Click(object sender, EventArgs e)
        {
            string sourcepath = string.Empty;
            DirectoryInfo dirInfo = null;
            string Path1 = remove4.Attributes["imgpath"].ToString();
            sourcepath = Server.MapPath("~" + Path1);

            FileInfo g = new FileInfo(sourcepath);
            if (g.Exists)
                g.Delete();

            int index = strAllImgPath.IndexOf(Path1);
            int leng = Path1.Length;
            int newlength = 0;
            int newindex = 0;

            if (index + leng == strAllImgPath.Length && index == 0)
            {
                newindex = index;
                newlength = leng;
            }
            else if (index + leng == strAllImgPath.Length && index != 0)
            {
                newindex = index - 1;
                newlength = leng + 1;
            }
            else
            {
                newindex = index;
                newlength = leng + 1;
            }

            YardeCartData.AdImageDetails adimg = new YardeCartData.AdImageDetails();
            adimg.ImageId = Convert.ToInt32(strImageId);
            adimg.ImagePath = strAllImgPath.Remove(newindex, newlength);
            objYser.UpdateAdImagePath(adimg);
            BindUrl();
        }
        protected void remove5_Click(object sender, EventArgs e)
        {
            string sourcepath = string.Empty;
            DirectoryInfo dirInfo = null;
            string Path1 = remove5.Attributes["imgpath"].ToString();
            sourcepath = Server.MapPath("~" + Path1);

            FileInfo g = new FileInfo(sourcepath);
            if (g.Exists)
                g.Delete();

            int index = strAllImgPath.IndexOf(Path1);
            int leng = Path1.Length;
            int newlength = 0;
            int newindex = 0;

            if (index + leng == strAllImgPath.Length && index == 0)
            {
                newindex = index;
                newlength = leng;
            }
            else if (index + leng == strAllImgPath.Length && index != 0)
            {
                newindex = index - 1;
                newlength = leng + 1;
            }
            else
            {
                newindex = index;
                newlength = leng + 1;
            }

            YardeCartData.AdImageDetails adimg = new YardeCartData.AdImageDetails();
            adimg.ImageId = Convert.ToInt32(strImageId);
            adimg.ImagePath = strAllImgPath.Remove(newindex, newlength);
            objYser.UpdateAdImagePath(adimg);
            BindUrl();
        }

        void VisibleNoImage()
        {
            img1.Visible = false;
            img2.Visible = false;
            img3.Visible = false;
            img4.Visible = false;
            img5.Visible = false;

            remove1.Visible = false;
            remove2.Visible = false;
            remove3.Visible = false;
            remove4.Visible = false;
            remove5.Visible = false;
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            int intError = 0;
            if (FileUpload1.HasFile)
            {
                string[] strTemp = new string[5];
                strTemp = strAllImgPath.Split(':');
                if (FileUpload1.PostedFile.ContentLength > 1048576)
                {
                    errFile1.Visible = true;
                    errFile1.Text = "Exceeds maximum limit 1 MB";
                    intError++;
                }
                else if (strTemp.Length == 5 && strTemp[4] != null && strTemp[4] != "")
                {
                    errFile1.Visible = true;
                    errFile1.Text = "Maximum 5 images are allowed. ";
                    intError++;
                }
                else
                    errFile1.Visible = false;
            }
            else
            {
                string[] strTemp = new string[5];
                strTemp = strAllImgPath.Split(':');
                if (strTemp.Length == 5 && strTemp[4] != null && strTemp[4] != "")
                {
                    errFile1.Visible = true;
                    errFile1.Text = "Maximum 5 images are allowed. ";
                    intError++;
                }
                else
                {
                    errFile1.Visible = true;
                    errFile1.Text = "Select a image file. ";
                    intError++;
                }
            }
            if (intError == 0)
            {
                string path = string.Empty;
                string finalPath = string.Empty;
                string filePath = string.Empty;
                int userId = Convert.ToInt32(Session["UserId"].ToString());
                string sFilename = "";
                if (FileUpload1.PostedFile != null)
                {
                    HttpPostedFile myFile = FileUpload1.PostedFile;
                    int nFileLen = myFile.ContentLength;
                    if (nFileLen != 0)
                    {
                        DirectoryInfo dirInfo = null;
                        string fileSavePath = "/Data/TS_" + userId + "/Images/";
                        path = Server.MapPath("~" + fileSavePath);
                        if (!Directory.Exists(path))
                        {
                            dirInfo = Directory.CreateDirectory(path);
                        }
                        sFilename = System.IO.Path.GetFileName(myFile.FileName);
                        path = path + "/" + sFilename;
                        FileUpload1.PostedFile.SaveAs(path);

                        finalPath = Path.Combine(fileSavePath, sFilename);
                    }
                    if (strAllImgPath.Trim() == "")
                        strAllImgPath = finalPath;
                    else
                        strAllImgPath = strAllImgPath + ":" + finalPath;
                    
                    YardeCartData.AdImageDetails adimg = new YardeCartData.AdImageDetails();
                    adimg.ImageId = Convert.ToInt32(strImageId);
                    adimg.ImagePath = strAllImgPath;
                    objYser.UpdateAdImagePath(adimg);
            
                    BindUrl();

                }
            }
        }
    }
}