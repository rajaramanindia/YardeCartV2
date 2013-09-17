<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="Register.aspx.cs" Inherits="YardeCartV2.Register" Title="Yard e-Cart Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
    <%--<link rel="stylesheet" type="text/css" href="easyui/demo/demo.css">--%>

    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>

    <div id="MainSection">
        <%-- <div id="MainCategory">
    <br>
            <strong><label id="currentLocation" runat="server"> / Current Location:</label></strong>
	<small style="color:#C03;">&nbsp;&nbsp;&nbsp;[Change]</small>
    <br>
    <hr>
    </div>--%>
        <div id="MainItem" style="width: 750px; padding-left: 175px; padding-top: 25px;">
            <div style="height: 50px; background-color: dodgerblue; vertical-align: bottom; text-align: center; border-radius: 10px 10px 0px 0px">
                <h3><strong>Register Details</strong></h3>

            </div>
            <div style="background-color: aliceblue;">
                (<span style="color: red;">*</span>) indiates mandatory fields.
            </div>
            <div id="divErrorMsg" style="color:red;background-color: aliceblue;">

            </div>
            <table id="tblRegister" style="width: 100%; background-color: aliceblue;">
                <tr style="height: 50px; background-color: aliceblue;">
                    <th style="width: 175px">Login Information
                    </th>

                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">
                        <span>Username</span><span style="color: red;">*</span>
                    </td>
                    <td>
                        <input type="text" id="txtUsername" style="width: 200px;" class="easyui-validatebox" data-options="required:true" />
                        <img id="yesImg" alt="" src="Content/images/yes_avai.jpg" style="visibility: collapse" height="20px" width="15px" />
                        <img id="noImg" alt="" src="Content/images/del_no.png" style="visibility: collapse" height="20px" width="15px" />
                    </td>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">Password<span style="color: red;">*</span>
                    </td>
                    <td>
                        <input type="password" id="txtUserPassword" style="width: 200px;" class="easyui-validatebox" data-options="required:true,validType:'minLength[6]'" />
                    </td>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">Confirm Password<span style="color: red;">*</span>
                    </td>
                    <td>
                        <input type="password" id="txtUserPasswordCon" style="width: 200px;" class="easyui-validatebox"
                            data-options="required:true" validtype="equals['#txtUserPassword']" />
                    </td>
                </tr>
                <tr style="height: 50px; background-color: aliceblue;">
                    <th style="width: 175px">Name Information
                    </th>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">First <span>name</span><span style="color: red;">*</span>
                    </td>
                    <td>
                        <input type="text" id="txtFirstName" style="width: 200px;" />
                    </td>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">Last <span>name</span>
                    </td>
                    <td>
                        <input type="text" id="txtLastName" style="width: 200px;" />
                    </td>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">Gender<span style="color: red;">*</span>
                    </td>
                    <td>
                        <input type="radio" value="1" name="rdoGender" />Male
                    <input type="radio" value="2" name="rdoGender" />Female
                    <input type="radio" value="0" name="rdoGender" />Rather not say
                    </td>
                </tr>
                <tr style="height: 50px; background-color: aliceblue;">
                    <th style="width: 175px">Address Information
                    </th>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">Email<span style="color: red;">*</span>
                    </td>
                    <td>
                        <input type="text" id="txtEmail" style="width: 200px;" class="easyui-validatebox" data-options="required:true,validType:'email'" />
                        <img id="mYesImg" alt="" src="Content/images/yes_avai.jpg" style="visibility: collapse" height="20px" width="15px" />
                        <img id="mNoImg" alt="" src="Content/images/del_no.png" style="visibility: collapse" height="20px" width="15px" />
                    </td>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">Mobile<span style="color: red;">*</span>
                    </td>
                    <td>
                        <input type="text" id="txtMobilePhone" style="width: 200px;" class="easyui-validatebox" data-options="required:true" />
                    </td>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">Address
                    </td>
                    <td>
                        <input type="text" id="txtAddress" style="width: 200px;" />
                    </td>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">Street name
                    </td>
                    <td>
                        <input type="text" id="txtStreetName" style="width: 200px;" />
                    </td>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">Country<span style="color: red;">*</span>
                    </td>
                    <td>
                        <select id="ddlCountry" style="width: 200px;" class="easyui-validatebox" data-options="required:true" />
                    </td>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">State<span style="color: red;">*</span>

                    </td>
                    <td>
                        <select id="ddlState" style="width: 200px;" />
                    </td>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">City<span style="color: red;">*</span>

                    </td>
                    <td>
                        <select id="ddlCity" style="width: 200px;" />
                    </td>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">Zipcode</td>
                    <td>
                        <input type="text" id="txtZipCode" style="width: 200px;" />
                    </td>
                </tr>
                <tr style="height: 50px; background-color: aliceblue;">
                    <th style="width: 175px">Bank Information
                    </th>
                </tr>

                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">Bank Name</td>
                    <td>
                        <input type="text" id="txtBankName" style="width: 200px;" />
                    </td>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">Cardholder Name</td>
                    <td>
                        <input type="text" id="txtCardHolderName" style="width: 200px;" />
                    </td>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">Credit Card Number</td>
                    <td>
                        <input type="text" id="txtCardNumber" style="width: 200px;" />
                    </td>
                </tr>
                <tr style="height: 30px; border-bottom-width: 3px; border-bottom-color: black;">
                    <td style="width: 175px">CVC Number </td>
                    <td>
                        <input type="text" id="txtCVCNumber" style="width: 200px;" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 175px">&nbsp;</td>
                    <td>&nbsp;<input id="chkAgree" type="checkbox" />I agree to the Yard e-Cart Terms of Service and Privacy policy.</td>
                </tr>
                <tr>
                    <td style="width: 175px">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 175px">&nbsp;</td>
                    <td>
                        <input id="btnRegister" type="button" value="Register" class="YardButton" style="width: 120px;" />
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

        var intUserid;
        var boolValid=false;
        var intUserAvailable = 0;
        var intMailAvailable = 0;

        function ServiceSucceeded(result) {
            if (DataType == "json") {
                if (method == "SelectAllCountry") {
                    //debugger;
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    $("<option value=''></option>").appendTo("#ddlCountry");
                    for (var i = 0; i < obj.length; i++) {
                        $("<option value=" + obj[i].CountryId + ">" + obj[i].CountryName + "</option>").appendTo("#ddlCountry");
                    }
                    loadState();
                }
                else if (method == "SelectAllState") {
                    //debugger;
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    $("<option value=''></option>").appendTo("#ddlState");
                    for (var i = 0; i < obj.length; i++) {
                        $("<option value=" + obj[i].StateId + ">" + obj[i].StateName + "</option>").appendTo("#ddlState");
                    }
                    loadCity();
                }
                else if (method == "SelectAllCity") {
                    //debugger;
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    $("<option value=''></option>").appendTo("#ddlCity");
                    for (var i = 0; i < obj.length; i++) {
                        $("<option value=" + obj[i].CityId + ">" + obj[i].CityName + "</option>").appendTo("#ddlCity");
                    }
                }
                else if (method == "AvailableUser") {
                    //debugger;
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    if (obj.length == 0) {
                        intUserAvailable = 0;
                        $("#noImg").attr("style", "visibility:collapse;");
                        $("#yesImg").attr("style", "visibility:visible;");
                        $("#txtUsername").attr("style", "width:200px;border-color:green");
                    } else {
                        intUserAvailable = 1;
                        $("#noImg").attr("style", "visibility:visible;");
                        $("#yesImg").attr("style", "visibility:collapse;");
                        $("#txtUsername").attr("style", "width:200px;border-color:red");
                    }
                }
                else if (method == "AvailableMail") {
                    //debugger;
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    if (obj.length == 0) {
                        intMailAvailable = 0;
                        $("#mNoImg").attr("style", "visibility:collapse;");
                        $("#mYesImg").attr("style", "visibility:visible;");
                        $("#txtEmail").attr("style", "width:200px;border-color:green");
                    } else {
                        intMailAvailable = 1;

                        $("#mNoImg").attr("style", "visibility:visible;");
                        $("#mYesImg").attr("style", "visibility:collapse;");
                        $("#txtEmail").attr("style", "width:200px;border-color:red");
                    }
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
        function validateEmailAddr(sEmail) {
            var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            if (filter.test(sEmail))
                return true;
            else
                return false;
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
            Type = "GET";
            Url = sServicePath + "/SelectAllState";
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "SelectAllState";
            CallService();
        }
        function loadCountry() {
            Type = "GET";
            Url = sServicePath + "/SelectAllCountry";
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "SelectAllCountry";
            CallService();
        }
        function loadCity() {
            Type = "GET";
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
        function CheckAvailableMail() {
            Type = "GET";
            Url = sServicePath + "/AvailableMail/" + $("#txtEmail").val();
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "AvailableMail";
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

                if ($('#txtUsername').val() == "") {
                    $("#noImg").attr("style", "visibility:collapse;");
                    $("#yesImg").attr("style", "visibility:collapse;");
                    $("#txtUsername").attr("style", "width:200px;border-color:none");
                }
                else {
                    CheckAvailable();
                }
            });
            $("#txtEmail").keyup(function () {

                if ($('#txtEmail').val() == "") {
                    //$("#noImg").attr("style", "visibility:collapse;");
                    //$("#yesImg").attr("style", "visibility:collapse;");
                    $("#txtEmail").attr("style", "width:200px;border-color:none");
                }
                else {
                    CheckAvailableMail();
                }
            });

            $("#btnRegister").click(function () {
                CheckValidation();
                if (boolValid) {
                    $("#divErrorMsg").hide();

                AddRegister();
                    alert("Successfuully registered");

                    $("#noImg").attr("style", "visibility:collapse;");
                    $("#yesImg").attr("style", "visibility:collapse;");
                    $("#mNoImg").attr("style", "visibility:collapse;");
                    $("#mYesImg").attr("style", "visibility:collapse;");

                $("#tblRegister").attr("style", "visibility:collapse;");
                $("#tblSuccess").attr("style", "visibility:visible;");
                }
                else {
                    $("#divErrorMsg").show();

                }
            });

            $("#SearchButton").click(function () {
                window.location = "index.aspx?searchstr=" + $("#SearchBox").val();
            });

            });

        function CheckValidation() {
            $("#divErrorMsg").empty();
            boolValid = true;
            if ($("#txtUsername").val() == "") {
                $("<strong>- Username should not be empty.</strong><br/>").appendTo("#divErrorMsg");
                boolValid = false;
            }
            if (intUserAvailable == 1) {
                $("<strong>- Username already exists.</strong><br/>").appendTo("#divErrorMsg");
                boolValid = false;
            }
            if ($("#txtUserPassword").val() == "") {
                $("<strong>- Password should not be empty.</strong><br/>").appendTo("#divErrorMsg");
                boolValid = false;
            }
            if ($("#txtUserPassword").val() != "" && $("#txtUserPassword").val().length < 6) {
                $("<strong>- Password should be minimum 6 characters.</strong><br/>").appendTo("#divErrorMsg");
                boolValid = false;
            }
            if ($("#txtUserPassword").val() != "" && $("#txtUserPassword").val() != $("#txtUserPasswordCon").val()) {
                $("<strong>- Confirm Password should be match with User Password.</strong><br/>").appendTo("#divErrorMsg");
                boolValid = false;
            }
            if ($("#txtFirstName").val() == "") {
                $("<strong>- First name should not be empty.</strong><br/>").appendTo("#divErrorMsg");
                boolValid = false;
            }
            if ($("input[name=rdoGender]:checked").val() == null) {
                $("<strong>- Gender should not be empty.</strong><br/>").appendTo("#divErrorMsg");
                boolValid = false;
            }
            if ($("#txtEmail").val() == "" || validateEmailAddr($("#txtEmail").val()) == false) {
                $("<strong>- Invalid Email Address.</strong><br/>").appendTo("#divErrorMsg");
                boolValid = false;
            }
            if (intMailAvailable == 1) {
                $("<strong>- Email address already exists.</strong><br/>").appendTo("#divErrorMsg");
                boolValid = false;
            }
            if ($("#txtMobilePhone").val() == "") {
                $("<strong>- Mobile Number  should not be empty.</strong><br/>").appendTo("#divErrorMsg");
                boolValid = false;
            }
            if ($("#ddlCountry").val() == "") {
                $("<strong>- please Select Country.</strong><br/>").appendTo("#divErrorMsg");
                boolValid = false;
            }
            if ($("#ddlState").val() == "") {
                $("<strong>- please Select State.</strong><br/>").appendTo("#divErrorMsg");
                boolValid = false;
            }
            if ($("#ddlCity").val() == "") {
                $("<strong>- please Select City.</strong><br/>").appendTo("#divErrorMsg");
                boolValid = false;
            }
            if($("#chkAgree").prop("checked") == false){
                $("<strong>- Please agree terms and conditions.</strong><br/>").appendTo("#divErrorMsg");
                boolValid = false;
            } 
        }

        // extend the 'equals' rule
        $.extend($.fn.validatebox.defaults.rules, {
            equals: {
                validator: function (value, param) {
                    return value == $(param[0]).val();
                },
                message: 'Field do not match.'
            }
        });

        $.extend($.fn.validatebox.defaults.rules, {
            minLength: {
                validator: function (value, param) {
                    return value.length >= param[0];
                },
                message: 'Please enter at least {0} characters.'
            }
        });
    </script>
    <input type="hidden" id="hdnUserId" />
</asp:Content>