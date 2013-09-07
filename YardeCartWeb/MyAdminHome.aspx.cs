using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YardeCartV2
{
    public partial class MyAdminHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void viewprofileid_Click(object sender, EventArgs e)
        {
            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            ViewProfile homeHead = (ViewProfile)Page.LoadControl("ViewProfile.ascx");
            Placeholder1.Controls.Add(homeHead);

        }
        
        protected void myadpostid_Click(object sender, EventArgs e)
        {
            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            MyAdposts homeHead = (MyAdposts)Page.LoadControl("MyAdposts.ascx");
            Placeholder1.Controls.Add(homeHead);

        }

        protected void categoryid_Click(object sender, EventArgs e)
        {

            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            Category homeHead = (Category)Page.LoadControl("Category.ascx");
            Placeholder1.Controls.Add(homeHead);
        }

        protected void categorygroupid_Click(object sender, EventArgs e)
        {

            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            CategoryGroup homeHead = (CategoryGroup)Page.LoadControl("CategoryGroup.ascx");
            Placeholder1.Controls.Add(homeHead);
        
        }

        protected void chargelistid_Click(object sender, EventArgs e)
        {

            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            ChargeList homeHead = (ChargeList)Page.LoadControl("ChargeList.ascx");
            Placeholder1.Controls.Add(homeHead);
        
        }

        protected void blockuserid_Click(object sender, EventArgs e)
        {

            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            BlockUsers homeHead = (BlockUsers)Page.LoadControl("BlockUsers.ascx");
            Placeholder1.Controls.Add(homeHead);
        
        }

        protected void blockadsid_Click(object sender, EventArgs e)
        {

            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            BlockAdpost homeHead = (BlockAdpost)Page.LoadControl("BlockAdpost.ascx");
            Placeholder1.Controls.Add(homeHead);
        
        }

        protected void deleteuserid_Click(object sender, EventArgs e)
        {

            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            DeleteUsers homeHead = (DeleteUsers)Page.LoadControl("DeleteUsers.ascx");
            Placeholder1.Controls.Add(homeHead);
        
        }

        protected void deleteadsid_Click(object sender, EventArgs e)
        {

            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            DeleteAdpost homeHead = (DeleteAdpost)Page.LoadControl("DeleteAdpost.ascx");
            Placeholder1.Controls.Add(homeHead);
        
        }
                
        protected void mypurchaseid_Click(object sender, EventArgs e)
        {
            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            MyPuchase homeHead = (MyPuchase)Page.LoadControl("MyPuchase.ascx");
            Placeholder1.Controls.Add(homeHead);


        }

        protected void mycartid_Click(object sender, EventArgs e)
        {

            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            MyCart homeHead = (MyCart)Page.LoadControl("MyCart.ascx");
            Placeholder1.Controls.Add(homeHead);

        }

        protected void bankinfoid_Click(object sender, EventArgs e)
        {
            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            BankInfo homeHead = (BankInfo)Page.LoadControl("BankInfo.ascx");
            Placeholder1.Controls.Add(homeHead);


        }

        protected void editbankinfoid_Click(object sender, EventArgs e)
        {

            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            EditBankInfo homeHead = (EditBankInfo)Page.LoadControl("EditBankInfo.ascx");
            Placeholder1.Controls.Add(homeHead);

        }

        protected void editprofileid_Click(object sender, EventArgs e)
        {

            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            EditProfile homeHead = (EditProfile)Page.LoadControl("EditProfile.ascx");
            Placeholder1.Controls.Add(homeHead);

        }

        protected void changepasswordid_Click(object sender, EventArgs e)
        {

            PlaceHolder ht = (PlaceHolder)Page.FindControl("PlaceHolder1");

            Placeholder1.Controls.Clear();
            ChangePassword homeHead = (ChangePassword)Page.LoadControl("ChangePassword.ascx");
            Placeholder1.Controls.Add(homeHead);

        }
    }
}