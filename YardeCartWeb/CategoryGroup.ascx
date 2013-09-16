<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CategoryGroup.ascx.cs" Inherits="YardeCartV2.CategoryGroup" %>
 <div style="text-align:center; width:800px;padding-top:50px;padding-left:10px;" >
     <div><strong>List of Category Group details</strong></div>
     <br />
     <br />
        <table id="JQCategoryGroup" style="width:500px;">
        </table>
        <div id="JQCategoryGroupPager">
        </div>
    </div>
      <script type="text/javascript">
          jQuery("#JQCategoryGroup").jqGrid({
              url: 'Handlers/JQCategoryGroup.ashx',
              datatype: "json",
              colNames: ['Id', 'Group Name'],
              colModel: [
                          { name: 'CategoryGroupId', index: 'CategoryGroupId', width: 20, hidden: true },
                          { name: 'CategoryGroupName', index: 'CategoryGroupName', width: 350, stype: 'text', sortable: true, editable: true }
              ],
              rowNum: 10,
              dataheight:'40px',
              autowidth: true,
              height: '280px',
              mtype: 'GET',
              loadonce: true,
              rowList: [10, 20, 30],
              pager: '#JQCategoryGroupPager',
              sortname: 'CategoryGroupId',
              viewrecords: true,
              rownumbers: true,
              sortorder: 'asc',
              caption: "List Categoty Group Details",
              editurl: 'Handlers/JQCategoryGroup.ashx'
          });

          $('#JQCategoryGroup').jqGrid('navGrid', '#JQCategoryGroupPager',
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
                         beforeShowForm: function (form) {
                             // "editmodlist"
                             var dlgDiv = $("#editmod" + $('#JQCategoryGroup')[0].id);
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
                         closeOnEscape: true,//Closes the popup on pressing escape key
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
                             GroupId: function () {
                                 var sel_id = $('#JQCategoryGroup').jqGrid('getGridParam', 'selrow');
                                 var value = $('#JQCategoryGroup').jqGrid('getCell', sel_id, 'CategoryGroupId');
                                 return value;
                             }
                         }
                     },
                     {
                         beforeShowForm: function (form) {
                             // "editmodlist"
                             var dlgDiv = $("#editmod" + $('#JQCategoryGroup')[0].id);
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
                             var dlgDiv = $("#delmod" + $('#JQCategoryGroup')[0].id);
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
                             //debugger;
                             if (response.responseText == "") {

                                 $("#JQCategoryGroup").trigger("reloadGrid", [{ current: true }]);
                                 return [false, response.responseText]
                             }
                             else {
                                 $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')
                                 return [false, response.responseText]
                             }
                         },
                         delData: {
                             GroupId: function () {
                                 var sel_id = $('#JQCategoryGroup').jqGrid('getGridParam', 'selrow');
                                 var value = $('#JQCategoryGroup').jqGrid('getCell', sel_id, 'CategoryGroupId');
                                 return value;
                             }
                         }
                     },
                     {//SEARCH
                         closeOnEscape: true

                     }
              );

    </script>
