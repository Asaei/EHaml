<%@ Control Language="C#" AutoEventWireup="true" Inherits="avt.MyTokens.ManageServers" CodeBehind="ManageServers.ascx.cs" %>


<div id = "dlgServers" class = "dlgServers" style = "display: none;">
    <div style = "height: 260px; overflow:auto; padding: 6px;">
        <div class="grayed_desc">
            Custom tokens you create often need to connect to a server to pull data. 
            Since many tokens could connect to same server there's no point to define the server each time. 
            Instead a dropdown allows selecting from existing servers.
        </div>

        <table style = "" cellspacing="0" cellpadding="6" id = "tblServers" class="tblServers">
            <tr class ="trHead">
                <td class="hdr">&nbsp;</td>
                <td class="hdr">Type</td>
                <td class="hdr">Name</td>
                <td class="hdr">Location</td>
            </tr>
            <tr id = "tplServerEntry" style="display: none;" class = "tplServerEntry">
                <td class="srvActions" style = "width: 40px;">
                    <a href = "#" onclick="editServer(avt.mt.$(this).parents('.tplServerEntry:first')[0].srvData); return false;"><img src="<%= TemplateSourceDirectory %>/res/edit.gif" alt="Edit" border="0" /></a>
                    <a href = "#" onclick="deleteServer(avt.mt.$(this).parents('.tplServerEntry:first')[0].srvData); return false;"><img src="<%= TemplateSourceDirectory %>/res/delete.gif" alt="Delete" border="0" /></a>
                </td>
                <td class="srvType"></td>
                <td class="srvName"></td>
                <td class="srvLocation"></td>
            </tr>
        </table>
    </div>
</div>


<div id = "dlgEditServer" class = "dlgEditServer" style = "display: none;">
    <div style = "height: 280px; overflow:auto; padding: 6px;">
        
        <div class = "srvSaving" style="display: none; position: absolute; margin: 256px 0;">
            <img src = "<%=TemplateSourceDirectory %>/res/loader.gif" />
        </div>
        
        <div class="grayed_desc">
            
        </div>

        <input type="hidden" class="srvId" value="-1" />
        <table style = "" cellspacing="0" cellpadding="6" class="tblEditServer">
            <tr>
                <td class="hdr"><b>Name</b></td>
                <td class="hdr">
                    <input type="text" style="width: 160px" class = "srvName" />
                    <span class="err errName"><br />&raquo; required</span>
                </td>
                <td class="hdr"><i>Provide a descriptive name</i></td>
            </tr>
            <tr>
                <td class="hdr"><b>Type</b></td>
                <td class="hdr">
                    <select style="width: 160px" class = "srvType">
                        <%--<option value="database">Database</option>--%>
                        <%--<option value="http">HTTP</option>--%>
                        <option value="ftp">FTP</option>
                        <%--<option>IMAP</option>
                        <option>POP3</option>--%>
                    </select>
                </td>
                <td class="hdr"><i>Select which type of server is this</i></td>
            </tr>

            <tr runat="server" id="trServerPortals">
                <td class="hdr"><b>Available on all portals?</b></td>
                <td class="hdr"><input type="checkbox" style="" class = "srvAllPortals" /></td>
                <td class="hdr"><i>This option is visible to Super Users only.</i></td>
            </tr>
        </table>

        <%-- Database fields --%>
        <table class="pnlSrv pnlSrv-database" style = "">
            <tr>
                <td class="hdr"><b>Connection String</b></td>
                <td class="hdr">
                    <textarea style="width: 360px; height: 80px;" class = "srvDbConn"></textarea>
                    <span class="err errDbConn"><br />&raquo; required</span>
                    <br />
                    <i>Provide connection string or name of connection string from web.config</i>
                </td>
            </tr>
        </table>

        <%-- FTP fields --%>
        <table class="pnlSrv pnlSrv-ftp">
            <tr>
                <td class="hdr"><b>Host</b></td>
                <td class="hdr">
                    <input type="text" style="width: 360px" class = "srvFtpUrl" />
                    <span class="err errFtpHost"><br />&raquo; required</span>
                    <br />
                    <i>The host to connect to. 
                        If port number is not the default (21), append it at the end of the address(for example, ftp://yourserver.here:9191). 
                        <br /> The Server Address can contain other tokens.
                    </i>
                </td>
            </tr>
            <tr>
                <td class="hdr"><b>Username</b></td>
                <td class="hdr">
                    <input type="text" style="width: 160px" class = "srvFtpUser" />
                    <br />
                    <i>Provide username for the FTP Server. Leave blank for anonymous access; can contain other tokens</i>
                </td>
            </tr>
            <tr>
                <td class="hdr"><b>Password</b></td>
                <td class="hdr">
                    <input type="password" style="width: 160px" class = "srvFtpPass" />
                    <br />
                    <i>Provide password for the FTP Server. Leave blank for anonymous access; can contain other tokens</i>
                </td>
            </tr>
        </table>

    </div>
</div>


<script type="text/javascript">

    avt.mt.studio.servers = <%= ServersJson %>;

    avt.mt.$(document).ready(function () {

        avt.mt.$("#dlgServers").dialog({
            bgiframe: false,
            autoOpen: false,
            title: "Manage Servers",
            width: 600,
            modal: true,
            resizable: false,
            closeOnEscape: true,

            buttons: {
                'Close': function () {
                    avt.mt.$("#dlgServers").dialog('close');
                },
                'Add Server': function () {
                    editServer(null, null);
                }
            }
        });

        // initalize servers 
        for (var i = 0; i < avt.mt.studio.servers.length; i++) {
            populateServerEntry(avt.mt.studio.servers[i]);
        }
    });


    function populateServerEntry(srv) {
        var _tpl = avt.mt.$("#tplServerEntry").clone().removeAttr("id");
        
        _tpl.find("td").each(function() {
            avt.mt.$(this)
                .mouseover(function() {
                    avt.mt.$(this).parent().css('background-color','#f2f2f2');
                })
                .mouseout(function() {
                    avt.mt.$(this).parent().css('background-color','transparent');
                });
        });
        
        _tpl[0].srvData = srv;
        _tpl.find(".srvType").text(srv.type);
        _tpl.find(".srvName").text(srv.name);
        _tpl.find(".srvLocation").text(srv.location);

        _tpl.show();
        avt.mt.$("#tblServers").append(_tpl);

    }

    function initEditServerDlg() {
        var _dlg = avt.mt.$("#dlgEditServer");
        if (_dlg.hasClass("ui-dialog-content")) {
            // already exists, but let's reset everything to initial state
            _dlg.next(".ui-dialog-buttonpane").show();
            _dlg.find(".srvSaving").hide();
            // reset fields
            _dlg.find(":text,textarea").val("");
            _dlg.find(".srvId").val("-1");
            _dlg.find(".err").hide();
            _dlg.find("select").find("option:first").attr("selected", "selected");
            _dlg.find(".srvAllPortals").removeAttr("checked");
            return;
        }

        avt.mt.$("#dlgEditServer").dialog({
            bgiframe: false,
            autoOpen: false,
            title: "",
            width: 600,
            modal: true,
            resizable: false,
            closeOnEscape: false,

            buttons: {
                'Save': function () {

                    var _dlg = avt.mt.$("#dlgEditServer");
                    _dlg.find(".err").hide();

                    // validate data
                    if (avt.mt.$.trim(_dlg.find(".srvName").val()).length == 0) {
                        _dlg.find(".errName").show();
                        return;
                    }

                    if (_dlg.find(".srvType").val()=="database" && avt.mt.$.trim(_dlg.find(".srvDbConn").val()).length == 0) {
                        _dlg.find(".errDbConn").show();
                        return;
                    }

                    if (_dlg.find(".srvType").val()=="ftp" && avt.mt.$.trim(_dlg.find(".srvFtpUrl").val()).length == 0) {
                        _dlg.find(".errFtpHost").show();
                        return;
                    }

                    var postData = {
                        fn: "srv-save", 
                        format: "json",
                        id: _dlg.find(".srvId").val(),
                        name: _dlg.find(".srvName").val(),
                        type: _dlg.find(".srvType").val(),
                        allPortals: _dlg.find(".srvAllPortals:checked").size() > 0 ? "true" : "false",
                        connStr: "",
                        location: ""
                    };


                    switch (_dlg.find(".srvType").val()) {
                        case "database":
                            postData.connStr = avt.mt.$.trim(_dlg.find(".srvDbConn").val());
                            postData.location = "(Database Server)";
                            break;
                        case "ftp":
                            postData.connStr = "<conn><host>"+ avt_encodeXml(avt.mt.$.trim(_dlg.find(".srvFtpUrl").val())) +"</host><user>"+ avt_encodeXml(avt.mt.$.trim(_dlg.find(".srvFtpUser").val())) +"</user><pass>"+ avt_encodeXml(avt.mt.$.trim(_dlg.find(".srvFtpPass").val())) +"</pass></conn>";
                            postData.location = avt.mt.$.trim(_dlg.find(".srvFtpUrl").val());
                            break;
                    }
                    

                    // show progress
                    _dlg.find(".srvSaving").show();
                    _dlg.next(".ui-dialog-buttonpane").hide();

                    avt.mt.$.post(avt.mt.apiUrl, postData,
                        function (data) {
                            var _dlg = avt.mt.$("#dlgEditServer");
                            if (data.error) {
                                _dlg.next(".ui-dialog-buttonpane").show();
                                _dlg.find(".srvSaving").hide();
                                avt.mt.$.jGrowl("Error saving folder! Internal error: " + data.error, { header: 'Error', life: 5000 });
                            } else {
                                avt.mt.studio.servers = data;

                                avt.mt.$.jGrowl("Server successfully saved!", {header: 'Success', life: 5000});
                                
                                // sync data
                                avt.mt.$("#tblServers").find(".tplServerEntry").not("#tplServerEntry").remove();
                                for (var i = 0; i < data.length; i++) {
                                    populateServerEntry(data[i]);
                                }

                                // also sync dropdown
                                if (_dlg[0].ddRefresh) {
                                    _dlg[0].ddRefresh.empty();
                                    _dlg[0].ddRefresh.append("<option value='-1'>-- Please Select --</option>");
                                    for (var i = 0; i < data.length; i++) {
                                        if (data[i].type==_dlg[0].forceType) {
                                            _dlg[0].ddRefresh.append("<option value='" + data[i].id + "'>" + data[i].name + "</option>");
                                        }
                                    }
                                    _dlg[0].ddRefresh.append("<option value='0'>Create New...</option>");
                                    
                                    // and select the new value
                                    _dlg[0].ddRefresh.find("option").each(function() {
                                        if (avt.mt.$(this).text() == postData.name) {
                                            avt.mt.$(this).attr("selected", "selected");
                                        }
                                    });
                                }

                                avt.mt.$("#dlgEditServer").dialog('close');
                            }
                        },
                        "json"
                    );
                },
                'Cancel': function () {
                    avt.mt.$("#dlgEditServer").dialog('close');
                }
            }
        });

        avt.mt.$("#dlgEditServer").find(".srvType").change(function() {
            avt.mt.$("#dlgEditServer").find(".pnlSrv").hide();
            avt.mt.$("#dlgEditServer").find(".pnlSrv-"+avt.mt.$(this).val()).show();
        });
    }

    function editServer(srv, forceType, ddRefresh) {
        initEditServerDlg();
        var _dlg = avt.mt.$("#dlgEditServer");
        
        _dlg[0].ddRefresh = ddRefresh;
        _dlg[0].forceType = forceType;

        if (srv) {
            _dlg.find(".srvId").val(srv.id);
            _dlg.find(".srvName").val(srv.name);
            _dlg.find(".srvType").val(srv.type);
            if (srv.allPortals)
                _dlg.find(".srvAllPortals").attr("checked", "checked");
            
            switch (srv.type) {
                case "database":
                    _dlg.find(".srvDbConn").val(srv.connStr);
                    break;
                case "ftp":
                    _dlg.find(".srvFtpUrl").val(srv.data.host);
                    _dlg.find(".srvFtpUser").val(srv.data.user);
                    _dlg.find(".srvFtpPass").val(srv.data.pass);
                    break;
            }
            _dlg.parents(".ui-dialog:first").find(".ui-dialog-title").text("Edit Server " + srv.name);
        } else {
            _dlg.parents(".ui-dialog:first").find(".ui-dialog-title").text("Add Server");
        }

        if (forceType) {
            _dlg.find(".srvType").val(forceType);
        }
        
        _dlg.find(".srvType").change();
        _dlg.dialog("open");
    }

    function deleteServer(srv) {
        if (!confirm("Are you sure you want to delete this server?")) {
            return;
        }

        avt.mt.$.post(avt.mt.apiUrl, {
                fn: "srv-del", 
                format: "json",
                id: srv.id
            },
            function (data) {
                if (data.error) {
                    avt.mt.$.jGrowl("Error deleting folder! Make sure it's no longer in use...", { header: 'Error', life: 5000 });
                } else {
                    avt.mt.studio.servers = data;

                    avt.mt.$.jGrowl("Server successfully deleted!", {header: 'Success', life: 5000});
                                
                    // sync data
                    avt.mt.$("#tblServers").find(".tplServerEntry").not("#tplServerEntry").remove();
                    for (var i = 0; i < data.length; i++) {
                        populateServerEntry(data[i]);
                    }
                }
            },
            "json"
        );
    }

    function getServersByType(srvType) {
        var servers = [];
        for (var i = 0; i < avt.mt.studio.servers.length; i++) {
            if (avt.mt.studio.servers[i].type==srvType) {
                servers.push(avt.mt.studio.servers[i]);
            }
        }
        return servers;
    }

</script>


