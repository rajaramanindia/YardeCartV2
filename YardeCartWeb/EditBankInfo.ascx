<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditBankInfo.ascx.cs" Inherits="YardeCartV2.EditBankInfo" %>
<div style="vertical-align:central;padding-left:100px;padding-top:50px">
        <div >
            <h3 >Bank Information</h3><br />
        </div>
        <div>
            <table style="width:700px;border-bottom-left-radius:4px;border-width:thin; border-style:groove">
                <tr>
                    <td style="vertical-align:central;">
                        <div style="vertical-align:central;"> 
                        <table>
                            <tr style="height:40px;">
                                <td style="width:150px;">
                                    <label>Bank Name</label>
                                </td>
                                <td style="width:250px;">
                                    <input type="text" id="txtBankName" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td style="width:150px;">
                                    <label>Cardholder Name</label>
                                </td>
                                <td style="width:250px;">
                                    <input type="text" id="txtCardHolderName" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td style="width:150px;">
                                    <label>Credit Card Number</label>
                                </td>
                                <td style="width:250px;">
                                    <input type="text" id="txtCardNumber" style="width:200px;" />
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td style="width:150px;">
                                    <label>CVC Number</label>
                                </td>
                                <td style="width:250px;">
                                    <input type="text" id="txtCVCNumber" style="width:200px;" />
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
    var sBankId;
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
            if (method == "SelectProfile") {
                resultObject = result;
                var obj = jQuery.parseJSON(result);
                sBankId = obj[0].BankId;
                $("#txtBankName").val(obj[0].BankName);
                $("#txtCardHolderName").val(obj[0].CardHolderName);
                $("#txtCardNumber").val(obj[0].CreditCardNumber);
                $("#txtCVCNumber").val(obj[0].CVCNumber);
            }
            else if (method == "AddBank") {
                resultObject = result;
                hdnUserId = resultObject;
                //MailToUser();
                if(sUserType=="1")
                    window.location = "MyHome.aspx";
                else if(sUserType == "2")
                    window.location = "MyAdminHome.aspx";

            }
        }
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
        Url = "http://localhost:1098/SelectProfile";
        ContentType = "application/json;charset=utf-8";
        Data = objectAsJson;
        DataType = "json"; ProcessData = false;
        method = "SelectProfile";
        CallService();
    }
    function AddBankinfo() {
        var msg2 = {
            "BankId": sBankId, "UserId": sUserId, "BankName": $("#txtBankName").val(),
            "CardHolderName": $("#txtCardHolderName").val(), "CardNumber": $("#txtCardNumber").val(), "CVCNumber": $("#txtCVCNumber").val()
        };
        var objectAsJson = JSON.stringify(msg2);
        Type = "POST";
        Url = "http://localhost:1098/AddBank";
        ContentType = "application/json;charset=utf-8";
        Data = objectAsJson;
        DataType = "json"; ProcessData = false;
        method = "AddBank";
        debugger;
        CallService();
    }

    $(document).ready(
    function () {
        debugger;
        GetSession();
        SelectProfile();
        $("#btnUpdate").click(function () {
            AddBankinfo();
            alert("Updated Successfully");
        });
    }
    );


</script>