<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Inquiry_Dghco.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.Inquiry_Dghco" %>
<%@ Import Namespace="DotNetNuke.Entities.Portals" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2013.2.611.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>
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
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/GetShahrList2",
            data: { "keshvarName": value },
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
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/GetShahrList2",
            data: { "keshvarName": value },
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
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid11" Text="ارسال مجدد لینک تایید" />
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<div class="InquiryDghco-Form dnnForm dghcoForm ">
    <div class="dnnFormItem" style="display: none">
        <dnn:label id="lblInquiryDghcoTitle" runat="server"></dnn:label>
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
    <div class="InquiryDghco-Form-ListeAdlBandi dnnFormItem">

        <dnn:label runat="server" cssclass="dnnFormRequired" helptext=" " text="فرم لیست عدل بندی:"></dnn:label>
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



    <div class="dnnFormItem fromtop20">
        <dnn:label helptext=" " runat="server" id="lblLoadType" cssclass="dnnFormRequired" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolLoadType" checkboxes="True" />
                                    <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator2" CssClass="dnnFormMessage dnnFormError"
                                                runat="server" Display="Dynamic" ControlToValidate="cbolLoadType" resourcekey="ErrorMessage" />
    </div>

    <div class="dnnFormItem">
        <dnn:label helptext=" " text="کد HS محموله:" runat="server"></dnn:label>
        <asp:TextBox ID="txtCodeHSMahmoole" runat="server"></asp:TextBox>
        <div style="float: left;">
            <dnn:label cssclass="textAfterTheButton tosiye6" text="توصیه میشود تکمیل نمایید" runat="server"></dnn:label>
        </div>
    </div>

    <div class="dnnFormItem">
        <dnn:label cssclass="dnnFormRequired" helptext=" " text="نوع بسته بندی:" runat="server" id="lblPackingType"  />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolPackingType" checkboxes="True" />
                                            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator3" CssClass="dnnFormMessage dnnFormError"
                                                runat="server" Display="Dynamic" ControlToValidate="cbolPackingType" resourcekey="ErrorMessage" />
    </div>

    <div class="dnnFormItem">
        <dnn:label text="کشور مبدا(قابل تایپ):" helptext=" " cssclass="dnnFormRequired" runat="server" id="lblStartingPointOstan2" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" cssclass="latinCombo" filter="Contains" onclientselectedindexchanged=" FillShahrList " runat="server" id="cbolStartingPointOstan"></dnn:dnncombobox>
                                                    <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator4" CssClass="dnnFormMessage dnnFormError"
                                                runat="server" Display="Dynamic" ControlToValidate="cbolStartingPointOstan" resourcekey="ErrorMessage" />

    </div>
    <div class="dnnFormItem">
        <dnn:label cssclass="dnnFormRequired" text="شهر مبدا(قابل تایپ):" helptext=" " runat="server" id="lblStartingPointShahr" />
        <telerik:RadComboBox EmptyMessage="-- انتخاب نماييد --" Filter="Contains" CssClass="latinCombo" AllowCustomText="True" runat="server" ID="cbolStartingPointShahr"></telerik:RadComboBox>
                                                            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator5" CssClass="dnnFormMessage dnnFormError"
                                                runat="server" Display="Dynamic" ControlToValidate="cbolStartingPointShahr" resourcekey="ErrorMessage" />
    </div>

    <div class="dnnFormItem">
        <dnn:label cssclass="dnnFormRequired" helptext=" " text="کشور مقصد(قابل تایپ):" runat="server" id="lblDestinationOstan2" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" filter="Contains" onclientselectedindexchanged=" FillShahrListMagsad " cssclass="latinCombo" runat="server" id="cbolDestinationOstan"></dnn:dnncombobox>
                                                                    <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator6" CssClass="dnnFormMessage dnnFormError"
                                                runat="server" Display="Dynamic" ControlToValidate="cbolDestinationOstan" resourcekey="ErrorMessage" />
</div>
        <div cssclass="dnnFormRequired" class="dnnFormItem">
            <dnn:label text="شهر مقصد(قابل تایپ):" cssclass="dnnFormRequired" helptext=" " runat="server" id="lblDestinationShahr" />
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" filter="Contains" cssclass="latinCombo" allowcustomtext="True" runat="server" id="cbolDestinationShahr"></dnn:dnncombobox>
                                                                                <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator7" CssClass="dnnFormMessage dnnFormError"
                                                runat="server" Display="Dynamic" ControlToValidate="cbolDestinationShahr" resourcekey="ErrorMessage" />

        </div>



        <div class="InquiryDghco-Form-ListeAdlBandi dnnFormItem">

            <div class="dnnFormItem" style="margin-top: 20px">
                <dnn:label helptext=" " runat="server" id="lblLoadImage1" text="عکس محموله:"></dnn:label>

                <asp:FileUpload ID="fupLoadImage" runat="server" resourcekey="fupFormeListeAdlBandiFull" />

                <%--                <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator1"--%>
                <%--                    CssClass="dnnFormMessage dnnFormError"--%>
                <%--                    runat="server" Display="Dynamic" ControlToValidate="fupLoadImage"--%>
                <%--                    resourcekey="ErrorMessage" />--%>

                <%--        <asp:RegularExpressionValidator ValidationGroup="FormValidation" ID="RegularExpressionValidator1" runat="server" --%>
                <%--                                        ErrorMessage="فقط فایل با پسوندهای png,gif,jpg,bmp مجاز می باشد!"--%>
                <%--                                        ControlToValidate="fupLoadImage"--%>
                <%--                                        ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.(png|jpg|bmp|gif)$"--%>
                <%--                                        CssClass="dnnFormMessage dnnFormError"></asp:RegularExpressionValidator>--%>
            </div>

            <div class="dnnFormItem">
                <dnn:label helptext=" " text="با احتساب بارگیری روی کشتی در بندر مبداء:" runat="server" id="Label1" />
                <asp:CheckBox Text="با احتساب بارگیری روی کشتی در بندر مبداء" runat="server" ID="chkIsBaEhtesabeBargiriRooyeCashtiDarBandareMabda" />
            </div>
            <div class="dnnFormItem" style="display: none">
                <dnn:label runat="server" text="با احتساب THC در مبداء" helptext=" "></dnn:label>
                <asp:CheckBox runat="server" Text="با احتساب THC در مبداء" ID="chkIsBaEhtesabeTHCDarMabda" />
            </div>
            <div class="dnnFormItem">
                <dnn:label runat="server" text="با احتساب THC درمقصد" helptext=" "></dnn:label>
                <asp:CheckBox runat="server" Text="با احتساب THC درمقصد" ID="chkIsBaEhtesabeTHCDarMagsad" />
            </div>
            <div class="dnnFormItem">
                <dnn:label runat="server" text="با احتساب اخذ ترخیصیه در مقصد" helptext=" "></dnn:label>
                <asp:CheckBox runat="server" Text="با احتساب اخذ ترخیصیه در مقصد" ID="chkIsBaEhtesabeAkhseTarkhisiye" />
            </div>
            <div class="dnnFormItem">
                    <dnn:label cssclass="dnnFormRequired" helptext=" " runat="server" id="lblActionDate" />
                    <dnn:dnndatepicker runat="server" id="dtpActionDate" />
                    <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvDtpActionDate" CssClass="dnnFormMessage dnnFormError"
                                                runat="server" Display="Dynamic" ControlToValidate="dtpActionDate" resourcekey="ErrorMessage" />
                </div>
            <div class="dnnFormItem">
                    <dnn:label cssclass="dnnFormRequired" helptext=" " runat="server" id="lblExpireDate" />
                    <dnn:dnndatepicker runat="server" id="dtpExpiredate"></dnn:dnndatepicker>

                    <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvDtpExpiredate" CssClass="dnnFormMessage dnnFormError"
                                                runat="server" Display="Dynamic" ControlToValidate="DtpExpiredate" resourcekey="ErrorMessage" />

                    <asp:CompareValidator runat="server" ID="cvDtpExpiredate" ValidationGroup="FormValidation"
                                          CssClass="dnnFormMessage dnnFormError" Type="Date" Operator="LessThanEqual" ControlToValidate="dtpExpiredate"
                                          ControlToCompare="dtpActionDate" resourcekey="ExpireDateGreaterThanActionDateErrorMessage" Display="Dynamic"></asp:CompareValidator>

                </div>
            </div>

            <div class="dnnFormItem" style="display: none">
                <dnn:label runat="server" helptext=" " text="خواهان ارسال استعلام خود برای شرکت های خارج:"></dnn:label>
                <asp:CheckBox runat="server" Text="خواهانم" ID="chkKhahaneErsalEstelamBeKharej" />
            </div>
            <div class="dnnFormItem" style="display: none">
                <asp:CheckBox runat="server" resourcekey="chkIsTender" ID="chkIsTender" />
            </div>

            <div class="dnnFormItem">
                <ul class="dnnActions dnnClear">
                    <li>
                        <asp:LinkButton ID="lnkSubmit" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" resourcekey="lnkSubmit" />
                    </li>
                </ul>
            </div>
        </div>
        <div runat="server" class="dnnFormWarning myErrorMessage" id="errorMessages" Visible="False"></div>


<div class="messageAfterSubmit dnnFormMessage" visible="False" id="messageAfterSubmit" runat="server"></div>
<div class=""><asp:LinkButton Text="چاپ" Visible="False" ID="lnkPrintKon" runat="server" CssClass="dnnPrimaryAction" /></div>
<asp:HiddenField runat="server" ID="hiddenFieldId"/>

<%--<script type="text/javascript">--%>
<%----%>
<%--    function FillShahrList() {--%>
<%--        var sf = $.ServicesFramework(<%= ModuleId %>);--%>
<%----%>
<%--        var combobox = $find("<%= cbolStartingPointOstan.ClientID %>");--%>
<%--        var value = combobox.get_value();--%>
<%----%>
<%--        $.ajax({--%>
<%--            type: "GET",--%>
<%--            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/GetShahrList",--%>
<%--            data: { "ostanName": value },--%>
<%--            beforeSend: sf.setModuleHeaders--%>
<%--        }).done(function(result) {--%>
<%--            bindCbolShahr(result);--%>
<%--        }).fail(function(xhr, status, error) {--%>
<%--            alert(error);--%>
<%--        });--%>
<%--    }--%>
<%----%>
<%--    function FillShahrListMagsad() {--%>
<%--        var sf = $.ServicesFramework(<%= ModuleId %>);--%>
<%----%>
<%--        var combobox = $find("<%= cbolDestinationOstan.ClientID %>");--%>
<%--        var value = combobox.get_value();--%>
<%----%>
<%--        $.ajax({--%>
<%--            type: "GET",--%>
<%--            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/GetShahrList",--%>
<%--            data: { "ostanName": value },--%>
<%--            beforeSend: sf.setModuleHeaders--%>
<%--        }).done(function(result) {--%>
<%--            bindCbolShahrMagsad(result);--%>
<%--        }).fail(function(xhr, status, error) {--%>
<%--            alert(error);--%>
<%--        });--%>
<%--    }--%>
<%----%>
<%--    function bindCbolShahr(shahrList) {--%>
<%--        var combo = $find("<%= cbolStartingPointShahr.ClientID %>");--%>
<%--        combo.clearItems();--%>
<%--        for (var i = 0; i < shahrList.length; i++) {--%>
<%--            var comboItem = new Telerik.Web.UI.RadComboBoxItem();--%>
<%--            comboItem.set_text(shahrList[i].Shahr);--%>
<%--            comboItem.set_value(shahrList[i].Shahr);--%>
<%----%>
<%--            combo.get_items().add(comboItem);--%>
<%--            comboItem.select();--%>
<%--            combo.commitChanges();--%>
<%--        }--%>
<%--    }--%>
<%----%>
<%--    function bindCbolShahrMagsad(shahrList) {--%>
<%--        var combo = $find("<%= cbolDestinationShahr.ClientID %>");--%>
<%--        combo.clearItems();--%>
<%--        for (var i = 0; i < shahrList.length; i++) {--%>
<%--            var comboItem = new Telerik.Web.UI.RadComboBoxItem();--%>
<%--            comboItem.set_text(shahrList[i].Shahr);--%>
<%--            comboItem.set_value(shahrList[i].Shahr);--%>
<%----%>
<%--            combo.get_items().add(comboItem);--%>
<%--            comboItem.select();--%>
<%--            combo.commitChanges();--%>
<%--        }--%>
<%--    }--%>
<%--    function voorood(parameters) {var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';dnnModal.show(modulePath, true, 550, 960, true, '');}</script>--%>