<%@ control language="C#" inherits="EasyDNN.Modules.EasyDNNNewsCalendar.EditEasyDNNNewsCalendar, App_Web_editeasydnnnewscalendar.ascx.3e42803b" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<script type="text/javascript">
/* <![CDATA[ */
	jQuery().ready(function ($) {
		$('#<%=tvCatAndSubCat.ClientID %>').EDS_TreeViewSelector({
			state_checkbox: $('#<%=cbAutoAddCatChilds.ClientID %>')
		});
		$('#<%=cbShowCalendarArchive.ClientID%>, #<%=cbShowMonthlyArchive.ClientID%>, #<%=cbShowEventArchive.ClientID%>, #<%=cbDisplayHeaderEvents.ClientID%>, #<%=cbShowEvents.ClientID%>, #<%=cbIsTooltipEnabled.ClientID%>, #<%=cbUpcomingEventsToolTip.ClientID%> ').change(function () {
			var $target = $('.collapsable_container.' + this.id);

			if( this.id == '<%=cbShowEvents.ClientID %>')
			{
				if(this.checked){
					var myVal = document.getElementById('<%=rfvPastEventLimit.ClientID %>'); ValidatorEnable(myVal, true);
					var myVal2 = document.getElementById('<%=cvPastEventLimit.ClientID %>'); ValidatorEnable(myVal2, true);
				}
				else{
					var myVal = document.getElementById('<%=rfvPastEventLimit.ClientID %>'); ValidatorEnable(myVal, false);
					var myVal2 = document.getElementById('<%=cvPastEventLimit.ClientID %>'); ValidatorEnable(myVal2, false);
				}
			}
			else if( this.id == '<%=cbIsTooltipEnabled.ClientID %>')
			{
				if(this.checked){
					var myVal = document.getElementById('<%=rfvCalendarTooltipSummaryLenght.ClientID %>'); ValidatorEnable(myVal, true);
					var myVal2 = document.getElementById('<%=rvCalendarTooltipSummaryLenght.ClientID %>'); ValidatorEnable(myVal2, true);
				}
				else{
					var myVal = document.getElementById('<%=rfvCalendarTooltipSummaryLenght.ClientID %>'); ValidatorEnable(myVal, false);
					var myVal2 = document.getElementById('<%=rvCalendarTooltipSummaryLenght.ClientID %>'); ValidatorEnable(myVal2, false);
				}
			}
			else if( this.id == '<%=cbUpcomingEventsToolTip.ClientID %>')
			{
				if(this.checked){
					var myVal = document.getElementById('<%=rfvUpcomingEventsTTSummaryLenght.ClientID %>'); ValidatorEnable(myVal, true);
					var myVal2 = document.getElementById('<%=rvUpcomingEventsTTSummaryLenght.ClientID %>'); ValidatorEnable(myVal2, true);
				}
				else{
					var myVal = document.getElementById('<%=rfvUpcomingEventsTTSummaryLenght.ClientID %>'); ValidatorEnable(myVal, false);
					var myVal2 = document.getElementById('<%=rvUpcomingEventsTTSummaryLenght.ClientID %>'); ValidatorEnable(myVal2, false);
				}
			}
			if (this.checked)
				$target.slideDown(200);
			else
				$target.slideUp(200);
		});
	});
	function ClientValidate(source, arguments) {
		var treeView = document.getElementById("<%= tvCatAndSubCat.ClientID %>");
		var checkBoxes = treeView.getElementsByTagName("input");
		var checkedCount = 0;
		for (var i = 0; i < checkBoxes.length; i++) {
			if (checkBoxes[i].checked) {
				checkedCount++;
				break;
			}
		}
		if (checkedCount > 0) {
			arguments.IsValid = true;
		} else {
			arguments.IsValid = false;
		}
	}

	function ClientValidateAuthors(source, arguments) {
		var treeView = document.getElementById("<%= tvAuthorAndGroupSelection.ClientID %>");
		var checkBoxes = treeView.getElementsByTagName("input");
		var checkedCount = 0;
		for (var i = 0; i < checkBoxes.length; i++) {
			if (checkBoxes[i].checked) {
				checkedCount++;
				break;
			}
		}
		if (checkedCount > 0) {
			arguments.IsValid = true;
		} else {
			arguments.IsValid = false;
		}
	}
/* ]]> */
</script>
<div id="EDNadmin">
	<div class="module_settings">
		<div class="settings_category_container last">
			<div class="category_toggle">
				<h2>
					<%=Calendarsettings%></h2>
			</div>
			<div class="category_content">
				<div id="pnlSocialInstance" runat="server" style="display: none;">
					<table class="settings_table" cellpadding="0" cellspacing="0">
						<tr id="Tr1" runat="server" style="background: #D1EBFA;">
							<td class="left" style="border: 1px solid #AAD6F1; border-right: 0;">
								<dnn:Label ID="lblIsSocialInstance" runat="server" Text="Community mode:" HelpText="Displays user's and group's articles on the Activity feed. The articles are filtered by the UserID or GroupID querystring. If this option is enabled and the querystring
				UserID or GroupID is missing, then the articles won't show up." ControlName="cbIsSocialInstance" ResourceKey="lblIsSocialInstance" HelpKey="lblIsSocialInstance.HelpText" EnableViewState="True" />
							</td>
							<td class="right" style="border: 1px solid #AAD6F1; border-left: 0;">
								<asp:CheckBox ID="cbIsSocialInstance" runat="server" Checked="false" OnCheckedChanged="cbIsSocialInstance_CheckedChanged" AutoPostBack="true" />
							</td>
						</tr>
					</table>
				</div>
				<div id="pnlPortalSharing" runat="server">
					<h3 class="subsections">
						<%=Portalsharing%></h3>
					<table class="settings_table" cellpadding="0" cellspacing="0">
						<tr>
							<td class="left">
								<dnn:Label ID="lblPortalSharing" runat="server" Text="Select portal:" HelpText="Select data source portal." ControlName="ddlPortalSharing" HelpKey="lblPortalSharing.HelpText" ResourceKey="lblPortalSharing" />
							</td>
							<td class="right">
								<asp:DropDownList ID="ddlPortalSharing" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataTextField="PortalName" DataValueField="PortalIDFrom" CssClass="ddlcategorysettings" OnSelectedIndexChanged="ddlPortalSharing_SelectedIndexChanged">
									<asp:ListItem resourcekey="liCurrentPortal" Value="-1">Current portal</asp:ListItem>
								</asp:DropDownList>
							</td>
						</tr>
					</table>
				</div>
				<h3 class="subsections">
					<%=Permissions%></h3>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblPermissionSource" runat="server" Text="Select permission source:" HelpText="Category menu will inherit permission from selected source. Articles from allow categories will be shown in module." HelpKey="lblPermissionSource" ResourceKey="lblPermissionSource" />
						</td>
						<td class="right">
							<asp:RadioButtonList ID="rblCategoryPermissionSource" runat="server" OnSelectedIndexChanged="rblCategoryPermissionSource_SelectedIndexChanged" AutoPostBack="True" RepeatDirection="Horizontal">
								<asp:ListItem Selected="True" Text="None" Value="0" resourcekey="ListItemResource1"></asp:ListItem>
								<asp:ListItem Text="Portal" Value="1" resourcekey="ListItemResource2"></asp:ListItem>
								<asp:ListItem Text="Module" Value="2" resourcekey="ListItemResource3"></asp:ListItem>
							</asp:RadioButtonList>
							<asp:Panel ID="pnlCategoryModuleInherite" runat="server" Visible="False">
								<asp:DropDownList ID="ddlPermFromModuleInstance" runat="server" />
							</asp:Panel>
						</td>
					</tr>
				</table>
				<h3 class="subsections">
					<%=Modulespecificoptions%></h3>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr style="background: #D1EBFA;">
						<td class="left" style="border: 1px solid #AAD6F1; border-right: 0;">
							<dnn:Label ID="lblShowCalendar" runat="server" Text="Show calendar:" HelpText="Displays calendar with marked article publish dates. " ControlName="cbShowCalendarArchive" HelpKey="lblShowCalendar.HelpText" ResourceKey="lblShowCalendar" />
						</td>
						<td class="right" style="border: 1px solid #AAD6F1; border-left: 0;">
							<asp:CheckBox ID="cbShowCalendarArchive" runat="server" />
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="tblCollapsable1" class="collapsable_container <%=cbShowCalendarArchive.ClientID%>" style="border: 1px solid #717171; border-top: 0; margin-bottom: 10px; <%=cssTableStyleCalendar%>">
								<table class="settings_table" cellpadding="0" cellspacing="0">
									<tr class="second">
										<td class="left">
											<dnn:Label ID="lblSelectCalendarType" runat="server" Text="Calendar type:" HelpText="Select type of calendar to display." ControlName="rblCalendarType" ResourceKey="lblSelectCalendarType" HelpKey="lblSelectCalendarType.HelpText" />
										</td>
										<td class="right">
											<asp:RadioButtonList ID="rblCalendarType" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblCalendarType_SelectedIndexChanged" AutoPostBack="true">
												<asp:ListItem Value="1" Text="Simple" Selected="True" />
												<asp:ListItem Value="2" Text="Advanced" />
											</asp:RadioButtonList>
										</td>
									</tr>
									<tr>
										<td class="left">
											<dnn:Label ID="lblSelectArticleEvents" runat="server" Text="Select article or events:" HelpText="Select article and/or events to show in calendar." ControlName="cbShowCalendarArchive" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbShowArticles" runat="server" resourcekey="cbShowArticlesCalendarArchiveResource1" Checked="True" Text="Articles" AutoPostBack="True" OnCheckedChanged="cbShowArticles_CheckedChanged" />
											<asp:CheckBox ID="cbShowEvents" runat="server" resourcekey="cbShowEventsCalendarArchiveResource1" Text="Events (Start to end date)" />
											<asp:CheckBox ID="cbShowEventsBypublishDate" runat="server" resourcekey="cbShowEventsBypublishDate" Text="Events (Publish date)" />
										</td>
									</tr>
									<tr runat="server" id="trLimitBackwordsEvents">
										<td class="left">
											<dnn:Label ID="lblLimitBackwordsEvents" runat="server" Text="Specify display of past events:" HelpText="Specify display of past events:" HelpKey="lblLimitBackwordsEvents.HelpText" ResourceKey="lblLimitBackwordsEvents" />
										</td>
										<td class="right">
											<asp:RadioButtonList ID="rblLimitBackEvents" Style="float: left" runat="server" RepeatDirection="Horizontal">
												<asp:ListItem resourcekey="liShowAll" Value="All" Text="Show All" />
												<asp:ListItem resourcekey="liLimitNumber" Value="Limit" Selected="True" Text="Limit to number of days:" />
											</asp:RadioButtonList>
											<asp:TextBox Style="float: left" ID="tbPastEventLimit" runat="server" Width="25px" Text="0" />
											<asp:RequiredFieldValidator ID="rfvPastEventLimit" runat="server" ForeColor="Red" ControlToValidate="tbPastEventLimit" ErrorMessage="This filed is required." meta:resourcekey="rfvRhumbImageWidthResource1" SetFocusOnError="True" ValidationGroup="vgCalSettings"
												Display="Dynamic" />
											<asp:CompareValidator ID="cvPastEventLimit" runat="server" ForeColor="Red" ControlToValidate="tbPastEventLimit" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfItemsResource1.ErrorMessage"
												Type="Integer" ValidationGroup="vgCalSettings" />
										</td>
									</tr>
									<tr>
										<td class="left">
											<dnn:Label ID="lblIsTooltipEnabled" runat="server" Text="Enable tooltip:" HelpText="On calendar cell mouse hover short details are displayed in tooltip." ControlName="cbIsTooltipEnabled" ResourceKey="lblIsTooltipEnabled" HelpKey="lblIsTooltipEnabled.HelpText" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbIsTooltipEnabled" runat="server" />
										</td>
									</tr>
								</table>
								<table class="settings_table" cellpadding="0" cellspacing="0" runat="server" id="tblAdvancedCalOptions" visible="false">
									<tr class="second">
										<td class="left">
											<dnn:Label ID="lblNumOfItemsInCell" runat="server" Text="Limit cell items per day:" HelpText="Limit number of items to display in cell. 0 is for all." ControlName="tbxNumOfItemsInCell" ResourceKey="lblNumOfItemsInCell" HelpKey="lblNumOfItemsInCell.HelpText" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbxNumOfItemsInCell" runat="server" Width="30px" Text="4" />
											<asp:RequiredFieldValidator ID="rfvNumOfItemsInCell" runat="server" ForeColor="Red" ControlToValidate="tbxNumOfItemsInCell" ErrorMessage="Required value" />
											<asp:RangeValidator ID="rvNumOfItemsInCell" runat="server" ForeColor="Red" ControlToValidate="tbxNumOfItemsInCell" ErrorMessage="Range not valid (0 - 100)" MinimumValue="0" MaximumValue="100" Type="Integer" />
										</td>
									</tr>
									<tr>
										<td class="left">
											<dnn:Label ID="lblTitleLenght" runat="server" Text="Limit lenght of article/event title:" HelpText="Limit lenght of title in cell to specified num of characters (0 - show all)." ControlName="tbxTitleLenght" ResourceKey="lblTitleLenght" HelpKey="lblTitleLenght.HelpText" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbxTitleLenght" runat="server" Width="30px" Text="0" />
											<asp:RequiredFieldValidator ID="rfvTitleLenght" runat="server" ForeColor="Red" ControlToValidate="tbxTitleLenght" ErrorMessage="Required value" />
											<asp:RangeValidator ID="rvTitleLenght" runat="server" ForeColor="Red" ControlToValidate="tbxTitleLenght" ErrorMessage="Range not valid (0 - 200)" MinimumValue="0" MaximumValue="200" Type="Integer" />
										</td>
									</tr>
									<tr class="second">
										<td class="left">
											<dnn:Label ID="lblCellHeight" runat="server" Text="Minimal calendar cell height (px):" HelpText="Minimal height of calendar content cell." ControlName="tbxCellHeight" ResourceKey="lblCellHeight" HelpKey="lblCellHeight.HelpText" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbxCellHeight" runat="server" Width="30px" Text="100" />
											<asp:RequiredFieldValidator ID="rfvCellHeight" runat="server" ForeColor="Red" ControlToValidate="tbxCellHeight" ErrorMessage="RequiredFieldValidator" />
											<asp:RangeValidator ID="rvCellHeight" runat="server" ForeColor="Red" ControlToValidate="tbxCellHeight" ErrorMessage="RangeValidator" MinimumValue="0" MaximumValue="1080" Type="Integer" />
										</td>
									</tr>
									<tr>
										<td class="left">
											<dnn:Label ID="lblShowNewsRSSLink" runat="server" Text="Display link:" HelpText="Select links to display." ControlName="cbShowNewsRSSLink" HelpKey="lblShowNewsRSSLink.HelpText" ResourceKey="lblShowNewsRSSLink" Visible="True" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbShowNewsRSSLink" runat="server" resourcekey="cbShowNewsRSSLink" Checked="false" Text="News RSS" />&nbsp
											<asp:CheckBox ID="cbShowEventRSSLink" runat="server" resourcekey="cbShowEventRSSLink" Checked="false" Text="Events RSS" />&nbsp
											<asp:CheckBox ID="cbShowListLink" runat="server" resourcekey="cbShowListLink" Checked="false" Text="Articles/events list" />&nbsp
											<asp:CheckBox ID="cbCalendarEventsExportIcon" runat="server" resourcekey="cbCalendarEventsExportIcon" Checked="false" Text="iCalendar export" />
										</td>
									</tr>
								</table>
								<table class="settings_table" cellpadding="0" cellspacing="0">
									<tr runat="server" id="trCalendarTooltipSummaryLenght">
										<td class="left">
											<dnn:Label ID="lblCalendarTooltipSummaryLenght" runat="server" Text="Limit lenght of tooltip article/event summary:" HelpText="Limit lenght of summary in tooltip to specified num of characters (0 - show all)." ControlName="tbxCalendarTooltipSummaryLenght" ResourceKey="lblCalendarTooltipSummaryLenght" HelpKey="lblCalendarTooltipSummaryLenght.HelpText" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbxCalendarTooltipSummaryLenght" runat="server" Width="30px" Text="0" />
											<asp:RequiredFieldValidator ID="rfvCalendarTooltipSummaryLenght" runat="server" ForeColor="Red" ControlToValidate="tbxCalendarTooltipSummaryLenght" ErrorMessage="Required value" />
											<asp:RangeValidator ID="rvCalendarTooltipSummaryLenght" runat="server" ForeColor="Red" ControlToValidate="tbxCalendarTooltipSummaryLenght" ErrorMessage="Range not valid" MinimumValue="0" MaximumValue="4000" Type="Integer" />
										</td>
									</tr>
									<tr class="second">
										<td class="left">
											<dnn:Label ID="lblSelectModule" runat="server" Text="Open in:" ControlName="cbModules" HelpText="Select news module instance or page to open articles:" HelpKey="lblSelectModule.HelpText" ResourceKey="lblSelectModule" />
										</td>
										<td class="right">
											<asp:CheckBox ID="cbModules" Style="display: none" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbModules_CheckedChanged" Text="Module" resourcekey="cbModulesResource1" />
											<asp:DropDownList ID="ddlOpenDetails" runat="server">
												<asp:ListItem Value="0" resourcekey="ListItemResource4" Text="Select" />
											</asp:DropDownList>
											&nbsp;<asp:Label ID="lblModuleError" runat="server" ForeColor="Red" Text="Please select." Visible="False" resourcekey="lblModuleErrorResource1" />
										</td>
									</tr>
									<tr style="display: none">
										<td class="left">
											&nbsp;
										</td>
										<td class="right">
											<asp:CheckBox ID="cbPage" runat="server" AutoPostBack="True" OnCheckedChanged="cbPage_CheckedChanged" Text="Page" resourcekey="cbPageResource1" />
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<asp:DropDownList ID="ddlPageOpenDetails" runat="server" resourcekey="ddlPageOpenDetailsResource1">
											</asp:DropDownList>
											&nbsp;<asp:Label ID="lblPageError" runat="server" ForeColor="Red" Text="Please select." Visible="False" resourcekey="lblPageErrorResource1" />
										</td>
									</tr>
									<tr>
										<td class="left">
											<dnn:Label ID="lblFirstDayOfTheWeek" runat="server" Text="Select the first day of the week:" HelpText="Select news module instance or page to open articles:" ResourceKey="lblFirstDayOfTheWeek" HelpKey="lblFirstDayOfTheWeek.HelpText" />
										</td>
										<td class="right">
											<asp:DropDownList ID="ddlFirstDayOfTheWeek" runat="server">
												<asp:ListItem resourcekey="liMonday" Value="Monday">Monday</asp:ListItem>
												<asp:ListItem resourcekey="liTuesday" Value="Tuesday">Tuesday</asp:ListItem>
												<asp:ListItem resourcekey="liWednesday" Value="Wednesday">Wednesday</asp:ListItem>
												<asp:ListItem resourcekey="liThursday" Value="Thursday">Thursday</asp:ListItem>
												<asp:ListItem resourcekey="liFriday" Value="Friday">Friday</asp:ListItem>
												<asp:ListItem resourcekey="liSaturday" Value="Saturday">Saturday</asp:ListItem>
												<asp:ListItem resourcekey="liSunday" Value="Sunday">Sunday</asp:ListItem>
											</asp:DropDownList>
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
				</table>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr class="second" style="background: #D1EBFA;">
						<td class="left" style="border: 1px solid #AAD6F1; border-right: 0;">
							<dnn:Label ID="lblShowMonthlyArchive" runat="server" Text="Show monthly archive:" HelpText="Shows articles by month:" ControlName="cbShowMonthlyArchive" HelpKey="lblShowMonthlyArchive.HelpText" ResourceKey="lblShowMonthlyArchive" />
						</td>
						<td class="right" style="border: 1px solid #AAD6F1; border-left: 0;">
							<asp:CheckBox ID="cbShowMonthlyArchive" runat="server" resourcekey="cbShowMonthlyArchiveResource1" />
						</td>
					</tr>
				</table>
				<div id="tblCollapsable2" class="collapsable_container <%=cbShowMonthlyArchive.ClientID%>" style="border: 1px solid #717171; border-top: 0; margin-bottom: 10px; <%=cssTableStyleMonthlyArchive%>">
					<table class="settings_table" cellpadding="0" cellspacing="0">
						<tr>
							<td class="left">
								<dnn:Label ID="lblShowMonthArchiveModule" runat="server" Text="Show monthly archive in module:" HelpText="Select news module
			instance to open articles:" ControlName="ddlMonthlyArchiveOpenDetails" HelpKey="lblShowMonthArchiveModule.HelpText" ResourceKey="lblShowMonthArchiveModule" />
							</td>
							<td class="right">
								<asp:DropDownList ID="ddlMonthlyArchiveOpenDetails" runat="server" resourcekey="ddlMonthlyArchiveOpenDetailsResource1">
									<asp:ListItem Value="0" resourcekey="ListItemResource5">Select</asp:ListItem>
								</asp:DropDownList>
								<asp:Label ID="lblArchiveMonthlyModuleError" runat="server" ForeColor="Red" Text="Please select." Visible="False" resourcekey="lblArchiveMonthlyModuleErrorResource1"></asp:Label>
							</td>
						</tr>
						<tr class="second">
							<td class="left">
								<dnn:Label ID="lblDisplayHeader" runat="server" Text="Display header:" HelpText="Display header:." ControlName="ddlDisplayStyle" HelpKey="lblDisplayHeader.HelpText" ResourceKey="lblDisplayHeader" />
							</td>
							<td class="right">
								<asp:CheckBox ID="cbDisplayHeader" runat="server" Checked="True" resourcekey="cbDisplayHeaderResource1" />
							</td>
						</tr>
					</table>
				</div>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr style="background: #D1EBFA;">
						<td class="left" style="border: 1px solid #AAD6F1; border-right: 0;">
							<dnn:Label ID="lblShowEventArchive" runat="server" Text="Show event archive:" HelpText="Shows upcoming events:" ControlName="cbShowMonthlyArchive" HelpKey="lblShowEventArchive.HelpText" ResourceKey="lblShowEventArchive" />
						</td>
						<td class="right" style="border: 1px solid #AAD6F1; border-left: 0;">
							<asp:CheckBox ID="cbShowEventArchive" runat="server" resourcekey="cbShowMonthlyArchiveResource1" />
						</td>
					</tr>
				</table>
				<div id="tblCollapsable3" class="collapsable_container <%=cbShowEventArchive.ClientID%>" style="border: 1px solid #717171; border-top: 0; margin-bottom: 10px; <%=cssTableStyleEvents%>">
					<table class="settings_table" cellpadding="0" cellspacing="0">
						<tr class="second">
							<td class="left">
								<dnn:Label ID="lblEventArticleOpen" runat="server" Text="Open event articles in module:" HelpText="Open event articles in module:" HelpKey="lblEventArticleOpen.HelpText" ResourceKey="lblEventArticleOpen" />
							</td>
							<td class="right">
								<asp:DropDownList ID="ddlOpenDetailsEvents" runat="server" resourcekey="ddlOpenDetailsResource1">
									<asp:ListItem Value="0" resourcekey="ListItemResource4">Select</asp:ListItem>
								</asp:DropDownList>
							</td>
						</tr>
						<tr>
							<td class="left">
								<dnn:Label ID="lblNumberOfEvents" runat="server" Text="Number of upcoming events:" HelpText="Number of upcoming events:" HelpKey="lblNumberOfEvents.HelpText" ResourceKey="lblNumberOfEvents" />
							</td>
							<td class="right">
								<asp:TextBox ID="tbNumberOfEvents" runat="server" Width="30px">5</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvNumberOfPosts" runat="server" ForeColor="Red" ControlToValidate="tbNumberOfEvents" ErrorMessage="This filed is required." ValidationGroup="vgCalSettings" resourcekey="rfvNumberOfEventsResource1.ErrorMessage" Display="Dynamic" />
								<asp:CompareValidator ID="cvLightBoxGalleryNumberOfItems2" runat="server" ForeColor="Red" ControlToValidate="tbNumberOfEvents" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfItemsResource1.ErrorMessage"
									Type="Integer" ValidationGroup="vgCalSettings" />
							</td>
						</tr>
						<tr class="second">
							<td class="left">
								<dnn:Label ID="lblUpcomingEventsToolTip" runat="server" Text="Enable tooltip:" HelpText="Items are shown in tooltip." ControlName="cbUpcomingEventsToolTip" ResourceKey="lblUpcomingEventsToolTip" HelpKey="lblUpcomingEventsToolTip.HelpText" />
							</td>
							<td class="right">
								<asp:CheckBox ID="cbUpcomingEventsToolTip" runat="server" />
							</td>
						</tr>
						<tr runat="server" id="trUpcomingEventsTTSummaryLenght">
							<td class="left">
								<dnn:Label ID="lblUpcomingEventsTTSummaryLenght" runat="server" Text="Limit lenght of tooltip article/event summary:" HelpText="Limit lenght of summary in tooltip to specified num of characters (0 - show all)." ControlName="tbxUpcomingEventsTTSummaryLenght" ResourceKey="lblUpcomingEventsTTSummaryLenght" HelpKey="lblUpcomingEventsTTSummaryLenght.HelpText" />
							</td>
							<td class="right">
								<asp:TextBox ID="tbxUpcomingEventsTTSummaryLenght" runat="server" Width="30px" Text="0" />
								<asp:RequiredFieldValidator ID="rfvUpcomingEventsTTSummaryLenght" runat="server" ForeColor="Red" ControlToValidate="tbxUpcomingEventsTTSummaryLenght" ErrorMessage="Required value" />
								<asp:RangeValidator ID="rvUpcomingEventsTTSummaryLenght" runat="server" ForeColor="Red" ControlToValidate="tbxUpcomingEventsTTSummaryLenght" ErrorMessage="Range not valid" MinimumValue="0" MaximumValue="4000" Type="Integer" />
							</td>
						</tr>
						<tr>
							<td class="left">
								<dnn:Label ID="lblDisplayHeaderEvents" runat="server" Text="Display header:" HelpText="Display header:." HelpKey="lblDisplayHeader.HelpText" ResourceKey="lblDisplayHeader" />
							</td>
							<td class="right">
								<asp:CheckBox ID="cbDisplayHeaderEvents" runat="server" Checked="True" />
							</td>
						</tr>
						<tr runat="server" id="trDisplayUpcomingEventsRSSlinks">
							<td class="left">
								<dnn:Label ID="lblDisplayUpcomingEventsRSSlinks" runat="server" Text="Display links:" HelpText="Select links to display." ResourceKey="lblDisplayUpcomingEventsRSSlinks" HelpKey="lblDisplayUpcomingEventsRSSlinks.HelpText" />
							</td>
							<td class="right">
								<asp:CheckBox ID="cbShowUpcomingRSSIcon" runat="server" resourcekey="cbShowUpcomingRSSIcon" Text="Events RSS" />&nbsp
								<asp:CheckBox ID="cbShowUpcomingEventsExportIcon" runat="server" resourcekey="cbShowUpcomingEventsExportIcon" Text="iCalendar export" />
							</td>
						</tr>
					</table>
				</div>
				<h3 class="subsections">
					<%=Theme%></h3>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblModuleTheme" runat="server" Text="Module theme:" HelpText="Select theme." ControlName="ddlTheme" HelpKey="lblModuleTheme.HelpText" ResourceKey="lblModuleTheme" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlTheme" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlTemplates_SelectedIndexChanged" AppendDataBoundItems="True">
							</asp:DropDownList>
							<asp:CompareValidator ID="cvThemeSelect" runat="server" ForeColor="Red" ControlToValidate="ddlTheme" Display="Dynamic" ErrorMessage=" Please select theme" Operator="NotEqual" ValidationGroup="vgCalSettings" ValueToCompare="0" resourcekey="cvThemeSelectResource1.ErrorMessage" />
						</td>
					</tr>
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblSelectDisplayStyle" runat="server" Text="Module display style:" HelpText="Select display style." ControlName="ddlDisplayStyle" HelpKey="lblSelectDisplayStyle.HelpText" ResourceKey="lblSelectDisplayStyle" />
						</td>
						<td class="right">
							<asp:DropDownList ID="ddlDisplayStyle" runat="server" />
							<asp:CompareValidator ID="cvdisplayStyleSelect" runat="server" ForeColor="Red" ControlToValidate="ddlDisplayStyle" Display="Dynamic" ErrorMessage=" Please select display style" Operator="NotEqual" ValidationGroup="vgCalSettings" ValueToCompare="0" resourcekey="cvdisplayStyleSelectResource1.ErrorMessage" />
						</td>
					</tr>
				</table>
				<h3 class="subsections">
					<%=Filter%></h3>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<dnn:Label ID="lblSelectCategories" runat="server" Text="Select categories to display articles from:" ControlName="cbdisplayallcats" HelpText="Show
			all categories or make category selection in the tree view selection list." HelpKey="lblSelectCategories.HelpText" ResourceKey="lblSelectCategories" />
						</td>
						<td class="right">
							<asp:CheckBox ID="cbdisplayallcats" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbdisplayallcats_CheckedChanged" Text="Display all categories and subcategories" resourcekey="cbdisplayallcatsResource1" />
						</td>
					</tr>
				</table>
				<table id="tblSelectCategories" runat="server" visible="false" class="settings_table" cellpadding="0" cellspacing="0" style="margin-left: auto; margin-right: auto;">
					<tr class="second">
						<td class="left">
						</td>
						<td class="right">
							<asp:CheckBox ID="cbAutoAddCatChilds" runat="server" Text="Auto select all child categories." resourcekey="cbAutoAddCatChildsResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
						</td>
						<td class="right">
							<asp:TreeView ID="tvCatAndSubCat" runat="server" ForeColor="Black" ShowCheckBoxes="All" ShowExpandCollapse="False" ShowLines="True" />
							<asp:CustomValidator ID="cvCategoriesTreeview" runat="server" ForeColor="Red" ClientValidationFunction="ClientValidate" ErrorMessage="Please select at least one category." Display="Dynamic" Enabled="False" resourcekey="cvCategoriesTreeview.ErrorMessage"
								ValidationGroup="vgCalSettings" />
						</td>
					</tr>
				</table>
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr class="second">
						<td class="left">
							<dnn:Label ID="lblFilterAuthors" runat="server" Text="Display articles from all authors in the portal:" HelpText="Display articles from all authors in the portal." ControlName="cbFilterCategories" HelpKey="lblFilterAuthors.HelpText" ResourceKey="lblFilterAuthors" />
						</td>
						<td>
							<asp:CheckBox ID="cbDisplayAllAuthors" runat="server" AutoPostBack="True" OnCheckedChanged="cbDisplayAllAuthors_CheckedChanged" Checked="True" resourcekey="cbDisplayAllAuthorsResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
						</td>
						<td class="right">
							<asp:TreeView ID="tvAuthorAndGroupSelection" runat="server" ForeColor="Black" ImageSet="Contacts" ShowCheckBoxes="All" NodeIndent="25" Visible="false">
								<HoverNodeStyle Font-Underline="False" />
								<NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
								<ParentNodeStyle Font-Bold="True" ForeColor="#5555DD" />
								<SelectedNodeStyle Font-Underline="True" HorizontalPadding="0px" VerticalPadding="0px" />
							</asp:TreeView>
							<asp:CustomValidator ID="cvAuthorsTreeview" runat="server" ForeColor="Red" ClientValidationFunction="ClientValidateAuthors" Display="Dynamic" Enabled="False" ErrorMessage="Please select at least one author." ValidationGroup="vgCalSettings" resourcekey="cvAuthorsTreeview" />
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center; color: Red;">
							<asp:Label ID="lblCalendarInfo" runat="server" EnableViewState="False" resourcekey="lblCalendarInfoResource1" />
						</td>
					</tr>
				</table>
				<asp:Panel ID="pnlLocalization" runat="server" Visible="false">
					<h3 class="subsections">
						<%=LocalizationText%></h3>
					<table class="settings_table" cellpadding="0" cellspacing="0">
						<tr>
							<td class="left">
								<dnn:Label ID="lblHideUnlocalizedItems" runat="server" Text="Don't show unlocalized items:" HelpText="Articles, events that are unlocalized won't show when localization selected." ResourceKey="lblHideUnlocalizedItems" HelpKey="lblHideUnlocalizedItems.HelpText" />
							</td>
							<td class="right">
								<asp:CheckBox ID="cbHideUnlocalizedItems" runat="server" />
							</td>
						</tr>
					</table>
				</asp:Panel>
			</div>
		</div>
		<div class="main_actions">
			<p>
				<asp:Label ID="lblMainMessage" runat="server" EnableViewState="false" /></p>
			<div class="buttons">
				<asp:Button ID="btnSaveSettings" runat="server" OnClick="btnSaveSettings_Click" Text="Save" ValidationGroup="vgCalSettings" resourcekey="btnSaveSettingsResource1" />
				<asp:Button ID="btnSaveClose" runat="server" OnClick="btnSaveClose_Click" Text="Save &amp; Close" ValidationGroup="vgCalSettings" resourcekey="btnSaveCloseResource1" />
				<asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Close" resourcekey="btnCancelResource1" />
			</div>
		</div>
	</div>
</div>
