<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SahebSide.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Gozaresh.SahebSide" %>

<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:DnnCssInclude ID="DnnCssInclude1" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.common.min.css" />
<dnn:DnnCssInclude ID="DnnCssInclude2" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.default.min.css" />
<dnn:DnnCssInclude ID="DnnCssInclude3" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.rtl.min.css" />
<dnn:DnnJsInclude ID="DnnJsInclude1" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Scripts/kendo.web.min.js" />

<div class="LordDashboard-Form dnnForm">
    <div class="dnnFormItem">
        <dnn:Label ID="lblActiveInquiry"Text="استعلام ها"></dnn:Label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" Font-Names="Tahoma" Font-Size="9" CssClass="dnnFixedSizeComboBox" ID="cbolActiveInquiry"/>
        <a Class="dnnPrimaryAction" style="font-family: bkoodak; font-size: 15px; padding: 1px 6px !important" ID="lnkSearch">جستجو</a>
    </div>
    <div class="dnnFormItem">
        <div id="grdMy" class="k-rtl">
        
        </div>
    </div>
</div>

<script type="text/javascript">

    $(document).ready(function() {

        function bindMyInquiryReplyList(myInquirysReply) {
            $("#grdMy").kendoGrid({
                dataSource: {
                    data: myInquirysReply,
                    pageSize: 10
                },
                height: 450,
                groupable: true,
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
                    { title: "آیدی", field: "Id", width: "9px" },
                    { title: "نام", field: "Name", width: "20px" },
                    { title: "متن گزارش", field: "Matn", width: "20px" },
                    { title: "تاریخ", field: "Tarikh", width: "16px" },
                    {
                        title: "جزئیات",
                        field: "Id",
                        width: "19px",
                        template:
                            function(dataItem) {
                                return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='replyDetail(" + dataItem.Id + ")'><span class=' '></span>مشاهده</a>";
                            }
                    }
                ]
            });
        }

        $("#lnkSearch").click(function() {
            var sf = $.ServicesFramework(<%= ModuleId %>);
            var combobox = $find('<%= cbolActiveInquiry.ClientID %>');
            var value = combobox.get_value();

            $.ajax({
                type: "GET",
                url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/MyinquirysReplyListThatIApproveGozaresh",
                data: { "IRTI_Id": value },
                beforeSend: sf.setModuleHeaders
            }).done(function(result) {
                bindMyInquiryReplyList(result);
            }).fail(function(xhr, status, error) {
                alert(error);
            });
        });
    });

    function replyDetail(id) {
        var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=GozareshFormView&popUp=true&Id=", this.TabId, this.ModuleId) %>' + id;
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }

//
//    function SherkatDarNazarSanji(id) {
//        var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=NazarSanji_SahebBeKhadamat&popUp=true&inquiryReplyToInquiry_Id=", this.TabId, this.ModuleId) %>' + id;
//        dnnModal.show(modulePath, true, 550, 960, true, '');
//    }
    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>