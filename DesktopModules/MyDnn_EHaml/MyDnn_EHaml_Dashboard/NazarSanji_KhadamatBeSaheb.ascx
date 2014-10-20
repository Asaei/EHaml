<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NazarSanji_KhadamatBeSaheb.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Dashboard.NazarSanji_KhadamatBeSaheb" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<div class="dnnForm">
    <div class="dnnFormItem">
        <dnn:Label runat="server" ID="lblSahebBar" Text=":نام صاحب بار"/>
    </div>
    <div class="dnnFormItem">
        <dnn:Label runat="server" HelpText="نظر کلی" ID="lblNazareKoli" Text="نظر کلی:"/>
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolNazarKoli"></dnn:DnnComboBox>
    </div>
    
    <div>
        <div class="dnnFormItem">
            <dnn:Label HelpText="ارتباطات عمومی" runat="server" ID="lblErtebatateOomoomi" Text="ارتباطات عمومی:"/>
            <dnn:DnnRating runat="server" ID="rtgErtebatateOomoomi" Precision="Item" Orientation="Horizontal" SelectionMode="Continuous"/>
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText="صحت اطلاعات استعلام" runat="server" ID="lblSehateEtelaateEstelam" Text="صحت اطلاعات استعلام:"/>
            <dnn:DnnRating runat="server" ID="rtgSehateEtelaateEstelam" Precision="Item" Orientation="Horizontal" SelectionMode="Continuous"/>
        </div>
        <div class="dnnFormItem">
            <dnn:Label HelpText="پرداخت دقیق و به موقع" runat="server" ID="lblPardakhteDaghigVaBeMoghe" Text="پرداخت دقیق و به موقع:"/>
            <dnn:DnnRating runat="server" ID="rtgPardakhteDaghigVaBeMoghe" Precision="Item" Orientation="Horizontal" SelectionMode="Continuous"/>
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