<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.ViewEasyDNNNewsCatalog, App_Web_vieweasydnnnewscatalog.ascx.d988a5ac" autoeventwireup="true" enableviewstate="true" %>
<%@ Register TagPrefix="dnnCTRL" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<script type="text/javascript">
	eds1_8(document).ready(function ($) {
		$("a[rel^='ednprettyPhoto']").prettyPhoto({
			animationSpeed: 'normal',
			slideshow: false, 
			autoplay_slideshow: false,
			overlay_gallery: false,
			padding: 80,
			opacity: 0.8,
			showTitle: true,
			allowresize: true,
			hideflash: true,
			wmode: 'opaque',
			autoplay: true,
			modal: false,
			counter_separator_label: '/',
			theme: '<%=LightboxTheme%>',
			callback: function () { }
		});
	});

	function pageLoad(sender, args) {
		if (args.get_isPartialLoad()) {
			eds1_8(document).ready(function ($) {
				$("a[rel^='ednprettyPhoto']").prettyPhoto({
					animationSpeed: 'normal',
					slideshow: false,
					autoplay_slideshow: false,
					overlay_gallery: false,
					padding: 80,
					opacity: 0.8,
					showTitle: true,
					hideflash: true,
					wmode: 'opaque',
					autoplay: true,
					modal: false,
					allowresize: true,
					counter_separator_label: '/',
					theme: '<%=LightboxTheme%>',
					callback: function () { }
				});
			});
		}
	}
	function setFocusComment() {
			var item = document.getElementById('<%=tbAddCommentName.ClientID%>');
			if(item)
			{
			document.getElementById('<%=lbAddComment.ClientID%>').focus();
			document.getElementById('<%=tbAddCommentName.ClientID%>').focus();
			}
			else 
			{
			document.getElementById('<%=lbAddComment.ClientID%>').focus();
			document.getElementById('<%=tbAddComment.ClientID%>').focus();
		}
	}
</script>
<asp:Literal ID="countfacebookJS" runat="server" EnableViewState="false" />
<div id="<%=MainDivID%>" <%=MainDivClass%>>
	<asp:Panel ID="pnlUserDashBoard" runat="server" Visible="False" CssClass="user_dashboard" EnableViewState="false">
		<asp:LinkButton ID="lbAddArticles" runat="server" CssClass="add_article" OnClick="lbAddNewArticle_Click"><%=Localization.GetString("lbAddArticles.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:LinkButton>
		<asp:LinkButton ID="lbArticleEditor" runat="server" CssClass="article_manager" OnClick="lbArticleEditor_Click"><%=Localization.GetString("lbArticleEditor.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:LinkButton>
		<asp:LinkButton ID="lbApproveComments" runat="server" CssClass="approve_comments" OnClick="lbApproveComments_Click"><%=Localization.GetString("lbApproveComments.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:LinkButton>
		<asp:LinkButton ID="lbCategoryEdit" runat="server" CssClass="category_manager" OnClick="lbCategoryEdit_Click"><%=Localization.GetString("lbCategoryEdit.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:LinkButton>
		<asp:LinkButton ID="lbApproveRoles" runat="server" CssClass="approve_articles" OnClick="lbApproveRoles_Click"><%=Localization.GetString("lbApproveRoles.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:LinkButton>
		<asp:LinkButton ID="lbDashboard" runat="server" CssClass="dashboard" OnClick="lbDashboard_Click" Visible="False"><%=Localization.GetString("lbDashboard.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:LinkButton>
		<asp:LinkButton ID="lbDBSettings" runat="server" CssClass="settings" Visible="False" OnClick="lbDBSettings_Click"><%=Localization.GetString("lbDBSettings.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:LinkButton>
		<asp:LinkButton ID="lbAboutMe" runat="server" CssClass="author_profile" Visible="False" OnClick="lbAboutMe_Click"><%=Localization.GetString("lbAboutMe.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:LinkButton>
	</asp:Panel>
	<asp:Panel ID="pnlListArticles" runat="server">
		<p class="bread_crumbs">
			<asp:Literal runat="server" ID="breadCrumbsHTML" EnableViewState="false"/>
		</p>
		<%=DisplayBeforeMulti()%>
		<%=DisplayCatalogHeader()%>
		<asp:Panel ID="pnlListCategories" runat="server" CssClass="child_categories">
			<asp:DataList ID="dlCatList" runat="server" RepeatDirection="Horizontal" EnableViewState="false">
				<ItemStyle VerticalAlign="Top" />
				<ItemTemplate>
					<%#DisplayCatalogCategories(Eval("CategoryName"), Eval("CategoryText"), Eval("CategoryImage"), Eval("CategoryID"), Eval("CategoryURL"))%>
				</ItemTemplate>
			</asp:DataList>
		</asp:Panel>
		<asp:Literal ID="litSearchInfo" runat="server" Visible="false" EnableViewState="false"></asp:Literal>
		<asp:DataList ID="dlArticleList" runat="server" OnItemCommand="dlArticleList_ItemCommand" RepeatDirection="Horizontal" ShowFooter="false" ShowHeader="false" EnableViewState="false">
			<ItemStyle VerticalAlign="Top" />
			<ItemTemplate>
				<asp:HyperLink ID="hlEditThisArticle" CssClass="admin_action edit" runat="server" Visible='<%#(PortalSharing==PortalId)&&Convert.ToBoolean(Eval("CanEdit"))%>' NavigateUrl='<%#EditArticleUrl(Eval("ArticleID"))%>'><%=strEditArticle%></asp:HyperLink>
				<asp:LinkButton ID="btnApprove" runat="server" Visible='<%#Convert.ToBoolean(Eval("Approve"))%>' CommandArgument='<%#Eval("ArticleID")%>' CommandName="Approve" Text="Approve" CssClass="admin_action publish_article"><%=strApproveArticle%></asp:LinkButton>
				<asp:LinkButton ID="btnPublish" runat="server" Visible='<%#Convert.ToBoolean(Eval("Published"))%>' CommandArgument='<%#Eval("ArticleID")%>' CommandName="Publish" Text="Publish" CssClass="admin_action publish_article"><%=strPublishArticle%></asp:LinkButton>
				<%#DisplayArticles(Eval("ArticleID"), Eval("Article"), Eval("UserID"), Eval("Title"), Eval("SubTitle"), Eval("Summary"), Eval("PublishDate"), Eval("ArticleImage"), Eval("TitleLink"), Eval("DetailType"), Eval("DetailTypeData"), Eval("ShowMainImageFront"), Eval("ArticleImageFolder"), Eval("NumberOfViews"), Container.ItemIndex, Eval("DetailTarget"), Eval("Active"), Eval("ArticleFromRSS"), Eval("CatToShow"), Eval("CanEdit"), Eval("Published"), Eval("AuthorAliasName"), Eval("EventArticle"), Eval("RatingValue"), Eval("MainImageTitle"), Eval("MainImageDescription"), Eval("Featured"))%>
			</ItemTemplate>
		</asp:DataList>
		<%=DisplayAfterMulti()%>
		<asp:Panel ID="pnlArticlePager" runat="server" CssClass="article_pager" EnableViewState="false">
			<asp:LinkButton ID="ibFirst" CssClass="first" runat="server" OnClick="ibFirst_Click" Visible="False"><%=Localization.GetString("First.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:LinkButton>
			<asp:LinkButton ID="ibLeft" runat="server" CssClass="prev" OnClick="ibLeft_Click" Visible="False"><%=Localization.GetString("Previous.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:LinkButton>
			<asp:PlaceHolder ID="PaggingHTML" runat="server" />
			<asp:LinkButton ID="ibRight" runat="server" CssClass="next" OnClick="ibRight_Click" Visible="False"><%=Localization.GetString("Next.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:LinkButton>
			<asp:LinkButton ID="ibLast" CssClass="last" runat="server" OnClick="ibLast_Click" Visible="False"><%=Localization.GetString("Last.Text", this.LocalResourceFile + "ViewEasyDNNNews.ascx.resx")%></asp:LinkButton>
		</asp:Panel>
	</asp:Panel>
	<asp:Panel ID="pnlViewArticle" runat="server">
		<p class="bread_crumbs">
			<%=generateArticleBreadCrumbs()%>
		</p>
		<%=editLink("admin_action edit")%>
		<asp:LinkButton ID="lbPublishArticle" CssClass="admin_action publish_article" OnClick="lbPublishArticle_Click" Visible="false" runat="server">Published</asp:LinkButton>
		<asp:LinkButton ID="lbApproveArticle" CssClass="admin_action publish_article" OnClick="lbApproveArticle_Click" Visible="false" runat="server">Approve</asp:LinkButton>
		<%=generateArticleHtml("EDNHeader")%>
		<asp:UpdatePanel ID="upHeader" runat="server" UpdateMode="Conditional">
			<ContentTemplate>
				<asp:GridView ID="gvHeaderArtPagging" runat="server" EnableModelValidation="True" AutoGenerateColumns="False" AllowPaging="True" PageSize="1" BorderStyle="None" BorderWidth="0px" CellPadding="0" GridLines="None" ShowHeader="False" OnPageIndexChanging="gvHeaderArtPagging_PageIndexChanging" EnableViewState="false">
					<Columns>
						<asp:TemplateField HeaderText="Article" ShowHeader="False">
							<ItemTemplate>
								<%# Eval("Article") %>
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
					<PagerStyle HorizontalAlign="Center" />
				</asp:GridView>
			</ContentTemplate>
		</asp:UpdatePanel>
		<asp:PlaceHolder ID="plTopGallery" runat="server"></asp:PlaceHolder>
		<%=generateArticleHtml("EDNContentTop")%>
		<%=generateArticleHtml("EDNContent")%>
		<asp:UpdatePanel ID="upArticle" runat="server" UpdateMode="Conditional">
			<ContentTemplate>
				<%=generateArticleHtml("EDNContent")%>
				<asp:GridView ID="gvArticlePagging" runat="server" EnableModelValidation="True" AutoGenerateColumns="False" AllowPaging="True" PageSize="1" BorderStyle="None" BorderWidth="0px" CellPadding="0" GridLines="None" OnPageIndexChanging="gvArticlePagging_PageIndexChanging"
					ShowHeader="False" EnableViewState="false">
					<Columns>
						<asp:TemplateField HeaderText="Article" ShowHeader="False">
							<ItemTemplate>
								<%# Eval("Article") %>
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
					<PagerSettings Mode="NumericFirstLast" />
					<PagerStyle HorizontalAlign="Center" CssClass="article_pagination" />
				</asp:GridView>
			</ContentTemplate>
		</asp:UpdatePanel>
		<%=generateArticleHtml("EDNContentBottom")%>
		<asp:PlaceHolder ID="plBottomGallery" runat="server"></asp:PlaceHolder>
		<%=generateArticleHtml("EDNFooter")%>
		<asp:Panel ID="pnlArticelImagesGallery" runat="server" class="edn_article_gallery">
			<ul>
				<asp:Repeater ID="repArticleImages" runat="server" EnableViewState="false">
					<ItemTemplate>
						<li><a href='<%#Eval("FileName")%>' pptitle='<%#Eval("Description")%>' rel="ednprettyPhoto_M<%=ModuleId%>">
							<asp:Image alt='<%#Eval("Title")%>' ID="imgArticleGalleryImage" ImageUrl='<%#Eval("Thumburl")%>' runat="server" /></a> </li>
					</ItemTemplate>
				</asp:Repeater>
			</ul>
		</asp:Panel>
		<%=editLink("admin_action edit")%>
		<script type="text/javascript">
			eds1_8(document).ready(function ($) {
				var $rate_it = $("#<%=MainDivID%> .EDN_article_rateit");
				$rate_it.bind('rated reset', function (e) {
						var ri = $(this);
						var value = ri.rateit('value');
						var articleid = <%=publicOpenArticleID%>;
						$rate_it.rateit('readonly', true);
						ri.rateit('readonly', true);
						$.cookie("<%=EDNViewArticleID%>", "true");
						document.getElementById("<%=hfRate.ClientID %>").value= value;
						$.ajax(
						{
							url: "<%=ModulePath %>Rater.aspx",
							type: "POST",
							data: {artid: articleid, rating: value},
							success: function (data)
							{
								ri.siblings('.current_rating').text(data);
							}
						});
					})
					.rateit('value', document.getElementById("<%=hfRate.ClientID %>").value)
					.rateit('readonly', $.cookie("<%=EDNViewArticleID%>"))
					.rateit('step',1);
			});
		</script>
		<asp:HiddenField ID="hfRate" runat="server" />
		<script type="text/javascript">
		// <![CDATA[
			eds1_8(function ($) {
				$('#<%=upPanelComments.ClientID %>').on('click', '#<%=lbAddComment.ClientID %>', function () {
					var $lbAddComment = $('#<%=lbAddComment.ClientID %>'),
						noErrors = true,

						$authorNameInput = $('#<%=tbAddCommentName.ClientID %>'),
						$authorEmailInput = $('#<%=tbAddCommentEmail.ClientID %>'),

						authorName,
						authorEmail,
						comment = $('#<%=tbAddComment.ClientID %>').val(),

						$noAuthorName = $('#<%=lblAddCommentNameError.ClientID %>'),
						$noAuthorEmail = $('#<%=lblAddCommentEmailError.ClientID %>'),
						$authorEmailNotValid = $('#<%=lblAddCommentEmailValid.ClientID %>'),
						$noComment = $('#<%=lblAddCommentError.ClientID %>'),

						emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

					if ($lbAddComment.data('disable'))
						return false;

					if ($authorNameInput.length > 0) {
						authorName = $authorNameInput.val();

						$noAuthorName.css('display', 'none');

						if (authorName == '') {
							$noAuthorName.css('display', 'block');
							noErrors = false;
						}
					}

					if ($authorEmailInput.length > 0) {
						authorEmail = $authorEmailInput.val();

						$noAuthorEmail.css('display', 'none');
						$authorEmailNotValid.css('display', 'none');

						if (authorEmail == '') {
							$noAuthorEmail.css('display', 'block');
							noErrors = false;
						} else if (!emailRegex.test(authorEmail)) {
							$authorEmailNotValid.css('display', 'block');
							noErrors = false;
						}
					}

					if (comment == '') {
						$noComment.css('display', 'block');
						noErrors = false;
					} else
						$noComment.css('display', 'none');

					if (noErrors)
						$lbAddComment.data('disable', true);
					else
						return false;
				});
			});
		//*/ ]]>
		</script>
		<asp:UpdatePanel ID="upPanelComments" runat="server">
			<ContentTemplate>
				<asp:Panel ID="pnlComments" runat="server" CssClass="article_comments" Visible="false">
					<asp:Literal ID="numberOfCommentsHTML" runat="server" />
					<asp:DataList ID="dlComments" runat="server" DataKeyField="CommentID" OnItemCommand="dlComments_ItemCommand" CssClass="comment_list" RepeatLayout="Flow" EnableViewState="false">
						<ItemTemplate>
							<div class="comment level<%#NestedCommentClass(Eval("ReplayLevel"))%>">
								<asp:Panel ID="pnlCommentRating" runat="server" CssClass="votes" Visible='<%#ShowCommentsRatingascx%>'>
									<div>
										<asp:ImageButton ID="imgBGoodVotes" runat="server" ImageUrl='~/DesktopModules/EasyDNNNews/images/upvote.png' CommandArgument="<%# ((DataListItem) Container).ItemIndex %>" CommandName="GoodVote" CausesValidation="false" />
										<asp:Label ID="lblGoodVotes" runat="server" Text='<%#Eval("GoodVotes")%>' />
									</div>
									<div>
										<asp:ImageButton ID="imgBBadVotes" runat="server" ImageUrl="~/DesktopModules/EasyDNNNews/images/downvote.png" CommandArgument="<%# ((DataListItem) Container).ItemIndex %>" CommandName="BadVote" />
										<asp:Label ID="lblBadVotes" runat="server" Text='<%#Eval("BadVotes")%>' />
									</div>
								</asp:Panel>
								<div class="right_side">
									<%#DisplayComments(Eval("CommentID"),Eval("CommentersEmail"),Eval("ArticleID"),Eval("UserID"),Eval("AnonymName"),Eval("Comment"),Eval("DateAdded"), Eval("GoodVotes"),Eval("BadVotes"),Eval("Approved"),Eval("CommentersEmail")) %>
									<div class="actions">
										<asp:LinkButton ID="lbReplayToComment" CssClass="reply" runat="server" OnClientClick="setFocusComment();" Text='<%#lbReplayToCommentloc%>' CommandName="ReplayToCommet" CommandArgument='<%#Eval("CommentID")%>' Visible='<%#DisplayReplayTo%>' />
										<asp:LinkButton ID="lbDeleteComment" CssClass="delete" runat="server" Text="Delete comment" CommandName="DeleteComment" CommandArgument='<%#Eval("CommentID")%>' Visible="<%#IsComentModerator()%>" />
										<asp:LinkButton ID="lbEditComment" CssClass="edit" runat="server" Text="Edit comment" CommandName="EditComment" CommandArgument='<%#Eval("CommentID")%>' Visible="<%#Convert.ToBoolean(IsComentModerator())%>" />
									</div>
									<asp:HiddenField ID="hfCommentID" Value='<%#Eval("CommentID")%>' runat="server" />
								</div>
								<asp:Panel ID="pnlEditComments" runat="server" Visible="false" class="edit_comment">
									<asp:TextBox ID="tbEditComment" Text='<%#Eval("Comment")%>' runat="server" TextMode="MultiLine" />
									<div class="actions">
										<asp:LinkButton ID="lbUpdateComment" runat="server" CommandArgument='<%#Eval("CommentID")%>' CommandName="UpdateComment"><span>Update</span></asp:LinkButton>
										<asp:LinkButton ID="lbCancelUpdateComment" runat="server" CommandArgument='<%#Eval("CommentID")%>' CommandName="CancelEdit"><span>Cancel</span></asp:LinkButton>
									</div>
								</asp:Panel>
							</div>
						</ItemTemplate>
					</asp:DataList>
					<asp:Panel ID="pnlAddComments" runat="server" CssClass="add_comment">
						<h3>
							<%=LeaveAComment%></h3>
						<div class="add_article_box">
							<asp:Panel ID="pnlReplayToComment" runat="server" CssClass="comment_info" Visible="false">
								<asp:Label ID="lblReplayToComment" runat="server" Text="" />
							</asp:Panel>
							<asp:Panel ID="pnlCommentsNameEmail" runat="server">
								<table cellspacing="0" cellpadding="0">
									<tr>
										<td class="left">
											<asp:Label ID="lblAddCommentName" runat="server" Text="Name:" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbAddCommentName" runat="server" CssClass="text" MaxLength="50" ValidationGroup="vgAddArtComment" />
											<asp:Label ID="lblAddCommentNameError" runat="server" Text="Please enter your name." style="color: red; display: none;" />
										</td>
									</tr>
									<tr>
										<td class="left">
											<asp:Label ID="lblAddCommentEmail" runat="server" Text="Email:" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbAddCommentEmail" runat="server" CssClass="text" MaxLength="50" ValidationGroup="vgAddArtComment" />
											<asp:Label ID="lblAddCommentEmailError" runat="server" Text="Please enter email." style="color: red; display: none;" />
											<asp:Label ID="lblAddCommentEmailValid" runat="server" Text="Please enter valid email." style="color: red; display: none;" />
										</td>
									</tr>
								</table>
							</asp:Panel>
							<table cellspacing="0" cellpadding="0">
								<tr>
									<td class="left">
										<asp:Label ID="lblAddComment" runat="server" Text="Comment:"></asp:Label>
									</td>
									<td class="right">
										<asp:TextBox ID="tbAddComment" runat="server" TextMode="MultiLine" MaxLength="10000" ValidationGroup="vgAddArtComment" />
										<asp:Label ID="lblAddCommentError" runat="server" Text="Please enter comment." style="color: red; display: none;" />
									</td>
								</tr>
							</table>
							<asp:Panel ID="pnlCaptcha" runat="server" Visible="False">
								<table cellspacing="0" cellpadding="0">
									<tr>
										<td class="left">
										</td>
										<td class="right">
											<dnnCTRL:CaptchaControl ID="ctlCaptcha" runat="server" CaptchaHeight="50px" CaptchaLength="5" CaptchaWidth="300px" CssClass="Normal" Enabled="true" ErrorStyle-CssClass="NormalRed" Expiration="600" BorderColor="Black" />
											<asp:Label ID="lblCaptchaError" runat="server" ForeColor="Red" Text="The typed code must match the image, please try again" Visible="False" />
										</td>
									</tr>
								</table>
							</asp:Panel>
							<table cellspacing="0" cellpadding="0">
								<tr>
									<td class="left">
									</td>
									<td class="right bottom">
										<asp:LinkButton ID="lbAddComment" runat="server" OnClick="lbAddComment_Click" resourcekey="lbAddComentResource" CssClass="submit" ValidationGroup="vgAddArtComment"><span><%=AddComment%></span></asp:LinkButton>
									</td>
								</tr>
							</table>
						</div>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlCommentInfo" runat="server" CssClass="article_comments" Visible="false" EnableViewState="false" />
				<asp:HiddenField ID="hfReplayToComment" runat="server" />
			</ContentTemplate>
		</asp:UpdatePanel>
		<asp:Literal ID="socComments" runat="server" EnableViewState="False" Visible="False"></asp:Literal>
		<%=generateArticleHtml("EDNBottom")%>
	</asp:Panel>
	<asp:Label ID="lblInfoMassage" runat="server" Style="font-weight: bold" EnableViewState="false" Visible="false" />
</div>
<asp:Literal ID="ltPPbioInit" runat="server" Visible="False" />
<asp:ObjectDataSource ID="odsGetArticleImages" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetOnlyImagesToShow" EnableViewState="false">
	<SelectParameters>
		<asp:Parameter Name="GalleryID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
<asp:HiddenField ID="hfViewed" runat="server" />
<asp:Literal ID="countdisqusJS" runat="server" EnableViewState="false" />
<script src="<%=ModulePath%>js/jquery.rateit.js" type="text/javascript"></script>
