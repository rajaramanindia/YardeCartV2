<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="ForgotPwd.aspx.cs" Inherits="YardeCartV2.ForgotPwd" Title="Yard e-Cart Contact" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

        <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
	<%--<link rel="stylesheet" type="text/css" href="easyui/demo/demo.css">--%>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript">

        $(document).ready(
        function () {
            $("#HighlightItemHeading").attr("style", "height: 500px; width: 100%;padding-top:100px;padding-left:300px;");

            $("#SearchButton").click(function () {
                window.location = "index.aspx?searchstr=" + $("#SearchBox").val();
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
            method = "SelectUserByEmail";
            Type = "GET";
            Url = sServicePath + "/SelectUserByEmail/" + $("#txtEmail").val();
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            CallService();
        }
        function ServiceSucceeded(result) {
            if (DataType == "json") {
                if (method == "SelectUserByEmail") {
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);

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
                                <td style="text-align:right;padding-right:10px;padding-top:15px;" class="auto-style3">
                                    <strong><span class="auto-style2">E Mail Address</span></strong>
                                </td>
                                <td class="auto-style2">
                                    <input id="txtEmail" class="YardTextbox" type="text" class="easyui-validatebox" data-options="required:true,validType:'email'" />
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