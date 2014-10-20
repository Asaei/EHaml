<%@ control language="C#" inherits="EasyDNN.Modules.EasyDNNNewsTagCloud.EditEasyDNNNewsTagCloud, App_Web_editeasydnnnewstagcloud.ascx.c28fc201" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Audit" Src="~/controls/ModuleAuditControl.ascx" %>
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
					<%=Tagcloudsettings%></h2>
			</div>
			<div class="category_content">
				<div id="pnlSocialInstance" runat="server" style="display: none;">
					<table class="settings_table" cellpadding="0" cellspacing="0">
						<tr runat="server" style="background: #D1EBFA;">
							<td class="left" style="border: 1px solid #AAD6F1; border-right: 0;">
								<dnn:Label ID="lblIsSocialInstance" runat="server" Text="Community mode:" HelpText="Displays user's and group's articles on the Activity feed. The articles are filtered by the UserID or GroupID querystring. If this option is enabled and the querystring UserID or GroupID is missing, then the articles won't show up."
									ControlName="cbIsSocialInstance" />
							</td>
							<td class="right" style="border: 1px solid #AAD6F1; border-left: 0;">
								<asp:CheckBox ID="cbIsSocialInstance" runat="server" Checked="false" OnCheckedChanged="cbIsSocialInstance_CheckedChanged" AutoPostBack="true" />
							</td>
						</tr>
					</table>
				</div>
				<div id="pnlPortalSharing" runat="server">
					<h3 class="subsections">
						<%=Portalsharing%></h3>
					<table class="settings_table" cellpadding="0" cellspacing="0">
						<tr>
							<td class="left">
								<dnn:Label ID="lblPortalSharing" runat="server" Text="Select portal:" HelpText="Select data source portal." ControlName="ddlPortalSharing" HelpKey="lblPortalSharing.HelpText" ResourceKey="lblPortalSharing" />
							</td>
							<td class="right">
								<asp:DropDownList ID="ddlPortalSharing" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataTextField="PortalName" DataValueField="PortalIDFrom" CssClass="ddlcategorysettings" OnSelectedIndexChanged="ddlPortalSharing_SelectedIndexChanged">
									<asp:ListItem resourcekey="liCurrentPortal" Value="-1">Current portal</asp:ListItem>
								</asp:DropDownList>
							</td>
						</tr>
					</table>
				</div>
				<h3 class="subsections">
					<%=Permissions%></h3>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblPermissionSource" runat="server" Text="Select permission source:" HelpText="Category menu will inherit permission from selected source. Tags from allowed categories will show in module." HelpKey="lblPermissionSource.HelpText" ResourceKey="lblPermissionSource" />
						</td>
						<td class="right">
							<asp:RadioButtonList ID="rblCategoryPermissionSource" runat="server" OnSelectedIndexChanged="rblCategoryPermissionSource_SelectedIndexChanged" AutoPostBack="True" RepeatDirection="Horizontal" resourcekey="rblCategoryPermissionSourceResource1">
								<asp:ListItem Selected="True" Text="None" Value="0" resourcekey="ListItemResource1"></asp:ListItem>
								<asp:ListItem Text="Portal" Value="1" resourcekey="ListItemResource2"></asp:ListItem>
								<asp:ListItem Text="Module" Value="2" resourcekey="ListItemResource3"></asp:ListItem>
							</asp:RadioButtonList>
							<asp:Panel ID="pnlCategoryModuleInherite" runat="server" Visible="False" resourcekey="pnlCategoryModuleInheriteResource1">
								<asp:DropDownList ID="ddlPermFromModuleInstance" runat="server" resourcekey="ddlPermFromModuleInstanceResource1" />
							</asp:Panel>
						</td>
					</tr>
				</table>
				<h3 class="subsections">
					<%=TagCouldOptions%></h3>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblNumberOfTags" runat="server" Text="Number of tags:" HelpText="Number of tags to display. 0 to display all tags." HelpKey="lblNumberOfTags.HelpText" ResourceKey="lblNumberOfTags" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbNumberOfTags" runat="server" Width="50px" ValidationGroup="vgSave" resourcekey="tbNumberOfTagsResource1" Text="10" />
							<asp:RequiredFieldValidator ID="rfvNumberOfTags" runat="server" ForeColor="Red" ControlToValidate="tbNumberOfTags" Display="Dynamic" ErrorMessage="This filed is required." ValidationGroup="vgSave" resourcekey="rfvNumberOfTagsResource1" />
							<asp:CompareValidator ID="cvNumberOfTags" runat="server" ForeColor="Red" ControlToValidate="tbNumberOfTags" Display="Dynamic" ErrorMessage="Enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSave" resourcekey="cvNumberOfTagsResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblSorting" runat="server" Text="Sorting:" HelpText="Tag sorting type:" HelpKey="lblSorting.HelpText" ResourceKey="lblSorting" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlSorting" runat="server">
								<asp:ListItem Value="TagName" resourcekey="ListItemResource4">Tag name</asp:ListItem>
								<asp:ListItem Value="Number" resourcekey="ListItemResource5">Number of posts</asp:ListItem>
							</asp:DropDownList>
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblShowTagCount" runat="server" Text="Show tag count:" HelpText="Shows number of tag appearance." HelpKey="lblShowTagCount.HelpText" ResourceKey="lblShowTagCount" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbShowTagCount" runat="server" Checked="False" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblModuleToOpen" runat="server" Text="Open in:" HelpText="Select news module instance or page to open articles:" HelpKey="lblModuleToOpen.HelpText" ResourceKey="lblModuleToOpen" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbModules" Style="display: none" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbModules_CheckedChanged" resourcekey="cbModulesResource1" />
							<asp:DropDownList ID="ddlOpenDetails" runat="server" />
						</td>
					</tr>
					<tr class="second" style="display: none">
						<td class="left">
						</td>
						<td class="right">
							<asp:CheckBox ID="cbPage" runat="server" AutoPostBack="True" OnCheckedChanged="cbPage_CheckedChanged" Text="Page" resourcekey="cbPageResource1" />
							<asp:DropDownList ID="ddlPageOpenDetails" runat="server" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblDisplayHeader" runat="server" Text="Display header:" HelpText="Display header:" HelpKey="lblDisplayHeader.HelpText" ResourceKey="lblDisplayHeader" Visible="True" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbDisplayHeader" runat="server" Checked="True" resourcekey="cbDisplayHeaderResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblTagsByCategory" runat="server" Text="Dynamically display tags from the selected category:" HelpText="While navigating through multiple categories, only the currently selected category's tags are displayed." HelpKey="lblTagsByCategory.HelpText"
								ResourceKey="lblTagsByCategory" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbTagsByCategory" runat="server" Checked="False" />
						</td>
					</tr>
					<tr class="second">
						<td colspan="2" style="text-align: center; color: Red;">
							<asp:Label ID="lblTagCloudInfo" runat="server" EnableViewState="False" resourcekey="lblTagCloudInfoResource1" />
						</td>
					</tr>
				</table>
				<h3 class="subsections">
					<%=Themeandtemplate%></h3>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblTagsTheme" runat="server" Text="Module theme:" ControlName="ddlTheme" HelpText="Select theme." HelpKey="lblTagsTheme.HelpText" ResourceKey="lblTagsTheme" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlTheme" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlTemplates_SelectedIndexChanged" ValidationGroup="vgSave" />
							<asp:CompareValidator ID="cvThemeSelect" runat="server" ForeColor="Red" ControlToValidate="ddlTheme" Display="Dynamic" ErrorMessage=" Please select theme" Operator="NotEqual" ValidationGroup="vgSave" ValueToCompare="0" resourcekey="cvThemeSelectResource1.ErrorMessage" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblSelectDisplayStyle" runat="server" Text="Module display style:" HelpText="Select display style." HelpKey="lblSelectDisplayStyle.HelpText" ResourceKey="lblSelectDisplayStyle" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlDisplayStyle" runat="server" ValidationGroup="vgSave" />
							<asp:CompareValidator ID="cvdisplayStyleSelect" runat="server" ForeColor="Red" ControlToValidate="ddlDisplayStyle" Display="Dynamic" ErrorMessage=" Please select display style" Operator="NotEqual" ValidationGroup="vgSave" ValueToCompare="0" resourcekey="cvdisplayStyleSelectResource1.ErrorMessage" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblHtmTemplate" runat="server" Text="Module htm template:" HelpText="Htm template." HelpKey="lblHtmTemplate.HelpText" ResourceKey="lblHtmTemplate" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlHtmTemplate" runat="server" ValidationGroup="vgSave" />
						</td>
					</tr>
				</table>
				<h3 class="subsections">
					<%=Filter%></h3>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblCelectCats" runat="server" Text="Select categories to display tags from:" HelpText="Show all categories or make category selection in the tree view selection list." HelpKey="lblCelectCats.HelpText" ResourceKey="lblCelectCats" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbdisplayallcats" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbdisplayallcats_CheckedChanged" Text="Display tags from all categories" resourcekey="cbdisplayallcatsResource1" />
						</td>
					</tr>
				</table>
				<table id="tblSelectCategories" runat="server" visible="false" class="settings_table" cellpadding="0" cellspacing="0" style="margin-left: auto; margin-right: auto;">
					<tr class="second">
						<td class="left">
						</td>
						<td class="right">
							<asp:CheckBox ID="cbAutoAddCatChilds" runat="server" Text="Auto select all child categories." resourcekey="cbAutoAddCatChildsResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
						</td>
						<td class="right">
							<asp:TreeView ID="tvCatAndSubCat" CssClass="categories_to_display" runat="server" ForeColor="Black" ShowCheckBoxes="All" ShowExpandCollapse="False" ShowLines="True" resourcekey="tvCatAndSubCatResource1" />
							<asp:CustomValidator ID="cvCategoriesTreeview" runat="server" ForeColor="Red" ClientValidationFunction="ClientValidate" ErrorMessage="Please select at least one category." Display="Dynamic" Enabled="False" resourcekey="cvCategoriesTreeview.ErrorMessage"
								ValidationGroup="vgSave" />
						</td>
					</tr>
				</table>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblFilterAuthors" runat="server" Text="Display articles from all authors in the portal:" HelpText="Display articles from all authors in the portal:" ControlName="cbFilterCategories" HelpKey="lblFilterAuthors.HelpText" ResourceKey="lblFilterAuthors" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbDisplayAllAuthors" runat="server" AutoPostBack="True" OnCheckedChanged="cbDisplayAllAuthors_CheckedChanged" Checked="True" resourcekey="cbDisplayAllAuthorsResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
						</td>
						<td class="right">
							<asp:TreeView ID="tvAuthorAndGroupSelection" runat="server" ForeColor="Black" ImageSet="Contacts" ShowCheckBoxes="All" NodeIndent="25" Visible="false">
								<HoverNodeStyle Font-Underline="False" />
								<NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
								<ParentNodeStyle Font-Bold="True" ForeColor="#5555DD" />
								<SelectedNodeStyle Font-Underline="True" HorizontalPadding="0px" VerticalPadding="0px" />
							</asp:TreeView>
							<asp:CustomValidator ID="cvAuthorsTreeview" runat="server" ForeColor="Red" ClientValidationFunction="ClientValidateAuthors" Display="Dynamic" Enabled="False" ErrorMessage="Please select at least one author." resourcekey="cvAuthorsTreeview.ErrorMessage"
								ValidationGroup="vgSave" />
						</td>
					</tr>
				</table>
				<asp:Panel ID="pnlLocalization" runat="server" Visible="false">
					<h3 class="subsections">
						<%=LocalizationText%></h3>
					<table class="settings_table" cellpadding="0" cellspacing="0">
						<tr>
							<td class="left">
								<dnn:Label ID="lblHideUnlocalizedItems" runat="server" Text="Don't show unlocalized items:" HelpText="Articles, events that are unlocalized won't show when localization selected." HelpKey="lblHideUnlocalizedItems.HelpText" 
									ResourceKey="lblHideUnlocalizedItems" />
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
				<asp:Button ID="btnSaveSettings" runat="server" OnClick="btnSaveSettings_Click" Text="Save" ValidationGroup="vgSave" resourcekey="btnSaveSettingsResource1" />
				<asp:Button ID="btnSaveClose" runat="server" OnClick="btnSaveClose_Click" Text="Save &amp; Close" ValidationGroup="vgSave" resourcekey="btnSaveCloseResource1" />
				<asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Close" resourcekey="btnCancelResource1" />
			</div>
		</div>
	</div>
</div>
