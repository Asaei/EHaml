<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReplyToElamiyeShenasname.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_ElamiyeDashboard.ReplyToElamiyeShenasname" %>
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
<asp:Panel runat="server" ID="pnlMessageForBedehkarUser" Visible="False">
    <div class="MessageForBedehkarUser">
        <p>
            کاربر گرامی مهلت فعالیت شما در حالت بدهکاری پایان یافته ، برای ارسال فرم می بایست تسویه نمایید.
        </p>
        <a href="/default.aspx?tabid=<%= PortalController.GetPortalSettingAsInteger("TasviyeTabId", PortalId, -1) %>&type=1&FinalReturnTabId=<%= TabId %>">تسویه حساب</a>
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
                                                                                                                                                                                                                                          <asp:Button runat="server" ID="btnErsaleLinkTaeid1" Text="ارسال مجدد لینک تایید"/>
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<asp:Panel CssClass="dnnForm" runat="server" ID="ReplyToElamiyeEshterakatShenasname" Visible="True">
    <div class="dnnFormItem">
        <dnn:Label ID="lblPasokhDahande" Text="پاسخ دهنده:" runat="server"></dnn:Label>
        <dnn:Label ID="lblPasokhDahandeValue" runat="server"></dnn:Label>
    </div>
    <%--    <div class="dnnFormItem">
        <dnn:Label ID="lblGeymateKol" Text="قیمت کل:" runat="server" ></dnn:Label>
        <dnn:label ID="lblGeymateKolValue" runat="server"></dnn:label>
    </div>--%>
</asp:Panel>

<asp:Panel CssClass="dnnForm" runat="server" ID="pnlReplyToElamiyeKhaliJadeiShenasnameTitle" Visible="False">
    <br/>
    <br/>

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ اعلامیه خالی جاده ای" ID="lblReplyToElamiyeKhaliJadeiShenasnameTitle" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="نوع و تعداد وسیله حمل:" ID="lblNoVaTedadeVasileyeHaml" runat="server"></dnn:Label>
        <dnn:Label ID="lblNoVaTedadeVasileyeHamlValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmit" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>

<asp:Panel CssClass="dnnForm" runat="server" ID="pnlReplyToElamiyeKhaliReyliShenasnameTitle" Visible="False">
    <br/>
    <br/>

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ اعلامیه خالی ریلی" ID="lblReplyToElamiyeKhaliReyliShenasnameTitle" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="نوع و تعداد وسیله حمل:" ID="Label1" runat="server"></dnn:Label>
        <dnn:Label ID="lblNoVaTedadeVasileyeHamlValueReyli" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitReyli" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>
<asp:Panel CssClass="dnnForm" runat="server" ID="pnlReplyToElamiyeKhaliDaryayiShenasnameTitle" Visible="False">
    <br/>
    <br/>

    <div class="dnnFormItem">
        <dnn:Label Text="شناسنامه پاسخ اعلامیه خالی دریایی" ID="lblReplyToElamiyeKhaliDaryayiShenasnameTitle" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label Text="نوع و تعداد وسیله حمل:" ID="Label2" runat="server"></dnn:Label>
        <dnn:Label ID="Label3" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmitDaryayi" runat="server" CssClass="dnnPrimaryAction" Text="تایید:" />
            </li>
        </ul>
    </div>
</asp:Panel>