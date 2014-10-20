<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="BackupConfigurationLicensing.ascx.cs" 
            Inherits="Evotiva.DNN.Modules.DNNBackup.BackupConfigurationLicensing" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="MenuBar" Src="controls/MenuBar.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="BreadCrumb" Src="controls/BreadCrumb.ascx" %>
<%@ Register TagPrefix="evotiva" TagName="MessagePanel" Src="controls/MessagePanel.ascx" %>

<div style="text-align: left;">

<evotiva:MenuBar runat="server" ID="ctlMenuActions" />
<evotiva:BreadCrumb runat="server" ID="ctlBreadConfigActions" ActionsSeparator=" " ShowTitle="False" />

<evotiva:MessagePanel runat="server" ID="ctlMessagePanel" />

<table runat="server" id="MainTable" style="border-spacing: 10px;margin-top: 10px;" summary="Licensing Settings">
    <tr>
        <td>
            <dnn:SectionHead ID="dshLicensingStuff" runat="server" CssClass="bkp-head" IsExpanded="True"
                             ResourceKey="dshLicensing" Section="tblLicensingStuff" Text="Licensing Configuration" IncludeRule="true">
            </dnn:SectionHead>
            <table runat="server" id="tblLicensingStuff" style="border-spacing: 10px;" summary="Licensing Design Table">

                <tr id="rowModuleInfo" runat="server" class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label id="lblModuleInfo" runat="server" controlname="lblModuleInfoMessage" suffix=":"></dnn:Label>
                    </td>
                    <td>
                        <asp:label id="lblModuleInfoMessage"  runat="server"></asp:label>
                    </td>
                </tr>

                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel"><dnn:Label id="lblCurrentDomain" runat="server" controlname="lblCurrentDomainMessage" suffix=":"></dnn:Label></td>
                    <td>
                        <asp:label id="lblCurrentDomainMessage" CssClass="bkp-normal" runat="server"></asp:label>
                    </td>
                </tr>
                <tr class="bkp-formrow" visible="false" >
                    <td class="bkp-titlelabel"><dnn:Label id="lblCurrentServerSignature" runat="server" controlname="lblCurrentServerSignatureMessage" suffix=":"></dnn:Label></td>
                    <td>
                        <asp:label id="lblCurrentServerSignatureMessage" CssClass="bkp-normal" runat="server"></asp:label>
                    </td>
                </tr>		
                <tr runat="server" id="rowLicStatus" class="bkp-formrow">
                    <td class="bkp-titlelabel"><dnn:Label id="lblLicenseStatus" runat="server" controlname="txtLicenseStatus" suffix=":"></dnn:Label></td>
                    <td>
                        <asp:label id="lblLicenseStatusMessage" CssClass="bkp-normal" runat="server"></asp:label></td>
                </tr>
                <tr runat="server" id="rowLnkEmail" visible="false" class="bkp-formrow">
                    <td class="bkp-titlelabel"></td>
                    <td>
                        <%--		            <br />
					<asp:label id="lblContactMessage"  runat="server" ResourceKey="LicenseContactSupport.Message"></asp:label>--%>
                        <br /><br />
                        <asp:hyperlink id="lnkEmail"  runat="server" ResourceKey="lnkEmail">email</asp:hyperlink>&nbsp;
                        <asp:label id="lblLnkEmailDescription"  runat="server" ResourceKey="lblLnkEmailDescription.Text"></asp:label>
                        <br /><asp:hyperlink id="lnkEmailAlt"  runat="server" ResourceKey="lnkEmailAlt">email</asp:hyperlink>
                        &nbsp;<asp:label id="lblEmailAltHelp"  runat="server" ResourceKey="lnkEmailAltHelp.Text"></asp:label>
                        <br /><br />
                    </td>
                </tr>
                <tr class="bkp-formrow">
                    <td class="bkp-titlelabel">
                        <dnn:Label id="lblLicenseKey" runat="server" controlname="txtLicenseKey" suffix=":"/>
                    </td>
                    <td>
                        <asp:textbox id="txtLicenseKey" runat="server" Rows="7" columns="50" TextMode="MultiLine"/>
                        <br /><asp:Label runat="server" ID="lblLicenseKeyMessage" ResourceKey="lblLicenseKeyMessage"/>
                        <%--                        
                        <br /><asp:FileUpload ID="uploadFile" runat="server"  Width="100%" />
                        <br /><asp:Label ID="lblUploadMessage" runat="server" CssClass="bkp-error" Visible="false"></asp:Label>
                        --%>
                    </td>
                </tr>

                <tr>
                    <td class="bkp-titlelabel">
                            &nbsp;
                        </td>
                        <td>
                        <div style="margin-top: 10px;" >                            
                            <asp:Image ID="imgUpdate" TabIndex="-1" runat="server" ImageUrl="~/images/save.gif"
                                       EnableViewState="False" BorderStyle="None"/>
                            <asp:LinkButton ID="cmdUpdate" ResourceKey="cmdUpdate" runat="server" 
                                            Text="Update" BorderStyle="none" CausesValidation="True" ValidationGroup="EvotivaDNNBackup"/>        
                            <%--
                            <asp:Image ID="imgUpload" TabIndex="-1" runat="server" ImageUrl="~/images/FileManager/files/Upload.gif"
                                       EnableViewState="False" BorderStyle="None"/>
                            <asp:LinkButton ID="cmdUpload" ResourceKey="cmdUploadUpdate" runat="server" 
                                            Text="Upload" BorderStyle="none" CausesValidation="False"/>
                            --%>
                            &nbsp;
                            <asp:Image ID="imgReset" TabIndex="-1" runat="server" ImageUrl="~/images/reset.gif"
                                       EnableViewState="False" BorderStyle="None"/>
                            <asp:LinkButton ID="cmdReset" ResourceKey="cmdReset" runat="server" 
                                            Text="Return" BorderStyle="none" CausesValidation="False"/>                                
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
                        <div>
                            <evotiva:MessagePanel runat="server" ID="MessagePanelMaintenance"  Visible="false"/>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
    
</div>