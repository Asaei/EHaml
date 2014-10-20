<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NazarSanji_SahebBeKhadamat.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Dashboard.NazarSanji_SahebBeKhadamat" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<div class="dnnForm">
    <div class="dnnFormItem">
        <dnn:Label runat="server" ID="lblKhadamatResan" Text=":نام خدمات رسان"/>
    </div>
    <div class="dnnFormItem">
        <dnn:Label HelpText="نظر کلی" runat="server" ID="lblNazareKoli" Text="نظر کلی:"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolNazarKoli"></dnn:DnnComboBox>
    </div>
    
    <div>
        <div class="dnnFormItem">
            <dnn:Label runat="server" HelpText="ارتباطات عمومی" ID="lblErtebatateOomoomi" Text="ارتباطات عمومی:"/>
            <dnn:DnnRating runat="server" ID="rtgErtebatateOomoomi" Precision="Item" Orientation="Horizontal" SelectionMode="Continuous"/>
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText="دقت در انجام مسئولیت ها" runat="server" ID="lblDeghatDarAnjameMasooliyatha" Text="دقت در انجام مسئولیت ها:"/>
            <dnn:DnnRating runat="server" ID="rtgDeghatDarAnjameMasooliyatha" Precision="Item" Orientation="Horizontal" SelectionMode="Continuous"/>
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText="پایبندی به گفته ها" runat="server" ID="lblPaybandiBeGofteha" Text="پایبندی به گفته ها:"/>
            <dnn:DnnRating runat="server" ID="rtgPaybandiBeGofteha" Precision="Item" Orientation="Horizontal" SelectionMode="Continuous"/>
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText="پایبندی به تعهد زمانی" runat="server" ID="lblPaybandiBeTaahodeZamani" Text="پایبندی به تعهد زمانی:"/>
            <dnn:DnnRating runat="server" ID="rtgPaybandiBeTaahodeZamani" Precision="Item" Orientation="Horizontal" SelectionMode="Continuous"/>
        </div>
        <div class="dnnFormItem">
            <dnn:Label runat="server" HelpText="پایبندی به تعهد قیمتی" ID="lblPaybandiBeTaahodeGeymati" Text="پایبندی به تعهد قیمتی:"/>
            <dnn:DnnRating runat="server" ID="rtgPaybandiBeTaahodeGeymati" Precision="Item" Orientation="Horizontal" SelectionMode="Continuous"/>
        </div>

    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmit" runat="server" CssClass="dnnPrimaryAction" Text="ثبت نظر" />
            </li>
        </ul>
    </div>
</div>