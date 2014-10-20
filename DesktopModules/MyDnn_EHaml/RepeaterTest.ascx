<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RepeaterTest.ascx.cs" Inherits="MyDnn_EHaml.RepeaterTest" %>

<asp:Repeater runat="server" ID="rpt1">
    <ItemTemplate>
        <asp:PlaceHolder runat="server" ID="plc1"></asp:PlaceHolder>        
    </ItemTemplate>
</asp:Repeater>