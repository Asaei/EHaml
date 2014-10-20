<%@ Control Language="C#" CodeBehind="Edit.ascx.cs" AutoEventWireup="true" Inherits="Mandeeps.DNN.Modules.LiveTabs.Edit" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/Labelcontrol.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="dnn" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register Assembly="Mandeeps.Web" Namespace="Mandeeps.Web.UI.WebControls" TagPrefix="Mandeeps" %>
<%@ Register Namespace="Mandeeps.DNN.Modules.LiveTabs.Components" Assembly="Mandeeps.DNN.Modules.LiveTabs"
    TagPrefix="LinkButton" %>
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
<div class="livetabsdefaultdefault">
    <br />
    <div id="Info" runat="server" class="info">
        Get started with Live Tabs. Simply specify the name of your new tab and click "Add
        Tab"
    </div>
    <br />
    <asp:DropDownList CssClass="ddllocalepreview" ID="ddlLocalePreview" runat="server"
        OnSelectedIndexChanged="ddlLocalePreview_SelectedIndexChanged" AutoPostBack="True">
    </asp:DropDownList>
    <table class="livetabs" style="width: 100%">
        <tr>
            <td style="width: 135px;">
                <dnn:Label ID="lNewTab" runat="server" HelpText="Create New Tab" Text="New Tab" />
            </td>
            <td>
                <asp:TextBox ID="tbNewTabName" runat="server" CssClass="tbnewtabname" Width="180px"></asp:TextBox>&nbsp;
                <asp:LinkButton ID="bCreateTab" CssClass="mbutton" resourcekey="bCreateTab" runat="server"
                    OnClientClick="LiveTabs.Add(); return false;" Text="Add"></asp:LinkButton>
                <asp:Label ID="ValidateError" runat="server" CssClass="validateerror"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div style="overflow-y: auto; max-height: 180px">
                    <ul runat="server" id="uTabsList">
                    </ul>
                </div>
            </td>
        </tr>
    </table>
    <asp:Panel ID="panTab" runat="server" Visible="false">
        <br />
        <Mandeeps:TabStrip runat="server" ID="LiveTabsEdit" TabsPersistence="true" Theme="Default"
            ThemePath="~/DesktopModules/LiveTabs/Resources/Tabs">
            <Mandeeps:Tab ID="ContentTab" runat="server">
                <div class="livetabsverticalvertical">
                    <Mandeeps:TabStrip runat="server" ID="VerticalContents" Theme="Vertical" ThemePath="~/DesktopModules/LiveTabs/Resources/Tabs">
                        <Mandeeps:Tab ID="ContentSubTab" runat="server">
                            <asp:Label ID="lContent" runat="server" CssClass="tabheading" resourcekey="lContent"></asp:Label>
                            <hr size="1" style="color: #cccccc" />
                            <dnn:TextEditor ID="tbContent" runat="server" OnPreRender="tbContent_PreRender" Width="100%"
                                Height="400"></dnn:TextEditor>
                        </Mandeeps:Tab>
                        <Mandeeps:Tab ID="ModulesTab" runat="server">
                            <asp:Label ID="lModules" runat="server" CssClass="tabheading" resourcekey="lModules"></asp:Label>
                            <hr size="1" style="color: #cccccc" />
                            <table width="100%">
                                <tr id="PortalRow" runat="server">
                                    <td width="200">
                                        <dnn:Label ID="lPortals" runat="server" Text="Portal" HelpText="Select a portal">
                                        </dnn:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlPortals" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPortals_SelectedIndexChanged"
                                            Width="300px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 225px">
                                        <dnn:Label ID="lPages" runat="server" HelpText="Select a page from your portal" Text="Pages" />
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlPages" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPages_SelectedIndexChanged"
                                            Width="300px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 225px">
                                        <dnn:Label ID="lModuless" runat="server" HelpText="Select a module" Text="Modules" />
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlModules" runat="server" Width="300px">
                                        </asp:DropDownList>
                                        &nbsp;
                                        <asp:LinkButton ID="bAddModule" runat="server" CssClass="mbutton" resourcekey="bAddModule"
                                            OnClick="bAddModule_Click"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 225px">
                                        <dnn:Label ID="lSelectedModules" runat="server" HelpText="Selected modules to show in tab"
                                            Text="Selected Modules" />
                                    </td>
                                    <td>
                                        <table style="margin-left: -3px;">
                                            <tr>
                                                <td rowspan="3">
                                                    <asp:ListBox ID="lbModules" runat="server" Width="300px" AutoPostBack="True" OnSelectedIndexChanged="lbModules_SelectedIndexChanged">
                                                    </asp:ListBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="ibModuleUp" runat="server" ImageUrl="~/images/action_up.gif"
                                                        OnClick="bModuleUp_Click" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:ImageButton ID="ibRemoveModule" runat="server" ImageUrl="~/images/action_delete.gif"
                                                        OnClick="bRemoveModule_Click" Style="height: 16px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:ImageButton ID="ibModuleDown" runat="server" ImageUrl="~/images/action_down.gif"
                                                        OnClick="bModuleDown_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <asp:Panel ID="ModuleSettings" runat="server">
                                    <tr>
                                        <td colspan="2">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 225px">
                                            <dnn:Label ID="lTagName" runat="server" HelpText="[TagName] is used within Content in Wrapper Mode"
                                                Text="Tag Name" />
                                        </td>
                                        <td>
                                            <asp:TextBox ID="tbTagName" runat="server" Width="295px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 225px">
                                            <dnn:Label ID="lShowModuleContainer" runat="server" Text="Show Module Container" />
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="cbShowModuleContainer" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 225px">
                                            <dnn:Label ID="lDateExpire" runat="server" HelpText="Enforce start and end date of module"
                                                Text="Enforce Start/End Date" />
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="cbDateExpire" runat="server" Checked="True" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 225px">
                                            <dnn:Label ID="lModulePermissions" runat="server" HelpText="Enforces module permissions"
                                                Text="Enforce Module Permissions" />
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="cbModulePermissions" runat="server" Checked="True" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 225px">
                                            <dnn:Label ID="lInjectEvent" runat="server" HelpText="Inject event for the module"
                                                Text="Inject event" />
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlInjectEvent" runat="server">
                                                <asp:ListItem resourcekey="Automatic" Value="Automatic" />
                                                <asp:ListItem resourcekey="PageInit" Value="PageInit" />
                                                <asp:ListItem resourcekey="PageLoad" Value="PageLoad" />
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:LinkButton ID="bUpdateTagName" runat="server" CssClass="mbutton" OnClick="bUpdateTagName_Click"
                                                resourcekey="bUpdateTagName"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </asp:Panel>
                            </table>
                        </Mandeeps:Tab>
                    </Mandeeps:TabStrip>
                </div>
            </Mandeeps:Tab>
            <Mandeeps:Tab ID="SettingsTab" runat="server">
                <div class="livetabsverticalvertical">
                    <Mandeeps:TabStrip runat="server" ID="VerticalSettings" Theme="Vertical" ThemePath="~/DesktopModules/LiveTabs/Resources/Tabs">
                        <Mandeeps:Tab ID="BasicTab" runat="server">
                            <asp:Label ID="lBasic" runat="server" CssClass="tabheading" resourcekey="lBasic"></asp:Label>
                            <hr size="1" style="color: #cccccc" />
                            <table width="100%">
                                <tr>
                                    <td style="width: 225px">
                                        <dnn:Label ID="lTabName" runat="server" HelpText="Allows you to rename the tab" Text="Tab Name" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbTabName" runat="server" Width="295px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 225px">
                                        <dnn:Label ID="lTabHeader" runat="server" HelpText="Allows you to customize the tab header. Use HTML editor and add icons and other formatting to your tabs."
                                            Text="Show Tab Header" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="cbTabHeader" runat="server" AutoPostBack="true" OnCheckedChanged="cbTabHeader_CheckedChanged" />
                                    </td>
                                </tr>
                                <tr id="TabHeader" runat="server" visible="false">
                                    <td colspan="2">
                                        <dnn:TextEditor ID="tbTabHeader" Visible="true" OnPreRender="tbTabHeader_PreRender"
                                            runat="server" Width="100%" Height="300"></dnn:TextEditor>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr id="CustomizeBreaklineRow1" runat="server">
                                    <td style="width: 225px">
                                        <dnn:Label ID="lCustomizeBreakline" runat="server" HelpText="You can optionally specify your own breakline html..."
                                            Text="Customize Breakline" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="cbCustomizeBreakline" runat="server" AutoPostBack="True" OnCheckedChanged="cbCustomizeBreakline_CheckedChanged" />
                                    </td>
                                </tr>
                                <tr id="CustomizeBreaklineRow2" runat="server">
                                    <td style="width: 225px">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbBreakline" runat="server" Height="50px" TextMode="MultiLine" Visible="False"
                                            Width="300px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="LoadOnDemandRow" runat="server">
                                    <td style="width: 225px">
                                        <dnn:Label ID="lLoadOnDemand" runat="server" HelpText="You can optionally specify your own breakline html..."
                                            Text="Customize Breakline" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="cbLoadOnDemand" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" id="NavigateUrlTable" runat="server">
                                <tr>
                                    <td style="width: 225px">
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 225px">
                                        <dnn:Label ID="lNavigateUrl" runat="server" HelpText="Links directly to the tab from any page"
                                            Text="Navigate Url" />
                                    </td>
                                    <td>
                                        <dnn:URL ID="BrowseNavigateUrl" runat="server" ShowTabs="True" ShowNone="true" UrlType="T"
                                            ShowNewWindow="False" ShowSecure="true" ShowLog="false" ShowTrack="false" ShowUpLoad="false"
                                            ShowDatabase="True" ShowUrls="True" ShowFiles="false"></dnn:URL>
                                    </td>
                                </tr>
                            </table>
                        </Mandeeps:Tab>
                        <Mandeeps:Tab ID="SearchTab" runat="server">
                            <asp:Label ID="lSearch" runat="server" CssClass="tabheading" resourcekey="lSearch"></asp:Label>
                            <hr size="1" style="color: #cccccc" />
                            <table width="100%">
                                <tr>
                                    <td style="width: 225px">
                                        <dnn:Label ID="lSearchable" runat="server" HelpText="Enable DNN Search" Text="Searchable" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="cbSearchable" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 225px">
                                        <dnn:Label ID="lSearchSummary" runat="server" HelpText="Shown in Search Results"
                                            Text="Search Summary" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbSearchSummary" runat="server" TextMode="MultiLine" Width="100%"
                                            Height="100px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </Mandeeps:Tab>
                        <Mandeeps:Tab ID="PermissionsTab" runat="server">
                            <asp:Label ID="lPermissions" runat="server" CssClass="tabheading" resourcekey="lPermissions"></asp:Label>
                            <hr size="1" style="color: #cccccc" />
                            <table width="100%">
                                <tr>
                                    <td style="width: 225px">
                                        <dnn:Label ID="lPermissionss" runat="server" HelpText="Tab Permissions" Text="Permissions" />
                                    </td>
                                    <td>
                                        <asp:CheckBoxList ID="cblPermissions" runat="server" CssClass="MNormal" RepeatLayout="Flow">
                                        </asp:CheckBoxList>
                                    </td>
                                </tr>
                            </table>
                        </Mandeeps:Tab>
                        <Mandeeps:Tab ID="IntegrationTab" runat="server">
                            <asp:Label ID="lIntegration" runat="server" CssClass="tabheading" resourcekey="lIntegration"></asp:Label>
                            <hr size="1" style="color: #cccccc" />
                            <table width="100%">
                                <tr id="UseToken" runat="server" visible="false">
                                    <td style="width: 225px">
                                        <dnn:Label ID="lUseToken" runat="server" HelpText="Links directly to the tab from any page"
                                            Text="Use Token" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbUseToken" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="UseToken1" runat="server" visible="false">
                                    <td colspan="2">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 225px">
                                        <dnn:Label ID="lTabLink" runat="server" HelpText="Links directly to the tab from any page"
                                            Text="Tab Link" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbTabLink" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 225px">
                                        <dnn:Label ID="lTabLinkHtmlCode" runat="server" HelpText="Links directly to the tab from any page"
                                            Text="Link HTML Code" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbTabLinkHtmlCode" runat="server" Height="75px" Width="100%" ReadOnly="true"
                                            TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 225px">
                                        <dnn:Label ID="lJavascriptLink" runat="server" HelpText="Links directly to the tab from within page"
                                            Text="Javascript Link" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbJavascriptLink" runat="server" Height="75px" Width="100%" ReadOnly="true"
                                            TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </Mandeeps:Tab>
                    </Mandeeps:TabStrip>
                </div>
            </Mandeeps:Tab>
        </Mandeeps:TabStrip>
        <br />
        <asp:LinkButton ID="bUpdate" runat="server" Text="Update Tab" CssClass="mbutton"
            resourcekey="bUpdate" OnClick="cmdUpdate_Click" />&nbsp; &nbsp;<asp:LinkButton resourcekey="cmdBack"
                ID="cmdBack" runat="server" Text="Back" CssClass="mbutton2" OnClick="cmdBack_Click" />
    </asp:Panel>
    <br />
    <asp:LinkButton resourcekey="cmdBack1" ID="cmdBack1" runat="server" Text="Back" CssClass="mbutton"
        OnClick="cmdBack1_Click" />
</div>
<LinkButton:PostBackLinkButton ID="BindTabId" runat="server"></LinkButton:PostBackLinkButton>
