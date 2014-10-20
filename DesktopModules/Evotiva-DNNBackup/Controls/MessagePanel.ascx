<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="MessagePanel.ascx.cs" 
            Inherits="Evotiva.DNN.Modules.DNNBackup.MessagePanel" %>

<div runat="server" class="bkp-attentionbackground" id="divMessagePanel" visible="true">
    <table>
        <tr>
            <td>
                <asp:Image ID="imgMessage" runat="server" />
            </td>
            <td style="padding-left: 10px;">                
                <asp:Label runat="server" ID="lblMessage"/>
            </td>
        </tr>
    </table>
</div>