<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Elamiye_KhaliDaryayi.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Elamiye.Elamiye_KhaliDaryayi" %>
<%@ Register TagPrefix="dnn" TagName="Label_1" Src="~/controls/labelcontrol.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Portals" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>

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
            کاربر گرامي براي ارسال فرم بايد طرح عضويت به عنوان صاحب بار را خريداري نماييد. در غير اين صورت قادر به ارسال فرم نخواهيد بود.
        </p>
        <asp:LinkButton runat="server" ID="lnkTasviyeS" Text="خريد طرح عضويت"></asp:LinkButton>
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
        <a href="/default.aspx?tabid=<%= PortalController.GetPortalSettingAsInteger("TasviyeTabId", PortalId, -1) %>&type=1&FinalReturnTabId=<%= TabId %>">تسويه حساب</a>
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
<asp:Panel runat="server" ID="pnlMessageForNotApprovedAfterErsal" Visible="False"><div class="MessageAfterErsal"><p>لينک فعال سازي حساب کاربري شما به ايميل تان ارسال گرديد. لطفآ ايميل خود را بررسي نماييد.</p></div></asp:Panel><asp:Panel runat="server" ID="pnlMessageForNotApproved" Visible="False">
                                                                                                                                                                                                                                      <div class="MessageForNotApproved">
                                                                                                                                                                                                                                          <p>
                                                                                                                                                                                                                                              کاربر گرامي شما هنور عضويت خود را تاييد ننمود ه ايد. براي اين کار لطفآ بر روي لينک ارسالي در ايمل خود کليک نماييد.
                                                                                                                                                                                                                                          </p>
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid11" Text="ارسال مجدد لينک تاييد"/>
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<div class="ElamiyeVasileyeKhali-Form dnnForm formkhalidaryayi" id="ElamiyeVasileyeKhaliForm" runat="server">
    <div class="dnnFormItem" style="display: none">
        <dnn:Label ID="lblElamiyeVasileyeKhaliTitle" Text="اعلامیه وسیله حمل خالی" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " ID="lblDarkhastKonande" runat="server"></dnn:Label>
        <dnn:Label HelpText=" " ID="lblDarkhastKonandeValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:label id="lblNoeMashin" cssclass="dnnFormRequired" runat="server" Text="نوع کانتینر:"></dnn:label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolNoeVasile" />
        <asp:CompareValidator runat="server" ID="cvCbolIsReallyNeed" ValidationGroup="FormValidation"
                              CssClass="dnnFormMessage dnnFormError" Type="String" Operator="NotEqual" ControlToValidate="cbolNoeVasile"
                              ValueToCompare="-- انتخاب نمایید --" resourcekey="ErrorMessage" Display="Dynamic"></asp:CompareValidator>
    </div>


    
    <div class="dnnFormItem" style="display: none">
        <dnn:Label runat="server" HelpText=" " Text="خواهان ارسال استعلام خود برای شرکت های خارج:"></dnn:Label>
        <asp:CheckBox runat="server" Text="خواهانم" ID="chkKhahaneErsalEstelamBeKharej"/>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label cssclass="dnnFormRequired" ID="lblTedad" Text="تعداد:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtTedad" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rptTedad"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="txtTedad"
                                    ErrorMessage="" />    </div>
    <%--    <div class="dnnFormItem">
        <dnn:Label cssclass="dnnFormRequired" ID="lblNoeBar" Text="نوع محموله:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtNoeBar" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rptNoeBar"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="txtNoeBar"
                                    ErrorMessage="" />    </div>--%>
    <div class="dnnFormItem">                           
        <dnn:Label cssclass="dnnFormRequired" ID="lblNameKeshti" Text="نام کشتی:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtNameKeshti" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rptNameKeshti"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="txtNameKeshti"
                                    ErrorMessage="" /> </div>
    <div class="dnnFormItem">                           
        <dnn:Label cssclass="dnnFormRequired" ID="lblZarfiyateKashti" Text="ظرفیت کشتی:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtZarfiyateKashti" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rptZarfiyateKashti"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="txtZarfiyateKashti"
                                    ErrorMessage="" /> </div>
    <div class="dnnFormItem">
        <dnn:Label cssclass="dnnFormRequired" ID="lblOmreKashti" Text="عمر کشتی:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtOmreKashti" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rptOmreKashti"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="txtOmreKashti"
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
        <dnn:Label cssclass="dnnFormRequired" ID="lblMasireHarakat" Text="مسیر حرکت:" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtMasireHarakat" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rptMasireHarakat"
                                    CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="txtMasireHarakat"
                                    ErrorMessage="" />
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label cssclass="dnnFormRequired"  ID="lblZamaneAmadegi" Text="زمان آمادگی:" runat="server" ></dnn:Label>
        <dnn:DnnDatePicker runat="server" ID="dtpZamaneAmadegi"></dnn:DnnDatePicker>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvDtpActionDate" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="dtpZamaneAmadegi" resourcekey="ErrorMessage" />
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label cssclass="dnnFormRequired"  ID="lblExpireDate" Text="تاریخ اعتبار:" runat="server" ></dnn:Label>
        <dnn:DnnDatePicker runat="server" ID="dtpExpireDate"></dnn:DnnDatePicker>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator1" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="dtpExpireDate" resourcekey="ErrorMessage" />
        
        <asp:CompareValidator runat="server" ID="cvDtpExpiredate" ValidationGroup="FormValidation"
                              CssClass="dnnFormMessage dnnFormError" Type="Date" Operator="LessThanEqual" ControlToValidate="dtpExpiredate"
                              ControlToCompare="dtpZamaneAmadegi" resourcekey="ExpireDateGreaterThanActionDateErrorMessage" Display="Dynamic"></asp:CompareValidator>
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