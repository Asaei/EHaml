<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KhedmatSide.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Gozaresh.KhedmatSide" %>

<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Content.Common" %>
<%@ Import Namespace="MyDnn_EHaml" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:dnncssinclude id="DnnCssInclude1" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.common.min.css" />
<dnn:dnncssinclude id="DnnCssInclude3" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.rtl.min.css" />

<script src="/DesktopModules/MyDnn_EHaml/Scripts/kendo.web.min.js"> </script>
<div class="dnnForm">
	<div id="grdKhedmatActiveList" class="k-rtl">
	</div>
</div>

<script type="text/javascript">

	$(document).ready(function () {
			var sf = $.ServicesFramework(<%= ModuleId %>);
			$.ajax({
				type: "GET",
				url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/InquiryListThatIReplyAndAccept",
				beforeSend: sf.setModuleHeaders
			}).done(function (result) {
				bindMyInquiryReplyList(result);
			}).fail(function (xhr, status, error) {
				alert(error);
			});
		});

//
//		$("#lnkSearch").click

	function bindMyInquiryReplyList(myInquirysReply) {
		$("#grdKhedmatActiveList").kendoGrid({
			dataSource: {
				data: myInquirysReply,
				pageSize: 10
			},
			height: 450,
			groupable: true,
			resizable: true,
			columnMenu: true,
			scrollable: true,
			sortable: true,
			filterable: true,
			pageable: {
				input: true,
				numeric: false
			},
			columns: [
				{ title: "آیدی", field: "Id", width: "9px" },
				{ title: "نام", field: "DisplayName", width: "20px" },
				{ title: "تاریخ", field: "Tarikh", width: "16px" },
				{
					title: "جزئیات",
					field: "Id",
					width: "19px",
					template:
						function (dataItem) {
							if (dataItem.DisplayName == "***") {
								return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='replyDetail(" + dataItem.Id + ")'><span class=' '></span>مشاهده</a>";
							} else {
								return "<span class=' '>قبلآ تایید نموده اید</span>";
							}

						}
				}
			]
		});
	}

//	function replyDetail(id) {
//		var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=ReplyToInquiryShenasname&popUp=true&RepId=", this.TabId, this.ModuleId) %>' + id;
//		dnnModal.show(modulePath, true, 550, 960, true, '');
//	}
//
//	function SherkatDarNazarSanji(id) {
//		var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=NazarSanji_SahebBeKhadamat&popUp=true&inquiryReplyToInquiry_Id=", this.TabId, this.ModuleId) %>' + id;
//		dnnModal.show(modulePath, true, 550, 960, true, '');
//	}
</script>