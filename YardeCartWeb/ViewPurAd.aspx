﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="ViewPurAd.aspx.cs" Inherits="YardeCartV2.ViewPurAd" Title="Yard e-Cart My Home" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <link href="css/flexslider.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="Scripts/jquery.flexslider.js"></script>
    <script type="text/javascript" src="Scripts/mediaelement-and-player.min.js"></script>
    <link rel="stylesheet" href="css/mediaelementplayer.css" />
    <script type="text/javascript">
        var adid = "<%=AdpostId%>";
        var adusrid = "<%=AdUserId%>";
        $(document).ready(function () {
            //debugger;
            $("#SearchButton").click(function () {
                if ($("#SearchBox").val() != "" && $("#SearchBox").val() != "Search String")
                window.location = "index.aspx?searchstr=" + $("#SearchBox").val();
                else if ($("#SearchBoxPlace").val() != "" && $("#SearchBoxPlace").val() != "Place")
                    window.location = "index.aspx?searchplace=" + $("#SearchBoxPlace").val();
                else
                    window.location = "index.aspx";

            });

            $("#btnBack").click(function(){
                if (UserType == "1") {
                    window.location = "MyHome.aspx?page=purchase";
                }
                else if (UserType == "2") {
                    window.location = "MyAdminHome.aspx?page=purchase";
                }
                else {
                    window.location = "index.aspx";
                }
            });

            GetAdDetails(adid, adusrid);
            InitializeImageSlider();
        });
        function InitializeImageSlider() {
            $('.flexslider').flexslider({
                animation: "slide",
                controlNav: true,
                directionNav: true,
                itemWidth: "100%",
                itemHeight: 400,
                width: 500
            });
        }
        function GetAdDetails(adId, userId) {
            Type = "GET";
            Url = sServicePath + "/GetAdPurcDetails/" + adId + "/" + userId;
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "GetAdDetails";
            CallService();
        }
        function ServiceSucceeded(result) {
            if (DataType == "json") {
                if (method == "GetAdDetails") {
                    //debugger;
                    resultObject = result;
                    var obj = window.JSON.parse(result);

                    //For Image slider  
                    var sImagePath = obj[0].ImagePath.split(':');
                    var s = "";
                    for (var i = 0; i < sImagePath.length; i++) {
                        s += "<li><img src='" + sImagePath[i] + "' /></li>";
                    }
                    $("<ul class='slides'>" + s + "</ul>").appendTo("#divImageSlider");

                    //For Date Format 
                    var MyDate_String_Value = obj[0].PostedDate;//"/Date(1224043200000)/"
                    var value = new Date
                                (
                                     parseInt(MyDate_String_Value.replace(/(^.*\()|([+-].*$)/g, ''))
                                );
                    var dat = MonthName(value.getMonth()) + " " + value.getDate() + ", " + value.getFullYear();
                    var pMyDate_String_Value = obj[0].SaleDate;//"/Date(1224043200000)/"
                    var pvalue = new Date
                                (
                                     parseInt(pMyDate_String_Value.replace(/(^.*\()|([+-].*$)/g, ''))
                                );
                    var Purdat = MonthName(pvalue.getMonth()) + " " + pvalue.getDate() + ", " + pvalue.getFullYear();

                    var sName = obj[0].FirstName + " " + obj[0].LastName;
                    sName = sName.toLowerCase().replace(/\b[a-z]/g, function (letter) {
                        return letter.toUpperCase();
                    });

                    var pName = obj[0].BuyFirstName + " " + obj[0].BuyLastName;
                    pName = pName.toLowerCase().replace(/\b[a-z]/g, function (letter) {
                        return letter.toUpperCase();
                    });

                    $("#divAdTitle").text(obj[0].AdPostTitle);
                    $("#divDate").text("Posted on - " + dat);
                    $("#divPurDate").text("Purchased on - " + Purdat);
                    $("<span>Posted By:</span><br/><span>Name - " + sName + "</span><br/>" +
                        "</span>Email - " + obj[0].Email + "</span><br/><span>Mobile - " + obj[0].Mobile + "</span><br/><hr>").appendTo("#divPostedBy");
                    $("<span>Purchased By:</span><br/><span>Name - " + pName + "</span><br/>" +
                        "</span>Email - " + obj[0].BuyEmail + "</span><br/><span>Mobile - " + obj[0].BuyMobile + "</span><br/><hr>").appendTo("#divPurchasedBy");
                    $("<span>Description:<br/><hr>" + obj[0].Description + "</span>").appendTo("#divDesc");
                    $("<span>Category:&nbsp;&nbsp;&nbsp;" + obj[0].CategoryName + "</span><br/><hr>").appendTo("#divCategory");
                    //debugger;
                    var p = obj[0].Price;
                    var sPrice = "Price : $ " + p.toFixed(2);
                    $("<span>" + sPrice + "</span>").appendTo("#divPrice");

                    // Play youtube video
                    var V = obj[0].VideoLink;
                    var stIndex = V.lastIndexOf("=");
                    var endIndex = V.length;
                    var Vname = V.substr(stIndex + 1, endIndex - 1 - stIndex);
                    var sVideoUrl = "http://www.youtube.com/v/" + Vname;
                    $("<object type='application/x-shockwave-flash' data='" + sVideoUrl + "' width='420' height='340'>" +
            "<param name='movie' value='" + sVideoUrl + "' />" +
            "<param name='wmode' value='transparent' />" +
            "<embed src='" + sVideoUrl + "' type='application/x-shockwave-flash' wmode='transparent' allowscriptaccess='always' allowfullscreen='true' width='480'" +
            "height='385'></embed>" +
            "</object>").appendTo("#videoLink");

                }
            }
        }
        function MonthName(mon) {
            if (mon == 1) return "January";
            else if (mon == 2) return "February";
            else if (mon == 3) return "March";
            else if (mon == 4) return "April";
            else if (mon == 5) return "May";
            else if (mon == 6) return "June";
            else if (mon == 7) return "July";
            else if (mon == 8) return "August";
            else if (mon == 9) return "September";
            else if (mon == 10) return "October";
            else if (mon == 11) return "November";
            else if (mon == 12) return "December";
        }

    </script>

    <div style="padding-top:100px;padding-left:150px;">
        <p><strong><h2>Posted Ad Information</h2></strong> </p><br />
        <div>
            <%--<input type="button" class="YardButton" id="btnBack" value="Back" style="width:80px;"/>--%>
        </div>
        <table style="border:2px solid gray; width: 750px;">
            <tr>
                <td colspan="3">
                </td>
            </tr>
            <tr>
                <td style="background-color:#669999;height:60px;vertical-align:middle;">
                    <label id="divAdTitle" style="font-family:sans-serif;font-size:x-large;font-weight:bolder;width:400px;" ></label>
                    &nbsp;</td>
                <td style="background-color:#669999;height:60px;vertical-align:middle;text-align:right;">
                    <label id="divDate" style="font-family:sans-serif;font-size:larger;font-weight:bolder;" ></label>&nbsp;&nbsp;<br />
                    <label id="divPurDate" style="font-family:sans-serif;font-size:larger;font-weight:bolder;" ></label>
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="text-align:center;" colspan="3">
                    <table style="width:600px;"><tr><td>
                         <div id="divImageSlider" class="flexslider">
                        </div>
                               </td></tr></table>
                       
                    &nbsp;</td>
            </tr>
            <tr style="background-color:#669999;text-align:left; height:30px;vertical-align:middle;font-weight:700;">
                <td colspan="3">Ad Details</td>
            </tr>
            <tr>
                <td colspan="3">
                    <div id="divPostedBy"></div>
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="3">
                    <div id="divPurchasedBy"></div>
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="3">
                    <div id="divCategory"></div>
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="3">
                    <div id="divDesc"></div>
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="3">
                    <div id="divPrice" style="font-size:x-large; width:191px; height:50px;background-color:#FFCC00; font-weight: 700;"></div>

                    &nbsp;</td>
            </tr>
            <tr style="background-color:#669999;text-align:left; height:30px;vertical-align:middle;font-weight:700;">
                <td colspan="3">Youtube For this Ad</td>
            </tr>
            <tr>
                <td style="text-align:center;" colspan="3">
                    <div id="videoLink"></div>
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="3" style="text-align:center;">
                    &nbsp;</td>
            </tr>
        </table>
        <p></p>
    </div>
</asp:Content>