<%@ Control Language="C#" CodeBehind="Options.ascx.cs" AutoEventWireup="true" Inherits="Mandeeps.DNN.Modules.LiveTabs.Options" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/Labelcontrol.ascx" %>
<%@ Register Assembly="Mandeeps.Web" Namespace="Mandeeps.Web.UI.WebControls" TagPrefix="Mandeeps" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/sectionheadcontrol.ascx" %>
<style type="text/css">
    .MNormal
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: normal;
    }
    .MNormalBold
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: bold;
    }
    .MNormalRed
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 12px;
        font-weight: bold;
        color: #ff0000;
    }
    .MHead
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 20px;
        font-weight: normal;
        color: #333333;
    }
    .MSubHead
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: bold;
        color: #003366;
    }
    .MCommandButton
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: normal;
    }
    .MNormalTextBox
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 12px;
        font-weight: normal;
    }
</style>
<br />
<div class="livetabsverticalvertical" style="width: 870px;">
    <Mandeeps:TabStrip runat="server" ID="VerticalTabs" Theme="Vertical" TabsPersistence="true"
        ThemePath="~/DesktopModules/LiveTabs/Resources/Tabs">
        <Mandeeps:Tab ID="BasicTab" runat="server">
            <asp:Label ID="lBasic" runat="server" CssClass="tabheading" resourcekey="lBasic"></asp:Label>
            <hr size="1" style="color: #cccccc" />
            <table width="100%">
                <tr>
                    <td colspan="2">
                        <div style="font-size: 11px; background-color: InactiveBorder; border-radius: 5px;
                            -moz-border-radius: 5px; webkit-border-radius: 5px; border: 1px solid #999999;
                            padding: 5px;">
                            <asp:Label ID="lStateInfo" runat="server" /></div>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px">
                        <dnn:Label ID="lTabMode" runat="server" HelpText="Please specify tab mode." Text="Tab Mode" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlTabMode" runat="server" Width="225px" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlTabMode_SelectedIndexChanged">
                            <asp:ListItem Value="Default" resourcekey="Default" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="Advanced" resourcekey="Advanced"></asp:ListItem>
                            <asp:ListItem Value="SQLQuery" resourcekey="SQLQuery"></asp:ListItem>
                            <asp:ListItem Value="RSSFeed" resourcekey="RSSFeed"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr id="FeedUrl" runat="server" visible="false">
                    <td style="width: 150px">
                        <dnn:Label ID="lFeedUrl" runat="server" Text="Feed Url" HelpText="Specify FeedUrl" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbFeeUrl" runat="server" Width="220px"></asp:TextBox>
                    </td>
                </tr>
                <tr id="MaxTitleLength" runat="server" visible="false">
                    <td style="width: 150px">
                        <dnn:Label ID="lMaxTitleLength" runat="server" Text="Max Title Length" HelpText="Specify Maximum Title Length" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbMaxTitleLength" runat="server" Width="75px"></asp:TextBox>&nbsp;
                        <asp:DropDownList ID="ddlTitleLengthUnit" runat="server" Width="137px">
                            <asp:ListItem Value="Character" resourcekey="Character" Selected="True">Character</asp:ListItem>
                            <asp:ListItem Value="Words" resourcekey="Words">Words</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr id="MaxTablength" runat="server" visible="false">
                    <td style="width: 150px">
                        <dnn:Label ID="lMaxTabLength" runat="server" HelpText="Specify Maximum Tab length"
                            Text="Maximum Tabs" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbMaxTabLength" runat="server" Width="220px"></asp:TextBox>
                    </td>
                </tr>
                <tr id="UseToken" runat="server" visible="false">
                    <td style="width: 150px">
                        <dnn:Label ID="lUseToken" runat="server" Text="Use Token" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbUseToken" runat="server" Width="220px"></asp:TextBox>
                    </td>
                </tr>
                <tr id="CatchTime" runat="server" visible="false">
                    <td style="width: 150px">
                        <dnn:Label ID="lCacheTime" runat="server" Text="Catch Time" HelpText="Speicfy Cache Time" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbCacheTime" runat="server" Width="75px"></asp:TextBox>&nbsp;
                        <asp:Label ID="lMinutes" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr id="SqlIntegration" runat="server" visible="false">
                    <td style="width: 150px">
                        <dnn:Label ID="lSQLConnection" runat="server" HelpText="Connection String" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSQLConnection" Style="width: 225px;" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr id="SqlQuery" runat="server" visible="false">
                    <td style="width: 150px">
                        <dnn:Label ID="lSQLquery" runat="server" HelpText="Specify SQLquery" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbSQLquery" Visible="true" runat="server" Style="width: 550px" Rows="9"
                            TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
            <asp:Label ID="lLayout" runat="server" CssClass="tabheading" resourcekey="lLayout"></asp:Label>
            <hr size="1" style="color: #cccccc" />
            <table width="100%">
                <tr>
                    <td style="width: 150px">
                        <dnn:Label ID="lWidth" runat="server" HelpText="Optionally specify a width; otherwise, module will dynamically resize."
                            Text="Width" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbSpecifyWidth" runat="server" AutoPostBack="True" OnCheckedChanged="cbSpecifyWidth_CheckedChanged"
                            resourcekey="cbSpecifyWidth" Text="Specify Width" />
                    </td>
                </tr>
                <tr id="RowWidth" runat="server" visible="False">
                    <td style="width: 150px">
                        &nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="tbWidth" runat="server" Width="75px"></asp:TextBox>
                        &nbsp;<asp:Label ID="lWidthPixels" runat="server" Enabled="False" resourcekey="lWidthPixels"
                            Font-Italic="True" Font-Size="10pt" Text="pixels"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px">
                        <dnn:Label ID="lHeight" runat="server" HelpText="Optionally specify a height; otherwise, module will dynamically resize"
                            Text="Height" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbSpecifyHeight" runat="server" AutoPostBack="True" OnCheckedChanged="cbSpecifyHeight_CheckedChanged"
                            resourcekey="cbSpecifyHeight" Text="Specify Height" />
                    </td>
                </tr>
                <tr id="RowHeight" runat="server" visible="False">
                    <td style="width: 150px">
                        &nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="tbHeight" runat="server" Width="75px"></asp:TextBox>
                        &nbsp;<asp:Label ID="lHeightPixels" runat="server" Enabled="False" resourcekey="lHeightPixels"
                            Font-Italic="True" Font-Size="10pt" Text="pixels"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <asp:Label ID="lEffects" runat="server" CssClass="tabheading" resourcekey="lEffects"></asp:Label>
            <hr size="1" style="color: #cccccc" />
            <table width="100%">
                <tr>
                    <td style="width: 150px">
                        <dnn:Label ID="lEffect" runat="server" HelpText="Effects" Text="Effects" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlEffect" runat="server"  Width="225px">
                            <asp:ListItem Value="none" Text="None"></asp:ListItem>
                            <asp:ListItem Value="fade" Text="Fade"></asp:ListItem>
                            <asp:ListItem Value="slide" Text="Slide"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </Mandeeps:Tab>
        <Mandeeps:Tab ID="AdvancedTab" runat="server">
            <asp:Label ID="lAdvanced" runat="server" CssClass="tabheading" resourcekey="lAdvanced"></asp:Label>
            <hr size="1" style="color: #cccccc" />
            <table width="100%">
                <tr>
                    <td style="width: 165px">
                        <dnn:Label ID="lSelectOnMouseover" runat="server" HelpText="Automatically selects the tab on mouseover"
                            Text="Auto Select Tab" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbSelectOnMouseover" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 165px">
                        <dnn:Label ID="lTabsPersistence" runat="server" HelpText="Remembers the last selected tab on postback or when user returns to the page"
                            Text="Tabs Persistence" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbTabsPersistence" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 165px">
                        <dnn:Label ID="lEnableThemeScript" runat="server" HelpText="Remembers the last selected tab on postback or when user returns to the page"
                            Text="Enable ThemeScript" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbEnableThemeScript" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 165px">
                        <dnn:Label ID="lIntelligentTabLink" runat="server" HelpText="Enables Scroll to tab link"
                            Text="Intelligent Tab Link" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbIntelligentTabLink" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 165px">
                        <dnn:Label ID="lCollapsibleTab" runat="server" HelpText="Rotates through each tab after specified rotate time"
                            Text="Collapsible Tab" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbCollapsible" runat="server" AutoPostBack="true" OnCheckedChanged="cbCollapsible_CheckedChanged" />
                    </td>
                </tr>

                <tr runat="server" id="RowInitiallyCollapsed" visible="false">
                    <td style="width: 165px">
                        <dnn:Label ID="lInitiallyCollapsed" runat="server" HelpText="Rotates through each tab after specified rotate time"
                            Text="Initially Collapsed" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbInitiallyCollapsed" runat="server" />
                    </td>
                </tr>
                <tr >
                    <td style="width: 165px">
                        <dnn:Label ID="lLoadOnDemand" runat="server" HelpText="Hides Single Tab - Use if you don't want to show alone tab."
                            Text="Load on Demand" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbLoadAndDemand" runat="server" Visible="True" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:Label ID="lAnalytics" runat="server" CssClass="tabheading" resourcekey="lAnalytics"></asp:Label>
            <hr size="1" style="color: #cccccc" />
            <table width="100%">
                <tr>
                    <td style="width: 165px">
                        <dnn:Label ID="lTrackClicks" runat="server" HelpText="Track individual tab clicks using Google Analytics"
                            Text="Track Clicks" Visible="True" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbTrackClicks" runat="server" OnCheckedChanged="cbTrackClicks_CheckedChanged"
                            AutoPostBack="True" />
                    </td>
                </tr>
            </table>
            <table style="width: 100%" id="TableTrackClicks" runat="server" visible="false">
                <tr>
                    <td style="width: 165px">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="width: 165px">
                        <dnn:Label ID="lEventCategory" runat="server" HelpText="Google Analytics Event Tracking Category"
                            Text="Event Category" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbTrackCategory" runat="server" Width="350px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 165px">
                        <dnn:Label ID="lEventAction" runat="server" HelpText="Google Analytics Event Tracking Action"
                            Text="Event Action" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbTrackAction" runat="server" Width="350px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 165px">
                        <dnn:Label ID="lEventLabel" runat="server" HelpText="Google Analytics Event Tracking Label"
                            Text="Event Label" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbTrackLabel" runat="server" Width="350px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 165px">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="width: 165px">
                        &nbsp;
                    </td>
                    <td>
                        <asp:RadioButton ID="rbTrackingCodeExists" runat="server" resourcekey="rbTrackingCodeExists"
                            GroupName="GA" Text="Google Analytics Tracking Code is already on the page..."
                            AutoPostBack="True" CssClass="MNormal" OnCheckedChanged="rbTrackingCodeExists_CheckedChanged" />
                        <br />
                        <asp:RadioButton ID="rbInsertTrackingCode" runat="server" resourcekey="rbInsertTrackingCode"
                            AutoPostBack="True" GroupName="GA" OnCheckedChanged="rbInsertTrackingCode_CheckedChanged"
                            Text="Let me provide my Google Analytics Tracking code..." CssClass="MNormal" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 165px">
                        <dnn:Label ID="lTrackingCode" runat="server" HelpText="Provide the Google Analytics Tracking code"
                            Text="Tracking Code" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbTrackingCode" runat="server" Height="198px" TextMode="MultiLine"
                            Width="375px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </Mandeeps:Tab>
        <Mandeeps:Tab ID="ThemesTab" runat="server">
            <asp:Label ID="lThemes" runat="server" CssClass="tabheading" resourcekey="lThemes"></asp:Label>
            <hr size="1" style="color: #cccccc" />
            <table width="100%">
                <tr>
                    <td style="width: 150px;">
                        <dnn:Label ID="lThemess" runat="server" HelpText="Available Themes" Text="Themes" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlThemes" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlThemes_SelectedIndexChanged"
                            Width="200px">
                        </asp:DropDownList>
                    </td>
                    <td rowspan="6">
                        <asp:Image ID="imgSkin" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px">
                        <dnn:Label ID="lOrientation" runat="server" Text="Orientation" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlOrientation" runat="server" Width="200px" AutoPostBack="True"
                            OnSelectedIndexChanged="ddlOrientation_SelectedIndexChanged">
                            <asp:ListItem Value="Top" resourcekey="liTop"></asp:ListItem>
                            <asp:ListItem Value="Left" resourcekey="liLeft"></asp:ListItem>
                            <asp:ListItem Value="Right" resourcekey="liRight"></asp:ListItem>
                            <asp:ListItem Value="Bottom" resourcekey="liBottom"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr id="NavigationWidth" runat="server" visible="false">
                    <td style="width: 150px">
                        <dnn:Label ID="lWidthSize" runat="server" Text="WidthSize" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbWidthSize" runat="server" Width="50px"></asp:TextBox>
                        <asp:Label Style="color: Gray" ID="lPercentage" Text="%" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </Mandeeps:Tab>
    </Mandeeps:TabStrip>
    <br />
    <asp:LinkButton ID="bUpdate" resourcekey="bUpdate" runat="server" CssClass="mbutton"
        OnClick="bUpdate_Click"></asp:LinkButton>
    <asp:LinkButton ID="cmdCancel" runat="server" resourcekey="cmdCancel" Text="Cancel"
        CssClass="mbutton2" OnClick="cmdCancel_Click" />
</div>
