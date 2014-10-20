<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserInfo.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Dashboard.MyDnn_EHaml_UserInfo" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:dnncssinclude id="DnnCssInclude1" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.common.min.css" />
<dnn:dnncssinclude id="DnnCssInclude2" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.default.min.css" />
<dnn:dnncssinclude id="DnnCssInclude3" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.rtl.min.css" />
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

<div class="dnnForm">
    <asp:Panel runat="server" ID="pnlUserInfo" CssClass="PaneleUserInfo">
        <div class="dnnFormItem">
            <dnn:label runat="server" text="نام: " id="lblName"></dnn:label>
            <asp:TextBox Enabled="False" runat="server" ID="txtName"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label runat="server" text="نام شرکت: " id="lblNameSherkat"></dnn:label>
            <asp:TextBox Enabled="False" runat="server" ID="txtNameSherkat"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label runat="server" text="آدرس: " id="lblAddress"></dnn:label>
            <asp:TextBox Enabled="False" runat="server" ID="txtAddress"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label runat="server" text="شماره تلفن ثابت: " id="lblTell"></dnn:label>
            <asp:TextBox Enabled="False" runat="server" ID="txtTell"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label runat="server" text="شماره موبایل: " id="lblCell"></dnn:label>
            <asp:TextBox Enabled="False" runat="server" ID="txtCell"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label runat="server" text="آدرس ایمیل: " id="lblEmail"></dnn:label>
            <asp:TextBox Enabled="False" runat="server" ID="txtEmail"></asp:TextBox>
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlNazarSanjiSahebDetail" runat="server" CssClass="PaneleNazarSanjiSahebDetail" Visible="False">
        <div class="dnnFormItem">
            <dnn:label runat="server" helptext=" " id="lblGodrat" text="قدرت: " />
            <asp:TextBox Enabled="False" runat="server" ID="txtGodrat"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label runat="server" helptext="تعداد نظرات: " id="lblTedadeNazarat" text="تعداد نظرات:" />
            <asp:TextBox Enabled="False" runat="server" ID="txtTedadeNazarat"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label runat="server" helptext="نظر کلی" id="lblNazareKoli" text="نظر کلی: " />
            <asp:TextBox Enabled="False" runat="server" ID="txtNazarKoliKhob"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label runat="server" helptext="نظر کلی" id="lblNazareKoliBad" text="نظر کلی: " />
            <asp:TextBox Enabled="False" runat="server" ID="txtNazareKoliBad"></asp:TextBox>
        </div>
        <div>
            <div class="dnnFormItem">
                <dnn:label helptext="ارتباطات عمومی" runat="server" id="lblErtebatateOomoomi" text="ارتباطات عمومی:" />
                <dnn:DnnRating Enabled="False" runat="server" id="rtgErtebatateOomoomi" precision="Exact" orientation="Horizontal" selectionmode="Continuous" />
            </div>
            <div class="dnnFormItem">
                <dnn:label helptext="صحت اطلاعات استعلام" runat="server" id="lblSehateEtelaateEstelam" text="صحت اطلاعات استعلام:" />
                <dnn:DnnRating Enabled="False" runat="server" id="rtgSehateEtelaateEstelam" precision="Exact" orientation="Horizontal" selectionmode="Continuous" />
            </div>
            <div class="dnnFormItem">
                <dnn:label helptext="پرداخت دقیق و به موقع" runat="server" id="lblPardakhteDaghigVaBeMoghe" text="پرداخت دقیق و به موقع:" />
                <dnn:DnnRating Enabled="False" runat="server" id="rtgPardakhteDaghigVaBeMoghe" precision="Exact" orientation="Horizontal" selectionmode="Continuous" />
            </div>

        </div>
    </asp:Panel>
    <asp:Panel ID="pnlNazarSanjiKhedmatDetail" runat="server" CssClass="PaneleNazarSanjiKhedmatDetail" Visible="False">
        <div class="dnnFormItem">
            <dnn:label runat="server" helptext=" " id="lblGodratKh" text="قدرت: " />
            <asp:TextBox Enabled="False" runat="server" ID="txtGodratKh"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label runat="server" helptext="تعداد نظرات: " id="lblTedadeNazaratKh" text="تعداد نظرات:" />
            <asp:TextBox Enabled="False" runat="server" ID="txtTedadeNazaratKh"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label runat="server" helptext="نظر کلی" id="lblNazareKoliKh" text="نظر کلی: " />
            <asp:TextBox Enabled="False" runat="server" ID="txtNazareKoliKh"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:label runat="server" helptext="نظر کلی" id="lblNazareKoliBadKh" text="نظر کلی: " />
            <asp:TextBox Enabled="False" runat="server" ID="txtlblNazareKoliBadKh"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:Label runat="server" HelpText="ارتباطات عمومی" ID="Label1" Text="ارتباطات عمومی:"/>
            <dnn:DnnRating Enabled="False" runat="server" ID="rtgErtebatateOomoomiKh" Precision="Exact" Orientation="Horizontal" SelectionMode="Continuous"/>
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText="دقت در انجام مسئولیت ها" runat="server" ID="lblDeghatDarAnjameMasooliyatha" Text="دقت در انجام مسئولیت ها:"/>
            <dnn:DnnRating Enabled="False" runat="server" ID="rtgDeghatDarAnjameMasooliyatha" Precision="Exact" Orientation="Horizontal" SelectionMode="Continuous"/>
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText="پایبندی به گفته ها" runat="server" ID="lblPaybandiBeGofteha" Text="پایبندی به گفته ها:"/>
            <dnn:DnnRating Enabled="False" runat="server" ID="rtgPaybandiBeGofteha" Precision="Exact" Orientation="Horizontal" SelectionMode="Continuous"/>
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText="پایبندی به تعهد زمانی" runat="server" ID="lblPaybandiBeTaahodeZamani" Text="پایبندی به تعهد زمانی:"/>
            <dnn:DnnRating Enabled="False" runat="server" ID="rtgPaybandiBeTaahodeZamani" Precision="Exact" Orientation="Horizontal" SelectionMode="Continuous"/>
        </div>
        <div class="dnnFormItem">
            <dnn:Label runat="server" HelpText="پایبندی به تعهد قیمتی" ID="lblPaybandiBeTaahodeGeymati" Text="پایبندی به تعهد قیمتی:"/>
            <dnn:DnnRating Enabled="False" runat="server" ID="rtgPaybandiBeTaahodeGeymati" Precision="Exact" Orientation="Horizontal" SelectionMode="Continuous"/>
        </div>
    </asp:Panel>
</div>