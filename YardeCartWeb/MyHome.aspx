<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="MyHome.aspx.cs" Inherits="YardeCartV2.MyHome" Title="Yard e-Cart My Home" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <script type="text/javascript">

        var Type;
        var Url;
        var Data;
        var ContentType;
        var DataType;
        var ProcessData;
        var method;
        var UserType;
        var UserId;
        //Generic function to call AXMX/WCF  Service
        function CallService() {
            $.ajax({
                type: Type, //GET or POST or PUT or DELETE verb
                url: Url, // Location of the service
                data: Data, //Data sent to server
                contentType: ContentType, // content type sent to server
                dataType: DataType, //Expected data format from server
                processdata: ProcessData, //True or False
                dataFilter: function (data, type) {
                    // convert from "\/Date(nnnn)\/" to "new Date(nnnn)"
                    return data.replace(/"\\\/(Date\([0-9-]+\))\\\/"/gi, 'new $1');
                },

                success: function (msg) {//On Successfull service call
                    ServiceSucceeded(msg);
                },
                error: ServiceFailed// When Service call fails
            });
        }

        function ServiceFailed(result) {
            alert('Service call failed: ' + result.status + '' + result.statusText);
            Type = null; Url = null; Data = null; ContentType = null; DataType = null; ProcessData = null;
        }

        function ServiceSucceeded(result) {
            if (DataType == "json") {
                if (method == "LoginUser") {
                }

            }
        }

        $(document).ready(
        function () {
            $.ajax({
                url: 'GetSession.ashx',
                processData: false,
                contentType: false,
                type: 'GET',
                async: false,
                success: function (data) {
                    //debugger;
                    var temp = data.split('/');
                    UserType = temp[0];
                    UserId = temp[1];
                    /*
                    if (UserType == "1") {
                        $("<strong>My Profile</strong><br>"+
                            "<a href='ViewProfile.aspx'>View Profile</a><br>" +
                            "<a href='ViewProfile.aspx'>Bank Details</a><br>" +
                            "<a href='ViewProfile.aspx'>Change Password</a><br><hr>"+
                            "<strong>My Account</strong><br>"+
                            "<a href='MyAdposts.aspx'>My Ad posts</a><br>" +
                            "<a href='ViewProfile.aspx'>My Purchases</a><br>"+
                            "<a href='ViewProfile.aspx'>My Cart</a><br>"+
                            "<a href='ViewProfile.aspx'>My Pending</a><br><hr>"+
                            "<strong>Others</strong><br>"+
                            "<a href='ViewProfile.aspx'>Everything Else<br>"+
                            "<a href='ViewProfile.aspx'>Home & Lifestyle<br><br>"
                          ).appendTo("#MainCategory");
                    }
                    else if (UserType == "2") {

                        $("<strong>My Profile</strong><br>" +
                            "<a href='ViewProfile.aspx'>View Profile</a><br>" +
                            "<a href='ViewProfile.aspx'>Bank Details</a><br>" +
                            "<a href='ViewProfile.aspx'>Change Password</a><br><hr>" +
                            "<strong>My Account</strong><br>" +
                            "<a id='myadpostid'>My Ad posts</a><br>" +
                            "<a href='ViewProfile.aspx'>My Purchases</a><br>" +
                            "<a href='ViewProfile.aspx'>My Cart</a><br>" +
                            "<a href='ViewProfile.aspx'>My Pending</a><br><hr>" +
                            "<strong>Admin Section</strong><br>" +
                            "<a href='ViewProfile.aspx'>Category</a><br>" +
                            "<a href='ViewProfile.aspx'>Category Group</a><br>" +
                            "<a href='ViewProfile.aspx'>Charge List</a><br>" +
                            "<a href='ViewProfile.aspx'>Block User</a><br>" +
                            "<a href='ViewProfile.aspx'>Block Ads</a><br>" +
                            "<a href='ViewProfile.aspx'>Delete User</a><br>" +
                            "<a href='ViewProfile.aspx'>Delete Ads</a><br><hr>" +
                            "<strong>Others</strong><br>" +
                            "<a href='ViewProfile.aspx'>Everything Else<br>" +
                            "<a href='ViewProfile.aspx'>Home & Lifestyle<br><br>"
                          ).appendTo("#MainCategory");
                    }*/
                },
                error: function (errorData) {
                    //debugger;
                    alert("ERR ON  " + errorData);
                    $('.result-message').html("there was a problem uploading the file.").show();
                }
            });

            $("#myadpostid").click(function () {

            });

        });

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