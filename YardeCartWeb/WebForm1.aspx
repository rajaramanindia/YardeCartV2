<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="Login.aspx.cs" Inherits="YardeCartV2.Login" Title="Yard e-Cart Login" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <%--<script type="text/javascript">

        var Type;
        var Url;
        var Data;
        var ContentType;
        var DataType;
        var ProcessData;
        var method;
        var userId;
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
                },
                //error: ServiceFailed// When Service call fails
            });
        }

        function ServiceFailed(result) {
            alert('Service call failed: ' + result.status + '' + result.statusText);
            Type = null; Url = null; Data = null; ContentType = null; DataType = null; ProcessData = null;
        }

        function LoginUsers() {

            var msg2 = { "UserName": $("#txtUsername").val(), "UserPassword": $("#txtUserpassword").val() };
            var objectAsJson = JSON.stringify(msg2);

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
                        alert(resultObject);
                    }
                    else {
                        $.ajax({
                            url: 'SetSession.ashx?uid=' + resultObject,
                            processData: false,
                            contentType: false,
                            type: 'POST',
                            async: false,
                            success: function (data) {
                                //debugger;
                                //alert(data);
                            }
                        });
                    }
                }
            }
        }

        $(document).ready(
        function () {
            $("#butLogin").click(function () {
                LoginUsers();
                //debugger;
                window.location = "index.aspx";
                //alert("hi");

            });
        });

    </script>--%>
    
        <%--<div id="MainSection">
            <%--<div id="MainCategory">
            <br>
            <strong><label id="currentLocation" runat="server"> / Current Location:</label></strong>
	        <small style="color:#C03;">&nbsp;&nbsp;&nbsp;[Change]</small>
            <br>
            <hr>
            </div>
            -%>
            <div id="MainItem">
                <div id="HighlightItem" style="height: 500px; width: 100%;">
                    <div style="padding-top:100px;padding-left:75px;border: thin solid #800080;width: 100%; height: 237px; border-radius:5px 5px 5px 5px;">
                    <table style="border: thin solid #800080;width: 500PX; height: 237px;">
                        <tr>
                            <td colspan="2" class="auto-style1" style="background-color: #660033; font-family: sans-serif; font-weight: 500; font-size: large; color: #FFFFCC;">Login</td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div id="divErrMsg"></div>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:right;padding-right:10px;">
                                <strong><span class="auto-style2">User Name</span></strong>
                            </td>
                            <td class="auto-style2">
                                <input id="txtUsername" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:right;padding-right:10px;">                    
                                <strong><span class="auto-style2">Password</span></strong>
                            </td>
                            <td class="auto-style2">
                                <input id="txtUserpassword" type="password" />
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td class="auto-style2">
                                <input id="butLogin" type="button" value="Login" class="YardButton" style="width:120px;" /><br />
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
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

    </div>--%>
    <%--<style type="text/css">
                            .auto-style1 {
                                height: 36px;
                            }
                            .auto-style2 {
                                width: 269px;
                            }
                        </style>--%>

    <style>
        #AdShow {
	clear: none;
	float: left;
	margin-left: 4.1666%;
	width: 100%;
	display: block;
}
    </style>

    <div id="AdShow" style="height:200px;width:700px;border-radius:10px 10px 10px 10px;
    border:thin solid #800080;">
        <div style="height:30px;width:700px;border-radius:10px 10px 0px 0px;background-color:lightgray;vertical-align:middle;">
            <strong>Ad Title</strong> 
            <a href="">Edit</a>
            <a href="">Delete</a>
        </div>
        <div style="height:150px;width:300px;margin-left:10px;margin-top:10px;float:left;">
            <img src="Content/images/1803074608-1366626107.jpg" style="height:150px;width:250px;">
    </div>
        <div  style="height:35px;margin-top:10px;">Category - ddddddd</div>
        <div style="height:35px;">Posted Date - ddddddd</div>
        <div style="height:35px;">Price - ddddddd</div>
    </div>
</asp:Content>