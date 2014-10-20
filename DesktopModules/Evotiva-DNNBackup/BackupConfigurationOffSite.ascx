<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BackupConfigurationOffSite.ascx.cs" 
            Inherits="Evotiva.DNN.Modules.DNNBackup.BackupConfigurationOffSite" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="MenuBar" Src="controls/MenuBar.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="BreadCrumb" Src="controls/BreadCrumb.ascx" %>

<div style="text-align: left;">

<evotiva:MenuBar runat="server" ID="ctlMenuActions" />
<evotiva:BreadCrumb runat="server" ID="ctlBreadConfigActions" ActionsSeparator=" " ShowTitle="False" />

<%--<evotiva:MessagePanel runat="server" ID="ctlMessagePanel" />--%>

<table runat="server" id="MainTable" style="border-spacing: 10px;margin-top: 10px;" summary="DNNBackup OffSite Settings Design Table">

    <tr class="bkp-formrow">
        <td>
            <dnn:SectionHead ID="dshFtpStuff" runat="server" CssClass="bkp-head" IsExpanded="False"
                             ResourceKey="FtpStuff" Section="tblFtpStuff" Text="Ftp Options" IncludeRule="true">
            </dnn:SectionHead>
            <table id="tblFtpStuff"  style="border-spacing: 10px;"  summary="Ftp Settings" runat="server">
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblPerformFtpTransfer" runat="server" ControlName="chkPerformFtpTransfer"
                                   Suffix=":" Text="Perform FTP transfer"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkPerformFtpTransfer"  runat="server" AutoPostBack="True">
                        </asp:CheckBox>
                        &nbsp; 
                        <asp:Image ID="imgFeatureUnavailable" runat="server"  AlternateText="Notice"  />
                        &nbsp; <asp:Label ID="lblFeatureUnavailable" runat="server" ResourceKey="FeatureUnavailable.Text" CssClass="bkp-bold" />
                        <asp:Button ID="btnFTPTest" runat="server" Text="Test" ResourceKey="btnFTPTest.Text" />
                        &nbsp;<asp:Label ID="lblFTPTestResults" runat="server" CssClass="bkp-error" Text=""></asp:Label>
                        <br /><br />
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblDeleteFileAfterFTP" runat="server" ControlName="chkDeleteFileAfterFTP"
                                   Suffix=":" Text="Delete File After FTP"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkDeleteFileAfterFTP"  runat="server" AutoPostBack="False">
                        </asp:CheckBox>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblUseSFTP" runat="server" ControlName="chkUseSFTP"
                                   Suffix=":" Text="Use SFTP"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkUseSFTP"  runat="server" AutoPostBack="True">
                        </asp:CheckBox>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblFtpServer" runat="server" ControlName="txtFtpServer" Suffix=":">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtFtpServer" runat="server"  Columns="35"
                                     MaxLength="100" Width="300px"></asp:TextBox>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblFtpServerPort" runat="server" ControlName="txtFtpServerPort" Suffix=":">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtFtpServerPort" runat="server"  Columns="10"
                                     MaxLength="10"></asp:TextBox>
                        <asp:RangeValidator ID="valFtpServerPort" ResourceKey="valFtpServerPort" runat="server" CssClass="bkp-error" 
                                            Display="Dynamic"  ValidationGroup="EvotivaDNNBackup" 
                                            ControlToValidate="txtFtpServerPort" MinimumValue="10" MaximumValue="40000"></asp:RangeValidator>
                    </td>

                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblFtpUser" runat="server" ControlName="txtFtpUser" Suffix=":"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtFtpUser" runat="server"  Columns="35"
                                     MaxLength="100" Width="300px"></asp:TextBox>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblFtpPassword" runat="server" ControlName="txtFtpPassword" Suffix=":">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtFtpPassword" runat="server"  Columns="35"
                                     MaxLength="100" Width="300px" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>

                <%--            
				<tr class="bkp-formrow">
					<td class="bkp-titlelabel">
						<dnn:Label ID="lblFtpPasswordConfirm" runat="server" ControlName="txtFtpPasswordConfirm"
							Suffix=":"></dnn:Label>
					</td>
					<td>
						<asp:TextBox ID="txtFtpPasswordConfirm" runat="server"  Columns="35"
							MaxLength="100" Width="300px" TextMode="Password" ValidationGroup="EvotivaDNNBackup" CausesValidation="True"></asp:TextBox>
						<asp:CompareValidator ID="valFtpPasswordMatch" runat="server" ResourceKey="valFtpPasswordMatch"
							CssClass="bkp-error" ControlToValidate="txtFtpPasswordConfirm" ErrorMessage="Ftp Password doesn't match"
							Display="Dynamic" ControlToCompare="txtFtpPassword" ValidationGroup="EvotivaDNNBackup"></asp:CompareValidator>
					</td>
				</tr>
				--%>

                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblFtpPassiveMode" runat="server" ControlName="chkFtpPassiveMode"
                                   Suffix=":" Text="Use Passive mode"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkFtpPassiveMode"  runat="server" AutoPostBack="False">
                        </asp:CheckBox>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblFtpRemoteFolder" runat="server" ControlName="txtFtpRemoteFolder"
                                   Suffix=":"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtFtpRemoteFolder" runat="server"  Columns="35"
                                     MaxLength="100" Width="300px"></asp:TextBox>
                    </td>
                </tr>
                <%--                <tr class="bkp-formrow">
					<td colspan="2">
						<hr />
						<asp:Panel runat="server" ID="pnlFtpSettings" Visible="true" Enabled="true">
							<table id="tblFtpStuffDetails" style="border-spacing: 10px;"summary="Ftp Stuff Details" runat="server">
							</table>
						</asp:Panel>
					</td>
				</tr>--%>
            </table>
            <br />
        </td>
    </tr>

    <tr class="bkp-formrow">
        <td>
            <dnn:SectionHead ID="dshAmazonS3Stuff" runat="server" CssClass="bkp-head" IsExpanded="False"
                             ResourceKey="AmazonS3Stuff" Section="tblAmazonS3Stuff" Text="AmazonS3 Options" IncludeRule="true">
            </dnn:SectionHead>
            <table runat="server" id="tblAmazonS3Stuff" style="border-spacing: 10px;" summary="AmazonS3 Settings">
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                    </td>
                    <td>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td colspan="2">
                        <asp:Label ID="lblAmazonS3Info" ResourceKey="lblAmazonS3Info" runat="server" /></td>
                </tr>            
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblPerformAmazonS3Transfer" runat="server" ControlName="chkPerformFtpTransfer"
                                   Suffix=":" Text="Perform AmazonS3 transfer"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkPerformAmazonS3Transfer"  runat="server" AutoPostBack="True">
                        </asp:CheckBox>
                        &nbsp; 
                        <asp:Button ID="btnAmazonS3Test" runat="server" Text="Test" ResourceKey="btnAmazonS3Test.Text" />                                                
                        &nbsp;<asp:Label ID="lblAmazonS3TestResults" runat="server" CssClass="bkp-error" Text=""></asp:Label>
                        <br /><br />
                    </td>
                </tr>    
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblDeleteFileAfterS3" runat="server" ControlName="chkDeleteFileAfterS3"
                                   Suffix=":" Text="Delete File After S3"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkDeleteFileAfterS3"  runat="server" AutoPostBack="False">
                        </asp:CheckBox>
                    </td>
                </tr>	                            
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblAmazonAccessKeyID" runat="server" ControlName="txtAmazonAccessKeyID" Suffix=":">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAmazonAccessKeyID" runat="server"  Columns="60"
                                     MaxLength="200"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="valRequiredAmazonAccessKeyID" ResourceKey="valRequiredAmazonAccessKeyID"
                                                    runat="server" ErrorMessage="Access Key ID is required"
                                                    ControlToValidate="txtAmazonAccessKeyID"
                                                    CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblAmazonSecretAccessKey" runat="server" ControlName="txtAmazonSecretAccessKey" Suffix=":">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAmazonSecretAccessKey" runat="server"  Columns="60"
                                     MaxLength="200" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="valRequiredAmazonSecretAccessKey" ResourceKey="valRequiredAmazonSecretAccessKey"
                                                    runat="server" ErrorMessage="Secret Access Key is required"
                                                    ControlToValidate="txtAmazonSecretAccessKey"
                                                    CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <%--
				<tr class="bkp-formrow">
					<td class="bkp-titlelabel">
						<dnn:Label ID="lblAmazonSecretAccessKeyConfirm" runat="server" ControlName="txtAmazonSecretAccessKeyConfirm"
							Suffix=":"></dnn:Label>
					</td>
					<td>
						<asp:TextBox ID="txtAmazonSecretAccessKeyConfirm" runat="server"  Columns="60"
							MaxLength="200" TextMode="Password" ValidationGroup="EvotivaDNNBackup" CausesValidation="True"></asp:TextBox>
						<asp:CompareValidator ID="valAmazonSecretAccessKeyMatch" runat="server" ResourceKey="valAmazonSecretAccessKeyMatch"
							CssClass="bkp-error" ControlToValidate="txtAmazonSecretAccessKeyConfirm" ErrorMessage="Amazon Secret Access Key doesn't match"
							Display="Dynamic" ControlToCompare="txtAmazonSecretAccessKey" ValidationGroup="EvotivaDNNBackup"></asp:CompareValidator>
					</td>
				</tr>
				--%>

                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblAmazonS3UseSSL" runat="server" ControlName="chkAmazonS3UseSSL"
                                   Suffix=":" Text="Use SSL"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkAmazonS3UseSSL"  runat="server" AutoPostBack="False">
                        </asp:CheckBox>
                    </td>
                </tr>

                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblAmazonBucketName" runat="server" ControlName="txtAmazonBucketName"
                                   Suffix=":"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAmazonBucketName" runat="server"  Columns="60"
                                     MaxLength="200" ></asp:TextBox>
                        <br /><asp:Label ID="lblAmazonBucketNameNotice" runat="server" ResourceKey="lblAmazonBucketNameNotice"></asp:Label>
                        <asp:RequiredFieldValidator ID="valRequiredAmazonBucketName" ResourceKey="valRequiredAmazonBucketName"
                                                    runat="server" ErrorMessage="Bucket Name is required"
                                                    ControlToValidate="txtAmazonBucketName"
                                                    CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>

                    </td>
                </tr>

                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblAmazonFileNamePattern" runat="server" ControlName="txtAmazonFileNamePattern"
                                   Suffix=":"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAmazonFileNamePattern" runat="server"  Columns="60"
                                     MaxLength="300" ></asp:TextBox>
                    </td>
                </tr>

            </table>
            <br />
        </td>
    </tr>

    <tr class="bkp-formrow">
        <td>
            <dnn:SectionHead ID="dshAzureStuff" runat="server" CssClass="bkp-head" IsExpanded="False"
                             ResourceKey="AzureStuff" Section="tblAzureStuff" Text="Windows Azure Options" IncludeRule="true">
            </dnn:SectionHead>
            <table runat="server" id="tblAzureStuff" style="border-spacing: 10px;" summary="Windows Azure Settings">
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                    </td>
                    <td>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td colspan="2">
                        <asp:Label ID="lblAzureInfo" ResourceKey="lblAzureInfo" runat="server" /></td>
                </tr>            
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblPerformAzureTransfer" runat="server" ControlName="chkPerformFtpTransfer"
                                   Suffix=":" Text="Perform Azure transfer"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkPerformAzureTransfer"  runat="server" AutoPostBack="True">
                        </asp:CheckBox>
                        &nbsp; 
                        <asp:Button ID="btnAzureTest" runat="server" Text="Test" ResourceKey="btnAzureTest.Text" />                                                
                        &nbsp;<asp:Label ID="lblAzureTestResults" runat="server" CssClass="bkp-error" Text=""></asp:Label>
                        <br /><br />
                    </td>
                </tr>    
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblDeleteFileAfterAzure" runat="server" ControlName="chkDeleteFileAfterAzure"
                                   Suffix=":" Text="Delete File After Azure"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkDeleteFileAfterAzure"  runat="server" AutoPostBack="False">
                        </asp:CheckBox>
                    </td>
                </tr>	                            
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblAzureAccountName" runat="server" ControlName="txtAzureAccountName" Suffix=":">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAzureAccountName" runat="server"  Columns="60"
                                     MaxLength="300"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="valAzureAccountName" ResourceKey="valAzureAccountName"
                                                    runat="server" 
                                                    ControlToValidate="txtAzureAccountName"
                                                    CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblAzureAccessKey" runat="server" ControlName="txtAzureAccessKey" Suffix=":">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAzureAccessKey" runat="server"  Columns="60"
                                     MaxLength="300" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="valAzureAccessKey" ResourceKey="valAzureAccessKey"
                                                    runat="server" 
                                                    ControlToValidate="txtAzureAccessKey"
                                                    CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblAzureUseSSL" runat="server" ControlName="chkAzureUseSSL"
                                   Suffix=":" Text="Use SSL"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkAzureUseSSL"  runat="server" AutoPostBack="False">
                        </asp:CheckBox>
                    </td>
                </tr>

                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblAzureContainerName" runat="server" ControlName="txtAzureContainerName"
                                   Suffix=":"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAzureContainerName" runat="server"  Columns="60"
                                     MaxLength="200" ></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ID="valRequiredAzureContainerName" ResourceKey="valRequiredAzureContainerName"
                                                    runat="server" 
                                                    ControlToValidate="txtAzureContainerName"
                                                    CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="valAzureContainerName"  runat="server" CssClass="bkp-error" 
                                                        ResourceKey="valInvalidAzureContainerName" 
                                                        ControlToValidate="txtAzureContainerName" Display="Dynamic" 
                                                        ValidationExpression="^(([a-z\d]((-(?=[a-z\d]))|([a-z\d])){2,62})|(\$root))$">
                        </asp:RegularExpressionValidator>
                    </td>
                </tr>

                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblAzureFileNamePattern" runat="server" ControlName="txtAzureFileNamePattern"
                                   Suffix=":"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAzureFileNamePattern" runat="server"  Columns="60"
                                     MaxLength="300" ></asp:TextBox>
                    </td>
                </tr>

            </table>
            <br />
        </td>
    </tr>

    <tr class="bkp-formrow">
        <td>
            <dnn:SectionHead ID="dshCloudFilesStuff" runat="server" CssClass="bkp-head" IsExpanded="False"
                             ResourceKey="CloudFilesStuff" Section="tblCloudFilesStuff" Text="CloudFiles Options" IncludeRule="true">
            </dnn:SectionHead>
            <table runat="server" id="tblCloudFilesStuff" style="border-spacing: 10px;" summary="CloudFiles Settings">
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                    </td>
                    <td>
                    </td>
                </tr>            
                <tr class="bkp-formrow">
                    <td colspan="2">
                        <asp:Label ID="lblCloudFilesInfo" ResourceKey="lblCloudFilesInfo" runat="server" /></td>
                </tr>            
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblPerformCloudFilesTransfer" runat="server" ControlName="chkPerformFtpTransfer"
                                   Suffix=":" Text="Perform CloudFiles transfer"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkPerformCloudFilesTransfer"  runat="server" AutoPostBack="True">
                        </asp:CheckBox>
                        &nbsp; 
                        <asp:Button ID="btnCloudFilesTest" runat="server" Text="Test" ResourceKey="btnCloudFilesTest.Text" />                                                
                        &nbsp;<asp:Label ID="lblCloudFilesTestResults" runat="server" CssClass="bkp-error" Text=""></asp:Label>
                        <br /><br />
                    </td>
                </tr>    
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblDeleteFileAfterCloudFiles" runat="server" ControlName="chkDeleteFileAfterCloudFiles"
                                   Suffix=":" Text="Delete File After CloudFiles"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkDeleteFileAfterCloudFiles"  runat="server" AutoPostBack="False">
                        </asp:CheckBox>
                    </td>
                </tr>		                            
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblCloudFilesUserName" runat="server" ControlName="txtCloudFilesUserName" Suffix=":">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCloudFilesUserName" runat="server"  Columns="60"
                                     MaxLength="200"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="valRequiredCloudFilesUserName" ResourceKey="valRequiredCloudFilesUserName"
                                                    runat="server" ErrorMessage="UserName is required"
                                                    ControlToValidate="txtCloudFilesUserName"
                                                    CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblCloudFilesAPIKey" runat="server" ControlName="txtCloudFilesAPIKey" Suffix=":">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCloudFilesAPIKey" runat="server"  Columns="60"
                                     MaxLength="200" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="valRequiredCloudFilesAPIKey" ResourceKey="valRequiredCloudFilesAPIKey"
                                                    runat="server" ErrorMessage="API Key is required"
                                                    ControlToValidate="txtCloudFilesAPIKey"
                                                    CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblCloudFilesAccountLocation" runat="server" ControlName="ddlCloudFilesAccountLocation" Suffix=":">
                        </dnn:Label>
                    </td>
                    <td>
						<asp:DropDownList ID="ddlCloudFilesAccountLocation"  runat="server">
                            <asp:listitem value="US">US</asp:listitem>
                            <asp:listitem value="UK">UK</asp:listitem>
                        </asp:DropDownList>					
                    </td>
                </tr>

                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblCloudFilesContainerName" runat="server" ControlName="txtCloudFilesContainerName"
                                   Suffix=":"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCloudFilesContainerName" runat="server"  Columns="60"
                                     MaxLength="200" ></asp:TextBox>
                        <br /><asp:Label ID="lblCloudFilesContainerNameNotice" runat="server" ResourceKey="lblCloudFilesContainerNameNotice"></asp:Label>
                        <asp:RequiredFieldValidator ID="valRequiredCloudFilesContainerName" ResourceKey="valRequiredCloudFilesContainerName"
                                                    runat="server" ErrorMessage="Container Name is required"
                                                    ControlToValidate="txtCloudFilesContainerName"
                                                    CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>

                    </td>
                </tr>

                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblCloudFilesFileNamePattern" runat="server" ControlName="txtCloudFilesFileNamePattern"
                                   Suffix=":"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCloudFilesFileNamePattern" runat="server"  Columns="60"
                                     MaxLength="300" ></asp:TextBox>
                    </td>
                </tr>

            </table>
            <br />
        </td>
    </tr>

    <tr class="bkp-formrow">
        <td>
            <dnn:SectionHead ID="dshDropboxStuff" runat="server" CssClass="bkp-head" IsExpanded="False"
                             ResourceKey="DropboxStuff" Section="tblDropboxStuff" Text="Dropbox Options" IncludeRule="true">
            </dnn:SectionHead>
            <table runat="server" id="tblDropboxStuff" style="border-spacing: 10px;" summary="Dropbox Settings">
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                    </td>
                    <td>
                    </td>
                </tr>            
                <tr class="bkp-formrow">
                    <td colspan="2">
                        <asp:Label ID="lblDropboxInfo" ResourceKey="lblDropboxInfo" runat="server" /></td>
                </tr>            
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblPerformDropboxTransfer" runat="server" ControlName="chkPerformFtpTransfer"
                                   Suffix=":" Text="Perform Dropbox transfer"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkPerformDropboxTransfer"  runat="server" AutoPostBack="True">
                        </asp:CheckBox>
                        <%--&nbsp; 
						<asp:Button ID="btnDropboxTest" runat="server" Text="Test" ResourceKey="btnDropboxTest.Text" />                                                
						&nbsp;<asp:Label ID="lblDropboxTestResults" runat="server" CssClass="bkp-error" Text=""></asp:Label>
						<br /><br />--%>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblDeleteFileAfterDropbox" runat="server" ControlName="chkDeleteFileAfterDropbox"
                                   Suffix=":" Text="Delete File After Dropbox"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkDeleteFileAfterDropbox"  runat="server" AutoPostBack="False">
                        </asp:CheckBox>
                    </td>
                </tr>	

                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblDropBoxAppKey" runat="server" ControlName="txtDropBoxAppKey" suffix=":" >
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDropBoxAppKey" runat="server"   Columns="60" MaxLength="200" />						
                        <asp:RequiredFieldValidator ID="valDropBoxAppKey" ResourceKey="valDropBoxAppKey"
                                                    runat="server" ErrorMessage="AppKey is required"
                                                    ControlToValidate="txtDropBoxAppKey"
                                                    CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
                    </td>
                </tr>				
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblDropBoxAppSecret" runat="server" ControlName="txtDropBoxAppSecret" Suffix=":">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDropBoxAppSecret" runat="server"  Columns="60"
                                     MaxLength="200" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="valDropBoxAppSecret" ResourceKey="valDropBoxAppSecret"
                                                    runat="server" ErrorMessage="API Key is required"
                                                    ControlToValidate="txtDropBoxAppSecret"
                                                    CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblDropBoxFolder" runat="server" ControlName="txtDropBoxFolder" Suffix=":">
                        </dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDropBoxFolder" runat="server"  Columns="60"
                                     MaxLength="200"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="valDropBoxFolder" ResourceKey="valDropBoxFolder"
                                                    runat="server" ErrorMessage="API Key is required"
                                                    ControlToValidate="txtDropBoxFolder"
                                                    CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr class="bkp-formrow" runat="server" id="rowDropboxStatus">
                    <td class="bkp-titlelabel">
                        <dnn:Label ID="lblDropBoxConnectionStatus" runat="server" ControlName="lblConnectionStatus"
                                   Suffix=":"></dnn:Label>
                    </td>
                    <td>
                        <asp:Panel runat="server" id="pnlConnectionStatus">
                            <asp:Label ID="lblConnectionStatus" runat="server" />
                        </asp:Panel>
                    </td>
                </tr>

                <tr class="bkp-formrow" runat="server" id="rowDropboxActions">
                    <td class="bkp-titlelabel">
                        &nbsp;
                    </td>
                    <td>
                        <asp:Image ID="imgRequestConnection" TabIndex="-1" runat="server" ImageUrl="images/RequestConnection.png"
                                   EnableViewState="False" BorderStyle="None"></asp:Image>
                        <asp:LinkButton ID="cmdRequestConnection" ResourceKey="cmdRequestConnection" runat="server" 
                                        BorderStyle="none" CausesValidation="True" ValidationGroup="EvotivaDNNBackup"></asp:LinkButton>
                        &nbsp;&nbsp;
                        <asp:Image ID="imgEstablishConnection" TabIndex="-1" runat="server" ImageUrl="images/EstablishConnection.png"
                                   EnableViewState="False" BorderStyle="None"></asp:Image>
                        <asp:LinkButton ID="cmdEstablishConnection" ResourceKey="cmdEstablishConnection" runat="server" 
                                        BorderStyle="none" CausesValidation="True" ValidationGroup="EvotivaDNNBackup"></asp:LinkButton>						
                        &nbsp;&nbsp;
                        <asp:Image ID="imgClearConnection" TabIndex="-1" runat="server" ImageUrl="images/ClearConnection.png"
                                   EnableViewState="False" BorderStyle="None"></asp:Image>
                        <asp:LinkButton ID="cmdClearConnection" runat="server" ResourceKey="cmdClearConnection" CausesValidation="true" />
                    </td>
                </tr>

                <tr class="bkp-formrow"  runat="server" id="rowDropboxTest">
                    <td class="bkp-titlelabel">
                        &nbsp;
                    </td>
                    <td>
                        <asp:Panel ID="pnlTestResults" runat="server" Visible="false" CssClass="bkp-error">
                            <asp:Label ID="lblDropBoxTestResults" runat="server" />
                            <asp:Label  ID="lblSecurityToken" runat="server" Visible="false"/>
                        </asp:Panel>
                    </td>
                </tr>				

            </table>
            <br />
        </td>
    </tr>

    <%--	 
	<tr class="bkp-formrow">
		<td>
			<dnn:SectionHead ID="dhsBoxStuff" runat="server" CssClass="bkp-head" IsExpanded="False"
				ResourceKey="BoxStuff" Section="tblBoxStuff" Text="Box Options" IncludeRule="true">
			</dnn:SectionHead>
		   <table id="tblBoxStuff" style="border-spacing: 10px;"summary="Box Settings" runat="server">
				<tr class="bkp-formrow">
					<td class="bkp-titlelabel">
					</td>
					<td>
					</td>
				</tr>            
				<tr class="bkp-formrow">
					<td colspan="2">
						<asp:Label ID="lblBoxInfo" ResourceKey="lblBoxInfo" runat="server" /></td>
				</tr> 
				<tr class="bkp-formrow">
					<td class="bkp-titlelabel">
						<dnn:Label ID="lblPerformBoxTransfer" runat="server" ControlName="chkPerformBoxTransfer"
							Suffix=":" Text="Perform Box transfer"></dnn:Label>
					</td>
					<td>
						<asp:CheckBox ID="chkPerformBoxTransfer"  runat="server" AutoPostBack="True">
						</asp:CheckBox>
					</td>
				</tr>			
				<tr class="bkp-formrow">
					<td class="bkp-titlelabel">
						<dnn:Label ID="lblDeleteFileAfterBox" runat="server" ControlName="chkDeleteFileAfterBox"
							Suffix=":" Text="Delete File After Box"></dnn:Label>
					</td>
					<td>
						<asp:CheckBox ID="chkDeleteFileAfterBox"  runat="server" AutoPostBack="False">
						</asp:CheckBox>
					</td>
				</tr>	


				<tr class="bkp-formrow">
					<td class="bkp-titlelabel">
						<dnn:Label ID="lblBoxNetApplicationAPIKey" runat="server" ControlName="txtBoxNetApplicationAPIKey" suffix=":" >
						</dnn:Label>
					</td>
					<td>
						<asp:TextBox ID="txtBoxNetApplicationAPIKey" runat="server"   Columns="60" MaxLength="200" />						
						<asp:RequiredFieldValidator ID="valBoxNetApplicationAPIKey" ResourceKey="valBoxNetApplicationAPIKey"
							runat="server" ErrorMessage="APIKey is required"
							ControlToValidate="txtBoxNetApplicationAPIKey"
							CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
					</td>
				</tr>	

				<tr class="bkp-formrow">
					<td class="bkp-titlelabel">
						<dnn:Label ID="lblBoxFolder" runat="server" ControlName="txtBoxFolder" Suffix=":">
						</dnn:Label>
					</td>
					<td>
						<asp:TextBox ID="txtBoxFolder" runat="server"  Columns="60"
							MaxLength="200"></asp:TextBox>
					   <asp:RequiredFieldValidator ID="valBoxFolder" ResourceKey="valBoxFolder"
							runat="server" ErrorMessage="API Key is required"
							ControlToValidate="txtBoxFolder"
							CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
					</td>
				</tr>

				<tr class="bkp-formrow" runat="server" id="rowBoxStatus">
					<td class="bkp-titlelabel">
						<dnn:Label ID="lblBoxNetConnectionStatus" runat="server" ControlName="lblConnectionStatusBox"
							Suffix=":"></dnn:Label>
					</td>
					<td>
						<asp:Panel runat="server" id="pnlConnectionStatusBox">
							<asp:Label ID="lblConnectionStatusBox" runat="server" />
						</asp:Panel>
					</td>
				</tr>

				<tr class="bkp-formrow" runat="server" id="rowBoxNetActions">
					<td class="bkp-titlelabel">
						&nbsp;
					</td>
					<td>
						<asp:Image ID="imgRequestConnectionBox" TabIndex="-1" runat="server" ImageUrl="images/RequestConnection.png"
							EnableViewState="False" BorderStyle="None"></asp:Image>
						<asp:LinkButton ID="cmdRequestConnectionBox" ResourceKey="cmdRequestConnection" runat="server" 
							BorderStyle="none" CausesValidation="True" ValidationGroup="EvotivaDNNBackup"></asp:LinkButton>
						&nbsp;&nbsp;
						<asp:Image ID="imgEstablishConnectionBox" TabIndex="-1" runat="server" ImageUrl="images/EstablishConnection.png"
							EnableViewState="False" BorderStyle="None"></asp:Image>
						<asp:LinkButton ID="cmdEstablishConnectionBox" ResourceKey="cmdEstablishConnection" runat="server" 
							BorderStyle="none" CausesValidation="True" ValidationGroup="EvotivaDNNBackup"></asp:LinkButton>						
						&nbsp;&nbsp;
						<asp:Image ID="imgClearConnectionBox" TabIndex="-1" runat="server" ImageUrl="images/ClearConnection.png"
							EnableViewState="False" BorderStyle="None"></asp:Image>
						<asp:LinkButton ID="cmdClearConnectionBox" runat="server" ResourceKey="cmdClearConnection" CausesValidation="true" />
					</td>
				</tr>				

				<tr class="bkp-formrow"  runat="server" id="rowBoxNetTest">
					<td class="bkp-titlelabel">
						&nbsp;
					</td>
					<td>
						<asp:Panel ID="pnlTestResultsBox" runat="server" Visible="false" CssClass="dnnFormMessage dnnFormValidationSummary">
							<asp:Label ID="lblBoxNetTestResults" runat="server" />
							<asp:Label runat="server" ID="lblBoxNetAuthorizationToken" Visible="false" />
						</asp:Panel>
					</td>
				</tr>					

			</table>			
			<br />
		</td>
	</tr>
--%>
    
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

<script type="text/javascript">

    function ShowPopUp(url) {

        var width = 800;
        var height = 800;
        var behaviors = "status=1,location=1,resizable=1,scrollbars=1";

        //Center Vertically
        var a = Math.round(screen.height / 2);
        var b = Math.round(height / 2);

        var c = a - b;
        //Center Horizontally
        var x = Math.round(screen.width / 2);
        var y = Math.round(width / 2);
        var z = x - y;

        if (z < 0) z = 0;
        if (c < 0) c = 0;

        if (behaviors != "")
            behaviors = "," + behaviors;

        var finalBehaviors = "width=" + width + ",height=" + height + ",top=" + c + ",left=" + z + behaviors;
        var activeWindow = window.open(url, '_blank', finalBehaviors);
    }

</script>
