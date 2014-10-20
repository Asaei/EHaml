<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Elamiye_KhaliReyli.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Elamiye.Elamiye_KhaliReyli" %>
<%@ Register TagPrefix="dnn" TagName="Label_1" Src="~/controls/labelcontrol.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Portals" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>


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
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid11" Text="ارسال مجدد لینک تایید"/>
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<div class="ElamiyeVasileyeKhaliReyli-Form dnnForm"  id="ElamiyeVasileyeKhaliForm" runat="server">
    <div class="dnnFormItem">
        <dnn:label id="lblNoeVasile" cssclass="dnnFormRequired" runat="server" Text="نوع واگن:"></dnn:label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolNoeVasileVagon" />
        <asp:CompareValidator runat="server" ID="cvCbolIsReallyNeed" ValidationGroup="FormValidation"
                              CssClass="dnnFormMessage dnnFormError" Type="String" Operator="NotEqual" ControlToValidate="cbolNoeVasileVagon"
                              ValueToCompare="-- انتخاب نمایید --" resourcekey="ErrorMessage" Display="Dynamic"></asp:CompareValidator>
    </div>

    <div class="dnnFormItem">
        <dnn:Label ID="lblTedad" cssclass="dnnFormRequired" Text="تعداد:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtTedad" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator4"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="txtTedad"
                                    ErrorMessage="" />
    </div>

    <div class="dnnFormItem">
        <dnn:Label cssclass="dnnFormRequired" ID="lblMabda" Text="مبدا:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtMabda" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rptMabda"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="txtMabda"
                                    ErrorMessage="" />
    </div>

    <div class="dnnFormItem">
        <dnn:Label cssclass="dnnFormRequired" ID="lblMagsad" Text="مقصد:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtMagsad" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rptMagsad"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="txtMagsad"
                                    ErrorMessage="" />
    </div>

    <div class="dnnFormItem">
        <dnn:Label ID="lblMasir" cssclass="dnnFormRequired" Text="مسیر:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtMasir" cssclass="dnnFormRequired" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator3" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="txtMasir" resourcekey="ErrorMessage" />
    </div>

    <div class="dnnFormItem">
        <dnn:Label ID="lblZamaneHarakat" cssclass="dnnFormRequired" Text="زمان حرکت:" runat="server" ></dnn:Label>
        <dnn:DnnDatePicker runat="server" ID="dtpZamaneAmadegi"></dnn:DnnDatePicker>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator2" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="dtpZamaneAmadegi" resourcekey="ErrorMessage" />
    </div>

    <div class="dnnFormItem">
        <dnn:Label cssclass="dnnFormRequired"  ID="lblExpireDate" Text="تاريخ اعتبار:" runat="server" ></dnn:Label>
        <dnn:DnnDatePicker runat="server" ID="dtpExpireDate"></dnn:DnnDatePicker>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator1" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="dtpZamaneAmadegi" resourcekey="ErrorMessage" />
        
        <asp:CompareValidator runat="server" ID="cvDtpExpiredate" ValidationGroup="FormValidation"
                              CssClass="dnnFormMessage dnnFormError" Type="Date" Operator="LessThanEqual" ControlToValidate="dtpExpiredate"
                              ControlToCompare="dtpZamaneAmadegi" resourcekey="ExpireDateGreaterThanActionDateErrorMessage" Display="Dynamic"></asp:CompareValidator>
    </div>
    
    <div class="dnnFormItem" style="display: none">
        <asp:CheckBox runat="server" Text="خواهان ارسال اعلامیه خود برای شرکت های خارج از ایران(غیر ایرانی) هستم." ID="chkKhahaneErsalBeKharej"/>
    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmit" Text="ارسال" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" resourcekey="lnkSubmit" />
            </li>
        </ul>
    </div>
</div>

<div id="pnlmessageSubmit" class="dnnFormMessage dnnFormSuccess" runat="server" Visible="False" >
    اعلامیه شما با موفقیت ثبت شد.جهت پیگیری وضعیت اعلامیه به میز کار خود مراجعه نمایید.
    <br>
    <a class="dnnPrimaryAction" style="margin-top: 15px;" href="/Activity-Feed.aspx">میزکار</a>
</div> 

<script>
    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>