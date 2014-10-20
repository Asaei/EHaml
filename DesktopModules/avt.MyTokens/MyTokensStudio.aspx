<%@ Page Language="c#" AutoEventWireup="True" Explicit="True" Inherits="avt.MyTokens.MyTokensStudio" CodeBehind="MyTokensStudio.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="avt" TagName="TknWiz" Src = "~/DesktopModules/avt.MyTokens/TknWizard.ascx" %>
<%@ Register TagPrefix="avt" TagName="TknNs" Src = "~/DesktopModules/avt.MyTokens/TknNs.ascx" %>
<%@ Register TagPrefix="avt" TagName="ScriptEditor" Src = "~/DesktopModules/avt.MyTokens/ScriptEditor.ascx" %>
<%@ Register TagPrefix="avt" TagName="ExternalApi" Src = "~/DesktopModules/avt.MyTokens/ExternalApiPage.ascx" %>
<%@ Register TagPrefix="avt" TagName="StartPage" Src = "~/DesktopModules/avt.MyTokens/StartPage.ascx" %>
<%@ Register TagPrefix="avt" TagName="ManageServers" Src = "~/DesktopModules/avt.MyTokens/ManageServers.ascx" %>
<%@ Register TagPrefix="avt" TagName="Setup" Src = "~/DesktopModules/avt.MyTokens/SetupDialog.ascx" %>
<%@ Register TagPrefix="avt" TagName="ImportExport" Src = "~/DesktopModules/avt.MyTokens/ImportExport.ascx" %>

<html>
<head>

    <title>My Tokens Studio</title>
    
    <link type = "text/css" rel = "stylesheet" href = "<%=TemplateSourceDirectory%>/js/ui-themes/redmond/jquery-ui-1.8.11.css?v=<%= avt.MyTokens.MyTokensController.Build%>" />
    <link rel="stylesheet" type="text/css" href="<%=TemplateSourceDirectory%>/js/layout/css/complex.css?v=<%= avt.MyTokens.MyTokensController.Build%>" />
    <link rel="stylesheet" type="text/css" href="<%=TemplateSourceDirectory%>/js/beautytips/jquery.bt.css?v=<%= avt.MyTokens.MyTokensController.Build%>" />
    <link rel="stylesheet" type="text/css" href="<%=TemplateSourceDirectory%>/js/jGrowl/jquery.jgrowl.css?v=<%= avt.MyTokens.MyTokensController.Build%>" />
    <link type ="text/css" rel="stylesheet" href = "<%= TemplateSourceDirectory + "/studio.css"%>?v=<%= avt.MyTokens.MyTokensController.Build%>" />


    <script type = "text/javascript" src = "<%=TemplateSourceDirectory%>/js/jquery-1.5.1.js?v=<%= avt.MyTokens.MyTokensController.Build%>"></script>
    <script type = "text/javascript" src = "<%=TemplateSourceDirectory%>/js/jquery-ui-1.8.11.js?v=<%= avt.MyTokens.MyTokensController.Build%>"></script>
    <script type = "text/javascript" src = "<%=TemplateSourceDirectory%>/js/layout/jquery.layout.js?v=<%= avt.MyTokens.MyTokensController.Build%>"></script>
    <script type = "text/javascript" src = "<%=TemplateSourceDirectory%>/js/beautytips/jquery.bt.js?v=<%= avt.MyTokens.MyTokensController.Build%>"></script>
    <script type = "text/javascript" src = "<%=TemplateSourceDirectory%>/js/jGrowl/jquery.jgrowl.js?v=<%= avt.MyTokens.MyTokensController.Build%>"></script>
    <script type = "text/javascript" src = "<%=TemplateSourceDirectory%>/js/excanvas.js?v=<%= avt.MyTokens.MyTokensController.Build%>"></script>

    <script type = "text/javascript" src = "<%=TemplateSourceDirectory%>/js/avt.MyTokensStudio-1.0.js?v=<%= avt.MyTokens.MyTokensController.Build%>"></script>
    <script type = "text/javascript" src = "<%=TemplateSourceDirectory%>/js/avt.TokenTypes-1.0.js?v=<%= avt.MyTokens.MyTokensController.Build%>"></script>
    <script type = "text/javascript" src = "<%=TemplateSourceDirectory%>/js/json2.js?v=<%= avt.MyTokens.MyTokensController.Build%>"></script>
    <script type = "text/javascript" src = "<%=TemplateSourceDirectory%>/js/jquery.cookie.js?<%= avt.MyTokens.MyTokensController.Build%>"></script>
    <script type = "text/javascript" src = "<%=TemplateSourceDirectory%>/js/jsTree/jquery.jstree.js?<%= avt.MyTokens.MyTokensController.Build%>"></script>
    
    

    <script type="text/javascript">
    var outerLayout; // init global vars
    var g_tknTree;

	jQuery(document).ready( function() {

        if (!avt.mt.namespaces) { // back end not loaded
            $("body>form").children().not("#<%= pnlRegCoreStatus.ClientID%>").hide();
            return;
        }

		// create the OUTER LAYOUT
		outerLayout = jQuery("body").layout( layoutSettings_Outer );

		/*******************************
		 ***  CUSTOM LAYOUT BUTTONS  ***
		 *******************************
		 *
		 * Add SPANs to the east/west panes for customer "close" and "pin" buttons
		 *
		 * COULD have hard-coded span, div, button, image, or any element to use as a 'button'...
		 * ... but instead am adding SPANs via script - THEN attaching the layout-events to them
		 *
		 * CSS will size and position the spans, as well as set the background-images
		 */

		// BIND events to hard-coded buttons in the NORTH toolbar
		outerLayout.addToggleBtn( "#tbarToggleTest", "south" );

		// DEMO HELPER: prevent hyperlinks from reloading page when a 'base.href' is set
		jQuery("a").each(function () {
			var path = document.location.href;
			if (path.substr(path.length-1)=="#") path = path.substr(0,path.length-1);
			if (this.href.substr(this.href.length-1) == "#") this.href = path +"#";
		});

        jQuery("#lefttabs")
				.tabs();

        jQuery("#helpTabs")
                .tabs();

        jQuery("#tknTabs")
				.tabs()
				.find(".ui-tabs-nav")
					.sortable({ axis: 'x', zIndex: 2 })
			;

        // resize everything so it fits nice
        avt.mt.studio.resizeEditor();

        // init paths
        avt.mt.addUrl = "<%= TemplateSourceDirectory%>/AddEditToken.aspx?inline=true&portalid=<%=_portal.PortalID%>";
        avt.mt.editUrl = "<%= TemplateSourceDirectory%>/AddEditToken.aspx?inline=true&portalid=<%=_portal.PortalID%>&token_id=";
        
        avt.mt.pageUrl = '<%= Request.Url.OriginalString%>';
        avt.mt.serverRoot = '<%= ResolveUrl("~/")%>';
        avt.mt.modRoot = '<%= TemplateSourceDirectory[TemplateSourceDirectory.Length - 1] == '/' ? TemplateSourceDirectory : TemplateSourceDirectory + "/"%>';
	    //avt.mt.apiUrl = avt.mt.modRoot + "MyTokensApi.aspx?alias= HttpUtility.UrlEncode(_portalAlias) ";
	    avt.mt.apiUrl = avt.mt.modRoot + "MyTokensApi.aspx?portalid=<%= _portal.PortalID %>";
        avt.mt.returnUrl = '<%= Server.UrlDecode(Request.QueryString["rurl"])%>';
        avt.mt.isSuper = <%= DotNetNuke.Entities.Users.UserController.GetCurrentUserInfo().IsSuperUser ? "true" : "false"%>;
        
        
        //if (avt.mt.tokens.sel && avt.mt.tokens.sel.length > 0) {
        //    show_token(jQuery("[rel=tkn_"+ avt.mt.tokens.sel[0].id +"]").get(0));
        //}

        if (avt.mt.isSuper) {
            jQuery(".notSuperUser").hide();
        } else {
            jQuery(".notSuperUser").show();
        }
       
        // initialize the framework
        avt.mt.studio.init();

    });

    function searchTreeTokens(searchTerms) {
        if (jQuery.trim(searchTerms) == 0) {
            $("#treeTokens").jstree("clear_search");
            $("#btnClearSerchTokenTree").hide();
        } else {
            $("#treeTokens").jstree("search", searchTerms);
            $("#btnClearSerchTokenTree").show();
        }
    }


var layoutSettings_Outer = {
		name: "outerLayout" // NO FUNCTIONAL USE, but could be used by custom code to 'identify' a layout
		// options.defaults apply to ALL PANES - but overridden by pane-specific settings
	,	defaults: {
			size:					"auto"
		,	minSize:				50
		,	paneClass:				"pane" 		// default = 'ui-layout-pane'
		,	resizerClass:			"resizer"	// default = 'ui-layout-resizer'
		,	togglerClass:			"toggler"	// default = 'ui-layout-toggler'
		,	buttonClass:			"button"	// default = 'ui-layout-button'
		,	contentSelector:		".content"	// inner div to auto-size so only it scrolls, not the entire pane!
		,	contentIgnoreSelector:	"span"		// 'paneSelector' for content to 'ignore' when measuring room for content
		,	togglerLength_open:		35			// WIDTH of toggler on north/south edges - HEIGHT on east/west edges
		,	togglerLength_closed:	35			// "100%" OR -1 = full height
		,	hideTogglerOnSlide:		true		// hide the toggler when pane is 'slid open'
		,	togglerTip_open:		"Close This Pane"
		,	togglerTip_closed:		"Open This Pane"
		,	resizerTip:				"Resize This Pane"
		//	effect defaults - overridden on some panes
		,	fxName:					"slide"		// none, slide, drop, scale
		,	fxSpeed_open:			750
		,	fxSpeed_close:			1500
		,	fxSettings_open:		{ easing: "easeInQuint" }
		, fxSettings_close: { easing: "easeOutQuint" }
		, enableCursorHotkey: false
	}
	,	north: {
			spacing_open:			1			// cosmetic spacing
		,	togglerLength_open:		0			// HIDE the toggler button
		,	togglerLength_closed:	-1			// "100%" OR -1 = full width of pane
		,	resizable: 				false
		,	slidable:				false
		//	override default effect
		,	fxName:					"none"
		}
	,	south: {
	        size:					170,
			maxSize:				170
		,	spacing_closed:			10			// HIDE resizer & toggler when 'closed'
		,	slidable:				false		// REFERENCE - cannot slide if spacing_closed = 0
		,	initClosed:				true
		}
	,	west: {
			size:					300
		,	spacing_closed:			21			// wider space when closed
		,	togglerLength_closed:	21			// make toggler 'square' - 21x21
		,	togglerAlign_closed:	"top"		// align to top of resizer
		,	togglerLength_open:		0			// NONE - using custom togglers INSIDE west-pane
		,	togglerTip_open:		"Close Help"
		,	togglerTip_closed:		"Open Help"
		,	resizerTip_open:		"Resize Help"
		,	slideTrigger_open:		"click" 	// default
		,	initClosed:				false
		//	add 'bounce' option to default 'slide' effect
		,	fxSettings_open:		{ easing: "easeOutBounce" }
		}
	,	center: {
			paneSelector:			"#mainContent" 			// sample: use an ID to select pane instead of a class
		//,	onresize:				"innerLayout.resizeAll"	// resize INNER LAYOUT when center pane resizes
		,	minWidth:				200
		,	minHeight:				200
		,   onresize_end:           function () { avt.mt.studio.resizeEditor(); }
		}
	};

	</script>

</head>
<body>
<form runat = "server">

<div id="pnlRegCoreStatus" runat="server"></div>

<div class="ui-layout-west">

    <div class="header" style = "height: 14px; text-align: left; padding-left: 60px; font-size: 13px;">My Tokens</div>

    <div style="position:absolute; margin-top: -19px; margin-left: 7px;">
        <img border="0" src="<%=TemplateSourceDirectory%>/res/MyTokens_logo.png" class="pngFix" border="0" align="absmiddle" style="" height="50" />
    </div>

    <div style="font-size: 11px; margin: 6px 0 6px 60px;">
        Search <input type="text" id="tbSearchTokenTree" style="" />
        <a href="#" id="btnClearSerchTokenTree" style="font-size: 10px; display:none;">Clear</a>
    </div>
    <div id ="treeTokens" style="border: 1px solid #c2c2c2; overflow: auto;"></div>
    
    <div style="text-align:center;">
        <a href="#" onclick="g_tknTree.jstree('open_node', g_tknTree.find('li'), false, true); return false;" class="blue" style="font-size:11px;">Expand All</a> | 
        <a href="#" onclick="g_tknTree.jstree('open_node', g_tknTree.find('li'), false, true); g_tknTree.jstree('close_node', g_tknTree.find('li'),  true); return false;" class="blue" style="font-size:11px;">Collapse All</a> 
    </div>

    <div style="text-align:center; margin: 16px 0 0 0;">
        <button class="jbtn" onclick="avt.mt.tkn.newToken(-1); return false;">New Token...</button>
        <button class="jbtn" onclick="editScript(-1, null, null, null, null, null, 0, null, null); return false;">New Script...</button>
    </div>
</div>

<div class="ui-layout-north">
	<div class="header" style = "text-align: left; padding: 4px; font-size: 16px; color: #424242;">
	    <div style = "float: right; font-size: 11px; text-align: right;">
	        <span style = "">build <b><%= avt.MyTokens.MyTokensController.Build%></b></span>
	        by <a href = "http://www.dnnsharp.com">Avatar Software</a>
	    </div>
	    MyTokens Studio<span class = "current_token" style = "display: none;">- </span>
	    <div style = "clear: both;"></div>
	</div>

	<ul class="toolbar">
	    <li style="border-right-width: 2px;"><div style = "padding: 4px 4px 4px 22px; font-weight: bold;" onclick = "jQuery('#dlgSetup').dialog('open');" class = "btn_servers tooltip_hover" title = "Use this screen to access My Tokens global configuation that affects how tokens are replaced.">Setup</div></li>
        <%--<li><div style = "padding: 4px 4px 4px 22px;" onclick = "avt.mt.studio.newNamespace();" class = "btn_new_token tooltip_hover" title = "A token namespace acts as a container for tokens. It appears before token name such as in [Namespace:TokenName]. Click this button to create a new namespace. You'll be able to add tokens into it afterwards.">New Namespace</div></li>--%>
        <li><div style = "padding: 4px 4px 4px 22px;" onclick = "avt.mt.tkn.newToken(-1);" class = "btn_new_token tooltip_hover" title = "Create new token from SQL Queries, Web Services, files on local disk or FTP Servers and more.">New Token</div></li>
        <li><div style = "padding: 4px 4px 4px 22px;" onclick = "editScript(-1, null, null, null, null, null, 0, null, null);" class = "btn_new_script tooltip_hover" title = "Create a Razor or Spark script which allows creating advanced templates with loops and conditions.">New Script</div></li>
        <li><div style = "padding: 4px 4px 4px 22px;" onclick = "showImportTokens();" class = "btn_import_export tooltip_hover" title = "Import/Export custom token definitions.">Import</div></li>
        <li><div style = "padding: 4px 4px 4px 22px;" onclick = "showExportTokens();" class = "btn_import_export tooltip_hover" title = "Backup/Restore custom token definitions.">Export</div></li>
	    <li id = "tbarToggleTest"><div style = "padding: 4px 4px 4px 22px;" class = "btn_test_token tooltip_hover" title = "Test tokens with this tool to make sure they act as expected.">Test</div></li>
        <%--<li><div style = "padding: 4px 4px 4px 22px;" onclick = "jQuery('#dlgServers').dialog('open');" class = "btn_servers tooltip_hover" title = "Manage Database, HTTP, FTP, Mail Servers used by tokens.">Servers</div></li>--%>
	    <%--<li><div style = "padding: 4px 4px 4px 22px;" onclick = "avt.mt.studio.clear_cache_all();" class = "btn_clear_cache tooltip_hover" title = "MyTokens runs two levels of cache, one that's internal and minimizes database access when reading token definitions and the second is user defined per token. Click this button to have everything cleared from cache to ensure all data is up to date.">Clear Cache</div></li>--%>
        <%--<li runat="server" id = "pnlBtnPatchCore"><div style = "padding: 4px 4px 4px 22px;" onclick = "avt.mt.studio.showCorePatchInfo();" class = "btn_patch_core tooltip_hover" title = "Use this function to patch DotNetNuke Core making My Tokens available in all places that support tokens. Otherwise, My Tokens is only avilable in modules that have been integrated with.">Patch Core</div></li>
        <li runat="server" id = "pnlBtnPatchCoreUndo"><div style = "padding: 4px 4px 4px 22px; color: #cc0000; font-weight: bold;" onclick = "avt.mt.studio.showCorePatchUndo();" class = "btn_patch_core tooltip_hover" title = "Use this function to patch DotNetNuke Core making My Tokens available in all places that support tokens. Otherwise, My Tokens is only avilable in modules that have been integrated with.">Undo Core Patch</div></li>--%>
	    <li><div style = "padding: 4px 4px 4px 22px;" onclick = "avt.mt.studio.showExternalApi();" class = "btn_test_token tooltip_hover" title = "Besides integrations API, MyTokens also exposes an Web API that external components (for example desktop apps or other websites) can invoke to retrieve token values.">External API</div></li>
	    <li><div style = "padding: 4px 4px 4px 22px;" onclick = "window.location = '<%= HttpRuntime.AppDomainAppVirtualPath%>';" class = "btn_return"> Return</div></li>

        <li style = "float: right;"><a class="blue btn_help" href="http://www.dnnsharp.com/support#opturl=%2Fmy-tokens" style="display: block; padding: 4px 4px 4px 22px;">Forums</a></li>
        <li style = "float: right;"><a class="blue btn_help" href="<%= avt.MyTokens.MyTokensController.DocSrv%>" style="display: block; padding: 4px 4px 4px 22px;">Documentation</a></li>
        
        <li style = "float: right;" runat = "server" id = "btnActivate"><a runat="server" id ="lnkActivate" href="" style = " padding: 4px 4px 4px 22px; display: block; " class = "blue btn_activate">Activate</a></li>
        <li style = "float: right;" runat = "server" id = "btnBuy"><a class="blue btn_buy" href="<%= avt.MyTokens.MyTokensController.BuyLink%>" style="display: block; padding: 4px 4px 4px 22px;">Buy</a></li>

	</ul>
</div>


<div class="ui-layout-south" style = "">
	<div class="header" style = "text-align: left; padding: 3px; font-size: 12px;" >Test Tokens</div>
	<div style = "font-size: 12px; padding: 8px;">
	    <div style = "float: left;">
	        <b>Input your text with tokens below</b><br />
            <textarea id = "testTokensInput" style = "width: 400px; height: 100px"></textarea>
	    </div>
	    <div style = "float: left; margin-left: 20px; margin-top: 20px;">
            <a href = "javascript: avt.mt.studio.replaceTokensTest();">Replace <img src = "<%=TemplateSourceDirectory%>/res/rt.gif" border = "0"></a><br />
            <a href = "javascript: avt.mt.studio.replaceTokensTest(true);">Replace (without parsing)<img src = "<%=TemplateSourceDirectory%>/res/rt.gif" border = "0"></a>
	    </div>
	    <div style = " float: left; margin-left: 20px;">
		    <b>See text with replaced tokens below</b> (errors are visible only to admins)<br />
		    <div id = "testTokensResult" style = "width: 400px; height: 100px; border: 1px solid #929292; overflow: auto;"></div>
            <a href = "javascript: avt.mt.studio.testTokenAsHtml();">See as HTML</a>
	    </div>
	    <div style = "clear: both;"></div>
	</div>
</div>


<div id="mainContent" style = "overflow: hidden;">

    <div class="ui-layout-center">
        <div class="ui-layout-content">
            <div id = "tknTabs" style = "font-size: 13px;">
                <ul>
                    <li><a href="#tabs-tkn-info">Start Page</a><a class="lnkTabClose" onclick="avt.mt.wnd.close('tabs-tkn-info');" href="javascript: ;">x</a></li>
                </ul>
                
                <div id="tabs-tkn-info" style = "">
                    <div class = "main_auto_scroll" style = "overflow: auto;">
                        
                        <avt:StartPage ID="myTokStartPage" runat = "server" />

                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

    

<avt:TknNs ID="TknNs" runat = "server" />
<avt:TknWiz ID="tknWiz" runat = "server" />
<avt:ScriptEditor ID="scriptEditor" runat = "server" />
<avt:ExternalApi ID="tknExternalApi" runat = "server" />
<avt:ManageServers ID="myTokServers" runat = "server" />
<avt:Setup ID="myTokSetup" runat = "server" />
<avt:ImportExport ID="myImportExport" runat = "server" />


</form> 

</body>
</html>