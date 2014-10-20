<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Elamiye_ServentDashboard.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_ElamiyeDashboard.Elamiye_ServentDashboard" %>

<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>


<dnn:dnncssinclude id="DnnCssInclude1" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.common.min.css" />
<dnn:dnncssinclude id="DnnCssInclude2" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.default.min.css" />
<dnn:dnncssinclude id="DnnCssInclude3" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.rtl.min.css" />
<dnn:dnnjsinclude id="DnnJsInclude1" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Scripts/kendo.web.min.js" />

<script src="/DesktopModules/MyDnn_EHaml/Scripts/kendo.web.min.js"></script>
<script src="/DesktopModules/MyDnn_EHaml/Scripts/xdate.js"></script>
<script src="/DesktopModules/MyDnn_EHaml/Scripts/date.js"></script>
<script src="/DesktopModules/MyDnn_EHaml/Scripts/mydnn.js"></script>


<div class="LordDashboard-Form dnnForm">
    <div class="dnnFormItem">
        <div id="grdMyElamiyesS" class="k-rtl"></div>
    </div>
    <div class="dnnFormItem MyElamiyesReply">
        <div id="grdMyElamiyesReply" class="k-rtl" style="top: -60px;"></div>
    </div>
    <div class="dnnFormItem">
        <div id="grdMyElamiyesTarikhGozashte" class="k-rtl"></div>
    </div>
    <div class="dnnFormItem MyElamiyesReplyTarikhGozashte">
        <div id="grdMyElamiyesReplydTarikhGozashte" class="k-rtl" style="top: -60px;"></div>
    </div>
    <div class="dnnFormItem">
        <div id="grdMySucElamiyes" class="k-rtl"></div>
    </div>
    <div class="ajax-load">
    </div>
</div>
<div runat="server" id="isKhadamatresan" class="IsKhadamatresan" Visible="False"></div>

<%--<div class="LordDashboard-Form dnnForm">

    <div class="dnnFormItem">
        <dnn:Label ID="lblActiveElamiye"Text="اعلاميه ها"></dnn:Label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" CssClass="dnnFixedSizeComboBox" Font-Names="Tahoma" Font-Size="9" runat="server" ID="cbolActiveElamiye"/>
        <a Class="dnnPrimaryAction" style="font-family: bkoodak; font-size: 15px; padding: 1px 6px !important" ID="lnkSearch">جستجو</a>
    </div>
    <div class="dnnFormItem">
        <div id="grdMyElamiyesReply" class="k-rtl">
        
        </div>
    </div>
</div>--%>

<script type="text/javascript">

    $(document).ready(function() {
        if ($(".IsKhadamatresan").length ==0) {
            $(".khadamateMan").hide();
            $(".ElamiyeHayeMan").hide();

        }

        var sf0 = $.ServicesFramework(<%= ModuleId %>);
        var value0 = '<%= this.UserId %>';
        var tabModuleid0 = '<%= TabModuleId %>';
        $.ajax({
            type: "GET",
            url: sf0.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/GetGrideMoredeNazarVaseDashboardElamiyeServent",
            data: { "moduleId": tabModuleid0 },
            beforeSend: sf0.setModuleHeaders
        }).done(function (result) {
            bindGrdES(result);
        }).fail(function(xhr, status, error) {
            //alert(error);
        });
    });

    function bindGrdES(type) {
        if (type == 2) {
            $(".ajax-load").fadeIn(100);
            var sf2 = $.ServicesFramework(<%= ModuleId %>);
            var value2 = '<%= this.UserId %>';
            var tabModulei2 = '<%= TabModuleId %>';
            $.ajax({
                type: "GET",
                url: sf2.getServiceRoot('MyDnn_EHaml_Inquiries') + "Elamiye/MyElamiyeListServent",
                data: { "UserId": value2, "ModuleId": tabModulei2 },
                beforeSend: sf2.setModuleHeaders
            }).done(function(result) {
                bindGrdMyElamiyesS(result);
                //processTokens();
                $(".ajax-load").fadeOut(300);
            }).fail(function(xhr, status, error) {
                //alert(error);
            });
        } else if (type == 1) {
            $(".MyInquirysReplyd").fadeOut();
            $(".MyInquirysReplydTarikhGozashte").fadeOut();

            $(".ajax-load").fadeIn(100);

            var sf1 = $.ServicesFramework(<%= ModuleId %>);
            var value1 = '<%= this.UserId %>';
            $.ajax({
                type: "GET",
                url: sf1.getServiceRoot('MyDnn_EHaml_Inquiries') + "Elamiye/MyElamiyesListSuc",
                data: { "UserId": value1 },
                beforeSend: sf1.setModuleHeaders
            }).done(function(result) {
                bindGrdMyElamiyesSucS(result);
                $(".ajax-load").fadeOut(300);
            }).fail(function(xhr, status, error) {
                //alert(error);
            });
        } else if (type == 0) {
            $(".MyInquirysReplyd").fadeOut();

            $(".ajax-load").fadeIn(100);
            var sf2 = $.ServicesFramework(<%= ModuleId %>);
            var value2 = '<%= this.UserId %>';
            var tabModulei2 = '<%= TabModuleId %>';
            $.ajax({
                type: "GET",
                url: sf2.getServiceRoot('MyDnn_EHaml_Inquiries') + "Elamiye/MyElamiyeList",
                data: { "UserId": value2, "ModuleId": tabModulei2 },
                beforeSend: sf2.setModuleHeaders
            }).done(function(result) {
                bindGrdMyElamiyesTarikhGozashteS(result);
                //processTokens();
                $(".ajax-load").fadeOut(300);
            }).fail(function(xhr, status, error) {
                //alert(error);
            });
        }

    }

    function bindGrdMyElamiyesSucS(myInquirysList) {

        $("#grdMySucElamiyes").kendoGrid({
            dataSource: {
                data: myInquirysList,
                pageSize: 7
            },
            height: 310,
            groupable: false,
            resizable: false,
            columnMenu: false,
            scrollable: true,
            sortable: true,
            filterable: true,
            selectable: 'row',
            pageable: {
                input: true,
                numeric: true
            },
            columns: [
                { title: "رديف", field: "Id", width: "6px" },
                {
                    title: "اطلاعات اعلاميه",
                    field: "Id",
                    width: "30px",
                    template:
                        function(dataItem) { return "<div><span class='ShomareEstelam'>شماره اعلاميه: " + dataItem.Id + "</span><span class='CreateDateSuc'>تاريخ تاييد: " + dataItem.CreateDate + "</span><span class='StartingPointSuc'>مبدا: " + dataItem.StartingPoint + "</span><span class='JoziyateEstelamSSuc'>جزئيات: " + dataItem.JoziyateAsli + "</span></div>" }
                    //function(dataItem) { return "<div><span class='ShomareEstelam'>شماره اعلاميه: " + dataItem.Id + "</span><span class='CreateDateSuc'>تاريخ تاييد: " + dataItem.CreateDate + "</span><span class='StartingPointSuc'>(" + dataItem.StartingPoint + ") به (" + dataItem.Destination + ")</span><span class='JoziyateEstelamSSuc'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyateElamiyeS(\"" + dataItem.JoziyatLink + "\")'>جزئيات اعلاميه</a></span></div>" }
                },
                {
                    title: "اطلاعات صاحب بار",
                    field: "Power",
                    width: "60px",
                    template:
                        function(dataItem) { return "<div><div class='col1Suc'><span class='titleKhadamatresan'>صاحب بار منتخب شما: </span><span class='NameKhadamatResan'>" + dataItem.NameSahebBar + "</span></div><div class='col2Suc'><span class='EtelaateSherkat'><a class='k-button k-button-icontext' href='javascript:void(0)' onclick='UserInfoDetail(" + 0 + ',' + dataItem.ERTEID + ")'>اطلاعات صاحب بار</a></span><span class='masirsuc'>مسير: " + dataItem.Masir + "</span><span class='joziyatePishnahadSuc'>جزئيات: " + dataItem.JoziyatePishnahad + " </span></div><div class='col3Suc'><span class='quality'>" + dataItem.Rank + "</span><span class='Power'>" + dataItem.Power + "</span><span class='NazareKhoob'>مثبت: " + dataItem.NazareKoliKhoob + "</span><span class='NazareBad'>منفي: " + dataItem.NazareKoliBad + "</span><span class='JoziyateNazarSanji'><a class='k-button k-button-icontext' href='javascript:void(0)' onclick='UserInfoDetail(" + 0 + ',' + dataItem.ERTEID + ")'>جزئيات نظرسنجي</a></span></div></div>" }
                },
                //{
                //    title: "عمليات",
                //    field: "KhadamatresanId",
                //    width: "20px",
                //    template:
                //        function(dataItem) {
                //            if (dataItem.NazarSanjiVaziyat == 0) {
                //                return "<span class='ShomaGablanSherkatKadeed'><a href='javascript:void(0)' onclick='NazarSanjiSahebBeKhadamatViewElamiye(" + dataItem.ERTEID + ")' class='k-button k-button-icontext'>مشاهده نظر شما</a></span>";
                //            } else if (dataItem.NazarSanjiVaziyat == 1) {
                //                return "<span class='ShomaGablanSherkatKadeed'><a href='javascript:void(0)' onclick='NazarSanjiSahebBeKhadamatElamiye(" + dataItem.ERTEID + ")' class='k-button k-button-icontext'>شرکت در نظر سنجي</a></span>";
                //            } else {
                //                return "<span class='ShomaGablanSherkatKadeed'>زمان شرکت در نظر سنجي فرا نرسيده</span>";
                //            }
                //        }
                //}
            ]
        });

        $(".quality").each(function() {
            $(this).html("<img src='/desktopmodules/mydnn_ehaml/mydnn_ehaml_inquiries/images/star_" + Math.round($(this).text()) + ".png' />");
        });
        $(".TarikheErsal").each(function() {
            var dt = $(this).html();
            var dt2 = dt.substr(13, 10);
            var myDate = Date.parse(dt2);
            //var year = dt2.substr(0, 4);
            //var month = dt2.substr(5, 2);
            //var day = dt2.substr(7, 2);
            $(this).text("تاريخ ارسال: " + (ToPersianDate(myDate)));
        });
        $(".CreateDateSuc").each(function() {
            var dt = $(this).html();
            var dt2 = dt.substr(13, 10);
            var myDate = Date.parse(dt2);
            //var year = dt2.substr(0, 4);
            //var month = dt2.substr(5, 2);
            //var day = dt2.substr(7, 2);
            $(this).text("تاريخ ارسال: " + (ToPersianDate(myDate)));
        });
    }

    function bindGrdMyElamiyesS(myElamiyesList) {
        $("#grdMyElamiyesS").kendoGrid({
            dataSource: {
                data: myElamiyesList,
                pageSize: 7
            },
            height: 310,
            groupable: false,
            scrollable: true,
            sortable: true,
            filterable: true,
            selectable: 'row',
            pageable: {
                input: true,
                numeric: true
            },
            change: function(arg) {
                var selected = $.map(this.select(), function(item) {
                    return $(item).find('td').first().text();

                });

                var selected2 = $.map(this.select(), function(item) {
                    return $(item).find('td').last().text();

                });
                bindMyElamiyeReplyListStep1S(selected, selected2);
            },
            columns: [
                { title: "رديف", field: "Id", width: "25px" },
                //{ title: "رديف", field: "Id0", width: "30px" },
                {
                    title: "تاريخ درج",
                    field: "CreateDate",
                    width: "27px",
                    template:
                        function(dataItem) {
                            var myDate = Date.parse(dataItem.CreateDate);
                            return ToPersianDate(myDate);
                        }
                },
                { title: "نوع اعلاميه", field: "ElamiyeType", width: "27px" },
                { title: "وسيله", field: "Vasile", width: "90px" },
                {
                    title: "زمان آمادگي",
                    field: "ZamaneAmadegi",
                    width: "27px",
                    template:
                        function(dataItem) {
                            var myDate = Date.parse(dataItem.ZamaneAmadegi);
                            return ToPersianDate(myDate);
                        }
                },
                {
                    title: "روز مانده",
                    field: "ExpireDate",
                    width: "20px",
                    template:
                        function(dataItem) {
                            return _diffDays(dataItem.ExpireDate);
                        }
                },
                { title: "تعداد پاسخها", field: "TedadePasohkha", width: "26px" },
                { title: "نوع علاميه", field: "ElamiyeTypeEN", width: ".01px" },


                //    { title: "نوع حمل", field: "InquiryType", width: "50px" },
                //    { title: "مبدا", field: "StartingPoint", width: "100px" },
                //    { title: "مقصد", field: "Destination", width: "100px" },
                //    {
                //        title: "روز مانده",
                //        field: "ExpireDate",
                //        width: "35px",
                //        template:
                //            function(dataItem) {
                //                return _diffDays(dataItem.ExpireDate);
                //            }
                //    },
                //    { title: "شماره اعلاميه", field: "Id", width: "55px" },
                //    {
                //        title: "جزئيات اعلاميه",
                //        field: "Id",
                //        width: "55px",
                //        template:
                //            function(dataItem) {
                //                return "<span class='JoziyateElamiyeS'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyateElamiyeS(\"" + dataItem.JoziyatLink + "\")'>مشاهده</a></span>";
                //            }
                //    },
                //    { title: "پاسخ ها", field: "TedadePasokhha", width: "35px" }
            ]
        });
    }

    function bindGrdMyElamiyesTarikhGozashteS(myElamiyesList) {
        $("#grdMyElamiyesTarikhGozashte").kendoGrid({
            dataSource: {
                data: myElamiyesList,
                pageSize: 7
            },
            height: 310,
            groupable: false,
            scrollable: true,
            sortable: true,
            filterable: true,
            selectable: 'row',
            pageable: {
                input: true,
                numeric: true
            },
            change: function(arg) {
                var selected = $.map(this.select(), function(item) {
                    return $(item).find('td').first().text();

                });

                var selected2 = $.map(this.select(), function(item) {
                    return $(item).find('td').last().text();

                });

                bindMyElamiyeReplyListStep1STarihkGozashte(selected, selected2);
            },
            columns: [
                { title: "رديف", field: "Id", width: "25px" },
                //{ title: "رديف", field: "Id0", width: "30px" },
                {
                    title: "تاريخ درج",
                    field: "CreateDate",
                    width: "27px",
                    template:
                        function(dataItem) {
                            var myDate = Date.parse(dataItem.CreateDate);
                            return ToPersianDate(myDate);
                        }
                },
                { title: "نوع علاميه", field: "ElamiyeType", width: "27px" },
                { title: "وسيله", field: "Vasile", width: "90px" },
                {
                    title: "زمان آمادگي",
                    field: "ZamaneAmadegi",
                    width: "27px",
                    template:
                        function(dataItem) {
                            var myDate = Date.parse(dataItem.ZamaneAmadegi);
                            return ToPersianDate(myDate);
                        }
                },
                {
                    title: "روز مانده",
                    field: "ExpireDate",
                    width: "20px",
                    template:
                        function(dataItem) {
                            return _diffDays(dataItem.ExpireDate);
                        }
                },
                { title: "تعداد پاسخها", field: "TedadePasohkha", width: "26px" },
                { title: "نوع علاميه", field: "ElamiyeTypeEN", width: ".01px" },


                //    { title: "نوع حمل", field: "InquiryType", width: "50px" },
                //    { title: "مبدا", field: "StartingPoint", width: "100px" },
                //    { title: "مقصد", field: "Destination", width: "100px" },
                //    {
                //        title: "روز مانده",
                //        field: "ExpireDate",
                //        width: "35px",
                //        template:
                //            function(dataItem) {
                //                return _diffDays(dataItem.ExpireDate);
                //            }
                //    },
                //    { title: "شماره اعلاميه", field: "Id", width: "55px" },
                //    {
                //        title: "جزئيات اعلاميه",
                //        field: "Id",
                //        width: "55px",
                //        template:
                //            function(dataItem) {
                //                return "<span class='JoziyateElamiyeS'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyateElamiyeS(\"" + dataItem.JoziyatLink + "\")'>مشاهده</a></span>";
                //            }
                //    },
                //    { title: "پاسخ ها", field: "TedadePasokhha", width: "35px" }
            ]
        });
    }

    function bindMyElamiyeReplyListStep1S(arg1, arg2) {
        var sf = $.ServicesFramework(<%= ModuleId %>);
        var elaId = arg1;
        var elaType = arg2;

        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Elamiye/MyElamiyeReplyList",
            data: { "elamiyeID": elaId, "elamiyeType": elaType },
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            bindMyElamiyeReplyListStep2S(result);
        }).fail(function(xhr, status, error) {
            alert(error);
        });

    };

    function bindMyElamiyeReplyListStep1STarihkGozashte(arg1, arg2) {

        var sf = $.ServicesFramework(<%= ModuleId %>);
        var elaId = arg1;
        var elaType = arg2;

        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Elamiye/MyElamiyeReplyList",
            data: { "elamiyeID": elaId, "elamiyeType": elaType },
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            bindMyElamiyeReplyListStep2STarihkGozashte(result);
        }).fail(function(xhr, status, error) {
            alert(error);
        });

    };

    function bindMyElamiyeReplyListStep2S(myElamiyesReply) {
        $("#grdMyElamiyesReply").kendoGrid({
            dataSource: {
                data: myElamiyesReply,
                pageSize: 10
            },
            height: 450,
            groupable: false,
            resizable: true,
            columnMenu: true,
            scrollable: true,
            sortable: true,
            filterable: true,
            pageable: {
                input: true,
                numeric: false
            },
            columns: [
                { title: "رديف", field: "rtelID", width: "6px" },
                {
                    title: "اطلاعات صاحب بار",
                    field: "Power",
                    width: "20px",
                    template:
                        function(dataItem) { return "<div><span class='quality'>" + dataItem.Rank + "</span><span class='Power'>" + dataItem.Power + "</span><span class='NazareKhoob'>مثبت: " + dataItem.NazareKoliKhoob + "</span><span class='NazareBad'>منفي: " + dataItem.NazareKoliBad + "</span><span class='JoziyateNazarSanji'><a class='k-button k-button-icontext' onclick='UserInfoDetailWithoutPersonalInfoEla(" + 0 + ',' + dataItem.ERTEID + ")' href='javascript:void(0)'>جزئيات نظر سنجي</a></span></div>" }
                },
                {
                    title: "اطلاعات درخواست",
                    field: "Id",
                    width: "47px",
                    template:
                        function(dataItem) { return "<div><span class='masir'>" + dataItem.Masir + "</span><span class='vasilemoredeniyazesm'>وسيله مورد نياز: " + dataItem.VasileyeHaml + "  " + dataItem.Tedad + " دستگاه </span><span class='ZamaneAmadegiBarayeShooroo'>زمان نياز به حمل: " + dataItem.zaman + "</span><span class='TarikheErsal'>تاريخ ارسال: " + dataItem.CreateDate + "</span></div>" }
                    //function (dataItem) { return "<div><span class='TarikheErsal'>تاريخ ارسال: " + dataItem.CreateDate + "</span><span class='ZamaneAmadegiBarayeShooroo'>زمان آماده به حمل: " + dataItem.ZamaneAmadegiBarayeShooroo + "</span><span class='GeymateKol'>قيمت کل: " + dataItem.GeymateKol + " ريال </span><span class='Pishbini'>پيش بيني وضعيت حمل: " + dataItem.Pishbini + "</span></div>" }
                },
                {
                    title: "جزئيات پيشنهاد",
                    field: "Id",
                    width: ".01px",
                    template:
                        function(dataItem) { return "<span class='JoziyatePishnahad'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyatePishnahadeBeEstelamEstelamS(" + dataItem.Id + ")'>جزئيات پيشنهاد</a></span>" }
                },
                {
                    title: "عمليات",
                    field: "ZamaneAmadegiBarayeShooroo",
                    width: "17px",
                    template:
                        function(dataItem) {
                            if (dataItem.VaziyatePaziresh == "1") {
                                return "<div><span class='NameKhedmatresan amaliyat'>" + dataItem.DisplayName + "</span><span class='MoshahedeyeEtelaateTamas'><a class='k-button k-button-icontext' href='javascript:void(0)' onclick='UserInfoDetail(" + 0 + ',' + dataItem.ERTEID + ")'>اطلاعات تماس</a></span></div>";
                            } else if (dataItem.VaziyatePaziresh == "2") {
                                return "<div><span class='BaPishnahadMovafegam amaliyat'><a class='k-button k-button-icontext' <a href='javascript:void(0)' onclick='BaPishnahadMovafeghamS(" + dataItem.ERTEID + ',' + dataItem.elaId + ',' + '"' + dataItem.typeela + '"' + ")'>با اين پيشنهاد موافقم</a></span></div>";
                            } else {
                                return "<div><span class='GablanPasohkeManfi amaliyat'>قبلآ به اين پيشنهاد پاسخ منفي داده ايد</span></div>"
                            }
                        }
                }
            ]
            //{ title: "وسيله مورد نياز", field: "VasileyeMoredeNiyaz", width: "16px" },
            //{
            //    title: "جزئيات",
            //    field: "Id",
            //    width: "19px",
            //    template:
            //        function(dataItem) {
            //            return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='replyDetail2(" + dataItem.Id + ")'><span class=' '></span>مشاهده</a>";
            //        }
            //}

        });
        $(".quality").each(function() {
            $(this).html("<img src='/desktopmodules/mydnn_ehaml/mydnn_ehaml_inquiries/images/star_" + Math.round($(this).text()) + ".png' />");
        });
        $(".TarikheErsal").each(function() {
            var dt = $(this).html();
            var dt2 = dt.substr(13, 10);
            var myDate = Date.parse(dt2);
            //var year = dt2.substr(0, 4);
            //var month = dt2.substr(5, 2);
            //var day = dt2.substr(7, 2);
            $(this).text("تاريخ ارسال: " + (ToPersianDate(myDate)));
        });
        $(".ZamaneAmadegiBarayeShooroo").each(function() {
            var dt = $(this).html();
            var dt2 = dt.substr(18, 10);
            var myDate = Date.parse(dt2);
            //var year = dt2.substr(0, 4);
            //var month = dt2.substr(5, 2);
            //var day = dt2.substr(7, 2);
            $(this).text("زمان نياز به حمل: " + (ToPersianDate(myDate)));
        });
    }

    function bindMyElamiyeReplyListStep2STarihkGozashte(myElamiyesReply) {
        $("#grdMyElamiyesReplydTarikhGozashte").kendoGrid({
            dataSource: {
                data: myElamiyesReply,
                pageSize: 10
            },
            height: 450,
            groupable: false,
            resizable: true,
            columnMenu: true,
            scrollable: true,
            sortable: true,
            filterable: true,
            pageable: {
                input: true,
                numeric: false
            },
            columns: [
                { title: "رديف", field: "rtelID", width: "6px" },
                {
                    title: "اطلاعات صاحب بار",
                    field: "Power",
                    width: "20px",
                    template:
                        function(dataItem) { return "<div><span class='quality'>" + dataItem.Rank + "</span><span class='Power'>" + dataItem.Power + "</span><span class='NazareKhoob'>مثبت: " + dataItem.NazareKoliKhoob + "</span><span class='NazareBad'>منفي: " + dataItem.NazareKoliBad + "</span><span class='JoziyateNazarSanji'><a class='k-button k-button-icontext' onclick='UserInfoDetailWithoutPersonalInfoEla(" + 0 + ',' + dataItem.ERTEID + ")' href='javascript:void(0)'>جزئيات نظر سنجي</a></span></div>" }
                },
                {
                    title: "اطلاعات درخواست",
                    field: "Id",
                    width: "47px",
                    template:
                        function(dataItem) { return "<div><span class='masir'>" + dataItem.Masir + "</span><span class='vasilemoredeniyazesm'>وسيله مورد نياز: " + dataItem.VasileyeHaml + "  " + dataItem.Tedad + " دستگاه </span><span class='ZamaneAmadegiBarayeShooroo'>زمان نياز به حمل: " + dataItem.zaman + "</span><span class='TarikheErsal'>تاريخ ارسال: " + dataItem.CreateDate + "</span></div>" }
                    //function (dataItem) { return "<div><span class='TarikheErsal'>تاريخ ارسال: " + dataItem.CreateDate + "</span><span class='ZamaneAmadegiBarayeShooroo'>زمان آماده به حمل: " + dataItem.ZamaneAmadegiBarayeShooroo + "</span><span class='GeymateKol'>قيمت کل: " + dataItem.GeymateKol + " ريال </span><span class='Pishbini'>پيش بيني وضعيت حمل: " + dataItem.Pishbini + "</span></div>" }
                },
                {
                    title: "جزئيات پيشنهاد",
                    field: "Id",
                    width: ".01px",
                    template:
                        function(dataItem) { return "<span class='JoziyatePishnahad'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyatePishnahadeBeEstelamEstelamS(" + dataItem.Id + ")'>جزئيات پيشنهاد</a></span>" }
                },
                {
                    title: "عمليات",
                    field: "ZamaneAmadegiBarayeShooroo",
                    width: "17px",
                    template:
                        function(dataItem) {
                            if (dataItem.VaziyatePaziresh == "1") {
                                return "<div><span class='NameKhedmatresan amaliyat'>" + dataItem.DisplayName + "</span><span class='MoshahedeyeEtelaateTamas'><a class='k-button k-button-icontext' href='javascript:void(0)' onclick='UserInfoDetail(" + 0 + ',' + dataItem.ERTEID + ")'>اطلاعات تماس</a></span></div>";
                            } else if (dataItem.VaziyatePaziresh == "2") {
                                return "<div><span class='BaPishnahadMovafegam amaliyat'><a class='k-button k-button-icontext' <a href='javascript:void(0)' onclick='BaPishnahadMovafeghamS(" + dataItem.ERTEID + ',' + dataItem.elaId + ',' + '"' + dataItem.typeela + '"' + ")'>با اين پيشنهاد موافقم</a></span></div>";
                            } else {
                                return "<div><span class='GablanPasohkeManfi amaliyat'>قبلآ به اين پيشنهاد پاسخ منفي داده ايد</span></div>"
                            }
                        }
                }
            ]
            //{ title: "وسيله مورد نياز", field: "VasileyeMoredeNiyaz", width: "16px" },
            //{
            //    title: "جزئيات",
            //    field: "Id",
            //    width: "19px",
            //    template:
            //        function(dataItem) {
            //            return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='replyDetail2(" + dataItem.Id + ")'><span class=' '></span>مشاهده</a>";
            //        }
            //}

        });
        $(".quality").each(function() {
            $(this).html("<img src='/desktopmodules/mydnn_ehaml/mydnn_ehaml_inquiries/images/star_" + Math.round($(this).text()) + ".png' />");
        });
        $(".TarikheErsal").each(function() {
            var dt = $(this).html();
            var dt2 = dt.substr(13, 10);
            var myDate = Date.parse(dt2);
            //var year = dt2.substr(0, 4);
            //var month = dt2.substr(5, 2);
            //var day = dt2.substr(7, 2);
            $(this).text("تاريخ ارسال: " + (ToPersianDate(myDate)));
        });
        //$(".ZamaneAmadegiBarayeShooroo").each(function () {
        //    var dt = $(this).html();
        //    var dt2 = dt.substr(18, 10);
        //    alert(dt2);
        //    var myDate = Date.parse(dt2);
        //    //var year = dt2.substr(0, 4);
        //    //var month = dt2.substr(5, 2);
        //    //var day = dt2.substr(7, 2);
        //    $(this).text("زمان آماده به حمل: " + (ToPersianDate(myDate)));
        //});
    }
    <%--        $("#lnkSearch").click(function() {
            var sf = $.ServicesFramework(<%= ModuleId %>);

            var combobox = $find('<%= cbolActiveElamiye.ClientID %>');
            var value = combobox.get_value();

            $.ajax({
                type: "GET",
                url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Elamiye/MyElamiyesReplyList",
                data: { "elamiyeId": value },
                beforeSend: sf.setModuleHeaders
            }).done(function(result) {
                bindMyInquiryReplyList(result);
            }).fail(function(xhr, status, error) {
                alert(error);
            });
        });--%>

    function replyDetail2(id) {
        var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=ReplyToElamiyeShenasname&popUp=true&ElaId=", this.TabId, this.ModuleId) %>' + id;
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }

    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }

    function UserInfoDetailWithoutPersonalInfoEla(Type, ERTEID) {
        var modulePath = "/default.aspx?tabid=1147&mid=3561&ctl=UserInfo&Type=" + Type + "&Info=M&ERTEID=" + ERTEID + "&popUp=true";
        dnnModal.show(modulePath, true, 550, 960, false, '');
    }

    function UserInfoDetail(Type, ERTEID) {
        var modulePath = "/default.aspx?tabid=1147&mid=3561&ctl=UserInfo&ERTEID=" + ERTEID + "&Type=" + Type + "&popUp=true";
        dnnModal.show(modulePath, true, 550, 960, false, '');
    }

    function BaPishnahadMovafeghamS(erte, e, et) {
        var sf = $.ServicesFramework(<%= ModuleId %>);
        var eId = e;
        var erteid = erte;
        var elamiyeType = et;
        $(".ajax-load").fadeIn(100);
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Elamiye/BaPishnahadMovafegamPasEmalKonElamiye",
            data: { "erteid": erteid },
            <%--            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/MyinquirysReplyList",--%>
            <%--            data: { "inquiryID": inqId },--%>
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {

            bindMyElamiyeReplyListStep1S(eId, elamiyeType);
            $(".ajax-load").fadeOut(200);

        }).fail(function(xhr, status, error) {
            $(".ajax-load").fadeOut(200);
            //alert(error);
        });
    }

    $(".quality").each(function() {
        $(this).html("<img src='/desktopmodules/mydnn_ehaml/mydnn_ehaml_inquiries/images/star_" + Math.round($(this).text()) + ".png' />");
    });
    $(".TarikheErsal").each(function() {
        var dt = $(this).html();
        var dt2 = dt.substr(13, 10);
        var myDate = Date.parse(dt2);
        //var year = dt2.substr(0, 4);
        //var month = dt2.substr(5, 2);
        //var day = dt2.substr(7, 2);
        $(this).text("تاريخ ارسال: " + (ToPersianDate(myDate)));
    });

    function NazarSanjiSahebBeKhadamatElamiye(ERTEID) {
        var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=NazarSanji_SahebBeKhadamat&popUp=true&ERTEID=", 1148, 3566) %>' + ERTEID;
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }

    function NazarSanjiSahebBeKhadamatViewElamiye(ERTEID) {
        var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=NazarSanji_SahebBeKhadamat&popUp=true&IsView=True&ERTEID=", 1148, 3566) %>' + ERTEID;
        dnnModal.show(modulePath, true, 550, 960, false, '');
    }

</script>