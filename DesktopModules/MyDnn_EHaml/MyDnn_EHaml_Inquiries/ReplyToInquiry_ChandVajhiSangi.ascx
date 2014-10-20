<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReplyToInquiry_ChandVajhiSangi.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.ReplyToInquiry_ChandVajhiSangi" %>
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
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid1" Text="ارسال مجدد لینک تایید"/>
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<div class="ReplyToInquiry-ChandVajhiSangin-Shenasname dnnForm">
    
    <div class="dnnFormItem pasokh-title">
        <dnn:Label Text="شناسنامه استعلام" ID="lblReplyToInquiryChandVajhiSanginShenasnameTitle" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label ID="lblDarkhastKonande" Text="استعلام دهنده:" runat="server"></dnn:Label>
        <dnn:Label ID="lblDarkhastKonandeValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
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
        <dnn:Label ID="lblTarihkeEngeza" Text="تاریخ انقضاء" runat="server"></dnn:Label>
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
    <div class="dnnFormItem" style="display: none">
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
        <dnn:Label Text="نوع بسته بندی:" runat="server" ID="lblPackingType" />
        <dnn:Label runat="server" ID="lblPackingTypeValue" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblWithInsurance" Text="با احتساب بیمه:" runat="server"></dnn:Label>
        <dnn:Label ID="lblWithInsuranceValue" runat="server"></dnn:Label>
    </div>
    
    <%--    <div class="dnnFormItem">
        <dnn:Label ID="lblEmptyingCharges" Text="با احتساب هزینه تخلیه بار:" runat="server"></dnn:Label>
        <dnn:Label ID="lblEmptyingChargesValue" runat="server"></dnn:Label>
    </div>--%>
    <%--    <div class="dnnFormItem">
        <dnn:Label ID="lblNoVaTedadeVasileyeHaml" Text="نوع و تعداد وسیله حمل:" runat="server"></dnn:Label>
        <dnn:Label ID="lblNoVaTedadeVasileyeHamlValue" runat="server"></dnn:Label>
    </div>--%>
    
    <%--    <div class="dnnFormItem">
        <dnn:Label Text="موقعیت تحویل دادن محموله به پیمانکار حمل:" runat="server" ID="lblMogeiyateTahvilDadanShenasname" CssClass="dnnFormRequired"/>
        <asp:Label runat="server" ID="lblMogeiyateTahvilDadanShenasnameValue"/>
    </div>--%>
    
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب THC در مبداء:" ID="Label17" runat="server"></dnn:Label>
        <dnn:Label ID="lblIsTHCDarMabdaChandVajhiSabokValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب بیمه مسئولیت در طول مسیر:" ID="Label19" runat="server"></dnn:Label>
        <dnn:Label ID="lblBaEhtesabeBimeValue" runat="server"></dnn:Label>
    </div>
    <%--    <div class="dnnFormItem">
        <dnn:Label Text="امکان استریپ کردن(خالی کردن محمولات از کانتینر قبل از مقصد نهایی) کانتینر وجود دارد:" ID="Label21" runat="server"></dnn:Label>
        <dnn:Label ID="lblStripValue" runat="server"></dnn:Label>
    </div>--%>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب هزینه بارگیری کانتینر/غیرکانتینر در مبداء:" ID="Label23" runat="server"></dnn:Label>
        <dnn:Label ID="lblBaHazineyeBargiriValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب هزینه ترخیص در مبدا:" ID="Label25" runat="server"></dnn:Label>
        <dnn:Label ID="lblHazineyeTarkhisDarMabdaValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب THC درمقصد:" ID="Label27" runat="server"></dnn:Label>
        <dnn:Label ID="lblTHCDarMabdaValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب کلیه هزینه های بندری ،مرزی،گمرکی و عملیاتی بین مسیر:" ID="Label31" runat="server"></dnn:Label>
        <dnn:Label ID="lblHazinehayeBandariValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب اخذ ترخیصیه در مقصد:" ID="Label33" runat="server"></dnn:Label>
        <dnn:Label ID="lblAkhseTarkhisiyeDarMagsadValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب هزینه تخلیه در مقصد:" ID="Label35" runat="server"></dnn:Label>
        <dnn:Label ID="lblTakhliyeDarMagsadValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب هزینه عودت کانتینر خالی به کشتیرانی:" ID="Label37" runat="server"></dnn:Label>
        <dnn:Label ID="lblOdatContinerValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="Label1" Text="فایل ارزش محموله:" runat="server"></dnn:Label>
        <asp:HyperLink runat="server"  ID="HyperLink1"></asp:HyperLink>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblFileArzesheBar" Text="فایل ارزش محموله:" runat="server"></dnn:Label>
        <asp:HyperLink runat="server"  ID="hplFileArzesheBar"></asp:HyperLink>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblFileListeAdlBandi" Text="فایل لیست عدلبندی:" runat="server"></dnn:Label>
        <asp:HyperLink runat="server"  ID="hplFileListeAdlBandi"></asp:HyperLink>
    </div>
    
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkReply" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" Text="پاسخ به استعلام:" />
            </li>
        </ul>
    </div>
</div>

<div class="ReplyToInquiry-ChandVajhiSangin-Reply-Form dnnForm">
    <div class="dnnFormItem pasokh-title">
        <dnn:Label ID="lblReplyToChandVajhiSanginTitle" runat="server" Text="پاسخ به استعلام"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label ID="lblPasokhDahande" Text="پاسخ دهنده:" runat="server"></dnn:Label>
        <dnn:Label ID="lblPasokhDahandeValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label runat="server" Text="قیمت کل عملیات:" ID="lblGeymatekol"/>
        <asp:TextBox runat="server" ID="txtGeymateKolAmaliyat"></asp:TextBox>
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
        <asp:CheckBox runat="server" Text="با احتساب هزینه تخلیه در مقصد" ID="chkIsEmptying"/>
    </div>
    
   
    <div class="dnnFormItem">
        <dnn:Label ID="Label2" Text="کل مدت زمان حمل:" runat="server" ></dnn:Label>
        <dnn:Label ID="Label3" Text="روز:" runat="server" ></dnn:Label>
        <dnn:DnnNumericTextBox DisplayText="0" ID="txtModatRooz" NumberFormat="n0" runat="server" ShowSpinButtons="True"/>
        <%--        <dnn:Label ID="Label4" Text="ساعت:" runat="server" ></dnn:Label>
        --%>
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
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolPishbini"/>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="Label5" Text="قیمت کل:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtGeymateKol" runat="server" Enabled="False"></asp:TextBox>
    </div>
    
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton  ID="lnkSubmit" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" Text="ارسال:" />
            </li>
        </ul>
    </div>
</div>