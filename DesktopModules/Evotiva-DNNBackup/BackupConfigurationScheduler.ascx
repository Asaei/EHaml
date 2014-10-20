<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BackupConfigurationScheduler.ascx.cs" 
            Inherits="Evotiva.DNN.Modules.DNNBackup.BackupConfigurationScheduler" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="MenuBar" Src="controls/MenuBar.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="BreadCrumb" Src="controls/BreadCrumb.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="MessagePanel" Src="controls/MessagePanel.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="ScheduleList" Src="controls/ScheduleList.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="ScheduleEdit" Src="controls/ScheduleEdit.ascx" %>


<div style="text-align: left;">

<evotiva:MenuBar runat="server" ID="ctlMenuActions" />
<evotiva:BreadCrumb runat="server" ID="ctlBreadConfigActions" ActionsSeparator=" " ShowTitle="False" />

<table runat="server" id="MainTable" style="border-spacing: 10px;margin-top: 10px;" summary="DNNBackup Scheduler Settings Design Table">

    <tr runat="server" id="rowScheduleEdit" visible="False">
        <td>
            <evotiva:ScheduleEdit runat="server" ID="scheduleEdit" 
                                  Caller="BackupConfigurationScheduler" 
                                  Filter="Any" />  
        </td>
    </tr>	

    <tr class="bkp-formrow" runat="server" id="rowRunner">
        <td>
            <dnn:SectionHead ID="dshSchedulerStuff" runat="server" CssClass="bkp-head" IsExpanded="True"
                             ResourceKey="SchedulerStuff" Section="tblSchedulerStuff" Text="Scheduler Options"  IncludeRule="true">
            </dnn:SectionHead>            
            <table id="tblSchedulerStuff" style="border-spacing: 10px;" summary="Scheduler Settings"  runat="server">
                <tr>
                    <td colspan="2">
                        <evotiva:MessagePanel runat="server" ID="ctlMessagePanel" />
                    </td>
                </tr>            
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="plEnabled" runat="server" ControlName="chkEnabled" Suffix=":" Text="Schedule Enabled">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkEnabled" runat="server"  Enabled="True" AutoPostBack="true">
                        </asp:CheckBox>
                        &nbsp;<asp:Label ID="lblScheduleEnabled" runat="server"  ResourceKey="lblScheduleEnabled"></asp:Label>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="plTimeLapse" runat="server" ControlName="txtTimeLapse" Suffix=":"
                                   Text="Time Lapse"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtTimeLapse" runat="server"  MaxLength="10"
                                     Width="50"></asp:TextBox><asp:DropDownList ID="ddlTimeLapseMeasurement" runat="server">
                                                                  <%--<asp:ListItem ResourceKey="Seconds" Value="s">Seconds</asp:ListItem>--%>
                                                                  <asp:ListItem ResourceKey="Minutes" Value="m">Minutes</asp:ListItem>
                                                                  <asp:ListItem ResourceKey="Hours" Value="h">Hours</asp:ListItem>
                                                                  <%--<asp:ListItem ResourceKey="Days" Value="d">Days</asp:ListItem>--%>
                                                              </asp:DropDownList>
                    </td>
                </tr>
                <%--<tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="plRetryTimeLapse" runat="server" ControlName="txtRetryTimeLapse" Suffix=":"
                                   Text="Retry Frequency"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtRetryTimeLapse" runat="server"  MaxLength="10"
                                     Width="50"></asp:TextBox><asp:DropDownList ID="ddlRetryTimeLapseMeasurement" runat="server">
                                                                  <asp:ListItem ResourceKey="Seconds" Value="s">Seconds</asp:ListItem>
                                                                  <asp:ListItem ResourceKey="Minutes" Value="m">Minutes</asp:ListItem>
                                                                  <asp:ListItem ResourceKey="Hours" Value="h">Hours</asp:ListItem>
                                                                  <asp:ListItem ResourceKey="Days" Value="d">Days</asp:ListItem>
                                                              </asp:DropDownList>
                    </td>
                </tr>--%>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="plServers" runat="server" ControlName="txtServers" Text="Run on Servers:">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtServers" runat="server" MaxLength="150" Width="390" ></asp:TextBox>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="plRetainHistoryNum" runat="server" ControlName="ddlRetainHistoryNum"
                                   Suffix=":" Text="Retain Schedule History"></dnn:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlRetainHistoryNum" runat="server">
                            <asp:ListItem Value="0">None</asp:ListItem>
                            <asp:ListItem Value="1">1</asp:ListItem>
                            <asp:ListItem Value="5">5</asp:ListItem>
                            <asp:ListItem Value="10">10</asp:ListItem>
                            <asp:ListItem Value="25">25</asp:ListItem>
                            <asp:ListItem Value="50">50</asp:ListItem>
                            <asp:ListItem Value="100">100</asp:ListItem>
                            <asp:ListItem Value="250">250</asp:ListItem>
                            <asp:ListItem Value="500">500</asp:ListItem>
                            <asp:ListItem Value="-1">All</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblNextSchedulerRun" runat="server" ControlName="txtNextSchedulerRun" Text="Run on Servers:">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtNextSchedulerRun" runat="server" MaxLength="50" Columns="50" Enabled="false" ></asp:TextBox>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td>&nbsp;</td>
                    <td>
                        <div style="margin-top: 20px;">
                            <asp:Image ID="imgUpdate" TabIndex="-1" runat="server" ImageUrl="~/images/save.gif"
                                       EnableViewState="False" BorderStyle="None"></asp:Image>
                            <asp:LinkButton ID="cmdUpdate" ResourceKey="cmdUpdate" runat="server" 
                                            Text="Update" BorderStyle="none" CausesValidation="True" ValidationGroup="EvotivaDNNBackup"></asp:LinkButton>
                            &nbsp;
                            <asp:Image ID="ImgDelete" TabIndex="-1" runat="server" ImageUrl="~/images/delete.gif"
                                       EnableViewState="False" BorderStyle="None"></asp:Image>
                            <asp:LinkButton ID="cmdDelete" ResourceKey="cmdDelete" runat="server" 
                                            Text="Delete" BorderStyle="none" CausesValidation="False" ValidationGroup="EvotivaDNNBackup"></asp:LinkButton>
                            &nbsp;
                            <asp:Image ID="imgReturn" TabIndex="-1" runat="server" ImageUrl="~/images/lt.gif"
                                       EnableViewState="False" BorderStyle="None"></asp:Image>
                            <asp:LinkButton ID="cmdReturn" ResourceKey="cmdReturn" runat="server" 
                                            Text="Return" BorderStyle="none" CausesValidation="False"></asp:LinkButton>
                        </div>                    
                    </td>
                </tr> 
                <tr>
                    <td colspan="2">
                        <evotiva:MessagePanel runat="server" ID="ctlMessagePanelTips" Visible="True" Text />
                    </td>
                </tr>                            
            </table>
        </td>
    </tr>

    <tr class="bkp-formrow"  runat="server" id="rowRunnerHistory">
        <td>
            <dnn:SectionHead ID="dshSchedulerHistory" runat="server" CssClass="bkp-head" IsExpanded="False"
                             ResourceKey="SchedulerHistory" Section="tblSchedulerHistory" Text="Scheduler History"  IncludeRule="true">
            </dnn:SectionHead> 
            <table runat="server" id="tblSchedulerHistory" style="border-spacing: 10px;" summary="Scheduler History Design Table">   
                <tr class="bkp-formrow">
                    <td>
                        <asp:DataGrid ID="dgScheduleHistory" runat="server" AutoGenerateColumns="false" CellPadding="4"
                                      CellSpacing="2" DataKeyField="ScheduleID" EnableViewState="false" 
                                      BorderColor="gray"
                                      BorderStyle="Solid" BorderWidth="1px" GridLines="Both">
                            <Columns>
                                <asp:TemplateColumn HeaderText="Description">
                                    <HeaderStyle CssClass="bkp-bold" />
                                    <ItemStyle  VerticalAlign="Top" />
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                                <td class="bkp-nowraptext">
                                                    <i><%#DataBinder.Eval(Container.DataItem,"TypeFullName") %></i>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:Label ID="Label1" runat="server" Visible='<%# !String.IsNullOrEmpty(Convert.ToString(DataBinder.Eval(Container.DataItem,"LogNotes"))) %>'
                                                   Text='<%#  DataBinder.Eval(Container.DataItem, "LogNotes") %>' />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:BoundColumn DataField="ElapsedTime" HeaderText="Duration">
                                    <HeaderStyle CssClass="bkp-bold"></HeaderStyle>
                                    <ItemStyle Wrap="False"  VerticalAlign="Top"></ItemStyle>
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="Succeeded" HeaderText="Succeeded">
                                    <HeaderStyle CssClass="bkp-bold"></HeaderStyle>
                                    <ItemStyle Wrap="False"  VerticalAlign="Top"></ItemStyle>
                                </asp:BoundColumn>
                                <asp:TemplateColumn HeaderText="Start/End/Next Start">
                                    <HeaderStyle CssClass="bkp-bold"></HeaderStyle>
                                    <ItemStyle Wrap="False"  VerticalAlign="Top"></ItemStyle>
                                    <ItemTemplate>
                                        S:&nbsp;<%# DataBinder.Eval(Container.DataItem, "StartDate") %>
                                        <br>
                                        E:&nbsp;<%# DataBinder.Eval(Container.DataItem, "EndDate") %>
                                        <br>
                                        N:&nbsp;<%# DataBinder.Eval(Container.DataItem, "NextStart") %>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </asp:DataGrid>
                    </td>
                </tr> 
            </table>
        </td>
    </tr>

    <tr class="bkp-formrow" runat="server" id="rowSchedule" visible="True">
        <td>
            <evotiva:ScheduleList runat="server" ID="scheduleList" 
                                  Caller="BackupConfigurationScheduler" 
                                  Filter="Any" />  

        </td>
    </tr>

</table>

</div>