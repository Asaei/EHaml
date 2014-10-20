<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReplyToInquiry_Bazdid.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.ReplyToInquiry_Bazdid" %>
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
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid1333" Text="ارسال مجدد لینک تایید" />
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<div class="ReplyToInquiry-Bazdid-Shenasname dnnForm shenasnameForm">
    <div class="dnnFormItem pasokh-title">
        <dnn:label text="شناسنامه استعلام" id="lblReplyToInquiryBazdidShenasnameTitle" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:label id="lblDarkhastKonande" text="استعلام دهنده:" runat="server"></dnn:label>
        <dnn:label id="lblDarkhastKonandeValue" runat="server"></dnn:label>
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
        <dnn:label id="lblFileListeAdlBandi" text="فایل لیست عدلبندی:" runat="server"></dnn:label>
        <asp:HyperLink CssClass="dnnSecondaryAction" runat="server" ID="hplFileListeAdlBandi"></asp:HyperLink>
    </div>


    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <a id="lnkReply" class="dnnPrimaryAction">پاسخ به استعلام</a>
            </li>
        </ul>
    </div>
</div>

<div class="ReplyToInquiry-Bazdid-Reply-Form dnnForm formPasokh" style="display: none">
    <div class="dnnFormItem">
        <dnn:label id="lblGeymat" text="قیمت:" runat="server"></dnn:label>
        <asp:TextBox ID="txtGeymat" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator CssClass="dnnFormMessage dnnFormError" runat="server" ControlToValidate="txtGeymat" ValidationGroup="FormValidation" 
                                    ErrorMessage="وارد نمودن این مورد الزامیست."></asp:RequiredFieldValidator>

    </div>

    <div class="dnnFormItem">
        <dnn:label id="Label2" text="کل مدت زمان حمل(روز):" runat="server"></dnn:label>
        <asp:TextBox ID="txtModatRooz" runat="server" />
        <asp:RequiredFieldValidator CssClass="dnnFormMessage dnnFormError" runat="server" ControlToValidate="txtModatRooz" ValidationGroup="FormValidation" 
                                    ErrorMessage="وارد نمودن این مورد الزامیست."></asp:RequiredFieldValidator>
        <%--        <dnn:Label ID="Label4" Text="ساعت:" runat="server" ></dnn:Label>
        --%>
    </div>

    <div class="dnnFormItem" style="display: none">
        <dnn:label id="Label5" text="قیمت کل:" runat="server"></dnn:label>
        <asp:TextBox ID="txtGeymateKol" runat="server" Enabled="False"></asp:TextBox>
    </div>

    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmit" ValidationGroup="FormValidation"
                                runat="server" CssClass="dnnPrimaryAction" Text="ارسال:" />
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

    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>