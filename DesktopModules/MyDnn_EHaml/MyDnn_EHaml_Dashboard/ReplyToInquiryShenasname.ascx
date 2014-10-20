<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReplyToInquiryShenasname.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Dashboard.ReplyToInquiryShenasname" %>
<%@ Import Namespace="DotNetNuke.Entities.Portals" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>

<asp:Panel runat="server" ID="pnlMessageForNotSubscribeUser" Visible="False">
    <div class="MessageForNotSubscribeUser">
        <p>
            کاربر گرامی برای ارسال فرم باید طرح عضویت را خریداری نمایید. در غیر این صورت قادر به ارسال فرم نخواهید بود.
        </p>
        <asp:LinkButton runat="server" ID="lnkTasviye" Text="خرید طرح عضویت"></asp:LinkButton>
    </div>
</asp:Panel>

<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="ReplyToInquiryEshterakatShenasname" Visible="True">
    <div class="dnnFormItem pasokhdahande">
        <dnn:Label HelpText=" " ID="lblPasokhDahande" Text="پاسخ دهنده:" runat="server"></dnn:Label>
        <dnn:Label ID="lblPasokhDahandeValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="کل مدت زمان حمل:" runat="server"></dnn:Label>
        <dnn:Label ID="lblKoleModatZamaneHaml" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="زمان آمادگی برای شروع عملیات:" runat="server" ID="lblZamaneAmadegiBarayeShoorooeAmaliyat" />
        <dnn:Label runat="server" ID="lblZamaneAmadegiBarayeShoorooeAmaliyatValue" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " runat="server" Text="گزارش عملیات و ردیابی محموله به صورت روزانه و منظم ارائه می گردد:" ID="lblIsGozareshAmaliyat" />
        <dnn:Label runat="server" ID="lblIsGozareshAmaliyatValue" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblGeymateKol" Text="قیمت کل:" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymateKolValue" runat="server"></dnn:Label>
    </div>
</asp:Panel>
<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryZadghanShenasnameTitle" Visible="False">
    <br />
    <br />

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ استعلام زدغن" ID="lblReplyToInquiryZadghanShenasnameTitle" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="نوع و تعداد وسیله حمل:" ID="lblNoVaTedadeVasileyeHaml" runat="server"></dnn:Label>
        <dnn:Label ID="lblNoVaTedadeVasileyeHamlValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label Text="کرایه پیشنهادی:" ID="lblKerayeyePishnahadi" runat="server"></dnn:Label>
        <dnn:Label ID="lblKerayeyePishnahadiValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmit" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>
<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryZadghalShenasnameTitle" Visible="False">
    <br />
    <br />

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ استعلام زدغل" ID="lblReplyToInquiryZadghalShenasnameTitle" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="نوع و تعداد وسیله حمل با قیمت:" ID="lblNoVaTedadeVasileyeHamlZadghal" runat="server"></dnn:Label>
        <dnn:Label ID="lblNoVaTedadeVasileyeHamlZadghalValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitZadghal" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>
<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryZabanShenasnameTitle" Visible="False">
    <br />
    <br />
    <div class="dnnFormItem">
        <div class="dnnFormItem">
            <dnn:Label Text="شناسنامه پاسخ استعلام زبن" ID="lblReplyToInquiryZabanShenasnameTitle" runat="server"></dnn:Label>
        </div>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="عودت کانتینر خالی:" ID="lblIsOdateContinereKhali" runat="server"></dnn:Label>
        <dnn:Label ID="lblIsOdateContinereKhaliValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="استعلام بر اساس:" ID="lblBarasaseZadghan" runat="server"></dnn:Label>
        <dnn:Label ID="lblBarasaseValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="جزئیات:" ID="lblBarasaseJoziyat" runat="server"></dnn:Label>
        <dnn:Label ID="lblBarasaseJoziyatValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت کل بر اساس لیست عدل بندی:" ID="lblGeymateKolBarAsaseListeAdlBandi" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymateKolBarAsaseListeAdlBandiValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتسای هزینه تخلیه در محل:" ID="lblIsTakhliyeDarMahal" runat="server"></dnn:Label>
        <dnn:Label ID="lblIsTakhliyeDarMahalValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitZaban" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>
<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryTkShenasnameTitle" Visible="False">
    <br />
    <br />
    <div class="dnnFormItem">
        <div class="dnnFormItem">
            <dnn:Label Text="شناسنامه پاسخ استعلام رل" ID="lblReplyToInquiryTkShenasnameTitle" runat="server"></dnn:Label>
        </div>
        <div class="dnnFormItem">
            <dnn:Label Text="قیمت کل بر اساس لیست عدل بندی:" ID="lblGeymateKolBarAsaseListeAdlBandiRl" runat="server"></dnn:Label>
            <dnn:Label ID="lblGeymateKolBarAsaseListeAdlBandiRlValue" runat="server"></dnn:Label>
        </div>
        <div class="dnnFormItem">
            <dnn:Label Text="با احتسای هزینه تخلیه در محل:" ID="lblIsHazineyeTakhliye" runat="server"></dnn:Label>
            <dnn:Label ID="lblIsHazineyeTakhliyeValue" runat="server"></dnn:Label>
        </div>
        <div class="dnnFormItem">
            <dnn:Label Text="با احتسای هزینه بارگیری در مبدا:" ID="lblIsHazineyeBargiriDarMabda" runat="server"></dnn:Label>
            <dnn:Label ID="lblIsHazineyeBargiriDarMabdaValue" runat="server"></dnn:Label>
        </div>
        <div class="dnnFormItem">
            <ul class="dnnActions dnnClear">
                <li>
                    <asp:LinkButton ID="lnkSubmitRl" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
                </li>
            </ul>
        </div>
    </div>
</asp:Panel>
<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryDnShenasnameTitle" Visible="False">
    <br />
    <br />
    <div class="dnnFormItem">
        <div class="dnnFormItem">
            <dnn:Label Text="شناسنامه پاسخ استعلام دن" ID="lblReplyToInquiryDnShenasnameTitle" runat="server"></dnn:Label>
        </div>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت واحد و کل با جزئیات:" ID="lblGeymateVahedVaKolBajoziyat" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymateVahedVaKolBajoziyatValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب ترخیصیه در مقصد:" ID="lblIsTarkhisiyeDarMagsad" runat="server"></dnn:Label>
        <dnn:Label ID="lblIsTarkhisiyeDarMagsadValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب THC در مقصد:" ID="lblIsTHCDarMagsad" runat="server"></dnn:Label>
        <dnn:Label ID="lblIsTHCDarMagsadValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب THC در مبدا:" ID="lblIsTHCDarMabda" runat="server"></dnn:Label>
        <dnn:Label ID="lblIsTHCDarMabdaValue" runat="server"></dnn:Label>
    </div>


    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitDn" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>

<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryDlShenasnameTitle" Visible="False">
    <br />
    <br />
    <div class="dnnFormItem">
        <div class="dnnFormItem">
            <dnn:Label Text="شناسنامه پاسخ استعلام دل" ID="lblReplyToInquiryDlShenasnameTitle" runat="server"></dnn:Label>
        </div>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت واحد و کل با جزئیات:" ID="lblGeymateVahedVaKolBajoziyatDl" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymateVahedVaKolBajoziyatDlValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب ترخیصیه در مقصد:" ID="lblIsTarkhisiyeDarMagsadDl" runat="server"></dnn:Label>
        <dnn:Label ID="lblIsTarkhisiyeDarMagsadDlValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <dnn:Label Text="استعلام بر اساس:" ID="lblBarAsaseDl" runat="server"></dnn:Label>
        <dnn:Label ID="lblBarAsaseDlValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب THC در مقصد:" ID="lblIsTHCDarMagsadDl" runat="server"></dnn:Label>
        <dnn:Label ID="lblIsTHCDarMagsadDlValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitDl" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>



<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryZDFShenasname" Visible="False">
    <br />
    <br />
    <div class="dnnFormItem">
        <div class="dnnFormItem">
            <dnn:Label Text="شناسنامه پاسخ استعلام زدف" ID="Label1" runat="server"></dnn:Label>
        </div>
    </div>

    <div class="dnnFormItem" style="display: none">
        <dnn:Label Text="کرایه پیشنهادی:" ID="lblKerayeyePishnahadiZDF" runat="server"></dnn:Label>
        <dnn:Label ID="lblKerayeyePishnahadiZDFValue" runat="server"></dnn:Label>
    </div>


    <div class="dnnFormItem">
        <dnn:Label Text="موقعیت تحویل دادن:" ID="lblMogeiyateTahvilDaddanZDF" runat="server"></dnn:Label>
        <dnn:Label ID="lblMogeiyateTahvilDaddanZDFValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <dnn:Label Text="استعلام بر اساس:" ID="lblBarasaseZDF" runat="server"></dnn:Label>
        <dnn:Label ID="lblBarasaseZDFValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <dnn:Label Text="قیمت با جزئیات:" ID="lblGeymatBaJoziyatZDF" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymatBaJoziyatZDFValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitZDF" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>

<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryDghcoShenasname" Visible="False">
    <br />
    <br />

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ استعلام دغک" ID="Label2" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="بارگیری روی کشتی در مبدا:" ID="IsBargiriRooyeKasshidarMabda" runat="server"></dnn:Label>
        <dnn:Label ID="IsBargiriRooyeKasshidarMabdaValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب هزینه تخیله در بندر مقصد:" ID="lblEmptyingChargesDghco" runat="server"></dnn:Label>
        <dnn:Label ID="lblEmptyingChargesDghcoValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب اخذ ترخیصیه در مقصد:" ID="IsTarkhisiyeDarMagsad" runat="server"></dnn:Label>
        <dnn:Label ID="IsTarkhisiyeDarMagsadValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت کل بر اساس لیست عدلبندی:" ID="lblGeymateKolAdlBandiDghco" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymateKolAdlBandiDghcoValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت کل:" ID="lblGeymateKolDghco" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymateKolDghcoValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitDghco" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>

<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryHlShenasname" Visible="False">
    <br />
    <br />

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ استعلام هل" ID="Label3" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت کل بر اساس لیست عدلبندی:" ID="Label10" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymateKolBarAsaseListeAdlBandiHl" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت کل:" ID="lblGeymateKolHl" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymateKolHlValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitHl" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>

<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryTjShenasname" Visible="False">
    <br />
    <br />

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ استعلام هل" ID="Label4" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت کل بر اساس لیست عدلبندی:" ID="lblGeymateKolBarAsaseListeAdlBandiTj" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymateKolBarAsaseListeAdlBandiTjValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="حمل به وسیله:" ID="lblHamlBeVasileye" runat="server"></dnn:Label>
        <dnn:Label ID="lblHamlBeVasileyeValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت کل:" ID="lblGeymateKolTj" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymateKolTjValue" runat="server"></dnn:Label>
    </div>

    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitTj" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>

<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryTkShenasname" Visible="False">
    <br />
    <br />

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ استعلام تک" ID="Label5" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="نوع و تعداد وسیله حمل با جزئیات:" ID="Label6" runat="server"></dnn:Label>
        <dnn:Label ID="lblNoVaTedadeVasileyeHamlBajoziyatTkValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="انجام به وسیله:" ID="Label8" runat="server"></dnn:Label>
        <dnn:Label ID="lblHamlBeVasileyeValueTk" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label Text="قیمت پیشنهادی:" ID="lblGeymatePishnahadiTk" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymatePishnahadiTkValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitTk" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>

<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryTsShenasname" Visible="False">
    <br />
    <br />

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ استعلام تک" ID="Label7" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت:" ID="Label9" runat="server"></dnn:Label>
        <asp:HyperLink Text="در یافت فرم پاسخ قیمت تخلیه سنگین" NavigateUrl="/Portals/0/EHaml/Templates/P_Gh_T_S.xlsx" runat="server"
                       resourcekey="hplFormePasokheGeymate" ID="hplFormePasokheGeymate"></asp:HyperLink>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="انجام به وسیله:" ID="Label12" runat="server"></dnn:Label>
        <dnn:Label ID="lblAnjameAmaliyatBeVasileyeValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitTs" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>

<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryTrShenasname" Visible="False">
    <br />
    <br />

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ استعلام تک" ID="Label11" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت کل عملیات:" ID="Label14" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymateKoleAmaliyatValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="موقعیت تحویل دادن:" ID="lblMogeiyateTahvilDaddanTr" runat="server"></dnn:Label>
        <dnn:Label ID="lblMogeiyateTahvilDaddanTrValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="موقعیت تحویل دادن:" ID="lblMogeiyateTahvilGereftanTr" runat="server"></dnn:Label>
        <dnn:Label ID="lblMogeiyateTahvilGereftanTrValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitTr" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>

<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryChandVajhiSabokShenasname" Visible="False">
    <br />
    <br />

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ استعلام ایکس" ID="Label13" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت کل:" ID="Label15" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymateKoleChandVajhiSabokValue" runat="server"></dnn:Label>
    </div>
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
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitChandVajhiSabok" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>

<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryChandVajhiSanginShenasname" Visible="False">
    <br />
    <br />

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ استعلام ایکس" ID="Label16" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت کل:" ID="Label18" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymateKoleChandVajhiSanginValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب THC در مبداء:" ID="Label20" runat="server"></dnn:Label>
        <dnn:Label ID="lblIsTHCDarMabdaChandVajhiSanginValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب بیمه مسئولیت در طول مسیر:" ID="Label21" runat="server"></dnn:Label>
        <dnn:Label ID="lblBaEhtesabeBimeValueSangin" runat="server"></dnn:Label>
    </div>
    <%--    <div class="dnnFormItem">
        <dnn:Label Text="امکان استریپ کردن(خالی کردن محمولات از کانتینر قبل از مقصد نهایی) کانتینر وجود دارد:" ID="Label21" runat="server"></dnn:Label>
        <dnn:Label ID="lblStripValueSangin" runat="server"></dnn:Label>
    </div>--%>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب هزینه بارگیری کانتینر/غیرکانتینر در مبداء:" ID="Label22" runat="server"></dnn:Label>
        <dnn:Label ID="lblBaHazineyeBargiriValueSangin" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب هزینه ترخیص در مبدا:" ID="Label24" runat="server"></dnn:Label>
        <dnn:Label ID="lblHazineyeTarkhisDarMabdaValueSangin" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب THC درمقصد:" ID="Label26" runat="server"></dnn:Label>
        <dnn:Label ID="lblTHCDarMabdaValueSangin" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب کلیه هزینه های بندری ،مرزی،گمرکی و عملیاتی بین مسیر:" ID="Label28" runat="server"></dnn:Label>
        <dnn:Label ID="lblHazinehayeBandariValueSangin" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب اخذ ترخیصیه در مقصد:" ID="Label29" runat="server"></dnn:Label>
        <dnn:Label ID="lblAkhseTarkhisiyeDarMagsadValueSangin" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب هزینه تخلیه در مقصد:" ID="Label30" runat="server"></dnn:Label>
        <dnn:Label ID="lblTakhliyeDarMagsadValueSangin" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="با احتساب هزینه عودت کانتینر خالی به کشتیرانی:" ID="Label32" runat="server"></dnn:Label>
        <dnn:Label ID="lblOdatContinerValueSangin" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitChandVajhiSangin" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>

<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlReplyToInquiryBazdidShenasname" Visible="False">
    <br />
    <br />

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ استعلام تک" ID="Label34" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="قیمت کل عملیات:" ID="Label36" runat="server"></dnn:Label>
        <dnn:Label ID="lblGeymateKolBazdidValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitBazdid" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>

<asp:Panel CssClass="dnnForm ReplyToInquiryShenasname" runat="server" ID="pnlHs" Visible="False">
    <br />
    <br />
    Amazing Logo goes here! WTH

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ استعلام هس" ID="Label38" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="فایل قیمت تخلیه سنگین:" ID="Label39" runat="server"></dnn:Label>
        <asp:HyperLink CssClass="dnnSecondaryAction" Text="در یافت فرم پاسخ قیمت تخلیه سنگین" NavigateUrl="/Portals/0/EHaml/Templates/P_Gh_T_S.xlsx" runat="server"
                       resourcekey="hplFormePasokheGeymate" ID="hplFormePasokheGeymateHs"></asp:HyperLink>
    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkHsSubmit" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>

<div id="logoForPrint" class="logoForPrint" runat="server" visible="False">
    <img src="/Portals/0/Logo.png"/>
</div>

<script>
    $(document).ready(function() {

        if ($(".logoForPrint").length != 0) {
            $(".pasokhdahande").hide();
            window.print();
        }

    });

    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>