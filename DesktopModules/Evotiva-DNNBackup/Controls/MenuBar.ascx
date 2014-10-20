<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="MenuBar.ascx.cs" 
            Inherits="Evotiva.DNN.Modules.DNNBackup.MenuBar" %>

<div id="bkp-menubarbg">
    <table>
        <tr>
            <asp:Repeater ID="rptActions" runat="server">
                <ItemTemplate>
                    <td style="width: 120px;text-align: center;">
                        <img src="<%#DataBinder.Eval(Container.DataItem,"ImgUrl") %>"  
                            alt="<%#DataBinder.Eval(Container.DataItem, "Text") %>" 
                            title="<%#DataBinder.Eval(Container.DataItem, "Title") %>" 
                            style="border: 0;" />
                        <br />                       
                        <a class="bkp-menubarlink" href="<%#DataBinder.Eval(Container.DataItem, "Url") %>" target="<%#DataBinder.Eval(Container.DataItem, "Target") %>"> 
                            <%#DataBinder.Eval(Container.DataItem, "Text") %> 
                        </a>
                    </td>
                </ItemTemplate>
                <SeparatorTemplate>
                    &nbsp;&nbsp;
                </SeparatorTemplate>
            </asp:Repeater>
        </tr>
    </table>
</div>