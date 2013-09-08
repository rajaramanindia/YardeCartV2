<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="ActivateUser.aspx.cs" Inherits="YardeCartV2.ActivateUser" Title="Yard e-Cart Login" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <script type="text/javascript">

        var Type;
        var Url;
        var Data;
        var ContentType;
        var DataType;
        var ProcessData;
        var method;
        var userId;
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

        function updateAct() {

            var msg2 = { "strUserid": queryObj["uid"] };
            var objectAsJson = JSON.stringify(msg2);


            Type = "POST";
            Url = sServicePath + "/UpdateActivation";
            Data = objectAsJson;
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "UpdateActivation";
            CallService();
        }

        function ServiceSucceeded(result) {
            if (DataType == "json") {
                if (method == "UpdateActivation") {

                }

            }
        }
        var queryObj = {};

        $(document).ready(
        function () {
           // debugger;
            //this goes on the global scope
            // get querystring as an array split on "&"
            var querystring = location.search.replace( '?', '' ).split( '&' );
            // declare object
            // loop through each name-value pair and populate object
            for ( var i=0; i<querystring.length; i++ ) {
                // get name and value
                var name = querystring[i].split('=')[0];
                var value = querystring[i].split('=')[1];
                // populate object
                queryObj[name] = value;
            }

            // ***now you can use queryObj["<name>"] to get the value of a url
            // ***variable
            alert(queryObj["uid"]);



               // updateAct();
        });

    </script>
    
        <div id="MainSection">
            
            <div id="MainItem">
                
                Your account is activated successfully. Please goto Login page  
            </div>

    
        </div>

</asp:Content>