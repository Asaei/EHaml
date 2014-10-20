<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BackupDefault.ascx.cs"
            Inherits="Evotiva.DNN.Modules.DNNBackup.BackupDefault" %>    
<%@ Register TagPrefix="evotiva" TagName="MenuBar" Src="controls/MenuBar.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="MessagePanel" Src="controls/MessagePanel.ascx" %>

<asp:Label ID="lblLicenseStatus" runat="server" ></asp:Label>

<asp:Panel ID="pnlActions" runat="server">
    <evotiva:MenuBar runat="server" ID="ctlMenuActions" />
</asp:Panel>

<evotiva:MessagePanel runat="server" ID="ctlMessagePanel" visible="False"/>

<asp:Panel ID="pnlMainForm" runat="server">

    <div id="divMainBackupDefault">

        <%--<table>
<tr>
<td style="width:100%;white-space:nowrap;">--%>
        <p style="margin-top: 20px;margin-bottom: 20px;">
        <asp:Label ID="lblBackupOptions" runat="server" ResourceKey="lblBackupOptions" CssClass="bkp-head"></asp:Label>
        </p>

        <div class="bkp-centeredrow">
            <asp:CheckBox ID="chkBackupDatabase" runat="server" CssClass="bkp-normal bkp-centeredrow" />&nbsp;
            <img src="<%= ResolveUrl("images/Database.png") %>"  alt="Database" style="border: 0;" class="bkp-centeredrow" />
            <asp:Label ID="lblBackupDatabase" runat="server" CssClass="bkp-mainoption bkp-centeredrow"></asp:Label>

            <br  /><asp:CheckBox ID="chkBackupDBAnyway" runat="server" CssClass="bkp-error bkp-centeredrow" Visible="false" ResourceKey="chkBackupDBAnyway"/>
        </div>
        <br />

        <div class="bkp-centeredrow">
            <asp:CheckBox ID="chkBackupFiles" runat="server" CssClass="bkp-normal bkp-centeredrow" />&nbsp;
            <img src="<%= ResolveUrl("images/Files.png") %>" alt="Files" style="border: 0;" class="bkp-centeredrow" />
            <asp:Label ID="lblBackupFiles" runat="server"  CssClass="bkp-mainoption bkp-centeredrow"></asp:Label>
        </div>
        <br />

        <div class="bkp-centeredrow" runat="server" visible="true" id="divFTPUpload">
            <asp:CheckBox ID="chkFtpUpload" runat="server" CssClass="bkp-normal bkp-centeredrow" />&nbsp;
            <img src="<%= ResolveUrl("images/Upload.png") %>" alt="Upload" style="border: 0;" class="bkp-centeredrow" />
            <asp:Label ID="lblFtpUpload" runat="server" ResourceKey="lblFtpUpload" CssClass="bkp-mainoption bkp-centeredrow"></asp:Label>
            <br /><br />
        </div>

        <div class="bkp-centeredrow" runat="server" visible="true" id="divAmazonS3Upload">
            <asp:CheckBox ID="chkAmazonS3Upload" runat="server" CssClass="bkp-normal bkp-centeredrow" />&nbsp;
            <img src="<%= ResolveUrl("images/AmazonS3.png") %>" alt="Upload" style="border: 0;" class="bkp-centeredrow" />
            <asp:Label ID="lblAmazonS3Upload" runat="server" ResourceKey="lblAmazonS3Upload" CssClass="bkp-mainoption bkp-centeredrow"></asp:Label>
            <br /><br />
        </div>

        <div class="bkp-centeredrow" runat="server" visible="true" id="divAzureUpload">
            <asp:CheckBox ID="chkAzureUpload" runat="server" CssClass="bkp-normal bkp-centeredrow" />&nbsp;
            <img src="<%= ResolveUrl("images/Azure.png") %>" alt="Upload" style="border: 0;" class="bkp-centeredrow" />
            <asp:Label ID="lblAzureUpload" runat="server" ResourceKey="lblAzureUpload" CssClass="bkp-mainoption bkp-centeredrow"></asp:Label>
            <br /><br />
        </div>

        <div class="bkp-centeredrow" runat="server" visible="true" id="divCloudFilesUpload">
            <asp:CheckBox ID="chkCloudFilesUpload" runat="server" CssClass="bkp-normal bkp-centeredrow" />&nbsp;
            <img src="<%= ResolveUrl("images/Rackspace.png") %>" alt="Upload" style="border: 0;" class="bkp-centeredrow" />
            <asp:Label ID="lblCloudFilesUpload" runat="server" ResourceKey="lblCloudFilesUpload" CssClass="bkp-mainoption bkp-centeredrow"></asp:Label>
            <br /><br />
        </div>

        <div class="bkp-centeredrow" runat="server" visible="true" id="divDropboxUpload">
            <asp:CheckBox ID="chkDropboxUpload" runat="server" CssClass="bkp-normal bkp-centeredrow" />&nbsp;
            <img src="<%= ResolveUrl("images/Dropbox.png") %>" alt="Upload" style="border: 0;" class="bkp-centeredrow" />
            <asp:Label ID="lblDropboxUpload" runat="server" ResourceKey="lblDropboxUpload" CssClass="bkp-mainoption bkp-centeredrow"></asp:Label>
            <br /><br />
        </div>

        <p>
            <%--<asp:image id="imgRunBackup"  tabindex="-1" runat="server" imageurl="images/Backup.gif" enableviewstate="False"></asp:image>
			<asp:LinkButton ID="cmdRunBackup" ResourceKey="cmdRunBackup" runat="server" 
			Text="Return" BorderStyle="none" CausesValidation="False"></asp:LinkButton> --%>            
            <asp:LinkButton ID="btnRunbackup" runat="server" ResourceKey="btnRunbackup" CssClass="bkp-linkbutton" /> 
            &nbsp;&nbsp;
            <asp:CheckBox ID="chkRunInBackground" runat="server" ResourceKey="chkRunInBackground" TextAlign="Right"/>
            <br />
            <asp:Label ID="lblLastRunbackup" runat="server" ResourceKey="lblLastRunbackup" CssClass="bkp-centeredrow"></asp:Label>
            &nbsp;
            <asp:Label ID="lblLastRunbackupText" runat="server" CssClass="bkp-normal bkp-centeredrow"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkResetLastRunbackup" runat="server" ResourceKey="lnkResetLastRunbackup" CssClass="bkp-normal bkp-centeredrow">Reset</asp:LinkButton>            
        </p>
        <%--</td>
<td>
<img id="Img2" runat="server" src="images/DNNBackup.png" alt="Evotiva DNN Backup" style="border: 0;" class="bkp-centeredrow" />
</td>        
</tr>        
</table>  --%>      

        <%-- <br />                
		<hr class="bkp-hr" />--%>


        <br /> <br />
        <asp:Label ID="lblRestore" runat="server" ResourceKey="lblRestore" CssClass="bkp-head"></asp:Label>
        <br /><br />
        <p>
            <%--<asp:image id="imgRunBackup"  tabindex="-1" runat="server" imageurl="images/Backup.gif" enableviewstate="False"></asp:image>
			<asp:LinkButton ID="cmdRunBackup" ResourceKey="cmdRunBackup" runat="server" 
			Text="Return" BorderStyle="none" CausesValidation="False"></asp:LinkButton> --%>            
            <asp:LinkButton ID="btnRestore" runat="server" ResourceKey="btnRestore"  CssClass="bkp-linkbutton" />     
            &nbsp;&nbsp;
            <asp:CheckBox ID="chkInstallRestorePack" runat="server" ResourceKey="chkInstallRestorePack" TextAlign="Right"/>
        </p>

        <br /><br />
        <asp:Label ID="lblRecentBackups" runat="server" ResourceKey="lblRecentBackups" CssClass="bkp-head"></asp:Label>
        <br />

        <table id="tblDatabase" style="border-spacing: 10px;" runat="server">

            <tr class="bkp-formrow" runat="server" id="rowLastDatabaseBackup" visible="false">
                <td class="bkp-formrow bkp-nowraptext">
                    <asp:ImageButton ID="btnLastDatabaseBackup" runat="server" ImageUrl="images/Download" AlternateText="Download" ToolTip="Download" CssClass="CommandButton bkp-centeredrow" style="border: 0;" CausesValidation="False" />                    
                    <asp:Label ID="lblLastDatabaseBackup" runat="server"  ResourceKey="lblLastDatabasetBackup" CssClass="bkp-titlelabel" Text="Last Database Backup:"></asp:Label>
                </td>
                <td class="bkp-normal bkp-formrow bkp-centeredrow">
                    <asp:Label ID="lblLastDatabaseBackupDateInfo" runat="server" ></asp:Label>
                </td>
            </tr>

            <tr class="bkp-formrow" runat="server" id="rowLastDatabaseNativeBackup">
                <td class="bkp-formrow bkp-nowraptext">
                    <asp:ImageButton ID="btnLastDatabaseNativeBackup" runat="server" ImageUrl="images/Download" AlternateText="Download" ToolTip="Download" CssClass="CommandButton bkp-centeredrow" style="border: 0;" CausesValidation="False" />
                    <%--<a href="#" runat="server" id="lnkLastDatabaseBackup">
					<img id="imgLastDatabaseBackup" runat="server" src="images/Download.png" alt="Download" title="Download" style="border: 0;" class="bkp-centeredrow"  />
					</a>--%>
                    <%--<asp:LinkButton ID="lnkDownloadLastDatabaseBackup" runat="server" ResourceKey="Download" ></asp:LinkButton>--%>
                    <asp:Label ID="lblLastDatabaseNativeBackup" runat="server"  ResourceKey="lblLastDatabaseNativeBackup" CssClass="bkp-titlelabel" Text="Last Database Backup:"></asp:Label>
                </td>
                <td class="bkp-normal bkp-formrow bkp-centeredrow">
                    <%--<asp:Label ID="lblLastDatabaseBackupFileName" runat="server" Text="mydatabase20091104.bak"  ></asp:Label>
					<br />--%>
                    <asp:Label ID="lblLastDatabaseNativeBackupDateInfo" runat="server" ></asp:Label>
                </td>
            </tr>
            <tr class="bkp-formrow" runat="server" id="rowLastDatabaseScriptBackup">
                <td class="bkp-formrow bkp-nowraptext">
                    <asp:ImageButton ID="btnLastDatabaseScriptBackup" runat="server" ImageUrl="images/Download" AlternateText="Download" ToolTip="Download" CssClass="CommandButton bkp-centeredrow" style="border: 0;" CausesValidation="False" />                    
                    <asp:Label ID="lblLastDatabaseScriptBackup" runat="server"  ResourceKey="lblLastDatabaseScriptBackup" CssClass="bkp-titlelabel" Text="Last Database Backup:"></asp:Label>
                </td>
                <td class="bkp-formrow bkp-centeredrow">
                    <asp:Label ID="lblLastDatabaseScriptBackupDateInfo" runat="server" ></asp:Label>
                </td>
            </tr>

            <tr class="bkp-formrow" runat="server" id="rowLastFilesBackup">
                <td class="bkp-formrow bkp-nowraptext">
                    <asp:ImageButton ID="btnLastFilesBackup" runat="server" ImageUrl="images/Download.png" AlternateText="Download" ToolTip="Download" CssClass="CommandButton bkp-centeredrow" style="border: 0;" CausesValidation="False" />
                    <%--<a href="#" runat="server" id="lnkLastFilesBackup">
					<img id="imgLastFilesBackup" runat="server" src="images/Download.png" alt="Download" title="Download" style="border: 0;" class="bkp-centeredrow"  />
					</a>--%>
                    <asp:Label ID="lblLastFilesBackup" runat="server" ResourceKey="lblLastFilesBackup" CssClass="bkp-titlelabel" Text="Last Files Backup:"></asp:Label>
                </td>
                <td class="bkp-normal bkp-formrow bkp-centeredrow">
                    <%--<asp:Label ID="lblLastFilesBackupFileName" runat="server" Text="myfiles20090104.bak"  ></asp:Label>
					<br />--%>
                    <asp:Label ID="lblLastFilesBackupDateInfo" runat="server"  ></asp:Label>
                </td>
            </tr>            
        </table>

        <hr class="bkp-hr" />

        <%--<br />
		<img id="Img2" runat="server" src="images/DownloadDisabled.png" alt="Download" style="border: 0; vertical-align: middle;" />&nbsp;
		<asp:Label ID="Label3" runat="server" Text="Last Files Backup: "  CssClass="bkp-bold"></asp:Label>&nbsp;
		<asp:Label ID="Label4" runat="server" Text="myfiles20090104.bak - 14 Apr 2009, 5 days ago"  ></asp:Label>
		<hr class="bkp-hr" />--%>

    </div>
</asp:Panel>

<%--<div id="bkp_manager_table_bg">
	<table runat="server" id="tblConfiguration" style="border-spacing: 10px;"
		summary="Configuration Design Table">
		<tr>
			<td align="left">
			</td>
		</tr>
	</table>
</div>
--%>