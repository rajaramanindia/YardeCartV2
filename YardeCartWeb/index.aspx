<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="index.aspx.cs" Inherits="YardeCartV2.index" Title="Yard e-Cart Home" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
    <%--<link rel="stylesheet" type="text/css" href="easyui/demo/demo.css">--%>

    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript">

        var strKey = "<%= strSearchKey %>";
        var SearchbyCat;
        var AdPageSize = 10;
        var AdPage = 1;
        var AdTotal = 0;
        $(document).ready(
        function () {
            if (strKey == "" || strKey=="Search String") {
                GetAllAdDetails();
            }
            else {
                $("#SearchBox").val(strKey);
                SearchAdsByKeyword();
            }
            SelectAllCategory();
            PagingAd();

            $("#SearchButton").click(function () {
                if ($("#SearchBox").val() == "" || $("#SearchBox").val() == "Search String")
                    GetAllAdDetails();
                else
                    SearchAdsByKeyword();
                PagingAd();
            }
            );

        }
        );

        function PagingAd() {
            $('#AdPager').pagination({
                total: AdTotal,
                pageSize: AdPageSize,
                showPageList: false,
                onSelectPage: function (pageNumber, pageSize) {
                    $(this).pagination('loading');
                    //alert('pageNumber:' + pageNumber + ',pageSize:' + pageSize);
                    AdPage = pageNumber;
                    AdPageSize = pageSize;
                    if ($("#SearchBox").val() == "")
                        GetAllAdDetails();
                    else if (SearchbyCat != "")
                        AdbyCategory(SearchbyCat)
                    else
                        SearchAdsByKeyword();
                    $(this).pagination('loaded');
                }

            });

        }
        function AdbyCategory(catId) {
            Type = "GET";
            Url = sServicePath + "/SearchAdsByCategory/" + catId;
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "SearchAdsByCategory";
            CallService();
            SearchbyCat = catId;
            PagingAd();
        }
        function SearchAdsByKeyword() {
            Type = "GET";
            Url = sServicePath + "/SearchAdsByKeyword/" + $("#SearchBox").val();
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "SearchAdsByKeyword";
            CallService();
        }
        function GetAllAdDetails() {
            Type = "GET";
            Url = sServicePath + "/GetAllAdDetails";
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "GetAllAdDetails";
            CallService();
        }
        function SelectAllCategory() {
            Type = "GET";
            Url = sServicePath + "/SelectAllCategory";
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "SelectAllCategory";
            CallService();
        }
        function ServiceSucceeded(result) {
            if (DataType == "json") {
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
                else if (method == "SelectAllCategory") {
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    $("<strong>Category</strong>").appendTo("#MainCategory");
                    for (var i = 0; i < obj.length; i++) {

                        var str = obj[i].CategoryName;
                        str = str.toLowerCase().replace(/\b[a-z]/g, function (letter) {
                            return letter.toUpperCase();
                        });

                        $("<br><a href='#' onclick='AdbyCategory(" + obj[i].CategoryId + ");'>" + str + "</a>").appendTo("#MainCategory");
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
                else if (method == "SearchAdsByCategory") {
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

            }
        }


    </script>

    <div id="MainSection">
        <div id="MainCategory">
            <br>
            <strong>
                <label id="currentLocation" runat="server">/ Current Location:</label></strong>
            <small style="color: #C03;">&nbsp;&nbsp;&nbsp;[Change]</small>
            <br>
            <hr>
        </div>
        <div id="MainItem">
            <%--<div id="SortItem">First Prev 1 2 3 4 5 6 7 8 9 Next Last&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sort by &nbsp;
                <input name="TimePostedButton" id="SortButton" type="button" value="Time Posted">&nbsp;<input name="SearchButton" id="Button1" type="button" value="Sale Date">&nbsp;&nbsp;&nbsp;&nbsp;</div>
            --%>
            <div id="SortItem">
                <input name="TimePostedButton" id="SortButton" type="button" value="Time Posted">&nbsp;<input name="SearchButton" id="Button1" type="button" value="Sale Date">
                <div id="AdPager" class="easyui-pagination" style="border: 1px solid #ccc;">
                </div>
            </div>
            <div id="HighlightItem">
                <div id="HighlightItemHeading"></div>

            </div>


        </div>


    </div>

</asp:Content>