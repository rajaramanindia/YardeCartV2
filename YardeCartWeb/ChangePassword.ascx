<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.ascx.cs" Inherits="YardeCartV2.ChangePassword" %>
<div style="vertical-align:central;padding-left:100px;padding-top:50px">
        <div >
            <h3 >Change Password</h3><br />
        </div>
        <div>
            <table style="width:571px; border-bottom-left-radius:4px;border-width:thin; border-style:groove">
                <tr>
                    <td style="vertical-align:central;">
                        <div style="vertical-align:central;"> 
                        <table>
                            <tr style="height:40px;">
                                <td class="auto-style2">
                                    <label>Old Password</label>
                                </td>
                                <td class="auto-style1">
                                    <input type="text" id="txtOldpwd" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td class="auto-style2">
                                    <label>New Password</label>
                                </td>
                                <td class="auto-style1">
                                    <input type="text" id="txtNewpwd" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td class="auto-style2">
                                    <label>Confirm Password</label>
                                </td>
                                <td class="auto-style1">
                                    <input type="text" id="txtConpwd" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td class="auto-style2">
                                </td>
                                <td class="auto-style1">
                    <input id="btnUpdate" type="button" value="Update" />
                    <input id="btnReset" type="button" value="Reset" />
                                </td>
                            </tr>
                        </table>
                        </div>
                    </td>
                </tr>
                
            </table>
        </div>
    </div>

<style type="text/css">
    .auto-style1 {
        width: 408px;
    }
    .auto-style2 {
        width: 305px;
    }
</style>

<script type="text/javascript">


    var Type;
    var Url;
    var Data;
    var ContentType;
    var DataType;
    var ProcessData;
    var method;
    var sUsername;
    var sUserpassword;
    var sUserType;
    var sUserId;

    //Generic function to call AXMX/WCF  Service
    function CallService() {
        $.ajax({
            type: Type, //GET or POST or PUT or DELETE verb
            url: Url, // Location of the service
            data: Data, //Data sent to server
            contentType: ContentType, // content type sent to server
            dataType: DataType, //Expected data format from server
            processdata: ProcessData, //True or False
            async: false,
            dataFilter: function (data, type) {
                // convert from "\/Date(nnnn)\/" to "new Date(nnnn)"
                return data.replace(/"\\\/(Date\([0-9-]+\))\\\/"/gi, 'new $1');
            },

            success: function (msg) {//On Successfull service call
                ServiceSucceeded(msg);
            }
            //error: ServiceFailed// When Service call fails
        });
    }
    function ServiceFailed(result) {
        alert('Service call failed: ' + result.status + '' + result.statusText);
        Type = null; Url = null; Data = null; ContentType = null; DataType = null; ProcessData = null;
    }
    function ServiceSucceeded(result) {
        if (DataType == "json") {
            if (method == "SelectProfile") {

                resultObject = result;
                var obj = jQuery.parseJSON(result);
                sUsername = obj[0].UserName;
                sUserpassword = obj[0].UserPassword;

            }
            else if (method == "UpdateUserPassword") {
                resultObject = result;
                hdnUserId = resultObject;
                //MailToUser();
                if (sUserType == "1")
                    window.location = "MyHome.aspx";
                else if (sUserType == "2")
                    window.location = "MyAdminHome.aspx";
            }
        }
    }
    function UpdatePassword() {
        var msg2 = {
            "UserId": sUserId, "UserPassword": $("#txtNewpwd").val()
        };
        var objectAsJson = JSON.stringify(msg2);

        Type = "POST";
        Url = "http://localhost:1098/UpdateUserPassword";
        ContentType = "application/json;charset=utf-8";
        Data = objectAsJson;
        DataType = "json"; ProcessData = false;
        method = "UpdateUserPassword";
        CallService();


    }
    function MailToUser() {
        var valop = $('input:radio[name=rdoGender]:checked').val();
        var msg2 = {
            "UserId": intUserid, "UserName": $("#txtUsername").val(), "UserPassword": $("#txtUserPassword").val(), "FirstName": $("#txtFirstName").val()
        , "LastName": $("#txtLastName").val(), "Gender": $('input:radio[name=rdoGender]:checked').val(), "Address": $("#txtAddress").val(), "StreetName": $("#txtStreetName").val()
        , "Email": $("#txtEmail").val(), "MobilePhone": $("#txtMobilePhone").val(), "CountryId": $("#ddlCountry").val(), "StateId": $("#ddlState").val()
        , "CityId": $("#ddlCity").val(), "ZipCode": $("#txtZipCode").val()
        };
        var objectAsJson = JSON.stringify(msg2);
        Type = "POST";
        Url = "http://localhost:1098/SendMailtoUser";
        ContentType = "application/json;charset=utf-8";
        Data = objectAsJson;
        DataType = "json"; ProcessData = false;
        method = "SendMailtoUser";
        CallService();
    }
    function GetSession() {
        $.ajax({
            url: 'GetSession.ashx',
            processData: false,
            contentType: false,
            type: 'GET',
            async: false,
            success: function (data) {
                var temp = data.split('/');
                sUserType = temp[0];
                sUserId = temp[1];
            }
        });
    }
    function SelectProfile() {
        var msg2 = { "UserId": sUserId };
        var objectAsJson = JSON.stringify(msg2);
        Type = "POST";
        Url = "http://localhost:1098/SelectProfile";
        ContentType = "application/json;charset=utf-8";
        Data = objectAsJson;
        DataType = "json"; ProcessData = false;
        method = "SelectProfile";
        CallService();
    }

    $(document).ready(
    function () {
        GetSession();
        SelectProfile();
        $("#btnUpdate").click(function () {
            UpdatePassword();
            alert("Password Updated Successfully");
        });
    }
    );


</script>