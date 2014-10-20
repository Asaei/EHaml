<%@ Control Language="C#" AutoEventWireup="true" Inherits="avt.MyTokens.ScriptEditor" CodeBehind="ScriptEditor.ascx.cs" %>

<div id = "tplScriptEditor" class = "tplScriptEditor" style = "display: none;">
    <div runat="server" id="pnlScriptsNotSupported">
        Razor and Spark scripts are only supported by the .NET 4.0 build.
        <br /><br />
        To enable them, use DNN 5.4 and set the .NET framework to 4.0. 
        <br />
        Also, get the .NET4.0 special build from <a href="http://www.dnnsharp.com/dotnetnuke/modules/token-replacement/my-tokens/download.aspx">our Downloads Section.</a>
    </div>
    <div runat="server" id="pnlScriptEditor">
        <span style="display: none;" class="scriptId"></span>

        <div class = "wizTextInputLabel " style = "font-weight: bold;">Name</div>
        <span style = "font-weight: bold;">
        [ 
            <select name = "scriptEditor_ddNamespace" class = "tooltip_hover " style = "width: 160px;" title = "Select a namespace under which to place this script.">
            </select>
        : 
            <input type = "text" name = "scriptEditor_tbScriptName" class = "tooltip_focus wizTextInputSmall gray_text" title= "The name is used to access this token script from other modules. It must not contain spaces. It also has to be unique." /> 
        ]
        </span>
        <asp:Image runat="server" ImageUrl="~/images/required.gif" style = "margin-left: 3px;"/><br />
        <span class = "err scriptEditor_errScriptName" style = "margin-left: 160px;">&raquo; Template name is required!</span>
        <br />
        
        <div class = "wizTextInputLabel " style = "">Description</div> 
        <textarea  name = "scriptEditor_tbDesc" class = "tooltip_focus wizTextInputLarge gray_text" style = "height: 40px;" title = "Optionally, provide a descriptive text for this token script."></textarea>
        <br /><br />

        <div class = "wizTextInputLabel " style = "">Cache Time</div> 
        <input type = "text" name = "scriptEditor_tbCacheTime" class = "tooltip_focus wizTextInputSmall gray_text" style = "width: 80px;" title = "Time in seconds to keep this token cached. Caching helps improve performance as it saves roundtrips to database or external files for xml tokens. Set to 0 to disable caching."/>
        Layer 
        <select name="scriptEditor_ddCacheLayer">
            <option value="global">Global (Per Host)</option>
            <option value="portal">Per Portal</option>
            <option value="role">Per Role</option>
            <option value="user">Per User</option>
            <option value="usersession">Per User Session</option>
        </select>
        <br />
        <div class = "grayed_desc" style = "margin-left: 130px">
            If cache is needed, make sure the cache layer matches the token specification (for example, if you use [Portal:PortalId] token in the definition then set the cache layer to Per Portal).
        </div>
        <div style = "clear: both;"></div>
        
        <div class = "wizTextInputLabel " style = "">Template Engine</div> 
        <select name = "scriptEditor_ddEngine" class = "tooltip_hover gray_text" style = "width: 120px;" title = "Select a template engine to use.">
            <option value = "razor">Razor</option>
            <option value = "spark">Spark</option>
        </select>
        <span class = "grayed_desc">
            Read syntax for <a href='http://www.asp.net/webmatrix/tutorials/2-introduction-to-asp-net-web-programming-using-the-razor-syntax'>Razor</a> and <a href='http://sparkviewengine.com/documentation/syntax'>Spark</a>
        </span>
        <br /><br />

        <div class="pnl_scriptEditor_ddEngineLang">
            <div class = "wizTextInputLabel " style = "">Code Language</div> 
            <select name = "scriptEditor_ddEngineLang" class = "tooltip_hover gray_text" style = "width: 120px;" title = "Choose your preferred syntax for writing Razor templates.">
                <option value = "csharp">C#</option>
                <option value = "vbnet">VB.NET</option>
            </select>
            <br /><br />
        </div>

        <div class = "wizTextInputLabel " style = "font-weight: bold;">Additional Assemblies</div>
        <textarea name = "scriptEditor_tbAssemblies" class = "tooltip_focus wizTextInputXLarge gray_text" style = "height: 60px;" title = "My Tokens will references the specified assemblies so you can use them in the script. Input one assembly per line, for example System.Web.Services.dll. If the assembly is locate in bin folder, use following syntax ~/bin/Your.Assembly.dll."></textarea><br />

        <div class = "wizTextInputLabel " style = "font-weight: bold;">Script Body</div>
        <textarea name = "scriptEditor_tbScriptBody" class = "tooltip_focus wizTextInputXLarge gray_text" style = "height: 130px;" title = "My Tokens will compile the script using the engine you've selected. Notice that the script can call to other tokens by using the syntax [Namespace:TokenName]."></textarea><br />
        <span class = "err scriptEditor_errScript" style = "margin-left: 160px;">&raquo; Template body is Required!</span>
        
        <div class = "grayed_desc" style = "margin-left: 130px">
            Can call to other other tokens/scripts using [Source:TokenName] syntax...
        </div>
    
        <div style="height: 40px; overflow: hidden;">
            <div class = "TknNsSaving" style="color: #E17009; margin: 16px 0 0 0;">
                <blink>Saving... Please Wait...</blink>
            </div>
        </div>
    </div>

</div>


<script type="text/javascript">

    var g_dlgScriptOffset = 0;

    $(document).ready(function () {
        
    });

    function editScript(id, namespace, name, desc, engine, engineLang, cacheTime, cacheLayer, scriptBody, assemblies) {
        var _tpl = $("#tplScriptEditor").clone().removeAttr("id");
        avt.mt.studio.initAllTooltips(_tpl);

        // populate namespaces
        
        var _ddNs = _tpl.find("[name='scriptEditor_ddNamespace']");
        _ddNs.addClass("ddNsSync");

        _ddNs.change(function (e) {
            if ($(this).val() == "-1") {
                avt.mt.studio.newNamespace(this);
                $(this).find(".lastSel").attr("selected", "selected");
            } else {
                $(this).find(".lastSel").removeClass("lastSel");
                $(this).find(":selected").addClass("lastSel");
            }
        });

        avt.mt.studio.initAllTooltips(_tpl);

        _tpl.dialog({
            bgiframe: false,
            autoOpen: true,
            title: id == -1 ? "New Template/Script" : "Edit Template " + name,
            width: 600,
            modal: false,
            resizable: false,
            closeOnEscape: true,

            close: function (event, ui) {
                $(this).dialog("destroy").remove();
            },

            buttons: {
                'Save': function () {

                    var _this = $(this);
                    _this.find(".err").hide();

                    var TknNsId = parseInt(_this.find("[name='scriptEditor_ddNamespace']").val());

                    // validate name not empty
                    if ($.trim(_this.find("[name='scriptEditor_tbScriptName']").val()).length == 0 || isNaN(TknNsId) || TknNsId <= 0) {
                        _this.find(".scriptEditor_errScriptName").show();
                        _this.find("[name='scriptEditor_tbScriptName']").focus();
                        return;
                    }

                    // validate script not empty
                    if ($.trim(_this.find("[name='scriptEditor_tbScriptBody']").val()).length == 0) {
                        _this.find(".scriptEditor_errScript").show();
                        _this.find("[name='scriptEditor_tbScriptBody']").focus();
                        return;
                    }

                    // show loading caption
                    _this.find(".TknNsSaving").fadeIn();

                    // hide buttons
                    _this.parent(".ui-dialog:first").find(".ui-dialog-buttonpane").hide();

                    avt.mt.studio.loading(true);

                    var templateId = _this.find(".scriptId").text();
                    jQuery.post(avt.mt.apiUrl, {
                        format: "json",
                        fn: "save_token",
                        id: templateId,
                        nsId: TknNsId,
                        name: _this.find("[name='scriptEditor_tbScriptName']").val(),
                        desc: _this.find("[name='scriptEditor_tbDesc']").val(),
                        cache: _this.find("[name='scriptEditor_tbCacheTime']").val(),
                        cacheLayer: _this.find("[name='scriptEditor_ddCacheLayer']").val(),
                        defVal: "",
                        src: "<src><type>" + _this.find("[name='scriptEditor_ddEngine']").val() + "</type><lang>" + _this.find("[name='scriptEditor_ddEngineLang']").val() + "</lang><script>" + avt_encodeXml(_this.find("[name='scriptEditor_tbScriptBody']").val()) + "<" + "/script><assemblies>" + avt_encodeXml(_this.find("[name='scriptEditor_tbAssemblies']").val()) + "</assemblies></src>",
                        parser: "",
                        serverId: -1
                    },
                    function (data) {

                        avt.mt.studio.loading(false);

                        var id;
                        if (data.error) {
                            jQuery.jGrowl("Failed to create token (internal error: " + data.error + ")", { header: 'Error', life: 5000 });
                            _this.parent(".ui-dialog:first").find(".ui-dialog-buttonpane").slideDown();
                            _this.find(".TknNsSaving").fadeOut();
                            return;
                        }

                        if (templateId <= 0) {
                            jQuery.jGrowl("Template succesfully created!", { header: 'Success', life: 5000 });
                        } else {
                            jQuery.jGrowl("Template succesfully updated!", { header: 'Success', life: 5000 });
                        }

                        var bUpdate = templateId > 0;

                        // update local token source
                        var _tknNs = avt.mt.studio.getTknNs(TknNsId);
                        if (bUpdate) {
                            for (var j = 0; j < _tknNs.tokens.length; j++) {
                                if (_tknNs.tokens[j].id == data.id) {
                                    _tknNs.tokens[j] = data;
                                    break;
                                }
                            }
                        } else {
                            _tknNs.tokens.push(jQuery.extend(true, {}, data));
                        }

                        // reload token source
                        avt.mt.studio.showTknNs(TknNsId);

                        // reload tree
                        g_tknTree.jstree("refresh");

                        // close dialog
                        _this.dialog('destroy').remove();

                    }, "json");
                },
                'Close': function () {
                    $(this).dialog('destroy').remove();
                }
            }
        });

        // this will fill the namespaces dropdown
        avt.mt.studio.syncNs();
        _ddNs.change();

        // load data
        var _d = _tpl.parents(".ui-dialog:first");

        _d.find(".scriptId").text(id);
        namespace ? _d.find("[name='scriptEditor_ddNamespace']").val(namespace) : _d.find("[name='scriptEditor_ddNamespace'] option:first").attr("selected", "selected");
        name && _d.find("[name='scriptEditor_tbScriptName']").val(name);
        desc && _d.find("[name='scriptEditor_tbDesc']").val(desc);
        cacheTime && _d.find("[name='scriptEditor_tbCacheTime']").val(cacheTime);
        cacheLayer && _d.find("[name=scriptEditor_ddCacheLayer]").val(cacheLayer);
        engine && _d.find("[name='scriptEditor_ddEngine']").val(engine);
        engineLang && _d.find("[name='scriptEditor_ddEngineLang']").val(engineLang);
        scriptBody && _d.find("[name='scriptEditor_tbScriptBody']").val(scriptBody);
        assemblies && _d.find("[name='scriptEditor_tbAssemblies']").val(assemblies);

        _d.css({ "left": _d.position().left + g_dlgScriptOffset, "top": Math.max(0, _d.position().top + g_dlgScriptOffset) });

        g_dlgScriptOffset += 20;
        if (g_dlgScriptOffset > 40)
            g_dlgScriptOffset = -40;

        _tpl.find("[name=scriptEditor_ddEngine]").change(function () {
            $(".pnl_scriptEditor_ddEngineLang").toggle($(this).val() == "razor");
        }).change();
    }

</script>


