<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KhedmatSide.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Gozaresh.KhedmatSide" %>

<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Content.Common" %>
<%@ Import Namespace="MyDnn_EHaml" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:dnncssinclude id="DnnCssInclude1" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.common.min.css" />
<dnn:dnncssinclude id="DnnCssInclude3" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.rtl.min.css" />

<script src="/DesktopModules/MyDnn_EHaml/Scripts/kendo.web.min.js">
    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>
<div class="dnnForm">
    <div id="grdKhedmatActiveListKh" class="k-rtl">
    </div>
</div>

<script type="text/javascript">

    $(document).ready(function() {
        var sf = $.ServicesFramework(<%= ModuleId %>);
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/InquiryListThatIReplyAndAcceptForGozaresh",
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            bindMyInquiryReplyListKh(result);
        }).fail(function(xhr, status, error) {
            alert(error);
        });
    });

//
//		$("#lnkSearch").click

    function bindMyInquiryReplyListKh(myInquirysReply) {
        $("#grdKhedmatActiveListKh").kendoGrid({
            dataSource: {
                data: myInquirysReply,
                pageSize: 10
            },
            height: 450,
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
                { title: "آیدی", field: "Id", width: "9px" },
                { title: "نام", field: "NameSahebBar", width: "10px" },
                { title: "بار", field: "Mohtava", width: "50px" },
                { title: "تاریخ", field: "ZamaneAmadegiBarayeShooroo", width: "10px" },
                {
                    title: "جزئیات",
                    field: "Id",
                    width: "10px",
                    template:
                        function(dataItem) {
                            return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='replyDetail(" + dataItem.Id + ")'>" +
                                "<span class=' '></span>مشاهده</a>";
                        }
                }
            ]
        });
    }

    function replyDetail(id) {
        var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=GozareshForm&popUp=true&Id=", this.TabId, this.ModuleId) %>' + id;
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }

//
//	function SherkatDarNazarSanji(id) {
//		var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=NazarSanji_SahebBeKhadamat&popUp=true&inquiryReplyToInquiry_Id=", this.TabId, this.ModuleId) %>' + id;
//		dnnModal.show(modulePath, true, 550, 960, true, '');
//	}
    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>