<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Widgets.Settings, App_Web_settings.ascx.c7240fce" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div id="EDNadmin">
	<div class="module_settings">
		<div class="settings_category_container">
			<div class="category_toggle">
				<h2>
					<%=NewsCategorymenu%></h2>
			</div>
			<div class="category_content">
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblSelectViewControl" runat="server" Text="Select widget:" HelpText="Select advanced control for viewing news module items." ResourceKey="lblSelectViewControl" />
						</td>
						<td class="right">
							<asp:RadioButtonList ID="rblViewControls" runat="server" onselectedindexchanged="rblViewControls_SelectedIndexChanged">
								<asp:ListItem ResourceKey="liTreeview" Text="Tree view" Selected="True" Value="1" />
							</asp:RadioButtonList>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<asp:PlaceHolder ID="phSelectedControlSettings" runat="server"></asp:PlaceHolder>
	</div>
</div>
