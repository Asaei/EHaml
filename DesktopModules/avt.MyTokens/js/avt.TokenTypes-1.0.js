
var g_dlgTokenOffset = 0;

avt.mt.tkn = {


    empty: {
        id: -1,
        name: "",
        desc: "",
        TknNs: null,
        cache: "0",
        cacheLayer: "global",
        src: { type: "string", text: "" }, //"http", // tknSrcType
        parser: { type: "string", replace: false }
    },


    newToken: function (TknNsId) {
        /* avt.mt.tkn.current = {};
        var _tknNs = avt.mt.studio.getTknNs(TknNsId);
        jQuery.extend(true, avt.mt.tkn.current, avt.mt.tkn.empty);
        jQuery("[href='#tabs-tkn-new2']").text("New Token").show();
        jQuery("#tknTabs").tabs("select", 4);
        avt.mt.tkn.showGeneral(); */

        //var _c = avt.mt.wnd.create('#tplTknWizard', 'newtkn' + (new Date()).getTime(), 'New Token');
        var _c = $('#tplTknWizard').clone().removeAttr("id");
        _c.appendTo(document.body);

        avt.mt.studio.initAllTooltips(_c);

        _c.dialog({
            bgiframe: false,
            autoOpen: true,
            title: "New Token",
            width: 600,
            modal: false,
            resizable: false,
            closeOnEscape: true,

            close: function (event, ui) {
                $(this).dialog("destroy").remove();
            }
        });

        var _d = _c.parents(".ui-dialog:first");
        _d.css({ "left": _d.position().left + g_dlgTokenOffset, "top": Math.max(0, _d.position().top + g_dlgTokenOffset) });

        g_dlgTokenOffset += 20;
        if (g_dlgTokenOffset > 40)
            g_dlgTokenOffset = -40;

        _c[0].tkn = jQuery.extend(true, {}, avt.mt.tkn.empty);
        //_c[0].tkn.tknNs = avt.mt.studio.getTknNs(TknNsId);
        avt.mt.tkn.showGeneral(_c);

        var _ddNs = _c.find("[name='wiz_tknNs']");
        _ddNs.addClass("ddNsSync");

        _ddNs.change(function (e) {
            if ($(this).val() == "-1") {
                avt.mt.studio.newNamespace(this);
                $(this).find(".lastSel").attr("selected", "selected");
            } else {
                $(this).find(".lastSel").removeClass("lastSel");
                $(this).find(":selected").addClass("lastSel");
            }
        })

        // this will fill the namespaces dropdown
        avt.mt.studio.syncNs();
        _ddNs.change();

        // and auto select namespace id (if any)
        if (TknNsId > 0)
            _ddNs.val(TknNsId);
    },

    editToken: function (tknSummaryRoot) { // TODO: obsolete old tokens

        var tknId = parseInt(tknSummaryRoot.find(".tknId:first").text());
        var TknNsId = parseInt(tknSummaryRoot.parents(".tknViewNamespace:first").find(".nsId").text());
        avt.mt.tkn.editTokenByIds(tknId, TknNsId);
    },

    editTokenByIds: function (tknId, TknNsId) { // TODO: obsolete old tokens

        var _tknNs = avt.mt.studio.getTknNs(TknNsId);
        var _tkn;

        for (var j = 0; j < _tknNs.tokens.length; j++) {
            if (_tknNs.tokens[j].id == tknId) {
                _tkn = jQuery.extend(true, {}, _tknNs.tokens[j]);
                break;
            }
        }

        if (_tkn.src.type == "razor" || _tkn.src.type == "spark") {
            editScript(_tkn.id, TknNsId, _tkn.name, _tkn.desc, _tkn.src.type, _tkn.src.lang, _tkn.cache, _tkn.cacheLayer, _tkn.src.script, _tkn.src.assemblies);
            return;
        }

        avt.mt.tkn.current = jQuery.extend(true, {}, _tkn);

        //var _c = avt.mt.wnd.create('#tplTknWizard', 'tkn' + _tkn.id, "[" + _tknNs.name + ":<b>" + _tkn.name + "</b>]");
        var _c = $('#tplTknWizard').clone().removeAttr("id");
        avt.mt.studio.initAllTooltips(_c);
        _c.dialog({
            bgiframe: false,
            autoOpen: true,
            title: "Edit Token [" + _tknNs.name + ":" + _tkn.name + "]",
            width: 600,
            modal: false,
            resizable: false,
            closeOnEscape: true,

            close: function (event, ui) {
                $(this).dialog("destroy").remove();
            }
        });

        var _d = _c.parents(".ui-dialog:first");
        _d.css({ "left": _d.position().left + g_dlgTokenOffset, "top": Math.max(0, _d.position().top + g_dlgTokenOffset) });

        g_dlgTokenOffset += 20;
        if (g_dlgTokenOffset > 40)
            g_dlgTokenOffset = -40;


        _c[0].tkn = jQuery.extend(true, {}, avt.mt.tkn.current);
        _c[0].tknNs = TknNsId;
        //_c[0].tkn.tknNs = avt.mt.studio.getTknNs(TknNsId);
        avt.mt.tkn.showGeneral(_c);

        var _ddNs = _c.find("[name='wiz_tknNs']");
        _ddNs.addClass("ddNsSync");

        _ddNs.change(function (e) {
            if ($(this).val() == "-1") {
                avt.mt.studio.newNamespace(this);
                $(this).find(".lastSel").attr("selected", "selected");
            } else {
                $(this).find(".lastSel").removeClass("lastSel");
                $(this).find(":selected").addClass("lastSel");
            }
        }).change();

        // this will fill the namespaces dropdown
        avt.mt.studio.syncNs();

        // and auto select namespace id (if any)
        _ddNs.val(TknNsId);
    },

    showGeneral: function (_wiz) {
        _wiz.find(".tknwizard").hide();
        _wiz.find(".wizerror").hide();

        var _c = _wiz.find(".wizStep1");
        _c.find(".wizerrTokenName").hide();
        if (_wiz[0].tkn.nsid) _c.find("[name=wiz_tknNs]").val(_wiz[0].tkn.nsid);
        if (_wiz[0].tkn.name) _c.find("[name=wiz_tknName]").val(_wiz[0].tkn.name);
        if (_wiz[0].tkn.desc) _c.find("[name=wiz_tknDesc]").val(_wiz[0].tkn.desc);
        if (_wiz[0].tkn.src && _wiz[0].tkn.src.type) _c.find("[name=wiz_tknSourceType]").val(_wiz[0].tkn.src.type);
        if (_wiz[0].tkn.cache) _c.find("[name=wiz_tknCacheTime]").val(_wiz[0].tkn.cache);
        if (_wiz[0].tkn.cacheLayer) _c.find("[name=wiz_tknCacheLayer]").val(_wiz[0].tkn.cacheLayer);
        if (_wiz[0].tkn.defVal) _c.find("[name=wiz_tknDefVal]").val(_wiz[0].tkn.defVal);

        //_c.find(".nsName").text(_wiz[0].tkn.tknNs.name);

        _c.show();
    },

    submitGeneral: function (_wiz) {
        var _c = _wiz.find(".wizStep1");
        _wiz.find(".wizerror").hide();

        var nsid = parseInt(_c.find("[name=wiz_tknNs]").val());
        var name = jQuery.trim(_c.find("[name=wiz_tknName]").val());
        if (name.length == 0 || isNaN(nsid) || nsid <= 0) {
            _c.find(".wizerrTokenName").text("Token Name is required!").show();
            return;
        }

        // check token name is unique
        var _ns = avt.mt.studio.getTknNs(_c.find("[name=wiz_tknNs]").val());
        var _id = _wiz[0].tkn.id;
        for (var i = 0; i < _ns.tokens.length; i++) {
            if (name.toLowerCase() == _ns.tokens[i].name.toLowerCase() && _ns.tokens[i].id != _id) {
                _c.find(".wizerrTokenName").text("There is already a token with the same name in namespace " + _ns.name + "!").show();
                return;
            }
        }

        _wiz[0].tkn.name = name;
        _wiz[0].tkn.desc = _c.find("[name=wiz_tknDesc]").val();
        _wiz[0].tkn.src.type = _c.find("[name=wiz_tknSourceType]").val();
        _wiz[0].tkn.cache = _c.find("[name=wiz_tknCacheTime]").val();
        _wiz[0].tkn.cacheLayer = _c.find("[name=wiz_tknCacheLayer]").val();
        _wiz[0].tkn.defVal = _c.find("[name=wiz_tknDefVal]").val();

        avt.mt.tkn.showSource(_wiz);
    },

    showSource: function (_wiz) {

        _wiz.find(".tknwizard").hide();
        _wiz.find(".wizerror").hide();

        var _c = _wiz.find(".wizStep2");
        var tpl = jQuery("#" + avt.mt.tkn.tknSrcType[_wiz[0].tkn.src.type].tpl).clone().removeAttr("id");
        _c.find(".tknType").text(avt.mt.tkn.tknSrcType[_wiz[0].tkn.src.type].title);

        _c.find(".wizSrc").empty().append(tpl.show());
        avt.mt.tkn.tknSrcType[_wiz[0].tkn.src.type].init(_wiz, tpl);
        _c.find("[name='wiz_tknParseType']").val(_wiz[0].tkn.parser.type);
        avt.mt.studio.initAllTooltips(tpl);

        _c.show();
    },

    testHttp: function () {
        alert("Not implemented yet!");
    },

    submitSource: function (_wiz) {
        var _c = _wiz.find(".wizStep2");
        _wiz.find(".wizerror").hide();

        if (avt.mt.tkn.tknSrcType[_wiz[0].tkn.src.type].submit(_wiz, _c) === false) {
            return;
        }

        if (_wiz.find("[name='wiz_tknParseType']").size() > 0) {
            _wiz[0].tkn.parser.type = _wiz.find("[name='wiz_tknParseType']").val();
            avt.mt.tkn.showParsing(_wiz);
        } else {
            avt.mt.tkn.save(_wiz);
        }
    },


    showParsing: function (_wiz) {
        _wiz.find(".tknwizard").hide();
        _wiz.find(".wizerror").hide();

        var _c = _wiz.find(".wizStep3");
        //_wiz[0].tkn.parser = "noparse";

        var tpl = jQuery("#" + avt.mt.tkn.tknParser[_wiz[0].tkn.parser.type].tpl).clone().removeAttr("id");

        _c.find(".wizParse").empty().append(tpl.show());
        avt.mt.tkn.tknParser[_wiz[0].tkn.parser.type].init(_wiz, tpl);
        avt.mt.studio.initAllTooltips(tpl);

        // TODO:
        //if (_wiz[0].tkn.parserData && _wiz[0].tkn.parserData.xpath) _c.find("[name=wiz_tknXmlXPath]").val(_wiz[0].tkn.parserData.xpath);

        _c.show();
    },

    submitParsing: function (_wiz) {
        var _c = _wiz.find(".wizStep3");
        _wiz.find(".wizerror").hide();
        if (avt.mt.tkn.tknParser[_wiz[0].tkn.parser.type].submit(_wiz, _c) === false) {
            return;
        }

        avt.mt.tkn.save(_wiz);
    },

    save: function (_wiz) {

        // hide buttons
        _wiz.find(".wizPrev").hide();
        _wiz.find(".wizNext").hide();
        _wiz.find(".wizSave").hide();

        // show loading caption
        _wiz.find(".TknNsSaving").show();

        avt.mt.studio.loading(true);
        var TknNsId = _wiz.find("[name=wiz_tknNs]").val(); // _wiz[0].tkn.tknNs.id;
        jQuery.post(avt.mt.apiUrl, {
            format: "json",
            fn: "save_token",
            id: _wiz[0].tkn.id,
            nsId: TknNsId,
            name: _wiz[0].tkn.name,
            desc: _wiz[0].tkn.desc,
            cache: _wiz[0].tkn.cache,
            cacheLayer: _wiz[0].tkn.cacheLayer,
            defVal: _wiz[0].tkn.defVal,
            src: avt.mt.tkn.tknSrcType[_wiz[0].tkn.src.type].serialize(_wiz),
            // parse: _wiz[0].tkn.parser == "xml" ? avt.mt.tkn.http.buildParseXml() : avt.mt.tkn.http.buildParseJson()
            parser: avt.mt.tkn.tknParser[_wiz[0].tkn.parser.type].serialize(_wiz),
            serverId: _wiz[0].tkn.srvId
            //parse: "<parse><type>string</type></parse>"
        },
            function (data) {

                avt.mt.studio.loading(false);

                var id;
                if (data.error) {
                    jQuery.jGrowl("Failed to create token (internal error: " + data.error + ")", { header: 'Error', life: 5000 });
                    return;
                }

                if (_wiz[0].tkn.id <= 0) {
                    jQuery.jGrowl("Token succesfully created!", { header: 'Success', life: 5000 });
                } else {
                    jQuery.jGrowl("Token succesfully updated!", { header: 'Success', life: 5000 });
                }

                // delete _wiz[0].tkn.tknNs;

                var bUpdate = _wiz[0].tkn.id > 0;
                _wiz[0].tkn = data;

                // update local token source
                var _tknNs = avt.mt.studio.getTknNs(TknNsId);
                if (_wiz[0].tknNs && _wiz[0].tknNs != TknNsId) {
                    // remove from old namespace
                    var _oldTknNs = avt.mt.studio.getTknNs(_wiz[0].tknNs);
                    for (var j = 0; j < _oldTknNs.tokens.length; j++) {
                        if (_oldTknNs.tokens[j].id == _wiz[0].tkn.id) {
                            _oldTknNs.tokens.splice(j, 1);
                            break;
                        }
                    }
                }

                if (bUpdate) {
                    var bFound = false;
                    for (var j = 0; j < _tknNs.tokens.length; j++) {
                        if (_tknNs.tokens[j].id == _wiz[0].tkn.id) {
                            _tknNs.tokens[j] = _wiz[0].tkn;
                            bFound = true;
                            break;
                        }
                    }
                    if (!bFound)
                        _tknNs.tokens.push(jQuery.extend(true, {}, _wiz[0].tkn));
                } else {
                    _tknNs.tokens.push(jQuery.extend(true, {}, _wiz[0].tkn));
                }

                _tknNs.tokens.sort(function (a, b) {
                    if (a.name.toLowerCase() < b.name.toLowerCase())
                        return -1;
                    return 1;
                });

                // check sync
                avt.mt.tkn.tknSrcType[_wiz[0].tkn.src.type].sync(_wiz[0].tkn);

                // hide wizard
                avt.mt.tkn.hideNewToken(_wiz);

                // also reload prev token source (if any)
                if (_wiz[0].tknNs && _wiz[0].tknNs != TknNsId) {
                    avt.mt.studio.showTknNs(_wiz[0].tknNs);
                }

                // reload token source
                avt.mt.studio.showTknNs(TknNsId);

                // reload tree
                g_tknTree.jstree("refresh");

            }, "json");
    },

    cloneToken: function (tknSummaryRoot) {

        var tknId = parseInt(tknSummaryRoot.find(".tknId:first").text());
        var TknNsId = parseInt(tknSummaryRoot.parents(".tknViewNamespace:first").find(".nsId").text());

        avt.mt.studio.loading(true);

        jQuery.post(avt.mt.apiUrl, {
            format: "json",
            fn: "clone_token",
            id: tknId
        },
            function (data) {

                avt.mt.studio.loading(false);

                if (data.error) {
                    jQuery.jGrowl("Failed to clone token (internal error: " + data.error + ")", { header: 'Error', life: 5000 });
                    return;
                }

                jQuery.jGrowl("Token succesfully created!", { header: 'Success', life: 5000 });

                // update local token source
                var _tknNs = avt.mt.studio.getTknNs(TknNsId);
                _tknNs.tokens.push(jQuery.extend(true, {}, data));

                // check sync
                avt.mt.tkn.tknSrcType[data.src.type].sync(data);

                // reload token source
                avt.mt.studio.showTknNs(TknNsId);

                // reload tree
                g_tknTree.jstree("refresh");

            }, "json");
    },

    hideNewToken: function (_wiz) {
        //avt.mt.wnd.close(_wiz.attr('id'));
        _wiz.dialog("destroy");
    },

    deleteToken: function (tknSummaryRoot) {
        var tknId = parseInt(tknSummaryRoot.find(".tknId:first").text());
        var TknNsId = parseInt(tknSummaryRoot.parents(".tknViewNamespace:first").find(".nsId").text());

        avt.mt.studio.loading(true);
        jQuery.post(avt.mt.apiUrl, {
            format: "json",
            fn: "delete_token",
            id: tknId
        },
            function (data) {

                avt.mt.studio.loading(false);

                if (data.error) {
                    jQuery.jGrowl("Failed to delete token (internal error: " + data.error + ")", { header: 'Error', life: 5000 });
                    return;
                }

                jQuery.jGrowl("Token succesfully deleted!", { header: 'Success', life: 5000 });

                // remove token from namespace
                var _tknNs = avt.mt.studio.getTknNs(TknNsId);
                var _tkn;

                for (var j = 0; j < _tknNs.tokens.length; j++) {
                    if (_tknNs.tokens[j].id == tknId) {
                        _tknNs.tokens.splice(j, 1);
                        //_tkn = jQuery.extend(true, {}, _tknNs.tokens[j]);
                        break;
                    }
                }

                // reload token source
                avt.mt.studio.showTknNs(TknNsId);

                // reload tree
                g_tknTree.jstree("refresh");

            }, "json");

    },

    testToken: function (tknUsage) {
        outerLayout.open("south");
        jQuery("#testTokensInput").val(tknUsage);
        avt.mt.studio.replaceTokensTest();
    }
}

avt.mt.tkn.noparse = {
    init: function(_tpl) {
        
    }
}

avt.mt.tkn.http = {
    buildRuleXml: function() {
        
    },
    
    encodeXml: function(str) {
        if (str)
            return str.replace(/&/g, "&amp;").replace(/\"/g, "&quot;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
        return ""
    },
    
    buildParseXml: function() {
        var _c = jQuery("#wizStep3");
        return _c.find("[name=wiz_tknXmlXPath]").val();
    },
    
    buildParseJson: function() {
        var _c = jQuery("#wizStep3");
        return _c.find("[name=wiz_tknJsonXPath]").val();
    }
}

avt.mt.tkn.tknSrcType = {
    string: {
        title: "Constant String",
        tpl: "tplTknCt",
        init: function (_wiz, _tpl) {
            if (_wiz[0].tkn.src.text) {
                _tpl.find("[name=wiz_ctBody]").val(_wiz[0].tkn.src.text);
            }
        },
        submit: function (_wiz, _tpl) {
            var _str = jQuery.trim(_tpl.find("[name=wiz_ctBody]").val());
            if (_str.length == 0) {
                _tpl.find(".wizerrCtSrc").text("String is required!").show();
                return false;
            }
            _wiz[0].tkn.src.text = _str;
        },
        serialize: function (_wiz) {
            return "<src><type>string</type><text>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.text) + "</text></src>";
        },

        sync: function (tkn) {
        }
    },
    db: {
        title: "Database",
        tpl: "tplTknDb",
        init: function (_wiz, _tpl) {

            // populate sync dropdown
            var _dbTkns = avt.mt.studio.getTokensByType("db");
            var _ddSync = _wiz.find("[name=wiz_dbSync]").empty();
            var _ddSyncList = _wiz.find(".wiz_dbSyncList").empty();

            _ddSync.append("<option value = '-1'>- Not Synchronized -</option>");
            _ddSyncList.append("Following tokens are in sync with this token source:");

            _wiz[0].tkn.synched = [];
            for (var i = 0; i < _dbTkns.length; i++) {
                if (_wiz[0].tkn.id != -1 && _dbTkns[i].src.syncTknId == _wiz[0].tkn.id) {
                    _ddSyncList.append("<li>[" + _dbTkns[i].ns.name + ":" + _dbTkns[i].name + "] <a href='javascript: ;' onclick='avt.mt.tkn.editTokenByIds(" + _dbTkns[i].id + "," + _dbTkns[i].ns.id + ");'><img src = '" + avt.mt.modRoot + "res/edit.gif' border = '0' /></a></li>");
                    _wiz[0].tkn.synched.push(_dbTkns[i].id);
                } else {
                    if (_dbTkns[i].src.syncTknId == -1 || avt.mt.studio.getTkn(_dbTkns[i].src.syncTknId) == null) {
                        _ddSync.append("<option value = '" + _dbTkns[i].id + "'> [" + _dbTkns[i].ns.name + ":" + _dbTkns[i].name + "] </option>");
                    }
                }
            }

            if (_ddSyncList.find("li").length > 0) {
                // this a sync point, can't be synced with other tokens
                _ddSync.hide();
                _ddSyncList.show();
            } else {
                _ddSyncList.hide();
                _ddSync.show();
            }

            // check value
            if (_wiz[0].tkn.src.syncTknId > 1) {
                var tknSync = avt.mt.studio.getTkn(_wiz[0].tkn.src.syncTknId);
                if (tknSync != null) {
                    _ddSync.val(tknSync.id);
                    avt.mt.tkn.tknSrcType.db.syncChanged(_ddSync);
                }
            }

            if (_wiz[0].tkn.src.sql) {
                _tpl.find("[name=wiz_dbSql]").val(_wiz[0].tkn.src.sql);
            }
            if (_wiz[0].tkn.src.cols) {
                _tpl.find("[name=wiz_dbColumnNames]").val(_wiz[0].tkn.src.cols);
            }
            if (_wiz[0].tkn.src.col) {
                _tpl.find("[name=wiz_dbColumn]").val(_wiz[0].tkn.src.col);
            }
            if (_wiz[0].tkn.src.connStr) {
                _tpl.find("[name=wiz_dbConnStr]").val(_wiz[0].tkn.src.connStr);
            }
        },

        syncChanged: function (dd) {
            dd = jQuery(dd);

            var _wiz = dd.parents(".tknWizardRoot:first");

            var _tknSyncId = parseInt(dd.val());
            if (isNaN(_tknSyncId) || _tknSyncId < 0) {
                //_wiz.find("[name=wiz_dbSql]").removeClass("wizInputDisabled").removeAttr("readonly");
                //_wiz.find("[name=wiz_dbConnStr]").removeClass("wizInputDisabled").removeAttr("readonly");
                _wiz.find(".srcSync").hide();
                if (_wiz[0].tkn.src.sql) {
                    _wiz.find("[name=wiz_dbSql]").val(_wiz[0].tkn.src.sql);
                }
                if (_wiz[0].tkn.src.connStr) {
                    _wiz.find("[name=wiz_dbConnStr]").val(_wiz[0].tkn.src.connStr);
                }
                return;
            }


            var _tknSync = avt.mt.studio.getTkn(_tknSyncId);
            if (_tknSync != null) {

                if (_tknSync.src.sql) {
                    _wiz.find("[name=wiz_dbSql]").val(_tknSync.src.sql);
                }
                //_wiz.find("[name=wiz_dbSql]").addClass("wizInputDisabled").attr("readonly", "readonly");

                if (_tknSync.src.connStr) {
                    _wiz.find("[name=wiz_dbConnStr]").val(_tknSync.src.connStr);
                }
                _wiz.find(".srcSync").show();
                //_wiz.find("[name=wiz_dbConnStr]").addClass("wizInputDisabled").attr("readonly", "readonly");
            }
        },

        submit: function (_wiz, _tpl) {

            var _sql = jQuery.trim(_tpl.find("[name=wiz_dbSql]").val());
            var _cols = jQuery.trim(_tpl.find("[name=wiz_dbColumnNames]").val());
            var _col = jQuery.trim(_tpl.find("[name=wiz_dbColumn]").val());
            var _connStr = jQuery.trim(_tpl.find("[name=wiz_dbConnStr]").val());
            var bError = false;

            if (_sql.length == 0) {
                _tpl.find(".wizerrDbSql").text("Please input SQL!").show();
                _tpl.find("[name=wiz_dbSql]").focus();
                bError = true;
            }

            if (_cols.length == 0) {
                _tpl.find(".wizerrDbCol").text("Please input column name to extract!").show();
                _tpl.find("[name=wiz_dbColumnNames]").focus();
                bError = true;
            }

            if (bError == true)
                return false;

            _wiz[0].tkn.src.syncTknId = parseInt(_tpl.find("[name=wiz_dbSync]").val());
            _wiz[0].tkn.src.sql = _sql;
            _wiz[0].tkn.src.cols = _cols;
            _wiz[0].tkn.src.col = _col;
            _wiz[0].tkn.src.connStr = _connStr;
        },
        serialize: function (_wiz) {
            return "<src><type>db</type><syncTknId>" + _wiz[0].tkn.src.syncTknId + "</syncTknId><connStr>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.connStr) + "</connStr><sql>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.sql) + "</sql><cols>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.cols) + "</cols><col>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.col) + "</col></src>";
        },

        sync: function (tkn) {
            var _tknSync = avt.mt.studio.getTkn(parseInt(tkn.src.syncTknId));
            if (_tknSync) {
                _tknSync.src.sql = tkn.src.sql;
                _tknSync.src.connStr = tkn.src.connStr;
            }

            if (tkn.synched) {
                for (var i = 0; i < tkn.synched.length; i++) {
                    var _tknSync = avt.mt.studio.getTkn(parseInt(tkn.synched[i]));
                    if (_tknSync) {
                        _tknSync.src.sql = tkn.src.sql;
                        _tknSync.src.connStr = tkn.src.connStr;
                    }
                }
            }
        }
    },
    http: {
        title: "Http Request",
        tpl: "tplTknHttp",
        init: function (_wiz, _tpl) {
            if (!_wiz[0].tkn.src) {
                _wiz[0].tkn.src = { url: "", get: "", post: "", headers: "" };
            }

            // populate sync dropdown
            var _dbTkns = avt.mt.studio.getTokensByType("http");
            var _ddSync = _wiz.find("[name=wiz_httpSync]").empty();
            var _ddSyncList = _wiz.find(".wiz_httpSyncList").empty();

            _ddSync.append("<option value = '-1'>- Not Synchronized -</option>");
            _ddSyncList.append("Following tokens are in sync with this token source:");

            _wiz[0].tkn.synched = [];

            for (var i = 0; i < _dbTkns.length; i++) {
                if (_wiz[0].tkn.id != -1 && _dbTkns[i].src.syncTknId == _wiz[0].tkn.id) {
                    _ddSyncList.append("<li>[" + _dbTkns[i].ns.name + ":" + _dbTkns[i].name + "] <a href='javascript: ;' onclick='avt.mt.tkn.editTokenByIds(" + _dbTkns[i].id + "," + _dbTkns[i].ns.id + ");'><img src = '" + avt.mt.modRoot + "res/edit.gif' border = '0' /></a></li>");
                    _wiz[0].tkn.synched.push(_dbTkns[i].id);
                } else {
                    if (_dbTkns[i].src.syncTknId == -1 || avt.mt.studio.getTkn(_dbTkns[i].src.syncTknId) == null) {
                        _ddSync.append("<option value = '" + _dbTkns[i].id + "'> [" + _dbTkns[i].ns.name + ":" + _dbTkns[i].name + "] </option>");
                    }
                }
            }

            if (_ddSyncList.find("li").length > 0) {
                // this a sync point, can't be synced with other tokens
                _ddSync.hide();
                _ddSyncList.show();
            } else {
                _ddSyncList.hide();
                _ddSync.show();
            }


            // check value
            if (_wiz[0].tkn.src.syncTknId > 1) {
                var tknSync = avt.mt.studio.getTkn(_wiz[0].tkn.src.syncTknId);
                if (tknSync != null) {
                    _ddSync.val(tknSync.id);
                    avt.mt.tkn.tknSrcType.http.syncChanged(_ddSync);
                }
            }


            if (_wiz[0].tkn.src.url) _tpl.find("[name=wiz_tknUrl]").val(_wiz[0].tkn.src.url);
            if (_wiz[0].tkn.src.get) _tpl.find("[name=wiz_tknGetParams]").val(_wiz[0].tkn.src.get);
            if (_wiz[0].tkn.src.post) _tpl.find("[name=wiz_tknPostParams]").val(_wiz[0].tkn.src.post);
            if (_wiz[0].tkn.src.headers) _tpl.find("[name=wiz_tknHttpHeaders]").val(_wiz[0].tkn.src.headers);
            //if (_wiz[0].tkn.parser) _tpl.find("[name=wiz_tknParseType]").val(_wiz[0].tkn.parser);
        },

        syncChanged: function (dd) {
            dd = jQuery(dd);

            var _wiz = dd.parents(".tknWizardRoot:first");

            var _tknSyncId = parseInt(dd.val());
            if (isNaN(_tknSyncId) || _tknSyncId < 0) {
                _wiz.find(".srcSync").hide();
                if (_wiz[0].tkn.src.url) {
                    _wiz.find("[name=wiz_tknUrl]").val(_wiz[0].tkn.src.url);
                }
                if (_wiz[0].tkn.src.get) {
                    _wiz.find("[name=wiz_tknGetParams]").val(_wiz[0].tkn.src.get);
                }
                if (_wiz[0].tkn.src.post) {
                    _wiz.find("[name=wiz_tknPostParams]").val(_wiz[0].tkn.src.post);
                }
                if (_wiz[0].tkn.src.headers) {
                    _wiz.find("[name=wiz_tknHttpHeaders]").val(_wiz[0].tkn.src.headers);
                }
                return;
            }

            var _tknSync = avt.mt.studio.getTkn(_tknSyncId);
            if (_tknSync != null) {

                if (_tknSync.src.url) {
                    _wiz.find("[name=wiz_tknUrl]").val(_tknSync.src.url);
                }

                if (_tknSync.src.get) {
                    _wiz.find("[name=wiz_tknGetParams]").val(_tknSync.src.get);
                }

                if (_tknSync.src.post) {
                    _wiz.find("[name=wiz_tknPostParams]").val(_tknSync.src.post);
                }

                if (_tknSync.src.headers) {
                    _wiz.find("[name=wiz_tknHttpHeaders]").val(_tknSync.src.headers);
                }

                _wiz.find(".srcSync").show();
            }
        },

        submit: function (_wiz, _tpl) {

            var _url = jQuery.trim(_tpl.find("[name=wiz_tknUrl]").val());
            if (_url.length == 0) {
                _tpl.find(".wizerrHttpUrl").text("Please input URL to connect to!").show();
                return false;
            }

            _wiz[0].tkn.src.syncTknId = parseInt(_tpl.find("[name=wiz_httpSync]").val());
            _wiz[0].tkn.src.url = _url;
            _wiz[0].tkn.src.get = _tpl.find("[name=wiz_tknGetParams]").val();
            _wiz[0].tkn.src.post = _tpl.find("[name=wiz_tknPostParams]").val();
            _wiz[0].tkn.src.headers = _tpl.find("[name=wiz_tknHttpHeaders]").val();
            //_wiz[0].tkn.parser = _tpl.find("[name=wiz_tknParseType]").val();
        },
        serialize: function (_wiz) {
            var ruleXml = "";

            ruleXml += "<src>";
            ruleXml += "<type>http</type>";
            ruleXml += "<syncTknId>" + _wiz[0].tkn.src.syncTknId + "</syncTknId>";
            ruleXml += "<url>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.url) + "</url>";
            ruleXml += "<get>";
            var getParams = _wiz[0].tkn.src.get.split("\n");
            for (var i in getParams)
                if (jQuery.trim(getParams[i]).length > 0)
                    ruleXml += "<p>" + avt.mt.tkn.http.encodeXml(getParams[i]) + "</p>";
            ruleXml += "</get>";
            ruleXml += "<post>";
            if (_wiz[0].tkn.src.post.indexOf("<soap:Envelope") == -1 && _wiz[0].tkn.src.post.indexOf("<soap12:Envelope") == -1
                 && _wiz[0].tkn.src.post.indexOf("<?xml ") != 0) {
                var postParams = _wiz[0].tkn.src.post.split("\n");
                for (var i in postParams)
                    if (jQuery.trim(postParams[i]).length > 0)
                        ruleXml += "<p>" + avt.mt.tkn.http.encodeXml(postParams[i]) + "</p>";
            } else {
                ruleXml += "<p>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.post) + "</p>";
            }

            ruleXml += "</post>";
            ruleXml += "<headers>";
            var httpHeaders = _wiz[0].tkn.src.headers.split("\n");
            for (var i in httpHeaders)
                if (jQuery.trim(httpHeaders[i]).length > 0)
                    ruleXml += "<h>" + avt.mt.tkn.http.encodeXml(httpHeaders[i]) + "</h>";
            ruleXml += "</headers>";
            //ruleXml += "<response>"+ _wiz[0].tkn.parser +"</response>";
            ruleXml += "</src>";

            return ruleXml;
        },

        sync: function (tkn) {
            var _tknSync = avt.mt.studio.getTkn(parseInt(tkn.src.syncTknId));
            if (_tknSync) {
                _tknSync.src.url = tkn.src.url;
                _tknSync.src.get = tkn.src.get;
                _tknSync.src.post = tkn.src.post;
                _tknSync.src.headers = tkn.src.headers;
            }

            if (tkn.synched) {
                for (var i = 0; i < tkn.synched.length; i++) {
                    var _tknSync = avt.mt.studio.getTkn(parseInt(tkn.synched[i]));
                    if (_tknSync) {
                        _tknSync.src.url = tkn.src.url;
                        _tknSync.src.get = tkn.src.get;
                        _tknSync.src.post = tkn.src.post;
                        _tknSync.src.headers = tkn.src.headers;
                    }
                }
            }
        }
    },
    file: {
        title: "File System",
        tpl: "tplTknFile",
        init: function (_wiz, _tpl) {
            if (!_wiz[0].tkn.src) {
                _wiz[0].tkn.src = { path: "" };
            }

            // populate sync dropdown
            var _dbTkns = avt.mt.studio.getTokensByType("file");
            var _ddSync = _wiz.find("[name=wiz_fileSync]").empty();
            var _ddSyncList = _wiz.find(".wiz_fileSyncList").empty();

            _ddSync.append("<option value = '-1'>- Not Synchronized -</option>");
            _ddSyncList.append("Following tokens are in sync with this token source:");

            _wiz[0].tkn.synched = [];
            for (var i = 0; i < _dbTkns.length; i++) {
                if (_wiz[0].tkn.id != -1 && _dbTkns[i].src.syncTknId == _wiz[0].tkn.id) {
                    _ddSyncList.append("<li>[" + _dbTkns[i].ns.name + ":" + _dbTkns[i].name + "] <a href='javascript: ;' onclick='avt.mt.tkn.editTokenByIds(" + _dbTkns[i].id + "," + _dbTkns[i].ns.id + ");'><img src = '" + avt.mt.modRoot + "res/edit.gif' border = '0' /></a></li>");
                    _wiz[0].tkn.synched.push(_dbTkns[i].id);
                } else {
                    if (_dbTkns[i].src.syncTknId == -1 || avt.mt.studio.getTkn(_dbTkns[i].src.syncTknId) == null) {
                        _ddSync.append("<option value = '" + _dbTkns[i].id + "'> [" + _dbTkns[i].ns.name + ":" + _dbTkns[i].name + "] </option>");
                    }
                }
            }

            if (_ddSyncList.find("li").length > 0) {
                // this a sync point, can't be synced with other tokens
                _ddSync.hide();
                _ddSyncList.show();
            } else {
                _ddSyncList.hide();
                _ddSync.show();
            }


            // check value
            if (_wiz[0].tkn.src.syncTknId > 1) {
                var tknSync = avt.mt.studio.getTkn(_wiz[0].tkn.src.syncTknId);
                if (tknSync != null) {
                    _ddSync.val(tknSync.id);
                    avt.mt.tkn.tknSrcType.file.syncChanged(_ddSync);
                }
            }


            if (_wiz[0].tkn.src.path) _tpl.find("[name=wiz_tknPath]").val(_wiz[0].tkn.src.path);
            //if (_wiz[0].tkn.parser) _tpl.find("[name=wiz_tknParseType]").val(_wiz[0].tkn.parser);
        },

        syncChanged: function (dd) {
            dd = jQuery(dd);

            var _wiz = dd.parents(".tknWizardRoot:first");

            var _tknSyncId = parseInt(dd.val());
            if (isNaN(_tknSyncId) || _tknSyncId < 0) {
                _wiz.find(".srcSync").hide();
                if (_wiz[0].tkn.src.path) {
                    _wiz.find("[name=wiz_tknPath]").val(_wiz[0].tkn.src.path);
                }
                return;
            }

            var _tknSync = avt.mt.studio.getTkn(_tknSyncId);
            if (_tknSync != null) {

                if (_tknSync.src.path) {
                    _wiz.find("[name=wiz_tknPath]").val(_tknSync.src.path);
                }

                _wiz.find(".srcSync").show();
            }
        },

        submit: function (_wiz, _tpl) {

            var _path = jQuery.trim(_tpl.find("[name=wiz_tknPath]").val());
            if (_path.length == 0) {
                _tpl.find(".wizerrFilePath").text("Please input file path!").show();
                return false;
            }

            _wiz[0].tkn.src.syncTknId = parseInt(_tpl.find("[name=wiz_fileSync]").val());
            _wiz[0].tkn.src.path = _path;
            //_wiz[0].tkn.parser = _tpl.find("[name=wiz_tknParseType]").val();
        },
        serialize: function (_wiz) {
            var ruleXml = "";

            ruleXml += "<src>";
            ruleXml += "<type>file</type>";
            ruleXml += "<syncTknId>" + _wiz[0].tkn.src.syncTknId + "</syncTknId>";
            ruleXml += "<path>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.path) + "</path>";
            //ruleXml += "<response>"+ _wiz[0].tkn.parser +"</response>";
            ruleXml += "</src>";

            return ruleXml;
        },

        sync: function (tkn) {
            var _tknSync = avt.mt.studio.getTkn(parseInt(tkn.src.syncTknId));
            if (_tknSync) {
                _tknSync.src.path = tkn.src.path;
            }

            if (tkn.synched) {
                for (var i = 0; i < tkn.synched.length; i++) {
                    var _tknSync = avt.mt.studio.getTkn(parseInt(tkn.synched[i]));
                    if (_tknSync) {
                        _tknSync.src.path = tkn.src.path;
                    }
                }
            }
        }
    },

    ftp: {
        title: "FTP",
        tpl: "tplTknFtp",
        init: function (_wiz, _tpl) {
            if (!_wiz[0].tkn.src) {
                _wiz[0].tkn.src = { path: "" };
            }

            // populate servers dropdown
            var _ftpServers = getServersByType("ftp");
            var _ddServers = _wiz.find("[name=wiz_tknSrv]").empty();
            _ddServers.append("<option value='-1'>-- Please Select --</option>");
            for (var i = 0; i < _ftpServers.length; i++) {
                _ddServers.append("<option value='" + _ftpServers[i].id + "'>" + _ftpServers[i].name + "</option>");
            }
            _ddServers.append("<option value='0'>Create New...</option>");

            _ddServers.val(_wiz[0].tkn.srvId);

            if (_wiz[0].tkn.src.path) _tpl.find("[name=wiz_tknPath]").val(_wiz[0].tkn.src.path);
            //if (_wiz[0].tkn.parser) _tpl.find("[name=wiz_tknParseType]").val(_wiz[0].tkn.parser);
        },

        submit: function (_wiz, _tpl) {

            var _srvId = _tpl.find("[name=wiz_tknSrv]").val();
            if (_srvId <= 0) {
                _tpl.find(".wizerrSrv").text("Please select server!").show();
                return false;
            }

            var _path = jQuery.trim(_tpl.find("[name=wiz_tknPath]").val());
            if (_path.length == 0) {
                _tpl.find(".wizerrPath").text("Please input file path!").show();
                return false;
            }

            _wiz[0].tkn.src.path = _path;
            _wiz[0].tkn.srvId = _srvId;
            //_wiz[0].tkn.parser = _tpl.find("[name=wiz_tknParseType]").val();
        },
        serialize: function (_wiz) {
            var ruleXml = "";

            ruleXml += "<src>";
            ruleXml += "<type>ftp</type>";
            ruleXml += "<path>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.path) + "</path>";
            //ruleXml += "<response>"+ _wiz[0].tkn.parser +"</response>";
            ruleXml += "</src>";

            return ruleXml;
        },
        sync: function () { }
    },

    execType: {
        title: "Execute Type (implement IExecutableToken)",
        tpl: "tplTknExecType",
        init: function (_wiz, _tpl) {
            if (!_wiz[0].tkn.src) {
                _wiz[0].tkn.src = { execType: "", execTypeParams: "" };
            }

            if (_wiz[0].tkn.src.execType) _tpl.find("[name=wiz_tknExecType]").val(_wiz[0].tkn.src.execType);
            if (_wiz[0].tkn.src.execTypeParams) _tpl.find("[name=wiz_tknExecTypeParams]").val(_wiz[0].tkn.src.execTypeParams);
            //if (_wiz[0].tkn.parser) _tpl.find("[name=wiz_tknParseType]").val(_wiz[0].tkn.parser);
        },

        syncChanged: function (dd) {

        },

        submit: function (_wiz, _tpl) {

            var _execType = jQuery.trim(_tpl.find("[name=wiz_tknExecType]").val());
            if (_execType.length == 0) {
                _tpl.find(".wizerrExecType").text("Please input IExecutableToken type!").show();
                return false;
            }

            _wiz[0].tkn.src.execType = _execType;
            _wiz[0].tkn.src.execTypeParams = jQuery.trim(_tpl.find("[name=wiz_tknExecTypeParams]").val());
            //_wiz[0].tkn.parser = _tpl.find("[name=wiz_tknParseType]").val();
        },
        serialize: function (_wiz) {
            var ruleXml = "";

            ruleXml += "<src>";
            ruleXml += "<type>execType</type>";
            ruleXml += "<execType>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.execType) + "</execType>";
            ruleXml += "<execTypeParams>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.execTypeParams) + "</execTypeParams>";
            //ruleXml += "<response>"+ _wiz[0].tkn.parser +"</response>";
            ruleXml += "</src>";

            return ruleXml;
        },

        sync: function (tkn) {

        }
    },

    mail: {
        title: "Mail Server",
        tpl: "tplTknMail",
        init: function (_wiz, _tpl) {
            if (!_wiz[0].tkn.src) {
                _wiz[0].tkn.src = { url: "", get: "", post: "" };
            }

            // populate sync dropdown
            var _dbTkns = avt.mt.studio.getTokensByType("mail");
            var _ddSync = _wiz.find("[name=wiz_mailSync]").empty();
            var _ddSyncList = _wiz.find(".wiz_mailSyncList").empty();

            _ddSync.append("<option value = '-1'>- Not Synchronized -</option>");
            _ddSyncList.append("Following tokens are in sync with this token source:");

            for (var i = 0; i < _dbTkns.length; i++) {
                if (_wiz[0].tkn.id != -1 && _dbTkns[i].src.syncTknId == _wiz[0].tkn.id) {
                    _ddSyncList.append("<li>[" + _dbTkns[i].ns.name + ":" + _dbTkns[i].name + "] <a href='javascript: ;' onclick='avt.mt.tkn.editTokenByIds(" + _dbTkns[i].id + "," + _dbTkns[i].ns.id + ");'><img src = '" + avt.mt.modRoot + "res/edit.gif' border = '0' /></a></li>");
                } else {
                    if (_dbTkns[i].src.syncTknId == -1 || avt.mt.studio.getTkn(_dbTkns[i].src.syncTknId) == null) {
                        _ddSync.append("<option value = '" + _dbTkns[i].id + "'> [" + _dbTkns[i].ns.name + ":" + _dbTkns[i].name + "] </option>");
                    }
                }
            }

            if (_ddSyncList.find("li").length > 0) {
                // this a sync point, can't be synced with other tokens
                _ddSync.hide();
                _ddSyncList.show();
            } else {
                _ddSyncList.hide();
                _ddSync.show();
            }


            // check value
            if (_wiz[0].tkn.src.syncTknId > 1) {
                var tknSync = avt.mt.studio.getTkn(_wiz[0].tkn.src.syncTknId);
                if (tknSync != null) {
                    _ddSync.val(tknSync.id);
                    avt.mt.tkn.tknSrcType.http.syncChanged(_ddSync);
                }
            }


            if (_wiz[0].tkn.src.srvType) _tpl.find("[name=wiz_tknProtocol]").val(_wiz[0].tkn.src.srvType);
            if (_wiz[0].tkn.src.host) _tpl.find("[name=wiz_tknHost]").val(_wiz[0].tkn.src.host);
            _tpl.find("[name=wiz_tknSSL]").attr("checked", false);
            if (_wiz[0].tkn.src.ssl) _tpl.find("[name=wiz_tknSSL]").attr("checked", true);
            if (_wiz[0].tkn.src.port) _tpl.find("[name=wiz_tknPort]").val(_wiz[0].tkn.src.port);
            if (_wiz[0].tkn.src.user) _tpl.find("[name=wiz_tknUser]").val(_wiz[0].tkn.src.user);
            if (_wiz[0].tkn.src.pass) _tpl.find("[name=wiz_tknPass]").val(_wiz[0].tkn.src.pass);

            if (_wiz[0].tkn.src.getEmail) _tpl.find("[name=wiz_tknGetEmail]").val(_wiz[0].tkn.src.getEmail);
            if (_wiz[0].tkn.src.getPart) _tpl.find("[name=wiz_tknGetPart]").val(_wiz[0].tkn.src.getPart);
            _tpl.find("[name=wiz_tknMarkRead]").attr("checked", false);
            if (_wiz[0].tkn.src.markRead) _tpl.find("[name=wiz_tknMarkRead]").attr("checked", true);

            //if (_wiz[0].tkn.parser) _tpl.find("[name=wiz_tknParseType]").val(_wiz[0].tkn.parser);
        },

        syncChanged: function (dd) {
            dd = jQuery(dd);

            var _wiz = dd.parents(".tknWizardRoot:first");

            var _tknSyncId = parseInt(dd.val());
            if (isNaN(_tknSyncId) || _tknSyncId < 0) {
                _wiz.find(".srcSync").hide();
                if (_wiz[0].tkn.src.srvType) _wiz.find("[name=wiz_tknProtocol]").val(_wiz[0].tkn.src.srvType);
                if (_wiz[0].tkn.src.host) _wiz.find("[name=wiz_tknHost]").val(_wiz[0].tkn.src.host);
                _wiz.find("[name=wiz_tknSSL]").attr("checked", false);
                if (_wiz[0].tkn.src.ssl) _wiz.find("[name=wiz_tknSSL]").attr("checked", true);
                if (_wiz[0].tkn.src.port) _wiz.find("[name=wiz_tknPort]").val(_wiz[0].tkn.src.port);
                if (_wiz[0].tkn.src.user) _wiz.find("[name=wiz_tknUser]").val(_wiz[0].tkn.src.user);
                if (_wiz[0].tkn.src.pass) _wiz.find("[name=wiz_tknPass]").val(_wiz[0].tkn.src.pass);
                return;
            }

            var _tknSync = avt.mt.studio.getTkn(_tknSyncId);
            if (_tknSync != null) {
                if (_tknSync.src.srvType) _wiz.find("[name=wiz_tknProtocol]").val(_tknSync.src.srvType);
                if (_tknSync.src.host) _wiz.find("[name=wiz_tknHost]").val(_tknSync.src.host);
                _wiz.find("[name=wiz_tknSSL]").attr("checked", false);
                if (_tknSync.src.ssl) _wiz.find("[name=wiz_tknSSL]").attr("checked", true);
                if (_tknSync.src.port) _wiz.find("[name=wiz_tknPort]").val(_tknSync.src.port);
                if (_tknSync.src.user) _wiz.find("[name=wiz_tknUser]").val(_tknSync.src.user);
                if (_tknSync.src.pass) _wiz.find("[name=wiz_tknPass]").val(_tknSync.src.pass);
                _wiz.find(".srcSync").show();
            }
        },

        submit: function (_wiz, _tpl) {

            var _host = jQuery.trim(_tpl.find("[name=wiz_tknHost]").val());
            if (_host.length == 0) {
                _tpl.find(".wizerrHost").text("Please input Server Address!").show();
                return false;
            }

            var _port = jQuery.trim(_tpl.find("[name=wiz_tknPort]").val());
            if (_port.length == 0) {
                _tpl.find(".wizerrPort").text("Please input port!").show();
                return false;
            }

            var _user = jQuery.trim(_tpl.find("[name=wiz_tknUser]").val());
            if (_user.length == 0) {
                _tpl.find(".wizerrUser").text("Please input username!").show();
                return false;
            }

            var _pass = jQuery.trim(_tpl.find("[name=wiz_tknPass]").val());
            if (_pass.length == 0) {
                _tpl.find(".wizerrPass").text("Please input password!").show();
                return false;
            }

            _wiz[0].tkn.src.syncTknId = parseInt(_tpl.find("[name=wiz_mailSync]").val());
            _wiz[0].tkn.src.srvType = _tpl.find("[name=wiz_tknProtocol]").val();
            _wiz[0].tkn.src.host = _host;
            _wiz[0].tkn.src.ssl = _tpl.find("[name=wiz_tknSSL]").is(":checked");
            _wiz[0].tkn.src.port = _port;
            _wiz[0].tkn.src.user = _user;
            _wiz[0].tkn.src.pass = _pass;

            _wiz[0].tkn.src.getEmail = _tpl.find("[name=wiz_tknGetEmail]").val();
            _wiz[0].tkn.src.getPart = _tpl.find("[name=wiz_tknGetPart]").val();
            _wiz[0].tkn.src.markRead = _tpl.find("[name=wiz_tknMarkRead]").is(":checked");
            //_wiz[0].tkn.parser = _tpl.find("[name=wiz_tknParseType]").val();
        },
        serialize: function (_wiz) {
            var ruleXml = "";

            ruleXml += "<src>";
            ruleXml += "<type>mail</type>";
            ruleXml += "<syncTknId>" + _wiz[0].tkn.src.syncTknId + "</syncTknId>";
            ruleXml += "<srvType>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.srvType) + "</srvType>";
            ruleXml += "<host>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.host) + "</host>";
            ruleXml += "<ssl>" + (_wiz[0].tkn.src.ssl ? "true" : "false") + "</ssl>";
            ruleXml += "<port>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.port) + "</port>";
            ruleXml += "<user>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.user) + "</user>";
            ruleXml += "<pass>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.pass) + "</pass>";

            ruleXml += "<getEmail>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.getEmail) + "</getEmail>";
            ruleXml += "<getPart>" + avt.mt.tkn.http.encodeXml(_wiz[0].tkn.src.getPart) + "</getPart>";
            ruleXml += "<markRead>" + (_wiz[0].tkn.src.markRead ? "true" : "false") + "</markRead>";

            //ruleXml += "<response>"+ _wiz[0].tkn.parser +"</response>";
            ruleXml += "</src>";

            return ruleXml;
        },

        sync: function (tkn) {
            var _tknSync = avt.mt.studio.getTkn(parseInt(tkn.src.syncTknId));
            if (_tknSync) {
                _tknSync.src.srvType = tkn.src.srvType;
                _tknSync.src.host = tkn.src.host;
                _tknSync.src.ssl = tkn.src.ssl;
                _tknSync.src.port = tkn.src.port;
                _tknSync.src.user = tkn.src.user;
                _tknSync.src.pass = tkn.src.pass;
            }

            if (tkn.synched) {
                for (var i = 0; i < tkn.synched.length; i++) {
                    var _tknSync = avt.mt.studio.getTkn(parseInt(tkn.synched[i]));
                    if (_tknSync) {
                        _tknSync.src.srvType = tkn.src.srvType;
                        _tknSync.src.host = tkn.src.host;
                        _tknSync.src.ssl = tkn.src.ssl;
                        _tknSync.src.port = tkn.src.port;
                        _tknSync.src.user = tkn.src.user;
                        _tknSync.src.pass = tkn.src.pass;
                    }
                }
            }
        },

        setDefaultPort: function (_wiz) {
            var _srvType = _wiz.find("[name=wiz_tknProtocol]").val();
            var _useSsl = _wiz.find("[name=wiz_tknSSL]").is(":checked");
            var _tbPort = _wiz.find("[name=wiz_tknPort]");

            if (_srvType == "imap") {
                _tbPort.val(_useSsl ? 993 : 143);
            } else {
                _tbPort.val(_useSsl ? 995 : 110);
            }
        }
    },

    spark: {
        title: "Spark Template",
        sync: function () { }
    },

    razor: {
        title: "Razor Template",
        sync: function () { }
    }
}



avt.mt.tkn.tknParser = {
    string: {
        title: "No Parser",
        tpl: "tplTknParseNot",
        init: function (_wiz, _tpl) {
            /* var _wiz = _tpl.parents('.tknWizardRoot:first');
            _tpl.find(".usage").html("[" + _wiz[0].tkn.tknNs.name + ":" + _wiz[0].tkn.name + "]");
            _tpl.find(".output").html(_wiz[0].tkn.src.text); */
            _tpl.find(".wiz_tknNoParseReplace")[0].checked = _wiz[0].tkn.parser.replace;
            _tpl.find(".wiz_tknNoParseDecodeHtml")[0].checked = _wiz[0].tkn.parser.decodeHtml;
        },
        submit: function (_wiz, _tpl) {
            _wiz[0].tkn.parser.replace = _tpl.find(".wiz_tknNoParseReplace")[0].checked;
            _wiz[0].tkn.parser.decodeHtml = _tpl.find(".wiz_tknNoParseDecodeHtml")[0].checked;
        },
        serialize: function (_wiz) {
            return "<parser><type>string</type><replace>" + (_wiz[0].tkn.parser.replace ? "true" : "false") + "</replace><decodeHtml>" + (_wiz[0].tkn.parser.decodeHtml ? "true" : "false") + "</decodeHtml></parser>";
        }
    },
    striptags: {
        title: "Strip Xml/Html Tags",
        tpl: "tplTknParseStrip",
        init: function (_wiz, _tpl) {
            _tpl.find(".wiz_tknStripReplace")[0].checked = _wiz[0].tkn.parser.replace;
            _tpl.find(".wiz_tknStripDecodeHtml")[0].checked = _wiz[0].tkn.parser.decodeHtml;
        },
        submit: function (_wiz, _tpl) {
            _wiz[0].tkn.parser.replace = _tpl.find(".wiz_tknStripReplace")[0].checked;
            _wiz[0].tkn.parser.decodeHtml = _tpl.find(".wiz_tknStripDecodeHtml")[0].checked;
        },
        serialize: function (_wiz) {
            return "<parser><type>striptags</type><replace>" + (_wiz[0].tkn.parser.replace ? "true" : "false") + "</replace><decodeHtml>" + (_wiz[0].tkn.parser.decodeHtml ? "true" : "false") + "</decodeHtml></parser>";
        }
    },
    xml: {
        title: "XML Parser",
        tpl: "tplTknParseXml",
        init: function (_wiz, _tpl) {
            _tpl.find("[name='wiz_tknXmlXPath']").val(_wiz[0].tkn.parser.xpath);
            _tpl.find(".wiz_tknXmlReplace")[0].checked = _wiz[0].tkn.parser.replace;
            _tpl.find(".wiz_tknXmlDecodeHtml")[0].checked = _wiz[0].tkn.parser.decodeHtml;

            var index = parseInt(_wiz[0].tkn.parser.index);
            if (isNaN(index) || index < -1) {
                _tpl.find("[name='wiz_tknXmlIndex']").val(0);
            } else {
                _tpl.find("[name='wiz_tknXmlIndex']").val(index);
            }
        },
        submit: function (_wiz, _tpl) {
            var _xpath = jQuery.trim(_tpl.find("[name='wiz_tknXmlXPath']").val());
            var _index = parseInt(_tpl.find("[name='wiz_tknXmlIndex']").val());

            var bError = false;
            if (_xpath.length == 0) {
                _tpl.find(".wizerrParseXml").text("Please input XPath expression!").show();
                bError = true;
            }

            if (isNaN(_index) || _index < -1) {
                _tpl.find(".wizerrParseXmlIndex").text("Index must be a number greater than or equal to -1!").show();
                bError = true;
            }

            if (bError)
                return false;

            _wiz[0].tkn.parser.xpath = _xpath;
            _wiz[0].tkn.parser.index = _index;
            _wiz[0].tkn.parser.replace = _tpl.find(".wiz_tknXmlReplace")[0].checked;
            _wiz[0].tkn.parser.decodeHtml = _tpl.find(".wiz_tknXmlDecodeHtml")[0].checked;
        },
        serialize: function (_wiz) {
            return "<parser><type>xml</type><xpath>" + avt_replaceExtChars(_wiz[0].tkn.parser.xpath) + "</xpath><index>" + _wiz[0].tkn.parser.index + "</index><replace>" + (_wiz[0].tkn.parser.replace ? "true" : "false") + "</replace><decodeHtml>" + (_wiz[0].tkn.parser.decodeHtml ? "true" : "false") + "</decodeHtml></parser>";
        }
    },
    json: {
        title: "JSON Parser",
        tpl: "tplTknParseJson",
        init: function (_wiz, _tpl) {
            _tpl.find("[name='wiz_tknJsonExpr']").val(_wiz[0].tkn.parser.expr);
            _tpl.find(".wiz_tknJsonReplace")[0].checked = _wiz[0].tkn.parser.replace;
            _tpl.find(".wiz_tknJsonDecodeHtml")[0].checked = _wiz[0].tkn.parser.decodeHtml;

            var index = parseInt(_wiz[0].tkn.parser.index);
            if (isNaN(index) || index < 0) {
                _tpl.find("[name='wiz_tknJsonIndex']").val(0);
            } else {
                _tpl.find("[name='wiz_tknJsonIndex']").val(index);
            }
        },
        submit: function (_wiz, _tpl) {

            var _xpath = _tpl.find("[name='wiz_tknJsonExpr']").val();
            var _index = parseInt(_tpl.find("[name='wiz_tknJsonIndex']").val());

            var bError = false;
            if (_xpath.length == 0) {
                _tpl.find(".wizerrParseJson").text("Please input XPath expression!").show();
                bError = true;
            }

            if (isNaN(_index) || _index < 0) {
                _tpl.find(".wizerrParseJsonIndex").text("Index must be a number greater than or equal to 0!").show();
                bError = true;
            }

            if (bError)
                return false;

            _wiz[0].tkn.parser.expr = _xpath;
            _wiz[0].tkn.parser.index = _index;
            _wiz[0].tkn.parser.replace = _tpl.find(".wiz_tknJsonReplace")[0].checked;
            _wiz[0].tkn.parser.decodeHtml = _tpl.find(".wiz_tknJsonDecodeHtml")[0].checked;
        },
        serialize: function (_wiz) {
            return "<parser><type>json</type><expr>" + avt_replaceExtChars(_wiz[0].tkn.parser.expr) + "</expr><index>" + _wiz[0].tkn.parser.index + "</index><replace>" + (_wiz[0].tkn.parser.replace ? "true" : "false") + "</replace><decodeHtml>" + (_wiz[0].tkn.parser.decodeHtml ? "true" : "false") + "</decodeHtml></parser>";
        }
    },

    regexp: {
        title: "RegExp Parser",
        tpl: "tplTknParseRegExp",
        init: function (_wiz, _tpl) {

            _tpl.find("[name='wiz_tknRegExp']").val(_wiz[0].tkn.parser.regexp);
            _tpl.find(".wiz_tknRegexpReplace")[0].checked = _wiz[0].tkn.parser.replace;
            _tpl.find(".wiz_tknRegexpDecodeHtml")[0].checked = _wiz[0].tkn.parser.decodeHtml;
            var index = parseInt(_wiz[0].tkn.parser.index);
            if (isNaN(index) || index < 0) {
                _tpl.find("[name='wiz_tknRegExpIndex']").val(0);
            } else {
                _tpl.find("[name='wiz_tknRegExpIndex']").val(index);
            }
        },
        submit: function (_wiz, _tpl) {
            var _regexp = _tpl.find("[name='wiz_tknRegExp']").val();
            var _index = parseInt(_tpl.find("[name='wiz_tknRegExpIndex']").val());

            var bError = false;

            if (_regexp.length == 0) {
                _tpl.find(".wizerrParseRegExp").text("Please input regular expression!").show();
                bError = true;
            }

            if (isNaN(_index) || _index < 0) {
                _tpl.find(".wizerrParseRegExpIndex").text("Index must be a number greater than or equal to 0!").show();
                bError = true;
            }

            if (bError)
                return false;

            _wiz[0].tkn.parser.regexp = _regexp;
            _wiz[0].tkn.parser.index = _index;
            _wiz[0].tkn.parser.replace = _tpl.find(".wiz_tknRegexpReplace")[0].checked;
            _wiz[0].tkn.parser.decodeHtml = _tpl.find(".wiz_tknRegexpDecodeHtml")[0].checked;
        },
        serialize: function (_wiz) {
            return "<parser><type>regexp</type><regexp>" + avt_replaceExtChars(_wiz[0].tkn.parser.regexp) + "</regexp><index>" + _wiz[0].tkn.parser.index + "</index><replace>" + (_wiz[0].tkn.parser.replace ? "true" : "false") + "</replace><decodeHtml>" + (_wiz[0].tkn.parser.decodeHtml ? "true" : "false") + "</decodeHtml></parser>";
        }
    },

    xslt: {
        title: "XSLT Parser",
        tpl: "tplTknParseXslt",
        init: function (_wiz, _tpl) {
            _tpl.find("[name='wiz_tknXslTpl']").val(_wiz[0].tkn.parser.xsl);
            _tpl.find(".wiz_tknXsltReplace")[0].checked = _wiz[0].tkn.parser.replace;
            //_tpl.find(".wiz_tknXmlDecodeHtml")[0].checked = _wiz[0].tkn.parser.decodeHtml;
        },
        submit: function (_wiz, _tpl) {
            var _xsl = jQuery.trim(_tpl.find("[name='wiz_tknXslTpl']").val());

            var bError = false;
            if (_xsl.length == 0) {
                _tpl.find(".wizerrParseXsl").text("Please input XSL template!").show();
                bError = true;
            }

            if (bError)
                return false;

            _wiz[0].tkn.parser.xsl = _xsl;
            _wiz[0].tkn.parser.replace = _tpl.find(".wiz_tknXsltReplace")[0].checked;
            //_wiz[0].tkn.parser.decodeHtml = _tpl.find(".wiz_tknXmlDecodeHtml")[0].checked;
        },
        serialize: function (_wiz) {
            return "<parser><type>xslt</type><xsl>" + avt_replaceExtChars(_wiz[0].tkn.parser.xsl) + "</xsl><replace>" + (_wiz[0].tkn.parser.replace ? "true" : "false") + "</replace></parser>";
        }
    }

}


function avt_replaceExtChars(text,output) {
    text = text.replace(new RegExp("&", "gm"), '&amp;');
    text = text.replace(new RegExp("<", "gm"), '&lt;');
    text = text.replace(new RegExp(">", "gm"), '&gt;');
	return (text);
}

function avt_encodeXml(str) {
    if (str)
        return str.replace(/&/g, "&amp;").replace(/\"/g, "&quot;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
    return ""
}
