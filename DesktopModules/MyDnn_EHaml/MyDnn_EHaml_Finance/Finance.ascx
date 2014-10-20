<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Finance.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Finance.Finance" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Content.Common" %>
<%@ Import Namespace="MyDnn_EHaml" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:dnncssinclude id="DnnCssInclude1" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.common.min.css" />
<dnn:dnncssinclude id="DnnCssInclude3" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.rtl.min.css" />

<script src="/DesktopModules/MyDnn_EHaml/Scripts/kendo.web.min.js"></script>
<div class="dnnFormItem MojoodiTitle">
    <asp:Label runat="server" ID="lblMojoodiTitle" Text="موجودی:" font-Names="Tahoma" font-Size="12px"></asp:Label>
    <asp:Label runat="server" ID="lblMojoodiValue"></asp:Label>
</div>
<div class="dnnFormItem">
    <asp:LinkButton CssClass="dnnPrimaryAction" runat="server" ID="btnPardakht" Text="پرداخت" font-Names="Tahoma" font-Size="12px"></asp:LinkButton>
</div>
<div runat="server" id="isKhadamatresan" class="IsKhadamatresan" Visible="False"></div>
<div class="dnnForm">
    <div id="grdTransActionList" class="k-rtl">
    </div>
</div>

<script type="text/javascript">

    $(document).ready(function () {
        if ($(".IsKhadamatresan").length == 0) {
            $(".khadamateMan").hide();
            $(".ElamiyeHayeMan").hide();

        }
        var sf = $.ServicesFramework(<%= ModuleId %>);
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/BankTransActionList",
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            bindMyInquiryReplyList(result);
        }).fail(function(xhr, status, error) {
            alert(error);
        });


//		$("#lnkSearch").click(function () {
//			var sf = $.ServicesFramework(<%= ModuleId %>);
//			$.ajax({
//				type: "GET",
//				url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Dashboard/BankTransActionList",
//				beforeSend: sf.setModuleHeaders
//			}).done(function (result) {
//				bindMyInquiryReplyList(result);
//			}).fail(function (xhr, status, error) {
//				alert(error);
//			});
//		});
    });

    function bindMyInquiryReplyList(myInquirysReply) {
        $("#grdTransActionList").kendoGrid({
            dataSource: {
                data: myInquirysReply,
                pageSize: 10
            },
            height: 450,
            groupable: false,
            resizable: false,
            columnMenu: false,
            scrollable: true,
            sortable: true,
            filterable: true,
            pageable: {
                input: true,
                numeric: false
            },
            columns: [
                { title: "ردیف", field: "Id", width: "9px" },
                { title: "تاریخ ثبت", field: "Zaman", width: "16px" },
                {
                    title: "موضوع",
                    field: "Babate",
                    width: "20px",
                    template:
                        function(dataItem) {
                            return dataItem.Babate + dataItem.Link;
                        }
                },
                {
                    title: "مقدار (ریال)",
                    field: "Megdar",
                    width: "20px",
                    template:
                        function(dataItem) {
                            if (dataItem.Noesh == 0) {
                                return dataItem.Megdar + " ریال (بدهکار)";
                            } else if (dataItem.Noesh == 1) {
                                return dataItem.Megdar + " ریال (واریز)";
                            } else {
                                return dataItem.Megdar + " ریال (واریز توسط مدیر)";
                            }
                        }
                },
                {
                    title: "وضعیت",
                    field: "Status",
                    width: "15px",
                    template:
                        function(dataItem) {
                            if (dataItem.Status == "0") {
                                return "ملغی شد";
                            } else if (dataItem.Status == "1") {
                                return "تایید شده";
                            } else if (dataItem.Status == "2") {
                                return "در حال بررسی";
                            } else {
                                return "تایید اولیه";
                            }
                        }
                },

                //{
                //	title: "نظرسنجی",
                //	field: "NazarSanji",
                //	width: "20px",
                //	template:
                //		function (dataItem) {
                //			if (dataItem.NazarSanji == "Yes") {
                //				return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='SherkatDarNazarSanji(" + dataItem.Id + ")'><span class=' '></span>شرکت در نظر سنجی</a>";
                //			} else if (dataItem.NazarSanji == "SherkatKarde") {
                //				return "<span class=' '>قبلآ در نظر سنجی شرکت نموده اید</span>";
                //			} else {
                //				return "<span class=' '>زمان شرکت در نظر سنجی فرا نرسیده</span>";
                //			}

                //		}
                //},
                //{
                //	title: "جزئیات",
                //	field: "Id",
                //	width: "19px",
                //	template:
                //		function (dataItem) {
                //			if (dataItem.DisplayName == "***") {
                //				return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='replyDetail(" + dataItem.Id + ")'><span class=' '></span>مشاهده</a>";
                //			} else {
                //				return "<span class=' '>قبلآ تایید نموده اید</span>";
                //			}

                //		}
                //}
            ]
        });
    }


//	function replyDetail(id) {
//		var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=ReplyToInquiryShenasname&popUp=true&RepId=", this.TabId, this.ModuleId) %>' + id;
//		dnnModal.show(modulePath, true, 550, 960, true, '');
//	}

//	function SherkatDarNazarSanji(id) {
//		var modulePath = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl=NazarSanji_SahebBeKhadamat&popUp=true&inquiryReplyToInquiry_Id=", this.TabId, this.ModuleId) %>' + id;
//		dnnModal.show(modulePath, true, 550, 960, true, '');
//	}
    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>