<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="Login.aspx.cs" Inherits="YardeCartV2.Login" Title="Yard e-Cart Login" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
	<%--<link rel="stylesheet" type="text/css" href="easyui/demo/demo.css">--%>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>

    <script type="text/javascript">

        var userId;

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
                if (method == "GetAllAdDetails") {
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    //debugger;
                    var tempStart;
                    var tempEnd;
                    AdTotal = obj.length;
                    if (AdPage == 1) {
                        tempStart = 0;
                        tempEnd = AdPage * AdPageSize;
                    }
                    else {
                        tempStart = (AdPage - 1) * AdPageSize;
                        tempEnd = AdPage * AdPageSize;
                    }

                    $("#HighlightItemHeading").empty();
                    $("#SortItem").show();
                    $("#HighlightItemHeading").removeAttr("style", "height: 500px; width: 100%;padding-top:100px;padding-left:300px;");

                    for (var i = tempStart; i < obj.length && i < tempEnd; i++) {


                        var strImgPath = obj[i].ImagePath.split(':');
                        var strAdStatus = obj[i].AdStatus;
                        var sViewLink = "";
                        if (strAdStatus == "NEW")
                            sViewLink = "ViewPostAd.aspx?uid=" + obj[i].UserId + "&aid=" + obj[i].AdPostId;
                        else
                            sViewLink = "ViewPurAd.aspx?uid=" + obj[i].UserId + "&aid=" + obj[i].AdPostId;

                        $("<div id='HighlightItem2'>" +
                            "<div><strong>" + obj[i].AdPostTitle + "</strong></div>" +
                            "<div><img src=" + strImgPath[0] + " style='height:125px;' ></div>" +
                            "<div style='font-size:12px'>" + obj[i].CategoryName + "</div>" +
                            "<div><strong> $ " + parseFloat(obj[i].Price) + "</strong></div>" +
                            "<div>" + strAdStatus + "</div>" +
                            "<div><a href='" + sViewLink + "'>View Details</a> </div>"
                        ).attr("style", "padding:3px").appendTo("#HighlightItemHeading");

                    }

                }
                else if (method == "SearchAdsByKeyword") {
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    //debugger;
                    var tempStart;
                    var tempEnd;
                    AdTotal = obj.length;
                    if (AdPage == 1) {
                        tempStart = 0;
                        tempEnd = AdPage * AdPageSize;
                    }
                    else {
                        tempStart = (AdPage - 1) * AdPageSize;
                        tempEnd = AdPage * AdPageSize;
                    }

                    $("#HighlightItemHeading").empty();

                    for (var i = tempStart; i < obj.length && i < tempEnd; i++) {

                        var strImgPath = obj[i].ImagePath.split(':');
                        var strAdStatus = obj[i].AdStatus;
                        $("<div id='HighlightItem2'>" +
                            "<div><strong>" + obj[i].AdPostTitle + "</strong></div>" +
                            "<div><img src=" + strImgPath[0] + " style='height:125px;' ></div>" +
                            "<div style='font-size:12px'>" + obj[i].CategoryName + "</div>" +
                            "<div><strong> $ " + parseFloat(obj[i].Price) + "</strong></div>" +
                            "<div>" + strAdStatus + "</div>" +
                            "<div><a href='ViewPostAd.aspx?uid=" + obj[i].UserId + "&aid=" + obj[i].AdPostId + "'>View Details</a> </div>"
                        ).attr("style", "padding:3px").appendTo("#HighlightItemHeading");

                    }

                }

            }
        }

        $(document).ready(
        function () {
            $("#SortItem").hide();
            $("#HighlightItemHeading").attr("style", "height: 500px; width: 100%;padding-top:100px;padding-left:300px;");

            $("#butLogin").click(function () {
            LoginUsers();
            });

            $("#SearchButton").click(function () {
                window.location = "index.aspx?searchstr=" + $("#SearchBox").val();
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
                    <div id="SortItem">
                    <input name="TimePostedButton" id="SortButton" type="button" value="Time Posted">&nbsp;<input name="SearchButton" id="Button1" type="button" value="Sale Date">
                <div id="AdPager" class="easyui-pagination" style="border:1px solid #ccc;">
                </div>
                </div>
                
                <div id="HighlightItem">
                    <div id="HighlightItemHeading">
                    
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
                                    <a href="ForgotPwd.aspx">Forgot password</a> 
                            </td>
                        </tr>
                    </table>
                </div>
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