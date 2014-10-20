<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_GeneralList.Settings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>

    <div class="GeneralListSettings">
        <div class="dnnFormItem">
            <dnn:Label ID="lblTemplate" runat="server" Text="تمپلیت:" HelpText="" />
            <asp:TextBox TextMode="MultiLine" runat="server" ID="txtTemplate"/>
        </div>
        <div class="dnnFormItem">
            <dnn:Label ID="lblTartibeNemayesh" runat="server" Text="ترتیب نمایش:" HelpText="" />
            <dnn:DnnComboBox ID="cbolTartibeNemayesh" runat="server"></dnn:DnnComboBox>
        </div>
        <div class="dnnFormItem">
            <dnn:Label ID="lblTedadeNemayesh" runat="server" Text="تعداد نمایش:" HelpText="" />
            <asp:TextBox runat="server" ID="txtTedadeNemayesh"/>
        </div>
        <div class="dnnFormItem">
            <dnn:Label ID="lblPaging" runat="server" Text="تعداد نمایش در هر صفحه:" HelpText="" />
            <asp:TextBox runat="server" ID="txtPagingSize"/>
        </div>

    </div>