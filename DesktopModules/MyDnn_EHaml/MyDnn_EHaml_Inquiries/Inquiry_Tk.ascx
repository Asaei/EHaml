<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Inquiry_Tk.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.Inquiry_Tk" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Portals" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2013.2.611.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>
<script>
    function MackeThisUserOK(userId, userStatus, userType, returnUrl) {
        if (userStatus === "SubscribeNist") {
            var modulePath = '<%= string.Format("/default.aspx?tabid=1142&type=") %>' + userType;
            dnnModal.show(modulePath, true, 550, 960, true, '');
        }
    }

    function DisableHiddenValidators() {
        for (var i = 0; i < Page_Validators.length; i++) {
            var visible = $('#' + Page_Validators[i].controltovalidate).is(':visible');
            ValidatorEnable(Page_Validators[i], visible)
        }
        return Page_ClientValidate();
    }

    function onItemCheckedContiner(sender, args) {
        var checked = args.get_item().get_checked();
        if (checked) {
            if (args.get_item().get_text().indexOf("GP'20") != -1) {
                <%--                rfvSubject = document.getElementById('<%= RequiredFieldValidatorkhatarnak.ClientID %>');
                rfvSubject.validationGroup = "FormValidation";
                ValidatorEnable(rfvSubject, true);--%>
                $(".pnlGP20").fadeIn(200);
            }
            if (args.get_item().get_text().indexOf("GP'40") != -1) {
                <%--                rfvSubject = document.getElementById('<%= RequiredFieldValidatorkhatarnak.ClientID %>');
                rfvSubject.validationGroup = "FormValidation";
                ValidatorEnable(rfvSubject, true);--%>
                $(".pnlGP40").fadeIn(200);
            }
            if (args.get_item().get_text().indexOf("HC'40") != -1) {
                <%--               rfvSubject = document.getElementById('<%= RequiredFieldValidatorkhatarnak.ClientID %>');
                rfvSubject.validationGroup = "FormValidation";
                ValidatorEnable(rfvSubject, true);--%>
                $(".pnlHC40").fadeIn(200);
            }
            if (args.get_item().get_text().indexOf("RF'20") != -1) {
                <%--                rfvSubject = document.getElementById('<%= RequiredFieldValidatorkhatarnak.ClientID %>');
                rfvSubject.validationGroup = "FormValidation";
                ValidatorEnable(rfvSubject, true);--%>
                $(".pnlRF20").fadeIn(200);
            }
            if (args.get_item().get_text().indexOf("RF'40") != -1) {
                <%--                rfvSubject = document.getElementById('<%= RequiredFieldValidatorkhatarnak.ClientID %>');
                rfvSubject.validationGroup = "FormValidation";
                ValidatorEnable(rfvSubject, true);--%>
                $(".pnlRF40").fadeIn(200);
            }
        } else {
            if (args.get_item().get_text().indexOf("GP'20") != -1) {
                <%--                rfvSubject = document.getElementById('<%= RequiredFieldValidatorkhatarnak.ClientID %>');
                rfvSubject.validationGroup = "FormValidation";
                ValidatorEnable(rfvSubject, true);--%>
                $(".pnlGP20").fadeOut(200);
            }
            if (args.get_item().get_text().indexOf("GP'40") != -1) {
                <%--                rfvSubject = document.getElementById('<%= RequiredFieldValidatorkhatarnak.ClientID %>');
                rfvSubject.validationGroup = "FormValidation";
                ValidatorEnable(rfvSubject, true);--%>
                $(".pnlGP40").fadeOut(200);
            }
            if (args.get_item().get_text().indexOf("HC'40") != -1) {
                <%--               rfvSubject = document.getElementById('<%= RequiredFieldValidatorkhatarnak.ClientID %>');
                rfvSubject.validationGroup = "FormValidation";
                ValidatorEnable(rfvSubject, true);--%>
                $(".pnlHC40").fadeOut(200);
            }
            if (args.get_item().get_text().indexOf("RF'20") != -1) {
                <%--                rfvSubject = document.getElementById('<%= RequiredFieldValidatorkhatarnak.ClientID %>');
                rfvSubject.validationGroup = "FormValidation";
                ValidatorEnable(rfvSubject, true);--%>
                $(".pnlRF20").fadeOut(200);
            }
            if (args.get_item().get_text().indexOf("RF'40") != -1) {
                <%--                rfvSubject = document.getElementById('<%= RequiredFieldValidatorkhatarnak.ClientID %>');
                rfvSubject.validationGroup = "FormValidation";
                ValidatorEnable(rfvSubject, true);--%>
                $(".pnlRF40").fadeOut(200);
            }
        }
    }

    function IsThisUserOK() {
        var sf = $.ServicesFramework(<%= ModuleId %>);
        var value = "<%= this.UserId %>";
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/IsThisUserOk",
            data: { "UserId": value, "UserCurrentType": 1 },
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            if (result !== "OK") {
                MackeThisUserOK(value, result, 1, "default.aspx");
                return false;
            } else {
                return true;
            }
        }).fail(function(xhr, status, error) {
            alert(error);
        });
    };

    function FillShahrList() {
        var sf = $.ServicesFramework(<%= ModuleId %>);

        var combobox = $find("<%= cbolStartingPointOstan.ClientID %>");
        var value = combobox.get_value();

        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/GetShahrList2",
            data: { "keshvarName": value },
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            bindCbolShahr(result);
        }).fail(function(xhr, status, error) {
            alert(error);
        });
    }

    function bindCbolShahr(shahrList) {
        var combo = $find("<%= cbolStartingPointShahr.ClientID %>");
        combo.clearItems();
        for (var i = 0; i < shahrList.length; i++) {
            var comboItem = new Telerik.Web.UI.RadComboBoxItem();
            comboItem.set_text(shahrList[i].Shahr);
            comboItem.set_value(shahrList[i].Shahr);

            combo.get_items().add(comboItem);
            comboItem.select();
            combo.commitChanges();
        }
    }

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
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid11" Text="ارسال مجدد لینک تایید"/>
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<div class="InquiryTk-Form dnnForm">
    <div class="dnnFormItem">
        <dnn:Label  id="lblInquiryTkTitle" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " id="lblDarkhastKonande" runat="server"></dnn:label>
        <dnn:Label HelpText=" " id="lblDarkhastKonandeValue" runat="server"></dnn:label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " id="lblIsReallyNeed" cssclass="dnnFormRequired" runat="server"></dnn:label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolIsReallyNeed" />
        <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator1" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolIsReallyNeed" resourcekey="ErrorMessage" />
        
    </div>
    <%--    
    <div class="dnnFormItem">--%>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " runat="server" CssClass="dnnFormRequired" Text="نوع کانتینر مورد نظر را انتخاب نمایید:"/>
        <dnn:DnnComboBox runat="server" ID="cblocontinertype" CheckBoxes="True" EmptyMessage="-- انتخاب نماييد --" OnClientItemChecked=" onItemCheckedContiner ">
            <Items>
                <dnn:DnnComboBoxItem runat="server" Text="کانتینر GP'20" Value="کانتینر GP'20"/>
                <dnn:DnnComboBoxItem runat="server" Text="کانتینر GP'40" Value="کانتینر GP'40"/>
                <dnn:DnnComboBoxItem runat="server" Text="کانتینر HC'40" Value="کانتینر HC'40"/>
                <dnn:DnnComboBoxItem runat="server" Text="کانتینر RF'20" Value="کانتینر RF'20"/>
                <dnn:DnnComboBoxItem runat="server" Text="کانتینر RF'40" Value="کانتینر RF'40"/>
            </Items>
        </dnn:DnnComboBox>
        <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator5" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cblocontinertype" resourcekey="ErrorMessage" />
    </div>

    <div class="pnlGP20" id="pnlGP20" style="display: none" runat="server">
        <div class="dnnFormItem" style="margin-bottom: 10px; font-weight: bold">
            <dnn:Label HelpText=" " runat="server" Text="کانتینر GP'20" />
            <%--<dnn:DnnCheckBox><%# "نوع کانتینر " + (Eval("ContinerName").ToString()) %></dnn:DnnCheckBox>--%>
        </div>
        <div class="dnnFormItem">
            <dnn:Label CssClass="dnnFormRequired" HelpText=" " ID="lblVazneKhales" Text="وزن ناخالص هر کانتینر پر(کیلوگرم):" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtVazneNakhales" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator2" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="txtVazneNakhales" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" ID="lblTedad" Text="تعداد:" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtTedad" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator3" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="txtTedad" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" ID="lblNoeMalekiyat" Text="نوع مالکیت:" runat="server" ></dnn:Label>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolNoeMalekiyat">
                <Items>
                    <dnn:DnnComboBoxItem runat="server" Text="SOC" Value="SOC"/>
                    <dnn:DnnComboBoxItem runat="server" Text="COC" Value="COC"/>
                </Items>
            </dnn:DnnComboBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator4" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolNoeMalekiyat" resourcekey="ErrorMessage" />
        </div>
    </div>
    <div class="dnnFormItem">
        <%--<asp:CheckBox CssClass="gp40checkbox" onclick="NoeContinerCheckBoxChanged40()" runat="server" Text="کانتینر GP'40" />--%>
        <%--<dnn:DnnCheckBox><%# "نوع کانتینر " + (Eval("ContinerName").ToString()) %></dnn:DnnCheckBox>--%>
    </div>
    <div class="pnlGP40" id="pnlGP40" style="display: none" runat="server">
        <div class="dnnFormItem" style="margin-bottom: 10px; font-weight: bold">
            <dnn:Label HelpText=" " runat="server" Text="کانتینر GP'40" />
            <%--<dnn:DnnCheckBox><%# "نوع کانتینر " + (Eval("ContinerName").ToString()) %></dnn:DnnCheckBox>--%>
        </div>
        <div class="dnnFormItem">
            <dnn:Label CssClass="dnnFormRequired" HelpText=" " ID="lblVazneKhales40" Text="وزن ناخالص هر کانتینر پر(کیلوگرم):" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtVazneNakhales40" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator240" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="txtVazneNakhales40" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" ID="lblTedad40" Text="تعداد:" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtTedad40" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator340" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="txtTedad40" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" ID="lblNoeMalekiyat40" Text="نوع مالکیت:" runat="server" ></dnn:Label>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolNoeMalekiyat40">
                <Items>
                    <dnn:DnnComboBoxItem runat="server" Text="SOC" Value="SOC"/>
                    <dnn:DnnComboBoxItem runat="server" Text="COC" Value="COC"/>
                </Items>
            </dnn:DnnComboBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator440" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolNoeMalekiyat40" resourcekey="ErrorMessage" />
        </div>
    </div>
    <div class="dnnFormItem">
        <%--<asp:CheckBox CssClass="HC40checkbox" onclick="NoeContinerCheckBoxChangedHC40()" runat="server" Text="کانتینر HC'40" />--%>
        <%--<dnn:DnnCheckBox><%# "نوع کانتینر " + (Eval("ContinerName").ToString()) %></dnn:DnnCheckBox>--%>
    </div>
    <div class="pnlHC40" id="pnlHC40" style="display: none" runat="server">
        <div class="dnnFormItem" style="margin-bottom: 10px; font-weight: bold">
            <dnn:Label HelpText=" " runat="server" Text="کانتینر HC'40"  />
            <%--<dnn:DnnCheckBox><%# "نوع کانتینر " + (Eval("ContinerName").ToString()) %></dnn:DnnCheckBox>--%>
        </div>
        <div class="dnnFormItem">
            <dnn:Label CssClass="dnnFormRequired" HelpText=" " ID="lblVazneKhalesHC40" Text="وزن ناخالص هر کانتینر پر(کیلوگرم):" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtVazneNakhalesHC40" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator2HC40" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="txtVazneNakhalesHC40" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" ID="lblTedadHC40" Text="تعداد:" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtTedadHC40" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator3HC40" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="txtTedadHC40" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" ID="lblNoeMalekiyatHC40" Text="نوع مالکیت:" runat="server" ></dnn:Label>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolNoeMalekiyatHC40">
                <Items>
                    <dnn:DnnComboBoxItem runat="server" Text="SOC" Value="SOC"/>
                    <dnn:DnnComboBoxItem runat="server" Text="COC" Value="COC"/>
                </Items>
            </dnn:DnnComboBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator4HC40" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolNoeMalekiyatHC40" resourcekey="ErrorMessage" />
        </div>
    </div>
    <div class="dnnFormItem">
        <%--<asp:CheckBox CssClass="RF20checkbox" onclick="NoeContinerCheckBoxChangedRF20()" runat="server" Text="کانتینر RF'20" />--%>
        <%--<dnn:DnnCheckBox><%# "نوع کانتینر " + (Eval("ContinerName").ToString()) %></dnn:DnnCheckBox>--%>
    </div>
    <div class="pnlRF20" id="pnlRF20" style="display: none" runat="server">
        <div class="dnnFormItem" style="margin-bottom: 10px; font-weight: bold">
            <dnn:Label HelpText=" " runat="server" Text="کانتینر RF'20"  />
            <%--<dnn:DnnCheckBox><%# "نوع کانتینر " + (Eval("ContinerName").ToString()) %></dnn:DnnCheckBox>--%>
        </div>
        <div class="dnnFormItem">
            <dnn:Label CssClass="dnnFormRequired" HelpText=" " ID="lblVazneKhalesRF20" Text="وزن ناخالص هر کانتینر پر(کیلوگرم):" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtVazneNakhalesRF20" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator2RF20" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="txtVazneNakhalesRF20" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" ID="lblTedadRF20" Text="تعداد:" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtTedadRF20" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator3RF20" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="txtTedadRF20" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" ID="lblNoeMalekiyatRF20" Text="نوع مالکیت:" runat="server" ></dnn:Label>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolNoeMalekiyatRF20">
                <Items>
                    <dnn:DnnComboBoxItem runat="server" Text="SOC" Value="SOC"/>
                    <dnn:DnnComboBoxItem runat="server" Text="COC" Value="COC"/>
                </Items>
            </dnn:DnnComboBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator4RF20" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolNoeMalekiyatRF20" resourcekey="ErrorMessage" />
        </div>
    </div>
    <div class="dnnFormItem">
        <%--<asp:CheckBox CssClass="RF40checkbox" onclick="NoeContinerCheckBoxChangedRF40()" runat="server" Text="کانتینر RF'40" />--%>
        <%--<dnn:DnnCheckBox><%# "نوع کانتینر " + (Eval("ContinerName").ToString()) %></dnn:DnnCheckBox>--%>
    </div>
    <div class="pnlRF40" id="pnlRF40" style="display: none" runat="server">
        <div class="dnnFormItem" style="margin-bottom: 10px; font-weight: bold">
            <dnn:Label HelpText=" " runat="server" Text="کانتینر RF'40"  />
            <%--<dnn:DnnCheckBox><%# "نوع کانتینر " + (Eval("ContinerName").ToString()) %></dnn:DnnCheckBox>--%>
        </div>
        <div class="dnnFormItem">
            <dnn:Label CssClass="dnnFormRequired" HelpText=" " ID="lblVazneKhalesRF40" Text="وزن ناخالص هر کانتینر پر(کیلوگرم):" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtVazneNakhalesRF40" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator2RF40" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="txtVazneNakhalesRF40" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" ID="lblTedadRF40" Text="تعداد:" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtTedadRF40" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator3RF40" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="txtTedadRF40" resourcekey="ErrorMessage" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " CssClass="dnnFormRequired" ID="lblNoeMalekiyatRF40" Text="نوع مالکیت:" runat="server" ></dnn:Label>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolNoeMalekiyatRF40">
                <Items>
                    <dnn:DnnComboBoxItem runat="server" Text="SOC" Value="SOC"/>
                    <dnn:DnnComboBoxItem runat="server" Text="COC" Value="COC"/>
                </Items>
            </dnn:DnnComboBox>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator4RF40" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="cbolNoeMalekiyatRF40" resourcekey="ErrorMessage" />
        </div>
    </div>
    <%--</div>--%>


    <%--    <asp:Repeater ID="rptNoeContiner" runat="server">
        <ItemTemplate>
            <div class="dnnFormItem">
                <dnn:Label HelpText=" " id="lblContinerName" text='<%# (Eval("ContinerName").ToString()) %>' runat="server"></dnn:label>
                <br />
                <dnn:Label HelpText=" " id="lblVazneKhales" text="وزن ناخالص هر کانتینر پر(کیلوگرم):" runat="server"></dnn:label>
                <asp:TextBox ID="txtVazneNakhales" runat="server" ToolTip='<%# (Eval("ContinerName").ToString()) %>'></asp:TextBox>
                <br />
                <dnn:Label HelpText=" " id="lblTedad" text="تعداد:" runat="server"></dnn:label>
                <asp:TextBox ID="txtTedad" runat="server"></asp:TextBox>
                <br />
            </div>
        </ItemTemplate>
    </asp:Repeater>--%>
    

    <div class="dnnFormItem" style="padding-top: 8px; border-top: solid 1px silver;">
        <dnn:Label HelpText=" " text="نوع عملیات:" id="lblNoeAmaliyat" cssclass="dnnFormRequired" runat="server"></dnn:label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolNoeAmaliyat" />
        <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator6" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolNoeAmaliyat" resourcekey="ErrorMessage" />
    </div>

    <div class="dnnFormItem">
        <dnn:Label HelpText=" " cssclass="dnnFormRequired" text="کشور محل عملیات:" runat="server" id="lblStartingPointOstanA" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" Filter="Contains" OnClientSelectedIndexChanged=" FillShahrList " runat="server" id="cbolStartingPointOstan"></dnn:dnncombobox>
         <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator7" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolStartingPointOstan" resourcekey="ErrorMessage" />

    </div>
    <div class="dnnFormItem">
        <dnn:Label cssclass="dnnFormRequired" Text="شهر محل عملیات:" HelpText=" " runat="server" ID="lblStartingPointShahrA"/>
        <telerik:RadComboBox Filter="Contains" CssClass="latinCombo" AllowCustomText="True" runat="server" ID="cbolStartingPointShahr"></telerik:RadComboBox>
<asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="RequiredFieldValidator8" CssClass="dnnFormMessage dnnFormError"
                                    runat="server" Display="Dynamic" ControlToValidate="cbolStartingPointShahr" resourcekey="ErrorMessage" />
    </div>
    
    <div class="dnnFormItem">
            <dnn:Label HelpText=" " cssclass="dnnFormRequired" runat="server" Text="تاریخ شروع عملیات:" ID="lblActionDate"/>
            <dnn:DnnDatePicker runat="server" ID="dtpActionDate"/>
            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="rfvDtpActionDate" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="dtpActionDate" resourcekey="ErrorMessage" />
        </div>
    <div class="dnnFormItem">
            <dnn:Label cssclass="dnnFormRequired" HelpText=" " runat="server" Text="تاریخ انقضا استعلام:" ID="lblExpireDate"/>
            <dnn:DnnDatePicker runat="server" ID="dtpExpiredate"></dnn:DnnDatePicker>

            <asp:RequiredFieldValidator ValidationGroup="FormValidation"  ID="rfvDtpExpiredate" CssClass="dnnFormMessage dnnFormError"
                                        runat="server" Display="Dynamic" ControlToValidate="DtpExpiredate" resourcekey="ErrorMessage" />

            <asp:CompareValidator runat="server" ID="cvDtpExpiredate" ValidationGroup="FormValidation"
                                  CssClass="dnnFormMessage dnnFormError" Type="Date" Operator="LessThanEqual" ControlToValidate="dtpExpiredate"
                                  ControlToCompare="dtpActionDate" resourcekey="ExpireDateGreaterThanActionDateErrorMessage" Display="Dynamic"></asp:CompareValidator>
        </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton OnClientClick="DisableHiddenValidators()"  ID="lnkSubmit" Text="ارسال:" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" resourcekey="lnkSubmit" />
            </li>
        </ul>
    </div>
        <div runat="server" class="dnnFormWarning myErrorMessage" id="errorMessages" Visible="False"></div>
</div>

<div class="messageAfterSubmit dnnFormMessage" visible="False" id="messageAfterSubmit" runat="server"></div>
<div class=""><asp:LinkButton Text="چاپ" Visible="False" ID="lnkPrintKon" runat="server" CssClass="dnnPrimaryAction" /></div>
<asp:HiddenField runat="server" ID="hiddenFieldId"/>