<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AdsReport.ascx.cs" Inherits="YardeCartV2.AdsReport" %>
<link rel="stylesheet" type="text/css" href="easyUI/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyUI/themes/icon.css">
    <%--<script type="text/javascript" src="easyUI/jquery.min.js"></script>--%>
    <script type="text/javascript" src="easyUI/jquery.easyui.min.js"></script>
    
<div style="padding-top:20px;padding-left:10px;">
     <div style="text-align:center;"><strong>Adpost Report details</strong></div>
<br />
<br 
    <table style="width:700px;">
        <tr>
            <td style="width:200px;">
                <input id="soption1" name="soption" type="radio" value="1" />Region
                <input id="soption2" name="soption" type="radio" value="2" checked="checked"/>Date
            </td>
            <td style="width:350px;">
                <div id="divDate" style="width: 400px">
                From 
                <input id="dtFrom" type="text" class="easyui-datebox"  />
                To
                <input id="dtTo" type="text" class="easyui-datebox" />
                </div>
                <div id="divReg"  style="width: 150px">
                <input id="txtRegion" type="text" class="YardTextbox" />
                </div>
            </td>
            <td style="width:150px;">
                <input id="btnSearch" type="button" value="Search" class="YardButton" />
            </td>
        </tr>
    </table>
    </div>
<br />
    <div style="text-align:center; width:800px;" >
       <br />
<br />
         <table id="jQAdpost" style="width:500px;">
        </table>
        <div id="jQAdpostPager">
        </div>
<br />

    </div>
    <script type="text/javascript">

        function onchange() {
            if ($("input[name=soption]:checked").val() == "1") {
                $("#divReg").show();
                $("#divDate").hide();

            }
            else if ($("input[name=soption]:checked").val() == "2") {
                $("#divDate").show();
                $("#divReg").hide();
            }
        }
        $(document).ready(function () {
            //$(('input:radio[name=soption]').val() == '2').click(function () {
            //    alert("hello");
            //});
            onchange();

            $('input[name="soption"]:radio').change(function () {
                onchange();

            });
            $("#SearchButton").click(function () {
                window.location = "index.aspx?searchstr=" + $("#SearchBox").val();
            });

            $('#btnSearch').click(function () {
                var strData;
                var fromdate = $("#dtFrom").datebox('getValue');
                var todate = $("#dtTo").datebox('getValue');

                if ($("input[name=soption]:checked").val() == "1") {
                    strData = "reg=" + $("#txtRegion").val();
                }
                else if($("input[name=soption]:checked").val() == "2"){
                    strData = "dtf=" + fromdate + "&dtt=" + todate;
                }
              
                $('#jQAdpost').jqGrid('GridUnload');  //this does the work of clearing out the table content and loading fresh data


                jQuery("#jQAdpost").jqGrid({
                    url: 'Handlers/JQAdsReport.ashx?'+strData,
                    datatype: "json",
                    colNames: ['Id', 'Ad Title', 'Posted Date', 'Purchased Date', 'Region', 'Status', 'Buyer Name', 'Buyer Address', 'Delivery Date'],
                    colModel: [
                                { name: 'AdPostId', index: 'AdPostId', width: 20, hidden: true },
                                { name: 'AdPostTitle', index: 'AdPostTitle', width: 150, stype: 'text', sortable: true, editable: true },
                                {
                                    name: 'PostedDate', index: 'PostedDate', width: 100, stype: 'text', sortable: true, editable: true, formatter: 'date',
                                    formatoptions: { srcformat: 'd/m/Y', newformat: 'd/m/Y' }
                                },
                                {
                                    name: 'SaleDate', index: 'SaleDate', width: 100, stype: 'text', sortable: true, editable: true, formatter: 'date',
                                    formatoptions: { srcformat: 'd/m/Y', newformat: 'd/m/Y' }
                                },
                                { name: 'SaleLocationName', index: 'SaleLocationName', width: 100, stype: 'text', sortable: true, editable: true },
                                { name: 'CurrentStatus', index: 'CurrentStatus', width: 100, stype: 'text', sortable: true, editable: true },
                                { name: 'BuyerName', index: 'BuyerName', width: 150, stype: 'text', sortable: true, editable: true },
                                { name: 'BuyerAddress', index: 'BuyerAddress', width: 300, stype: 'text', sortable: true, editable: true },
                                { name: 'DeliveryDate', index: 'DeliveryDate', width: 100, stype: 'text', sortable: true, editable: true }

                    ],
                    rowNum: 20,
                    autowidth: true,
                    height: '400px',
                    mtype: 'GET',
                    align: 'center',
                    loadonce: true,
                    rowList: [10, 20, 30],
                    pager: '#jQAdpostPager',
                    sortname: 'AdPostId',
                    viewrecords: true,
                    rownumbers: true,
                    sortorder: 'desc',
                    caption: "List Adpost Details",
                    onSelectRow: function (id, status) {
                        var rowData = jQuery(this).getRowData(id);
                        configid = rowData['AdPostId'];
                        configname = rowData['AdBlocked'];

                        if (status == true) {

                        }
                        //alert(configid + "/" + configname);
                        rowChecked = 1;
                        currentrow = id;
                    }
                });

                $('#jQAdpost').jqGrid('navGrid', '#jQAdpostPager',
                           {
                               edit: false,
                               add: false,
                               del: false,
                               search: false,
                               searchtext: "Search",
                               checkalltext: "Check all"
                           },
                           {
                               //Edit
                               closeOnEscape: true
                           },
                           {
                               //add
                               closeOnEscape: true
                           },
                           {
                               //DELETE
                               closeOnEscape: true
                           },
                           {
                               //SEARCH
                               closeOnEscape: true
                           }
                    );

            });
        });



        function ServiceSucceeded(result) {
            if (DataType == "json") {
                if (method == "UpdateAdBlockStatus") {

                }
            }
        }
    </script>
