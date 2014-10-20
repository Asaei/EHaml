<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Dashboard, App_Web_dashboard.ascx.d988a5ac" %>
<%@ Register TagPrefix="dnnCTRL" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<div id="EDNadmin">
	<div class="module_action_title_box">
		<ul class="module_navigation_menu">
			<li class="power_off">
				<asp:LinkButton ID="lbPowerOff" runat="server" ToolTip="Close" OnClick="lbPowerOff_Click" resourcekey="lbPowerOffResource1"><img src="<%=ModulePath %>images/icons/power_off.png" alt="" /></asp:LinkButton></li>
		</ul>
		<h1>
			<%=strDashboard%></h1>
	</div>
	<div class="main_content dashboard">
		<ul class="links">
			<li>
				<asp:HyperLink runat="server" ID="lbAddArticle" class="icon add_article" resourcekey="lbAddArticleResource1">Add article</asp:HyperLink></li>
			<li>
				<asp:HyperLink runat="server" ID="lbArticleList" class="icon article_manager" resourcekey="lbArticleListResource1">Article manager</asp:HyperLink></li>
			<li>
				<asp:HyperLink runat="server" ID="lbApproveArticles" class="icon approve_articles" resourcekey="lbApproveArticlesResource1">Approve Articles</asp:HyperLink></li>
		</ul>
		<ul class="links">
			<li>
				<asp:HyperLink runat="server" ID="lbComments" class="icon comments" resourcekey="lbCommentsResource1">Comments</asp:HyperLink></li>
			<li>
				<asp:HyperLink runat="server" ID="lbCategoryManager" class="icon category_manager" resourcekey="lbCategoryManagerResource1">Category manager</asp:HyperLink></li>
			<li>
				<asp:HyperLink runat="server" ID="lbTags" class="icon tags" resourcekey="lbTagsResource1">Tags</asp:HyperLink></li>
			<li>
				<asp:HyperLink runat="server" ID="lbTokens" class="icon tokens" resourcekey="LinkButton2Resource1">Tokens</asp:HyperLink></li>
			<li>
				<asp:LinkButton runat="server" ID="lbGalleryManager" OnClick="lbGalleryManager_Click" CssClass="icon gallery" resourcekey="lbGalleryManagerResource1">Gallery management</asp:LinkButton></li>
			<li>
				<asp:HyperLink runat="server" ID="lbAuthorProfiles" class="icon authors" resourcekey="lbAuthorProfilesResource1">Author Profiles</asp:HyperLink></li>
			<li>
				<asp:HyperLink runat="server" ID="lbRSSImport" class="icon atom" resourcekey="lbRSSImportResource1">RSS Import</asp:HyperLink></li>
			<li>
				<asp:HyperLink runat="server" ID="lbNotifications" class="icon snotifications" resourcekey="lbNotifications" Visible="False">System notifications</asp:HyperLink></li>
		</ul>
		<ul class="links bigger_margin">
			<li>
				<asp:HyperLink runat="server" ID="lbModuleSettings" class="icon module_settings" resourcekey="lbModuleSettingsResource1">Module settings</asp:HyperLink></li>
			<li>
				<asp:HyperLink runat="server" ID="lbDefaultSettings" class="icon global_settings" resourcekey="LinkButton1Resource1">Default settings</asp:HyperLink></li>
			<li>
				<asp:HyperLink runat="server" ID="lbGeneralSettings" class="icon general_settings" resourcekey="lbGeneralSettingsResource1">General settings</asp:HyperLink></li>
			<li>
				<asp:HyperLink runat="server" ID="lbCrossPortalSharing" class="icon cross" resourcekey="lbCrossPortalSharing" Visible="False">Cross Portal sharing</asp:HyperLink></li>
			<li>
				<asp:HyperLink runat="server" ID="lbApiConnection" class="icon apiconnections" resourcekey="lbApiConnection" Visible="False">API connections</asp:HyperLink></li>
			<li>
				<asp:LinkButton runat="server" ID="lblCustomFields" class="icon general_settings" OnClick="lblCustomFields_Click" resourcekey="lblCustomFieldsResource1">Custom Fields manager</asp:LinkButton></li>
			<li>
				<asp:LinkButton runat="server" ID="lblCustomFieldsTemplates" class="icon general_settings" OnClick="lblCustomFieldsTemplates_Click" resourcekey="lblCustomFieldsTemplatesResource1">Custom Fields group manager</asp:LinkButton></li>
			<li>
				<asp:LinkButton runat="server" ID="lblCurrencyManager" class="icon general_settings" OnClick="lblCurrencyManager_Click" resourcekey="lblCurrencyManagerResource1">Currency Manager</asp:LinkButton></li>
		</ul>
	</div>
</div>
