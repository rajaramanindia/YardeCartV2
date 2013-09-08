<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditProfile.ascx.cs" Inherits="YardeCartV2.EditProfile" %>
<div style="vertical-align:central;padding-left:100px;padding-top:50px">
        <div >
            <h3 >Profile Information</h3><br />
        </div>
        <div>
            <table style="width:700px;border-bottom-left-radius:4px;border-width:thin; border-style:groove">
                <tr>
                    <td style="vertical-align:central;">
                        <div style="vertical-align:central;"> 
                        <table>
                            <tr style="height:40px;">
                                <td style="width:150px;">
                                    <label>First Name</label>
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
                                    <label>Gender</label>
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
                                    <label>E mail</label>
                                </td>
                                <td>
                    <input type="text" id="txtEmail" style="width:200px;" />
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td>
                                    <label>Mobile</label>
                                </td>
                                <td>
                    <input type="text" id="txtMobilePhone" style="width:200px;" />
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
                                    Country
                                </td>
                                <td>
                    <select id="ddlCountry" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td>
                                    <label>State</label>
                                </td>
                                <td>
                    <select id="ddlState" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td>
                                    City
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
                    <input id="btnUpdate" type="button" value="Update" />
                    <input id="btnReset" type="button" value="Reset" />

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


    var Type;
    var Url;
    var Data;
    var ContentType;
    var DataType;
    var ProcessData;
    var method;
    var sUsername;
    var sUserpassword;
    var sUserType;
    var sUserId;

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
            else if (method == "SelectProfile") {

                resultObject = result;
                var obj = jQuery.parseJSON(result);
                sUsername=obj[0].UserName;
                sUserpassword=obj[0].UserPassword;
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
                if (sUserType == "1")
                    window.location = "MyHome.aspx";
                else if (sUserType == "2")
                    window.location = "MyAdminHome.aspx";
            }
        }
    }
    function AddRegister() {
        //debugger;
        var valop = $('input:radio[name=rdoGender]:checked').val();
        var msg2 = {
            "UserId": sUserId, "UserName": sUsername, "UserPassword": sUserpassword, "FirstName": $("#txtFirstName").val()
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
    function GetSession() {
        $.ajax({
            url: 'GetSession.ashx',
            processData: false,
            contentType: false,
            type: 'GET',
            async: false,
            success: function (data) {
                var temp = data.split('/');
                sUserType = temp[0];
                sUserId = temp[1];
            }
        });
    }
    function SelectProfile() {
        var msg2 = { "UserId": sUserId };
        var objectAsJson = JSON.stringify(msg2);
        Type = "POST";
        Url = sServicePath + "/SelectProfile";
        ContentType = "application/json;charset=utf-8";
        Data = objectAsJson;
        DataType = "json"; ProcessData = false;
        method = "SelectProfile";
        CallService();
    }

    $(document).ready(
    function () {
        debugger;
        GetSession();
        loadCountry();
        SelectProfile();
        $("#btnUpdate").click(function () {
            AddRegister();
            alert("Updated Successfully");
        });
    }
    );


</script>