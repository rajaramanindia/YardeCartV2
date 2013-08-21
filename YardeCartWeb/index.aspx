<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="index.aspx.cs" Inherits="YardeCartV2.index" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">


    <div id="MainItem">
      <div id="SortItem">First Prev 1 2 3 4 5 6 7 8 9 Next Last&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sort by &nbsp;
        <input name="TimePostedButton" id="SortButton" type="button" value="Time Posted">&nbsp;<input name="SearchButton" id="Button1" type="button" value="Sale Date">&nbsp;&nbsp;&nbsp;&nbsp;</div>
      <div id="HighlightItem">
        <div id="HighlightItemHeading">List Heading</div>
        
               
      	<div id="HighlightItem2" style="padding:3px">
        	<div><strong>Item Name</strong></div>
        	<div><img src="images/car1.jpg"></div>
        	<div style="font-size:12px">description of the item description of the item description of the item description of the item</div> 
        	<div><strong>$136.00</strong></div>
        </div>
        <!--<div id="Div1" style="padding:3px">
        	<div><strong>Item Name</strong></div>
        	<div><img src="images/car1.jpg"></div>
        	<div style="font-size:12px">description of the item description of the item description of the item description of the item</div> 
        	<div><strong>$136.00</strong></div>
        </div>
        <div id="Div2" style="padding:3px">
        	<div><strong>Item Name</strong></div>
        	<div><img src="images/car1.jpg"></div>
        	<div style="font-size:12px">description of the item description of the item description of the item description of the item</div> 
        	<div><strong>$136.00</strong></div>
        </div>
        <div id="Div3" style="padding:3px">
        	<div><strong>Item Name</strong></div>
        	<div><img src="images/car1.jpg"></div>
        	<div style="font-size:12px">description of the item description of the item description of the item description of the item</div> 
        	<div><strong>$136.00</strong></div>
        </div>
        <div id="Div4" style="padding:3px">
        	<div><strong>Item Name</strong></div>
        	<div><img src="images/car1.jpg"></div>
        	<div style="font-size:12px">description of the item description of the item description of the item description of the item</div> 
        	<div><strong>$136.00</strong></div>
        </div>
        <div id="Div5" style="padding:3px">
        	<div><strong>Item Name</strong></div>
        	<div><img src="images/car1.jpg"></div>
        	<div style="font-size:12px">description of the item description of the item description of the item description of the item</div> 
        	<div><strong>$136.00</strong></div>
        </div>
        <div id="Div6" style="padding:3px">
        	<div><strong>Item Name</strong></div>
        	<div><img src="images/car1.jpg"></div>
        	<div style="font-size:12px">description of the item description of the item description of the item description of the item</div> 
        	<div><strong>$136.00</strong></div>
        </div>
        <div id="Div7" style="padding:3px">
        	<div><strong>Item Name</strong></div>
        	<div><img src="images/car1.jpg"></div>
        	<div style="font-size:12px">description of the item description of the item description of the item description of the item</div> 
        	<div><strong>$136.00</strong></div>
        </div>
        <div id="Div8" style="padding:3px">
        	<div><strong>Item Name</strong></div>
        	<div><img src="images/car1.jpg"></div>
        	<div style="font-size:12px">description of the item description of the item description of the item description of the item</div> 
        	<div><strong>$136.00</strong></div>
        </div>
        <div id="Div9" style="padding:3px">
        	<div><strong>Item Name</strong></div>
        	<div><img src="images/car1.jpg"></div>
        	<div style="font-size:12px">description of the item description of the item description of the item description of the item</div> 
        	<div><strong>$136.00</strong></div>
        </div>
        <div id="Div10" style="padding:3px">
        	<div><strong>Item Name</strong></div>
        	<div><img src="images/car1.jpg"></div>
        	<div style="font-size:12px">description of the item description of the item description of the item description of the item</div> 
        	<div><strong>$136.00</strong></div>
        </div>
        -->
        
      </div>
    </div>

    <script type="text/javascript">

    var Type;
    var Url;
    var Data;
    var ContentType;
    var DataType;
    var ProcessData;
    var method;
    //Generic function to call AXMX/WCF  Service
    function CallService() {
        $.ajax({
            type: Type, //GET or POST or PUT or DELETE verb
            url: Url, // Location of the service
            data: Data, //Data sent to server
            contentType: ContentType, // content type sent to server
            dataType: DataType, //Expected data format from server
            processdata: ProcessData, //True or False
            dataFilter: function (data, type) {
                // convert from "\/Date(nnnn)\/" to "new Date(nnnn)"
                return data.replace(/"\\\/(Date\([0-9-]+\))\\\/"/gi, 'new $1');
            },

            success: function (msg) {//On Successfull service call
                ServiceSucceeded(msg);
            },
            error: ServiceFailed// When Service call fails
        });
    }

    function ServiceFailed(result) {
        alert('Service call failed: ' + result.status + '' + result.statusText);
        Type = null; Url = null; Data = null; ContentType = null; DataType = null; ProcessData = null;
    }



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
            alert(method);

            if (method == "GetAllAdDetails") {
                //alert(result);
                debugger;
                resultObject = result;
                var obj = jQuery.parseJSON(result);
                //alert(obj);
                for (var i = 0; i < obj.length; i++) {

                    $("<div id='HighlightItem2'>" +
                        "<div><strong>" + obj[i].AdPostTitle + "</strong></div>" +
                        "<div><img src=" + obj[i].ImagePath + " ></div>" +
                        "<div style='font-size:12px'>" + obj[i].CategoryName + "</div>" +
                        "<div><strong> $ " + parseFloat(obj[i].Price) + "</strong></div>"
                    ).attr("style", "padding:3px").appendTo("#HighlightItemHeading");
                    //            <div id="Div8" style="padding:3px">
                    //	<div><strong>Item Name</strong></div>
                    //	<div><img src="images/car1.jpg"></div>
                    //	<div style="font-size:12px">description of the item description of the item description of the item description of the item</div> 
                    //	<div><strong>$136.00</strong></div>
                    //</div>

                    //            alert(obj[i].AdPostTitle);
                }
                SelectAllCategory();

                //$.each(result[0], function (key, obj) {
                //    alert(obj.AdPostTitle);
                //});
                //var string = resultObject.AdPostTitle + " \n " + resultObject.CategoryName + " \n " + resultObject.ImagePath + " \n " + resultObject.Price;
                //alert(string);
            }
            else if (method == "SelectAllCategory") {
                resultObject = result;
                debugger;
                var obj = jQuery.parseJSON(result);
                $("<strong>Category</strong>").appendTo("#MainCategory");
                for (var i = 0; i < obj.length; i++) {

                    $("<br><a href='index.html'>" + obj[i].CategoryName + "</a>").appendTo("#MainCategory");
                }
            }
        }
    }

    function ServiceFailed(xhr) {
        alert(xhr.responseText);
        if (xhr.responseText) {
            var err = xhr.responseText;
            //if (err)
            //    //error(err);
            //else
            //error({ Message: "Unknown server error." })
        }
        return;
    }

    $(document).ready(
    function () {
        debugger;
        GetAllAdDetails();
    }
    );

    </script>

</asp:Content>