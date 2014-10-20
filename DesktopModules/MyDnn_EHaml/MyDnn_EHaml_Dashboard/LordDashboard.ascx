<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LordDashboard.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_LordDashboard" %>
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
        <div id="grdMyInquirys" class="k-rtl"></div>
    </div>
    <div class="dnnFormItem MyInquirysReplyd">
        <div id="grdMyInquirysReplyd" class="k-rtl"></div>
    </div>
    <div class="dnnFormItem">
        <div id="grdMyInquirysTarikhGozashte" class="k-rtl"></div>
    </div>
    <div class="dnnFormItem MyInquirysReplydTarikhGozashte" style="margin-top: 60px">
        <div id="grdMyInquirysReplydTarikhGozashte" class="k-rtl"></div>
    </div>
    <div class="dnnFormItem">
        <div id="grdMySucInquirys" class="k-rtl"></div>
    </div>
    <div class="ajax-load">
    </div>
</div>
<div runat="server" id="isKhadamatresan" class="IsKhadamatresan" Visible="False"></div>

<script type="text/javascript">
    $(document).ready(function () {
        if ($(".IsKhadamatresan").length == 0) {
            $(".khadamateMan").hide();
            $(".ElamiyeHayeMan").hide();

        }
        var sf0 = $.ServicesFramework(<%= ModuleId %>);
        var value0 = '<%= this.UserId %>';
        var tabModuleid0 = '<%= TabModuleId %>';
        $.ajax({
            type: "GET",
            url: sf0.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/GetGrideMoredeNazarVaseDashboardSaheb",
            data: { "moduleId": tabModuleid0 },
            beforeSend: sf0.setModuleHeaders
        }).done(function(result) {
            bindGrdS(result);
        }).fail(function(xhr, status, error) {
            //alert(error);
        });
    });

    function bindGrdS(type) {
        if (type == 2) {

            $(".ajax-load").fadeIn(100);
            var sf2 = $.ServicesFramework(<%= ModuleId %>);
            var value2 = '<%= this.UserId %>';
            var tabModulei2 = '<%= TabModuleId %>';
            $.ajax({
                type: "GET",
                url: sf2.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/MyinquirysList",
                data: { "UserId": value2, "ModuleId": tabModulei2 },
                beforeSend: sf2.setModuleHeaders
            }).done(function(result) {
                bindGrdMyInquirysS(result);
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
                url: sf1.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/MyinquirysListSuc",
                data: { "UserId": value1 },
                beforeSend: sf1.setModuleHeaders
            }).done(function(result) {
                bindGrdMyInquirysSucS(result);
                $(".ajax-load").fadeOut(300);
            }).fail(function(xhr, status, error) {
                //alert(error);
            });
        } else if (type == 0) {
            $(".MyInquirysReplyd").fadeOut();

            $(".ajax-load").fadeIn(100);
            var sf00 = $.ServicesFramework(<%= ModuleId %>);
            var value00 = '<%= this.UserId %>';
            var tabModulei00 = '<%= TabModuleId %>';
            $.ajax({
                type: "GET",
                url: sf00.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/MyinquirysList",
                data: { "UserId": value00, "ModuleId": tabModulei00 },
                beforeSend: sf00.setModuleHeaders
            }).done(function(result) {
                bindGrdMyInquirysTarikhGozashteS(result);
                //processTokens();
                $(".ajax-load").fadeOut(300);
            }).fail(function(xhr, status, error) {
                //alert(error);
            });
        }

    }

    function bindGrdMyInquirysSucS(myInquirysList) {
        $("#grdMySucInquirys").kendoGrid({
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
                { title: "ردیف", field: "Id", width: "6px" },
                {
                    title: "اطلاعات استعلام",
                    field: "Id",
                    width: "30px",
                    template:
                        function(dataItem) { return "<div><span class='ShomareEstelam'>شماره استعلام: " + dataItem.Id + "</span><span class='CreateDateSuc'>تاریخ تایید: " + dataItem.CreateDate + "</span><span class='StartingPointSuc'>(" + dataItem.StartingPoint + ") به (" + dataItem.Destination + ")</span><span class='JoziyateEstelamSSuc'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyateEstelamS(\"" + dataItem.JoziyatLink + "\")'>جزئیات استعلام</a></span></div>" }
                },
                {
                    title: "اطلاعات خدمت رسان",
                    field: "Power",
                    width: "60px",
                    template:
                        function(dataItem) { return "<div><div class='col1'><span class='titleKhadamatresan'>خدمات رسان منتخب شما: </span><span class='NameKhadamatResan'>" + dataItem.NameKhedmatresan + "</span></div><div class='col2'><span class='EtelaateSherkat'><a class='k-button k-button-icontext' href='javascript:void(0)' onclick='UserInfoDetail(" + dataItem.irti + ',' + 0 + ")'>اطلاعات خدمات رسان</a></span><span class='joziyatePishnahadSuc'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyatePishnahadeBeEstelamEstelamS(" + dataItem.irti + ")'>جزئیات پیشنهاد</a></span></div><div class='col3'><span class='qualitySuc'>" + dataItem.Rank + "</span><span class='Power'>" + dataItem.Power + "</span><span class='NazareKhoob'>مثبت: " + dataItem.NazareKoliyeKhoob + "</span><span class='NazareBad'>منفی: " + dataItem.NazareKoliyeBad + "</span><span class='JoziyateNazarSanji'><a class='k-button k-button-icontext' href='javascript:void(0)' onclick='UserInfoDetail(" + dataItem.irti + ',' + 0 + ")'>جزئیات نظرسنجی</a></span></div></div>" }
                },
                {
                    title: "عملیات",
                    field: "KhadamatresanId",
                    width: "20px",
                    template:
                        function(dataItem) {
                            if (dataItem.NazarSanjiVaziyat == 0) {
                                return "<span class='ShomaGablanSherkatKadeed'><a href='javascript:void(0)' onclick='NazarSanjiSahebBeKhadamatView(" + dataItem.irti + ")' class='k-button k-button-icontext'>مشاهده نظر شما</a></span>";
                            } else if (dataItem.NazarSanjiVaziyat == 1) {
                                return "<span class='ShomaGablanSherkatKadeed'><a href='javascript:void(0)' onclick='NazarSanjiSahebBeKhadamat(" + dataItem.irti + ")' class='k-button k-button-icontext'>شرکت در نظر سنجی</a></span>";
                            } else {
                                return "<span class='ShomaGablanSherkatKadeed'>زمان شرکت در نظر سنجی فرا نرسیده</span>";
                            }
                        }
                }
            ]
        });

        $(".qualitySuc").each(function() {
            $(this).html("<img src='/desktopmodules/mydnn_ehaml/mydnn_ehaml_inquiries/images/star_" + Math.round($(this).text()) + ".png' />");
        });
        $(".CreateDateSuc").each(function() {
            var dt = $(this).html();
            var dt2 = dt.substr(13, 10);
            var myDate = Date.parse(dt2);
            //var year = dt2.substr(0, 4);
            //var month = dt2.substr(5, 2);
            //var day = dt2.substr(7, 2);
            $(this).text("تاریخ تایید: " + (ToPersianDate(myDate)));
        });

    }

    function NazarSanjiSahebBeKhadamat(irti) {
        var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=NazarSanji_SahebBeKhadamat&popUp=true&inquiryReplyToInquiry_Id=", 1148, 3566) %>' + irti;
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }

    function NazarSanjiSahebBeKhadamatView(irti) {
        var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=NazarSanji_SahebBeKhadamat&popUp=true&IsView=True&inquiryReplyToInquiry_Id=", 1148, 3566) %>' + irti;
        dnnModal.show(modulePath, true, 550, 960, false, '');
    }


    function bindGrdMyInquirysTarikhGozashteS(myInquirysList) {
        $("#grdMyInquirysTarikhGozashte").kendoGrid({
            dataSource: {
                data: myInquirysList,
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
                bindMyInquiryReplyListTarikhGozashteStep1S(selected);
            },
            columns: [
                { title: "ردیف", field: "Id", width: "30px" },
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
                { title: "نوع حمل", field: "InquiryType", width: "50px" },
                { title: "مبدا", field: "StartingPoint", width: "100px" },
                { title: "مقصد", field: "Destination", width: "100px" },
                {
                    title: "روز مانده",
                    field: "ExpireDate",
                    width: "35px",
                    template:
                        function(dataItem) {
                            return _diffDays(dataItem.ExpireDate);
                        }
                },
                { title: "شماره استعلام", field: "Id", width: "55px" },
                {
                    title: "جزئیات استعلام",
                    field: "Id",
                    width: "55px",
                    template:
                        function(dataItem) {
                            return "<span class='JoziyateEstelamS'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyateEstelamS(\"" + dataItem.JoziyatLink + "\")'>مشاهده</a></span>";
                        }
                },
                { title: "پاسخ ها", field: "TedadePasokhha", width: "35px" }
            ]
        });
    }

    function bindGrdMyInquirysS(myInquirysList) {
        $("#grdMyInquirys").kendoGrid({
            dataSource: {
                data: myInquirysList,
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
                bindMyInquiryReplyListStep1S(selected);
            },
            columns: [
                { title: "ردیف", field: "Id", width: "1px" },
                { title: "ردیف", field: "Id0", width: "30px" },
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
                { title: "نوع حمل", field: "InquiryType", width: "50px" },
                { title: "مبدا", field: "StartingPoint", width: "100px" },
                { title: "مقصد", field: "Destination", width: "100px" },
                {
                    title: "روز مانده",
                    field: "ExpireDate",
                    width: "35px",
                    template:
                        function(dataItem) {
                            return _diffDays(dataItem.ExpireDate);
                        }
                },
                { title: "شماره استعلام", field: "Id", width: "55px" },
                {
                    title: "جزئیات استعلام",
                    field: "Id",
                    width: "55px",
                    template:
                        function(dataItem) {
                            return "<span class='JoziyateEstelamS'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyateEstelamS(\"" + dataItem.JoziyatLink + "\")'>مشاهده</a></span>";
                        }
                },
                { title: "پاسخ ها", field: "TedadePasokhha", width: "35px" }
            ]
        });
    }

    function replyToInquiry(id) {
        window.location = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl={2}&InqId=", this.TabId, this.ModuleId, Settings["NameControlForReply"]) %>' + id;
    }

    function bindMyInquiryReplyListStep1S(arg) {
        var sf = $.ServicesFramework(<%= ModuleId %>);
        var inqId = arg;

        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/MyinquirysReplyList",
            data: { "inquiryID": inqId },
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            bindMyInquiryReplyListStep2S(result);
        }).fail(function(xhr, status, error) {
            //alert(error);
        });

    };

    function bindMyInquiryReplyListTarikhGozashteStep1S(arg) {
        var sf = $.ServicesFramework(<%= ModuleId %>);
        var inqId = arg;

        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/MyinquirysReplyList",
            data: { "inquiryID": inqId },
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            bindMyInquiryReplyListTarikhGozashteStep2S(result);
        }).fail(function(xhr, status, error) {
            //alert(error);
        });

    };

    function bindMyInquiryReplyListStep2S(myInquirysReply) {
        $("#grdMyInquirysReplyd").kendoGrid({
            dataSource: {
                data: myInquirysReply,
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
                numeric: true
            },
            columns: [
                { title: "ردیف", field: "Id", width: "6px" },
                {
                    title: "اطلاعات خدمت رسان",
                    field: "Power",
                    width: "20px",
                    template:
                        function(dataItem) { return "<div><span class='quality'>" + dataItem.Rank + "</span><span class='Power'>" + dataItem.Power + "</span><span class='NazareKhoob'>مثبت: " + dataItem.NazareKoliKhoob + "</span><span class='NazareBad'>منفی: " + dataItem.NazareKoliBad + "</span><span class='JoziyateNazarSanji'><a class='k-button k-button-icontext' onclick='UserInfoDetailWithoutPersonalInfo(" + dataItem.Id + ',' + 0 + ")' href='javascript:void(0)'>جزئیات نظر سنجی</a></span></div>" }
                },
                {
                    title: "اطلاعات پیشنهاد",
                    field: "Id",
                    width: "47px",
                    template:
                        function(dataItem) { return "<div><span class='TarikheErsal'>تاریخ ارسال: " + dataItem.CreateDate + "</span><span class='ZamaneAmadegiBarayeShooroo'>زمان آماده به حمل: " + dataItem.ZamaneAmadegiBarayeShooroo + "</span><span class='GeymateKol'>قیمت کل: " + dataItem.GeymateKol + " ریال </span><span class='Pishbini'>پیش بینی وضعیت حمل: " + dataItem.Pishbini + "</span></div>" }
                },
                {
                    title: "جزئیات پیشنهاد",
                    field: "Id",
                    width: "14px",
                    template:
                        function(dataItem) { return "<span class='JoziyatePishnahad'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyatePishnahadeBeEstelamEstelamS(" + dataItem.Id + ")'>جزئیات پیشنهاد</a></span>" }
                },
                {
                    title: "عملیات",
                    field: "ZamaneAmadegiBarayeShooroo",
                    width: "17px",
                    template:
                        function(dataItem) {
                            if (dataItem.VaziyatePaziresh == "1") {
                                return "<div><span class='NameKhedmatresan amaliyat'>" + dataItem.NameKhedmatresan + "</span><span class='MoshahedeyeEtelaateTamas'><a class='k-button k-button-icontext' href='javascript:void(0)' onclick='UserInfoDetail(" + dataItem.Id + ',' + 0 + ")'>اطلاعات تماس</a></span></div>";
                            } else if (dataItem.VaziyatePaziresh == "2") {
                                return "<div><span class='BaPishnahadMovafegam amaliyat'><a class='k-button k-button-icontext' <a href='javascript:void(0)' onclick='BaPishnahadMovafeghamS(" + dataItem.Id + ',' + dataItem.inqId + ")'>با این پیشنهاد موافقم</a></span></div>";
                            } else {
                                return "<div><span class='GablanPasohkeManfi amaliyat'>قبلآ به این پیشنهاد پاسخ منفی داده اید</span></div>"
                            }
                        }
                }

                <%--                {--%>
                <%--                    title: "نظرسنجی",--%>
                <%--                    field: "NazarSanji",--%>
                <%--                    width: "20px",--%>
                <%--                    template:--%>
                <%--                        function (dataItem) {--%>
                <%--                            if (dataItem.NazarSanji == "Yes") {--%>
                <%--                                return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='SherkatDarNazarSanji(" + dataItem.Id + ")'><span class=' '></span>شرکت در نظر سنجی</a>";--%>
                <%--                            } else if (dataItem.NazarSanji == "SherkatKarde") {--%>
                <%--                                return "<span class=' '>قبلآ در نظر سنجی شرکت نموده اید</span>";--%>
                <%--                            } else {--%>
                <%--                                return "<span class=' '>زمان شرکت در نظر سنجی فرا نرسیده</span>";--%>
                <%--                            }--%>
                <%----%>
                <%--                        }--%>
                <%--                },--%>
                <%--                {--%>
                <%--                    title: "جزئیات",--%>
                <%--                    field: "Id",--%>
                <%--                    width: "19px",--%>
                <%--                    change: function (arg) {--%>
                <%--                        var selected = $.map(this.select(), function (item) {--%>
                <%--                            return $(item).find('td').first().text();--%>
                <%--                        });--%>
                <%--                    },--%>
                <%--                    template:--%>
                <%--                        function (dataItem) {--%>
                <%--                            if (dataItem.DisplayName == "***") {--%>
                <%--                                return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='replyDetaildS(" + dataItem.Id + ")'><span class=' '></span>مشاهده</a>";--%>
                <%--                            } else {--%>
                <%--                                return "<span class=' '>قبلآ تایید نموده اید</span>";--%>
                <%--                            }--%>
                <%----%>
                <%--                        }--%>
                <%--                }--%>
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
            $(this).text("تاریخ ارسال: " + (ToPersianDate(myDate)));
        });
        $(".ZamaneAmadegiBarayeShooroo").each(function() {
            var dt = $(this).html();
            var dt2 = dt.substr(19, 10);
            var myDate = Date.parse(dt2);
            //var year = dt2.substr(0, 4);
            //var month = dt2.substr(5, 2);
            //var day = dt2.substr(7, 2);
            $(this).text("زمان آماده به حمل: " + (ToPersianDate(myDate)));
        });
    }

    function UserInfoDetail(IRTIId, Type) {
        var modulePath = "/default.aspx?tabid=1147&mid=3561&ctl=UserInfo&IRTIId=" + IRTIId + "&Type=" + Type + "&popUp=true";
        dnnModal.show(modulePath, true, 550, 960, false, '');
    }

    function UserInfoDetailWithoutPersonalInfo(IRTIId, Type) {
        var modulePath = "/default.aspx?tabid=1147&mid=3561&ctl=UserInfo&IRTIId=" + IRTIId + "&Type=" + Type + "&Info=M&popUp=true";
        dnnModal.show(modulePath, true, 550, 960, false, '');
    }


    function bindMyInquiryReplyListTarikhGozashteStep2S(myInquirysReply) {
        $("#grdMyInquirysReplydTarikhGozashte").kendoGrid({
            dataSource: {
                data: myInquirysReply,
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
                numeric: true
            },
            columns: [
                { title: "ردیف", field: "Id", width: "6px" },
                {
                    title: "اطلاعات خدمت رسان",
                    field: "Power",
                    width: "20px",
                    template:
                        function(dataItem) { return "<div><span class='qualityTarikhGozashte'>" + dataItem.Rank + "</span><span class='Power'>" + dataItem.Power + "</span><span class='NazareKhoob'>مثبت: " + dataItem.NazareKoliKhoob + "</span><span class='NazareBad'>منفی: " + dataItem.NazareKoliBad + "</span><span class='JoziyateNazarSanji'><a class='k-button k-button-icontext' href='#'>جزئیات نظر سنجی</a></span></div>" }
                },
                {
                    title: "اطلاعات پیشنهاد",
                    field: "Id",
                    width: "47px",
                    template:
                        function(dataItem) { return "<div><span class='TarikheErsal'>تاریخ ارسال: " + dataItem.CreateDate + "</span><span class='ZamaneAmadegiBarayeShooroo'>زمان آماده به حمل: " + dataItem.ZamaneAmadegiBarayeShooroo + "</span><span class='GeymateKol'>قیمت کل: " + dataItem.GeymateKol + " ریال </span><span class='Pishbini'>پیش بینی وضعیت حمل: " + dataItem.Pishbini + "</span></div>" }
                },
                {
                    title: "جزئیات پیشنهاد",
                    field: "Id",
                    width: "14px",
                    template:
                        function(dataItem) { return "<span class='JoziyatePishnahad'><a href='javascript:void(0)' class='k-button k-button-icontext' onclick='JoziyatePishnahadeBeEstelamEstelamS(" + dataItem.Id + ")'>جزئیات پیشنهاد</a></span>" }
                },
                {
                    title: "عملیات",
                    field: "ZamaneAmadegiBarayeShooroo",
                    width: "17px",
                    template:
                        function(dataItem) {
                            if (dataItem.VaziyatePaziresh == "1") {
                                return "<div><span class='NameKhedmatresan amaliyat'>" + dataItem.NameKhedmatresan + "</span><span class='MoshahedeyeEtelaateTamas'><a class='k-button k-button-icontext' href='javascript:void(0)' onclick='UserInfoDetail(" + dataItem.Id + ',' + 0 + ")'>اطلاعات تماس</a></span></div>"
                            } else if (dataItem.VaziyatePaziresh == "0") {
                                return "<div><span class='GablanPasohkeManfi amaliyat'>قبلآ به این پیشنهاد پاسخ منفی داده اید</span></div>"
                            } else if (dataItem.VaziyatePaziresh == "2") {
                                return "<div><span class='BaPishnahadMovafegamTarikhGozashte amaliyat'><a class='k-button k-button-icontext' <a href='javascript:void(0)' onclick='BaPishnahadMovafeghamS(" + dataItem.Id + ',' + dataItem.inqId + ")'>با این پیشنهاد موافقم</a></span></div>";
                            } else {
                                return "<div><span class='GablanPasohkeManfi amaliyat'>قبلآ به این پیشنهاد پاسخ منفی داده اید</span></div>"
                            }
                        }
                }
                <%--                {--%>
                <%--                    title: "نظرسنجی",--%>
                <%--                    field: "NazarSanji",--%>
                <%--                    width: "20px",--%>
                <%--                    template:--%>
                <%--                        function (dataItem) {--%>
                <%--                            if (dataItem.NazarSanji == "Yes") {--%>
                <%--                                return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='SherkatDarNazarSanji(" + dataItem.Id + ")'><span class=' '></span>شرکت در نظر سنجی</a>";--%>
                <%--                            } else if (dataItem.NazarSanji == "SherkatKarde") {--%>
                <%--                                return "<span class=' '>قبلآ در نظر سنجی شرکت نموده اید</span>";--%>
                <%--                            } else {--%>
                <%--                                return "<span class=' '>زمان شرکت در نظر سنجی فرا نرسیده</span>";--%>
                <%--                            }--%>
                <%----%>
                <%--                        }--%>
                <%--                },--%>
                <%--                {--%>
                <%--                    title: "جزئیات",--%>
                <%--                    field: "Id",--%>
                <%--                    width: "19px",--%>
                <%--                    change: function (arg) {--%>
                <%--                        var selected = $.map(this.select(), function (item) {--%>
                <%--                            return $(item).find('td').first().text();--%>
                <%--                        });--%>
                <%--                    },--%>
                <%--                    template:--%>
                <%--                        function (dataItem) {--%>
                <%--                            if (dataItem.DisplayName == "***") {--%>
                <%--                                return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='replyDetaildS(" + dataItem.Id + ")'><span class=' '></span>مشاهده</a>";--%>
                <%--                            } else {--%>
                <%--                                return "<span class=' '>قبلآ تایید نموده اید</span>";--%>
                <%--                            }--%>
                <%----%>
                <%--                        }--%>
                <%--                }--%>
            ]
        });

        $(".qualityTarikhGozashte").each(function() {
            $(this).html("<img src='/desktopmodules/mydnn_ehaml/mydnn_ehaml_inquiries/images/star_" + Math.round($(this).text()) + ".png' />");
        });
        $(".TarikheErsal").each(function() {
            var dt = $(this).html();
            var dt2 = dt.substr(13, 10);
            var myDate = Date.parse(dt2);
            //var year = dt2.substr(0, 4);
            //var month = dt2.substr(5, 2);
            //var day = dt2.substr(7, 2);
            $(this).text("تاریخ ارسال: " + (ToPersianDate(myDate)));
        });
        $(".ZamaneAmadegiBarayeShooroo").each(function() {
            var dt = $(this).html();
            var dt2 = dt.substr(19, 10);
            var myDate = Date.parse(dt2);
            //var year = dt2.substr(0, 4);
            //var month = dt2.substr(5, 2);
            //var day = dt2.substr(7, 2);
            $(this).text("زمان آماده به حمل: " + (ToPersianDate(myDate)));
        });
    }

    function JoziyatePishnahadeBeEstelamEstelamS(irti) {
        var modulePath = "/default.aspx?tabid=1147&mid=3561&ctl=ReplyToInquiryShenasname&RepId=" + irti + "&popUp=true";
        dnnModal.show(modulePath, true, 550, 960, false, '');
    }

    function JoziyateEstelamS(link) {
        var modulePath = link;
        dnnModal.show(modulePath, true, 550, 960, false, '');
    }

    function BaPishnahadMovafeghamS(irti, iId) {
        var sf = $.ServicesFramework(<%= ModuleId %>);
        var inqId = iId;
        var irtiId = irti;
        $(".ajax-load").fadeIn(100);
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/BaPishnahadMovafegamPasEmalKon",
            data: { "irti": irtiId },
            <%--            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/MyinquirysReplyList",--%>
            <%--            data: { "inquiryID": inqId },--%>
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {

            bindMyInquiryReplyListStep1S(inqId);
            $(".ajax-load").fadeOut(200);

        }).fail(function(xhr, status, error) {
            $(".ajax-load").fadeOut(200);
            //alert(error);
        });
    }

    function replyDetaildS(id) {
        var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=ReplyToInquiryShenasname&popUp=true&RepId=", this.TabId, this.ModuleId) %>' + id;
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }

    <%--    function SherkatDarNazarSanji(id) {--%>
    <%--        var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=NazarSanji_SahebBeKhadamat&popUp=true&inquiryReplyToInquiry_Id=", this.TabId, this.ModuleId) %>' + id;--%>
    <%--        dnnModal.show(modulePath, true, 550, 960, true, '');--%>
    <%--    }--%>
    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>
<%--<script type="text/javascript">--%>
<%--    function processTokens() {--%>
<%--        $(".test123").each(function () {--%>
<%--            var val = $(this).html();--%>
<%--            if (parseInt(val) > 0)--%>
<%--                $(this).css("color", "green");--%>
<%--            if (parseInt(val) < 0)--%>
<%--                $(this).css("color", "gray");--%>
<%--        });--%>
<%--    }--%>
<%--    --%>
<%----%>
<%----%>
<%--    function voorood(parameters) {var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';dnnModal.show(modulePath, true, 550, 960, true, '');}</script>--%>