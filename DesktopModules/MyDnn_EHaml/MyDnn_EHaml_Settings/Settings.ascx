<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Settings.Settings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Import Namespace="DotNetNuke.Entities.Content.Common" %>
<%@ Import Namespace="MyDnn_EHaml" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:dnncssinclude id="DnnCssInclude1" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.common.min.css" />
<dnn:dnncssinclude id="DnnCssInclude3" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.rtl.min.css" />
<dnn:dnncssinclude id="DnnCssInclude4" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.default.min.css" />
<dnn:dnnjsinclude id="DnnJsInclude1" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Scripts/kendo.web.min.js" />

<script src="/DesktopModules/MyDnn_EHaml/Scripts/kendo.web.min.js">
    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>
<script src="/DesktopModules/MyDnn_EHaml/Scripts/xdate.js">
    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>
<script src="/DesktopModules/MyDnn_EHaml/Scripts/date.js">
    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>
<script src="/DesktopModules/MyDnn_EHaml/Scripts/mydnn.js">
    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>

<div id="dnnDateType" style="margin-top: 20px;">
    <ul class="dnnAdminTabNav dnnClear">
        <li>
            <a href="#Paye" id="lnkPaye">تنظیمات پایه</a>
        </li>
        <li>
            <a href="#Zaher" id="lnkZaher">تنظیمات ظاهری</a>
        </li>
        <li>
            <a href="#Mali" id="lnkMali">تنظیمات مالی</a>
        </li>
        <li>
            <a href="#Darghah" id="lnkDarghah">تنظیمات درگاه بانک</a>
        </li>
        <li>
            <a href="#SMS" id="lnkSMS">تنظیمات پنل اس ام اس</a>
        </li>
        <li>
            <a href="#AmaliyatRooyeKarbaran" id="lnkAmaliyatRooyeKarbaran">عملیات کاربران</a>
        </li>
        <li>
            <a href="#AmaliyatRooyeHesabeKarbaran" id="lnkAmaliyatRooyeHesabeKarbaran">عملیات روی حساب بانکی کاربران</a>
        </li>
        <li>
            <a href="#EtelaResani" id="lnkEtelaResani">تنظیمات اطلاع رسانی</a>
        </li>
        <li>
            <a href="#KeshvarShahr" id="lnkKeshvarShahr">لیست کشور شهر</a>
        </li>
        <li>
            <a href="#TarhHa" id="lnkTarhHa">تنظیمات طرح های عضویت</a>
        </li>

    </ul>

    <div id="Paye" class="dnnForm">
        <div class="dnnFormItem">
            <dnn:label helptext=" " runat="server" id="lblNahveyeBarkhordBaBedehkarha1" text="نحوه بر خورد با بدهکاری:"></dnn:label>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" cssclass="dnnFixedSizeComboBox" runat="server" id="cbolNahveyeBarkhordBaBedehkari" />
        </div>
        <div class="dnnFormItem">
            <dnn:label helptext=" " runat="server" id="lblNahveyeBarkhordBaBedehkarhaMegdare" text="مقدار مورد نظر برای بر خورد با بدهکارا:"></dnn:label>
            <asp:TextBox runat="server" ID="txtNahveyeBarkhordBaBedehkarhaValue"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label helptext=" " runat="server" id="lblTedadeRoozBadAzAnjamKarBarayeNemayesheNazarsanji"
                       text="تعداد روز بعد از انجام کار برای نمایش نظر سنجی:"></dnn:label>
            <asp:TextBox runat="server" ID="txtTedadeRoozBadAzAnjamKarBarayeNemayesheNazarsanji">
            </asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label helptext=" " runat="server" id="lblTedadeRoozBarayeNemayesheDarDashboardBadAzNemayesheNazarSanji"
                       text="تعداد روز برای نمایش در لیست بعد از نمایش نظر سنجی:"></dnn:label>
            <asp:TextBox runat="server" ID="txtTedadeRoozBarayeNemayesheDarDashboardBadAzNemayesheNazarSanji">
            </asp:TextBox>
        </div>
    </div>
    <div id="Zaher" class="dnnForm">
        <div>
            <div class="dnnFormItem">
                <dnn:label helptext=" " runat="server" id="lblKendoThem" text="تم گرید:"></dnn:label>
                <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" cssclass="dnnFixedSizeComboBox" runat="server" id="cbolKendoThem" />
            </div>
        </div>
        <div>
            <div class="dnnFormItem">
                <dnn:label helptext=" " runat="server" id="lblLableFont" text="فونت لیبل:"></dnn:label>
                <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" cssclass="dnnFixedSizeComboBox" runat="server" id="cbollableFontLable" />
            </div>
            <div class="dnnFormItem">
                <dnn:label helptext=" " runat="server" id="lblLableBackground" text="رنگ فونت لیبل:"></dnn:label>
                <dnn:dnncolorpicker runat="server" id="cpLabelBackground" showicon="True" />
            </div>
            <div class="dnnFormItem">
                <dnn:label helptext=" " runat="server" id="lblLableFontSize" text="اندازه فونت لیبل:"></dnn:label>
                <asp:TextBox runat="server" ID="txtLabelFontSize"></asp:TextBox>
            </div>
        </div>
        <div>
            <div class="dnnFormItem">
                <dnn:label helptext=" " runat="server" id="lblTextBoxFont" text="فونت تکست باکس:"></dnn:label>
                <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" cssclass="dnnFixedSizeComboBox" runat="server" id="cbolTextBoxFontLable" />
            </div>
            <div class="dnnFormItem">
                <dnn:label helptext=" " runat="server" id="lblTextBoxFontColor" text="رنگ فونت تکست باکس:"></dnn:label>
                <dnn:dnncolorpicker runat="server" id="cpTextBoxFontColor" showicon="True" />
            </div>
            <div class="dnnFormItem">
                <dnn:label helptext=" " runat="server" id="lblTextBoxBackgroundColor" text="رنگ فونت پس زمینه تکست باکس:"></dnn:label>
                <dnn:dnncolorpicker runat="server" id="cpTextBoxBackgroundColor" showicon="True" />
            </div>
            <div class="dnnFormItem">
                <dnn:label helptext=" " runat="server" id="lblTextBoxFontSize" text="اندازه فونت تکست باکس:"></dnn:label>
                <asp:TextBox runat="server" ID="txtTextBoxFontSize"></asp:TextBox>
            </div>
            <div class="dnnFormItem">
                <dnn:label helptext=" " runat="server" id="lblTextBoxWidth" text="عرض تکست باکس:"></dnn:label>
                <asp:TextBox runat="server" ID="txtTextBoxWidth"></asp:TextBox>
            </div>
            <div class="dnnFormItem">
                <dnn:label helptext=" " runat="server" id="lblTextBoxHeight" text="ارتفاع تکست باکس:"></dnn:label>
                <asp:TextBox runat="server" ID="txtTextBoxHeight"></asp:TextBox>
            </div>
        </div>
        <div>
            <div class="dnnFormItem">
                <dnn:label helptext=" " runat="server" id="lblLogoFile" text="عکس لوگو:"></dnn:label>
                <asp:FileUpload runat="server" ID="fupLogoFile" />
            </div>
        </div>

    </div>
    <div id="Mali" class="dnnForm">
        <div id="ssbsContent dnnClear">
            <h2 id="dnnSitePanel-SiteDetails" class="dnnFormSectionHead">
                <a href="" class="dnnSectionExpanded">تنظیمات پورسانت</a>
            </h2>
            <fieldset>
                <asp:Repeater ID="rptPoorsant" runat="server">
                    <ItemTemplate>
                        <div class="dnnFormItem">
                            <dnn:label helptext=" " id="lblNoeMoamele" text='<%# (Eval("Name").ToString()) %>' runat="server"></dnn:label>
                            <asp:TextBox ID="txtMegdarePoorsant" Text='<%# (Eval("Megdar").ToString()) %>' runat="server" ToolTip='<%# (Eval("Name").ToString()) %>'></asp:TextBox>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </fieldset>
        </div>
    </div>
    <div id="Darghah" class="dnnForm">
        <div class="dnnFormItem" style="display: none">
            <dnn:label helptext=" " runat="server" id="lblBankName" text="نام بانک:"></dnn:label>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" cssclass="dnnFixedSizeComboBox" runat="server" id="cbolBankName" />
        </div>
        <div class="dnnFormItem">
            <dnn:label helptext=" " runat="server" id="lblShomareTerminal" text="شماره ترمینال:"></dnn:label>
            <asp:TextBox runat="server" ID="txtShomareTerminal"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label helptext=" " runat="server" id="lblShomarePazirande" text="شماره پذیرنده"></dnn:label>
            <asp:TextBox runat="server" ID="txtShomarePazirande"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label helptext=" " runat="server" id="lblKelideEkhtesasi" text="کلید اختصاصی:"></dnn:label>
            <asp:TextBox runat="server" ID="txtKelideEktesasi"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label helptext=" " runat="server" id="lblAddresseBazgashtAzBank" text="آدرس بازگشت از بانک:"></dnn:label>
            <asp:TextBox runat="server" ID="txtAddresseBazgashtAzBank"></asp:TextBox>
        </div>
    </div>
    <div id="SMS" class="dnnForm">
        <div class="dnnFormItem">
            <dnn:label helptext=" " runat="server" id="lblShomareSMS" text="شماره اس ام اس:"></dnn:label>
            <asp:TextBox runat="server" ID="txtShomareSMS"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label helptext=" " runat="server" id="lblAddressUserName" text="نام کاربری:"></dnn:label>
            <asp:TextBox runat="server" ID="txtUserName"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label helptext=" " runat="server" id="lblPassword" text="کلمه عبور:"></dnn:label>
            <asp:TextBox runat="server" ID="txtPassword"></asp:TextBox>
        </div>
    </div>

    <div id="AmaliyatRooyeKarbaran" class="dnnForm">
        <div id="grdUserList" class="k-rtl"></div>
    </div>

    <div id="AmaliyatRooyeHesabeKarbaran" class="dnnForm">
        <div class="userNamelist">
            <div class="dnnFormItem">
                <dnn:label text="لیست نام کاربری کاربران:" helptext=" " runat="server" id="lblStartingPointOstan2" />
                <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" cssclass="UserNameCombo dnnFixedSizeComboBox" filter="Contains" runat="server" id="cbolUserNameList"></dnn:dnncombobox>
            </div>
            <div>
                <div class="dnnFormItem">
                    <dnn:label text="نوع عملیات:" helptext=" " runat="server" id="Label1" />
                    <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolNoeAmaliyatBanki">
                        <Items>
                            <dnn:DnnComboBoxItem runat="server" Text="-- انتخاب نمایید --" Value="-1" Enabled="False" Selected="True"/>
                            <dnn:DnnComboBoxItem runat="server" Text="بدهکاری" Value="0"/>
                            <dnn:DnnComboBoxItem runat="server" Text="بستانکاری" Value="1"/>
                        </Items>
                    </dnn:dnncombobox>
                </div>
                <div class="dnnFormItem">
                    <dnn:label runat="server" text="مبلغ:" helptext=" " id="Label2"></dnn:label>
                    <asp:TextBox runat="server" ID="txtMablag"></asp:TextBox>
                    <dnn:label runat="server" text=" ریال " id="Label4"></dnn:label>
                </div>
                <div class="dnnFormItem">
                    <dnn:label runat="server" text="بابت:" helptext=" " id="Label3"></dnn:label>
                    <asp:TextBox TextMode="MultiLine" runat="server" ID="txtBabate"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="dnnFormItem">
            <asp:LinkButton Text="ثبت" runat="server" CssClass="dnnPrimaryAction" ID="btnUserBanks" />
        </div>
    </div>

    <div id="EtelaResani" class="dnnForm">
        <div class="dnnFormItem dnnFormMessage" style="float: right">
            <dnn:label>
                توکن های قابل استفاده در متن : [JoziyateEstelam] , [TarikheDaryaftePishnahad] , [AddressSite] , [TarikheTaeedPishnahad]
            </dnn:label>
        </div>
        <div class="dnnFormItem">
            <dnn:label id="lblOnvanePishnahad" runat="server" helptext=" " text="متن عنوان ایمیل برای دریافت پیشنهاد جدید:"></dnn:label>
            <asp:TextBox TextMode="MultiLine" ID="txtOnvanePishnahad" runat="server"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label id="lblMatnePishnahad" runat="server" helptext=" " text="متن ایمیل برای دریافت پیشنهاد جدید:"></dnn:label>
            <asp:TextBox TextMode="MultiLine" ID="txtMatnePishnahad" runat="server"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label id="lblMatnePishnahadSMS" runat="server" helptext=" " text="متن اس ام اس برای دریافت پیشنهاد جدید:"></dnn:label>
            <asp:TextBox TextMode="MultiLine" ID="txtMatnePishnahadSMS" runat="server"></asp:TextBox>
        </div>

        <div class="seperator"></div>
        
        <div class="dnnFormItem">
            <dnn:label id="lblOnvaneTaeidPishnahad" runat="server" helptext=" " text="متن عنوان ایمیل برای دریافت تاییدیه پیشنهاد شما:"></dnn:label>
            <asp:TextBox TextMode="MultiLine" ID="txtOnvaneTaeidPishnahad" runat="server"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label id="lblMatneTaeidPishnahad" runat="server" helptext=" " text="متن ایمیل برای دریافت تاییدیه پیشنهاد شما:"></dnn:label>
            <asp:TextBox TextMode="MultiLine" ID="txtMatneTaeidPishnahad" runat="server"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label id="lblMatneTaeidPishnahadSMS" runat="server" helptext=" " text="متن اس ام اس برای دریافت تاییدیه پیشنهاد شما:"></dnn:label>
            <asp:TextBox TextMode="MultiLine" ID="txtMatneTaeidPishnahadSMS" runat="server"></asp:TextBox>
        </div>

        <div class="seperator"></div>

        <div class="dnnFormItem">
            <dnn:label id="lblOnvaneEMailLinkeTaeed" runat="server" helptext=" " text="متن عنوان ایمیل برای لینک تایید حساب کاربری:"></dnn:label>
            <asp:TextBox TextMode="MultiLine" ID="txtOnvaneEMailLinkeTaeed" runat="server"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label id="lblMatneEMailLinkeTaeed" runat="server" helptext=" " text="متن ایمیل برای لینک تایید حساب کاربری:"></dnn:label>
            <asp:TextBox TextMode="MultiLine" ID="txtMatneEMailLinkeTaeed" runat="server"></asp:TextBox>
        </div>
        <%--        <div class="dnnFormItem">--%>
        <%--            <dnn:label id="lblMatneEMailLinkeTaeedSMS" runat="server" helptext=" " text="متن اس ام اس برای لینک تایید حساب کاربری:"></dnn:label>--%>
        <%--            <asp:TextBox TextMode="MultiLine" ID="txtMatneEMailLinkeTaeedSMS" runat="server"></asp:TextBox>--%>
        <%--        </div>--%>
    </div>
    <div class="dnnForm" id="KeshvarShahr">
        <div class="dnnFormItem">
            <dnn:Label HelpText=" " runat="server" Text="لیست کشور ها:" ID="lblListeKeshvarHa"/>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" AutoPostBack="True" Filter="Contains" CssClass="dnnFixedSizeComboBox" runat="server" ID="cbolKeshvarList"/>
        </div>

        <div class="dnnFormItem">
            <dnn:Label HelpText=" " runat="server" Text="لیست شهر ها:" ID="lblListeShahrHa"/>
            <asp:TextBox  runat="server" ID="txtListeShahrha" TextMode="MultiLine"></asp:TextBox>
        </div>
        
        <div class="dnnFormItem fromtop20">
            <asp:LinkButton runat="server" ID="lnkUpdateShahrs" Text="ثبت تغییرات"></asp:LinkButton>
        </div>
    </div>
    <div id="TarhHa" class="dnnForm">
        <div class="contlorlsForTarhs">
            <div class="dnnFormItem">
                <dnn:Label HelpText=" " runat="server" Text="نام طرح:" ID="lblNameTarefe"/>
                <asp:TextBox  runat="server" ID="txtNameTarefe" TextMode="SingleLine"></asp:TextBox>
            </div>
            <div class="dnnFormItem">
                <dnn:Label HelpText=" " runat="server" Text="توضیحات طرح:" ID="lblTozihatTarefe"/>
                <asp:TextBox  runat="server" ID="txtTozihatTarefe" TextMode="SingleLine"></asp:TextBox>
            </div>
            <div class="dnnFormItem">
                <dnn:Label HelpText=" " runat="server" Text="تعداد روز طرح:" ID="lblTedadeRoozeTarefe"/>
                <asp:TextBox  runat="server" ID="txtTedadeRoozeTarefe" TextMode="SingleLine"></asp:TextBox>
            </div>
            <div class="dnnFormItem">
                <dnn:Label HelpText=" " runat="server" Text="هزینه طرح(ریال):" ID="lblHazineyeTarefe"/>
                <asp:TextBox  runat="server" ID="txtHazineyeTarefeTarefe" TextMode="SingleLine"></asp:TextBox>
            </div>
            <div class="dnnFormItem fromtop20">
                <asp:LinkButton runat="server" CssClass="dnnPrimaryAction" ID="lnkUpdateTarhs" Text="افزودن طرح"></asp:LinkButton>
            </div>
        </div>
        <div class="dnnFormItem MyTarhs">
            <div id="grdTarhs" class="k-rtl"></div>
        </div>
    </div>
</div>

<div class="dnnFormItem">
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkUpdate" ValidationGroup="FormValidation" Text="بروز رسانی" runat="server" CssClass="dnnPrimaryAction" resourcekey="lnkSub" />
            </li>
            <li>
                <asp:LinkButton ID="lnkCancel" ValidationGroup="FormValidation" Text="لغو" runat="server" CssClass="dnnSecondaryAction" resourcekey="lnkSub" />
            </li>
        </ul>
    </div>
</div>


<script type="text/javascript" language="javascript">

    $(document).ready(function() {
        $('#dnnDateType').dnnTabs().dnnPanels();
        var sf = $.ServicesFramework(<%= ModuleId %>);
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/GetUserList",
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            bindUserGrid(result);
        }).fail(function(xhr, status, error) {
            alert(error);
        });


        $('#TarhHa').dnnTabs().dnnPanels();
        var sf2 = $.ServicesFramework(<%= ModuleId %>);
        $.ajax({
            type: "GET",
            url: sf2.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/GetTarhs",
            beforeSend: sf2.setModuleHeaders
        }).done(function(result) {
            bindGrdTarhs(result);
        }).fail(function(xhr, status, error) {
            alert(error);
        });

    });

    function bindGrdTarhs(trahsList) {
        $("#grdTarhs").kendoGrid({
            dataSource: {
                data: trahsList,
                pageSize: 10
            },
            height: 450,
            groupable: false,
            resizable: false,
            columnMenu: false,
            scrollable: true,
            sortable: true,
            filterable: false,
            pageable: {
                input: true,
                numeric: true
            },
            columns:
            [
                { title: "آیدی", field: "Id", width: "5px" },
                { title: "نام", field: "Name", width: "35px" },
                { title: "توضیحات", field: "Description", width: "70px" },
                { title: "تعداد روز", field: "DayCount", width: "10px" },
                { title: "قیمت", field: "Price", width: "10px" },
                { title: "نوع", field: "TarhType", width: "10px" },
                {
                    title: "عملیات",
                    width: "10px",
                    template:
                        function(dataItem) {
                            if (dataItem.TarhType == true) {
                                return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='DeleteTarh(" + dataItem.Id + ")'><span class=' '></span>حذف</a>";
                            } else {
                                return "(ʘ‿ʘ)";
                            }
                        }
                }
            ]
        });
    }

    function bindUserGrid(userList) {
        $("#grdUserList").kendoGrid({
            dataSource: {
                data: userList,
                pageSize: 10
            },
            height: 450,
            groupable: true,
            resizable: true,
            columnMenu: true,
            scrollable: true,
            sortable: true,
            filterable: true,
            pageable: {
                input: true,
                numeric: false
            },
            columns: [
                { title: "آیدی", field: "Id", width: "9px" },
//                { title: "وضعیت", field: "StatusPR", width: "15px" },
                { title: "نام", field: "DisplayName", width: "20px" },
//                { title: "قیمت", field: "GeymateKol", width: "20px" },
//                { title: "زمان آمادگی برای شروع", field: "ZamaneAmadegiBarayeShooroo", width: "16px" },
                {
                    title: "تایید",
                    field: "Taeed",
                    width: "20px",
                    template:
                        function(dataItem) {
                            //                            if (dataItem.NazarSanji == "Yes") {
                            return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='ApproveKardan(" + dataItem.Id + ")'><span class=' '></span>تایید کردن کاربر</a>";
                            //                            } else if (dataItem.NazarSanji == "SherkatKarde") {
                            //                                return "<span class=' '>قبلآ در نظر سنجی شرکت نموده اید</span>";
                            //                            } else {
                            //                                return "<span class=' '>زمان شرکت در نظر سنجی فرا نرسیده</span>";
                            //                            }
                            //
                        }
                },
                {
                    title: "صاحب بار",
                    width: "20px",
                    template:
                        function(dataItem) {
                            return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='MakeUserSahebBar(" + dataItem.Id + ")'><span class=' '></span>صاحب بار</a>";
                        }
                },
                {
                    title: "خدمات رسان",
                    width: "20px",
                    template:
                        function(dataItem) {
                            return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='MakeUserKhadamatResan(" + dataItem.Id + ")'><span class=' '></span>خدمات رسان</a>";
                        }
                }
            ]
        });
    }

    function DeleteTarh(id) {
        var sf = $.ServicesFramework(<%= ModuleId %>);
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/DeleteTarh",
            data: { "id": id },
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            $('#TarhHa').dnnTabs().dnnPanels();
            var sf2 = $.ServicesFramework(<%= ModuleId %>);
            $.ajax({
                type: "GET",
                url: sf2.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/GetTarhs",
                beforeSend: sf2.setModuleHeaders
            }).done(function(result) {
                bindGrdTarhs(result);
            }).fail(function(xhr, status, error) {
                alert(error);
            });
        }).fail(function(xhr, status, error) {
            alert("درحال حاضر این طرج برای کاربر یا کاربرانی فعال است. لذا این طرح فعلآ غیر قابل حذف می باشد.");
        });
    }

    function MakeUserSahebBar(id) {
        var url = "/default.aspx?TabId=1142&mid=1536&type=1&UId=" + id + "&IsAdminHand=Yes";
        var win = window.open(url, '_blank');
        win.focus();
    }

    function MakeUserKhadamatResan(id) {
        var url = "/default.aspx?TabId=1142&mid=1536&type=0&UId=" + id + "&IsAdminHand=Yes";
        var win = window.open(url, '_blank');
    }

    function ApproveKardan(id) {
        var sf = $.ServicesFramework(<%= ModuleId %>);
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/MakeUserApprove",
            data: { "id": id },
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            alert("با موفقیت تایید شد.");
        }).fail(function(xhr, status, error) {
            alert("عملیات با خطا مواجه شد.");
        });
    }

    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>