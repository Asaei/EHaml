<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReplyToInquiry_Tr.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.ReplyToInquiry_Tr" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Portals" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<script>

    $(document).ready(function() {
        $("#lnkReply").click(function() {
            $(".formPasokh").fadeIn(200);
        });

        if ($(".logoForPrint").length != 0) {
            $("#lnkReply").hide();
            window.print();
        }
    });

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
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid123" Text="ارسال مجدد لینک تایید"/>
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<div class="ReplyToInquiry-Ts-Shenasname dnnForm shenasnameForm">
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
        <dnn:Label HelpText=" " ID="lblFileListeAdlBandi" Text="فایل لیست عدلبندی:" runat="server"></dnn:Label>
        <asp:HyperLink CssClass="dnnSecondaryAction" Text="فایل لیست عدلبندی" runat="server"  ID="hplFileListeAdlBandi"></asp:HyperLink>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="Label3" Text="فایل فاکتور محصولات:" runat="server"></dnn:Label>
        <asp:HyperLink CssClass="dnnSecondaryAction" Text="فایل فاکتور محصولات" runat="server"  ID="hplFactorValue"></asp:HyperLink>
    </div>

    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblNoeAmaliyat" Text="نوع ترخیص:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblNoeAmaliyatValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblStartingPoint" Text="محل ترخیص:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblStartingPointValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="Label1" Text="موقعیت تحویل دادن:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblMogeiyateTahvilDadanValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="Label2" Text="موقعیت تحویل گرفتن:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblMogeiyateTahvilGereftanValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblActionDate" Text="تاریخ آغاز عملیات:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblActionDateValue" runat="server"></dnn:Label>
    </div>
  
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <a id="lnkReply" class="dnnPrimaryAction">پاسخ به استعلام</a>
            </li>
        </ul>
    </div>
</div>

<div class="ReplyToInquiry-Dn-Reply-Form dnnForm frompasokhtr formPasokh">
    <div class="dnnFormItem pasokh-title">
        <dnn:Label HelpText=" " ID="lblReplyToInquiryDlTitle" runat="server" Text="پاسخ به استعلام"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " ID="lblPasokhDahande" Text="پاسخ دهنده:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblPasokhDahandeValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " Text="موقعیت تحویل دادن محموله به پیمانکار حمل:" runat="server" ID="lblMogeiyateTahvilDadan" CssClass="dnnFormRequired"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolMogeiyateTahvilDadan"/>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="موقعیت تحویل گرفتن محموله از پیمانکار حمل:" runat="server" ID="lblMogeiyateGereftan" CssClass="dnnFormRequired"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolMogeiyateTahvilGereftan"/>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="Label7" Text="قیمت کل عملیات:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtGeymateKolAmaliyat" runat="server"></asp:TextBox>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="Label4" Text="مدت زمان عملیات(روز):" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtModatRooz" runat="server"/>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="گزارش عملیات:" runat="server" ID="lblGozareshAmaliyat"/>
        <asp:CheckBox runat="server" Text="گزارش وضعیت محموله به صورت روزانه ارائه می گردد:" ID="chkIsGozareshAmaliyat"/>
    </div>

    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="زمان آمادگی برای شروع عملیات:" runat="server" ID="lblZamaneAmadegiBarayeShoorooeAmaliyat"/>
        <dnn:DnnDatePicker runat="server" ID="dtpZamaneAmadegiBarayeShoorooeAmaliyat"/>
    </div>
    
    <div class="dnnFormItem" style="display: none">
        <span class="full-line textAfterTheButton">با توجه به شرایط موجود( از قبیل شرایط مسیر،شرایط آب و هوایی،در دسترس بودن وسیله مورد نیاز و غیره ) امکان پذیری عملیات به این صورت پیش بینی می گردد:" </span>
    </div>
    <div class="dnnFormItem fromtop20" style="display: none">
        <dnn:Label HelpText=" " ID="lblPishbini" Text="پیش بینی:" runat="server" ></dnn:Label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolPishbini"/>
    </div>
   
    <%--    <div class="dnnFormItem">--%>
    <%--        <dnn:Label HelpText=" " ID="Label6" Text="قیمت کل:" runat="server" ></dnn:Label>--%>
    <%--        <asp:TextBox ID="txtGeymateKol" runat="server" Enabled="False"></asp:TextBox>--%>
    <%--    </div>--%>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton  ID="lnkSubmit" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" Text="ارسال:" />
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