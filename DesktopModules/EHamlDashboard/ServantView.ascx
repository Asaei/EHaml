﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ServantView.ascx.cs" Inherits="EHamlDashboard.ServantView" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:dnncssinclude id="DnnCssInclude1" runat="server" filepath="~/DesktopModules/EHamlLibrary/Styles/kendo.common.min.css" />
<dnn:dnncssinclude id="DnnCssInclude3" runat="server" filepath="~/DesktopModules/EHamlLibrary/Styles/kendo.rtl.min.css" />
<dnn:dnncssinclude id="DnnCssInclude4" runat="server" filepath="~/DesktopModules/EHamlLibrary/Styles/kendo.default.min.css" />

<dnn:dnnJsinclude ID="DnnJsInclude1" runat="server" filepath="~/DesktopModules/EHamlLibrary/Scripts/kendo.web.min.js" />
<dnn:dnnJsinclude ID="DnnJsInclude2" runat="server" filepath="~/DesktopModules/EHamlLibrary/Scripts/xdate.js" />
<dnn:dnnJsinclude ID="DnnJsInclude3" runat="server" filepath="~/DesktopModules/EHamlLibrary/Scripts/date.js" />
<dnn:dnnJsinclude ID="DnnJsInclude4" runat="server" filepath="~/DesktopModules/EHamlLibrary/Scripts/mydnn.js" />

<div class="dnnForm">
    <div id="grdInquiryListIReply" class="k-rtl">
    </div>
</div>

<div class="dnnForm GrdInquiryReplyDetail">
    <div id="grdInquiryReplyDetail" class="k-rtl">
    </div>
</div>

<div class="dnnForm">
    <div id="grdInquiryListIReplyTarikhGozashte" class="k-rtl">
    </div>
</div>

<div class="dnnForm GrdInquiryReplyDetailTarikhGozashte">
    <div id="grdInquiryReplyDetailTarikhGozashte" class="k-rtl">
    </div>
</div>

<div class="dnnFormItem">
    <div id="grdInquiryListIReplySuc" class="k-rtl"></div>
</div>

<div class="ajax-load"></div>


<script type="text/javascript">
    $(document).ready(function() {
        var sf1 = $.ServicesFramework(<%= ModuleId %>);
        var value1 = '<%= this.UserId %>';
        var tabModuleid = '<%= TabModuleId %>';
        $.ajax({
            type: "GET",
            url: sf1.getServiceRoot('EHamlLibrary') + "Dashboard/GetGrideMoredeNazarVaseDashboardServant",
            data: { "moduleId": tabModuleid },
            beforeSend: sf1.setModuleHeaders
        }).done(function(result) {
            bindGrd(result);
        }).fail(function(xhr, status, error) {
            //alert(error);
        });

    });

    function bindGrd(type) {
        if (type == "پاسخ به استعلامات فعال") {
            $(".ajax-load").fadeIn(100);
            var sf1 = $.ServicesFramework(<%= ModuleId %>);
            var value1 = '<%= this.UserId %>';
            var tabModuleid1 = '<%= TabModuleId %>';
            $.ajax({
                type: "GET",
                url: sf1.getServiceRoot('EHamlLibrary') + "Dashboard/GetMyReplyToInquiryList",
                data: { "UserId": value1, "ModuleId": tabModuleid1 },
                beforeSend: sf1.setModuleHeaders
            }).done(function(result) {
                bindInquiryList(result);
                $(".ajax-load").fadeOut(300);
            }).fail(function(xhr, status, error) {
                alert(error);
            });
        } else if (type == "پاسخ به استعلامات قبلی") {
            $(".ajax-load").fadeIn(100);
            var sf2 = $.ServicesFramework(<%= ModuleId %>);
            var value2 = '<%= this.UserId %>';
            var tabModuleid2 = '<%= TabModuleId %>';
            $.ajax({
                type: "GET",
                url: sf2.getServiceRoot('EHamlLibrary') + "Dashboard/GetMyReplyToInquiryList",
                data: { "UserId": value2, "ModuleId": tabModuleid2 },
                beforeSend: sf2.setModuleHeaders
            }).done(function(result) {
                bindGrdMyInquirysTatikhGozashte(result);
                $(".ajax-load").fadeOut(300);
            }).fail(function(xhr, status, error) {
                //alert(error);
            });
        } else if (type == "معاملات موفق/نظرسنجی") {
            $(".ajax-load").fadeIn(100);
            var sf3 = $.ServicesFramework(<%= ModuleId %>);
            var value3 = '<%= this.UserId %>';
            $.ajax({
                type: "GET",
                url: sf3.getServiceRoot('EHamlLibrary') + "Dashboard/GetMyReplyToInquiryListThatAccepted",
                data: { "UserId": value3 },
                beforeSend: sf3.setModuleHeaders
            }).done(function(result) {
                bindGrdMyInquirysSuc(result);
                $(".ajax-load").fadeOut(300);
            }).fail(function(xhr, status, error) {
                //alert(error);
            });
        }
    }

    function bindGrdMyInquirysSuc(myInquirysList) {
        $("#grdInquiryListIReplySuc").kendoGrid({
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
                numeric: false
            },
            columns: [
                { title: "ردیف", field: "ReplyToInquiryId", width: "6px" },
                {
                    title: "اطلاعات استعلام",
                    field: "InquiryId",
                    width: "30px",
                    template:
                        function (dataItem) { return "<div><span class='ShomareEstelam'>شماره استعلام: " + dataItem.InquiryId + "</span><span class='CreateDateSuc'>تاریخ تایید: " + dataItem.CreateDate + "</span><span class='StartingPointSuc'>(" + dataItem.StartingPoint + ") به (" + dataItem.Destination + ")</span><span class='JoziyateEstelamKhSuc'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyateEstelamKh(\"" + dataItem.JoziyatLink + "\")'>جزئیات استعلام</a></span></div>" }
                },
                {
                    title: "اطلاعات صاحب بار",
                    field: "Power",
                    width: "60px",
                    template:
                        function (dataItem) { return "<div><div class='col1_Kh'><span class='titleKhadamatresan'>متقاضی استفاده از خدمات شما: </span><span class='NameKhadamatResan'>" + dataItem.NameSahebBar + "</span></div><div class='col2_Kh'><span class='EtelaateSherkat'><a class='k-button k-button-icontext' href='javascript:void(0)' onclick='UserInfoDetail(" + dataItem.InquiryId + ")'>اطلاعات صاحب بار</a></span><span class='joziyatePishnahadSuc_Kh'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyatePishnahadeBeEstelamEstelam(" + dataItem.ReplyToInquiryId + ")'>جزئیات پیشنهاد شما</a></span></div><div class='col3_Kh'><span class='qualitySucKh'>" + dataItem.Rank + "</span><span class='Power'>" + dataItem.Power + "</span><span class='NazareKhoob'>مثبت: " + dataItem.NazareKoliKhoob + "</span><span class='NazareBad'>منفی: " + dataItem.NazareKoliBad + "</span><span class='JoziyateNazarSanji_Kh'><a class='k-button k-button-icontext' href='javascript:void(0)' onclick='UserInfoDetail(" + dataItem.InquiryId + ',' + 1 + ")'>جزئیات نظرسنجی</a></span></div></div>" }
                },
                {
                    title: "عملیات",
                    field: "ServantId",
                    width: "20px",
                    template:
                        function(dataItem) {
                            if (dataItem.NazarSanjiVaziyat == "") {
                                return "<span class='ShomaGablanSherkatKadeed'><a href='javascript:void(0)' onclick='NazarSanjiKhadamatBeSahebView(" + dataItem.ReplyToInquiryId + ")' class='k-button k-button-icontext'>مشاهده نظر شما</a></span>";
                            } else if (dataItem.NazarSanjiVaziyat == "") {
                                return "<span class='ShomaGablanSherkatKadeed'><a href='javascript:void(0)' onclick='NazarSanjiKhadamatBeSaheb(" + dataItem.ReplyToInquiryId + ")' class='k-button k-button-icontext'>شرکت در نظر سنجی</a></span>";
                            } else {
                                return "<span class='ShomaGablanSherkatKadeed'>زمان شرکت در نظر سنجی فرا نرسیده</span>";
                            }
                        }
                }
            ]
        });

        $(".qualitySucKh").each(function() {
            $(this).html("<img src='/desktopmodules/mydnn_ehaml/mydnn_ehaml_inquiries/images/star_" + Math.round($(this).text()) + ".png' />");
        });

        //$(".CreateDateSuc").each(function() {
        //    var dt = $(this).html();
        //    var dt2 = dt.substr(13, 10);
        //    var myDate = Date.parse(dt2);
        //    //var year = dt2.substr(0, 4);
        //    //var month = dt2.substr(5, 2);
        //    //var day = dt2.substr(7, 2);
        //    $(this).text("تاریخ تایید: " + (ToPersianDate(myDate)));
        //});
    }

//    function ShowUserInfo(id) {
//        $.ajax({
//            type: "GET",
//            url: sf.getServiceRoot('MyDnn_ContentReview') + "Dashboard/GetUserInfo",
//            data: { "id": id },
//            beforeSend: sf.setModuleHeaders
//        }).done(function(result) {
//            showpopup(result);
//        }).fail(function(xhr, status, error) {
//            alert(error);
//        });
//    }



    function NazarSanjiKhadamatBeSaheb(irti) {
        var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=NazarSanji_KhadamatBeSaheb&popUp=true&inquiryReplyToInquiry_Id=", 1148, 3566) %>' + irti;
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }

    function NazarSanjiKhadamatBeSahebView(irti) {
        var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=NazarSanji_KhadamatBeSaheb&popUp=true&IsView=True&inquiryReplyToInquiry_Id=", 1148, 3566) %>' + irti;
        dnnModal.show(modulePath, true, 550, 960, false, '');
    }

    function bindGrdMyInquirysTatikhGozashte(inquiryList) {
        $("#grdInquiryListIReplyTarikhGozashte").kendoGrid({
            dataSource: {
                data: inquiryList,
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
                numeric: false
            },
            change: function (arg) {
                var selected = $.map(this.select(), function (item) {
                    return $(item).find('td').first().text();
                });
                bindMyInquiryReplyListTarikhGozashteStep1(selected);
            },
            columns: [
                { title: "ReplyToInquiryId", field: "ReplyToInquiryId", width: "1px" },
                { title: "ردیف", field: "ReplyToInquiryId", width: "30px" },
                {
                    title: "تاریخ درج",
                    field: "CreateDate",
                    width: "45px",
                    template:
                        function (dataItem) {
                            var myDate = Date.parse(dataItem.CreateDate);
                            return ToPersianDate(myDate);
                        }
                },
                { title: "نوع حمل", field: "InquiryType", width: "45px" },
                { title: "مبدا", field: "StartingPoint", width: "95px" },
                { title: "مقصد", field: "Destination", width: "95px" },
                {
                    title: "روز مانده",
                    field: "ExpireDate",
                    width: "35px",
                    template:
                        function (dataItem) {
                            return _diffDays(dataItem.ExpireDate);
                        }
                },
                { title: "شماره استعلام", field: "InquiryId", width: "53px" },
                {
                    title: "جزئیات استعلام",
                    field: "InquiryId",
                    width: "54px",
                    template:
                        function (dataItem) {
                            return "<span class='JoziyateEstelamKh'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyateEstelamKh(\"" + dataItem.JoziyatLink + "\")'>مشاهده</a></span>";
                        }
                },
                { title: "پاسخ ها", field: "TedadePasokhHa", width: "33px" },
                {
                    title: "نظر مشتری",
                    field: "Status",
                    width: "42px",
                    template:
                        function (dataItem) {
                            if (dataItem.Status == "پذیرفته شده") {
                                return "<span class='green'>green<a href='javascript:void(0)' onclick='ShowMoshakhasateSaheb(" + dataItem.SahebId + ")'></a></span>";
                            } else if (dataItem.Status == "پذیرفته نشده") {
                                return "<span class='red'>red</span>";
                            } else {
                                return "<span class='blue'>red</span>";
                            }
                        }
                }
            ]
        });
    }

    function bindInquiryList(inquiryList) {
        $("#grdInquiryListIReply").kendoGrid({
            dataSource: {
                data: inquiryList,
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
                numeric: false
            },
            change: function(arg) {
                var selected = $.map(this.select(), function(item) {
                    return $(item).find('td').first().text();
                });
                bindMyInquiryReplyListStep1(selected);
            },
            columns: [
                { title: "ReplyToInquiryId", field: "ReplyToInquiryId", width: "1px" },
                { title: "ردیف", field: "ReplyToInquiryId", width: "30px" },
                {
                    title: "تاریخ درج",
                    field: "CreateDate",
                    width: "45px",
                    template:
                        function(dataItem) {
                            var myDate = Date.parse(dataItem.CreateDate);
                            return ToPersianDate(myDate);
                        }
                },
                { title: "نوع حمل", field: "InquiryType", width: "45px" },
                { title: "مبدا", field: "StartingPoint", width: "95px" },
                { title: "مقصد", field: "Destination", width: "95px" },
                {
                    title: "روز مانده",
                    field: "ExpireDate",
                    width: "35px",
                    template:
                        function(dataItem) {
                            return _diffDays(dataItem.ExpireDate);
                        }
                },
                { title: "شماره استعلام", field: "InquiryId", width: "53px" },
                {
                    title: "جزئیات استعلام",
                    field: "InquiryId",
                    width: "54px",
                    template:
                        function(dataItem) {
                            return "<span class='JoziyateEstelamKh'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyateEstelamKh(\"" + dataItem.JoziyatLink + "\")'>مشاهده</a></span>";
                        }
                },
                { title: "پاسخ ها", field: "TedadePasokhHa", width: "33px" },
                {
                    title: "نظر مشتری",
                    field: "Status",
                    width: "42px",
                    template:
                        function(dataItem) {
                            if (dataItem.Status == "پذیرفته شده") {
                                return "<span class='green'>green<a href='javascript:void(0)' onclick='ShowMoshakhasateSaheb(" + dataItem.SahebId + ")'></a></span>";
                            } else if (dataItem.Status == "پذیرفته نشده") {
                                return "<span class='red'>red</span>";
                            } else {
                                return "<span class='blue'>blue</span>";
                            }
                        }
                }
            ]
        });
    }

    function bindMyInquiryReplyListStep1(value) {
        var sf = $.ServicesFramework(<%= ModuleId %>);

        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('EHamlLibrary') + "Dashboard/GetMyReplyToInquiryDetail",
            data: { "myReplyToInquiryId": value },
            beforeSend: sf.setModuleHeaders
        }).done(function (result) {
            bindMyInquiryReplyListStep2(result);
        }).fail(function(xhr, status, error) {
            alert(error);
        });
    }

    function bindMyInquiryReplyListTarikhGozashteStep1(value) {
        var sf = $.ServicesFramework(<%= ModuleId %>);
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('EHamlLibrary') + "Dashboard/GetMyReplyToInquiryDetail",
            data: { "myReplyToInquiryId": value },
            beforeSend: sf.setModuleHeaders
        }).done(function (result) {
            bindMyInquiryReplyListTarikhGozashteStep2(result);
        }).fail(function(xhr, status, error) {
            alert(error);
        });
    }

    function bindMyInquiryReplyListStep2(value) {

        $("#grdInquiryReplyDetail").kendoGrid({
            dataSource: {
                data: value,
                pageSize: 7
            },
            height: 310,
            groupable: false,
            resizable: false,
            columnMenu: false,
            scrollable: true,
            sortable: true,
            filterable: true,
            pageable: {
                input: true,
                numeric: false
            },
            columns: [
                { title: "ردیف", field: "ReplyToInquiryId", width: "6px" },
                <%--    {--%>
                <%--        title: "اطلاعات خدمت رسان", field: "Power", width: "20px",--%>
                <%--        template:--%>
                <%--        function (dataItem) { return "<div><span class='quality'>" + dataItem.Rank + "</span><span class='Power'>" + dataItem.Power + "</span><span class='NazareKhoob'>مثبت: " + dataItem.NazareKoliKhoob + "</span><span class='NazareBad'>منفی: " + dataItem.NazareKoliBad + "</span><span class='JoziyateNazarSanji'><a class='k-button k-button-icontext' href='#'>جزئیات نظر سنجی</a></span></div>" }--%>
                <%----%>
                <%--    },--%>
                {
                    title: "اطلاعات پیشنهاد شما",
                    field: "ReplyToInquiryId",
                    width: "47px",
                    template:
                        function(dataItem) {
                            if (dataItem.Status == "پذیرفته شده") {
                                return "<div><span class='TarikheErsal'>تاریخ ارسال: " + dataItem.ReplyToInquiryCreateDate + "</span><span class='ZamaneAmadegiBarayeShooroo'>زمان آماده به حمل: " + dataItem.ZamaneAmadegiBarayeShooroo + "</span><span class='GeymateKol'>قیمت کل: " + dataItem.GeymateKol + " ریال </span><span class='PishbiniKh'>پیش بینی وضعیت حمل: " + dataItem.Pishbini + "</span><span class='ModatZamaneHaml'>مدت انجام عملیات: " + dataItem.ModateAnjameAmaliyat + " روز </span><div class='downContent'><span class='classInsideDiv'></span><span class='VaziyatePishnahadOk'>پیشنهاد شما پذیرفته شده است!</span><span class='twoRelatetToSahebInfo'><span class='SahebName'>" + dataItem.DisplayName + "</span><span class='MoshakhasateSaheb' ><a class='k-button k-button-icontext' href='javascript:void(0)' onclick='UserInfoDetail(" + dataItem.InquiryId +")'>مشخصات صاحب بار</a></span></span></div></div>";
                            } else if (dataItem.Status == "پذیرفته نشده") {
                                return "<div><span class='TarikheErsal'>تاریخ ارسال: " + dataItem.ReplyToInquiryCreateDate + "</span><span class='ZamaneAmadegiBarayeShooroo'>زمان آماده به حمل: " + dataItem.ZamaneAmadegiBarayeShooroo + "</span><span class='GeymateKol'>قیمت کل: " + dataItem.GeymateKol + " ریال </span><span class='PishbiniKh'>پیش بینی وضعیت حمل: " + dataItem.Pishbini + "</span><span class='ModatZamaneHaml'>مدت انجام عملیات: " + dataItem.ModateAnjameAmaliyat + " روز </span><div class='downContent'><span class='classInsideDiv'><span class='VaziyatePishnahadNotOk'>\پیشنهاد شما پذیرفته نشده است!</span></div></div>";
                            } else if (dataItem.Status == "در حال بررسی") {
                                return "<div><span class='TarikheErsal'>تاریخ ارسال: " + dataItem.ReplyToInquiryCreateDate + "</span><span class='ZamaneAmadegiBarayeShooroo'>زمان آماده به حمل: " + dataItem.ZamaneAmadegiBarayeShooroo + "</span><span class='GeymateKol'>قیمت کل: " + dataItem.GeymateKol + " ریال </span><span class='PishbiniKh'>پیش بینی وضعیت حمل: " + dataItem.Pishbini + "</span><span class='ModatZamaneHaml'>مدت انجام عملیات: " + dataItem.ModateAnjameAmaliyat + " روز </span><div class='downContent'><span class='classInsideDiv'><span class='VaziyatePishnahadBarrasi'>\پیشنهاد شما در حال بررسی است.</span></div></div>";
                            }
                        }
                },
                {
                    title: "جزئیات پیشنهاد شما",
                    field: "ReplyToInquiryId",
                    width: "14px",
                    template:
                        function (dataItem) { return "<span class='JoziyatePishnahad'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyatePishnahadeBeEstelamEstelam(" + dataItem.ReplyToInquiryId + ")'>جزئیات پیشنهاد</a></span>" }
                },
            ]
        });

        //$(".TarikheErsal").each(function() {
        //    var dt = $(this).html();
        //    var dt2 = dt.substr(13, 10);
        //    var myDate = Date.parse(dt2);
        //    //var year = dt2.substr(0, 4);
        //    //var month = dt2.substr(5, 2);
        //    //var day = dt2.substr(7, 2);
        //    $(this).text("تاریخ ارسال: " + (ToPersianDate(myDate)));
        //});
        //$(".ZamaneAmadegiBarayeShooroo").each(function() {
        //    var dt = $(this).html();
        //    var dt2 = dt.substr(19, 10);
        //    var myDate = Date.parse(dt2);
        //    //var year = dt2.substr(0, 4);
        //    //var month = dt2.substr(5, 2);
        //    //var day = dt2.substr(7, 2);
        //    $(this).text("زمان آماده به حمل: " + (ToPersianDate(myDate)));
        //});
    }

    function bindMyInquiryReplyListTarikhGozashteStep2(value) {
        $("#grdInquiryReplyDetailTarikhGozashte").kendoGrid({
            dataSource: {
                data: value,
                pageSize: 7
            },
            height: 310,
            groupable: false,
            resizable: false,
            columnMenu: false,
            scrollable: true,
            sortable: true,
            filterable: true,
            pageable: {
                input: true,
                numeric: false
            },
            columns: [
                { title: "ردیف", field: "ReplyToInquiryId", width: "6px" },
                <%--    {--%>
                <%--        title: "اطلاعات خدمت رسان", field: "Power", width: "20px",--%>
                <%--        template:--%>
                <%--        function (dataItem) { return "<div><span class='quality'>" + dataItem.Rank + "</span><span class='Power'>" + dataItem.Power + "</span><span class='NazareKhoob'>مثبت: " + dataItem.NazareKoliKhoob + "</span><span class='NazareBad'>منفی: " + dataItem.NazareKoliBad + "</span><span class='JoziyateNazarSanji'><a class='k-button k-button-icontext' href='#'>جزئیات نظر سنجی</a></span></div>" }--%>
                <%----%>
                <%--    },--%>
                {
                    title: "اطلاعات پیشنهاد شما",
                    field: "ReplyToInquiryId",
                    width: "47px",
                    template:
                        function (dataItem) {
                            if (dataItem.Status == "پذیرفته شده") {
                                return "<div><span class='TarikheErsal'>تاریخ ارسال: " + dataItem.ReplyToInquiryCreateDate + "</span><span class='ZamaneAmadegiBarayeShooroo'>زمان آماده به حمل: " + dataItem.ZamaneAmadegiBarayeShooroo + "</span><span class='GeymateKol'>قیمت کل: " + dataItem.GeymateKol + " ریال </span><span class='PishbiniKh'>پیش بینی وضعیت حمل: " + dataItem.Pishbini + "</span><span class='ModatZamaneHaml'>مدت انجام عملیات: " + dataItem.ModateAnjameAmaliyat + " روز </span><div class='downContent'><span class='classInsideDiv'></span><span class='VaziyatePishnahadOk'>پیشنهاد شما پذیرفته شده است!</span><span class='twoRelatetToSahebInfo'><span class='SahebName'>" + dataItem.DisplayName + "</span><span class='MoshakhasateSaheb' ><a class='k-button k-button-icontext' href='javascript:void(0)' onclick='UserInfoDetail(" + dataItem.InquiryId + ")'>مشخصات صاحب بار</a></span></span></div></div>";
                            } else if (dataItem.Status == "پذیرفته نشده") {
                                return "<div><span class='TarikheErsal'>تاریخ ارسال: " + dataItem.ReplyToInquiryCreateDate + "</span><span class='ZamaneAmadegiBarayeShooroo'>زمان آماده به حمل: " + dataItem.ZamaneAmadegiBarayeShooroo + "</span><span class='GeymateKol'>قیمت کل: " + dataItem.GeymateKol + " ریال </span><span class='PishbiniKh'>پیش بینی وضعیت حمل: " + dataItem.Pishbini + "</span><span class='ModatZamaneHaml'>مدت انجام عملیات: " + dataItem.ModateAnjameAmaliyat + " روز </span><div class='downContent'><span class='classInsideDiv'><span class='VaziyatePishnahadNotOk'>\پیشنهاد شما پذیرفته نشده است!</span></div></div>";
                            } else if (dataItem.Status == "در حال بررسی") {
                                return "<div><span class='TarikheErsal'>تاریخ ارسال: " + dataItem.ReplyToInquiryCreateDate + "</span><span class='ZamaneAmadegiBarayeShooroo'>زمان آماده به حمل: " + dataItem.ZamaneAmadegiBarayeShooroo + "</span><span class='GeymateKol'>قیمت کل: " + dataItem.GeymateKol + " ریال </span><span class='PishbiniKh'>پیش بینی وضعیت حمل: " + dataItem.Pishbini + "</span><span class='ModatZamaneHaml'>مدت انجام عملیات: " + dataItem.ModateAnjameAmaliyat + " روز </span><div class='downContent'><span class='classInsideDiv'><span class='VaziyatePishnahadBarrasi'>\پیشنهاد شما در حال بررسی است.</span></div></div>";
                            }
                        }
                },
                {
                    title: "جزئیات پیشنهاد شما",
                    field: "ReplyToInquiryId",
                    width: "14px",
                    template:
                        function (dataItem) { return "<span class='JoziyatePishnahad'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyatePishnahadeBeEstelamEstelam(" + dataItem.ReplyToInquiryId + ")'>جزئیات پیشنهاد</a></span>" }
                },
            ]
        });

        //$(".TarikheErsal").each(function() {
        //    var dt = $(this).html();
        //    var dt2 = dt.substr(13, 10);
        //    var myDate = Date.parse(dt2);
        //    //var year = dt2.substr(0, 4);
        //    //var month = dt2.substr(5, 2);
        //    //var day = dt2.substr(7, 2);
        //    $(this).text("تاریخ ارسال: " + (ToPersianDate(myDate)));
        //});
        //$(".ZamaneAmadegiBarayeShooroo").each(function() {
        //    var dt = $(this).html();
        //    var dt2 = dt.substr(19, 10);
        //    var myDate = Date.parse(dt2);
        //    //var year = dt2.substr(0, 4);
        //    //var month = dt2.substr(5, 2);
        //    //var day = dt2.substr(7, 2);
        //    $(this).text("زمان آماده به حمل: " + (ToPersianDate(myDate)));
        //});
    }

    function UserInfoDetail(IRTIId, Type) {
        var modulePath = "/default.aspx?tabid=1147&mid=3561&ctl=UserInfo&IRTIId=" + IRTIId + "&Type=" + Type + "&popUp=true";
        dnnModal.show(modulePath, false, 550, 960, false, '');
    }

    function UserInfoDetailWithoutPersonalInfo(IRTIId, Type) {
        var modulePath = "/default.aspx?tabid=1147&mid=3561&ctl=UserInfo&IRTIId=" + IRTIId + "&Type=" + Type + "&Info=M&popUp=true";
        dnnModal.show(modulePath, false, 550, 960, false, '');
    }


    function JoziyatePishnahadeBeEstelamEstelam(irti) {
        var modulePath = "/default.aspx?tabid=1147&mid=3561&ctl=ReplyToInquiryShenasname&RepId=" + irti + "&popUp=true";
        dnnModal.show(modulePath, false, 550, 960, false, '');
    }

    function JoziyateEstelamKh(link) {
        var modulePath = link;
        dnnModal.show(modulePath, false, 550, 960, false, '');
    }
</script>