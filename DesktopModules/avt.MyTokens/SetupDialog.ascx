<%@ Control Language="C#" AutoEventWireup="true" Inherits="avt.MyTokens.SetupDialog" CodeBehind="SetupDialog.ascx.cs" %>


<div id = "dlgSetup" class = "dlgSetup" style = "display: none;">
    <div style = "height: 320px; overflow:auto; padding: 6px;">

        <div id ="dlgSetupTabs" style="height: 90%; ">
            <ul>
                <li><a href="#setup-tabs-patch">My Tokens Support</a></li>
                <li><a href="#setup-tabs-security">Security</a></li>
                <li><a href="#setup-tabs-logging">Logging</a></li>
                <li><a href="#setup-tabs-cache">Cache</a></li>
                <li><a href="#setup-tabs-servers">Servers</a></li>
                <li><a href="#setup-tabs-nsexc">Exceptions</a></li>
            </ul>

            <div id="setup-tabs-patch">
                <label style="font-weight: bold;">
                    A. Module Patches - <span style="color: #2E6E9E;">enabled</span>
                </label>
                <div class="grayed_desc" style="margin: 8px 0 0 16px;font-style: normal;">
                    My Tokens supports lots of modules including the standard HTML module, Links module or commercial modules such as NavXp, Redirect Toolkit and so on. 
                    <a href="http://www.dnnsharp.com/dotnetnuke/modules/token-replacement/my-tokens.aspx">Read more about supported modules</a>.
                </div>

                <div style="margin: 20px 16px;">
                    If you need My Tokens support in other places where is not supported but you know the standard token replacer to be supported, then use the method below.
                </div>

                <div style="font-weight: bold;">
                    B. DotNetNuke Core Patch - 
                    <span style="color: #2E6E9E;" runat="server" id="pnlCorePathStatusEnabled">enabled</span>
                    <span style="color: #2E6E9E;" runat="server" id="pnlCorePathStatusDisabled">not enabled</span>
                    <button class="jbtn" runat="server" id="pnlBtnPatchCore" onclick = "avt.mt.studio.showCorePatchInfo(); return false;">Enable Now</button>
                <button class="jbtn" runat="server" id="pnlBtnPatchCoreUndo" onclick = "avt.mt.studio.showCorePatchUndo(); return false;">Undo Core Patch</button>
                </div>
                <div class="grayed_desc" style="margin: 0 0 0 16px;font-style: normal;">
                    Use this method to patch DotNetNuke Core making My Tokens available in all places that support standard tokens such as the Admin>Newsletters module or commercial modules that already support the standard token replacement.
                </div>

            </div>

            <div id="setup-tabs-security" style="height: 224px; overflow: auto;">
                <label style="font-weight: bold;">
                    <input type="checkbox" id="setupAllowInlineScriptAccess" <%= avt.MyTokens.Core.GlobalConfiguration.AllowInlineScripts ? "checked=\"checked\"" : "" %> />
                    Allow Inline Script Access
                </label>
                <div class="grayed_desc" style="margin: 20px 0;">
                    This option enables creating Razor or Spark templates on the fly directly inside the content (for example, in the content of HTML modules).
                    <br /><br /> 
                    Encapsulate the scripts in &lt;razor&gt;...&lt;/razor&gt; tags, respectively &lt;spark&gt;...&lt;/spark&gt;
                    <br /><br /> 
                    Note that from the Razor and Spark scripts is possible to also perform update and delete operations, so only enable this option if you have control over who can write content with tokens.
                </div>

                <label style="font-weight: bold;">
                    <input type="checkbox" id="setupAllowPasswordToken" <%= avt.MyTokens.Core.GlobalConfiguration.AllowPasswordToken ? "checked=\"checked\"" : "" %> />
                    Allow [User:Password] token.
                </label>
                <div class="grayed_desc" style="margin: 20px 0;">
                    This option makes it possible to access user password through tokens, for example to include in emails. <br />
                    Be aware that if users can write content that supports tokens on your portal, then they can also use this token if it's enabled.
                </div>

                <label style="font-weight: bold;">
                    <input type="checkbox" id="setupAllowAppSettingsToken" <%= avt.MyTokens.Core.GlobalConfiguration.AllowAppSettingsToken ? "checked=\"checked\"" : "" %> />
                    Allow [AppSettings:*] tokens.
                </label>
                <div class="grayed_desc" style="margin: 20px 0;">
                    This option makes it possible to access app settings from web.config. <br />
                    Be aware that if users can write content that supports tokens on your portal, then they can also use this token to see for example the database connection string.
                </div>

            </div>

            <div id="setup-tabs-logging">
                <label>
                    Log Level
                    <select id="ddSetupLogLevel">
                        <option value="off">Off</option>
                        <option value="errors" <%= avt.MyTokens.Core.GlobalConfiguration.LogLevel == avt.MyTokens.Core.DnnSf.Logging.eLogLevel.Errors ? "selected=\"selected\"" : "" %>>Errors Only</option>
                        <option value="debug" <%= avt.MyTokens.Core.GlobalConfiguration.LogLevel == avt.MyTokens.Core.DnnSf.Logging.eLogLevel.Debug ? "selected=\"selected\"" : "" %>>Debug</option>
                    </select>
                </label>
                <div class="grayed_desc" style="margin: 20px 0;">
                    Use this option to generate debug logs or error logs. They are saved under /Portals/_default/Logs/MyTokens folder.
                </div>

                <label>
                    Limit Debug to IPs<br />
                    <textarea id="tbDebugIps" rows="5"><%= avt.MyTokens.Core.GlobalConfiguration.DebugIps %></textarea>
                </label>
                <div class="grayed_desc" style="margin: 20px 0;">
                    Enable debugging only for a list of IPs. This is especially useful for debugging live systems.
                    Debug mode will always be enabled for these IPs, regardless of the settings above.
                    Input one IP per line. 
                </div>

                <b>Log Files:</b>
                <div style="width: 400px; height: 120px; border: 1px solid #929292; overflow: auto;" id="pnlLogFiles">
                </div>
                <asp:LinkButton runat="server" OnClick="DeleteLogFiles" Text="Delete All"></asp:LinkButton>

            </div>

            <div id="setup-tabs-cache">
                <div class="grayed_desc" style="margin: 20px 0;">
                    MyTokens runs two levels of cache, one that's internal and minimizes database access when reading token definitions and the second is user defined per token. 
                    Click button below to have everything cleared from cache to ensure all data is up to date.
                </div>
                <button class="jbtn" onclick="avt.mt.studio.clear_cache_all();return false;">Clear Cache</button>

            </div>

            <div id="setup-tabs-servers">
                <div class="grayed_desc" style="margin: 20px 0;">
                    Manage servers used by tokens.
                </div>
                <button class="jbtn" onclick="jQuery('#dlgServers').dialog('open'); return false;">Open Servers...</button>
            </div>

            <div id="setup-tabs-nsexc">
                <label>
                    Skip Token Replacement for following namespaces:
                    <textarea id="tbIgnoreNamespaces" rows="5" style="width: 320px"></textarea>
                </label><br />
                <div class="grayed_desc" style="margin: 20px 0;">
                    Use this to instruct My Tokens to bypass evaluating tokens that would get replaced later by other components.<br />
                    Input one entry per line.
                </div>

            </div>

        </div>

        <div style="height: 20px; overflow: hidden; text-align:right;">
            <div class = "configSaving" style="color: #E17009; margin: 0px 0 0 0; display: none;">
                <blink>Saving... Please Wait...</blink>
            </div>
        </div>

    </div>
</div>


<div runat = "server" id = "pnlDlgPatch">
<div id ="dlgCorePatch" style="padding: 20px; display: none;">

    <div class="content">
        <div style="color: #E17009; font-weight: bold; font-size: 13px;">
            Optionally patch DotNetNuke core to extend My Tokens support to all places where tokens are supported.
        </div>

        <div style="color: #2E6E9E; font-weight:  bold; font-size: 14px; margin: 16px 0 10px 0;">
            How does it work?
        </div>

        My Tokens only works with modules that have been already integrated with 
        (see <a class="blue" href = "http://www.dnnsharp.com/dotnetnuke/modules/token-replacement/my-tokens.aspx">My Tokens page</a> for a list of supported standard and commercial modules).
        Patching the core will remove this limitation by replacing DotNetNuke.dll with another file we precompiled to fully support My Tokens.

        <div style="color: #2E6E9E; font-weight:  bold; font-size: 14px; margin: 16px 0 10px 0;">
            Benefits of patching the DNN core
        </div>
        Patching the core will make My Tokens available in all places where standard token replacing is supported.
        This includes a large number of standard or commercial modules. Take a look for example at the Newsletters module under Admin.
    
        <div style="color: #2E6E9E; font-weight:  bold; font-size: 14px; margin: 16px 0 10px 0;">
            How to undo the patch
        </div>
        Note that My Tokens will make a backup of your current <u>/bin/DotNetNuke.dll</u> file and put it under <u>/DesktopModules/avt.MyTokens/Backup</u>.
        So if you later need to undo the patch, just copy the backup back to the /bin folder or click the Undo Core Patch button on the toolbar which does the same thing.

        <div style="color: #2E6E9E; font-weight:  bold; font-size: 14px; margin: 16px 0 10px 0;">
            How to apply the patch manually
        </div>
        If for some reason the button below doesn't work, 
        <a class="blue" href="https://github.com/bogdan-litescu/DotNetNuke-Core-My-Tokens-Patch">browse the public repository</a> and download source code. <br />
        Compiled DLLs are available at <a class="blue" href="http://my-tokens.dnnsharp.com/integration/patch-dotnetnuke">my-tokens.avatar-soft.ro/integration/patch-dotnetnuke</a>. <br />
        Contributions are also welcomed.
    </div>

    <div class = "notSuperUser" style="display: none; color: #cc0000; margin: 10px; font-size: 13px; font-weight: bold;">
        Only Super User Accounts can use this function. Login with a Super User account or notify one...
    </div>

    <div class="err" style="display: none; margin: 40px;"></div>

    <div class="patching" style="display: none; text-align: right;">
        <img src="<%= TemplateSourceDirectory %>/res/progressbar.gif" />
    </div>

</div>
</div>


<div runat = "server" id = "pnlDlgPatchUndo">
<div id ="dlgCorePatchUndo" style="padding: 20px; display: none;">

    <div class="content">
        <div style="color: #E17009; font-weight: bold; font-size: 13px;">
            Your DotNetNuke core is patched.
        </div>
        <br /><br />

        Click button below to have My Tokens remove the core patch. After the patch is removed, My Tokens will only work with modules that have been integrated with
        (see <a class="blue" href = "http://www.dnnsharp.com/dotnetnuke/modules/token-replacement/my-tokens.aspx">My Tokens page</a> for a list of supported standard and commercial modules).
        <br /><br />

        To undo the patch manually copy <u>/DesktopModules/avt.MyTokens/Backup/DotNetNuke.dll</u> back to <u>/bin/DotNetNuke.dll</u>.

    </div>

    <div class = "notSuperUser" style="display: none; color: #cc0000; margin: 10px; font-size: 13px; font-weight: bold;">
        Only Super User Accounts can use this function. Login with a Super User account or notify one...
    </div>

    <div class="err" style="display: none; margin: 40px;"></div>

    <div class="patching" style="display: none; text-align: right;">
        <img src="<%= TemplateSourceDirectory %>/res/progressbar.gif" />
    </div>

</div>
</div>


<script type="text/javascript">


    $(document).ready(function () {

        $("#dlgSetup").dialog({
            bgiframe: false,
            autoOpen: false,
            title: "My Tokens Global Configuration",
            width: 700,
            modal: true,
            resizable: false,
            closeOnEscape: true,

            buttons: {
                'Close': function () {
                    $("#dlgSetup").dialog('close');
                },
                'Save': function () {

                    var _this = $(this);

                    // show loading caption
                    _this.find(".configSaving").fadeIn();

                    // hide buttons
                    _this.parent(".ui-dialog:first").find(".ui-dialog-buttonpane").hide();

                    avt.mt.studio.loading(true);
                    jQuery.post(avt.mt.apiUrl, {
                        format: "json",
                        fn: "save_config",
                        enableScriptAccess: $("#setupAllowInlineScriptAccess:checked").size() > 0 ? "true" : "false",
                        allowPasswordToken: $("#setupAllowPasswordToken:checked").size() > 0 ? "true" : "false",
                        setupAllowAppSettingsToken: $("#setupAllowAppSettingsToken:checked").size() > 0 ? "true" : "false",
                        logLevel: $("#ddSetupLogLevel").val(),
                        debugIps: $("#tbDebugIps").val(),
                        ignoreNamespaces: $("#tbIgnoreNamespaces").val() //,
                        //corePatch: _this.find("[name='setupPatchMethod']:checked").val() == "core"
                    },
                        function (data) {

                            avt.mt.studio.loading(false);

                            _this.parent(".ui-dialog:first").find(".ui-dialog-buttonpane").show();
                            _this.find(".configSaving").hide();

                            if (data.error) {
                                jQuery.jGrowl("Failed to save configuration token (internal error: " + data.error + ")", { header: 'Error', life: 5000 });
                                return;
                            }

                            jQuery.jGrowl("Configuration successfully saved!", { header: 'Success', life: 5000 });


                            // close dialog
                            _this.dialog('close');

                        }, "json");
                }
            }
        });

        $("#dlgSetupTabs").tabs();

        // load log files
        jQuery.post(avt.mt.apiUrl, {
            fn: "get_logs"
        },
        function (data) {
            avt.mt.$("#pnlLogFiles").html(data);
        }, "html");
    });

</script>


