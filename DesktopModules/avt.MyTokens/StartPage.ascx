<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StartPage.ascx.cs" Inherits="avt.MyTokens.StartPage" %>

<div class = "start_page" style = "">
     
    <div style = "float: right; background-color: #fafafa; border: 1px solid #dfdfdf; padding: 12px 5px 0px 8px; margin: 0px 12px 12px 12px; width: 40%;">

        <img border="0" src="<%=TemplateSourceDirectory %>/res/icon_whatsnew_16px.gif" class="pngFix" border="0" align="absmiddle" style="margin-bottom: 3px; margin-right: 1px;" />
        <span style = "font-weight: bold; color: #5a5129;"><b>What's New in <%= avt.MyTokens.MyTokensController.Version %></b></span> 
        <br /><br />
        <ul style="font-size: 12px; color: #424242;"><li style="margin: 5px;">added SetSession, SetCookie and SetProfile tokens</li><li style="margin: 5px;">added AppSettings:* tokens</li><li style="margin: 5px;">implemented new caching strategy: per user server session</li><li style="margin: 5px;">implemented [User:Password] token and an option to turn this on/off from settings</li><li style="margin: 5px;">added User:Avatar and User:AvatarUrl tokens</li><li style="margin: 5px;">ability to iterated db tokens programatically from razor scripts</li><li style="margin: 5px;">Allow underscore in token names and item keys</li><li style="margin: 5px;">Allow dynamic parameters to be passed to Razor scripts, accessed through tknparams object</li><li style="margin: 5px;">Fixed NavigateUrl tokens to work with DNN tab localization</li><li style="margin: 5px;">Fixed [Profile:Photo] token for core patch (in profile view)</li><li style="margin: 5px;">Fixed replacing subtokens in objects from scripts</li><li style="margin: 5px;">Fixed writing logs to network locations and added check for write permissions</li><li style="margin: 5px;">Fixed dnn 7 compatibility issue with security exception</li><li style="margin: 5px;">Implemented new ExecToken2 interface that also receives a token replacer and the TknParams dictionary</li><li style="margin: 5px;">Added Url:Relative token to return relative URL of current page</li><li style="margin: 5px;">Fixed HasRole token when role name was a number interpreted as role ID</li><li style="margin: 5px;">Log the generated source code when there are errors from compiling razor scripts</li></ul>
        
        <a class="blue" href = "http://www.dnnsharp.com/Download/tabid/63/ctl/Changelog/mid/752/product/MYTOK/Default.aspx">Read full changelog...</a>
        <br />
        <br />
        <br />
        <br />
    </div>
    
    <div style = "margin: 6px;">
    
        <img border="0" src="<%=TemplateSourceDirectory %>/res/MyTokens_logo.png" class="pngFix" border="0" align="absmiddle" style="margin-right: 25px; margin-top: 15px;"/>
        <span style = "font-size: 20px; color: #528764; font-family: Arial; "> <b>Getting Started</b></span><br /><br />
        <span style = "font-size: 12px; color: #515151; font-family: Verdana;">
        MyTokens Studio offers information about predefined tokens and allows building
        user defined tokens against strings, databases or HTTP Request.
        <br /><br />
       
        <img border="0" src="<%=TemplateSourceDirectory %>/res/arrow.png" class="pngFix" border="0" align="absmiddle" />
         <b>To view information about existing tokens</b>, navigate tree in the left pane and click/hover each item for more information.
        <br /><br />
        
        <img border="0" src="<%=TemplateSourceDirectory %>/res/arrow.png" class="pngFix" border="0" align="absmiddle" />
        <b>To create custom tokens</b>, click <i>New Token</i> button on the toolbar. 
        You will be prompted to also create a Token Namespace if you don't already have one.
        Namespaces are used for grouping tokens by arbitrary criteria. They are also used in token markup, which has the form <span style = " color: #528764">[Namespace:TokenName]</span>.
        <br /><br />

        <img border="0" src="<%=TemplateSourceDirectory %>/res/arrow.png" class="pngFix" border="0" align="absmiddle" />
        <b>To create a Razor or Spark script</b>, click <i>New Script</i> button on the toolbar. 
        Scripts allow for advanced syntax with conditions and loops and also provide access to .NET framework.
        <br /><br />
        
        <img border="0" src="<%=TemplateSourceDirectory %>/res/arrow.png" class="pngFix" border="0" align="absmiddle" />
        <b>To test the newly created token</b>, either use the <i>Test Tokens</i> button from the toolbar 
        or open the namespace that contains it and click on token names.
        </span>
    </div>

    <div style="margin-top: 50px;">Current user IP is <%= avt.MyTokens.MyTokensController.GetUserIp() %></div>
    
    <div style = "clear: both;"></div>
</div>
