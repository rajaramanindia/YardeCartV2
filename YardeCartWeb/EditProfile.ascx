<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditProfile.ascx.cs" Inherits="YardeCartV2.EditProfile" %>


    <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
    <%--<link rel="stylesheet" type="text/css" href="easyui/demo/demo.css">--%>

    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>

<div style="vertical-align:central;padding-left:100px;padding-top:50px">
        <div >
            <h3 >Profile Information</h3><br />
        </div>
        <div>
            
            <div id="divErrorMsg" style="color:red;font-weight:bold;"></div>

            <table style="width:700px;border-bottom-left-radius:4px;border-width:thin; border-style:groove">
                <tr>
                    <td style="vertical-align:central;">
                        <div style="vertical-align:central;"> 
                        <table>
                            <tr style="height:40px;">
                                <td style="width:150px;">
                                    <label>First Name</label><span style="color: red;">*</span>
                                </td>
                                <td style="width:250px;">
                                    <input type="text" id="txtFirstName" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td style="width:150px;">
                                    <label>Last Name</label>
                                </td>
                                <td style="width:250px;">
                                    <input type="text" id="txtLastName" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td>
                                    <label>Gender</label><span style="color: red;">*</span>
                                </td>
                                <td>
                                    <div >
                                  <input type="radio" value="1" name="rdoGender" />Male
                    <input type="radio" value="2"  name="rdoGender"/>Female
                    <input type="radio" value="0"  name="rdoGender"/>Rather not say
                  </div>
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td>
                                    <label>E mail</label><span style="color: red;">*</span>
                                </td>
                                <td>
                    <input type="text" id="txtEmail" style="width:200px;" class="easyui-validatebox" data-options="required:true,validType:'email'"/>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td>
                                    <label>Mobile</label><span style="color: red;">*</span>
                                </td>
                                <td>
                    <input type="text" id="txtMobilePhone" style="width:200px;"  class="easyui-validatebox" data-options="required:true"/>
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td style="width:150px;">
                                    Address
                                </td>
                                <td style="width:250px;">
                    <input type="text" id="txtAddress" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td>
                                    Street name
                                </td>
                                <td>
                    <input type="text" id="txtStreetName" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td>
                                    Country<span style="color: red;">*</span>
                                </td>
                                <td>
                    <select id="ddlCountry" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td>
                                    <label>State</label><span style="color: red;">*</span>
                                </td>
                                <td>
                    <select id="ddlState" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td>
                                    City<span style="color: red;">*</span>
                                </td>
                                <td>
                    <select id="ddlCity" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td>
                                    Zipcode
                                </td>
                                <td>
                    <input type="text" id="txtZipCode" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td>
                                </td>
                                <td>
                    <input id="btnUpdate" type="button" value="Update" class="YardButton" style="width:150px;"/>

                                </td>
                            </tr>
                        </table>
                        </div>
                    </td>
                    <td> 
                    </td>
                </tr>
            </table>
        </div>
    </div>

<script type="text/javascript">

    var sUsername;
    var sUserpassword;
    var sUserEmail;
    var boolValid = false;
    var intMailAvailable = 0;

    //Generic function to call AXMX/WCF  Service
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
            else if (method == "SelectUserProfile") {

                resultObject = result;
                var obj = jQuery.parseJSON(result);
                sUsername=obj[0].UserName;
                sUserpassword = obj[0].UserPassword;
                sUserEmail = obj[0].Email;
                $("#txtFirstName").val(obj[0].FirstName);
                $("#txtLastName").val(obj[0].LastName);
                //$("input:radio[name=rdoGender]").val(obj[0].Gender);
                var $radios = $('input:radio[name=rdoGender]');
                var val = "[Value=" + obj[0].Gender + "]";
                if ($radios.is(':checked') === false) {
                    $radios.filter(val).prop('checked', true);
                }
                $("#txtAddress").val(obj[0].Address);
                $("#txtStreetName").val(obj[0].StreetName);
                $("#txtEmail").val(obj[0].Email);
                $("#txtMobilePhone").val(obj[0].Mobile);
                $("#ddlCountry").val(obj[0].CountryId).attr("selected", "selected");
                $("#ddlState").val(obj[0].StateId).attr("selected", "selected");
                $("#ddlCity").val(obj[0].CityId).attr("selected", "selected");
                $("#txtZipCode").val(obj[0].ZipCode);
        
            }
            else if (method == "AddRegistration") {
                resultObject = result;
                hdnUserId = resultObject;
                //MailToUser();
                if (UserType == "1")
                    window.location = "MyHome.aspx?page=profile";
                else if (UserType == "2")
                    window.location = "MyAdminHome.aspx?page=profile";
            }
            else if (method == "AvailableMail") {
                resultObject = result;
                var obj = jQuery.parseJSON(result);
                if (obj.length == 0) {
                    $("#txtEmail").attr("style", "width:200px;border-color:green");
                    intMailAvailable = 0;
                } else {
                    $("#txtEmail").attr("style", "width:200px;border-color:red");
                    intMailAvailable = 1;
                }
            }
        }
    }
    function AddRegister() {
        //debugger;
        var valop = $('input:radio[name=rdoGender]:checked').val();
        var msg2 = {
            "UserId": UserId, "UserName": sUsername, "UserPassword": sUserpassword, "FirstName": $("#txtFirstName").val()
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
    function SelectUserProfile() {
        Type = "GET";
        Url = sServicePath + "/SelectProfile/" + UserId;
        ContentType = "application/json;charset=utf-8";
        DataType = "json"; ProcessData = false;
        method = "SelectUserProfile";
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

    function validateEmailAddr(sEmail) {
        var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        if (filter.test(sEmail))
            return true;
        else
            return false;
    }
    $(document).ready(
    function () {
        $("#SearchButton").click(function () {
            window.location = "index.aspx?searchstr=" + $("#SearchBox").val();
        });

        loadCountry();
        SelectUserProfile();
        $("#btnUpdate").click(function () {
            $("#divErrorMsg").empty();
            boolValid = true;
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
                $("<strong>- Mobile Number should not be empty.</strong><br/>").appendTo("#divErrorMsg");
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

            if (boolValid) {
                AddRegister();
                alert("User details updated successfully");
            }
        });

        $("#txtEmail").keyup(function () {
            
            if ($('#txtEmail').val() != sUserEmail) {
                CheckAvailableMail();
            }
        });

    }
    );


</script>