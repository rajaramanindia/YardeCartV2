<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="MyHome.aspx.cs" Inherits="YardeCartV2.MyHome" Title="Yard e-Cart My Home" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    
    <div id="MainSection">
            <div id="MainCategory">
                <br>
                <strong><label id="currentLocation" runat="server"> / Current Location:</label></strong>
	            <small style="color:#C03;">&nbsp;&nbsp;&nbsp;[Change]</small>
                <br>
                <hr>
                <strong>Manage My Profile</strong><br>
                <asp:LinkButton ID='viewprofileid' runat="server" OnClick="viewprofileid_Click">View Profile</asp:LinkButton>
                <asp:LinkButton ID='editprofileid' runat="server" OnClick="editprofileid_Click">
	            <small style="color:#C03;">&nbsp;&nbsp;&nbsp;[Edit]</small>
                 </asp:LinkButton><br>
                <asp:LinkButton ID='bankinfoid' runat="server" OnClick="bankinfoid_Click">Bank Details</asp:LinkButton>
                <asp:LinkButton ID='editbankinfoid' runat="server" OnClick="editbankinfoid_Click">
	            <small style="color:#C03;">&nbsp;&nbsp;&nbsp;[Edit]</small>
                </asp:LinkButton><br>
                <asp:LinkButton ID='changepasswordid' runat="server" OnClick="changepasswordid_Click">Change Password</asp:LinkButton><br><hr>
                <strong>Manage My Ads</strong><br>
                <asp:LinkButton ID='myadpostid' runat="server" OnClick="myadpostid_Click">My Ad posts</asp:LinkButton><br>
                <asp:LinkButton ID='mycartid' runat="server" OnClick="mycartid_Click">My Cart</asp:LinkButton><br>
                <hr>
                 <strong>Manage My Paid Ads</strong><br>
                <asp:LinkButton ID='mypurchaseid' runat="server" OnClick="mypurchaseid_Click">My Purchases</asp:LinkButton><br>
                <asp:LinkButton ID='mypendingid' runat="server">My Pending</asp:LinkButton><br><hr>
                <strong>Others</strong><br>
                <asp:LinkButton ID='myadpostid1' runat="server">Everything Else</asp:LinkButton><br>
                <asp:LinkButton ID='myadpostid2' runat="server">Home & Lifestyle</asp:LinkButton><br><br>

            </div>
            <div id="MainItem">
                <asp:PlaceHolder ID="Placeholder1" runat="server">
                </asp:PlaceHolder>
            </div>
        </div>

</asp:Content>