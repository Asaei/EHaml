<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BackupUtilities.ascx.cs" 
            Inherits="Evotiva.DNN.Modules.DNNBackup.BackupUtilities" %>
<%@ Register TagPrefix="evotiva" TagName="MenuBar" Src="controls/MenuBar.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="BreadCrumb" Src="controls/BreadCrumb.ascx" %>

<div style="text-align: left;">
<evotiva:MenuBar runat="server" ID="ctlMenuActions" />

<div style="margin-top: 30px;">
            <evotiva:BreadCrumb runat="server" ID="ctlBreadToolsActions" />
</div>

<p style="margin-top: 30px;">
    <asp:image id="imgReturn"  tabindex="-1" runat="server" imageurl="~/images/lt.gif" enableviewstate="False"/> 
    <asp:LinkButton ID="cmdReturn" ResourceKey="cmdReturn" runat="server" 
                    Text="Return" BorderStyle="none" CausesValidation="False"/>
</p>
    
    </div>