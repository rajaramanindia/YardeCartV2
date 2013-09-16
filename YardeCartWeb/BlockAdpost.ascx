<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BlockAdpost.ascx.cs" Inherits="YardeCartV2.BlockAdpost" %>
<div style="text-align:center;padding-top:50px;padding-left:10px;">
        <input id="soption1" name="soption" type="radio" value="1" />Users
        <input id="soption2" name="soption" type="radio" value="2"/>Ads
    &nbsp;&nbsp;&nbsp;&nbsp;
        <input id="txtSearch" type="text" class="YardTextbox" />
    &nbsp;&nbsp;&nbsp;&nbsp;
        <input id="btnSearch" type="button" value="Search" class="YardButton" />
    </div>
<br />
    <div style="text-align:center; width:800px;" >
        <table id="jQAdpost" style="width:500px;">
        </table>
        <div id="jQAdpostPager">
        </div>
<br />
        <input id="btnBlock" type="button" value="Block" onclick="DoAction();" class="YardButton" style="visibility:collapse;"/>
        <%--<input id="btnBlock0" type="button" value="Check All" onclick="CheckAll();"/>--%>
        <%--<input id="btnBlock1" type="button" value="Uncheck All" onclick="CheckAll();"/>--%>

    </div>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#SearchButton").click(function () {
                window.location = "index.aspx?searchstr=" + $("#SearchBox").val();
            });

            $('#btnSearch').click(function () {
                //debugger;
                $('#btnBlock').attr("style", "visibility:visible;");

                $('#jQAdpost').jqGrid('GridUnload');  //this does the work of clearing out the table content and loading fresh data

                var valop = $('input:radio[name=soption]:checked').val();
                var str = $("#txtSearch").val();

                jQuery("#jQAdpost").jqGrid({
                    url: 'Handlers/JQBlockAdpost.ashx?opt=' + valop + '&str=' + str,
                    datatype: "json",
                    colNames: ['Id', 'Ad Title', 'First Name', 'Last Name', 'Block Status'],
                    colModel: [
                                { name: 'AdPostId', index: 'AdPostId', width: 20, hidden: true },
                                { name: 'AdPostTitle', index: 'AdPostTitle', width: 150, stype: 'text', sortable: true, editable: true },
                                { name: 'FirstName', index: 'FirstName', width: 150, stype: 'text', sortable: true, editable: true },
                                { name: 'LastName', index: 'LastName', width: 150, stype: 'text', sortable: true, editable: true },
                                {
                                    name: 'AdBlocked', index: 'AdBlocked', autowidth: true, editable: true, edittype: "checkbox", align: 'center',
                                    editoptions: { value: "1:0" },
                                    formatter: "checkbox", formatoptions: { disabled: false }
                                }
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


        function DoAction() {
            //debugger;
            var lista = jQuery("#jQAdpost").getDataIDs();
            for (i = 0; i < lista.length; i++) {
                rowData = jQuery("#jQAdpost").getRowData(lista[i]);
                DoBlockAdpost(rowData.AdPostId, rowData.AdBlocked);
            }
            alert("Ads are blocked successfully.");

        }
        function CheckAll() {
            //debugger;

            $('#jQAdpost.cbox').trigger('click').attr('checked', true);
            alert("Users are deleted successfully.");

        }
        function DoBlockAdpost(adpostid, Blockstatus) {
            //debugger;
            var msg = { "AdPostId": adpostid, "AdBlocked": Blockstatus };
            var objectAsJson = JSON.stringify(msg);
            Type = "PUT";
            Data = objectAsJson;
            Url = sServicePath + "/UpdateAdBlockStatus";
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "UpdateAdBlockStatus";
            CallService();
        }

        function ServiceSucceeded(result) {
            if (DataType == "json") {
                if (method == "UpdateAdBlockStatus") {

                }
            }
        }
    </script>
