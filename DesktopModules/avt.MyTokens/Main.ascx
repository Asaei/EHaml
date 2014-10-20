<%@ Control Language="C#" AutoEventWireup="true" Inherits="avt.MyTokens.Main" EnableViewState = "true" CodeBehind="Main.ascx.cs" %>

<div runat = "server" id = "pnlMng" style="background-color: White; padding: 10px; width: 500px; border: 1px solid #3E81B5;">

    <div style ="float: left;">
        <a href="http://www.dnnsharp.com/dotnetnuke/modules/token-replacement/my-tokens.aspx" title="My Tokens Homepage">
            <img src="<%= TemplateSourceDirectory %>/res/MyTokens_logo.png" border="0" />
        </a>
    </div>

    <div style = "float: left; width: 360px; margin:4px 10px;">
        <div style="color: #3E81B5; font-weight: bold; font-size:13px;">Admin button successfully created!</div>
        <div style="margin: 4px 0 16px 0; font-size:12px; color: #424242; font-weight: normal;">
            It's now recommended that you remove this module.<br />
        </div>

        <div style = "float: right; margin-top: 6px;"><a href = "<%= TemplateSourceDirectory %>/MyTokensStudio.aspx?portalid=<%=PortalId %>">Go to MyTokens Studio &gt;</a></div>
        <div class = "mytkn_info_section"><img src = "<%=TemplateSourceDirectory %>/res/help_small.jpg" /> Manage</div>
        <div style = "clear: both;"></div>
        <div style="color: #525252;">
            Administration of tokens is made from MyTokens Studio.
        </div>
    </div>

    <div style="clear: both;"></div>
</div>

