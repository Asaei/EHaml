<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="LANGUAGE" Src="~/Admin/Skins/Language.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="BREADCRUMB" Src="~/Admin/Skins/BreadCrumb.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/Admin/Skins/Privacy.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/Admin/Skins/Terms.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LINKTOMOBILE" Src="~/Admin/Skins/LinkToMobileSite.ascx" %>
<%@ Register TagPrefix="dnn" TagName="MENU" Src="~/DesktopModules/DDRMenu/Menu.ascx" %>
<%@ Register TagPrefix="dnn" TagName="CurrentDate" Src="~/Admin/Skins/CurrentDate.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<div class="skin-wrapper">
    <div id="header">
        <div class="top-bar">
            <div class="content-pane">
                <dnn:LOGIN ID="dnnLogin" CssClass="login" runat="server" LegacyMode="true" />
                <dnn:USER ID="dnnUser" runat="server" CssClass="user" LegacyMode="true" />
                <%--<div class="search-bar">
                    <dnn:SEARCH ID="dnnSearch" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true" Submit="جستجو" CssClass="SearchButton" />
                </div>--%>
                <dnn:CurrentDate runat="server" ID="dnnCURRENTDATE" CssClass="date" />
            </div>
        </div>
        <div class="menu-bar">
            <div class="enamad-pane">
                <iframe src="/eNamadLogo.htm" frameborder="0" scrolling="no" allowtransparency="true" style="width: 150px; height:150px;"></iframe>
            </div>
            <dnn:MENU ID="MENU1" MenuStyle="eHamlMenu" runat="server"></dnn:MENU>
        </div>
    </div>
    <div class="clear"></div>
    <div class="banner-bar">
        <div class="banner-pane" id="BannerPane" runat="server">
        </div>
    </div>
    <div class="clear"></div>
    <div class="content-panel1">
        <div class="box-panel">
            <div class="content-pane box-pane">
                <div class="left-box-pane" id="BoxLeftPane" runat="server"></div>
                <div class="center-box-pane" id="BoxCenterPane" runat="server"></div>
                <div class="right-box-pane" id="BoxRightPane" runat="server"></div>
            </div>
        </div>
        <div class="clear"></div>
        <div class="content-pane" id="ContentPane" runat="server"></div>
        <div class="clear"></div>
    </div>
    <div class="clear"></div>
    <div class="content-panel2">
        <div class="content-pane" id="GrayPane" runat="server"></div>
    </div>
    <div class="clear"></div>
    <div class="content-panel3 content-pane">
        <div class="left-pane" id="leftPane" runat="server"></div>
        <div class="right-pane" id="RightPane" runat="server"></div>
    </div>
    <div class="clear"></div>
    <div class="footer-panel">
        <div class="content-pane">
            <div class="left-footer-pane" id="FooterLeftPane" runat="server"></div>
            <div class="center-footer-pane" id="FooterCenterPane" runat="server"></div>
            <div class="right-footer-pane" id="FooterRightPane" runat="server"></div>
        </div>
        <div class="clear"></div>
        <div class="copyright-panel">
            <div class="content-pane">
                <dnn:COPYRIGHT ID="dnnCopyright" runat="server" CssClass="copyright" />
                <a class="terms" href="http://mydnn.ir" >طراحی پورتال : mydnn.ir</a>
            </div>
            <%--<dnn:TERMS ID="dnnTerms" runat="server" CssClass="terms" />--%>
            <%--|--%>
			<%--<dnn:PRIVACY ID="dnnPrivacy" runat="server" CssClass="terms" />--%>
        </div>
    </div>
</div>

<dnn:DnnCssInclude runat="server" FilePath="eHamlMenu/menu.css" PathNameAlias="SkinPath" />

<script type="text/javascript">
    $(document).ready(function () {
        $("ul.menu li").click(function () {
            var id = $(this).attr("id");
            $("div.dynamic-menu").attr("class", "dynamic-menu");
            $("div.dynamic-menu").addClass(id + "Menu");
            $("div.dynamic-menu ul.childmenu").hide();
            $("ul#" + id + "Menu.childmenu").show();

            $("ul.menu li").removeClass("selected");
            $(this).addClass("selected");

            $(".box-content").hide();

            $(".boxfor" + id).show();
        });

        $('html').on('click', function () {
            $(this).parent().find("ul.boxMenu").fadeOut(200);
        });

        $(".boxMenuLink").live("click", function () {
            $(this).parent().find("ul.boxMenu").toggle(200);
        });
    });

</script>

<dnn:DnnJsInclude ID="DnnJsInclude6" runat="server" FilePath="jquery.quovolver.js" PathNameAlias="SkinPath" />
<dnn:DnnCssInclude ID="DnnCssInclude1" runat="server" FilePath="DodgerBlue.css" PathNameAlias="SkinPath" />

<script type="text/ecmascript">
    //For Quovolver Style:
    jQuery(document).ready(function ($) {
        $("#quovolver_style").quovolver({
            children: "li",
            transitionSpeed: 600,
            autoPlay: true,
            autoPlaySpeed: 5000,
            pauseOnHover: true,
            equalHeight: false,
            navPosition: "above",
            navNum: true
        })
    });
</script>
    	
	
	