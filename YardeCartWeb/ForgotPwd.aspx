<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="ForgotPwd.aspx.cs" Inherits="YardeCartV2.ForgotPwd" Title="Yard e-Cart Contact" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

        <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
	<%--<link rel="stylesheet" type="text/css" href="easyui/demo/demo.css">--%>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript">

        var boolValid = true;

        $(document).ready(
        function () {
            $("#HighlightItemHeading").attr("style", "height: 500px; width: 100%;padding-top:100px;padding-left:300px;");

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

        function MailToUser(sData) {

            Type = "POST";
            Url = sServicePath + "/SendMailForgot";
            ContentType = "application/json;charset=utf-8";
            Data = sData;
            DataType = "json"; ProcessData = false;
            method = "SendMailForgot";
            CallService();
        }
        function SelectUserByEmail() {
            boolValid = true;
            if($("#txtEmail").val() == "" || validateEmailAddr($("#txtEmail").val()) == false){
                boolValid = false;
                alert("Invalid Email address");
            }
            if (boolValid) {
            method = "SelectUserByEmail";
            Type = "GET";
            Url = sServicePath + "/SelectUserByEmail/" + $("#txtEmail").val();
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            CallService();
        }
        }
        function validateEmailAddr(sEmail) {
            var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            if (filter.test(sEmail)) 
                return true;
            else 
                return false;
        }

        function ServiceSucceeded(result) {
            if (DataType == "json") {
                if (method == "SelectUserByEmail") {
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    if (obj.length > 0) {
                    var msg2 = {
                        "UserId": obj[0].UserID, "UserName": obj[0].UserName, "UserPassword": obj[0].UserPassword, "FirstName": obj[0].FirstName
        , "LastName": obj[0].LastName, "Gender": obj[0].Gender, "Address": obj[0].Address, "StreetName": obj[0].StreetName
        , "Email": $("#txtEmail").val(), "MobilePhone": obj[0].Mobile
                    };
                    var objectAsJson = JSON.stringify(msg2);
                    MailToUser(objectAsJson);
                    $("#divErrMsg").empty();
                    $("<strong>User Name and Password are sending to " + $("#txtEmail").val() + ". Check your mail..</strong><br/>").appendTo("#divErrMsg");

                    $("#txtEmail").val("");
                }
                    else {
                        $("#divErrMsg").empty();
                        $("<strong>User is not available on " + $("#txtEmail").val() + ".</strong><br/>").appendTo("#divErrMsg");
                    }
                }
            }
        }

    </script>
    
        <div id="MainSection">
            <%--<div id="MainCategory">
            <br>
            <strong><label id="currentLocation" runat="server"> / Current Location:</label></strong>
	        <small style="color:#C03;">&nbsp;&nbsp;&nbsp;[Change]</small>
            <br>
            <hr>
            </div>--%>
            <div id="MainItem">
                <div id="HighlightItem">
                    <div id="HighlightItemHeading">
                    
                        <div style="border: thin solid #800080;width: 400px; height: 250px; border-radius:10px 10px 10px 10px;">
                        <table style="width: 400px; height: 237px;">
                            <tr>
                                <td colspan="2" class="auto-style1" style="border-radius:10px 10px 0px 0px;background-color: #660033;
     font-family: sans-serif; font-weight: 500; font-size: large; color: #FFFFCC;vertical-align:middle;">
                                    &nbsp;&nbsp;Forgot Password
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div id="divErrMsg" style="color:black;font-weight:700;"></div>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:right;padding-right:10px;padding-top:5px;" class="auto-style3">
                                    <strong><span class="auto-style2">E Mail Address</span></strong>
                                </td>
                                <td class="auto-style2">
                                    <input id="txtEmail" type="text" class="easyui-validatebox" data-options="required:true,validType:'email'" 
                                        style="padding:5px 5px 5px 5px;border:1px solid #1c1c1c;border-radius: 3px;" />
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style3">&nbsp;</td>
                                <td class="auto-style2">
                                    <input id="btnSend" type="button" value="Send" class="YardButton" style="width:120px;" onclick="SelectUserByEmail();" /><br />
                                </td>
                            </tr>
                        </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

</asp:Content>