<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.GalleryControlAudio, App_Web_gallerycontrolaudio.ascx.1b1ab6" enableviewstate="false" %>
<div id="AudioGalleryID" runat="server" class="article_gallery">
	<asp:Panel ID="pnlAudioGallery" runat="server">
		<div id='<%=settings.GalleryTheme.Substring(0, settings.GalleryTheme.LastIndexOf("."))%>' class="easydnngallery">
			<div class="EDGbackground">
				<div class="EDGcontentbgrd">
					<div class="EDGcornerbotleft">
						<div class="EDGcornerbotright">
							<div class="EDGcornertopleft">
								<div class="EDGcornertopright">
									<div class="EDGcontent" style="text-align: center;">
										<asp:Label ID="lblMessage" runat="server" Text="" Visible="False"></asp:Label>
										<asp:DataList ID="dlAudioGallery" runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" ItemStyle-VerticalAlign="Top" OnItemCreated="dlAudioGallery_ItemCreated"
											CssClass="audio_gallery">
											<EditItemStyle HorizontalAlign="Center" />
											<ItemStyle VerticalAlign="Top" />
											<ItemTemplate>
												<div class="AudioTitle">
													<asp:Label ID="lblAGMediaTitle" runat="server" CssClass="EDGTitleText" Text='<%#Eval("Title") %>' Visible="True" />
												</div>
												<div id="<%#Eval("PictureID")%>" class="AudioBody">
													You need to upgrade your flash player.
												</div>
												<script type="text/javascript">
													eds1_8(document).ready(function () {
														var flashvars = {};
														var params = {};
														var attributes = {};
														params.codebase = 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0';
														params.scale = 'noscale';
														params.salign = "middle";
														params.swliveconnect = "true";
														params.allowscriptaccess = "always";
														params.wmode = "transparent";
														flashvars.width = '<%=settings.ThumbWidth%>';
														flashvars.autoLoad = 'false';
														flashvars.autoPlay = 'false';
														flashvars.volume = '200';
														flashvars.song1url = '<%=hostpath%><%#Eval("Filename")%>';
														attributes.id = 'AudioPlayer';
														swfobject.embedSWF('<%=ModulePath%><%=Mp3Player%>', '<%#Eval("PictureID")%>', '<%=settings.ThumbWidth%>', '33', '9.0.0', 'js/expressInstall.swf', flashvars, params, attributes);
													});
												</script>
												<div class="AudioDescription">
													<asp:Label ID="lblAGMediaDescription" runat="server" CssClass="EDGTitleText" Text='<%#Server.HtmlDecode(DataBinder.Eval(Container.DataItem, "Description").ToString())%>' Visible="True" />
												</div>
											</ItemTemplate>
										</asp:DataList>
										<asp:GridView ID="gvAudioGalPagination" runat="server" AllowPaging="True" AutoGenerateColumns="False" BorderWidth="0px" BorderStyle="None" DataKeyNames="NumOf" HorizontalAlign="Center" PageSize="1" ShowFooter="True" GridLines="None" CssClass="gallery_pagination"
											OnPageIndexChanging="gvAudioGalPagination_PageIndexChanging">
											<Columns>
												<asp:BoundField DataField="FileName" Visible="False" />
											</Columns>
											<PagerStyle BorderWidth="0px" CssClass="EDGpager" HorizontalAlign="Center" />
										</asp:GridView>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div style="clear: both">
					&nbsp;</div>
			</div>
		</div>
	</asp:Panel>
</div>
