<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.EditSettings, App_Web_editsettings.ascx.d988a5ac" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<script type="text/javascript">
//<![CDATA[
	function CategoryClientValidate(source, arguments) {
		var checkedCount = $('#advanced_tree_view_categor_selector').find('input[type="checkbox"]').filter(':checked').length;
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
			jQuery('#<%=pnlArticleSettingsTable.ClientID%>').show(0);
		}
	}
	function showWarnningEdit()
	{
	alert("You will be editing the default settings. This will affect all modules that use the default settings.");
	}

	if ('<%=ViewState["jQuery"]%>' == 'jQuery') {
		jQuery.noConflict();
	}

	var edn_all_categories = <%=GetAllCategoriesObject() %>;
	var edn_customize_add_edit = <%=getcustomize_add_edit() %>;

	var generate_category_list_items = function (selected_categories, items) {
		var all_categories = jQuery.extend(true, [], items),
			category_list = '',
			i = 0,
			selected;

		for (; i < all_categories.length; i++) {
			selected = selected_categories.indexOf(',' + all_categories[i].id + ',') != -1;
			category_list += '<li style="margin-left: ' + (all_categories[i].level * 15) + 'px"><label><input type="checkbox"' + (selected ? ' checked="checked"' : '') + ' name="edn_permission_for_category_' + all_categories[i].id + '" value="' + all_categories[i].id + '" /><span>' + all_categories[i].name + '</span></label></li>';
		}

		return category_list;
	}

	var generate_add_edit_list_items = function (selected_categories, items) {
		var all_categories = jQuery.extend(true, [], items),
			category_list = '',
			i = 0,
			selected_html,
			hide_checkbox = false;

		for (; i < all_categories.length; i++) {
			selected_html = '';

			if (all_categories[i].id == 'Title' || all_categories[i].id == 'Categories') {
				selected_html = ' checked="checked" disabled="disabled"';
			} else {
				if (selected_categories.indexOf(',' + all_categories[i].id + ',') != -1)
					selected_html = ' checked="checked"';
			}

			if (all_categories[i].id == 'DetailType' || all_categories[i].id == 'Gallery' || all_categories[i].id == 'AdvancedSettings')
				hide_checkbox = true;
			else
				hide_checkbox = false;

			category_list += '<li style="margin-left: ' + (all_categories[i].level * 15) + 'px;' + (hide_checkbox ? ' margin-top: 5px;' : '') + '"><label><input type="checkbox"' + selected_html + (hide_checkbox ? ' style="display: none;"' : '') + ' name="edn_permission_for_category_' + all_categories[i].id + '" value="' + all_categories[i].id + '" /><span>' + all_categories[i].name + '</span></label></li>';
		}

		return category_list;
	}

	jQuery().ready(function ($) {
		var $permissions_show_all_items = $('.permissions_show_all_items > input'),
			$permissions_show_manual_item_selection = $('.permissions_show_manual_item_selection > input'),
			$permissions_show_no_items = $('.permissions_show_no_items > input'),
			$edn_permission_selection_dialog = $('.permission_selection_dialog'),
			$permission_list_items = $edn_permission_selection_dialog.find('> ul'),
			$permissions_show_selection_dialog = $('a.permissions_show_selection_dialog'),
			$customize_add_edit_show_selection_dialog = $('a.customize_add_edit_show_selection_dialog');

		$edn_permission_selection_dialog
			.dialog({
				autoOpen: false,
				buttons: { 'Close': function () { $(this).dialog('close'); } },
				resizable: false,
				width: 'auto'
			});

		$permissions_show_all_items.change(function () {
			var $this = $(this),
				$parent = $this.parent(),
				$permissions_manual_item_selection = $this.parent().siblings('.permissions_manual_item_selection');

			$permissions_manual_item_selection
				.hide(200, function () {
					$('#EDNadmin .first_coll_fixed_table .second_table_viewport .settings_table tr')
						.each(function (i) {
							align_fixed_table_row($(this));
						});
				})
				.children('input[type="hidden"]').val('')
				.siblings('textarea').val('');

			$edn_permission_selection_dialog.dialog('close');

			if ($parent.hasClass('add_edit'))
				$('> a.customize_add_edit_show_selection_dialog', $parent.parent().siblings()).css('visibility', 'visible');
		});

		$permissions_show_manual_item_selection.change(function () {
			var $this = $(this),
				$parent = $this.parent(),
				$permissions_manual_item_selection = $parent.siblings('.permissions_manual_item_selection');

			$permissions_manual_item_selection.show(200, function () {
					$('#EDNadmin .first_coll_fixed_table .second_table_viewport .settings_table tr')
						.each(function (i) {
							align_fixed_table_row($(this));
						});
				});

			$edn_permission_selection_dialog.dialog('close');

			if ($parent.hasClass('add_edit'))
				$('> a.customize_add_edit_show_selection_dialog', $parent.parent().siblings()).css('visibility', 'hidden');
		});

		$permissions_show_no_items.change(function () {
			var $this = $(this),
				$parent = $this.parent(),
				$permissions_manual_item_selection = $parent.siblings('.permissions_manual_item_selection');

			$permissions_manual_item_selection.find('> input[type="hidden"]').val('');
			$permissions_manual_item_selection.find('> .selected_categories').html('');

			$permissions_manual_item_selection.hide(200, function () {
					$('#EDNadmin .first_coll_fixed_table .second_table_viewport .settings_table tr')
						.each(function (i) {
							align_fixed_table_row($(this));
						});
				});

			$edn_permission_selection_dialog.dialog('close');

			if ($parent.hasClass('add_edit'))
				$('> a.customize_add_edit_show_selection_dialog', $parent.parent().siblings()).css('visibility', 'hidden');
		});

		$permissions_show_selection_dialog.click(function () {
			var $clicked = $(this),
				$parent = $clicked.parent(),
				$selected_categories_field = $clicked.siblings('input[type="hidden"]'),
				$selected_categories_text = $parent.find('textarea.selected_categories'),
				$add_edit_field_selection_trigger;

			$add_edit_field_selection_trigger = $parent.hasClass('add_edit') ? $('> .customize_add_edit_show_selection_dialog', $parent.parent().siblings()) : $();

			$permission_list_items
				.html(generate_category_list_items($selected_categories_field.attr('value'), ($clicked.hasClass('custom_fields') ? edn_all_custom_fields : edn_all_categories)))
				.find('input[type="checkbox"]')
					.change(function () {
						var $selected_categories = $permission_list_items.find('input[type="checkbox"]:checked'),
							selected_ids = ',',
							selected_categories_names = '';

						if ($selected_categories.length) {
							$selected_categories.each(function () {
								var $this = $(this);

								selected_ids += $this.val() + ',';
								selected_categories_names += $this.siblings('span:first').html() + ', ';
							});
							$selected_categories_field.attr('value', selected_ids);
							$selected_categories_text.html(selected_categories_names.substring(0, selected_categories_names.length - 2));

							$add_edit_field_selection_trigger.css('visibility', 'visible');
						} else {
							$selected_categories_field.attr('value', '');
							$selected_categories_text.html('');

							$add_edit_field_selection_trigger.css('visibility', 'hidden');
						}
					});

			$edn_permission_selection_dialog
				.dialog('open');

			return false;
		});

		$customize_add_edit_show_selection_dialog.click(function () {
			var $clicked = $(this),
				$selected_categories_field = $clicked.siblings('input[type="hidden"]'),
				$selected_categories_text = $clicked.parent().find('textarea.selected_categories');

			$permission_list_items
				.html(generate_add_edit_list_items($selected_categories_field.attr('value'), edn_customize_add_edit))
				.find('input[type="checkbox"]')
					.change(function () {
						var $selected_categories = $permission_list_items.find('input[type="checkbox"]:checked'),
							selected_ids = ',',
							selected_categories_names = '';

						if ($selected_categories.length) {
							$selected_categories.each(function () {
								var $this = $(this);

								selected_ids += $this.val() + ',';
								selected_categories_names += $this.siblings('span:first').html() + ', ';
							});
							$selected_categories_field.attr('value', selected_ids);
							$selected_categories_text.html(selected_categories_names.substring(0, selected_categories_names.length - 2));
						} else {
							$selected_categories_field.attr('value', '');
							$selected_categories_text.html('');
						}
					});

			$edn_permission_selection_dialog
				.dialog('open');

			return false;
		});
	jQuery(function ($) {

		$('#advanced_tree_view_categor_selector').EDS_TreeViewSelector({
			state_checkbox: $('#<%=cbAutoAddCatChilds.ClientID %>')
		});

	});

		$('#<%=upArticleTags.ClientID %>')
			.delegate('#<%=dlListOfExistingTags.ClientID %> a.tag_link', 'click', function () {
				var $this = $(this),
					tag_id = $this.data('edsTagId') || $this.data('eds-tag-id'),
					$filterContentByTagsWrapper = $('#filterContentByTagsWrapper'),
					$hfSelectedTags = $('#<%=hfSelectedTags.ClientID %>'),
					id_list = $hfSelectedTags.val();

				$('#<%=filterContentByTagsNoTagsMsg.ClientID %>').css('display', 'none');

				if (id_list.indexOf(',' + tag_id + ',') === -1) {
					$('> ul', $filterContentByTagsWrapper).append('<li data-eds-tag-id="' + tag_id + '" class="tag-' + tag_id + '">' + $this.text() + '<span>Delete</span></li>');

					if (id_list == '')
						id_list = ',' + tag_id + ',';
					else
						id_list += tag_id + ',';

					$hfSelectedTags.val(id_list);
				}

				return false;
			})
			.delegate('#<%=dlListOfExistingTags.ClientID %> a.tag_link', 'mouseenter mouseleave', function (e) {
				var $this = $(this),
					$target = $('#filterContentByTagsWrapper li.tag-' + ($this.data('edsTagId') || $this.data('eds-tag-id')));

				if (e.type == 'mouseenter')
					$target.addClass('already_present');
				else
					$target.removeClass('already_present');
			});

		$('#filterContentByTagsWrapper').delegate('li > span', 'click', function () {
			var $li = $(this).parent(),
				$hfSelectedTags = $('#<%=hfSelectedTags.ClientID %>'),
				id_list = $hfSelectedTags.val();

			id_list = id_list.replace(',' + ($li.data('edsTagId') || $li.data('eds-tag-id')) + ',', ',');
			if (id_list == ',') {
				id_list = '';
				$('#<%=filterContentByTagsNoTagsMsg.ClientID %>').css('display', 'block');
			}

			$hfSelectedTags.val(id_list);
			$li.remove();
		});



		$('#<%=upFilterPerArticle.ClientID %>')
			.delegate('#<%=dlFilterPerArticle.ClientID %> a.articleid_link', 'click', function () {
				var $this = $(this),
					article_id = $this.data('edsArticleId') || $this.data('eds-article-id'),
					$filterContentByArticlesWrapper = $('#filterContentByArticlesWrapper'),
					$hfSelectedArticles = $('#<%=hfSelectedArticles.ClientID %>'),
					id_list = $hfSelectedArticles.val();

				$('#<%=filterContentByArticlesNoTagsMsg.ClientID %>').css('display', 'none');

				if (id_list.indexOf(',' + article_id + ',') === -1) {
					$('> ul', $filterContentByArticlesWrapper).append('<li data-eds-article-id="' + article_id + '" class="article-' + article_id + '">' + $this.text() + '<span>Delete</span></li>');

					if (id_list == '')
						id_list = ',' + article_id + ',';
					else
						id_list += article_id + ',';

					$hfSelectedArticles.val(id_list);
				}

				return false;
			})
			.delegate('#<%=dlFilterPerArticle.ClientID %> a.articleid_link', 'mouseenter mouseleave', function (e) {
				var $this = $(this),
					$target = $('#filterContentByArticlesWrapper li.article-' + ($this.data('edsArticleId') || $this.data('eds-article-id')));

				if (e.type == 'mouseenter')
					$target.addClass('already_present');
				else
					$target.removeClass('already_present');
			})
			.delegate('#filterContentByArticlesWrapper li > span', 'click', function () {
				var $li = $(this).parent(),
					$hfSelectedArticles = $('#<%=hfSelectedArticles.ClientID %>'),
					id_list = $hfSelectedArticles.val();

				id_list = id_list.replace(',' + ($li.data('edsArticleId') || $li.data('eds-article-id')) + ',', ',');
				if (id_list == ',') {
					id_list = '';
					$('#<%=filterContentByArticlesNoTagsMsg.ClientID %>').css('display', 'block');
				}

				$hfSelectedArticles.val(id_list);
				$li.remove();
			});
	});


//]]>
</script>
<div id="EDNadmin">
	<asp:Panel ID="pnlUseGeneralSettingsAll" runat="server" Visible="False">
		<asp:Label ID="lblUseGeneralSettingsAll" runat="server" Text="You are using general settings." resourcekey="lblUseGeneralSettingsAllResource1" />
	</asp:Panel>
	<asp:Panel ID="pnlAllSettings" class="module_settings" runat="server">
		<h1>
			<%=NewsSettings%></h1>
		<div class="settings_source_selection">
			<asp:Label ID="lblSettingSitle" runat="server" Text="This module instance is using:" Font-Bold="True" />&nbsp;
			<asp:RadioButtonList ID="rblSettingsMode" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblSettingsMode_SelectedIndexChanged" RepeatDirection="Horizontal">
				<asp:ListItem Value="Module" Selected="True" resourcekey="ListItemResource1">Custom settings (instance)</asp:ListItem>
				<asp:ListItem Value="Portal" resourcekey="ListItemResource2">Default setings (portal)</asp:ListItem>
			</asp:RadioButtonList>
			<asp:LinkButton ID="lbEnableEditPortalSettings" runat="server" OnClientClick="showWarnningEdit();" Visible="False" CssClass="enable_global_editing" OnClick="lbEnableEditPortalSettings_Click" resourcekey="lbEnableEditPortalSettingsResource1">Enable default settings editing</asp:LinkButton>
			<p class="expand_collapse_buttons">
				<a href="#" class="expand">
					<%=Expandall%></a> | <a href="#" class="collapse">
						<%=Collapseall%></a></p>
		</div>
		<asp:Panel ID="pnlPortalSharing" runat="server">
			<div class="settings_crossportal_selection">
				<asp:Label ID="lblPortalSharing" resourcekey="lblPortalSharing" runat="server" Text="Select portal:" Font-Bold="True"></asp:Label>
				<asp:DropDownList ID="ddlPortalSharing" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataTextField="PortalName" DataValueField="PortalIDFrom" CssClass="ddlcategorysettings" Style="margin-right: 15px;" OnSelectedIndexChanged="ddlPortalSharing_SelectedIndexChanged">
					<asp:ListItem resourcekey="liCurrentPortal" Value="-1">Current portal</asp:ListItem>
				</asp:DropDownList>
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlPermissions" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfPermissionsState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblPermisionsSource" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblPermisionsSource_SelectedIndexChanged">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource3">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource4">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					1</p>
				<h2>
					<%=Permissions%></h2>
			</div>
			<div class="category_content">
				<div class="permission_selection_dialog" title="Select items">
					<ul>
					</ul>
				</div>
				<h3 class="subsections">
					<%=Rolepermissions%></h3>
				<div class="first_coll_fixed_table">
					<asp:GridView ID="gvRolePremissionsLabels" runat="server" CssClass="settings_table fixed_table permissions" AutoGenerateColumns="False" DataKeyNames="PremissionSettingsID" CellPadding="0" >
						<AlternatingRowStyle CssClass="second" />
						<Columns>
							<asp:TemplateField HeaderText="Role">
								<ItemTemplate>
									<p>
										<asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("RoleName") %>' />
									</p>
								</ItemTemplate>
								<HeaderStyle CssClass="header_cell" />
							</asp:TemplateField>
						</Columns>
					</asp:GridView>
					<div class="second_table_viewport">
						<asp:GridView ID="gvRolePremissions" runat="server" CssClass="settings_table permissions" AutoGenerateColumns="False" DataKeyNames="PremissionSettingsID" CellPadding="0" OnRowDataBound="gvPremissions_RowDataBound">
							<AlternatingRowStyle CssClass="second" />
							<Columns>
								<asp:TemplateField HeaderText="Role">
									<ItemTemplate>
										<asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("RoleName") %>' />
									</ItemTemplate>
									<HeaderStyle CssClass="hidden_coll" />
									<ItemStyle CssClass="hidden_coll" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Approve articles">
									<ItemTemplate>
										<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# Eval("RoleID") %>' />
										<asp:HiddenField ID="hfPremissionID" runat="server" Value='<%# Eval("PremissionSettingsID") %>' />
										<asp:CheckBox ID="cbApproveArticles" runat="server" Checked='<%#IsportalSharingCheck(Eval("RoleID"), Eval("ApproveArticles"))%>' Enabled="<%#!PortalSharingIsSelected%>" />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Document download">
									<ItemTemplate>
										<asp:CheckBox ID="cbDocumentDownload" runat="server" Checked='<%# Convert.ToBoolean(Eval("DocumentDownload")) %>' />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Add Edit Categories">
									<ItemTemplate>
										<asp:CheckBox ID="cbAddEditCategories" runat="server" Checked='<%#IsportalSharingCheck(Eval("RoleID"),Eval("AddEditCategories")) %>' Enabled="<%#!PortalSharingIsSelected%>" />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Allow To Comment">
									<ItemTemplate>
										<asp:CheckBox ID="cbAllowToComment" runat="server" Checked='<%# Convert.ToBoolean(Eval("AllowToComment")) %>' />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Approve Comments">
									<ItemTemplate>
										<asp:CheckBox ID="cbApproveComments" runat="server" Checked='<%#IsportalSharingCheck(Eval("RoleID"), Eval("ApproveComments")) %>' Enabled="<%#!PortalSharingIsSelected%>" />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="View Paid Content">
									<ItemTemplate>
										<asp:CheckBox ID="cbViewPaidContent" runat="server" Checked='<%# Convert.ToBoolean(Eval("ViewPaidContent")) %>' />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Custom add/edit">
									<ItemTemplate>
										<asp:LinkButton ID="lbCustomizeAddEdit" resourcekey="lbCustomizeAddEdit" runat="server" CssClass="customize_add_edit_show_selection_dialog" Text="Select fields" Visible="<%#showElementPortalSharing%>" />
										<asp:HiddenField ID="hfCustomizeAddEdit" runat="server" Value='<%#Eval("Customized")%>' />
										<asp:Panel runat="server" ID="pnlAddToCatsManualSelectionCopy" CssClass="permissions_manual_item_selection" Style="display: none">
											<asp:TextBox ID="tbxCustomizeAddEdit" runat="server" Columns="50" CssClass="selected_categories" ReadOnly="True" TextMode="MultiLine" />
										</asp:Panel>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Social autoposting" Visible="false">
									<ItemTemplate>
										<asp:CheckBox ID="cbRoleSocialSharing" runat="server" Checked='<%# Convert.ToBoolean(Eval("PostToSocialNetwork")) %>' Enabled="<%#!PortalSharingIsSelected%>" />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Enable add/edit articles to selected categories">
									<ItemTemplate>
										<asp:RadioButton ID="rbRolleAddtoAllCategories" runat="server" Checked='<%# Convert.ToBoolean(Eval("AddArticleToAll")) %>' CssClass="permissions_show_all_items add_edit" GroupName="roleAddToCategoryPermissions" Text="All categories" resourcekey="rbRolleAddtoAllCategoriesResource1" />
										<asp:RadioButton ID="rbRolleAddtoManualCategories" runat="server" Checked='<%# !Convert.ToBoolean(Eval("AddArticleToAll")) %>' CssClass="permissions_show_manual_item_selection add_edit" GroupName="roleAddToCategoryPermissions" Text="Select categories"
											resourcekey="rbRolleAddtoManualCategoriesResource1" />
										<asp:RadioButton ID="rbRoleNoneAdd" runat="server" Checked='<%# !Convert.ToBoolean(Eval("AddArticleToAll")) %>' CssClass="permissions_show_no_items add_edit" GroupName="roleAddToCategoryPermissions" Text="None" resourcekey="rbRoleNoneAddResource1" />
										<asp:Panel runat="server" ID="pnlAddToCatsManualSelection" CssClass="permissions_manual_item_selection add_edit" Style="display: none">
											<asp:HiddenField ID="hfRolesCategoriesToAdd" runat="server" />
											<asp:LinkButton ID="lbRoleManualySelectCategoriesToAdd" runat="server" CssClass="permissions_show_selection_dialog" Text="Select categories" resourcekey="lbRoleManualySelectCategoriesToAddResource1" Visible="<%#showElementPortalSharing%>" />
											<asp:TextBox ID="tbRolesCatsToADD" runat="server" Columns="50" CssClass="selected_categories" TextMode="MultiLine" onkeypress="javascript:return false;" />
										</asp:Panel>
									</ItemTemplate>
									<HeaderStyle HorizontalAlign="Center" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Select categories to view articles from">
									<ItemTemplate>
										<asp:RadioButton ID="rbAllCategories" runat="server" Checked='<%# Convert.ToBoolean(Eval("ShowAllCategories")) %>' CssClass="permissions_show_all_items" GroupName="roleCategoryPermissions" Text="All categories" resourcekey="rbAllCategoriesResource1" />
										<asp:RadioButton ID="rbManualCategories" runat="server" Checked='<%# !Convert.ToBoolean(Eval("ShowAllCategories")) %>' CssClass="permissions_show_manual_item_selection" GroupName="roleCategoryPermissions" Text="Select categories" resourcekey="rbManualCategoriesResource1" />
										<asp:RadioButton ID="rbRoleNoneShow" runat="server" Checked='<%# !Convert.ToBoolean(Eval("ShowAllCategories")) %>' CssClass="permissions_show_no_items" GroupName="roleCategoryPermissions" Text="None" resourcekey="rbRoleNoneShowResource1" />
										<asp:Panel runat="server" ID="pnlShowCatsManualSelection" CssClass="permissions_manual_item_selection" Style="display: none">
											<asp:HiddenField ID="hfCategoriesToShow" runat="server" />
											<asp:LinkButton ID="lbManualySelectCategories" runat="server" CssClass="permissions_show_selection_dialog" Text="Select categories" resourcekey="lbManualySelectCategoriesResource1" Visible="<%#showElement%>" />
											<asp:TextBox ID="tbRolesCatsToShow" runat="server" Columns="50" CssClass="selected_categories" TextMode="MultiLine" resourcekey="tbRolesCatsToShowResource1" onkeypress="javascript:return false;" />
										</asp:Panel>
									</ItemTemplate>
									<ItemStyle HorizontalAlign="Center" />
								</asp:TemplateField>
							</Columns>
						</asp:GridView>
					</div>
				</div>
				<h3 class="subsections">
					<%=Userpermissions%></h3>
				<div class="first_coll_fixed_table">
					<asp:GridView ID="gvUserPremissionsLabels" runat="server" CellPadding="0" AutoGenerateColumns="False" DataKeyNames="PremissionSettingsID" CssClass="settings_table fixed_table permissions" OnRowDeleting="gvUserPremissionsLabels_RowDeleting">
						<Columns>
							<asp:TemplateField HeaderText="User">
								<ItemTemplate>
									<p>
										<asp:Label ID="lblUserName" runat="server" Text='<%# Eval("DisplayName") %>' /><br />
										<asp:LinkButton ID="lbUserPremissionDelete" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this user permissions?');" Text="Delete" resourcekey="lbUserPremissionDeleteResource1"></asp:LinkButton>
									</p>
								</ItemTemplate>
								<HeaderStyle CssClass="header_cell" />
							</asp:TemplateField>
						</Columns>
					</asp:GridView>
					<div class="second_table_viewport">
						<asp:GridView ID="gvUserPremissions" runat="server" CssClass="settings_table permissions" AutoGenerateColumns="False" DataKeyNames="PremissionSettingsID" CellPadding="0" OnRowDataBound="gvUserPremissions_RowDataBound" OnRowDeleting="gvUserPremissions_RowDeleting">
							<AlternatingRowStyle CssClass="second" />
							<Columns>
								<asp:TemplateField HeaderText="User">
									<ItemTemplate>
										<asp:Label ID="lblUserName" runat="server" Text='<%# Eval("DisplayName") %>' />
									</ItemTemplate>
									<HeaderStyle CssClass="hidden_coll" />
									<ItemStyle CssClass="hidden_coll" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Approve articles">
									<ItemTemplate>
										<asp:HiddenField ID="hfPremissionID" runat="server" Value='<%# Eval("PremissionSettingsID") %>' />
										<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
										<asp:CheckBox ID="cbUserApproveArticles" runat="server" Checked='<%# UserCheckPortalSharing(Eval("ApproveArticles")) %>' Enabled="<%#!PortalSharingIsSelected%>" />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Document download">
									<ItemTemplate>
										<asp:CheckBox ID="cbUserDocumentDownload" runat="server" Checked='<%# Eval("DocumentDownload") %>' />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Add Edit Categories">
									<ItemTemplate>
										<asp:CheckBox ID="cbUserAddEditCategories" runat="server" Checked='<%# UserCheckPortalSharing(Eval("AddEditCategories")) %>' Enabled="<%#!PortalSharingIsSelected%>" />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Allow To Comment">
									<ItemTemplate>
										<asp:CheckBox ID="cbUserAllowToComment" runat="server" Checked='<%# Eval("AllowToComment") %>' />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Approve Comments">
									<ItemTemplate>
										<asp:CheckBox ID="cbUserApproveComments" runat="server" Checked='<%#UserCheckPortalSharing(Eval("ApproveComments"))%>' Enabled="<%#!PortalSharingIsSelected%>" />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="View Paid Content">
									<ItemTemplate>
										<asp:CheckBox ID="cbUserViewPaidContent" runat="server" Checked='<%# Eval("ViewPaidContent") %>' />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Custom add/edit">
									<ItemTemplate>
										<asp:LinkButton ID="lbCustomizeAddEdit" runat="server" resourcekey="lbCustomizeAddEdit" CssClass="customize_add_edit_show_selection_dialog" Text="Select fields" Visible="<%#showElementPortalSharing%>" />
										<asp:HiddenField ID="hfCustomizeAddEdit" runat="server" Value='<%#Eval("Customized")%>' />
										<asp:Panel runat="server" ID="pnlAddToCatsManualSelectionCopy" CssClass="permissions_manual_item_selection" Style="display: none">
											<asp:TextBox ID="tbxCustomizeAddEdit" runat="server" Columns="50" CssClass="selected_categories" ReadOnly="True" TextMode="MultiLine" />
										</asp:Panel>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Enable add/edit articles to selected categories">
									<ItemTemplate>
										<asp:RadioButton ID="rbUserAddToAllCategories" runat="server" Checked='<%# Eval("AddArticleToAll") %>' CssClass="permissions_show_all_items add_edit" GroupName="userAddToCategoryPermissions" Text="All categories" resourcekey="rbUserAddToAllCategoriesResource1" />
										<asp:RadioButton ID="rbUserAddToManualCategories" runat="server" Checked='<%# !Convert.ToBoolean(Eval("AddArticleToAll")) %>' CssClass="permissions_show_manual_item_selection add_edit" GroupName="userAddToCategoryPermissions" Text="Select categories"
											resourcekey="rbUserAddToManualCategoriesResource1" />
										<asp:RadioButton ID="rblUserNoneAdd" runat="server" Checked='<%# !Convert.ToBoolean(Eval("AddArticleToAll")) %>' CssClass="permissions_show_no_items add_edit" GroupName="userAddToCategoryPermissions" Text="None" resourcekey="rblUserNoneAddResource1" />
										<asp:Panel runat="server" ID="pnlUserAddToCatsManualSelection" CssClass="permissions_manual_item_selection add_edit" Style="display: none">
											<asp:HiddenField ID="hfUserCategoriesToAdd" runat="server" />
											<asp:LinkButton ID="lbManualySelectCategories0" runat="server" CssClass="permissions_show_selection_dialog" Text="Select categories" resourcekey="lbManualySelectCategories0Resource1" Visible="<%#showElementPortalSharing%>" />
											<asp:TextBox ID="tbUserCatsToAdd" runat="server" Columns="50" CssClass="selected_categories" TextMode="MultiLine" resourcekey="tbUserCatsToAddResource1" onkeypress="javascript:return false;" />
										</asp:Panel>
									</ItemTemplate>
									<HeaderStyle HorizontalAlign="Center" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Select categories to view articles from">
									<ItemTemplate>
										<asp:RadioButton ID="rbUserAllCategories" runat="server" Checked='<%# Eval("ShowAllCategories") %>' CssClass="permissions_show_all_items" GroupName="userCategoryPermissions" Text="All categories" resourcekey="rbUserAllCategoriesResource1" />
										<asp:RadioButton ID="rbUserManualCategories" runat="server" Checked='<%# !Convert.ToBoolean(Eval("ShowAllCategories")) %>' CssClass="permissions_show_manual_item_selection" GroupName="userCategoryPermissions" Text="Select categories" resourcekey="rbUserManualCategoriesResource1" />
										<asp:RadioButton ID="rbUserNoneShow" runat="server" Checked='<%# !Convert.ToBoolean(Eval("ShowAllCategories")) %>' CssClass="permissions_show_no_items" GroupName="userCategoryPermissions" Text="None" resourcekey="rbUserNoneShowResource1" />
										<asp:Panel runat="server" ID="pnlUserShowCatsManualSelection" CssClass="permissions_manual_item_selection" Style="display: none">
											<asp:HiddenField ID="hfUserCategoriesToShow" runat="server" />
											<asp:LinkButton ID="lbUserManualySelectCategories" runat="server" CssClass="permissions_show_selection_dialog" Text="Select categories" resourcekey="lbUserManualySelectCategoriesResource1" Visible="<%#showElement%>" />
											<asp:TextBox ID="tbUserCatsToShow" runat="server" Columns="50" CssClass="selected_categories" TextMode="MultiLine" resourcekey="tbUserCatsToShowResource1" onkeypress="javascript:return false;" />
										</asp:Panel>
									</ItemTemplate>
									<HeaderStyle HorizontalAlign="Center" />
								</asp:TemplateField>
								<asp:TemplateField ShowHeader="False" Visible="false">
									<ItemTemplate>
										<asp:LinkButton ID="lbUserPremissionDelete" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this user permissions?');" Text="Delete" resourcekey="lbUserPremissionDeleteResource1"></asp:LinkButton>
									</ItemTemplate>
								</asp:TemplateField>
							</Columns>
						</asp:GridView>
					</div>
				</div>
				<p style="margin: 10px 0 0">
					<asp:Label ID="lblUsernameToAdd" runat="server" Text="Add user by username:" resourcekey="lblUsernameToAddResource1" />
					<asp:TextBox ID="tbUserNameToAdd" runat="server" Width="237px" />
					<asp:LinkButton ID="lbUsernameAdd" runat="server" OnClick="lbUsernameAdd_Click" Text="Add" resourcekey="lbUsernameAddResource1" />
				</p>
				<asp:Label ID="lblAdduserMessage" runat="server" resourcekey="lblAdduserMessageResource1" />
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlMainDisplaySettigs" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfMainDisplaySettigsState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblMainDisplaySettingsSource" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblMainDisplaySettingsSource_SelectedIndexChanged">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource5">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource6">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					2</p>
				<h2>
					<%=Maindisplay%></h2>
			</div>
			<asp:Panel ID="pnlMainDisplaySettigsTable" runat="server" CssClass="category_content">
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblSelectArticleView" runat="server" Text="Select article display view:" HelpText="Select article display view:" HelpKey="lblSelectArticleView.HelpText" ResourceKey="lblSelectArticleView" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlSelectArticleDisplayView" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSelectArticleDisplayView_SelectedIndexChanged">
								<asp:ListItem Value="ViewEasyDNNNews.ascx" resourcekey="ListItemResource7">Article</asp:ListItem>
								<asp:ListItem Value="ViewEasyDNNNewsCatalog.ascx" resourcekey="ListItemResource8">Catalog</asp:ListItem>
							</asp:DropDownList>
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblNumberOfPosts" runat="server" Text="Number of posts per page:" HelpText="Number of posts per page:" HelpKey="lblNumberOfPosts.HelpText" ResourceKey="lblNumberOfPosts" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbNumberOfPosts" runat="server" Width="70px" Text="5" />
							<asp:RequiredFieldValidator ID="rfvNumberOfPosts" runat="server" ControlToValidate="tbNumberOfPosts" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvNumberOfPostsResource1.ErrorMessage" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblRenderAsTable" runat="server" Text="Display layout as HTML table:" HelpText="Display article layout as HTML table:" HelpKey="lblRenderAsTable.HelpText" ResourceKey="lblRenderAsTable" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbDispalayAsTable" Checked="false" runat="server" AutoPostBack="True" OnCheckedChanged="cbDispalayAsTable_CheckedChanged" />
							<div id="divDisplayTableProperties" runat="server" style="display: none">
								<label for="DisplayTableProperties" runat="server" id="lblDisplayTableProperties">
									<%=Columnproperties %></label>
								<p>
									<label for="tbNumberOfPostColumns" runat="server" id="lblNumberColumnsInTable" resourcekey="lblNumberOfPostColumns">
										<%=Numofcolumns%></label>
									<asp:TextBox ID="tbNumberOfPostColumns" runat="server" Width="70px" Text="1" />
									<label for="tbxColumnWidth" runat="server" id="lblColumnWidth">
										<%=Columnwidth%></label>
									<asp:TextBox ID="tbxColumnWidth" runat="server" Width="70px" Text="250" />
									<asp:RequiredFieldValidator ID="rfvNumberOfPostColumns" runat="server" ControlToValidate="tbNumberOfPostColumns" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvNumberOfPostColumnsResource1.ErrorMessage" Enabled="false" />
									<asp:RequiredFieldValidator ID="rfvColumnWidth" runat="server" ControlToValidate="tbxColumnWidth" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvNumberOfPostColumnsResource1.ErrorMessage" Enabled="false" />
								</p>
							</div>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblNumberOfPostsToDisplay" runat="server" Text="Total number of posts to display:" HelpText="Total number of posts to display (0-display all posts):" HelpKey="lblNumberOfPostsToDisplay.HelpText" ResourceKey="lblNumberOfPostsToDisplay" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbTotalNumberOfPosts" runat="server" Width="70px" Text="0" />
							<asp:RequiredFieldValidator ID="rfvNumberOfPostColumns0" runat="server" ControlToValidate="tbNumberOfPostColumns" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvNumberOfPostColumns0Resource1.ErrorMessage" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblNumberOfPager" runat="server" Text="Number of pager links:" HelpText="Number of pager links:" HelpKey="lblNumberOfPager.HelpText" ResourceKey="lblNumberOfPager" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbNumberOfPagerLinks" runat="server" Width="70px" ValidationGroup="vgSettings">10</asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvNumberOfPostColumns1" runat="server" ControlToValidate="tbNumberOfPagerLinks" ErrorMessage="This filed is required." ValidationGroup="vgSettings" Display="Dynamic" resourcekey="rfvNumberOfPostColumns1Resource1.ErrorMessage" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblShowArticlePaging" runat="server" Text="Show article paging:" HelpText="Show article paging:" HelpKey="lblShowArticlePaging.HelpText" ResourceKey="lblShowArticlePaging" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbShowPaging" runat="server" Checked="True" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblOpenInAnotherModule" runat="server" Text="Open details in another module instance:" HelpText="Open details in another module instance:" HelpKey="lblOpenInAnotherModule.HelpText" ResourceKey="lblOpenInAnotherModule" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlOpenDetails" runat="server">
								<asp:ListItem Value="0" resourcekey="ListItemResource9">Current module instance</asp:ListItem>
							</asp:DropDownList>
						</td>
					</tr>
				</table>
				<asp:Panel ID="pnlLocalization" runat="server" Visible="false">
					<h3 class="subsections">
						<%=LocalizationText %></h3>
					<table class="settings_table" cellpadding="0" cellspacing="0">
						<tr>
							<td class="left">
								<dnn:Label ID="lblHideUnlocalizedItems" runat="server" Text="Don't show unlocalized items:" HelpText="Articles, events that are unlocalized won't show when localization selected." HelpKey="lblHideUnlocalizedItems.HelpText" ResourceKey="lblHideUnlocalizedItems" />
							</td>
							<td class="right">
								<asp:CheckBox ID="cbHideUnlocalizedItems" runat="server" />
							</td>
						</tr>
					</table>
				</asp:Panel>
				<h3 class="subsections">
					<%=Modulecontainer%></h3>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblDynamicModuleConatinerTitle" runat="server" Text="Dynamically create module container title:" HelpText="Dynamically create module container title based on the content. For example if module is listing articles from selected category module container title will be that category name."
								HelpKey="lblDynamicModuleConatinerTitle.HelpText" ResourceKey="lblDynamicModuleConatinerTitle" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbDynamicModuleConatinerTitle" runat="server" />
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlAdvancedArticleSettings" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfAdvancedArticleSettingsState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblAdvancedArticleSettingsSource" runat="server" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblAdvancedArticleSettingsSource_SelectedIndexChanged" RepeatDirection="Horizontal">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource10">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource11">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					3</p>
				<h2>
					<%=Multimodulearticledisplay%></h2>
			</div>
			<asp:Panel ID="pnlAdvancedArticleSettingsSourceTable" runat="server" CssClass="category_content">
				<table cellpadding="0" cellspacing="0" class="settings_table">
					<tr>
						<td class="left">
							<dnn:Label ID="lblNumberOfPostsToDisplayLab" runat="server" HelpText="Number of starting article:" Text="Number of starting article:" HelpKey="lblNumberOfPostsToDisplayLab.HelpText" ResourceKey="lblNumberOfPostsToDisplayLab" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbStartingArticleNumber" runat="server" Text="1" Width="70px" />
							<asp:RequiredFieldValidator ID="rfvNumberOfPostColumns2" runat="server" ControlToValidate="tbNumberOfPostColumns" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvNumberOfPostColumns2Resource1" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblGlobalQuery" runat="server" HelpText="This module receives global query string that may be set in another article." Text="Receive global query string:" HelpKey="lblGlobalQuery.HelpText" ResourceKey="lblGlobalQuery" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbAllModules" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblOpenInaPage" runat="server" HelpText="Open category, subcategory and tag links in a new page." Text="Open article links in another page." HelpKey="lblOpenInaPage.HelpText" ResourceKey="lblOpenInaPage" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlOpenDetailsPage" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblPassCategoryID" runat="server" HelpText="If received pass CategoryID query string value." Text="Pass CategoryID query string:" HelpKey="lblPassCategoryID.HelpText" ResourceKey="lblPassCategoryID" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbPassCategoryID" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblOpenCategoryFirstArticle" runat="server" HelpText="Open category first article if CategoryID query string exists." Text="Open category first article:" HelpKey="lblOpenCategoryFirstArticle.HelpText" ResourceKey="lblOpenCategoryFirstArticle" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbOpenCategoryFirstArticle" runat="server" AutoPostBack="True" OnCheckedChanged="cbOpenCategoryFirstArticle_CheckedChanged" />
						</td>
					</tr>
					<tr id="trOpenCategoryFirstArticleIfMorethanOne" runat="server" visible="False">
						<td class="left" runat="server">
							<dnn:Label ID="lblOpenFirstKatMOreThanOne" runat="server" HelpText="Open category first article if there is only one article in the category." Text="Open category first article if there is only one article:" HelpKey="lblOpenFirstKatMOreThanOne.HelpText"
								ResourceKey="lblOpenFirstKatMOreThanOne.Text" />
						</td>
						<td class="right" runat="server">
							<asp:CheckBox ID="cbOpenCategoryFirstArticleIfMorethanOne" runat="server" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblOpenFirstArticleByDate" runat="server" HelpText="Open first article by date if ArtDate query string exists." Text="Open first article by date:" HelpKey="lblOpenFirstArticleByDate.HelpText" ResourceKey="lblOpenFirstArticleByDate" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbOpenFirstArticleByDate" runat="server" AutoPostBack="True" OnCheckedChanged="cbOpenFirstArticleByDate_CheckedChanged" resourcekey="cbOpenFirstArticleByDateResource1" />
						</td>
					</tr>
					<tr id="trOpenFirstArticleByDateIfMorethanOne" runat="server" visible="False" class="second">
						<td class="left" runat="server">
							<dnn:Label ID="lblOpenFirstByDateMorethanone" runat="server" HelpText="Open first article by date if there is only one article." Text="Open first article by date if there is only one article:" HelpKey="lblOpenFirstByDateMorethanone.HelpText" ResourceKey="lblOpenFirstByDateMorethanone" />
						</td>
						<td class="right" runat="server">
							<asp:CheckBox ID="cbOpenFirstArticleByDateIfMorethanOne" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblOpenFirstArticle" runat="server" HelpText="Open first article:" Text="Open first article:" HelpKey="lblOpenFirstArticle.HelpText" ResourceKey="lblOpenFirstArticle" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbOpenFirstArticle" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblUserIDInLink" runat="server" HelpText="This will show userid of the article author as query string in article link." Text="Show userid querystring in article link:" HelpKey="UserIDInLink.HelpText" ResourceKey="UserIDInLink" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbUserIDInLink" runat="server" />
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlArticleSettings" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfArticleSettingsState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblArticleSettingsSource" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblArticleSettingsSource_SelectedIndexChanged">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource12">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource13">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					4</p>
				<h2>
					<%=Categoryandauthorselection%></h2>
			</div>
			<asp:Panel ID="pnlArticleSettingsTable" runat="server" CssClass="category_content">
				<table class="settings_table" cellpadding="0" cellspacing="0" runat="server">
					<tr>
						<td class="left">
						</td>
						<td class="right">
							<asp:RadioButtonList ID="rblFilterArticlesBy" runat="server" Style="float: left" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblFilterArticlesBy_SelectedIndexChanged" AutoPostBack="true">
								<asp:ListItem resourcekey="liApplyFilters" Selected="True" Value="False" Text="Apply filters" />
								<asp:ListItem resourcekey="liSelectSpecific" Value="True" Text="Select specific article(s)" />
							</asp:RadioButtonList>
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblPostOrder" runat="server" Text="Order articles by:" HelpText="Order articles by:" HelpKey="lblPostOrder.HelpText" ResourceKey="lblPostOrder" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlOrderPostsBy" runat="server">
								<asp:ListItem Selected="True" Value="PublishDate" resourcekey="ListItemResource14">Publish date</asp:ListItem>
								<asp:ListItem Value="NumberOfViews" resourcekey="ListItemResource15">Number of views</asp:ListItem>
								<asp:ListItem Value="RatingValue" resourcekey="ListItemResource16">Rating</asp:ListItem>
								<asp:ListItem Value="DateAdded" resourcekey="ListItemResource17">Date added</asp:ListItem>
								<asp:ListItem Value="ExpireDate" resourcekey="ListItemResource18">Expire date</asp:ListItem>
								<asp:ListItem Value="LastModified" resourcekey="ListItemResource19">Last modified</asp:ListItem>
								<asp:ListItem Value="NumberOfComments" resourcekey="ListItemResource20">Number of comments</asp:ListItem>
								<asp:ListItem resourcekey="ListItemResource21">Title</asp:ListItem>
							</asp:DropDownList>
							&nbsp;
							<asp:DropDownList ID="ddlAscOrder" runat="server">
								<asp:ListItem Value="DESC" resourcekey="ListItemResource22">Descending</asp:ListItem>
								<asp:ListItem Value="ASC" resourcekey="ListItemResource23">Ascending</asp:ListItem>
							</asp:DropDownList>
						</td>
					</tr>
				</table>
				<asp:UpdatePanel ID="upFilterPerArticle" runat="server" UpdateMode="Conditional">
					<ContentTemplate>
						<table class="settings_table" cellpadding="0" cellspacing="0" runat="server" id="tblPerArticleFilter" visible="false">
							<tr>
								<td class="left">
									<dnn:Label ID="lblCategoryIDForFilterByArticle" runat="server" Text="Select category:" HelpText="Selected category will filter articles list in grid view." ResourceKey="lblCategoryIDForFilterByArticle" HelpKey="lblCategoryIDForFilterByArticle.HelpText" />
								</td>
								<td class="right">
									<asp:DropDownList ID="ddlCategoryIDListFilterByArticle" runat="server" OnSelectedIndexChanged="ddlCategoryIDListFilterByArticle_SelectedIndexChanged" AutoPostBack="true" />
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div runat="server" id="divFilterByArticles" class="collapsible_box no_margin visible tag_collection">
										<div class="content">
											<asp:DataList ID="dlFilterPerArticle" runat="server" RepeatColumns="5" DataKeyField="ArticleID" RepeatDirection="Vertical" RepeatLayout="Flow" CssClass="existing_article_list">
												<ItemTemplate>
													<a class="articleid_link" href="#" data-eds-article-id='<%#Eval("ArticleID")%>'>
														<%#Eval("Title")%>
														(ID:<%#Eval("ArticleID") %>)<span class="addarticle"></span></a>
												</ItemTemplate>
											</asp:DataList>
											<asp:Panel ID="pnlArticlePager" runat="server" CssClass="article_pager" EnableViewState="true">
												<asp:LinkButton ID="ibArticlePagerFirst" CssClass="first" runat="server" Visible="False" OnClick="ibArticlePagerFirst_Click" Text="First" />
												<asp:LinkButton ID="ibArticlePagerLeft" CssClass="prev" runat="server" Visible="False" OnClick="ibArticlePagerLeft_Click" Text="Previous" />
												<asp:Repeater ID="repPaggeingFilterByArticle" runat="server" OnItemCommand="repPaggeingFilterByArticle_ItemCommand">
													<ItemTemplate>
														<asp:LinkButton ID="lbArticlePagerpage" runat="server" CssClass='<%# Eval("CssClass") %>' Text='<%#Eval("pagerIndex") %>' CommandArgument='<%#Eval("pagerIndex") %>' />
													</ItemTemplate>
												</asp:Repeater>
												<asp:LinkButton ID="ibArticlePagerRight" CssClass="next" runat="server" Visible="False" OnClick="ibArticlePagerRight_Click" Text="Next" />
												<asp:LinkButton ID="ibArticlePagerLast" CssClass="last" runat="server" Visible="False" OnClick="ibArticlePagerLast_Click" Text="Last" />
												<asp:HiddenField ID="hgPageIDFilterByArticleID" runat="server" Value="1" />
											</asp:Panel>
											<div class="tags_selection_wrapper article_list" id="filterContentByArticlesWrapper">
												<p>
													<strong>
														<%=Selectedarticles %></strong></p>
												<p id="filterContentByArticlesNoTagsMsg" runat="server" class="please_select_article">
													<%=Selectarticles%></p>
												<asp:Literal ID="ListOfselectedArticles" runat="server" />
											</div>
											<asp:HiddenField ID="hfSelectedArticles" runat="server" />
										</div>
									</div>
								</td>
							</tr>
						</table>
					</ContentTemplate>
				</asp:UpdatePanel>
				<table class="settings_table" cellpadding="0" cellspacing="0" runat="server" id="tblDefaultArticleFilter">
					<tr>
						<td class="left">
							<dnn:Label ID="lblCategoryDisplay" runat="server" Text="Categories to display:" HelpText="Categories to display:" HelpKey="lblCategoryDisplay.HelpText" ResourceKey="lblCategoryDisplay" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbCategoriesToDisplay" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbCategoriesToDisplay_CheckedChanged" Text="Display all categories." resourcekey="cbCategoriesToDisplayResource1" />
						</td>
					</tr>
					<tr runat="server" id="rowSelectCategories" visible="false">
						<td colspan="2">
							<table class="settings_table" cellpadding="0" cellspacing="0" style="margin-left: auto; margin-right: auto;">
								<tr>
									<td class="left">
									</td>
									<td class="right">
										<asp:CheckBox ID="cbAutoAddCatChilds" runat="server" Text="Auto select all child categories." resourcekey="cbAutoAddCatChildsResource1" /></p>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<asp:PlaceHolder ID="pnlDinamicTreeView" runat="server"></asp:PlaceHolder>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblModuleToCat" runat="server" HelpText="You can only view articles from this cattegory" Text="Display articles only from this categry:" Visible="False" HelpKey="lblModuleToCat.HelpText" ResourceKey="lblModuleToCat" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbBoundModuleToCategory" runat="server" AutoPostBack="True" OnCheckedChanged="cbBoundModuleToCategory_CheckedChanged" Visible="False" resourcekey="cbBoundModuleToCategoryResource1" />
							&nbsp;<asp:DropDownList ID="ddlCatogoryBound" runat="server" AppendDataBoundItems="True" Visible="False">
							</asp:DropDownList>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblFilterPostsbyAuthor" runat="server" HelpText="Show all authors." Text="Show all authors:" HelpKey="lblFilterPostsbyAuthor.HelpText" ResourceKey="lblFilterPostsbyAuthor" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbShowAllAuthors" runat="server" AutoPostBack="True" OnCheckedChanged="cbShowAllAuthors_CheckedChanged" />
						</td>
					</tr>
					<tr>
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							<asp:TreeView ID="tvAuthorAndGroupSelection" runat="server" ExpandDepth="0" ImageSet="Contacts" ShowCheckBoxes="All" Visible="False" NodeIndent="25">
								<HoverNodeStyle Font-Underline="False" />
								<NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
								<ParentNodeStyle Font-Bold="True" ForeColor="#5555DD" />
								<SelectedNodeStyle Font-Underline="True" HorizontalPadding="0px" VerticalPadding="0px" />
							</asp:TreeView>
							<asp:CustomValidator ID="cvAuthorsTreeview" runat="server" ClientValidationFunction="ClientValidateAuthors" Display="Dynamic" Enabled="False" ErrorMessage="Please select at least one author." resourcekey="cvAuthorsTreeview.ErrorMessage" ValidationGroup="vgSettings">
							</asp:CustomValidator>
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblFeaturedArticles" runat="server" Text="Featured articles:" ResourceKey="lblFeaturedArticles" HelpKey="lblFeaturedArticles.HelpText" HelpText="Set the displaying of features articles" />
						</td>
						<td class="right">
							<table>
								<tr>
									<td>
										<asp:CheckBox ID="cbFeaturedArticles" runat="server" resourcekey="cbFeaturedArticlesResource1" AutoPostBack="true" OnCheckedChanged="cbFeaturedArticles_CheckedChanged" />
									</td>
									<td>
										<dnn:Label ID="lblShowOnlyFeatured" runat="server" Text="Show only featured articles" HelpText="Show only featured articles." HelpKey="lblShowOnlyFeatured.HelpText" ResourceKey="lblShowOnlyFeatured" />
									</td>
									<td>
										<asp:CheckBox ID="cbFeaturedOnTop" runat="server" AutoPostBack="true" OnCheckedChanged="cbFeaturedOnTop_CheckedChanged" />
									</td>
									<td>
										<dnn:Label ID="lblFeaturedOnTop" runat="server" Text="Keep featured articles on top" HelpText="If this option is turned on, the featured articles are displayed before all other articles." HelpKey="lblFeaturedOnTop.HelpText" ResourceKey="lblFeaturedOnTop" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="second">
						<td class="left">
						</td>
						<td class="right">
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblShowOnlyEvents" runat="server" HelpText="Show only event articles:" Text="Show only event articles:" HelpKey="lblShowOnlyEvents.HelpText" ResourceKey="lblShowOnlyEvents" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbShowOnlyEvents" runat="server" AutoPostBack="True" OnCheckedChanged="cbShowOnlyEvents_CheckedChanged" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblShowOnlyEventsLimit" runat="server" HelpText="Specify display of past events. Limit to 0 - displays events from current date:" Text="Specify display of past events:" HelpKey="lblShowOnlyEventsLimit.HelpText" ResourceKey="lblShowOnlyEventsLimit" />
						</td>
						<td class="right">
							<asp:RadioButtonList ID="rblLimitBackEvents" runat="server" Style="float: left" RepeatDirection="Horizontal">
								<asp:ListItem Value="All" resourcekey="ListItemResource24">ShowAll</asp:ListItem>
								<asp:ListItem Selected="True" Value="Limit" resourcekey="ListItemResource25">Limit to number of days:</asp:ListItem>
							</asp:RadioButtonList>
							<asp:TextBox Style="float: left" ID="tbPastEventLimit" runat="server" Width="25px" resourcekey="tbPastEventLimitResource1">0</asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvRhumbImageWidth2" runat="server" ControlToValidate="tbPastEventLimit" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvRhumbImageWidth2Resource1.ErrorMessage" />
							<asp:CompareValidator ID="cvLightBoxGalleryNumberOfItems1" runat="server" ControlToValidate="tbPastEventLimit" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgTGSettings" resourcekey="cvLightBoxGalleryNumberOfItems1Resource1.ErrorMessage" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblFilterByTags" runat="server" HelpText="Filter articles by tags" Text="Filter articles by tags:" HelpKey="lblFilterByTags.HelpText" ResourceKey="lblFilterByTags" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbFilterArticlesByTags" runat="server" AutoPostBack="True" OnCheckedChanged="cbFilterArticlesByTags_CheckedChanged" />
						</td>
					</tr>
					<tr id="trFilterArticlesByTags" runat="server">
						<td colspan="2">
							<asp:UpdatePanel ID="upArticleTags" runat="server" UpdateMode="Conditional">
								<ContentTemplate>
									<div class="collapsible_box no_margin visible" id="add_existing_tags_box">
										<div class="content">
											<div class="tag_collection">
												<ul class="tag_selection_menu">
													<li class="spaced">
														<asp:LinkButton ID="lbAllAddedTags" runat="server" OnClick="lbAllAddedTags_Click"><%=AllTags%></asp:LinkButton></li>
													<li class="spaced">
														<asp:LinkButton ID="lbMostPopularTags" runat="server" OnClick="lbMostPopularTags_Click"><%=MostPopularFirst%></asp:LinkButton></li>
													<li class="spaced">
														<asp:LinkButton ID="lbLastAddedTags" runat="server" OnClick="lbLastAddedTags_Click"><%=LastAddedDirst%></asp:LinkButton></li>
												</ul>
												<asp:DataList ID="dlListOfExistingTags" runat="server" RepeatColumns="5" DataKeyField="TagID" RepeatDirection="Horizontal" CssClass="existing_tag_list" Style="margin-bottom: 10px;">
													<ItemTemplate>
														<a class="tag_link" href="#" data-eds-tag-id='<%#Eval("TagID")%>'>
															<%#Eval("Name")%>
															<span class="addtag"></span></a>
													</ItemTemplate>
												</asp:DataList>
												<asp:Panel ID="pnlFilterByTagsPager" runat="server" CssClass="article_pager" EnableViewState="true">
													<asp:LinkButton ID="ibFilterByTagsFirst" CssClass="first" runat="server" Visible="False" OnClick="ibFilterByTagsFirst_Click" Text="First" />
													<asp:LinkButton ID="ibFilterByTagsLeft" CssClass="prev" runat="server" Visible="False" OnClick="ibFilterByTagsLeft_Click" Text="Previous" />
													<asp:Repeater ID="repPaggeingFilterByTags" runat="server" OnItemCommand="repPaggeingFilterByTags_ItemCommand">
														<ItemTemplate>
															<asp:LinkButton ID="lbArticlePagerpage" runat="server" CssClass='<%# Eval("CssClass") %>' Text='<%#Eval("pagerValue") %>' CommandArgument='<%#Eval("pagerIndex") %>' />
														</ItemTemplate>
													</asp:Repeater>
													<asp:LinkButton ID="ibFilterByTagsRight" CssClass="next" runat="server" Visible="False" OnClick="ibFilterByTagsRight_Click" Text="Next" />
													<asp:LinkButton ID="ibFilterByTagsLast" CssClass="last" runat="server" Visible="False" OnClick="ibFilterByTagsLast_Click" Text="Last" />
													<asp:HiddenField ID="hgPageIDFilterByTags" runat="server" Value="1" />
												</asp:Panel>
												<div class="tags_selection_wrapper" id="filterContentByTagsWrapper">
													<p>
														<strong>
															<%=Selectedtags %></strong></p>
													<p id="filterContentByTagsNoTagsMsg" runat="server" class="please_select_tags">
														<%=Selecttagstofilterarticles%></p>
													<asp:Literal ID="ListOfselectedTags" runat="server" />
												</div>
												<asp:HiddenField ID="hfSelectedTags" runat="server" />
											</div>
										</div>
									</div>
								</ContentTemplate>
							</asp:UpdatePanel>
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlArticleRatingApprove" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfArticleRatingApprove" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblArticleRatingApproveSettingSource" runat="server" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblAArticleRatingApprove_SelectedIndexChanged" RepeatDirection="Horizontal">
					<asp:ListItem Selected="True" Value="Portal" resourcekey="ListItemResource26">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource27">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					5</p>
				<h2>
					<%=Articleratingandapproval%></h2>
			</div>
			<asp:Panel ID="pnlArticleRatingApprovalSettingsTable" runat="server" CssClass="category_content">
				<table cellpadding="0" cellspacing="0" class="settings_table">
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblAproveRating" runat="server" HelpText="Enable article rating:" Text="Enable article rating:" HelpKey="lblAproveRating.HelpText" ResourceKey="lblAproveRating" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbArticleRating" runat="server" Checked="True" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblAproveArticle" runat="server" HelpText="Article must be approved:" Text="Article must be approved:" HelpKey="lblAproveArticle.HelpText" ResourceKey="lblAproveArticle" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbArticleApprove" runat="server" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblAproveUpdatedArticles" runat="server" HelpText="Updated article must be approved:" Text="Updated article must be approved:" HelpKey="lblAproveUpdatedArticles.HelpText" ResourceKey="lblAproveUpdatedArticles" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbUPpdatedArticleApprove" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblAuthorsEditOwnArticles" runat="server" HelpText="Authors can only edit their own articles:" Text="Author can only edit his own articles:" HelpKey="lblAuthorsEditOwnArticles.HelpText" ResourceKey="lblAuthorsEditOwnArticles" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbAuthorsEditOwnArticles" runat="server" />
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlThemeSettingsSource" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfThemeSettingsSourceState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblThemeSettingsSource" runat="server" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblThemeSettingsSource_SelectedIndexChanged" RepeatDirection="Horizontal">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource28">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource29">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					6</p>
				<h2>
					<%=Templateandthemeselection%></h2>
			</div>
			<asp:Panel ID="pnlThemeSettingsSourceTable" runat="server" CssClass="category_content">
				<asp:UpdatePanel ID="upThemeSettings" runat="server">
					<ContentTemplate>
						<table cellpadding="0" cellspacing="0" class="settings_table">
							<tr>
								<td class="left">
									<dnn:Label ID="lblArticleListTheme" runat="server" HelpText="Article list theme:" Text="Article list theme:" HelpKey="lblArticleListTheme.HelpText" ResourceKey="lblArticleListTheme" />
								</td>
								<td class="right">
									<asp:DropDownList ID="ddlArticleListTheme" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlArticleListFolder_SelectedIndexChanged" />
								</td>
							</tr>
							<tr class="second">
								<td class="left">
									<dnn:Label ID="lblArticleListTemplate" runat="server" HelpText="Article list template:" Text="Article list template:" HelpKey="lblArticleListTemplate.HelpText" ResourceKey="lblArticleListTemplate" />
								</td>
								<td class="right">
									<asp:DropDownList ID="ddlArticleListTemplate" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="left">
									<dnn:Label ID="lblArticleDetailsTheme" runat="server" HelpText="Article details theme:" Text="Article details theme:" HelpKey="lblArticleDetailsTheme.HelpText" ResourceKey="lblArticleDetailsTheme" />
								</td>
								<td class="right">
									<asp:DropDownList ID="ddlArticleDetailsTheme" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlArticleDetailsFolder_SelectedIndexChanged" />
								</td>
							</tr>
							<tr class="second">
								<td class="left">
									<dnn:Label ID="lblArticleDetailsTemplate" runat="server" HelpText="Article details template:" Text="Article details template:" HelpKey="lblArticleDetailsTemplate.HelpText" ResourceKey="lblArticleDetailsTemplate" />
								</td>
								<td class="right">
									<asp:DropDownList ID="ddlArticleDetailsTemplate" runat="server" />
									<asp:RequiredFieldValidator ID="rfvArticleDetails" runat="server" ControlToValidate="ddlArticleDetailsTemplate" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvArticleDetailsResource1" />
								</td>
							</tr>
							<tr>
								<td class="left">
									<dnn:Label ID="lblArticleCommentsTemplate" runat="server" HelpText="Article comments template:" Text="Article comments template:" HelpKey="lblArticleCommentsTemplate.HelpText" ResourceKey="lblArticleCommentsTemplate" />
								</td>
								<td class="right">
									<asp:DropDownList ID="ddlArticleCommentsTheme" runat="server" CausesValidation="True" ValidationGroup="vgSettings" />
									<asp:RequiredFieldValidator ID="rfvCommentsTheme" runat="server" ControlToValidate="ddlArticleCommentsTheme" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvCommentsThemeResource1" />
								</td>
							</tr>
							<tr class="second">
								<td class="left">
									<dnn:Label ID="lblArticleCSSStyle" runat="server" HelpText="Display style:" Text="Display style:" HelpKey="lblArticleCSSStyle.HelpText" ResourceKey="lblArticleCSSStyle" />
								</td>
								<td class="right">
									<asp:DropDownList ID="ddlDisplayStyle" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="left">
									<dnn:Label ID="lblThemeChangeing" runat="server" HelpText="Enable theme changing in article:" Text="Enable theme changing in article:" HelpKey="lblThemeChangeing.HelpText" ResourceKey="lblThemeChangeing" />
								</td>
								<td class="right">
									<asp:CheckBox ID="cbThemeChanging" runat="server" />
								</td>
							</tr>
						</table>
					</ContentTemplate>
				</asp:UpdatePanel>
				<asp:UpdateProgress ID="uppThemeSettings" runat="server" AssociatedUpdatePanelID="upThemeSettings" DisplayAfter="100" DynamicLayout="true">
					<ProgressTemplate>
						<img src="<%=ModulePath%>images/settings/ajaxLoading.gif" /></ProgressTemplate>
				</asp:UpdateProgress>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlArticleImageSettingsSource" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfArticleImageSettingsSourceState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblArticleImageSettingsSource" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblArticleImageSettingsSource_SelectedIndexChanged">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource30">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource31">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					7</p>
				<h2>
					<%=Articleimage%></h2>
			</div>
			<asp:Panel ID="pnlArticleImageSettingsSourceTable" runat="server" CssClass="category_content">
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblImageThmbWidth" runat="server" HelpText="Image thumb width:" Text="Image thumb width:" HelpKey="lblImageThmbWidth.HelpText" ResourceKey="lblImageThmbWidth" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbImageThumbWidth" runat="server" Text="150" />
							<asp:RequiredFieldValidator ID="rfvRhumbImageWidth" runat="server" ControlToValidate="tbImageThumbWidth" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvRhumbImageWidthResource1.ErrorMessage" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblImageThmbHeight" runat="server" HelpText="Image thumb height:" Text="Image thumb height:" HelpKey="lblImageThmbHeight.HelpText" ResourceKey="lblImageThmbHeight" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbImageThumbHeight" runat="server" Text="150" />
							<asp:RequiredFieldValidator ID="rfvThumbImageHeight" runat="server" ControlToValidate="tbImageThumbHeight" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvThumbImageHeightResource1.ErrorMessage" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblShrinkImagesProportionalyOption" runat="server" HelpText="Proportionaly resize thumb:" Text="Proportionaly resize thumb:" HelpKey="lblShrinkImagesProportionalyOption.HelpText" ResourceKey="lblShrinkImagesProportionalyOption" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbProportionalyShrinkThumb" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbProportionalyShrinkThumb_CheckedChanged" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblShrinkImages" runat="server" HelpText="Resize &amp; crop thumb:" Text="Resize &amp; crop thumb:" HelpKey="lblShrinkImages.HelpText" ResourceKey="lblShrinkImages" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbResizeCropThumb" runat="server" AutoPostBack="True" OnCheckedChanged="cbResizeCropThumb_CheckedChanged" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblMainImageWidth" runat="server" Text="Main image width:" HelpText="Main image width:" HelpKey="lblMainImageWidth.HelpText" ResourceKey="lblMainImageWidth" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbMainImageWidth" runat="server" Text="600" />
							<asp:RequiredFieldValidator ID="rfvMainImageWidth" runat="server" ControlToValidate="tbMainImageWidth" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvMainImageWidthResource1.ErrorMessage" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblMainImageHeight" runat="server" Text="Main image height:" HelpText="Main image height:" HelpKey="lblMainImageHeight.HelpText" ResourceKey="lblMainImageHeight" Visible="True" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbMainImageHeight" runat="server" Text="600" />
							<asp:RequiredFieldValidator ID="rfvMainImageWidth0" runat="server" ControlToValidate="tbMainImageHeight" ErrorMessage="This filed is required." ValidationGroup="vgSettings" SetFocusOnError="True" resourcekey="rfvMainImageWidth0Resource1.ErrorMessage" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblShrinkImagesProportionaly" runat="server" Text="Proportionaly resize main image:" HelpText="Proportionaly resize main image:" HelpKey="lblShrinkImagesProportionaly.HelpText" ResourceKey="lblShrinkImagesProportionaly" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbProportionalyShrinkArticle" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbProportionalyShrinkArticle_CheckedChanged" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblShrinkImagesProportionalyOpt" runat="server" Text="Resize &amp; crop main image:" HelpText="Resize &amp; crop main image:" HelpKey="lblShrinkImagesProportionalyOpt.HelpText" ResourceKey="lblShrinkImagesProportionalyOpt" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbResizeCropMainImage" runat="server" AutoPostBack="True" OnCheckedChanged="cbResizeCropMainImage_CheckedChanged" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblJpegQuality" runat="server" HelpText="Jpeg quality:" Text="Jpeg quality:" HelpKey="lblJpegQuality.HelpText" ResourceKey="lblJpegQuality" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbJpegThumbnailQuality" runat="server" CausesValidation="True" MaxLength="3" ValidationGroup="vgSettings" Width="30px" Text="97" />
							<asp:RequiredFieldValidator ID="rfvMainImageWidth1" runat="server" ControlToValidate="tbJpegThumbnailQuality" Display="Dynamic" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvMainImageWidth1Resource1.ErrorMessage" />
							<asp:RangeValidator ID="rvJpegQuality" runat="server" ControlToValidate="tbJpegThumbnailQuality" Display="Dynamic" ErrorMessage="Enter value between 1 - 100." MaximumValue="100" MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="vgSettings"
								resourcekey="rvJpegQualityResource1.ErrorMessage" />
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlImageUploadSettingsSource" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfImageUploadSettingsSourceState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblImageUploadSettingsSource" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblImageUploadSettingsSource_SelectedIndexChanged">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource32">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource33">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					8</p>
				<h2>
					<%=Articlegalleryimageupload%></h2>
			</div>
			<asp:Panel ID="pnlImageUploadSettingsSourceTable" runat="server" CssClass="category_content">
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblImageReize" runat="server" HelpText="Resize image on upload:" Text="Resize image on upload" HelpKey="lblImageReize.HelpText" ResourceKey="lblImageReize" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbUploadImageResize" runat="server" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblImageReizeWidth" runat="server" HelpText="Image upload width:" Text="Image upload width:" HelpKey="lblImageReizeWidth.HelpText" ResourceKey="lblImageReizeWidth" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbUploadImageWidth" runat="server" Width="50px" Text="800" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblImageReizeHeight" runat="server" HelpText="Image upload height:" Text="Image upload height:" HelpKey="lblImageReizeHeight.HelpText" ResourceKey="lblImageReizeHeight" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbUploadImageHeight" runat="server" Width="50px" Text="800" />
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlEasyDNNGalleyIntegrationSettingsSource" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfEasyDNNGalleyIntegrationSettingsSourceState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblEasyDNNGalleyIntegrationSettingsSource" runat="server" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblEasyDNNGalleyIntegrationSettingsSource_SelectedIndexChanged" RepeatDirection="Horizontal">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource34">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource35">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					9</p>
				<h2>
					<%=EasyDNNGalleryintegration%></h2>
			</div>
			<asp:Panel ID="pnlEasyDNNGalleyIntegrationSettingsSourceTable" runat="server" CssClass="category_content">
				<table cellpadding="0" cellspacing="0" class="settings_table">
					<tr>
						<td class="center_text">
							<asp:Label ID="lblGalleryInstalled" runat="server" resourcekey="lblGalleryInstalledResource1" />
						</td>
					</tr>
				</table>
				<asp:Panel ID="pnlIntegratedGallery" runat="server">
					<h3 class="subsections">
						<%=Gallerysettings%></h3>
					<asp:UpdatePanel ID="upGallerySettings" runat="server">
						<ContentTemplate>
							<table cellpadding="0" cellspacing="0" class="settings_table">
								<tr>
									<td class="left">
										<dnn:Label ID="lblEnableGalleryIntegration" runat="server" HelpText="Enable gallery integration:" Text="Enable gallery integration:" HelpKey="lblEnableGalleryIntegration.HelpText" ResourceKey="lblEnableGalleryIntegration" />
									</td>
									<td class="right">
										<asp:CheckBox ID="cbEnableGalleryIntegraton" runat="server" Checked="True" />
									</td>
								</tr>
								<tr class="second">
									<td class="left">
										<dnn:Label ID="lblUseGalleryDefault" runat="server" HelpText="Force default settings on all articles:" Text="Force default settings on all articles:" HelpKey="lblUseGalleryDefault.HelpText" ResourceKey="lblUseGalleryDefault" />
									</td>
									<td class="right">
										<asp:CheckBox ID="cbUseGalleryDefaultSettings" runat="server" />
									</td>
								</tr>
								<tr>
									<td class="left">
										<dnn:Label ID="lblGalleryDisplayType" runat="server" HelpText="Gallery display type:" Text="Gallery display type:" HelpKey="lblGalleryDisplayType.HelpText" ResourceKey="lblGalleryDisplayType" />
									</td>
									<td class="right">
										<asp:DropDownList ID="ddlGalleryDisplayType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlGalleryDisplayType_SelectedIndexChanged">
											<asp:ListItem Value="lightbox" resourcekey="ListItemResource36">Lightbox gallery</asp:ListItem>
											<asp:ListItem Value="audio" resourcekey="ListItemResource37">Audio gallery</asp:ListItem>
											<asp:ListItem Value="video" resourcekey="ListItemResource38">Video gallery</asp:ListItem>
										</asp:DropDownList>
									</td>
								</tr>
								<tr class="second">
									<td class="left">
										<dnn:Label ID="lblGalleryPosition" runat="server" HelpText="Gallery position:" Text="Gallery position:" HelpKey="lblGalleryPosition.HelpText" ResourceKey="lblGalleryPosition" />
									</td>
									<td class="right">
										<asp:DropDownList ID="ddlGalleryPosition" runat="server">
											<asp:ListItem Value="top" resourcekey="ListItemResource39">Top position</asp:ListItem>
											<asp:ListItem Selected="True" Value="bottom" resourcekey="ListItemResource40">Boottom position</asp:ListItem>
										</asp:DropDownList>
									</td>
								</tr>
								<tr class="second">
									<td class="left">
										<dnn:Label ID="lblFixedResponsiveLayout" runat="server" HelpText="Fixed or responsive layout:" Text="Fixed or responsive layout:" HelpKey="lblFixedResponsiveLayout.HelpText" ResourceKey="lblFixedResponsiveLayout" />
									</td>
									<td class="right">
										<asp:RadioButtonList ID="rblFixedResponsiveLayoutTypeSelect" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblFixedResponsiveLayoutTypeSelect_SelectedIndexChanged">
											<asp:ListItem resourcekey="liFixed" Selected="True" Value="fixed">Fixed Layout</asp:ListItem>
											<asp:ListItem resourcekey="liResponsive" Value="responsive">Responsive Layout</asp:ListItem>
										</asp:RadioButtonList>
									</td>
								</tr>
							</table>
							<asp:Panel ID="pnlChameleonGallery" runat="server" Visible="False">
								<table cellpadding="0" cellspacing="0" class="settings_table">
									<tr>
										<td class="left">
											<dnn:Label ID="lblGalleryWidth" runat="server" HelpText="Gallery width:" Text="Gallery width:" HelpKey="lblGalleryWidth.HelpText" ResourceKey="lblGalleryWidth" Visible="True" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbxGalleryWidth" runat="server" Width="50px" resourcekey="tbxGalleryWidthResource1">620</asp:TextBox>
											<asp:Label ID="lblChamMainPanelWidthType" runat="server" Text="%" Visible="False" />
											&nbsp;<asp:RequiredFieldValidator ID="rfvRhumbImageWidth0" runat="server" ControlToValidate="tbxGalleryWidth" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvRhumbImageWidth0Resource1.ErrorMessage"
												Display="Dynamic" />
											<asp:CompareValidator ID="cvLightBoxGalleryNumberOfItems" runat="server" ControlToValidate="tbxGalleryWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgTGSettings" resourcekey="cvLightBoxGalleryNumberOfItemsResource1.ErrorMessage" />
											<asp:RangeValidator ID="rvChameleonWidthPerct" runat="server" ControlToValidate="tbxGalleryWidth" Display="Dynamic" Enabled="False" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" resourcekey="rvAGVolume0Resource1.ErrorMessage"
												SetFocusOnError="True" Type="Integer" ValidationGroup="vgSettings" Visible="False" />
										</td>
									</tr>
									<tr class="second">
										<td class="left">
											<dnn:Label ID="lblGalleryHeight" runat="server" HelpText="Gallery height:" Text="Gallery height:" HelpKey="lblGalleryHeight.HelpText" ResourceKey="lblGalleryHeight" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbxGalleryHeight" runat="server" Width="50px" resourcekey="tbxGalleryHeightResource1">500</asp:TextBox>
											<asp:Label ID="lblChamMainPanelHeightType" runat="server" Text="px" Visible="False" />
											<asp:RequiredFieldValidator ID="rfvRhumbImageWidth1" runat="server" ControlToValidate="tbxGalleryHeight" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvRhumbImageWidth1Resource1.ErrorMessage"
												Display="Dynamic" />
											<asp:CompareValidator ID="cvLightBoxGalleryNumberOfItems0" runat="server" ControlToValidate="tbxGalleryHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgTGSettings" resourcekey="cvLightBoxGalleryNumberOfItems0Resource1.ErrorMessage" />
										</td>
									</tr>
									<tr>
										<td class="left">
											<dnn:Label ID="lblChameleonLayout" runat="server" HelpText="Gallery layout." Text="Layout:" HelpKey="lblChameleonLayout.HelpText" ResourceKey="lblChameleonLayout" />
										</td>
										<td class="right">
											<asp:DropDownList ID="ddlChameleonLayout" runat="server" />
										</td>
									</tr>
									<tr>
										<td class="left">
											<dnn:Label ID="lblChameleonLayoutTheme" runat="server" HelpText="Chameleon theme:" Text="Chameleon theme:" HelpKey="lblChameleonLayoutTheme.HelpText" ResourceKey="lblChameleonLayoutTheme" />
										</td>
										<td class="right">
											<asp:DropDownList ID="ddlChameleonGalleryThemeSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlChameleonGalleryThemeSelect_SelectedIndexChanged" />
										</td>
									</tr>
									<tr>
										<td class="left">
											<dnn:Label ID="lblChameleonLayoutThemeStyle" runat="server" HelpText="Chameleon theme style:" Text="Chameleon theme style:" HelpKey="lblChameleonLayoutThemeStyle.HelpText" ResourceKey="lblChameleonLayoutThemeStyle" />
										</td>
										<td class="right">
											<asp:DropDownList ID="ddlChameleonGalleryThemeSelectStyling" runat="server" DataTextField="Text" DataValueField="Value" />
										</td>
									</tr>
								</table>
							</asp:Panel>
							<asp:Panel ID="pnlOldGallery" runat="server">
								<table cellpadding="0" cellspacing="0" class="settings_table">
									<tr>
										<td class="left">
											<dnn:Label ID="lblGalleryTheme" runat="server" HelpText="Gallery theme:" Text="Gallery theme:" HelpKey="lblGalleryTheme.HelpText" ResourceKey="lblGalleryTheme" />
										</td>
										<td class="right">
											<asp:DropDownList ID="ddlGalleryTheme" runat="server" AppendDataBoundItems="True" />
											<asp:Label ID="lblThemeError" runat="server" Enabled="False" ForeColor="Red" Text="Please select theme." Visible="False" resourcekey="lblThemeErrorResource1" />
										</td>
									</tr>
									<tr class="second">
										<td class="left">
											<dnn:Label ID="lblLightBoxTheme" runat="server" HelpText="Lightbox theme:" Text="Lightbox theme:" HelpKey="lblLightBoxTheme.HelpText" ResourceKey="lblLightBoxTheme" />
										</td>
										<td class="right">
											<asp:DropDownList ID="ddlLightBoxTheme" runat="server">
												<asp:ListItem Value="light_rounded" resourcekey="ListItemResource41">Light rounded</asp:ListItem>
												<asp:ListItem Value="light_square" resourcekey="ListItemResource42"> Light square</asp:ListItem>
												<asp:ListItem Value="dark_rounded" resourcekey="ListItemResource43">Dark rounded</asp:ListItem>
												<asp:ListItem Value="dark_square" resourcekey="ListItemResource44">Dark square</asp:ListItem>
											</asp:DropDownList>
										</td>
									</tr>
									<tr>
										<td class="left">
											<dnn:Label ID="lblGalleryThumbWidth" runat="server" HelpText="Gallery thumb width:" Text="Gallery thumb width:" HelpKey="lblGalleryThumbWidth.HelpText" ResourceKey="lblGalleryThumbWidth" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbGalleryThumbWidth" runat="server" Width="50px" resourcekey="tbGalleryThumbWidthResource1">100</asp:TextBox>
										</td>
									</tr>
									<tr class="second">
										<td class="left">
											<dnn:Label ID="lblGalleryThumbHeight" runat="server" HelpText="Gallery thumb height:" Text="Gallery thumb height:" HelpKey="lblGalleryThumbHeight.HelpText" ResourceKey="lblGalleryThumbHeight" Visible="True" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbGalleryThumbHeight" runat="server" Width="50px" resourcekey="tbGalleryThumbHeightResource1">100</asp:TextBox>
										</td>
									</tr>
									<tr>
										<td class="left">
											<dnn:Label ID="lblGalleryItemsPerPage" runat="server" HelpText="Items per page:" Text="Items per page:" HelpKey="lblGalleryItemsPerPage.HelpText" ResourceKey="lblGalleryItemsPerPage" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbGalleryItemsPerPage" runat="server" Width="50px" Text="12" resourcekey="tbGalleryItemsPerPageResource1" />
										</td>
									</tr>
									<tr class="second">
										<td class="left">
											<dnn:Label ID="lblGalleryNumberOfColumns" runat="server" HelpText="Number of columns:" Text="Number of columns:" HelpKey="lblGalleryNumberOfColumns.HelpText" ResourceKey="lblGalleryNumberOfColumns" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbGalleryNuberOfColumns" runat="server" Width="50px" Text="4" resourcekey="tbGalleryNuberOfColumnsResource1" />
										</td>
									</tr>
									<tr>
										<td class="left">
											<dnn:Label ID="lblGIDisplayItemTitleLightBOx" runat="server" HelpText="Display item title in Lightbox:" Text="Display item title in Lightbox:" HelpKey="lblGIDisplayItemTitleLightBOx.HelpText" ResourceKey="lblGIDisplayItemTitleLightBOx" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbGIDisplayItemTitleLightBox" runat="server" />
										</td>
									</tr>
									<tr class="second">
										<td class="left">
											<dnn:Label ID="lblGIDisplayItemDescriptionLightBox" runat="server" HelpText="Display item description in Lightbox:" Text="Display item description in Lightbox:" HelpKey="lblGIDisplayItemDescriptionLightBox.HelpText" ResourceKey="lblGIDisplayItemDescriptionLightBox" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbGIDisplayItemDescriptionLightBox" runat="server" />
										</td>
									</tr>
									<tr>
										<td class="left">
											<dnn:Label ID="lblGIDisplayItemTitle" runat="server" HelpText="Display item title:" Text="Display item title:" HelpKey="lblGIDisplayItemTitle.HelpText" ResourceKey="lblGIDisplayItemTitle" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbItemTitle" runat="server" />
										</td>
									</tr>
									<tr class="second">
										<td class="left">
											<dnn:Label ID="lblGIDisplayItemDescription" runat="server" HelpText="Display item description:" Text="Display item description:" HelpKey="lblGIDisplayItemDescription.HelpText" ResourceKey="lblGIDisplayItemDescription" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbGIItemDescription" runat="server" />
										</td>
									</tr>
									<tr>
										<td class="left">
											<dnn:Label ID="lblGIPagerStyle" runat="server" HelpText="Pager style:" Text="Pager style:" Visible="False" HelpKey="lblGIPagerStyle.HelpText" ResourceKey="lblGIPagerStyle" />
										</td>
										<td class="right">
											<asp:DropDownList ID="ddlGIPagerStyle" runat="server" Visible="False">
												<asp:ListItem resourcekey="ListItemResource45">Numeric</asp:ListItem>
												<asp:ListItem Value="NextPrevious" resourcekey="ListItemResource46">Arrows (Next, Previous)</asp:ListItem>
												<asp:ListItem Value="NextPreviousFirstLast" resourcekey="ListItemResource47">Arrows (Next, Previous, First, Last)</asp:ListItem>
											</asp:DropDownList>
										</td>
									</tr>
								</table>
							</asp:Panel>
							<table cellpadding="0" cellspacing="0" class="settings_table">
								<tr class="second">
									<td class="left">
										&nbsp;
									</td>
									<td class="right">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td class="left">
										<dnn:Label ID="lblUserCanSeeOnlyHisGalleries" runat="server" HelpText="User can see only their own galleries that they have created:" Text="User can see only their own galleries:" HelpKey="lblUserCanSeeOnlyHisGalleries.HelpText" ResourceKey="lblUserCanSeeOnlyHisGalleries.Text" />
									</td>
									<td class="right">
										<asp:CheckBox ID="cbUserCanSeeOnlyTheirGalleries" runat="server" />
									</td>
								</tr>
								<tr class="second">
									<td class="left">
										<dnn:Label ID="lblUserCanSeeOnlyHisImages" runat="server" HelpText="User can see only their own images in shared gallery:" Text="User can see only their own images:" HelpKey="lblUserCanSeeOnlyHisImages.HelpText" ResourceKey="lblUserCanSeeOnlyHisImages" />
									</td>
									<td class="right">
										<asp:CheckBox ID="cbUserCanOnlySeeTheirOwnImages" runat="server" />
									</td>
								</tr>
							</table>
						</ContentTemplate>
					</asp:UpdatePanel>
					<asp:UpdateProgress ID="uppGallerySettings" runat="server" AssociatedUpdatePanelID="upGallerySettings" DisplayAfter="100" DynamicLayout="true">
						<ProgressTemplate>
							<img src="<%=ModulePath%>images/settings/ajaxLoading.gif" /></ProgressTemplate>
					</asp:UpdateProgress>
				</asp:Panel>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlImageInPostSettingsSource" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfImageInPostSettingsSourceState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblImageInPostSettingsSource" runat="server" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblImageInPostSettingsSource_SelectedIndexChanged" RepeatDirection="Horizontal">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource48">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource49">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					10</p>
				<h2>
					<%=Articleimagestokensdefaultpreset%></h2>
			</div>
			<asp:Panel ID="pnlImageInPostSettingsSourceTable" runat="server" CssClass="category_content">
				<table cellpadding="0" cellspacing="0" class="settings_table">
					<tr>
						<td class="left">
							<dnn:Label ID="lblTokenWidth" runat="server" HelpText="Insert image width:" Text="Insert image width." HelpKey="lblTokenWidth.HelpText" ResourceKey="lblTokenWidth" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbTokenWidth" runat="server" Width="50px" Text="200" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblTokenHeight" runat="server" HelpText="Insert image height:" Text="Insert image height." HelpKey="lblTokenHeight.HelpText" ResourceKey="lblTokenHeight" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbTokenHeight" runat="server" Width="50px" Text="200" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblTokenCSSClass" runat="server" HelpText="Position:" Text="Image position:" HelpKey="lblTokenCSSClass.HelpText" ResourceKey="lblTokenCSSClass" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbTokenCSSClass" runat="server" Width="150px" resourcekey="tbTokenCSSClassResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblTokenEmbedLightBox" runat="server" HelpText="Insert image inline CSS style:" Text="Show audio video itemes in LightBox:" HelpKey="lblTokenEmbedLightBox.HelpText" ResourceKey="lblTokenEmbedLightBox" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbTokenLighbox" runat="server" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblTokenTitle" runat="server" HelpText="Display image title:" Text="Display image title:" HelpKey="lblTokenTitle.HelpText" ResourceKey="lblTokenTitle" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbTokenTitle" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblTokenDescription" runat="server" HelpText="Display image description:" Text="Display image description:" HelpKey="lblTokenDescription.HelpText" ResourceKey="lblTokenDescription" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbTokenDescription" runat="server" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblTokenResizeCrop" runat="server" HelpText="Resize and crop image:" Text="Resize and crop image:" HelpKey="lblTokenResizeCrop.HelpText" ResourceKey="lblTokenResizeCrop" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbTokenResizeCrop" runat="server" />
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlCommentSettings" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfCommentSettingsState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblCommentSettingsSource" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblCommentSettingsSource_SelectedIndexChanged">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource50">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource51">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					11</p>
				<h2>
					<%=Comments%></h2>
			</div>
			<asp:Panel ID="pnlCommentsSettingsTable" runat="server" CssClass="category_content">
				<asp:UpdatePanel ID="upCommentsSettings" runat="server">
					<ContentTemplate>
						<table class="settings_table" cellpadding="0" cellspacing="0">
							<tr>
								<td class="left">
									<dnn:Label ID="lblAllowComments" runat="server" Text="Enable comments:" HelpText="Enable comments." HelpKey="lblAllowComments.HelpText" ResourceKey="lblAllowComments"></dnn:Label>
								</td>
								<td class="right">
									<asp:CheckBox ID="cbAllowComments" runat="server" AutoPostBack="True" OnCheckedChanged="cbAllowComments_CheckedChanged" Checked="True" resourcekey="cbAllowCommentsResource1" />
								</td>
							</tr>
							<tr class="second">
								<td colspan="2" align="center">
									<asp:RadioButtonList ID="rblCommensSource" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblCommensSource_SelectedIndexChanged" RepeatDirection="Horizontal">
										<asp:ListItem Selected="True" Value="Standard" resourcekey="ListItemResource52">Standard comments</asp:ListItem>
										<asp:ListItem Value="Facebook" resourcekey="ListItemResource53">Facebook comments</asp:ListItem>
										<asp:ListItem Value="DISQUS" resourcekey="ListItemResource54">DISQUS Comments</asp:ListItem>
									</asp:RadioButtonList>
								</td>
							</tr>
						</table>
						<asp:Panel ID="pnlFacebookCommentsOptions" runat="server">
							<table class="settings_table" cellpadding="0" cellspacing="0">
								<tr>
									<td class="left">
										<dnn:Label ID="lblFacebookID" runat="server" Text="Facebook App ID:" HelpText="Enter Facebook App Id. If you do no thave one leve None." HelpKey="lblFacebookID.HelpText" ResourceKey="lblFacebookID" />
									</td>
									<td class="right">
										<asp:TextBox ID="tbFacebookAppID" runat="server" Width="140px" resourcekey="tbFacebookAppIDResource1">None</asp:TextBox>
									</td>
								</tr>
								<tr class="second">
									<td class="left">
										<dnn:Label ID="lblFacebookUserID" runat="server" Text="Facebook User ID:" HelpText="Enter Facebook User Id. If you do no thave one leve None." HelpKey="lblFacebookUserID.HelpText" ResourceKey="lblFacebookUserID" />
									</td>
									<td class="right">
										<asp:TextBox ID="tbFacebookUserID" runat="server" Width="140px" resourcekey="tbFacebookUserIDResource1">None</asp:TextBox>
									</td>
								</tr>
								<tr>
									<td class="left">
										<dnn:Label ID="lblFacebookNumberOfComents" runat="server" Text="Facebook number of comments:" HelpText="Enter number of Facebook comments per page:" HelpKey="lblFacebookNumberOfComents.HelpText" ResourceKey="lblFacebookNumberOfComents" />
									</td>
									<td class="right">
										<asp:TextBox ID="tbFacebookNumberOfComments" runat="server" Width="50px" resourcekey="tbFacebookNumberOfCommentsResource1">10</asp:TextBox>
									</td>
								</tr>
								<tr class="second">
									<td class="left">
										<dnn:Label ID="lblFacebookCommentsTheme" runat="server" Text="Facebook comments theme:" HelpText="Select Facebook comments theme:" HelpKey="lblFacebookCommentsTheme.HelpText" ResourceKey="lblFacebookCommentsTheme" />
									</td>
									<td class="right">
										<asp:DropDownList ID="ddlFacebookCommentsTheme" runat="server">
											<asp:ListItem Value="light" resourcekey="ListItemResource55">Light theme</asp:ListItem>
											<asp:ListItem Value="dark" resourcekey="ListItemResource56">Dark Theme</asp:ListItem>
										</asp:DropDownList>
									</td>
								</tr>
							</table>
						</asp:Panel>
						<asp:Panel ID="pnlDisqUSOptions" runat="server">
							<table class="settings_table" cellpadding="0" cellspacing="0">
								<tr>
									<td class="left">
										<dnn:Label ID="lblDisqusID" runat="server" Text="Site Shortname:" HelpText="Enter the DISQUS id of the site. Your site(forum) shortname as registered on Disqus:" HelpKey="lblDisqusID.HelpText" ResourceKey="lblDisqusID" />
									</td>
									<td class="right">
										<asp:TextBox ID="tbDisqusID" runat="server" Width="240px" resourcekey="tbDisqusIDResource1">None</asp:TextBox>
									</td>
								</tr>
								<tr class="second">
									<td class="left">
										<dnn:Label ID="lblDisqusOnLine" runat="server" Text="Site online:" HelpText="Tells the Disqus service that you are testing the system on an inaccessible website, e.g. secured staging server or a local environment." HelpKey="lblDisqusOnLine.HelpText" ResourceKey="lblDisqusOnLine" />
									</td>
									<td class="right">
										<asp:CheckBox ID="cbDisqusOnline" runat="server" Checked="True" />
									</td>
								</tr>
							</table>
						</asp:Panel>
						<asp:Panel ID="pnlStandardComents" runat="server">
							<asp:Panel ID="pnlStandardEnabledComments" runat="server">
								<table class="settings_table" cellpadding="0" cellspacing="0">
									<tr class="second">
										<td class="left">
											<dnn:Label ID="lblAllowArticleComments" runat="server" Text="Enable  turn on/off comments per article:" HelpText="Enable  turn on/off comments per article:" HelpKey="lblAllowArticleComments.HelpText" ResourceKey="lblAllowArticleComments" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbAllowArticleComments" runat="server" />
										</td>
									</tr>
									<tr>
										<td class="left">
											<dnn:Label ID="lblEnableCAPTCA" runat="server" Text="Enable CAPTCHA:" HelpText="Enable CAPTCHA:" HelpKey="lblEnableCAPTCA.HelpText" ResourceKey="lblEnableCAPTCA" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbEnableCAPTCHA" runat="server" />
										</td>
									</tr>
									<tr class="second">
										<td class="left">
											<dnn:Label ID="lblCommentsMustBeApproved" runat="server" Text="Comments must be approved:" HelpText="Comments must be approved:" HelpKey="lblCommentsMustBeApproved.HelpText" ResourceKey="lblCommentsMustBeApproved" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbModerateComments" runat="server" />
										</td>
									</tr>
								</table>
							</asp:Panel>
							<asp:Panel ID="pnlStandardDisabledComments" runat="server">
								<table class="settings_table" cellpadding="0" cellspacing="0">
									<tr class="second">
										<td class="left">
											<dnn:Label ID="lblShowAlredyWrittenComments" runat="server" Text="Show already written comments:" HelpText="Show already written comments." HelpKey="lblShowAlredyWrittenComments.HelpText" ResourceKey="lblShowAlredyWrittenComments" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbShowWrittenComments" runat="server" OnCheckedChanged="cbShowWrittenComments_CheckedChanged" AutoPostBack="true" />
										</td>
									</tr>
								</table>
							</asp:Panel>
							<asp:Panel ID="pnlStandardGroupSettings" runat="server">
								<table class="settings_table" cellpadding="0" cellspacing="0">
									<tr>
										<td class="left">
											<dnn:Label ID="lblShowCommentsRAting" runat="server" Text="Show comments rating:" HelpText="Show comments rating:" HelpKey="lblShowCommentsRAting.HelpText" ResourceKey="lblShowCommentsRAting" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbShowCommentsRating" runat="server" Checked="True" />
										</td>
									</tr>
									<tr class="second">
										<td class="left">
											<dnn:Label ID="lblShowThreaedComments" runat="server" Text="Show threaded comments:" HelpText="Show threaded comments:" HelpKey="lblShowThreaedComments.HelpText" ResourceKey="lblShowThreaedComments" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbShowThreadedComments" runat="server" Checked="True" />
										</td>
									</tr>
									<tr class="second" id="trCommentsAvatarSelection" runat="server">
										<td class="left">
											<dnn:Label ID="lblSelectCommentsAvatarSource" runat="server" Text="Select coment avatar source:" HelpText="Select provider for the comment avatars:" HelpKey="lblSelectCommentsAvatarSource.HelpText" ResourceKey="lblSelectCommentsAvatarSource" />
										</td>
										<td class="right">
											<asp:RadioButtonList ID="rblCommentsAvatarSource" runat="server" RepeatDirection="Horizontal">
												<asp:ListItem resourcekey="ligravatar" Value="gravatar" Selected="True">Gravatar</asp:ListItem>
												<asp:ListItem resourcekey="lidnnprofile" Value="dnnprofile">DotNetNuke user profile</asp:ListItem>
											</asp:RadioButtonList>
										</td>
									</tr>
								</table>
							</asp:Panel>
						</asp:Panel>
					</ContentTemplate>
				</asp:UpdatePanel>
				<asp:UpdateProgress ID="uppCommentsSettings" runat="server" AssociatedUpdatePanelID="upCommentsSettings" DisplayAfter="100" DynamicLayout="true">
					<ProgressTemplate>
						<img src="<%=ModulePath%>images/settings/ajaxLoading.gif" /></ProgressTemplate>
				</asp:UpdateProgress>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlPaidContentSettings" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfPaidContentSettingsState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblPaidContentSettingsSource" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblPaidContentSettingsSource_SelectedIndexChanged">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource57">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource58">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					12</p>
				<h2>
					<%=Paidcontent%></h2>
			</div>
			<asp:Panel ID="pnlPaidContentSettingsSourceTable" runat="server" CssClass="category_content">
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblEnablePaidContent" runat="server" Text="Enable paid content:" HelpText="Enable paid content:" HelpKey="lblEnablePaidContent.HelpText" ResourceKey="lblEnablePaidContent" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbEnablePaidContent" runat="server" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblPaidContentShowComments" runat="server" Text="Show comments for non paid viewers:" HelpText="Show comments for non paid viewers:" HelpKey="lblPaidContentShowComments.HelpText" ResourceKey="lblPaidContentShowComments" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbShowCommentsOnPaidContent" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblPaidContentShowImageGallery" runat="server" Text="Show image gallery for non paid viewers:" HelpText="Show image gallery for non paid viewers:" HelpKey="lblPaidContentShowImageGallery.HelpText" ResourceKey="lblPaidContentShowImageGallery" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbShowImageGalleriesOnPaidContent" runat="server" />
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlRelatedPrintRSSSetingsSource" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfRelatedPrintRSSSetingsSourceState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblRelatedPrintRSSSetingsSource" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblRelatedPrintRSSSetingsSource_SelectedIndexChanged">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource59">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource60">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					13</p>
				<h2>
					<%=RelatedarticlesandRSS%></h2>
			</div>
			<asp:Panel ID="pnlRelatedPrintRSSSetingsSourceTable" runat="server" CssClass="category_content">
				<h3 class="subsections">
					<%=Releatedarticles%></h3>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblEnableRelatedArticles" runat="server" Text="Enable related articles:" HelpText="Enable related articles:" HelpKey="lblEnableRelatedArticles.HelpText" ResourceKey="lblEnableRelatedArticles" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbEnableRelatedArticles" runat="server" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblNumberOfReleatedArticles" runat="server" Text="Number of related articles:" HelpText="Number of related articles:" HelpKey="lblNumberOfReleatedArticles.HelpText" ResourceKey="lblNumberOfReleatedArticles" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbNumOfRelatedArticles" runat="server" Width="50px">5</asp:TextBox>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblSortRelatedArticles" runat="server" Text="Sorting of related articles:" HelpText="Sorting of related articles:" HelpKey="lblSortRelatedArticles.HelpText" ResourceKey="lblSortRelatedArticles" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlRelatedArticlesSorting" runat="server" resourcekey="ddlRelatedArticlesSortingResource1">
								<asp:ListItem resourcekey="ListItemResource61">Default</asp:ListItem>
								<asp:ListItem Value="NumberOfViews" resourcekey="ListItemResource62">Number of views</asp:ListItem>
							</asp:DropDownList>
						</td>
					</tr>
				</table>
				<table class="settings_table" cellpadding="0" cellspacing="0" style="display: none">
					<tr>
						<td class="left">
							<dnn:Label ID="lblEnablePrintArticle" runat="server" HelpText="Enable print article:" Text="Enable print article:" />
						</td>
						<td class="style1">
							<asp:CheckBox ID="cbEnablePrintArticle" runat="server" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblPrintArticleTemplate" runat="server" HelpText="Enable print article:" Text="Enable print article:" />
						</td>
						<td class="style1">
							<asp:DropDownList ID="ddlPrintArticleTemplate" runat="server">
							</asp:DropDownList>
						</td>
					</tr>
				</table>
				<h3 class="subsections">
					<%=RSS%></h3>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblEnableRSS" runat="server" Text="RSS link:" ResourceKey="lblEnableRSSResource1" HelpKey="lblEnableRSSResource1.HelpText" HelpText="RSS link for the articles from current module:" />
						</td>
						<td class="right">
							<asp:HyperLink runat="server" ID="hlRSSLink" Target="_blank">RSS Link</asp:HyperLink>
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblRSSLinkBack" runat="server" HelpText="Enter url for the RSS back link:" Text="Enter url for the RSS back link:" HelpKey="lblRSSLinkBack.HelpText" ResourceKey="lblRSSLinkBack" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbRSSUrl" runat="server" Width="285px" resourcekey="tbRSSUrlResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblRSSShowImages" runat="server" HelpText="Show article images in RSS:" Text="Show article images in RSS:" HelpKey="lblRSSShowImages.HelpText" ResourceKey="lblRSSShowImages" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbRSSShowArticleImages" runat="server" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblRSSInsertImage" runat="server" HelpKey="lblRSSInsertImage.HelpText" HelpText="If article has image insert it into RSS text summary:" ResourceKey="lblRSSInsertImage" Text="Insert image into RSS text summary:" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbRSSSInsertImageIntoSummary" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblRSSNumberOfArticles" runat="server" HelpText="Number of articles to show in RSS feed:" Text="Number of articles to show in RSS feed:" HelpKey="lblRSSNumberOfArticles.HelpText" ResourceKey="lblRSSNumberOfArticles" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbRSSNumberOfArticles" runat="server" Width="30px">20</asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvRSSNumberOfArticles" runat="server" ControlToValidate="tbRSSNumberOfArticles" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="tbRSSNumberOfArticles.ErrorMessage" ValidationGroup="vgSettings" />
							<asp:RangeValidator ID="rvRSSNumberOfArticles" runat="server" ControlToValidate="tbRSSNumberOfArticles" Display="Dynamic" ErrorMessage="Enter value between 1-100." MaximumValue="100" MinimumValue="1" resourcekey="rvRSSNumberOfArticles.ErrorMessage" SetFocusOnError="True"
								Type="Integer" ValidationGroup="vgSettings" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblRSSNumberOfCharactersInRSS" runat="server" HelpKey="lblRSSNumberOfCharactersInRSS.HelpText" HelpText="Number of character to show in RSS feed description:" ResourceKey="lblRSSNumberOfCharactersInRSS" Text="Number of character to show in RSS feed description:" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbRSSNumberOfCharactersInRSS" runat="server" Width="30px">200</asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvRSSNumberOfCharacters" runat="server" ControlToValidate="tbRSSNumberOfCharactersInRSS" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvRSSNumberOfCharacters.ErrorMessage" SetFocusOnError="True"
								ValidationGroup="vgSettings" />
							<asp:RangeValidator ID="rvRSSNumberOfCharacters" runat="server" ControlToValidate="tbRSSNumberOfCharactersInRSS" Display="Dynamic" ErrorMessage="Enter value between 1-4000." MaximumValue="4000" MinimumValue="1" resourcekey="rvRSSNumberOfCharacters.ErrorMessage"
								SetFocusOnError="True" Type="Integer" ValidationGroup="vgSettings" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblRSSShowLink" runat="server" HelpText="Show RSS link when listing articles:" Text="Show RSS link when listing articles:" ResourceKey="lblRSSShowLink" HelpKey="lblRSSShowLink.HelpText" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbRSSShowLink" runat="server" Checked="True" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblRSSDetailsData" runat="server" HelpText="Select article data for RSS description:" Text="Select article data for RSS description:" HelpKey="lblRSSDetailsData.HelpText" ResourceKey="lblRSSDetailsData" />
						</td>
						<td class="right">
							<asp:RadioButtonList ID="rblRssArticleDetailsData" runat="server" RepeatDirection="Horizontal">
								<asp:ListItem resourcekey="liArticle" Selected="True" Value="article">Article content</asp:ListItem>
								<asp:ListItem resourcekey="liArticleSummary" Value="summary">Article summary</asp:ListItem>
								<asp:ListItem resourcekey="liNothing" Value="nothing">Nothing</asp:ListItem>
							</asp:RadioButtonList>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="left">
							<h3 class="subsections">
								<%=ArticleSitemap%></h3>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblArticleSiteMap" runat="server" Text="Article Sitemap:" HelpText="Link for the article sitemap. To get the sitemap for the other languages add the query string parameter language with the value of the language local code. For example /language/en-us/."
								HelpKey="lblArticleSiteMap.HelpText" ResourceKey="lblArticleSiteMap" />
						</td>
						<td class="right">
							<asp:HyperLink runat="server" ID="hlArticleSitemap" Target="_blank">Article Sitemap</asp:HyperLink>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="left">
							<h3 class="subsections">
								<%=GoogleNewsArticleSitemap%></h3>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblGoogleNewsArticleSiteMap" runat="server" Text="Google News Article Sitemap:" 
								HelpText="Link for the article sitemap. To get the sitemap for the other languages add the query string parameter language with the value of the language local code. For example /language/en-us/." ResourceKey="lblGoogleNewsArticleSiteMap" />
						</td>
						<td class="right">
							<asp:HyperLink runat="server" ID="hlGoogleNewsArticleSiteMap" Target="_blank">Google News Article Sitemap</asp:HyperLink>
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlContentFormationSettingsSource" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfContentFormationSettingsSourceState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblContentFormationSettingsSource" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblContentFormationSettingsSource_SelectedIndexChanged">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource63">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource64">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					14</p>
				<h2>
					<%=Limitcontentformatting%></h2>
			</div>
			<asp:Panel ID="pnlContentFormationSettingsSourceTable" runat="server" CssClass="category_content">
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblLimitTitle" runat="server" Text="Limit title length:" HelpText="Limit title to number of characters (0- No limit):" HelpKey="lblLimitTitle.HelpText" ResourceKey="lblLimitTitle" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbLimitTitle" runat="server" Width="30px" resourcekey="tbLimitTitleResource1">0</asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvTitleLImit" runat="server" ControlToValidate="tbLimitTitle" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvTitleLImitResource1.ErrorMessage" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblLimitSubtitle" runat="server" Text="Limit subtitle length:" HelpText="Limit subtitle to number of characters (0- No limit):" HelpKey="lblLimitSubtitle.HelpText" ResourceKey="lblLimitSubtitle" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbLimitSubTitle" runat="server" Width="30px" resourcekey="tbLimitSubTitleResource1">0</asp:TextBox>
							<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbLimitSubTitle" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="RequiredFieldValidator2Resource1.ErrorMessage" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblLimitSummary" runat="server" Text="Limit summary length:" HelpText="Limit summary to number of characters (0- No limit):" HelpKey="lblLimitSummary.HelpText" ResourceKey="lblLimitSummary" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbLimitSummary" runat="server" Width="30px" resourcekey="tbLimitSummaryResource1">0</asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvSummaryLimit" runat="server" ControlToValidate="tbLimitSummary" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvSummaryLimitResource1.ErrorMessage" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblLimitArticle" runat="server" Text="Limit article length:" HelpText="Limit article to number of characters (0- No limit):" HelpKey="lblLimitArticle.HelpText" ResourceKey="lblLimitArticle" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbArticleLimit" runat="server" Width="30px" resourcekey="tbArticleLimitResource1">0</asp:TextBox>
							<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbArticleLimit" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="RequiredFieldValidator1Resource1.ErrorMessage" />
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlDNNSearchIntegrationMain" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfDNNSearchIntegrationState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblDNNSearchIntegrationSettingsSource" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblDNNSearchIntegrationSettingsSource_SelectedIndexChanged">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource65">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource66">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					15</p>
				<h2>
					<%=DNNSearchintegration%></h2>
			</div>
			<asp:Panel ID="pnlDNNSearchIntegration" runat="server" CssClass="category_content">
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblDNNSearchIntegration" runat="server" Text="DNN search integration:" HelpText="DNN search integration:" HelpKey="lblDNNSearchIntegration.HelpText" ResourceKey="lblDNNSearchIntegration" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbDNNSearchIntegration" runat="server" Checked="True" />
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlAuthorProfilesMain" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfAuthorProfilesState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblAuthorProfiles" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblAuthorProfiles_SelectedIndexChanged">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource67">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource68">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					16</p>
				<h2>
					<%=AuthorProfiles%></h2>
			</div>
			<asp:Panel ID="pnlAuthorProfiles" runat="server" CssClass="category_content">
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblShowAuthorsBox" runat="server" Text="Show authors profile:" HelpText="Show authors profile:" HelpKey="lblShowAuthorsBox.HelpText" ResourceKey="lblShowAuthorsBox" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbShowAuthorProfiles" runat="server" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblShowAuthorsGroupBox" runat="server" Text="Show authors group:" HelpText="Show authors group:" HelpKey="lblShowAuthorsGroupBox.HelpText" ResourceKey="lblShowAuthorsGroupBox" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbShowAuthorGroupProfiles" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblAuthorcCanEditProfile" runat="server" Text="Authors can edit thier own profile:" HelpText="Authors can edit thier own profile:" HelpKey="lblAuthorcCanEditProfile.HelpText" ResourceKey="lblAuthorcCanEditProfile" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbAuthorsCanEditThierProfile" runat="server" Checked="True" AutoPostBack="True" OnCheckedChanged="cbAuthorsCanEditThierProfile_CheckedChanged" />
						</td>
					</tr>
					<tr class="second" runat="server" id="trEOG">
						<td class="left" runat="server">
							<dnn:Label ID="lblAuthorCanEditTheirOwnGroup" runat="server" Text="Authors can edit thier own group:" HelpText="Authors can edit thier own group:" HelpKey="lblAuthorCanEditTheirOwnGroup.HelpText" ResourceKey="lblAuthorCanEditTheirOwnGroup" />
						</td>
						<td class="right" runat="server">
							<asp:CheckBox ID="cbAuthorsCanEditThierGroup" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblAuthorAlias" runat="server" Text="Enable adding author name alias per article:" HelpText="Enable adding author name alias per article:" HelpKey="lblAuthorAlias.HelpText" ResourceKey="lblAuthorAlias" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbEnableAuthorAlias" runat="server" />
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlImportedRSSArticlesMain" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfImportedRSSArticlesState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblImportedRSSArticles" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblImportedRSSArticles_SelectedIndexChanged">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource69">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource70">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					17</p>
				<h2>
					<%=ImportedarticlesfromRSS%></h2>
			</div>
			<asp:Panel ID="pnlImportedRSSArticles" runat="server" CssClass="category_content">
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblImportetRSSAsLink" runat="server" Text="Imported RSS articles will lead to original artcle:" HelpText="If checked details of imported RSS articles will not open, original article will be opened." HelpKey="lblImportetRSSAsLink.HelpText"
								ResourceKey="lblImportetRSSAsLink" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbImportedRSSASLink" runat="server" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblAddLinkToOriginalRSS" runat="server" HelpText="Add link at the end of text leading to original article." Text="Add link leading to original article:" HelpKey="lblAddLinkToOriginalRSS.HelpText" ResourceKey="lblAddLinkToOriginalRSS" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbAddLinkToOrigitalText" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblOpenRssLinksInNewWindow" runat="server" HelpText="Open RSS links in new window:" Text="Open RSS links in new window:" HelpKey="lblOpenRssLinksInNewWindow.HelpText" ResourceKey="lblOpenRssLinksInNewWindow" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbOpenRssLinksInNewWindow" runat="server" />
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlSocialSharingMain" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfSocialSharing" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<asp:RadioButtonList ID="rblSocialSharing" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CellPadding="0" CellSpacing="0" OnSelectedIndexChanged="rblSocialSharing_SelectedIndexChanged">
					<asp:ListItem Value="Portal" Selected="True" resourcekey="ListItemResource69">Default settings</asp:ListItem>
					<asp:ListItem Value="Instance" resourcekey="ListItemResource70">Module instance (override default)</asp:ListItem>
				</asp:RadioButtonList>
				<p class="section_number">
					18</p>
				<h2>
					<%=AutopostingtoJournal%></h2>
			</div>
			<asp:Panel ID="pnlNoSocialSharing" runat="server" CssClass="category_content" Visible="False">
				<asp:Label ID="lblNoSocialSharing" resourcekey="lblNoSocialSharing" runat="server" Text="This functionality is only available in DotNetNuke version 6.2 or higher." Font-Bold="True" />
			</asp:Panel>
			<asp:Panel ID="pnlSocialSharing" runat="server" CssClass="category_content">
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr runat="server" id="tblRowIsSocialInstance" style="background: #D1EBFA; display: none;">
						<td class="left" style="border: 1px solid #AAD6F1; border-right: 0;">
							<dnn:Label ID="lblIsSocialInstance" runat="server" HelpText="Displays user's and group's articles on the Activity feed. The articles are filtered by the UserID or GroupID querystring. If this option is enabled and the querystring UserID or GroupID is missing, then the articles won't show up."
								Text="Community mode:" HelpKey="lblIsSocialInstance.HelpText" ResourceKey="lblIsSocialInstance" />
						</td>
						<td class="right" style="border: 1px solid #AAD6F1; border-left: 0;">
							<asp:CheckBox ID="cbIsSocialInstance" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							<asp:Label ID="lblJournal" resourcekey="lblJournal" runat="server" Text="Journal" Font-Bold="True"></asp:Label>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblEnableJournal" runat="server" HelpText="Enable posting to Journal when article is added:" Text="Enable posting to Journal when article is added:" ResourceKey="lblEnableJournal" HelpKey="lblEnableJournal.HelpText" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbEnableJournalAddArticle" runat="server" AutoPostBack="True" OnCheckedChanged="cbEnableJournalAddArticle_CheckedChanged" />
							<br />
							<asp:Label ID="lblJournaPostingInfo" resourcekey="lblJournaPostingInfo" runat="server" Text="Select article data to post on Journal description:"></asp:Label>
							<asp:CheckBoxList ID="cblJournaPostingInfo" runat="server" Enabled="False" RepeatDirection="Horizontal">
								<asp:ListItem resourcekey="liTitle" Value="Title">Title</asp:ListItem>
								<asp:ListItem resourcekey="liSubtitle" Value="Subtitle">Subtitle</asp:ListItem>
								<asp:ListItem resourcekey="liSummary" Value="Summary">Summary</asp:ListItem>
								<asp:ListItem resourcekey="liImage" Value="Image">Image</asp:ListItem>
							</asp:CheckBoxList>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblCommentTojournal" runat="server" HelpText="Enable posting to Journal when comment is added:" Text="Enable posting to Journal when comment is added:" ResourceKey="lblCommentTojournal" HelpKey="lblCommentTojournal.HelpText" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbEnableJournalAddComment" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblUserActivityModule" runat="server" HelpText="Select module to open news details from user Journal:" Text="Select module to open news details from user Journal:" HelpKey="lblUserActivityModule.HelpText" ResourceKey="lblUserActivityModule" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlOpenDetailsFromUserJurnal" runat="server">
							</asp:DropDownList>
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblGroupActivityModule" runat="server" HelpText="Select module to open news details from group Journal:" Text="Select module to open news details from group Journal:" HelpKey="lblGroupActivityModule.HelpText" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlOpenDetailsFromGroupJurnal" runat="server">
							</asp:DropDownList>
						</td>
					</tr>
					<tr id="trSetupTwitterAppTitle" runat="server" class="second">
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							<asp:Label ID="lblTwitterTopInfo" resourcekey="lblTwitterTopInfo" runat="server" Font-Bold="True" Text="Twitter"></asp:Label>
						</td>
					</tr>
					<tr id="trSetupTwitterApp" runat="server" class="second">
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							<asp:HyperLink ID="hlToAppiConnection" resourcekey="hlToAppiConnection" runat="server" Target="_blank">To enable Twitter integration please setup Twitter app</asp:HyperLink>
						</td>
					</tr>
					<tr id="trEnableTwitter" runat="server" class="second">
						<td class="left">
							<dnn:Label ID="lblEnableTwitter" runat="server" HelpText="Enable posting to Twitter:" Text="Enable posting to Twitter:" HelpKey="lblEnableTwitter.HelpText" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbTwitterSocialSharing" runat="server" Enabled="False" resourcekey="cbImportedRSSASLinkResource1" />
						</td>
					</tr>
					<tr id="trEnableTwitterDetails" runat="server" class="second">
						<td class="left">
							<dnn:Label ID="lblTwitterDetails" runat="server" HelpText="Select module to open news details from Twitter links:" Text="Select module to open news details from Twitter links:" HelpKey="lblTwitterDetails.HelpText" ResourceKey="lblTwitterDetails" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlOpenDetailsFromTwitter" runat="server">
							</asp:DropDownList>
						</td>
					</tr>
					<tr id="trSetupTwitterApp2" runat="server" class="second">
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							<asp:Label ID="lblConectedToTwitter" runat="server" ForeColor="Red">Module Not conected to Twitter</asp:Label>
							<br />
							<asp:Label ID="lblConToTwitterError" resourcekey="lblConToTwitterError" runat="server" Text="Error while connecting to Twitter. Please check your Internet connection and your Twitter app consumer key and secret." ForeColor="Red" Visible="False"></asp:Label>
							<br />
							<asp:Button ID="btnOpenTwitterConnectionWizzard" runat="server" resourcekey="btnOpenTwitterConnectionWizzard" OnClick="btnOpenTwitterConnectionWizzard_Click" Text="Open/Close Twitter connection panel" />
						</td>
					</tr>
					<tr id="twitter0" runat="server" class="second">
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							<script type="text/javascript">
						// <![CDATA[
								jQuery(document).ready(function ($) {
									$('#twitterConnectInfoSwitch').click(function () {
										$('#twitterConnectInfo').slideToggle(150);
										return false;
									});
								});
						// ]]>
							</script>
							<a href="#" id="twitterConnectInfoSwitch">
								<%=ShowhideTwitterconnectinfo%></a>
							<div id="twitterConnectInfo" style="display: none">
								<asp:HyperLink ID="hlVisitDetailInstrictionsTwitter" resourcekey="lblConToTwitterError" runat="server" Font-Bold="True" NavigateUrl="http://www.easydnnsolutions.com/Blog/TabId/248/ArtMID/790/ArticleID/15/default.aspx" Target="_blank">For more detail instructions please visit this link.</asp:HyperLink><br />
								<asp:Label ID="lblTwitterSetup" resourcekey="lblTwitterSetup" runat="server" Text="To connect to Twitter you need to:&lt;br/&gt;1.Click on link &quot;Connect module to  Twitter account&quot;. New window will open and you need to login to Twitter and give your Twitter app to connect to your account&lt;br /&gt; 2. Copy the security code that Twitter will provide into field below. &lt;br/&gt3. Click on Connect to Twitter button.">
								</asp:Label>
								<br />
							</div>
							<br />
						</td>
					</tr>
					<tr id="twitter1" runat="server" class="second">
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							1.
							<asp:HyperLink ID="hlSetupTwitter" resourcekey="hlSetupTwitter" runat="server" Target="_blank">Connect module to Twitter account</asp:HyperLink>
						</td>
					</tr>
					<tr id="twitter2" runat="server" class="second">
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							2.
							<asp:Label ID="lblEnterTwitterPIN" resourcekey="lblEnterTwitterPIN" runat="server" Text="Enter security code provided by Twitter:"></asp:Label>
							<br />
							<asp:TextBox ID="tbTwitterPinCode" runat="server" ValidationGroup="vgTwitterConnection">
							</asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvTwitterPin" runat="server" ControlToValidate="tbTwitterPinCode" ErrorMessage="Please enter number provided by Twitter." ValidationGroup="vgTwitterConnection">
							</asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr id="twitter3" runat="server" class="second">
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							<asp:HiddenField ID="hfTwitterRequestToken" runat="server" />
							<asp:HiddenField ID="hfTwitterRequestTokenSecret" runat="server" />
							<asp:HiddenField ID="hfTwitterAccessToken" runat="server" />
							<asp:HiddenField ID="hfTwitterAccessSecret" runat="server" />
							<asp:Label ID="lblTwitterMessage" runat="server"></asp:Label>
							<br />
							3.
							<asp:Button ID="btnCheckTwitterPIN" runat="server" resourcekey="btnCheckTwitterPIN" OnClick="btnCheckTwitterPIN_Click" Text="Connect to Twitter" ValidationGroup="vgTwitterConnection" />
						</td>
					</tr>
					<tr id="trFB1Toptitle" runat="server">
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							<asp:Label ID="lblFacebookTopTitle" resourcekey="lblFacebookTopTitle" runat="server" Font-Bold="True" Text="Facebook"></asp:Label>
						</td>
					</tr>
					<tr id="trFB1" runat="server">
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							<asp:HyperLink ID="hlToAppiConnectionFB" runat="server" Target="_blank">To enable Facebook integration please setup Facebook app</asp:HyperLink>
						</td>
					</tr>
					<tr id="trFB2" runat="server">
						<td class="left">
							<dnn:Label ID="lblEnableFacebook" runat="server" HelpText="Enable posting to Facebook:" Text="Enable posting to Facebook:" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbFaceookSocialSharing" runat="server" Enabled="False" />
						</td>
					</tr>
					<tr id="trFB2Details" runat="server">
						<td class="left">
							<dnn:Label ID="lblOpenFacebookDetails" runat="server" HelpText="Select module to open news details from Facebook links:" Text="Select module to open news details from Facebook links:" ResourceKey="lblOpenFacebookDetails" HelpKey="lblOpenFacebookDetails.HelpText" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlOpenDetailsFromFacebook" runat="server">
							</asp:DropDownList>
						</td>
					</tr>
					<tr id="trFB6" runat="server">
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							<asp:Label ID="lblConectedToFacebook" runat="server" ForeColor="Red">Module Not conected to Facebook</asp:Label>
							<br />
							<asp:Label ID="lblConToFacebookError" resourcekey="lblConToFacebookError" runat="server" ForeColor="Red" Text="Error while connecting to Facebook. Please check your Internet connection and your Facebook app consumer key and secret." Visible="False"></asp:Label>
							<br />
							<asp:Button ID="btnOpenFacebookConnectionPanel" resourcekey="btnOpenFacebookConnectionPanel" runat="server" OnClick="btnOpenFacebookConnectionPanel_Click" Text="Open/Close Facebook connetion panel" />
						</td>
					</tr>
					<tr id="trFB3" runat="server">
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							<script type="text/javascript">
						// <![CDATA[
								jQuery(document).ready(function ($) {
									$('#fbConnectInfoSwitch').click(function () {
										$('#fbConnectInfo').slideToggle(150);
										return false;
									});
								});
						// ]]>
							</script>
							<a id="fbConnectInfoSwitch" href="#">
								<%=ShowhideFacebookconnectinfo%></a>
							<div id="fbConnectInfo" style="display: none">
								<asp:HyperLink ID="hlVisitDetailInstrictionsFacebook" resourcekey="hlVisitDetailInstrictionsFacebook" runat="server" Font-Bold="True" NavigateUrl="http://www.easydnnsolutions.com/Blog/TabId/248/ArtMID/790/ArticleID/15/default.aspx" Target="_blank">For more detail instructions please visit this link.</asp:HyperLink><br />
								<asp:Label ID="lblFacebookSetup" runat="server" resourcekey="lblFacebookSetup" Text="To connect to Facebook you need to:&lt;br/&gt;1.Click on link &quot;Connect to Facebook account&quot;. New window will open and you need to login to Facebook and give your Facebbok app to connect to your account&lt;br /&gt; 2. Click on button Connect to Facebook. After connected select from the dropdown list where you will post on Facebook.">
								</asp:Label>
								<br />
							</div>
							<br />
						</td>
					</tr>
					<tr id="trFB5" runat="server">
						<td class="left">
							<asp:Label runat="server" resourcekey="lblSelectFBPostTo" Text="Select where to post on Facebook:" ID="lblSelectFBPostTo" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlFacebookAccounts" runat="server">
							</asp:DropDownList>
						</td>
					</tr>
					<tr id="trFB4" runat="server">
						<td class="left">
							&nbsp;
						</td>
						<td class="right">
							1.
							<asp:HyperLink ID="hlConnectToFacebook" resourcekey="hlConnectToFacebook" runat="server" Target="_blank">Connect to Facebook account</asp:HyperLink>
							<br />
							<asp:Label ID="lblConnectToFBMessage" runat="server" />
							<br />
							2.
							<asp:Button ID="btnConnectToFacebook" runat="server" resourcekey="btnConnectToFacebook" OnClick="btnConnectToFacebook_Click" Text="Connect to Facebook" />
							<asp:HiddenField ID="hfFacebookAccessToken" runat="server" />
							<br />
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlSeoURLSettings" runat="server" CssClass="settings_category_container">
			<asp:HiddenField ID="hfSeoURLSettingsState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<table cellpadding="0" cellspacing="0" style="border-collapse: collapse;">
					<tr>
						<td>
							<asp:Label ID="lblSeoUrlPortalOnly" runat="server" Text="Portal only" resourcekey="lblSeoUrlPortalOnlyResource1" />
						</td>
					</tr>
				</table>
				<p class="section_number">
					19</p>
				<h2>
					<%=SEOURLsettings%></h2>
			</div>
			<asp:Panel ID="pnlSeoURLSettingsSourceTable" runat="server" CssClass="category_content">
				<table cellpadding="0" cellspacing="0" class="settings_table">
					<tr>
						<td class="left">
							<dnn:Label ID="lblCharaterReplace" runat="server" HelpText="List of characters to replace during link generation. The following characters are automaticly removed::.&amp;%$#" Text="List of characters to replace during link generation:" HelpKey="lblCharaterReplace.HelpText"
								ResourceKey="lblCharaterReplace" />
						</td>
						<td class="right">
							<asp:GridView ID="gvCharList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="ItemID" DataSourceID="odsGetCharList"
								ForeColor="Black" GridLines="Horizontal" EnableModelValidation="True" resourcekey="gvCharListResource1">
								<Columns>
									<asp:CommandField ShowDeleteButton="True" />
									<asp:BoundField DataField="OriginalChar" HeaderText="Old character" SortExpression="OriginalChar">
										<ItemStyle HorizontalAlign="Center" />
									</asp:BoundField>
									<asp:BoundField DataField="NewChar" HeaderText="New character" SortExpression="NewChar">
										<ItemStyle HorizontalAlign="Center" />
									</asp:BoundField>
								</Columns>
								<FooterStyle BackColor="#CCCC99" ForeColor="Black" />
								<HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
								<PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
								<SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
							</asp:GridView>
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblAddCharacter" runat="server" HelpText="Add character to list:" Text="Add character to list:" HelpKey="lblAddCharacter.HelpText" ResourceKey="lblAddCharacter" />
						</td>
						<td class="right">
							<asp:Label ID="lblOldCharacter0" runat="server" Text="Old character:" resourcekey="lblOldCharacter0Resource1" />
							<asp:TextBox ID="tbOldCharacter" runat="server" MaxLength="3" ValidationGroup="vgAddCharacter" Width="30px" />
							&nbsp;&nbsp;&nbsp;&nbsp;
							<asp:Label ID="lblNewCharacter0" runat="server" Text="New character:" resourcekey="lblNewCharacter0Resource1" />
							<asp:TextBox ID="tbNewCharacter" runat="server" MaxLength="3" ValidationGroup="vgAddCharacter" Width="30px" />
							&nbsp;
							<asp:Button ID="btnAddCharacter" runat="server" OnClick="btnAddCharacter_Click" Text="Add" ValidationGroup="vgAddCharacter" resourcekey="btnAddCharacterResource1" />
							<br />
							<asp:RequiredFieldValidator ID="rfvACOld0" runat="server" ControlToValidate="tbOldCharacter" ErrorMessage="This field is required." ValidationGroup="vgAddCharacter" resourcekey="rfvACOld0Resource1" />
							&nbsp;
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlGoogleMapsSettings" runat="server" CssClass="settings_category_container last">
			<asp:HiddenField ID="hfGoogleMapsSettingsState" runat="server" Value="collapsed" />
			<div class="category_toggle">
				<table cellpadding="0" cellspacing="0" style="border-collapse: collapse;">
					<tr>
						<td>
							<asp:Label ID="lblGoogleMapsPortalOnly" runat="server" Text="Portal only" resourcekey="lblGoogleMapsPortalOnlyResource1" />
						</td>
					</tr>
				</table>
				<p class="section_number">
					20</p>
				<h2>
					<%=Googlemapssettings%></h2>
			</div>
			<asp:Panel ID="pnlGoogleMapsSettingsSourceTable" runat="server" CssClass="category_content">
				<table cellpadding="0" cellspacing="0" class="settings_table">
					<tr>
						<td class="left">
							<dnn:Label ID="lblGOogleAPIKey" runat="server" HelpText="Google Maps Api key:" Text="Google Maps Api key:" HelpKey="lblGOogleAPIKey.HelpText" ResourceKey="lblGOogleAPIKey" />
						</td>
						<td class="right">
							<asp:TextBox ID="tbGoogleMapsApiKey" runat="server" Width="350px" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<dnn:Label ID="lblMapsUserLocationRequest" runat="server" HelpText="Ask user to share location when writing article:" Text="Ask user to share location when writing article:" HelpKey="lblMapsUserLocationRequest.HelpText" ResourceKey="lblMapsUserLocationRequest.Text" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbMapsUserLocationRequest" runat="server" Checked="True" />
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<div class="main_actions">
			<p>
				<asp:Label ID="lblSaveSettings" runat="server" EnableViewState="false" /></p>
			<p>
				<asp:Label ID="lblMainMessage" runat="server" EnableViewState="false" />
				<asp:CustomValidator ID="cvCategoriesTreeview" runat="server" ClientValidationFunction="CategoryClientValidate" Display="Dynamic" Enabled="False" ErrorMessage="Please select at least one category." ValidationGroup="vgSettings">
				</asp:CustomValidator>
			</p>
			<div class="buttons">
				<asp:Button ID="btnSaveSettings" runat="server" OnClick="btnSaveSettings_Click" Text="Save settings" ValidationGroup="vgSettings" resourcekey="btnSaveSettingsResource1" />
				<asp:Button ID="btnSaveClose" runat="server" OnClick="btnSaveClose_Click" Text="Save &amp; Close" ValidationGroup="vgSettings" resourcekey="btnSaveCloseResource1" />
				<asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Close" UseSubmitBehavior="False" resourcekey="btnCancelResource1" />
			</div>
		</div>
		<br />
	</asp:Panel>
</div>
<asp:ObjectDataSource ID="odsGetCharList" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" runat="server" DeleteMethod="DeleteCharFromList" SelectMethod="GetCharsFromListForODS">
	<DeleteParameters>
		<asp:Parameter Name="ItemID" Type="Int32" />
	</DeleteParameters>
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
