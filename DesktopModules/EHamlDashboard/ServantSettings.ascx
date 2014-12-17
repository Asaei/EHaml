<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ServantSettings.ascx.cs" Inherits="EHamlDashboard.ServantSettings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>

<div class="GeneralListSettings">
    <div class="dnnFormItem">
        <dnn:Label ID="lblKendoNemayesh" runat="server" Text="'گرید برای نمایش:" HelpText="" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" ID="cbolKendoNemayesh" runat="server">
            <Items>
                <dnn:DnnComboBoxItem runat="server" Text="پاسخ به استعلامات فعال" Value="پاسخ به استعلامات فعال"/>
                <dnn:DnnComboBoxItem runat="server" Text="پاسخ به استعلامات قبلی" Value="پاسخ به استعلامات قبلی"/>
                <dnn:DnnComboBoxItem runat="server" Text="معاملات موفق/نظرسنجی" Value="معاملات موفق/نظرسنجی"/>
            </Items>
        </dnn:DnnComboBox>
    </div>
</div>
