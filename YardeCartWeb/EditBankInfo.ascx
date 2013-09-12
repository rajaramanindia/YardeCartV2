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

    var sBankId;

    function ServiceSucceeded(result) {
        if (DataType == "json") {
            if (method == "SelectUserProfile") {
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
                if(UserType=="1")
                    window.location = "MyHome.aspx";
                else if(UserType == "2")
                    window.location = "MyAdminHome.aspx";

            }
        }
    }
    function SelectUserProfile() {
        Type = "GET";
        Url = sServicePath + "/SelectProfile/" + UserId;
        ContentType = "application/json;charset=utf-8";
        DataType = "json"; ProcessData = false;
        method = "SelectUserProfile";
        CallService();
    }
    function AddBankinfo() {
        var msg2 = {
            "BankId": sBankId, "UserId": UserId, "BankName": $("#txtBankName").val(),
            "CardHolderName": $("#txtCardHolderName").val(), "CardNumber": $("#txtCardNumber").val(), "CVCNumber": $("#txtCVCNumber").val()
        };
        var objectAsJson = JSON.stringify(msg2);
        Type = "POST";
        Url = sServicePath + "/AddBank";
        ContentType = "application/json;charset=utf-8";
        Data = objectAsJson;
        DataType = "json"; ProcessData = false;
        method = "AddBank";
        CallService();
    }

    $(document).ready(
    function () {
        SelectUserProfile();
        $("#btnUpdate").click(function () {
            AddBankinfo();
            alert("Updated Successfully");
        });
    }
    );


</script>