<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.GeneralSettings, App_Web_generalsettings.ascx.d988a5ac" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div id="EDNadmin">
	<div class="module_settings">
		<div class="settings_category_container">
			<div class="category_toggle">
				<h2>
					<%=GeneralSettingsTitle%></h2>
			</div>
			<div class="category_content">
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td align="center" colspan="2">
							<asp:label id="lbljQueryConfig" runat="server" text="Jquery Configuration" font-bold="True" font-size="Large" resourcekey="lbljQueryConfigResource1"></asp:label>
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<asp:label id="lblIncludeJquery" runat="server" text="Include jQuery:" resourcekey="lblIncludeJqueryResource1"></asp:label>
						</td>
						<td class="right">
							<asp:checkbox id="cbIncludeJquery" runat="server" resourcekey="cbIncludeJqueryResource1" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							<asp:label id="lblJqueryWarning" runat="server" text="Please do NOT include jQuery if you are using DotNetNuke version 6 and above." resourcekey="lblJqueryWarningResource1"></asp:label>
						</td>
					</tr>
					<tr>
						<td class="left">
							<asp:label id="lbljQueryNoConflict" runat="server" text="Run jQuery in no confilct mode:" resourcekey="lbljQueryNoConflictResource1"></asp:label>
						</td>
						<td class="right">
							<asp:checkbox id="cbjQueryNoConflictMode" runat="server" resourcekey="cbjQueryNoConflictModeResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							<asp:label id="lblJqueryWarning0" runat="server" text="Please do NOT run jQuery in conflict mode if you are using DotNetNuke version 6 and above." resourcekey="lblJqueryWarning0Resource1"></asp:label>
						</td>
					</tr>
					<tr class="second">
						<td align="center" colspan="2">
							<asp:label id="lblArticlehistory" runat="server" text="Article history" font-bold="True" font-size="Large" resourcekey="lblArticlehistoryResource1"></asp:label>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblArticleHistoryArchive" runat="server" Text="Number of article history versions:" HelpText="Set how many article history versions should be in archive:" HelpKey="lblArticleHistoryArchive.HelpText" ResourceKey="lblArticleHistoryArchive">
							</dnn:Label>
						</td>
						<td class="right">
							<asp:textbox id="tbArticleHistoryVersion" runat="server" width="40px" validationgroup="vgGeneralSettings">10</asp:textbox>
							&nbsp;<asp:requiredfieldvalidator id="rfvArticleHistoryVersion" runat="server" controltovalidate="tbArticleHistoryVersion" errormessage="This filed is required." validationgroup="vgGeneralSettings" visible="False" setfocusonerror="True" resourcekey="rfvModuleWidthResource1"></asp:requiredfieldvalidator>
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							&nbsp;
						</td>
					</tr>
					<tr class="second">
						<td colspan="2" align="center">
							<asp:label id="lblPageTitleConfigTitle" runat="server" text="Page title configuration" font-bold="True" font-size="Large" resourcekey="lblPageTitleConfigTitleResource1"></asp:label>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblPageTitleConfig" runat="server" Text="Configure article page title. Select the items and you want to appear in page title and set their positions. Below you can preview what each page title will look like." HelpText="Configure article page title. Select the items and you want to appear in page title and set their positions. Below you can preview what each page title will look like.">
							</dnn:Label>
						</td>
						<td class="right">
							<asp:gridview id="gvPageTitleFormating" runat="server" autogeneratecolumns="False" enablemodelvalidation="True" cssclass="grid_view_table" onrowcommand="gvPageTitleFormating_RowCommand" ondatabound="gvPageTitleFormating_DataBound" width="250px" resourcekey="gvPageTitleFormatingResource1">
								<columns>
									<asp:TemplateField HeaderText="Item" HeaderStyle-CssClass="title" ItemStyle-CssClass="title" SortExpression="Title" >
										<ItemTemplate>
											<asp:HiddenField ID="hfID" runat="server" Value='<%# Eval("ID") %>'></asp:HiddenField>
											<asp:Label ID="Label1" runat="server" Text='<%# Bind("Item") %>' resourcekey="Label1Resource1"></asp:Label>
										</ItemTemplate>
<HeaderStyle CssClass="title"></HeaderStyle>
<ItemStyle CssClass="title"></ItemStyle>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Visible" HeaderStyle-CssClass="title" ItemStyle-CssClass="title" SortExpression="Title" >
										<ItemTemplate>
											<asp:CheckBox ID="cbVisible" runat="server" Checked='<%# Bind("Visible") %>' AutoPostBack="True" OnCheckedChanged="cbVisible_CheckedChanged" resourcekey="cbVisibleResource1"></asp:CheckBox>
										</ItemTemplate>
<HeaderStyle CssClass="title"></HeaderStyle>
<ItemStyle CssClass="title" HorizontalAlign="Center"></ItemStyle>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Position" HeaderStyle-CssClass="arrows" ItemStyle-CssClass="arrows" >
										<ItemTemplate>
											<asp:HiddenField ID="hfPosition" runat="server" Value='<%# Eval("Position") %>'></asp:HiddenField>
											<asp:LinkButton ID="lbDocMoveDown" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' CommandName="Down" runat="server" CssClass="arrow down" resourcekey="lbDocMoveDownResource1">Down</asp:LinkButton>
											<asp:LinkButton ID="lbDocMoveUp" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' CommandName="Up" runat="server" CssClass="arrow up" resourcekey="lbDocMoveUpResource1">Up</asp:LinkButton>
										</ItemTemplate>
<HeaderStyle CssClass="arrows"></HeaderStyle>
<ItemStyle CssClass="arrows" HorizontalAlign="Center"></ItemStyle>
									</asp:TemplateField>
								</columns>
								<alternatingrowstyle cssclass="second" />
								<editrowstyle />
								<headerstyle cssclass="header_row" horizontalalign="Center" />
								<pagerstyle />
								<rowstyle />
							</asp:gridview>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblItemSeparator" runat="server" Text="Title item separator:" HelpText="Title item separator:"></dnn:Label>
						</td>
						<td class="right">
							<asp:textbox id="tbSeparator" runat="server" autopostback="True" maxlength="5" ontextchanged="tbSeparator_TextChanged" width="35px">-</asp:textbox>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblPreview" runat="server" Text="Page title preview when article is open:" HelpText="Page title preview when article is open:" HelpKey="lblPreview.HelpText" ResourceKey="lblPreview"></dnn:Label>
						</td>
						<td class="right">
							<asp:label id="lblPageTitlePreview" runat="server" resourcekey="lblPageTitlePreviewResource1"></asp:label>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblCatList" runat="server" Text="Page title preview when listing categories:" HelpText="Page title preview when listing categories:" HelpKey="lblCatList.HelpText" ResourceKey="lblCatList"></dnn:Label>
						</td>
						<td class="right">
							<asp:label id="lblPageCategoryTitlePreview" runat="server" resourcekey="lblPageCategoryTitlePreviewResource1"></asp:label>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblTagList" runat="server" Text="Page title preview when listing tags:" HelpText="Page title preview when listing tags:" HelpKey="lblTagList.HelpText" ResourceKey="lblTagList"></dnn:Label>
						</td>
						<td class="right">
							<asp:label id="lblPageTagTitlePreview" runat="server" resourcekey="lblPageTagTitlePreviewResource1"></asp:label>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblAuthorList" runat="server" Text="Page title preview when listing articles by author:" HelpText="Page title preview when listing articles by author:" HelpKey="lblAuthorList.HelpText" ResourceKey="lblAuthorList"></dnn:Label>
						</td>
						<td class="right">
							<asp:label id="lblPageAuthorTitlePreview" runat="server" resourcekey="lblPageAuthorTitlePreviewResource1"></asp:label>
						</td>
					</tr>
					<tr id="trDaylightSavingTimeTitle" runat="server" class="second">
						<td colspan="2" align="center">
							<asp:label id="lblDaylightTime" runat="server" text="Daylight saving time" font-bold="True" font-size="Large"></asp:label></td>
					</tr>
					<tr id="trDaylightSavingTime" runat="server">
						<td class="left">
							<dnn:Label ID="lblDaylightSavingTime" runat="server" Text="Use daylight saving time:" HelpText="Calculate DST shift into dates."></dnn:Label></td>
						<td class="right">
							<asp:CheckBox ID="cbDaylightSavingTime" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							<asp:label id="lblMessage" runat="server" enableviewstate="False" font-bold="True" resourcekey="lblMessageResource1"></asp:label>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="main_actions">
			<div class="buttons">
				<asp:button id="btnSaveSettings" runat="server" onclick="btnSaveSettings_Click" text="Save settings" validationgroup="vgGeneralSettings" resourcekey="btnSaveSettingsResource1" />
				<asp:button id="btnClose" runat="server" onclick="btnClose_Click" text="Close" validationgroup="vgGeneralSettings" resourcekey="btnCloseResource1" />
			</div>
		</div>
	</div>
</div>
