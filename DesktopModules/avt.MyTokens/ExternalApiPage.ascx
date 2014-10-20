<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ExternalApiPage.ascx.cs" Inherits="avt.MyTokens.ExternalApiPage" %>

<div id = "tplExternalApi" class = "main_auto_scroll apiRoot" style = "display: none;">
    <div class = "wizTitle">External API</div>
    <div style = "clear: both;"></div>
    <div class = "grayed_desc">Provides access for external components (such as Desktop Apps or other websites) to connect to this DNN instance and invoke tokens or pass-through with authentication. Read below for more info...</div>
    <br />
    
    <div class = "inputLabel" style = "padding-bottom: 5px;">Syntax</div> 
    <div class ="grayed_desc">
        The External API is accessed through HTTP. The parameters can be send either with GET or POST. The syntax is as follows:<br /><br />
    </div>

    <div style = "font-size: 11px;" class = "blue">
        <strong>Call token replacement:</strong><br />
        <u>http://<%= Request.Url.Host %>/DesktopModules/avt.MyTokens/Api.aspx</u>?<b>portalid</b>=0&amp;<b>apikey</b>=5E20D8B7-D8E0-7440-66EB-69FFD24A435A&amp;<b>token</b>=[User:Userid]&amp;<b>user</b>=myusername&amp;<b>pass</b>=mypassword

        <br /><br />
        <strong>Pass-through authentication with username and password:</strong><br />
        <u>http://<%= Request.Url.Host %>/DesktopModules/avt.MyTokens/Api.aspx</u>?<b>portalid</b>=0&amp;<b>apikey</b>=5E20D8B7-D8E0-7440-66EB-69FFD24A435A&amp;<b>user</b>=myusername&amp;<b>pass</b>=mypassword&amp;<b>returnurl</b>=%2fhome.aspx

        <br /><br />
         <strong>Pass-through authentication with username only:</strong><br />
        Login server to server using followong URL:
        <u>http://<%= Request.Url.Host %>/DesktopModules/avt.MyTokens/Api.aspx</u>?<b>portalid</b>=0&amp;<b>apikey</b>=5E20D8B7-D8E0-7440-66EB-69FFD24A435A&amp;<b>secretKey</b>=FCE0FE86EBC18BF6AABA3B0E2A887AEE3E594D50F37A138E0EB19BAC69CECB3D&amp;<b>user</b>=user001&amp;<b>clientIp</b>=123.123.123.123&amp;<b>fwdUrl</b>=%2fgettingstarted.aspx
        <br />
        Then, simply redirect the client browser to the URL returned by the HTTP request above.

     </div>
    
    <br />
    <div class ="grayed_desc">
         <img class="pngFix"  src= "<%= TemplateSourceDirectory %>/res/ico_contact_64.png" style = "  margin-right: 5px;" border = "0" align="absmiddle" />Note that the <span style = "font-size: 11px; color: #ad5f3d;">user</span> and <span style = "font-size: 11px; color: #ad5f3d;">pass</span> parameters are relevant only when Authentication/Impersonation is set to  <span style = "font-size: 11px; color: #ad5f3d;">Impersonate Based on Credentials</span>.
    </div>
    <br />
    
    <a href = "http://my-tokens.dnnsharp.com/integration/api-building-web-services" class = "blue">
        Read More about External Api on our Documentation Server...
    </a>
    <br /><br />
    
    <div runat = "server" id = "pnlEditApiSettings">
        <div runat = "server" id = "pnlConfScope">
            <div class = "inputLabel"style = "padding-bottom: 5px;">Configuration Scope</div> 
            <select class = "tooltip_hover wizTextInputLarge gray_text apiSettingsScope" title= "External API can be configured the same for all portals (Global) or different for each portal. If set to Global, only SuperUser Accounts will be able to change External API Configuration.">
                <option value = "portal">Per Portal</option>
                <option value = "global">Global (All Portals)</option>
            </select><br />
            <div class = "grayed_desc">
                Only SuperUser Accounts can modify this setting.
            </div>
        </div>
        <br />
        

        <div class = "inputLabel" style = "padding-bottom: 5px;">IP Filtering</div> 
        <select class = "tooltip_hover wizTextInputLarge gray_text apiFilterIPs" title= "As an additional layer of security, incoming requests to the External API can also be filtered by client IP Addresses. This is especially useful when the API is used privately to interconnect a limited number of known systems. IP Filtering specified here can be overriden for each API Key." onchange = "avt_changeIPFiltering(this);">
            <option value = "allowAll">Unrestricted (Allow All)</option>
            <option value = "denyAll">Deny All (grant access per API Key)</option>
            <option value = "list">Grant Access to list...</option>
        </select><br />
        <div class = "grayed_desc apiFilterOpt apiFilterAllowAll">
            Unrestricted access allows any computer to connect to the API.
        </div>
        <div class = "grayed_desc apiFilterOpt apiFilterDenyAll">
            Access is denied by default for all computers. <br />
            Usually it means that access is granted manually for each API Key.
        </div>
        <div class = "grayed_desc apiFilterOpt apiFilterList">
            Grant access only to IPs in list below (input one IP per line).<br />
            <textarea class = "wizTextInputLarge apiFilterListIPs" rows = "4"></textarea>
            <div class = "grayed_desc">
                Also accepts wild characters, for example 192.168.*.*
            </div>
            <div class = "wizerror errEmptyIPs">
                Please provide IP Address(es).
            </div>
        </div>
        <br />
        
        <br />
        <div class = "btnBar">
            <a href = "javascript: ;" onclick = "avt.mt.studio.saveApiSettings(avt.mt.$(this).parents('.apiRoot:first'));" class = "blue save_icon">Save&amp;Close</a>
            <a href = "javascript: ;" onclick = "avt.mt.wnd.close(avt.mt.$(this).parents('.apiRoot:first').attr('id')); avt.mt.$('#tplIssueNewKey').dialog('close');"  class = "blue cancel_icon">Cancel</a>
        </div>
        <div class = "apiSaving">
            Saving... Please wait...
        </div>
        <br /><br /><br />
        
        
        <div class = "inputLabel" style = "padding-bottom: 5px;">External API Access Keys</div> 
        <div class = "apiKeysLoading" style = "margin: 20px;">Loading API Keys...</div>
        <div class = "cApiKeys"></div><br/>
        <a href = "javascript: ;" onclick = "issueNewApiKey()" class = "blue key_icon" style = "padding-top: 7px;">Issue New API Key</a>
        <br />
        
        
        <br /><br />
    
    </div> <%--pnlEditApiSettings--%>
  
  
    <div runat = "server" id = "pnlNoApiSettingsAccess" style = "color: #EE5555;">
        Api Access is configured to be the same for all portals, therefore only SuperUser accounts can edit them.
    </div>


</div>


<div id = "tplApiKey" class = "apiKeyRoot">

    <a href = "javascript: ;" onclick = "editApiKey(avt.mt.$(this).parents('.apiKeyRoot:first'));"><img src = "<%= TemplateSourceDirectory %>/res/edit.gif" border = "0" style = "margin-top: 5px;" /></a>
    <a href = "javascript: ;" onclick = "deleteApiKey(avt.mt.$(this).parents('.apiKeyRoot:first'));"><img src = "<%= TemplateSourceDirectory %>/res/delete.gif" border = "0" style = "margin-top: 5px;" /></a>
    <span class = "apiKey" style = " font-family: Courier New, monospace; font-weight: normal; font-size: 12px; color: #ad5f3d;"></span>
    <i>
        (<span class = "apiImpers"></span>, <span class = "apiFiltering"></span>)
        <div class = "grayed_desc apiDesc" style = "margin-left: 40px;"></div>
    </i>
</div>


<div style = "font-size: 12px; display: none;" id = "tplIssueNewKey">
    
    <div style = "margin: 20px; height: 310px; overflow: auto;">
        
        <div class = "wizTextInputLabel ">API Key</div> 
        <input type = "text" class = "wizTextInputLarge gray_text apiKey wizInputDisabled"  readonly = "readonly" />
        <div class = "grayed_desc" style = "margin-left: 130px;">
            API Key authenticates client apps making requests.
        </div>
        <br />
        
        <div class = "wizTextInputLabel " style = "">Caption</div> 
        <input type = "text" class = "wizTextInputLarge gray_text apiDesc" style = "" />
        <div class = "grayed_desc" style = "margin-left: 130px;">
            Optionally, provide a short description to identify this API Key.
        </div>
        <br />
        
        <div class = "wizTextInputLabel" style = "">Impersonation</div> 
        <select class = "tooltip_hover wizTextInputLarge gray_text apiImpersonation" title= "The Impersonation allows client apps to access tokens as if they were an user on your portal. " onchange = "avt_changeApiImpersonation(this);">
            <option value = "disabled">Don't Allow Impersonation</option>
            <option value = "login">Impersonate based on credentials</option>
            <option value = "user">Impersonate user...</option>
            <option value = "passthru">Pass Through Authentication</option>
        </select><br />
        <div class = "grayed_desc apiImpersOpt apiImpersonationNone">
            No Impersonation means tokens will accessed as unauthenticated users.
        </div>
        <div class = "grayed_desc apiImpersOpt apiImpersonationLogin">
            Login Impersonation allows client apps to provide username and password when 
            making API Requests; tokens will be accessed in the context of authenticated user
        </div>
        <div class = "apiImpersonationUser apiImpersOpt">
            <div class = "grayed_desc">
                Impersonate user means tokens will always be accessed under user account
                provided below.
            </div>
            <span class = "inputLabel">Username:</span> <input type = "text" class = "wizTextInputSmall apiImpersonationUsername" />
            <div class = "wizerror errEmptyUsername">
                Please provide username.
            </div>
        </div>
        <div class = "apiImpersonationPassThru apiImpersOpt">
            <div class = "grayed_desc">
                This method allows an unauthenticated user to arrive on the site with a secured URL, which logins the user then redirects to another URL.
            </div>
             <br />
            <span class = "inputLabel">Secret Key:</span><br />
            <textarea class = "wizTextInputLarge apiImpersonationPassThruKey" rows="4"></textarea>
            <div class = "wizerror errEmptyPassThruKey">
                Please provide a key.
            </div>
        </div>
        <br />
        
        <div class = "wizTextInputLabel" style = "">IP Filtering</div> 
        <select class = "tooltip_hover wizTextInputLarge gray_text apiKeyFilterIPs" title= "As an additional layer of security, incoming requests to the External API using this API Key can also be filtered by client IP Addresses. Note that if specified, IP Filtering per API Key overrides IP Filtering specified in portal/global API Settings." onchange = "avt_changeKeyIPFiltering(this)">
            <option value = "inherit">Inherit</option>
            <option value = "allowAll">Unrestricted (Allow All)</option>
            <option value = "list">Grant Access to list...</option>
        </select><br />
        <div class = "grayed_desc apiKeyFilterOpt apiKeyFilterInherit">
            The IP Filtering for this API Key will use the rules specified in portal/global API Settings.
        </div>
        <div class = "grayed_desc apiKeyFilterOpt apiKeyFilterAllowAll">
            Unrestricted access allows any computer using this API Key to connect to the API.
        </div>
        <div class = "grayed_desc apiKeyFilterOpt apiKeyFilterList">
            Grant access only to IPs in list below (input one IP per line).<br />
            <textarea class = "wizTextInputLarge apiKeyFilterListIPs" rows = "4"></textarea>
            <div class = "grayed_desc">
                Also accepts wild characters, for example 192.168.*.*
            </div>
            <div class = "wizerror errEmptyKeyIPs">
                Please provide IP Address(es).
            </div>
        </div>
    </div>
    
    <div class = "apiKeySaving inputLabel">
        Saving... Please wait...
    </div>
    
</div>


<script type = "text/javascript">

    function issueNewApiKey() {
        var _dlg = avt.mt.$("#tplIssueNewKey");

        if (_dlg.filter(":visible").length > 0) {
            return;
        }

        _dlg.find(".apiKey").val(avt_guid().toUpperCase());
        _dlg.find(".apiDesc").val("");
        _dlg.find(".apiImpersonation").val("disabled");
        _dlg.find(".apiImpersonationUsername").val("");
        _dlg.find(".apiImpersonationPassThruKey").val(avt_key(16).toUpperCase());
        
        _dlg.find(".apiKeyFilterIPs").val("inherit");
        _dlg.find(".apiKeyFilterListIPs").val("");

        _dlg.find(".apiKeyFilterIPs").change();
        _dlg.find(".apiImpersonation").change();
        
        _dlg.parents(".ui-dialog:first").find(".ui-dialog-buttonpane").show();
        _dlg.parents(".ui-dialog:first").find(".apiKeySaving").hide();
        
        _dlg.dialog("open");
    }

    function editApiKey(apiKeyRoot) {
        var _dlg = avt.mt.$("#tplIssueNewKey");

        if (_dlg.filter(":visible").length > 0) {
            return;
        }
        
        _dlg.parents(".ui-dialog:first").find(".ui-dialog-buttonpane").show();
        _dlg.parents(".ui-dialog:first").find(".apiKeySaving").hide();

        var _apiKey = avt.mt.studio.getApiKey(apiKeyRoot.find(".apiKey").text().toLowerCase());
        _dlg.find(".apiKey").val(_apiKey.apiKey);
        _dlg.find(".apiDesc").val(_apiKey.caption);
        _dlg.find(".apiImpersonation").val(_apiKey.authMode);
        _dlg.find(".apiImpersonationUsername").val(_apiKey.username);
        _dlg.find(".apiImpersonationPassThruKey").val(_apiKey.secretKey);
        
        switch (_apiKey.filterIPs) {
            case "[inherit]":
                _dlg.find(".apiKeyFilterIPs").val("inherit");
                break;
            case "[allow]":
                _dlg.find(".apiKeyFilterIPs").val("allowAll");
                break;
            default:
                _dlg.find(".apiKeyFilterIPs").val("list");
                _dlg.find(".apiKeyFilterListIPs").val(_apiKey.filterIPs.replace(/;/g, "\n"));
                break;
        }
        _dlg.find(".apiKeyFilterIPs").change();
        _dlg.find(".apiImpersonation").change();

        _dlg.dialog("open");
    }

    function deleteApiKey(apiKeyRoot) {
        var apiKey = apiKeyRoot.find(".apiKey").text();

        if (confirm("Are you sure you want to delete API Key " + apiKey + "?")) {
            avt.mt.$.post(avt.mt.apiUrl, {
                fn: "delete_apiKey",
                apiKey: apiKey,
                format: "json"
            },
                function(data) {
                    if (data.error) {
                        avt.mt.$.jGrowl("Error deleting API Key!<br />Server response: " + data.error, { header: 'Error', life: 5000 });
                    } else {
                        avt.mt.$.jGrowl("API Key Deleted!", { header: 'Success', life: 5000 });
                        // sync
                        avt.mt.$(".apiKey:contains(" + apiKey + ")").parents(".apiKeyRoot:first").remove();
                        if (typeof (avt.mt.apiKeysGlobal) != "undefined") {
                            for (var i = 0; i < avt.mt.apiKeysGlobal.length; i++) {
                                if (avt.mt.apiKeysGlobal[i].apiKey == apiKey) {
                                    avt.mt.apiKeysGlobal.splice(i, 1);
                                    break;
                                }
                            }
                        }
                        if (typeof (avt.mt.apiKeysPortal) != "undefined") {
                            for (var i = 0; i < avt.mt.apiKeysPortal.length; i++) {
                                if (avt.mt.apiKeysPortal[i].apiKey == apiKey) {
                                    avt.mt.apiKeysPortal.splice(i, 1);
                                    break;
                                }
                            }
                        }
                    }
                },
                "json"
            );
        }
    }

    function avt_S4() {
        return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    }
    function avt_guid() {
        return (avt_S4() + avt_S4() + "-" + avt_S4() + "-" + avt_S4() + "-" + avt_S4() + "-" + avt_S4() + avt_S4() + avt_S4());
    }
    function avt_key(groups) {
        var key = ''
        for (var i = 0; i < groups; i++)
            key += avt_S4();
        return key;
    }

    function avt_changeApiImpersonation(_this) {
        var _dlg = avt.mt.$("#tplIssueNewKey");
        _dlg.find(".apiImpersOpt").hide();
        switch (_this.options[_this.selectedIndex].value) {
            case "disabled":
                _dlg.find(".apiImpersonationNone").show();
                break;
            case "login":
                _dlg.find(".apiImpersonationLogin").show();
                break;
            case "user":
                _dlg.find(".apiImpersonationUser").show();
                break;
            case "passthru":
                _dlg.find(".apiImpersonationPassThru").show();
                break;
        }
    }

    function avt_changeKeyIPFiltering(_this) {
        var _dlg = avt.mt.$("#tplIssueNewKey");
        _dlg.find(".apiKeyFilterOpt").hide();
        switch (_this.options[_this.selectedIndex].value) {
            case "inherit":
                _dlg.find(".apiKeyFilterInherit").show();
                break;
            case "allowAll":
                _dlg.find(".apiKeyFilterAllowAll").show();
                break;
            case "list":
                _dlg.find(".apiKeyFilterList").show();
                break;
        }
    }

    function avt_changeIPFiltering(_this) {
        var _root = avt.mt.$(_this).parents(".apiRoot:first");
        _root.find(".apiFilterOpt").hide();
        switch (_this.options[_this.selectedIndex].value) {
            case "allowAll":
                _root.find(".apiFilterAllowAll").show();
                break;
            case "denyAll":
                _root.find(".apiFilterDenyAll").show();
                break;
            case "list":
                _root.find(".apiFilterList").show();
                break;
        }
    }

    avt.mt.$(document).ready(function() {

        // initiate dialog
        avt.mt.$("#tplIssueNewKey").dialog({
            bgiframe: false,
            autoOpen: false,
            title: "Issue New Api Key",
            width: 600,
            modal: false,
            resizable: false,
            buttons: {
                'Save': function() {
                    var _dlg = avt.mt.$(this).parents(".ui-dialog");

                    // save api key
                    avt.mt.studio.saveApiKey(_dlg);
                },
                'Cancel': function() {
                    avt.mt.$("#tplIssueNewKey").dialog('close');
                    //alert("cancel");
                }
            },
            close: function() {
                //avt.nxp.$("#tbNewContactPerson").find(":input").val('').removeClass('ui-state-error');
                //alert("close");
            }

        });


    });

</script>




