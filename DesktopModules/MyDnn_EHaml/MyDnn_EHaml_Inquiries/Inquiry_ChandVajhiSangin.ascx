<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Inquiry_ChandVajhiSangin.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.Inquiry_ChandVajhiSangin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Portals" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
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
        کاربر گرامی شما نوع کالای خود را خطرناک معرفی نموده اید. لذا مشخص نمودن نوع خطرناکی کالای مذبور الزامیست.
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
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid1" Text="ارسال مجدد لینک تایید"/>
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<div class="Inquiry_ChandVajhiSangin-Form dnnForm">
    <div class="dnnFormItem">
        <dnn:label id="lblInquiry_ChandVajhiSanginTitle" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:label id="lblDarkhastKonande" runat="server"></dnn:label>
        <dnn:label id="lblDarkhastKonandeValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:label id="lblIsReallyNeed" cssclass="dnnFormRequired" runat="server"></dnn:label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolIsReallyNeed" />
        <asp:CompareValidator runat="server" ID="cvCbolIsReallyNeed" ValidationGroup="FormValidation"
                              CssClass="dnnFormMessage dnnFormError" Type="String" Operator="NotEqual" ControlToValidate="cbolIsReallyNeed"
                              ValueToCompare="-- انتخاب نمایید --" resourcekey="ErrorMessage" Display="Dynamic"></asp:CompareValidator>
    </div>
    <div class="Inquiry_ChandVajhiSangin-Form-ListeAdlBandi dnnFormItem">

        <asp:HyperLink Text="دریافت فرم لیست عدل بندی" NavigateUrl="/Portals/0/EHaml/Templates/V_P_L.xlsx" runat="server" 
                       resourcekey="hplFormeListeAdlBandi" ID="hplFormeListeAdlBandi"></asp:HyperLink>


        <asp:FileUpload ID="fupFormeListeAdlBandiFull" runat="server" resourcekey="fupFormeListeAdlBandiFull" />

        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvFupFormeListeAdlBandiFull"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="fupFormeListeAdlBandiFull"
                                    resourcekey="ErrorMessage" />

        <asp:RegularExpressionValidator ValidationGroup="FormValidation" ID="revFupFormeListeAdlBandiFull" runat="server" 
                                        ErrorMessage="فقط فایل با پسوند xlsx مجاز می باشد!"
                                        ControlToValidate="fupFormeListeAdlBandiFull"
                                        ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.(xlsx|XLSX)$"
                                        CssClass="dnnFormMessage dnnFormError"></asp:RegularExpressionValidator>

    </div>
    <div class="dnnFormItem">
        <dnn:Label runat="server" ID="lblLoadType" CssClass="dnnFormRequired"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolLoadType" CheckBoxes="True"/>

    </div>
    <div class="dnnFormItem">
        <dnn:Label runat="server" ID="lblListeKalahayeKhatarnak"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolDangerLoadCodes" CheckBoxes="True"/>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="کد HS محموله:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtCodeHSMahmoole" runat="server"></asp:TextBox><dnn:Label Text="توصیه میشود تکمیل نمایید" runat="server" ></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="نوع بسته بندی:" runat="server" ID="lblPackingType" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolPackingType" CheckBoxes="True" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="کشور مبدا(قابل تایپ):" runat="server" ID="lblStartingPointOstan"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolStartingPointOstan"  ></dnn:DnnComboBox>

        <asp:CompareValidator runat="server" ID="cvCbolStartingPointKeshvar" ValidationGroup="FormValidation"
                              CssClass="dnnFormMessage dnnFormError" Type="String" Operator="NotEqual" ControlToValidate="cbolStartingPointOstan"
                              ValueToCompare="-- انتخاب نمایید --" resourcekey="ErrorMessage" Display="Dynamic"></asp:CompareValidator>

        <dnn:Label Text="شهر مقصد:" runat="server" ID="lblStartingPointShahr"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" Text="شهر مبدا(قابل تایپ):" runat="server" ID="cbolStartingPointShahr"></dnn:DnnComboBox>

        <asp:CompareValidator runat="server" ID="cvCbolStartingPointShahr" ValidationGroup="FormValidation"
                              CssClass="dnnFormMessage dnnFormError" Type="String" Operator="NotEqual" ControlToValidate="cbolStartingPointShahr"
                              ValueToCompare="-- انتخاب نمایید --" resourcekey="ErrorMessage" Display="Dynamic"></asp:CompareValidator>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="کشور مقصد(قابل تایپ):" runat="server" ID="lblDestinationOstan"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolDestinationOstan"  ></dnn:DnnComboBox>

        <asp:CompareValidator runat="server" ID="cvCbolDestinationKeshvar" ValidationGroup="FormValidation"
                              CssClass="dnnFormMessage dnnFormError" Type="String" Operator="NotEqual" ControlToValidate="cbolDestinationOstan"
                              ValueToCompare="-- انتخاب نمایید --" resourcekey="ErrorMessage" Display="Dynamic"></asp:CompareValidator>

        <dnn:Label Text="شهر مقصد(قابل تایپ):" runat="server" ID="lblDestinationShahr"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolDestinationShahr"></dnn:DnnComboBox>

        <asp:CompareValidator runat="server" ID="cvCbolDestinationShahr" ValidationGroup="FormValidation"
                              CssClass="dnnFormMessage dnnFormError" Type="String" Operator="NotEqual" ControlToValidate="cbolDestinationShahr"
                              ValueToCompare="-- انتخاب نمایید --" resourcekey="ErrorMessage" Display="Dynamic"></asp:CompareValidator>

    </div>
    
    <div class="dnnFormItem">
        <asp:CheckBox runat="server" Text="با احتساب THC در مبداء" ID="chkIsBaEhtesabeTHCDarMabda"/>
    </div>
    
    <div class="dnnFormItem">
        <asp:CheckBox runat="server" Text="با احتساب هزینه بارگیری کانتینر/غیرکانتینر در مبداء" ID="chkIsBargiriDarMabda"/>
    </div>
    
    <div class="dnnFormItem">
        <asp:CheckBox runat="server" Text="با احتساب هزینه ترخیص در مبدا" ID="chkIsBaEhtesabeAkhseTarkhisDarMabda"/>
    </div>
    <div class="dnnFormItem">
        <asp:CheckBox runat="server" Text="با احتساب هزینه ترخیص در مقصد" ID="chkIsBaEhtesabeHazineyeTarkhisDarMagsad"/>
    </div>
    <div class="dnnFormItem">
        <asp:CheckBox runat="server" Text="با احتساب کلیه هزینه های بندری ،مرزی،گمرکی و عملیاتی بین مسیر" ID="chkIsBaEhtesabeHazinehayeBandariVaGeyre"/>
    </div>
    <div class="dnnFormItem">
        <asp:CheckBox runat="server" Text="با احتساب THC درمقصد" ID="chkIsBaEhtesabeTHCDarMagsad"/>
    </div>
    <div class="dnnFormItem">
        <asp:CheckBox runat="server" Text="با احتساب اخذ ترخیصیه در مقصد" ID="chkIsBaEhtesabeTarkhisiyeDarMagsad"/>
    </div>
    <div class="dnnFormItem">
        <asp:CheckBox runat="server" Text="با احتساب بیمه مسئولیت در طول مسیر" ID="chkIsBaEhtesabeBimeDarTooleMasir"/>
    </div>
    <div class="dnnFormItem">
        <asp:CheckBox runat="server" Text="با احتساب بیمه هزینه تخلیه در مقصد" ID="chkIsEmptying"/>
    </div>
    
    <div class="Inquiry_ChandVajhiSabok-Form-ListeAdlBandi dnnFormItem">

        <asp:HyperLink Text="دریافت فرم ورود ارزش بر اساس لیست عدل بندی" NavigateUrl="/Portals/0/EHaml/Templates/V_A_B_A_L_A.xlsx" runat="server" 
                       resourcekey="hplFormeListeAdlBandi" ID="HyperLink1"></asp:HyperLink>


        <asp:FileUpload ID="fupFormeArzeshBarAsaseListeAdlBandiFull" runat="server" resourcekey="fupFormeArzeshBarAsaseListeAdlBandiFull" />

        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator1"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="fupFormeArzeshBarAsaseListeAdlBandiFull"
                                    resourcekey="ErrorMessage" />

        <asp:RegularExpressionValidator ValidationGroup="FormValidation" ID="RegularExpressionValidator1" runat="server" 
                                        ErrorMessage="فقط فایل با پسوند xlsx مجاز می باشد!"
                                        ControlToValidate="fupFormeArzeshBarAsaseListeAdlBandiFull"
                                        ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.(xlsx|XLSX)$"
                                        CssClass="dnnFormMessage dnnFormError"></asp:RegularExpressionValidator>

    </div>
    
    <div class="dnnFormItem">
        <div>
            <dnn:Label runat="server" ID="lblActionDate"/>
            <dnn:DnnDatePicker runat="server" ID="dtpActionDate"/>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="rfvDtpActionDate" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="dtpActionDate" resourcekey="ErrorMessage" />
        </div>
        <div>
            <dnn:Label runat="server" ID="lblExpireDate"/>
            <dnn:DnnDatePicker runat="server" ID="dtpExpiredate"></dnn:DnnDatePicker>

            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="rfvDtpExpiredate" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="DtpExpiredate" resourcekey="ErrorMessage" />

            <asp:CompareValidator runat="server" ID="cvDtpExpiredate" ValidationGroup="FormValidation"
                                  CssClass="dnnFormMessage dnnFormError" Type="Date" Operator="LessThanEqual" ControlToValidate="dtpExpiredate"
                                  ControlToCompare="dtpActionDate" resourcekey="ExpireDateGreaterThanActionDateErrorMessage" Display="Dynamic"></asp:CompareValidator>

        </div>
    </div>
    <div class="dnnFormItem">
        <asp:CheckBox runat="server" Text="خواهان ارسال استعلام خود برای شرکت های خارج از ایران(غیر ایرانی) هستم." ID="chkKhahaneErsalEstelamBeKharej"/>
    </div>
    <div class="dnnFormItem" style="display: none">
        <asp:CheckBox runat="server" resourcekey="chkIsTender" ID="chkIsTender"/>
    </div>
    
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton  ID="lnkSubmit" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" resourcekey="lnkSubmit" />
            </li>
        </ul>
    </div>
        <div runat="server" class="dnnFormWarning myErrorMessage" id="errorMessages" Visible="False"></div>

</div>