<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DeleteUsers.ascx.cs" Inherits="YardeCartV2.DeleteUsers" %>
<div style="text-align:center; width:800px;" >
        <table id="jQUser" style="width:500px;">
        </table>
        <div id="jQUserPager">
        </div>
        <input id="btnBlock" type="button" value="Delete" onclick="GetUsers();"/>
        <input id="btnBlock0" type="button" value="Check All" onclick="CheckAll();"/>
        <input id="btnBlock1" type="button" value="Uncheck All" onclick="CheckAll();"/></div>
    <script type="text/javascript">

        jQuery("#jQUser").jqGrid({
            url: 'JQBlockUsers.ashx',
            datatype: "json",
            colNames: ['Id', 'User Name', 'First Name', 'Last Name', 'Delete Status'],
            colModel: [
                        { name: 'UserID', index: 'UserID', width: 20, stype: 'hidden' },
                        { name: 'UserName', index: 'UserName', width: 150, stype: 'text', sortable: true, editable: true },
                        { name: 'FirstName', index: 'FirstName', width: 150, stype: 'text', sortable: true, editable: true },
                        { name: 'LastName', index: 'LastName', width: 150, stype: 'text', sortable: true, editable: true },
                        {
                            name: 'UserDeleted', index: 'UserDeleted', autowidth: true, editable: true, edittype: "checkbox", align: 'center',
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
            sortorder: 'desc',
            caption: "List User Details",
            editurl: 'JQBlockUsers.ashx',
            onSelectRow: function (id, status) {
                var rowData = jQuery(this).getRowData(id);
                configid = rowData['UserID'];
                configname = rowData['UserDeleted'];

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
                       search: true,
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
            debugger;
            var lista = jQuery("#jQUser").getDataIDs();
            for (i = 0; i < lista.length; i++) {
                rowData = jQuery("#jQUser").getRowData(lista[i]);
                DoDeleteUsers(rowData.UserID, rowData.UserDeleted);
            }
            alert("Users are deleted successfully.");

        }
        function CheckAll() {
            //debugger;

            $('#jQUser.cbox').trigger('click').attr('checked', true);
            alert("Users are deleted successfully.");

        }
        function DoDeleteUsers(userid, Deletestatus) {
            //debugger;
            var msg = { "UserId": userid, "UserDeleted": Deletestatus };
            var objectAsJson = JSON.stringify(msg);
            Type = "POST";
            Data = objectAsJson;
            Url = sServicePath + "/UpdateUserDeleteStatus";
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "UpdateUserDeleteStatus";
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
