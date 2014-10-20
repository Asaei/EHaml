<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReplyToElamiye_KhaliReyli.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Elamiye.ReplyToElamiye_KhaliReyli" %>
<%@ Register TagPrefix="dnn" TagName="Label_1" Src="~/controls/labelcontrol.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Portals" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>


<script>
    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>
<asp:Panel runat="server" ID="pnlMessageForNotSubscribeAvaziKUser" Visible="False">
    <div class="MessageForNotSubscribeUser">
        <p>
            کاربر گرامي براي ارسال فرم بايد به عنوان خدمت گزار ثيت نام نماييد.در غير اين صورت قادر به ارسال فرم نخواهيد بود.
        </p>
        <asp:LinkButton runat="server" ID="lnkExitSubscribeAvaziKUser" Text=""></asp:LinkButton>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="pnlMessageForNotSubscribeAvaziSUser" Visible="False">
    <div class="MessageForNotSubscribeUser">
        <p>
            کاربر گرامي براي ارسال فرم بايد به عنوان صاحب بار ثبت نام نماييد.در غير اين صورت قادر به ارسال فرم نخواهيد بود.
        </p>
        <asp:LinkButton runat="server" ID="lnkExitSubscribeAvaziSUser" Text=""></asp:LinkButton>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="pnlMessageForNotSubscribeUser" Visible="False">
    <div class="MessageForNotSubscribeUser">
        <p>
            کاربر گرامي براي ارسال فرم بايد طرح عضويت را خريداري نماييد. در غير اين صورت قادر به ارسال فرم نخواهيد بود.
        </p>
        <asp:LinkButton runat="server" ID="lnkTasviye" Text="خريد طرح عضويت"></asp:LinkButton>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="pnlMessageForBedehkarUser" Visible="False">
    <div class="MessageForBedehkarUser">
        <p>
            کاربر گرامي مهلت فعاليت شما در حالت بدهکاري پايان يافته ، براي ارسال فرم مي بايست تسويه نماييد.
        </p>
        <a href="/default.aspx?tabid=<%= PortalController.GetPortalSettingAsInteger("TasviyeTabId", PortalId, -1) %>&type=1&FinalReturnTabId=<%= this.TabId %>">تسويه حساب</a>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="pnlMessageForLoginNakarde" Visible="False">
    <div class="MessageForLoginNakarde">
        <p>
            کاربر گرامي شما در سايت لوگين نکرده ايد. لطفآ ابتدا در سايت لوگين کنيد.
        </p>
        <a class="RegisterClass dnnPrimaryAction" href="/ثبت-نام">ثبت نام</a>
        <a class="LoginClass dnnSecondaryAction" onclick=" voorood(); ">ورود</a>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="pnlMessageForNotApprovedAfterErsal" Visible="False"><div class="MessageAfterErsal">
                                                                                      <p>لينک فعال سازي حساب کاربري شما به ايميل تان ارسال گرديد. لطفآ ايميل خود را بررسي نماييد.</p>
                                                                                  </div></asp:Panel><asp:Panel runat="server" ID="pnlMessageForNotApproved" Visible="False">
                                                                                                        
                                                                                                        <div class="MessageForNotApproved">
                                                                                                            <p>
                                                                                                                کاربر گرامي شما هنور عضويت خود را تاييد ننمود ه ايد. براي اين کار لطفآ بر روي لينک ارسالي در ايمل خود کليک نماييد.
                                                                                                            </p>
                                                                                                            <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid1223" Text="ارسال مجدد لينک تاييد"/>
                                                                                                        </div>
                                                                                                    </asp:Panel> 



<div class="ReplyToElamiye-Shenasname dnnForm shenasnameForm shenasnameForm" runat="server" id="ElamiyeVasileyeKhaliForm0">
    <div class="dnnFormItem">
        <dnn:Label ID="lblName" Text="وسیله:" runat="server" ></dnn:Label>
        <dnn:Label ID="lblNameText" runat="server" ></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="Label1" Text="تعداد:" runat="server" ></dnn:Label>
        <dnn:Label ID="lblTedadText" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblMabda" Text="مبدا:" runat="server" ></dnn:Label>
        <dnn:Label ID="lblMabdaText" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblMagsad" Text="مقصد:" runat="server"  ></dnn:Label>
        <dnn:Label ID="lblMagsadText" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblMasireKamel" Text="مسیر کامل حرکت از مبداء اولیه به مقصد نهایی:" runat="server" ></dnn:Label>
        <dnn:Label ID="lblMasireKamelText" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblTarikheEngeza" Text="تاریخ اعتبار:" runat="server" ></dnn:Label>
        <dnn:Label runat="server" ID="lblTarikheEngezaText"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="Label2" Text="زمان حرکت:" runat="server" ></dnn:Label>
        <dnn:Label runat="server" ID="lblZamaneAmadegiText"></dnn:Label>
    </div>
</div>



<div class="ReplyToElamiye-KhaliJadei-Reply-Form dnnForm" style="margin-top: 50px;">

    <%--            <div class="dnnFormItem">
                <dnn:label id="lblName" runat="server"></dnn:label>
            </div>--%>
    <div class="dnnFormItem">
        <dnn:label CssClass="dnnFormRequired" id="lblTedad" text="تعداد:" runat="server"></dnn:label>
        <asp:TextBox ID="txtTedad" runat="server" ></asp:TextBox>
        <asp:RequiredFieldValidator  ValidationGroup="FormValidation"  ID="rfvTedad" CssClass="dnnFormMessage dnnFormError"
                                     runat="server" Display="Dynamic" ControlToValidate="txtTedad" resourcekey="ErrorMessage" />

    </div>
    <div class="dnnFormItem">
        <dnn:label CssClass="dnnFormRequired" id="lblNoeMahmoole" text="نوع محموله:" runat="server"></dnn:label>
        <asp:TextBox ID="txtNoeMahmoole" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator  ValidationGroup="FormValidation"  ID="RequiredFieldValidator1" CssClass="dnnFormMessage dnnFormError"
                                     runat="server" Display="Dynamic" ControlToValidate="txtNoeMahmoole" resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem">
        <dnn:label CssClass="dnnFormRequired" id="lblShahrMabda" text="شهر مبدا:" runat="server"></dnn:label>
        <asp:TextBox ID="txtShahrMabda" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator  ValidationGroup="FormValidation"  ID="RequiredFieldValidator2" CssClass="dnnFormMessage dnnFormError"
                                     runat="server" Display="Dynamic" ControlToValidate="txtShahrMabda" resourcekey="ErrorMessage" />

    </div>
    <div class="dnnFormItem">
        <dnn:label CssClass="dnnFormRequired" id="lblShahrMagsad" text="شهر مقصد:" runat="server"></dnn:label>
        <asp:TextBox ID="txtShahreMagsad" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator  ValidationGroup="FormValidation"  ID="RequiredFieldValidator3" CssClass="dnnFormMessage dnnFormError"
                                     runat="server" Display="Dynamic" ControlToValidate="txtShahreMagsad" resourcekey="ErrorMessage" />
    </div>
    <div class="dnnFormItem">
        <dnn:label CssClass="dnnFormRequired" id="lblZamaneAmadegi" text="زمان آمادگی:" runat="server"></dnn:label>
        <dnn:dnndatepicker runat="server" id="dtpZamaneAmadegi"></dnn:dnndatepicker>
        <asp:RequiredFieldValidator  ValidationGroup="FormValidation"  ID="RequiredFieldValidator4" CssClass="dnnFormMessage dnnFormError"
                                     runat="server" Display="Dynamic" ControlToValidate="dtpZamaneAmadegi" resourcekey="ErrorMessage" />
    </div>

    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmit" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" Text="ارسال:" />
            </li>
        </ul>
    </div>
</div>