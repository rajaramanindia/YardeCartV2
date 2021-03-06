﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyCart.ascx.cs" Inherits="YardeCartV2.MyCart" %>

<div>
    <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
	<%--<link rel="stylesheet" type="text/css" href="easyui/demo/demo.css">--%>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<style>
        #AdShow {
	clear: none;
	float: left;
	margin-left: 4.1666%;
	width: 100%;
	display: block;
}
    </style>

    <div>
        <p></p>
        <strong><label id="cartItem"></label></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input id="btnShop" type="button" value="Keep Shopping" class="YardButton"/>
    </div>
    <p>&nbsp;</p>
    <div id="divAdContent">

    </div>
    <div id="Adpaging" class="easyui-pagination" style="border:1px solid #ccc;visibility:collapse;">
    </div>
    <%--<div style="width:100%;height:30px;">
        <span>Delivery Charge</span>&nbsp;&nbsp;&nbsp;&nbsp;
        <select id="ddlCharge" style="width: 200px;" class="easyui-validatebox" data-options="required:true" onchange="DeliAmount();" />
    </div>--%>
    
    <div id="divAmtDetail" style="visibility:collapse; text-align:center; vertical-align:middle;">
        <table style="" >
            <tr>
                <td>
                        Select Delivery charge
                </td>
                <td>
        <select id="ddlCharge" style="width: 200px;" class="easyui-validatebox" data-options="required:true" onchange="DeliveryAmountDet();" />
                    <label id="lblErr"></label>
                </td>
            </tr>
        <tr>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        <tr>
                <td>
                    <label id="lblTotalAdAmont1" style="visibility:collapse;">Total Ads amount</label>
                </td>
                <td>
                    <strong><label id="lblTotalAdAmont"> </label></strong>
                    <br />

                </td>
            </tr>
        <tr>
                <td>
                    <label id="lblDeliCharge1" style="visibility:collapse;">Delivery Charges</label>
                </td>
                <td>
        <strong><label id="lblDeliCharge"></label></strong><br />

                </td>
            </tr>
        <tr>
                <td>
                    <label id="lblDeliTotAmount1"  style="visibility:collapse;">Total Amount to paid</label>
                </td>
                <td>
        <strong><label id="lblDeliTotAmount"></label></strong><br /><br />

                </td>
            </tr>
            </table>
    </div>

        <br />
    <div id="divBuybtn" style="text-align:center; vertical-align:middle;visibility:collapse;">
                        <input id="btnBuy" type="button" value="BUY" class="YardButton" style="width: 120px;" onclick="AddBuyDet();" />
        
    </div>
<br />
<br />
<br />
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
<script type="text/javascript">

    var AdPageSize = 10;
    var AdPage = 1;
    var AdTotal = 0;
    var AdTotalPrice = 0;
    var DeliTotAmount = 0;
    var DeliAmount = 0;
    var strChgType;
    var strChgAmount;
    var AdBuyArray;
    var intLocationId = 0;
    var HistroyId = 0;
    var sLocationName = "<%= strLocationName %>";
    var abspath = "<%= strAbsPath %>";
    var delact = "<%= sDel %>";
    var cid = "<%= sCartid %>";
    var boolValid = true;

    $(document).ready(
    function () {

        $("#SearchButton").click(function () {
            if ($("#SearchBox").val() != "" && $("#SearchBox").val() != "Search String")
            window.location = "index.aspx?searchstr=" + $("#SearchBox").val();
            else if ($("#SearchBoxPlace").val() != "" && $("#SearchBoxPlace").val() != "Place")
                window.location = "index.aspx?searchplace=" + $("#SearchBoxPlace").val();
            else
                window.location = "index.aspx";

        });

        $("#btnShop").click(function () {
            window.location = "index.aspx";
        });
        if (delact == "del") {
            CartDetailDelete(cid);
            alert("Adpost Removed from your Cart successfully");
        }
        //alert("u ="+UserId);
        //debugger;
        UserCartDetails();
        loadCharge();
        $('#Adpaging').pagination({
            total: AdTotal,
            pageSize: AdPageSize,
            showPageList: false,
            onSelectPage: function (pageNumber, pageSize) {
                $(this).pagination('loading');
                //alert('pageNumber:' + pageNumber + ',pageSize:' + pageSize);
                AdPage = pageNumber;
                AdPageSize = pageSize;
                UserCartDetails();
                $(this).pagination('loaded');
            }

        });

        GetLocationID();
    });
    function GetLocationID() {
        Type = "GET";
        Url = sServicePath + "/SelectCityByName/" + sLocationName;
        ContentType = "application/json;charset=utf-8";
        DataType = "json"; ProcessData = false;
        method = "SelectCityByName";
        CallService();
    }

    function AddBuyDet() {
        boolValid = true;

        if ($("#ddlCharge").val() == "0" || $("#ddlCharge").val() == "") {
            alert("Please select Delivery Charges");

            boolValid = false;
        }

        if (boolValid) {
            GetHistoryId();
            if (HistroyId == null)
                HistroyId = 0;
            HistroyId++;
            //debugger;
            for (var i = 0; i < AdBuyArray.length; i++) {

                var chgname = $('#ddlCharge option:selected').text();
                var delitype = 0;
                delitype = parseInt($("#ddlCharge").val());

                var msg = {
                    "AdPostId": AdBuyArray[i].AdPostId, "HistroyId": HistroyId, "UserId_Buyer": UserId,
                    "TotalPrice": DeliTotAmount.toFixed(2), "DeliveryType": delitype,
                    "SaleLocationId": intLocationId,
                    "CurrentStatus": "BOUGHT", "ViewersCount": 1, "ChargeName": chgname,
                    "ChargeType": strChgType, "ChargeAmount": strChgAmount
                };
                var objectAsJson = JSON.stringify(msg);
                //debugger;
                Type = "POST";
                Url = sServicePath + "/CreateBuyDetails";
                ContentType = "application/json;charset=utf-8";
                Data = objectAsJson;
                DataType = "json"; ProcessData = false;
                method = "CreateBuyDetails";
                CallService();

                //Card Status
                var msg2 = {
                    "AdPostId": AdBuyArray[i].AdPostId, "UserId": UserId
                };
                var objectAsJsonUP = JSON.stringify(msg2);
                //debugger;
                Type = "PUT";
                Url = sServicePath + "/UpdateCartStatus";
                ContentType = "application/json;charset=utf-8";
                Data = objectAsJsonUP;
                DataType = "json"; ProcessData = false;
                method = "UpdateCartStatus";
                CallService();

            }


            alert("Purchases are done successfully.");

            if (UserType == "1")
                window.location = "MyHome.aspx?page=purchase";
            else if (UserType == "2")
                window.location = "MyAdminHome.aspx?page=purchase";
        }
    }
    function GetHistoryId() {
        Type = "GET";
        Url = sServicePath + "/SelectMaxID";
        ContentType = "application/json;charset=utf-8";
        DataType = "json"; ProcessData = false;
        method = "SelectMaxID";
        CallService();
    }
    function DeliveryAmountDet() {
        var msg2 = { "ChargeId": $("#ddlCharge").val() };
        var objectAsJson = JSON.stringify(msg2);

        Type = "GET";
        Url = sServicePath + "/SelectChargeDetailsByID/" + $("#ddlCharge").val();
        ContentType = "application/json;charset=utf-8";
        //Data = objectAsJson;
        DataType = "json"; ProcessData = false;
        method = "SelectChargeDetailsByID";
        CallService();
    }
    function loadCharge() {
        Type = "GET";
        Url = sServicePath + "/SelectChargeDetails";
        ContentType = "application/json;charset=utf-8";
        DataType = "json"; ProcessData = false;
        method = "SelectChargeDetails";
        CallService();
    }
    function UserCartDetails() {
        //debugger;
        Type = "GET";
        Url = sServicePath + "/SelectUserCartDetails/" + UserId;
        ContentType = "application/json;charset=utf-8";
        DataType = "json"; ProcessData = false;
        method = "SelectUserCart";
        CallService();
    }
    function ServiceSucceeded(result) {
        if (DataType == "json") {
            if (method == "SelectChargeDetails") {
                resultObject = result;
                var obj = jQuery.parseJSON(result);
                $("<option value='0'>&nbsp;</option>").appendTo("#ddlCharge");
                for (var i = 0; i < obj.length; i++) {
                    $("<option value='" + obj[i].ChargeId + "'>" + obj[i].ChargeName + "</option>").appendTo("#ddlCharge");
                }
            }
            else if (method == "CreateBuyDetails") {
                resultObject = result; 
                var obj = jQuery.parseJSON(result);
            }
            else if (method == "UpdateCartStatus") {
                //debugger;
                resultObject = result; 
                var obj = jQuery.parseJSON(result);
            }
            else if (method == "SelectMaxID") {
                //debugger;
                resultObject = result;
                var obj = jQuery.parseJSON(result);
                HistroyId = obj[0].HistroyId;
            }
            else if (method == "SelectCityByName") {
                //debugger;
                resultObject = result;
                var obj = jQuery.parseJSON(result);
                if (obj.length == 0)
                    intLocationId = 0;
                else
                    intLocationId = obj[0].CityId;
            }
            else if (method == "SelectUserCart") {
                //debugger;
                resultObject = result;
                var obj = jQuery.parseJSON(result);
                var tempStart;
                var tempEnd;
                AdTotal = obj.length;
                AdBuyArray = obj;

                $("#cartItem").text(AdTotal + " Items in your cart");
                if (AdPage == 1) {
                    tempStart = 0;
                    tempEnd = AdPage * AdPageSize;
                }
                else {
                    tempStart = (AdPage - 1) * AdPageSize;
                    tempEnd = AdPage * AdPageSize;
                }

                $("#divAdContent").empty();
                if (AdTotal > 0) {
                    $("#divAmtDetail").attr("style", "visibility:visible;vertical-align:middle;padding-left:200px;");
                    $("#divBuybtn").attr("style", "text-align:center; vertical-align:middle;visibility:visible;");
                }
                else {
                    $("#divAmtDetail").attr("style", "visibility:collapse;vertical-align:middle;padding-left:200px;");
                    $("#divBuybtn").attr("style", "text-align:center; vertical-align:middle;visibility:collapse;");
                }
                AdTotalPrice = 0;
                for (var i = tempStart; i < obj.length && i < tempEnd; i++) {

                    AdTotalPrice = AdTotalPrice + obj[i].Price;

                    var strImgPath = obj[i].ImagePath.split(':');
                    //var strAdStatus = obj[i].AdStatus;

                    //For Date Format 
                    var MyDate_String_Value = obj[i].PostedDate;
                    var valueDat = new Date
                                (
                                     parseInt(MyDate_String_Value.replace(/(^.*\()|([+-].*$)/g, ''))
                                );
                    var dat = MonthName(valueDat.getMonth()) + " " + valueDat.getDate() + ", " + valueDat.getFullYear();

                    //For Price value
                    var p = obj[i].Price;
                    var sPrice = "$ " + p.toFixed(2);
                    var sRemovelink = abspath + "?page=cart&act=del&cid=" + obj[i].CartId + "&uid=" + UserId;

                    $("<div id='AdShow' style='height:200px;width:700px;border-radius:10px 10px 10px 10px;border:thin solid #800080;'>" +
                        "<div style='height:30px;width:700px;border-radius:10px 10px 0px 0px;background-color:lightgray;vertical-align:middle;'>" +
                        "<strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + obj[i].AdPostTitle + "</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
                        "<a href='" + sRemovelink + "'>Remove</a></div>" +
                        "<div style='height:150px;width:300px;margin-left:10px;margin-top:10px;float:left;'>" +
                        "<img src=" + strImgPath[0] + " style='height:150px;width:250px;'></div>" +
                        "<div  style='height:35px;margin-top:10px;'>Category - " + obj[i].CategoryName + "</div>" +
                        "<div style='height:35px;'>Posted Date - " + dat + "</div>" +
                        "<div style='height:35px;'>Price - " + sPrice + "</div></div><br>"

                    ).appendTo("#divAdContent");

                }

            }
            else if (method == "SelectChargeDetailsByID") {
                //debugger;
                //alert(AdTotalPrice.toFixed(2));
                //$("<div id='AdShow'><span>Total Ad Amount - </span></div>").appendTo("#divAmtDetail");

                resultObject = result;
                var obj = jQuery.parseJSON(result);

                if (obj.length > 0) {
                    for (var i = 0; i < obj.length; i++) {
                        strChgType = obj[i].ChargeType;
                        strChgAmount = obj[i].AmountOrPercent;
                        DeliTotAmount = 0;
                        DeliAmount = 0;

                        if (strChgType == "0") {
                            DeliAmount = strChgAmount;
                            DeliTotAmount = DeliAmount + AdTotalPrice;
                        }
                        else if (strChgType == "1") {
                            DeliAmount = (AdTotalPrice * (strChgAmount / 100));
                            DeliTotAmount = DeliAmount + AdTotalPrice;
                        }

                        $("#lblTotalAdAmont1").attr("style", "visibility:visible;")
                        $("#lblDeliCharge1").attr("style", "visibility:visible;")
                        $("#lblDeliTotAmount1").attr("style", "visibility:visible;")
                        $("#lblTotalAdAmont").text(" $ " + AdTotalPrice.toFixed(2));
                        $("#lblDeliCharge").text(" $ " + DeliAmount.toFixed(2));
                        $("#lblDeliTotAmount").text(" $ " + DeliTotAmount.toFixed(2));

                    }
                }
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
    function CartDetailDelete(cartID) {

        var msg2 = { "CartId": cartID };
        var objectAsJson = JSON.stringify(msg2);

        Type = "DELETE";
        Url = sServicePath + "/CartDetailDelete";
        ContentType = "application/json;charset=utf-8";
        Data = objectAsJson;
        DataType = "json"; ProcessData = false;
        method = "CartDetailDelete";
        CallService();
    }

    </script>
</div>
