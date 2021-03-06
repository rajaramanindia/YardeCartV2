﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DeleteAdpost.ascx.cs" Inherits="YardeCartV2.DeleteAdpost" %>

    <div style="text-align:center;padding-top:20px;padding-left:10px;">
       <div><strong>Adpost Delete details</strong></div>
<br />
<br />
      <input id="soption1" name="soption" type="radio" value="1" />Users
        <input id="soption2" name="soption" type="radio" value="2"/>Ads
    &nbsp;&nbsp;&nbsp;&nbsp;
        <input id="txtSearch" type="text" class="YardTextbox"/>
    &nbsp;&nbsp;&nbsp;&nbsp;
        <input id="btnSearch" type="button" value="Search"  class="YardButton" />
    </div>
<br />
    <div style="text-align:center; width:800px;" >
        <div id="divCheck" style="text-align:left;" >
        <input id="btnChkAll" type="button" value="Check All" onclick="CheckAll();" class="YardButton" style="width: 100px;" />
        <input id="btnUnchkAll" type="button" value="Uncheck All " onclick="UnCheckAll();" class="YardButton" style="width: 120px;"/>
    </div>
<br />
        <table id="jQAdpost" style="width:500px;">
        </table>
        <div id="jQAdpostPager">
        </div>
<br />

        <input id="btnBlock" type="button" value="Delete" onclick="DoAction();" class="YardButton" style="visibility:collapse;"/>

    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#divCheck").hide();

            $('#btnSearch').click(function () {
                //debugger;
                $('#btnBlock').attr("style", "visibility:visible;");
                $("#divCheck").show();

                $('#jQAdpost').jqGrid('GridUnload');  //this does the work of clearing out the table content and loading fresh data

                var valop = $('input:radio[name=soption]:checked').val();
                var str = $("#txtSearch").val();

                jQuery("#jQAdpost").jqGrid({
                    url: 'Handlers/JQBlockAdpost.ashx?opt=' + valop + '&str=' + str,
                    datatype: "json",
                    colNames: ['Id', 'Ad Title', 'First Name', 'Last Name', 'Block Status'],
                    colModel: [
                                { name: 'AdPostId', index: 'AdPostId', width: 20, hidden: true },
                                { name: 'AdPostTitle', index: 'AdPostTitle', width: 150, stype: 'text', sortable: true },
                                { name: 'FirstName', index: 'FirstName', width: 150, stype: 'text', sortable: true },
                                { name: 'LastName', index: 'LastName', width: 150, stype: 'text', sortable: true },
                                {
                                    name: 'AdDeleted', index: 'AdDeleted', autowidth: true, editable: true, edittype: "checkbox", align: 'center',
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
                    caption: "List User Details",
                    onSelectRow: function (id, status) {
                        var rowData = jQuery(this).getRowData(id);
                        configid = rowData['AdPostId'];
                        configname = rowData['AdDeleted'];

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
                               search: false
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
                DoDeleteAdposts(rowData.AdPostId, rowData.AdDeleted);
            }
            alert("Ads are deleted successfully.");

        }
        function CheckAll() {
            var lista = jQuery("#jQAdpost").getDataIDs();
            for (i = 0; i < lista.length; i++) {
                var rowData = $("#jQAdpost").jqGrid('getRowData', lista[i]);
                rowData.AdDeleted = '1';
                $("#jQAdpost").jqGrid('setRowData', lista[i], rowData);
            }
        }
        function UnCheckAll() {
            var lista = jQuery("#jQAdpost").getDataIDs();
            for (i = 0; i < lista.length; i++) {
                var rowData = $("#jQAdpost").jqGrid('getRowData', lista[i]);
                rowData.AdDeleted = '0';
                $("#jQAdpost").jqGrid('setRowData', lista[i], rowData);
            }
        }
        function DoDeleteAdposts(adpostid, Deletestatus) {
            //debugger;
            var msg = { "AdPostId": adpostid, "AdDeleted": Deletestatus };
            var objectAsJson = JSON.stringify(msg);
            Type = "PUT";
            Data = objectAsJson;
            Url = sServicePath + "/UpdateAdDeleteStatus";
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "UpdateAdDeleteStatus";
            CallService();
        }

        var Type;
        var Url;
        var Data;
        var ContentType;
        var DataType;
        var ProcessData;
        var method;
        var catGroup;
        //Generic function to call AXMX/WCF  Service
        function CallService() {
            $.ajax({
                type: Type, //GET or POST or PUT or DELETE verb
                url: Url, // Location of the service
                data: Data, //Data sent to server
                contentType: ContentType, // content type sent to server
                dataType: DataType, //Expected data format from server
                processdata: ProcessData, //True or False
                async: false,
                dataFilter: function (data, type) {
                    // convert from "\/Date(nnnn)\/" to "new Date(nnnn)"
                    return data.replace(/"\\\/(Date\([0-9-]+\))\\\/"/gi, 'new $1');
                },

                success: function (msg) {//On Successfull service call
                    ServiceSucceeded(msg);
                }
            });
        }
        function ServiceFailed(result) {
            alert('Service call failed: ' + result.status + '' + result.statusText);
            Type = null; Url = null; Data = null; ContentType = null; DataType = null; ProcessData = null;
        }
        function ServiceSucceeded(result) {
            if (DataType == "json") {
                if (method == "UpdateUserDeleteStatus") {

                }
            }
        }
    </script>