<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_GeneralList.View" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Content.Common" %>
<%@ Import Namespace="MyDnn_EHaml" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<div class="dnnForm">
    <div class="dnnFormItem">
        <asp:Repeater runat="server" ID="rptGeneralList">
            <ItemTemplate>
                <asp:PlaceHolder runat="server" ID="plcGeneralList"></asp:PlaceHolder>        
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <div class="dnnFormItem"></div>
    <div class="dnnFormItem"></div>
    <div class="dnnFormItem"></div>
</div>