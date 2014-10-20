<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BackupSettingsPage.ascx.cs" 
            Inherits="Evotiva.DNN.Modules.DNNBackup.BackupSettingsPage" %>
<%@ Import Namespace="System.Globalization" %>

<%--<a id="evoLogo" href="http://www.evotiva.com" target="_blank">
	<asp:Image ID="imgLogo" runat="server" AlternateText="Evotiva Logo"></asp:Image>
</a>--%>
<div id="divGoToSettings" style="vertical-align: middle;">

    <img style="border: 0; vertical-align: middle;" src="<%= ResolveUrl("images/Configuration.png") %>"  alt="Settings" />
    <a style="vertical-align: middle;" class="CommandButton" href="<%= DotNetNuke.Common.Globals.NavigateURL(TabId, "BackupConfiguration",
                                                               "mid=" + ModuleId.ToString(CultureInfo.InvariantCulture)) %>"> 
        <%= DotNetNuke.Services.Localization.Localization.GetString("GoToSettings.Text",
                                                                                 LocalResourceFile) %>
    </a>

    <%--    <asp:LinkButton ID="lnkGoToSettings" runat="server" >
		<asp:Image ID="imgSettings" runat="server" AlternateText="Settings"></asp:Image>
	</asp:LinkButton>--%>
</div>
<br /><br />