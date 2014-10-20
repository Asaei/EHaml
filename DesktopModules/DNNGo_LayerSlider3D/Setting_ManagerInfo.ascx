<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Setting_ManagerInfo.ascx.cs" Inherits="DNNGo.Modules.LayerSlider3D.Setting_ManagerInfo" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="dnn" TagName="URL" Src="~/controls/URLControl.ascx" %>

<asp:Button runat="server" ID="butRefreshList" onclick="butRefreshList_Click" style=" display:none; height:0px;" />
<div class="options_views">
    <h2 class="setting_page_title"><%=ViewTitle("lblModuleTitle", "Compose a new Content")%></h2>
 

   <div class="choose_tags form_field handlediv">
        <h3 class="hndle"><%=ViewTitle("lblEditContentTitle", "Edit Content")%></h3>
        <div class="inside">
             <div class="form_field">
                <h4>
                    <%=ViewTitle("lblTitle", "Title", "txtTitle")%>:</h4>
                    <asp:TextBox ID="txtTitle" runat="server" Width="90%"  CssClass="input_text validate[required,maxSize[100]]"></asp:TextBox>
            </div>
               <div class="form_field">
                <h4>
                    <%=ViewTitle("lblStatus", "Activation", "cbStatus")%>:</h4>
                   <asp:CheckBox ID="cbStatus" runat="server" />
            </div>
           
            
        </div>
    </div>
    <div class="insert_picture form_field handlediv">
        <h3 class="hndle"><%=ViewTitle("lblStartEndTime", "Start/End Time")%></h3>
        <div class="inside">
             <div class="form_field">
                <h4>
                    <%=ViewTitle("lblStartTime", "Start Time", "txtStartTime")%>:</h4>
                   <asp:TextBox ID="txtStartTime" runat="server" Width="150" ReadOnly="true" CssClass="input_text validate[required,dateFormat]"></asp:TextBox>
            </div>
            <div class="form_field">
                <h4>
                    <%=ViewTitle("lblEndTime", "End Time", "txtEndTime")%>:</h4>
                    <asp:TextBox ID="txtEndTime" runat="server" Width="150" ReadOnly="true" CssClass="input_text validate[required,dateFormat]"></asp:TextBox>
            </div>
        </div>
    </div>

    <div class="insert_picture form_field handlediv" runat="server" id="divItemList" visible="false">
         <label id="ItemList"></label>
        <h3 class="hndle"><%=ViewTitle("lblItemListTitle", "Element List")%></h3>
        <div class="inside">
             <div class="form_field">
                <h4><%=ViewTitle("lblAddItem", "Add Element")%>:</h4>
                    <asp:HyperLink runat="server" ID="hlAddPicture" CssClass="link_button various" data-fancybox-type="iframe" ResourceKey="hlAddPicture" Text="Add Picture"></asp:HyperLink> &nbsp;
                    <asp:HyperLink runat="server" ID="hlAddText" CssClass="link_button various" data-fancybox-type="iframe" ResourceKey="hlAddText" Text="Add Text"></asp:HyperLink> &nbsp;
                    <asp:HyperLink runat="server" ID="hlAddMedia" CssClass="link_button various" data-fancybox-type="iframe" ResourceKey="hlAddMedia"  Text="Add Media"></asp:HyperLink> &nbsp;
      
             </div>
             <div class="form_field">
                <h4><%=ViewTitle("lblItemListGridView", "List GridView")%>:</h4>
               
               <table width="100%" cellpadding="0" cellspacing="0">
            
            <tr>
                <td>
                   
                     <asp:GridView ID="gvItemListGridView" runat="server"  
                         AutoGenerateColumns="False" OnRowDataBound="gvItemListGridView_RowDataBound"
                        Width="100%" CellPadding="0" cellspacing="0" border="0" 
                         CssClass="table table-bordered table-striped"  GridLines="none" 
                           >
                        <RowStyle CssClass="td_row" />
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" HeaderStyle-Width="50" /> 
                            <asp:BoundField DataField="Title" HeaderText="Title" /> 
                             <asp:TemplateField HeaderText="Picture" HeaderStyle-Width="110">
                                <ItemTemplate>
                                     <asp:Image ID="imgPicture" runat="server" style="max-width:100px; max-height:100px;" />  
                                </ItemTemplate>
                            </asp:TemplateField>
  
                            <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-Width="50" /> 
                            <asp:TemplateField HeaderText="Sort" HeaderStyle-Width="80">
                                <ItemTemplate>
                                       <asp:ImageButton CssClass="CommandButton" ID="imgbutUp" 
                                            runat="server" ImageUrl="~/images/up.gif" OnClick="ImgbutSort_Click" BorderStyle="none"  />
                                        &nbsp;&nbsp;
                                       <asp:ImageButton CssClass="CommandButton" ID="imgbutDn"  
                                            runat="server" ImageUrl="~/images/dn.gif" OnClick="ImgbutSort_Click" BorderStyle="none"   />
                                        </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action" HeaderStyle-Width="80">
                                <ItemTemplate>
                                
                                    <asp:HyperLink ID="imbEdit" runat="server" ToolTip="Edit" OnCommand="imbEdit_Command" CssClass=" various" data-fancybox-type="iframe" 
                                                    ImageUrl="~/images/edit.gif" />
                                    <asp:ImageButton ID="imbDelete" runat="server" ToolTip="Delete" OnCommand="imbDelete_Command"
                                                    ImageUrl="~/images/delete.gif" />
                                    
                                </ItemTemplate>
                                <HeaderStyle></HeaderStyle>
                            </asp:TemplateField>
                        </Columns>
                        <PagerSettings Visible="False" />
                        <FooterStyle  />
                        <PagerStyle  />
                        <SelectedRowStyle  />
                        <HeaderStyle  />
                        <AlternatingRowStyle CssClass="alternating_row"  />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <dnn:PagingControl ID="ctlPagingControl" Width="100%" runat="server"></dnn:PagingControl>
                </td>
            </tr>
        </table>
            </div>
        </div> 
    </div>


    <div class="insert_picture form_field handlediv" runat="server" id="divPicture">
        <h3 class="hndle"><%=ViewTitle("lblPicture", "Background Picture", "ucPicture")%></h3>
        <div class="inside">
           <dnn:URL ID="ucPicture" runat="server" ShowTabs="false" UrlType="U" ShowNewWindow="false"
                    ShowNone="false" Visible="true" ShowSecure="false" ShowDatabase="false" ShowLog="false"
                    ShowTrack="false" ShowFiles="true" ShowUrls="true" />
        </div>
    </div>
 

     

    <div runat="server" id="divOptions">
     <asp:Repeater ID="RepeaterGroup" runat="server" OnItemDataBound="RepeaterGroup_ItemDataBound">
        <ItemTemplate>
                    <div class="choose_tags form_field handlediv"  >
                    <h3 class="hndle"><%#Eval("key")%></h3>
                    <div class="inside">
                        <table cellpadding="5">
                        <asp:Repeater ID="RepeaterOptions" runat="server" OnItemDataBound="RepeaterOptions_ItemDataBound">
                            <ItemTemplate>
                                        <tr>
                                            <td  style="white-space: nowrap;">
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
    <asp:Button CssClass="input_button" lang="Submit" ID="cmdUpdate" resourcekey="cmdUpdate" runat="server"
         Text="Update" OnClick="cmdUpdate_Click"></asp:Button>&nbsp;
    <asp:Button CssClass="input_button" ID="cmdCancel" resourcekey="cmdCancel" runat="server"  OnClientClick="CancelValidation();"
         Text="Cancel" CausesValidation="False" OnClick="cmdCancel_Click"></asp:Button>&nbsp;
    <asp:Button CssClass="input_button" ID="cmdDelete" resourcekey="cmdDelete" runat="server"  OnClientClick="CancelValidation();"
         Text="Delete" Enabled="false" CausesValidation="False" OnClick="cmdDelete_Click"></asp:Button>&nbsp;
    </p>

</div>

<script type="text/javascript">

    function RefreshList() {
        jQuery("#<%=butRefreshList.ClientID %>").click();
    }

    function closeFancybox() {
        jQuery.fancybox_3d.close();

    }

    jQuery(document).ready(function ($) {
        $(".various").fancybox_3d({
            maxWidth: 800,
            maxHeight: 800,
            fitToView: false,
            modal: true,
            showCloseButton:true,
            width: '75%',
            height: '95%',
            autoSize: false
        });
    });

    jQuery(function () {
        var dates = jQuery("#<%=txtStartTime.ClientID %>, #<%=txtEndTime.ClientID %>").datepicker({
            changeMonth: true, changeYear: true,
            onSelect: function (selectedDate) {
                var option = this.id == "<%=txtStartTime.ClientID %>" ? "minDate" : "maxDate",
					instance = jQuery(this).data("datepicker"),
					date = jQuery.datepicker.parseDate(
						instance.settings.dateFormat ||
						jQuery.datepicker._defaults.dateFormat,
						selectedDate, instance.settings);
                dates.not(this).datepicker("option", option, date);
            }
        });
    });
</script>
 









 