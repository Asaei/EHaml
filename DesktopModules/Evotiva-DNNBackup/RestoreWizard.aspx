<%@ Page Language="C#" AutoEventWireup="false"  
         CodeBehind="RestoreWizard.aspx.cs" 
         Inherits="Evotiva.DNN.Modules.DNNBackup.RestoreWizard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

    <head id="HeadRestore" runat="server">
        <title>Evotiva .:. DNNBackup | Restore Wizard</title>
        <link rel="stylesheet" type="text/css" href="Install.css" />
        <link rel="stylesheet" type="text/css" href="module.css" />

        <script type="text/javascript">

            function ToDoOnLoad() {
                var rd = document.getElementById('<%= Request.Form["rbSelectZipFile"] %>');
                if (rd) rd.checked = true;
            }

            function checkDisabled(button) {
                if (button.className == "WizardButtonDisabled") {
                    return true;
                } else {
                    return false;
                }
            }
            
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
    </head>

    <body onload=" ToDoOnLoad() ">
        <form id="form1" runat="server">

            <a target="_blank" class="CommandButton" href="http://www.evotiva.com/ContactUs.aspx">
                <img src="logo.gif" alt="Evotiva"  title="Evotiva" style="border-width: 0; border-style: none;"/>
            </a>

            <h1><asp:Label ID="lblMainTitle" runat="server" /></h1>

            <asp:Wizard ID="wizRestore" runat="server" CssClass="Wizard" ActiveStepIndex="0"
                        Font-Names="Verdana" CellPadding="5" CellSpacing="5" FinishCompleteButtonType="Link"
                        FinishPreviousButtonType="Link" StartNextButtonType="Link" StepNextButtonType="Link"
                        StepPreviousButtonType="Link" DisplaySideBar="false">
                <StepStyle VerticalAlign="Top" Width="650px" />
                <NavigationButtonStyle CssClass="WizardButton" />
                <StepNavigationTemplate>
                    <table style="border-spacing: 10px;">
                        <tr>
                            <td style="text-align: right;">
                                <asp:LinkButton ID="CustomButton" runat="server" Text="Custom" CssClass="WizardButton"
                                                Visible="False" />
                            </td>
                            <td style="text-align: right;">
                                <asp:LinkButton ID="StepPreviousButton" runat="server" CommandName="MovePrevious"
                                                Text="Previous" CssClass="WizardButton" />
                            </td>
                            <td style="text-align: right;">
                                <asp:LinkButton ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Next"
                                                CssClass="WizardButton" />
                            </td>
                        </tr>
                    </table>
                </StepNavigationTemplate>
                <HeaderTemplate>            
                </HeaderTemplate>        
                <WizardSteps>

                    <%--Welcome--%>
                    <asp:WizardStep ID="Step_Welcome" runat="Server" Title="Welcome">
                        <h2><asp:Label ID="lblStepWelcomeTitle" runat="server" /></h2>
                        <asp:Label ID="lblStepWelcomeDetail" runat="Server" />
                        <%--<asp:Label ID="lblDNNIsRunning" runat="server" CssClass="bkp-error" />
				<asp:LinkButton ID="lnkDNNIsRunning" runat="server" CssClass="WizardButton">Return</asp:LinkButton>--%>                
                        <asp:Label ID="lblDNNRunning" runat="server"></asp:Label>
                        <br /><br />
                        <asp:Label ID="lblHostWarning" runat="server" CssClass="bkp-error" />
                    </asp:WizardStep>

                    <%--File Permissions--%>
                    <asp:WizardStep ID="Step_FilePermissions" runat="server" Title="FilePermissions">
                        <h2><asp:Label ID="lblStepFilePermissionsTitle" runat="server" /></h2>
                        <asp:Label ID="lblStepFilePermissionsDetail" runat="Server" />
                        <hr />
                        <h3><asp:Label ID="lblPermissions" runat="server" /></h3>
                        <asp:CheckBoxList ID="lstPermissions" runat="server" DataTextField="Name" DataValueField="Permission"
                                          TextAlign="Left" />
                        <hr />
                        <asp:Label ID="lblPermissionsError" runat="server" />
                    </asp:WizardStep>

                    <%--License--%>
                    <asp:WizardStep ID="Step_License" runat="server" Title="License">
                        <h2><asp:Label ID="lblStepLicenseTitle" runat="server" /></h2>
                        <asp:Label ID="lblStepLicenseDetail" runat="Server" />
                        <hr />
                        <br />
                        <asp:Label ID="lblLicenseKey" runat="server" CssClass="bkp-bold" />
                        <br />
                        <asp:textbox id="txtLicenseKey" runat="server" Enabled="false"  TextMode="MultiLine" columns="50" Rows="7"></asp:textbox>
                        <br />
                        <asp:FileUpload ID="uploadFile" runat="server" />
                        <br /><br />
                        <hr />
                        <asp:Label ID="lblLicenseError" runat="server" />            
                    </asp:WizardStep>

                    <%--Operation--%>
                    <asp:WizardStep ID="Step_SelectOperation" runat="server" Title="Operation">
                        <h2><asp:Label ID="lblStepOperationTitle" runat="server" /></h2>
                        <asp:Label ID="lblStepOperationDetail" runat="Server" />
                        <hr />
                        <br />
                        <asp:Label ID="lblOperation" runat="server" CssClass="bkp-bold" />
                        <br /><br />
                        <asp:RadioButton ID="rbOperationDatabaseBackup" runat="server"  ValidationGroup="BkpOperation" GroupName="BkpOperation" />
                        <br /><br />
                        <asp:RadioButton ID="rbOperationSetSafeHostSettings" runat="server"  ValidationGroup="BkpOperation" GroupName="BkpOperation" />
                        <br /><br />
                        <asp:RadioButton ID="rbOperationFilesbackup" runat="server"  ValidationGroup="BkpOperation" GroupName="BkpOperation" />
                        <br /><br />
                        <asp:RadioButton ID="rbOperationZipFiles" runat="server"  ValidationGroup="BkpOperation" GroupName="BkpOperation" />
                        <br /><br />
                        <asp:RadioButton ID="rbOperationAllFiles" runat="server"  ValidationGroup="BkpOperation" GroupName="BkpOperation" />
                        <br /><br />
                        <asp:RadioButton ID="rbOperationSqlQuery" runat="server"  ValidationGroup="BkpOperation" GroupName="BkpOperation" />
                        <br /><br />
                        <hr />
                        <asp:Label ID="lblOperationError" runat="server" />            
                    </asp:WizardStep>

                    <%--Connection String--%>
                    <asp:WizardStep ID="Step_DatabaseConnectionString" runat="server" Title="ConnectionString"> <%--AllowReturn="false"--%>
                        <h2><asp:Label ID="lblStepConnectionStringTitle" runat="server" /></h2>
                        <asp:Label ID="lblStepConnectionStringDetail" runat="Server" />
                        <hr />
                        <asp:Panel ID="pnlUseConnectionString" runat="server">
                            <br />
                            <asp:Label ID="lblUseConnectionString" runat="server" />
                            <br /><br />
                        </asp:Panel>

                        <asp:Panel ID="pnlBuildConnectionString" runat="server">
                            <asp:Label ID="lblWebConfigNotice" runat="server" />
                            <table style="border-spacing: 10px;">
                                <tr>
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblChooseDatabase" runat="server" />
                                    </td>
                                    <td>
                                        <asp:RadioButtonList ID="rblDatabases" runat="Server" AutoPostBack="true" RepeatDirection="Horizontal"
                                                             RepeatColumns="2" />
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table id="tblDatabase" runat="Server" visible="False" style="border-spacing: 1px;">
                                <tr>
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblServer" runat="Server" />
                                    </td>
                                    <td style="width: 150px;">
                                        <asp:TextBox ID="txtServer" runat="Server" Width="150px" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblServerHelp" runat="Server" />
                                    </td>
                                </tr>
                                <tr id="trFile" runat="server">
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblFile" runat="Server" />
                                    </td>
                                    <td style="width: 150px;">
                                        <asp:TextBox ID="txtFile" runat="Server" Width="150px" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblDatabaseFileHelp" runat="Server" />
                                    </td>
                                </tr>
                                <tr id="trDatabase" runat="server">
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblDataBase" runat="Server" />
                                    </td>
                                    <td style="width: 150px;">
                                        <asp:TextBox ID="txtDatabase" runat="Server" Width="150px" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblDatabaseHelp" runat="Server" />
                                    </td>
                                </tr>
                                <tr id="trIntegrated" runat="server">
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblIntegrated" runat="Server" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkIntegrated" runat="Server" AutoPostBack="True" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblIntegratedHelp" runat="Server" />
                                    </td>
                                </tr>
                                <tr id="trUser" runat="Server">
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblUserId" runat="Server" />
                                    </td>
                                    <td style="width: 150px;">
                                        <asp:TextBox ID="txtUserId" runat="Server" Width="150px" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblUserHelp" runat="Server" />
                                    </td>
                                </tr>
                                <tr id="trPassword" runat="Server">
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblPassword" runat="Server" />
                                    </td>
                                    <td style="width: 150px;">
                                        <asp:TextBox ID="txtPassword" runat="Server" TextMode="Password" Width="150px" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblPasswordHelp" runat="Server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="bkp-bold">
                                        <asp:Label ID="lblOwner" runat="Server" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkOwner" runat="Server" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblOwnerHelp" runat="Server" />
                                    </td>
                                </tr>        
                            </table>
                            <table id="tblDatabase2" runat="Server" visible="False" style="border-spacing: 1px;">    
                                <tr>
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblQualifier" runat="Server" />
                                    </td>
                                    <td style="width: 150px;">
                                        <asp:TextBox ID="txtqualifier" runat="Server" Width="150px" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblQualifierHelp" runat="Server" />
                                    </td>
                                </tr>                                  
                            </table>                    
                        </asp:Panel>
                        <hr />
                        <asp:Label ID="lblDataBaseError" runat="server" />
                    </asp:WizardStep>

                    <%--Select File--%>
                    <asp:WizardStep ID="Step_SelectFile" runat="server" Title="Select File">
                        <h2><asp:Label ID="lblStepSelectFileTitle" runat="server" /></h2>
                        <asp:Label ID="lblStepSelectFileDetail" runat="Server" />
                        <hr />
                        <table style="border-spacing: 10px;">
                            <tr>
                                <td style="white-space: nowrap;">
                                    <asp:Label ID="lblFilesLocation" runat="server" CssClass="bkp-bold" Text="Please select the file's source:"/>
                                </td>
                                <td style="text-align: left; width: 100%;">
                                    <asp:dropdownlist id="drpFilesLocation" Runat="server"  AutoPostBack="True" />
                                </td>        
                            </tr> 
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lblRemoteFileNotice" runat="server" CssClass="bkp-bold" Visible="false" Text="NOTE: Once you click on 'Next', please wait while the select file is downloaded to the web server."/>
                                </td>
                            </tr>

                            <tr ID="pnlFilesAmazonS3" runat="server" Visible="false">
                                <td colspan="2">
                                    <%--<asp:Panel ID="pnlFilesAmazonS3" runat="server" Visible="false">--%>
                                        <table id="tblAmazonS3Stuff" style="border-spacing: 10px;" summary="AmazonS3 Settings" runat="server">                       
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblAmazonAccessKeyID" runat="server" CssClass="bkp-bold" Text="Access Key ID" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAmazonAccessKeyID" runat="server"  Columns="60" MaxLength="200" />
                                                    <asp:RequiredFieldValidator ID="valRequiredAmazonAccessKeyID" 
                                                                                runat="server" ErrorMessage="Access Key ID is required"
                                                                                ControlToValidate="txtAmazonAccessKeyID"
                                                                                CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup" />
                                                </td>
                                            </tr>
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblAmazonSecretAccessKey" runat="server"  CssClass="bkp-bold" Text="Secret Access Key" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAmazonSecretAccessKey" runat="server"  Columns="60"
                                                                 MaxLength="200" TextMode="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="valRequiredAmazonSecretAccessKey"
                                                                                runat="server" ErrorMessage="Secret Access Key is required"
                                                                                ControlToValidate="txtAmazonSecretAccessKey"
                                                                                CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>		
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblAmazonS3UseSSL" runat="server" CssClass="bkp-bold" Text="Use SSL" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkAmazonS3UseSSL" runat="server" AutoPostBack="False" />
                                                </td>
                                            </tr>				
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblAmazonBucketName" runat="server" CssClass="bkp-bold" Text="Bucket Name" />					                    </td>
                                                <td>
                                                    <asp:TextBox ID="txtAmazonBucketName" runat="server"  Columns="60" MaxLength="200" />
                                                    <asp:RequiredFieldValidator ID="valRequiredAmazonBucketName" 
                                                                                runat="server" ErrorMessage="Bucket Name is required"
                                                                                ControlToValidate="txtAmazonBucketName"
                                                                                CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup" />
                                                </td>
                                            </tr>
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblAmazonFileNamePattern" runat="server" CssClass="bkp-bold" Text="Folder" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAmazonFileNamePattern" runat="server"  Columns="60" MaxLength="300" />
                                                </td>
                                            </tr>

                                        </table>

                                    <%--</asp:Panel>--%>
                                </td>
                            </tr>
                            
                            <tr ID="pnlFilesCloudfiles" runat="server" Visible="false">
                                <td colspan="2">
                                    <%--<asp:Panel ID="pnlFilesCloudfiles" runat="server" Visible="false">--%>
                                        <table id="tblCloudFilesStuff" style="border-spacing: 10px;" summary="CloudFiles Settings" border="0" runat="server">                                           		                            
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblCloudFilesUserName" runat="server" CssClass="bkp-bold" Text="Username"/>                                                    
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCloudFilesUserName" runat="server"  Columns="60"
                                                                 MaxLength="200"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="valRequiredCloudFilesUserName" 
                                                                                runat="server" ErrorMessage="UserName is required"
                                                                                ControlToValidate="txtCloudFilesUserName"
                                                                                CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblCloudFilesAPIKey" runat="server"   CssClass="bkp-bold"  Text="API Key"/>                                                    
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCloudFilesAPIKey" runat="server"  Columns="60"
                                                                 MaxLength="200" TextMode="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="valRequiredCloudFilesAPIKey" 
                                                                                runat="server" ErrorMessage="API Key is required"
                                                                                ControlToValidate="txtCloudFilesAPIKey"
                                                                                CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblCloudFilesAccountLocation" runat="server" CssClass="bkp-bold" />                                                    
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
                                                    <asp:Label ID="lblCloudFilesContainerName" runat="server" CssClass="bkp-bold" Text="Container Name"/>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCloudFilesContainerName" runat="server"  Columns="60"
                                                                 MaxLength="200" ></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="valRequiredCloudFilesContainerName" 
                                                                                runat="server" ErrorMessage="Container Name is required"
                                                                                ControlToValidate="txtCloudFilesContainerName"
                                                                                CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"></asp:RequiredFieldValidator>

                                                </td>
                                            </tr>

                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblCloudFilesFileNamePattern" runat="server" CssClass="bkp-bold" Text="Folder" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCloudFilesFileNamePattern" runat="server"  Columns="60"
                                                                 MaxLength="300" ></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    <%--</asp:Panel>--%>
                                </td>                                
                            </tr>
                            
                            <tr runat="server" ID="pnlFilesAzure" Visible="false">
                                <td colspan="2">
                                    <%--<asp:Panel runat="server" ID="pnlFilesAzure" Visible="false">--%>
                                        <table id="tblAzureStuff" style="border-spacing: 10px;" summary="Windows Azure Settings" border="0" runat="server">                                                                   
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblAzureAccountName" runat="server" CssClass="bkp-bold" Text="Account Name" />                                                    
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAzureAccountName" runat="server"  Columns="60" MaxLength="300" />
                                                    <asp:RequiredFieldValidator ID="valAzureAccountName"  
                                                                                runat="server"  ErrorMessage="Account Name is required"
                                                                                ControlToValidate="txtAzureAccountName"
                                                                                CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup" />
                                                </td>
                                            </tr>
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblAzureAccessKey" runat="server" CssClass="bkp-bold" Text="Access Key" />   
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAzureAccessKey" runat="server"  Columns="60" MaxLength="300" TextMode="Password" />
                                                    <asp:RequiredFieldValidator ID="valAzureAccessKey"
                                                                                runat="server" ErrorMessage="Access Key is required"
                                                                                ControlToValidate="txtAzureAccessKey"
                                                                                CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup" />
                                                </td>
                                            </tr>

                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblAzureUseSSL" runat="server" CssClass="bkp-bold" Text="Use SSL" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkAzureUseSSL" runat="server" AutoPostBack="False" />   
                                                </td>
                                            </tr>

                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblAzureContainerName" runat="server" CssClass="bkp-bold" Text="Container Name" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAzureContainerName" runat="server"  Columns="60" MaxLength="200" />
                                                    <asp:RequiredFieldValidator ID="valRequiredAzureContainerName" 
                                                                                runat="server" ErrorMessage="Container name is required"
                                                                                ControlToValidate="txtAzureContainerName"
                                                                                CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup" />
                                                </td>
                                            </tr>

                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblAzureFileNamePattern" runat="server" CssClass="bkp-bold" Text="Folder" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAzureFileNamePattern" runat="server"  Columns="60" MaxLength="300" />
                                                </td>
                                            </tr>

                                        </table>
                                    <%--</asp:Panel>--%>
                                </td>                                
                            </tr>
                            
                            <tr ID="pnlFilesFTP" runat="server" Visible="false">
                                <td colspan="2">
                                    <%--<asp:Panel ID="pnlFilesFTP" runat="server" Visible="false">--%>
                                        <table id="tblFtpStuff" style="border-spacing: 10px;" summary="Ftp Settings" border="0" runat="server">
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblUseSFTP" runat="server" CssClass="bkp-bold" Text="Use SFTP"/>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkUseSFTP" runat="server" AutoPostBack="False" />                                                    
                                                </td>
                                            </tr>
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblFtpServer" runat="server" CssClass="bkp-bold" Text="Server (IP or Address)" />                                                    
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFtpServer" runat="server"  Columns="35"
                                                                 MaxLength="100" Width="300px" />
                                                </td>
                                            </tr>
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblFtpServerPort" runat="server" CssClass="bkp-bold" Text="Port" />   
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFtpServerPort" runat="server"  Columns="10" MaxLength="10"  Text="21"/>
                                                    <asp:RangeValidator ID="valFtpServerPort" Text="Please type a number (from 10 to 40000)" runat="server" CssClass="bkp-error" 
                                                                        Display="Dynamic"  ValidationGroup="EvotivaDNNBackup" 
                                                                        ControlToValidate="txtFtpServerPort" MinimumValue="10" MaximumValue="40000"/>
                                                </td>
                                            </tr>
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblFtpUser" runat="server" CssClass="bkp-bold" Text="User" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFtpUser" runat="server"  Columns="35" MaxLength="100" Width="300px"/>
                                                </td>
                                            </tr>
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblFtpPassword" runat="server" CssClass="bkp-bold" Text="Password" />   
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFtpPassword" runat="server"  Columns="35"
                                                                 MaxLength="100" Width="300px" TextMode="Password" />
                                                </td>
                                            </tr>
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblFtpPassiveMode" runat="server" CssClass="bkp-bold" Text="Use Passive mode" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkFtpPassiveMode" runat="server" AutoPostBack="False" Checked="True"/>
                                                </td>
                                            </tr>
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblFtpRemoteFolder" runat="server" CssClass="bkp-bold" Text="Folder" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFtpRemoteFolder" runat="server"  Columns="35"
                                                                 MaxLength="100" Width="300px" />
                                                </td>
                                            </tr>
                                        </table>
                                    <%--</asp:Panel>--%>
                                </td>                                
                            </tr>
                            
                            <tr ID="pnlFilesDropbox" runat="server" Visible="false">
                                <td colspan="2">
                                    <%--<asp:Panel ID="pnlFilesDropbox" runat="server" Visible="false">--%>
                                        <table id="tblDropboxStuff" style="border-spacing: 10px;" summary="Dropbox Settings" border="0" runat="server">          
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblDropBoxAppKey" runat="server" CssClass="bkp-bold" Text="AppKey" />  
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDropBoxAppKey" runat="server"   Columns="60" MaxLength="200" />						
                                                    <asp:RequiredFieldValidator ID="valDropBoxAppKey" 
                                                                                runat="server" ErrorMessage="AppKey is required"
                                                                                ControlToValidate="txtDropBoxAppKey"
                                                                                CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup" />
                                                </td>
                                            </tr>				
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblDropBoxAppSecret" runat="server"  CssClass="bkp-bold" Text="AppSecret"  />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDropBoxAppSecret" runat="server"  Columns="60"
                                                                 MaxLength="200" TextMode="Password" />
                                                    <asp:RequiredFieldValidator ID="valDropBoxAppSecret" 
                                                                                runat="server" ErrorMessage="AppSecret is required"
                                                                                ControlToValidate="txtDropBoxAppSecret"
                                                                                CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"/>
                                                </td>
                                            </tr>
                                            <tr class="bkp-formrow">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblDropBoxFolder" runat="server" CssClass="bkp-bold" Text="Folder" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDropBoxFolder" runat="server"  Columns="60"
                                                                    MaxLength="200"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="valDropBoxFolder" 
                                                                                runat="server" ErrorMessage="Folder is required"
                                                                                ControlToValidate="txtDropBoxFolder"
                                                                                CssClass="bkp-error" Display="Dynamic" ValidationGroup="EvotivaDNNBackup"/>
                                                </td>
                                            </tr>

                                            <tr class="bkp-formrow" runat="server" id="rowDropboxStatus">
                                                <td class="bkp-titlelabel">
                                                    <asp:Label ID="lblDropBoxConnectionStatus" runat="server" CssClass="bkp-bold" Text="Connection Status" />
                                                </td>
                                                <td>
                                                    <asp:Panel runat="server" id="pnlConnectionStatus">
                                                        <asp:Label ID="lblConnectionStatus" runat="server" />
                                                    </asp:Panel>
                                                    <asp:Label  ID="lblDropBoxSecurityToken" runat="server" Visible="false"/>
                                                </td>
                                            </tr>

                                            <tr class="bkp-formrow" runat="server" id="rowDropboxActions">
                                                <td class="bkp-titlelabel">
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    <%--<asp:Label runat="server" ID="lblDropboxConnectionTitle" Text="Connection:&nbsp;&nbsp;" CssClass="bkp-bold" />--%>
                                                    <asp:Image ID="imgRequestConnection" TabIndex="-1" runat="server" ImageUrl="images/RequestConnection.png"
                                                               EnableViewState="False" BorderStyle="None"/>
                                                    <asp:LinkButton ID="cmdDropboxRequestConnection"  Text="Request Connection" runat="server" 
                                                                    BorderStyle="none" CausesValidation="True" ValidationGroup="EvotivaDNNBackup"/>
                                                    &nbsp;&nbsp;
                                                    <asp:Image ID="imgEstablishConnection" TabIndex="-1" runat="server" ImageUrl="images/EstablishConnection.png"
                                                               EnableViewState="False" BorderStyle="None"/>
                                                    <asp:LinkButton ID="cmdDropboxEstablishConnection" Text="Establish Connection" runat="server" 
                                                                    BorderStyle="none" CausesValidation="True" ValidationGroup="EvotivaDNNBackup"/>						
                                                    <%--
                                                    &nbsp;&nbsp;
                                                    <asp:Image ID="imgClearConnection" TabIndex="-1" runat="server" ImageUrl="images/ClearConnection.png"
                                                               EnableViewState="False" BorderStyle="None"/>
                                                    <asp:LinkButton ID="cmdDropboxClearConnection" runat="server"  Text="Clear" CausesValidation="true" />
                                                    --%>
                                                    <asp:Label runat="server" ID="lblDropboxDirections" Text="<ul style='padding-top:0px;'><b>Directions:</b><li>Fill the form, and click on 'Update'.</li><li>Click on 'Request Connection', authorize the connection in Dropbox, and then click on 'Establish Connection'.</li><li>Click again on 'Update' to get the Dropbox's files list.</li></ul>"  />
                                                </td>
                                            </tr>

                                           <%-- <tr class="bkp-formrow"  runat="server" id="rowDropboxTest">
                                                <td class="bkp-titlelabel">
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    <asp:Panel ID="pnlTestResults" runat="server" Visible="false" CssClass="bkp-error">
                                                        <asp:Label ID="lblDropBoxTestResults" runat="server" />
                                                        <asp:Label  ID="lblDropBoxSecurityToken" runat="server" Visible="false"/>
                                                    </asp:Panel>
                                                </td>
                                            </tr>	--%>			

                                        </table>
<%--                                    </asp:Panel>--%>
                                </td>                                
                            </tr>                         

                            <tr>
                                <td colspan="2"><asp:Button ID="btnUpdateOffSiteSettings" runat="server" Text="Update" Visible="false"  ValidationGroup="EvotivaDNNBackup" /></td>
                            </tr>
                        </table>	
                        <hr />
                        <br /><br />
                        <asp:Label ID="lblDatabaseInformation" runat="server" ></asp:Label>
                        <%--<br /><br />--%>
                        <asp:Label ID="lblDatabaseExpressFileInformation" runat="server"  Visible="false"></asp:Label>
                        <br /><br />
                        <asp:Panel ID="pnlNoFileList" runat="server">
                            <asp:Label ID="lblNoFileList" runat="server" ></asp:Label>
                        </asp:Panel>
                        <asp:Panel ID="pnlFileList" runat="server">
                            <table style="border-spacing: 10px;">

                                <%--Disabled native backup files--%>
                                <tr runat="server" id="trDisabledNativeBackups" visible="false">
                                    <td colspan="2"> 
                                        <asp:Label ID="lblDisabledNativeBackupsHeader" runat="server" ></asp:Label><br />
                                        <asp:Repeater ID="rptDisabledNativeBackups" runat="server">
                                            <HeaderTemplate><ul></HeaderTemplate>
                                            <ItemTemplate><li><asp:Label ID="lblDisabledNativeBackup" runat="server"  Text='<%#Container.DataItem %>'></asp:Label></li></ItemTemplate>
                                            <FooterTemplate></ul></FooterTemplate>
                                        </asp:Repeater> 
                                        <br /><br />
                                        <asp:Label ID="lblSelectADatabaseFile" runat="server" CssClass="bkp-bold"></asp:Label> <br /><br />
                                    </td>
                                </tr>

                                <tr runat="server" id="rowFilePassword">
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblZipFilePassword" runat="server" />
                                    </td>
                                    <td>
                                        <asp:textbox id="txtZipFilePassword" runat="server" TextMode="Password" width="150px"></asp:textbox>
                                        &nbsp;&nbsp;<asp:Label ID="lblZipFilePasswordHelp" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblZipFileSelect" runat="server" CssClass="bkp-bold"/>
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:label id="lblItemsPerPage" runat="server" CssClass="bkp-bold">Items Per Page:</asp:label>&nbsp;
                                        <asp:dropdownlist id="selPageSize" Runat="server"  AutoPostBack="True">
                                            <asp:ListItem Selected="True" Value="10">10</asp:ListItem>
                                            <asp:ListItem Value="15">15</asp:ListItem>
                                            <asp:ListItem Value="20">20</asp:ListItem>
                                            <asp:ListItem Value="30">30</asp:ListItem>
                                            <asp:ListItem Value="40">40</asp:ListItem>
                                            <asp:ListItem Value="50">50</asp:ListItem>
                                        </asp:dropdownlist>                    
                                    </td>        
                                </tr>                    
                                <tr>
                                    <td colspan="2">                            
                                        <asp:DataGrid ID="dgFileList" Width="100%" SelectedItemStyle-CssClass="FileManager_SelItem"
                                                      AlternatingItemStyle-CssClass="FileManager_AltItem"
                                                      ItemStyle-CssClass="FileManager_Item" HeaderStyle-CssClass="FileManager_Header"
                                                      AllowSorting="True" CellPadding="5" AutoGenerateColumns="False" AllowPaging="True"
                                                      GridLines="Horizontal" runat="server">
                                            <SelectedItemStyle CssClass="FileManager_SelItem"></SelectedItemStyle>
                                            <EditItemStyle ></EditItemStyle>
                                            <AlternatingItemStyle CssClass="FileManager_AltItem"></AlternatingItemStyle>
                                            <ItemStyle CssClass="FileManager_Item"></ItemStyle>
                                            <HeaderStyle CssClass="FileManager_Header"></HeaderStyle>
                                            <Columns>
                                                <asp:TemplateColumn>
                                                    <ItemStyle HorizontalAlign="Right" Width="1%"></ItemStyle>
                                                    <ItemTemplate>  
                                                        <input name="rbSelectZipFile" type="radio" id='<%#                                        DataBinder.Eval(Container, "DataItem.FileName") %>' value='<%#                                        DataBinder.Eval(Container, "DataItem.FileName") %>' />       
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>                               
                                                <asp:TemplateColumn SortExpression="FileName" HeaderText="FileName">
                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                    <ItemTemplate>
                                                        <asp:LinkButton  runat="server" OnCommand="lnkDLFile_Command" ID="lnkDLFile"
                                                                        CommandArgument='<%#                                        DataBinder.Eval(Container, "DataItem.FileName") %>'>
                                                            <%#                                        DataBinder.Eval(Container, "DataItem.FileName") %>
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn SortExpression="DateModified" HeaderText="Date">
                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                    <ItemStyle HorizontalAlign="Left" ></ItemStyle>
                                                    <ItemTemplate>
                                                        <%#                                        DataBinder.Eval(Container, "DataItem.DateModified") %>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn SortExpression="intFileSize" HeaderText="Size">
                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                    <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                                                    <ItemTemplate>
                                                        <%#                                        DataBinder.Eval(Container, "DataItem.FileSize") %>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <%--<asp:TemplateColumn SortExpression="Extension" HeaderText="Extension">
										<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
										<ItemStyle HorizontalAlign="Center" ></ItemStyle>
										<ItemTemplate>
											<%#DataBinder.Eval(Container, "DataItem.Extension")%>
										</ItemTemplate>
									</asp:TemplateColumn>--%>
                                                <asp:TemplateColumn SortExpression="Type" HeaderText="Type">
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                    <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                                                    <ItemTemplate>
                                                        <%#                DataBinder.Eval(Container, "DataItem.Type") %>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>                    
                                            </Columns>
                                            <PagerStyle Visible="False"></PagerStyle>
                                        </asp:DataGrid>     
                                        <asp:Panel runat="server" ID="tblMessagePager" style="text-align: right;margin-top: 3px;">
                                            <asp:Label ID="lblCurPage" runat="server" CssClass="upg-gridlabel"/>
                                            &nbsp;&nbsp;<asp:LinkButton ID="lnkMoveFirst" runat="server"/>
                                            &nbsp;<asp:LinkButton ID="lnkMovePrevious" runat="server"/>
                                            &nbsp;<asp:LinkButton ID="lnkMoveNext" runat="server"/>
                                            &nbsp;<asp:LinkButton ID="lnkMoveLast" runat="server"/>
                                        </asp:Panel>                                                           
                                    </td>
                                </tr>                                       
                            </table>
                        </asp:Panel>
                        <br />
                        <hr />
                        <asp:Label ID="lblSelectFileError" runat="server" />    
                        <asp:DataGrid ID="grdSelectedRestoreFiles" runat="server" EnableViewState="False"
                                      HeaderStyle-CssClass="bkp-bold" AutoGenerateColumns="True" CellPadding="5">
                            <ItemStyle />
                            <HeaderStyle CssClass="bkp-bold"/>
                        </asp:DataGrid>
                    </asp:WizardStep>

                    <%--Database Restore Settings--%>
                    <asp:WizardStep ID="Step_DatabaseRestoreSettings" runat="server" Title="Restore Settings">
                        <h2><asp:Label ID="lblStepRestoreSettingsTitle" runat="server" /></h2>
                        <asp:Label ID="lblStepRestoreSettingsDetail" runat="Server" />
                        <hr />
                        <br />
                        <asp:Panel ID="pnlDatabaseScriptRestoreSettings" runat="server">                
                            <table style="border-spacing: 10px;">
                                <tr>
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblCreateDatabaseObjects" runat="server" />
                                    </td>
                                    <td>
                                        <%--<asp:RadioButton ID="chkCreateDatabaseObjects" runat="server" GroupName="DbObjects" ValidationGroup="DbObjects" />--%>
                                        <asp:CheckBox ID="chkCreateDatabaseObjects" runat="server" AutoPostBack="True" ValidationGroup="DbObjects" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblCreateDatabaseObjectsHelp" runat="Server" />
                                    </td>                              
                                </tr>                         
                                <tr>
                                    <td class="bkp-bold">
                                        <asp:Label ID="lblApplyDatabaseProviders" runat="server" />
                                    </td>
                                    <td>
                                        <%--<asp:RadioButton ID="chkApplyDatabaseProviders" runat="server" GroupName="DbObjects" ValidationGroup="DbObjects" />--%>
                                        <asp:CheckBox ID="chkApplyDatabaseProviders" runat="server" AutoPostBack="True" ValidationGroup="DbObjects" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblApplyDatabaseProvidersHelp" runat="Server" />
                                    </td>                              
                                </tr>
                                <tr>
                                    <td class="bkp-bold">
                                        <asp:Label ID="lblRestoreTablesData" runat="server" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkRestoreTablesData" runat="server" AutoPostBack="True" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblRestoreTablesDataHelp" runat="Server" />
                                    </td>                            
                                </tr>      
                                <tr>
                                    <td class="bkp-bold">
                                        <asp:Label ID="lblRestoreDataOnlyForScriptsLike" runat="server" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtRestoreDataOnlyForScriptsLike" runat="Server" Width="150px" AutoPostBack="True" />
                                        &nbsp;&nbsp;<asp:CheckBox ID="chkRestoreDataOnlyForScriptsLikeExactMatch" runat="server" Text="Exact match" Checked="True" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblRestoreDataOnlyForScriptsLikeHelp" runat="Server" />
                                    </td>                            
                                </tr>    
                                <tr>
                                    <td class="bkp-bold">
                                        <asp:Label ID="lblOwner2" runat="Server" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkOwner2" runat="Server" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblOwner2Help" runat="Server" />
                                    </td>
                                </tr>                                      
                            </table>    
                            <table style="border-spacing: 10px;">    
                                <tr>
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblQualifier2" runat="Server" />
                                    </td>
                                    <td style="width: 150px;">
                                        <asp:TextBox ID="txtqualifier2" runat="Server" Width="150px" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblQualifier2Help" runat="Server" />
                                    </td>
                                </tr>                                  
                            </table>       
                        </asp:Panel>
                        <asp:Panel ID="pnlDatabaseNativeRestoreSettings" runat="server">
                            <table style="border-spacing: 10px;">
                                <tr>
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblAuxDB" runat="server" />
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="drpAuxDB" runat="server"  DataTextField="Name" DataValueField="Name"></asp:DropDownList>
                                        <%--<asp:TextBox ID="txtAuxDB" runat="server" MaxLength="100" Columns="35" ></asp:TextBox>--%>
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblAuxDBHelp" runat="Server" />
                                    </td>                              
                                </tr> 

                                <tr>
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblWithReplaceRestore" runat="server" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkWithReplaceRestore" runat="server" Checked="True"/>
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblWithReplaceRestoreHelp" runat="Server" />
                                    </td>  
                                </tr>

                                <tr>
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblWithMoveRestore" runat="server" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkWithMoveRestore" runat="server" Checked="True"/>
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblWithMoveRestoreHelp" runat="Server" />
                                    </td>  
                                </tr>

                                <tr>
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblNoRecoveryRestore" runat="server" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkNoRecoveryRestore" runat="server" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblNoRecoveryRestoreHelp" runat="Server" />
                                    </td>  
                                </tr>

                                <tr id="trNativeCredentials" runat="server">
                                    <td colspan="3" class="bkp-bold">
                                        <asp:Label ID="lblNativeCredentialsHelp" runat="Server" />
                                    </td>
                                </tr>
                                <tr id="trIntegratedNative" runat="server">
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblIntegratedNative" runat="Server" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkIntegratedNative" runat="Server" AutoPostBack="True" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblIntegratedNativeHelp" runat="Server" />
                                    </td>
                                </tr>
                                <tr id="trUserNative" runat="Server">
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblUserIdNative" runat="Server" />
                                    </td>
                                    <td style="width: 150px;">
                                        <asp:TextBox ID="txtUserIdNative" runat="Server" Width="150px" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblUserNativeHelp" runat="Server" />
                                    </td>
                                </tr>
                                <tr id="trPasswordNative" runat="Server">
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblPasswordNative" runat="Server" />
                                    </td>
                                    <td style="width: 150px;">
                                        <asp:TextBox ID="txtPasswordNative" runat="Server" TextMode="Password" Width="150px" /> 
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblPasswordNativeHelp" runat="Server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="bkp-bold">
                                        <asp:Label ID="lblOwner3" runat="Server" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkOwner3" runat="Server" Enabled="false" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblOwner3Help" runat="Server" />
                                    </td>
                                </tr>                                                
                            </table>
                            <table style="border-spacing: 10px;">    
                                <tr>
                                    <td class="bkp-bold" style="width: 150px;">
                                        <asp:Label ID="lblQualifier3" runat="Server" />
                                    </td>
                                    <td style="width: 150px;">
                                        <asp:TextBox ID="txtqualifier3" runat="Server" Width="150px" Enabled="false" />
                                    </td>
                                    <td class="Help">
                                        <asp:Label ID="lblQualifier3Help" runat="Server" />
                                    </td>
                                </tr>                                  
                            </table>                     
                        </asp:Panel>
                        <br /><br />
                        <hr />
                        <asp:Label ID="lblRestoreSettingsError" runat="server" />                  
                    </asp:WizardStep>

                    <%--SafeHostSettings--%>
                    <asp:WizardStep ID="Step_SafeHostSettings" runat="server" Title="Safe Host Settings">
                        <h2><asp:Label ID="lblSafeHostSettingsTitle" runat="server" /></h2>
                        <asp:Label ID="lblSafeHostSettingsDetail" runat="Server" />
                        <hr />
                        <asp:Panel ID="pnlSafeHostSettingsEmptyDB" runat="server">
                            <asp:Label ID="lblSafeHostSettingsEmptyDB" runat="server" />
                        </asp:Panel>
                        <asp:Panel ID="pnlSafeHostSettings" runat="server">

                            <div>
                                <h3><asp:Label ID="lblPortalAliases" runat="server" /></h3>
                                <asp:Label ID="lblHostPortalAlias" runat="server" /><br /><br />
                                <asp:Label ID="lblPortalLabel" runat="server" CssClass="bkp-bold"/>&nbsp; <asp:dropdownlist id="drpPortalsList" Runat="server"  AutoPostBack="True" />
                                &nbsp; <asp:Label ID="lblPortalAliasDefaultCurrent" runat="server" /><br />
                                <asp:Label ID="lblPortalAliasLabel" runat="server" CssClass="bkp-bold"/><br />
                                <asp:DataGrid ID="grdPortalAliases" runat="server" EnableViewState="False" summary="Portal Aliases"
                                              HeaderStyle-CssClass="bkp-bold" AutoGenerateColumns="True" CellPadding="5">
                                    <ItemStyle ></ItemStyle>
                                    <HeaderStyle CssClass="bkp-bold"></HeaderStyle>
                                </asp:DataGrid>
                                <br /><br />
                                <asp:Label ID="lblPortalAliasUpdate" runat="server" />&nbsp; <asp:dropdownlist id="drpPortalAliasID" Runat="server"  AutoPostBack="False" />
                                <asp:Label ID="lblToBe" runat="server" />&nbsp; <asp:TextBox ID="txtNewPortalAlias"  Columns="30" runat="server"></asp:TextBox>&nbsp;<asp:Label ID="Label1" runat="server" Text="?" /><br/>
                                 <asp:CheckBox runat="server" ID="chkSetAliasAsDefault"  TextAlign="Left" />
                                <br /><br /> 
                                <asp:LinkButton ID="lnkSetHostPortalAlias" runat="server"  >Set Host PortalAlias</asp:LinkButton>                    
                                <br /><br />
                                <asp:Label ID="lblErrorPortalAlias"  CssClass="bkp-bold" runat="server" />
                                <br /> 
                            </div>

                            <div id="divFixWebServers" runat="server" visible="false">
                                <hr />
                                <h3><asp:Label ID="lblWebServers" runat="server" /></h3>
                                <asp:DataGrid ID="grdWebServers" runat="server" EnableViewState="True" summary="Web Servers"
                                              HeaderStyle-CssClass="bkp-bold" AutoGenerateColumns="True" CellPadding="5">
                                    <ItemStyle ></ItemStyle>
                                    <HeaderStyle CssClass="bkp-bold"></HeaderStyle>
                                </asp:DataGrid>
                                <br />
                                <asp:LinkButton ID="lnkRefreshWebServers" runat="server"  >Refresh Web Servers</asp:LinkButton>
                                <%--&nbsp;&nbsp;&nbsp;
					<asp:LinkButton ID="lnkSetWebServers" runat="server"  >Set Web Servers</asp:LinkButton>--%>                    
                                <br /><br />
                                <asp:Label ID="lblErrorRefreshWebServers"  CssClass="bkp-bold" runat="server" />
                                <br /> 
                            </div>

                            <div id="divSSLEnabled" runat="server" visible="false">                   
                                <hr />
                                <h3><asp:Label ID="lblSSLEnabled" runat="server" /></h3>
                                <asp:DataGrid ID="grdSSLEnabled" runat="server" EnableViewState="True" summary="SSL Enableds Portals"
                                              HeaderStyle-CssClass="bkp-bold" AutoGenerateColumns="True" CellPadding="5">
                                    <ItemStyle ></ItemStyle>
                                    <HeaderStyle CssClass="bkp-bold"></HeaderStyle>
                                </asp:DataGrid>
                                <br />
                                <asp:LinkButton ID="lnkDisableSSL" runat="server"  >Disable SSL</asp:LinkButton>
                                <br /><br />
                                <asp:Label ID="lblErrorDisableSSL"  CssClass="bkp-bold" runat="server" />
                                <br /> 
                            </div>

                            <div>
                                <hr />
                                <h3><asp:Label ID="lblCurrentHostSettings" runat="server" /></h3>
                                <asp:DataGrid ID="grdCurrentHostSettings" runat="server" EnableViewState="True" summary="Host Settings"
                                              HeaderStyle-CssClass="bkp-bold" AutoGenerateColumns="True" CellPadding="5">
                                    <ItemStyle ></ItemStyle>
                                    <HeaderStyle CssClass="bkp-bold"></HeaderStyle>
                                </asp:DataGrid>
                                <h4><asp:Label ID="lblSafeHostSettings" runat="server" /></h4>
                                <table style="border-spacing: 10px;">
                                    <tr>
                                        <td><b>Setting</b></td>
                                        <td><b>Value</b></td>
                                        <td><b>Meaning</b></td>
                                    </tr>
                                    <tr class="bkp-normal">
                                        <td>HttpCompression</td>
                                        <td>0</td>
                                        <td>None: no compression</td>
                                    </tr>
                                    <tr class="bkp-normal">
                                        <td>SchedulerMode</td>
                                        <td>0</td>
                                        <td>Disabled: scheduled tasks will not run</td>
                                    </tr>
                                    <tr class="bkp-normal">
                                        <td>WhitespaceFilter</td>
                                        <td>N</td>
                                        <td>No (disbled): excess white space from the response sent to the client will not be removed</td>
                                    </tr>                                                                                             
                                </table>
                                <br />
                                <asp:LinkButton ID="lnkApplySafeHostSettings" runat="server"  >Apply Safe Host Settings</asp:LinkButton>
                                <br /><br />
                                <asp:Label ID="lblSafeHostSettingsNote" runat="server"   />     
                                <br /><br />
                                <asp:Label ID="lblErrorSafeHostSettings" runat="server"  CssClass="bkp-bold" />       
                                <br />  
                            </div>

                        </asp:Panel>
                        <hr />                             
                    </asp:WizardStep>

                    <%--Step_SqlQuery--%>
                    <asp:WizardStep ID="Step_SqlQuery" runat="server" Title="Sql Query">
                        <h2><asp:Label ID="lblSqlQueryTitle" runat="server" /></h2>
                        <asp:Label ID="lblSqlQueryDetail" runat="Server" />
                        <hr />
                        <asp:TextBox ID="txtQuery" runat="server" TextMode="MultiLine" Rows="15" Width="100%"
                                     EnableViewState="False" Columns="50"></asp:TextBox>
                        <br />
                        <asp:LinkButton ID="cmdExecuteSqlQuery" runat="server"  Width="64px" EnableViewState="False" ToolTip="can include {directives} and /*comments*/">Execute</asp:LinkButton>
                        <asp:CheckBox ID="chkRunSqlQueryAsScript" runat="server"  ResourceKey="chkRunAsScript"
                                      Text="Run as Script" ToolTip="include 'GO' directives; for testing &amp; update scripts"
                                      TextAlign="Left"></asp:CheckBox>
                        <br /><br />
                        <%--<asp:Label ID="lblMessage" CssClass="bkp-bold" Visible="True" runat="server"
						EnableViewState="False"></asp:Label>
						<br /><br />--%>
                        <asp:DataGrid ID="grdSqlQueryResults" runat="server" EnableViewState="False" summary="SQL Grid"
                                      HeaderStyle-CssClass="bkp-bold" AutoGenerateColumns="True" CellPadding="3">
                            <ItemStyle ></ItemStyle>
                            <HeaderStyle CssClass="bkp-bold"></HeaderStyle>
                        </asp:DataGrid>
                        <hr />
                        <asp:Label ID="lblSqlQueryError" runat="server"  CssClass="bkp-bold"/>            
                    </asp:WizardStep>

                    <%--Finished--%>
                    <asp:WizardStep ID="Step_Complete" runat="server" StepType="Finish" Title="Installation Complete">
                        <h2>
                            <asp:Label ID="lblCompleteTitle" runat="server" /></h2>
                        <asp:Label ID="lblCompleteDetail" runat="server" />
                        <asp:Panel ID="pnlFinished" runat="server">
                            <hr />
                            
                            <br /><br />
                            <asp:Label ID="lblReadyToGoDetails" runat="server" />      
                                                  
                            <div id="divFilesBackupWebConfigSettings" runat="server" visible="false">
                                <h3><asp:Label ID="lblFilesBackupWebConfigTitle" runat="server" Text="web.config File Options"/></h3>
                                <asp:CheckBox runat="server" ID="chkFilesBackupWebConfigConnString"  TextAlign="Right"  Text="Update the Connection String<br /><br />" /> 
                                <asp:CheckBox runat="server" ID="chkFilesBackupWebConfigDbo"  TextAlign="Right"  Text="Update the databaseOwner and objectQualifier<br /><br />" />
                                <asp:CheckBox runat="server" ID="chkFilesBackupWebConfigFriendlyUrl"  TextAlign="Right"  Text="Set 'DNNFriendlyUrl' as the default FriendlyUrl Provider." />
                                <asp:CheckBox runat="server" ID="chkFilesBackupWebConfigIISRewrite"  TextAlign="Right"  Text="Remove IIS' 'rewrite' rules." />
                                <br /><br /><br />
                            </div>

                            <asp:Label ID="lblReadyToRestoreDatabaseScript" runat="server" />
                            <asp:Label ID="lblReadyToRestoreDatabaseInfo" runat="server" />
                            <br /><br />
                        </asp:Panel>
                        <hr />
                        <asp:Label ID="lblCompleteError" runat="server"  CssClass="bkp-error" />
                    </asp:WizardStep>            

                </WizardSteps>
            </asp:Wizard>

            <br />
            <asp:Label ID="lblGeneralError" runat="server" />
        </form>
    </body>
</html>