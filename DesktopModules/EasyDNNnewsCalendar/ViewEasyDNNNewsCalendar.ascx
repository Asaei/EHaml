<%@ control language="C#" inherits="EasyDNN.Modules.EasyDNNNewsCalendar.ViewEasyDNNNewsCalendar, App_Web_vieweasydnnnewscalendar.ascx.3e42803b" autoeventwireup="true" enableviewstate="true" %>
<div id='<%=MainDivID%>' <%=MainDivClass%>>
	<asp:PlaceHolder ID="includeJavaScriptToolTip" runat="server" />
	<asp:UpdatePanel ID="upCalendar" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<div runat="server" id="divAdvancedIcons" visible="false" class="top_calendar_actions">
				<asp:PlaceHolder ID="phAdvancedIcons" runat="server" />
			</div>
			<asp:Panel ID="pnlCalendarArchive" CssClass="callendar_table_container" runat="server" Visible="False">
				<asp:Calendar ID="calDate" runat="server" CssClass="calendar_table" NextMonthText="&raquo;" PrevMonthText="&laquo;" SelectMonthText="&raquo;" SelectWeekText="&rsaquo;" CellPadding="0" CellSpacing="0" ShowGridLines="false" BorderStyle="None" BorderWidth="0"
					FirstDayOfWeek="Monday" OnVisibleMonthChanged="calDate_VisibleMonthChanged">
					<SelectedDayStyle CssClass="selected day" />
					<TitleStyle CssClass="month_selection" />
					<NextPrevStyle CssClass="next_prev_months" />
					<DayHeaderStyle CssClass="week_days" />
					<TodayDayStyle CssClass="day today" />
					<OtherMonthDayStyle CssClass="day other_month" />
					<DayStyle CssClass="day" />
				</asp:Calendar>
			</asp:Panel>
		</ContentTemplate>
	</asp:UpdatePanel>
	<asp:Panel ID="pnlMonthlyArchive" class="archive_list" runat="server" Visible="False">
		<h1 id="ednCalendarMonHeader" runat="server" class="edn_module_title">
			<span>
				<%=ArchiveHeader%></span></h1>
		<ul>
			<asp:Repeater ID="repArchiveList" runat="server">
				<ItemTemplate>
					<li>
						<asp:HyperLink ID="hlMonthList" runat="server" NavigateUrl='<%#Eval("Link")%>'><%#Eval("Year") %>, <%#Eval("MonthText")%> (<%#Eval("Count")%>)</asp:HyperLink></li>
				</ItemTemplate>
			</asp:Repeater>
		</ul>
		<asp:Literal ID="test" runat="server" Visible="false"/>
		<asp:PlaceHolder ID="phArchive" runat="server" Visible="false"/>
	</asp:Panel>
	<asp:Panel ID="pnlEventArchive" class="archive_list events" runat="server" Visible="False">
		<h1 id="EventH1" runat="server" class="edn_module_title">
			<span>
				<%=EventHeader%></span>
			<asp:PlaceHolder ID="phUpcomingEventsIcons" runat="server" />
		</h1>
		<asp:PlaceHolder ID="phupcomingEventsArchive" runat="server" />
	</asp:Panel>
	<asp:Label ID="lblCalMessage" runat="server" resourcekey="lblCalMessage" Text="Please edit and save settings." Visible="false" />
</div>
