<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BackupUtilitiesTablesSize.ascx.cs" 
            Inherits="Evotiva.DNN.Modules.DNNBackup.BackupUtilitiesTablesSize" %>
<%@ Register TagPrefix="evotiva" TagName="MenuBar" Src="controls/MenuBar.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="BreadCrumb" Src="controls/BreadCrumb.ascx" %>

<evotiva:MenuBar runat="server" ID="ctlMenuActions" />
<evotiva:BreadCrumb runat="server" ID="ctlBreadConfigActions" ActionsSeparator=" " ShowTitle="False" />

<%--<evotiva:MessagePanel runat="server" ID="ctlMessagePanel" />--%>

<div style="text-align: left;">

    <p>
        <asp:Label ID="lblTablesSize" runat="server" ResourceKey="lblTablesSize" CssClass="bkp-head"></asp:Label>
        <br /><br />
    </p>

    <p style="text-align: left;">
        <asp:Label ID="lblTablesSizeInfo" runat="server" ResourceKey="lblTablesSizeInfo" ></asp:Label>
        <br />
    </p>

    <asp:DataGrid ID="dgTablesList" Width="600px" AllowSorting="True" CellPadding="5" AutoGenerateColumns="False" AllowPaging="False"
                  GridLines="Horizontal" runat="server">
        <HeaderStyle CssClass="bkp-head-small" />
        <Columns>                               
            <asp:TemplateColumn SortExpression="Name" HeaderText="TableName">
                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left" ></ItemStyle>
                <ItemTemplate>
                    <%# DataBinder.Eval(Container,"DataItem.Name") %>
                </ItemTemplate>
            </asp:TemplateColumn>

            <asp:TemplateColumn SortExpression="Rows" HeaderText="Rows">
                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                <ItemTemplate>
                    <%# DataBinder.Eval(Container, "DataItem.Rows") %>
                </ItemTemplate>
            </asp:TemplateColumn>

            <asp:TemplateColumn SortExpression="Kb" HeaderText="Kb">
                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                <ItemTemplate>
                    <%# DataBinder.Eval(Container, "DataItem.Kb") %>
                </ItemTemplate>
            </asp:TemplateColumn>

            <%--
            <asp:TemplateColumn SortExpression="Activity" HeaderText="Activity">
                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                <ItemTemplate>
                    <%#                DataBinder.Eval(Container, "DataItem.Activity") %>
                </ItemTemplate>
            </asp:TemplateColumn>  
            --%>               
        </Columns>
        <PagerStyle Visible="False"></PagerStyle>
    </asp:DataGrid>  

    <p style="margin-top: 30px;">
    <asp:Image ID="imgReturn" TabIndex="-1" runat="server" ImageUrl="~/images/lt.gif"
               EnableViewState="False" BorderStyle="None"/>
    <asp:LinkButton ID="cmdReturn" ResourceKey="cmdReturn" runat="server" 
                    Text="Return" BorderStyle="none" CausesValidation="False"/>
</p>

</div>

