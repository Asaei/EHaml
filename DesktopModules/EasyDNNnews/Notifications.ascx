<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Notifications, App_Web_notifications.ascx.d988a5ac" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<style type="text/css">
	td > .dnnTooltip label
	{
		text-align: left;
	}
</style>
<asp:Panel ID="pnlMain" runat="server" meta:resourcekey="pnlMainResource1">
	<div id="EDNadmin">
		<div class="module_action_title_box">
			<ul class="module_navigation_menu">
				<li>
					<asp:LinkButton ID="lbModuleNavigationAddArticle" runat="server" ToolTip="Add article" OnClick="lbModuleNavigationAddArticle_Click" meta:resourcekey="lbModuleNavigationAddArticleResource1"><img src="<%=ModulePath %>images/icons/paper_and_pencil.png" alt="" /></asp:LinkButton></li>
				<li>
					<asp:LinkButton ID="lbModuleNavigationArticleEditor" runat="server" ToolTip="Article editor" OnClick="lbModuleNavigationArticleEditor_Click" meta:resourcekey="lbModuleNavigationArticleEditorResource1"><img src="<%=ModulePath %>images/icons/papers_and_pencil.png" alt="" /></asp:LinkButton></li>
				<li>
					<asp:LinkButton ID="lbModuleNavigationCategoryEditor" runat="server" ToolTip="Category editor" OnClick="lbModuleNavigationCategoryEditor_Click" meta:resourcekey="lbModuleNavigationCategoryEditorResource1"><img src="<%=ModulePath %>images/icons/categories.png" alt="" /></asp:LinkButton></li>
				<li>
					<asp:LinkButton ID="lbModuleNavigationApproveComments" runat="server" ToolTip="Approve comments" OnClick="lbModuleNavigationApproveComments_Click" meta:resourcekey="lbModuleNavigationApproveCommentsResource1"><img src="<%=ModulePath %>images/icons/conversation.png" alt="" /></asp:LinkButton></li>
				<li>
					<asp:LinkButton ID="lbModuleNavigationDashboard" runat="server" ToolTip="Dashboard" OnClick="lbModuleNavigationDashboard_Click" meta:resourcekey="lbModuleNavigationDashboardResource1"><img src="<%=ModulePath %>images/icons/lcd.png" alt="" /></asp:LinkButton></li>
				<li class="power_off">
					<asp:LinkButton ID="lbPowerOff" runat="server" ToolTip="Close" meta:resourcekey="lbPowerOffResource1"><img src="<%=ModulePath %>images/icons/power_off.png" alt="" /></asp:LinkButton></li>
			</ul>
			<h1>
				<%=TopTitle%></h1>
		</div>
		<div class="main_content">
			<div class="tabbed_container">
				<br />
				<div id="pnlAllSettings" class="module_settings" runat="server" resourcekey="pnlAllSettingsResource1">
					<div id="pnlPermissions" runat="server" cssclass="settings_category_container" resourcekey="pnlPermissionsResource1">
						<div class="category_content">
							<div class="first_coll_fixed_table">
								<asp:GridView ID="gvRoleNames" runat="server" CssClass="settings_table fixed_table permissionsNotifications" AutoGenerateColumns="False" DataKeyNames="RoleID" CellPadding="0" resourcekey="gvRolePremissionsLabelsResource1">
									<AlternatingRowStyle CssClass="second" />
									<Columns>
										<asp:TemplateField HeaderText="Roles" HeaderStyle-Height="30px">
											<ItemTemplate>
												<p>
													<asp:Label ID="lblRoleName" runat="server" Text='<%#Eval("RoleName")%>' resourcekey="lblRoleNameResource1"></asp:Label>
												</p>
											</ItemTemplate>
											<HeaderStyle CssClass="header_cell" />
										</asp:TemplateField>
									</Columns>
								</asp:GridView>
								<div>
									<asp:GridView ID="gvRoleNotificationSettings" runat="server" CssClass="settings_table permissionsNotifications" AutoGenerateColumns="False" DataKeyNames="RoleID" CellPadding="0" resourcekey="gvRolePremissionsResource1">
										<AlternatingRowStyle CssClass="second" />
										<Columns>
											<asp:TemplateField HeaderText="New article notification">
												<ItemTemplate>
													<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# Eval("RoleID") %>' />
													<asp:HiddenField ID="hfRoleName" runat="server" Value='<%# Eval("RoleName") %>' />
													<asp:CheckBox ID="cbNewArticle" runat="server" Checked='<%#Convert.ToBoolean(Eval("NewArticle"))%>' resourcekey="cbApproveArticlesResource1" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="New event notification">
												<ItemTemplate>
													<asp:CheckBox ID="cbNewEvent" runat="server" Checked='<%#Convert.ToBoolean(Eval("Newevent"))%>' resourcekey="cbDocumentUploadResource1" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Edit article notification">
												<ItemTemplate>
													<asp:CheckBox ID="cbEditArticle" runat="server" Checked='<%#Convert.ToBoolean(Eval("EditArticle"))%>' resourcekey="cbDocumentUploadResource1" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Request for approve article">
												<ItemTemplate>
													<asp:CheckBox ID="cbApproveArticle" runat="server" Checked='<%#Convert.ToBoolean(Eval("ApproveArticle"))%>' resourcekey="cbDocumentDownloadResource1" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="New comment notification">
												<ItemTemplate>
													<asp:CheckBox ID="cbNewComment" runat="server" Checked='<%#Convert.ToBoolean(Eval("NewComment"))%>' resourcekey="cbAddEditCategoriesResource1" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Request for approve comment">
												<ItemTemplate>
													<asp:CheckBox ID="cbApproveComment" runat="server" Checked='<%#Convert.ToBoolean(Eval("ApproveComment"))%>' resourcekey="cbAllowToCommentResource1" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="">
												<ItemTemplate>
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
									</asp:GridView>
								</div>
							</div>
							<div class="first_coll_fixed_table">
								<asp:GridView ID="gvUserNames" runat="server" CssClass="settings_table fixed_table permissionsNotifications" AutoGenerateColumns="False" DataKeyNames="UserID" CellPadding="0" resourcekey="gvRolePremissionsLabelsResource1">
									<AlternatingRowStyle CssClass="second" />
									<Columns>
										<asp:TemplateField HeaderText="Users" HeaderStyle-Height="30px">
											<ItemTemplate>
												<p>
													<asp:Label ID="lblUserName" runat="server" Text='<%#Eval("UserName")%>' resourcekey="lblRoleNameResource1"></asp:Label>
												</p>
											</ItemTemplate>
											<HeaderStyle CssClass="header_cell" />
										</asp:TemplateField>
									</Columns>
								</asp:GridView>
								<div>
									<asp:GridView ID="gvUserNotificationSettings" runat="server" CssClass="settings_table permissionsNotifications" AutoGenerateColumns="False" DataKeyNames="UserID" CellPadding="0" resourcekey="gvRolePremissionsResource1" OnRowCommand="gvUserNotificationSettings_RowCommand">
										<AlternatingRowStyle CssClass="second" />
										<Columns>
											<asp:TemplateField HeaderText="New article notification">
												<ItemTemplate>
													<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
													<asp:HiddenField ID="hfUsername" runat="server" Value='<%# Eval("Username") %>' />
													<asp:CheckBox ID="cbNewArticle" runat="server" Checked='<%#Convert.ToBoolean(Eval("NewArticle"))%>' resourcekey="cbApproveArticlesResource1" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="New event notification">
												<ItemTemplate>
													<asp:CheckBox ID="cbNewEvent" runat="server" Checked='<%#Convert.ToBoolean(Eval("Newevent"))%>' resourcekey="cbDocumentUploadResource1" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Edit article notification">
												<ItemTemplate>
													<asp:CheckBox ID="cbEditArticle" runat="server" Checked='<%#Convert.ToBoolean(Eval("EditArticle"))%>' resourcekey="cbDocumentUploadResource1" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Request for approve article">
												<ItemTemplate>
													<asp:CheckBox ID="cbApproveArticle" runat="server" Checked='<%#Convert.ToBoolean(Eval("ApproveArticle"))%>' resourcekey="cbDocumentDownloadResource1" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="New comment notification">
												<ItemTemplate>
													<asp:CheckBox ID="cbNewComment" runat="server" Checked='<%#Convert.ToBoolean(Eval("NewComment"))%>' resourcekey="cbAddEditCategoriesResource1" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Request for approve comment">
												<ItemTemplate>
													<asp:CheckBox ID="cbApproveComment" runat="server" Checked='<%#Convert.ToBoolean(Eval("ApproveComment"))%>' resourcekey="cbAllowToCommentResource1" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="">
												<ItemTemplate>
													<asp:LinkButton ID="lbUserNotificationsRemove" resourcekey="lbUserNotificationsRemove" runat="server" CausesValidation="False" CommandArgument='<%#Eval("UserID")%>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this user notifications?');" Text="Remove"></asp:LinkButton>
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
									</asp:GridView>
								</div>
							</div>
						</div>
					</div>
				</div>
				<asp:Label ID="lblAdduserMessage" runat="server" EnableViewState="False" ForeColor="Red" />
				<table class="permissions_table" style="margin-top: 10px;">
					<tr>
						<td class="subject">
							<asp:Label ID="lblUsernameToAdd" resourcekey="lblUsernameToAdd" runat="server" Text="Add user by username:" Font-Bold="True" />
						</td>
						<td style="width: 250px; text-align: left;">
							<asp:TextBox ID="tbUserNameToAdd" runat="server" />
							<asp:LinkButton ID="lbUsernameAdd" resourcekey="lbUsernameAdd" runat="server" OnClick="lbUsernameAdd_Click" Text="Add" />
						</td>
					</tr>
				</table>
			</div>
			<br />
			<br />
			<table class="settings_table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="left">
						<asp:CheckBox ID="cbArticleApproveConfirmation" runat="server" />
					</td>
					<td class="right">
						<dnn:Label ID="lblArticleApproveConfirmation" runat="server" Text="Send notification to author of article when article is approved or denied" ControlName="cbArticleApproveConfirmation" 
							HelpText="Send notification to author of article when article is approved or denied" HelpKey="lblArticleApproveConfirmation.HelpText" ResourceKey="lblArticleApproveConfirmation" />
					</td>
				</tr>
				<tr>
					<td class="left">
						<asp:CheckBox ID="cbCommentApproveConfirmation" runat="server" />
					</td>
					<td class="right">
						<dnn:Label ID="lblCommentApproveConfirmation" runat="server" Text="Send notification to author of comment when comment is approved or denied" ControlName="cbCommentApproveConfirmation" 
							HelpText="Send notification to author of comment when comment is approved or denied" HelpKey="lblCommentApproveConfirmation.HelpText" ResourceKey="lblCommentApproveConfirmation" />
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center">
						<asp:Label ID="lblsaveInfo" runat="server" EnableViewState="False" ForeColor="Red" />
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center">
						<asp:Button ID="btnSave" resourcekey="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" />
						<asp:Button ID="btnClose" resourcekey="btnClose" runat="server" OnClick="btnClose_Click" Text="Close" /><br />
					</td>
				</tr>
			</table>
			<br />
			<br />
		</div>
	</div>
</asp:Panel>
