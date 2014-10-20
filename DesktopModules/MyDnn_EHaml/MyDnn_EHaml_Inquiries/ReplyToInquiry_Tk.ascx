<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReplyToInquiry_Tk.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.ReplyToInquiry_Tk" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Portals" %>
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
            data: { "UserId": value, "UserCurrentType": 0 },
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            if (result !== "OK") {
                MackeThisUserOK(value, result, 0, "default.aspx");
                return false;
            } else {
                return true;
            }
        }).fail(function(xhr, status, error) {
            alert(error);
        });
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
            کاربر گرامی برای ارسال فرم باید به عنوان صاحب بار ثبت نام نمایید.در غیر این صورت قادر به ارسال فرم نخواهید بود.
        </p>
        <asp:LinkButton runat="server" ID="lnkExitSubscribeAvaziSUser" Text=""></asp:LinkButton>
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
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid111" Text="ارسال مجدد لینک تایید"/>
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<div class="ReplyToInquiry-Tk-Shenasname dnnForm shenasnameForm">
    
    <div class="dnnFormItem pasokh-title">
        <dnn:Label Text="شناسنامه استعلام" ID="lblReplyToInquiryDghcoShenasnameTitle" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " ID="lblDarkhastKonande" Text="استعلام دهنده:" runat="server"></dnn:Label>
        <dnn:Label HelpText=" " ID="lblDarkhastKonandeValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " ID="lblSherkat" Text="نام شرکت:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblSherkatValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblIsReallyNeed" Text="ماهیت استعلام:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblIsReallyNeedValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblZamaneEstelam" Text="زمان استعلام:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblZamaneEstelamValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblTarihkeEngeza" Text="تاریخ انقضاء" runat="server"></dnn:Label>
        <dnn:Label  ID="lblTarihkeEngezaValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblAkharinZamaneTagireEstelam" Text="آخرین زمان تغییر استعلام:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblAkharinZamaneTagireEstelamValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblIsExtend" Text="تمدید شده:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblIsExtendValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblNoeAmaliyat" Text="نوع عملیات:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblNoeAmaliyatValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblStartingPoint" Text="محل عملیات:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblStartingPointValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblActionDate" Text="تاریخ آغاز عملیات:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblActionDateValue" runat="server"></dnn:Label>
    </div>
    
    <asp:Repeater ID="rptNoeVaTedadeVasileyeHamlView" runat="server">
        <ItemTemplate>
            <div class="dnnFormItem">
                <dnn:Label HelpText=" " ID="Label3" Text="جزئیات:" runat="server" ></dnn:Label>
                <dnn:Label  Text='<%# Eval("VasileyeHamlName").ToString() %>' runat="server" ></dnn:Label>
            </div>
            <%--            <div class="dnnFormItem">--%>
            <%--                <dnn:Label HelpText=" " ID="lblTedad" Text="تعداد:" runat="server" ></dnn:Label>--%>
            <%--                <asp:TextBox ID="txtTedad" data-dastgah='<%# (Eval("VasileyeHamlName"))%>' CssClass="priceItem_Tedad_T4" runat="server" ToolTip="تعداد" ValidationGroup='<%# Eval("VasileyeHamlName").ToString() %>'></asp:TextBox>--%>
            <%--            </div>--%>
            <%--            <div class="dnnFormItem" >--%>
            <%--                <dnn:Label HelpText=" " ID="lblGeymateVahed" Text="قیمت واحد:" runat="server" ></dnn:Label>--%>
            <%--                <asp:TextBox data-dastgah='<%# (Eval("VasileyeHamlName"))%>' CssClass="priceItem_Geymate_T4" ID="txtGeymateVahed" runat="server" ToolTip="قیمت واحد:" ValidationGroup='<%# Eval("VasileyeHamlName").ToString() %>'></asp:TextBox>--%>
            <%--            </div>--%>
            <%--            <div class="dnnFormItem" style="display: none">--%>
            <%--                <dnn:Label HelpText=" " ID="lblGeymateKol" Text="قیمت کل:" runat="server" ></dnn:Label>--%>
            <%--                <asp:TextBox ID="txtGeymateKol" runat="server" ToolTip="قیمت کل:"></asp:TextBox>--%>
            <%--            </div>--%>
        </ItemTemplate>
    </asp:Repeater>
  
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <a id="lnkReply" class="dnnPrimaryAction" >پاسخ به استعلام</a>
            </li>
        </ul>
    </div>

</div>

<div class="ReplyToInquiry-Dn-Reply-Form dnnForm formPasokh">
    <div class="dnnFormItem pasokh-title">
        <dnn:Label  ID="lblReplyToInquiryDlTitle" runat="server" Text="پاسخ به استعلام"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " ID="lblPasokhDahande" Text="پاسخ دهنده:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblPasokhDahandeValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " ID="lblGeymatePishnahadi" Text="قیمت پیشنهادی:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtGeymatePishnahadiValue" runat="server"></asp:TextBox>
    </div>
    
    <asp:Repeater ID="rptNoeVaTedadeVasileyeHaml" runat="server">
        <ItemTemplate>
            
            <div class="dnnFormItem" style="display: none">
                <dnn:Label HelpText=" " ID="Label3" Text="جزئیات:" runat="server" ></dnn:Label>
                <dnn:Label  Text='<%# Eval("VasileyeHamlName").ToString() %>' runat="server" ></dnn:Label>
            </div>
            <div class="dnnFormItem">
                <dnn:Label CssClass="dnnFormRequired" HelpText=" " ID="lblTedad" Text="تعداد:" runat="server" ></dnn:Label>
                <asp:TextBox ID="txtTedad" data-dastgah='<%# (Eval("VasileyeHamlName")) %>' CssClass="priceItem_Tedad_T4" runat="server" ToolTip="تعداد" ValidationGroup='<%# Eval("VasileyeHamlName").ToString() %>'></asp:TextBox>
                <asp:RequiredFieldValidator  ValidationGroup="FormValidation" CssClass="dnnFormMessage dnnFormError" runat="server" ControlToValidate="txtTedad" ErrorMessage="وارد کردن این فیلد الزامیست" ></asp:RequiredFieldValidator>
            </div>
            <div class="dnnFormItem" >
                <dnn:Label CssClass="dnnFormRequired" HelpText=" " ID="lblGeymateVahed" Text="قیمت واحد:" runat="server" ></dnn:Label>
                <asp:TextBox data-dastgah='<%# (Eval("VasileyeHamlName")) %>' CssClass="priceItem_Geymate_T4" ID="txtGeymateVahed" runat="server" ToolTip="قیمت واحد:" ValidationGroup='<%# Eval("VasileyeHamlName").ToString() %>'></asp:TextBox>
                <asp:RequiredFieldValidator ValidationGroup="FormValidation" CssClass="dnnFormMessage dnnFormError" runat="server" ControlToValidate="txtGeymateVahed" ErrorMessage="وارد کردن این فیلد الزامیست" ></asp:RequiredFieldValidator>
            </div>
            <div class="dnnFormItem" style="display: none">
                <dnn:Label HelpText=" " ID="lblGeymateKol" Text="قیمت کل:" runat="server" ></dnn:Label>
                <asp:TextBox ID="txtGeymateKol" runat="server" ToolTip="قیمت کل:"></asp:TextBox>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " CssClass="dnnFormRequired" runat="server" Text="انجام عملیات به وسیله:" ID="lblAnjameAmaliyatBeVasileye"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbollblAnjameAmaliyatBeVasileye"/>
        <asp:CompareValidator runat="server" ValidationGroup="FormValidation"
                              CssClass="dnnFormMessage dnnFormError" Type="String" Operator="NotEqual" ControlToValidate="cbollblAnjameAmaliyatBeVasileye"
                              ValueToCompare="-- انتخاب کنید --" ErrorMessage="وارد کردن این فیلد الزامیست"  Display="Dynamic"></asp:CompareValidator>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label CssClass="dnnFormRequired" HelpText=" " ID="Label3" Text="مدت زمان عملیات(روز):" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtModatRooz" runat="server"/>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" CssClass="dnnFormMessage dnnFormError" runat="server" ControlToValidate="txtModatRooz" ErrorMessage="وارد کردن این فیلد الزامیست" ></asp:RequiredFieldValidator>
        <%--        <dnn:Label HelpText=" " ID="Label4" Text="ساعت:" runat="server" ></dnn:Label>
        --%>
    </div>

    <div class="dnnFormItem">
        <dnn:Label CssClass="dnnFormRequired" HelpText=" " Text="زمان آمادگی برای شروع عملیات:" runat="server" ID="lblZamaneAmadegiBarayeShoorooeAmaliyat"/>
        <dnn:DnnDatePicker runat="server" ID="dtpZamaneAmadegiBarayeShoorooeAmaliyat"/>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation"  CssClass="dnnFormMessage dnnFormError" runat="server" ControlToValidate="dtpZamaneAmadegiBarayeShoorooeAmaliyat" ErrorMessage="وارد کردن این فیلد الزامیست" ></asp:RequiredFieldValidator>
    </div>
    
    <div class="dnnFormItem ">
        <span class="full-line textAfterTheButton">با توجه به شرایط موجود( از قبیل شرایط مسیر،شرایط آب و هوایی،در دسترس بودن وسیله مورد نیاز و غیره ) امکان پذیری عملیات به این صورت پیش بینی می گردد:" </span>
    </div>
    <div class="dnnFormItem fromtop20">
        <dnn:Label HelpText=" " CssClass="dnnFormRequired" ID="lblPishbini" Text="پیش بینی:" runat="server" ></dnn:Label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolPishbini"/>
        <asp:CompareValidator runat="server" ValidationGroup="FormValidation"
                              CssClass="dnnFormMessage dnnFormError" Type="String" Operator="NotEqual" ControlToValidate="cbolPishbini"
                              ValueToCompare="-- انتخاب کنید --" ErrorMessage="وارد کردن این فیلد الزامیست"  Display="Dynamic"></asp:CompareValidator>

    </div>
   
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="Label5" Text="قیمت کل:" runat="server" ></dnn:Label>
        <asp:TextBox CssClass="geymateKol" ID="txtGeymateKol" runat="server" Enabled="False"></asp:TextBox>
        <asp:RequiredFieldValidator CssClass="dnnFormMessage dnnFormError" runat="server" ControlToValidate="txtGeymateKol" ValidationGroup="FormValidation" 
                                    ErrorMessage="محاسبه قیمت کل الزامی است.لطفآ برروی دکمه محاسبه قیمت کلیک نمایید."></asp:RequiredFieldValidator>
        <a class="dnnSecondaryAction" onclick=" CalcultePrice(); " >محاسبه قیمت</a>
    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton  ID="lnkSubmit" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" Text="ارسال" />
            </li>
        </ul>
    </div>
</div>

<div class="messageAfterSubmit dnnFormMessage" visible="False" id="messageAfterSubmit" runat="server"></div>
<div class="">
    <asp:LinkButton Text="چاپ" Visible="False" ID="lnkPrintKon" runat="server" CssClass="dnnPrimaryAction" /></div>
<asp:HiddenField runat="server" ID="hiddenFieldId" />

<div id="logoForPrint" class="logoForPrint" runat="server" visible="False">
    <img src="/Portals/0/Logo.png"/>
</div>

<script type="text/javascript">

    $(document).ready(function() {
        $("#lnkReply").click(function() {
            $(".formPasokh").fadeIn(200);
        });

        if ($(".logoForPrint").length != 0) {
            $("#lnkReply").hide();
            window.print();
        }

    });

    function CalcultePrice() {
        $(".geymateKol").val("0");
    }

    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>