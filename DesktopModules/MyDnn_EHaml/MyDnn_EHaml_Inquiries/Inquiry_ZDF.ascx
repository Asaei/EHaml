<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Inquiry_ZDF.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.Inquiry_ZDF" %>

<%@ Import Namespace="DotNetNuke.Entities.Portals" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2013.2.611.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>

<script type="text/javascript">
<%--    function onItemChecked(sender, args) {
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
    }--%>
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
<div class="InquiryZDF-Form dnnForm zdfForm">
    <div class="dnnFormItem">
        <dnn:Label ID="lblInquiryZDFTitle" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " ID="lblDarkhastKonande" runat="server"></dnn:Label>
        <dnn:Label HelpText=" " ID="lblDarkhastKonandeValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblIsReallyNeed" CssClass="dnnFormRequired" runat="server"></dnn:Label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolIsReallyNeed"/>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator2" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolIsReallyNeed" resourcekey="ErrorMessage" />
    </div>
   
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblNamVaNoeMahamoole" Text="نام و نوع محموله:" CssClass="dnnFormRequired" runat="server"></dnn:Label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolNamVaNoeMahmoole"/>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator3" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolNamVaNoeMahmoole" resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="کد HS محموله:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtCodeHSMahmoole" runat="server"></asp:TextBox>
        <div style="float: left;"> <div style="float: left;"><dnn:Label CssClass="textAfterTheButton tosiye" Text="توصیه میشود تکمیل نمایید" runat="server" ></dnn:Label></div></div>

    </div>
    <div class="dnnFormItem">
        <dnn:Label CssClass="dnnFormRequired" HelpText=" " Text="وزن محموله (کیلوگرم:)" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtVazneMahmoole" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator1" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="txtVazneMahmoole" resourcekey="ErrorMessage" />
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label CssClass="dnnFormRequired" HelpText=" " runat="server" ID="lblStartingPointOstan"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" CssClass="ostanCbo" runat="server" ID="cbolStartingPointOstan" OnClientSelectedIndexChanged=" FillShahrList " ></dnn:DnnComboBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator4" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolStartingPointOstan" resourcekey="ErrorMessage" />
        
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " runat="server" ID="lblStartingPointShahr"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" EnableViewState="True" runat="server" ID="cbolStartingPointShahr"></dnn:DnnComboBox>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="موقعیت تحوبل دادن محموله:" HelpText=" " ID="Label1" CssClass="dnnFormRequired" runat="server"></dnn:Label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="Tahvilmogeiyate"/>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator5" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="Tahvilmogeiyate" resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label CssClass="dnnFormRequired" HelpText=" " runat="server" ID="lblDestinationOstan"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolDestinationOstan" OnClientSelectedIndexChanged=" FillShahrListMagsad "></dnn:DnnComboBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator6" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolDestinationOstan" resourcekey="ErrorMessage" />

    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " runat="server" ID="lblDestinationShahr"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" EnableViewState="True" ID="cbolDestinationShahr"></dnn:DnnComboBox>
        
    </div>
    
    <div class="dnnFormItem">

        <dnn:Label  CssClass="dnnFormRequired" HelpText=" " runat="server" ID="lblActionDate"/>
        <dnn:DnnDatePicker runat="server" ID="dtpActionDate"/>

        <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="rfvDtpActionDate" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="dtpActionDate" resourcekey="ErrorMessage" />

    </div>
    <div class="dnnFormItem">
        <dnn:Label  CssClass="dnnFormRequired" HelpText=" " runat="server" ID="lblExpireDate"/>
        <dnn:DnnDatePicker runat="server" ID="dtpExpiredate"></dnn:DnnDatePicker>

        <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="rfvDtpExpiredate" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="dtpExpiredate" resourcekey="ErrorMessage" />

<%--        <asp:CompareValidator runat="server"  ID="cvDtpExpiredate" ValidationGroup="FormValidation"
                              CssClass="dnnFormMessage dnnFormError" Type="Date" Operator="LessThanEqual" ControlToValidate="dtpExpiredate"
                              ControlToCompare="dtpActionDate"  resourcekey="ExpireDateGreaterThanActionDateErrorMessage" Display="Dynamic"></asp:CompareValidator>--%>
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

<div class="messageAfterSubmit dnnFormMessage" visible="False" id="messageAfterSubmit" runat="server"></div>
<div class=""><asp:LinkButton Text="چاپ" Visible="False" ID="lnkPrintKon" runat="server" CssClass="dnnPrimaryAction" /></div>
<asp:HiddenField runat="server" ID="hiddenFieldId"/>