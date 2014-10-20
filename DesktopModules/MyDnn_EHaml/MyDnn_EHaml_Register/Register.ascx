<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="Register.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_Ehaml_Register.Register" %>

<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>

<script type="text/javascript">
    function ValidateCheckBox(sender, args) {
        if (document.getElementById("<%=chkTavafog.ClientID %>").checked == true) {
            args.IsValid = true;
        } else {
            args.IsValid = false;
        }
    }

    function OnClientSelectedIndexChanged(sender, eventArgs) {
        var combo = $find("<%= cbolUserType.ClientID %>");
        var usertype = combo.get_value();
        if (usertype == "A") {
            $(".khedmateresan-panel").show();
            $(".tavafog").removeClass("tavafog2");
        } else {
            $(".khedmateresan-panel").hide();
            $(".tavafog").addClass("tavafog2");

        }
    }

    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>

<asp:Panel runat="server" ID="pnlKoli" Visible="True">
    <asp:Panel CssClass="MessageForNotSubscribeUser" runat="server" ID="pnlUserNameTaken" Visible="False">
        <p>
            نام کاربری وارد شده قبلآ انتخاب شده است. لطفآ نام کاربری دیگری وارد نمایید.
        </p>
    </asp:Panel>
    <asp:Panel CssClass="MessageForNotSubscribeUser" runat="server" ID="pnlTavafog" Visible="False">
        <p>
            برای ثبت نام پذیرفتن توافقنامه الزامیست. لطفآ فرم ثبت نام را بادقت تکمیل نمایید.
        </p>
    </asp:Panel>

    <table dir="rtl" width="100%">
        <tr>
            <td valign="top">
                <div class="note-panel">
                    <dnn:label id="Label1" runat="server" text="لطفا اطلاعات زیر را با دقت تکمیل نمائید"></dnn:label>
                </div>
                <div class="Register-Form dnnForm">
                    <div class="dnnFormItem">
                        <dnn:label id="lblHagigiYaHoogoogiType" runat="server" cssclass="dnnFormRequired"></dnn:label>
                        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolHagigiYaHoogoogiType" cssclass="dnnFixedSizeComboBox" />
<asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator1" CssClass="dnnFormMessage dnnFormError"
                                                    runat="server" Display="Dynamic" ControlToValidate="cbolHagigiYaHoogoogiType" resourcekey="ErrorMessage" />
                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblUserType" runat="server" cssclass="dnnFormRequired"></dnn:label>
                        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolUserType" cssclass="dnnFixedSizeComboBox" onclientselectedindexchanged=" OnClientSelectedIndexChanged " />
<asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="RequiredFieldValidator2" CssClass="dnnFormMessage dnnFormError"
                                                    runat="server" Display="Dynamic" ControlToValidate="cbolUserType" resourcekey="ErrorMessage" />
                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblFirstName" runat="server" cssclass="dnnFormRequired"></dnn:label>
                        <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvTxtFirstName" CssClass="dnnFormMessage dnnFormError"
                                                    runat="server" Display="Dynamic" ControlToValidate="txtFirstName" resourcekey="ErrorMessage" />
                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblLastName" runat="server" cssclass="dnnFormRequired"></dnn:label>
                        <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvTxtLastName" CssClass="dnnFormMessage dnnFormError"
                                                    runat="server" Display="Dynamic" ControlToValidate="txtLastName" resourcekey="ErrorMessage" />
                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblUserName" runat="server" cssclass="dnnFormRequired"></dnn:label>
                        <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvTxtUserame" CssClass="dnnFormMessage dnnFormError"
                                                    runat="server" Display="Dynamic" ControlToValidate="txtUserName" resourcekey="ErrorMessage" />
                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblPassword" runat="server" cssclass="dnnFormRequired"></dnn:label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvTxtPassword" CssClass="dnnFormMessage dnnFormError"
                                                    runat="server" Display="Dynamic" ControlToValidate="txtPassword" resourcekey="ErrorMessage" />
                        <asp:RegularExpressionValidator CssClass="dnnFormMessage dnnFormError" ID="rxvTxtPassword" runat="server"
                                                        resourcekey="PasswordLenghtErrorMessage"
                                                        ControlToValidate="txtPassword"
                                                        ValidationExpression="^.{7,12}$" />
                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblPasswordConfirm" runat="server" cssclass="dnnFormRequired"></dnn:label>
                        <asp:TextBox ID="txtPasswordConfirm" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvTxtPasswordConfirm" CssClass="dnnFormMessage dnnFormError"
                                                    runat="server" Display="Dynamic" ControlToValidate="txtPasswordConfirm" resourcekey="ErrorMessage" />
                        <asp:CompareValidator runat="server" ID="cvTxtPasswordConfirm" ValidationGroup="FormValidation"
                                              CssClass="dnnFormMessage dnnFormError" Type="String" Operator="Equal" ControlToValidate="txtPasswordConfirm"
                                              ControlToCompare="txtPassword" resourcekey="PasswordConfirmErrorMessage" Display="Dynamic"></asp:CompareValidator>
                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblCompany" runat="server" cssclass="dnnFormRequired"></dnn:label>
                        <asp:TextBox ID="txtCompany" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvTxtCompany" CssClass="dnnFormMessage dnnFormError"
                                                    runat="server" Display="Dynamic" ControlToValidate="txtCompany" resourcekey="ErrorMessage" />

                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblPhone" runat="server" cssclass="dnnFormRequired"></dnn:label>
                        <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                    
                        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvTxtPhone" CssClass="dnnFormMessage dnnFormError"
                                                    runat="server" Display="Dynamic" ControlToValidate="txtPhone" resourcekey="ErrorMessage" />

                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblCellPhone" runat="server" cssclass="dnnFormRequired"></dnn:label>
                        <asp:TextBox ID="txtCellPhone" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvTxtCellPhone" CssClass="dnnFormMessage dnnFormError"
                                                    runat="server" Display="Dynamic" ControlToValidate="txtCellPhone" resourcekey="ErrorMessage" />
                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblEmail" runat="server" cssclass="dnnFormRequired"></dnn:label>
                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvTxtEmail" CssClass="dnnFormMessage dnnFormError"
                                                    runat="server" Display="Dynamic" ControlToValidate="txtEmail" resourcekey="ErrorMessage" />
                        <asp:RegularExpressionValidator CssClass="dnnFormMessage dnnFormError" ErrorMessage="لطفآ یک ایمیل معتبر وارد نمایید" ControlToValidate="txtEmail" ValidationExpression="^[a-zA-Z0-9._%\-+']+@(?:[a-zA-Z0-9\-]+\.)+(?:[a-zA-Z]{2}|aero|arpa|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|root|tel|travel|cym|geo|post)$" ValidationGroup="FormValidation" runat="server" ></asp:RegularExpressionValidator>

                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblAddress" runat="server" cssclass="dnnFormRequired"></dnn:label>
                        <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvTxtAddress" CssClass="dnnFormMessage dnnFormError"
                                                    runat="server" Display="Dynamic" ControlToValidate="txtAddress" resourcekey="ErrorMessage" />
                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblPostalCode" runat="server" cssclass="dnnFormRequired"></dnn:label>
                        <asp:TextBox ID="txtPostalCode" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="FormValidation" ID="rfvTxtPostalCode" CssClass="dnnFormMessage dnnFormError"
                                                    runat="server" Display="Dynamic" ControlToValidate="txtPostalCode" resourcekey="ErrorMessage" />
                    </div>
                    <div class="dnnFormItem dnn_ctr439_Register_lnkRegister1">
                        <ul class="dnnActions dnnClear">
                            <li>
                                <asp:LinkButton ID="lnkRegister" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" resourcekey="lnkRegiste" />
                            </li>
                        </ul>
                    </div>
                </div>
            </td>
            <td valign="top" id="khedmateresanpanel" class="khedmateresan-panel" runat="server">
                <div class="note-panel">
                    <dnn:label Text="شما به عنوان خدمت گذار میبایست حداقل یک زمینه فعالیتی را انتخاب نمایید." id="lblRequireActivityFieldTypeServentNote" runat="server"></dnn:label>
                </div>
                <div class="Register-Form-ActivityFieldTypeServant dnnForm">
                    <div class="dnnFormItem">
                        <dnn:label id="lblActivityFieldTypeServantForwarder" runat="server"></dnn:label>
                        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolForwarder" checkboxes="True" cssclass="dnnFixedSizeComboBox" />
                    </div>
                    <div class="dnnFormItem">
                        <dnn:label id="lblActivityFieldTypeServantCarrierDakheli" runat="server"></dnn:label>
                        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolCarrierDakhely" checkboxes="True" cssclass="dnnFixedSizeComboBox" />
                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblActivityFieldTypeServantCarrierBooroonMarzi" runat="server"></dnn:label>
                        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolCarrierBooroonMarzi" checkboxes="True" cssclass="dnnFixedSizeComboBox" />
                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblActivityFieldTypeServantTakhliyeVaBargiry" runat="server"></dnn:label>
                        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolTakhliyeVaBargiry" checkboxes="True" cssclass="dnnFixedSizeComboBox" />
                    </div>

                    <div class="dnnFormItem">
                        <dnn:label id="lblActivityFieldTypeServantTarkhis" runat="server"></dnn:label>
                        <asp:CheckBox Text="ترخیص" runat="server" ID="chkTarkhis" Checked="False" />
                    </div>

                    <%--                <div class="dnnFormItem">--%>
                    <%--                    <dnn:label id="lblActivityFieldTypeServantOther" runat="server"></dnn:label>--%>
                    <%--                    <asp:TextBox runat="server" ID="txtActivityFieldTypeServantOther" />--%>
                    <%--                </div>--%>
                </div>
                <div class="dnnFormItem">
                    <dnn:dnnlabel runat="server" id="lblActivityFieldTypeServantError" text="انتخاب حداقل یک زمینه فعالیت الزامی میباشد" visible="False"></dnn:dnnlabel>
                </div>
            </td>
        </tr>
    </table>
    <div class="tavafog">

        <div class="dnnFormItem">
            <dnn:label id="lblTavafogName" runat="server"></dnn:label>
            <asp:Label runat="server"></asp:Label>
        </div>
        <div class="dnnFormItem fromtop20">
            <asp:Label runat="server"></asp:Label>
            <div ID="tavafogname"  class="tavafogname" runat="server">
                <div dir="RTL"><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><span dir="rtl"><strong>توافق نامه با کاربران:</strong></span></span></span></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;">با سپاس فراوان از شما کاربر(مشتری- خدمات رسان) عزیز که عضویت در پایگاه e-حمل را برگزیده اید،</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;">تقاضا داریم پس از مطالعه دقیق موارد ذیل ،آنها را تایید فرموده تا مراحل عضویت شما تکمیل گردد:</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><strong>1.به موجب این فرم تایید می کنید که:</strong></span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><span style="color: #008000;"><span style="font-size: 16px;">*</span></span> &nbsp; &nbsp; &nbsp;کلیه مشخصات قید شده در فرم عضویت مطابق با واقع می باشد</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><span style="color: #008000;"><span style="font-size: 16px;">*</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; در صورت تغییر هرکدام از مشخصات عضویت،نسبت به اصلاح آن در فرم عضویت در اسرع وقت اقدام خواهم کرد.</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><span style="color: #008000;"><span style="font-size: 16px;">*</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; نسبت به تمامی مواردی که از این پس در این پایگاه اعلام و درج می نمایم صدق گفتار و حسن نیت دارم</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><span style="color: #008000;"><span style="font-size: 16px;">*</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; هيچ گونه فعاليت خلاف قانون يا اخلاق يا نظم عمومي با امكانات اين پايگاه انجام نخواهم داد .</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><span style="color: #008000;"><span style="font-size: 16px;">*</span></span> &nbsp; &nbsp; &nbsp;اقدام به هیچگونه عمل و تلاشی که منجر به ضرر و زیان این پایگاه گردد نخواهم کرد</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><span style="color: #008000;"><span style="font-size: 16px;">*</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; به منظور Up load نمودن فایل های مورد نیاز در استعلامات یا پاسخ آنها،هیچگونه فایلی غیر از فایل مورد درخواست را ارسال نخواهم کرد.</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><span style="color: #008000;"><span style="font-size: 16px;">*</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; کلیه خدمات قابل مطالبه من مطابق با نوع عضویتی می باشد که انتخاب کرده ام.</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><span style="font-size: 16px;"><span style="color: #008000;">*</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; مدت اعتبار عضویت من مطابق با نوع عضویتی می باشد که انتخاب کرده ام.</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><span style="color: #008000;"><span style="font-size: 16px;">*</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; نسبت به پرداخت کلیه بدهی های خود به این پایگاه در زمان تعیین شده و دراسرع وقت اقدام خواهم نمود. در غير اين صورت اين پايگاه مي تواند هرگونه اقدام مقتضي قانوني انجام دهد.</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><span style="font-size: 16px;"><span style="color: #008000;">*</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; کلیه حقوق نرم افزاری ، سخت افزاری و مالکیت معنوی پایگاه e-حمل، متعلق به صاحبان آن بوده و هیچگونه اقدامی برعلیه آن انجام نخواهم داد.</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><span style="font-size: 16px;"><span style="color: #008000;">*</span></span> &nbsp; &nbsp; &nbsp;مطالب مندرج در فایل <a target="_blank" href="/صفحه-اصلی/توضیحات-تکمیلی">توضیحات مکمل</a> را مطالعه نموده ام.</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;">​</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><strong>2.فورس ماژور:</strong> به هرگونه حادثه غیر منتظره و غیرقابل پیش گیری از قبیل جنگ،زلزله،سیل،شورش و غیره اطلاق می شود که انجام تعهدات این پایگاه را در مورد مشتریان با مانع مواجه می کند. در صورت بروز فورس ماژور، انجام این تعهدات تا مدت معقولی متوقف می شود.هرگاه فورس ماژور بیش از حد به طول انجامد،با اعلام کتبی این پایگاه به مشتری ظرف مدت 7 روز،کلیه تعهدات کان لم یکن تلقی می گردد.</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;">​</span></span></samp></div>

                <div dir="RTL"><samp><span style="font-family: tahoma, geneva, sans-serif;"><span style="font-size: 12px;"><strong>3.مرجع رسیدگی :</strong>حل و فصل كليه اختلافات ناشي ازفعاليت در اين پايگاه يا مرتبط با آن در صلاحيت مراجع قضايي جمهوري اسلامي ايران است.</span></span></samp></div>

            </div>
            <div class="dnnFormItem chkTavafog" style="text-align: right;">
                <dnn:DnnCheckBox CssClass="dnnFormRequired" runat="server" ID="chkTavafog" Text="متن توافقنامه را مطالعه کرده و آنرا قبول دارم"/>
                <asp:CustomValidator ID="CustomValidator1"  ValidationGroup="FormValidation" runat="server" ClientValidationFunction = "ValidateCheckBox"></asp:CustomValidator>
            </div>
        </div>
    </div>
</asp:Panel>
<asp:Panel CssClass="lblThingsAreOk" runat="server" ID="pnlAfterRegister" Visible="False">
    <asp:Label runat="server" ID="lblThingsAreOk">ثبت نام شما انجام شد.
        .لطفآ برا تایید ثبت نام خود بر روی لینکی که به ایمیل شما ارسال شده است کلید نمایید.</asp:Label>
    <div class="dnnFormItem" style="margin-top: 15px">
        <asp:HyperLink NavigateUrl="/default.aspx" runat="server" CssClass="dnnPrimaryAction"  ID="btnBazgasht">صفحه اصلی</asp:HyperLink>
    </div>
</asp:Panel>