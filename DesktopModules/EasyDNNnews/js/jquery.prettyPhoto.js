/* ------------------------------------------------------------------------
Class: prettyPhoto
Use: Lightbox clone for jQuery
Author: Stephane Caron (http://www.no-margin-for-errors.com)
Version: 3.1.2
------------------------------------------------------------------------- */
(function () {
var eds_prettyPhoto = function($) {
	$.prettyPhoto = { version: '3.1.2' };

	$.fn.prettyPhoto = function(pp_settings) {
		pp_settings = $.extend({}, {
			animation_speed: 'fast', /* fast/slow/normal */
			slideshow: 5000, /* false OR interval time in ms */
			autoplay_slideshow: false, /* true/false */
			opacity: 0.80, /* Value between 0 and 1 */
			show_title: true, /* true/false */
			allow_resize: true, /* Resize the photos bigger than viewport. true/false */
			default_width: 500,
			default_height: 344,
			counter_separator_label: '/', /* The separator for the gallery counter 1 "of" 2 */
			theme: 'pp_default', /* light_rounded / dark_rounded / light_square / dark_square / facebook */
			horizontal_padding: 20, /* The padding on each side of the picture */
			hideflash: false, /* Hides all the flash object on a page, set to TRUE if flash appears over prettyPhoto */
			wmode: 'opaque', /* Set the flash wmode attribute */
			autoplay: true, /* Automatically start videos: True/False */
			modal: false, /* If set to true, only the close button will close the window */
			deeplinking: false, /* Allow prettyPhoto to update the url to enable deeplinking. */
			overlay_gallery: true, /* If set to true, a gallery will overlay the fullscreen image on mouse over */
			keyboard_shortcuts: true, /* Set to false if you open forms inside prettyPhoto */
			changepicturecallback: function() { }, /* Called everytime an item is shown/changed */
			callback: function() { }, /* Called when prettyPhoto is closed */
			ie6_fallback: true,
			gallery_thumb_dimensions: { width: 50, height: 33 },
			download_handler_url: 'false',
			download_image_text: 'Download image',
			allow_image_printing: false,
			print_image_text: 'Print image',
			show_social_sharing: false,
			facebook_locale: 'en_US',
			item_emailing_text: 'Email the link',
			item_emailing_subject: 'Look what I\'ve found...',
			enable_item_emailing: false,
			item_title_position: 'top',
			gallery_ontop_item: true,
			gallery_autohide: true,

			markup: '<div class="pp_pic_holder">{pp_title_top}\
						<div class="pp_top"> \
							<div class="pp_left"></div> \
							<div class="pp_middle"></div> \
							<div class="pp_right"></div> \
						</div> \
						<div class="pp_content_container"> \
							<div class="pp_left"> \
							<div class="pp_right"> \
								<div class="pp_content"> \
									<div class="pp_loaderIcon"></div> \
									<div class="pp_fade"> \
										<a href="#" class="pp_expand" title="Expand the image">Expand</a> \
										<div class="pp_hoverContainer"> \
											<a class="pp_next" href="#">next</a> \
											<a class="pp_previous" href="#">previous</a> \
										</div> \
										<div id="pp_full_res"></div> \
										<div class="pp_details"> \
											<div class="pp_nav"> \
												<a href="#" class="pp_arrow_previous">Previous</a> \
												<p class="currentTextHolder">0/0</p> \
												<a href="#" class="pp_arrow_next">Next</a> \
											</div>{pp_title_bottom}\
											<p class="pp_description"></p> \
											{pp_tools_and_sharing} \
											<a class="pp_close" href="#">Close</a> \
										</div> \
									</div> \
								</div> \
							</div> \
							</div> \
						</div> \
						<div class="pp_bottom"> \
							<div class="pp_left"></div> \
							<div class="pp_middle"></div> \
							<div class="pp_right"></div> \
						</div> \
					</div> \
					<div class="pp_overlay"></div>',
			gallery_markup: '<div class="pp_gallery"> \
								<a href="#" class="pp_arrow_previous">Previous</a> \
								<div> \
									<ul> \
										{gallery} \
									</ul> \
								</div> \
								<a href="#" class="pp_arrow_next">Next</a> \
							</div>',
			image_markup: '<img id="fullResImage" src="{path}" />',
			flash_markup: '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="{width}" height="{height}"><param name="wmode" value="{wmode}" /><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="movie" value="{path}" /><embed src="{path}" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="{width}" height="{height}" wmode="{wmode}"></embed></object>',
			quicktime_markup: '<object classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B" codebase="http://www.apple.com/qtactivex/qtplugin.cab" height="{height}" width="{width}"><param name="src" value="{path}"><param name="autoplay" value="{autoplay}"><param name="type" value="video/quicktime"><embed src="{path}" height="{height}" width="{width}" autoplay="{autoplay}" type="video/quicktime" pluginspage="http://www.apple.com/quicktime/download/"></embed></object>',
			iframe_markup: '<iframe src ="{path}" width="{width}" height="{height}" frameborder="no"></iframe>',
			inline_markup: '<div class="pp_inline">{content}</div>',
			custom_markup: '',
			tools_and_sharing: '<div class="pp_tools_and_sharing">\
								<a id="pp_image_download_link" class="icon_link pp_image_down_link" href="#" title="{download_image_text}"></a>\
								<a id="pp_print_image_link" class="icon_link pp_image_print_link" href="#" title="{print_image_text}"></a>\
								<a id="pp_email_link" class="icon_link pp_send_email_link" href="#" title="{item_emailing_text}"></a>\
								<div class="pp_social_tools"></div>\
							</div>',
			social_tools: '\
									<a href="http://twitter.com/share" class="twitter-share-button" data-url="{location_href}" data-count="horizontal">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>\
									<iframe src="http://www.facebook.com/plugins/like.php?locale={facebook_locale}&href={location_href_encoded}&amp;layout=button_count&amp;show_faces=true&amp;action=like&amp;font&amp;colorscheme=light&amp;height=20" scrolling="no" frameborder="0" style="border:none; overflow:hidden; height:20px; width: 100px;" allowTransparency="true"></iframe>\
									<g:plusone size="medium" href="{location_href}" annotation="bubble"></g:plusone><script type="text/javascript">gapi.plusone.go();</script>'
		}, pp_settings);

		// Global variables accessible only by prettyPhoto
		var matchedObjects = this, percentBased = false, pp_dimensions, pp_open,

		// prettyPhoto container specific
		pp_contentHeight, pp_contentWidth, pp_containerHeight, pp_containerWidth,

		// Window size
		windowHeight = $(window).height(), windowWidth = $(window).width(),

		// Global elements
		pp_slideshow, download_url = '', social_button_href = '', edgpid, edgmid;

		doresize = true, scroll_pos = _get_scroll();

		// Window/Keyboard events
		$(window).unbind('resize.prettyphoto').bind('resize.prettyphoto', function() { _center_overlay(); _resize_overlay(); });

		if (pp_settings.keyboard_shortcuts) {
			$(document).unbind('keydown.prettyphoto').bind('keydown.prettyphoto', function(e) {
				if (typeof $pp_pic_holder != 'undefined') {
					if ($pp_pic_holder.is(':visible')) {
						switch (e.keyCode) {
							case 37:
								$.prettyPhoto.changePage('previous');
								e.preventDefault();
								break;
							case 39:
								$.prettyPhoto.changePage('next');
								e.preventDefault();
								break;
							case 27:
								if (!settings.modal)
									$.prettyPhoto.close();
								e.preventDefault();
								break;
						};
						// return false;
					};
				};
			});
		};

		/**
		* Initialize prettyPhoto.
		*/
		$.prettyPhoto.initialize = function() {

			settings = pp_settings;

			if (settings.theme == 'pp_default') settings.horizontal_padding = 16;
			if (settings.ie6_fallback && $.browser.msie && parseInt($.browser.version) == 6) settings.theme = "light_square"; // Fallback to a supported theme for IE6

			var $clicked = $(this);

			// Find out if the picture is part of a set
			theRel = $clicked.attr('rel');
			galleryRegExp = /_(?:.*)/;
			isSet = (galleryRegExp.exec(theRel)) ? true : false;

			// Put the SRCs, TITLEs, ALTs into an array.
			pp_images = (isSet) ? $.map(matchedObjects, function(n, i) { if ($(n).attr('rel').indexOf(theRel) != -1) return $(n).attr('href'); }) : $.makeArray($clicked.attr('href'));
			pp_titles = (isSet) ? $.map(matchedObjects, function(n, i) { if ($(n).attr('rel').indexOf(theRel) != -1) return ($(n).find('img').attr('alt')) ? $(n).find('img').attr('alt') : ""; }) : $.makeArray($clicked.find('img').attr('alt'));
			pp_descriptions = (isSet) ? $.map(matchedObjects, function(n, i) { if ($(n).attr('rel').indexOf(theRel) != -1) return ($(n).attr('pptitle')) ? $(n).attr('pptitle') : ""; }) : $.makeArray($clicked.attr('pptitle'));

			set_position = $.inArray($clicked.attr('href'), pp_images); // Define where in the array the clicked item is positionned
			rel_index = (isSet) ? set_position : $("a[rel^='" + theRel + "']").index($clicked);

			_build_overlay(this); // Build the overlay {this} being the caller

			if (settings.allow_resize)
				$(window).bind('scroll.prettyphoto', function() { _center_overlay(); });

			$pp_pic_holder.delegate('#pp_print_image_link', 'click', function() {
				printWindow = window.open('', 'mywindow', 'location=1,status=1,scrollbars=1,width=600,height=600');
				printWindow.document.write('<div><img alt="" src="' + $pp_pic_holder.find('#fullResImage').attr('src') + '"/></div>');
				printWindow.document.close();
				printWindow.print();

				return false;
			});

			$pp_pic_holder.delegate('#pp_email_link', 'click', function() {
				window.location.href = "mailto:"
					+ "?subject=" + escape(settings.item_emailing_subject)
					+ '&body=' + encodeURIComponent(social_button_href);

				return false;
			});

			$.prettyPhoto.open();

			return false;
		}


		/**
		* Opens the prettyPhoto modal box.
		* @param image {String,Array} Full path to the image to be open, can also be an array containing full images paths.
		* @param title {String,Array} The title to be displayed with the picture, can also be an array containing all the titles.
		* @param description {String,Array} The description to be displayed with the picture, can also be an array containing all the descriptions.
		*/
		$.prettyPhoto.open = function(event) {
			if (typeof settings == "undefined") { // Means it's an API call, need to manually get the settings and set the variables
				settings = pp_settings;
				if ($.browser.msie && $.browser.version == 6) settings.theme = "light_square"; // Fallback to a supported theme for IE6
				pp_images = $.makeArray(arguments[0]);
				pp_titles = (arguments[1]) ? $.makeArray(arguments[1]) : $.makeArray("");
				pp_descriptions = (arguments[2]) ? $.makeArray(arguments[2]) : $.makeArray("");
				isSet = (pp_images.length > 1) ? true : false;
				set_position = 0;
				_build_overlay(event.target); // Build the overlay {this} being the caller
			}

			var current_item = $('a[rel="' + theRel + '"][href="' + pp_images[set_position] + '"]');

			download_url = current_item.attr('downhref') ? current_item.attr('downhref') : '';
			social_button_href = current_item.attr('lbnestedurl') ? current_item.attr('lbnestedurl') : location.href;

			var url_has_hash = social_button_href.substring(0, social_button_href.indexOf('#'))
			url_rel = theRel.replace('_fullscreen', '');

			if (url_has_hash) {
				social_button_href = url_has_hash;
			}

			edgpid = current_item.attr('edgpid');
			edgmid = current_item.attr('edgmid');

			social_button_href = setParamInUri(social_button_href, 'edgpid', edgpid) + '#!' + url_rel + '/id' + edgpid + '/';

			if (edgmid != undefined) {
				social_button_href = setParamInUri(social_button_href, 'edgmid', edgmid);
			}

			if ($.browser.msie && $.browser.version == 6) $('select').css('visibility', 'hidden'); // To fix the bug with IE select boxes

			if (settings.hideflash) $('object,embed,iframe[src*=youtube],iframe[src*=vimeo]').css('visibility', 'hidden'); // Hide the flash

			_checkPosition($(pp_images).size()); // Hide the next/previous links if on first or last images.

			$('.pp_loaderIcon').show();

			// Fade the content in
			if ($ppt.is(':hidden')) $ppt.css('opacity', 0).show();
			$pp_overlay.show().fadeTo(settings.animation_speed, settings.opacity);

			// Display the current position
			$pp_pic_holder.find('.currentTextHolder').text((set_position + 1) + settings.counter_separator_label + $(pp_images).size());

			// Set the description
			if (pp_descriptions[set_position] != "") {
				$pp_pic_holder.find('.pp_description').show().html(unescape(pp_descriptions[set_position]));
			} else {
				$pp_pic_holder.find('.pp_description').hide();
			}

			// Get the dimensions
			movie_width = (parseFloat(getParam('width', pp_images[set_position]))) ? getParam('width', pp_images[set_position]) : settings.default_width.toString();
			movie_height = (parseFloat(getParam('height', pp_images[set_position]))) ? getParam('height', pp_images[set_position]) : settings.default_height.toString();

			// If the size is % based, calculate according to window dimensions
			percentBased = false;
			if (movie_height.indexOf('%') != -1) { movie_height = parseFloat(($(window).height() * parseFloat(movie_height) / 100) - 150); percentBased = true; }
			if (movie_width.indexOf('%') != -1) { movie_width = parseFloat(($(window).width() * parseFloat(movie_width) / 100) - 150); percentBased = true; }

			// Fade the holder
			$pp_pic_holder.fadeIn(function() {
				// Set the title
				(settings.show_title && pp_titles[set_position] != "" && typeof pp_titles[set_position] != "undefined") ? $ppt.html(unescape(pp_titles[set_position])) : $ppt.html('&nbsp;');

				imgPreloader = "";
				skipInjection = false;

				// Inject the proper content
				switch (_getFileType(pp_images[set_position])) {
					case 'image':
						imgPreloader = new Image();

						// Preload the neighbour images
						nextImage = new Image();
						if (isSet && set_position < $(pp_images).size() - 1) nextImage.src = pp_images[set_position + 1];
						prevImage = new Image();
						if (isSet && pp_images[set_position - 1]) prevImage.src = pp_images[set_position - 1];

						$pp_pic_holder.find('#pp_full_res')[0].innerHTML = settings.image_markup.replace(/{path}/g, pp_images[set_position]);

						imgPreloader.onload = function() {
							// Fit item to viewport
							pp_dimensions = _fitToViewport(imgPreloader.width, imgPreloader.height);

							_showContent();
						};

						imgPreloader.onerror = function() {
							alert('Image cannot be loaded. Make sure the path is correct and image exist.');
							$.prettyPhoto.close();
						};

						imgPreloader.src = pp_images[set_position];
						break;

					case 'youtube':
						pp_dimensions = _fitToViewport(movie_width, movie_height); // Fit item to viewport

						// Regular youtube link
						movie_id = getParam('v', pp_images[set_position]);

						// youtu.be link
						if (movie_id == "") {
							movie_id = pp_images[set_position].split('youtu.be/');
							movie_id = movie_id[1];
							if (movie_id.indexOf('?') > 0)
								movie_id = movie_id.substr(0, movie_id.indexOf('?')); // Strip anything after the ?

							if (movie_id.indexOf('&') > 0)
								movie_id = movie_id.substr(0, movie_id.indexOf('&')); // Strip anything after the &
						}

						movie = 'http://www.youtube.com/embed/' + movie_id;
						(getParam('rel', pp_images[set_position])) ? movie += "?rel=" + getParam('rel', pp_images[set_position]) : movie += "?rel=1";

						if (settings.autoplay) movie += "&autoplay=1";

						toInject = settings.iframe_markup.replace(/{width}/g, pp_dimensions['width']).replace(/{height}/g, pp_dimensions['height']).replace(/{wmode}/g, settings.wmode).replace(/{path}/g, movie);
						break;

					case 'vimeo':
						pp_dimensions = _fitToViewport(movie_width, movie_height); // Fit item to viewport

						movie_id = pp_images[set_position];
						var regExp = /http:\/\/(www\.)?vimeo.com\/(\d+)/;
						var match = movie_id.match(regExp);

						movie = 'http://player.vimeo.com/video/' + match[2] + '?title=0&amp;byline=0&amp;portrait=0';
						if (settings.autoplay) movie += "&autoplay=1;";

						vimeo_width = pp_dimensions['width'] + '/embed/?moog_width=' + pp_dimensions['width'];

						toInject = settings.iframe_markup.replace(/{width}/g, vimeo_width).replace(/{height}/g, pp_dimensions['height']).replace(/{path}/g, movie);
						break;

					case 'quicktime':
						pp_dimensions = _fitToViewport(movie_width, movie_height); // Fit item to viewport
						pp_dimensions['height'] += 15; pp_dimensions['contentHeight'] += 15; pp_dimensions['containerHeight'] += 15; // Add space for the control bar

						toInject = settings.quicktime_markup.replace(/{width}/g, pp_dimensions['width']).replace(/{height}/g, pp_dimensions['height']).replace(/{wmode}/g, settings.wmode).replace(/{path}/g, pp_images[set_position]).replace(/{autoplay}/g, settings.autoplay);
						break;

					case 'flash':
						pp_dimensions = _fitToViewport(movie_width, movie_height); // Fit item to viewport

						flash_vars = pp_images[set_position];
						flash_vars = flash_vars.substring(pp_images[set_position].indexOf('flashvars') + 10, pp_images[set_position].length);

						filename = pp_images[set_position];
						filename = filename.substring(0, filename.indexOf('?'));

						toInject = settings.flash_markup.replace(/{width}/g, pp_dimensions['width']).replace(/{height}/g, pp_dimensions['height']).replace(/{wmode}/g, settings.wmode).replace(/{path}/g, filename + '?' + flash_vars);
						break;

					case 'iframe':
						pp_dimensions = _fitToViewport(movie_width, movie_height); // Fit item to viewport

						frame_url = pp_images[set_position];
						frame_url = frame_url.substr(0, frame_url.indexOf('iframe') - 1);

						toInject = settings.iframe_markup.replace(/{width}/g, pp_dimensions['width']).replace(/{height}/g, pp_dimensions['height']).replace(/{path}/g, frame_url);
						break;

					case 'ajax':
						doresize = false; // Make sure the dimensions are not resized.
						pp_dimensions = _fitToViewport(movie_width, movie_height);
						doresize = true; // Reset the dimensions

						skipInjection = true;
						$.get(pp_images[set_position], function(responseHTML) {
							toInject = settings.inline_markup.replace(/{content}/g, responseHTML);
							$pp_pic_holder.find('#pp_full_res')[0].innerHTML = toInject;
							_showContent();
						});

						break;

					case 'custom':
						pp_dimensions = _fitToViewport(movie_width, movie_height); // Fit item to viewport

						toInject = settings.custom_markup;
						break;

					case 'inline':
						// to get the item height clone it, apply default width, wrap it in the prettyPhoto containers , then delete
						myClone = $(pp_images[set_position]).clone().append('<div style="clear: all; margin: 0; padding: 0; border: 0; height: 0; width: 0;" />').css({ 'width': settings.default_width }).wrapInner('<div id="pp_full_res"><div class="pp_inline"></div></div>').appendTo($('body')).show();
						doresize = false; // Make sure the dimensions are not resized.
						pp_dimensions = _fitToViewport($(myClone).width(), $(myClone).height());
						doresize = true; // Reset the dimensions
						$(myClone).remove();
						toInject = settings.inline_markup.replace(/{content}/g, $(pp_images[set_position]).html());
						break;
				};

				if (!imgPreloader && !skipInjection) {
					$pp_pic_holder.find('#pp_full_res')[0].innerHTML = toInject;

					// Show content
					_showContent();
				};

			});

			return false;
		};


		/**
		* Change page in the prettyPhoto modal box
		* @param direction {String} Direction of the paging, previous or next.
		*/
		$.prettyPhoto.changePage = function(direction) {
			currentGalleryPage = 0;

			if (direction == 'previous') {
				set_position--;
				if (set_position < 0) set_position = $(pp_images).size() - 1;
			} else if (direction == 'next') {
				set_position++;
				if (set_position > $(pp_images).size() - 1) set_position = 0;
			} else {
				set_position = direction;
			};
			rel_index = set_position;

			if (!doresize) doresize = true; // Allow the resizing of the images
			$('.pp_contract').removeClass('pp_contract').addClass('pp_expand');

			_hideContent(function() { $.prettyPhoto.open(); });
		};


		/**
		* Change gallery page in the prettyPhoto modal box
		* @param direction {String} Direction of the paging, previous or next.
		*/
		$.prettyPhoto.changeGalleryPage = function(direction) {
			if (direction == 'next') {
				currentGalleryPage++;

				if (currentGalleryPage > totalPage) currentGalleryPage = 0;
			} else if (direction == 'previous') {
				currentGalleryPage--;

				if (currentGalleryPage < 0) currentGalleryPage = totalPage;
			} else {
				currentGalleryPage = direction;
			};

			slide_speed = (direction == 'next' || direction == 'previous') ? settings.animation_speed : 0;

			slide_to = currentGalleryPage * (itemsPerPage * itemWidth);

			$pp_gallery.find('ul').animate({ left: -slide_to }, slide_speed);
		};


		/**
		* Start the slideshow...
		*/
		$.prettyPhoto.startSlideshow = function() {
			if (typeof pp_slideshow == 'undefined') {
				$pp_pic_holder.find('.pp_play').unbind('click').removeClass('pp_play').addClass('pp_pause').click(function() {
					$.prettyPhoto.stopSlideshow();
					return false;
				});
				pp_slideshow = setInterval($.prettyPhoto.startSlideshow, settings.slideshow);
			} else {
				$.prettyPhoto.changePage('next');
			};
		}


		/**
		* Stop the slideshow...
		*/
		$.prettyPhoto.stopSlideshow = function() {
			$pp_pic_holder.find('.pp_pause').unbind('click').removeClass('pp_pause').addClass('pp_play').click(function() {
				$.prettyPhoto.startSlideshow();
				return false;
			});
			clearInterval(pp_slideshow);
			pp_slideshow = undefined;
		}


		/**
		* Closes prettyPhoto.
		*/
		$.prettyPhoto.close = function() {
			if ($pp_overlay.is(":animated")) return;

			$.prettyPhoto.stopSlideshow();

			$pp_pic_holder.stop().find('object,embed').css('visibility', 'hidden');

			$('div.pp_pic_holder,div.ppt,.pp_fade').fadeOut(settings.animation_speed, function() { $(this).remove(); });

			$pp_overlay.fadeOut(settings.animation_speed, function() {
				if ($.browser.msie && $.browser.version == 6) $('select').css('visibility', 'visible'); // To fix the bug with IE select boxes

				if (settings.hideflash) $('object,embed,iframe[src*=youtube],iframe[src*=vimeo]').css('visibility', 'visible'); // Show the flash

				$(this).remove(); // No more need for the prettyPhoto markup

				$(window).unbind('scroll.prettyphoto');

				clearHashtag();

				settings.callback();

				doresize = true;

				pp_open = false;
			});
		};

		/**
		* Set the proper sizes on the containers and animate the content in.
		*/
		function _showContent() {
			$('.pp_loaderIcon').hide();

			var $image_download_link = $('#pp_image_download_link'),
				current_file_type = _getFileType(pp_images[set_position]);

			if (settings.download_handler_url !== 'false' && download_url && current_file_type == 'image') {
				$image_download_link.attr('href', download_url);
			} else {
				$image_download_link.hide();
			}

			if (!settings.allow_image_printing || current_file_type != 'image') {
				$pp_pic_holder.find('.pp_image_print_link').hide();
			}

			if (!settings.enable_item_emailing) {
				$pp_pic_holder.find('.pp_send_email_link').hide();
			}

			// Calculate the opened top position of the pic holder
			projectedTop = scroll_pos['scrollTop'] + ((windowHeight / 2) - (pp_dimensions['containerHeight'] / 2));
			if (projectedTop < 0) projectedTop = 0;

			$ppt.fadeTo(settings.animation_speed, 1);

			// Resize the content holder
			$pp_pic_holder.find('.pp_content')
				.animate({
					height: pp_dimensions['contentHeight'],
					width: pp_dimensions['contentWidth']
				}, settings.animation_speed);

			// Resize picture the holder
			$pp_pic_holder.animate({
				'top': projectedTop,
				'left': (windowWidth / 2) - (pp_dimensions['containerWidth'] / 2),
				width: pp_dimensions['containerWidth']
			}, settings.animation_speed, function() {
				$pp_pic_holder.find('.pp_hoverContainer,#fullResImage').height(pp_dimensions['height']).width(pp_dimensions['width']);

				$pp_pic_holder.find('.pp_fade').fadeIn(settings.animation_speed); // Fade the new content

				// Show the nav
				if (isSet && _getFileType(pp_images[set_position]) == "image") { $pp_pic_holder.find('.pp_hoverContainer').show(); } else { $pp_pic_holder.find('.pp_hoverContainer').hide(); }

				if (pp_dimensions['resized']) { // Fade the resizing link if the image is resized
					$('a.pp_expand,a.pp_contract').show();
				} else {
					$('a.pp_expand').hide();
				}

				if (settings.autoplay_slideshow && !pp_slideshow && !pp_open) $.prettyPhoto.startSlideshow();

				if (settings.deeplinking)
					setHashtag();

				if (settings.show_social_sharing) {
					var $social_tools = $pp_pic_holder.find('div.pp_social_tools'),
						social_tools_html = settings.social_tools;

					social_tools_html = social_tools_html.replace("{facebook_locale}", settings.facebook_locale)
							.replace("{location_href_encoded}", encodeURIComponent(social_button_href))
							.replace(/{location_href}/g, social_button_href);

					$social_tools.html(social_tools_html);
				}

				settings.changepicturecallback(); // Callback!

				pp_open = true;

				if (isSet && settings.overlay_gallery) {
					$pp_gallery_li.find('img').each(function() {
						var $img = $(this),
							$parent = $img.parent();

						if ($img.height() < settings.gallery_thumb_dimensions.height) {
							$parent
								.height($img.height())
								.css({
									marginTop: Math.ceil((settings.gallery_thumb_dimensions.height - $img.height()) / 2)
								});
						} else {
							$parent.css({
								marginTop: 0
							});
							$img
								.css({
									marginTop: -(Math.ceil(($img.height() - settings.gallery_thumb_dimensions.height) / 2))
								});
						}
					});
				}
			});

			_insert_gallery();
		};

		/**
		* Hide the content...DUH!
		*/
		function _hideContent(callback) {
			// Fade out the current picture
			$pp_pic_holder.find('#pp_full_res object,#pp_full_res embed').css('visibility', 'hidden');
			$pp_pic_holder.find('.pp_fade').fadeOut(settings.animation_speed, function() {
				$('.pp_loaderIcon').show();

				callback();
			});
		};

		/**
		* Check the item position in the gallery array, hide or show the navigation links
		* @param setCount {integer} The total number of items in the set
		*/
		function _checkPosition(setCount) {
			(setCount > 1) ? $('.pp_nav').show() : $('.pp_nav').hide(); // Hide the bottom nav if it's not a set.
		};

		/**
		* Resize the item dimensions if it's bigger than the viewport
		* @param width {integer} Width of the item to be opened
		* @param height {integer} Height of the item to be opened
		* @return An array containin the "fitted" dimensions
		*/
		function _fitToViewport(width, height) {
			var resized = false,
				imageRatio,
				windowRatio,

			// Define them in case there's no resize needed
				imageWidth = width,
				imageHeight = height;

			_getDimensions(width, height);

			if (((pp_containerWidth > windowWidth) || (pp_containerHeight > windowHeight)) && doresize && settings.allow_resize && !percentBased) {
				resized = true;

				imageRation = width / height;
				windowRatio = (windowWidth - 200) / (windowHeight - 200);

				if (imageRation > windowRatio) {
					imageWidth = windowWidth - 200;
					imageHeight = (windowWidth - 200) / imageRation;
				} else {
					imageWidth = (windowHeight - 200) * imageRation;
					imageHeight = windowHeight - 200;
				}

				pp_containerHeight = imageHeight;
				pp_containerWidth = imageWidth;

				_getDimensions(imageWidth, imageHeight);
			};

			return {
				width: Math.floor(imageWidth),
				height: Math.floor(imageHeight),
				containerHeight: Math.floor(pp_containerHeight),
				containerWidth: Math.floor(pp_containerWidth) + (settings.horizontal_padding * 2),
				contentHeight: Math.floor(pp_contentHeight),
				contentWidth: Math.floor(pp_contentWidth),
				resized: resized
			};
		};

		/**
		* Get the containers dimensions according to the item size
		* @param width {integer} Width of the item to be opened
		* @param height {integer} Height of the item to be opened
		*/
		function _getDimensions(width, height) {
			width = parseFloat(width);
			height = parseFloat(height);

			// Get the details height, to do so, I need to clone it since it's invisible
			$pp_details = $pp_pic_holder.find('.pp_details');
			$pp_details.width(width);
			detailsHeight = parseFloat($pp_details.css('marginTop')) + parseFloat($pp_details.css('marginBottom'));

			if (width < 395) {
				$pp_details.find('.pp_tools_and_sharing').height(49);
			} else {
				$pp_details.find('.pp_tools_and_sharing').height('auto');
			}

			$pp_details = $pp_details.clone().addClass(settings.theme).width(width).appendTo($('body')).css({
				'position': 'absolute',
				'top': -10000
			});
			detailsHeight += $pp_details.height() + 3;
			detailsHeight = (detailsHeight <= 34) ? 36 : detailsHeight; // Min-height for the details
			if ($.browser.msie && $.browser.version == 7) detailsHeight += 8;
			$pp_details.remove();

			// Get the titles height, to do so, I need to clone it since it's invisible
			$pp_title = $pp_pic_holder.find('.ppt');
			if (settings.item_title_position == 'top')
				$pp_title.width(width);
			titleHeight = parseFloat($pp_title.css('marginTop')) + parseFloat($pp_title.css('marginBottom'));
			$pp_title = $pp_title.clone().appendTo($('body')).css({
				'position': 'absolute',
				'top': -10000
			});
			titleHeight += $pp_title.height();
			$pp_title.remove();

			// Get the container size, to resize the holder to the right dimensions
			pp_contentHeight = height + detailsHeight;
			pp_contentWidth = width;
			pp_containerHeight = pp_contentHeight + titleHeight + $pp_pic_holder.find('.pp_top').height() + $pp_pic_holder.find('.pp_bottom').height();
			pp_containerWidth = width;
		}

		function _getFileType(itemSrc) {
			if (itemSrc.match(/youtube\.com\/watch/i) || itemSrc.match(/youtu\.be/i)) {
				return 'youtube';
			} else if (itemSrc.match(/vimeo\.com/i)) {
				return 'vimeo';
			} else if (itemSrc.match(/\biframe=true\b/i)) {
				return 'iframe';
			} else if (itemSrc.match(/\b.mov\b/i)) {
				return 'quicktime';
			} else if (itemSrc.match(/\b.swf\b/i)) {
				return 'flash';

			} else if (itemSrc.match(/\bajax=true\b/i)) {
				return 'ajax';
			} else if (itemSrc.match(/\bcustom=true\b/i)) {
				return 'custom';
			} else if (itemSrc.substr(0, 1) == '#') {
				return 'inline';
			} else {
				return 'image';
			};
		};

		function _center_overlay() {
			if (doresize && typeof $pp_pic_holder != 'undefined') {
				scroll_pos = _get_scroll();
				contentHeight = $pp_pic_holder.height(), contentwidth = $pp_pic_holder.width();

				projectedTop = (windowHeight / 2) + scroll_pos['scrollTop'] - (contentHeight / 2);
				if (projectedTop < 0) projectedTop = 0;

				if (contentHeight > windowHeight)
					return;

				$pp_pic_holder.css({
					'top': projectedTop,
					'left': (windowWidth / 2) + scroll_pos['scrollLeft'] - (contentwidth / 2)
				});
			};
		};

		function _get_scroll() {
			if (self.pageYOffset) {
				return { scrollTop: self.pageYOffset, scrollLeft: self.pageXOffset };
			} else if (document.documentElement && document.documentElement.scrollTop) { // Explorer 6 Strict
				return { scrollTop: document.documentElement.scrollTop, scrollLeft: document.documentElement.scrollLeft };
			} else if (document.body) {// all other Explorers
				return { scrollTop: document.body.scrollTop, scrollLeft: document.body.scrollLeft };
			};
		};

		function _resize_overlay() {
			windowHeight = $(window).height(), windowWidth = $(window).width();

			if (typeof $pp_overlay != "undefined") $pp_overlay.height($(document).height()).width(windowWidth);
		};

		function _insert_gallery() {
			if (isSet && settings.overlay_gallery && _getFileType(pp_images[set_position]) == "image" && (settings.ie6_fallback && !($.browser.msie && parseInt($.browser.version) == 6))) {
				$pp_gallery.show();
				itemWidth = settings.gallery_thumb_dimensions.width + 7;
				navWidth = (settings.theme == "facebook" || settings.theme == "pp_default") ? 50 : 30; // Define the arrow width depending on the theme

				itemsPerPage = Math.floor((pp_dimensions['containerWidth'] - 100 - navWidth) / itemWidth);
				itemsPerPage = (itemsPerPage < pp_images.length) ? itemsPerPage : pp_images.length;
				totalPage = Math.ceil(pp_images.length / itemsPerPage) - 1;

				// Hide the nav in the case there's no need for links
				if (totalPage == 0) {
					navWidth = 0; // No nav means no width!
					$pp_gallery.find('.pp_arrow_next,.pp_arrow_previous').hide();
				} else {
					$pp_gallery.find('.pp_arrow_next,.pp_arrow_previous')
						.show()
						.attr('style', 'margin-top: ' + ((settings.gallery_thumb_dimensions.height / 2) - 7) + 'px !important');
				};

				galleryWidth = itemsPerPage * itemWidth;
				fullGalleryWidth = pp_images.length * itemWidth;

				// Set the proper width to the gallery items
				$pp_gallery
					.css({
						marginLeft: -((galleryWidth / 2) + (navWidth / 2)),
						marginTop: (settings.gallery_ontop_item ? -(settings.gallery_thumb_dimensions.height + 20) : 10)
					})
					.css('display', 'block')
					.find('div:first').width(galleryWidth + 5)
					.find('ul').width(fullGalleryWidth).height(settings.gallery_thumb_dimensions.height + 2)
					.find('li').removeClass('selected')
					.find('a').height(settings.gallery_thumb_dimensions.height);

				goToPage = (Math.floor(set_position / itemsPerPage) < totalPage) ? Math.floor(set_position / itemsPerPage) : totalPage;

				$.prettyPhoto.changeGalleryPage(goToPage);

				$pp_gallery_li.filter(':eq(' + set_position + ')').addClass('selected');
			} else {
				$pp_pic_holder.find('.pp_content').unbind('mouseenter mouseleave');
				if (typeof $pp_gallery == 'object')
					$pp_gallery.hide();
			}
		}

		function _build_overlay(caller) {
			settings.tools_and_sharing = settings.tools_and_sharing
				.replace("{download_image_text}", settings.download_image_text)
				.replace("{print_image_text}", settings.print_image_text)
				.replace("{item_emailing_text}", settings.item_emailing_text);

			settings.markup = settings.markup
				.replace('{pp_tools_and_sharing}', (settings.tools_and_sharing ? settings.tools_and_sharing : ''))
				.replace('{pp_title_top}', settings.item_title_position == 'top' ? '<div class="ppt">&nbsp;</div>' : '')
				.replace('{pp_title_bottom}', settings.item_title_position == 'bottom' ? '<div class="ppt">&nbsp;</div>' : '');

			$('body').append(settings.markup); // Inject the markup

			$pp_pic_holder = $('.pp_pic_holder'), $ppt = $('.ppt'), $pp_overlay = $('div.pp_overlay'); // Set my global selectors

			// Inject the inline gallery!
			if (isSet && settings.overlay_gallery) {
				currentGalleryPage = 0;
				toInject = "";
				$allItemsInGallery = $('a[rel="'+theRel+'"]');

				for (var i = 0; i < pp_images.length; i++) {
					if (!pp_images[i].match(/\b(jpg|jpeg|png|gif)\b/gi)) {
						classname = 'default';
						img_src = $allItemsInGallery.eq(i).find('> img').attr('src');
					} else {
						classname = '';
						img_src = pp_images[i];
					}
					toInject += "<li class='" + classname + "'><a href='#'><img src='" + img_src + "' width='" + settings.gallery_thumb_dimensions.width + "' alt='' /></a></li>";
				};

				toInject = settings.gallery_markup.replace(/{gallery}/g, toInject);

				$pp_pic_holder.find('#pp_full_res').after(toInject);

				$pp_gallery = $('.pp_pic_holder .pp_gallery'), $pp_gallery_li = $pp_gallery.find('li'); // Set the gallery selectors

				$pp_gallery.find('.pp_arrow_next').click(function() {
					$.prettyPhoto.changeGalleryPage('next');
					$.prettyPhoto.stopSlideshow();
					return false;
				});

				$pp_gallery.find('.pp_arrow_previous').click(function() {
					$.prettyPhoto.changeGalleryPage('previous');
					$.prettyPhoto.stopSlideshow();
					return false;
				});

				if (settings.gallery_autohide) {
					$pp_pic_holder.find('.pp_content').hover(
						function() {
							$pp_pic_holder.find('.pp_gallery:not(.disabled)').stop().fadeTo(400, 1);
						},
						function() {
							$pp_pic_holder.find('.pp_gallery:not(.disabled)').stop().fadeTo(400, 0);
						}
					);
				}

				$pp_gallery_li.each(function(i) {
					$(this)
						.find('a')
						.click(function() {
							$.prettyPhoto.changePage(i);
							$.prettyPhoto.stopSlideshow();
							return false;
						});
				});
			};


			// Inject the play/pause if it's a slideshow
			if (settings.slideshow) {
				$pp_pic_holder.find('.pp_nav').prepend('<a href="#" class="pp_play">Play</a>')
				$pp_pic_holder.find('.pp_nav .pp_play').click(function() {
					$.prettyPhoto.startSlideshow();
					return false;
				});
			}

			$pp_pic_holder.attr('class', 'pp_pic_holder ' + settings.theme); // Set the proper theme

			$pp_overlay
				.css({
					'opacity': 0,
					'height': $(document).height(),
					'width': $(window).width()
				})
				.bind('click', function() {
					if (!settings.modal) $.prettyPhoto.close();
				});

			$('a.pp_close').bind('click', function() { $.prettyPhoto.close(); return false; });

			$('a.pp_expand').bind('click', function(e) {
				// Expand the image
				if ($(this).hasClass('pp_expand')) {
					$(this).removeClass('pp_expand').addClass('pp_contract');
					doresize = false;
				} else {
					$(this).removeClass('pp_contract').addClass('pp_expand');
					doresize = true;
				};

				_hideContent(function() { $.prettyPhoto.open(); });

				return false;
			});

			$pp_pic_holder.find('.pp_previous, .pp_nav .pp_arrow_previous').bind('click', function() {
				$.prettyPhoto.changePage('previous');
				$.prettyPhoto.stopSlideshow();
				return false;
			});

			$pp_pic_holder.find('.pp_next, .pp_nav .pp_arrow_next').bind('click', function() {
				$.prettyPhoto.changePage('next');
				$.prettyPhoto.stopSlideshow();
				return false;
			});

			_center_overlay(); // Center it
		};

		var hashId = getHashtag(),
			hashRel;

		if (!pp_alreadyInitialized && hashId) {
			pp_alreadyInitialized = true;

			// Grab the rel index to trigger the click on the correct element
			hashRel = hashId;
			hashId = hashId.substring(hashId.indexOf('/') + 1, hashId.length - 1);
			hashRel = hashRel.substring(0, hashRel.indexOf('/'));

			// Little timeout to make sure all the prettyPhoto initialize scripts has been run.
			// Useful in the event the page contain several init scripts.

			openDeepLinkedItem(0, hashRel, hashId);
		}

		return this.unbind('click.prettyphoto').bind('click.prettyphoto', $.prettyPhoto.initialize); // Return the jQuery object for chaining. The unbind method is used to avoid click conflict when the plugin is called more than once
	};

	function openDeepLinkedItem(trys, hashRel, hashId) {
		if (trys >= 100)
			return;

		var isId = hashId.indexOf('id') == -1 ? false : true;

		setTimeout(function() {
			var $deepLinkedItem;

			if (isId) {
				$deepLinkedItem = $("a[rel='" + hashRel + "'][edgpid='" + hashId.substring(hashId.indexOf('id') + 2, hashId.length) + "']");
			} else {
				$deepLinkedItem = $("a[rel='" + hashRel + "']").eq(hashId);
			}

			if ($deepLinkedItem.length !== 0)
				$deepLinkedItem.trigger('click');
			else
				openDeepLinkedItem(trys + 1, hashRel, hashId);
		}, 100);
	};

	function getHashtag() {
		url = location.href;
		hashtag = (url.indexOf('#!') != -1) ? decodeURI(url.substring(url.indexOf('#!') + 2, url.length)) : false;
		return hashtag;
	};

	function setHashtag() {
		if (typeof theRel == 'undefined') return; // theRel is set on normal calls, it's impossible to deeplink using the API
		location.hash = '!' + theRel + '/' + edgpid + '/';
	};

	function clearHashtag() {
		if (location.href.indexOf('#!') != -1)
			location.hash = '';
	}

	function getParam(name, url) {
		name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
		var regexS = "[\\?&]" + name + "=([^&#]*)";
		var regex = new RegExp(regexS);
		var results = regex.exec(url);
		return (results == null) ? "" : results[1];
	}

	function setParamInUri(uri, param) {
		var uri_hash = '',
			return_uri = '',
			param_string = param + (arguments.length > 2 ? '=' + arguments[2] : '');

		uri = uri.split('#');

		if (uri.length == 1) {
			uri_hash = false;
		} else {
			uri_hash = uri[1];
		}

		uri = uri[0].split('?');
		if (uri.length == 1 || uri[1] == '') {
			return_uri = uri[0] + '?' + param_string;
		} else {
			return_uri = uri[0] + '?';

			var params = uri[1].split('&'),
				segment = false,
				found = false;

			for (var i in params) {
				if (typeof params[i] != 'string')
					continue;

				segment = params[i].split('=');

				if (segment[0] == param) {
					found = true;
					return_uri += param_string + '&';
				} else {
					if (segment.length == 1) {
						return_uri += segment[0] + '&';
					} else {
						return_uri += segment[0] + '=' + segment[1] + '&';
					}
				}
			}

			if (found)
				return_uri = return_uri.substring(0, return_uri.length - 1);
			else
				return_uri += param_string;
		}

		return return_uri + (uri_hash === false ? '' : '#' + uri_hash);
	}

};

if (typeof jQuery !== 'undefined')
	eds_prettyPhoto(jQuery);

if (typeof eds1_8 !== 'undefined')
	eds_prettyPhoto(eds1_8);
})();

var pp_alreadyInitialized = false; // Used for the deep linking to make sure not to call the same function several times.
