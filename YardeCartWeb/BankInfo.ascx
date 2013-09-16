﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BankInfo.ascx.cs" Inherits="YardeCartV2.BankInfo" %>
<style type="text/css">
    .auto-style1 {
        width: 408px;
    }
    .auto-style2 {
        width: 305px;
    }
</style>
<script type="text/javascript">
    $(document).ready(
        function () {

            $("#SearchButton").click(function () {
                window.location = "index.aspx?searchstr=" + $("#SearchBox").val();
            });
        });

</script>
<div style="vertical-align:central;padding-left:100px;padding-top:50px">
        <div >
            <h3 >Bank Information</h3><br />
        </div>
        <div>
            <table style="width:571px; border-bottom-left-radius:4px;border-width:thin; border-style:groove">
                <tr>
                    <td style="vertical-align:central;">
                        <div style="vertical-align:central;"> 
                        <table>
                            <tr style="height:40px;">
                                <td class="auto-style2">
                                    <label>Bank Name</label>
                                </td>
                                <td class="auto-style1">
                                    <asp:Label ID="lblBankName" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td class="auto-style2">
                                    <label>Card Holder Name</label>
                                </td>
                                <td class="auto-style1">
                                    <asp:Label ID="lblCardHoldername" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td class="auto-style2">
                                    C<label>ard Number</label>
                                </td>
                                <td class="auto-style1">
                                    <asp:Label ID="lblCardNumber" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr style="height:40px;">
                                <td class="auto-style2">
                                    CVC Number
                                </td>
                                <td class="auto-style1">
                                    <asp:Label ID="lblCVCNumber" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        </div>
                    </td>
                </tr>
                
            </table>
        </div>
    </div>

