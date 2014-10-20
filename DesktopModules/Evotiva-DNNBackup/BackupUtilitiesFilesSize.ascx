<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BackupUtilitiesFilesSize.ascx.cs" 
            Inherits="Evotiva.DNN.Modules.DNNBackup.BackupUtilitiesFilesSize" %>
<%@ Register TagPrefix="evotiva" TagName="MenuBar" Src="controls/MenuBar.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="BreadCrumb" Src="controls/BreadCrumb.ascx" %>

<evotiva:MenuBar runat="server" ID="ctlMenuActions" />
<evotiva:BreadCrumb runat="server" ID="ctlBreadConfigActions" ActionsSeparator=" " ShowTitle="False" />


<div style="text-align: left;">

    <p>
        <asp:Label ID="lblFilesSize" runat="server" ResourceKey="lblFilesSize" CssClass="bkp-head"></asp:Label>
        <br /><br />
    </p>

    <p style="text-align: left;">
        <asp:Label ID="lblFilesSizeInfo" runat="server" ></asp:Label>
        <br /><br />
    </p>


    <asp:DataGrid ID="dgFoldersList" Width="600px" AllowSorting="True" CellPadding="5" AutoGenerateColumns="False" AllowPaging="False"
                  GridLines="Horizontal" runat="server">
        <HeaderStyle CssClass="bkp-head-small" />
        <Columns>        
            <asp:TemplateColumn SortExpression="Name" HeaderText="FolderName">
                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left" ></ItemStyle>
                <ItemTemplate>
                    <asp:LinkButton  runat="server" OnCommand="lnkGoFolder_Command" ID="lnkGoFolder"
                                    CommandArgument='<%#DataBinder
                                                                                                   .
                                                                                                   Eval
                                                                                                   (Container,
                                                                                                    "DataItem.Path") %>'>
                        <%#                DataBinder.Eval(Container, "DataItem.Name") %>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateColumn>        

            <asp:TemplateColumn SortExpression="Size" HeaderText="Files">
                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                <ItemTemplate>
                    <%#                DataBinder.Eval(Container, "DataItem.SizeString") %>
                </ItemTemplate>
            </asp:TemplateColumn>

            <asp:TemplateColumn SortExpression="SizeOfSelfAndChildren" HeaderText="FilesandFolders">
                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                <ItemTemplate>
                    <%#                                        DataBinder.Eval(Container, "DataItem.SizeOfSelfAndChildrenString") %>
                </ItemTemplate>
            </asp:TemplateColumn>              
        </Columns>
        <PagerStyle Visible="False"></PagerStyle>
    </asp:DataGrid>  

    <asp:Label ID="lblNoFoldersFound" runat="server" ResourceKey="lblNoFoldersFound" CssClass="bkp-bold" ></asp:Label>

    <P style="margin-top: 30px;">
    <asp:Image ID="imgReset" TabIndex="-1" runat="server" ImageUrl="~/images/reset.gif"
               EnableViewState="False" BorderStyle="None"/>
    <asp:LinkButton ID="cmdReset" ResourceKey="cmdReset" runat="server" 
                    Text="Return" BorderStyle="none" CausesValidation="False"/>                                
        &nbsp;
    <asp:Image ID="imgReturn" TabIndex="-1" runat="server" ImageUrl="~/images/lt.gif"
               EnableViewState="False" BorderStyle="None"/>
    <asp:LinkButton ID="cmdReturn" ResourceKey="cmdReturn" runat="server" 
                    Text="Return" BorderStyle="none" CausesValidation="False"/>
    </p>
</div>

