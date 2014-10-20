<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Inquiry_Hs.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.Inquiry_Hs" %>
<%@ Register TagPrefix="dnn" TagName="Label_1" Src="~/controls/labelcontrol.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Portals" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<script>
    function MackeThisUserOK(userId, userStatus, userType, returnUrl) {
        if (userStatus === "SubscribeNist") {
            var modulePath = '<%= string.Format("/default.aspx?tabid=1142&type=") %>' + userType;
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
            if (result !== "OK") {
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


    function onclickisbime() {
        var checked = $(".isBime input").is(":checked");
        if (checked) {
            rfvSubject = document.getElementById('<%= RequiredFieldValidator99.ClientID %>');
            rfvSubject.validationGroup = "FormValidation";
            ValidatorEnable(rfvSubject, true);
            $(".arzeshekala").fadeIn(500);
        } else {
            rfvSubject = document.getElementById('<%= RequiredFieldValidator99.ClientID %>');
            rfvSubject.validationGroup = "someGroup";
            ValidatorEnable(rfvSubject, false);
            $(".arzeshekala").fadeOut()(500);
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
            کاربر گرامی برای ارسال فرم باید طرح عضویت را خریداری نمایید. در غیر این صورت قادر به ارسال فرم نخواهید بود.
        </p>
        <asp:LinkButton runat="server" ID="lnkTasviye" Text="خرید طرح عضویت"></asp:LinkButton>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="pnlMessageForBedehkarUser" Visible="False">
    <div class="MessageForBedehkarUser">
        <p>
            کاربر گرامی مهلت فعالیت شما در حالت بدهکاری پایان یافته ، برای ارسال فرم می بایست تسویه نمایید.
        </p>
        <a href="/default.aspx?tabid=<%= PortalController.GetPortalSettingAsInteger("TasviyeTabId", PortalId, -1) %>&type=1&FinalReturnTabId=<%= this.TabId %>">تسویه حساب</a>
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
<div class="InquiryDn-Form dnnForm hsForm">
    <div class="dnnFormItem">
        <dnn:label id="lblInquiryDnTitle" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:label helptext=" " id="lblDarkhastKonande" runat="server"></dnn:label>
        <dnn:label helptext=" " id="lblDarkhastKonandeValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblIsReallyNeed" cssclass="dnnFormRequired" runat="server"></dnn:label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolIsReallyNeed" />
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator1" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolIsReallyNeed" resourcekey="ErrorMessage" />
    </div>

    <div class="InquiryDl-Form-ListeAdlBandi dnnFormItem" style="margin-bottom: 20px">
        <dnn:label runat="server" cssclass="dnnFormRequired" helptext=" " text="فرم لیست عدل بندی:"></dnn:label>
        <asp:HyperLink CssClass="textAfterTheButton" Text="دریافت فرم لیست عدل بندی" NavigateUrl="/Portals/0/EHaml/Templates/V_P_L.xlsx" runat="server"
                       resourcekey="hplFormeListeAdlBandi" ID="hplFormeListeAdlBandi"></asp:HyperLink>


        <asp:FileUpload ID="fupFormeListeAdlBandiFull" runat="server" resourcekey="fupFormeListeAdlBandiFull" />

        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvFupFormeListeAdlBandiFull"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="fupFormeListeAdlBandiFull"
                                    resourcekey="ErrorMessage" />

        <%--        <asp:RegularExpressionValidator ValidationGroup="FormValidation" ID="revFupFormeListeAdlBandiFull" runat="server"--%>
        <%--            ErrorMessage="فقط فایل با پسوند xlsx مجاز می باشد!"--%>
        <%--            ControlToValidate="fupFormeListeAdlBandiFull"--%>
        <%--            ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.(xlsx|XLSX)$"--%>
        <%--            CssClass="dnnFormMessage dnnFormError"></asp:RegularExpressionValidator>--%>

    </div>
    <div class="InquiryDghco-Form-ListeAdlBandi dnnFormItem" style="margin-bottom: 20px">

        <dnn:label helptext=" " runat="server" id="lblLoadImage1" text="لطفآ یک عکس از محموله را بارگذاری نمایید."></dnn:label>

        <asp:FileUpload CssClass="textAfterTheButton" ID="fupLoadImage" runat="server" resourcekey="fupFormeListeAdlBandiFull" />

        <%--        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator2"--%>
        <%--            CssClass="dnnFormMessage dnnFormError"--%>
        <%--            runat="server" Display="Dynamic" ControlToValidate="fupLoadImage"--%>
        <%--            resourcekey="ErrorMessage" />--%>

        <%--        <asp:RegularExpressionValidator ValidationGroup="FormValidation" ID="RegularExpressionValidator2" runat="server"--%>
        <%--            ErrorMessage="فقط فایل با پسوندهای png,gif,jpg,bmp مجاز می باشد!"--%>
        <%--            ControlToValidate="fupLoadImage"--%>
        <%--            ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.(png|jpg|bmp|gif)$"--%>
        <%--            CssClass="dnnFormMessage dnnFormError"></asp:RegularExpressionValidator>--%>

    </div>

    <div class="dnnFormItem">
        <dnn:label helptext=" " cssclass="dnnFormRequired" text="استان dsfdsfsمبدا:" runat="server" id="lblStartingPointOstan" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolStartingPointOstan" onclientselectedindexchanged=" FillShahrList "></dnn:dnncombobox>

                <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator2"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolStartingPointOstan"
                                    resourcekey="ErrorMessage" />

    </div>
    <div class="dnnFormItem">
        <dnn:label cssclass="dnnFormRequired" helptext=" " text="شهر مبدا:" runat="server" id="lblStartingPointShahr" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolStartingPointShahr"></dnn:dnncombobox>

                <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator3"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolStartingPointShahr"
                                    resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem">
        <dnn:label runat="server" text=":با احتساب هزینه بارگیری در مبداء" helptext=" "></dnn:label>
        <asp:CheckBox Text="با احتساب هزینه بارگیری در مبداء" runat="server" ID="chkIsBargiriDarMabda" />
    </div>

    <div class="dnnFormItem">
        <dnn:label helptext=" " cssclass="dnnFormRequired" text="استان مقصد:" runat="server" id="lblDestinationOstan" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolDestinationOstan" onclientselectedindexchanged=" FillShahrListMagsad "></dnn:dnncombobox>

                <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator4"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolDestinationOstan"
                                    resourcekey="ErrorMessage" />

    </div>
    <div class="dnnFormItem">
        <dnn:label cssclass="dnnFormRequired" helptext=" " text="شهر مقصد:" runat="server" id="lblDestinationShahr" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolDestinationShahr"></dnn:dnncombobox>

                <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator5"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolDestinationShahr"
                                    resourcekey="ErrorMessage" />

    </div>
    <div class="dnnFormItem">
        <dnn:label runat="server" text=":با احتساب هزینه تخلیه در مقصد" helptext=" "></dnn:label>
        <asp:CheckBox Text="با احتساب هزینه تخلیه در مقصد" runat="server" ID="chkIsTakhliyeDarMagsad" />
    </div>

    <div class="dnnFormItem">
        <dnn:label runat="server" text=":با احتساب بیمه مسئولیت در طول مسیر" helptext=" "></dnn:label>
        <asp:CheckBox CssClass="isBime" runat="server" onclick="onclickisbime();" Text="با احتساب بیمه مسئولیت در طول مسیر" ID="chkIsBaEhtesabeBimeDarTooleMasir" />
    </div>
    <div class="Inquiry_ChandVajhiSabok-Form-ListeAdlBandi arzeshekala dnnFormItem" style="margin-bottom: 20px; display: none">
        <dnn:label cssclass="dnnFormRequired" runat="server" helptext=" " text="دریافت فرم ورود ارزش بر اساس لیست عدل بندی:"></dnn:label>
        <asp:HyperLink CssClass="textAfterTheButton" Text="دریافت فرم ورود ارزش بر اساس لیست عدل بندی" NavigateUrl="/Portals/0/EHaml/Templates/V_A_B_A_L_A.xlsx" runat="server"
                       resourcekey="hplFormeListeAdlBandi" ID="HyperLink1"></asp:HyperLink>


        <asp:FileUpload ID="fupFormeArzeshBarAsaseListeAdlBandiFull" runat="server" resourcekey="fupFormeArzeshBarAsaseListeAdlBandiFull" />

        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator99"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="fupFormeArzeshBarAsaseListeAdlBandiFull"
                                    resourcekey="ErrorMessage" />
        <%----%>
        <%--        <asp:RegularExpressionValidator ValidationGroup="FormValidation" ID="RegularExpressionValidator1" runat="server" --%>
        <%--                                        ErrorMessage="فقط فایل با پسوند xlsx مجاز می باشد!"--%>
        <%--                                        ControlToValidate="fupFormeArzeshBarAsaseListeAdlBandiFull"--%>
        <%--                                        ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.(xlsx|XLSX)$"--%>
        <%--                                        CssClass="dnnFormMessage dnnFormError"></asp:RegularExpressionValidator>--%>
    </div>
    <div class="dnnFormItem">
            <dnn:label helptext=" " cssclass="dnnFormRequired" runat="server" id="lblActionDate" text="تاریخ شروع عملیات:" />
            <dnn:dnndatepicker runat="server" id="dtpActionDate" />
            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvDtpActionDate" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="dtpActionDate" resourcekey="ErrorMessage" />
        </div>
    <div class="dnnFormItem">
            <dnn:label helptext=" " cssclass="dnnFormRequired" runat="server" id="lblExpireDate" text="تاریخ انقضا استعلام:" />
            <dnn:dnndatepicker runat="server" id="dtpExpiredate"></dnn:dnndatepicker>

            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvDtpExpiredate" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="DtpExpiredate" resourcekey="ErrorMessage" />

            <asp:CompareValidator runat="server" ID="cvDtpExpiredate" ValidationGroup="FormValidation"
                                  CssClass="dnnFormMessage dnnFormError" Type="Date" Operator="LessThanEqual" ControlToValidate="dtpExpiredate"
                                  ControlToCompare="dtpActionDate" resourcekey="ExpireDateGreaterThanActionDateErrorMessage" Display="Dynamic"></asp:CompareValidator>

        </div>

    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton Text="ارسال فرم" ID="lnkSubmit" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" resourcekey="lnkSubmit" />
            </li>
        </ul>
    </div>
        <div runat="server" class="dnnFormWarning myErrorMessage" id="errorMessages" Visible="False"></div>
</div>

<div class="messageAfterSubmit dnnFormMessage" visible="False" id="messageAfterSubmit" runat="server"></div>
<div class=""><asp:LinkButton Text="چاپ" Visible="False" ID="lnkPrintKon" runat="server" CssClass="dnnPrimaryAction" /></div>
<asp:HiddenField runat="server" ID="hiddenFieldId"/>