<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReplyToInquiry_Dl.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.ReplyToInquiry_Dl" %>

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
                                                                                                                                                                                                                                          <asp:LinkButton runat="server" ID="btnErsaleLinkTaeid1223" Text="ارسال مجدد لینک تایید"/>
                                                                                                                                                                                                                                      </div>
                                                                                                                                                                                                                                  </asp:Panel>
<div class="ReplyToInquiry-Dl-Shenasname dnnForm shenasnameForm dlshenasname">
    
    <div class="dnnFormItem pasokh-title">
        <dnn:Label Text="شناسنامه استعلام" ID="lblReplyToInquiryDlShenasnameTitle" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " ID="lblDarkhastKonande" Text="استعلام دهنده:" runat="server"></dnn:Label>
        <dnn:Label HelpText=" " ID="lblDarkhastKonandeValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " ID="lblSherkat" Text="نام شرکت:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblSherkatValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblIsReallyNeed" Text="ماهیت استعلام:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblIsReallyNeedValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblZamaneEstelam" Text="زمان استعلام:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblZamaneEstelamValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblTarihkeEngeza" Text="تاریخ انقضاء" runat="server"></dnn:Label>
        <dnn:Label  ID="lblTarihkeEngezaValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblAkharinZamaneTagireEstelam" Text="آخرین زمان تغییر استعلام:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblAkharinZamaneTagireEstelamValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblIsExtend" Text="تمدید شده:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblIsExtendValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " ID="lblIsTender" Text="استعلام به صورت مناقصه میباشد؟" runat="server"></dnn:Label>
        <dnn:Label  ID="lblIsTenderValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblStartingPoint" Text="مبدا:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblStartingPointValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblMagsad" Text="مقصد:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblMagsadValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblActionDate" Text="تاریخ آغاز عملیات:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblActionDateValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblLoadType" Text="نوع محموله:" runat="server"></dnn:Label>
        <dnn:Label ID="lblLoadTypeValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblHSCodeSh" Text="کد HS:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblHSCodeShValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:label helptext=" " id="lblFileListeAdlBandi" text="فایل لیست عدلبندی:" runat="server"></dnn:label>
        <asp:HyperLink CssClass="dnnSecondaryAction" runat="server" ID="hplFileListeAdlBandi"></asp:HyperLink>
    </div>
    <%--    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblNoVaTedadeVaJoziyat" Text="نوع و تعداد و جزئیات:" runat="server"></dnn:Label>
        <dnn:Label HelpText=" " ID="lblNoVaTedadeVaJoziyatValue" runat="server"></dnn:Label>
    </div>--%>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblNahveyeEjareyeContiner" Text="نحوه اجاره کانتینر:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblNahveyeEjareyeContinerValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblNoeBastebandi" Text="نوع بسته بندی:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblNoeBastebandiValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblMogeiyateTahvilDadan" Text="موقعیت تحویل دادن:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblMogeiyateTahvilDadanValue" runat="server"></dnn:Label>
    </div>
    
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " ID="lblEhtesabeTamameHazinehayeBandari" Text="احتساب هزینه های بندری:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblEhtesabeTamameHazinehayeBandariValue" runat="server"></dnn:Label>
    </div>


    
    <%--    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblIsTHCDarMabdaSh" Text="با احتساب THC در مبداء" runat="server"></dnn:Label>
        <dnn:Label HelpText=" " ID="lblIsTHCDarMabdaShValue" runat="server"></dnn:Label>
    </div>--%>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblIsTHCDarMagsadSh" Text="با احتساب THC در مقصد" runat="server"></dnn:Label>
        <dnn:Label  ID="lblIsTHCDarMagsadShValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblIsTarkhisiyeDarMagsadSh" Text="با احتساب ترخیصیه در مقصد" runat="server"></dnn:Label>
        <dnn:Label  ID="lblIsTarkhisiyeDarMagsadShValue" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblIsKhahaneErsaleBeKharejiha" Text="خواهان ارسال استعلام برای خارجی ها:" runat="server"></dnn:Label>
        <dnn:Label  ID="lblIsKhahaneErsaleBeKharejihaValue" runat="server"></dnn:Label>
    </div>    
    <%--    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblWithInsurance" Text="با احتساب بیمه:" runat="server"></dnn:Label>
        <dnn:Label HelpText=" " ID="lblWithInsuranceValue" runat="server"></dnn:Label>
    </div>--%>
    
    <%--    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblEmptyingCharges" Text="با احتساب هزینه تخلیه بار:" runat="server"></dnn:Label>
        <dnn:Label HelpText=" " ID="lblEmptyingChargesValue" runat="server"></dnn:Label>
    </div>--%>
    <%--    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblNoVaTedadeVasileyeHaml" Text="نوع و تعداد وسیله حمل:" runat="server"></dnn:Label>
        <dnn:Label HelpText=" " ID="lblNoVaTedadeVasileyeHamlValue" runat="server"></dnn:Label>
    </div>--%>
    
    <%--    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="lblFileArzesheBar" Text="فایل ارزش محموله:" runat="server"></dnn:Label>
        <asp:HyperLink runat="server"  ID="hplFileArzesheBar"></asp:HyperLink>
    </div>--%>
    
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <a id="lnkReply" class="dnnPrimaryAction">پاسخ به استعلام</a>
            </li>
        </ul>
    </div>
</div>

<div class="ReplyToInquiry-Dn-Reply-Form dnnForm formPasokh formpasokhdl" style="display: none">
    <div class="dnnFormItem pasokh-title">
        <dnn:Label ID="lblReplyToInquiryDlTitle" runat="server" Text="پاسخ به استعلام"></dnn:Label>
    </div>
    <div class="dnnFormItem" style="display: none">
        <dnn:Label HelpText=" " ID="lblPasokhDahande" Text="پاسخ دهنده:" runat="server"></dnn:Label>
        <dnn:Label HelpText=" " ID="lblPasokhDahandeValue" runat="server"></dnn:Label>
    </div>
    
    <div id="barAsaseFCL">
        <asp:Repeater ID="rptNoeContiner" runat="server">
            <ItemTemplate>
                <div class="dnnFormItem" style="display: none">
                    <dnn:Label HelpText=" " ID="lblContinerNameVaJoziyat" Text='<%# (Eval("ContinerNameVaJoziyat")) + "-تعداد" %>' runat="server" ></dnn:Label>
                </div>
                <div class="dnnFormItem">
                    <dnn:Label HelpText=" " runat="server" ID="lblTedad" Text='<%# (Eval("ContinerNameVaJoziyat")) + " -تعداد" %>'></dnn:Label>
                    <asp:TextBox CssClass="priceItem_Tedad_T2D" data-dastgah='<%# (Eval("ContinerNameVaJoziyat")) %>' runat="server" ID="txtTedad"></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn:Label HelpText=" " ID="lblGeymateVahede" Text='<%# (Eval("ContinerNameVaJoziyat")) + " -قیمت واحد(ریال)" %>' runat="server"></dnn:Label>
                    <asp:TextBox CssClass="priceItem_Geymat_T2D" data-dastgah='<%# (Eval("ContinerNameVaJoziyat")) %>' ID="txtGeymateVahede" ToolTip='<%# (Eval("ContinerNameVaJoziyat").ToString()) %>' runat="server"></asp:TextBox>
                </div>
                <div class="dnnFormItem" style="display: none">
                    <dnn:Label HelpText=" " ID="lblGeymateKol" Text='<%# (Eval("ContinerNameVaJoziyat")) + " -قیمت کل" %>' runat="server" ></dnn:Label>
                    <asp:TextBox CssClass="priceItem" ID="txtGeymateKol" runat="server"></asp:TextBox>
                </div>
                <div class="dnnFormItem" style="display: none">
                    <dnn:Label HelpText=" " ID="lblGeymateKoleKoli" Text="قیمت کل:" runat="server" ></dnn:Label>
                    <asp:TextBox ID="txtGeymateKolKoli" runat="server"></asp:TextBox>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        
        <div class="dnnFormItem" style="display: none">
            <dnn:Label HelpText=" " ID="lblGeymat" Text="قیمت:" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtGeymat" runat="server"></asp:TextBox>
        </div>
    </div>
    
    <asp:panel runat="server" id="barAsaseLCL">
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " ID="lblGeymatBarAsaseListAdlBandi" Text="قیمت کل بر اساس لیست عدل بندی(ریال):" runat="server" ></dnn:Label>
            <asp:TextBox ID="txtGeymatBarAsaseListAdlBandi" runat="server"></asp:TextBox>
        </div>
    </asp:panel>
    <div class="dnnFormItem">
        <dnn:Label runat="server" Text="با احتساب THC درمقصد" HelpText=" "></dnn:Label>
        <asp:CheckBox runat="server" Text="با احتساب THC درمقصد" ID="chkIsBaEhtesabeTHCDarMagsad"/>
    </div>
    <div class="dnnFormItem">
        <dnn:Label runat="server" Text="با احتساب اخذ ترخیصیه در مقصد" HelpText=" "></dnn:Label>
        <asp:CheckBox runat="server" Text="با احتساب اخذ ترخیصیه در مقصد " ID="chkIsBaEhtesabeAkhseTarkhisiye"/>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="BaEhtesabeKoliyeyeHazinehayeBandari" Text="با احتساب کلیه هزینه های بندری پس از تحویلگیری محموله در مبداء تا بارگیری روی کشتی"></dnn:Label>
    </div>
   
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="Label2" Text="کل مدت زمان حمل(روز):" runat="server" ></dnn:Label>
        <asp:TextBox ID="txtModatRooz" runat="server" />
        <%--        <dnn:Label HelpText=" " ID="Label4" Text="ساعت:" runat="server" ></dnn:Label>
        --%>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="زمان آمادگی برای شروع عملیات:" runat="server" ID="lblZamaneAmadegiBarayeShoorooeAmaliyat"/>
        <dnn:DnnDatePicker runat="server" ID="dtpZamaneAmadegiBarayeShoorooeAmaliyat"/>
    </div>

    <div class="dnnFormItem">
        <dnn:Label HelpText=" " Text="گزارش عملیات:" runat="server" ID="lblGozareshAmaliyat"/>
        <asp:CheckBox runat="server" Text="گزارش عملیات و ردیابی محموله به صورت روزانه و منظم ارائه می گردد:" ID="chkIsGozareshAmaliyat"/>
    </div>
    
    <div class="dnnFormItem ">
        <span class="full-line textAfterTheButton">با توجه به شرایط موجود( از قبیل شرایط مسیر،شرایط آب و هوایی،در دسترس بودن وسیله مورد نیاز و غیره ) امکان پذیری عملیات به این صورت پیش بینی می گردد:" </span>
    </div>
    <div class="dnnFormItem fromtop20">
        <dnn:Label HelpText=" " ID="lblPishbini" Text="پیش بینی:" runat="server" ></dnn:Label>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolPishbini"/>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label HelpText=" " ID="Label5" Text="قیمت کل(ریال):" runat="server" ></dnn:Label>
        <asp:TextBox CssClass="geymateKol" ID="txtGeymateKol" runat="server" Enabled="False"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtGeymateKol" ValidationGroup="FormValidation" 
                                    ErrorMessage="محاسبه قیمت کل الزامی است.لطفآ برروی دکمه محاسبه قیمت کلیک نمایید."></asp:RequiredFieldValidator>
        <a class="dnnSecondaryAction" onclick=" CalcultePrice(); " >محاسبه قیمت</a>
    </div>
    
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton  ID="lnkSubmit" ValidationGroup="FormValidation" runat="server" CssClass="dnnPrimaryAction" Text="ارسال:" />
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

    function CalcultePrice() {
        $(".geymateKol").val(mohasebegheymatForDAL());
    };

    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>