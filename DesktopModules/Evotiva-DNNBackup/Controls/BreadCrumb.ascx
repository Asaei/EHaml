<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BreadCrumb.ascx.cs"
            Inherits="Evotiva.DNN.Modules.DNNBackup.BreadCrumb" %>

<asp:Panel ID="pnlTitle" runat="server" enableviewstate="False">
    <asp:Label runat="server" ID="lblTitle" CssClass="bkp-head" enableviewstate="False"/>
    <hr class="bkp-hr" /> 
</asp:Panel>

<div class="bkp-breadcrumbs">
    <asp:Repeater ID="rptActions" runat="server">
        <ItemTemplate>            
            <img src="<%# DataBinder.Eval(Container.DataItem,"ImgUrl") %>" alt="<%#  DataBinder.Eval(Container.DataItem, "Text") %>" style="border: 0;" />
            <a class="<%# DataBinder.Eval(Container.DataItem, "Css") %>" href="<%# DataBinder.Eval(Container.DataItem, "Url") %>"> <%# DataBinder.Eval(Container.DataItem, "Text") %> </a>
        </ItemTemplate>
        <SeparatorTemplate>
            <%= ActionsSeparator %>
        </SeparatorTemplate>
    </asp:Repeater>
</div>
