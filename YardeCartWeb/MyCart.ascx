<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyCart.ascx.cs" Inherits="YardeCartV2.MyCart" %>
<div>
           <table style="width:900px;" id="tblAdposthead" runat="server">
            <tr style="height:40px;">
                <td style="text-align:left;vertical-align:central; font-size:large;font-weight:600;" class="auto-style4">&nbsp;
                <asp:Label ID="lblCart" runat="server" Text="Shopping"/>
                </td>
                <td style="text-align:right;vertical-align:central;">&nbsp;
                <asp:Button ID="btnKeep" runat="server" Text="Keep Shopping" BorderStyle="Groove" BorderWidth="1px" Width="150px" OnClick="btnKeep_Click" Height="30px"/>
                </td>
            </tr></table><p></p>
           <table style="width:900px;" id="tblAdpost" runat="server">
            <tr><td colspan="2">
            <asp:GridView ID="GridView1" runat="server" Width="800px" AllowPaging="true" DataKeyNames="CartId" OnRowDeleting="GridView1_RowDeleting"
                    AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound" RowStyle-BorderColor="Tan" RowStyle-BorderWidth="1px"
                    ShowHeader="False" OnPageIndexChanging="GridView1_PageIndexChanging" BorderColor="Black" BorderWidth="2px" PageSize="10"
                    >
                    <Columns>
                        <asp:BoundField DataField="AdPostId" Visible="false" InsertVisible="false"/>
                        <asp:TemplateField >
                            <ItemTemplate>
                                <table style="width:600px;">
                                    <tr><td style="text-align:right;vertical-align:central;">
                                        <asp:LinkButton ID="lnkDelete" runat="server" CommandName="delete" style="text-align:center;" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Height="25px" Width="105px"> Remove </asp:LinkButton>
                                    </td></tr>
                                    <tr><td>
                                    <span id="spnHtml0" runat="server"></span>
                                    </td></tr>
                                </table>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <PagerStyle BorderStyle="Solid" HorizontalAlign="Center" VerticalAlign="Bottom" Wrap="True" />
                </asp:GridView>
            </td></tr>
               <tr><td class="auto-style4" style="text-align: center" colspan="2">
                    &nbsp;</td>
               </tr>
               <tr><td class="auto-style6" style="text-align: right">
                       <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Small" Text="Delivery charges"></asp:Label>&nbsp;&nbsp;
                   </td>
                   <td class="auto-style6" style="text-align: left">
                    &nbsp;&nbsp;<asp:DropDownList ID="ddlDeliType" Height="24px" Width="150px" CssClass="validate[required] radio"  CausesValidation="false"
                        OnSelectedIndexChanged="ddlDeliType_SelectedIndexChanged" AutoPostBack="true"
                                style="border:solid 1px; transform-style:flat;"  runat="server" TabIndex="2"></asp:DropDownList> 
                    <asp:Label ID="lblError" runat="server" Font-Bold="True" ForeColor="Red" Text="Select Delivery charges" Visible ="false"></asp:Label>
                       </td>
               </tr></table>
           <table style="width:900px;" id="tblAmount" runat="server">
               <tr id="trDeliAmt" runat="server" visible="false">
                   <td class="auto-style6" style="text-align: right">
                       <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="Small" Text="Delivery amount"></asp:Label>&nbsp;&nbsp;&nbsp;
                   </td>
                   <td class="auto-style6" style="text-align: left">
                       &nbsp;&nbsp;<asp:Label ID="lblDeliAmt" runat="server" Font-Bold="True" Font-Size="Small" Text="Delivery amount"></asp:Label>
                       </td>
               </tr>
               <tr  id="trTotalAmt" runat="server" visible="false">
                   <td class="auto-style6" style="text-align: right">
                       <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Small" Text="Total amount"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   </td>
                   <td class="auto-style6" style="text-align: left">
                       &nbsp;&nbsp;<asp:Label ID="lblTotalAmt" runat="server" Font-Bold="True" Font-Size="Small" Text="Delivery amount"></asp:Label></td>
               </tr>
               <tr><td class="auto-style4" style="text-align: center">
                    &nbsp;</td>
                   <td class="auto-style4" style="text-align: center">
                       &nbsp;</td>
               </tr></table>
           <table style="width:900px;" id="tblBuy" runat="server">
               <tr><td class="auto-style4" style="text-align: center" colspan="2">
                    <asp:Button ID="btnBuy" Width="100" Height="28px" runat="server" Text="BUY" BorderStyle="Groove" BorderWidth="1px"  OnClick="btnBuy_Click" />

                   </td>
               </tr>
               <tr><td class="auto-style4" style="text-align: center" colspan="2">
                    &nbsp;</td>
               </tr>
           </table>
    </div>
    <style type="text/css">
        .auto-style4 {
            width: 865px;
        }
        .auto-style6 {
            width: 865px;
            height: 35px;
        }
    </style>
