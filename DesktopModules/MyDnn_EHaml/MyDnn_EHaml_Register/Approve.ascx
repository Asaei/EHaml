<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Approve.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Register.Approve" %>
<%@ Register TagPrefix="dnn" TagName="Label_1" Src="~/controls/labelcontrol.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>

<div class="dnnForm">
    <asp:Panel CssClass="pnlSomeThingWrong" runat="server" ID="pnlSomeThingWrong" Visible="False">
        <asp:Label runat="server" ID="lblSomeThinsWrong">متاسفانه خطایی در فعال سازی حساب کاربری شما به وجود آمده است.</asp:Label>
    </asp:Panel>
    <asp:Panel CssClass="lblThingsAreOk" runat="server" ID="pnlOk">
        <asp:Label runat="server" ID="lblThingsAreOk">حساب کاربری شما با موفقیت فعال شد.</asp:Label>
        <div class="dnnFormItem" style="margin-top: 15px">
            <asp:LinkButton runat="server" CssClass="dnnPrimaryAction" ID="btnKharideTarh">خرید طرح عضویت</asp:LinkButton>
            <asp:LinkButton runat="server" CssClass="dnnSecondaryAction" ID="btnBazgasht">بازگشت به سایت</asp:LinkButton>
        </div>
    </asp:Panel>
    <asp:Panel CssClass="pnlLoginKonAhmagh" runat="server" ID="pnlLoginKonAhmagh" Visible="False">
        <asp:Label runat="server" ID="lblLoginKonDoctor">لطفآ ابتدا در سایت وارد شوید و دوباره اقدام نمایید.</asp:Label>
    </asp:Panel>
</div>