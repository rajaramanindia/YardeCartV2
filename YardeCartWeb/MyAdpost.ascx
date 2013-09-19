<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyAdpost.ascx.cs" Inherits="YardeCartV2.MyAdpost" %>


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

<div id="Adpaging" class="easyui-pagination" style="background:#efefef;border:1px solid #ccc;">
                </div>


<div id="divAdContent">


</div>

<script type="text/javascript">

    var AdPageSize = 10;
    var AdPage = 1;
    var AdTotal = 0;
    var abspath = "<%= strAbsPath %>";
    var delact = "<%= sDel %>";
    var adid = "<%= sAdid %>";

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

        if (delact == "del") {
            DeleteAdpost(adid);
            alert("Adpost deleted successfully");
        }

        UserAdDetails();
        $('#Adpaging').pagination({
            total: AdTotal,
            pageSize: AdPageSize,
            showPageList: false,
            onSelectPage: function (pageNumber, pageSize) {
                $(this).pagination('loading');
                //alert('pageNumber:' + pageNumber + ',pageSize:' + pageSize);
                AdPage = pageNumber;
                AdPageSize = pageSize;
                UserAdDetails();
                $(this).pagination('loaded');
            }

        });

        
    }
    );
    
    function UserAdDetails() {

        var msg2 = { "UserId": UserId };
        var objectAsJson = JSON.stringify(msg2);

        Type = "GET";
        Url = sServicePath + "/SelectUserAds/" + UserId;
        ContentType = "application/json;charset=utf-8";
        //Data = objectAsJson;

        DataType = "json"; ProcessData = false;
        method = "SelectUserAds";
        CallService();
    }
    function ServiceSucceeded(result) {
        if (DataType == "json") {
            if (method == "AdPostDeleteById") {
                //debugger;
                resultObject = result;
                var obj = jQuery.parseJSON(result);

            }
            else if (method == "SelectUserAds") {
                //debugger;
                resultObject = result;
                var obj = jQuery.parseJSON(result);
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

                $("#divAdContent").empty();

                for (var i = tempStart; i < obj.length && i < tempEnd; i++) {

                    var strImgPath = obj[i].ImagePath.split(':');
                    var strAdStatus = obj[i].AdStatus;

                    //For Date Format 
                    var MyDate_String_Value = obj[0].PostedDate;//"/Date(1224043200000)/"
                    var value = new Date
                                (
                                     parseInt(MyDate_String_Value.replace(/(^.*\()|([+-].*$)/g, ''))
                                );
                    var dat = MonthName(value.getMonth()) + " " + value.getDate() + ", " + value.getFullYear();
                    
                    //For Price value
                    var p = obj[0].Price;
                    var sPrice = "$ " + p.toFixed(2);
                    var sViewlink;
                    var sEditlink;
                    var sDeletelink;

                    sViewlink = "ViewPostAd.aspx?uid=" + obj[i].UserId + "&aid=" + obj[i].AdPostId;
                    sEditlink = "EditAdpost.aspx?aid=" + obj[i].AdPostId + "&uid=" + UserId;
                    sDeletelink = abspath + "?page=adpost&actad=del&aid=" + obj[i].AdPostId + "&uid=" + UserId;

                    $("<div id='AdShow' style='height:200px;width:700px;border-radius:10px 10px 10px 10px;border:thin solid #800080;'>" +
                        "<div style='height:30px;width:700px;border-radius:10px 10px 0px 0px;background-color:lightgray;vertical-align:middle;'>" +
                        "<strong>&nbsp;&nbsp;" + obj[i].AdPostTitle + "</strong>&nbsp;&nbsp;&nbsp;&nbsp;" +
                        "<a href='" + sEditlink + "'>View</a>&nbsp;&nbsp;&nbsp;<a href='" + sEditlink + "'>Edit</a>&nbsp;&nbsp;&nbsp;<a href='" + sDeletelink + "'>Delete</a></div>" +
                        "<div style='height:150px;width:300px;margin-left:10px;margin-top:10px;float:left;'>" +
                        "<img src=" + strImgPath[0] + " style='height:150px;width:250px;'></div>" +
                        "<div  style='height:35px;margin-top:10px;'>Category - " + obj[i].CategoryName + "</div>" +
                        "<div style='height:35px;'>Posted Date - " + dat + "</div>" +
                        "<div style='height:35px;'>Price - " + sPrice + "</div></div><br>"

                    ).appendTo("#divAdContent");

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
    function DeleteAdpost(AdpostID) {
        //debugger;
        var msg2 = { "AdPostId": AdpostID };
        var objectAsJson = JSON.stringify(msg2);

        Type = "DELETE";
        Url = sServicePath + "/AdPostDeleteById";
        ContentType = "application/json;charset=utf-8";
        Data = objectAsJson;
        DataType = "json"; ProcessData = false;
        method = "AdPostDeleteById";
        CallService();
    }

    </script>

