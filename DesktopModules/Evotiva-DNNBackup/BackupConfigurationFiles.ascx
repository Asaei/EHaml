<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BackupConfigurationFiles.ascx.cs"
            Inherits="Evotiva.DNN.Modules.DNNBackup.BackupConfigurationFiles" %>
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

<table runat="server" id="MainTable" style="margin-top: 10px;border-spacing: 10px;" summary="Files Backup Settings">

    <tr runat="server" id="rowScheduleEdit" visible="False">
        <td>
            <evotiva:ScheduleEdit runat="server" ID="scheduleEdit" 
                                  Caller="BackupConfigurationFiles" 
                                  Filter="Files" />  
        </td>
    </tr>				

    <tr>
        <td>
            <dnn:SectionHead ID="dshPortalFilesStuff" runat="server" CssClass="bkp-head" IsExpanded="True"
                             ResourceKey="PortalFilesStuff" Section="tblFilesBackup" Text="Files backup" IncludeRule="true">
            </dnn:SectionHead>
            <table runat="server" id="tblFilesBackup" style="border-spacing: 10px;"  summary="Files Backup Settings Design Table">
                <tr class="bkp-formrow">
                    <td colspan="2">
                        <evotiva:MessagePanel runat="server" ID="ctlMessageFilesBackup" />
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td colspan="2">
                        <evotiva:MessagePanel runat="server" ID="ctlMessagePanel" />
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblCreateDataZipFile" runat="server" ControlName="chkDataScriptDatabaseObjects"
                                   Suffix=":" Text="Create Data Zip File"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkCreateDataZipFile"  runat="server" AutoPostBack="True">
                        </asp:CheckBox>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblDataBackupFileName" runat="server" ControlName="txtDataBackupFileName"
                                   Suffix=":"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDataBackupFileName" runat="server"  Columns="35"
                                     MaxLength="100" ValidationGroup="EvotivaDNNBackup" CausesValidation="True"></asp:TextBox><asp:RegularExpressionValidator ID="valDataBackupFileName"
                                                                                                                                                              runat="server" CssClass="bkp-error" ResourceKey="valBackupFileName" ControlToValidate="txtDataBackupFileName"
                                                                                                                                                              ErrorMessage="Invalid file name." ValidationExpression="[a-zA-Z0-9-_.!]*"
                                                                                                                                                              Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RegularExpressionValidator>
                        <%-- <br />
										<asp:Label ID="lblBackupFolderMessage" runat="server" ResourceKey="lblBackupFolderMessage"></asp:Label>--%>
                    </td>
                </tr>
                <tr class="bkp-formrow" runat="server" Visible="False" id="rowNewOrUpdatedFilesOnly">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblNewOrUpdatedFilesOnly" runat="server" ControlName="chkNewOrUpdatedFilesOnly" Suffix=":" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkNewOrUpdatedFilesOnly"  runat="server" />
                    </td>
                </tr>  
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblIncludeWebConfig" runat="server" ControlName="chkIncludeWebConfig"
                                   Suffix=":" Text="Include Web.Config file"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkIncludeWebConfig"  runat="server"></asp:CheckBox>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblIncludeHostFolder" runat="server" ControlName="chkIncludeHostFolder"
                                   Suffix=":" Text="Include Host folder"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkIncludeHostFolder"  runat="server"></asp:CheckBox>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblIncludeBinFolder" runat="server" ControlName="chkIncludeBinFolder"
                                   Suffix=":" Text="Include Host folder"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkIncludeBinFolder"  runat="server"></asp:CheckBox>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblIncludeModulesFolder" runat="server" ControlName="chkIncludeModulesFolder"
                                   Suffix=":" Text="Include Host folder"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkIncludeModulesFolder"  runat="server">
                        </asp:CheckBox>
                    </td>
                </tr>

                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblIncludeAppDataFolder" runat="server" ControlName="chkIncludeAppDataFolder"
                                   Suffix=":" Text="Include AppData folder" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkIncludeAppDataFolder"  runat="server" />                        
                    </td>
                </tr>       
                         
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblIncludeOtherFolders" runat="server" ControlName="chkIncludeOtherFolders"
                                   Suffix=":" Text="Include Host folder"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkIncludeOtherFolders"  runat="server"></asp:CheckBox>
                    </td>
                </tr>
                
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblExcludeTempFolders" runat="server" ControlName="chkExcludeTempFolders" Suffix=":" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkExcludeTempFolders"  runat="server" />
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblExcludeCacheFolders" runat="server" ControlName="chkExcludeCacheFolders" Suffix=":" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkExcludeCacheFolders"  runat="server" />
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblExcludeLogFiles" runat="server" ControlName="chkIncludeOtherFolders" Suffix=":" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkExcludeLogFiles"  runat="server" />
                    </td>
                </tr>                               

                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblExcludeFoldersList" runat="server" ControlName="txtExcludeFoldersList" Suffix=":" Text="Exclude Foldes List"/>
                    </td>
                    <td>
                        <asp:TextBox ID="txtExcludeFoldersList" runat="server" Columns="60" MaxLength="600" Rows="2" TextMode="MultiLine" />
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblExcludeFilesList" runat="server" ControlName="txtExcludeFilesList"
                                   Suffix=":" Text="Exclude Files List"/>
                    </td>
                    <td>
                        <asp:TextBox ID="txtExcludeFilesList" runat="server" Columns="60" MaxLength="600" Rows="2" TextMode="MultiLine" />
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblExternalFoldersList" runat="server" ControlName="txtExternalFoldersList"
                                   Suffix=":" Text="External Foldes List"/>
                    </td>
                    <td>
                        <asp:TextBox ID="txtExternalFoldersList" runat="server" Columns="60" MaxLength="600" Rows="2" TextMode="MultiLine" />
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td colspan="2">
                        <br />
                        <div style="margin-top: 20px;">
                            <asp:Image ID="imgUpdate" TabIndex="-1" runat="server" ImageUrl="~/images/save.gif"
                                       EnableViewState="False" BorderStyle="None"></asp:Image>
                            <asp:LinkButton ID="cmdUpdate" ResourceKey="cmdUpdate" runat="server" 
                                            Text="Update" BorderStyle="none" CausesValidation="True" ValidationGroup="EvotivaDNNBackup"></asp:LinkButton>
                            &nbsp;
                            <asp:Image ID="imgReturn" TabIndex="-1" runat="server" ImageUrl="~/images/lt.gif"
                                       EnableViewState="False" BorderStyle="None"></asp:Image>
                            <asp:LinkButton ID="cmdReturn" ResourceKey="cmdReturn" runat="server" 
                                            Text="Return" BorderStyle="none" CausesValidation="False"></asp:LinkButton>

                            <%--<dnnwc:commandbutton id="cmdReturn" ResourceKey="cmdReturn" runat="server" causesvalidation="False"
								imageurl="~/images/lt.gif"  DisplayIcon="True" />--%>
                        </div>                    
                    </td>
                </tr>
            </table>
        </td>
    </tr>


    <tr runat="server" id="rowSchedule" visible="True">
        <td>        
            <evotiva:ScheduleList runat="server" ID="scheduleList" 
                                  Caller="BackupConfigurationFiles" 
                                  Filter="Files" />            
        </td>
    </tr>                    

</table>
    
</div>