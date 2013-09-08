using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using YardeCartCommon;
using YardeCartServiceApp;

namespace YardeCartV2
{
    public partial class MyAdposts : System.Web.UI.UserControl
    {
        public string[] strImgpath = new string[5];
        DataTable dt = null;
        public int gridpageIndex = 0;

        YardeCartServiceApp.YardeCartServices oY = new YardeCartServices();
 
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["UserId"] != null)
            {
                Session.Add("UserId", Request.Cookies["UserId"].Value.ToString());
            }
            //if (!IsPostBack)
            {
                BindAlbumGrid();
                if (Request.QueryString["del"] != null)
                {
                    DeleteRecord(Request.QueryString["aid"].ToString());
                }

            }
        }

        void DeleteRecord(string adpostId)
        {
            string path = string.Empty;

            oY.AdPostDeleteById(Convert.ToInt32(adpostId));

            BindAlbumGrid();
        }

        void BindAlbumGrid()
        {
            int k = GridView1.PageCount;
            GridView1.Controls.Clear();

            //gridpageIndex = 0;
            dt = oY.SelectUserAdsDT(Convert.ToInt32(Session["UserId"].ToString()));


            if (dt.Rows.Count > 4)
            {
                decimal dPageSize = (dt.Rows.Count / 4M);
                //GridView1.PagerSettings.PageButtonCount = Convert.ToInt32(Math.Floor(dPageSize));
                //GridView1.PageSize = Convert.ToInt32(Math.Ceiling(dPageSize));
            }
            GridView1.DataSource = dt.DefaultView;
            GridView1.DataBind();
        }

        string BindUrl(string title, string desc, string category, string ipath, string aid, string userid, string price, string posteddate)
        {
            strImgpath = ipath.Split(':');

            string path = ConfigurationManager.AppSettings["ApplicationPath"].ToString() + strImgpath[0];
            string strDeletelink = ConfigurationManager.AppSettings["ApplicationPath"].ToString() + "/MyAdposts.aspx?aid=" + aid + "&uid=" + userid + "&del=1";
            string strEditlink = ConfigurationManager.AppSettings["ApplicationPath"].ToString() + "/EditAdpost.aspx?aid=" + aid + "&uid=" + userid;


            string htmlSText = @"<table style='width:100%;'>
        <tr>
            <td class='auto-style7' rowspan='6' style='border: 2px solid #FFFFFF; vertical-align: middle; text-align: center;'>
                <img src='{3}' width='200px' bordor='2' style='height: 160px'/></td>
            <td>&nbsp;</td>
            <td style='vertical-align: middle; text-align: right;'>&nbsp;
                <a href='{5}' style='font-family: Arial; font-size: medium; font-weight: bold; color: #3333FF;'>Edit</a>&nbsp;&nbsp;
                <a href='{6}' style='font-family: Arial; font-size: medium; font-weight: bold; color: #3333FF;'>Delete</a>
            </td>
        </tr>
        <tr>
            <td class='auto-style6'>&nbsp;Name</td>
            <td class='auto-style6'>&nbsp;{0}</td>
        </tr>
        <tr>
            <td class='auto-style6'>&nbsp;Category</td>
            <td class='auto-style6'>&nbsp;{2}</td>
        </tr>
        <tr>
            <td class='auto-style6'>&nbsp;Price</td>
            <td class='auto-style6'>&nbsp;{4}</td>
        </tr>
        <tr>
            <td class='auto-style6'>&nbsp;Posted Date</td>
            <td class='auto-style6'>&nbsp;{7}</td>
        </tr>
    </table>";

            //<table height='100px' width='500px'>
            //<tr>
            //<td><a title='{0}' href='{3}' ><IMG SRC='{3}' width='200px' bordor='2' style='height: 160px' ></td><td>&nbsp;</td>
            //<td style='font-family: Britannic Bold; color: #00CC00;'><h1>{0}</h1>
            //<h2>{2}<h2>
            //<span>{4}</span><br/>
            //</td><td>
            //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            //<a href='{5}' style='font-family: Arial; font-size: medium; font-weight: bold; color: #3333FF;'>Edit</a>
            //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            //<a href='{6}' style='font-family: Arial; font-size: medium; font-weight: bold; color: #3333FF;'>Delete</a></td></tr></table>";

            string sTestHtml = string.Empty;
            sTestHtml = string.Format(htmlSText, title, desc, category, path, price, strEditlink, strDeletelink, posteddate);

            return sTestHtml;
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            HtmlGenericControl spnHtml = (HtmlGenericControl)e.Row.FindControl("spnHtml0");
            if (spnHtml == null)
                return;
            string sAdPostTitle = dt.Rows[e.Row.RowIndex]["AdPostTitle"].ToString().Trim();
            string sDescription = dt.Rows[e.Row.RowIndex]["Description"].ToString().Trim();
            string sCategoryName = dt.Rows[e.Row.RowIndex]["CategoryName"].ToString().Trim();
            string sPrice = " $ " + dt.Rows[e.Row.RowIndex]["Price"].ToString().Trim();
            string sImagePath = dt.Rows[e.Row.RowIndex]["ImagePath"].ToString().Trim();
            string sAdPostId = dt.Rows[e.Row.RowIndex]["AdPostId"].ToString().Trim();
            string sUserId = dt.Rows[e.Row.RowIndex]["UserId"].ToString().Trim();
            string sPostedate = dt.Rows[e.Row.RowIndex]["CreatedOn"].ToString().Trim();

            spnHtml.InnerHtml = BindUrl(sAdPostTitle, sDescription, sCategoryName, sImagePath, sAdPostId, sUserId, sPrice, sPostedate);
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindAlbumGrid();
        }

    }
}