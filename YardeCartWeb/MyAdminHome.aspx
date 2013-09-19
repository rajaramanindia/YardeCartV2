<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="MyAdminHome.aspx.cs" Inherits="YardeCartV2.MyAdminHome" Title="Yard e-Cart My Home" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <script type="text/javascript">

        $(document).ready(
        function () {
            $("#SearchButton").click(function () {
                if ($("#SearchBox").val() != "" && $("#SearchBox").val() != "Search String")
                window.location = "index.aspx?searchstr=" + $("#SearchBox").val();
                else if ($("#SearchBoxPlace").val() != "" && $("#SearchBoxPlace").val() != "Place")
                    window.location = "index.aspx?searchplace=" + $("#SearchBoxPlace").val();
                else
                    window.location = "index.aspx";

            });
        }
        );

    </script>
    
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
                <strong>My Account</strong><br>
                <asp:LinkButton ID='myadpostid' runat="server" OnClick="myadpostid_Click">My Ad posts</asp:LinkButton><br>
                <asp:LinkButton ID='mypurchaseid' runat="server" OnClick="mypurchaseid_Click">My Purchases</asp:LinkButton><br>
                <asp:LinkButton ID='mycartid' runat="server" OnClick="mycartid_Click">My Cart</asp:LinkButton><br><hr>
                <strong>Manage Users/Ads</strong><br>
                <asp:LinkButton ID='categoryid' runat="server" OnClick="categoryid_Click" >Category</asp:LinkButton><br>
                <asp:LinkButton ID='categorygroupid' runat="server" OnClick="categorygroupid_Click" >Category Group</asp:LinkButton><br>
                <asp:LinkButton ID='chargelistid' runat="server" OnClick="chargelistid_Click" >Charge List</asp:LinkButton><br>
                <asp:LinkButton ID='blockuserid' runat="server" OnClick="blockuserid_Click" >Block User</asp:LinkButton><br>
                <asp:LinkButton ID='blockadsid' runat="server" OnClick="blockadsid_Click" >Block Ads</asp:LinkButton><br>
                <asp:LinkButton ID='deleteuserid' runat="server" OnClick="deleteuserid_Click" >Delete User</asp:LinkButton><br>
                <asp:LinkButton ID='deleteadsid' runat="server" OnClick="deleteadsid_Click" >Delete Ads</asp:LinkButton><br>
                <asp:LinkButton ID='reportadsid' runat="server" OnClick="reportadsid_Click" >Reports</asp:LinkButton><br><hr>
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