<%@ Page Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.Framework.DefaultPage" CodeFile="Default.aspx.cs" %>
<%@ Register TagPrefix="dnncrm" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Common.Controls" Assembly="DotNetNuke" %>
<asp:literal id="skinDocType" runat="server"></asp:literal>
<html <asp:literal id="attributeList" runat="server"></asp:literal>
<head id="Head" runat="server">
    <title />
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
    <meta content="text/javascript" http-equiv="Content-Script-Type" />
    <meta content="text/css" http-equiv="Content-Style-Type" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta id="MetaRefresh" runat="Server" http-equiv="Refresh" name="Refresh" />
    <meta id="MetaDescription" runat="Server" name="DESCRIPTION" />
    <meta id="MetaKeywords" runat="Server" name="KEYWORDS" />
    <meta id="MetaCopyright" runat="Server" name="COPYRIGHT" />
    <meta id="MetaGenerator" runat="Server" name="GENERATOR" />
    <meta id="MetaAuthor" runat="Server" name="AUTHOR" />
    <meta name="RESOURCE-TYPE" content="DOCUMENT" />
    <meta name="DISTRIBUTION" content="GLOBAL" />
    <meta id="MetaRobots" runat="server" name="ROBOTS" />
    <meta name="REVISIT-AFTER" content="1 DAYS" />
    <meta name="RATING" content="GENERAL" />
    <meta http-equiv="PAGE-ENTER" content="RevealTrans(Duration=0,Transition=1)" />
    <style type="text/css" id="StylePlaceholder" runat="server"></style>
    <asp:PlaceHolder runat="server" ID="ClientDependencyHeadCss"></asp:PlaceHolder>
    <asp:PlaceHolder runat="server" ID="ClientDependencyHeadJs"></asp:PlaceHolder>
    <asp:placeholder id="CSS" runat="server" />
    <asp:placeholder id="SCRIPTS" runat="server" />
</head>
<body id="Body" runat="server">    
    <dnn:Form ID="Form" runat="server" ENCTYPE="multipart/form-data">
        <asp:PlaceHolder ID="BodySCRIPTS" runat="server" />
        <asp:Label ID="SkinError" runat="server" CssClass="NormalRed" Visible="False"></asp:Label>
        <asp:PlaceHolder ID="SkinPlaceHolder" runat="server" />
        <input id="ScrollTop" runat="server" name="ScrollTop" type="hidden" />
        <input id="__dnnVariable" runat="server" name="__dnnVariable" type="hidden" autocomplete="off" />
        <asp:placeholder runat="server" ID="ClientResourcesFormBottom" />
    </dnn:Form>
    <asp:placeholder runat="server" id="ClientResourceIncludes" />
    <dnncrm:ClientResourceLoader runat="server" id="ClientResourceLoader">
        <Paths>
            <dnncrm:ClientResourcePath Name="SkinPath" Path="<%# CurrentSkinPath %>" />
            <dnncrm:ClientResourcePath Name="SharedScripts" Path="~/Resources/Shared/Scripts/" />
        </Paths>
    </dnncrm:ClientResourceLoader>

    <%-- for ehaml--%>
    <script type="text/javascript">
        $(".rcbItem.rcbTemplate > input").each(function () {
            $(this).val('تعداد...');
        });

        $(".rcbItem.rcbTemplate > input").live("focus", function () {
            if ($(this).val().trim() == 'تعداد...') {
                $(this).val('');
                $(this).css("color", "#222").css("font-size", "12");
            }
        });
        $(".rcbItem.rcbTemplate > input").live("blur", function () {
            if ($(this).val().trim() == '') {
                $(this).val('تعداد...');
                $(this).css("color", "gray").css("font-size", "11");
            }
        });
/*
        function onItemChecked(sender, args) {
            var checked = args.get_item().get_checked();
            if (checked) {
                if (args.get_item().get_text().toLowerCase().indexOf("imdg") != -1) {
                    $(".panelekalayekhatarnak").fadeIn(200);
                }
            } else {
                if (args.get_item().get_text().toLowerCase().indexOf("imdg") != -1) {
                    $(".panelekalayekhatarnak").fadeOut(200);
                }
            }
        }
*/

        function IsNumeric(input) {
            return (input - 0) == input && (input + '').replace(/^\s+|\s+$/g, "").length > 0;
        }

        //for zadghan
        function mohasebegheymatForZADGHAN() {
            var sum = 0;
            $(".priceItem_Tedad_T1").each(function () {
                var txtPrice = $(this).parents("div.dnnFormItem").find("input.priceItem_Geymat_T1");
                if (txtPrice != undefined) {
                    var tedad = $(this).text().replace(/[^0-9]/gi, '');
                    if (IsNumeric(tedad)) {
                        var val = txtPrice.val();
                        if (IsNumeric(val))
                            sum += parseInt(val) * parseInt(tedad);
                    }
                }
            });
            return sum;
        }

        // for zadghal [repeater] bar asase tedade dastgah 
        function mohasebegheymatForZADGHAL() {
            var sum = 0;
            $(".priceItem_Tedad_T2").each(function () {
                var dastgah = $(this).attr("data-dastgah");
                var txtPrice = $(".priceItem_Geymat_T2[data-dastgah='" + dastgah + "']");
                if (txtPrice != undefined) {
                    var tedad = $(this).val();
                    if (IsNumeric(tedad)) {
                        var val = txtPrice.val();
                        if (IsNumeric(val))
                            sum += parseInt(val) * parseInt(tedad);
                    }
                }
            });
            return sum;
        }

        // for zadghal [repeater] bar asase tedade dastgah 
        function mohasebegheymatForZADAF() {
            var sum = 0;
            $(".priceItem_Tedad_T2").each(function () {
                var dastgah = $(this).attr("data-dastgah");
                var txtPrice = $(".priceItem_Geymat_T2[data-dastgah='" + dastgah + "']");
                if (txtPrice != undefined) {
                    var tedad = $(this).val();
                    if (IsNumeric(tedad)) {
                        var val = txtPrice.val();
                        if (IsNumeric(val))
                            sum += parseInt(val) * parseInt(tedad);
                    }
                }
            });
            return sum;
        }

        //for zaban bar asase ton
        function mohasebegheymatForZABAN1() {
            var sum = 0;
            $(".PriceItem_Tonaj_VazneKol_T1").each(function () {
                var txtPrice = $("input.PriceItem_Tonaj_Geymat_T1 ");
                if (txtPrice != undefined) {
                    var ton = $(this).text().split("]")[0].replace(/[^0-9]/gi, '');
                    if (IsNumeric(ton)) {
                        ton = parseInt(ton) / 1000;
                        var val = txtPrice.val();
                        if (IsNumeric(val))
                            sum = parseInt(parseInt(val) * ton);
                    }
                }
            });
            return sum;
        }

        //for zaban bar asase groopaj
        function mohasebegheymatForZABAN2() {
            var sum = 0;
            $(".PriceItem_Groopaj_Geymat").each(function () {
                var txtPrice = $(this);
                sum = txtPrice.val();
            });
            return sum;
        }

        //for zaban bar asase tedad
        function mohasebegheymatForZABAN3() {
            var sum = 0;
            $(".priceItem_Tonaji_VazneKol_T1").each(function () {
                var txtPrice = $(".priceItem_Tonaji_Geymate_T1");
                var tedad = $(this).text().split("]")[0].replace(/[^0-9]/gi, '');
                if (IsNumeric(tedad)) {
                    var val = txtPrice.val();
                    if (IsNumeric(val))
                        sum = parseInt(val) * parseInt(tedad);
                }
            });
            return sum;
        }

        //for ral bar asase groopaj
        function mohasebegheymatForRAL() {
            var sum = 0;
            $(".PriceItem_Groopaj_Geymat").each(function () {
                var txtPrice = $(this);
                sum = txtPrice.val();
            });
            return sum;
        }

        //for hal bar asase groopaj
        function mohasebegheymatForHAL() {
            var sum = 0;
            $(".PriceItem_Groopaj_Geymat").each(function () {
                var txtPrice = $(this);
                sum = txtPrice.val();
            });
            return sum;
        }

        //for dal
        function mohasebegheymatForDAL()
        {
            var sum = 0;
            $(".priceItem_Tedad_T2D").each(function () {
                var dastgah = $(this).attr("data-dastgah");
                var txtPrice = $(".priceItem_Geymat_T2D[data-dastgah*='" + dastgah + "']");
                if (txtPrice != undefined) {
                    var tedad = $(this).val();
                    if (IsNumeric(tedad)) {
                        var val = txtPrice.val();
                        if (IsNumeric(val))
                            sum += parseInt(val) * parseInt(tedad);
                    }
                }
            });
            return sum;
        }

        //for dn
        function mohasebegheymatForDN() {
            var sum = 0;
            $(".priceItem_Tedad_T3").each(function () {
                var dastgah = $(this).attr("data-dastgah");
                var txtPrice = $(".priceItem_Geymate_T3[data-dastgah*='" + dastgah + "']");
                var tedad = $(this).text().split("]")[1].replace(/[^0-9]/gi, '');
                if (IsNumeric(tedad)) {
                    var val = txtPrice.val();
                    if (IsNumeric(val))
                        sum += parseInt(val) * parseInt(tedad);
                }
            });
            return sum;
        }

        // for dghco
        function mohasebegheymatForDGHCO() {
            var sum = 0;
            $(".PriceItem_Groopaj_Geymat").each(function () {
                var txtPrice = $(this);
                sum = txtPrice.val();
            });
            return sum;
        }


        // for takhlie tj
        function mohasebegheymatForTJ() {
            var sum = 0;
            $(".PriceItem_Groopaj_Geymat").each(function () {
                var txtPrice = $(this);
                sum = txtPrice.val();
            });
            return sum;
        }

        // for takhlie tk
        function mohasebegheymatForTK() {
            var sum = 0;
            $(".priceItem_Tedad_T3").each(function () {
                var dastgah = $(this).attr("data-dastgah");
                var txtPrice = $(".priceItem_Geymate_T3[data-dastgah*='" + dastgah + "']");
                var tedad = $(this).text().split("]")[1].replace(/[^0-9]/gi, '');
                if (IsNumeric(tedad)) {
                    var val = txtPrice.val();
                    if (IsNumeric(val))
                        sum += parseInt(val) * parseInt(tedad);
                }
            });
            return sum;
        }

    </script>
    <script src="/Resources/MyDnn/util.js"></script>
    <script src="/Resources/MyDnn/sweet-alert.min.js"></script>
    <script src="/Resources/MyDnn/moment.min.js"></script>
</body>
</html>