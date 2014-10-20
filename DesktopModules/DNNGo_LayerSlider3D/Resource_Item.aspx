<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Resource_Item.aspx.cs" EnableViewStateMac="false" 
    Inherits="DNNGo.Modules.LayerSlider3D.Resource_Item" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <asp:placeholder id="CSS" runat="server" />
</head>
<body>
    <form id="Form" runat="server">
    <div class="options_views">
        <h2 class="setting_page_title">
            <%=ViewTitle("lblModuleTitle", "Compose a new Content")%></h2>
        <div class="choose_tags form_field handlediv">
            <h3 class="hndle">
                <%=ViewTitle("lblEditContentTitle", "Edit Content")%></h3>
            <div class="inside">
                <div class="form_field">
                    <h4>
                        <%=ViewTitle("lblTitle", "Content Text", "txtTitle")%>:</h4>
                    <asp:TextBox ID="txtTitle" runat="server" Width="500" CssClass="input_text validate[required,maxSize[500]]" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>
                <div class="form_field">
                    <h4>
                        <%=ViewTitle("lblStatus", "Activation", "cbStatus")%>:</h4>
                        <asp:CheckBox ID="cbStatus" runat="server" />
                </div>
                <div class="form_field" id="divSort" runat="server" visible="false">
                    <h4>
                        <%=ViewTitle("lblSort", "Sort", "txtSort")%>:</h4>
                        <asp:TextBox ID="txtSort" runat="server" Width="50" CssClass="input_text validate[required,integer]"></asp:TextBox>
                </div>
                <div class="form_field" id="divPicture" runat="server" visible="false">
                    <h4>
                        <%=ViewTitle("lblPicture", "Picture", "fuPicture")%>:</h4>
                    <asp:Image ID="imgPicture" border="0" runat="server" onclick="javascript:window.open(this.title)"
                        Style="cursor: pointer; max-width: 500px; max-height: 200px;" alt="Click to enlarge"
                        Visible="false" /><br />
                    <asp:FileUpload ID="fuPicture" runat="server" Style="width:300px;" CssClass="validate[required]" />
                </div>
            </div>
        </div>


        <div class="choose_tags form_field handlediv" id="divLinkOptions" runat="server">
            <h3 class="hndle">
                <%=ViewTitle("lblLinkOptionsTitle", "Link Options")%></h3>
            <div class="inside">
                 <table cellpadding="5">
                    <tr>
                        <td style="white-space: nowrap;">
                            <%=ViewTitle("lblLinkEnable", "Link Enable", "cbLinkEnable")%>:
                        </td>
                        <td>
                            <asp:CheckBox ID="cbLinkEnable" runat="server" />
                        </td>
                    </tr>
                        <tr>
                        <td style="white-space: nowrap;">
                            <%=ViewTitle("lblNewWindow", "New Window", "cbNewWindow")%>: 
                        
                        </td>
                        <td>
                            <asp:CheckBox ID="cbNewWindow" runat="server" />
                        </td>
                    </tr>
                        <tr>
                        <td style="white-space: nowrap; " >
                             <%=ViewTitle("lblLinkUrl", "Link Url", "txtLinkUrl")%>: 
                        
                        </td>
                        <td>
                            <asp:RadioButtonList ID="rblLinkUrl" runat="server" RepeatDirection="Horizontal"></asp:RadioButtonList>
                            <asp:TextBox ID="txtLinkUrl" runat="server" Width="350" CssClass="input_text validate[custom[url]]"></asp:TextBox>
                            <asp:DropDownList  ID="ddlLinkUrl" runat="server" CssClass="input_text"></asp:DropDownList>
                        </td>
                    </tr>
                    </table>
            </div>
        </div>



        <div runat="server" id="divOptions">
            <asp:Repeater ID="RepeaterGroup" runat="server" OnItemDataBound="RepeaterGroup_ItemDataBound">
                <ItemTemplate>
                    <div class="choose_tags form_field handlediv">
                        <h3 class="hndle">
                            <%#Eval("key")%></h3>
                        <div class="inside">
                            <table cellpadding="5">
                                <asp:Repeater ID="RepeaterOptions" runat="server" OnItemDataBound="RepeaterOptions_ItemDataBound">
                                    <ItemTemplate>
                                        <tr>
                                            <td style="white-space: nowrap;">
                                                <asp:Literal ID="liTitle" runat="server"></asp:Literal>:
                                            </td>
                                            <td>
                                                <asp:PlaceHolder ID="ThemePH" runat="server"></asp:PlaceHolder>
                                                <asp:Literal ID="liHelp" runat="server"></asp:Literal>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </table>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <p style="text-align: center;">
            <asp:Button CssClass="input_button" lang="Submit" ID="cmdUpdate" resourcekey="cmdUpdate"
                runat="server" OnClientClick="return Validation();" Text="Update" OnClick="cmdUpdate_Click">
            </asp:Button>&nbsp;
            <asp:Button CssClass="input_button" ID="cmdCancel" resourcekey="cmdCancel" runat="server"
                OnClientClick="closeFancybox();return false;" Text="Cancel" CausesValidation="False"
                OnClick="cmdCancel_Click"></asp:Button>&nbsp;
            <asp:Button CssClass="input_button" ID="cmdDelete" resourcekey="cmdDelete" runat="server"
                OnClientClick="CancelValidation();" Text="Delete" Enabled="false" CausesValidation="False"
                OnClick="cmdDelete_Click"></asp:Button>&nbsp;
        </p>
    </div>
    <script type="text/javascript">
        jQuery(function (q) {
            jQuery("input:submit, a, button", ".demo").button();
            jQuery("a", ".demo").click(function () { return false; });

            /*展示框的属性*/
            q("h3[class='hndle']").each(function (i, n) {
                q(this).click(function () { q(this).parent().find("div[class='inside']").toggle(50); });
            });

            q("#Form").validationEngine({
                promptPosition: "topRight"
            });


            q("#<%=cmdUpdate.ClientID %>").click(function () {
                //Validation();
                //                window.parent.closeFancybox();
                //                window.parent.RefreshList();

            });
            q("#<%=cmdDelete.ClientID %>").click(function () {
                //setInterval("closeFancybox1", 100);

            });

            q("#<%=rblLinkUrl.ClientID %> input").click(function () {
                if ($(this).val() == 1) {
                    q("#<%=txtLinkUrl.ClientID %>").show();
                    q("#<%=ddlLinkUrl.ClientID %>").hide();
                } else {
                    q("#<%=ddlLinkUrl.ClientID %>").show();
                    q("#<%=txtLinkUrl.ClientID %>").hide();
                }
            });


        });

        function Validation() {
            if (jQuery('#Form').validationEngine('validate')) {
                //setInterval("closeFancybox1", 100);
              
                return true;
            }
            return false;

        }

        function closeFancybox1() {
            window.parent.RefreshList();
            window.parent.closeFancybox();
        }

        function closeFancybox() {
            window.parent.closeFancybox();

        }

        function CancelValidation() {
            jQuery('#Form').validationEngine('detach');
        }
    </script>
    </form>
</body>
</html>
