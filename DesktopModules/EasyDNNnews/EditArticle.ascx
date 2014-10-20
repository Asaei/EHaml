<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.EditArticle, App_Web_editarticle.ascx.d988a5ac" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<style type="text/css">
	.styleDisplayNone
	{
		display: none;
	}
</style>
<script type="text/javascript">
	function ConfirmDelete() {
		return confirm('<%=Localization.GetString("Areyousure.Text", this.LocalResourceFile)%>');
	}
</script>
<asp:Label ID="lblEditMessage" runat="server" Visible="False" resourcekey="lblEditMessageResource1" />
<asp:Panel ID="pnlMainWrapper" runat="server">
	<asp:Panel ID="pnlEditArticle" runat="server">
		<div id="EDNadmin">
			<div class="module_action_title_box">
				<asp:PlaceHolder ID="phAdminNavigation" runat="server"></asp:PlaceHolder>
				<h1>
					<%=EditArticleTitle%></h1>
			</div>
			<asp:Panel ID="pnlImagelocalization" CssClass="main_content" runat="server" Visible="False">
				<asp:HiddenField ID="hfImageLocaPicID" runat="server" />
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<asp:Label ID="lblContentLocalizationMediaTitle" runat="server" Font-Bold="True" Text="Media title:" resourcekey="lblContentLocalizationMediaTitleResource1" />
						</td>
						<td class="right">
							<asp:Label ID="lblContentLocalizationMediaTitleOriginal" runat="server" resourcekey="lblContentLocalizationMediaTitleOriginalResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<asp:Label ID="lblContentLocalizationMediaDescription" runat="server" Font-Bold="True" Text="Media description:" resourcekey="lblContentLocalizationMediaDescriptionResource1" />
						</td>
						<td class="right">
							<asp:Label ID="lblContentLocalizationMediaDescriptionOriginal" runat="server" resourcekey="lblContentLocalizationMediaDescriptionOriginalResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<asp:Label ID="lblPortalDefLanguage" runat="server" Text="Poratal default language:" resourcekey="lblPortalDefLanguageResource1" />
						</td>
						<td class="right">
							<asp:Label ID="lblDefaultPortalLangugageImage" runat="server" resourcekey="lblDefaultPortalLangugageImageResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<asp:Label ID="lblContentLocalizationLocalizedLanguages" runat="server" Text="Localized languages:" resourcekey="lblContentLocalizationLocalizedLanguagesResource1" />
						</td>
						<td class="right">
							<asp:Label ID="lblContentLocalizationLocalizedLanguagesList" runat="server" resourcekey="lblContentLocalizationLocalizedLanguagesListResource1" />
						</td>
					</tr>
				</table>
				<div class="text_input_set">
					<dnn:Label ID="lblContentLocalizationSelectLanguage" runat="server" HelpKey="lblContentLocalizationSelectLanguage.HelpText" HelpText="Select the languange you want to edit. There is no need to edit dafault language." Text="Select language:" ResourceKey="lblContentLocalizationSelectLanguage" />
					<asp:DropDownList ID="ddlContentLocalizationSelectLanguage" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlImageEditorContentLocalizationSelectLanguage_SelectedIndexChanged" resourcekey="ddlContentLocalizationSelectLanguageResource1" />
					<asp:LinkButton ID="btnContentLocalizationCopyDefault" CssClass="silver_button" Style="float: right;" runat="server" OnClick="btnContentLocalizationCopyDefault_Click" resourcekey="btnContentLocalizationCopyDefaultResource1">
						<span>
							<%=Copydefaultvalues%></span></asp:LinkButton>
				</div>
				<div class="text_input_set overflow_visible">
					<dnn:Label ID="lblContentLocalizationTitle" runat="server" HelpKey="lblContentLocalizationTitle.HelpText" HelpText="Title:" Text="Title:" ResourceKey="lblContentLocalizationTitle" />
					<asp:TextBox ID="tbContentLocalizationTitle" runat="server" CssClass="text s18" resourcekey="tbContentLocalizationTitleResource1" />
				</div>
				<div class="text_input_set">
					<dnn:Label ID="lblContentLocalizationDescription" runat="server" HelpKey="lblContentLocalizationDescription.HelpText" HelpText="Description:" Text="Description:" ResourceKey="lblContentLocalizationDescription" />
					<dnn:TextEditor ID="txtContentLocalizationDescription" runat="server" Height="300" Width="700" />
				</div>
				<div class="text_input_set">
					<asp:LinkButton ID="btnContentLocalizationUpdate" CssClass="silver_button" runat="server" OnClick="btnImageEditorContentLocalizationUpdate_Click" resourcekey="btnContentLocalizationUpdateResource1">
						<span>
							<%=Savelocalization%></span></asp:LinkButton>
					<asp:LinkButton ID="btnContentLocalizationClose" CssClass="silver_button" runat="server" OnClick="btnContentLocalizationClose_Click" resourcekey="btnContentLocalizationCloseResource1">
						<span>
							<%=Close%></span></asp:LinkButton>
				</div>
			</asp:Panel>
			<asp:Panel ID="pnlContentLocalizationDetails" CssClass="main_content" runat="server" Visible="False">
				<p style="margin-top: 20px;">
					<b>
						<%=Defaultportallanguage%></b>
					<asp:Label ID="lblDefaultPortalLangugage" runat="server" resourcekey="lblDefaultPortalLangugageResource1"></asp:Label>
					<div class="text_input_set" style="margin-top: 0px; overflow: visible;">
						<asp:CheckBox ID="cbHideDefaultLocale" runat="server" /><dnn:Label ID="lblHideDefaultLocale" ResourceKey="lblHideDefaultLocale" runat="server" Text="Don't show default language article when localization not selected:" HelpText="Don't show default language article when localization not selected:"
							ControlName="cbHideDefaultLocale" />
					</div>
				</p>
				<p>
					<b>
						<asp:Label ID="lblLocLangArticle" runat="server" Text="Localized languages for this article:" resourcekey="lblLocLangArticleResource1" /></b>
					<asp:Label ID="lblLocalizedLanguages" runat="server" Text="None" />
				</p>
				<div class="text_input_set">
					<asp:Label ID="lblCLSelectLanguage" runat="server" resourcekey="lblCLSelectLanguageResource1" Text="Select language:" />
					<asp:DropDownList ID="ddlCLLanguageSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCLLanguageSelect_SelectedIndexChanged" />
					<asp:LinkButton ID="lbCLCopyDefaults" runat="server" CssClass="silver_button" OnClick="lbCLCopyDefaults_Click" resourcekey="lbCLCopyDefaultsResource1" Style="float: right;">
						<span>
							<%=Copydefaultvalues%></span></asp:LinkButton>
					<asp:LinkButton ID="btnDeleteLocalization" runat="server" CssClass="silver_button" OnClick="btnDeleteLocalization_Click" resourcekey="btnDeleteLocalization" Style="float: right;">
						<span>Delete selected locale</span></asp:LinkButton>
				</div>
				<div class="text_input_set overflow_visible">
					<dnn:Label ID="lblCLTitle" runat="server" HelpKey="lblCLTitle.HelpText" HelpText="Title" ResourceKey="lblCLTitle" Text="Title" />
					<asp:TextBox ID="tbCLArticleTitle" runat="server" CssClass="text s18" resourcekey="tbCLArticleTitleResource1" />
					<asp:RequiredFieldValidator ID="rfvCLArticleTitle" runat="server" ControlToValidate="tbCLArticleTitle" CssClass="input_validation_error" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvTitleResource1" SetFocusOnError="True" ValidationGroup="vgCLEditArticle" />
				</div>
				<div class="text_input_set overflow_visible">
					<dnn:Label ID="lblCLSubtitle" runat="server" HelpKey="lblCLSubtitle.HelpText" HelpText="Subtitle" ResourceKey="lblCLSubtitle" Text="Subtitle" />
					<asp:TextBox ID="tbCLArticleSubtitle" runat="server" CssClass="text" resourcekey="tbCLArticleSubtitleResource1" />
				</div>
				<div class="collapsible_box">
					<h1 class="collapsible_box_title">
						<%=SEOsettings%>
					</h1>
					<div id="collapsible_CLseo_box_content" class="content">
						<div class="text_input_set">
							<div>
								<dnn:Label ID="lblCLArticleURL" runat="server" ControlName="tbxCLArticleURL" HelpKey="lblArticleURL.HelpText" HelpText="Article URL" ResourceKey="lblArticleURL" Text="Article URL" />
							</div>
							<asp:TextBox ID="tbxCLArticleURL" runat="server" CssClass="text narrow left" resourcekey="tbArticleURLResource1" />
							<a id="EDN_btnCLReGenerateURL" class="reset_url_btn main_action_button grey" href="#"><span>
								<%=ResetarticleURL%></span></a>
						</div>
						<div class="text_input_set">
							<label>
								<%=METAdescription%>
							</label>
							<asp:TextBox ID="tbxCLMetaDescription" runat="server" resourcekey="tbMetaDescriptionResource1" TextMode="MultiLine" />
						</div>
						<div class="text_input_set">
							<label>
								<%=METAkeywords%>
							</label>
							<asp:TextBox ID="tbxCLMetaKeywords" runat="server" resourcekey="tbMetaKeywordsResource1" TextMode="MultiLine" />
						</div>
					</div>
				</div>
				<div class="text_input_set">
					<dnn:Label ID="lblCLSummary" runat="server" HelpKey="lblCLSummary.HelpText" HelpText="Summary" ResourceKey="lblCLSummary" Text="Summary" />
					<dnn:TextEditor ID="txtCLSummary" runat="server" Height="250" Width="700" />
				</div>
				<div class="text_input_set">
					<dnn:Label ID="lblCLArticle" runat="server" HelpKey="lblCLArticle.HelpText" HelpText="Article" ResourceKey="lblCLArticle.Text" Text="Article" />
					<dnn:TextEditor ID="txtCLArticle" runat="server" Height="250" Width="700" />
				</div>
				<asp:Panel ID="pnlMainImageLocalization" runat="server">
					<div class="text_input_set">
						<dnn:Label ID="lblMainImageTitleLozalization" runat="server" HelpKey="Main image title localization." CssClass="text s18" HelpText="Article" ResourceKey="lblMainImageTitleLozalization" Text="Main image title:" />
						<asp:TextBox ID="tbMainImageTitleLozalization" runat="server" CssClass="text s18" MaxLength="500" Width="300px" />
					</div>
					<div class="text_input_set">
						<dnn:Label ID="lblMainImageDescriptionLozalization" runat="server" HelpKey="Main image description localization." HelpText="Article" ResourceKey="lblMainImageDescriptionLozalization" Text="Main image description:" />
						<asp:TextBox ID="tbMainImageDescriptionLozalization" runat="server" Height="50px" MaxLength="2000" TextMode="MultiLine" Width="450px" />
					</div>
				</asp:Panel>
				<div class="text_input_set">
					<p>
						<asp:Label ID="lblErrorInfoMsg" runat="server" EnableViewState="false" ForeColor="Red" Visible="false" />
					</p>
					<asp:LinkButton ID="lbCLSaveLocalization" runat="server" CausesValidation="true" CssClass="silver_button" OnClick="lbCLSaveLocalization_Click" resourcekey="lbCLSaveLocalizationResource1" ValidationGroup="vgCLEditArticle">
						<span>Save localization</span></asp:LinkButton>
					<asp:LinkButton ID="lbCancelLocalization" runat="server" CssClass="silver_button" OnClick="lbCancelLocalization_Click" resourcekey="lbCancelLocalizationResource1">
						<span>Close</span></asp:LinkButton>
				</div>
				<p>
				</p>
				<p>
				</p>
				<p>
				</p>
				<p>
				</p>
				<p>
				</p>
				<p>
				</p>
				<p>
				</p>
				<p>
				</p>
				<p>
				</p>
				<p>
				</p>
				<p>
				</p>
				<p>
				</p>
				<p>
				</p>
				</p>
			</asp:Panel>
			<asp:Panel ID="pnlMainEdit" runat="server" CssClass="main_content">
				<div class="text_input_set">
					<asp:LinkButton ID="lbLocalizeContent" runat="server" OnClick="lbLocalizeContent_Click" CssClass="content_localization_btn" resourcekey="lbLocalizeContentResource1">
						<span>Content localization</span></asp:LinkButton>
				</div>
				<div class="text_input_set overflow_visible no_margin">
					<dnn:Label ID="lblArticleTitle" runat="server" Text="Title" HelpText="Article Title" HelpKey="lblArticleTitle.HelpText" ResourceKey="lblArticleTitle" />
					<asp:RequiredFieldValidator ID="rfvTitle" runat="server" ErrorMessage="This field is required." ValidationGroup="vgEditArticle" ControlToValidate="tbArticleTitle" SetFocusOnError="True" CssClass="input_validation_error" Display="Dynamic" resourcekey="rfvTitleResource1" />
					<asp:TextBox ID="tbArticleTitle" runat="server" CssClass="text s18" MaxLength="200" resourcekey="tbArticleTitleResource1" />
				</div>
				<div id="pnlSubTitle" runat="server" class="text_input_set overflow_visible">
					<dnn:Label ID="lblSubtitle" runat="server" Text="Subtitle:" HelpText="Subtitle:" HelpKey="lblSubtitle.HelpText" ResourceKey="lblSubtitle" />
					<asp:TextBox ID="txtSubtitle" runat="server" CssClass="text" MaxLength="4000" resourcekey="txtSubtitleResource1" />
				</div>
				<div id="pnlSEO" runat="server" class="collapsible_box">
					<h1 class="collapsible_box_title">
						<%=SEOsettings%></h1>
					<div class="content" id="collapsible_seo_box_content">
						<div class="text_input_set">
							<div>
								<dnn:Label ID="lblArticleURL" runat="server" HelpText="Article URL" Text="Article URL" ControlName="tbArticleURL" HelpKey="lblArticleURL.HelpText" ResourceKey="lblArticleURL" />
							</div>
							<asp:TextBox ID="tbArticleURL" runat="server" CssClass="text narrow left" resourcekey="tbArticleURLResource1" />
							<a id="EDN_btnReGenerateURL" class="reset_url_btn main_action_button grey" href="#"><span>
								<%=ResetarticleURL%></span></a>
						</div>
						<div class="text_input_set">
							<label>
								<%=METAdescription%></label>
							<asp:TextBox ID="tbMetaDescription" runat="server" TextMode="MultiLine" resourcekey="tbMetaDescriptionResource1" />
						</div>
						<div class="text_input_set">
							<label>
								<%=METAkeywords%></label>
							<asp:TextBox ID="tbMetaKeywords" runat="server" TextMode="MultiLine" resourcekey="tbMetaKeywordsResource1" />
						</div>
					</div>
				</div>
				<div id="pnlCategoriesSelection" class="section_box white_border_1 cyan" runat="server">
					<h1 class="section_box_title">
						<span>
							<%=Categories%></span></h1>
					<div class="content category_selection">
						<asp:Label ID="lblCategoryPermissionsInfo" runat="server" ForeColor="Red" Visible="False" resourcekey="lblCategoryPermissionsInfoResource1" />
						<asp:Label ID="lblCategorySelectError" runat="server" ForeColor="Red" Text="Please select category." Visible="False" resourcekey="lblCategorySelectErrorResource1"></asp:Label>
						<asp:TreeView ID="tvCatAndSubCat" runat="server" EnableViewState="False" ForeColor="Black" NodeWrap="True" ShowCheckBoxes="All" ShowLines="True" CssClass="category_tree_view" />
					</div>
				</div>
				<div id="pnlSummary" runat="server" class="text_input_set">
					<dnn:Label ID="lblArticleSummary" runat="server" Text="Summary:" HelpText="Article summary:" ControlName="txtSummary" HelpKey="lblArticleSummary.HelpText" ResourceKey="lblArticleSummary" Visible="True" />
					<dnn:TextEditor ID="txtSummary" runat="server" Height="250" Width="720" />
				</div>
				<div id="pnlDetailTypeSelection" runat="server" class="section_box white_border_1 cyan" style="border-bottom: 0;">
					<h1 class="section_box_title">
						<span>
							<%=Articledetailtype %></span></h1>
					<div class="content detail_type_selection">
						<asp:RadioButtonList ID="rblDetailType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblDetailType_SelectedIndexChanged" RepeatDirection="Horizontal">
							<asp:ListItem Value="Text" Selected="True" resourcekey="ListItemResource1">Text/HTML</asp:ListItem>
							<asp:ListItem Value="Page" resourcekey="ListItemResource2">Page</asp:ListItem>
							<asp:ListItem Value="File" resourcekey="ListItemResource3">File</asp:ListItem>
							<asp:ListItem Value="Link" resourcekey="ListItemResource4">Link</asp:ListItem>
							<asp:ListItem Value="None" resourcekey="ListItemResource5">None</asp:ListItem>
						</asp:RadioButtonList>
					</div>
				</div>
				<div id="pnlDetailTypePanels" runat="server" class="section_box white_border_1 cyan" style="border-top: 0; margin: 0; background: #ebfafe;">
					<asp:Panel ID="pnlDetailTypeText" CssClass="text_input_set" runat="server">
						<dnn:Label ID="lblContent" runat="server" Text="Content:" HelpText="Article content:" ControlName="txtContent" HelpKey="lblContent.HelpText" ResourceKey="lblContent" />
						<dnn:TextEditor ID="txtContent" runat="server" Height="500" Width="700" />
						<p class="article_content_bottom_actions">
							<a href="#" onclick="jQuery(this).parent().siblings('div.avalible_article_tokens').toggle(200); return false;">Show/Hide token list</a>
						</p>
						<div class="avalible_article_tokens">
							<asp:TextBox ID="tbTokenList" runat="server" ReadOnly="True" TextMode="MultiLine" Height="93px" Width="650px" resourcekey="tbTokenListResource1" /></div>
					</asp:Panel>
					<asp:Panel ID="pnlDetailTypePage" Style="width: 500px; margin: 15px auto 0;" runat="server" Visible="False">
						<Portal:URL ID="ctlURL" runat="server" Width="250" ShowNewWindow="False" ShowUsers="False" ShowFiles="False" ShowLog="False" ShowSecure="False" ShowTabs="False" ShowTrack="False" ShowUpLoad="False" ShowUrls="False" ShowDatabase="False" UrlType="U" />
						<asp:Label ID="lblSelectDetailTarget" runat="server" Text="Select target:" AssociatedControlID="ddlDetailTarget" resourcekey="lblSelectDetailTargetResource1"></asp:Label>
						<asp:DropDownList ID="ddlDetailTarget" runat="server">
							<asp:ListItem resourcekey="ListItemResource6">_self</asp:ListItem>
							<asp:ListItem resourcekey="ListItemResource7">_blank</asp:ListItem>
							<asp:ListItem resourcekey="ListItemResource8">_parent</asp:ListItem>
							<asp:ListItem resourcekey="ListItemResource9">_top</asp:ListItem>
						</asp:DropDownList>
					</asp:Panel>
				</div>
				<asp:UpdatePanel ID="upArticleTags" runat="server" UpdateMode="Conditional">
					<ContentTemplate>
						<div class="text_input_set">
							<dnn:Label ID="lblArticleTags" runat="server" HelpText="Article tags separated by comma ( , ):" Text="Article tags:" ControlName="tbTags" HelpKey="lblArticleTags.HelpText" ResourceKey="lblArticleTags" />
							<asp:TextBox ID="tbTags" runat="server" CssClass="text" resourcekey="tbTagsResource1" />
						</div>
						<div class="collapsible_box no_margin visible" id="add_existing_tags_box">
							<h1 class="collapsible_box_title close">
								<%=ADDEXISTINGTAGS%></h1>
							<div class="content">
								<div class="tag_collection">
									<ul class="tag_selection_menu">
										<li class="spaced">
											<asp:LinkButton ID="lbAllAddedTags" runat="server" OnClick="lbAllAddedTags_Click"><%=AllTags%></asp:LinkButton></li>
										<li class="spaced">
											<asp:LinkButton ID="lbMostPopularTags" runat="server" OnClick="lbMostPopularTags_Click" resourcekey="lbMostPopularTagsResource1">MOST POPULAR FIRST</asp:LinkButton></li>
										<li class="spaced">
											<asp:LinkButton ID="lbLastAddedTags" runat="server" OnClick="lbLastAddedTags_Click" resourcekey="lbLastAddedTagsResource1">LAST ADDED FIRST</asp:LinkButton></li>
									</ul>
									<asp:DataList ID="dlListOfExistingTags" runat="server" RepeatColumns="5" OnItemCommand="dlListOfExistingTags_ItemCommand" RepeatDirection="Horizontal" CssClass="existing_tag_list">
										<ItemTemplate>
											<asp:LinkButton ID="lbAddTag" runat="server" CommandName="AddTag" CommandArgument='<%# Eval("Name") %>' resourcekey="lbAddTagResource1" CssClass="tag_link"><%#Eval("Name")%><span class="addtag"></span></asp:LinkButton>
										</ItemTemplate>
									</asp:DataList>
									<asp:GridView ID="gvTagsPaging" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="0" CssClass="existing_tag_list_pagination article_pager" DataSourceID="odsGetTagsByName" EnableModelValidation="True" GridLines="None" OnPageIndexChanged="gvTagsPaging_PageIndexChanged"
										OnPageIndexChanging="gvTagsPaging_PageIndexChanging1" PageSize="50">
										<Columns>
											<asp:BoundField DataField="Name" Visible="False" />
										</Columns>
									</asp:GridView>
								</div>
							</div>
						</div>
					</ContentTemplate>
				</asp:UpdatePanel>
				<div class="content_token_generator gallery_item">
				</div>
				<asp:UpdatePanel ID="upArticleImages" runat="server" UpdateMode="Conditional">
					<ContentTemplate>
						<asp:Panel ID="pnlArticleImage" CssClass="section_box white_border_1 cyan" runat="server" Visible="False">
							<h1 class="section_box_title">
								<span>
									<%=Mainarticleimage %></span></h1>
							<div class="content main_article_image">
								<div class="left_col">
									<asp:Image ID="imgArticleImage" runat="server" resourcekey="imgArticleImageResource1" />
								</div>
								<div class="right_col">
									<asp:Label ID="lblSetImageMessage" runat="server" resourcekey="lblSetImageMessageResource1"></asp:Label>
									<p>
										<asp:CheckBox ID="cbShowMainArticleImageList" runat="server" Checked="True" Text="Show article image on article list" Width="300px" resourcekey="cbShowMainArticleImageListResource1" /></p>
									<p>
										<asp:CheckBox ID="cbShowMainArticleImage" runat="server" Checked="True" Text="Show main article image" resourcekey="cbShowMainArticleImageResource1" />
										<asp:RadioButtonList runat="server" ID="rblSelectMainImageEmbedType" RepeatDirection="Horizontal" Visible="False" Style="margin-left: 15px">
											<asp:ListItem resourcekey="liImage" Value="Image" Selected="True">Image</asp:ListItem>
											<asp:ListItem resourcekey="liVideo" Value="Video">Video</asp:ListItem>
										</asp:RadioButtonList>
									</p>
									<div class="info_box check_sign">
										<asp:LinkButton ID="btnRemoveArticleImage" runat="server" CssClass="action remove_btn" OnClick="btnRemoveArticleImage_Click" Text="Remove" resourcekey="btnRemoveArticleImageResource1" /><p>
											<%=ThisImage%></p>
									</div>
								</div>
								<asp:Panel ID="pnlImageTitleDescription" CssClass="section_actions_mainimage" Style="clear: left;" runat="server">
									<asp:HyperLink ID="hlOpenImageTitleDescriptionOptions" runat="server" CssClass="icon down_arrows" href="#"><%=ImgeTitleDescriptionSettings%></asp:HyperLink>
									<asp:Panel ID="pnlImageTitleDescriptionOptions" runat="server" Style="display: none;">
										<div style="text-align: left; padding-left: 30px; padding-bottom: 20px;" class="edit_fields">
											<span style="display: block; padding-top: 5px;">
												<%=Title%>:</span>
											<asp:TextBox ID="tbMainImageTitle" runat="server" MaxLength="500" Width="300px" />
											<span style="display: block; padding-top: 10px;">
												<%=Description%>:</span>
											<asp:TextBox ID="tbMainImageDescription" runat="server" Height="50px" MaxLength="2000" TextMode="MultiLine" Width="450px" />
										</div>
									</asp:Panel>
								</asp:Panel>
							</div>
						</asp:Panel>
						<asp:Panel ID="pnlIncludedGalleries" CssClass="section_box white_border_1 dark_blue" runat="server" Visible="False">
							<h1 class="section_box_title">
								<span>
									<%=Galleriesincluded%></span></h1>
							<div class="content included_galleries">
								<ul id="EDN_admin_included_galleries">
									<asp:Repeater ID="repIncludedGalleries" runat="server" OnItemCommand="repIncludedGalleries_ItemCommand">
										<ItemTemplate>
											<li>
												<div class="left">
												</div>
												<div class="middle">
													<p class='gallery_title <%# GetDotClass(Eval("GalleryID")) %>'>
														<%#Eval("GalleryName")%>
														<asp:Label ID="lblIntGalCategoryName" runat="server" Text='<%# GetCategoryName(Eval("GalleryID")) %>' resourcekey="lblIntGalCategoryNameResource1"></asp:Label></p>
													<p class="gallery_actions">
														<asp:HiddenField ID="hfGalIntID" runat="server" Value='<%# Eval("GalleryID") %>' />
														<asp:LinkButton ID="lbOpenIntegratedGallery" CssClass="gallery_settings" CommandName="OpenIntGallery" CommandArgument='<%# Eval("GalleryID") %>' title="Open this gallery" runat="server" resourcekey="lbOpenIntegratedGalleryResource1" />
														<span class="border"></span><a href="#" class="up_down_arrows" title="Rearange this gallery's position by dragging and droping it"></a><span class="border"></span>
														<asp:LinkButton ID="imbDeleteIntegratedArticle" CssClass="remove" CommandName="DeleteRow" CommandArgument='<%# Container.ItemIndex %>' title="Remove the gallery from this article" runat="server" resourcekey="imbDeleteIntegratedArticleResource1" />
														<input type="hidden" name="EDN_Included_Gals" value='<%# Eval("GalleryID") %>' />
													</p>
												</div>
												<div class="right">
												</div>
											</li>
										</ItemTemplate>
									</asp:Repeater>
								</ul>
								<asp:Panel ID="pnlViewGallerySettings" CssClass="section_actions" runat="server" Visible="False">
									<asp:HyperLink ID="lbGallerySettings" runat="server" CssClass="icon down_arrows" href="#" resourcekey="lbGallerySettingsResource1">View settings</asp:HyperLink>
									<asp:Panel ID="pnlGallerySettings" runat="server" Style="display: none;">
										<table style="width: 600px;" class="settings_table">
											<tr>
												<td>
													<dnn:Label ID="lblGIGalleryType" runat="server" HelpText="Gallery display type:" Text="Gallery display type:" ResourceKey="lblGIGalleryType" HelpKey="lblGIGalleryType.HelpText" />
												</td>
												<td class="text_left">
													<asp:DropDownList ID="ddlGalleryDisplayType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlGalleryDisplayType_SelectedIndexChanged">
														<asp:ListItem Value="lightbox" resourcekey="ListItemResource10">Lightbox gallery</asp:ListItem>
														<asp:ListItem Value="audio" resourcekey="ListItemResource11">Audio gallery</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource12" Value="video">Video gallery</asp:ListItem>
													</asp:DropDownList>
												</td>
											</tr>
											<tr>
												<td>
													<dnn:Label ID="lblGIGalleryPosition" runat="server" HelpText="Gallery position:" Text="Gallery position:" ResourceKey="lblGIGalleryPosition" HelpKey="lblGIGalleryPosition.HelpText" Visible="True" />
												</td>
												<td class="text_left">
													<asp:DropDownList ID="ddlGalleryPosition" runat="server">
														<asp:ListItem Value="bottom" resourcekey="ListItemResource13" Selected="True">Bottom position</asp:ListItem>
														<asp:ListItem Value="top" resourcekey="ListItemResource14">Top position</asp:ListItem>
													</asp:DropDownList>
												</td>
											</tr>
											<tr>
												<td>
													<dnn:Label ID="lblFixedResponsiveLayout" runat="server" HelpText="Fixed or responsive layout:" Text="Fixed or responsive layout:" HelpKey="lblFixedResponsiveLayout.HelpText" ResourceKey="lblFixedResponsiveLayout" />
												</td>
												<td>
													<asp:RadioButtonList ID="rblFixedResponsiveLayoutTypeSelect" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblFixedResponsiveLayoutTypeSelect_SelectedIndexChanged">
														<asp:ListItem resourcekey="liFixed" Selected="True" Value="fixed">Fixed Layout</asp:ListItem>
														<asp:ListItem resourcekey="liResponsive" Value="responsive">Responsive Layout</asp:ListItem>
													</asp:RadioButtonList>
												</td>
											</tr>
											<tr>
												<td>
													<dnn:Label ID="lblGIPagerStyle" runat="server" HelpText="Pager style:" Text="Pager style:" Visible="False" />
												</td>
												<td class="text_left">
													<asp:DropDownList ID="ddlGIPagerStyle" runat="server" Visible="False" resourcekey="ddlGIPagerStyleResource1">
														<asp:ListItem resourcekey="ListItemResource15">Numeric</asp:ListItem>
														<asp:ListItem Value="NextPrevious" resourcekey="ListItemResource16">Arrows (Next, Previous)</asp:ListItem>
														<asp:ListItem Value="NextPreviousFirstLast" resourcekey="ListItemResource17">Arrows (Next, Previous, First, Last)</asp:ListItem>
													</asp:DropDownList>
												</td>
											</tr>
										</table>
										<asp:Panel ID="pnlChameleonGallery" runat="server" Visible="False">
											<table style="width: 600px;" class="settings_table">
												<tr>
													<td>
														<dnn:Label ID="lblGalleryWidth" runat="server" HelpText="Gallery width." Text="Gallery width:" HelpKey="lblGalleryWidth.HelpText" ResourceKey="lblGalleryWidth" />
													</td>
													<td class="text_left">
														<asp:TextBox ID="tbxGalleryWidth" runat="server" Width="50px">700</asp:TextBox>
														<asp:Label ID="lblChamMainPanelWidthType" runat="server" Text="%" Visible="False"></asp:Label>
														<asp:RequiredFieldValidator ID="rfvRhumbImageWidth" runat="server" ControlToValidate="tbxGalleryWidth" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvRhumbImageWidth0Resource1" Display="Dynamic"></asp:RequiredFieldValidator>
														<asp:CompareValidator ID="cvLightBoxGalleryNumberOfItems" runat="server" ControlToValidate="tbxGalleryWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" resourcekey="cvLightBoxGalleryNumberOfItemsResource1"
															SetFocusOnError="True"></asp:CompareValidator>
														<asp:RangeValidator ID="rvChameleonWidthPerct" runat="server" ControlToValidate="tbxGalleryWidth" Display="Dynamic" Enabled="False" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" resourcekey="rvChameleonWidthPerct.ErrorMessage"
															SetFocusOnError="True" Type="Integer" ValidationGroup="vgEditArticle" Visible="False"></asp:RangeValidator>
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGalleryHeight" runat="server" HelpText="Gallery height." Text="Gallery height:" ResourceKey="lblGalleryHeight" HelpKey="lblGalleryHeight.HelpText" />
													</td>
													<td class="text_left">
														<asp:TextBox ID="tbxGalleryHeight" runat="server" Width="50px">600</asp:TextBox>
														<asp:Label ID="lblChamMainPanelHeightType" runat="server" Text="px" Visible="False"></asp:Label>
														<asp:RequiredFieldValidator ID="rfvRhumbImageWidth1" runat="server" ControlToValidate="tbxGalleryHeight" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvRhumbImageWidth1Resource1"></asp:RequiredFieldValidator>
														<asp:CompareValidator ID="cvLightBoxGalleryHeight" runat="server" ControlToValidate="tbxGalleryHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" resourcekey="cvLightBoxGalleryNumberOfItems0Resource1"></asp:CompareValidator>
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblChameleonLayout" runat="server" HelpText="Gallery layout" Text="Gallery layout:" ResourceKey="lblChameleonLayout" HelpKey="lblChameleonLayout.HelpText" />
													</td>
													<td class="text_left">
														<asp:DropDownList ID="ddlChameleonLayout" runat="server">
														</asp:DropDownList>
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblChameleonLayoutTheme" runat="server" HelpText="Chameleon theme:" Text="Chameleon theme:" ResourceKey="lblChameleonLayoutTheme" HelpKey="lblChameleonLayoutTheme.HelpText" />
													</td>
													<td class="text_left">
														<asp:DropDownList ID="ddlChameleonGalleryThemeSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlChameleonGalleryThemeSelect_SelectedIndexChanged">
														</asp:DropDownList>
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblChameleonLayoutThemeStyle" runat="server" HelpText="Chameleon theme style:" Text="Chameleon theme style:" ResourceKey="lblChameleonLayoutThemeStyle" HelpKey="lblChameleonLayoutThemeStyle.HelpText" />
													</td>
													<td class="text_left">
														<asp:DropDownList ID="ddlChameleonGalleryThemeSelectStyling" runat="server">
														</asp:DropDownList>
													</td>
												</tr>
											</table>
										</asp:Panel>
										<asp:Panel ID="pnlOldGalleryes" runat="server">
											<table style="width: 600px;" class="settings_table">
												<tr>
													<td>
														<dnn:Label ID="lblGIImagesResize" runat="server" HelpText="Resize and crop images. If un-checked images will be resized proportionaly.:" Text="Resize and crop images:" Visible="False" />
													</td>
													<td class="text_left">
														<asp:CheckBox ID="cbGICropImages" runat="server" resourcekey="cbGICropImagesResource1" Visible="False" />
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGIThumbWidth" runat="server" HelpText="Thumbnail width:" Text="Thumbnail width:" ResourceKey="lblGIThumbWidth" HelpKey="lblGIThumbWidth.HelpText" />
													</td>
													<td class="text_left">
														<asp:TextBox ID="tbGIThumbnailWidth" runat="server" Width="50px">100</asp:TextBox>
														<asp:RequiredFieldValidator ID="rfvGIThumbanilWidth" runat="server" ControlToValidate="tbGIThumbnailWidth" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvGIThumbanilWidthResource1" SetFocusOnError="True" ValidationGroup="vgAddArticle" />
														<asp:CompareValidator ID="cvGIThumbnailWidth" runat="server" ControlToValidate="tbGIThumbnailWidth" ErrorMessage="Please enter number." Operator="DataTypeCheck" resourcekey="cvGIThumbnailWidthResource1" Type="Integer" ValidationGroup="vgAddArticle"></asp:CompareValidator>
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGIThumbHeight" runat="server" HelpText="Thumbnail height:" Text="Thumbnail height:" ResourceKey="lblGIThumbHeight" HelpKey="lblGIThumbHeight.HelpText" />
													</td>
													<td class="text_left">
														<asp:TextBox ID="tbGIThumbnailHeight" runat="server" Width="50px">100</asp:TextBox>
														<asp:RequiredFieldValidator ID="rfvGIThumbanilHeight" runat="server" ControlToValidate="tbGIThumbnailHeight" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgAddArticle" resourcekey="rfvGIThumbanilHeightResource1" />
														<asp:CompareValidator ID="cvGIThumbnailHeight" runat="server" ControlToValidate="tbGIThumbnailHeight" ErrorMessage="Please enter number." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAddArticle" resourcekey="cvGIThumbnailHeightResource1"></asp:CompareValidator>
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGIItemsPerPage" runat="server" HelpText="Items per page:" Text="Items per page:" HelpKey="lblGIItemsPerPage.HelpText" ResourceKey="lblGIItemsPerPage" />
													</td>
													<td class="text_left">
														<asp:TextBox ID="tbGIItemsPerPage" runat="server" Width="50px" resourcekey="tbGIItemsPerPageResource1">4</asp:TextBox>
														<asp:RequiredFieldValidator ID="rfvGIItemsPerPage" runat="server" ControlToValidate="tbGIItemsPerPage" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgAddArticle" resourcekey="rfvGIItemsPerPageResource1" />
														<asp:CompareValidator ID="cvGINumber" runat="server" ControlToValidate="tbGIItemsPerPage" ErrorMessage="Please enter number." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAddArticle" resourcekey="cvGINumberResource1"></asp:CompareValidator>
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGINumberOfColumns" runat="server" HelpText="Number of columns:" Text="Number of columns:" HelpKey="lblGINumberOfColumns.HelpText" ResourceKey="lblGINumberOfColumns" />
													</td>
													<td class="text_left">
														<asp:TextBox ID="tbNumberOfColumns" runat="server" resourcekey="tbNumberOfColumnsResource1" Width="50px">4</asp:TextBox>
														<asp:RequiredFieldValidator ID="rfvGIItemsPerPage0" runat="server" ControlToValidate="tbNumberOfColumns" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvGIItemsPerPage0Resource1" SetFocusOnError="True" ValidationGroup="vgAddArticle" />
														<asp:CompareValidator ID="cvGINumber0" runat="server" ControlToValidate="tbNumberOfColumns" ErrorMessage="Please enter number." Operator="DataTypeCheck" resourcekey="cvGINumber0Resource1" Type="Integer" ValidationGroup="vgAddArticle"></asp:CompareValidator>
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGIDisplayItemTitle" runat="server" HelpText="Display item title:" Text="Display item title:" ResourceKey="lblGIDisplayItemTitle" HelpKey="lblGIDisplayItemTitle.HelpText" />
													</td>
													<td class="text_left">
														<asp:CheckBox ID="cbGIDisplayItemTitle" runat="server" />
													</td>
												</tr>
												<tr id="rowOldGalleryTitleLightbox" runat="server">
													<td>
														<dnn:Label ID="lblGIDisplayItemTitleLightBox" runat="server" HelpText="Display item title in Lightbox:" Text="Display item title in Lightbox:" ResourceKey="lblGIDisplayItemTitleLightBox" HelpKey="lblGIDisplayItemTitleLightBox.HelpText" />
													</td>
													<td class="text_left">
														<asp:CheckBox ID="cbGIDisplayItemTitleLightBox" runat="server" />
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGIDisplayItemDescription" runat="server" HelpText="Display item description:" Text="Display item description:" HelpKey="lblGIDisplayItemDescription.HelpText" ResourceKey="lblGIDisplayItemDescription" />
													</td>
													<td class="text_left">
														<asp:CheckBox ID="cbGIDisplayItemDescription" runat="server" />
													</td>
												</tr>
												<tr id="rowOldGalleryDescriptionLightbox" runat="server">
													<td>
														<dnn:Label ID="lblGIDisplayItemDescriptionLightBox" runat="server" HelpText="Display item description in Lightbox:" Text="Display item description in Lightbox:" ResourceKey="lblGIDisplayItemDescriptionLightBox" HelpKey="lblGIDisplayItemDescriptionLightBox.HelpText" />
													</td>
													<td class="text_left">
														<asp:CheckBox ID="cbGIDisplayItemDescriptionLightBox" runat="server" resourcekey="cbGIDisplayItemDescriptionLightBoxResource1" />
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGIGalleryTheme" runat="server" HelpText="Gallery theme:" Text="Gallery theme:" ResourceKey="lblGIGalleryTheme" HelpKey="lblGIGalleryTheme.HelpText" />
													</td>
													<td class="text_left">
														<asp:DropDownList ID="ddlGalleryTheme" runat="server" />
													</td>
												</tr>
											</table>
										</asp:Panel>
									</asp:Panel>
								</asp:Panel>
							</div>
						</asp:Panel>
						<div class="section_box">
							<h1 class="section_box_title">
								<span>
									<%=GalleryPanel%></span></h1>
							<ul class="tabs">
								<li>
									<asp:LinkButton ID="lbArticleGalleryImages" runat="server" CssClass="btnArticleimages" OnClick="lbArticleGallery_Click" resourcekey="lbArticleGalleryImagesResource1">ARTICLE<span class="blue dot"></span></asp:LinkButton></li>
								<li>
									<asp:LinkButton ID="lbSharedArticleGalleryImages" runat="server" CssClass="btnArticleimages" OnClick="lbSharedArticleGallery_Click" resourcekey="lbSharedArticleGalleryImagesResource1">SHARED</asp:LinkButton></li>
								<li>
									<asp:LinkButton ID="lbCustomGallery" runat="server" CssClass="btnArticleimages" OnClick="lbCustomGallery_Click" resourcekey="lbCustomGalleryResource1">CUSTOM<span class="yellow dot"></span></asp:LinkButton></li>
							</ul>
							<div class="content tabbed dark_blue">
								<asp:Panel ID="pnlCustomIntegrationAndUpload" runat="server" Visible="False">
									<div class="edg_gallery_selection_container">
										<div class="category_and_gallery_selection">
											<div class="category selection">
												<asp:Label ID="lblCategorySelect" runat="server" Text="Select category:" resourcekey="lblCategorySelectResource1" />
												<asp:DropDownList ID="ddlCategories" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataTextField="CategoryName" DataValueField="CategoryID" OnDataBound="ddlCategories_DataBound" OnSelectedIndexChanged="ddlCategories_SelectedIndexChanged">
													<asp:ListItem Value="0" resourcekey="ListItemResource18">Select category</asp:ListItem>
												</asp:DropDownList>
											</div>
											<div class="gallery selection">
												<asp:Label ID="lblGallerySelect" runat="server" Text="Select gallery: " resourcekey="lblGallerySelectResource1" />
												<asp:DropDownList ID="ddlGaleries" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataTextField="GalleryName" DataValueField="GalleryID" OnDataBound="ddlGaleries_DataBound" OnSelectedIndexChanged="ddlGaleries_SelectedIndexChanged">
													<asp:ListItem Value="-2" resourcekey="ListItemResource19">Select gallery</asp:ListItem>
												</asp:DropDownList>
											</div>
											<asp:LinkButton ID="btnRefrehsData" runat="server" CssClass="refresh" OnClick="btnRefrehsData_Click" resourcekey="btnRefrehsDataResource1" />
										</div>
										<div class="actions">
											<asp:LinkButton ID="btnIntegGallery" runat="server" CssClass="add_gallery_to_article" OnClick="btnIntegGallery_Click" Text="Add gallery to article" resourcekey="btnIntegGalleryResource1" />
										</div>
									</div>
									<asp:Button ID="btnOpenEasyDnnGallery" runat="server" OnClick="btnOpenEasyDnnGallery_Click" OnClientClick="SetTarget();" Text="Open gallery" Visible="False" resourcekey="btnOpenEasyDnnGalleryResource1" />
									<asp:DropDownList ID="ddlEasyDNNGalleryList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlEasyDNNGalleryList_SelectedIndexChanged" Visible="False" resourcekey="ddlEasyDNNGalleryListResource1">
									</asp:DropDownList>
									<asp:Panel ID="pnlGalleryMediaUpload" CssClass="uploadify_container" runat="server" Visible="False">
										<div style="display: block; float: left; margin-left: 30px;">
											<asp:FileUpload ID="GalfileInput" runat="server" resourcekey="GalfileInputResource1" />
										</div>
										<div style="display: block; float: left; margin-left: 15px;">
											<a class="start_upload" href="javascript:<%=jQueryPrefix%>('#<%=GalfileInput.ClientID%>').uploadifySettings('scriptData', { 'foo': '<%=ddlGaleries.SelectedValue%>','resize':document.getElementById('<%=hfResize.ClientID%>').value, 'width': document.getElementById('<%=hfResizeWidth.ClientID%>').value,'height':document.getElementById('<%=hfResizeHeight.ClientID%>').value});<%=jQueryPrefix%>('#<%=GalfileInput.ClientID%>').uploadifyUpload();">
												<%=StartUpload%></a>
										</div>
										<asp:Button ID="Button3" runat="server" OnClick="Button2_Click" Text="Button" Style="display: none;" resourcekey="Button3Resource1" />
										<div class="add_video_by_url">
											<p>
												<asp:Label runat="server" resourcekey="addVideoFromYouTube" Text="Add video from YouTube or Vimeo:" ID="lblCustomAddEmbedToGallery"></asp:Label>
												<asp:TextBox runat="server" ID="tbCustomEmbedVideoURL" ValidationGroup="vgCustomAddEmbedVideo" onblur="if(this.value=='') {this.value=this.defaultValue;}" onfocus="if(this.defaultValue==this.value) {this.value = '';}" value="Enter video URL..."></asp:TextBox>
												<asp:LinkButton runat="server" ID="lbCustomAddEmedVideoToGallery" class="add_video" ValidationGroup="vgCustomAddEmbedVideo" OnClick="lbCustomAddEmedVideoToGallery_Click">Add video</asp:LinkButton>
											</p>
											<p class="validators">
												<asp:CustomValidator ID="cvCustomAddEmbedVideo" runat="server" ClientValidationFunction="ClientValidateEmbedURL" Display="Dynamic" ErrorMessage="Invalid URL." ValidationGroup="vgCustomAddEmbedVideo" ControlToValidate="tbCustomEmbedVideoURL" SetFocusOnError="True"></asp:CustomValidator>
												<asp:RequiredFieldValidator ID="rfvCustomAddEmbedVideoURL" runat="server" ControlToValidate="tbCustomEmbedVideoURL" Display="Dynamic" ErrorMessage="Please enter valid URL." SetFocusOnError="True" ValidationGroup="vgCustomAddEmbedVideo"></asp:RequiredFieldValidator>
											</p>
										</div>
									</asp:Panel>
								</asp:Panel>
								<asp:Panel ID="pnlArticleGalleryUpload" runat="server" Visible="False">
									<asp:Panel ID="pnlEmptyGallery" runat="server" CssClass="info_box attention add_gallery">
										<asp:LinkButton ID="ibAddImages" runat="server" OnClick="ibAddImages_Click" CssClass="action add_gallery" ValidationGroup="vgCreateGallery" resourcekey="ibAddImagesResource1">Add gallery</asp:LinkButton>
										<p>
											<%=Thegalleryisempty %></p>
									</asp:Panel>
									<asp:Panel ID="pnlDisplayArticleGallery" runat="server" class="info_box warning add_gallery">
										<asp:LinkButton ID="ibDisplayArticleGallery" runat="server" OnClick="lbDisplayArticleGallery_Click" CssClass="action add_gallery" resourcekey="ibDisplayArticleGalleryResource1">Display this gallery</asp:LinkButton>
										<p>
											<%=NotWithArticle %></p>
									</asp:Panel>
									<asp:Panel ID="pnlRemoveArticleGallery" runat="server" class="info_box attention add_gallery" Visible="False">
										<asp:LinkButton ID="lbRemoveDisplayArticleGallery" runat="server" CssClass="action remove_btn" OnClick="lbRemoveDisplayArticleGallery_Click" resourcekey="lbRemoveDisplayArticleGalleryResource1">Do not display gallery</asp:LinkButton>
										<p>
											<%=GalleryWithArticle%></p>
									</asp:Panel>
									<asp:Panel ID="pnlArticleImageUpload" runat="server">
										<asp:CheckBox ID="cbShowGallery" runat="server" Text="Show gallery" Visible="False" resourcekey="cbShowGalleryResource1" />
										<div class="uploadify_container">
											<div style="display: block; float: left; margin-left: 30px;">
												<asp:FileUpload ID="fileInput" runat="server" resourcekey="fileInputResource2" />
											</div>
											<div style="display: block; float: left; margin-left: 15px;">
												<a class="start_upload" href="javascript:<%=jQueryPrefix%>('#<%=fileInput.ClientID%>').uploadifySettings('scriptData', {'resize':document.getElementById('<%=hfResize.ClientID%>').value, 'width': document.getElementById('<%=hfResizeWidth.ClientID%>').value,'height':document.getElementById('<%=hfResizeHeight.ClientID%>').value});<%=jQueryPrefix%>('#<%=fileInput.ClientID%>').uploadifyUpload();">
													<%=StartUpload %></a>
											</div>
										</div>
										<asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Button" Style="display: none;" resourcekey="Button2Resource1" />
										<div class="add_video_by_url">
											<p>
												<asp:Label runat="server" resourcekey="addVideoFromYouTube" Text="Add video from YouTube or Vimeo:" ID="lblAddEmbedToGallery"></asp:Label>
												<asp:TextBox runat="server" ID="tbEmbedVideoURL" ValidationGroup="vgAddEmbedVideo" onblur="if(this.value=='') {this.value=this.defaultValue;}" onfocus="if(this.defaultValue==this.value) {this.value = '';}" value="Enter video URL..."></asp:TextBox>
												<asp:LinkButton runat="server" ID="lbAddEmedVideoToGallery" ValidationGroup="vgAddEmbedVideo" OnClick="lbAddEmedVideoToGallery_Click" class="add_video">Add video</asp:LinkButton>
											</p>
											<p class="validators">
												<asp:CustomValidator ID="cvMainGalleryAddEmbedVideo" runat="server" ClientValidationFunction="ClientValidateEmbedURL" Display="Dynamic" ErrorMessage="Invalid URL." ValidationGroup="vgAddEmbedVideo" ControlToValidate="tbEmbedVideoURL" SetFocusOnError="True"></asp:CustomValidator>
												<asp:RequiredFieldValidator ID="rfvAddEmbedVideoURL" runat="server" ControlToValidate="tbEmbedVideoURL" Display="Dynamic" ErrorMessage="Please enter valid URL." SetFocusOnError="True" ValidationGroup="vgAddEmbedVideo"></asp:RequiredFieldValidator>
											</p>
										</div>
									</asp:Panel>
								</asp:Panel>
								<asp:Panel ID="pnlSharedGalleryUpload" runat="server" Visible="False">
									<div class="uploadify_container">
										<div style="display: block; float: left; margin-left: 30px;">
											<asp:FileUpload ID="SharedfileInput" runat="server" resourcekey="SharedfileInputResource1" />
										</div>
										<div style="display: block; float: left; margin-left: 15px;">
											<a class="start_upload" href="javascript:<%=jQueryPrefix%>('#<%=SharedfileInput.ClientID%>').uploadifySettings('scriptData', {'resize':document.getElementById('<%=hfResize.ClientID%>').value, 'width': document.getElementById('<%=hfResizeWidth.ClientID%>').value,'height':document.getElementById('<%=hfResizeHeight.ClientID%>').value});<%=jQueryPrefix%>('#<%=SharedfileInput.ClientID%>').uploadifyUpload();">
												<%=StartUpload %></a>
										</div>
										<asp:Button ID="ButtonShared" runat="server" OnClick="Button2_Click" Text="Button" Style="display: none;" resourcekey="ButtonSharedResource1" />
									</div>
									<div class="add_video_by_url">
										<p>
											<asp:Label runat="server" resourcekey="addVideoFromYouTube" Text="Add a video from YouTube or Vimeo:" ID="lblSharedAddEmbedToGallery" />
											<asp:TextBox runat="server" ID="tbSharedEmbedVideoURL" ValidationGroup="vgSharedAddEmbedVideo" onblur="if(this.value=='') {this.value=this.defaultValue;}" onfocus="if(this.defaultValue==this.value) {this.value = '';}" value="Enter video URL..." />
											<asp:LinkButton runat="server" ID="lbSharedAddEmedVideoToGallery" ValidationGroup="vgSharedAddEmbedVideo" OnClick="lbSharedAddEmedVideoToGallery_Click" class="add_video">Add video</asp:LinkButton>
										</p>
										<p class="validators">
											<asp:CustomValidator ID="cvSharedAddEmbedVideo" runat="server" ClientValidationFunction="ClientValidateEmbedURL" Display="Dynamic" ErrorMessage="Invalid URL." ValidationGroup="vgSharedAddEmbedVideo" ControlToValidate="tbSharedEmbedVideoURL" SetFocusOnError="True"></asp:CustomValidator>
											<asp:RequiredFieldValidator ID="rfvSharedAddEmbedVideoURL" runat="server" ControlToValidate="tbSharedEmbedVideoURL" Display="Dynamic" ErrorMessage="Please enter valid URL." SetFocusOnError="True" ValidationGroup="vgSharedAddEmbedVideo"></asp:RequiredFieldValidator>
										</p>
									</div>
								</asp:Panel>
							</div>
						</div>
						<div class="section_box no_top_margin">
							<div class="content dark_blue">
								<div class="gallery_items_container">
									<asp:GridView ID="gvArticleMediaList" runat="server" AllowPaging="True" AutoGenerateColumns="False" Border="0" CellPadding="0" CssClass="gallery_items_table" DataKeyNames="PictureID" EnableModelValidation="True" HorizontalAlign="Center" OnDataBound="gvArticleMediaList_DataBound"
										OnRowCommand="gvArticleMediaList_RowCommand" OnRowDeleted="gvArticleMediaList_RowDeleted" OnRowDeleting="gvArticleMediaList_RowDeleting" ShowFooter="True" Width="700px" GridLines="None">
										<AlternatingRowStyle CssClass="main_row second" />
										<Columns>
											<asp:TemplateField HeaderText="Media list" SortExpression="Position">
												<EditItemTemplate>
													<table cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td class="action">
																<asp:LinkButton ID="LinkButton5" runat="server" CommandName="Update" CssClass="action_btn update" resourcekey="LinkButton5Resource1"></asp:LinkButton>
																<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="action_btn cancel" resourcekey="LinkButton6Resource1"></asp:LinkButton>
															</td>
															<td class="edit_fields">
																<asp:TextBox ID="TextBox3" runat="server" resourcekey="TextBox3Resource1" Text='<%# Bind("Title") %>'></asp:TextBox>
															</td>
															<td class="edit_fields">
																<asp:TextBox ID="TextBox2" runat="server" resourcekey="TextBox2Resource1" Text='<%# Bind("Description") %>' TextMode="MultiLine"></asp:TextBox>
															</td>
														</tr>
													</table>
												</EditItemTemplate>
												<HeaderTemplate>
													<table cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td class="header_field action">
																<%=Action %>
															</td>
															<td class="header_field image">
															</td>
															<td class="header_field title">
																<%=Title%>
															</td>
															<td class="header_field description">
																<%=Description %>
															</td>
															<td class="header_field">
															</td>
														</tr>
													</table>
												</HeaderTemplate>
												<ItemTemplate>
													<table cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td class="action">
																<asp:LinkButton ID="lbSetArticleImageArtGallery" runat="server" CommandArgument='<%# Eval("PictureID") %>' CommandName="SetArticleImage" CssClass="action_btn article_img" resourcekey="lbSetArticleImageArtGalleryResource1">Set as main article image</asp:LinkButton>
																<asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Edit" CssClass="action_btn edit" resourcekey="LinkButton3Resource1"></asp:LinkButton>
																<asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Delete" CssClass="action_btn delete" resourcekey="LinkButton4Resource1"></asp:LinkButton>
																<asp:LinkButton ID="lbLocalizeimage" runat="server" CommandArgument='<%# Eval("PictureID") %>' CommandName="LocalizeImage" CssClass="image_localization" resourcekey="lbLocalizeimageResource1" Visible='<%# Convert.ToBoolean(ViewState["EnableLocalization"] as string) %>'>Localize content</asp:LinkButton>
															</td>
															<td class="image">
																<div class="wrapper">
																	<a href='<%#Eval("MediaType").ToString()=="Image"?Eval("FileName").ToString():"#"%>' target="_blank">
																		<asp:Image ID="Image1" runat="server" ImageUrl='<%#FixImageUrl(Eval("ThumbUrl").ToString())%>' />
																	</a>
																</div>
															</td>
															<td class="title">
																<asp:Label ID="Label4" runat="server" resourcekey="Label4Resource1" Text='<%# Bind("Title") %>'></asp:Label>
															</td>
															<td class="description">
																<asp:Label ID="Label6" runat="server" resourcekey="Label6Resource1" Text='<%# Bind("Description") %>'></asp:Label>
															</td>
															<td class="position_show_type">
																<div class="action_box">
																	<div class="action_wrapper">
																		<asp:ImageButton ID="imbMediaUp" runat="server" CausesValidation="False" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="Up" CssClass="position_btn up" ImageUrl="~/images/action_up.gif" resourcekey="imbMediaUpResource1" />
																		<asp:ImageButton ID="imbMediaDown" runat="server" CausesValidation="False" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="Down" CssClass="position_btn down" ImageUrl="~/images/action_down.gif" resourcekey="imbMediaDownResource1" />
																	</div>
																	<span class="text">
																		<%=Position%></span>
																</div>
																<div class="action_box">
																	<div class="action_wrapper">
																		<asp:LinkButton ID="lbArticleGalleryItemState" runat="server" CommandArgument='<%# Eval("PictureID") %>' CommandName="ChangeShow" CssClass='<%# GetShowMediaClass(Eval("ShowMedia")) %>' resourcekey="lbArticleGalleryItemStateResource1"></asp:LinkButton>
																	</div>
																	<span class="text">
																		<%=Show%></span>
																</div>
																<div class="action_box">
																	<div class="action_wrapper">
																		<asp:Label ID="imgMediaType" runat="server" CssClass='<%# GetMediaTypeClass(Eval("MediaType")) %>' resourcekey="imgMediaTypeResource1"></asp:Label>
																	</div>
																	<span class="text">
																		<%=Media %></span>
																</div>
															</td>
														</tr>
														<tr>
															<td class="token_wrapper" colspan="5">
																<asp:TextBox ID="lblGalleryInsertArtGallery" runat="server" CssClass="token_box" resourcekey="lblGalleryInsertArtGalleryResource1" ReadOnly="True" Text='<%# GenerateTokens(Eval("PictureID")) %>'></asp:TextBox>
																<span class="start_token_generator">
																	<%=Customtoken %></span>
															</td>
														</tr>
													</table>
													<asp:HiddenField ID="hvPictureID" runat="server" Value='<%# Bind("PictureID") %>' />
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
										<HeaderStyle CssClass="main_table_header" />
										<PagerStyle CssClass="pagination" HorizontalAlign="Center" />
										<RowStyle CssClass="main_row" />
										<SelectedRowStyle CssClass="categorygridselected" />
									</asp:GridView>
								</div>
								<div id="mediaPageManagment" runat="server" class="padded" visible="false">
									<asp:Label ID="lblGalSetThenumberOfItems" runat="server" Text="Set the number of items per page:" resourcekey="lblGalSetThenumberOfItems0Resource1"></asp:Label>
									&nbsp;<asp:DropDownList ID="ddlArticleViewNumberOfItems" runat="server" AutoPostBack="True" CssClass="ddlpageitems" OnSelectedIndexChanged="ddlArticleViewNumberOfItems_SelectedIndexChanged" resourcekey="ddlArticleViewNumberOfItemsResource1">
										<asp:ListItem resourcekey="ListItemResource20">10</asp:ListItem>
										<asp:ListItem resourcekey="ListItemResource21">20</asp:ListItem>
										<asp:ListItem resourcekey="ListItemResource22">30</asp:ListItem>
										<asp:ListItem resourcekey="ListItemResource23">50</asp:ListItem>
										<asp:ListItem resourcekey="ListItemResource24">100</asp:ListItem>
									</asp:DropDownList>
								</div>
								<asp:HiddenField ID="hfGalID" runat="server" />
								<asp:HiddenField ID="hfCatID" runat="server" />
								<asp:HiddenField ID="hfResizeHeight" runat="server" />
								<asp:HiddenField ID="hfResizeWidth" runat="server" />
								<asp:HiddenField ID="hfResize" runat="server" />
								<asp:HiddenField ID="hfSharedGalID" runat="server" />
								<asp:HiddenField ID="hfArtImageSet" runat="server" />
								<asp:HiddenField ID="hfImageChanged" runat="server" Value="False" />
								<asp:HiddenField ID="hfSelectedMediaID" runat="server" Value="0" />
							</div>
						</div>
						<asp:Panel runat="server" ID="pnlCustomGalleryManager" CssClass="section_box no_top_margin" Visible="False">
							<div class="content dark_blue">
								<div class="section_actions">
									<asp:HyperLink ID="hlOpenGallery" runat="server" CssClass="icon laptop" Target="_blank" resourcekey="hlOpenGalleryResource1">Open Media manager</asp:HyperLink>
								</div>
							</div>
						</asp:Panel>
					</ContentTemplate>
				</asp:UpdatePanel>
				<asp:Panel ID="pnlDocumentUpload" CssClass="section_box white_border_1 dark_grey" runat="server">
					<h1 class="section_box_title">
						<span>
							<%=DOCUMENTSincluded%></span></h1>
					<div class="content document_upload">
						<div class="upload_box">
							<asp:Label ID="lblDocUploadmessage" runat="server" CssClass="upload_msg" />
							<div class="input_box">
								<asp:Label ID="lblDocUploadTitle" AssociatedControlID="tbDocUploadTitle" runat="server" Text="Document title:" resourcekey="lblDocUploadTitleResource1" />
								<asp:TextBox ID="tbDocUploadTitle" runat="server" CssClass="text" resourcekey="tbDocUploadTitleResource1" />
								<asp:RequiredFieldValidator ID="rfvDocumentTitle" runat="server" ControlToValidate="tbDocUploadTitle" ErrorMessage="This field is required." ValidationGroup="vgArticleDocs" resourcekey="rfvDocumentTitleResource1" />
							</div>
							<div class="input_box">
								<asp:Label ID="lblDocUploadDescription" AssociatedControlID="tbDocUploadDescription" runat="server" Text="Document description:" resourcekey="lblDocUploadDescriptionResource1" />
								<asp:TextBox ID="tbDocUploadDescription" CssClass="text" runat="server" resourcekey="tbDocUploadDescriptionResource1" />
							</div>
							<div class="input_box file">
								<asp:Label ID="lblDocUploadSelectFile" AssociatedControlID="fuDocFileUpload" runat="server" Text="Select a document:" resourcekey="lblDocUploadSelectFileResource1" />
								<asp:FileUpload ID="fuDocFileUpload" CssClass="file" runat="server" resourcekey="fuDocFileUploadResource1" />
							</div>
							<div class="input_box upload_btn">
								<asp:LinkButton ID="btnDocUpload" runat="server" OnClick="btnDocUpload_Click" ValidationGroup="vgArticleDocs" resourcekey="btnDocUploadResource1">
									<span>UPLOAD</span></asp:LinkButton>
							</div>
						</div>
						<asp:GridView ID="gvArticleDocuments" runat="server" AutoGenerateColumns="False" CellPadding="0" CssClass="grid_view_table" DataKeyNames="DocEntryID" EnableModelValidation="True" GridLines="None" DataSourceID="odsArticleDocuments" OnRowCommand="gvArticleDocuments_RowCommand"
							OnDataBound="gvArticleDocuments_DataBound" resourcekey="gvArticleDocumentsResource1">
							<AlternatingRowStyle CssClass="second" />
							<Columns>
								<asp:TemplateField HeaderText="Actions">
									<EditItemTemplate>
										<asp:LinkButton ID="lbDocUpdate" runat="server" CommandName="Update" CssClass="action_btn save" resourcekey="lbDocUpdateResource1" ToolTip="Save changes"></asp:LinkButton>
										<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="action_btn cancel" resourcekey="LinkButton2Resource1" ToolTip="Discard changes"></asp:LinkButton>
									</EditItemTemplate>
									<ItemTemplate>
										<asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" CssClass="action_btn edit" resourcekey="LinkButton1Resource1" ToolTip="Edit this document"></asp:LinkButton>
										<asp:LinkButton ID="lbDeleteDoc" runat="server" CausesValidation="False" CommandArgument='<%# Eval("DocEntryID") %>' CommandName="DeleteDoc" CssClass="action_btn red_x" resourcekey="lbDeleteDocResource1" ToolTip="Delete this document"></asp:LinkButton>
									</ItemTemplate>
									<HeaderStyle CssClass="actions" />
									<ItemStyle CssClass="actions" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Title" SortExpression="Title">
									<EditItemTemplate>
										<asp:TextBox ID="tbDocTitle" runat="server" resourcekey="tbDocTitleResource1" Text='<%# Bind("Title") %>'></asp:TextBox>
									</EditItemTemplate>
									<ItemTemplate>
										<asp:Label ID="lblDocUploadTitle" runat="server" resourcekey="lblDocUploadTitleResource2" Text='<%# Bind("Title") %>'></asp:Label>
									</ItemTemplate>
									<HeaderStyle CssClass="title" />
									<ItemStyle CssClass="title" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Description" SortExpression="Description">
									<EditItemTemplate>
										<asp:TextBox ID="tbDocDescription" runat="server" resourcekey="tbDocDescriptionResource1" Text='<%# Bind("Description") %>'></asp:TextBox>
									</EditItemTemplate>
									<ItemTemplate>
										<asp:Label ID="lblDocUploadDesc" runat="server" resourcekey="lblDocUploadDescResource1" Text='<%# Bind("Description") %>'></asp:Label>
									</ItemTemplate>
									<HeaderStyle CssClass="description" />
									<ItemStyle CssClass="description" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Filename" SortExpression="Filename">
									<EditItemTemplate>
										<asp:Label ID="lbFilename" runat="server" resourcekey="lbFilenameResource1" Text='<%# GetDocumentFilename(Eval("Filename")) %>'></asp:Label>
									</EditItemTemplate>
									<ItemTemplate>
										<a href='<%# Eval("Filename") %>'>
											<%# GetDocumentFilename(Eval("Filename")) %>
										</a>
									</ItemTemplate>
									<HeaderStyle CssClass="filename" />
									<ItemStyle CssClass="filename" />
								</asp:TemplateField>
								<asp:BoundField DataField="DateUploaded" HeaderText="Date" ReadOnly="True">
									<HeaderStyle CssClass="date" />
									<ItemStyle CssClass="date" />
								</asp:BoundField>
								<asp:TemplateField HeaderText="Author" SortExpression="Author">
									<ItemTemplate>
										<asp:Label ID="lblDocUploadAuthor" runat="server" resourcekey="lblDocUploadAuthorResource1" Text="<%# UserInfo.DisplayName %>"></asp:Label>
									</ItemTemplate>
									<HeaderStyle CssClass="author" />
									<ItemStyle CssClass="author" />
								</asp:TemplateField>
								<asp:TemplateField ShowHeader="False">
									<ItemTemplate>
										<asp:HiddenField ID="hfPosition" Value='<%#Eval("DocEntryID")%>' runat="server"></asp:HiddenField>
										<asp:LinkButton ID="lbDocMoveDown" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' CommandName="Down" runat="server" CssClass="arrow down" resourcekey="lbDocMoveDownResource1"></asp:LinkButton>
										<asp:LinkButton ID="lbDocMoveUp" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' CommandName="Up" runat="server" CssClass="arrow up" resourcekey="lbDocMoveUpResource1"></asp:LinkButton>
									</ItemTemplate>
									<HeaderStyle CssClass="arrows" />
									<ItemStyle CssClass="arrows" />
								</asp:TemplateField>
							</Columns>
							<HeaderStyle CssClass="header_row" />
						</asp:GridView>
						<asp:ObjectDataSource ID="odsArticleDocuments" runat="server" SelectMethod="GetArticleDocuments" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" UpdateMethod="UpdateArticleDocument">
							<SelectParameters>
								<asp:Parameter Name="ArticleID" Type="Int32" />
							</SelectParameters>
							<UpdateParameters>
								<asp:Parameter Name="DocEntryID" Type="Int32" />
								<asp:Parameter Name="Title" Type="String" />
								<asp:Parameter Name="Description" Type="String" />
							</UpdateParameters>
						</asp:ObjectDataSource>
					</div>
				</asp:Panel>
				<asp:Panel ID="google_maps_main" CssClass="section_box white_border_1 light_green green_globe google_maps_main" runat="server">
					<h1 class="section_box_title">
						<span>
							<%=Mainarticlemap %></span></h1>
					<div class="content google_maps">
						<script type="text/javascript" src="//maps.googleapis.com/maps/api/js?key=<%=gApiKey%>&sensor=true&libraries=places"></script>
						<div class="content_token_generator google_maps">
						</div>
						<asp:HiddenField ID="hfGooglemapTokenGenerated" runat="server" />
						<div id="idAddGmap" runat="server" class="info_box red_cross no_map">
							<a href="#" class="action add open_map_editor <%=hasGapiKey%>">
								<%=Addmap%></a>
							<p>
								<%=Mainarticlemapisnotset%></p>
						</div>
						<div id="idRemoveGmap" runat="server" class="info_box check_sign map_set">
							<a href="#" class="action remove_btn remove_article_map">
								<%=Remove%></a> <a href="#" class="action edit open_map_editor <%=hasGapiKey%>">Edit map</a>
							<p>
								<%=Mainarticlemapisset%></p>
						</div>
						<div class="section_actions">
							<a class="icon green_globe open_map_editor <%=hasGapiKey%>" href="#">
								<%=Mapeditor%></a>
						</div>
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlBottom" runat="server">
					<div id="divAdvancedSettings" runat="server" class="collapsible_box">
						<h1 class="collapsible_box_title">
							<%=AdvancedSettings %></h1>
						<div class="content">
							<asp:UpdatePanel ID="upAdvancedSettings" runat="server">
								<ContentTemplate>
									<asp:Panel ID="pnlChangeOwner" runat="server" Visible="False">
										<table class="settings_table w700">
											<tr>
												<td class="left">
													<dnn:Label ID="lblowner" runat="server" HelpText="Article Owner:" Text="Article Owner:" HelpKey="lblowner.HelpText" ResourceKey="lblowner" />
												</td>
												<td class="right">
													<asp:Label ID="tbArticleAuthorName" runat="server" resourcekey="tbArticleAuthorNameResource1" />
												</td>
											</tr>
											<tr id="trEnableAuthorProfile" runat="server" visible="false">
												<td class="left">
													<dnn:Label ID="lblAuthorAlias" runat="server" HelpText="Author alias:" Text="Author alias:" />
												</td>
												<td class="right">
													<asp:TextBox ID="tbAuthorAliasName" runat="server" MaxLength="100" Width="200px"></asp:TextBox>
												</td>
											</tr>
											<tr>
												<td class="left">
													<dnn:Label ID="lblChOwner" runat="server" HelpText="Change Owner:" Text="Change Owner:" HelpKey="lblChOwner.HelpText" ResourceKey="lblChOwner" />
												</td>
												<td class="right">
													<asp:DropDownList ID="ddlRoles" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="ddlgeneral" OnSelectedIndexChanged="ddlRoles_SelectedIndexChanged" Visible="False" resourcekey="ddlRolesResource1">
														<asp:ListItem Value="-1" resourcekey="ListItemResource25">Select role</asp:ListItem>
													</asp:DropDownList>
													<asp:DropDownList ID="ddlAuthors" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="ddlgeneral" OnSelectedIndexChanged="ddlAuthors_SelectedIndexChanged" Visible="False" resourcekey="ddlAuthorsResource1">
														<asp:ListItem Value="-1" resourcekey="ListItemResource26">Select author</asp:ListItem>
													</asp:DropDownList>
												</td>
											</tr>
										</table>
									</asp:Panel>
									<div id="divDefaultTemplate" runat="server">
										<table class="settings_table w700">
											<tr>
												<td class="left">
													<dnn:Label ID="lblUseDefaultTemplate" runat="server" HelpText="Use default template:" Text="Use default template:" HelpKey="lblUseDefaultTemplate.HelpText" ResourceKey="lblUseDefaultTemplate" />
												</td>
												<td class="right">
													<asp:CheckBox ID="cbUseDefaultTemplate" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbUseDefaultTemplate_CheckedChanged" resourcekey="cbUseDefaultTemplateResource1" />
												</td>
											</tr>
										</table>
										<asp:Panel ID="pnlSelectThemes" runat="server" Visible="False">
											<table class="settings_table w700 no_margin">
												<tr>
													<td class="left">
														<dnn:Label ID="lblArticleDetailsTheme" runat="server" HelpText="Article details theme:" Text="Article details theme:" HelpKey="lblArticleDetailsTheme.HelpText" ResourceKey="lblArticleDetailsTheme" />
													</td>
													<td class="right">
														<asp:DropDownList ID="ddlArticleDetailsTheme" runat="server" AutoPostBack="True" CausesValidation="True" CssClass="ddlgeneral" OnSelectedIndexChanged="ddlArticleDetailsFolder_SelectedIndexChanged" resourcekey="ddlArticleDetailsFolderResource1" />
													</td>
												</tr>
												<tr>
													<td class="left">
														<dnn:Label ID="lblArticleDetailsTemplate" runat="server" HelpText="Article details template:" Text="Article details template:" HelpKey="lblArticleDetailsTemplate.HelpText" ResourceKey="lblArticleDetailsTemplate" />
													</td>
													<td class="right">
														<asp:DropDownList ID="ddlArticleDetailsTemplate" runat="server" CssClass="ddlgeneral" />
													</td>
												</tr>
												<tr>
													<td class="left">
														<dnn:Label ID="lblArticleCommentsTemplate" runat="server" ControlName="ddlCommentsTemplate" HelpText="Article comments template:" Text="Article comments template:" HelpKey="lblArticleCommentsTemplate.HelpText" ResourceKey="lblArticleCommentsTemplate" />
													</td>
													<td class="right">
														<asp:DropDownList ID="ddlCommentsTemplate" runat="server" CssClass="ddlgeneral" />
													</td>
												</tr>
												<tr>
													<td class="left">
														<dnn:Label ID="lblArticleCSSStyle" ControlName="ddlDisplayStyle" runat="server" HelpText="Display style:" Text="Display style:" HelpKey="lblArticleCSSStyle.HelpText" ResourceKey="lblArticleCSSStyle" />
													</td>
													<td class="right">
														<asp:DropDownList ID="ddlDisplayStyle" runat="server" />
													</td>
												</tr>
											</table>
										</asp:Panel>
									</div>
								</ContentTemplate>
							</asp:UpdatePanel>
						</div>
					</div>
					<asp:Panel runat="server" ID="pnlEventManager">
						<asp:UpdatePanel ID="upEventManager" runat="server" UpdateMode="Conditional">
							<ContentTemplate>
								<table class="settings_table w700">
									<tr>
										<td class="left">
											<img src="<%=ModulePath%>images/icons/analog_clock.png" alt="" style="position: relative; top: 4px;" />
											<asp:Label ID="lblIsArticleEvent" runat="server" Text="Add as event:" Style="font-weight: bold;" resourcekey="lblIsArticleEventResource1" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbIsArticleEvent" runat="server" AutoPostBack="True" OnCheckedChanged="cbIsArticleEvent_CheckedChanged" resourcekey="cbIsArticleEventResource1" />
										</td>
									</tr>
								</table>
								<asp:Panel ID="pnlEventsData" runat="server" Visible="False">
									<table class="settings_table w700 no_margin">
										<tr>
											<td colspan="3" style="text-align: center;">
												<asp:Label ID="lblEventDateError" runat="server" ForeColor="Red" Text="End date is smaller than start date." Visible="False" resourcekey="lblEventDateErrorResource1" />
											</td>
										</tr>
										<tr>
											<td class="left" style="vertical-align: top; padding-top: 2px;">
												<dnn:Label ID="lblEventStartDateTime" runat="server" HelpText="Start date:" Text="Start date:" HelpKey="lblEventStartDateTime.HelpText" ResourceKey="lblEventStartDateTime" />
											</td>
											<td class="right" style="width: 215px;">
												<asp:TextBox ID="tbEventStartDate" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="90px" resourcekey="tbEventStartDateResource1" />
												<img src="<%=ModulePath%>images/icons/calendar.png" alt="" style="position: relative; top: 2px" />
												<asp:RequiredFieldValidator ID="rfvEventStartDate" runat="server" ControlToValidate="tbEventStartDate" CssClass="NormalRed" Display="Dynamic" Enabled="False" ErrorMessage="Date required." ValidationGroup="vgEditArticle" resourcekey="rfvEventStartDateResource1" />
												<asp:Label ID="lblEvStartDateError" runat="server" ForeColor="Red" resourcekey="lblPubDateErrorResource1" Text="Invalid date." Visible="False" />
												<asp:TextBox ID="tbEventStartTime" runat="server" CssClass="text_generic center" ValidationGroup="vgAddArticle" Width="55px" resourcekey="tbEventStartTimeResource1" />
												<img id="tbEventStartTimeIcon" runat="server" style="position: relative; top: 1px" />
												&nbsp;<asp:RegularExpressionValidator ID="revEventStartTime" runat="server" ControlToValidate="tbEventStartTime" Enabled="False" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgEditArticle" Display="Dynamic"
													resourcekey="revEventStartTimeResource1" />
												<asp:RequiredFieldValidator ID="rfvEventStartTime" runat="server" ControlToValidate="tbEventStartTime" CssClass="NormalRed" Display="Dynamic" Enabled="False" ErrorMessage="Time required." ValidationGroup="vgEditArticle" resourcekey="rfvEventStartTimeResource1" />
											</td>
											<td rowspan="2">
												<p style="position: relative; top: -1px">
													<asp:CheckBox ID="cbAllDayEvent" runat="server" AutoPostBack="True" OnCheckedChanged="cbAllDayEvent_CheckedChanged" Text="All day event" resourcekey="cbAllDayEventResource1" /></p>
												<p style="position: relative; top: -1px">
													<asp:CheckBox ID="cbShowEndDate" resourcekey="cbShowEndDate" runat="server" Checked="True" Text="Show end date" /></p>
											</td>
										</tr>
										<tr>
											<td class="left" style="vertical-align: top; padding-top: 2px;">
												<dnn:Label ID="lblEventEndDateTime" runat="server" HelpText="End date:" Text="End date:" HelpKey="lblEventEndDateTime.HelpText" ResourceKey="lblEventEndDateTime" />
											</td>
											<td class="right">
												<asp:TextBox ID="tbEventEndDate" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="90px" resourcekey="tbEventEndDateResource1" />
												<img src="<%=ModulePath%>images/icons/calendar.png" alt="" style="position: relative; top: 2px" />
												<asp:RequiredFieldValidator ID="rfvEventEndDate" runat="server" ControlToValidate="tbEventStartDate" CssClass="NormalRed" Display="Dynamic" Enabled="False" ErrorMessage="Date required." ValidationGroup="vgEditArticle" resourcekey="rfvEventEndDateResource1" />
												<asp:Label ID="lblEvEndDateError" runat="server" ForeColor="Red" resourcekey="lblExpireDateErrorResource1" Text="Invalid date." Visible="False" />
												<asp:TextBox ID="tbEventEndTime" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="55px" resourcekey="tbEventEndTimeResource1" />
												<img id="tbEventEndTimeIcon" runat="server" style="position: relative; top: 1px" />
												&nbsp;<asp:RegularExpressionValidator ID="revEventEndTIme" runat="server" ControlToValidate="tbEventEndTime" Enabled="False" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgEditArticle" Display="Dynamic"
													resourcekey="revEventEndTImeResource1" />
												<asp:RequiredFieldValidator ID="rfvEventEnd" runat="server" ControlToValidate="tbEventEndTime" CssClass="NormalRed" Display="Dynamic" Enabled="False" ErrorMessage="Time required." ValidationGroup="vgEditArticle" resourcekey="rfvEventEndResource1" />
											</td>
										</tr>
									</table>
								</asp:Panel>
							</ContentTemplate>
						</asp:UpdatePanel>
						<asp:UpdateProgress ID="uppEventManager" runat="server" AssociatedUpdatePanelID="upEventManager" DisplayAfter="100" DynamicLayout="true">
							<ProgressTemplate>
								<img src="<%=ModulePath%>images/settings/ajaxLoading.gif" /></ProgressTemplate>
						</asp:UpdateProgress>
					</asp:Panel>
					<table class="settings_table w700">
						<tr id="rowAllowComents" runat="server">
							<td class="left">
								<dnn:Label ID="lblAllowComments" runat="server" HelpText="Allow comments:" Text="Allow comments:" HelpKey="lblAllowComments.HelpText" ResourceKey="lblAllowComments" />
							</td>
							<td class="right">
								<asp:CheckBox ID="cbAllowComments" runat="server" />
							</td>
						</tr>
						<tr id="rowFeaturedArticle" runat="server">
							<td class="left">
								<dnn:Label ID="lblFeaturedArticle" runat="server" HelpText="Featured article:" Text="Featured article:" HelpKey="lblFeaturedArticle.HelpText" ResourceKey="lblFeaturedArticle" />
							</td>
							<td class="right">
								<asp:CheckBox ID="cbFeaturedArticle" runat="server" resourcekey="cbFeaturedArticleResource1" />
							</td>
						</tr>
						<tr id="rowPublishDate" runat="server">
							<td class="left">
								<dnn:Label ID="lblPublishDate" runat="server" HelpText="Publish date:" Text="Publish date:" HelpKey="lblPublishDate.HelpText" ResourceKey="lblPublishDate" />
							</td>
							<td class="right">
								<asp:TextBox ID="tbPublishDate" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="90px" resourcekey="tbPublishDateResource1" />
								<asp:RequiredFieldValidator ID="rfvArchiveDate" runat="server" ControlToValidate="tbPublishDate" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Date required." ValidationGroup="vgEditArticle" resourcekey="rfvArchiveDateResource1" />
								<asp:CompareValidator ID="cvPublishDate" runat="server" ControlToValidate="tbPublishDate" Display="Dynamic" Enabled="False" ErrorMessage="Invalid date." Operator="DataTypeCheck" Type="Date" ValidationGroup="vgEditArticle" resourcekey="cvPublishDateResource1" />
								<asp:Label ID="lblPubDateError" runat="server" ForeColor="Red" Text="Invalid date." Visible="False" resourcekey="lblPubDateErrorResource1" />
								<asp:TextBox ID="tbPublishTime" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="50px" resourcekey="tbPublishTimeResource1" />
								<asp:RegularExpressionValidator ID="revPublishTIme" runat="server" ControlToValidate="tbPublishTime" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgEditArticle" resourcekey="revPublishTImeResource1" />
							</td>
						</tr>
						<tr id="rowExpireDate" runat="server">
							<td class="left">
								<dnn:Label ID="lblExpireDate" runat="server" HelpText="Expire date. Must be greather than publish date." Text="Expire date:" HelpKey="lblExpireDate.HelpText" ResourceKey="lblExpireDate" />
							</td>
							<td class="right">
								<asp:TextBox ID="tbExpireDate" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="90px" resourcekey="tbExpireDateResource1" />
								<asp:RequiredFieldValidator ID="rfvArchiveDate0" runat="server" ControlToValidate="tbExpireDate" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Date required." ValidationGroup="vgEditArticle" resourcekey="rfvArchiveDate0Resource1" />
								<asp:CompareValidator ID="cvPublishDate0" runat="server" ControlToValidate="tbExpireDate" CultureInvariantValues="True" Display="Dynamic" Enabled="False" ErrorMessage="Invalid date." Operator="DataTypeCheck" Type="Date" ValidationGroup="vgEditArticle"
									resourcekey="cvPublishDate0Resource1" />
								<asp:Label ID="lblExpireDateError" runat="server" ForeColor="Red" Text="Invalid date." Visible="False" resourcekey="lblExpireDateErrorResource1" />
								<asp:TextBox ID="tbExpireTime" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="50px" resourcekey="tbExpireTimeResource1" />
								<asp:RegularExpressionValidator ID="revPublishTIme0" runat="server" ControlToValidate="tbExpireTime" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgEditArticle" resourcekey="revPublishTIme0Resource1" />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="timezoneinfo">
									<%=Timezone%>
									<asp:Label ID="lblTimeZone" runat="server" Text=""></asp:Label>
								</div>
							</td>
						</tr>
					</table>
					<asp:Panel ID="pnlCustomFieldsSelect" runat="server" resourcekey="pnlCustomFieldsSelectResource1">
						<asp:DropDownList ID="ddlCFgroup" runat="server" AutoPostBack="True" resourcekey="ddlCFgroupResource1">
						</asp:DropDownList>
						<table cellpadding="0" cellspacing="0" class="settings_table">
							<tr style="text-align: center;">
								<td>
									<asp:Label ID="lblAlLTemplates" runat="server" EnableViewState="False" ForeColor="Red" resourcekey="lblAlLTemplatesResource1"></asp:Label>
								</td>
							</tr>
						</table>
					</asp:Panel>
					<asp:Panel ID="pnlCustomFields" runat="server" resourcekey="pnlCustomFieldsResource1">
					</asp:Panel>
					<asp:Panel ID="pnlPerArticlePermissions" runat="server" Visible="False">
						<asp:UpdatePanel ID="upPerArticlePermissions" runat="server" UpdateMode="Conditional">
							<ContentTemplate>
								<p style="margin: 0 0 3px;">
									<img src="<%=ModulePath%>images/icons/lock.png" alt="" style="position: relative; top: 4px; margin: 0 3px 0 0" />
									<asp:Label ID="lblAddPerArticlePermission" runat="server" Text="Permissions per article:" helptext="Permissions per article." Style="font-size: 13px; line-height: 16px; font-weight: bold;" resourcekey="lblAddPerArticlePermissionResource1" />
									<asp:CheckBox ID="cbAddPerArticlePermissions" runat="server" AutoPostBack="True" OnCheckedChanged="cbAddPerArticlePermissions_CheckedChanged" />
								</p>
								<asp:Panel ID="pnlAddPerArticlePermissions" runat="server" Visible="False" CssClass="rounded_box grey per_article_permissions" resourcekey="pnlAddPerArticlePermissionsResource1">
									<p class="permission_warning">
										<%=Permissionsperarticleoverride%></p>
									<asp:GridView ID="gvPermissionDefault" runat="server" AutoGenerateColumns="False" CellPadding="0" CssClass="permissions_table" EnableModelValidation="True" GridLines="None" resourcekey="gvPermissionDefaultResource1">
										<AlternatingRowStyle CssClass="second" />
										<Columns>
											<asp:TemplateField HeaderText="Roles">
												<ItemTemplate>
													<asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("Name") %>' />:
												</ItemTemplate>
												<HeaderStyle CssClass="subject" />
												<ItemStyle CssClass="subject" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Viewarticle">
												<ItemTemplate>
													<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# Eval("RoleID") %>' />
													<asp:CheckBox ID="cbShowArticle" runat="server" Checked='<%# Eval("Show") %>' Enabled="False" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Editarticle">
												<ItemTemplate>
													<asp:CheckBox ID="cbEditArticle" runat="server" Checked='<%# Eval("Edit") %>' Enabled="False" />
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
									</asp:GridView>
									<asp:GridView ID="gvRolePremissions" runat="server" AutoGenerateColumns="False" CellPadding="0" CssClass="permissions_table" EnableModelValidation="True" GridLines="None" resourcekey="gvRolePremissionsResource1">
										<AlternatingRowStyle CssClass="second" />
										<Columns>
											<asp:TemplateField>
												<ItemTemplate>
													<asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("Name") %>' />:
												</ItemTemplate>
												<HeaderStyle CssClass="subject" />
												<ItemStyle CssClass="subject" />
											</asp:TemplateField>
											<asp:TemplateField>
												<ItemTemplate>
													<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# Eval("RoleID") %>' />
													<asp:CheckBox ID="cbShowArticle" runat="server" Checked='<%# Eval("Show") %>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField>
												<ItemTemplate>
													<asp:CheckBox ID="cbEditArticle" runat="server" Checked='<%# Eval("Edit") %>' />
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
									</asp:GridView>
									<table class="permissions_table" style="position: relative; left: -2px; margin-bottom: 15px;">
										<tr>
											<td class="subject">
												<asp:Label ID="lblShowToUnauthorizedUser" runat="server" Text="Unauthorized users:" resourcekey="lblShowToUnauthorizedUserResource1" />
											</td>
											<td>
												<asp:CheckBox ID="cbShowToUnauthorizedUser" runat="server" Style="position: relative; left: -2px;" resourcekey="cbShowToUnauthorizedUserResource1" />
											</td>
										</tr>
									</table>
									<asp:GridView ID="gvUserPermissions" runat="server" AutoGenerateColumns="False" CellPadding="0" CssClass="permissions_table" EnableModelValidation="True" GridLines="None" OnRowCommand="gvUserPermissions_RowCommand" resourcekey="gvUserPermissionsResource1">
										<AlternatingRowStyle CssClass="second" />
										<Columns>
											<asp:TemplateField HeaderText="Users">
												<ItemTemplate>
													<asp:Label ID="lblUserName" runat="server" Text='<%# Eval("Name") %>' />:
												</ItemTemplate>
												<HeaderStyle CssClass="subject" />
												<ItemStyle CssClass="subject" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="View article">
												<ItemTemplate>
													<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
													<asp:CheckBox ID="cbShowArticle" runat="server" Checked='<%# Eval("Show") %>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Edit article">
												<ItemTemplate>
													<asp:CheckBox ID="cbEditArticle" runat="server" Checked='<%# Eval("Edit") %>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField>
												<ItemTemplate>
													<asp:LinkButton ID="lbUserPremissionRemove" runat="server" CausesValidation="False" CommandArgument='<%# Eval("UserID") %>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this user permissions?');" Text="Remove" resourcekey="lbUserPremissionRemoveResource1"></asp:LinkButton>
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
									</asp:GridView>
									<asp:Label ID="lblAdduserMessage" runat="server" EnableViewState="False" ForeColor="Red" resourcekey="lblAdduserMessageResource1" />
									<table class="permissions_table">
										<tr>
											<td class="subject">
												<asp:Label ID="lblUsernameToAdd" runat="server" Text="Add user by username:" resourcekey="lblUsernameToAddResource1" />
											</td>
											<td style="width: 150px; text-align: left;">
												<asp:TextBox ID="tbUserNameToAdd" runat="server" resourcekey="tbUserNameToAddResource1" />
												<asp:LinkButton ID="lbUsernameAdd" runat="server" OnClick="lbUsernameAdd_Click" Text="Add" resourcekey="lbUsernameAddResource1" />
											</td>
										</tr>
									</table>
								</asp:Panel>
							</ContentTemplate>
						</asp:UpdatePanel>
						<asp:UpdateProgress ID="uppPerArticlePermissions" runat="server" AssociatedUpdatePanelID="upPerArticlePermissions" DisplayAfter="100" DynamicLayout="true">
							<ProgressTemplate>
								<img src="<%=ModulePath%>images/settings/ajaxLoading.gif" /></ProgressTemplate>
						</asp:UpdateProgress>
					</asp:Panel>
					<div class="main_action_buttons">
						<div id="pnlSocialSharing" class="social_sharing_box" runat="server" visible="false">
							<p id="lblSocialSharingTitle" runat="server" style="font-weight: bold;">
								<span style="color: red;">
									<%=Post%></span>
								<%= Articleto %></p>
							<p id="pnlPostToFacebook" runat="server" visible="false">
								<asp:CheckBox ID="cbPostToFacebook" runat="server" /><asp:Label ID="lblPostToFacebook" runat="server" Text="Facebook" />
								<asp:DropDownList ID="ddlPostToFacebook" runat="server" CssClass="custom_drop_down_style" />
							</p>
							<p id="pnlPostToTwitter" runat="server" visible="false">
								<asp:CheckBox ID="cbPostToTwitter" runat="server" /><asp:Label ID="lblPostToTwitter" runat="server" Text="Twitter" />
								<asp:DropDownList ID="ddlPostToTwitter" runat="server" CssClass="custom_drop_down_style" />
							</p>
						</div>
						<div id="pnlSocialSecurity" class="social_sharing_box" runat="server" visible="true" style="right: 255px;">
							<p id="lblSocialSecurityTitle" runat="server" style="font-weight: bold;">
								<%=Social%>
								<span style="color: red;">
									<%=Security%></span></p>
							<p id="pnlSocialSecuritySelect" runat="server">
								<asp:Label ID="lblSocialSecuritySelect" resourcekey="lblSocialSecuritySelect" runat="server" Text="View:" />
								<asp:DropDownList ID="ddlSocialSecuritySelect" runat="server" CssClass="custom_drop_down_style" />
							</p>
							<p>
								<asp:Label ID="lblSocialSecurityGroups" resourcekey="lblSocialSecurityGroups" runat="server" Text="Groups:" />
								<asp:ListBox ID="lbSocialSecurityGroups" runat="server" SelectionMode="Multiple" />
							</p>
							<p id="pnlPostToJournal" runat="server" style="display: none">
								<span style="width: 100%; height: 1px; background-color: #d1d0d0; border-bottom: 1px; border-bottom-color: #ffffff; border-bottom-style: solid; display: block; margin-bottom: 3px;"></span><span style="display: block; margin-left: 76px;">
									<asp:CheckBox ID="cbPostToJournal" runat="server" /><asp:Label ID="lblPostToJournal" resourcekey="lblPostToJournal" runat="server" Text="Post to Journal" /></span>
							</p>
						</div>
						<asp:Label ID="lblMainEditMessage" runat="server" resourcekey="lblMainEditMessageResource1" />
						<asp:RadioButtonList ID="rblDraftPublish" runat="server" CssClass="checkbox_list" RepeatDirection="Horizontal" resourcekey="rblDraftPublishResource1" Style="margin: 0 0 0 40px">
							<asp:ListItem Selected="True" Value="Draft" resourcekey="ListItemResource27">Draft Article</asp:ListItem>
							<asp:ListItem Value="Publish" resourcekey="ListItemResource28">Publish Article</asp:ListItem>
						</asp:RadioButtonList>
						<asp:Label ID="lblApprovingMessage" runat="server" Font-Size="Small" Text="After update, article must be approved again." Style="display: none" resourcekey="lblApprovingMessageResource1"></asp:Label>
						<div class="button_list center w_565">
							<asp:LinkButton ID="btnUpdateArticle" runat="server" CssClass="main_action_button w140 red" OnClick="btnUpdateArticle_Click" Text="&lt;span&gt;Update article&lt;/span&gt;" ValidationGroup="vgEditArticle" resourcekey="btnUpdateArticleResource1">
							</asp:LinkButton>
							<asp:LinkButton ID="btnUpdateClose" runat="server" CssClass="main_action_button w140 orange" OnClick="btnUpdateClose_Click" Text="&lt;span&gt;Update &amp;amp; Close&lt;/span&gt;" ValidationGroup="vgEditArticle" resourcekey="btnUpdateCloseResource1">
							</asp:LinkButton>
							<asp:LinkButton ID="btnGoArticle" runat="server" CssClass="main_action_button w140 yellow" OnClick="btnGoArticle_Click" Text="&lt;span&gt;Update &amp;amp; View&lt;/span&gt;" ValidationGroup="vgEditArticle" resourcekey="btnGoArticleResource1">
							</asp:LinkButton>
							<asp:LinkButton ID="btnCancel" runat="server" CssClass="main_action_button w100 grey" OnClick="btnCancel_Click" Text="&lt;span&gt;Cancel&lt;/span&gt;" usesubmitbehavior="False" resourcekey="btnCancelResource1" />
						</div>
						<div class="button_list right">
							<asp:LinkButton ID="lbDeleteArticle" runat="server" CssClass="delete_article_btn" OnClick="lbDeleteArticle_Click" OnClientClick="return ConfirmDelete();" resourcekey="lbDeleteArticleResource1" ToolTip="Delete article">
								<span>Delete article</span></asp:LinkButton>
						</div>
						<div style="clear: both;">
						</div>
					</div>
				</asp:Panel>
			</asp:Panel>
			<asp:Literal ID="containerSocialSharingHistory" runat="server" />
			<asp:Panel ID="pnlPreviousVersions" runat="server" CssClass="collapsible_box top_margin_3">
				<h1 class="collapsible_box_title">
					<%=History%></h1>
				<div class="content article_history">
					<asp:Repeater ID="repPreviousVersions" runat="server" OnItemCommand="repPreviousVersions_ItemCommand">
						<ItemTemplate>
							<p>
								<strong>
									<%=Previousversionsaved%></strong>
								<%#Eval("LastModified")%>
								<asp:LinkButton ID="lbVersionRestore" runat="server" CssClass="icon load_version" title="Restore article to this version" CommandName="RstoreVersion" CommandArgument='<%# Eval("HistoryEntryID") %>' resourcekey="lbVersionRestoreResource1" />
								<asp:LinkButton ID="lbDeleteThisVersion" runat="server" CssClass="icon delete_version" title="Delete this version" OnClientClick="return confirm('Are you certain you want to delete this version?');" CommandName="DeleteVersion" CommandArgument='<%# Eval("HistoryEntryID") %>'
									resourcekey="lbDeleteThisVersionResource1" />
							</p>
						</ItemTemplate>
					</asp:Repeater>
				</div>
			</asp:Panel>
		</div>
		<asp:ObjectDataSource ID="odsCategoryList" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" runat="server" SelectMethod="GetCategoriesFromList">
			<SelectParameters>
				<asp:Parameter Name="PortalID" Type="Int32" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsArticleImages" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" runat="server" SelectMethod="GetImagesFromGallery" UpdateMethod="UpdatePictureTitleDescription" DeleteMethod="DeleteImage">
			<DeleteParameters>
				<asp:Parameter Name="PictureID" Type="Int32" />
			</DeleteParameters>
			<SelectParameters>
				<asp:Parameter Name="GalleryID" Type="Int32" />
			</SelectParameters>
			<UpdateParameters>
				<asp:Parameter Name="PictureID" Type="Int32" />
				<asp:Parameter Name="Title" Type="String" />
				<asp:Parameter Name="Description" Type="String" />
			</UpdateParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsGalleryImages" runat="server" DeleteMethod="DeleteImage" SelectMethod="GetImagesFromGallery" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" UpdateMethod="UpdatePictureTitleDescription">
			<DeleteParameters>
				<asp:Parameter Name="PictureID" Type="Int32" />
			</DeleteParameters>
			<SelectParameters>
				<asp:Parameter Name="GalleryID" Type="Int32" />
			</SelectParameters>
			<UpdateParameters>
				<asp:Parameter Name="PictureID" Type="Int32" />
				<asp:Parameter Name="Title" Type="String" />
				<asp:Parameter Name="Description" Type="String" />
			</UpdateParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsGetTagsByName" runat="server" EnablePaging="True" SelectCountMethod="GetCloudTagsSortByNameCount" SelectMethod="GetCloudTagsSortByName" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" MaximumRowsParameterName="To"
			StartRowIndexParameterName="From">
			<SelectParameters>
				<asp:Parameter Name="PortalID" Type="Int32" />
				<asp:Parameter Name="From" Type="Int32" />
				<asp:Parameter Name="To" Type="Int32" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsGetTagsByModified" runat="server" SelectCountMethod="GetCloudTagsSortByNameCount" SelectMethod="GetCloudTagsSortByModified" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" EnablePaging="True" MaximumRowsParameterName="To"
			StartRowIndexParameterName="From">
			<SelectParameters>
				<asp:Parameter Name="PortalID" Type="Int32" />
				<asp:Parameter Name="From" Type="Int32" />
				<asp:Parameter Name="To" Type="Int32" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsGetTagsByPopularity" runat="server" SelectCountMethod="GetCloudTagsSortByNameCount" SelectMethod="GetCloudTagsSortByPopular" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" EnablePaging="True" MaximumRowsParameterName="To"
			StartRowIndexParameterName="From">
			<SelectParameters>
				<asp:Parameter Name="PortalID" Type="Int32" />
				<asp:Parameter Name="From" Type="Int32" />
				<asp:Parameter Name="To" Type="Int32" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsSharedImages" runat="server" DeleteMethod="DeleteImage" SelectMethod="GetImagesFromGalleryByUserID" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" UpdateMethod="UpdatePictureTitleDescription">
			<DeleteParameters>
				<asp:Parameter Name="PictureID" Type="Int32" />
			</DeleteParameters>
			<SelectParameters>
				<asp:Parameter Name="GalleryID" Type="Int32" />
				<asp:Parameter Name="ByUserID" Type="String" />
				<asp:Parameter Name="UserID" Type="Int32" />
			</SelectParameters>
			<UpdateParameters>
				<asp:Parameter Name="PictureID" Type="Int32" />
				<asp:Parameter Name="Title" Type="String" />
				<asp:Parameter Name="Description" Type="String" />
			</UpdateParameters>
		</asp:ObjectDataSource>
	</asp:Panel>
</asp:Panel>
<asp:Panel ID="pnlErrorInfo" runat="server" Visible="False" EnableViewState="False">
	<%=Youdonothavepermision%>
</asp:Panel>
<script type="text/javascript">
// <![CDATA[

var edn_admin_localization = {
	image_token_editor_title: '<%=Customizegalleryitemtoken%>',
	image_token_editor_close: '<%=Close%>',
	gmaps_token_editor_add_map: '<%=Addasarticlemap%>',
	gmaps_token_editor_close: '<%=Close%>',
	gmaps_token_editor_title: '<%=AddGoogleMapslocation%>',
	gmaps_token_editor_edit_marker: '<%=Edit%>',
	gmaps_token_editor_edit_marker_editor_title: '<%=Addmapmarker%>',
	gmaps_token_editor_edit_marker_latitude: '<%=Latitude%>:',
	gmaps_token_editor_edit_marker_langitude: '<%=Longitude%>',
	gmaps_token_editor_edit_marker_center: '<%=Centeronmap%>',
	gmaps_token_editor_edit_marker_title_required_warning: '<%=Atitleisrequired%>',
	gmaps_token_editor_edit_marker_marker_title: '<%=Title%>',
	gmaps_token_editor_edit_marker_marker_html: '<%=HTMoptional%>',
	gmaps_token_editor_edit_marker_button_confirm: '<%=Confirm%>',
	gmaps_token_editor_edit_marker_button_cancel: '<%=Cancel%>'
}

function ClientValidateEmbedURL(source, arguments) {
		var textBox = document.getElementById("<%=tbEmbedVideoURL.ClientID %>");
		if(source.id.indexOf("Shared")!=-1)
		{
			textBox = document.getElementById("<%=tbSharedEmbedVideoURL.ClientID %>");
		}
		else if (source.id.indexOf("Custom")!=-1)
		{
			textBox = document.getElementById("<%=tbCustomEmbedVideoURL.ClientID %>");
		}
		var s = textBox.value;
		if((s.indexOf("youtube.com") != -1 && s.indexOf("v=") != -1)||(s.indexOf("youtu.be/") != -1)||(s.indexOf("vimeo.com") != -1))
		{
			arguments.IsValid = true;
		}
		else
		{
			arguments.IsValid = false;
		}
	}
	window.edn_module_root = '<%=ModulePath%>';
	window.edn_geolocation_request = <%=askForLocation%>;
	function sveok() {
		<%=jQueryPrefix%>.jGrowl('<p></p>', {
			theme: 'success',
			header: 'Settings saved',
			life: 3000,
			sticky: false
		})
	}

if ('<%=jQueryPrefix%>'=='jQuery')
{
	jQuery.noConflict();
}


<%=jQueryPrefix%>(document).ready(function ($) {
	var $social_sharing_box = $('#<%=pnlSocialSharing.ClientID%>'),
		$PostToJournal = $('#<%=pnlPostToJournal.ClientID%>'),
		$draft_radio = $('#<%=rblDraftPublish.ClientID%>_0'),
		$publish_radio = $('#<%=rblDraftPublish.ClientID%>_1'),
		$approveMsg = $('#<%=lblApprovingMessage.ClientID%>'),

		token_editors_initialized = false;

		$('#EDNadmin').bind('token_editor_initialized', function () {
			if (token_editors_initialized)
				return;

			token_editors_initialized = true;

			$('.content_token_generator.gallery_item').html('\
					<div class="dialog_wrapper">\
						<div class="token_area">\
							<textarea class="the_token" cols="50" rows="5"></textarea>\
							<p><%=CopyAndPaste%></p>\
						</div>\
						<h1><%=Itemtokensettings%></h1>\
						<p class="option">\
							<label for="gallery_item_token_width">\
								<%=Width%></label>\
							<input id="gallery_item_token_width" type="text" name="width" value="" /></p>\
						<p class="option">\
							<label for="gallery_item_token_height">\
								<%=Height %></label>\
							<input id="gallery_item_token_height" type="text" name="height" value="" /></p>\
						<p class="option">\
							<%=Sizing%><input type="radio" id="gallery_item_token_sizing_proportional" class="gallery_item_token_sizing" name="sizing" value="proportional" />\
							<label for="gallery_item_token_sizing_proportional">\
								<%=Proportional %></label>\
							<input type="radio" id="gallery_item_token_sizing_crop" class="gallery_item_token_sizing" name="sizing" value="crop" /><label for="gallery_item_token_sizing_crop"><%=Croptosize%></label></p>\
						<p class="option">\
							<%=Position%><input type="radio" id="gallery_item_token_position_left_clear" class="gallery_item_token_position" name="position" value="left_clear" />\
							<label for="gallery_item_token_position_left_clear">\
								<%=Leftclear%></label>\
							<input type="radio" id="gallery_item_token_position_left" class="gallery_item_token_position" name="position" value="left" />\
							<label for="gallery_item_token_position_left">\
								<%=Leftwrap%></label>\
							<input type="radio" id="gallery_item_token_position_right" class="gallery_item_token_position" name="position" value="right" />\
							<label for="gallery_item_token_position_right">\
								<%=Rightwrap%></label></p>\
						<p class="option">\
							<%=Onclickaction%>\
							<input type="radio" id="gallery_item_token_onclick_lightbox" class="gallery_item_token_onclick" name="onclick" value="lightbox" />\
							<label for="gallery_item_token_onclick_lightbox">\
								<%=Openiteminlightbox%></label>\
							<input type="radio" id="gallery_item_token_onclick_redirect" class="gallery_item_token_onclick" name="onclick" value="redirect" />\
							<label for="gallery_item_token_onclick_redirect">\
								<%=RedirecttosetURL%></label>\
							<input type="radio" id="gallery_item_token_onclick_nothing" class="gallery_item_token_onclick" name="onclick" value="nothing" />\
							<label for="gallery_item_token_onclick_nothing">\
								<%=None%></label></p>\
						<p class="option">\
							<input type="checkbox" id="gallery_item_token_title" name="title" value="true" />\
							<label for="gallery_item_token_title">\
								<%=Showtitle%></label></p>\
						<p class="option">\
							<input type="checkbox" id="gallery_item_token_description" name="description" value="true" />\
							<label for="gallery_item_token_description">\
								<%=Showdescription%></label></p>\
						<p class="option">\
							<input type="checkbox" id="gallery_item_token_as_text_link" name="as_text_link" value="true" />\
							<label for="gallery_item_token_as_text_link">\
								<%=Showastandardtextlink%></label></p>\
						<div class="indented" style="display: none;">\
							<p class="option no_margin">\
								<label for="">\
									<%=Linktext%></label>\
								<input type="text" class="disabled" id="gallery_item_token_link_text" name="link_text" value="" /></p>\
							<p class="option no_margin small_grey">\
								<%=Note%></p>\
						</div>\
					</div>');

			$('.content_token_generator.google_maps').html('\
							<div class="dialog_wrapper">\
								<div class="pages_container">\
									<div class="page">\
										<div class="location_search">\
											<%=Searchforlocation%>\
											<input type="text" name="search_input" id="map_location_search" value="" />\
										</div>\
										<div class="map_container">\
										</div>\
										<div class="token_settings">\
											<div class="settings_wrapper">\
												<div class="page general">\
													<p class="option">\
														<button type="button" class="generate_token ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">\
															<%=Generatetoken%></button>\
													</p>\
													<h1>\
														<%=Generalsettings%></h1>\
													<p class="option">\
														<label for="edn_maps_token_map_type">\
															<%=Maptype%></label>\
														<select name="map_type" id="edn_maps_token_map_type">\
															<option value="roadmap">Roadmap</option>\
															<option value="satellite">Satellite</option>\
															<option value="hybrid">Hybrid</option>\
															<option value="terrain">Terrain</option>\
														</select>\
													</p>\
													<p class="option">\
														<label for="edn_maps_token_latitude">\
															<%=Latitude%></label>\
														<input type="text" name="latitude" id="edn_maps_token_latitude" value="" />\
													</p>\
													<p class="option">\
														<label for="edn_maps_token_longitude">\
															<%=Longitude%></label>\
														<input type="text" name="longitude" id="edn_maps_token_longitude" value="" />\
													</p>\
													<p class="option">\
														<label for="edn_maps_token_zoom">\
															<%=Zoom%></label>\
														<input type="text" name="zoom" id="edn_maps_token_zoom" value="" />\
													</p>\
													<p class="option">\
														<label for="edn_maps_token_width">\
															<%=WidthMap%></label>\
														<input type="text" name="width" id="edn_maps_token_width" value="" />\
													</p>\
													<p class="option">\
														<label for="edn_maps_token_height">\
															<%=HeightMap%></label>\
														<input type="text" name="height" id="edn_maps_token_height" value="" />\
													</p>\
													<p class="option">\
														<input type="checkbox" name="scrollwheel" id="edn_maps_token_scrollwheel" value="1" />\
														<label for="edn_maps_token_scrollwheel">\
															<%=Enablescrollwheelzoom%></label>\
													</p>\
													<p class="option">\
														<button type="button" class="add_marker_trigger ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">\
															<%=Addmarker%></button>\
													</p>\
													<div class="map_marker_container">\
														<h2>\
															<%=Mapmarkers %></h2>\
														<a href="#" class="delete_selected">\
															<%=Delete%></a>\
														<div class="marker_list">\
														</div>\
													</div>\
												</div>\
											</div>\
										</div>\
										<div class="token_area">\
											<p class="token_message">\
												<%=CopyAndPasteToken %></p>\
											<div>\
												<textarea class="the_token" cols="10" rows="3"></textarea></div>\
											<button type="button" class="back_to_editor ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">\
												<%=Backtoediting%></button>\
										</div>\
									</div>\
								</div>\
							</div>');
		});

	$draft_radio
		.bind('change', function () {
			$social_sharing_box.stop(true,true).fadeTo(200,0);
			$PostToJournal.stop(true,true).fadeTo(200,0);
			if(<%=ApproveUpdatedArticlesASCX.ToString().ToLower()%>) $approveMsg.stop(true,true).fadeTo(200,0);
		});

	$publish_radio
		.bind('change', function () {
			$social_sharing_box.stop(true,true).fadeTo(200,1);
			$PostToJournal.stop(true,true).fadeTo(200,1);
			if(<%=ApproveUpdatedArticlesASCX.ToString().ToLower()%>) $approveMsg.stop(true,true).fadeTo(200,1);
		});

	$("#<%=ddlCFgroup.ClientID%>").change(function() {
	$.cookie('EDNcfcookie<%=UserId%>', $(this).val());
	});

	$('#<%=lbSocialSecurityGroups.ClientID %>').dropdownchecklist({
		forceMultiple: true,
		minWidth: 106,
		width: 106,
		emptyText: '<span class="empty">None</span>'
	});

	$('#<%=tbPublishDate.ClientID%>').datepick({dateFormat:"<%=dateFormat%>"});
	$('#<%=tbExpireDate.ClientID%>').datepick({dateFormat:"<%=dateFormat%>"});
	$('#<%=tbEventStartDate.ClientID%>').datepick({dateFormat:"<%=dateFormat%>"});
	$('#<%=tbEventEndDate.ClientID%>').datepick({dateFormat:"<%=dateFormat%>"});
	$('#<%=tbEventStartTime.ClientID%>').timePicker({
		startTime: "00:00", // Using string. Can take string or Date object.
		endTime: new Date(0, 0, 0, 23, 59, 0), // Using Date object here.
		show24Hours: <%=time24h %>,
		separator: ':',
		step: 30});
	$('#<%=tbEventEndTime.ClientID%>').timePicker({
		startTime: "00:00", // Using string. Can take string or Date object.
		endTime: new Date(0, 0, 0, 23, 59, 0), // Using Date object here.
		show24Hours: <%=time24h %>,
		separator: ':',
		step: 30});
	$("#EDN_admin_included_galleries")
		.sortable()
		.disableSelection();
	$('#add_existing_tags_box > .content')
		.hide(0);
	$('#add_existing_tags_box > h1.collapsible_box_title.close')
		.removeClass('close');

	var toggleCollapsibleBox = function (e) {
		var clicked = $(e.target),
			target_content = clicked.parent().children('.content');

		if (target_content.is(':visible')) {
			target_content.slideUp(300);
			clicked.removeClass('close');
		} else {
			target_content.slideDown(300);
			clicked.addClass('close');
		}
	};

	$('#EDNadmin .main_content').delegate('h1.collapsible_box_title', 'click', toggleCollapsibleBox);
	$('#<%=pnlPreviousVersions.ClientID%>').click(toggleCollapsibleBox);
	$('#<%=tbArticleTitle.ClientID%>').EDNGenerateUrl('#<%=tbArticleURL.ClientID%>', {
		<%=ViewState["ReplaceChars"]%>
	});

	$('#EDNadmin .main_content').delegate('#<%=hlOpenImageTitleDescriptionOptions.ClientID%>', 'click', function () {
		var clickedLink = $(this),targetToOpen = $('#<%=pnlImageTitleDescriptionOptions.ClientID%>');
			if (targetToOpen.is(':visible')) {
				targetToOpen.slideUp(300);
				clickedLink.removeClass('close');
			} else {
				targetToOpen.slideDown(300);
				clickedLink.addClass('close');
			}
		return false;
		});

	$('#<%=tbCLArticleTitle.ClientID%>').EDNGenerateUrl('#<%=tbxCLArticleURL.ClientID%>', {
		<%=ViewState["ReplaceChars"]%>
	});

	$('#<%=upArticleImages.ClientID%>')
		.delegate('input.token_box', 'focusin', function () {
			var $clicked = $(this);
			$clicked.select()
		})
		.delegate('#<%=lbGallerySettings.ClientID%>', 'click', function () {
			var $toggle_button = $(this),
				$gal_settings_pnl = $('#<%=pnlGallerySettings.ClientID%>');
			if ($gal_settings_pnl.is(":visible")) {
				$gal_settings_pnl.stop(false, true).hide(300);
				$toggle_button
					.html('View settings')
					.removeClass('up_arrows')
					.addClass('down_arrows');
			} else {
				$gal_settings_pnl.stop(false, true).show(300);
				$toggle_button
					.html('Close settings')
					.removeClass('down_arrows')
					.addClass('up_arrows');
			}
			return false;
		});

	$('#EDN_btnReGenerateURL').click(function () {
		$('#<%=tbArticleTitle.ClientID%>').trigger('keyup');
		return false;
	});
	$('#EDN_btnCLReGenerateURL').click(function () {
		$('#<%=tbCLArticleTitle.ClientID%>').trigger('keyup');
		return false;
	});

	var hfGalleryID = document.getElementById('<%=hfGalID.ClientID%>');
	var GalleryID = '';
	if(hfGalleryID != null)
	{
		GalleryID= $("#<%=hfGalID.ClientID%>").val();
	}
	$('#<%=fileInput.ClientID%>').uploadify({
		'uploader': '<%=ModulePath%>js/uploadify.swf',
		'script': '<%=ModulePath%>UploadImages.ashx?tabid=<%=TabId%>',
		'scriptData': { 'id': <%=ModuleId%>, 'foo': GalleryID },
		'cancelImg': '<%=ModulePath%>images/cancel.png',
		'multi': true,
		'fileDesc': 'Image Files',
		'fileExt': '*.jpg;*.png;*.gif;*.bmp;*.jpeg',
		'queueSizeLimit': 100,
		'sizeLimit': 40000000,
		'buttonText': 'SELECT IMAGES FOR UPLOAD',
		'onAllComplete': function (event, queueID, fileObj, response, data) {
			document.getElementById('<%=Button2.ClientID%>').click();
		},
		'onError': function (event, queueID, fileObj, errorObj) {
			var msg;
			if (errorObj.status == 404) {
				alert('Could not find upload script. Use a path relative to: ' + '<?= getcwd() ?>');
				msg = 'Could not find upload script.';
			} else if (errorObj.type === "HTTP")
				msg = errorObj.type + ": " + errorObj.status;
			else if (errorObj.type === "File Size")
				msg = fileObj.name + '<br>' + errorObj.type + ' Limit: ' + Math.round(errorObj.sizeLimit / 1024) + 'KB';
			else
				msg = errorObj.type + ": " + errorObj.text;
			$.jGrowl('<p></p>' + msg, {
				theme: 'error',
				header: 'ERROR',
				sticky: true
			});
			$("#<%=fileInput.ClientID%>" + queueID).fadeOut(250, function () { $("#<%=fileInput.ClientID%>" + queueID).remove() });
			return false;
		},
		'onComplete': function (a, b, c, d, e) {
			var size = Math.round(c.size / 1024);
			$.jGrowl('<p></p>' + c.name + ' - ' + size + 'KB', {
				theme: 'success',
				header: '<%=UploadComplete%>',
				life: 3000,
				sticky: false
			});
		}
	});

		var hfSharedGalleryID = document.getElementById('<%=hfSharedGalID.ClientID%>');
		var SharedGalleryID = '';
		if(hfSharedGalleryID != null)
		{
			SharedGalleryID= $("#<%=hfSharedGalID.ClientID%>").val();
		}
		$(document).ready(function () {
			$('#<%=SharedfileInput.ClientID%>').uploadify({
				'uploader': '<%=ModulePath%>js/uploadify.swf',
				'script': '<%=ModulePath%>UploadImages.ashx?tabid=<%=TabId%>',
				'scriptData': { 'id': <%=ModuleId%>, 'foo': SharedGalleryID },
				'cancelImg': '<%=ModulePath%>images/cancel.png',
				'multi': true,
				'fileDesc': 'Image Files',
				'fileExt': '*.jpg;*.png;*.gif;*.bmp;*.jpeg',
				'queueSizeLimit': 100,
				'sizeLimit': 40000000,
				'buttonText': 'SELECT IMAGES FOR UPLOAD',
				'onAllComplete': function (event, queueID, fileObj, response, data) {
					document.getElementById('<%=ButtonShared.ClientID%>').click();
				},
				'onError': function (event, queueID, fileObj, errorObj) {
					var msg;
					if (errorObj.status == 404) {
						alert('Could not find upload script. Use a path relative to: ' + '<?= getcwd() ?>');
						msg = 'Could not find upload script.';
					} else if (errorObj.type === "HTTP")
						msg = errorObj.type + ": " + errorObj.status;
					else if (errorObj.type === "File Size")
						msg = fileObj.name + '<br>' + errorObj.type + ' Limit: ' + Math.round(errorObj.sizeLimit / 1024) + 'KB';
					else
						msg = errorObj.type + ": " + errorObj.text;
					$.jGrowl('<p></p>' + msg, {
						theme: 'error',
						header: 'ERROR',
						sticky: true
					});
					$("#<%=SharedfileInput.ClientID%>" + queueID).fadeOut(250, function () { $("#<%=SharedfileInput.ClientID%>" + queueID).remove() });
					return false;
				},
				'onComplete': function (a, b, c, d, e) {
					var size = Math.round(c.size / 1024);
					$.jGrowl('<p></p>' + c.name + ' - ' + size + 'KB', {
						theme: 'success',
						header: '<%=UploadComplete%>',
						life: 3000,
						sticky: false
					});

				}
			});
		});

	$('#<%=GalfileInput.ClientID%>').uploadify({
		'uploader': '<%=ModulePath%>js/uploadify.swf',
		'script': '<%=ModulePath%>UploadImages.ashx?tabid=<%=TabId%>',
		'scriptData': { 'id': <%=ModuleId%>, 'foo': '1' },
		'cancelImg': '<%=ModulePath%>images/cancel.png',
		'multi': true,
		'fileDesc': 'Image Files',
		'fileExt': '*.jpg;*.png;*.gif;*.bmp;*.jpeg',
		'queueSizeLimit': 100,
		'sizeLimit': 40000000,
		'buttonText': 'SELECT IMAGES FOR UPLOAD',
		'onAllComplete': function (event, queueID, fileObj, response, data) {
			document.getElementById('<%=Button3.ClientID%>').click();
		},
		'onError': function (event, queueID, fileObj, errorObj) {
			var msg;
			if (errorObj.status == 404) {
				alert('Could not find upload script. Use a path relative to: ' + '<?= getcwd() ?>');
				msg = 'Could not find upload script.';
			} else if (errorObj.type === "HTTP")
				msg = errorObj.type + ": " + errorObj.status;
			else if (errorObj.type === "File Size")
				msg = fileObj.name + '<br>' + errorObj.type + ' Limit: ' + Math.round(errorObj.sizeLimit / 1024) + 'KB';
			else
				msg = errorObj.type + ": " + errorObj.text;
			$.jGrowl('<p></p>' + msg, {
				theme: 'error',
				header: 'ERROR',
				sticky: true
			});
			$("#<%=GalfileInput.ClientID%>" + queueID).fadeOut(250, function () { $("#<%=GalfileInput.ClientID%>" + queueID).remove() });
			return false;
		},
		'onComplete': function (a, b, c, d, e) {
			var size = Math.round(c.size / 1024);
			$.jGrowl('<p></p>' + c.name + ' - ' + size + 'KB', {
				theme: 'success',
				header: '<%=UploadComplete%>',
				life: 3000,
				sticky: false
			});
		}
	});
});

function pageLoad(sender, args) {
	if (args.get_isPartialLoad()) {
		<%=jQueryPrefix%>('#<%=tbPublishDate.ClientID%>').datepick({dateFormat:'<%=dateFormat%>'});
		<%=jQueryPrefix%>('#<%=tbExpireDate.ClientID%>').datepick({dateFormat:'<%=dateFormat%>'});
		<%=jQueryPrefix%>('#<%=tbEventStartDate.ClientID%>').datepick({dateFormat:"<%=dateFormat%>"});
		<%=jQueryPrefix%>('#<%=tbEventEndDate.ClientID%>').datepick({dateFormat:"<%=dateFormat%>"});
		<%=jQueryPrefix%>('#<%=tbEventStartTime.ClientID%>').timePicker({
			startTime: "00:00", // Using string. Can take string or Date object.
			endTime: new Date(0, 0, 0, 23, 59, 0), // Using Date object here.
			show24Hours: <%=time24h %>,
			separator: ':',
			step: 30});
		<%=jQueryPrefix%>('#<%=tbEventEndTime.ClientID%>').timePicker({
			startTime: "00:00", // Using string. Can take string or Date object.
			endTime: new Date(0, 0, 0, 23, 59, 0), // Using Date object here.
			show24Hours: <%=time24h %>,
			separator: ':',
			step: 30});
	if (<%=jQueryPrefix%>('#<%=upArticleImages.ClientID%> .uploadifyQueue').length == 0) {

		var hfSharedGalleryID = document.getElementById('<%=hfSharedGalID.ClientID%>');
		var SharedGalleryID = '';
		if(hfSharedGalleryID != null)
		{
			SharedGalleryID= $("#<%=hfSharedGalID.ClientID%>").val();
		}
		<%=jQueryPrefix%>(document).ready(function ($) {
			$("#EDN_admin_included_galleries")
				.sortable()
				.disableSelection();
			$('#<%=SharedfileInput.ClientID%>').uploadify({
				'uploader': '<%=ModulePath%>js/uploadify.swf',
				'script': '<%=ModulePath%>UploadImages.ashx?tabid=<%=TabId%>',
				'scriptData': { 'id': <%=ModuleId%>, 'foo': SharedGalleryID },
				'cancelImg': '<%=ModulePath%>images/cancel.png',
				'multi': true,
				'fileDesc': 'Image Files',
				'fileExt': '*.jpg;*.png;*.gif;*.bmp;*.jpeg',
				'queueSizeLimit': 100,
				'sizeLimit': 40000000,
				'buttonText': 'SELECT IMAGES FOR UPLOAD',
				'onAllComplete': function (event, queueID, fileObj, response, data) {
					document.getElementById('<%=ButtonShared.ClientID%>').click();
				},
				'onError': function (event, queueID, fileObj, errorObj) {
					var msg;
					if (errorObj.status == 404) {
						alert('Could not find upload script. Use a path relative to: ' + '<?= getcwd() ?>');
						msg = 'Could not find upload script.';
					} else if (errorObj.type === "HTTP")
						msg = errorObj.type + ": " + errorObj.status;
					else if (errorObj.type === "File Size")
						msg = fileObj.name + '<br>' + errorObj.type + ' Limit: ' + Math.round(errorObj.sizeLimit / 1024) + 'KB';
					else
						msg = errorObj.type + ": " + errorObj.text;
					$.jGrowl('<p></p>' + msg, {
						theme: 'error',
						header: 'ERROR',
						sticky: true
					});
					$("#<%=SharedfileInput.ClientID%>" + queueID).fadeOut(250, function () { $("#<%=SharedfileInput.ClientID%>" + queueID).remove() });
					return false;
				},
				'onComplete': function (a, b, c, d, e) {
					var size = Math.round(c.size / 1024);
					$.jGrowl('<p></p>' + c.name + ' - ' + size + 'KB', {
						theme: 'success',
						header: '<%=UploadComplete%>',
						life: 3000,
						sticky: false
					});
				}
			});

			var hfGalleryID = document.getElementById('<%=hfGalID.ClientID%>');
			var GalleryID = '';
			if(hfGalleryID != null)
			{
				GalleryID= $("#<%=hfGalID.ClientID%>").val();
			}
			$('#<%=fileInput.ClientID%>').uploadify({
				'uploader': '<%=ModulePath%>js/uploadify.swf',
				'script': '<%=ModulePath%>UploadImages.ashx?tabid=<%=TabId%>',
				'scriptData': { 'id': <%=ModuleId%>, 'foo': GalleryID },
				'cancelImg': '<%=ModulePath%>images/cancel.png',
				'multi': true,
				'fileDesc': 'Image Files',
				'fileExt': '*.jpg;*.png;*.gif;*.bmp;*.jpeg',
				'queueSizeLimit': 100,
				'sizeLimit': 4000000,
				'buttonText': 'SELECT IMAGES FOR UPLOAD',
				'onAllComplete': function (event, queueID, fileObj, response, data) {
					document.getElementById('<%=Button2.ClientID%>').click();
				},
				'onError': function (event, queueID, fileObj, errorObj) {
					var msg;
					if (errorObj.status == 404) {
						alert('Could not find upload script. Use a path relative to: ' + '<?= getcwd() ?>');
						msg = 'Could not find upload script.';
					} else if (errorObj.type === "HTTP")
						msg = errorObj.type + ": " + errorObj.status;
					else if (errorObj.type === "File Size")
						msg = fileObj.name + '<br>' + errorObj.type + ' Limit: ' + Math.round(errorObj.sizeLimit / 1024) + 'KB';
					else
						msg = errorObj.type + ": " + errorObj.text;
					$.jGrowl('<p></p>' + msg, {
						theme: 'error',
						header: 'ERROR',
						sticky: true
					});
					$("#<%=fileInput.ClientID%>" + queueID).fadeOut(250, function () { $("#<%=fileInput.ClientID%>" + queueID).remove() });
					return false;
				},
				'onComplete': function (a, b, c, d, e) {
					var size = Math.round(c.size / 1024);
					$.jGrowl('<p></p>' + c.name + ' - ' + size + 'KB', {
						theme: 'success',
						header: '<%=UploadComplete%>',
						life: 3000,
						sticky: false
					});
				}
			});

			$('#<%=GalfileInput.ClientID%>').uploadify({
				'uploader': '<%=ModulePath%>js/uploadify.swf',
				'script': '<%=ModulePath%>UploadImages.ashx?tabid=<%=TabId%>',
				'scriptData': { 'id': <%=ModuleId%>, 'foo': '1' },
				'cancelImg': '<%=ModulePath%>images/cancel.png',
				'multi': true,
				'fileDesc': 'Image Files',
				'fileExt': '*.jpg;*.png;*.gif;*.bmp;*.jpeg',
				'queueSizeLimit': 100,
				'sizeLimit': 4000000,
				'buttonText': 'SELECT IMAGES FOR UPLOAD',
				'onAllComplete': function (event, queueID, fileObj, response, data) {
					document.getElementById('<%=Button3.ClientID%>').click();
				},
				'onError': function (event, queueID, fileObj, errorObj) {
					var msg;
					if (errorObj.status == 404) {
						alert('Could not find upload script. Use a path relative to: ' + '<?= getcwd() ?>');
						msg = 'Could not find upload script.';
					} else if (errorObj.type === "HTTP")
						msg = errorObj.type + ": " + errorObj.status;
					else if (errorObj.type === "File Size")
						msg = fileObj.name + '<br>' + errorObj.type + ' Limit: ' + Math.round(errorObj.sizeLimit / 1024) + 'KB';
					else
						msg = errorObj.type + ": " + errorObj.text;
					$.jGrowl('<p></p>' + msg, {
						theme: 'error',
						header: 'ERROR',
						sticky: true
					});
					$("#<%=GalfileInput.ClientID%>" + queueID).fadeOut(250, function () { $("#<%=GalfileInput.ClientID%>" + queueID).remove() });
					return false;
				},
				'onComplete': function (a, b, c, d, e) {
					var size = Math.round(c.size / 1024);
					$.jGrowl('<p></p>' + c.name + ' - ' + size + 'KB', {
						theme: 'success',
						header: '<%=UploadComplete%>',
						life: 3000,
						sticky: false
					});

				}
			});
		});
		}
	}
}
</script>
