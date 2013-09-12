<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="ActivateUser.aspx.cs" Inherits="YardeCartV2.ActivateUser" Title="Yard e-Cart Login" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <script type="text/javascript">

        var sUid = "<%= strUserId %>";
        function updateAct() {
            var msg2 = { "strUserid": sUid };
            var objectAsJson = JSON.stringify(msg2);

            Type = "PUT";
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
            //alert(queryObj["uid"]);



            updateAct();
        });

    </script>
    
        <div id="MainSection">
            
            <div id="MainItem">
                
                Your account is activated successfully. Please goto Login page  
            </div>

    
        </div>

</asp:Content>