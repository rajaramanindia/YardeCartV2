<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BlockUsers.ascx.cs" Inherits="YardeCartV2.BlockUsers" %>
<div style="text-align:center; width:800px;padding-top:20px;padding-left:10px;" >
     <div><strong>List of User details</strong></div>
<br />
    <div style="text-align:left;" >
        <input id="btnChkAll" type="button" value="Check All" onclick="CheckAll();" class="YardButton" style="width: 100px;" />
        <input id="btnUnchkAll" type="button" value="Uncheck All " onclick="UnCheckAll();" class="YardButton" style="width: 120px;"/>
    </div>
<br />
        <table id="jQUser" style="width:500px;">
        </table>
        <div id="jQUserPager">
        </div>
<br />
        <input id="btnBlock" type="button" value="Block" onclick="GetUsers();" class="YardButton" style="width: 120px;" />
    </div>
    <script type="text/javascript">

        jQuery("#jQUser").jqGrid({
            url: 'Handlers/JQBlockUsers.ashx',
            datatype: "json",
            colNames: ['Id', 'User Name', 'First Name', 'Last Name', 'Block Status'],
            colModel: [
                        { name: 'UserID', index: 'UserID', width: 20, hidden: true },
                        { name: 'UserName', index: 'UserName', width: 150, stype: 'text', sortable: true, editable: true },
                        { name: 'FirstName', index: 'FirstName', width: 150, stype: 'text', sortable: true, editable: true },
                        { name: 'LastName', index: 'LastName', width: 150, stype: 'text', sortable: true, editable: true },
                        {
                            name: 'UserBlocked', index: 'UserBlocked', autowidth: true, editable: true, edittype: "checkbox", align: 'center',
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
            pager: '#jQUserPager',
            sortname: 'UserID',
            viewrecords: true,
            rownumbers: true,
            sortorder: 'desc',
            caption: "List User Details",
            editurl: 'Handlers/JQBlockUsers.ashx',
            onSelectRow: function (id, status) {
                var rowData = jQuery(this).getRowData(id);
                configid = rowData['UserID'];
                configname = rowData['UserBlocked'];

                if (status == true) {

                }
                //alert(configid + "/" + configname);
                rowChecked = 1;
                currentrow = id;
            }
        });

        $('#jQUser').jqGrid('navGrid', '#jQUserPager',
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

        function GetUsers() {
            //debugger;
            var lista = jQuery("#jQUser").getDataIDs();
            for (i = 0; i < lista.length; i++) {
                var rowData = jQuery("#jQUser").getRowData(lista[i]);
                DoBlockUsers(rowData.UserID, rowData.UserBlocked);
            }
            alert("Users are blocked successfully.");
        }
        function CheckAll() {
            var lista = jQuery("#jQUser").getDataIDs();
            for (i = 0; i < lista.length; i++) {
                var rowData = $("#jQUser").jqGrid('getRowData', lista[i]);
                rowData.UserBlocked = '1';
                $("#jQUser").jqGrid('setRowData', lista[i], rowData);
            }
        }
        function UnCheckAll() {
            var lista = jQuery("#jQUser").getDataIDs();
            for (i = 0; i < lista.length; i++) {
                var rowData = $("#jQUser").jqGrid('getRowData', lista[i]);
                rowData.UserBlocked = '0';
                $("#jQUser").jqGrid('setRowData', lista[i], rowData);
            }
        }
        function DoBlockUsers(userid, blockstatus) {
            var msg = { "UserId": userid, "UserBlocked": blockstatus };
            var objectAsJson = JSON.stringify(msg);
            Type = "PUT";
            Data = objectAsJson;
            Url = sServicePath + "/UpdateUserBlockStatus";
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "UpdateUserBlockStatus";
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
                },
                error: ServiceFailed// When Service call fails
            });
        }
        function ServiceFailed(result) {
            //alert('Service call failed: ' + result.status + '' + result.statusText);
            Type = null; Url = null; Data = null; ContentType = null; DataType = null; ProcessData = null;
        }
        function ServiceSucceeded(result) {
            if (DataType == "json") {
                if (method == "UpdateUserBlockStatus") {

                }
            }
        }
    </script>
