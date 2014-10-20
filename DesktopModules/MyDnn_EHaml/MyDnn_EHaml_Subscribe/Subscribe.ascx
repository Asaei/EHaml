<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Subscribe.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Subscribe.Subscribe" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>

<div class="Register-Form dnnForm">
    <asp:Panel runat="server" ID="pnlRegular">
        <div class="dnnFormItem">
            <dnn:label helptext=" " text="نام:" id="lblFirstNamea" runat="server"></dnn:label>
            <dnn:label id="lblFirstName" runat="server"></dnn:label>
        </div>
        <div class="dnnFormItem">
            <dnn:label helptext=" " text="نام خانوادگی:" id="lblLastNamea" runat="server"></dnn:label>
            <dnn:label id="lblLastName" runat="server"></dnn:label>
        </div>
        <div class="dnnFormItem">
            <dnn:label helptext=" " text="Email:" id="lblEmaila" runat="server"></dnn:label>
            <dnn:label id="lblEmail" runat="server"></dnn:label>
        </div>

        <div class="dnnFormItem">
            <dnn:label helptext=" " text="طرح عضویت:" id="lblHagigiYaHoogoogiTypea" runat="server"></dnn:label>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolPlanNameType" cssclass="dnnFixedSizeComboBox"  />
            <%--        <asp:CompareValidator ValidationGroup="FormValidation" ID="cvCbolPlanName" CssClass="dnnFormMessage dnnFormError"
                              runat="server" Operator="NotEqual" Type="String" Display="Dynamic" ValueToCompare="-- انتخاب نماييد --"
                              ControlToValidate="cbolHagigiYaHoogoogiType" resourcekey="ErrorMessage" />--%>
        </div>
        <div class="dnnFormItem" style="display: none">
            <dnn:label text="نحوه پرداخت:" id="lblNahveyePardakht" runat="server"></dnn:label>
            <dnn:DnnComboBox EmptyMessage="-- انتخاب نماييد --" runat="server" id="cbolNahveyePardakht" cssclass="dnnFixedSizeComboBox" />
            <%--        <asp:CompareValidator ValidationGroup="FormValidation" ID="cvCbolPlanName" CssClass="dnnFormMessage dnnFormError"
                              runat="server" Operator="NotEqual" Type="String" Display="Dynamic" ValueToCompare="-- انتخاب نماييد --"
                              ControlToValidate="cbolHagigiYaHoogoogiType" resourcekey="ErrorMessage" />--%>
        </div>
        <div class="dnnFormItem">
            <ul class="dnnActions dnnClear">
                <li>
                    <asp:LinkButton ID="lnkSub" ValidationGroup="FormValidation" Text="پرداخت حق عضویت" runat="server" CssClass="dnnPrimaryAction" resourcekey="lnkSub" />
                </li>
            </ul>
        </div>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlAfterPayment" Visible="False">
        <asp:Label runat="server" ID="lblMessage"></asp:Label>
    </asp:Panel>
    <ul style="margin: 0;">
        <li style="list-style-type: none; text-align: left;">
            <asp:LinkButton ID="lnkReturn" ValidationGroup="FormValidation" Text="بازگشت به سایت" runat="server" CssClass="dnnSecondaryAction" resourcekey="lnkSub" />
        </li>
    </ul>
</div>