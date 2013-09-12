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
    public partial class MyPuchase : System.Web.UI.UserControl
    {
        public string[] strImgpath = new string[5];
        DataTable dt = null;
        public int gridpageIndex = 0;
        string strUserId = "";
        public static decimal decTotalPrice = 0;
        YardeCartServiceApp.YardeCartServices oy = new YardeCartServices();

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Request.QueryString["uid"] != null)
            //{
            //    Session.Add("UserId", Request.QueryString["uid"].ToString());
            //    strUserId = Request.QueryString["uid"].ToString();
            //}
            //if (Request.Cookies["UserId"] != null)
            //    Session.Add("UserId", Request.Cookies["UserId"].Value.ToString());
            //if (!IsPostBack)
            //{
            //    BindAlbumGrid();
            //}
        }

        /*
        void BindAlbumGrid()
        {
            int k = GridView1.PageCount;
            GridView1.Controls.Clear();

            //gridpageIndex = 0;
            dt = oy.SelectUserPurchases(Convert.ToInt32(Session["UserId"].ToString()));
            lblCart.Text = dt.Rows.Count.ToString() + " Items in Your Purchase";

            if (dt.Rows.Count > 4)
            {
                decimal dPageSize = (dt.Rows.Count / 4M);
                //GridView1.PagerSettings.PageButtonCount = Convert.ToInt32(Math.Floor(dPageSize));
                //GridView1.PageSize = Convert.ToInt32(Math.Ceiling(dPageSize));
            }
            GridView1.DataSource = dt.DefaultView;
            GridView1.DataBind();
        }

        string BindUrl(string title, string desc, string category, string ipath, string aid, string userid, string price, string DeliveryType, string SaleDate, string DeliveryAmount)
        {
            strImgpath = ipath.Split(':');

            string path = ConfigurationManager.AppSettings["ApplicationPath"].ToString() + strImgpath[0];
            string strViewlink = ConfigurationManager.AppSettings["ApplicationPath"].ToString() + "/ViewAds.aspx?aid=" + aid + "&uid=" + userid;

            string htmlSText = @"<table style='width:100%;'>
        <tr>
            <td class='auto-style7' rowspan='6' style='border: 2px solid #FFFFFF; vertical-align: middle; text-align: center;'>
                <img src='{3}' width='200px' bordor='2' style='height: 160px'/></td>
            <td>&nbsp;</td>
            <td style='vertical-align: middle; text-align: right;'>&nbsp;<a href='{7}'>VIEW</a></td>
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
            <td class='auto-style6'>&nbsp;Delivery Type -  Charges</td>
            <td class='auto-style6'>&nbsp;{5} - {8}</td>        
        </tr>
        <tr>
            <td class='auto-style6'>&nbsp;Purchased Date</td>
            <td class='auto-style6'>&nbsp;{6}</td>
        </tr>
    </table>";

            string sTestHtml = string.Empty;
            sTestHtml = string.Format(htmlSText, title, desc, category, path, price, DeliveryType, SaleDate, strViewlink, DeliveryAmount);

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
            string sPrice = "$ " + dt.Rows[e.Row.RowIndex]["Price"].ToString().Trim();
            string sImagePath = dt.Rows[e.Row.RowIndex]["ImagePath"].ToString().Trim();
            string sAdPostId = dt.Rows[e.Row.RowIndex]["AdPostId"].ToString().Trim();
            string sPurUserId = dt.Rows[e.Row.RowIndex]["PurUserId"].ToString().Trim();
            string sAdUserId = dt.Rows[e.Row.RowIndex]["AdUserId"].ToString().Trim();
            string sSaleDate = dt.Rows[e.Row.RowIndex]["SaleDate"].ToString().Trim();
            string sDeliType = dt.Rows[e.Row.RowIndex]["ChargeType"].ToString().Trim();
            string sChargeName = dt.Rows[e.Row.RowIndex]["ChargeName"].ToString().Trim();
            string sDeliAmtorPerc = dt.Rows[e.Row.RowIndex]["ChargeAmount"].ToString().Trim();
            string sDeliAmount = "";
            if (sDeliType == "0") sDeliAmount = "$ " + String.Format("{0:0.00}", Convert.ToDouble(sDeliAmtorPerc));
            else if (sDeliType == "1")
            {
                double dbl = Convert.ToDouble(dt.Rows[e.Row.RowIndex]["Price"].ToString()) * (Convert.ToDouble(sDeliAmtorPerc) / 100);
                sDeliAmount = "$ " + String.Format("{0:0.00}", dbl);
            }
            //decTotalPrice += Convert.ToDecimal(dt.Rows[e.Row.RowIndex]["Price"].ToString());

            spnHtml.InnerHtml = BindUrl(sAdPostTitle, sDescription, sCategoryName, sImagePath, sAdPostId, sAdUserId, sPrice, sChargeName, sSaleDate, sDeliAmount);
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindAlbumGrid();
        }

        protected void btnKeep_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
        }
        */
    }
}