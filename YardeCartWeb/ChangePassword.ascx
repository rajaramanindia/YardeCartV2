<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.ascx.cs" Inherits="YardeCartV2.ChangePassword" %>


    <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
    <%--<link rel="stylesheet" type="text/css" href="easyui/demo/demo.css">--%>

    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>

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
                                    <input type="password" id="txtOldpwd" style="width:200px;" class="easyui-validatebox" data-options="required:true" validType="equalsOld['#hdnOldpwd']"/>
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td class="auto-style2">
                                    <label>New Password</label>
                                </td>
                                <td class="auto-style1">
                                    <input type="password" id="txtNewpwd" style="width:200px;" class="easyui-validatebox" data-options="required:true,validType:'minLength[6]'"/>
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td class="auto-style2">
                                    <label>Confirm Password</label>
                                </td>
                                <td class="auto-style1">
                                    <input type="password" id="txtConpwd" style="width:200px;" class="easyui-validatebox"
                            data-options="required:true" validtype="equals['#txtNewpwd']"/>
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
                <input id="hdnOldpwd" type="hidden" />
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

    var sUsername;
    var sUserpassword;
    var sUserType;
    var sUserId;

    function ServiceSucceeded(result) {
        if (DataType == "json") {
            if (method == "SelectUserProfile") {

                resultObject = result;
                var obj = jQuery.parseJSON(result);
                sUsername = obj[0].UserName;
                sUserpassword = obj[0].UserPassword;
                $("#hdnOldpwd").val(sUserpassword);
            }
            else if (method == "UpdateUserPassword") {
                resultObject = result;
                hdnUserId = resultObject;
                //MailToUser();
                if (UserType == "1")
                    window.location = "MyHome.aspx";
                else if (UserType == "2")
                    window.location = "MyAdminHome.aspx";
            }
        }
    }
    function UpdatePassword() {
        var msg2 = {
            "UserId": UserId, "UserPassword": $("#txtNewpwd").val()
        };
        var objectAsJson = JSON.stringify(msg2);

        Type = "PUT";
        Url = sServicePath + "/UpdateUserPassword";
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
        Url = sServicePath + "/SendMailtoUser";
        ContentType = "application/json;charset=utf-8";
        Data = objectAsJson;
        DataType = "json"; ProcessData = false;
        method = "SendMailtoUser";
        CallService();
    }
    function GetSession() {
        $.ajax({
            url: 'Handlers/GetSession.ashx',
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
        var msg2 = { "UserId": UserId };
        var objectAsJson = JSON.stringify(msg2);
        Type = "GET";
        Url = sServicePath + "/SelectProfile/"+UserId;
        ContentType = "application/json;charset=utf-8";
        //Data = objectAsJson;
        DataType = "json"; ProcessData = false;
        method = "SelectUserProfile";
        CallService();
    }

    $(document).ready(
    function () {
        //GetSession();
        SelectProfile();
        $("#btnUpdate").click(function () {
            UpdatePassword();
            alert("Password Updated Successfully");
        });
    }
    );

    // extend the 'equals' rule
    $.extend($.fn.validatebox.defaults.rules, {
        equals: {
            validator: function (value, param) {
                return value == $(param[0]).val();
            },
            message: 'Field do not match.'
        }
    });
    $.extend($.fn.validatebox.defaults.rules, {
        equalsOld: {
            validator: function (value, param) {
                return value == $(param[0]).val();
            },
            message: 'Old password do not match.'
        }
    });

    $.extend($.fn.validatebox.defaults.rules, {
        minLength: {
            validator: function (value, param) {
                return value.length >= param[0];
            },
            message: 'Please enter at least {0} characters.'
        }
    });

</script>