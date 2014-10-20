<%@ Control Language="C#" AutoEventWireup="true" Inherits="DNNGo.Modules.LayerSlider3D.License" Codebehind="License.ascx.cs" %>
<table id="tdValidation" style="border: solid 2px #000000; background-color: #FFFFFF">
    <tr>
        <td colspan="2">
            <span class="Normal"><strong>Instructions: </strong>
            <br>
            1. Please login or register your account at <a style="color: Red" target="_blank" href="http://www.dnngo.net/">http://www.dnngo.net</a><br />
            2. Send an email to <a style="color: Red" href="mailto:dnnskindev@gmail.com">dnnskindev@gmail.com</a> with your invoice ID, machine key (below), and your DNNgo username. We will generate an activation code for you.  Please note: If your site is a demo site, your license will still be valid when you transfer your site to a live site. <br />
            3. <a style="color: Red" target="_blank" href="http://www.dnngo.net/MyAccount/OnlineAuthorization.aspx">Manage my licenses</a><br />

            </span>
        </td>
    </tr>
    <tr>
        <td nowrap="nowrap">
            <asp:Label  ID="lblMachineKey" runat="server" CssClass="SubHead" resourcekey="lblMachineKey"></asp:Label>
        </td>
        <td>
            <textarea style="width:450px;" ReadOnly="ReadOnly" CssClass="Normal" rows="3"><asp:Literal ID="lblMachineKeyShow" runat="server" ></asp:Literal></textarea>
        </td>
    </tr>
    <tr>
        <td valign="middle">
            <asp:Label ID="lblVersionStatus" runat="server" CssClass="SubHead" resourcekey="lblVersionStatus"></asp:Label>
        </td>
        <td valign="middle">
            <asp:Literal ID="lblVersionStatusShow" runat="server"></asp:Literal>
        </td>
    </tr>
     <tr>
        <td nowrap="nowrap">
            <asp:Label ID="lblBuyTime" runat="server" CssClass="SubHead" resourcekey="lblBuyTime"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblBuyTimeShow" runat="server" CssClass="Normal"></asp:Label>
        </td>
    </tr>
     <tr>
        <td nowrap="nowrap">
            <asp:Label ID="lblExpirationTime" runat="server" CssClass="SubHead" resourcekey="lblExpirationTime"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblExpirationTimeShow" runat="server" CssClass="Normal"></asp:Label>
        </td>
    </tr>
     <tr>
        <td nowrap="nowrap">
            <asp:Label ID="lblVerificationTime" runat="server" CssClass="SubHead" resourcekey="lblVerificationTime"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblVerificationTimeShow" runat="server" CssClass="Normal"></asp:Label>
        </td>
    </tr>
      <tr>
        <td nowrap="nowrap">
            <asp:Label ID="lblReturnMessage" runat="server" CssClass="SubHead" resourcekey="lblReturnMessage"></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblReturnMessageShow" runat="server" CssClass="Normal"></asp:Label>
        </td>
    </tr>

    <tr>
        <td>
            
        </td>
        <td>
            <asp:LinkButton ID="lbActive" runat="server" CssClass="Normal" resourcekey="lbActive" OnClick="lbActive_Click"></asp:LinkButton>
            <asp:LinkButton ID="lkbReturn" runat="server" CssClass="Normal" resourcekey="lkbReturn"  OnClick="lkbReturn_Click"></asp:LinkButton>
        </td>
    </tr>
</table>