<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReplyToInquiry_Zadghan.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.ReplyToInquiry_Zadghan" %>

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
        }).done(function (result) {
            if (result !== "OK") {
                MackeThisUserOK(value, result, 0, "default.aspx");
                return false;
            } else {
                return true;
            }
        }).fail(function (xhr, status, error) {
            alert(error);
        });
    };

</script>
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
        <a href="#">ثبت نام</a>
        <a href="#">ورود</a>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="pnlMessageForNotApproved" Visible="False">
    <div class="MessageForNotApproved">
        <p>
کاربر گرامی شما هنور عضویت خود را تایید ننمود ه اید. برای این کار لطفآ بر روی لینک ارسالی در ایمل خود کلیک نمایید.
        </p>
        <asp:Button runat="server" ID="btnErsaleLinkTaeid" Text="ارسال مجدد لینک تایید"/>
    </div>
</asp:Panel>
<div class="ReplyToInquiry-Zadghan-Shenasname dnnForm">
    
    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه استعلام" ID="lblReplyToInquiryZadghanShenasnameTitle" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblDarkhastKonande" Text="استعلام دهنده:" runat="server"></dnn:Label>
        <dnn:Label ID="lblDarkhastKonandeValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblSherkat" Text="نام شرکت:" runat="server"></dnn:Label>
        <dnn:Label ID="lblSherkatValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblIsReallyNeed" Text="ماهیت استعلام:" runat="server"></dnn:Label>
        <dnn:Label ID="lblIsReallyNeedValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblZamaneEstelam" Text="زمان استعلام:" runat="server"></dnn:Label>
        <dnn:Label ID="lblZamaneEstelamValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblTarihkeEngeza" Text="تاریخ انقضاء:" runat="server"></dnn:Label>
        <dnn:Label ID="lblTarihkeEngezaValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblAkharinZamaneTagireEstelam" Text="آخرین زمان تغییر استعلام:" runat="server"></dnn:Label>
        <dnn:Label ID="lblAkharinZamaneTagireEstelamValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblIsExtend" Text="تمدید شده:" runat="server"></dnn:Label>
        <dnn:Label ID="lblIsExtendValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblIsTender" Text="استعلام به صورت مناقصه میباشد؟" runat="server"></dnn:Label>
        <dnn:Label ID="lblIsTenderValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblStartingPoint" Text="مبدا:" runat="server"></dnn:Label>
        <dnn:Label ID="lblStartingPointValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblMagsad" Text="مقصد:" runat="server"></dnn:Label>
        <dnn:Label ID="lblMagsadValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblActionDate" Text="تاریخ آغاز عملیات:" runat="server"></dnn:Label>
        <dnn:Label ID="lblActionDateValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblLoadType" Text="نوع محموله:" runat="server"></dnn:Label>
        <dnn:Label ID="lblLoadTypeValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblWithInsurance" Text="با احتساب بیمه:" runat="server"></dnn:Label>
        <dnn:Label ID="lblWithInsuranceValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblEmptyingCharges" Text="با احتساب هزینه تخلیه بار:" runat="server"></dnn:Label>
        <dnn:Label ID="lblEmptyingChargesValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblNoVaTedadeVasileyeHaml" Text="نوع و تعداد وسیله حمل:" runat="server"></dnn:Label>
        <dnn:Label ID="lblNoVaTedadeVasileyeHamlValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblFileArzesheBar" Text="فایل ارزش بار:" runat="server"></dnn:Label>
        <asp:HyperLink runat="server"  ID="hplFileArzesheBar"></asp:HyperLink>
    </div>
    
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkReply" ValidationGroup="ReplyToInquiry-Zadghan-Shenasname-Form" runat="server" CssClass="dnnPrimaryAction" Text="پاسخ به استعلام:" />
            </li>
        </ul>
    </div>
</div>

<div class="ReplyToInquiry-Zadghan-Reply-Form dnnForm">
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblReplyToInquiryZadghanTitle" runat="server" Text="پاسخ به استعلام"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblPasokhDahande" Text="پاسخ دهنده:" runat="server"></dnn:Label>
        <dnn:Label ID="lblPasokhDahandeValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label Text="کرایه پیشنهادی:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtKerayeyePishnahadi" runat="server"></asp:TextBox>
    </div>

    <asp:Repeater ID="rptNoeVaTedadeVasileyeHaml" runat="server">
        <ItemTemplate>
            <div class="dnnFormItem">
                <dnn:Label Text='<%# Eval("VasileyeHamlName").ToString() %>' runat="server" ></dnn:Label>
                <div>
                    <dnn:Label ID="lblGeymateVahed" Text="قیمت واحد:" runat="server" ></dnn:Label>
                    <asp:TextBox ID="txtGeymateVahed" runat="server" ToolTip="قیمت واحد:" ValidationGroup='<%# Eval("VasileyeHamlName").ToString() %>'></asp:TextBox>
                </div>
                <div>
                    <dnn:Label ID="lblGeymateKol" Text="قیمت کل:" runat="server" ></dnn:Label>
                    <asp:TextBox ID="txtGeymateKol" runat="server" ToolTip="قیمت کل:"></asp:TextBox>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    
    <div class="dnnFormItem">
        <dnn:Label Text="کل مدت زمان حمل:" runat="server" ></dnn:Label>
        <dnn:Label Text="روز:" runat="server" ></dnn:Label>
        <dnn:DnnNumericTextBox DisplayText="0" ID="txtModatRooz" NumberFormat="n0" runat="server" ShowSpinButtons="True"/>
        
        
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label Text="زمان آمادگی برای شروع عملیات:" runat="server" ID="lblZamaneAmadegiBarayeShoorooeAmaliyat"/>
        <dnn:DnnDatePicker runat="server" ID="dtpZamaneAmadegiBarayeShoorooeAmaliyat"/>
    </div>
    
    <div class="dnnFormItem">
        <asp:CheckBox runat="server" Text="گزارش عملیات و ردیابی محموله به صورت روزانه و منظم ارائه می گردد:" ID="chkIsGozareshAmaliyat"/>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblPishbini" Text="با توجه به شرایط موجود( از قبیل شرایط مسیر،شرایط آب و هوایی،در دسترس بودن وسیله مورد نیاز و غیره ) امکان پذیری عملیات به این صورت پیش بینی می گردد:" runat="server" ></dnn:Label>
        <dnn:DnnComboBox runat="server" ID="cbolPishbini"/>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت کل:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtGeymateKol" runat="server" Enabled="False"></asp:TextBox>
    </div>
    
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmit" ValidationGroup="ReplyToInquiryZadghan-Reply-Form" runat="server" CssClass="dnnPrimaryAction" Text="ارسال:" />
            </li>
        </ul>
    </div>
</div>