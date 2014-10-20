<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ElamiyeSettings.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Elamiye.ElamiyeSettings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>

<div class="dnnForm">
    <div class="dnnFormItem">
        <dnn:Label ID="lblNoeElamiye" runat="server" ssClass="dnnFormRequired" Text="نوع اعلامیه جهت نمایش در لیست:" HelpText="نوع اعلامیه جهت نمایش در لیست" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolNoeElamiye"/>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblNameControl" runat="server" ssClass="dnnFormRequired" Text="نام کنترل:" HelpText="نام کنترل" />
        <asp:TextBox runat="server" ID="txtNameControl"/>
    </div>
    
    <div class="dnnFormItem">
        <dnn:Label ID="lblDefaultControl" runat="server" ssClass="dnnFormRequired" Text="کنترل پیش فرض:" HelpText="کنترل پیشفرض را انتخاب نمایید" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolDefaultControl"/>
    </div>
</div>