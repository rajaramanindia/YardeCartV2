<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyAdposts.ascx.cs" Inherits="YardeCartV2.MyAdposts" %>
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
                <td style="text-align:left;vertical-align:central; font-size:large;font-weight:600;">&nbsp;
                <asp:Label ID="lblCart" runat="server" Text="My AdPosts"/>
                </td>
                <td style="text-align:right;vertical-align:central;">&nbsp;
                </td>
            </tr>
            <tr><td colspan="2">
            <asp:GridView ID="GridView1" runat="server" Width="800px" AllowPaging="true" PageSize="10"
                    AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound" RowStyle-BorderColor="Tan" RowStyle-BorderWidth="1px"
                    ShowHeader="False" OnPageIndexChanging="GridView1_PageIndexChanging" BorderColor="Black" BorderWidth="2px"
                    >
                    <Columns>
                        <asp:TemplateField >
                            <ItemTemplate>
                                <table>
                                    <%--<tr><td style="text-align:right;vertical-align:central;">
                                        <asp:LinkButton ID="lnkEdit" runat="server" > Edit </asp:LinkButton>
                                        <asp:LinkButton ID="lnkDelete" runat="server" > Remove </asp:LinkButton>
                                    </td></tr>--%>
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
           </table>
    </div>