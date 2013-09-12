<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="ViewPostAd.aspx.cs" Inherits="YardeCartV2.ViewPostAd" Title="Yard e-Cart My Home" %>

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
        function ServiceFailed(result) {
            alert('Service call failed: ' + result.status + '' + result.statusText);
            Type = null; Url = null; Data = null; ContentType = null; DataType = null; ProcessData = null;
        }
        function GetAdDetails(adId, userId) {
            var msg = { "AdPostId": adId, "UserId": userId };
            var objectAsJson = JSON.stringify(msg);

            Type = "POST";
            Data = objectAsJson;
            Url = sServicePath + "/GetAdDetails";
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
                    var MyDate_String_Value = obj[0].AdTillDate;//"/Date(1224043200000)/"
                    var value = new Date
                                (
                                     parseInt(MyDate_String_Value.replace(/(^.*\()|([+-].*$)/g, ''))
                                );
                    var dat = MonthName(value.getMonth()) + " " + value.getDate() + ", " + value.getFullYear();

                    $("#divAdTitle").text(obj[0].AdPostTitle);
                    $("#divDate").text("Posted on - "+dat);
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
                else if (method == "CreateUserCart") {
                    alert("Added Successfully and then keep shopping");
                    if(UserType=="1")
                    window.location = "MyHome.aspx?page=cart";
                    if (UserType == "2")
                        window.location = "MyAdminHome.aspx?page=cart";
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
        function AddCart() {
            //debugger;
            var msg = { "CartId": 0, "AdPostId": adid, "UserId": UserId };
            var objectAsJson = JSON.stringify(msg);

            Type = "POST";
            Data = objectAsJson;
            Url = sServicePath + "/CreateUserCart";
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "CreateUserCart";
            CallService();

        }

    </script>

    <div style="padding-top:100px;padding-left:150px;">
        <p><strong><h2>Posted Ad Information</h2></strong> </p><br />
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
                    <label id="divDate" style="font-family:sans-serif;font-size:larger;font-weight:bolder;" ></label>
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
                    <input type="button" style="width:150px;" class="YardButton" id="btnAddCart" value="Add to Cart" onclick="AddCart();" />
                    &nbsp;</td>
            </tr>
        </table>
        <p></p>
    </div>
</asp:Content>