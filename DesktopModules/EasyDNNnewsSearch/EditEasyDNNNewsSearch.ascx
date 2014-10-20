<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNewsSearch.EditEasyDNNNewsSearch, App_Web_editeasydnnnewssearch.ascx.75700bee" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<script type="text/javascript">
	jQuery().ready(function ($) {
		$('#<%=tvCatAndSubCat.ClientID %>').EDS_TreeViewSelector({
			state_checkbox: $('#<%=cbAutoAddCatChilds.ClientID %>')
		});
	});
	function ClientValidate(source, arguments) {
		var treeView = document.getElementById("<%= tvCatAndSubCat.ClientID %>");
		var checkBoxes = treeView.getElementsByTagName("input");
		var checkedCount = 0;
		for (var i = 0; i < checkBoxes.length; i++) {
			if (checkBoxes[i].checked) {
				checkedCount++;
				break;
			}
		}
		if (checkedCount > 0) {
			arguments.IsValid = true;
		} else {
			arguments.IsValid = false;
		}
	}

	function ClientValidateAuthors(source, arguments) {
		var treeView = document.getElementById("<%= tvAuthorAndGroupSelection.ClientID %>");
		var checkBoxes = treeView.getElementsByTagName("input");
		var checkedCount = 0;
		for (var i = 0; i < checkBoxes.length; i++) {
			if (checkBoxes[i].checked) {
				checkedCount++;
				break;
			}
		}
		if (checkedCount > 0) {
			arguments.IsValid = true;
		} else {
			arguments.IsValid = false;
		}
	}
</script>
<div id="EDNadmin">
	<div class="module_settings">
		<div class="settings_category_container last">
			<div class="category_toggle">
				<h2>
					<%=Searchsettings%></h2>
			</div>
			<div class="category_content">
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr runat="server" id="tblRowIsSocialInstance" style="background: #D1EBFA; display: none;">
						<td class="left" style="border: 1px solid #AAD6F1; border-right: 0;">
							<dnn:Label ID="lblIsSocialInstance" runat="server" Text="Community mode:" HelpText="Displays user's and group's articles on the Activity feed. The articles are filtered by the UserID or GroupID querystring. If this option is enabled and the querystring UserID or GroupID is missing, then the articles won't show up."
								ControlName="cbIsSocialInstance" />
						</td>
						<td class="right" style="border: 1px solid #AAD6F1; border-left: 0;">
							<asp:CheckBox ID="cbIsSocialInstance" runat="server" Checked="false" OnCheckedChanged="cbIsSocialInstance_CheckedChanged" AutoPostBack="true" />
						</td>
					</tr>
					<tr id="trPortalSharing" runat="server">
						<td class="left">
							<dnn:Label ID="lblPortalSharing" runat="server" Text="Portal sharing:" HelpText="Select data source portal." ControlName="ddlPortalSharing" HelpKey="lblPortalSharing.HelpText" ResourceKey="lblPortalSharing" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlPortalSharing" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataTextField="PortalName" DataValueField="PortalIDFrom" CssClass="ddlcategorysettings" OnSelectedIndexChanged="ddlPortalSharing_SelectedIndexChanged">
								<asp:ListItem resourcekey="liCurrentPortal" Value="-1">Current portal</asp:ListItem>
							</asp:DropDownList>
						</td>
					</tr>
					<tr>
						<td class="left" style="width: 350px">
							<dnn:Label ID="lblModDIsplayOption" runat="server" Text="Select module display mode:" ControlName="rblDisplayFormOptions" HelpText="Select module display mode." HelpKey="lblModDIsplayOption.HelpText" ResourceKey="lblModDIsplayOption" />
						</td>
						<td class="right">
							<asp:RadioButtonList ID="rblDisplayFormOptions" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblDisplayFormOptions_SelectedIndexChanged" RepeatDirection="Horizontal" resourcekey="rblDisplayFormOptionsResource1">
								<asp:ListItem Selected="True" Value="search" resourcekey="ListItemResource1">Display search form</asp:ListItem>
								<asp:ListItem Value="results" resourcekey="ListItemResource2">Display results form</asp:ListItem>
								<%--<asp:ListItem Value="customfields">Custom fields search</asp:ListItem>--%>
							</asp:RadioButtonList>
						</td>
					</tr>
				</table>
				<asp:Panel ID="pnlCFGroupSelect" runat="server" Visible="False" resourcekey="pnlCFGroupSelectResource1">
					<table class="settings_table" cellpadding="0" cellspacing="0">
						<tr class="second">
							<td class="left" style="width: 350px">
								<dnn:Label ID="lblcfgroupselect" runat="server" Text="Select custom field group:" ControlName="ddlCfGroupSelect" HelpText="Select custom field group." HelpKey="lblcfgroupselect.HelpText" ResourceKey="lblcfgroupselect" />
							</td>
							<td class="right">
								<asp:DropDownList ID="ddlCfGroupSelect" runat="server" ValidationGroup="VgSaveSetting" resourcekey="ddlCfGroupSelectResource1" />
							</td>
						</tr>
					</table>
				</asp:Panel>
				<asp:Panel ID="pnlSerchForm" runat="server" resourcekey="pnlSerchFormResource1">
					<table class="settings_table" cellpadding="0" cellspacing="0">
						<tr class="second">
							<td class="left" style="width: 350px">
								<dnn:Label ID="lblResultsModuleSelect" runat="server" Text="Select EasyDNNnews or EasyDNNnews Search module to open search results:" ControlName="ddlDisplayRsults" HelpText="Search results will open in selected module instance." HelpKey="ddlDisplayRsults.HelpText"
									ResourceKey="ddlDisplayRsults" />
							</td>
							<td class="right">
								<asp:RadioButtonList ID="rblSelectResultsSource" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblSelectResultsSource_SelectedIndexChanged" AutoPostBack="True" resourcekey="rblSelectResultsSourceResource1">
									<asp:ListItem Selected="True" Value="news" resourcekey="ListItemResource3">EasyDNNnews</asp:ListItem>
									<asp:ListItem Value="search" resourcekey="ListItemResource4">EasyDNNnews Search</asp:ListItem>
								</asp:RadioButtonList>
							</td>
						</tr>
					</table>
					<asp:Panel ID="pnlDisplayInNews" runat="server" resourcekey="pnlDisplayInNewsResource1">
						<table class="settings_table" cellpadding="0" cellspacing="0">
							<tr>
								<td class="left" style="width: 350px">
									<dnn:Label ID="lblSelectNewsModule" runat="server" ControlName="ddlDisplayRsults" HelpText="Search results will open in selected module instance." Text="Select EasyDNNnews module to open search results:" HelpKey="lblSelectNewsModule.HelpText" ResourceKey="lblSelectNewsModule" />
								</td>
								<td class="right">
									<asp:DropDownList ID="ddlSelectNewsModuleToDisplayResults" runat="server" ValidationGroup="VgSaveSetting" resourcekey="ddlSelectNewsModuleToDisplayResultsResource1" />
								</td>
							</tr>
						</table>
					</asp:Panel>
					<asp:Panel ID="pnlDisplayInSearch" runat="server" resourcekey="pnlDisplayInSearchResource1">
						<table class="settings_table" cellpadding="0" cellspacing="0">
							<tr>
								<td class="left" style="width: 350px">
									<dnn:Label ID="lblSelectModuleTODisplayResults" runat="server" Text="Select EasyDNNnews Search module to open search results:" ControlName="ddlDisplayRsults" HelpText="Search results will open in selected module instance." HelpKey="lblSelectModuleTODisplayResults.HelpText"
										ResourceKey="lblSelectModuleTODisplayResults" />
								</td>
								<td class="right">
									<asp:DropDownList ID="ddlDisplayRsults" runat="server" ValidationGroup="VgSaveSetting" resourcekey="ddlDisplayRsultsResource1" />
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlPermissionsSource" runat="server" resourcekey="pnlPermissionsSourceResource1">
					<table class="settings_table" cellpadding="0" cellspacing="0">
						<tr class="second">
							<td class="left" style="width: 350px">
								<dnn:Label ID="lblPermissionSource" runat="server" Text="Select permission source:" HelpText="Search module will inherite permission from selected value. Only allowed categories will show in search." HelpKey="lblPermissionSource.HelpText" ResourceKey="lblPermissionSource" />
							</td>
							<td class="right">
								<asp:RadioButtonList ID="rblCategoryPermissionSource" runat="server" OnSelectedIndexChanged="rblCategoryPermissionSource_SelectedIndexChanged" AutoPostBack="True" RepeatDirection="Horizontal" resourcekey="rblCategoryPermissionSourceResource1">
									<asp:ListItem Selected="True" Text="None" Value="0" resourcekey="ListItemResource5"></asp:ListItem>
									<asp:ListItem Text="Portal" Value="1" resourcekey="ListItemResource6"></asp:ListItem>
									<asp:ListItem Text="Module" Value="2" resourcekey="ListItemResource7"></asp:ListItem>
								</asp:RadioButtonList>
								<asp:Panel ID="pnlCategoryModuleInherite" runat="server" Visible="False" resourcekey="pnlCategoryModuleInheriteResource1">
									<asp:DropDownList ID="ddlPermFromModuleInstance" runat="server" resourcekey="ddlPermFromModuleInstanceResource1" />
								</asp:Panel>
							</td>
						</tr>
					</table>
				</asp:Panel>
				<asp:Panel ID="pnlSelectModuleInstance" runat="server" resourcekey="pnlSelectModuleInstanceResource1">
					<table class="settings_table" cellpadding="0" cellspacing="0">
						<tr>
							<td class="left" style="width: 350px">
								<dnn:Label ID="lblSelectModuleInstance" runat="server" Text="Select module to open articles:" ControlName="ddlOpenDetails" HelpText="Articles will open in selected module instance." HelpKey="lblSelectModuleInstance.HelpText" ResourceKey="lblSelectModuleInstance" />
							</td>
							<td class="right">
								<asp:DropDownList ID="ddlOpenDetails" runat="server" resourcekey="ddlOpenDetailsResource1" />
							</td>
						</tr>
					</table>
				</asp:Panel>
				<h3 class="subsections">
					<%=Searchspecificoptions%></h3>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr id="trNumberOfCharacters" runat="server">
						<td class="left" style="width: 350px">
							<dnn:Label ID="lblNumberOfCharacters" runat="server" Text="Number of characters to display in result:" ControlName="tbNumberOfChars" HelpText="Number of caracters in display result." HelpKey="lblNumberOfCharacters.HelpText" ResourceKey="lblNumberOfCharacters"
								Visible="True" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbNumberOfChars" runat="server" Width="50px">300</asp:TextBox>
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblSearchButtonPosition" runat="server" Text="Serach button position:" ControlName="ddlSearchPosition" HelpText="Button position." HelpKey="lblSearchButtonPosition.HelpText" ResourceKey="lblSearchButtonPosition" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlSearchPosition" runat="server" resourcekey="ddlSearchPositionResource1">
								<asp:ListItem Value="button_outside" resourcekey="ListItemResource8">Outside search textbox</asp:ListItem>
								<asp:ListItem Value="-1" resourcekey="ListItemResource9">Inside search textbox</asp:ListItem>
							</asp:DropDownList>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblSearchWay" runat="server" Text="Search options:" ControlName="rblSearchWay" HelpText="Select search options." HelpKey="lblSearchWay.HelpText" ResourceKey="lblSearchWay" />
						</td>
						<td class="right">
							<asp:RadioButtonList ID="rblSearchWay" runat="server" resourcekey="rblSearchWayResource1">
								<asp:ListItem Selected="True" Value="title" resourcekey="ListItemResource10" Text="Search title and subtitle" />
								<asp:ListItem Value="article" resourcekey="ListItemResource11" Text="Search article" />
								<asp:ListItem Value="titleandarticle" resourcekey="ListItemResource12" Text="Search title, subtitle and article" />
							</asp:RadioButtonList>
						</td>
					</tr>
					<tr id="trHighLightResult" runat="server" class="second">
						<td class="left">
							<dnn:Label ID="lblHighlightResults" runat="server" Text="Highlight results:" ControlName="cbHighlightresults" HelpText="Highlight results." HelpKey="lblHighlightResults.HelpText" ResourceKey="lblHighlightResults" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbHighlightresults" runat="server" resourcekey="cbHighlightresultsResource1" />
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center; color: Red;">
							<asp:Label ID="lblSearchInfo" runat="server" EnableViewState="False" resourcekey="lblSearchInfoResource1"></asp:Label>
						</td>
					</tr>
					<tr id="trAutoComplete" runat="server" class="second">
						<td class="left" style="width: 350px">
							<dnn:Label ID="lblAutoComplete" runat="server" Text="Auto complete box:" HelpText="Auto complete box when typing search term." ControlName="cbAutoComplete" HelpKey="lblAutoComplete.HelpText" ResourceKey="lblAutoComplete" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbAutoComplete" runat="server" Checked="True" />
						</td>
					</tr>
				</table>
				<h3 class="subsections">
					<%=Themeandtemplate%></h3>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblSelectTemplate" runat="server" ControlName="ddlTheme" Text="Module theme:" HelpText="Select theme." HelpKey="lblSelectTemplate.HelpText" ResourceKey="lblSelectTemplate" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlTheme" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlTemplates_SelectedIndexChanged" />
							<asp:CompareValidator ID="cvThemeSelect" runat="server" ForeColor="Red" ControlToValidate="ddlTheme" Display="Dynamic" ErrorMessage=" Please select theme" Operator="NotEqual" ValidationGroup="VgSaveSetting" ValueToCompare="0" resourcekey="cvThemeSelectResource1.ErrorMessage" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblSelectDisplayStyle" runat="server" Text="Module display style:" ControlName="ddlDisplayStyle" HelpText="Select display style." HelpKey="lblSelectDisplayStyle.HelpText" ResourceKey="lblSelectDisplayStyle" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlDisplayStyle" runat="server" />
							<asp:CompareValidator ID="cvdisplayStyleSelect" runat="server" ForeColor="Red" ControlToValidate="ddlDisplayStyle" Display="Dynamic" ErrorMessage=" Please select display style" Operator="NotEqual" ValidationGroup="VgSaveSetting" ValueToCompare="0" resourcekey="cvdisplayStyleSelectResource1.ErrorMessage" />
						</td>
					</tr>
					<tr id="trModuleTemplate" runat="server" visible="false">
						<td class="left">
							<dnn:Label ID="SelectHTMLTemplate" runat="server" Text="Module template:" ControlName="ddlHTMLTemplates" HelpText="Select template." HelpKey="SelectHTMLTemplate.HelpText" ResourceKey="SelectHTMLTemplate" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlHTMLTemplates" runat="server" />
						</td>
					</tr>
				</table>
				<h3 class="subsections">
					<%=Filter%></h3>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr class="second">
						<td class="left" style="width: 350px">
							<dnn:Label ID="lblFilterCategories" runat="server" Text="Search all categories on portal:" HelpText="Show all categories in search menu, or filter by category." ControlName="cbFilterCategories" HelpKey="lblFilterCategories.HelpText" ResourceKey="lblFilterCategories" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbdisplayallcats" runat="server" Checked="True" OnCheckedChanged="cbFilterCategories_CheckedChanged" AutoPostBack="True" resourcekey="cbdisplayallcatsResource1" />
						</td>
					</tr>
				</table>
				<table id="tblSelectCategories" runat="server" visible="false" class="settings_table" cellpadding="0" cellspacing="0" style="margin-left: auto; margin-right: auto;">
					<tr>
						<td class="left" style="width: 350px">
						</td>
						<td class="right">
							<asp:CheckBox ID="cbAutoAddCatChilds" runat="server" Text="Auto select all child categories." resourcekey="cbAutoAddCatChildsResource1" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lbltvCategories" runat="server" Text="Manage category filter:" HelpText="Enable/disable category." ControlName="tvCategories" HelpKey="lbltvCategories.Helptext" ResourceKey="lbltvCategories" />
						</td>
						<td class="right">
							<asp:TreeView ID="tvCatAndSubCat" runat="server" ForeColor="Black" ShowCheckBoxes="All" ShowExpandCollapse="False" ShowLines="True" />
							<asp:CustomValidator ID="cvCategoriesTreeview" runat="server" ForeColor="Red" ClientValidationFunction="ClientValidate" Display="Dynamic" Enabled="False" ErrorMessage="Please select at least one category." ValidationGroup="VgSaveSetting" resourcekey="cvCategoriesTreeview.ErrorMessage" />
						</td>
					</tr>
				</table>
				<table id="tblAuthorSelection" runat="server" class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left" style="width: 350px">
							<dnn:Label ID="lblFilterAuthors" runat="server" Text="Search all authors on portal:" HelpText="Show all authors in search menu, or filter by author." ControlName="cbFilterCategories" HelpKey="lblFilterAuthors" ResourceKey="lblFilterAuthors" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbDisplayAllAuthors" runat="server" AutoPostBack="True" OnCheckedChanged="cbDisplayAllAuthors_CheckedChanged" Checked="True" resourcekey="cbDisplayAllAuthorsResource1" />
						</td>
					</tr>
					<tr id="rowAuthorsFilter" runat="server" visible="false" class="second">
						<td class="left" style="width: 350px" runat="server">
							<dnn:Label ID="lblAuthorSelection" runat="server" Text="Select authors to include in search:" HelpText="Select authors to include in search." HelpKey="lblAuthorSelection.HelpText" ResourceKey="lblAuthorSelection" />
						</td>
						<td class="right" runat="server">
							<asp:TreeView ID="tvAuthorAndGroupSelection" runat="server" ForeColor="Black" ImageSet="Contacts" ShowCheckBoxes="All" NodeIndent="25">
								<HoverNodeStyle Font-Underline="False" />
								<NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
								<ParentNodeStyle Font-Bold="True" ForeColor="#5555DD" />
								<SelectedNodeStyle Font-Underline="True" HorizontalPadding="0px" VerticalPadding="0px" />
							</asp:TreeView>
							<asp:CustomValidator ID="cvAuthorsTreeview" runat="server" ForeColor="Red" ClientValidationFunction="ClientValidateAuthors" Display="Dynamic" Enabled="False" ErrorMessage="Please select at least one author." ValidationGroup="VgSaveSetting" resourcekey="cvAuthorsTreeview.ErrorMessage" />
						</td>
					</tr>
				</table>
				<asp:Panel ID="pnlLocalization" runat="server" Visible="false">
					<%--				<h3 class="subsections">
					Localization:</h3>--%>
					<table class="settings_table" cellpadding="0" cellspacing="0" style="display: none">
						<tr>
							<td class="left">
								<dnn:Label ID="lblHideUnlocalizedItems" runat="server" Text="Don't show unlocalized items:" HelpText="Articles, events that are unlocalized won't show when localization selected." />
							</td>
							<td class="right">
								<asp:CheckBox ID="cbHideUnlocalizedItems" runat="server" />
							</td>
						</tr>
					</table>
				</asp:Panel>
			</div>
		</div>
		<div class="main_actions">
			<p>
				<asp:Label ID="lblMainMessage" runat="server" EnableViewState="false" /></p>
			<div class="buttons">
				<asp:Button ID="btnSaveSettings" runat="server" OnClick="btnSaveSettings_Click" Text="Save" ValidationGroup="VgSaveSetting" resourcekey="btnSaveSettingsResource1" />
				<asp:Button ID="btnSaveClose" runat="server" OnClick="btnSaveClose_Click" Text="Save &amp; Close" resourcekey="btnSaveCloseResource1" ValidationGroup="VgSaveSetting" />
				<asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Close" resourcekey="btnCancelResource1" />
			</div>
		</div>
	</div>
</div>
