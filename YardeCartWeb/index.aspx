<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="index.aspx.cs" Inherits="YardeCartV2.index" Title="Yard e-Cart Home" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <script type="text/javascript">
        
        $(document).ready(
        function () {
            GetAllAdDetails();
            SelectAllCategory();
        }
        );

        function GetAllAdDetails() {
            Type = "POST";
            Url = "http://localhost:1098/GetAllAdDetails";
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "GetAllAdDetails";
            CallService();
        }
        function SelectAllCategory() {
            Type = "POST";
            Url = "http://localhost:1098/SelectAllCategory";
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
                    for (var i = 0; i < obj.length; i++) {
                        var strImgPath = obj[i].ImagePath.split(':');
                        var strAdStatus = obj[i].AdStatus;
                        $("<div id='HighlightItem2'>" +
                            "<div><strong>" + obj[i].AdPostTitle + "</strong></div>" +
                            "<div><img src=" + strImgPath[0] + " ></div>" +
                            "<div style='font-size:12px'>" + obj[i].CategoryName + "</div>" +
                            "<div><strong> $ " + parseFloat(obj[i].Price) + "</strong></div>" +
                            "<div>" + strAdStatus + "</div>" +
                            "<div><a href='ViewPostAd.aspx?uid=" + obj[i].UserId + "&aid=" + obj[i].AdPostId + "'>View Details</a> </div>"
                        ).attr("style", "padding:3px").appendTo("#HighlightItemHeading");
                    }
                }
                else if (method == "SelectAllCategory") {
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    $("<strong>Category</strong>").appendTo("#MainCategory");
                    for (var i = 0; i < obj.length; i++) {

                        $("<br><a href='index.aspx'>" + obj[i].CategoryName + "</a>").appendTo("#MainCategory");
                    }
                }
            }
        }

    </script>
    
        <div id="MainSection">
            <div id="MainCategory">
            <br>
            <strong><label id="currentLocation" runat="server"> / Current Location:</label></strong>
	        <small style="color:#C03;">&nbsp;&nbsp;&nbsp;[Change]</small>
            <br>
            <hr>
            </div>
            <div id="MainItem">
              <div id="SortItem">First Prev 1 2 3 4 5 6 7 8 9 Next Last&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sort by &nbsp;
                <input name="TimePostedButton" id="SortButton" type="button" value="Time Posted">&nbsp;<input name="SearchButton" id="Button1" type="button" value="Sale Date">&nbsp;&nbsp;&nbsp;&nbsp;</div>
              <div id="HighlightItem">
                <div id="HighlightItemHeading"></div>
        
              </div>
            </div>

    
        </div>

</asp:Content>