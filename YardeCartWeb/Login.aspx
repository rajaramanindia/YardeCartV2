<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="Login.aspx.cs" Inherits="YardeCartV2.Login" Title="Yard e-Cart Login" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
	<%--<link rel="stylesheet" type="text/css" href="easyui/demo/demo.css">--%>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>

    <script type="text/javascript">

        var userId;

        function LoginUsers() {

            var msg2 = { "UserName": $("#txtUsername").val(), "UserPassword": $("#txtUserpassword").val() };
            var objectAsJson = JSON.stringify(msg2);
            //debugger;
            Type = "POST";
            if ($("#txtUsername").val() == "admin")
                Url = sServicePath + "/LoginAdmin";
            else
                Url = sServicePath + "/LoginUser";
            Data = objectAsJson;
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "LoginUser";
            CallService();
        }

        function ServiceSucceeded(result) {
            if (DataType == "json") {
                if (method == "LoginUser") {
                    //debugger;
                    resultObject = result;
                    if (resultObject.length > 10) {
                        //alert(resultObject);
                        $("#divErrMsg").empty();
                        $("<span>" + resultObject + "</span>").appendTo("#divErrMsg");
                    }
                    else {
                        $.ajax({
                            url: 'Handlers/SetSession.ashx?uid=' + resultObject,
                            processData: false,
                            contentType: false,
                            type: 'POST',
                            async: false,
                            success: function (data) {
                                //debugger;
                                //alert(data);
                            }
                        });
                        window.location = "index.aspx";

                    }
                }
            }
        }

        $(document).ready(
        function () {
            $("#butLogin").click(function () {
            LoginUsers();
            //debugger;
            //alert("hi");

            });
        });

    </script>
    
        <div id="MainSection">
            <%--<div id="MainCategory">
            <br>
            <strong><label id="currentLocation" runat="server"> / Current Location:</label></strong>
	        <small style="color:#C03;">&nbsp;&nbsp;&nbsp;[Change]</small>
            <br>
            <hr>
            </div>
            --%>
            <div id="MainItem">
                <div id="HighlightItem" style="height: 500px; width: 100%;padding-top:100px;padding-left:300px;">
                    
                    <div style="border: thin solid #800080;width: 400px; height: 250px; border-radius:10px 10px 10px 10px;">
                    <table style="width: 400px; height: 237px;">
                        <tr>
                            <td colspan="2" class="auto-style1" style="border-radius:10px 10px 0px 0px;background-color: #660033;
 font-family: sans-serif; font-weight: 500; font-size: large; color: #FFFFCC;vertical-align:middle;">
                                &nbsp;&nbsp;Login

                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div id="divErrMsg" style="color:red;font-weight:700;"></div>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:right;padding-right:10px;" class="auto-style3">
                                <strong><span class="auto-style2">User Name</span></strong>
                            </td>
                            <td class="auto-style2">
                                <input id="txtUsername" type="text" class="easyui-validatebox" data-options="required:true" />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:right;padding-right:10px;" class="auto-style3">                    
                                <strong><span class="auto-style2">Password</span></strong>
                            </td>
                            <td class="auto-style2">
                                <input id="txtUserpassword" type="password" class="easyui-validatebox" data-options="required:true" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style3">&nbsp;</td>
                            <td class="auto-style2">
                                <input id="butLogin" type="button" value="Login" class="YardButton" style="width:120px;" /><br />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style3">&nbsp;</td>
                            <td class="auto-style2">
                                <a href="Register.aspx">Create an account</a> <br />
                                <a href="Register.aspx">Forget password</a> 
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
            
    <p></p>
    <p></p>
    <p></p>
    <p></p>
    <p></p>

    </div>
    <style type="text/css">
                            .auto-style1 {
                                height: 36px;
                            }
                            .auto-style2 {
                                width: 269px;
                            }
                        .auto-style3 {
            width: 214px;
        }
                        </style>
</asp:Content>