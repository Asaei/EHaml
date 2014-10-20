<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="InquirySettings.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.InquirySettings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>

<div class="dnnForm">
    <div class="dnnFormItem">
        <dnn:Label ID="lblNoeInquiry" runat="server" ssClass="dnnFormRequired" Text="نوع استعلام جهت نمایش در لیست:" HelpText="نوع استعلام جهت نمایش در لیست" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolNoeEstelam"/>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblNameControl" runat="server" ssClass="dnnFormRequired" Text="نام کنترل:" HelpText="نام کنترل" />
        <asp:TextBox runat="server" ID="txtNameControl"/>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblDefaultControl" runat="server" ssClass="dnnFormRequired" Text="کنترل پیش فرض:" HelpText="کنترل پیشفرض را انتخاب نمایید" />
        <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" ID="cbolDefaultControl"/>
    </div>
    
    <%--    <div class="GeneralListSettings">--%>
    <%--        <div class="dnnFormItem">--%>
    <%--            <dnn:Label ID="lblTemplate" runat="server" Text="تمپلیت:" HelpText="" />--%>
    <%--            <asp:TextBox TextMode="MultiLine" runat="server" ID="txtTemplate"/>--%>
    <%--        </div>--%>
    <%--        <div class="dnnFormItem">--%>
    <%--            <dnn:Label ID="lblTartibeNemayesh" runat="server" Text="ترتیب نمایش:" HelpText="" />--%>
    <%--            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" ID="cbolTartibeNemayesh" runat="server"></dnn:DnnComboBox>--%>
    <%--        </div>--%>
    <%--        <div class="dnnFormItem">--%>
    <%--            <dnn:Label ID="lblTedadeNemayesh" runat="server" Text="تعداد نمایش:" HelpText="" />--%>
    <%--            <asp:TextBox runat="server" ID="txtTedadeNemayesh"/>--%>
    <%--        </div>--%>
    <%--        <div class="dnnFormItem">--%>
    <%--            <dnn:Label ID="lblPaging" runat="server" Text="تعداد نمایش در هر صفحه:" HelpText="" />--%>
    <%--            <asp:TextBox runat="server" ID="txtPagingSize"/>--%>
    <%--        </div>--%>
    <%----%>
    <%--    </div>--%>
</div>