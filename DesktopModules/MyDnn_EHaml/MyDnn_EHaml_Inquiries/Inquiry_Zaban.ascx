<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Inquiry_Zaban.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.Inquiry_Zaban" %>
<%@ Register TagPrefix="dnn" TagName="Label_1" Src="~/controls/labelcontrol.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Portals" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

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

    function onEstelamBarAsaseItemChanged() {
        var cbolNoeEstelam = $find("<%= this.cbolBarAsase.ClientID %>");
        var value = cbolNoeEstelam.get_value();

        if (value === "بر اساس تناژ محموله") {

            rfvSubject = document.getElementById('<%= barasaseTonaj1.ClientID %>');
            rfvSubject.validationGroup = "FormValidation";
            ValidatorEnable(rfvSubject, true);
            rfvSubject = document.getElementById('<%= barasaseTonaj2.ClientID %>');
            rfvSubject.validationGroup = "FormValidation";
            ValidatorEnable(rfvSubject, true);

            rfvSubject = document.getElementById('<%= barasaseTedadVaNoeVasileyeHaml1.ClientID %>');
            rfvSubject.validationGroup = "someGroup";
            ValidatorEnable(rfvSubject, false);
            rfvSubject = document.getElementById('<%= barasaseTedadVaNoeVasileyeHaml2.ClientID %>');
            rfvSubject.validationGroup = "someGroup";
            ValidatorEnable(rfvSubject, false);
            rfvSubject = document.getElementById('<%= barasaseTedadVaNoeVasileyeHaml3.ClientID %>');
            rfvSubject.validationGroup = "someGroup";
            ValidatorEnable(rfvSubject, false);

            rfvSubject = document.getElementById('<%= barasaseDekopaj1.ClientID %>');
            rfvSubject.validationGroup = "someGroup";
            ValidatorEnable(rfvSubject, false);


            $(".barasaseTonaj").fadeIn(500);
            $(".barasaseTedadVaNoeVasileyeHaml").fadeOut(500);
            $(".barasaseDekopaj").fadeOut(500);
        } else if (value === "بر اساس تعداد و نوع وسیله حمل") {

            rfvSubject = document.getElementById('<%= barasaseTedadVaNoeVasileyeHaml1.ClientID %>');
            rfvSubject.validationGroup = "FormValidation";
            ValidatorEnable(rfvSubject, true);
            rfvSubject = document.getElementById('<%= barasaseTedadVaNoeVasileyeHaml2.ClientID %>');
            rfvSubject.validationGroup = "FormValidation";
            ValidatorEnable(rfvSubject, true);
            rfvSubject = document.getElementById('<%= barasaseTedadVaNoeVasileyeHaml3.ClientID %>');
            rfvSubject.validationGroup = "FormValidation";
            ValidatorEnable(rfvSubject, true);

            rfvSubject = document.getElementById('<%= barasaseTonaj1.ClientID %>');
            rfvSubject.validationGroup = "someGroup";
            ValidatorEnable(rfvSubject, false);
            rfvSubject = document.getElementById('<%= barasaseTonaj2.ClientID %>');
            rfvSubject.validationGroup = "someGroup";
            ValidatorEnable(rfvSubject, false);

            rfvSubject = document.getElementById('<%= barasaseDekopaj1.ClientID %>');
            rfvSubject.validationGroup = "someGroup";
            ValidatorEnable(rfvSubject, false);

            $(".barasaseTedadVaNoeVasileyeHaml").fadeIn(500);
            $(".barasaseTonaj").fadeOut(500);
            $(".barasaseDekopaj").fadeOut(500);

        } else if (value === "گروپاژ") {

            rfvSubject = document.getElementById('<%= barasaseDekopaj1.ClientID %>');
            rfvSubject.validationGroup = "FormValidation";
            ValidatorEnable(rfvSubject, true);

            rfvSubject = document.getElementById('<%= barasaseTedadVaNoeVasileyeHaml1.ClientID %>');
            rfvSubject.validationGroup = "someGroup";
            ValidatorEnable(rfvSubject, false);
            rfvSubject = document.getElementById('<%= barasaseTedadVaNoeVasileyeHaml2.ClientID %>');
            rfvSubject.validationGroup = "someGroup";
            ValidatorEnable(rfvSubject, false);
            rfvSubject = document.getElementById('<%= barasaseTedadVaNoeVasileyeHaml3.ClientID %>');
            rfvSubject.validationGroup = "someGroup";
            ValidatorEnable(rfvSubject, false);

            rfvSubject = document.getElementById('<%= barasaseTonaj1.ClientID %>');
            rfvSubject.validationGroup = "someGroup";
            ValidatorEnable(rfvSubject, false);

            $(".barasaseDekopaj").fadeIn(500);
            $(".barasaseTedadVaNoeVasileyeHaml").fadeOut(500);
            $(".barasaseTonaj").fadeOut(500);

        }
    }

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
            کاربر گرامی برای ارسال فرم باید طرح عضویت به عنوان صاحب بار را خریداری نمایید. در غیر این صورت قادر به ارسال فرم نخواهید بود.
        </p>
        <asp:LinkButton runat="server" ID="lnkTasviye1" Text="خرید طرح عضویت"></asp:LinkButton>
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
<div class="InquiryZaban-Form dnnForm zabanForm">
    <div class="dnnFormItem">
        <dnn:Label ID="lblInquiryZabanTitle" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " ID="lblDarkhastKonande" runat="server"></dnn:Label>
        <dnn:Label HelpText=" " ID="lblDarkhastKonandeValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblIsReallyNeed" CssClass="dnnFormRequired" runat="server"></dnn:Label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolIsReallyNeed"/>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvcbolIsReallyNeed"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolIsReallyNeed"
                                    resourcekey="ErrorMessage" />
        
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " runat="server" Text="نوع حمل:" ID="lblNoeHaml" CssClass="dnnFormRequired"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolNoeHaml"/>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator1"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolNoeHaml"
                                    resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " runat="server" ID="lblLoadType" CssClass="dnnFormRequired"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" onclientitemchecked=" onItemChecked " runat="server" ID="cbolLoadType" CheckBoxes="True"/>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator2"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolLoadType"
                                    resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem panelekalayekhatarnak" style="display: none" runat="server" id="panelekalayekhatarnak">
        <dnn:Label HelpText=" " CssClass="dnnFormRequired" runat="server" ID="lblListeKalahayeKhatarnak"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" CssClass="dnnFixedSizeComboBox" runat="server" ID="cbolDangerLoadCodes" CheckBoxes="True"/>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidatorkhatarnak"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolDangerLoadCodes"
                                    resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="کد HS محموله:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtCodeHSMahmoole" runat="server"></asp:TextBox>
        <span style="float: left;"><dnn:Label CssClass="textAfterTheButton tosiye2" Text="توصیه میشود تکمیل نمایید" runat="server" ></dnn:Label></span>
    </div>
    
    

    <div class="dnnFormItem">
        <dnn:Label HelpText=" " CssClass="dnnFormRequired" runat="server" ID="lblBarAsase" Text="استعلام بر اساس:"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" CssClass="cbolBarAsaseValue" OnClientSelectedIndexChanged=" onEstelamBarAsaseItemChanged " runat="server" ID="cbolBarAsase"/>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator4"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolBarAsase"
                                    resourcekey="ErrorMessage" />
    </div>
    <div class="barasaseTedadVaNoeVasileyeHaml" id="barasaseTedadVaNoeVasileyeHaml" runat="server">
        <div class="dnnFormItem">
            <dnn:Label runat="server" Text="با احتساب هزینه عودت کانتینر خالی:" HelpText=" "></dnn:Label>
            <asp:CheckBox runat="server" Text="با احتساب هزینه عودت کانتینر خالی:" ID="chkIsEhtesabeHazineyeOdateKantinerKhali"/>
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" runat="server" ID="lblNoeVasileyeHaml" Text="نوع وسیله حمل:"/>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolNoeVasileyeHaml"/>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="barasaseTedadVaNoeVasileyeHaml1" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolNoeVasileyeHaml" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" Text="تعداد:" ID="lblTedadeVasileyeHaml" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtTedadeVasileyeHaml" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="barasaseTedadVaNoeVasileyeHaml2" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="txtTedadeVasileyeHaml" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" Text="حداکثر وزن محموله(کیلوگرم):" ID="lblHadeAxareVazneMahmoole" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtHadeAxareVazneMahmoole" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="barasaseTedadVaNoeVasileyeHaml3" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="txtHadeAxareVazneMahmoole" resourcekey="ErrorMessage" />
        </div>
    </div>

    <div class="barasaseTonaj" id="barasaseTonaj" runat="server">
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" Text="وزن کل محموله(کیلوگرم):" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtVazneKoleMahmoole" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="barasaseTonaj1" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="txtVazneKoleMahmoole" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" Text="وزن هر واحد محموله(کیلوگرم):" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtVazneHarVahedeMahmoole" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="barasaseTonaj2" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="txtVazneHarVahedeMahmoole" resourcekey="ErrorMessage" />
        </div>
    </div>

    <div class="barasaseDekopaj" id="barasaseDekopaj" runat="server" >
        <div class="dnnFormItem" style="margin-bottom: 20px">
            <dnn:Label CssClass="dnnFormRequired" runat="server" HelpText=" " Text="فرم لیست عدل بندی:"></dnn:Label>
            <asp:HyperLink CssClass="textAfterTheButton" Text="دریافت فرم لیست عدل بندی" NavigateUrl="/Portals/0/EHaml/Templates/V_P_L.xlsx" runat="server" 
                           resourcekey="hplFormeListeAdlBandi" ID="hplFormeListeAdlBandi"></asp:HyperLink>


            <asp:FileUpload ID="fupFormeListeAdlBandiFull" runat="server" resourcekey="fupFormeListeAdlBandiFull" />
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="barasaseDekopaj1" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="fupFormeListeAdlBandiFull" resourcekey="ErrorMessage" />

            <%--            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvFupFormeListeAdlBandiFull"--%>
            <%--                                        CssClass="dnnFormMessage dnnFormError"--%>
            <%--                                        runat="server" Display="Dynamic" ControlToValidate="fupFormeListeAdlBandiFull"--%>
            <%--                                        resourcekey="ErrorMessage" />--%>

            <%--        <asp:RegularExpressionValidator ValidationGroup="FormValidation" ID="revFupFormeListeAdlBandiFull" runat="server" --%>
            <%--                                        ErrorMessage="فقط فایل با پسوند xlsx مجاز می باشد!"--%>
            <%--                                        ControlToValidate="fupFormeListeAdlBandiFull"--%>
            <%--                                        ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.(xlsx|XLSX)$"--%>
            <%--                                        CssClass="dnnFormMessage dnnFormError"></asp:RegularExpressionValidator>--%>

        </div>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="کشور مبدا(قابل تایپ):" CssClass="dnnFormRequired" HelpText=" " runat="server" ID="lblStartingPointOstan2"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" Filter="Contains" CssClass="latinCombo" OnClientSelectedIndexChanged=" FillShahrList "  runat="server" ID="cbolStartingPointOstan"></dnn:DnnComboBox>

        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator5"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolStartingPointOstan"
                                    resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label CssClass="dnnFormRequired" Text="شهر مبدا(قابل تایپ):" HelpText=" " runat="server" ID="lblStartingPointShahr"/>
        <telerik:RadComboBox CssClass="latinCombo" Filter="Contains" AllowCustomText="True" runat="server" ID="cbolStartingPointShahr"></telerik:RadComboBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator6"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolStartingPointShahr"
                                    resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="موقعیت تحویل دادن محموله به پیمانکار حمل:" runat="server" ID="lblMogeiyateTahvilDadan" CssClass="dnnFormRequired"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolMogeiyateTahvilDadan"/>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator7"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolMogeiyateTahvilDadan"
                                    resourcekey="ErrorMessage" />
    </div>

    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="کشور مقصد(قابل تایپ):" runat="server" ID="lblDestinationOstan2" CssClass="dnnFormRequired"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" Filter="Contains" CssClass="latinCombo" OnClientSelectedIndexChanged=" FillShahrListMagsad " runat="server" ID="cbolDestinationOstan"></dnn:DnnComboBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator8"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolDestinationOstan"
                                    resourcekey="ErrorMessage" />

        <div class="dnnFormItem">
            <dnn:Label Text="شهر مقصد(قابل تایپ):" HelpText=" " runat="server" ID="lblDestinationShahr" CssClass="dnnFormRequired"/>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" CssClass="latinCombo" AllowCustomText="True" runat="server" ID="cbolDestinationShahr"></dnn:DnnComboBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator9"
                                        CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolDestinationShahr"
                                        resourcekey="ErrorMessage" />
        </div>
    

    
        <div class="dnnFormItem">
            <dnn:Label runat="server" Text=":با احتساب هزینه تخلیه در مقصد" HelpText=" "></dnn:Label>
            <asp:CheckBox resourcekey="chkEmptyingCharges" runat="server" ID="chkEmptyingCharges"/>
        </div>
    
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " runat="server" ID="lblActionDate" CssClass="dnnFormRequired"/>
            <dnn:DnnDatePicker runat="server" ID="dtpActionDate"/>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="rfvDtpActionDate" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="dtpActionDate" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " runat="server" ID="lblExpireDate" CssClass="dnnFormRequired"/>
            <dnn:DnnDatePicker runat="server" ID="dtpExpiredate"></dnn:DnnDatePicker>

            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="rfvDtpExpiredate" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="DtpExpiredate" resourcekey="ErrorMessage" />

            <asp:CompareValidator runat="server" ID="cvDtpExpiredate" ValidationGroup="FormValidation"
                                  CssClass="dnnFormMessage dnnFormError" Type="Date" Operator="LessThanEqual" ControlToValidate="dtpExpiredate"
                                  ControlToCompare="dtpActionDate" resourcekey="ExpireDateGreaterThanActionDateErrorMessage" Display="Dynamic"></asp:CompareValidator>

        </div>
        <div class="dnnFormItem">
            <span style="margin-bottom: 20px !important" class="full-line textAfterTheButton">(هزینه های مرزی غیر از حقوق و عوارض گمرکی مشمول محموله، در قیمت لحاظ می باشد)</span>
        </div>
        <div class="dnnFormItem" style="display: none">
            <dnn:Label runat="server" Text=" " HelpText=" "></dnn:Label>
            <asp:CheckBox runat="server" resourcekey="chkIsTender" ID="chkIsTender"/>
        </div>
        <div class="dnnFormItem fromtop20" style="display: none">
            <dnn:Label runat="server" Text="ارسال استعلام خود برای شرکت های خارج از ایران:" HelpText=" "></dnn:Label>
            <asp:CheckBox runat="server" Text="خواهانم" ID="chkKhahaneErsalEstelamBeKharej"/>
        </div>
        <div class="dnnFormItem">
            <ul class="dnnActions dnnClear">
                <li>
                    <asp:LinkButton  ID="lnkSubmit" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" resourcekey="lnkSubmit" />
                </li>
            </ul>
        </div>
    </div>
    <div runat="server" class="dnnFormWarning myErrorMessage" id="errorMessages" Visible="False"></div>
</div>

<div class="messageAfterSubmit dnnFormMessage" visible="False" id="messageAfterSubmit" runat="server"></div>
<div class=""><asp:LinkButton Text="چاپ" Visible="False" ID="lnkPrintKon" runat="server" CssClass="dnnPrimaryAction" /></div>
<asp:HiddenField runat="server" ID="hiddenFieldId"/>