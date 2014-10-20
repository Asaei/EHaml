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
                <div class="search-bar">
                    <%--<dnn:SEARCH ID="dnnSearch" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true" Submit="جستجو" CssClass="SearchButton" />--%>
                </div>
                <dnn:CurrentDate runat="server" ID="dnnCURRENTDATE" CssClass="date" />
            </div>
        </div>
        <div class="menu-bar">
            <dnn:MENU ID="MENU1" MenuStyle="eHamlMenu" runat="server"></dnn:MENU>
        </div>
    </div>
    <div class="clear"></div>
    <div class="content-panel1">
        <div class="content-pane" id="ContentPane" runat="server"></div>
    </div>
    <div class="clear"></div>
    <div class="content-panel3 content-pane">
        <div class="left-pane" id="leftPane" runat="server" style="float:right;"></div>
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
            </div>
            <%--<dnn:TERMS ID="dnnTerms" runat="server" CssClass="terms" />--%>
            <%--|--%>
			<%--<dnn:PRIVACY ID="dnnPrivacy" runat="server" CssClass="terms" />--%>
        </div>
    </div>
</div>

<dnn:DnnCssInclude ID="DnnCssInclude1" runat="server" FilePath="plus.css" PathNameAlias="SkinPath" />

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
        })
    });

</script>





