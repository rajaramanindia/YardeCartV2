<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Category.ascx.cs" Inherits="YardeCartV2.Category" %>
    
<div style="text-align:center; width:800px;padding-top:50px;padding-left:10px;" >
     <div><strong>List of Category details</strong></div>
     <br />
        <table id="jQGridDemo" style="width:500px;">
        </table>
        <div id="jQGridDemoPager">
        </div>
    </div>
      <script type="text/javascript">

          var catGroup;

          function getGroup() {
              getCategoryGroup();
              var s = catGroup;
              return s;
          }
          function getCategoryGroup() {
              $.ajax({
                  type: "GET", //GET or POST or PUT or DELETE verb
                  url: sServicePath + "/SelectAllCategoryGroup", // Location of the service
                  //data: objectAsJson, //Data sent to server
                  contentType: "application/json;charset=utf-8", // content type sent to server
                  dataType: "json", //Expected data format from server
                  processdata: false, //True or False
                  async: false,
                  success: function (result) {//On Successfull service call
                      //debugger;
                      resultObject = result;
                      var obj = jQuery.parseJSON(result);
                      catGroup = obj[0].CategoryGroupId + ":" + obj[0].CategoryGroupName;

                      for (var i = 1; i < obj.length; i++) {
                          catGroup += ";" + obj[i].CategoryGroupId + ":" + obj[i].CategoryGroupName;
                      }
                      return catGroup;

          }
          });

             }
          
          var mydata = grid = $("#jQGridDemo"),
              centerForm = function ($form) {
                  $form.closest('div.ui-jqdialog').position({
                      my: "center",
                      of: grid.closest('div.ui-jqgrid')
                  });
              };
          $(document).ready(function () {
              getGroup();


          jQuery("#jQGridDemo").jqGrid({
              url: 'Handlers/JQCategory.ashx',
              datatype: "json",
              //data: mydata,
              colNames: ['Id', 'Category Name', 'Category Group'],
              colModel: [
                          { name: 'CategoryId', index: 'CategoryId', width: 20, hidden: true },
                          { name: 'CategoryName', index: 'CategoryName', width: 250, stype: 'text', sortable: true, editable: true },
                          {
                              name: 'CategoryGroupName', index: 'CategoryGroupName', width: 250, stype: 'text', sortable: true, editable: true, celledit: true,
                              edittype: 'select',
                              editrules: { required: true },
                              editoptions: {
                                  value: getGroup()//'1:General;2:AAAA;3:BBBB'//LOAD ALL THE KPI PARAMETER KEY-VALUE PAIR}
                              },
                          }
              ],
              rowNum: 10,
              autowidth: true,
              height: '400px',
              mtype: 'GET',
              align: 'center',
              loadonce: true,
              rowList: [10, 20, 30],
              pager: '#jQGridDemoPager',
              sortname: 'CategoryId',
              viewrecords: true,
              rownumbers: true,
              sortorder: 'desc',
              caption: "List Categoty Details",
              editurl: 'Handlers/JQCategory.ashx'
          });

          $('#jQGridDemo').jqGrid('navGrid', '#jQGridDemoPager',
                     {
                         edit: true,
                         add: true,
                         del: true,
                         search: true,
                         searchtext: "Search",
                         addtext: "Add",
                         edittext: "Edit",
                         deltext: "Delete"
                     },
                      //{
                      //    beforeShowForm: function(form) {
                      //        // "editmodlist"
                      //        var dlgDiv = $("#editmod" + $('#jQGridDemo')[0].id);
                      //        var parentDiv = dlgDiv.parent(); // div#gbox_list
                      //        var dlgWidth = dlgDiv.width();
                      //        var parentWidth = parentDiv.width();
                      //        var dlgHeight = dlgDiv.height();
                      //        var parentHeight = parentDiv.height();
                      //        // TODO: change parentWidth and parentHeight in case of the grid
                      //        //       is larger as the browser window
                      //        dlgDiv[0].style.top = Math.round((parentHeight-dlgHeight)/2) + "px";
                      //        dlgDiv[0].style.left = Math.round((parentWidth-dlgWidth)/2) + "px";
                      //    }
                      //},
                     {   //EDIT
                         //                       height: 300,
                         //                       width: 400,
                         //                       top: 50,
                         //                       left: 100,
                         //                       dataheight: 280,
                         //afterShowForm: centerForm,
                         beforeShowForm: function (form) {
                             // "editmodlist"
                             var dlgDiv = $("#editmod" + $('#jQGridDemo')[0].id);
                             var parentDiv = dlgDiv.parent(); // div#gbox_list
                             var dlgWidth = dlgDiv.width();
                             var parentWidth = parentDiv.width();
                             var dlgHeight = dlgDiv.height();
                             var parentHeight = parentDiv.height();
                             // TODO: change parentWidth and parentHeight in case of the grid
                             //       is larger as the browser window
                             dlgDiv[0].style.top = Math.round((parentHeight - dlgHeight) / 2) + "px";
                             dlgDiv[0].style.left = Math.round((parentWidth - dlgWidth) / 2) + "px";
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
                             CategoryId: function () {
                                 var sel_id = $('#jQGridDemo').jqGrid('getGridParam', 'selrow');
                                 var value = $('#jQGridDemo').jqGrid('getCell', sel_id, 'CategoryId');
                                 return value;
                             }
                         }
                     },
                     {
                         beforeShowForm: function (form) {
                             // "editmodlist"
                             var dlgDiv = $("#editmod" + $('#jQGridDemo')[0].id);
                             var parentDiv = dlgDiv.parent(); // div#gbox_list
                             var dlgWidth = dlgDiv.width();
                             var parentWidth = parentDiv.width();
                             var dlgHeight = dlgDiv.height();
                             var parentHeight = parentDiv.height();
                             // TODO: change parentWidth and parentHeight in case of the grid
                             //       is larger as the browser window
                             dlgDiv[0].style.top = Math.round((parentHeight - dlgHeight) / 2) + "px";
                             dlgDiv[0].style.left = Math.round((parentWidth - dlgWidth) / 2) + "px";
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
                             var dlgDiv = $("#delmod" + $('#jQGridDemo')[0].id);
                             var parentDiv = dlgDiv.parent(); // div#gbox_list
                             var dlgWidth = dlgDiv.width();
                             var parentWidth = parentDiv.width();
                             var dlgHeight = dlgDiv.height();
                             var parentHeight = parentDiv.height();
                             // TODO: change parentWidth and parentHeight in case of the grid
                             //       is larger as the browser window
                             dlgDiv[0].style.top = Math.round((parentHeight - dlgHeight) / 2) + "px";
                             dlgDiv[0].style.left = Math.round((parentWidth - dlgWidth) / 2) + "px";
                         },
                         closeOnEscape: true,
                         closeAfterDelete: true,
                         reloadAfterSubmit: true,
                         closeOnEscape: true,
                         drag: true,
                         afterSubmit: function (response, postdata) {
                             if (response.responseText == "") {

                                 $("#jQGridDemo").trigger("reloadGrid", [{ current: true }]);
                                 return [false, response.responseText]
                             }
                             else {
                                 $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')
                                 return [false, response.responseText]
                             }
                         },
                         delData: {
                             CategoryId: function () {
                                 var sel_id = $('#jQGridDemo').jqGrid('getGridParam', 'selrow');
                                 var value = $('#jQGridDemo').jqGrid('getCell', sel_id, 'CategoryId');
                                 return value;
                             }
                         }
                     },
                     {//SEARCH
                         closeOnEscape: true

                     }
              );
          });

    </script>