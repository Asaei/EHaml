<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReplyToInquiry_ZDF.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.ReplyToInquiry_ZDF" %>

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

    function onClientSelectedChangedPasokhBarasase() {
        var cbolNoeEstelam = $find("<%= this.pasokhGooyiBarAsase.ClientID %>");
        var value = cbolNoeEstelam.get_value();

        if (value === "براساس تناژ محموله") {
            $(".barasaseTonaj").fadeIn(500);
            $(".barasaseTedadVaNoeVasileyeHaml").fadeOut(500);
        } else if (value === "براساس وسیله حمل") {
            $(".barasaseTedadVaNoeVasileyeHaml").fadeIn(500);
            $(".barasaseTonaj").fadeOut(500);
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
<asp:Panel runat="server" ID="pnlMessageForNotSubscribeUser" Visible="False">
    <div class="MessageForNotSubscribeUser">
        <p>
            کاربر گرامی برای ارسال فرم باید طرح عضویت را خریداری نمایید. در غیر این صورت قادر به ارسال فرم نخواهید بود.
        </p>
        <asp:LinkButton runat="server" ID="lnkTasviye" Text="خرید طرح عضویت"></asp:LinkButton>
    </div>
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
            کاربر گرامی برای ارسال فرم باید به عنوان صاحب بار ثبت نام نمایید.در غیر این صورت قادر به ارسال فرم نخواهید بود.
        </p>
        <asp:LinkButton runat="server" ID="lnkExitSubscribeAvaziSUser" Text=""></asp:LinkButton>
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
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid1" Text="ارسال مجدد لینک تایید" />
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<div class="ReplyToInquiry-Dn-Shenasname dnnForm shenasnameForm">

    <div class="dnnFormItem pasokh-title">
        <dnn:label text="شناسنامه استعلام" id="lblReplyToInquiryZDFShenasnameTitle" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:label helptext=" " id="lblDarkhastKonande" text="استعلام دهنده:" runat="server"></dnn:label>
        <dnn:label helptext=" " id="lblDarkhastKonandeValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem"  style="display: none">
        <dnn:label helptext=" " id="lblSherkat" text="نام شرکت:" runat="server"></dnn:label>
        <dnn:label id="lblSherkatValue" runat="server"></dnn:label>
    </div>

    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblIsReallyNeed" text="ماهیت استعلام:" runat="server"></dnn:label>
        <dnn:label id="lblIsReallyNeedValue" runat="server"></dnn:label>
    </div>

    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblZamaneEstelam" text="زمان استعلام:" runat="server"></dnn:label>
        <dnn:label id="lblZamaneEstelamValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblTarihkeEngeza" text="تاریخ انقضاء" runat="server"></dnn:label>
        <dnn:label id="lblTarihkeEngezaValue" runat="server"></dnn:label>
    </div>

    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblAkharinZamaneTagireEstelam" text="آخرین زمان تغییر استعلام:" runat="server"></dnn:label>
        <dnn:label id="lblAkharinZamaneTagireEstelamValue" runat="server"></dnn:label>
    </div>

    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblIsExtend" text="تمدید شده:" runat="server"></dnn:label>
        <dnn:label id="lblIsExtendValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:label helptext=" " id="lblIsTender" text="استعلام به صورت مناقصه میباشد؟" runat="server"></dnn:label>
        <dnn:label id="lblIsTenderValue" runat="server"></dnn:label>
    </div>

    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblStartingPoint" text="مبدا:" runat="server"></dnn:label>
        <dnn:label id="lblStartingPointValue" runat="server"></dnn:label>
    </div>

    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblMagsad" text="مقصد:" runat="server"></dnn:label>
        <dnn:label id="lblMagsadValue" runat="server"></dnn:label>
    </div>

    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblActionDate" text="تاریخ آغاز عملیات:" runat="server"></dnn:label>
        <dnn:label id="lblActionDateValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblHSCodeSh" text="کد HS:" runat="server"></dnn:label>
        <dnn:label id="lblHSCodeShValue" runat="server"></dnn:label>
    </div>
    <%--<div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblNoVaTedadeVaJoziyat" Text="نوع و تعداد و جزئیات:" runat="server"></dnn:Label>
        <dnn:Label HelpText=" " ID="lblNoVaTedadeVaJoziyatValue" runat="server"></dnn:Label>
    </div>--%>
    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblNamVaNoeMahmoole" text="نام و نوع محموله:" runat="server"></dnn:label>
        <dnn:label id="lblNamVaNoeMahmooleValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblNoeBastebandi" text="نوع بسته بندی:" runat="server"></dnn:label>
        <dnn:label id="lblNoeBastebandiValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblVazneKoleMahmoole" text="وزن کل محموله(کیلوگرم):" runat="server"></dnn:label>
        <dnn:label id="lblVazneKoleMahmooleValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblMogeiyateTahvilDadan" text="موقعیت تحویل دادن:" runat="server"></dnn:label>
        <dnn:label id="lblMogeiyateTahvilDadanValue" runat="server"></dnn:label>
    </div>

    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <a id="lnkReply" class="dnnPrimaryAction">پاسخ به استعلام</a>
            </li>
        </ul>
    </div>
</div>

<div class="ReplyToInquiry-Zadghal-Reply-Form ZDFRepForm dnnForm formPasokh">
    <div class="dnnFormItem pasokh-title">
        <dnn:label id="lblReplyToInquiryZadghalTitle" runat="server" text="پاسخ به استعلام"></dnn:label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:label helptext=" " id="lblPasokhDahande" text="پاسخ دهنده:" runat="server"></dnn:label>
        <dnn:label id="lblPasokhDahandeValue" runat="server"></dnn:label>
    </div>
    <%--    <div class="dnnFormItem">--%>
    <%--        <dnn:Label HelpText=" " ID="lblGeymatePishnahadi" Text="قیمت پیشمهادی:" runat="server" ></dnn:Label>--%>
    <%--        <asp:TextBox ID="txtGeymatePishnahadi" runat="server" ToolTip=""></asp:TextBox>--%>
    <%--    </div>--%>
    <div class="dnnFormItem">
        <dnn:label helptext=" " text="موقعیت تحویل دادن محموله به پیمانکار حمل:" runat="server" id="Label1" cssclass="dnnFormRequired" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolMogeiyateTahvilDadan" />
    </div>
    <%--    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="کرایه پیشنهادی:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtKerayeyePishnahadi" runat="server"></asp:TextBox>
    </div>--%>

    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="پاسخ گویی بر اساس:" runat="server" ID="lblPasokhgooyi" CssClass="dnnFormRequired"></dnn:Label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" onclientselectedindexchanged=" onClientSelectedChangedPasokhBarasase " runat="server" id="pasokhGooyiBarAsase" />
    </div>

    <div class="barasaseTedadVaNoeVasileyeHaml">
        <asp:Repeater ID="rptNoeVaTedadeVasileyeHaml" runat="server">
            <ItemTemplate>
                <div class="dnnFormItem" style="display: none">
                    <dnn:label helptext=" " text='<%# Eval("VasileyeHamlName").ToString() %>' runat="server"></dnn:label>
                </div>
                <div class="dnnFormItem">
                    <dnn:label helptext=" " id="lblTedad" text='<%# Eval("VasileyeHamlName").ToString() + "-تعداد دستگاه:" %>' runat="server"></dnn:label>
                    <asp:TextBox ID="txtTedad" data-dastgah='<%# Eval("VasileyeHamlName") %>' CssClass="priceItem_Tedad_T2" runat="server" ToolTip="تعداد" ValidationGroup='<%# Eval("VasileyeHamlName").ToString() %>'></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn:label helptext=" " id="lblGeymateVahed" text='<%# Eval("VasileyeHamlName").ToString() + "-قیمت واحد:" %>' runat="server"></dnn:label>
                    <asp:TextBox ID="txtGeymateVahed" data-dastgah='<%# Eval("VasileyeHamlName") %>' CssClass="priceItem_Geymat_T2" runat="server" ToolTip="قیمت واحد:" ValidationGroup='<%# Eval("VasileyeHamlName").ToString() %>'></asp:TextBox>
                </div>
                <div class="dnnFormItem" style="display: none">
                    <dnn:label helptext=" " id="lblGeymateKol" text='<%# Eval("VasileyeHamlName").ToString() + "-قیمت کل:" %>' runat="server"></dnn:label>
                    <asp:TextBox CssClass="priceItem" ID="txtGeymateKol" runat="server" ToolTip="قیمت کل:"></asp:TextBox>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>


    <%--    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblVazneKol" Text="وزن کل محموله:" runat="server" ></dnn:Label>
        <dnn:Label HelpText=" " ID="lblVazneKolValue" runat="server" ></dnn:Label>
    </div>--%>
    <div class="barasaseTonaj">
        <div class="dnnFormItem">
            <dnn:label helptext=" " id="lblGeymateHarTon" text="قیمت به ازای هر تن:" runat="server"></dnn:label>
            <asp:TextBox ID="txtGeymateHarTon" runat="server" ToolTip="قیمت هر تن:"></asp:TextBox>
        </div>
    </div>

    <div class="dnnFormItem" style="display: none">
        <dnn:label helptext=" " id="lblGeymateKol" text="قیمت کل:" runat="server"></dnn:label>
        <asp:TextBox ID="txtGeymateKolTon" runat="server" ToolTip="قیمت کل:"></asp:TextBox>
    </div>



    <div class="dnnFormItem">
        <dnn:label helptext=" " text="کل مدت زمان حمل(روز):" runat="server"></dnn:label>
        <asp:TextBox ID="txtModatRooz" runat="server" />
    </div>

    <div class="dnnFormItem">
        <dnn:label helptext=" " text="زمان آمادگی برای شروع عملیات:" runat="server" id="lblZamaneAmadegiBarayeShoorooeAmaliyat" />
        <dnn:dnndatepicker runat="server" id="dtpZamaneAmadegiBarayeShoorooeAmaliyat" />
    </div>

    <div class="dnnFormItem">
        <dnn:label helptext=" " text="گزارش عملیات:" runat="server"></dnn:label>
        <asp:CheckBox runat="server" Text="گزارش عملیات و ردیابی محموله به صورت روزانه و منظم ارائه می گردد:" ID="chkIsGozareshAmaliyat" />
    </div>

    <div class="dnnFormItem ">
        <span class="full-line textAfterTheButton">با توجه به شرایط موجود( از قبیل شرایط مسیر،شرایط آب و هوایی،در دسترس بودن وسیله مورد نیاز و غیره ) امکان پذیری عملیات به این صورت پیش بینی می گردد:" </span>
    </div>
    <div class="dnnFormItem fromtop20">
        <dnn:label helptext=" " id="lblPishbini" text="پیش بینی:" runat="server"></dnn:label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolPishbini" cssclass="dnnFixedSizeComboBox" />
    </div>

    <div class="dnnFormItem">
        <dnn:label helptext=" " text="قیمت کل:" runat="server"></dnn:label>
        <asp:TextBox CssClass="geymateKol" ID="txtGeymateKol" runat="server" Enabled="False"></asp:TextBox>
        <asp:RequiredFieldValidator ControlToValidate="txtGeymateKol" runat="server" ValidationGroup="FormValidation" 
                                    ErrorMessage="محاسبه قیمت کل الزامی است.لطفآ برروی دکمه محاسبه قیمت کلیک نمایید."></asp:RequiredFieldValidator>
        <a class="dnnSecondaryAction" onclick=" CalcultePrice(); ">محاسبه قیمت</a>
    </div>

    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmit" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" Text="ارسال:" />
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
            $(".formPasokh").fadeIn(500);
        });

        if ($(".logoForPrint").length != 0) {
            $("#lnkReply").hide();
            window.print();
        }
    });


    function CalcultePrice() {
        $(".geymateKol").val(mohasebegheymatForZADAF());
    };

    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>