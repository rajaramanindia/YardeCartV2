<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="Register.aspx.cs" Inherits="YardeCartV2.Register" Title="Yard e-Cart Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div id="MainSection">
           <%-- <div id="MainCategory">
    <br>
            <strong><label id="currentLocation" runat="server"> / Current Location:</label></strong>
	<small style="color:#C03;">&nbsp;&nbsp;&nbsp;[Change]</small>
    <br>
    <hr>
    </div>--%>
            <div id="MainItem" style="width:750px; padding-left:175px;padding-top:25px;">
                    <div style="height:50px;background-color:dodgerblue;vertical-align:bottom;text-align:center;border-radius:10px 10px 0px 0px">
                        <h3><strong>Register Details</strong></h3>

                    </div>
                        <table id="tblRegister" style="width:100%;background-color:aliceblue;">
                            <tr style="height:50px;background-color:aliceblue;">
                                <th>
                                    Login Information
                                </th>
                            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    <span>Username</span>
                </td>
                <td>
                    <input type="text" id="txtUsername" style="width:200px;" />
                </td>
            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    Password
                </td>
                <td>
                    <input type="password" id="txtUserPassword" style="width:200px;" />
                </td>
            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    Confirm Password
                </td>
                <td>
                    <input type="password" id="txtUserPasswordCon"  style="width:200px;"/>
                </td>
            </tr>
                              <tr style="height:50px;background-color:aliceblue;">
                                <th>
                                    Name Information
                                </th>
                            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    First <span>name</span>
                </td>
                <td>
                    <input type="text" id="txtFirstName" style="width:200px;" />
                </td>
            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    Last <span>name</span>
                </td>
                <td>
                    <input type="text" id="txtLastName" style="width:200px;" />
                </td>
            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    Gender
                </td>
                <td>
                    <input type="radio" value="1" name="rdoGender" />Male
                    <input type="radio" value="2"  name="rdoGender"/>Female
                    <input type="radio" value="0"  name="rdoGender"/>Rather not say
                </td> 
                </tr>
                            <tr style="height:50px;background-color:aliceblue;">
                                <th>
                                     Address Information
                                </th>
                            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    Email
                </td>
                <td>
                    <input type="text" id="txtEmail" style="width:200px;" />
                </td>
            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    Mobile
                </td>
                <td>
                    <input type="text" id="txtMobilePhone" style="width:200px;" />
                </td>
            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    Address
                </td>
                <td>
                    <input type="text" id="txtAddress" style="width:200px;" />
                </td>
            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    Street name
                </td>
                <td>
                    <input type="text" id="txtStreetName" style="width:200px;" />
                </td>
            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    Country
                </td>
                <td>
                    <select id="ddlCountry" style="width:200px;" />
                </td>
            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    State</td>
                <td>
                    <select id="ddlState" style="width:200px;" />
                </td>
            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    City</td>
                <td>
                    <select id="ddlCity" style="width:200px;" />
                </td>
            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    Zipcode</td>
                <td>
                    <input type="text" id="txtZipCode" style="width:200px;" />
                </td>
            </tr>
                            <tr style="height:50px;background-color:aliceblue;">
                                <th>
                                    Bank Information
                                </th>
                            </tr>
            
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    Bank Name</td>
                <td>
                    <input type="text" id="txtBankName" style="width:200px;" />
                </td>
            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    Cardholder Name</td>
                <td>
                    <input type="text" id="txtCardHolderName" style="width:200px;" />
                </td>
            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    Credit Card Number</td>
                <td>
                    <input type="text" id="txtCardNumber" style="width:200px;" />
                </td>
            </tr>
            <tr style="height:30px;border-bottom-width:3px;border-bottom-color:black;">
                <td>
                    CVC Number </td>
                <td>
                    <input type="text" id="txtCVCNumber" style="width:200px;" />
                </td>
            </tr>
                                <tr>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;<input id="Checkbox1" type="checkbox" />I agree to the Yard e-Cart Terms of Service and Privacy policy.</td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    <input id="btnRegister" type="button" value="Register" class="YardButton" style="width:120px;"/>
                </td>
            </tr>
            
        </table>
                        <table id="tblSuccess">
                            <tr>
                                <td>
            <h2>Successfully Registered. Check your Email and click Activation mail from YardeCart </h2>

                                </td>
                            </tr>
                        </table>
            </div>

    
        </div>
    <script type="text/javascript">

        var Type;
        var Url;
        var Data;
        var ContentType;
        var DataType;
        var ProcessData;
        var method;
        var intUserid;
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
                //error: ServiceFailed// When Service call fails
            });
        }
        function ServiceFailed(result) {
            alert('Service call failed: ' + result.status + '' + result.statusText);
            Type = null; Url = null; Data = null; ContentType = null; DataType = null; ProcessData = null;
        }
        function ServiceSucceeded(result) {
            if (DataType == "json") {
                if (method == "SelectAllCountry") {
                    //debugger;
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    for (var i = 0; i < obj.length; i++) {
                        $("<option value=" + obj[i].CountryId + ">" + obj[i].CountryName + "</option>").appendTo("#ddlCountry");
                    }
                    loadState();
                }
                else if (method == "SelectAllState") {
                    //debugger;
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    for (var i = 0; i < obj.length; i++) {
                        $("<option value=" + obj[i].StateId + ">" + obj[i].StateName + "</option>").appendTo("#ddlState");
                    }
                    loadCity();
                }
                else if (method == "SelectAllCity") {
                    //debugger;
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    for (var i = 0; i < obj.length; i++) {
                        $("<option value=" + obj[i].CityId + ">" + obj[i].CityName + "</option>").appendTo("#ddlCity");
                    }
                }
                else if (method == "AvailableUser") {
                    //debugger;
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    if (obj.length == 0)
                        $("#txtUsername").attr("style", "border-color:green");
                    else
                        $("#txtUsername").attr("style", "border-color:red");
                }
                else if (method == "AddRegistration") {
                    resultObject = result;
                    hdnUserId = resultObject;
                    intUserid = result;
                    AddBankinfo();
                    MailToUser();
                    //window.location.href = "index.aspx";
                }
            }
        }
        function AddRegister() {
            //debugger;
            var valop = $('input:radio[name=rdoGender]:checked').val();
            var msg2 = {
                "UserId": "0", "UserName": $("#txtUsername").val(), "UserPassword": $("#txtUserPassword").val(), "FirstName": $("#txtFirstName").val()
            , "LastName": $("#txtLastName").val(), "Gender": $('input:radio[name=rdoGender]:checked').val(), "Address": $("#txtAddress").val(), "StreetName": $("#txtStreetName").val()
            , "Email": $("#txtEmail").val(), "MobilePhone": $("#txtMobilePhone").val(), "CountryId": $("#ddlCountry").val(), "StateId": $("#ddlState").val()
            , "CityId": $("#ddlCity").val(), "ZipCode": $("#txtZipCode").val()
            };
            var objectAsJson = JSON.stringify(msg2);

            Type = "POST";
            Url = sServicePath + "/AddRegistration";
            ContentType = "application/json;charset=utf-8";
            Data = objectAsJson;
            DataType = "json"; ProcessData = false;
            method = "AddRegistration";
            CallService();
           
            
        }
        function MailToUser() {
            var valop = $('input:radio[name=rdoGender]:checked').val();
            var msg2 = {
                "UserId": intUserid, "UserName": $("#txtUsername").val(), "UserPassword": $("#txtUserPassword").val(), "FirstName": $("#txtFirstName").val()
            , "LastName": $("#txtLastName").val(), "Gender": $('input:radio[name=rdoGender]:checked').val(), "Address": $("#txtAddress").val(), "StreetName": $("#txtStreetName").val()
            , "Email": $("#txtEmail").val(), "MobilePhone": $("#txtMobilePhone").val(), "CountryId": $("#ddlCountry").val(), "StateId": $("#ddlState").val()
            , "CityId": $("#ddlCity").val(), "ZipCode": $("#txtZipCode").val()
            };
            var objectAsJson = JSON.stringify(msg2);
            Type = "POST";
            Url = sServicePath + "/SendMailtoUser";
            ContentType = "application/json;charset=utf-8";
            Data = objectAsJson;
            DataType = "json"; ProcessData = false;
            method = "SendMailtoUser";
            CallService();
        }
        function loadState() {
            Type = "POST";
            Url = sServicePath + "/SelectAllState";
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "SelectAllState";
            CallService();
        }
        function loadCountry() {
            Type = "POST";
            Url = sServicePath + "/SelectAllCountry";
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "SelectAllCountry";
            CallService();
        }
        function loadCity() {
            Type = "POST";
            Url = sServicePath + "/SelectAllCity";
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "SelectAllCity";
            CallService();
        }
        function CheckAvailable() {
            var msg2 = {
                "UserName": $("#txtUsername").val()
            };
            var objectAsJson = JSON.stringify(msg2);
            Type = "POST";
            Url = sServicePath + "/AvailableUser";
            ContentType = "application/json;charset=utf-8";
            Data = objectAsJson;
            DataType = "json"; ProcessData = false;
            method = "AvailableUser";
            CallService();
        }
        function AddBankinfo() {
            var msg2 = {
                "BankId": 0, "UserId": intUserid, "BankName": $("#txtBankName").val(),
                "CardHolderName": $("#txtCardHolderName").val(), "CardNumber": $("#txtCardNumber").val(), "CVCNumber": $("#txtCVCNumber").val()
            };
            var objectAsJson = JSON.stringify(msg2);
            Type = "POST";
            Url = sServicePath + "/AddBank";
            ContentType = "application/json;charset=utf-8";
            Data = objectAsJson;
            DataType = "json"; ProcessData = false;
            method = "AddBank";
            //debugger;
            CallService();
        }
        $(document).ready(
        function () {
            //debugger;
            loadCountry();
            $("#tblSuccess").attr("style", "visibility:collapse;");

            $("#txtUsername").keyup(function () {
                CheckAvailable();
            });
            $("#btnRegister").click(function () {
                AddRegister();
                alert("Added");

                $("#tblRegister").attr("style", "visibility:collapse;");
                $("#tblSuccess").attr("style", "visibility:visible;");
            });
        }
        );

</script>
    <input type="hidden" id="hdnUserId" />
</asp:Content>