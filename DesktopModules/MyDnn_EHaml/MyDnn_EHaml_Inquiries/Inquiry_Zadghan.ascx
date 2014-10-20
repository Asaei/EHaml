<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Inquiry_Zadghan.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.MyDnn_EHaml_Inquiry_Zadghan.Inquiry_Zadghan" %>

<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Import Namespace="DotNetNuke.Common.Utilities" %>
<%@ Import Namespace="DotNetNuke.Entities.Portals" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2013.2.611.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>

<script type="text/javascript">
    
    function onItemChecked(sender, args) {
        var checked = args.get_item().get_checked();
        if (checked) {
            if (args.get_item().get_text().toLowerCase().indexOf("imdg") != -1) {
                rfvSubject = document.getElementById('<%= RequiredFieldValidatorkhatarnak.ClientID %>');
                rfvSubject.validationGroup = "FormValidation";
                ValidatorEnable(rfvSubject, true);
                $(".panelekalayekhatarnak").fadeIn(200);
            }
        } else {
            if (args.get_item().get_text().toLowerCase().indexOf("imdg") != -1) {
                rfvSubject = document.getElementById('<%= RequiredFieldValidatorkhatarnak.ClientID %>');
                rfvSubject.validationGroup = "someGroup";
                ValidatorEnable(rfvSubject, false);
                $(".panelekalayekhatarnak").fadeOut(200);
            }
        }
    }
    
    function onClientSelectedChanged(sender, e) {
        var selectedItem = e.get_item();
        var selectedItemText = selectedItem != null ? selectedItem.get_text() : sender.get_text();
        var selectedItemValue = selectedItem != null ? selectedItem.get_value() : sender.get_value();
    }

    function bimeCheckBoxChanged() {
        var checked = $(".bimecheckbox input").is(":checked");
        //var rfvSubject;
        if (checked) {
            rfvSubject = document.getElementById('<%= RequiredFieldValidator99.ClientID %>');
            rfvSubject.validationGroup = "FormValidation";
            ValidatorEnable(rfvSubject, true);
            $(".paneleVooroodeArzesheBar").fadeIn(200);

        } else {
            rfvSubject = document.getElementById('<%= RequiredFieldValidator99.ClientID %>');
            rfvSubject.validationGroup = "someGroup";
            ValidatorEnable(rfvSubject, false);
            $(".paneleVooroodeArzesheBar").fadeOut(200);

        }
    }

    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }

    function MackeThisUserOK(userId, userStatus, userType, returnUrl) {


        if (userStatus === "SubscribeNist") {
            var subscriptionTabId = "<%= PortalController.GetPortalSettingAsInteger("SubscriptionTabId", PortalId, -1) %>";
            var modulePath = '<%= "/default.aspx?tabid=" %>' + subscriptionTabId + "&type=" + userType;
            dnnModal.show(modulePath, true, 550, 960, true, '');
        }
    }

    function IsThisUserOK() {
        var sf = $.ServicesFramework(<%= ModuleId %>);
        var value = "<%= this.UserId %>";
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/IsThisUserOk",
            data: { "UserId": value, "UserCurrentType": 1 },
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            if (result != "OK") {
                MackeThisUserOK(value, result, 1, "default.aspx");
                return false;
            } else {
                return true;
            }
        }).fail(function(xhr, status, error) {
            alert(error);
        });
    };

    function FillShahrList() {
        var sf = $.ServicesFramework(<%= ModuleId %>);

        var combobox = $find("<%= cbolStartingPointOstan.ClientID %>");
        var value = combobox.get_value();

        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/GetShahrList",
            data: { "ostanName": value },
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            bindCbolShahr(result);
        }).fail(function(xhr, status, error) {
            alert(error);
        });
    }

    function FillShahrListMagsad() {
        var sf = $.ServicesFramework(<%= ModuleId %>);

        var combobox = $find("<%= cbolDestinationOstan.ClientID %>");
        var value = combobox.get_value();

        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/GetShahrList",
            data: { "ostanName": value },
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            bindCbolShahrMagsad(result);
        }).fail(function(xhr, status, error) {
            alert(error);
        });
    }

    function bindCbolShahr(shahrList) {
        var combo = $find("<%= cbolStartingPointShahr.ClientID %>");
        combo.clearItems();
        for (var i = 0; i < shahrList.length; i++) {
            var comboItem = new Telerik.Web.UI.RadComboBoxItem();
            comboItem.set_text(shahrList[i].Shahr);
            comboItem.set_value(shahrList[i].Shahr);

            combo.get_items().add(comboItem);
            comboItem.select();
            combo.commitChanges();
        }
    }

    function bindCbolShahrMagsad(shahrList) {
        var combo = $find("<%= cbolDestinationShahr.ClientID %>");
        combo.clearItems();
        for (var i = 0; i < shahrList.length; i++) {
            var comboItem = new Telerik.Web.UI.RadComboBoxItem();
            comboItem.set_text(shahrList[i].Shahr);
            comboItem.set_value(shahrList[i].Shahr);

            combo.get_items().add(comboItem);
            comboItem.select();
            combo.commitChanges();
        }
    }

    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>

<asp:Panel runat="server" ID="pnlErrorMessageGeneral" CssClass="pnlErrorMessageGeneral" Visible="False">
    <div ID="lblErrorMessageGeneral" CssClass="pnlErrorMessageGeneral" runat="server">
        
    </div>
</asp:Panel>

<asp:Panel runat="server" ID="pnlMustSelectDangerLoadType" CssClass="pnlMustSelectDangerLoadType" Visible="False">
    <p>
        کاربر گرامی شما نوع کالای خود را خطرناک معرفی نموده اید. لذا مشخص نمودن نوع خطرناکی کالای مذبور الزامیست.<br/>
        لطفا فرم استعلام را دوباره با دقت بیشتر تکمیل نمایید.
    </p>
</asp:Panel>
<asp:Panel runat="server" ID="pnlMessageForNotSubscribeAvaziKUser" Visible="False">
    <div class="MessageForNotSubscribeUser">
        <p>
            کاربر گرامی برای ارسال فرم باید به عنوان خدمت گزار ثیت نام نمایید.در غیر این صورت قادر به ارسال فرم نخواهید بود.
        </p>
        <asp:LinkButton runat="server" ID="lnkExitSubscribeAvaziKUser" Text=""></asp:LinkButton>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="pnlMessageForNotSubscribeAvaziSUser" Visible="False">
    <div class="MessageForNotSubscribeUser">
        <p>
            کاربر گرامی برای ارسال فرم باید طرح عضویت به عنوان صاحب بار را خریداری نمایید. در غیر این صورت قادر به ارسال فرم نخواهید بود.
        </p>
        <asp:LinkButton runat="server" ID="lnkTasviyeS" Text="خرید طرح عضویت"></asp:LinkButton>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="pnlMessageForNotSubscribeUser" Visible="False">
    <div class="MessageForNotSubscribeUser">
        <p>
            کاربر گرامی برای ارسال فرم باید طرح عضویت را خریداری نمایید.در غیر این صورت قادر به ارسال فرم نخواهید بود.
        </p>
        <asp:LinkButton runat="server" ID="lnkTasviye" Text="خرید طرح عضویت"></asp:LinkButton>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="pnlMessageForBedehkarUser" Visible="False">
    <div class="MessageForBedehkarUser">
        <p>
            کاربر گرامی مهلت فعالیت شما در حالت بدهکاری پایان یافته ، برای ارسال فرم می بایست تسویه نمایید.
        </p>
        <a href="/default.aspx?tabid=<%= PortalController.GetPortalSettingAsInteger("TasviyeTabId", PortalId, -1) %>&type=1&FinalReturnTabId=<%= TabId %>">تسویه حساب</a>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="pnlMessageForLoginNakarde" Visible="False">
    <div class="MessageForLoginNakarde">
        <p>
            کاربر گرامی شما در سایت لوگین نکرده اید. لطفآ ابتدا در سایت لوگین کنید.
        </p>
        <a class="RegisterClass dnnPrimaryAction" href="/ثبت-نام">ثبت نام</a>
        <a class="LoginClass dnnSecondaryAction" onclick=" voorood(); ">ورود</a>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="pnlMessageForNotApprovedAfterErsal" Visible="False"><div class="MessageAfterErsal"><p>لینک فعال سازی حساب کاربری شما به ایمیل تان ارسال گردید. لطفآ ایمیل خود را بررسی نمایید.</p></div></asp:Panel><asp:Panel runat="server" ID="pnlMessageForNotApproved" Visible="False">
                                                                                                                                                                                                                                      <div class="MessageForNotApproved">
                                                                                                                                                                                                                                          <p>
                                                                                                                                                                                                                                              کاربر گرامی شما هنور عضویت خود را تایید ننمود ه اید. برای این کار لطفآ بر روی لینک ارسالی در ایمل خود کلیک نمایید.
                                                                                                                                                                                                                                          </p>
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid1" Text="ارسال مجدد لینک تایید" />
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>

<div class="InquiryZadghan-Form dnnForm">
    <%--    <div class="dnnFormItem form-title">--%>
    <%--        <dnn:label id="lblInquiryZadghanTitle" runat="server"></dnn:label>--%>
    <%--    </div>--%>
    <div class="dnnFormItem">
        <dnn:label id="lblIsReallyNeed" cssclass="dnnFormRequired" runat="server"></dnn:label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolIsReallyNeed" cssclass="dnnFixedSizeComboBox" />
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator2" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolIsReallyNeed" resourcekey="ErrorMessage" />
        <%--<asp:CompareValidator runat="server" ID="cvCbolIsReallyNeed" ValidationGroup="FormValidation"
                              CssClass="dnnFormMessage dnnFormError" Type="String" Operator="NotEqual" ControlToValidate="cbolIsReallyNeed"
                              ValueToCompare="-- انتخاب نماييد --" resourcekey="ErrorMessage" Display="Dynamic"></asp:CompareValidator>--%>
    </div>
    <%--    <asp:Repeater ID="rptNoeVaTedadeVasileyeHaml" runat="server">
        <ItemTemplate>
            <div class="dnnFormItem">
                <dnn:Label ID="lblVasileyeHamlName" Text='<%# LocalizeString(Eval("VasileyeHamlName").ToString()) %>' runat="server" ></dnn:Label>
                <asp:TextBox ID="txtTedadeVasileyeHaml" runat="server" ToolTip='<%# LocalizeString(Eval("VasileyeHamlName").ToString()) %>'></asp:TextBox>
            </div>
        </ItemTemplate>
    </asp:Repeater>--%>

    <div class="dnnFormItem">
        <dnn:label cssclass="dnnFormRequired" id="lblNoeVasileyeHaml" runat="server"></dnn:label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolNoeVasileyeHaml" checkboxes="True" cssclass="dnnFixedSizeComboBox">

            <ItemTemplate>
                <asp:Label ID="lblVasileName" runat="server" Text='<%# DataBinder.Eval(Container, "Text") %>' />
                <%--                <dnn:Label runat="server" ID="lblTedadeVasileyeHaml" Text="تعداد:"/>--%>
                <asp:TextBox ID="txtTedadeVasile" runat="server" />
            </ItemTemplate>
            <Items>
                <dnn:DnnComboBoxItem runat="server" Text='<%# Eval("VasileyeHamlName") %>' />
            </Items>
        </dnn:dnncombobox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator1" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolNoeVasileyeHaml" resourcekey="ErrorMessage" />
    </div>

    <div class="dnnFormItem">
        <dnn:label runat="server" cssclass="dnnFormRequired" id="lblLoadType"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" onclientitemchecked=" onItemChecked " runat="server" id="cbolLoadType" checkboxes="True" cssclass="dnnFixedSizeComboBox" />
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator3" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolLoadType" resourcekey="ErrorMessage" />
    </div>
    <div id="panelekalayekhatarnak" runat="server" class="dnnFormItem  panelekalayekhatarnak" style="display: none">
        <dnn:label cssclass="dnnFormRequired" runat="server" id="lblListeKalahayeKhatarnak" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolDangerLoadCodes" checkboxes="True" cssclass="dnnFixedSizeComboBox" />
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidatorkhatarnak" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolDangerLoadCodes" resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem">
        <dnn:label runat="server" id="Label1" text="احتساب بیمه مسئولیت" helptext="احتساب بیمه مسئولیت" />
        <asp:CheckBox CssClass="bimecheckbox" onclick="bimeCheckBoxChanged();" runat="server" resourcekey="chkWithInsurance" ID="chkWithInsurance" />
    </div>

    <div id="paneleVooroodeArzesheBar" runat="server" class="dnnFormItem paneleVooroodeArzesheBar" style="margin-bottom: 20px;">
        <dnn:label cssclass="dnnFormRequired" runat="server" id="Label2" text="فرم ورود ارزش محموله" helptext="فرم ورود ارزش محموله" />
        <asp:FileUpload ID="fupFormeVooroodeArzeshBarAsaseVasileyeHamlFull" runat="server" resourcekey="fupFormeVooroodeArzeshBarAsaseVasileyeHamlFull" />
        <asp:HyperLink NavigateUrl="/Portals/0/EHaml/Templates/V_A_B_A_V_H.xlsx" runat="server"
                       resourcekey="hplFormeVooroodeArzeshBarAsaseVasileyeHaml" ID="hplFormeVooroodeArzeshBarAsaseVasileyeHaml" Style="font-size: 12px; position: relative; top: 5px; color: #7d9ccc"></asp:HyperLink>
                <asp:RequiredFieldValidator Enabled="False" EnableClientScript="True" ValidationGroup="FormValidation" ID="RequiredFieldValidator99" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolStartingPointOstan" resourcekey="ErrorMessage" />
        
    </div>
    <div class="dnnFormItem">
        <dnn:label runat="server" id="lblStartingPointOstan" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolStartingPointOstan" onclientselectedindexchanged=" FillShahrList " cssclass="dnnFixedSizeComboBox"></dnn:dnncombobox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator5" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolStartingPointOstan" resourcekey="ErrorMessage" />

    </div>
    <div class="dnnFormItem">
        <dnn:label cssclass="dnnFormRequired" runat="server" id="lblStartingPointShahr" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolStartingPointShahr" cssclass="dnnFixedSizeComboBox"></dnn:dnncombobox>

        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator6" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolStartingPointShahr" resourcekey="ErrorMessage" />
    </div>

    <div class="dnnFormItem">
        <dnn:label cssclass="dnnFormRequired" runat="server" id="lblDestinationOstan" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolDestinationOstan" onclientselectedindexchanged=" FillShahrListMagsad " cssclass="dnnFixedSizeComboBox"></dnn:dnncombobox>

        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator7" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolDestinationOstan" resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem">
        <dnn:label cssclass="dnnFormRequired" runat="server" id="lblDestinationShahr" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolDestinationShahr" cssclass="dnnFixedSizeComboBox"></dnn:dnncombobox>

        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator8" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolDestinationShahr" resourcekey="ErrorMessage" />
    </div>

    <div class="dnnFormItem">
        <dnn:label  runat="server" id="Label3" text="با احتساب هزینه تخلیه در مقصد" helptext="با احتساب هزینه تخلیه در مقصد" />
        <asp:CheckBox resourcekey="chkEmptyingCharges" runat="server" ID="chkEmptyingCharges" />
    </div>
    <div class="dnnFormItem">

        <dnn:label cssclass="dnnFormRequired" runat="server" id="lblActionDate" />
        <dnn:dnndatepicker runat="server" id="dtpActionDate" />
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvDtpActionDate" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="dtpActionDate" resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem">
        <dnn:label cssclass="dnnFormRequired" runat="server" id="lblExpireDate" />
        <dnn:dnndatepicker runat="server" id="dtpExpireDate"></dnn:dnndatepicker>

        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvDtpExpireDate" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="dtpExpireDate" resourcekey="ErrorMessage" />

        <%-- <asp:CompareValidator runat="server" ID="cvDtpExpireDate" ValidationGroup="FormValidation"
                              CssClass="dnnFormMessage dnnFormError" Type="Date" Operator="LessThanEqual" ControlToValidate="dtpExpireDate"
                              ControlToCompare="dtpActionDate" resourcekey="ExpireDateGreaterThanActionDateErrorMessage" Display="Dynamic"></asp:CompareValidator>--%>


    </div>

    <div class="dnnFormItem" style="display: none">
        <asp:CheckBox runat="server" resourcekey="chkIsTender" ID="chkIsTender" />
    </div>

    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmit" ValidationGroup="FormValidation" runat="server"
                                CssClass="dnnPrimaryAction" resourcekey="lnkSubmit" />
            </li>
        </ul>
    </div>
    <div runat="server" class="dnnFormWarning myErrorMessage" id="errorMessages" Visible="False"></div>
</div>

<div class="messageAfterSubmit dnnFormMessage" visible="False" id="messageAfterSubmit" runat="server"></div>
<div class=""><asp:LinkButton Text="چاپ" Visible="False" ID="lnkPrintKon" runat="server" CssClass="dnnPrimaryAction" /></div>
<asp:HiddenField runat="server" ID="hiddenFieldId"/>
<asp:Label runat="server" id="Togelhachejoorihastan" Visible="False"></asp:Label>