<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BackupConfigurationDatabase.ascx.cs" 
            Inherits="Evotiva.DNN.Modules.DNNBackup.BackupConfigurationDatabase" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%--<%@ Register TagPrefix="dnn" TagName="DualList" Src="~/controls/DualListControl.ascx" %>--%>
<%@ Register TagPrefix="evotiva" TagName="MenuBar" Src="controls/MenuBar.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="BreadCrumb" Src="controls/BreadCrumb.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="MessagePanel" Src="controls/MessagePanel.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="DualList" Src="controls/DualList.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="ScheduleList" Src="controls/ScheduleList.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="ScheduleEdit" Src="controls/ScheduleEdit.ascx" %>

<div style="text-align: left;">
    
<evotiva:MenuBar runat="server" ID="ctlMenuActions" />
<evotiva:BreadCrumb runat="server" ID="ctlBreadConfigActions" ActionsSeparator=" " ShowTitle="False" />

<table runat="server" id="MainTable" style="margin-top: 10px;border-spacing: 10px;" summary="Database Backup Settings Table" >

    <tr runat="server" id="rowScheduleEdit" visible="False">
        <td>
            <evotiva:ScheduleEdit runat="server" ID="scheduleEdit" 
                                  Caller="BackupConfigurationDatabase" 
                                  Filter="Database" />  
            <br />
        </td>
    </tr>	

    <tr>
        <td>
            <asp:Label runat="server" ID="lblBackupTitle" CssClass="bkp-head" ResourceKey="lblBackupTitle"
                       EnableViewState="False"></asp:Label>
            <hr class="bkp-hr" />
        </td>        
    </tr>

    <tr class="bkp-formrow">
        <td>
            <evotiva:MessagePanel runat="server" ID="ctlMessageDatabaseBackup" />
        </td>
    </tr>

    <tr>
        <td>
            <evotiva:MessagePanel runat="server" ID="ctlMessagePanel" />
        </td>
    </tr>

    <tr>
        <td>

            <asp:Panel runat="server" ID="pnlDatabaseBackupMainSettings">
                <br />
                <dnn:SectionHead ID="dshDatabaseBackupMainSettings" runat="server" CssClass="bkp-head"
                                 IsExpanded="True" ResourceKey="dshDatabaseBackupMainSettings" Section="tblDatabaseBackupMainSettings"
                                 IncludeRule="true"/>
                <table id="tblDatabaseBackupMainSettings" style="border-spacing: 10px;" summary="Database Backup Main Settings Design Table"
                       border="0" runat="server">
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblDbInfo" runat="server" ControlName="lblDatabaseInfo" Suffix=":">
                            </dnn:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblDatabaseInfo"  runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblPerformDatabaseBackup" runat="server" ControlName="chkPerformDatabaseBackup"
                                       Suffix=":" Text="Perform Database Backup"></dnn:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkPerformDatabaseBackup" runat="server" AutoPostBack="True"/>
                        </td>
                    </tr>
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblBackupFileName" runat="server" ControlName="txtBackupFileName"
                                       Suffix=":"></dnn:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtBackupFileName" runat="server"  Columns="35"
                                         MaxLength="100" Width="300px" ValidationGroup="EvotivaDNNBackup" CausesValidation="True"></asp:TextBox><asp:RegularExpressionValidator ID="valBackupFileName"
                                                                                                                                                                                runat="server" CssClass="bkp-error" ResourceKey="valBackupFileName" ControlToValidate="txtBackupFileName"
                                                                                                                                                                                ErrorMessage="Invalid file name." ValidationExpression="[a-zA-Z0-9-_.!]*"
                                                                                                                                                                                Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblTruncateDNNEventLog" runat="server" ControlName="chkTruncateDNNEventLog"
                                       Suffix=":" Text="Truncate DNN Event Log"></dnn:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkTruncateDNNEventLog" runat="server"/>
                        </td>
                    </tr>                    
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblShrinkDatabase" runat="server" ControlName="chkShrinkDatabase"
                                       Suffix=":" Text="Shrink Database"></dnn:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkShrinkDatabase" runat="server"/>
                        </td>
                    </tr>                                         
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblDatabaseBackupMethod" runat="server" Suffix=":" Text="Database Backup Method">
                            </dnn:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkNative" runat="server" ResourceKey="rbNative" AutoPostBack="True" />
                            &nbsp;&nbsp;
                            <asp:CheckBox ID="chkScript" runat="server" ResourceKey="rbScript" AutoPostBack="True" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>

            <asp:Panel runat="server" ID="pnlDatabaseBackupNative">
                <br />
                <dnn:SectionHead ID="dshDatabaseBackupNative" runat="server" CssClass="bkp-head" IsExpanded="True"
                                 ResourceKey="dshDatabaseBackupNative" Section="tblDatabaseBackupNative" IncludeRule="true">
                </dnn:SectionHead>
                <table id="tblDatabaseBackupNative" style="border-spacing: 10px;" summary="Database Backup Native Settings"
                       border="0" runat="server">
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblInitializeStore" runat="server" Suffix=":" ControlName="chkInitializeStore"
                                       Text="Initialize Store"></dnn:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkInitializeStore" runat="server" />
                        </td>
                    </tr>
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblWithCompression" runat="server" Suffix=":" ControlName="chkWithCompression"
                                       Text="With Compression (>= 2008 only)"></dnn:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkWithCompression" runat="server" />
                        </td>
                    </tr>                    
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblContinueAfterErrorBackup" runat="server" Suffix=":" ControlName="chkContinueAfterErrorBackup"
                                       Text="NO_TRUNCATE setting for backup"></dnn:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkContinueAfterErrorBackup" runat="server" />
                            
                        </td>
                    </tr>
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblCreateZipFile" runat="server" Suffix=":" ControlName="chkCreateZipFile"
                                       Text="Create Zip File"></dnn:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkCreateZipFile" runat="server" AutoPostBack="true"/>
                        </td>
                    </tr>
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblDeleteAfterZip" runat="server" Suffix=":" ControlName="chkDeleteAfterZip"
                                       Text="Delete backup file after Zip operation"></dnn:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkDeleteBackupAfterZip" runat="server" />
                            
                        </td>
                    </tr>
                </table>
            </asp:Panel>

            <asp:Panel runat="server" ID="pnlDatabaseBackupScript">
                <br />
                <dnn:SectionHead ID="dshDatabaseBackupScript" runat="server" CssClass="bkp-head" IsExpanded="True"
                                 ResourceKey="dshDatabaseBackupScript" Section="tblDatabaseBackupScript" IncludeRule="true">
                </dnn:SectionHead>
                <table id="tblDatabaseBackupScript" style="border-spacing: 10px;" summary="Database Backup Script Settings"
                       border="0" runat="server">
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblScriptDataProviders" runat="server" ControlName="chkScriptDataProviders"
                                       Suffix=":" Text="Script DataProviders"></dnn:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkScriptDataProviders" runat="server"/>
                        </td>
                    </tr>                    
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblScriptTablesData" runat="server" ControlName="chkScriptTablesData"
                                       Suffix=":" Text="Delete backup file after Zip operation"></dnn:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkScriptTablesData"  runat="server"></asp:CheckBox>
                        </td>
                    </tr>
                    <%--<tr class="bkp-formrow">
						<td class="bkp-titlelabel">
							<dnn:Label ID="lblWarnAboutMissingPKs" runat="server" Suffix=":" ControlName="chkWarnAboutMissingPKs"
								Text="Warn About Missing PKs"></dnn:Label>
						</td>
						<td>
							<asp:CheckBox ID="chkWarnAboutMissingPKs"  runat="server"></asp:CheckBox>
						</td>
					</tr> --%>                   
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblTablesList" runat="server" Text="Tables list" Suffix=":" ControlName="ddlTablesIncludeExclude">
                            </dnn:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlTablesIncludeExclude" runat="server" >
                            </asp:DropDownList>
                            <br />
                            <%--<asp:Label ID="lblTablesListWarning" runat="server">(warning)</asp:Label>--%>
                            <br />
                            <evotiva:DualList ID="ctlTables" runat="server" ListBoxWidth="300" ListBoxHeight="250"
                                              DataValueField="TableFullName" DataTextField="TableFullName" />
                            <br />
                            <label id="plNotCriticalTables" runat="server">
                                <asp:linkbutton id="cmdHelp_plNotCriticalTables" tabindex="-1" runat="server" CausesValidation="False" enableviewstate="False">
                                    <asp:image id="Image1" tabindex="-1" runat="server" imageurl="~/images/help.gif" enableviewstate="False"></asp:image>
                                </asp:linkbutton>                            
                                <asp:LinkButton ID="lnkExcludeNotCriticalTables" runat="server" ResourceKey="lnkExcludeNotCriticalTables"></asp:LinkButton>                            
                            </label>
                            <asp:panel id="pnlHelp_plNotCriticalTables" runat="server" cssClass="Help" enableviewstate="False">
                                <asp:label id="Label4" ResourceKey="plNotCriticalTables.Help" runat="server" enableviewstate="False"></asp:label>
                            </asp:panel>
                            <br /><br />   
                        </td>
                    </tr>

                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblScriptPortalTablesOnly" runat="server" Suffix=":" ControlName="chkScriptPortalTablesOnly"
                                       Text="Script PortalTablesOnly"></dnn:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkScriptPortalTablesOnly"  runat="server" AutoPostBack="true"></asp:CheckBox>
                        </td>
                    </tr>  

                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblBlobBufferBytesLenght" runat="server" ControlName="txtBlobBufferBytesLenght"
                                       Suffix=":" Text="Blob Buffer Size"></dnn:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtBlobBufferBytesLenght" runat="server"  Columns="6"
                                         MaxLength="5" ValidationGroup="EvotivaDNNBackup" CausesValidation="True"></asp:TextBox>
                            <asp:RangeValidator ID="valBlobBufferBytesLenght" runat="server" ResourceKey="valBlobBufferBytesLenght" ErrorMessage="Invalid buffer size" 
                                                ControlToValidate="txtBlobBufferBytesLenght" CssClass="bkp-error" MinimumValue="64" MaximumValue="545760" 
                                                Display="Dynamic" ValidationGroup="EvotivaDNNBackup" Type="Integer">
                            </asp:RangeValidator>
                        </td>
                    </tr>
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblAddGoEvery" runat="server" ControlName="txtAddGoEvery"
                                       Suffix=":" Text="Add Go Every"></dnn:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAddGoEvery" runat="server"  Columns="6"
                                         MaxLength="6" ValidationGroup="EvotivaDNNBackup" CausesValidation="True"></asp:TextBox>
                            <asp:RangeValidator ID="valAddGoEvery" runat="server" ResourceKey="valAddGoEvery" ErrorMessage="Invalid interval" 
                                                ControlToValidate="txtAddGoEvery" CssClass="bkp-error" MinimumValue="0" MaximumValue="20480" 
                                                Display="Dynamic" ValidationGroup="EvotivaDNNBackup" Type="Integer">
                            </asp:RangeValidator>
                        </td>
                    </tr>
                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblMaxLenghtScriptFileSize" runat="server" ControlName="txtMaxLenghtScriptFileSize"
                                       Suffix=":" Text="MaxLenght Script File Size"></dnn:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMaxLenghtScriptFileSize" runat="server"  Columns="12"
                                         MaxLength="12" ValidationGroup="EvotivaDNNBackup" CausesValidation="True"></asp:TextBox>
                            <asp:RangeValidator ID="valMaxLenghtScriptFileSize" runat="server" ResourceKey="valMaxLenghtScriptFileSize" ErrorMessage="Invalid file size" 
                                                ControlToValidate="txtMaxLenghtScriptFileSize" CssClass="bkp-error" MinimumValue="0" MaximumValue="1091520" 
                                                Display="Dynamic" ValidationGroup="EvotivaDNNBackup" Type="Integer">
                            </asp:RangeValidator>
                        </td>
                    </tr>
                    <%--<tr class="bkp-formrow">
						<td class="bkp-titlelabel">
							<dnn:Label ID="lblUseTransactions" runat="server" Suffix=":" ControlName="chkUseTransactions"
								Text="Use Transactions"></dnn:Label>
						</td>
						<td>
							<asp:CheckBox ID="chkUseTransactions"  runat="server"></asp:CheckBox>
						</td>
					</tr> --%>                                     

                    <tr class="bkp-formrow">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblScriptDatabaseObjects" runat="server" ControlName="chkScriptDatabaseObjects"
                                       Suffix=":" Text="Create Zip File"></dnn:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkScriptDatabaseObjects"  runat="server" AutoPostBack="True">
                            </asp:CheckBox>
                            &nbsp; 
                            <asp:Image ID="imgFeatureUnavailable" runat="server"  AlternateText="Notice"  />
                            &nbsp; <asp:Label ID="lblFeatureUnavailable" runat="server" ResourceKey="FeatureUnavailable.Text"  CssClass="bkp-bold"/>
                        </td>
                    </tr>
                    <%--<tr class="bkp-formrow">
					<td class="bkp-titlelabel"><dnn:Label id="lblScriptOwner" runat="server" controlname="chkScriptOwner" suffix=":" text="Initialize Store"></dnn:Label></td>
					<td><asp:checkbox id="chkScriptOwner"  run at="server"></asp:checkbox></td>
					</tr>--%>
                    <tr class="bkp-formrow" id="rowScriptMethod">
                        <td class="bkp-titlelabel">
                            <dnn:Label ID="lblScriptMethod" runat="server" ControlName="chkScriptOwner" Suffix=":" Text="Script Method"/>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlScriptMethod" runat="server" />                            
                        </td>
                    </tr>
                    <%--<tr class="bkp-formrow">
					<td class="bkp-titlelabel"><dnn:Label id="lblUseCustomSchemaViews" runat="server" suffix=":" controlname="chkUseCustomSchemaViews"
							text="Download Method"></dnn:Label></td>
					<td><asp:checkbox id="chkUseCustomSchemaViews"  runat="server"></asp:checkbox></td>
					</tr>--%>
                </table>
            </asp:Panel>

        </td>
    </tr>

    <tr>
        <td>
            <div style="margin-top: 20px;">
                <asp:Image ID="imgUpdate" TabIndex="-1" runat="server" ImageUrl="~/images/save.gif"
                           EnableViewState="False" BorderStyle="None"></asp:Image>
                <asp:LinkButton ID="cmdUpdate" ResourceKey="cmdUpdate" runat="server" 
                                Text="Update" BorderStyle="none" CausesValidation="True" ValidationGroup="EvotivaDNNBackup"></asp:LinkButton>
                &nbsp;
                <asp:Image ID="Image2" TabIndex="-1" runat="server" ImageUrl="~/images/refresh.gif"
                           EnableViewState="False" BorderStyle="None"></asp:Image>
                <asp:LinkButton ID="cmdClearCache" ResourceKey="cmdClearCache" runat="server" 
                                Text="Update" BorderStyle="none" CausesValidation="True" ValidationGroup="EvotivaDNNBackup"></asp:LinkButton>
                &nbsp;    
                <asp:Image ID="imgReturn" TabIndex="-1" runat="server" ImageUrl="~/images/lt.gif"
                           EnableViewState="False" BorderStyle="None"></asp:Image>
                <asp:LinkButton ID="cmdReturn" ResourceKey="cmdReturn" runat="server" 
                                Text="Return" BorderStyle="none" CausesValidation="False"></asp:LinkButton>
            </div>        
        </td>
    </tr>

    <tr runat="server" id="rowSchedule" visible="True">
        <td>        
            <evotiva:ScheduleList runat="server" ID="scheduleList" 
                                  Caller="BackupConfigurationDatabase" 
                                  Filter="Database" />            
        </td>
    </tr> 

</table>
    
</div>