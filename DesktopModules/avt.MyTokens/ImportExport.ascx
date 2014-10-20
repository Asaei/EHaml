<%@ Control Language="C#" AutoEventWireup="True" Inherits="avt.MyTokens.ImportExport" CodeBehind="ImportExport.ascx.cs" %>


<div id = "dlgExport" class = "dlgExport" style = "display: none;">
    <div style = "overflow:auto; padding: 6px;">

        <div id ="pnlExportTokens">
            <div class="grayed_desc">
                Select tokens to export...
            </div>
            <div id ="pnlExportTokensList" style="margin: 10px 10px 10px 10px; height: 240px; border: 1px solid #c2c2c2; padding: 4px; overflow: auto;"></div>
            <div id ="pnlExportTokensActions" style="margin: 0 0 0 20px;">
                <a href="#" onclick="$(this).parent().prev().find(':checkbox').attr('checked', 'checked'); return false;" style="font-size: 11px;">Select All</a> | 
                <a href="#" onclick="$(this).parent().prev().find(':checkbox').removeAttr('checked'); return false;" style="font-size: 11px;">Select None</a>
            </div>
        </div>

        <div id ="pnlExportXml">
            <div class="grayed_desc">
                Copy XML below or use the direct link...
            </div>
            <textarea readonly="readonly" style="font-family: Courier New; color: #424242; margin: 10px 10px 10px 10px; height: 240px; width: 540px; border: 1px solid #c2c2c2; padding: 4px; overflow: auto;" wrap="off"></textarea>
            Direct Link (for automation): <a href="#" id="lnkExportDirect"></a>
        </div>

        <div style="height: 20px; overflow: hidden; text-align:right;">
            <div class = "configExporting" style="color: #E17009; margin: 0px 0 0 0; display: none;">
                <blink>Exporting... Please Wait...</blink>
            </div>
        </div>

    </div>
</div>

<div id = "dlgImport" class = "dlgImport" style = "display: none;">
    <div style = "overflow:auto; padding: 6px;">

        <div id ="pnlImportTokens">
            <div class="grayed_desc">
                Paste the XML containing the tokens...<br />
                <b>Warning: </b> This will overwrite existing tokens!
            </div>
            <textarea style="font-family: Courier New; color: #424242; margin: 10px 10px 10px 10px; height: 240px; width: 540px; border: 1px solid #c2c2c2; padding: 4px; overflow: auto;" wrap="off"></textarea>
            Direct Link (for automation, post XML data from export): <a href="#" id="lnkImportDirect"></a>
        </div>

        <div style="height: 20px; overflow: hidden; text-align:right;">
            <div class = "configImporting" style="color: #E17009; margin: 0px 0 0 0; display: none;">
                <blink>Exporting... Please Wait...</blink>
            </div>
        </div>

    </div>
</div>


<script type="text/javascript">


    $(document).ready(function () {

        $("#dlgExport").dialog({
            bgiframe: false,
            autoOpen: false,
            title: "Export Tokens",
            width: 600,
            modal: true,
            resizable: false,
            closeOnEscape: true,

            buttons: {
                'Close': function () {
                    $("#dlgExport").dialog('close');
                },
                'Export': function () {

                    var _this = $(this);

                    // get all checked tokens
                    var tknIds = [];
                    _this.find(".tkncb:checked").each(function () {
                        tknIds.push($(this).attr("data-tknid"));
                    });

                    if (tknIds.length == 0) {
                        jQuery.jGrowl("Select at least one token...", { header: 'Error', life: 5000 });
                        return;
                    }

                    // show loading caption
                    _this.find(".configExporting").fadeIn();

                    // hide buttons
                    _this.parent(".ui-dialog:first").find(".ui-dialog-buttonpane").hide();

                    avt.mt.studio.loading(true);

                    jQuery.get(avt.mt.apiUrl, {
                        fn: "export",
                        format: "json",
                        tokens: tknIds.join(",")
                    },
                        function (data) {

                            avt.mt.studio.loading(false);

                            _this.parent(".ui-dialog:first").find(".ui-dialog-buttonpane").show();
                            _this.find(".configExporting").hide();

                            if (data.error) {
                                jQuery.jGrowl("Failed to export tokens (internal error: " + data.error + ")", { header: 'Error', life: 5000 });
                                return;
                            }

                            //jQuery.jGrowl("Configuration successfully saved!", { header: 'Success', life: 5000 });
                            // display exported XML
                            //alert(data);
                            $("#pnlExportTokens").hide();
                            $("#pnlExportXml").show();
                            $("#pnlExportXml textarea").val(data.x)[0].select();
                            $("#dlgExport").parents(".ui-dialog:first").find(".ui-dialog-buttonpane").find(".ui-button").eq(1).hide();

                            // close dialog
                            // _this.dialog('close');

                            var directLink = avt.mt.apiUrl + "&fn=export&format=xml&tokens=" + tknIds.join(",");
                            $("#lnkExportDirect").attr("href", directLink).text(directLink);

                        }, "json");
                }
            }
        });


        $("#dlgImport").dialog({
            bgiframe: false,
            autoOpen: false,
            title: "Import Tokens",
            width: 600,
            modal: true,
            resizable: false,
            closeOnEscape: true,

            buttons: {
                'Close': function () {
                    $("#dlgImport").dialog('close');
                },
                'Import': function () {

                    var _this = $(this);

                    // get all checked tokens
                    var tkns = $.trim($("#pnlImportTokens textarea").val());

                    if (tkns.length == 0) {
                        jQuery.jGrowl("Specify the tokens to import...", { header: 'Error', life: 5000 });
                        return;
                    }

                    // show loading caption
                    _this.find(".configImporting").fadeIn();

                    // hide buttons
                    _this.parent(".ui-dialog:first").find(".ui-dialog-buttonpane").hide();

                    avt.mt.studio.loading(true);

                    jQuery.post(avt.mt.apiUrl, {
                        fn: "import",
                        format: "json",
                        tokens: tkns
                    },
                    function (data) {

                        avt.mt.studio.loading(false);

                        //_this.parent(".ui-dialog:first").find(".ui-dialog-buttonpane").show();
                        //_this.find(".configImporting").hide();

                        if (data.error) {
                            jQuery.jGrowl("Failed to import tokens (internal error: " + data.error + ")", { header: 'Error', life: 5000 });
                            return;
                        }

                        jQuery.jGrowl("Successfully imported tokens!<br/> Please wait while the screen refreshes...", { header: 'Success', life: 5000 });
                        window.location.reload();
                        // g_tknTree.jstree("refresh");

                    }, "json");
                }
            }
        });

    });

    function showExportTokens() {
        $("#dlgExport").dialog("open");
        $("#pnlExportXml").hide();
        $("#dlgExport").parents(".ui-dialog:first").find(".ui-dialog-buttonpane").find(".ui-button").eq(1).show();
        $("#pnlExportTokens").show();

        // load tokens
        var l = $("#pnlExportTokensList").empty();
        for (var i = 0; i < avt.mt.namespaces.length; i++) {
            l.append("<div class='ns-root'><label><input type='checkbox' data-nsid='"+ avt.mt.namespaces[i].id +"' />" + avt.mt.namespaces[i].name + "</label><div class='tkn-list'></div></div>");
            for (var j = 0; j < avt.mt.namespaces[i].tokens.length; j++) {
                l.children(":last").find(".tkn-list").append("<div class='tkn-root'><label><input type='checkbox' class='tkncb' data-tknid='" + avt.mt.namespaces[i].tokens[j].id + "' />" + avt.mt.namespaces[i].tokens[j].name + "</label></div>");
            }
        }

        l.find(".ns-root>label>input").change(function () {
            this.checked ? $(this).parents(".ns-root").find(".tkn-list :checkbox").attr("checked", "checked") :
                $(this).parents(".ns-root").find(".tkn-list :checkbox").removeAttr("checked");
        });
    }

    function showImportTokens() {
        $("#dlgImport").dialog("open");

        var directLink = avt.mt.apiUrl + "&fn=import&tokens=<xml structure>";
        $("#lnkImportDirect").attr("href", directLink).text(directLink);
    }

</script>


