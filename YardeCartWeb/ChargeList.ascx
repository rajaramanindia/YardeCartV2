<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChargeList.ascx.cs" Inherits="YardeCartV2.ChargeList" %>
 <div style="text-align:center; width:800px;padding-top:50px;padding-left:10px;" >
     <div><strong>List of Delivery charge details</strong></div>
     <br />
        <table id="JQCharge" style="width:500px;">
        </table>
        <div id="JQChargePager">
        </div>
    </div>
      <script type="text/javascript">

          jQuery("#JQCharge").jqGrid({
              url: 'Handlers/JQCharge.ashx',
              datatype: "json",
              //data: mydata,
              colNames: ['Id', 'Charge Name', 'Charge Type', 'Amount or Percent'],
              colModel: [
                          { name: 'ChargeId', index: 'ChargeId', width: 20, hidden: true },
                          { name: 'ChargeName', index: 'ChargeName', width: 150, stype: 'text', sortable: true, editable: true },
                          {
                              name: 'ChargeType', index: 'ChargeType', width: 150, stype: 'text', sortable: true, editable: true, celledit: true,
                              edittype: 'select',
                              editrules: { required: true },
                              editoptions: {
                                  value: '0:Amount;1:Percentage'//'1:General;2:AAAA;3:BBBB'//LOAD ALL THE KPI PARAMETER KEY-VALUE PAIR}
                              },
                          },
                          { name: 'AmountOrPercent', index: 'AmountOrPercent', width: 150, stype: 'text', sortable: true, editable: true },

              ],
              rowNum: 10,
              autowidth: true,
              height: '400px',
              mtype: 'GET',
              align: 'center',
              loadonce: true,
              rowList: [10, 20, 30],
              pager: '#JQChargePager',
              sortname: 'ChargeId',
              viewrecords: true,
              rownumbers: true,
              sortorder: 'desc',
              caption: "List Charge Details",
              editurl: 'Handlers/JQCharge.ashx'
          });

          $('#JQCharge').jqGrid('navGrid', '#JQChargePager',
                     {
                         edit: true,
                         add: true,
                         del: true,
                         search: false,
                         searchtext: "Search",
                         addtext: "Add",
                         edittext: "Edit",
                         deltext: "Delete"
                     },
                     {   //EDIT
                         //                       height: 300,
                         //                       width: 400,
                         //                       top: 50,
                         //                       left: 100,
                         //                       dataheight: 280,
                         //afterShowForm: centerForm,
                         beforeShowForm: function (form) {
                             // "editmodlist"
                             var dlgDiv = $("#editmod" + $('#JQCharge')[0].id);
                             var parentDiv = dlgDiv.parent(); // div#gbox_list
                             var dlgWidth = dlgDiv.width();
                             var parentWidth = parentDiv.width();
                             var dlgHeight = dlgDiv.height();
                             var parentHeight = parentDiv.height();
                             // TODO: change parentWidth and parentHeight in case of the grid
                             //       is larger as the browser window
                             dlgDiv[0].style.top = Math.round((parentHeight - dlgHeight) / 2 + 230) + "px";
                             dlgDiv[0].style.left = Math.round((parentWidth - dlgWidth) / 2+270) + "px";
                         },
                         //closeOnEscape: true,//Closes the popup on pressing escape key
                         reloadAfterSubmit: true,
                         drag: true,
                         afterSubmit: function (response, postdata) {
                             //debugger;
                             if (response.responseText == "") {

                                 $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid');//Reloads the grid after edit
                                 return [true, '']
                             }
                             else {
                                 $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid'); //Reloads the grid after edit
                                 return [false, response.responseText]//Captures and displays the response text on th Edit window
                             }
                         },
                         editData: {
                             ChargeId: function () {
                                 var sel_id = $('#JQCharge').jqGrid('getGridParam', 'selrow');
                                 var value = $('#JQCharge').jqGrid('getCell', sel_id, 'ChargeId');
                                 return value;
                             }
                         }
                     },
                     {
                         beforeShowForm: function (form) {
                             // "editmodlist"
                             var dlgDiv = $("#editmod" + $('#JQCharge')[0].id);
                             var parentDiv = dlgDiv.parent(); // div#gbox_list
                             var dlgWidth = dlgDiv.width();
                             var parentWidth = parentDiv.width();
                             var dlgHeight = dlgDiv.height();
                             var parentHeight = parentDiv.height();
                             // TODO: change parentWidth and parentHeight in case of the grid
                             //       is larger as the browser window
                             dlgDiv[0].style.top = Math.round((parentHeight - dlgHeight) / 2 + 230) + "px";
                             dlgDiv[0].style.left = Math.round((parentWidth - dlgWidth) / 2 + 270) + "px";
                         },
                         closeAfterAdd: true,//Closes the add window after add
                         afterSubmit: function (response, postdata) {
                             //debugger;
                             if (response.responseText == "") {

                                 $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')//Reloads the grid after Add
                                 return [true, '']
                             }
                             else {
                                 $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')//Reloads the grid after Add
                                 return [true, response.responseText]
                             }
                         }
                     },
                     {   //DELETE
                         beforeShowForm: function (form) {
                             // "editmodlist"
                             var dlgDiv = $("#delmod" + $('#JQCharge')[0].id);
                             var parentDiv = dlgDiv.parent(); // div#gbox_list
                             var dlgWidth = dlgDiv.width();
                             var parentWidth = parentDiv.width();
                             var dlgHeight = dlgDiv.height();
                             var parentHeight = parentDiv.height();
                             // TODO: change parentWidth and parentHeight in case of the grid
                             //       is larger as the browser window
                             dlgDiv[0].style.top = Math.round((parentHeight - dlgHeight) / 2 + 230) + "px";
                             dlgDiv[0].style.left = Math.round((parentWidth - dlgWidth) / 2 + 270) + "px";
                         },
                         closeOnEscape: true,
                         closeAfterDelete: true,
                         reloadAfterSubmit: true,
                         closeOnEscape: true,
                         drag: true,
                         afterSubmit: function (response, postdata) {
                             if (response.responseText == "") {

                                 $("#JQCharge").trigger("reloadGrid", [{ current: true }]);
                                 return [false, response.responseText]
                             }
                             else {
                                 $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')
                                 return [false, response.responseText]
                             }
                         },
                         delData: {
                             ChargeId: function () {
                                 var sel_id = $('#JQCharge').jqGrid('getGridParam', 'selrow');
                                 var value = $('#JQCharge').jqGrid('getCell', sel_id, 'ChargeId');
                                 return value;
                             }
                         }
                     },
                     {//SEARCH
                         closeOnEscape: true

                     }
              );

    </script>
