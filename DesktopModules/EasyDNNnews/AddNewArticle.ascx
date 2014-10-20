<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.AddNewArticle, App_Web_addnewarticle.ascx.d988a5ac" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<script type="text/javascript">

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

	if ('<%=jQueryPrefix%>'=='jQuery')
	{
		jQuery.noConflict();
	}
	window.edn_module_root = '<%=ModulePath%>';
	window.edn_geolocation_request = <%=NewsPortalSettings.MapsUserLocationRequest.ToString().ToLower()%>;
	function sveok() {
		<%=jQueryPrefix%>.jGrowl('<p></p>', {
			theme: 'success',
			header: 'Settings saved',
			life: 3000,
			sticky: false
		});
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
															<%=Width%></label>\
														<input type="text" name="width" id="edn_maps_token_width" value="" />\
													</p>\
													<p class="option">\
														<label for="edn_maps_token_height">\
															<%=Height%></label>\
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
														<a href="#" class="delete_selected">Delete</a>\
														<div class="marker_list">\
														</div>\
													</div>\
												</div>\
											</div>\
										</div>\
										<div class="token_area">\
											<p class="token_message">\
												<%=CopyAndPAsteContent %></p>\
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
				$social_sharing_box.stop(true, true).fadeTo(200,0);
				$PostToJournal.stop(true, true).fadeTo(200,0);
				if(<%=ApproveArticlesASCX.ToString().ToLower()%>) $approveMsg.stop(true, true).fadeTo(200,0);
			});

		$publish_radio
			.bind('change', function () {
				$social_sharing_box.stop(true, true).fadeTo(200,1);
				$PostToJournal.stop(true, true).fadeTo(200,1);
				if(<%=ApproveArticlesASCX.ToString().ToLower()%>) $approveMsg.stop(true, true).fadeTo(200,1);
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
		startTime: "00:00", 
		endTime: new Date(0, 0, 0, 23, 59, 0), 
		show24Hours: <%=time24h %>,
		separator: ':',
		step: 30});
		$('#<%=tbEventEndTime.ClientID%>').timePicker({
		startTime: "00:00", 
		endTime: new Date(0, 0, 0, 23, 59, 0), 
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
		$('#EDNadmin .main_content').delegate('h1.collapsible_box_title', 'click', function () {
			var clicked = $(this), target_content = clicked.parent().children('.content');
			if (target_content.is(':visible')) {
				target_content.slideUp(300);
				clicked.removeClass('close');
			} else {
				target_content.slideDown(300);
				clicked.addClass('close');
			}
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

		$('#<%=tbArticleTitle.ClientID%>').EDNGenerateUrl('#<%=tbArticleURL.ClientID%>', {
			<%=ViewState["ReplaceChars"]%>
		});

		$('#EDN_btnReGenerateURL').click(function () {
			$('#<%=tbArticleTitle.ClientID%>').trigger('keyup');
			return false;
		});

		$('#<%=upArticleImages.ClientID%>')
			.delegate('input.token_box', 'focusin', function () {
				var $clicked = <%=jQueryPrefix%>(this);
				$clicked.select()
			})
			.delegate('#<%=lbGallerySettings.ClientID%>', 'click', function () {
				var $toggle_button = jQuery(this),
					$gal_settings_pnl = jQuery('#<%=pnlGallerySettings.ClientID%>');

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

			var hfSharedGalleryID = document.getElementById('<%=hfSharedGalID.ClientID%>');
			var SharedGalleryID = '';
			if(hfSharedGalleryID != null)
			{
				SharedGalleryID= $("#<%=hfSharedGalID.ClientID%>").val();
			}
			<%=jQueryPrefix%>(document).ready(function ($) {

				$('#<%=SharedfileInput.ClientID%>').uploadify({
					'uploader': '<%=ModulePath%>js/uploadify.swf',
					'script': '<%=ModulePath%>UploadImages.ashx?tabid=<%=TabId%>',
					'scriptData': { 'id': <%=ModuleId%>, 'foo': SharedGalleryID },
					'cancelImg': '<%=ModulePath%>images/cancel.png',
					'multi': true,
					'fileDesc': 'Image Files',
					'fileExt': '*.jpg;*.png;*.gif;*.bmp;*.jpeg',
					'queueSizeLimit': 100,
					'sizeLimit': 400000000,
					'buttonText': "SELECT IMAGES FOR UPLOAD",

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
						$("#<%=SharedfileInput.ClientID%>" + queueID).fadeOut(250, function () { <%=jQueryPrefix%>("#<%=SharedfileInput.ClientID%>" + queueID).remove() });
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

			<%=jQueryPrefix%>(document).ready(function ($) {
				$('#<%=GalfileInput.ClientID%>').uploadify({
					'uploader': '<%=ModulePath%>js/uploadify.swf',
					'script': '<%=ModulePath%>UploadImages.ashx?tabid=<%=TabId%>',
					'scriptData': { 'id': <%=ModuleId%>, 'foo': '1' },
					'cancelImg': '<%=ModulePath%>images/cancel.png',
					'multi': true,
					'fileDesc': 'Image Files',
					'fileExt': '*.jpg;*.png;*.gif;*.bmp;*.jpeg',
					'queueSizeLimit': 100,
					'sizeLimit': 400000000,
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
						jQuery.jGrowl('<p></p>' + msg, {
							theme: 'error',
							header: 'ERROR',
							sticky: true
						});
						$("#<%=GalfileInput.ClientID%>" + queueID).fadeOut(250, function () { <%=jQueryPrefix%>("#<%=GalfileInput.ClientID%>" + queueID).remove() });
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

		var hfGalleryID = document.getElementById('<%=hfGalID.ClientID%>');
		var GalleryID = '';
		if(hfGalleryID != null)
		{
			GalleryID= $("#<%=hfGalID.ClientID%>").val();
		}
		<%=jQueryPrefix%>('#<%=fileInput.ClientID%>').uploadify({
			'uploader': '<%=ModulePath%>js/uploadify.swf',
			'script': '<%=ModulePath%>UploadImages.ashx?tabid=<%=TabId%>',
			'scriptData': { 'id': <%=ModuleId%>, 'foo': GalleryID },
			'cancelImg': '<%=ModulePath%>images/cancel.png',
			'multi': true,
			'fileDesc': 'Image Files',
			'fileExt': '*.jpg;*.png;*.gif;*.bmp;*.jpeg',
			'queueSizeLimit': 100,
			'sizeLimit': 400000000,
			'buttonText': 'SELECT IMAGES FOR UPLOAD',

			'onAllComplete': function (event, queueID, fileObj, response, data) {

				document.getElementById('<%=btnArtUploadDoPostback.ClientID%>').click();
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
				$("#<%=fileInput.ClientID%>" + queueID).fadeOut(250, function () { <%=jQueryPrefix%>("#<%=fileInput.ClientID%>" + queueID).remove() });
				return false;
			},
			'onComplete': function (a, b, c, d, e) {

				var size = Math.round(c.size / 1024);

				<%=jQueryPrefix%>.jGrowl('<p></p>' + c.name + ' - ' + size + 'KB', {
					theme: 'success',
					header: '<%=UploadComplete%>',
					life: 3000,
					sticky: false
				});

			}
		});

		jQuery("#<%=ddlCFgroup.ClientID%>").change(function() {
			jQuery.cookie('EDNcfcookie<%=UserId%>', jQuery(this).val());
		});
	});

	function pageLoad(sender, args) {
		if (args.get_isPartialLoad()) {
		<%=jQueryPrefix%>('#<%=tbPublishDate.ClientID%>').datepick({dateFormat:"<%=dateFormat%>"});
		<%=jQueryPrefix%>('#<%=tbExpireDate.ClientID%>').datepick({dateFormat:"<%=dateFormat%>"});
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
				});

				var hfGalleryID = document.getElementById('<%=hfGalID.ClientID%>');
				var GalleryID = '';
				if(hfGalleryID != null)
				{
					GalleryID= $("#<%=hfGalID.ClientID%>").val();
				}
				<%=jQueryPrefix%>(document).ready(function ($) {
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
						'buttonText': 'Select images for upload',

						'onAllComplete': function (event, queueID, fileObj, response, data) {

							document.getElementById('<%=btnArtUploadDoPostback.ClientID%>').click();
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
				});

				<%=jQueryPrefix%>(document).ready(function ($) {
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
							$("#<%=GalfileInput.ClientID%>" + queueID).fadeOut(250, function () { <%=jQueryPrefix%>("#<%=GalfileInput.ClientID%>" + queueID).remove() });
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
<asp:Panel ID="pnlMainWrapper" runat="server">
	<asp:Panel ID="pnlAddArticle" runat="server">
		<div id="EDNadmin">
			<div class="module_action_title_box">
				<asp:PlaceHolder ID="phAdminNavigation" runat="server" />
				<h1>
					<%=AddNewArticleTitle%>
					<asp:Label ID="lblArticleAuthorName" runat="server" /></h1>
			</div>
			<div class="main_content">
				<div class="text_input_set overflow_visible">
					<dnn:Label ID="lblTitle" runat="server" Text="Title" HelpText="Title" ControlName="tbArticleTitle" ResourceKey="lblTitle" HelpKey="lblTitle.HelpText" />
					<asp:RequiredFieldValidator CssClass="input_validation_error" ID="RequiredFieldValidator1" runat="server" ErrorMessage="This field is required." ValidationGroup="vgAddArticle" ControlToValidate="tbArticleTitle" SetFocusOnError="True" Display="Dynamic"
						resourcekey="rfvTitleResource1.ErrorMessage" />
					<asp:RequiredFieldValidator CssClass="input_validation_error" ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbArticleTitle" Display="Dynamic" ErrorMessage="This field is required." SetFocusOnError="True" ValidationGroup="vgCreateGallery"
						resourcekey="rfvTitleResource1.ErrorMessage" />
					<asp:TextBox ID="tbArticleTitle" runat="server" CssClass="text s18" MaxLength="200" />
				</div>
				<div id="pnlSubTitle" runat="server" class="text_input_set overflow_visible">
					<dnn:Label ID="lblSubtitle" runat="server" Text="Subtitle" HelpText="Subtitle:" HelpKey="lblSubtitle.HelpText" ResourceKey="lblSubtitle" />
					<asp:TextBox ID="txtSubtitle" runat="server" CssClass="text" MaxLength="4000" />
				</div>
				<div id="pnlSEO" runat="server" class="collapsible_box">
					<h1 class="collapsible_box_title">
						<%=SEOsettings%></h1>
					<div class="content" id="collapsible_seo_box_content">
						<div class="text_input_set">
							<div>
								<dnn:Label ID="lblArticleTitleURL" runat="server" HelpText="Article URL" Text="Article URL" ControlName="tbArticleURL" HelpKey="lblArticleTitleURL.HelpText" ResourceKey="lblArticleTitleURL" />
							</div>
							<asp:TextBox ID="tbArticleURL" runat="server" CssClass="text narrow left" />
							<a id="EDN_btnReGenerateURL" class="reset_url_btn main_action_button grey" href="#"><span>
								<%=ResetarticleURL%></span></a>
						</div>
						<div class="text_input_set">
							<dnn:Label ID="lblMetaDescription" runat="server" Text="META description" HelpKey="lblMetaDescription.HelpText" HelpText="META description" ResourceKey="lblMetaDescription"></dnn:Label>
							<asp:TextBox ID="tbMetaDescription" runat="server" TextMode="MultiLine"></asp:TextBox>
						</div>
						<div class="text_input_set">
							<dnn:Label ID="lblMetaKeywords" runat="server" Text="META keywords" HelpText="META keywords" HelpKey="lblMetaKeywords.HelpText" ResourceKey="lblMetaKeywords"></dnn:Label>
							<asp:TextBox ID="tbMetaKeywords" runat="server" TextMode="MultiLine"></asp:TextBox>
						</div>
					</div>
				</div>
				<div class="section_box white_border_1 cyan">
					<h1 class="section_box_title">
						<span>
							<%=Categories%></span></h1>
					<div class="content category_selection">
						<asp:Label ID="lblCategorySelectError" runat="server" resourcekey="lblCategorySelectError" ForeColor="Red" Text="Please select a category." Visible="False" EnableViewState="false" />
						<asp:TreeView ID="tvCatAndSubCat" runat="server" ForeColor="Black" NodeWrap="True" ShowCheckBoxes="All" ShowLines="True" CssClass="category_tree_view" NodeStyle-CssClass="category_node" EnableViewState="false" />
					</div>
				</div>
				<div id="pnlSummary" runat="server" class="text_input_set">
					<dnn:Label ID="lblArticleSummary" runat="server" HelpText="Article summary:" Text="Summary:" ControlName="txtSummary" ResourceKey="lblArticleSummary" HelpKey="lblArticleSummary.HelpText" />
					<dnn:TextEditor ID="txtSummary" runat="server" Height="250" Width="720" />
				</div>
				<div id="pnlDetailTypeSelection" runat="server" class="section_box white_border_1 cyan" style="border-bottom: 0;">
					<h1 class="section_box_title">
						<span>
							<%=Articledetailtype%></span></h1>
					<div class="content detail_type_selection">
						<asp:RadioButtonList ID="rblDetailType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblDetailType_SelectedIndexChanged" RepeatDirection="Horizontal">
							<asp:ListItem Value="Text" Selected="True">Text/HTML</asp:ListItem>
							<asp:ListItem Value="Page" ResourceKey="liPage">Page</asp:ListItem>
							<asp:ListItem Value="File" ResourceKey="liFile">File</asp:ListItem>
							<asp:ListItem Value="Link" ResourceKey="liLink">Link</asp:ListItem>
							<asp:ListItem Value="None" ResourceKey="liNone">None</asp:ListItem>
						</asp:RadioButtonList>
					</div>
				</div>
				<div id="pnlDetailTypePanels" runat="server" class="section_box white_border_1 cyan" style="border-top: 0; margin: 0; background: #ebfafe;">
					<asp:Panel ID="pnlDetailTypeText" runat="server" CssClass="text_input_set">
						<dnn:Label ID="lblContent" runat="server" Text="Content:" HelpText="Article content:" ControlName="txtContent" ResourceKey="lblContent.Text" HelpKey="lblContent.HelpText" />
						<dnn:TextEditor ID="txtContent" runat="server" Height="500" Width="700" />
						<p class="article_content_bottom_actions">
							<a href="#" onclick="jQuery(this).parent().siblings('div.avalible_article_tokens').toggle(200); return false;">
								<%=ShowHidetokenlist%></a>
						</p>
						<div class="avalible_article_tokens">
							<asp:TextBox ID="tbTokenList" runat="server" ReadOnly="True" TextMode="MultiLine" Height="93px" Width="670px" />
						</div>
					</asp:Panel>
					<asp:Panel ID="pnlDetailTypePage" runat="server" Style="width: 500px; margin: 15px auto 0;" Visible="False">
						<Portal:URL ID="ctlURL" runat="server" Width="250" ShowNewWindow="False" ShowUsers="False" ShowFiles="False" ShowLog="False" ShowSecure="False" ShowTabs="False" ShowTrack="False" ShowUpLoad="False" ShowUrls="False" ShowDatabase="False" UrlType="U" />
						<asp:Label ID="lblSelectDetailTarget" runat="server" ResourceKey="lblSelectDetailTarget" Text="Select target:" AssociatedControlID="ddlDetailTarget"></asp:Label>
						<asp:DropDownList ID="ddlDetailTarget" runat="server">
							<asp:ListItem>_self</asp:ListItem>
							<asp:ListItem>_blank</asp:ListItem>
							<asp:ListItem>_parent</asp:ListItem>
							<asp:ListItem>_top</asp:ListItem>
						</asp:DropDownList>
					</asp:Panel>
				</div>
				<asp:UpdatePanel ID="upArticleTags" runat="server" UpdateMode="Conditional">
					<ContentTemplate>
						<div class="text_input_set">
							<dnn:Label ID="lblArticleTags" runat="server" HelpText="Article tags separated by comma ( , ):" Text="Article tags:" ControlName="tbTags" ResourceKey="lblArticleTags" HelpKey="lblArticleTags.HelpText" />
							<asp:TextBox ID="tbTags" runat="server" CssClass="text" />
						</div>
						<div class="collapsible_box no_margin visible" id="add_existing_tags_box">
							<h1 class="collapsible_box_title close">
								<%=AddExistingTags%></h1>
							<div class="content">
								<div class="tag_collection">
									<ul class="tag_selection_menu">
										<li class="spaced">
											<asp:LinkButton ID="lbAllAddedTags" ResourceKey="lbAllAddedTags.Text" runat="server" OnClick="lbAllAddedTags_Click">ALL TAGS</asp:LinkButton></li>
										<li class="spaced">
											<asp:LinkButton ID="lbMostPopularTags" ResourceKey="lbMostPopularTags.Text" runat="server" OnClick="lbMostPopularTags_Click">MOST POPULAR FIRST</asp:LinkButton></li>
										<li class="spaced">
											<asp:LinkButton ID="lbLastAddedTags" ResourceKey="lbLastAddedTags.Text" runat="server" OnClick="lbLastAddedTags_Click">LAST ADDED FIRST</asp:LinkButton></li>
									</ul>
									<asp:DataList ID="dlListOfExistingTags" runat="server" RepeatColumns="5" OnItemCommand="dlListOfExistingTags_ItemCommand" RepeatDirection="Vertical" CssClass="existing_tag_list">
										<ItemTemplate>
											<asp:LinkButton ID="lbAddTag" runat="server" CommandName="AddTag" CommandArgument='<%#Eval("Name")%>' CssClass="tag_link"><%#Eval("Name")%><span class="addtag"></span></asp:LinkButton>
										</ItemTemplate>
									</asp:DataList>
									<asp:GridView ID="gvTagsPaging" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="0" CssClass="existing_tag_list_pagination article_pager" DataKeyNames="TagID" DataSourceID="odsGetTagsByName" EnableModelValidation="True" GridLines="None"
										OnPageIndexChanged="gvTagsPaging_PageIndexChanged" ShowHeader="False" OnPageIndexChanging="gvTagsPaging_PageIndexChanging1" PageSize="50">
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
				<asp:UpdatePanel ID="upArticleImages" runat="server" RenderMode="Block" UpdateMode="Conditional">
					<ContentTemplate>
						<asp:Panel ID="pnlArticleImage" CssClass="section_box white_border_1 cyan" runat="server" Visible="False">
							<h1 class="section_box_title">
								<span>
									<%=Mainarticleimage%></span></h1>
							<div class="content main_article_image">
								<div class="left_col">
									<asp:Image ID="imgArticleImage" runat="server" AlternateText="" />
								</div>
								<div class="right_col">
									<p>
										<asp:CheckBox ID="cbShowMainArticleImageList" runat="server" Checked="True" Text="Show article image on article list" Width="300px" /></p>
									<p>
										<asp:CheckBox ID="cbShowMainArticleImage" resourcekey="cbShowMainArticleImage" runat="server" Checked="True" Text="Show main article image" />
										<asp:RadioButtonList runat="server" ID="rblSelectMainImageEmbedType" RepeatDirection="Horizontal" Visible="False" Style="margin-left: 15px">
											<asp:ListItem resourcekey="liImage" Value="Image" Selected="True">Image</asp:ListItem>
											<asp:ListItem resourcekey="liVideo" Value="Video">Video</asp:ListItem>
										</asp:RadioButtonList>
									</p>
									<div class="info_box check_sign">
										<asp:LinkButton ID="btnRemoveArticleImage" resourcekey="liImage" runat="server" CssClass="action remove_btn" OnClick="btnRemoveArticleImage_Click" Text="Remove" /><p>
											<%=RemoveArticleImage%>
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
													<p class="gallery_title <%#GetDotClass(Eval("GalleryID"))%>">
														<%#Eval("GalleryName")%>
														<asp:Label ID="lblIntGalCategoryName" runat="server" Text='<%#GetCategoryName(Eval("GalleryID"))%>'></asp:Label></p>
													<p class="gallery_actions">
														<asp:HiddenField ID="hfGalIntID" runat="server" Value='<%#Eval("GalleryID")%>' />
														<asp:LinkButton ID="lbOpenIntegratedGallery" CssClass="gallery_settings" CommandName="OpenIntGallery" CommandArgument='<%#Eval("GalleryID")%>' title="Open this gallery" runat="server" />
														<span class="border"></span><a href="#" class="up_down_arrows" title="Rearange this gallery's position by dragging and droping it"></a><span class="border"></span>
														<asp:LinkButton ID="imbDeleteIntegratedArticle" CssClass="remove" CommandName="DeleteRow" CommandArgument='<%#Container.ItemIndex%>' title="Remove the gallery from this article" runat="server" />
														<input type="hidden" name="EDN_Included_Gals" value="<%#Eval("GalleryID")%>" />
													</p>
												</div>
												<div class="right">
												</div>
											</li>
										</ItemTemplate>
									</asp:Repeater>
								</ul>
								<asp:Panel ID="pnlViewGallerySettings" CssClass="section_actions" runat="server" Visible="False">
									<asp:HyperLink ID="lbGallerySettings" runat="server" CssClass="icon down_arrows" href="#"><%=Viewsettings%></asp:HyperLink>
									<asp:Panel ID="pnlGallerySettings" runat="server" Style="display: none;">
										<table style="width: 600px;" class="settings_table">
											<tr>
												<td>
													<dnn:Label ID="lblGIGalleryType" runat="server" HelpText="Gallery display type:" Text="Gallery display type:" ResourceKey="lblGIGalleryType" HelpKey="lblGIGalleryType.HelpText" />
												</td>
												<td class="text_left">
													<asp:DropDownList ID="ddlGalleryDisplayType" runat="server" OnSelectedIndexChanged="ddlGalleryDisplayType_SelectedIndexChanged" AutoPostBack="true">
														<asp:ListItem resourcekey="liLightbox" Value="lightbox">Lightbox gallery</asp:ListItem>
														<asp:ListItem resourcekey="liAudiogallery" Value="audio">Audio gallery</asp:ListItem>
														<asp:ListItem resourcekey="liVideogallery" Value="video">Video gallery</asp:ListItem>
													</asp:DropDownList>
												</td>
											</tr>
											<tr>
												<td>
													<dnn:Label ID="lblGIGalleryPosition" runat="server" HelpText="Gallery position:" Text="Gallery position:" ResourceKey="lblGIGalleryPositionDown" HelpKey="lblGIGalleryPosition.HelpText" />
												</td>
												<td class="text_left">
													<asp:DropDownList ID="ddlGalleryPosition" runat="server">
														<asp:ListItem resourcekey="liBottom" Selected="True" Value="bottom">Bottom position</asp:ListItem>
														<asp:ListItem resourcekey="liTop" Value="top">Top position</asp:ListItem>
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
													<asp:DropDownList ID="ddlGIPagerStyle" runat="server" Visible="False">
														<asp:ListItem>Numeric</asp:ListItem>
														<asp:ListItem Value="NextPrevious">Arrows (Next, Previous)</asp:ListItem>
														<asp:ListItem Value="NextPreviousFirstLast">Arrows (Next, Previous, First, Last)</asp:ListItem>
													</asp:DropDownList>
												</td>
											</tr>
										</table>
										<asp:Panel ID="pnlChameleonGallery" runat="server" Visible="false">
											<table style="width: 600px;" class="settings_table">
												<tr>
													<td>
														<dnn:Label ID="lblGalleryWidth" runat="server" HelpText="Gallery width." Text="Gallery width:" ResourceKey="lblGalleryWidth" HelpKey="lblGalleryWidth.HelpText" />
													</td>
													<td class="text_left">
														<asp:TextBox ID="tbxGalleryWidth" runat="server" Width="50px">700</asp:TextBox>
														<asp:Label ID="lblChamMainPanelWidthType" runat="server" Text="%" Visible="False"></asp:Label>
														<asp:RequiredFieldValidator ID="rfvRhumbImageWidth0" runat="server" ControlToValidate="tbxGalleryWidth" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgAddArticle" resourcekey="rfvRhumbImageWidth0Resource1"></asp:RequiredFieldValidator>
														<asp:CompareValidator ID="cvLightBoxGalleryNumberOfItems" runat="server" ControlToValidate="tbxGalleryWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAddArticle" resourcekey="cvLightBoxGalleryNumberOfItemsResource1"></asp:CompareValidator>
														<asp:RangeValidator ID="rvChameleonWidthPerct" runat="server" ControlToValidate="tbxGalleryWidth" Display="Dynamic" Enabled="False" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" resourcekey="rvAGVolume0Resource1.ErrorMessage"
															SetFocusOnError="True" Type="Integer" ValidationGroup="vgAddArticle" Visible="False"></asp:RangeValidator>
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGalleryHeight" runat="server" HelpText="Gallery height." Text="Gallery height:" ResourceKey="lblGalleryHeight" HelpKey="lblGalleryHeight.HelpText" Visible="True" />
													</td>
													<td class="text_left">
														<asp:TextBox ID="tbxGalleryHeight" runat="server" Width="50px">600</asp:TextBox>
														<asp:Label ID="lblChamMainPanelHeightType" runat="server" Text="px" Visible="False"></asp:Label>
														<asp:RequiredFieldValidator ID="rfvRhumbImageWidth1" runat="server" ControlToValidate="tbxGalleryHeight" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgAddArticle"></asp:RequiredFieldValidator>
														<asp:CompareValidator ID="cvLightBoxGalleryNumberOfItems0" runat="server" ControlToValidate="tbxGalleryHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAddArticle"></asp:CompareValidator>
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblChameleonLayout" runat="server" HelpText="Gallery layout." Text="Layout:" Visible="True" ResourceKey="lblChameleonLayout" HelpKey="lblChameleonLayout.HelpText" />
													</td>
													<td class="text_left">
														<asp:DropDownList ID="ddlChameleonLayout" runat="server" AutoPostBack="False">
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
										<asp:Panel ID="pnlOldGalleryes" runat="server" Visible="true">
											<table style="width: 600px;" class="settings_table">
												<tr>
													<td>
														<dnn:Label ID="lblGIImagesResize" runat="server" HelpText="Resize and crop images. If un-checked images will be resized proportionaly.:" Text="Resize and crop images:" Visible="False" />
													</td>
													<td class="text_left">
														<asp:CheckBox ID="cbGICropImages" runat="server" Visible="False" />
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGIThumbWidth" runat="server" HelpText="Thumbnail width:" Text="Thumbnail width:" ResourceKey="lblGIThumbWidth" HelpKey="lblGIThumbWidth.HelpText" />
													</td>
													<td class="text_left">
														<asp:TextBox ID="tbGIThumbnailWidth" runat="server" Width="50px">100</asp:TextBox>
														<asp:RequiredFieldValidator ID="rfvGIThumbanilWidth" runat="server" ControlToValidate="tbGIThumbnailWidth" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgAddArticle" />
														<asp:CompareValidator ID="cvGIThumbnailWidth" runat="server" ControlToValidate="tbGIThumbnailWidth" ErrorMessage="Please enter number." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAddArticle"></asp:CompareValidator>
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGIThumbHeight" runat="server" HelpText="Thumbnail height:" Text="Thumbnail height:" ResourceKey="lblGIThumbHeight" HelpKey="lblGIThumbHeight.HelpText" />
													</td>
													<td class="text_left">
														<asp:TextBox ID="tbGIThumbnailHeight" runat="server" Width="50px">100</asp:TextBox>
														<asp:RequiredFieldValidator ID="rfvGIThumbanilHeight" runat="server" ControlToValidate="tbGIThumbnailHeight" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgAddArticle" />
														<asp:CompareValidator ID="cvGIThumbnailHeight" runat="server" ControlToValidate="tbGIThumbnailHeight" ErrorMessage="Please enter number." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAddArticle"></asp:CompareValidator>
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGIItemsPerPage" runat="server" HelpText="Items per page:" Text="Items per page:" ResourceKey="lblGIItemsPerPage" HelpKey="lblGIItemsPerPage.HelpText" />
													</td>
													<td class="text_left">
														<asp:TextBox ID="tbGIItemsPerPage" runat="server" Width="50px">4</asp:TextBox>
														<asp:RequiredFieldValidator ID="rfvGIItemsPerPage" runat="server" ControlToValidate="tbGIItemsPerPage" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgAddArticle" />
														<asp:CompareValidator ID="cvGINumber" runat="server" ControlToValidate="tbGIItemsPerPage" ErrorMessage="Please enter number." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAddArticle"></asp:CompareValidator>
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGINumberOfColumns" runat="server" HelpText="Number of columns:" Text="Number of columns:" ResourceKey="lblGINumberOfColumns" HelpKey="lblGINumberOfColumns.HelpText" />
													</td>
													<td class="text_left">
														<asp:TextBox ID="tbNumberOfColumns" runat="server" Width="50px">4</asp:TextBox>
														<asp:RequiredFieldValidator ID="rfvGIItemsPerPage0" runat="server" ControlToValidate="tbNumberOfColumns" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgAddArticle" />
														<asp:CompareValidator ID="cvGINumber0" runat="server" ControlToValidate="tbNumberOfColumns" ErrorMessage="Please enter number." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAddArticle"></asp:CompareValidator>
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGIDisplayItemTitle" runat="server" HelpText="Display item title:" Text="Display item title:" HelpKey="lblGIDisplayItemTitle.HelpText" ResourceKey="lblGIDisplayItemTitle" />
													</td>
													<td class="text_left">
														<asp:CheckBox ID="cbGIDisplayItemTitle" runat="server" />
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGIDisplayItemDescription" runat="server" HelpText="Display item description:" Text="Display item description:" ResourceKey="lblGIDisplayItemDescription" HelpKey="lblGIDisplayItemDescription.HelpText" />
													</td>
													<td class="text_left">
														<asp:CheckBox ID="cbGIDisplayItemDescription" runat="server" />
													</td>
												</tr>
												<tr id="rowOldGalleryTitleLightbox" runat="server">
													<td>
														<dnn:Label ID="lblGIDisplayItemTitleLightBOx" runat="server" HelpText="Display item title in Lightbox:" Text="Display item title in Lightbox:" ResourceKey="lblGIDisplayItemTitleLightBOx" HelpKey="lblGIDisplayItemTitleLightBOx.HelpText" />
													</td>
													<td class="text_left">
														<asp:CheckBox ID="cbGIDisplayItemTitleLightBox" runat="server" />
													</td>
												</tr>
												<tr id="rowOldGalleryDescriptionLightbox" runat="server">
													<td>
														<dnn:Label ID="lblGIDisplayItemDescriptionLightBox" runat="server" HelpText="Display item description in Lightbox:" Text="Display item description in Lightbox:" ResourceKey="lblGIDisplayItemDescriptionLightBox" HelpKey="lblGIDisplayItemDescriptionLightBox.HelpText" />
													</td>
													<td class="text_left">
														<asp:CheckBox ID="cbGIDisplayItemDescriptionLightBox" runat="server" />
													</td>
												</tr>
												<tr>
													<td>
														<dnn:Label ID="lblGIGalleryTheme" runat="server" HelpText="Gallery theme:" Text="Gallery theme:" ResourceKey="lblGIGalleryTheme" HelpKey="lblGIGalleryTheme.HelpText" />
													</td>
													<td class="text_left">
														<asp:DropDownList ID="ddlGalleryTheme" runat="server">
														</asp:DropDownList>
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
									<asp:LinkButton ID="lbArticleGalleryImages" ResourceKey="lbArticleGalleryImages" runat="server" CssClass="active" OnClick="lbArticleGallery_Click">ARTICLE<span class="blue dot"></span></asp:LinkButton></li>
								<li>
									<asp:LinkButton ID="lbSharedArticleGalleryImages" ResourceKey="lbSharedArticleGalleryImages" runat="server" OnClick="lbSharedArticleGallery_Click">SHARED</asp:LinkButton></li>
								<li>
									<asp:LinkButton ID="lbCustomGallery" runat="server" ResourceKey="lbCustomGallery" OnClick="lbCustomGallery_Click">CUSTOM<span class="yellow dot"></span></asp:LinkButton></li>
							</ul>
							<div class="content tabbed dark_blue">
								<asp:Panel ID="pnlCustomIntegrationAndUpload" runat="server" Visible="False">
									<div class="edg_gallery_selection_container">
										<div class="category_and_gallery_selection">
											<div class="category selection">
												<asp:Label ID="lblCategorySelect" ResourceKey="lblCategorySelect" runat="server" Text="Select category:" />
												<asp:DropDownList ID="ddlCategories" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataTextField="CategoryName" DataValueField="CategoryID" OnDataBound="ddlCategories_DataBound" OnSelectedIndexChanged="ddlCategories_SelectedIndexChanged">
													<asp:ListItem ResourceKey="liSelectCategory" Value="0">Select category</asp:ListItem>
												</asp:DropDownList>
											</div>
											<div class="gallery selection">
												<asp:Label ID="lblGallerySelect" ResourceKey="lblGallerySelect" runat="server" Text="Select gallery: " />
												<asp:DropDownList ID="ddlGaleries" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataTextField="GalleryName" DataValueField="GalleryID" OnDataBound="ddlGaleries_DataBound" OnSelectedIndexChanged="ddlGaleries_SelectedIndexChanged">
													<asp:ListItem ResourceKey="liSelectGallery" Value="-2">Select gallery</asp:ListItem>
												</asp:DropDownList>
											</div>
											<asp:LinkButton ID="btnRefrehsData" runat="server" CssClass="refresh" OnClick="btnRefrehsData_Click" />
										</div>
										<div class="actions">
											<asp:LinkButton ID="btnIntegGallery" ResourceKey="btnIntegGallery" runat="server" CssClass="add_gallery_to_article" OnClick="btnIntegGallery_Click" Text="Add gallery to article" />
										</div>
									</div>
									<asp:Button ID="btnOpenEasyDnnGallery" ResourceKey="btnOpenEasyDnnGallery" runat="server" OnClick="btnOpenEasyDnnGallery_Click" OnClientClick="SetTarget();" Text="Open gallery" Visible="False" />
									<asp:DropDownList ID="ddlEasyDNNGalleryList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlEasyDNNGalleryList_SelectedIndexChanged" Visible="False">
									</asp:DropDownList>
									<asp:Panel ID="pnlGalleryMediaUpload" CssClass="uploadify_container" runat="server" Visible="False">
										<div style="display: block; float: left; margin-left: 30px;">
											<asp:FileUpload ID="GalfileInput" runat="server" />
										</div>
										<div style="display: block; float: left; margin-left: 15px;">
											<a class="start_upload" href="javascript:<%=jQueryPrefix%>('#<%=GalfileInput.ClientID%>').uploadifySettings('scriptData', { 'foo': '<%=ddlGaleries.SelectedValue%>','resize':document.getElementById('<%=hfResize.ClientID%>').value, 'width': document.getElementById('<%=hfResizeWidth.ClientID%>').value,'height':document.getElementById('<%=hfResizeHeight.ClientID%>').value});<%=jQueryPrefix%>('#<%=GalfileInput.ClientID%>').uploadifyUpload();">
												<%=StartUpload%></a>
										</div>
										<asp:Button ID="Button3" runat="server" OnClick="Button2_Click" Text="Button" Style="display: none;" />
										<div class="add_video_by_url">
											<p>
												<asp:Label runat="server" ResourceKey="lblCustomAddEmbedToGallery" Text="Add video from YouTube or Vimeo:" ID="lblCustomAddEmbedToGallery"></asp:Label>
												<asp:TextBox runat="server" ID="tbCustomEmbedVideoURL" ValidationGroup="vgCustomAddEmbedVideo" onblur="if(this.value=='') {this.value=this.defaultValue;}" onfocus="if(this.defaultValue==this.value) {this.value = '';}" value="Enter video URL..."></asp:TextBox>
												<asp:LinkButton runat="server" ResourceKey="lbCustomAddEmedVideoToGallery" ID="lbCustomAddEmedVideoToGallery" class="add_video" ValidationGroup="vgCustomAddEmbedVideo" OnClick="lbCustomAddEmedVideoToGallery_Click">Add video</asp:LinkButton>
											</p>
											<p class="validators">
												<asp:CustomValidator ID="cvCustomAddEmbedVideo" runat="server" ClientValidationFunction="ClientValidateEmbedURL" Display="Dynamic" ErrorMessage="Invalid URL." ValidationGroup="vgCustomAddEmbedVideo" ControlToValidate="tbCustomEmbedVideoURL" SetFocusOnError="True"></asp:CustomValidator>
												<asp:RequiredFieldValidator ID="rfvCustomAddEmbedVideoURL" runat="server" ControlToValidate="tbCustomEmbedVideoURL" Display="Dynamic" ErrorMessage="Please enter valid URL." SetFocusOnError="True" ValidationGroup="vgCustomAddEmbedVideo"></asp:RequiredFieldValidator>
											</p>
										</div>
									</asp:Panel>
								</asp:Panel>
								<asp:Panel ID="pnlArticleGalleryUpload" runat="server">
									<asp:Panel ID="pnlEmptyGallery" runat="server" CssClass="info_box attention add_gallery">
										<asp:LinkButton ID="ibAddImages" ResourceKey="ibAddImages" runat="server" OnClick="ibAddImages_Click" CssClass="action add_gallery" ValidationGroup="vgCreateGallery">Add gallery</asp:LinkButton>
										<p>
											<%=Thegalleryisempty%></p>
									</asp:Panel>
									<asp:Panel ID="pnlArticleImageUpload" runat="server" Visible="False">
										<asp:Panel ID="pnlDisplayArticleGallery" runat="server" class="info_box warning add_gallery" Visible="False">
											<asp:LinkButton ID="lbDisplayArticleGallery" ResourceKey="lbDisplayArticleGallery" runat="server" OnClick="lbDisplayArticleGallery_Click" CssClass="action add_gallery">Add gallery</asp:LinkButton>
											<p>
												<%=NotWithArticle %></p>
										</asp:Panel>
										<asp:Panel ID="pnlRemoveArticleGallery" runat="server" class="info_box attention add_gallery" Visible="False">
											<asp:LinkButton ID="lbRemoveDisplayArticleGallery" ResourceKey="lbRemoveDisplayArticleGallery" runat="server" CssClass="action remove_btn" OnClick="lbRemoveDisplayArticleGallery_Click">Do not display gallery</asp:LinkButton>
											<p>
												<%=GalleryWithArticle%></p>
										</asp:Panel>
										<div class="uploadify_container">
											<div style="display: block; float: left; margin-left: 30px;">
												<asp:FileUpload ID="fileInput" runat="server" />
											</div>
											<div style="display: block; float: left; margin-left: 15px;">
												<a class="start_upload" href="javascript:<%=jQueryPrefix%>('#<%=fileInput.ClientID%>').uploadifySettings('scriptData', {'foo': document.getElementById('<%=hfGalID.ClientID%>').value, 'resize':document.getElementById('<%=hfResize.ClientID%>').value, 'width': document.getElementById('<%=hfResizeWidth.ClientID%>').value,'height':document.getElementById('<%=hfResizeHeight.ClientID%>').value});<%=jQueryPrefix%>('#<%=fileInput.ClientID%>').uploadifyUpload();">
													<%=StartUpload%></a>
											</div>
										</div>
										<div class="add_video_by_url">
											<p>
												<asp:Label runat="server" ResourceKey="lblCustomAddEmbedToGallery" Text="Add video from YouTube or Vimeo:" ID="lblAddEmbedToGallery"></asp:Label>
												<asp:TextBox runat="server" ID="tbEmbedVideoURL" ValidationGroup="vgAddEmbedVideo" onblur="if(this.value=='') {this.value=this.defaultValue;}" onfocus="if(this.defaultValue==this.value) {this.value = '';}"></asp:TextBox>
												<asp:LinkButton runat="server" ResourceKey="lbCustomAddEmedVideoToGallery" ID="lbAddEmedVideoToGallery" ValidationGroup="vgAddEmbedVideo" OnClick="lbAddEmedVideoToGallery_Click" class="add_video">Add video</asp:LinkButton>
											</p>
											<p class="validators">
												<asp:CustomValidator ID="cvAddEmbedVideo" runat="server" ClientValidationFunction="ClientValidateEmbedURL" Display="Dynamic" ErrorMessage="Invalid URL." ValidationGroup="vgAddEmbedVideo" ControlToValidate="tbEmbedVideoURL" SetFocusOnError="True"></asp:CustomValidator>
												<asp:RequiredFieldValidator ID="rfvAddEmbedVideoURL" runat="server" ControlToValidate="tbEmbedVideoURL" Display="Dynamic" ErrorMessage="Please enter valid URL." SetFocusOnError="True" ValidationGroup="vgAddEmbedVideo"></asp:RequiredFieldValidator>
											</p>
										</div>
										<asp:Button ID="btnArtUploadDoPostback" runat="server" OnClick="Button2_Click" Text="Button" Style="display: none;" />
									</asp:Panel>
								</asp:Panel>
								<asp:Panel ID="pnlSharedGalleryUpload" runat="server" Visible="False">
									<div class="uploadify_container">
										<div style="display: block; float: left; margin-left: 30px;">
											<asp:FileUpload ID="SharedfileInput" runat="server" />
										</div>
										<div style="display: block; float: left; margin-left: 15px;">
											<a class="start_upload" href="javascript:<%=jQueryPrefix%>('#<%=SharedfileInput.ClientID%>').uploadifySettings('scriptData', {'resize':document.getElementById('<%=hfResize.ClientID%>').value, 'width': document.getElementById('<%=hfResizeWidth.ClientID%>').value,'height':document.getElementById('<%=hfResizeHeight.ClientID%>').value});<%=jQueryPrefix%>('#<%=SharedfileInput.ClientID%>').uploadifyUpload();">
												<%=StartUpload%></a> <a style="position: relative; top: 18px; left: 10px;" href="javascript:<%=jQueryPrefix%>('#<%=SharedfileInput.ClientID%>').uploadifyClearQueue();">Clear Queue</a>
										</div>
										<asp:Button ID="ButtonShared" runat="server" OnClick="Button2_Click" Text="Button" Style="display: none;" />
									</div>
									<div class="add_video_by_url">
										<p>
											<asp:Label runat="server" ResourceKey="lblCustomAddEmbedToGallery" Text="Add video from YouTube or Vimeo:" ID="lblSharedAddEmbedToGallery"></asp:Label>
											<asp:TextBox runat="server" ID="tbSharedEmbedVideoURL" ValidationGroup="vgSharedAddEmbedVideo" onblur="if(this.value=='') {this.value=this.defaultValue;}" onfocus="if(this.defaultValue==this.value) {this.value = '';}" value="Enter video URL..."></asp:TextBox>
											<asp:LinkButton runat="server" ResourceKey="lbCustomAddEmedVideoToGallery" ID="lbSharedAddEmedVideoToGallery" ValidationGroup="vgSharedAddEmbedVideo" OnClick="lbSharedAddEmedVideoToGallery_Click" class="add_video">Add video</asp:LinkButton>
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
										<Columns>
											<asp:TemplateField HeaderText="Media list" SortExpression="Position">
												<EditItemTemplate>
													<table width="100%" cellpadding="0" cellspacing="0">
														<tr>
															<td class="action">
																<asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="True" CommandName="Update" Text="" CssClass="action_btn update" />
																<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="Cancel" Text="" CssClass="action_btn cancel" />
															</td>
															<td class="edit_fields">
																<asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Title") %>' />
															</td>
															<td class="edit_fields">
																<asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine" />
															</td>
														</tr>
													</table>
												</EditItemTemplate>
												<HeaderTemplate>
													<table cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td class="header_field action">
																<%=ActionText %>
															</td>
															<td class="header_field image">
															</td>
															<td class="header_field title">
																<%=Title%>
															</td>
															<td class="header_field description">
																<%=Description%>
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
																<asp:LinkButton ID="lbSetArticleImageArtGallery" ResourceKey="lbSetArticleImageArtGallery" runat="server" CommandArgument='<%# Eval("PictureID") %>' CommandName="SetArticleImage" CssClass="action_btn article_img">Set as article image</asp:LinkButton>
																<asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Edit" CssClass="action_btn edit" Text="" />
																<asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Delete" CssClass="action_btn delete" Text="" />
															</td>
															<td class="image">
																<div class="wrapper">
																	<a href='<%#Eval("MediaType").ToString()=="Image"?Eval("FileName").ToString():"#"%>' target="_blank">
																		<asp:Image ID="Image1" runat="server" ImageUrl='<%#FixImageUrl(Eval("ThumbUrl").ToString())%>' />
																	</a>
																</div>
															</td>
															<td class="title">
																<asp:Label ID="Label4" runat="server" Text='<%# Bind("Title") %>' />
															</td>
															<td class="description">
																<asp:Label ID="Label6" runat="server" Text='<%# Bind("Description") %>' />
															</td>
															<td class="position_show_type">
																<div class="action_box">
																	<div class="action_wrapper">
																		<asp:ImageButton ID="imbMediaUp" runat="server" CausesValidation="False" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="Up" ImageUrl="~/images/action_up.gif" CssClass="position_btn up" />
																		<asp:ImageButton ID="imbMediaDown" runat="server" CausesValidation="False" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="Down" ImageUrl="~/images/action_down.gif" CssClass="position_btn down" />
																	</div>
																	<span class="text">
																		<%=Position%></span>
																</div>
																</div>
																<div class="action_box">
																	<div class="action_wrapper">
																		<asp:LinkButton ID="lbArticleGalleryItemState" runat="server" CssClass='<%#GetShowMediaClass(Eval("ShowMedia"))%>' Text="" CommandArgument='<%#Eval("PictureID") %>' CommandName="ChangeShow" />
																	</div>
																	<span class="text">
																		<%=Show%></span>
																</div>
																<div class="action_box">
																	<div class="action_wrapper">
																		<asp:Label ID="imgMediaType" CssClass='<%#GetMediaTypeClass(Eval("MediaType"))%>' runat="server" />
																	</div>
																	<span class="text">
																		<%=Media%></span>
																</div>
															</td>
														</tr>
														<tr>
															<td colspan="5" class="token_wrapper">
																<asp:TextBox ID="lblGalleryInsertArtGallery" runat="server" CssClass="token_box" ReadOnly="True" Text='<%#GenerateTokens(Eval("PictureID"))%>' />
																<span class="start_token_generator">
																	<%=Customtoken%></span>
															</td>
														</tr>
													</table>
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
										<HeaderStyle CssClass="main_table_header" />
										<PagerStyle CssClass="pagination" HorizontalAlign="Center" />
										<RowStyle CssClass="main_row" />
										<AlternatingRowStyle CssClass="main_row second" />
										<SelectedRowStyle CssClass="categorygridselected" />
									</asp:GridView>
								</div>
								<div id="mediaPageManagment" runat="server" class="padded" visible="false">
									<asp:Label ID="lblGalSetThenumberOfItems" ResourceKey="lblGalSetThenumberOfItems0" runat="server" Text="Set the number of items per page:"></asp:Label>
									&nbsp;<asp:DropDownList ID="ddlArticleViewNumberOfItems" runat="server" AutoPostBack="True" CssClass="ddlpageitems" OnSelectedIndexChanged="ddlArticleViewNumberOfItems_SelectedIndexChanged">
										<asp:ListItem>10</asp:ListItem>
										<asp:ListItem>20</asp:ListItem>
										<asp:ListItem>30</asp:ListItem>
										<asp:ListItem>50</asp:ListItem>
										<asp:ListItem>100</asp:ListItem>
									</asp:DropDownList>
								</div>
								<asp:HiddenField ID="hfResizeHeight" runat="server" />
								<asp:HiddenField ID="hfResizeWidth" runat="server" />
								<asp:HiddenField ID="hfResize" runat="server" />
								<asp:HiddenField ID="hfGalID" runat="server" />
								<asp:HiddenField ID="hfCatID" runat="server" />
								<asp:HiddenField ID="hfSharedGalID" runat="server" />
								<asp:HiddenField ID="hfArtImageSet" runat="server" />
								<asp:HiddenField ID="hfSelectedMediaID" runat="server" Value="0" />
							</div>
						</div>
						<asp:Panel runat="server" ID="pnlCustomGalleryManager" CssClass="section_box no_top_margin" Visible="False">
							<div class="content dark_blue">
								<div class="section_actions">
									<asp:HyperLink ID="hlOpenGallery" ResourceKey="hlOpenGallery" runat="server" CssClass="icon laptop" Target="_blank">Open Media manager</asp:HyperLink>
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
								<asp:Label ID="lblDocUploadTitle" ResourceKey="lblDocUploadTitle" AssociatedControlID="tbDocUploadTitle" runat="server" Text="Document title:" />
								<asp:TextBox ID="tbDocUploadTitle" runat="server" CssClass="text" />
								<asp:RequiredFieldValidator ID="rfvDocumentTitle" runat="server" ControlToValidate="tbDocUploadTitle" ErrorMessage="This field is required." ValidationGroup="vgArticleDocs" />
							</div>
							<div class="input_box">
								<asp:Label ID="lblDocUploadDescription" ResourceKey="lblDocUploadDescription" AssociatedControlID="tbDocUploadDescription" runat="server" Text="Document description:" />
								<asp:TextBox ID="tbDocUploadDescription" CssClass="text" runat="server" />
							</div>
							<div class="input_box file">
								<asp:Label ID="lblDocUploadSelectFile" ResourceKey="lblDocUploadSelectFile" AssociatedControlID="fuDocFileUpload" runat="server" Text="Select a document:" />
								<asp:FileUpload ID="fuDocFileUpload" CssClass="file" runat="server" />
							</div>
							<div class="input_box upload_btn">
								<asp:LinkButton ID="btnDocUpload" ResourceKey="btnDocUpload" runat="server" OnClick="btnDocUpload_Click" ValidationGroup="vgArticleDocs"><span>UPLOAD</span></asp:LinkButton>
							</div>
						</div>
						<asp:GridView ID="gvArticleDocuments" runat="server" AutoGenerateColumns="False" CellPadding="0" CssClass="grid_view_table" DataKeyNames="DocEntryID" EnableModelValidation="True" GridLines="None" OnRowCancelingEdit="gvArticleDocuments_RowCancelingEdit"
							OnRowCommand="gvArticleDocuments_RowCommand" OnRowEditing="gvArticleDocuments_RowEditing" OnRowUpdating="gvArticleDocuments_RowUpdating" OnRowUpdated="gvArticleDocuments_RowUpdated" OnRowDeleting="gvArticleDocuments_RowDeleting">
							<Columns>
								<asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="actions" ItemStyle-CssClass="actions">
									<EditItemTemplate>
										<asp:LinkButton ID="lbDocUpdate" CssClass="action_btn save" runat="server" CausesValidation="True" CommandName="Update" ToolTip="Save changes" />
										<asp:LinkButton ID="LinkButton2" CssClass="action_btn cancel" runat="server" CausesValidation="False" CommandName="Cancel" ToolTip="Discard changes" CommandArgument='<%#Eval("DocEntryID")%>' />
									</EditItemTemplate>
									<ItemTemplate>
										<asp:LinkButton ID="LinkButton1" CssClass="action_btn edit" runat="server" CausesValidation="False" CommandName="Edit" ToolTip="Edit this document" />
										<asp:LinkButton ID="lbDeleteDoc" CssClass="action_btn red_x" runat="server" CausesValidation="False" CommandName="DeleteDoc" ToolTip="Delete this document" />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Title" HeaderStyle-CssClass="title" ItemStyle-CssClass="title" SortExpression="Title">
									<EditItemTemplate>
										<asp:TextBox ID="tbDocTitle" runat="server" Text='<%# Bind("Title") %>' />
									</EditItemTemplate>
									<ItemTemplate>
										<asp:Label ID="lblDocUploadTitle" runat="server" Text='<%# Bind("Title") %>' />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Description" HeaderStyle-CssClass="description" ItemStyle-CssClass="description" SortExpression="Description">
									<EditItemTemplate>
										<asp:TextBox ID="tbDocDescription" runat="server" Text='<%# Bind("Description") %>' />
									</EditItemTemplate>
									<ItemTemplate>
										<asp:Label ID="lblDocUploadDesc" runat="server" Text='<%# Bind("Description") %>' />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Filename" HeaderStyle-CssClass="filename" ItemStyle-CssClass="filename" SortExpression="Filename">
									<EditItemTemplate>
										<asp:Label ID="lbFilenameEdit" runat="server" Text='<%#Eval("Filename")%>' />
									</EditItemTemplate>
									<ItemTemplate>
										<asp:HyperLink ID="lbFilename" NavigateUrl='<%#Eval("Filename")%>' runat="server"><%#GetDocumentFilename(Eval("Filename")) %></asp:HyperLink>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:BoundField DataField="DateUploaded" HeaderStyle-CssClass="date" ItemStyle-CssClass="date" HeaderText="Date" ReadOnly="True" />
								<asp:TemplateField HeaderText="Author" HeaderStyle-CssClass="author" ItemStyle-CssClass="author" SortExpression="Author">
									<ItemTemplate>
										<asp:Label ID="lblDocUploadAuthor" runat="server" Text='<%#UserInfo.DisplayName %>' />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField ShowHeader="false" HeaderStyle-CssClass="arrows" ItemStyle-CssClass="arrows">
									<ItemTemplate>
										<asp:HiddenField ID="hfPosition" Value='<%#Eval("Position")%>' runat="server" />
										<asp:LinkButton ID="lbDocMoveDown" CommandName="Down" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' CssClass="arrow down" runat="server" />
										<asp:LinkButton ID="lbDocMoveUp" CssClass="arrow up" CommandName="Up" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' runat="server" />
									</ItemTemplate>
								</asp:TemplateField>
							</Columns>
							<AlternatingRowStyle CssClass="second" />
							<EditRowStyle />
							<HeaderStyle CssClass="header_row" />
							<PagerStyle />
							<RowStyle />
						</asp:GridView>
					</div>
				</asp:Panel>
				<asp:Panel ID="google_maps_main" CssClass="section_box white_border_1 light_green green_globe google_maps_main" runat="server">
					<h1 class="section_box_title">
						<span>
							<%=Mainarticlemap%></span></h1>
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
								<%=Remove%></a> <a href="#" class="action edit open_map_editor <%=hasGapiKey%>">
									<%=Editmap%></a>
							<p>
								<%=Mainarticlemapisset%></p>
						</div>
						<div class="section_actions">
							<a class="icon green_globe open_map_editor <%=hasGapiKey%>" href="#">
								<%=Mapeditor%></a>
						</div>
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlBottom" class="settings_bottom" runat="server">
					<div id="divAdvancedSettings" runat="server" class="collapsible_box">
						<h1 class="collapsible_box_title">
							<%=AdvancedSettings%></h1>
						<div class="content">
							<asp:UpdatePanel ID="upAdvancedSettings" runat="server">
								<ContentTemplate>
									<asp:Panel ID="pnlChangeOwner" runat="server" Visible="False">
										<table class="settings_table w700">
											<tr>
												<td class="left">
													<asp:Label ID="lblowner" ResourceKey="lblowner" runat="server" Text="Article Owner:" />
												</td>
												<td class="right">
													<asp:Label ID="tbArticleAuthorName" runat="server" />
												</td>
											</tr>
											<tr id="trEnableAuthorProfile" runat="server" visible="false">
												<td class="left">
													<dnn:Label ID="lblAuthorAlias" ResourceKey="lblAuthorAlias" runat="server" HelpText="Author alias:" Text="Author alias:" HelpKey="lblAuthorAlias.HelpText" />
												</td>
												<td class="right">
													<asp:TextBox ID="tbAuthorAliasName" runat="server" MaxLength="100" Width="200px"></asp:TextBox>
												</td>
											</tr>
											<tr>
												<td class="left">
													<asp:Label ID="lblChOwner" ResourceKey="lblChOwner" runat="server" Text="Change Owner:" />
												</td>
												<td class="right">
													<asp:DropDownList ID="ddlRoles" runat="server" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlRoles_SelectedIndexChanged" Visible="False" CssClass="ddlgeneral">
														<asp:ListItem ResourceKey="liSelectRole" Value="-1">Select role</asp:ListItem>
													</asp:DropDownList>
													<asp:DropDownList ID="ddlAuthors" runat="server" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlAuthors_SelectedIndexChanged" Visible="False" CssClass="ddlgeneral">
														<asp:ListItem ResourceKey="liSelectAuthor" Value="-1">Select author</asp:ListItem>
													</asp:DropDownList>
												</td>
											</tr>
										</table>
									</asp:Panel>
									<div id="divDefaultTemplate" runat="server">
										<table class="settings_table w700">
											<tr>
												<td class="left">
													<dnn:Label ID="lblUseDefaultTemplate" runat="server" ControlName="cbUseDefaultTemplate" HelpText="Use default template:" Text="Use default template:" HelpKey="lblUseDefaultTemplate.HelpText" ResourceKey="lblUseDefaultTemplate" />
												</td>
												<td class="right">
													<asp:CheckBox ID="cbUseDefaultTemplate" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbUseDefaultTemplate_CheckedChanged" />
												</td>
											</tr>
										</table>
										<asp:Panel ID="pnlSelectThemes" runat="server" Visible="False">
											<table class="settings_table w700">
												<tr>
													<td class="left">
														<dnn:Label ID="lblArticleDetailsTheme" runat="server" ControlName="ddlArticleDetailsTheme" HelpText="Article details theme:" Text="Article details theme:" HelpKey="lblArticleDetailsTheme.HelpText" ResourceKey="lblArticleDetailsTheme" />
													</td>
													<td class="right">
														<asp:DropDownList ID="ddlArticleDetailsTheme" runat="server" AutoPostBack="True" CausesValidation="True" CssClass="ddlgeneral" OnSelectedIndexChanged="ddlArticleDetailsFolder_SelectedIndexChanged" />
													</td>
												</tr>
												<tr>
													<td class="left">
														<dnn:Label ID="lblArticleDetailsTemplate" runat="server" ControlName="ddlArticleDetailsTemplate" HelpText="Article details template:" Text="Article details template:" HelpKey="lblArticleDetailsTemplate.HelpText" ResourceKey="lblArticleDetailsTemplate" />
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
														<dnn:Label ID="lblArticleCSSStyle" runat="server" ControlName="ddlDisplayStyle" HelpText="Display style:" Text="Display style:" HelpKey="lblArticleCSSStyle.HelpText" ResourceKey="lblArticleCSSStyle" />
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
											<asp:Label ID="lblIsArticleEvent" resourcekey="lblIsArticleEvent" runat="server" Text="Add as event:" Style="font-weight: bold;" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbIsArticleEvent" runat="server" AutoPostBack="True" OnCheckedChanged="cbIsArticleEvent_CheckedChanged" />
										</td>
									</tr>
								</table>
								<asp:Panel ID="pnlEventsData" runat="server" Visible="False">
									<table class="settings_table w700 no_margin">
										<tr>
											<td colspan="3" style="text-align: center;">
												<asp:Label ID="lblEventDateError" resourcekey="lblEventDateError" runat="server" ForeColor="Red" Text="End date is smaller than start date." Visible="False" />
											</td>
										</tr>
										<tr>
											<td class="left" style="vertical-align: top; padding-top: 2px;">
												<dnn:Label ID="lblEventStartDateTime" runat="server" HelpText="Start date:" Text="Start date:" ResourceKey="lblEventStartDateTime" HelpKey="lblEventStartDateTime.HelpText" />
											</td>
											<td class="right" style="width: 215px;">
												<asp:TextBox ID="tbEventStartDate" runat="server" CssClass="text_generic center" ValidationGroup="vgAddArticle" Width="90px" />
												<img src="<%=ModulePath%>images/icons/calendar.png" alt="" style="position: relative; top: 2px" />
												<asp:RequiredFieldValidator ID="rfvEventStartDate" runat="server" ControlToValidate="tbEventStartDate" CssClass="NormalRed" Display="Dynamic" Enabled="False" ErrorMessage="Date required." ValidationGroup="vgAddArticle" />
												<asp:Label ID="lblEvStartDateError" runat="server" ForeColor="Red" resourcekey="lblPubDateErrorResource1" Text="Invalid date." Visible="False" />
												<asp:TextBox ID="tbEventStartTime" runat="server" CssClass="text_generic center" ValidationGroup="vgAddArticle" Width="65px" />
												<img id="tbEventStartTimeIcon" runat="server" alt="" style="position: relative; top: 1px" />
												<asp:RegularExpressionValidator ID="revEventStartTime" runat="server" ControlToValidate="tbEventStartTime" EnableClientScript="true" Enabled="False" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgEditArticle"
													Display="Dynamic" />
												<asp:RequiredFieldValidator ID="rfvEventStartTime" runat="server" ControlToValidate="tbEventStartTime" CssClass="NormalRed" Display="Dynamic" Enabled="False" ErrorMessage="Time required." ValidationGroup="vgAddArticle" />
											</td>
											<td rowspan="2">
												<p style="position: relative; top: -1px">
													<asp:CheckBox ID="cbAllDayEvent" resourcekey="cbAllDayEventResource1" runat="server" AutoPostBack="True" OnCheckedChanged="cbAllDayEvent_CheckedChanged" Text="All day event" /></p>
												<p style="position: relative; top: -1px">
													<asp:CheckBox ID="cbShowEndDate" resourcekey="cbShowEndDate" runat="server" Checked="True" Text="Show end date" /></p>
											</td>
										</tr>
										<tr>
											<td class="left" style="vertical-align: top; padding-top: 2px;">
												<dnn:Label ID="lblEventEndDateTime" runat="server" HelpText="End date:" Text="End date:" HelpKey="lblEventEndDateTime.HelpText" ResourceKey="lblEventEndDateTime" />
											</td>
											<td class="right">
												<asp:TextBox ID="tbEventEndDate" runat="server" CssClass="text_generic center" ValidationGroup="vgAddArticle" Width="90px" />
												<img src="<%=ModulePath%>images/icons/calendar.png" alt="" style="position: relative; top: 2px" />
												<asp:RequiredFieldValidator ID="rfvEventEndDate" runat="server" ControlToValidate="tbEventStartDate" CssClass="NormalRed" Display="Dynamic" Enabled="False" ErrorMessage="Date required." ValidationGroup="vgAddArticle" />
												<asp:Label ID="lblEvEndDateError" runat="server" ForeColor="Red" resourcekey="lblExpireDateErrorResource1" Text="Invalid date." Visible="False" />
												<asp:TextBox ID="tbEventEndTime" runat="server" CssClass="text_generic center" ValidationGroup="vgAddArticle" Width="65px" />
												<img id="tbEventEndTimeIcon" runat="server" alt="" style="position: relative; top: 1px" />
												<asp:RegularExpressionValidator ID="revEventEndTIme" runat="server" ControlToValidate="tbEventEndTime" EnableClientScript="true" Enabled="False" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgAddArticle"
													Display="Dynamic" />
												<asp:RequiredFieldValidator ID="rfvEventEnd" runat="server" ControlToValidate="tbEventEndTime" CssClass="NormalRed" Display="Dynamic" Enabled="False" ErrorMessage="Time required." ValidationGroup="vgAddArticle" />
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
								<asp:CheckBox ID="cbFeaturedArticle" runat="server" />
							</td>
						</tr>
						<tr id="rowPublishDate" runat="server">
							<td class="left">
								<dnn:Label ID="lblPublishDate" runat="server" HelpText="Publish date:" Text="Publish date:" HelpKey="lblPublishDate.HelpText" ResourceKey="lblPublishDate" />
							</td>
							<td class="right">
								<asp:TextBox ID="tbPublishDate" runat="server" CssClass="text_generic center" ValidationGroup="vgAddArticle" Width="90px"></asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvArchiveDate" runat="server" ControlToValidate="tbPublishDate" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Date required." ValidationGroup="vgAddArticle"></asp:RequiredFieldValidator>
								<asp:Label ID="lblPubDateError" ResourceKey="lblPubDateError" runat="server" ForeColor="Red" Text="Invalid date." Visible="False" />
								<asp:TextBox ID="tbPublishTime" runat="server" ValidationGroup="vgAddArticle" Width="50px" CssClass="text_generic center" />
								<asp:RegularExpressionValidator ID="revPublishTIme" runat="server" ControlToValidate="tbPublishTime" EnableClientScript="true" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgAddArticle"></asp:RegularExpressionValidator>
							</td>
						</tr>
						<tr id="rowExpireDate" runat="server">
							<td class="left">
								<dnn:Label ID="lblExpireDate" runat="server" HelpText="Expire date. Must be greather than publish date." Text="Expire date:" HelpKey="lblExpireDate.HelpText" ResourceKey="lblExpireDate" />
							</td>
							<td class="right">
								<asp:TextBox ID="tbExpireDate" runat="server" CssClass="text_generic center" ValidationGroup="vgAddArticle" Width="90px"></asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvArchiveDate0" runat="server" ControlToValidate="tbExpireDate" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Date required." ValidationGroup="vgAddArticle"></asp:RequiredFieldValidator>
								<asp:Label ID="lblExpireDateError" resourcekey="lblExpireDateError" runat="server" ForeColor="Red" Text="Invalid date." Visible="False" />
								<asp:TextBox ID="tbExpireTime" runat="server" ValidationGroup="vgAddArticle" Width="50px" CssClass="text_generic center" />
								<asp:RegularExpressionValidator ID="revPublishTIme0" runat="server" ControlToValidate="tbExpireTime" EnableClientScript="true" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgAddArticle"></asp:RegularExpressionValidator>
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
					<asp:Panel ID="pnlCustomFieldsSelect" runat="server">
						<asp:DropDownList ID="ddlCFgroup" runat="server" AutoPostBack="true">
						</asp:DropDownList>
						<%--<asp:Button ID="btnCreateCF" runat="server" Text="Select" />--%>
						<table class="settings_table" cellpadding="0" cellspacing="0">
							<tr style="text-align: center;">
								<td>
									<asp:Label ID="lblAlLTemplates" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
								</td>
							</tr>
						</table>
					</asp:Panel>
					<asp:Panel ID="pnlCustomFields" runat="server">
					</asp:Panel>
					<asp:Panel ID="pnlPerArticlePermissions" runat="server" Visible="false">
						<asp:UpdatePanel ID="upPerArticlePermissions" runat="server" UpdateMode="Conditional">
							<ContentTemplate>
								<p style="margin: 0 0 3px;">
									<img src="<%=ModulePath%>images/icons/lock.png" alt="" style="position: relative; top: 4px; margin: 0 3px 0 0" />
									<asp:Label ID="lblAddPerArticlePermission" resourcekey="lblAddPerArticlePermission" runat="server" Text="Permissions per article:" Style="font-size: 13px; line-height: 16px; font-weight: bold;" />
									<asp:CheckBox ID="cbAddPerArticlePermissions" runat="server" AutoPostBack="true" OnCheckedChanged="cbAddPerArticlePermissions_CheckedChanged" />
								</p>
								<asp:Panel ID="pnlAddPerArticlePermissions" runat="server" Visible="false" CssClass="rounded_box grey per_article_permissions">
									<p class="permission_warning">
										<%=Permissionsperarticleoverride%></p>
									<asp:GridView ID="gvPermissionDefault" runat="server" AutoGenerateColumns="False" CellPadding="0" CellSpacing="0" CssClass="permissions_table" EnableModelValidation="True" GridLines="None">
										<AlternatingRowStyle CssClass="second" />
										<Columns>
											<asp:TemplateField HeaderStyle-CssClass="subject" HeaderText="Roles" ItemStyle-CssClass="subject">
												<ItemTemplate>
													<asp:Label ID="lblRoleName" runat="server" Text='<%#Eval("Name")%>' />:
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="View article">
												<ItemTemplate>
													<asp:HiddenField ID="hfRoleID" runat="server" Value='<%#Eval("RoleID")%>' />
													<asp:CheckBox ID="cbShowArticle" runat="server" Checked='<%#Eval("Show")%>' Enabled="false" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Edit article">
												<ItemTemplate>
													<asp:CheckBox ID="cbEditArticle" runat="server" Checked='<%#Eval("Edit")%>' Enabled="false" />
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
									</asp:GridView>
									<asp:GridView ID="gvRolePremissions" runat="server" AutoGenerateColumns="False" CellPadding="0" CellSpacing="0" CssClass="permissions_table" EnableModelValidation="True" GridLines="None">
										<AlternatingRowStyle CssClass="second" />
										<Columns>
											<asp:TemplateField HeaderStyle-CssClass="subject" ItemStyle-CssClass="subject">
												<ItemTemplate>
													<asp:Label ID="lblRoleName" runat="server" Text='<%#Eval("Name")%>' />:
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField>
												<ItemTemplate>
													<asp:HiddenField ID="hfRoleID" runat="server" Value='<%#Eval("RoleID")%>' />
													<asp:CheckBox ID="cbShowArticle" runat="server" Checked='<%#Eval("Show")%>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField>
												<ItemTemplate>
													<asp:CheckBox ID="cbEditArticle" runat="server" Checked='<%#Eval("Edit")%>' />
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
									</asp:GridView>
									<table class="permissions_table" style="position: relative; left: -2px; margin-bottom: 15px;">
										<tr>
											<td class="subject">
												<asp:Label ID="lblShowToUnauthorizedUser" resourcekey="lblShowToUnauthorizedUser" runat="server" Text="Unauthorized users:" />
											</td>
											<td>
												<asp:CheckBox ID="cbShowToUnauthorizedUser" runat="server" Style="position: relative; left: -2px;" />
											</td>
										</tr>
									</table>
									<asp:GridView ID="gvUserPermissions" runat="server" AutoGenerateColumns="False" CellPadding="0" CssClass="permissions_table" EnableModelValidation="True" GridLines="None" OnRowCommand="gvUserPermissions_RowCommand">
										<AlternatingRowStyle CssClass="second" />
										<Columns>
											<asp:TemplateField HeaderStyle-CssClass="subject" HeaderText="Users" ItemStyle-CssClass="subject">
												<ItemTemplate>
													<asp:Label ID="lblUserName" runat="server" Text='<%#Eval("Name")%>' />:
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="View article">
												<ItemTemplate>
													<asp:HiddenField ID="hfUserID" runat="server" Value='<%#Eval("UserID")%>' />
													<asp:CheckBox ID="cbShowArticle" runat="server" Checked='<%#Eval("Show")%>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Edit article">
												<ItemTemplate>
													<asp:CheckBox ID="cbEditArticle" runat="server" Checked='<%#Eval("Edit")%>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="">
												<ItemTemplate>
													<asp:LinkButton ID="lbUserPremissionRemove" resourcekey="lbUserPremissionRemove" runat="server" CausesValidation="False" CommandArgument='<%#Eval("UserID")%>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this user permissions?');"
														Text="Remove"></asp:LinkButton>
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
									</asp:GridView>
									<asp:Label ID="lblAdduserMessage" runat="server" EnableViewState="False" ForeColor="Red" />
									<table class="permissions_table">
										<tr>
											<td class="subject">
												<asp:Label ID="lblUsernameToAdd" resourcekey="lblUsernameToAdd" runat="server" Text="Add user by username:" />
											</td>
											<td style="width: 150px; text-align: left;">
												<asp:TextBox ID="tbUserNameToAdd" runat="server" />
												<asp:LinkButton ID="lbUsernameAdd" resourcekey="lbUsernameAdd" runat="server" OnClick="lbUsernameAdd_Click" Text="Add" />
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
						<div id="pnlSocialSharing" class="social_sharing_box" runat="server" visible="false" style="display: none; bottom: 70px;">
							<p id="lblSocialSharingTitle" runat="server" style="font-weight: bold;">
								<span style="color: red;">
									<%=Post%></span>
								<%=Articleto%></p>
							<p id="pnlPostToFacebook" runat="server" visible="false">
								<asp:CheckBox ID="cbPostToFacebook" runat="server" /><asp:Label ID="lblPostToFacebook" resourcekey="lblPostToFacebook" runat="server" Text="Facebook" />
								<asp:DropDownList ID="ddlPostToFacebook" runat="server" CssClass="custom_drop_down_style" />
							</p>
							<p id="pnlPostToTwitter" runat="server" visible="false">
								<asp:CheckBox ID="cbPostToTwitter" runat="server" /><asp:Label ID="lblPostToTwitter" resourcekey="lblPostToTwitter" runat="server" Text="Twitter" />
								<asp:DropDownList ID="ddlPostToTwitter" runat="server" CssClass="custom_drop_down_style" />
							</p>
						</div>
						<div id="pnlSocialSecurity" class="social_sharing_box" runat="server" visible="true" style="right: 255px; bottom: 70px; opacity: 100;">
							<p id="lblSocialSecurityTitle" runat="server" style="font-weight: bold;">
								<%=Social%><span style="color: red;"><%=security %></span></p>
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
						<asp:Label ID="lblMainEditMessage" runat="server" />
						<asp:RadioButtonList ID="rblDraftPublish" runat="server" CssClass="checkbox_list" RepeatDirection="Horizontal" Style="margin: 0 0 0 40px; height: 27px;">
							<asp:ListItem Selected="True" Value="Draft" resourcekey="liDraftArticle" Text="Draft Article" />
							<asp:ListItem Value="Publish" resourcekey="liPublishArticle" Text="Publish Article" />
						</asp:RadioButtonList>
						<asp:Label ID="lblApprovingMessage" resourcekey="lblApprovingMessage" runat="server" Text="Your article needs to be approved. It will not be visible until it is approved." Font-Size="Small" Style="display: none" />
						<div class="button_list center w_565">
							<asp:LinkButton ID="btnAddNewArticle" runat="server" OnClick="btnAddNewArticle_Click" Text="Save article" ValidationGroup="vgAddArticle" CssClass="main_action_button w140 red" resourcekey="btnAddNewArticle" />
							<asp:LinkButton ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="" UseSubmitBehavior="False" CssClass="main_action_button w100 grey" resourcekey="btnCancel"></asp:LinkButton>
						</div>
						<div style="clear: both;">
						</div>
					</div>
				</asp:Panel>
			</div>
		</div>
	</asp:Panel>
</asp:Panel>
<div style="display: none;">
	<asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Button" />
</div>
<asp:ObjectDataSource ID="odsSharedImages" runat="server" DeleteMethod="DeleteImage" SelectMethod="GetImagesFromGalleryByUserID" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" UpdateMethod="UpdatePictureTitleDescription">
	<DeleteParameters>
		<asp:Parameter Name="PictureID" Type="Int32" />
	</DeleteParameters>
	<UpdateParameters>
		<asp:Parameter Name="PictureID" Type="Int32" />
		<asp:Parameter Name="Title" Type="String" />
		<asp:Parameter Name="Description" Type="String" />
	</UpdateParameters>
	<SelectParameters>
		<asp:Parameter Name="GalleryID" Type="Int32" />
		<asp:Parameter Name="ByUserID" Type="String" />
		<asp:Parameter Name="UserID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsCategoryList" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" runat="server" SelectMethod="GetCategoriesFromList">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsGalleryImages" runat="server" DeleteMethod="DeleteImage" OldValuesParameterFormatString="{0}" SelectMethod="GetImagesFromGallery" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" UpdateMethod="UpdatePictureTitleDescription">
	<DeleteParameters>
		<asp:Parameter Name="PictureID" Type="Int32" />
	</DeleteParameters>
	<UpdateParameters>
		<asp:Parameter Name="PictureID" Type="Int32" />
		<asp:Parameter Name="Title" Type="String" />
		<asp:Parameter Name="Description" Type="String" />
	</UpdateParameters>
	<SelectParameters>
		<asp:Parameter Name="GalleryID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsArticleImages" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetImagesFromGallery" UpdateMethod="UpdatePictureTitleDescription" DeleteMethod="DeleteImage">
	<DeleteParameters>
		<asp:Parameter Name="PictureID" Type="Int32" />
	</DeleteParameters>
	<UpdateParameters>
		<asp:Parameter Name="PictureID" Type="Int32" />
		<asp:Parameter Name="Title" Type="String" />
		<asp:Parameter Name="Description" Type="String" />
	</UpdateParameters>
	<SelectParameters>
		<asp:Parameter Name="GalleryID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsGetTagsByName" runat="server" EnablePaging="True" SelectCountMethod="GetCloudTagsSortByNameCount" SelectMethod="GetCloudTagsSortByName" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" MaximumRowsParameterName="To"
	StartRowIndexParameterName="from">
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
