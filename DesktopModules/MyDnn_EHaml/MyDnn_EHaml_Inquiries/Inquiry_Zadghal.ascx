<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Inquiry_Zadghal.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.Inquiry_Zadghal" %>
<%@ Register TagPrefix="dnn" TagName="Label_1" Src="~/controls/labelcontrol.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Portals" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>


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

    function bimeCheckBoxChanged() {

        var checked = $(".bimecheckbox input").is(":checked");
        if (checked) {
            $(".paneleVooroodeArzesheBar").fadeIn(200);
        } else {
            $(".paneleVooroodeArzesheBar").fadeOut(200);
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
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid1" Text="ارسال مجدد لینک تایید"/>
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<div class="InquiryZadghal-Form dnnForm zadghalForm">
    <div class="dnnFormItem">
        <dnn:Label ID="lblInquiryZadghalTitle" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText="" ID="lblDarkhastKonande" runat="server"></dnn:Label>
        <dnn:Label ID="lblDarkhastKonandeValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblIsReallyNeed" CssClass="dnnFormRequired" runat="server"></dnn:Label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolIsReallyNeed"/>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator5" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolIsReallyNeed" resourcekey="ErrorMessage" />
    </div>
    
    <%--    <asp:Repeater ID="rptNoeVaTedadeVasileyeHaml" runat="server">
        <ItemTemplate>
            <div class="dnnFormItem">
                <dnn:Label HelpText="" ID="lblVasileyeHamlName" Text='<%# LocalizeString(Eval("VasileyeHamlName").ToString()) %>' runat="server" ></dnn:Label>
                <asp:TextBox ID="txtTedadeVasileyeHaml" runat="server" ToolTip='<%# LocalizeString(Eval("VasileyeHamlName").ToString()) %>'></asp:TextBox>
            </div>
        </ItemTemplate>
    </asp:Repeater>--%>
    
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " ID="lblNoeVasileyeHaml" runat="server"></dnn:Label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolNoeVasileyeHaml" CheckBoxes="True" CssClass="dnnFixedSizeComboBox">

            <ItemTemplate>
                <asp:Label ID="lblVasileName" runat="server" Text='<%# DataBinder.Eval(Container, "Text") %>' />
                <%--                <dnn:Label HelpText="" runat="server" ID="lblTedadeVasileyeHaml" Text="تعداد:"/>--%>
                <asp:TextBox ID="txtTedadeVasile" runat="server" />
            </ItemTemplate>
            <Items>
                <dnn:DnnComboBoxItem runat="server" Text='<%# Eval("VasileyeHamlName") %>' />
            </Items>
        </dnn:DnnComboBox>
    </div>
    
    <div class="InquiryZadghal-Form-ListeAdlBandi dnnFormItem ">
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " Text=":بااحتساب بیمه مسئولیت" runat="server"></dnn:Label>
            <asp:CheckBox onclick="bimeCheckBoxChanged();" CssClass="bimecheckbox" runat="server" resourcekey="chkWithInsurance" ID="chkWithInsurance"/>
        </div>
        <div class="dnnFormItem">
            <dnn:Label cssclass="dnnFormRequired"  HelpText=" " runat="server" Text="فرم پکینگ لیست:" runat="server"></dnn:Label>
            <asp:HyperLink CssClass="textAfterTheButton" Text="دریافت فرم ورود پکینگ لیست" NavigateUrl="/Portals/0/EHaml/Templates/V_P_L.xlsx" runat="server" 
                           resourcekey="hplFormeListeAdlBandi" ID="hplFormeListeAdlBandi"></asp:HyperLink>


            <asp:FileUpload ID="fupFormeListeAdlBandiFull" runat="server" resourcekey="fupFormeListeAdlBandiFull" />

            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator99"
                                        CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="fupFormeListeAdlBandiFull"
                                        resourcekey="ErrorMessage" />

            <%--        <asp:RegularExpressionValidator ValidationGroup="FormValidation" ID="revFupFormeListeAdlBandiFull" runat="server" 
                                        ErrorMessage="فقط فایل با پسوند xlsx مجاز می باشد!"
                                        ControlToValidate="fupFormeListeAdlBandiFull"
                                        ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.(xlsx|XLSX)$"
                                        CssClass="dnnFormMessage dnnFormError"></asp:RegularExpressionValidator>--%>

        </div>

        <div class="InquiryZadghal-Form-StartingPointDestination paneleVooroodeArzesheBar dnnFormItem fromtop20" runat="server" id="paneleVooroodeArzesheBar" style="margin-bottom: 20px">
        
            <dnn:Label CssClass="dnnFormRequired" HelpText=" " runat="server" Text="فرم ورود ارزش بر اساس لیست عدل بندی:"></dnn:Label>
            <asp:HyperLink CssClass="textAfterTheButton" NavigateUrl="/Portals/0/EHaml/Templates/V_A_B_A_L_A.xlsx" runat="server" 
                           resourcekey="hplFormeVooroodeArzeshBarAsaseListeAdlBandi" Text="دریافت قالب فرم ورود ارزش بر اساس لیست عدل بندی" ID="hplFormeVooroodeArzeshBarAsaseVasileyeHaml"></asp:HyperLink>


            <asp:FileUpload ID="fupFormeVooroodeArzeshBarAsaseVasileyeHamlFull" runat="server" resourcekey="fupFormeVooroodeArzeshBarAsaseVasileyeHamlFull" />

            <%--            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvFupFormeVooroodeArzeshBarAsaseVasileyeHamlFull"
                                        CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="fupFormeVooroodeArzeshBarAsaseVasileyeHamlFull"
                                        resourcekey="ErrorMessage" />--%>

            <%--        <asp:RegularExpressionValidator ValidationGroup="FormValidation" ID="revFupFormeVooroodeArzeshBarAsaseVasileyeHamlFull" runat="server" 
                                        ErrorMessage="فقط فایل با پسوند xlsx مجاز می باشد!"
                                        ControlToValidate="fupFormeVooroodeArzeshBarAsaseVasileyeHamlFull"
                                        ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.(xlsx|XLSX)$"
                                        CssClass="dnnFormMessage dnnFormError"></asp:RegularExpressionValidator>--%>

        </div>
    
        <div class="dnnFormItem fromtop20">
            <dnn:Label HelpText=" " runat="server" ID="lblLoadType" CssClass="dnnFormRequired"/>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolLoadType" onclientitemchecked=" onItemChecked " CheckBoxes="True"/>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator1" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolLoadType" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem panelekalayekhatarnak" id="panelekalayekhatarnak" runat="server" style="display: none">
            <dnn:Label cssclass="dnnFormRequired" HelpText="" runat="server" ID="lblListeKalahayeKhatarnak"/>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" CssClass="dnnFixedSizeComboBox" runat="server" ID="cbolDangerLoadCodes" CheckBoxes="True"/>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidatorkhatarnak" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolDangerLoadCodes" resourcekey="ErrorMessage" />
            RequiredFieldValidatorkhatarnak
        </div>
    
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" Text="نوع بسته بندی:" runat="server" ID="lblPackingType"/>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolPackingType" CheckBoxes="True" />
            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator2" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolPackingType" resourcekey="ErrorMessage" />
        </div>
    
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" runat="server" ID="lblStartingPointOstan"/>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolStartingPointOstan" OnClientSelectedIndexChanged=" FillShahrList "></dnn:DnnComboBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator3" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolStartingPointOstan" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" runat="server" ID="lblStartingPointShahr"/>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolStartingPointShahr"></dnn:DnnComboBox>

            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator4" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolStartingPointShahr" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " Text="موقعیت تحویل دادن محموله به پیمانکار حمل:" runat="server" ID="lblMogeiyateTahvilDadan" CssClass="dnnFormRequired"/>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolMogeiyateTahvilDadan"/>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator6" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolMogeiyateTahvilDadan" resourcekey="ErrorMessage" />
        </div>

        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" runat="server" ID="lblDestinationOstan"/>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolDestinationOstan" OnClientSelectedIndexChanged=" FillShahrListMagsad "></dnn:DnnComboBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator7" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolDestinationOstan" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" runat="server" ID="lblDestinationShahr"/>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolDestinationShahr"></dnn:DnnComboBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator8" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolDestinationShahr" resourcekey="ErrorMessage" />
            
        </div>
    

    
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " Text="با احتساب تخلیه در مقصد:" runat="server"></dnn:Label>
            <asp:CheckBox resourcekey="chkEmptyingCharges" runat="server" ID="chkEmptyingCharges"/>
        </div>
    
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired"  runat="server" ID="lblActionDate"/>
            <dnn:DnnDatePicker runat="server" ID="dtpActionDate"/>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvDtpActionDate" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="dtpActionDate" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" runat="server" ID="lblExpireDate"/>
            <dnn:DnnDatePicker runat="server" ID="dtpExpiredate"></dnn:DnnDatePicker>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator9" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="dtpExpiredate" resourcekey="ErrorMessage" />

            <%-- <asp:CompareValidator runat="server" ID="cvDtpExpiredate" ValidationGroup="FormValidation"
                                      CssClass="dnnFormMessage dnnFormError" Type="Date" Operator="LessThanEqual" ControlToValidate="dtpExpiredate"
                                      ControlToCompare="dtpActionDate" resourcekey="ExpireDateGreaterThanActionDateErrorMessage" Display="Dynamic"></asp:CompareValidator>--%>

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