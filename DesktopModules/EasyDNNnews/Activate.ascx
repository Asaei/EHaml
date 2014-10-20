<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Activate, App_Web_activate.ascx.d988a5ac" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<style type="text/css">
	.style1
	{
		width: 100%;
	}
	.style2
	{
		width: 172px;
	}
	.style3
	{
		width: 172px;
		height: 30px;
	}
	.style4
	{
		height: 30px;
	}
</style>
<p>
	<b>EasyDNNnews Activation</b></p>
<table class="style1">
	<tr>
		<td class="style3">
			&nbsp;</td>
		<td class="style4">
			<asp:Label ID="lblUpgradeMessage" runat="server" Text="You have upgraded the module with new version. Please activate it again." Visible="False"></asp:Label>
		</td>
	</tr>
	<tr>
		<td class="style3">
			<dnn:Label ID="lblInvoiceID" runat="server" Text="Please enter invoice id:" HelpText="Enter you invoice id from purchasing the module."></dnn:Label>
		</td>
		<td class="style4">
			<asp:TextBox ID="tbInvoiceID" runat="server" Width="400px" MaxLength="100" ValidationGroup="vgInvoiceID"></asp:TextBox>
			&nbsp;<asp:RequiredFieldValidator ID="rfvInvoiceID" runat="server" ControlToValidate="tbInvoiceID" ErrorMessage="This field id required." ValidationGroup="vgInvoiceID"></asp:RequiredFieldValidator>
		</td>
	</tr>
	<tr>
		<td class="style2">
			&nbsp;
		</td>
		<td>
			<asp:Label ID="lblMessage" runat="server"></asp:Label>
		</td>
	</tr>
	<tr>
		<td class="style2">
			&nbsp;
		</td>
		<td>
			&nbsp;
		</td>
	</tr>
	<tr>
		<td class="style2">
			&nbsp;
		</td>
		<td>
			<asp:Button ID="btnActivate" runat="server" OnClick="btnActivate_Click" Text="Activate" ValidationGroup="vgInvoiceID" Style="height: 26px" />
		</td>
	</tr>
	<tr>
		<td class="style2">
			&nbsp;
		</td>
		<td>
			&nbsp;
		</td>
	</tr>
</table>
