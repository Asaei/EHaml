<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Widgets.ViewTreeView, App_Web_view.ascx.c9cb6fcf" enableviewstate="false" %>
<%@ Register TagPrefix="dnnweb" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>

<div>
<asp:UpdatePanel ID="uptest" runat="server" UpdateMode="Always">
	<ContentTemplate>
		<dnnweb:DnnTreeView ID="AdvancedTreeView" runat="server" EnableViewState="false" />
	</ContentTemplate>
</asp:UpdatePanel>
</div>

<%--<asp:Label ID="countAll" runat="server"  />--%>