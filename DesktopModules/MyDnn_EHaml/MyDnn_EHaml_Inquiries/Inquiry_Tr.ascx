<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Inquiry_Tr.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.Inquiry_Tr" %>
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
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid11" Text="ارسال مجدد لینک تایید"/>
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<div class="InquiryTr-Form dnnForm formTr">
    <div class="dnnFormItem">
        <dnn:Label id="lblInquiryTrTitle" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " id="lblDarkhastKonande" runat="server"></dnn:label>
        <dnn:Label HelpText=" " id="lblDarkhastKonandeValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " id="lblIsReallyNeed" cssclass="dnnFormRequired" runat="server"></dnn:label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolIsReallyNeed" />
        <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator2" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolIsReallyNeed" resourcekey="ErrorMessage" />
        
    </div>
    <div class="InquiryTs-Form-ListeAdlBandi dnnFormItem" style="margin-bottom: 20px">
        <dnn:Label runat="server" HelpText=" " Text="فرم لیست عدل بندی:"></dnn:Label>
        <asp:HyperLink CssClass="textAfterTheButton" Text="دریافت فرم لیست عدل بندی" NavigateUrl="/Portals/0/EHaml/Templates/V_P_L.xlsx" runat="server" 
                       resourcekey="hplFormeListeAdlBandi" ID="hplFormeListeAdlBandi"></asp:HyperLink>


        <asp:FileUpload ID="fupFormeListeAdlBandiFull" runat="server" resourcekey="fupFormeListeAdlBandiFull" />

        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvFupFormeListeAdlBandiFull"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="fupFormeListeAdlBandiFull"
                                    resourcekey="ErrorMessage" />

        <%--        <asp:RegularExpressionValidator ValidationGroup="FormValidation" ID="revFupFormeListeAdlBandiFull" runat="server" --%>
        <%--                                        ErrorMessage="فقط فایل با پسوند xlsx مجاز می باشد!"--%>
        <%--                                        ControlToValidate="fupFormeListeAdlBandiFull"--%>
        <%--                                        ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.(xlsx|XLSX)$"--%>
        <%--                                        CssClass="dnnFormMessage dnnFormError"></asp:RegularExpressionValidator>--%>

    </div>
    
    <div class="InquiryTs-Form-ListeAdlBandi dnnFormItem" style="margin-bottom: 20px">
        <dnn:Label runat="server" HelpText=" " Text="فرم ورود ارزش بر اساس لیست عدلبندی:"></dnn:Label>
        <asp:HyperLink CssClass="textAfterTheButton" Text="فرم ورود ارزش بر اساس لیست عدلبندی" NavigateUrl="/Portals/0/EHaml/Templates/V_A_B_A_L_A.xlsx" runat="server" 
                       resourcekey="hplFormeListeAdlBandi" ID="hplFormeGeymatListeAdlBandi"></asp:HyperLink>


        <asp:FileUpload ID="fupFormeGeymateListeAdlBandi" runat="server" resourcekey="fupFormeGeymateListeAdlBandi" />

        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator1"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="fupFormeGeymateListeAdlBandi"
                                    resourcekey="ErrorMessage" />

        <%--        <asp:RegularExpressionValidator ValidationGroup="FormValidation" ID="RegularExpressionValidator1" runat="server" --%>
        <%--                                        ErrorMessage="فقط فایل با پسوند xlsx مجاز می باشد!"--%>
        <%--                                        ControlToValidate="fupFormeGeymateListeAdlBandi"--%>
        <%--                                        ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.(xlsx|XLSX)$"--%>
        <%--                                        CssClass="dnnFormMessage dnnFormError"></asp:RegularExpressionValidator>--%>

    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " text="نوع ترخیص:" id="lblNoeTarkhis" cssclass="dnnFormRequired" runat="server"></dnn:label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolNoeTarkhis" />
                <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator3"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolNoeTarkhis"
                                    resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " text="محل ترخیص:" id="Label1" cssclass="dnnFormRequired" runat="server"></dnn:label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolMahaleTarkhis" />
                        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator4"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolMahaleTarkhis"
                                    resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " Text="موقعیت تحویل دادن محموله به پیمانکار حمل:" runat="server" ID="lblMogeiyateTahvilDadan" CssClass="dnnFormRequired"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolMogeiyateTahvilDadan"/>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="موقعیت تحویل گرفتن محموله از پیمانکار حمل:" runat="server" ID="lblMogeiyateGereftan" CssClass="dnnFormRequired"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolMogeiyateTahvilGereftan"/>
                                <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator5"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolMogeiyateTahvilGereftan"
                                    resourcekey="ErrorMessage" />
    </div>
    
    <div class="dnnFormItem">
            <dnn:Label HelpText=" " runat="server" Text="تاریخ شروع عملیات:" ID="lblActionDate"/>
            <dnn:DnnDatePicker runat="server" ID="dtpActionDate"/>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="rfvDtpActionDate" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="dtpActionDate" resourcekey="ErrorMessage" />
        </div>
    <div class="dnnFormItem">
            <dnn:Label HelpText=" " runat="server" Text="تاریخ انقضا استعلام:" ID="lblExpireDate"/>
            <dnn:DnnDatePicker runat="server" ID="dtpExpiredate"></dnn:DnnDatePicker>

            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="rfvDtpExpiredate" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="DtpExpiredate" resourcekey="ErrorMessage" />

            <asp:CompareValidator runat="server" ID="cvDtpExpiredate" ValidationGroup="FormValidation"
                                  CssClass="dnnFormMessage dnnFormError" Type="Date" Operator="LessThanEqual" ControlToValidate="dtpExpiredate"
                                  ControlToCompare="dtpActionDate" resourcekey="ExpireDateGreaterThanActionDateErrorMessage" Display="Dynamic"></asp:CompareValidator>
        </div>
    
    <div class="dnnFormItem" style="display: none">
        <dnn:Label runat="server" Text="ارسال استعلام خود برای شرکت های خارج از ایران:" HelpText=" "></dnn:Label>
        <asp:CheckBox runat="server" Text="خواهانم" ID="chkKhahaneErsalEstelamBeKharej"/>
    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton  ID="lnkSubmit" Text="ارسال:" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" resourcekey="lnkSubmit" />
            </li>
        </ul>
    </div>
        <div runat="server" class="dnnFormWarning myErrorMessage" id="errorMessages" Visible="False"></div>
</div>

<div class="messageAfterSubmit dnnFormMessage" visible="False" id="messageAfterSubmit" runat="server"></div>
<div class=""><asp:LinkButton Text="چاپ" Visible="False" ID="lnkPrintKon" runat="server" CssClass="dnnPrimaryAction" /></div>
<asp:HiddenField runat="server" ID="hiddenFieldId"/>