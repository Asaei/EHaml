<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="DualList.ascx.cs" 
            Inherits="Evotiva.DNN.Modules.DNNBackup.DualList" %>

<table style="border-spacing: 10px;">
    <tr>
        <td style="text-align: center;" class="bkp-bold"><asp:Label id=Label1 runat="server" enableviewstate="False">Available</asp:Label></td>
        <td style="text-align: center;">&nbsp;</td>
        <td style="text-align: center;" class="bkp-bold"><asp:Label id=Label2 runat="server" enableviewstate="False">Assigned</asp:Label></td>
    </tr>
    <tr>
        <td style="text-align: center; vertical-align: top;">
            <asp:ListBox ID="lstAvailable" runat="server" SelectionMode="Multiple"></asp:ListBox>
        </td>
        <td style="text-align: center; vertical-align: middle;">
            <table style="border-spacing: 1px;">
                <tr>
                    <td style="text-align: center; vertical-align: top;"><asp:linkbutton id="cmdAdd" runat="server"  Text="&nbsp;>&nbsp;" enableviewstate="False" /></td>
                </tr>
                <tr>
                    <td style="text-align: center; vertical-align: top;"><asp:linkbutton id="cmdRemove" runat="server"  Text="&nbsp;<&nbsp;" enableviewstate="False" /></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td style="text-align: center; vertical-align: bottom;"><asp:linkbutton id="cmdAddAll" runat="server"  Text="&nbsp;>>&nbsp;" enableviewstate="False" /></td>
                </tr>
                <tr>
                    <td style="text-align: center; vertical-align: bottom;"><asp:linkbutton id="cmdRemoveAll" runat="server"  Text="&nbsp;<<&nbsp;" enableviewstate="False" /></td>
                </tr>
            </table>
        </td>
        <td style="text-align: center; vertical-align: top;">
            <asp:listbox runat="server" ID="lstAssigned" SelectionMode="Multiple"></asp:listbox>
        </td>
    </tr>
</table>