<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BackupConfigurationGlobal.ascx.cs" 
            Inherits="Evotiva.DNN.Modules.DNNBackup.BackupConfigurationGlobal" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="MenuBar" Src="controls/MenuBar.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="BreadCrumb" Src="controls/BreadCrumb.ascx" %>

<div style="text-align: left;">

<evotiva:MenuBar runat="server" ID="ctlMenuActions" />
<evotiva:BreadCrumb runat="server" ID="ctlBreadConfigActions" ActionsSeparator=" " ShowTitle="False" />

<%--<evotiva:MessagePanel runat="server" ID="ctlMessagePanel" />--%>

<table runat="server" id="MainTable" style="margin-top: 10px;border-spacing: 10px;" summary="DNNBackup Configuration Table">
    <tr class="bkp-formrow">
        <td>
            <dnn:SectionHead ID="dshGlobalStuff" runat="server" CssClass="bkp-head" IsExpanded="True"
                             ResourceKey="GlobalStuff" Section="tblGlobalStuff" Text="General Options" IncludeRule="true"/>
            
            <table id="tblGlobalStuff" style="border-spacing: 10px;" summary="Global Settings" runat="server">
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblCheckForUpdates" runat="server" ControlName="chkCheckForUpdates" Suffix=":">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkCheckForUpdates"  runat="server"/>
                        &nbsp;&nbsp;<asp:Label ID="lblLastUpdate" runat="server" ></asp:Label>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblBackupFolder" runat="server" ControlName="txtBackupFolder" Suffix=":">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBackupFolder" runat="server"  Columns="35"
                                     MaxLength="100" Width="300px" ValidationGroup="EvotivaDNNBackup" CausesValidation="True"></asp:TextBox><asp:RegularExpressionValidator ID="valBackupFolder"
                                                                                                                                                                            runat="server" CssClass="bkp-error" ResourceKey="valBackupFolder" ControlToValidate="txtBackupFolder"
                                                                                                                                                                            ErrorMessage="Backup folder name must be valid" ValidationExpression="[a-zA-Z0-9-._!$\s\\:/]*"
                                                                                                                                                                            Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblBackupPriority" runat="server" ControlName="ddlBackupPriority"
                                   Suffix=":" Text="Backup Priority"></dnn:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlBackupPriority"  runat="server">
                            <asp:listitem ResourceKey="Normal" value="0">Normal</asp:listitem>
                            <asp:listitem ResourceKey="BelowNormal" value="2">Below Normal</asp:listitem>
                            <asp:listitem ResourceKey="Lowest" value="4">Lowest</asp:listitem>						
                        </asp:DropDownList>
                    </td>
                </tr>    
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblSilentMode" runat="server" ControlName="chkSilentMode"
                                   Suffix=":" Text="Silent Mode"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkSilentMode"  runat="server"></asp:CheckBox>

                    </td>
                </tr>                              
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblCompressionLevel" runat="server" ControlName="ddlCompressionLevel"
                                   Suffix=":" Text="Compression level"></dnn:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlCompressionLevel"  runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblCompressionBuffer" runat="server" ControlName="txtCompressionBuffer"
                                   Suffix=":" Text="ZIP Buffer Size"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCompressionBufferSize" runat="server"  Columns="6"
                                     MaxLength="5" ValidationGroup="EvotivaDNNBackup" CausesValidation="True"></asp:TextBox>
                        <asp:RangeValidator ID="valCompressionBuffer" runat="server" ResourceKey="valCompressionBuffer" ErrorMessage="Invalid buffer size" 
                                            ControlToValidate="txtCompressionBufferSize" CssClass="bkp-error" MinimumValue="64" MaximumValue="20480" 
                                            Display="Dynamic" ValidationGroup="EvotivaDNNBackup" Type="Integer">
                        </asp:RangeValidator>
                    </td>
                </tr>                
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblZip64" runat="server" ControlName="ddlZip64" Suffix=":" Text="Zip64">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlZip64"  runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblZipPassword" runat="server" ControlName="txtZipPassword" Suffix=":"
                                   Text="Zip Password"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtZipPassword" runat="server"  Columns="35"
                                     MaxLength="100" Width="300px" TextMode="Password"></asp:TextBox><br />
                        <asp:Label ID="lblZipPasswordBugNotice" runat="server"    ResourceKey="lblZipPasswordBugNotice" Visible="false"></asp:Label>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblZipPasswordConfirm" runat="server" ControlName="txtZipPasswordConfirm"
                                   Suffix=":" Text="Confirm Password"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtZipPasswordConfirm" runat="server"  Columns="35"
                                     MaxLength="100" Width="300px" TextMode="Password" ValidationGroup="EvotivaDNNBackup" CausesValidation="True"></asp:TextBox>
                        <asp:CompareValidator ID="valZipPasswordMatch" runat="server" ResourceKey="valZipPasswordMatch"
                                              CssClass="bkp-error" ControlToValidate="txtZipPassword" ErrorMessage="Zip Password doesn't match"
                                              Display="Dynamic" ControlToCompare="txtZipPasswordConfirm" ValidationGroup="EvotivaDNNBackup"></asp:CompareValidator>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblAppendDateTime" runat="server" ControlName="chkAppendDateTime"
                                   Suffix=":" Text="Append date/time"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkAppendDateTime"  runat="server" AutoPostBack="true"></asp:CheckBox>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblBackupFileMaxCount" runat="server" ControlName="txtBackupFileMaxCount"
                                   Suffix=":" Text="Backup File Max Count"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBackupFileMaxCount" runat="server"  Columns="5"
                                     MaxLength="3" ValidationGroup="EvotivaDNNBackup" CausesValidation="True"></asp:TextBox><asp:CompareValidator ID="valBackupFileMaxCount" runat="server"
                                                                                                                                                  ResourceKey="valBackupFileMaxCount" Display="Dynamic" ErrorMessage="Should be greater o equal than zero"
                                                                                                                                                  ControlToValidate="txtBackupFileMaxCount" Operator="GreaterThanEqual" Type="Integer"
                                                                                                                                                  ValueToCompare="0" ValidationGroup="EvotivaDNNBackup"></asp:CompareValidator>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblBackupOffSiteFileMaxCount" runat="server" ControlName="txtBackupOffSiteFileMaxCount"
                                   Suffix=":" Text="Backup File Max Count"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBackupOffSiteFileMaxCount" runat="server"  Columns="5"
                                     MaxLength="3" ValidationGroup="EvotivaDNNBackup" CausesValidation="True"></asp:TextBox><asp:CompareValidator ID="valBackupOffSiteFileMaxCount" runat="server"
                                                                                                                                                  ResourceKey="valBackupFileMaxCount" Display="Dynamic" ErrorMessage="Should be greater o equal than zero"
                                                                                                                                                  ControlToValidate="txtBackupOffSiteFileMaxCount" Operator="GreaterThanEqual" Type="Integer"
                                                                                                                                                  ValueToCompare="0" ValidationGroup="EvotivaDNNBackup"></asp:CompareValidator>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblBackupThresholdMinutes" runat="server" ControlName="txtBackupThresholdMinutes"
                                   Suffix=":" Text="Backup Threshold"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBackupThresholdMinutes" runat="server"  Columns="5"
                                     MaxLength="3" ValidationGroup="EvotivaDNNBackup" CausesValidation="True"></asp:TextBox><asp:CompareValidator ID="valBackupThresholdMinutes" runat="server"
                                                                                                                                                  ResourceKey="valBackupFileMaxCount" Display="Dynamic" ErrorMessage="Should be greater o equal than zero"
                                                                                                                                                  ControlToValidate="txtBackupThresholdMinutes" Operator="GreaterThanEqual" Type="Integer"
                                                                                                                                                  ValueToCompare="0" ValidationGroup="EvotivaDNNBackup"></asp:CompareValidator>
                    </td>
                </tr>                
                <%--<tr class="bkp-formrow">
					<td class="bkp-titlelabel">
						<dnn:Label ID="lblPageRefreshRate" runat="server" ControlName="txtPageRefreshRate"
							Suffix=":" Text="Page Refresh Rate"></dnn:Label>
					</td>
					<td>
						<asp:TextBox ID="txtPageRefreshRate" runat="server"  Columns="5"
							MaxLength="2"></asp:TextBox><asp:RangeValidator ID="valPageRefreshRate" runat="server"
								Display="Dynamic" ErrorMessage="Should be between 1 and 90" ControlToValidate="txtPageRefreshRate"
								Type="Integer" MinimumValue="1" MaximumValue="90"></asp:RangeValidator>
					</td>
				</tr>--%>
                <%--<tr class="bkp-formrow">
					<td class="bkp-titlelabel">
						<dnn:Label ID="lblProcessPriority" runat="server" ControlName="ddlProcessPriority"
							Suffix=":" Text="Process Priority"></dnn:Label>
					</td>
					<td>
						<asp:DropDownList ID="ddlProcessPriority"  runat="server">
						</asp:DropDownList>
					</td>
				</tr>
				<tr class="bkp-formrow">
					<td class="bkp-titlelabel">
						<dnn:Label ID="lblDownloadMethod" runat="server" Suffix=":" ControlName="cmbDownloadMethod"
							Text="Download Method"></dnn:Label>
					</td>
					<td>
						<asp:DropDownList ID="ddlDownloadMethod" runat="server" >
						</asp:DropDownList>
					</td>
				</tr>--%>
                <%--<tr class="bkp-formrow">
					<td class="bkp-titlelabel">
						<dnn:Label ID="lblImpersonate" runat="server" ControlName="chkImpersonate" Suffix=":"
							Text="Impersonate backup thread"></dnn:Label>
					</td>
					<td>
						<asp:CheckBox ID="chkImpersonate"  runat="server"></asp:CheckBox>
					</td>
				</tr>--%>
                <%--<tr class="bkp-formrow">
					<td class="bkp-titlelabel">
						<dnn:Label ID="lblRunInForeground" runat="server" ControlName="chkRunInForeground"
							Suffix=":" Text="Run In Foreground"></dnn:Label>
					</td>
					<td>
						<asp:CheckBox ID="chkRunInForeground"  runat="server"></asp:CheckBox>
					</td>
				</tr>--%>
            </table>
            <br />
        </td>
    </tr>

    <tr class="bkp-formrow">
        <td>
            <dnn:SectionHead ID="dshSchedulerNotifications" runat="server" CssClass="bkp-head" IsExpanded="True"
                             ResourceKey="SchedulerNotifications" Section="tblSchedulerNotifications" Text="Scheduler Options"  IncludeRule="true">
            </dnn:SectionHead>                                 
            <table runat="server" id="tblSchedulerNotifications" style="border-spacing: 10px;" summary="Scheduler Notification Settings Design Table">   
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblEnableNotification" runat="server" ControlName="chkEnableNotification" Suffix=":"
                                   Text="Enable Notification"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkEnableNotification" runat="server"></asp:CheckBox>
                    </td>
                </tr>                             
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblScheduledBackupEmailNotify" runat="server" ControlName="txtScheduledBackupEmailNotify"
                                   Suffix=":" Text="Notify Scheduled Backup to"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtScheduledBackupEmailNotify" runat="server" 
                                     Columns="50" MaxLength="300"></asp:TextBox>
                        <asp:RegularExpressionValidator ValidationGroup="EvotivaDNNBackup" ID="valScheduledBackupEmailNotify" runat="server" 
                                                        ResourceKey="valEmailAddress" SetFocusOnError="true"
                                                        ControlToValidate="txtScheduledBackupEmailNotify" Display="Dynamic" CssClass="bkp-error" 
                                                        ValidationExpression="^(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*$"></asp:RegularExpressionValidator>                            
                    </td>
                </tr>
                <%--                <tr class="bkp-formrow">
					<td class="bkp-titlelabel">
						<dnn:Label ID="plSchedBkpLinks" runat="server" ControlName="chkSchedBkpLinks" Suffix=":"
							Text="Include Backup links"></dnn:Label>
					</td>
					<td>
						<asp:CheckBox ID="chkSchedBkpLinks" runat="server" ResourceKey="Yes" Text="Yes">
						</asp:CheckBox>
					</td>
				</tr>  --%>    
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblEmailTemplateSubject" runat="server" ControlName="txtEmailTemplateSubject" Suffix=":"
                                   Text="Subject"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmailTemplateSubject" runat="server"  columns="80" MaxLength="1000" ></asp:TextBox>
                    </td>
                </tr>                 
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblEmailTemplateBody" runat="server" ControlName="txtEmailTemplate" Suffix=":"
                                   Text="Include Backup links"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmailTemplateBody" runat="server" 
                                     Rows="15" columns="50" TextMode="MultiLine" MaxLength="2000" ></asp:TextBox>
                    </td>
                </tr>  
                <tr class="bkp-formrow">
                    <td colspan="2">    
                        <asp:Label ID="lblTokensHelp" runat="server" Text="Tokens" ResourceKey="lblTokensHelp" ></asp:Label>
                    </td>
                </tr>                       
            </table>
        </td>
    </tr>

    <tr>
            <td>
                <div style="margin-top: 20px;">
                    <asp:Image ID="imgUpdate" TabIndex="-1" runat="server" ImageUrl="~/images/save.gif"
                               EnableViewState="False" BorderStyle="None"/>
                    <asp:LinkButton ID="cmdUpdate" ResourceKey="cmdUpdate" runat="server" 
                                    Text="Update" BorderStyle="none" CausesValidation="True" ValidationGroup="EvotivaDNNBackup"/>
                    &nbsp;
                    <asp:Image ID="imgReturn" TabIndex="-1" runat="server" ImageUrl="~/images/lt.gif"
                               EnableViewState="False" BorderStyle="None"/>
                    <asp:LinkButton ID="cmdReturn" ResourceKey="cmdReturn" runat="server" 
                                    Text="Return" BorderStyle="none" CausesValidation="False"/>                    
                </div>
            </td>
        </tr>
</table>

</div>
