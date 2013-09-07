<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyPuchase.ascx.cs" Inherits="YardeCartV2.MyPuchase" %>

<style type="text/css">
        .auto-style4 {
            width: 865px;
        }
        .auto-style6 {
            height: 20px;
        }
        .auto-style7 {
            width: 214px;
        }
    </style>
<div>
           <table style="width:900px;" id="tblAdpost" runat="server">
            <tr style="height:40px;">
                <td style="text-align:left;vertical-align:central; font-size:large;font-weight:600;" class="auto-style4">&nbsp;
                <asp:Label ID="lblCart" runat="server" Text="Shopping"/>
                </td>
                <td style="text-align:right;vertical-align:central;">&nbsp;
                <asp:Button ID="btnKeep" runat="server" Text="Keep Shopping" BorderStyle="Groove" BorderWidth="1px" Width="150px" OnClick="btnKeep_Click" Height="30px"/>
                </td>
            </tr>
            <tr><td colspan="2">
            <asp:GridView ID="GridView1" runat="server" Width="800px" AllowPaging="true" DataKeyNames="AdPostId"
                    AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound" RowStyle-BorderColor="Tan" RowStyle-BorderWidth="1px"
                    ShowHeader="False" OnPageIndexChanging="GridView1_PageIndexChanging" BorderColor="Black" BorderWidth="2px" PageSize="10"
                    >
                    <Columns>
                        <asp:BoundField DataField="AdPostId" Visible="false" InsertVisible="false"/>
                        <asp:TemplateField >
                            <ItemTemplate>
                                <table style="width:600px;">
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
           </table>
    </div>