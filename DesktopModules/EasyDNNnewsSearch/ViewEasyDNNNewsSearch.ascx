<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNewsSearch.ViewEasyDNNNewsSearch, App_Web_vieweasydnnnewssearch.ascx.75700bee" autoeventwireup="true" enableviewstate="false" %>
<asp:PlaceHolder ID="includeAutoComplete" runat="server" />
<div id="<%=MainDivID%>" <%=MainDivClass%>>
	<asp:UpdatePanel ID="upSearch" runat="server">
		<ContentTemplate>
			<asp:Panel ID="pnlCustomFields" Visible="False" runat="server" Style="text-align: left;" />
			<asp:Panel ID="pnlSearchBox" runat="server" DefaultButton="btnSearch" Visible="False">
				<div class="input" runat="server" id="pnlSearchBoxValue">
					<asp:TextBox ID="tbSearchText" runat="server" AutoCompleteType="Search" CausesValidation="False" />
				</div>
				<asp:LinkButton ID="btnSearch" runat="server" CssClass="do_search" OnClick="btnSearch_Click"><span><%=strSearch%></span></asp:LinkButton>
			</asp:Panel>
			<asp:Repeater ID="repSearchResults" runat="server">
				<ItemTemplate>
					<%#ShowArticle(Eval("Title"), Eval("Article"), Eval("Summary"), Eval("UserId"), Eval("PublishDate"), Eval("ArticleID"), Eval("TitleLink"))%>
				</ItemTemplate>
			</asp:Repeater>
			<asp:Label ID="lblNoResults" runat="server" CssClass="search_message" Text="No search results. Please try again." Visible="False" />
		</ContentTemplate>
	</asp:UpdatePanel>
	<asp:Label ID="lblMessage" runat="server" resourcekey="lblMessage" Visible="False" Text="Please edit and save settings." />
</div>
