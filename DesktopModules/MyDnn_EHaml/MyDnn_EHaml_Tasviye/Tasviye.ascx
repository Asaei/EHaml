<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Tasviye.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Tasviye.Tasviye" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:DnnCssInclude ID="DnnCssInclude1" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.common.min.css" />
<dnn:DnnCssInclude ID="DnnCssInclude2" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.default.min.css" />
<dnn:DnnCssInclude ID="DnnCssInclude3" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.rtl.min.css" />

<script src="/DesktopModules/MyDnn_EHaml/Scripts/kendo.web.min.js" ></script>

<script type="text/javascript">

    $(document).ready(function() {

        var sf = $.ServicesFramework(<%= ModuleId %>);

        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/GetInquiryListThatIReplyForBedehkari",
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            bindInquiryList(result);
        }).fail(function(xhr, status, error) {
            alert(error);
        });


        function bindInquiryList(inquiryList) {
            $("#grdAmaliyatiKeBaeseBedehkariShodan").kendoGrid({
                dataSource: {
                    data: inquiryList,
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
                    { title: "آیدی موقت", field: "IRTI", width: "10px" },
                    { title: "آیدی", field: "Id", width: "9px" },
                    { title: "وضعیت", field: "StatusPR", width: "15px" },
                    { title: "نام", field: "DisplayName", width: "20px" },
                    { title: "شرکت", field: "Company", width: "20px" },
                    { title: "نوع", field: "InquiryType", width: "16px" },
                    { title: "انقضا", field: "ExpireDate", width: "18px" },
                    { title: "مبدا", field: "StartingPoint", width: "20px" },
                    { title: "مقصد", field: "Destination", width: "25px" },
                    { title: "زمان انجام", field: "ActionDate", width: "18px" },
                    //{
                    //    title: "وضعیت",
                    //    field: "Status",
                    //    width: "19px",
                    //    template:
                    //        function (dataItem) {
                    //            if (dataItem.Status == "پذیرفته شد") {
                    //                return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='ShowUserInfo(" + dataItem.Id + ")'><span class=' '></span>پذیرفته شد</a>";
                    //            } else {
                    //                return dataItem.Status;
                    //            }
                    //        }
                    //},
                    {
                        title: "عملیات",
                        field: "Eteraz",
                        width: "20px",
                        template:
                            function(dataItem) {
                                return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='Eteraz(" + dataItem.IRTI + ")'><span class=' '></span>اعتراض دارم</a>";
                            }
                    }
                ]
            });
        }
    });

    function Eteraz(id) {
        var sf = $.ServicesFramework(<%= ModuleId %>);
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/EterazRaEmalKon",
            data: { "id": id },
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            bindInquiryList2(result);

        }).fail(function(xhr, status, error) {
            alert(error);
        });
    }

    function bindInquiryList2(inquiryList) {
        $("#grdAmaliyatiKeBaeseBedehkariShodan").kendoGrid({
            dataSource: {
                data: inquiryList,
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
                { title: "آیدی موقت", field: "IRTI", width: "10px" },
                { title: "آیدی", field: "Id", width: "9px" },
                { title: "وضعیت", field: "StatusPR", width: "15px" },
                { title: "نام", field: "DisplayName", width: "20px" },
                { title: "شرکت", field: "Company", width: "20px" },
                { title: "نوع", field: "InquiryType", width: "16px" },
                { title: "انقضا", field: "ExpireDate", width: "18px" },
                { title: "مبدا", field: "StartingPoint", width: "20px" },
                { title: "مقصد", field: "Destination", width: "25px" },
                { title: "زمان انجام", field: "ActionDate", width: "18px" },
                //{
                //    title: "وضعیت",
                //    field: "Status",
                //    width: "19px",
                //    template:
                //        function (dataItem) {
                //            if (dataItem.Status == "پذیرفته شد") {
                //                return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='ShowUserInfo(" + dataItem.Id + ")'><span class=' '></span>پذیرفته شد</a>";
                //            } else {
                //                return dataItem.Status;
                //            }
                //        }
                //},
                {
                    title: "عملیات",
                    field: "Eteraz",
                    width: "20px",
                    template:
                        function(dataItem) {
                            return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='Eteraz(" + dataItem.IRTI + ")'><span class=' '></span>اعتراض دارم</a>";
                        }
                }
            ]
        });
    };

    function replyToInquiry(id) {
        window.location = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl={2}&InqId=", this.TabId, this.ModuleId, Settings["NameControlForReply"]) %>' + id;
    }

    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>


<div class="Register-Form dnnForm">
    <asp:Panel runat="server" ID="pnlmessageforTasviye" Visible="False">
        <asp:Label runat="server" ID="lblMessageForTasviye"></asp:Label>
        <div class="dnnFormItem">
            <ul class="dnnActions dnnClear">
                <li>
                    <asp:LinkButton ID="lnkBack" ValidationGroup="FormValidation" Text="بازگشت" runat="server" CssClass="dnnPrimaryAction"  resourcekey="lnkSub" />
                </li>
            </ul>
        </div>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlregularTasviye">
        <div class="dnnFormItem">
            <dnn:label Text="نام:" id="lblFirstNamea" runat="server" ></dnn:label>
            <dnn:label  id="lblFirstName" runat="server" ></dnn:label>
        </div>
        <div class="dnnFormItem">
            <dnn:label Text="نام خانوادگی:" id="lblLastNamea" runat="server" ></dnn:label>
            <dnn:label  id="lblLastName" runat="server" ></dnn:label>
        </div>
        <div class="dnnFormItem">
            <dnn:label Text="Email:" id="lblEmaila" runat="server" ></dnn:label>
            <dnn:label  id="lblEmail" runat="server" ></dnn:label>
        </div>
    
        <div class="dnnFormItem">
            <div id="grdAmaliyatiKeBaeseBedehkariShodan" class="k-rtl"></div>
        </div>

        <%--    <div class="dnnFormItem">
        <dnn:label Text="طرح عضویت:" id="lblHagigiYaHoogoogiTypea" runat="server"></dnn:label>
        <dnn:label  id="lblHagigiYaHoogoogiType" runat="server" ></dnn:label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolPlanNameType" />
        <%--        <asp:CompareValidator ValidationGroup="FormValidation" ID="cvCbolPlanName" CssClass="dnnFormMessage dnnFormError"
                              runat="server" Operator="NotEqual" Type="String" Display="Dynamic" ValueToCompare="-- انتخاب نماييد --"
                              ControlToValidate="cbolHagigiYaHoogoogiType" resourcekey="ErrorMessage" />--%>
        <%--</div>--%>
    

        <div class="dnnFormItem">
            <dnn:label Text="مبلغ پرداخت:" id="lblMablaghePardakht" runat="server" ></dnn:label>
            <dnn:label  id="lblMablaghePardakhtValue" runat="server" ></dnn:label>
        </div>

        <div class="dnnFormItem" style="display: none">
            <dnn:label Text="نحوه پرداخت:" id="lblNahveyePardakht" runat="server"></dnn:label>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolNahveyePardakht" />
            <%--        <asp:CompareValidator ValidationGroup="FormValidation" ID="cvCbolPlanName" CssClass="dnnFormMessage dnnFormError"
                              runat="server" Operator="NotEqual" Type="String" Display="Dynamic" ValueToCompare="-- انتخاب نماييد --"
                              ControlToValidate="cbolHagigiYaHoogoogiType" resourcekey="ErrorMessage" />--%>
        </div>
        <div class="dnnFormItem">
            <ul class="dnnActions dnnClear">
                <li>
                    <asp:LinkButton ID="lnkSub" ValidationGroup="FormValidation" Text="پرداخت" runat="server" CssClass="dnnPrimaryAction"  resourcekey="lnkSub" />
                </li>
                <li>
                    <asp:LinkButton ID="lnkEteraz" ValidationGroup="FormValidation" Text="اعتراض دارم" runat="server" CssClass="dnnPrimaryAction"  resourcekey="lnkSub" />
                </li>
            </ul>
        </div>
    </asp:Panel>
</div>