<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BackupHistory.ascx.cs" 
            Inherits="Evotiva.DNN.Modules.DNNBackup.BackupHistory" %>
<%@ Register TagPrefix="evotiva" TagName="MenuBar" Src="controls/MenuBar.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="MessagePanel" Src="controls/MessagePanel.ascx" %>

<div style="text-align: left;">

<evotiva:MenuBar runat="server" ID="ctlMenuActions" />
<evotiva:MessagePanel runat="server" ID="ctlMessagePanel" />

<p style="margin-bottom: 10px;margin-top: 30px;">
    <asp:Label ID="lblTitle" runat="server" ResourceKey="lblTitle" CssClass="bkp-head"></asp:Label>
</p>
<asp:Panel ID="pnlMainForm" runat="server">
    <table runat="server" id="bkp_tblhistory" style="border-spacing: 10px;" summary="Backup History Design Table">
        <tr runat="server" id="rowGridOptions">
            <td>               
                <asp:Label ID="lblFilesLocation" runat="server" Text="Files Source" ResourceKey="lblFilesLocation" CssClass="bkp-bold" />
                &nbsp;<asp:DropDownList ID="drpFilesLocation" runat="server"  AutoPostBack="True"/>
                &nbsp;&nbsp;
                <asp:Label ID="lblFilter" runat="server" Text="Filter" ResourceKey="lblFilter" CssClass="bkp-bold" />
                &nbsp;<asp:DropDownList ID="drpFilter" runat="server"  AutoPostBack="True"/>				
            </td>
            <td style="text-align: right;">
                <asp:label id="lblItemsPerPage" runat="server" CssClass="bkp-bold" ResourceKey="ItemsPerPage">Items Per Page:</asp:label>&nbsp;
                <asp:dropdownlist id="selPageSize" Runat="server"  AutoPostBack="True">
                    <asp:ListItem Selected="True" Value="10">10</asp:ListItem>
                    <asp:ListItem Value="15">15</asp:ListItem>
                    <asp:ListItem Value="20">20</asp:ListItem>
                    <asp:ListItem Value="30">30</asp:ListItem>
                    <asp:ListItem Value="40">40</asp:ListItem>
                    <asp:ListItem Value="50">50</asp:ListItem>
                </asp:dropdownlist>                    
            </td>        
        </tr>
        <tr runat="server" id="rowGrid">
            <td colspan="2">
                <asp:DataGrid ID="dgFileList" Width="100%" AllowSorting="True" CellPadding="5" AutoGenerateColumns="False" AllowPaging="True"
                              GridLines="Horizontal" runat="server">
                    <HeaderStyle CssClass="bkp-head-small" />
                    <Columns>
                        <%--<asp:TemplateColumn>
						<ItemStyle HorizontalAlign="Right" Width="1%"></ItemStyle>
						<ItemTemplate>
							<asp:CheckBox ID="chkSelect" runat="server" filename='<%#DataBinder.Eval(Container, "DataItem.FileName")%>'>
							</asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>  --%>                  
                        <asp:TemplateColumn>
                            <ItemStyle HorizontalAlign="Left" Width="20px"></ItemStyle>
                            <ItemTemplate>
                                <asp:ImageButton ID="lnkDeleteFile" OnCommand="lnkDeleteFile_Command" ResourceKey="DeleteFileImg.AlternateText"
                                                 runat="server" ImageUrl="~/images/FileManager/DNNExplorer_trash.gif" AlternateText="Delete File"
                                                 CommandName='<%#                                        DataBinder.Eval(Container, "DataItem.FileName") %>'></asp:ImageButton>
                            </ItemTemplate>
                        </asp:TemplateColumn>                
                        <asp:TemplateColumn SortExpression="FileName" HeaderText="FileName">
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <ItemTemplate>
                                <asp:LinkButton  runat="server" OnCommand="lnkDLFile_Command" ID="lnkDLFile"
                                                CommandArgument='<%#                                        DataBinder.Eval(Container, "DataItem.FileName") %>'>
                                    <%#                                        DataBinder.Eval(Container, "DataItem.FileName") %>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn SortExpression="DateModified" HeaderText="Date">
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" ></ItemStyle>
                            <ItemTemplate>
                                <%#                                        DataBinder.Eval(Container, "DataItem.DateModified") %>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn SortExpression="intFileSize" HeaderText="Size">
                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <ItemTemplate>
                                <%#                                        DataBinder.Eval(Container,
                                                        "DataItem.FileSize") %>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn SortExpression="Extension" HeaderText="Extension">
                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" ></ItemStyle>
                            <ItemTemplate>
                                <%#                                        DataBinder.Eval(Container, "DataItem.Extension") %>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn SortExpression="Type" HeaderText="Type">
                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <ItemTemplate>
                                <%#                DataBinder.Eval(Container, "DataItem.Type") %>
                            </ItemTemplate>
                        </asp:TemplateColumn>                    
                    </Columns>
                    <PagerStyle Visible="False"/>
                </asp:DataGrid>
                <asp:Panel runat="server" ID="tblMessagePager" style="text-align: right;margin-top: 3px;">
                    <asp:Label ID="lblCurPage" runat="server" CssClass="bkp-bold"/>
                    &nbsp;&nbsp;<asp:LinkButton ID="lnkMoveFirst" runat="server"/>
                    &nbsp;<asp:LinkButton ID="lnkMovePrevious" runat="server"/>
                    &nbsp;<asp:LinkButton ID="lnkMoveNext" runat="server"/>
                    &nbsp;<asp:LinkButton ID="lnkMoveLast" runat="server"/>
                </asp:Panel>
            </td>
        </tr>
        
        <tr>
            <td colspan="2">
                <asp:Label runat="server" ID="lblNoRowsFound" ResourceKey="NoRowsFound" Visible="False" CssClass="bkp-bold"/>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <div style="margin-top: 20px;">
                <asp:image id="imgReturn"  tabindex="-1" runat="server" imageurl="~/images/lt.gif" enableviewstate="False"/> 
                <asp:LinkButton ID="cmdReturn" ResourceKey="cmdReturn" runat="server" 
                                Text="Return" BorderStyle="none" CausesValidation="False"/>                    
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
    <asp:Label runat="server" ID="lblError" CssClass="bkp-error" Visible="False" />
            </td>

        </tr>
    </table>
</asp:Panel>
    
</div>