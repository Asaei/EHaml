<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Setting_ManagerImportExport.ascx.cs" Inherits="DNNGo.Modules.LayerSlider3D.Setting_ManagerImportExport" %>
<div class="add_theme_setting">
    <h2 class="setting_page_title"><%=ViewTitle("lblModuleTitle", "Export and Import")%></h2>
   

    <div class="choose_tags form_field handlediv">
        <h3 class="hndle">
            <%=ViewTitle("lblContentListExport", "Content List Export")%></h3>
        <div class="inside">
            <div class="form_field">
                <h4><%=ViewTitle("lblExportToXml", "Export To Xml", "cmdExportToXml")%>:</h4>
                    <asp:Button runat="server" Text="Export Content List" ID="cmdExportToXml"  resourcekey="cmdExportToXml"
                    onclick="cmdExportToXml_Click"  OnClientClick="CancelValidation();" CssClass="input_button" />    
            </div>
        </div>
    </div>
    <div class="choose_tags form_field handlediv">
        <h3 class="hndle">
            <%=ViewTitle("lblContentListImport", "Content List Import")%></h3>
        <div class="inside">
            <div class="form_field">
                <h4><%=ViewTitle("lblImportFormXml", "Import Form Xml", "fuImportFormXml")%>:</h4>
                 <asp:FileUpload runat="server" ID="fuImportFormXml" Width="340" CssClass="validate[required] required input_text" />     
              
                 <asp:Button ID="cmdImportFormXml" runat="server" Text="Import Content List" resourcekey="cmdImportFormXml" onclick="cmdImportFormXml_Click" CssClass="input_button" /> 
            </div>
        </div>

</div>

</div>