<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings2.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Dashboard.Settings2" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>

<div class="GeneralListSettings">
    <div class="dnnFormItem">
        <dnn:Label ID="lblKendoNemayesh" runat="server" Text="'گرید برای نمایش:" HelpText="" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" ID="cbolKendoNemayesh" runat="server">
            <Items>
                <dnn:DnnComboBoxItem runat="server" Text="استعلامات فعال" Value="استعلامات فعال"/>
                <dnn:DnnComboBoxItem runat="server" Text="استعلامات قبلی" Value="استعلامات قبلی"/>
                <dnn:DnnComboBoxItem runat="server" Text="معاملات موفق/نظرسنجی" Value="معاملات موفق/نظرسنجی"/>
            </Items>
        </dnn:DnnComboBox>
    </div>
</div>