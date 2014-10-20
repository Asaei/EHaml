<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReplyToInquiry_Hs.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.ReplyToInquiry_Hs" %>
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
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid1" Text="ارسال مجدد لینک تایید" />
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<asp:Panel Visible="False" runat="server" ID="messageGeneral">
    <div class="MessageForBedehkarUser">کاربر گرامی ارسال فایل اکسل الزامی میباشد. لطفآ فایل اکسل را بارگزاری نمایید.</div>
</asp:Panel>
<div class="ReplyToInquiry-Ts-Shenasname shenasnameForm dnnForm">
    <div class="dnnFormItem pasokh-title">
        <dnn:label text="شناسنامه استعلام" id="lblReplyToInquiryDghcoShenasnameTitle" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:label HelpText=" " id="lblDarkhastKonande" text="استعلام دهنده:" runat="server"></dnn:label>
        <dnn:label id="lblDarkhastKonandeValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:label HelpText=" " id="lblSherkat" text="نام شرکت:" runat="server"></dnn:label>
        <dnn:label id="lblSherkatValue" runat="server"></dnn:label>
    </div>

    <div class="dnnFormItem">
        <dnn:label HelpText=" " id="lblIsReallyNeed" text="ماهیت استعلام:" runat="server"></dnn:label>
        <dnn:label id="lblIsReallyNeedValue" runat="server"></dnn:label>
    </div>

    <div class="dnnFormItem">
        <dnn:label HelpText=" " id="lblZamaneEstelam" text="زمان استعلام:" runat="server"></dnn:label>
        <dnn:label id="lblZamaneEstelamValue" runat="server"></dnn:label>
    </div>

    <div class="dnnFormItem">
        <dnn:label HelpText=" " id="lblTarihkeEngeza" text="تاریخ انقضاء" runat="server"></dnn:label>
        <dnn:label  id="lblTarihkeEngezaValue" runat="server"></dnn:label>
    </div>

    <div class="dnnFormItem">
        <dnn:label HelpText=" " id="lblAkharinZamaneTagireEstelam" text="آخرین زمان تغییر استعلام:" runat="server"></dnn:label>
        <dnn:label  id="lblAkharinZamaneTagireEstelamValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:label HelpText=" " id="lblIsExtend" text="تمدید شده:" runat="server"></dnn:label>
        <dnn:label  id="lblIsExtendValue" runat="server"></dnn:label>
    </div>

    <div class="dnnFormItem">
        <dnn:label HelpText=" " id="lblStartingPoint" text="مبدا:" runat="server"></dnn:label>
        <dnn:label  id="lblStartingPointValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:label HelpText=" " id="lblDestinationPoint" text="مقصد:" runat="server"></dnn:label>
        <dnn:label  id="lblDestinationPointValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:label HelpText=" " id="lblBaehtesabeBargiriDarMabda" text="با احتساب بار گیری در مبدا:" runat="server"></dnn:label>
        <dnn:label  id="lblBaehtesabeBargiriDarMabdaValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:label HelpText=" " id="lblBaehtesabeTakhliyeDarMagsad" text="با احتساب هزینه تخلیه در مقصد:" runat="server"></dnn:label>
        <dnn:label  id="lblBaehtesabeTakhliyeDarMagsadValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:label HelpText=" " id="lblBaEhtesabeBimeyeMasooliyat" text="با احتساب بیمه مسئولیت:" runat="server"></dnn:label>
        <dnn:label  id="lblBaEhtesabeBimeyeMasooliyatValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:label HelpText=" " id="lblFileArzesheMahsoolat" text="فایل ارزش محصولات:" runat="server"></dnn:label>
        <asp:HyperLink CssClass="dnnSecondaryAction" runat="server" ID="lblFileArzesheMahsoolatValue"></asp:HyperLink>
    </div>
    <div class="dnnFormItem">
        <dnn:label HelpText=" " id="lblFileListeAdlBandi" text="فایل لیست عدلبندی:" runat="server"></dnn:label>
        <asp:HyperLink CssClass="dnnSecondaryAction" runat="server" ID="hplFileListeAdlBandi"></asp:HyperLink>
    </div>
    <div class="dnnFormItem">
        <dnn:label HelpText=" " id="Label8" text="فایل عکس محصولات:" runat="server"></dnn:label>
        <asp:HyperLink CssClass="dnnSecondaryAction" Text="فایل عکس محصولات" runat="server" ID="hplPicture"></asp:HyperLink>
    </div>
    <div class="dnnFormItem">
        <dnn:label HelpText=" " id="lblActionDate" text="تاریخ آغاز عملیات:" runat="server"></dnn:label>
        <dnn:label  id="lblActionDateValue" runat="server"></dnn:label>
    </div>

    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <a id="lnkReply" class="dnnPrimaryAction">پاسخ به استعلام</a>
            </li>
        </ul>
    </div>
</div>
<div class="ReplyToInquiry-Hs-Reply-Form dnnForm formPasokh frmpasokhHs" style="display: none">
    <div class="dnnFormItem pasokh-title">
        <dnn:label  ID="lblReplyToInquiryDlTitle" runat="server" Text="پاسخ به استعلام"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:label HelpText=" "  ID="lblPasokhDahande" Text="پاسخ دهنده:" runat="server"></dnn:Label>
        <dnn:label   ID="lblPasokhDahandeValue" runat="server"></dnn:Label>
    </div>
    
    <div class="InquiryTs-Form-ListeAdlBandi dnnFormItem">
        <dnn:label HelpText=" "  ID="Label1" Text="فرم پاسخ قیمت حمل سنگین:" runat="server"></dnn:Label>
        <span style="margin-top: 5px"><asp:HyperLink Text="در یافت فرم پاسخ حمل سنگین" NavigateUrl="/Portals/0/EHaml/Templates/P_Gh_H_S.xlsx" runat="server" 
                                                     resourcekey="hplFormePasokheGeymate" ID="hplFormePasokheGeymate"></asp:HyperLink></span>


        <asp:FileUpload ID="fupFormePasokheGeymate" runat="server" resourcekey="fupFormePasokheGeymate" />

        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvFupFormePasokheGeymate"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="fupFormePasokheGeymate"
                                    resourcekey="ErrorMessage" />

        <%--        <asp:RegularExpressionValidator ValidationGroup="FormValidation" ID="revFupFormePasokheGeymate" runat="server" --%>
        <%--                                        ErrorMessage="فقط فایل با پسوند xlsx مجاز می باشد!"--%>
        <%--                                        ControlToValidate="fupFormePasokheGeymate"--%>
        <%--                                        ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.(xlsx|XLSX)$"--%>
        <%--                                        CssClass="dnnFormMessage dnnFormError"></asp:RegularExpressionValidator>--%>

    </div>
    
    <div class="dnnFormItem fromtop20">
        <dnn:label HelpText=" "  ID="Label3" Text="کل مدت زمان حمل(روز):" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtModatRooz" runat="server"/>
        <%--        <dnn:label HelpText=" " HelpText=" " ID="Label4" Text="ساعت:" runat="server" ></dnn:Label>
        --%>
    </div>

    <div class="dnnFormItem">
        <dnn:label HelpText=" " Text="زمان آمادگی برای شروع عملیات:" runat="server" ID="lblZamaneAmadegiBarayeShoorooeAmaliyat"/>
        <dnn:DnnDatePicker runat="server" ID="dtpZamaneAmadegiBarayeShoorooeAmaliyat"/>
    </div>
    
    <div class="dnnFormItem ">
        <span class="full-line textAfterTheButton">با توجه به شرایط موجود( از قبیل شرایط مسیر،شرایط آب و هوایی،در دسترس بودن وسیله مورد نیاز و غیره ) امکان پذیری عملیات به این صورت پیش بینی می گردد:" </span>
    </div>
    <div class="dnnFormItem fromtop20">
        <dnn:label HelpText=" "  ID="lblPishbini" Text="پیش بینی:" runat="server" ></dnn:Label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolPishbini"/>
    </div>
   
    <div class="dnnFormItem" style="display: none">
        <dnn:label HelpText=" "  ID="Label5" Text="قیمت کل:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtGeymateKol" runat="server"></asp:TextBox>
        <%--                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtGeymateKol" ValidationGroup="FormValidation" --%>
        <%--                                    ErrorMessage="محاسبه قیمت کل الزامی است.لطفآ برروی دکمه محاسبه قیمت کلیک نمایید."></asp:RequiredFieldValidator>--%>
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
    }


    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>