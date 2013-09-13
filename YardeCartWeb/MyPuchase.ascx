<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyPuchase.ascx.cs" Inherits="YardeCartV2.MyPuchase" %>

<%--<style type="text/css">
        .auto-style4 {
            width: 865px;
        }
        .auto-style6 {
            height: 20px;
        }
        .auto-style7 {
            width: 214px;
        }
    </style>
<div>
           <table style="width:900px;" id="tblAdpost" runat="server">
            <tr style="height:40px;">
                <td style="text-align:left;vertical-align:central; font-size:large;font-weight:600;" class="auto-style4">&nbsp;
                <asp:Label ID="lblCart" runat="server" Text="Shopping"/>
                </td>
                <td style="text-align:right;vertical-align:central;">&nbsp;
                <asp:Button ID="btnKeep" runat="server" Text="Keep Shopping" BorderStyle="Groove" BorderWidth="1px" Width="150px" OnClick="btnKeep_Click" Height="30px"/>
                </td>
            </tr>
            <tr><td colspan="2">
            <asp:GridView ID="GridView1" runat="server" Width="800px" AllowPaging="true" DataKeyNames="AdPostId"
                    AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound" RowStyle-BorderColor="Tan" RowStyle-BorderWidth="1px"
                    ShowHeader="False" OnPageIndexChanging="GridView1_PageIndexChanging" BorderColor="Black" BorderWidth="2px" PageSize="10"
                    >
                    <Columns>
                        <asp:BoundField DataField="AdPostId" Visible="false" InsertVisible="false"/>
                        <asp:TemplateField >
                            <ItemTemplate>
                                <table style="width:600px;">
                                    <tr><td>
                                    <span id="spnHtml0" runat="server"></span>
                                    </td></tr>
                                </table>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <PagerStyle BorderStyle="Solid" HorizontalAlign="Center" VerticalAlign="Bottom" Wrap="True" />
                </asp:GridView>
            </td></tr>
               <tr><td class="auto-style4" style="text-align: center" colspan="2">
                    &nbsp;</td>
               </tr>
           </table>
    </div>--%>


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
    $(document).ready(
    function () {
        UserAdPurchaseDetails();
        $('#Adpaging').pagination({
            total: AdTotal,
            pageSize: AdPageSize,
            showPageList: false,
            onSelectPage: function (pageNumber, pageSize) {
                $(this).pagination('loading');
                //alert('pageNumber:' + pageNumber + ',pageSize:' + pageSize);
                AdPage = pageNumber;
                AdPageSize = pageSize;
                UserAdPurchaseDetails();
                $(this).pagination('loaded');
            }

        });
    }
    );

    function UserAdPurchaseDetails() {
        Type = "GET";
        Url = sServicePath + "/SelectUserPurchases/" + UserId;
        ContentType = "application/json;charset=utf-8";
        DataType = "json"; ProcessData = false;
        method = "SelectUserPurchases";
        CallService();
    }
    function ServiceSucceeded(result) {
        if (DataType == "json") {
            if (method == "SelectUserPurchases") {
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
                    var MyDate_String_Value1 = obj[0].SaleDate;//"/Date(1224043200000)/"
                    var value1 = new Date
                                (
                                     parseInt(MyDate_String_Value1.replace(/(^.*\()|([+-].*$)/g, ''))
                                );
                    var datpur = MonthName(value1.getMonth()) + " " + value1.getDate() + ", " + value1.getFullYear();

                    //For Price value
                    var p = obj[0].Price;
                    var sPrice = "$ " + p.toFixed(2);

                    //Charge Details
                    var chgname = obj[0].ChargeName;
                    var delamt;
                    var chgamt = obj[0].ChargeAmount;
                    if (obj[0].ChargeType == "0")
                        delamt = chgamt;
                    else if (obj[0].ChargeType == "1")
                        delamt = p * (chgamt / 100);



                    var sViewlink = "ViewPurAd.aspx?aid=" + obj[i].AdPostId + "&uid=" + obj[i].AdUserId;

                    $("<div id='AdShow' style='height:200px;width:700px;border-radius:10px 10px 10px 10px;border:thin solid #800080;'>" +
                        "<div style='height:30px;width:700px;border-radius:10px 10px 0px 0px;background-color:lightgray;vertical-align:middle;'>" +
                        "<strong>&nbsp;&nbsp;" + obj[i].AdPostTitle + "</strong>&nbsp;&nbsp;&nbsp;&nbsp;" +
                        "<a href='" + sViewlink + "'>View</a></div>" +
                        "<div style='height:150px;width:300px;margin-left:10px;margin-top:10px;float:left;'>" +
                        "<img src=" + strImgPath[0] + " style='height:150px;width:250px;'></div>" +
                        "<div  style='height:30px;margin-top:10px;'>Category - " + obj[i].CategoryName + "</div>" +
                        "<div style='height:30px;'>Posted Date - " + dat + "</div>" +
                        "<div style='height:30px;'>Purchased Date - " + datpur + "</div>" +
                        "<div style='height:30px;'>Delivery Name/Amount - " + chgname + " / $ " + delamt.toFixed(2) + "</div>" +
                        "<div style='height:30px;'>Price - " + sPrice + "</div></div><br>"

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


    </script>


