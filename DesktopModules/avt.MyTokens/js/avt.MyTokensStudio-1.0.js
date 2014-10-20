
if (!avt) { var avt = {}; }

var dnn = {};

avt.mt = {
    $  : jQuery,

    serverRoot: "",
    apiUrl: "",
    modRoot: "",
    pageUrl: "" // fill this from code
}

avt.mt.tokens = {
    sources: []
}

avt.mt.studio = {

    resizeEditor: function () {
        jQuery("#accordion_controls").parent().css("height", (jQuery("#accordion_controls").parents(".ui-layout-west").innerHeight() - 60) + "px");
        jQuery("#tknTabs").css("height", (jQuery("#tknTabs").parents(".pane-center").innerHeight() - 11) + "px");
        jQuery("#accordion_controls").accordion("resize");

        jQuery(".main_auto_scroll").width(jQuery("#tabs-form-designer").width() - 5);
        jQuery(".main_auto_scroll").height(jQuery("#tknTabs").height() - 60);

        jQuery("#treeTokens").height(jQuery(".ui-layout-west").height() - 140);
        jQuery("#tbSearchTokenTree").width(jQuery(".ui-layout-west").width() - 180);
    },

    loading: function (bLoading) {
        if (bLoading) {
            jQuery(".load_maker_vis").css("visibility", "visible");
            jQuery(".load_maker_dis").show();
        } else {
            jQuery(".load_maker_vis").css("visibility", "hidden");
            jQuery(".load_maker_dis").hide();
        }
    },

    initAllTooltips: function (parent) {
        avt.mt.studio.initTooltips(parent, "hover");
        avt.mt.studio.initTooltips(parent, "click");
        avt.mt.studio.initTooltips(parent, ['focus', 'blur']);
        avt.mt.studio.initTooltips(parent, "hover");
        avt.mt.studio.initTooltips(parent, "hover", "hover_v", ["bottom", "top"]);
        avt.mt.studio.initTooltips(parent, ['focus', 'blur'], "focus_v", ["bottom", "top"]);
    },

    initTooltips: function (parent, action, cssClass, pos) {

        if (!cssClass)
            cssClass = action;

        if (!pos)
            pos = ["most"];

        if (!parent)
            parent = jQuery("body");

        parent.find('.tooltip_' + cssClass).bt({
            padding: 20,
            width: 260,
            spikeLength: 30,
            spikeGirth: 10,
            cornerRadius: 20,
            fill: 'rgba(0, 0, 0, .8)',
            strokeWidth: 2,
            strokeStyle: '#CC0',
            cssStyles: { color: '#FFF', fontWeight: 'normal', zIndex: '99999', fontSize: '12px', fontFamily: 'Verdana' },
            offsetParent: jQuery("body"), // TODO: analyze this for sf
            trigger: action,
            positions: pos
        });
    },


    init: function () {

        g_tknTree = $("#treeTokens");

        g_tknTree.bind("loaded.jstree", function (event, data) {
            avt.mt.studio.initAllTooltips(g_tknTree);
        }).jstree({
            "core": {
                "html_titles": true
            },
            "json_data": {
                "ajax": {
                    "method": "POST",
                    "async": true,
                    "url": avt.mt.apiUrl + "&fn=jstreeTokens"
                }
            },

            "themes": {
                "theme": "apple", //url: avt.mt.modRoot + "js/jsTree/themes/apple/style.css"
                "icons": false
            },

            "search": {
                "case_insensitive": true,
                "show_only_matches": true
            },

            "plugins": ["themes", "json_data", "search", "cookies"]
        });

        $("#btnClearSerchTokenTree").click(function (e) {
            $('#tbSearchTokenTree').val('');
            searchTreeTokens('');
            return false;
        });

        $("#tbSearchTokenTree").keyup(function (e) {
            if (e.keyCode == 27) {
                $("#btnClearSerchTokenTree").click();
                return;
            }
            searchTreeTokens(jQuery(this).val());
        }).keydown(function (event) {
            if (event.keyCode == 10 || event.keyCode == 13)
                event.preventDefault();
        });

        $(".treetoggle").live("click", function (e) {
            e.preventDefault();
            g_tknTree.jstree('toggle_node', $(this).parent());
            return false;
        });

        $(".showTknNs").live("click", function (e) {
            e.preventDefault();
            avt.mt.studio.showTknNs($(this).attr('data-nsid'));
            return false;
        });

        $(".showPredefToken").live("click", function (e) {
            e.preventDefault();
            avt.mt.studio.showPredefToken(this);
            return false;
        });

        $(".showTknGadget").live("click", function (e) {
            e.preventDefault();
            avt.mt.studio.showTknGadget($(this).attr("data-ns"));
            return false;
        });

        $(".showTknMod").live("click", function (e) {
            e.preventDefault();
            avt.mt.studio.showTknMod(this);
            return false;
        });


        avt.mt.studio.initAllTooltips();
        avt.mt.studio.loading(false);

        //avt.mt.studio.loadNamespaces();
        //avt.mt.studio.loadPredefTokens(avt.mt.tokens.predef, jQuery("#list_tokens_predef"));
        //avt.mt.studio.loadMods();
        //avt.mt.studio.loadGadgets();

        // init dialog
        jQuery("#dlgAddEditNamespace").dialog({
            bgiframe: false,
            autoOpen: false,
            title: "Namespace Properties",
            width: 600,
            modal: true,
            resizable: false,
            closeOnEscape: true,

            buttons: {
                'Save': function () {
                    avt.mt.studio.saveTknNs();
                },
                'Close': function () {
                    jQuery("#dlgAddEditNamespace").dialog('close');
                }
            }
        });

        jQuery(".jbtn").button();
    },

    showCorePatchInfo: function () {
        if (jQuery("#dlgCorePatch").parents(".ui-dialog").size() == 0) {
            jQuery("#dlgCorePatch").dialog({
                bgiframe: false,
                autoOpen: false,
                title: "Patch DotNetNuke Core",
                width: 700,
                modal: true,
                resizable: false,
                closeOnEscape: true,

                buttons: !avt.mt.isSuper ? {
                    'Close': function () {
                        jQuery("#dlgCorePatch").dialog('close');
                    }
                } : {
                    'Patch Now': function () {
                        jQuery("#dlgCorePatch").next().hide();
                        jQuery("#dlgCorePatch").find(".patching").show();
                        jQuery.post(avt.mt.apiUrl, {
                                fn: "corepatch-now",
                                format: "json"
                            },
                            function (data) {
                                if (data.error) {
                                    jQuery("#dlgCorePatch").find(".content").hide();
                                    jQuery("#dlgCorePatch").find(".err").html(data.error).show();
                                } else {
                                    jQuery.jGrowl("Core successfully patched!<br/> <i>Please wait while page reloads...</i>", { header: 'Success', life: 15000 });
                                    jQuery("#dlgCorePatch").dialog('close');
                                    jQuery("#dlgSetup").dialog('close');
                                    window.location.reload(true);
                                }
                                jQuery("#dlgCorePatch").next().show();
                                jQuery("#dlgCorePatch").find(".patching").hide();
                            },
                            "json"
                        );
                    },
                    'Remind Me in 3 Days': function () {
                        jQuery("#dlgCorePatch").dialog('close');
                        jQuery.post(avt.mt.apiUrl, {
                            fn: "corepatch-remind3",
                            format: "json"
                        },
                                function (data) {
                                    if (data.error)
                                        jQuery.jGrowl("Error setting reminder!<br />Server response: " + data.error, { header: 'Error', life: 5000 });
                                },
                                "json"
                            );
                    },
                    'Don\'t patch': function () {
                        jQuery("#dlgCorePatch").dialog('close');
                    }
                }
            });
        }

        jQuery("#dlgCorePatch").next().show();
        jQuery("#dlgCorePatch").find(".patching,.err").hide();
        jQuery("#dlgCorePatch").find(".content").show();
        jQuery("#dlgCorePatch").dialog("open");
        jQuery(".ui-widget-overlay").css({ "opacity": 0.7, "background-color": "#f2f2f2", "background-image": "none" });
    },

    showCorePatchUndo: function () {
        if (jQuery("#dlgCorePatchUndo").parents(".ui-dialog").size() == 0) {
            jQuery("#dlgCorePatchUndo").dialog({
                bgiframe: false,
                autoOpen: false,
                title: "UNDO DotNetNuke Core Patch",
                width: 700,
                modal: true,
                resizable: false,
                closeOnEscape: true,

                buttons: !avt.mt.isSuper ? {
                    'Close': function () {
                        jQuery("#dlgCorePatchUndo").dialog('close');
                    }
                } : {
                    'Undo Patch': function () {
                        jQuery("#dlgCorePatchUndo").next().hide();
                        jQuery("#dlgCorePatchUndo").find(".patching").show();
                        jQuery.post(avt.mt.apiUrl, {
                            fn: "undocorepatch",
                            format: "json"
                        },
                                function (data) {
                                    if (data.error) {
                                        jQuery("#dlgCorePatchUndo").find(".content").hide();
                                        jQuery("#dlgCorePatchUndo").find(".err").html(data.error).show();
                                    } else {
                                        jQuery.jGrowl("Core patch successfully removed!<br/> <i>Please wait while page reloads...</i>", { header: 'Success', life: 15000 });
                                        jQuery("#dlgCorePatchUndo").dialog('close');
                                        jQuery("#dlgSetup").dialog('close');
                                        window.location.reload(true);
                                    }
                                    jQuery("#dlgCorePatchUndo").next().show();
                                    jQuery("#dlgCorePatchUndo").find(".patching").hide();
                                },
                                "json"
                            );
                    },
                    'Close': function () {
                        jQuery("#dlgCorePatchUndo").dialog('close');
                    }
                }
            });
        }

        jQuery("#dlgCorePatchUndo").next().show();
        jQuery("#dlgCorePatchUndo").find(".patching,.err").hide();
        jQuery("#dlgCorePatchUndo").find(".content").show();
        jQuery("#dlgCorePatchUndo").dialog("open");
        jQuery(".ui-widget-overlay").css({ "opacity": 0.7, "background-color": "#f2f2f2", "background-image": "none" });
    },


    newNamespace: function (objSync) {
        var dlg = jQuery('#dlgAddEditNamespace');
        dlg.find(":input").val();
        dlg.find(":checkbox").removeAttr("checked");
        dlg.find(".wizerror").hide();
        dlg.find(".nsId").val("-1");
        dlg.find(".TknNsSaving").hide();
        dlg.next(".ui-dialog-buttonpane").show();
        dlg.dialog('open');
        dlg[0].sync = objSync;
    },

    syncNs: function () {
        $(".ddNsSync").each(function () {
            var _this = $(this);
            var _prevVal = _this.val();
            _this.empty();
            for (var i = 0; i < avt.mt.namespaces.length; i++) {
                _this.append("<option value='" + avt.mt.namespaces[i].id + "'>" + avt.mt.namespaces[i].name + "</option>");
            }
            _this.append("<option value='-1'>New namespace...</option>");

            if (_this.find("[value='" + _prevVal + "']").size() > 0) {
                _this.val(_prevVal);
            } else {
                // _this.find("option:first").attr("selected", "selected");
            }
        });
    },

    replaceTokensTest: function (bSkipParsing) {
        var txt = jQuery("#testTokensInput").val();
        if (txt.length == 0) {
            jQuery("#testTokensResult").text("Empty input...");
            return;
        }
        jQuery("#testTokensResult").text("Replacing... please wait...");

        // get response from server via AJAX
        jQuery.post(avt.mt.apiUrl, {
            fn: "replace_tokens",
            data: txt,
            format: "json",
            skipParsing: bSkipParsing ? "true" : "false"
        },
            function (data) {
                if (data.error)
                    jQuery("#testTokensResult").text(data.error);
                else
                    jQuery("#testTokensResult").text(data.success);
            },
            "json"
        );
    },

    testTokenAsHtml: function () {
        var pageHtml = "<html><body>";
        pageHtml += "<form name='tknForm' action='" + avt.mt.apiUrl + "' method='POST'>";
        pageHtml += "<input type='hidden' name='data' value='" + jQuery("#testTokensInput").val() + "' />";
        pageHtml += "<input type='hidden' name='portalid' value='" + avt.mt.portalId + "' />";
        pageHtml += "<input type='hidden' name='fn' value='replace_tokens_html' />";
        pageHtml += "</form>";
        pageHtml += "<script type = 'text/javascript'> document.forms['tknForm'].submit (); </script>";
        pageHtml += "</body></html>";

        var wnd = window.open('', 'tknTest', 'menubar=no,toolbar=no,resizable=1,width=500,height=300');
        wnd.document.write(pageHtml);

    },

    clear_cache_current: function () {

        if (avt.mt.current.cache == 0) { // no cache, just display the message
            jQuery.jGrowl("Cache for token <b>" + avt.mt.current.name + "</b> successfully cleared!", { header: 'Success', life: 5000 });
            return;
        }

        // do it via ajax
        jQuery.post(avt.mt.apiUrl, {
            fn: "clear_token_cache",
            format: "json",
            data: avt.mt.current.id
        },
            function (data) {
                jQuery.jGrowl("Cache for token <b>" + avt.mt.current.name + "</b> successfully cleared!", { header: 'Success', life: 5000 });
            }, "json");
    },

    clear_cache_all: function () {
        // do it via ajax
        jQuery.post(avt.mt.apiUrl, {
            fn: "clear_token_cache_all",
            format: "json"
        },
            function (data) {
                jQuery.jGrowl("Cache successfully cleared for all tokens!", { header: 'Success', life: 5000 });
            }, "json");
    },

    showExternalApi: function () {
        var _wnd = avt.mt.wnd.create('#tplExternalApi', 'externalApi', 'External API');

        // load settings
        if (avt.mt.apiSettings.portalId == -1) {
            _wnd.find(".apiSettingsScope").val("global");
        } else {
            _wnd.find(".apiSettingsScope").val("portal");
        }

        switch (avt.mt.apiSettings.filterIPs) {
            case "[allow]":
                _wnd.find(".apiFilterIPs").val("allowAll");
                break;
            case "[deny]":
                _wnd.find(".apiFilterIPs").val("denyAll");
                break;
            default:
                _wnd.find(".apiFilterIPs").val("list");
                _wnd.find(".apiFilterListIPs").val(avt.mt.apiSettings.filterIPs.replace(/;/g, "\n"));
                break;
        }

        _wnd.find(".apiFilterIPs").change();

        // load API Keys
        avt.mt.studio.loadApiKeys();
    },

    loadApiKeys: function () {
        var _wnd = jQuery(".apiRoot");
        var _apiKeys = null;

        if (_wnd.find(".apiSettingsScope").val() == "global") {
            if (typeof (avt.mt.apiKeysGlobal) != "undefined") {
                _apiKeys = avt.mt.apiKeysGlobal;
            }
        } else {
            if (typeof (avt.mt.apiKeysPortal) != "undefined") {
                _apiKeys = avt.mt.apiKeysPortal;
            }
        }

        if (_apiKeys != null) {
            avt.mt.studio._loadApiKeys();
        } else {
            // get from server
            jQuery.post(avt.mt.apiUrl, {
                fn: "get_apikeys",
                global: _wnd.find(".apiSettingsScope").val() == "global",
                format: "json"
            },
                function (data) {
                    if (data.error) {
                        jQuery.jGrowl("Error getting API Keys!<br />Server response: " + data.error, { header: 'Error', life: 5000 });
                    } else {
                        var _wnd = jQuery(".apiRoot");
                        if (_wnd.find(".apiSettingsScope").val() == "global") {
                            avt.mt.apiKeysGlobal = data;
                        } else {
                            avt.mt.apiKeysPortal = data;
                        }
                        avt.mt.studio._loadApiKeys();
                    }
                },
            "json");
        }
    },

    _loadApiKeys: function () {
        var _wnd = jQuery(".apiRoot");
        var _apiKeys = null;
        if (_wnd.find(".apiSettingsScope").val() == "global") {
            _apiKeys = avt.mt.apiKeysGlobal;
        } else {
            _apiKeys = avt.mt.apiKeysPortal;
        }

        _wnd.find(".apiKeysLoading").hide();

        var _c = _wnd.find(".cApiKeys:first").empty();

        for (var i = 0; i < _apiKeys.length; i++) {
            avt.mt.studio.__loadApiKey(_apiKeys[i], _c);
        }
    },

    __loadApiKey: function (apiKey, _c) {

        var bAppend = false;
        var t = _c.find(":contains(" + apiKey.apiKey.toUpperCase() + ")").parents(".apiKeyRoot:first");
        if (t.length == 0) {
            t = jQuery("#tplApiKey").clone().removeAttr("id");
            bAppend = true;
        }

        t.find(".apiKey").text(apiKey.apiKey.toUpperCase());
        t.find(".apiDesc").text(apiKey.caption);

        switch (apiKey.authMode) {
            case "disabled":
                t.find(".apiImpers").text("no impersonation");
                break;
            case "login":
                t.find(".apiImpers").text("allows user login");
                break;
            case "user":
                t.find(".apiImpers").html("impersonates <u>" + apiKey.username + "</u>");
            case "passthru":
                t.find(".apiImpers").html("passthru");
                break;
        }

        switch (apiKey.filterIPs) {
            case "[inherit]":
                t.find(".apiFiltering").text("inherit IP filtering");
                break;
            case "[allow]":
                t.find(".apiFiltering").text("allows connection from all machines");
                break;
            default:
                t.find(".apiFiltering").text("allows connection to IPs in list");
                break;
        }

        if (bAppend == true)
            _c.append(t.show());
    },

    getApiKey: function (apiKey) {
        if (typeof (avt.mt.apiKeysGlobal) != "undefined") {
            for (var i = 0; i < avt.mt.apiKeysGlobal.length; i++) {
                if (avt.mt.apiKeysGlobal[i].apiKey == apiKey) {
                    return avt.mt.apiKeysGlobal[i];
                }
            }
        }
        if (typeof (avt.mt.apiKeysPortal) != "undefined") {
            for (var i = 0; i < avt.mt.apiKeysPortal.length; i++) {
                if (avt.mt.apiKeysPortal[i].apiKey == apiKey) {
                    return avt.mt.apiKeysPortal[i];
                }
            }
        }
    },

    saveApiSettings: function (apiRoot) {

        apiRoot.find(".wizerror").hide();

        var _ips = "";
        switch (apiRoot.find(".apiFilterIPs").val()) {
            case "allowAll":
                _ips = "[allow]";
                break;
            case "denyAll":
                _ips = "[deny]";
                break;
            case "list":
                _ips = apiRoot.find(".apiFilterListIPs").val();
                if (jQuery.trim(_ips).length == 0) {
                    apiRoot.find(".errEmptyIPs").show();
                    return;
                }
                _ips = _ips.replace(/\n/g, ";");
                break;
        }


        apiRoot.find(".btnBar").hide();
        apiRoot.find(".apiSaving").show();


        jQuery.post(avt.mt.apiUrl, {
            fn: "update_api_settings",
            global: (apiRoot.find(".apiSettingsScope").val() == "global" ? "true" : "false"),
            ips: _ips,
            format: "json"
        },
            function (data) {
                if (data.error) {
                    jQuery.jGrowl("Error updating API Settings!<br />Server response: " + data.error, { header: 'Error', life: 5000 });
                    apiRoot.find(".btnBar").show();
                    apiRoot.find(".apiSaving").hide();
                } else {
                    jQuery.jGrowl("API Settings successfully saved!", { header: 'Success', life: 5000 });

                    // sync
                    avt.mt.apiSettings.portalId = (apiRoot.find(".apiSettingsScope").val() == "global" ? -1 : avt.mt.portalId);
                    avt.mt.apiSettings.filterIPs = _ips;

                    // close dialog
                    avt.mt.wnd.close(apiRoot.attr("id"));
                    jQuery('#tplIssueNewKey').dialog('close');
                }
            },
        "json");
    },

    saveApiKey: function (_apiKeyRoot) {

        _apiKeyRoot.find(".wizerror").hide();

        if (_apiKeyRoot.find(".apiImpersonation").val() == "user" && jQuery.trim(_apiKeyRoot.find(".apiImpersonationUsername").val()).length == 0) {
            _apiKeyRoot.find(".errEmptyUsername").show();
            return;
        }

        if (_apiKeyRoot.find(".apiImpersonation").val() == "passthru" && jQuery.trim(_apiKeyRoot.find(".apiImpersonationPassThruKey").val()).length == 0) {
            _apiKeyRoot.find(".errEmptyPassThruKey").show();
            return;
        }

        var _ips = "";
        switch (_apiKeyRoot.find(".apiKeyFilterIPs").val()) {
            case "inherit":
                _ips = "[inherit]";
                break;
            case "allowAll":
                _ips = "[allow]";
                break;
            case "list":
                _ips = _apiKeyRoot.find(".apiKeyFilterListIPs").val();
                if (jQuery.trim(_ips).length == 0) {
                    _apiKeyRoot.find(".errEmptyKeyIPs").show();
                    return;
                }
                _ips = _ips.replace(/\n/g, ";");
                break;
        }

        _apiKeyRoot.find(".ui-dialog-buttonpane").hide();
        _apiKeyRoot.find(".apiKeySaving").show();
        //console.log(_apiKeyRoot.find(".apiImpersonationPassThruKey"));
        var apiKey = _apiKeyRoot.find(".apiKey").val();
        jQuery.post(avt.mt.apiUrl, {
            fn: "update_apikey",
            apiKey: apiKey,
            caption: _apiKeyRoot.find(".apiDesc").val(),
            authMode: _apiKeyRoot.find(".apiImpersonation").val(),
            userName: _apiKeyRoot.find(".apiImpersonationUsername").val(),
            ips: _ips,
            secretKey: _apiKeyRoot.find(".apiImpersonationPassThruKey").val(),
            format: "json"
        },
            function (data) {
                if (data.error) {
                    jQuery.jGrowl("Error saving API Key!<br />Server response: " + data.error, { header: 'Error', life: 5000 });

                    _apiKeyRoot.find(".ui-dialog-buttonpane").show();
                    _apiKeyRoot.find(".apiKeySaving").hide();

                } else {
                    jQuery.jGrowl("API Key successfully saved!", { header: 'Success', life: 5000 });

                    // sync
                    jQuery("#tplIssueNewKey").dialog("close");

                    var bFound = false;
                    if (typeof (avt.mt.apiKeysGlobal) != "undefined") {
                        for (var i = 0; i < avt.mt.apiKeysGlobal.length; i++) {
                            if (avt.mt.apiKeysGlobal[i].apiKey == data.apiKey) {
                                avt.mt.apiKeysGlobal[i] = data;
                                bFound = true;
                                break;
                            }
                        }
                        if (bFound == false) {
                            avt.mt.apiKeysGlobal.push(data);
                        }
                    }
                    bFound = false;
                    if (typeof (avt.mt.apiKeysPortal) != "undefined") {
                        for (var i = 0; i < avt.mt.apiKeysPortal.length; i++) {
                            if (avt.mt.apiKeysPortal[i].apiKey == data.apiKey) {
                                avt.mt.apiKeysPortal[i] = data;
                                bFound = true;
                                break;
                            }
                        }
                        if (bFound == false) {
                            avt.mt.apiKeysPortal.push(data);
                        }
                    }

                    if (typeof (avt.mt.apiKeysGlobal) != "undefined") {
                        avt.mt.apiKeysGlobal.push(data);
                    }
                    if (typeof (avt.mt.apiKeysPortal) != "undefined") {
                        avt.mt.apiKeysPortal.push(data);
                    }

                    avt.mt.studio.__loadApiKey(data, jQuery(".cApiKeys"));
                }
            },
        "json");

    },

    // Token NameSpaces
    // -----------------------------------------------------------------------------------------

    //    loadNamespaces: function () {
    //        var _list = jQuery("#list_token_sources").empty();

    //        for (var i = 0; i < avt.mt.namespaces.length; i++) {
    //            var _tpl = jQuery("#list_token_sources_tpl").clone().removeAttr("id");
    //            _tpl.find(".tkn_list_item").attr("rel", avt.mt.namespaces[i].id);
    //            _tpl.find(".tkn_list_item").text(avt.mt.namespaces[i].name);
    //            _tpl.find(".tokenCount").text(avt.mt.namespaces[i].tokens.length);
    //            _list.append(_tpl);
    //        }
    //    },

    //    loadPredefTokens: function (tokens, list) {
    //        for (var i = 0; i < tokens.length; i++) {
    //            var _lia = jQuery("<a class = 'blue' href = 'javascript: ;' onclick = 'avt.mt.studio.showPredefToken(this);'><b>" + tokens[i].ns + "</b></a>&nbsp;");
    //            list.append(jQuery("<li></li>").append(_lia));
    //            _lia.get(0).tkn = tokens[i];
    //        }
    //    },

    showPredefToken: function (o) {
        o = $(o);
        var _c = avt.mt.wnd.create('#tplViewPredefNamespace', 'psrc' + o.attr("data-ns"), '<b>' + o.attr("data-ns") + '</b>');
        _c.find(".nsName").text(o.attr("data-ns"));
        _c.find(".nsDesc").html(o.attr("data-desc"));
        _c.find(".nsVal").html(o.attr("data-values"));
        _c.find(".nsUsage").text(o.attr("data-usage"));
        _c.find(".nsAllPortals").text("yes");
    },

    // TODO: some hasing
    getTknNs: function (id) {
        id = parseInt(id);
        for (var i = 0; i < avt.mt.namespaces.length; i++) {
            if (avt.mt.namespaces[i].id == id) {
                return avt.mt.namespaces[i];
            }
        }
        return null;
    },

    // TODO: some hasing
    getTkn: function (id) {
        id = parseInt(id);
        for (var i = 0; i < avt.mt.namespaces.length; i++) {
            for (var j = 0; j < avt.mt.namespaces[i].tokens.length; j++) {
                if (avt.mt.namespaces[i].tokens[j].id == id) {
                    return avt.mt.namespaces[i].tokens[j];
                }
            }
        }
        return null;
    },

    // TODO: some hasing
    getTokensByType: function (tknType) {
        var tknArr = [];
        for (var i = 0; i < avt.mt.namespaces.length; i++) {
            for (var j = 0; j < avt.mt.namespaces[i].tokens.length; j++) {
                if (avt.mt.namespaces[i].tokens[j].src.type == tknType) {
                    if (typeof (avt.mt.namespaces[i].tokens[j].ns) == "undefined") {
                        avt.mt.namespaces[i].tokens[j].ns = { id: avt.mt.namespaces[i].id, name: avt.mt.namespaces[i].name };
                    }
                    tknArr.push(avt.mt.namespaces[i].tokens[j]);
                }
            }
        }
        return tknArr;
    },

    showTknNs: function (id) {

        var _tknNs = avt.mt.studio.getTknNs(id);
        var _c = avt.mt.wnd.create('#tplViewNamespace', 'src' + id, '<b>' + _tknNs.name + '</b>');
        _c.find(".nsId").text(_tknNs.id);
        _c.find(".nsName").text(_tknNs.name);
        _c.find(".nsDesc").text(_tknNs.desc);
        _c.find(".nsAllPortals").text(_tknNs.allportals ? "yes" : "no");

        var _cTkn = _c.find(".tknList").empty();
        for (var j = 0; j < _tknNs.tokens.length; j++) {
            var _tplTkn = jQuery("#tplTokenSummary").clone().removeAttr("id");
            _tplTkn.find(".tknId").text(_tknNs.tokens[j].id);
            _tplTkn.find(".tknName").text(_tknNs.tokens[j].name);
            _tplTkn.find(".tknDesc").text(_tknNs.tokens[j].desc);
            if (typeof (_tknNs.tokens[j].items) != "undefined") {
                for (var k = 0; k < _tknNs.tokens[j].items.length; k++) {
                    var cl = jQuery("#tplTestTokenLink").clone().removeAttr("id");
                    //cl.text("[" + _tknNs.name + ":" + _tknNs.tokens[j].name + "." + _tknNs.tokens[j].items[k] + "]");
                    cl.text(avt.mt.studio.formatUsage(_tknNs.name, _tknNs.tokens[j].name + "." + _tknNs.tokens[j].items[k], _tknNs.tokens[j].src.params));
                    cl.show();
                    if (k > 0)
                        _tplTkn.find(".tknUsage").append(", ");
                    _tplTkn.find(".tknUsage").append(cl);

                }
            } else {
                var cl = jQuery("#tplTestTokenLink").clone().removeAttr("id");
                cl.text(avt.mt.studio.formatUsage(_tknNs.name, _tknNs.tokens[j].name, _tknNs.tokens[j].src.params));
                cl.show();
                _tplTkn.find(".tknUsage").append(cl);
            }

            if (avt.mt.tkn.tknSrcType[_tknNs.tokens[j].src.type])
                _tplTkn.find(".tknSource").text(avt.mt.tkn.tknSrcType[_tknNs.tokens[j].src.type].title);
            if (avt.mt.tkn.tknParser[_tknNs.tokens[j].parser.type])
                _tplTkn.find(".tknParser").text(avt.mt.tkn.tknParser[_tknNs.tokens[j].parser.type].title);
            _cTkn.append(_tplTkn.show());
        }
    },

    formatUsage: function (ns, tkn, params) {
        var usage = "[" + ns + ":" + tkn;
        if (typeof (params) != "undefined" && params.length > 0) {
            usage += "(";
            for (var i = 0; i < params.length; i++) {
                usage += (params[i] + "=\"SomeValue\",");
            }
            // replace last comma with closing parameter bracket
            usage = usage.substr(0, usage.length - 1);
            usage += ")";
        }
        usage += "]";
        return usage;
    },

    editTknNs: function (id) {
        var _tknNs = avt.mt.studio.getTknNs(id);

        var _c = jQuery("#dlgAddEditNamespace");
        _c.find(".nsId").val(_tknNs.id);
        _c.find(".nsName").val(_tknNs.name);
        _c.find(".nsDesc").val(_tknNs.desc);
        _c.find(".nsAllPortals")[0].checked = _tknNs.allportals;
        _c.find().hide();
        _c.next(".ui-dialog-buttonpane").show();
        _c.find(".TknNsSaving").hide();
        _c.dialog("open");
    },

    deleteTknNs: function (id) {
        if (!confirm("Are you sure you want to delete this namespace?\nAll tokens will also be deleted!")) {
            return;
        }
        avt.mt.studio.loading(true);
        jQuery.post(avt.mt.apiUrl, {
            fn: "delete_tknNs",
            format: "json",
            id: id
        }, function (data) {
            avt.mt.studio.loading(false);
            if (data.error) {
                jQuery.jGrowl("Error updating token source!<br />Server response: " + data.error, { header: 'Error', life: 5000 });
            } else {
                // 
                jQuery.jGrowl("Namespace successfully deleted", { header: 'Success', life: 5000 });

                // sync our collection
                id = parseInt(id);
                for (var i = 0; i < avt.mt.namespaces.length; i++) {
                    if (avt.mt.namespaces[i].id == id) {
                        avt.mt.namespaces.splice(i, 1);
                        break;
                    }
                }

                // close window
                avt.mt.wnd.close('src' + id);

                // reload token sources
                g_tknTree.jstree("refresh");
                //avt.mt.studio.loadNamespaces();

                avt.mt.studio.syncNs();
            }
        });

    },


    closeTknSource: function (frm) {
        avt.mt.wnd.close(frm.attr('id'));

        var TknNsId = parseInt(jQuery.trim(frm.find(".nsId").val()));
        if (TknNsId > 0) { // show token source details
            avt.mt.studio.showTknNs(TknNsId);
        }
    },

    saveTknNs: function () {

        var frm = jQuery("#dlgAddEditNamespace");
        var TknNsId = parseInt(jQuery.trim(frm.find(".nsId").val()));
        var TknNsName = jQuery.trim(frm.find(".nsName").val());
        var TknNsDesc = jQuery.trim(frm.find(".nsDesc").val());
        var TknNsAllPortals = frm.find(".nsAllPortals").get(0).checked;
        frm.find(".wizerror").hide();

        // validate token source name
        var regexpNoSpace = /(^[a-z0-9][a-z0-9]*$)/i;
        if (regexpNoSpace.test(TknNsName) === false) {
            frm.find(".reqName").show();
            return;
        }

        // validate token source name is unique
        for (var i = 0; i < avt.mt.namespaces.length; i++) {
            if (avt.mt.namespaces[i].name.toLowerCase() == TknNsName.toLowerCase() && TknNsId != avt.mt.namespaces[i].id) {
                frm.find(".uniqueName").show();
                return;
            }
        }

        // also, look in predefined tokens
        // TODO:
        //        for (var i = 0; i < avt.mt.tokens.predef.length; i++) {
        //            if (avt.mt.tokens.predef[i].ns.toLowerCase() == TknNsName.toLowerCase()) {
        //                frm.find(".uniqueName").show();
        //                return;
        //            }
        //        }

        // hide buttons to avoid clicking them twice
        frm.next(".ui-dialog-buttonpane").hide();
        frm.find(".TknNsSaving").show();
        avt.mt.studio.loading(true);

        jQuery.post(avt.mt.apiUrl, {
            fn: "update_tknNs",
            format: "json",
            id: TknNsId,
            name: TknNsName,
            desc: TknNsDesc,
            allportals: TknNsAllPortals ? "true" : "false"
        }, function (data) {
            avt.mt.studio.loading(false);
            if (data.error) {
                jQuery.jGrowl("Error updating namespace!<br />Server response: " + data.error, { header: 'Error', life: 5000 });
                frm.find(".TknNsCancel").show();
                frm.find(".TknNsSave").show();
                frm.find(".TknNsSaving").hide();
            } else {
                jQuery.jGrowl("Namespace " + TknNsName + " succesfully updated!", { header: 'Success', life: 5000 });

                // refresh collection
                if (TknNsId <= 0) {
                    // add new token source to collection
                    avt.mt.namespaces.push({
                        id: data.id,
                        name: TknNsName,
                        desc: TknNsDesc,
                        allportals: TknNsAllPortals,
                        tokens: []
                    });
                } else {
                    var _tknNs = avt.mt.studio.getTknNs(TknNsId);
                    _tknNs.name = TknNsName;
                    _tknNs.desc = TknNsDesc;
                    _tknNs.allportals = TknNsAllPortals;
                }

                avt.mt.namespaces.sort(function (a, b) {
                    if (a.name.toLowerCase() < b.name.toLowerCase())
                        return -1;
                    return 1;
                });

                // close window
                avt.mt.wnd.close('src' + data.id);
                jQuery("#dlgAddEditNamespace").dialog("close");

                // TODO: sort token source list


                // reload token sources
                //avt.mt.studio.loadNamespaces();
                g_tknTree.jstree("refresh");

                // open token source details
                avt.mt.studio.showTknNs(data.id);

                avt.mt.studio.syncNs();

                if (jQuery("#dlgAddEditNamespace")[0].sync) {
                    $(jQuery("#dlgAddEditNamespace")[0].sync).val(data.id.toString());
                }

                /* return; */

                // clear cached data
                /* delete avt.mt.profilesById[prId];
                for (var i = 0; i < avt.mt.profiles.length; i++) {
                if (avt.mt.profiles[i].id == prId) {
                avt.mt.profiles.splice(i, 1);
                break;
                }
                }
                    
                // sync ui
                prRoot.remove();
                avt.mt.studio.reloadInstance(); */
            }
        }, "json");
    },


    addEditTkn: function (TknNsId, tknId) {

    },



    // Token Aware Modules
    // -----------------------------------------------------------------------------------------
    //    loadMods: function () {
    //        var _list = jQuery("#list_tok_mods").empty();

    //        for (var i = 0; i < avt.mt.tokens.mods.length; i++) {
    //            var _tpl = jQuery("#tplListTokMod").clone().removeAttr("id");
    //            _tpl.find(".tkn_list_item").attr("rel", avt.mt.tokens.mods[i].ns);
    //            _tpl.find(".tkn_list_item").text(avt.mt.tokens.mods[i].ns);
    //            //_tpl.find(".tokenCount").text(avt.mt.mods[i].tokens.length);
    //            _list.append(_tpl);
    //        }
    //    },

    //    loadGadgets: function () {
    //        var _list = jQuery("#list_tok_gadget").empty();

    //        for (var i = 0; i < avt.mt.gadgets.length; i++) {
    //            var _tpl = jQuery("#tplListTokGadget").clone().removeAttr("id");
    //            _tpl.find(".tkn_list_item").attr("rel", avt.mt.gadgets[i].name);
    //            _tpl.find(".tkn_list_item").text(avt.mt.gadgets[i].name);
    //            //_tpl.find(".tokenCount").text(avt.mt.mods[i].tokens.length);
    //            _list.append(_tpl);
    //        }
    //    },


    showTknMod: function (o) {
        o = $(o);
        var _c = avt.mt.wnd.create('#tplToken3rdParty', 'srcmod' + ns, '<b>' + ns + '</b>');

        var _mod = { "ns": o.attr("ns"), "desc": o.attr("desc") };
        //        for (var i = 0; i < avt.mt.tokens.mods.length; i++) {
        //            avt.mt.tokens.mods[i].index = i;
        //            if (avt.mt.tokens.mods[i].ns == ns) {
        //                _mod = avt.mt.tokens.mods[i];
        //                // break; // let it flow to populate all indexes
        //            }
        //        }

        _c.find(".nsName").text(_mod.ns);
        _c.find(".nsDesc").text(_mod.desc);

        //if (typeof (_mod.info) == "undefined") {
        // load info from server
        jQuery.post(avt.mt.apiUrl, {
            fn: "tknmod_info",
            ns: ns,
            format: "json"
        },
                function (data) {
                    if (typeof (data.error) != "undefined") {
                        jQuery.jGrowl("Token information could not be retrieved (Server Message: " + data.error + ")!", { header: 'Error', life: 5000 });
                        return;
                    }

                    _mod.info = data;
                    avt.mt.studio.populateTknModInfo(_mod, _c);
                },
                "json"
            );
        //        } else {
        //            avt.mt.studio.populateTknModInfo(_mod, _c);
        //        }

    },


    showTknGadget: function (ns) {

        var _c = avt.mt.wnd.create('#tplGadgetInfo', 'gadget' + ns.replace(":", "").replace("[", "").replace("]", ""), '<b>' + ns + '</b>');

        var _gadget = { "name": ns };
        //        for (var i = 0; i < avt.mt.gadgets.length; i++) {
        //            avt.mt.gadgets[i].index = i;
        //            if (avt.mt.gadgets[i].name == ns) {
        //                _gadget = avt.mt.gadgets[i];
        //                // break; // let it flow to populate all indexes
        //            }
        //        }

        _c.find(".nsName").text(_gadget.name);
        _c.find(".nsDesc").text("");

        //if (typeof (_gadget.info) == "undefined") {
        // load info from server
        jQuery.post(avt.mt.apiUrl, {
            fn: "gadget_info",
            name: ns,
            format: "json"
        },
                function (data) {
                    if (typeof (data.error) != "undefined") {
                        jQuery.jGrowl("Token information could not be retrieved (Server Message: " + data.error + ")!", { header: 'Error', life: 5000 });
                        return;
                    }

                    _gadget.info = data;
                    avt.mt.studio.populateGadgetInfo(_gadget, _c);
                },
                "json"
            );
        //        } else {
        //            avt.mt.studio.populateGadgetInfo(_gadget, _c);
        //        }

    },

    populateTknModInfo: function (_mod, _c) {


        if (!_mod.info.hasDef) {

            _c.find(".tknLoading").hide();
            _c.find(".tknNotLoaded").show();

            _c.find(".nsNoInfo").show();
            _c.find(".nsInfo").hide();
            _c.find(".tknsContainer").hide();

            return;
        }


        // proceed to display documentation
        _c.find(".nsDefCache").text(_mod.info.cacheTime + " seconds");
        _c.find(".nsOnlyDocTokens").text(_mod.info.receiveOnlyKnownTokens ? "yes" : "no");
        if (_mod.info.docUrl.length > 0) {
            _c.find(".nsDocUrl").text(_mod.info.docUrl).attr("href", _mod.info.docUrl);
        } else {
            _c.find(".nsDocUrlC").hide();
        }

        // populate tokens
        if (_mod.info.tokens.length == 0) {
            _c.find(".noTokens").show();
        } else {
            var _cTkns = _c.find(".tknList").empty();
            for (var i = 0; i < _mod.info.tokens.length; i++) {
                var _tplTkn = jQuery("#tpl3rdPartyTokenSummary").clone().removeAttr("id");

                _tplTkn.find(".tknName").text(_mod.info.tokens[i].name);
                _tplTkn.find(".tknDesc").text(_mod.info.tokens[i].desc);

                if (_mod.info.tokens[i].docUrl.length > 0) {
                    _tplTkn.find(".tknDocUrl").text(_mod.info.tokens[i].docUrl).attr("href", _mod.info.tokens[i].docUrl);
                } else {
                    _tplTkn.find(".tknDocUrlC").hide();
                }

                _tplTkn.find(".tknCacheTime").text(_mod.info.tokens[i].cacheTime + " seconds");

                // print params
                var _cParams = _tplTkn.find(".tknParamsC").empty();
                for (var j = 0; j < _mod.info.tokens[i].tknParams.length; j++) {
                    var _tplParam = jQuery("#tplTknParam").clone().removeAttr("id");
                    _tplParam.find(".paramName").text(_mod.info.tokens[i].tknParams[j].name);
                    _tplParam.find(".paramDesc").html(_mod.info.tokens[i].tknParams[j].desc);

                    if (_mod.info.tokens[i].tknParams[j].isRequired) {
                        _tplParam.find(".paramRequired").show();
                        _tplParam.find(".paramOptional").hide();
                    } else {
                        _tplParam.find(".paramRequired").hide();
                        _tplParam.find(".paramOptional").show();
                    }

                    _tplParam.find(".paramType").text(_mod.info.tokens[i].tknParams[j].valType);
                    if (_mod.info.tokens[i].tknParams[j].defaultValue) {
                        _tplParam.find(".paramDefaultVal").text(_mod.info.tokens[i].tknParams[j].defaultValue);
                    } else {
                        _tplParam.find(".paramDefaultValC").hide();
                    }

                    if (_mod.info.tokens[i].tknParams[j].valType == "Enum") {
                        _tplParam.find(".paramPossibleVals").text(_mod.info.tokens[i].tknParams[j].possibleValues);
                    } else {
                        _tplParam.find(".paramPossibleValsC").hide();
                    }

                    _cParams.append(_tplParam.show());
                }

                // fill syntax
                var syntax = "<span style = 'font-weight: bold;'>[" + _mod.ns + ":" + _mod.info.tokens[i].name + "</span>";
                if (_mod.info.tokens[i].tknParams.length)
                    syntax += "(";
                for (var j = 0; j < _mod.info.tokens[i].tknParams.length; j++) {
                    if (_mod.info.tokens[i].tknParams[j].isRequired) {
                        syntax += "<span style ='color: #E24343;'>" + _mod.info.tokens[i].tknParams[j].name + "=</span>";
                    } else {
                        syntax += "<span style ='color: #3A924A;'>" + _mod.info.tokens[i].tknParams[j].name + "=</span>";
                    }
                    syntax += "<span style = 'color:##4343E2;font-style:italic; font-size: x-small;'>";
                    switch (_mod.info.tokens[i].tknParams[j].valType) {
                        case "Int32":
                            syntax += "(Integer Number)";
                            break;
                        case "Boolean":
                            syntax += "[true|false]";
                            break;
                        case "Double":
                            syntax += "(Real Number)";
                            break;
                        case "String":
                            syntax += "\"(Literal String)\"";
                            break;
                        case "Enum":
                            syntax += "[" + _mod.info.tokens[i].tknParams[j].possibleValues + "]";
                            break;
                    }
                    syntax += "</span>,";
                }
                if (syntax[syntax.length - 1] == ',')
                    syntax = syntax.substr(0, syntax.length - 1);

                if (_mod.info.tokens[i].tknParams.length)
                    syntax += ")";
                syntax += "<span style = 'font-weight: bold;'>]</span>";

                _tplTkn.find(".tknSyntax").html(syntax);

                // load examples
                if (_mod.info.tokens[i].examples.length == 0) {
                    _tplTkn.find(".tknExamplesC").hide();
                } else {
                    var _cExamples = _tplTkn.find(".tknExampleList").empty();
                    for (var j = 0; j < _mod.info.tokens[i].examples.length; j++) {
                        var _tplExmple = jQuery("#tplTknExample").clone().removeAttr("id");
                        _tplExmple.find(".exCode").text(_mod.info.tokens[i].examples[j].codeSnippet);
                        _tplExmple.find(".exDesc").html(_mod.info.tokens[i].examples[j].desc);
                        var codeSnippet = _mod.info.tokens[i].examples[j].codeSnippet;
                        _tplExmple.find(".exTest").attr("href", "#").click(function () {
                            avt.mt.tkn.testToken(codeSnippet);
                            return false;
                        });
                        _tplExmple.find(".exTest").attr("href", "javascript: avt.mt.tkn.testToken(avt.mt.tokens.mods[" + _mod.index + "].info.tokens[" + i + "].examples[" + j + "].codeSnippet);");
                        _cExamples.append(_tplExmple.show());
                    }
                }

                _cTkns.append(_tplTkn.show());
            }
        }

        // done loading
        _c.find(".tknLoading").hide();
        _c.find(".tknNotLoaded").show();
        _c.find(".nsNoInfo").hide();
    },


    populateGadgetInfo: function (_gadget, _c) {

        // proceed to display documentation
        if (_gadget.info.docUrl.length > 0) {
            _c.find(".tknDocUrl").text(_gadget.info.docUrl).attr("href", _gadget.info.docUrl);
        } else {
            _c.find(".tknDocUrlC").hide();
        }

        _c.find(".tknName").text(_gadget.name);
        _c.find(".tknDesc").text(_gadget.info.desc);

        // _tplTkn.find(".tknCacheTime").text(_mod.info.tokens[i].cacheTime + " seconds");

        // print params
        var _cParams = _c.find(".tknParamsC").empty();
        if (_gadget.info.tknParams.length == 0) {
            _c.find(".tknParamsCC").hide();
        } else {
            for (var j = 0; j < _gadget.info.tknParams.length; j++) {
                var _tplParam = jQuery("#tplTknParam").clone().removeAttr("id");
                _tplParam.find(".paramName").text(_gadget.info.tknParams[j].name);
                _tplParam.find(".paramDesc").html(_gadget.info.tknParams[j].desc);

                if (_gadget.info.tknParams[j].isRequired) {
                    _tplParam.find(".paramRequired").show();
                    _tplParam.find(".paramOptional").hide();
                } else {
                    _tplParam.find(".paramRequired").hide();
                    _tplParam.find(".paramOptional").show();
                }

                _tplParam.find(".paramType").text(_gadget.info.tknParams[j].valType);
                if (_gadget.info.tknParams[j].defaultValue) {
                    _tplParam.find(".paramDefaultVal").text(_gadget.info.tknParams[j].defaultValue);
                } else {
                    _tplParam.find(".paramDefaultValC").hide();
                }

                if (_gadget.info.tknParams[j].valType == "Enum") {
                    _tplParam.find(".paramPossibleVals").text(_gadget.info.tknParams[j].possibleValues);
                } else {
                    _tplParam.find(".paramPossibleValsC").hide();
                }

                _cParams.append(_tplParam.show());
            }
        }

        // fill syntax
        var syntax = "<span style = 'font-weight: bold;'>" + _gadget.name.replace("]", "") + "</span>";
        if (_gadget.info.tknParams.length)
            syntax += "(";
        for (var j = 0; j < _gadget.info.tknParams.length; j++) {
            if (_gadget.info.tknParams[j].isRequired) {
                syntax += "<span style ='color: #E24343;'>" + _gadget.info.tknParams[j].name + "=</span>";
            } else {
                syntax += "<span style ='color: #3A924A;'>" + _gadget.info.tknParams[j].name + "=</span>";
            }
            syntax += "<span style = 'color:##4343E2;font-style:italic; font-size: x-small;'>";
            switch (_gadget.info.tknParams[j].valType) {
                case "Int32":
                    syntax += "(Integer Number)";
                    break;
                case "Boolean":
                    syntax += "[true|false]";
                    break;
                case "Double":
                    syntax += "(Real Number)";
                    break;
                case "String":
                    syntax += "\"(Literal String)\"";
                    break;
                case "Enum":
                    syntax += "[" + _gadget.info.tknParams[j].possibleValues + "]";
                    break;
            }
            syntax += "</span>,";
        }
        if (syntax[syntax.length - 1] == ',')
            syntax = syntax.substr(0, syntax.length - 1);

        if (_gadget.info.tknParams.length)
            syntax += ")";
        syntax += "<span style = 'font-weight: bold;'>]</span>";

        _c.find(".tknSyntax").html(syntax);

        // load examples
        if (_gadget.info.examples.length == 0) {
            _c.find(".tknExamplesC").hide();
        } else {
            var _cExamples = _c.find(".tknExampleList").empty();
            for (var j = 0; j < _gadget.info.examples.length; j++) {
                var _tplExmple = jQuery("#tplTknExample").clone().removeAttr("id");
                _tplExmple.find(".exCode").text(_gadget.info.examples[j].codeSnippet);
                _tplExmple.find(".exDesc").html(_gadget.info.examples[j].desc);

                var _codeSnippet = _gadget.info.examples[j].codeSnippet;
                _tplExmple.find(".exTest").click(function () {
                    avt.mt.tkn.testToken(_codeSnippet);
                    return false;
                }).attr("href", "#");
                //_tplExmple.find(".exTest") //"javascript: avt.mt.tkn.testToken(avt.mt.gadgets[" + _gadget.index + "].info.examples[" + j + "].codeSnippet);");
                _cExamples.append(_tplExmple.show());
            }
        }

        // done loading
        _c.find(".tknLoading").hide();
        _c.find(".tknNotLoaded").show();
        _c.find(".nsNoInfo").hide();
    }


}


avt.mt.wnd = {
    
    _idPrefix: "tabs-tkn-",
    _idTabs: "tknTabs",
    
    create: function(tpl, id, title, bSel, bShowClose) {
    
        var _id = avt.mt.wnd._idPrefix + id;
        var _tabs = jQuery("#" + avt.mt.wnd._idTabs);
        
        // check if it already exists
        var _tplBody = _tabs.find("#" + _id);
        if (_tplBody.size() == 0) {
        
            _tplBody = jQuery(tpl).clone().attr("id", _id);

            _tabs.append(_tplBody.show());
            _tabs.tabs("add", "#" + _id, title);
            
            if (bShowClose !== false) {
                jQuery("[href='#" + _id + "']").parent()
                    .append("<a href = \"javascript: ;\" onclick = \"avt.mt.wnd.close('"+ id +"');\" class = \"lnkTabClose\">x</a>");
            }
            
            avt.mt.studio.initAllTooltips(_tplBody);
        }
        
        if (bSel !== false) {
            _tabs.tabs("select", "#" + _id);
        }
        _tplBody.find(".btnjQuery").button();
        return _tplBody;
    },
    
    
    close: function(tabId) {
    
        var _id = (tabId.indexOf("-") > 0 ? tabId : avt.mt.wnd._idPrefix + tabId);
        var _tabs = jQuery("#" + avt.mt.wnd._idTabs);
        
        var _nextTab = _tabs.find("[href=#"+ _id +"]").parents("li:first").next();
        while (_nextTab.length != 0 && (_nextTab.find("a:visible").length == 0 || _nextTab.hasClass("ui-state-disabled"))){
            _nextTab = _nextTab.next();
        }
        
        if (_nextTab.length == 0 || typeof(_nextTab.find("a").attr("href")) == "undefined") {
            _nextTab = _tabs.find("[href=#"+ _id +"]").parents("li:first").prev();
            while (_nextTab.length != 0 && (_nextTab.find("a:visible").length == 0 || _nextTab.hasClass("ui-state-disabled"))){
                _nextTab = _nextTab.prev();
            }
        }
        
        if (typeof(_nextTab.find("a").attr("href")) != "undefined") {
            _tabs.tabs("select", _nextTab.find("a").attr("href").substr('ui-tabs-'.length + 2));
        }
        
        _tabs.find("[href=#" + _id + "]").parents("li:first").remove();
        jQuery("#" + _id).remove();
    }
}




avt.mt.obsObj = function(obj) {
    this.handlers = {};
    this.glbHandlers = {};
    this.obj = obj;
    this.guidOO = 1;
    
    this.observe = function(props, handler) {
    
        if (!handler.guidOO)
            handler.guidOO = this.guidOO++;
            
        if (typeof props == 'string') {
            if (props == "*") { // global handler
                this.glbHandlers[handler.guidOO] = handler;
                return;
            }
            props = [props];
        }
        
        // bind handler to all named properties
        for (var i = 0; i < props.length; i++) {
            if (typeof(this.handlers[props[i]]) == "undefined")
                this.handlers[props[i]] = {};
            this.handlers[props[i]][handler.guidOO] = handler;
        }
    };
    
    this.unObserve = function(props, handler) {
        
        if (typeof props == 'string') {
            if (props == "*") { // remove all handlers
                
                delete this.handlers; 
                this.handlers = {};
                
                delete this.glbHandlers; 
                this.glbHandlers = {};
                
                return;
            }
            props = [props];
        }
        
        for (var i = 0; i < props.length; i++) {
            if (typeof this.handlers[props[i]] == "undefined")
                continue;
                
            if (typeof handler == "undefined" || !handler.guidOO) { // remove all handlers for given property
                delete this.handlers[props[i]];
            } else { // remove only given handler
                if (typeof this.handlers[props[i]][handler.guidOO] != undefined) {
                    delete this.handlers[props[i]][handler.guidOO];
                }
            }
        }
    }
    
    this.set = function(propsAndVals) {
        var toNotify = {};
        for (var prop in propsAndVals) {
            obj[prop] = propsAndVals[prop];
            if (typeof(this.handlers[prop]) != "undefined") {
                for (var guidOO in this.handlers[prop]) {
                    toNotify[this.handlers[prop][guidOO].guidOO] = this.handlers[prop][guidOO];
                }
            }
        }
        
        for (var guidOO in this.glbHandlers) {
            toNotify[guidOO] = this.glbHandlers[guidOO];
        }

        for (var guidOO in toNotify) {
            toNotify[guidOO].apply(this.obj);
        }
        
    };
};

avt.mt.obsArr = function(arr) {
    this.handlers = {"add":{},"edit":{},"delete":{}};
    this.arr = arr;
    this.guidOA = 1;

    // actions = [add,edit,delete]
    this.observe = function(actions, handler) {
    
        if (!handler.guidOA)
            handler.guidOA = this.guidOA++;
            
        if (typeof actions == 'string') {
            if (actions == "*") { // global handler
                actions = ["add","edit","delete"];
            } else {
                actions = [actions];
            }
        }
        
        // bind handlers
        for (var i = 0; i < actions.length; i++) {
            this.handlers[actions[i]][handler.guidOA] = handler;
        }
    };
    
    this.unObserve = function(actions, handler) {
        
        if (typeof actions == 'string') {
            if (actions == "*") { // remove all handlers
                
                delete this.handlers; 
                this.handlers = {"add":{},"edit":{},"delete":{}};
                
                return;
            }
            actions = [actions];
        }
        
        for (var i = 0; i < actions.length; i++) {
            if (typeof handler == "undefined" || !handler.guidOA) { // remove all handlers for given property
                delete this.handlers[actions[i]];
                this.handlers[actions[i]] = {};
            } else { // remove only given handler
                if (typeof this.handlers[actions[i]][handler.guidOA] != undefined) {
                    delete this.handlers[actions[i]][handler.guidOA];
                }
            }
        }
    }
    
    this.set = function(i, propsAndVals) {

        for (var prop in propsAndVals) {
            this.arr[i][prop] = propsAndVals[prop];
            
            // notify
            for (var guidOA in this.handlers["edit"]) {
                this.handlers["edit"][guidOA].apply(this.arr[i]);
            }
        }
        
    };
    
    this.add = function(obj) {
        this.arr.push(obj);
        
        // notify
        for (var guidOA in this.handlers["add"]) {
            this.handlers["add"][guidOA].apply(obj);
        }
    }
    
    this.remove = function(i) {
        var obj = this.arr.splice(i,1);

        // notify
        for (var guidOA in this.handlers["delete"]) {
            this.handlers["delete"][guidOA].apply(obj[0]);
        }
    }
};
