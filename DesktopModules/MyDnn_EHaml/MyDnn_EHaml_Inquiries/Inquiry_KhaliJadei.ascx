<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Inquiry_KhaliJadei.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.Inquiry_KhaliJadei" %>
<%@ Register TagPrefix="dnn" TagName="Label_1" Src="~/controls/labelcontrol.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>


<div class="InquiryVasileyeKhali-Form dnnForm">
    <div class="dnnFormItem">
        <dnn:Label ID="lblInquiryVasileyeKhaliTitle" Text="استعلام وسیله حمل خالی" runat="server"></dnn:Label>
    </div>
    <div class="dnnFormItem">
        <dnn:Label ID="lblDarkhastKonande" runat="server"></dnn:Label>
        <dnn:Label ID="lblDarkhastKonandeValue" runat="server"></dnn:Label>
    </div>
    
    <asp:Repeater ID="rptNoeContiner" runat="server">
        <ItemTemplate>
            <div class="dnnFormItem">
                <dnn:Label ID="lblName" Text='<%# (Eval("VasileName").ToString()) %>' runat="server" ></dnn:Label>
            </div>
            <div class="dnnFormItem">
                <dnn:Label ID="lblTedad" Text="تعداد:" runat="server" ></dnn:Label>
                <asp:TextBox ID="txtTedad" runat="server" ToolTip='<%# (Eval("VasileName").ToString()) %>'></asp:TextBox>
            </div>
            <div class="dnnFormItem">
                <dnn:Label ID="lblShahr" Text="شهر:" runat="server" ></dnn:Label>
                <asp:TextBox ID="txtShahr" runat="server"></asp:TextBox>
            </div>
            <div class="dnnFormItem">
                <dnn:Label ID="lblZamaneAmadegi" Text="زمان آمادگی:" runat="server" ></dnn:Label>
                <dnn:DnnDatePicker runat="server" ID="dtpZamaneAmadegi"></dnn:DnnDatePicker>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    
    <div class="dnnFormItem">
        <asp:CheckBox runat="server" Text="خواهان ارسال استعلام خود برای شرکت های خارج از ایران(غیر ایرانی) هستم." ID="chkKhahaneErsalEstelamBeKharej"/>
    </div>
    <div class="dnnFormItem">
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="lnkSubmit" ValidationGroup="InquiryVasileyeKhali-Form" runat="server" CssClass="dnnPrimaryAction" resourcekey="lnkSubmit" />
            </li>
        </ul>
    </div>
</div>