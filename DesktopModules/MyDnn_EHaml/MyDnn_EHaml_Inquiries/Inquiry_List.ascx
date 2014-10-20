<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Inquiry_List.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Inquiries.Inquiry_List" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>
<%@ Import Namespace="DotNetNuke.Entities.Content.Common" %>
<%@ Import Namespace="MyDnn_EHaml" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:dnncssinclude id="DnnCssInclude1" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.common.min.css" />
<dnn:dnncssinclude id="DnnCssInclude3" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.rtl.min.css" />

<script src="/DesktopModules/MyDnn_EHaml/Scripts/kendo.web.min.js"> </script>
<script src="/DesktopModules/MyDnn_EHaml/Scripts/xdate.js"> </script>
<script src="/DesktopModules/MyDnn_EHaml/Scripts/date.js"> </script>
<script src="/DesktopModules/MyDnn_EHaml/Scripts/mydnn.js"> </script>

<div class="dnnForm">
    <div id="grdInquiryList" class="k-rtl">
    </div>
</div>

<div class="ajax-load">
</div>

<script id="rowTemplate" type="text/x-kendo-tmpl">
	<tr>
		<td class="item-td">
            <div class="item-main">
                <div class="right-side">
                    <h2 class="user-title">شناسنامه کاربر</h2>
                    <div class="rating1">
                        <span class="rat-power">
                            <span class="ratpower">#:data.Power#</span>
                        </span>
                        <span class="rat-qality">
                            <span class="ratqality">#:data.Rank#</span>                        
                        </span>
                    </div>
                    <div class="rating2">
                        <span class="rat-good">مثبت : 
                           <span class="ratgood">#:data.NazareKoliyeKhoob#</span>
                        </span>
                        <span class="rat-bad">منفی : 
                            <span class="ratbad">#:data.NazareKoliyeBad#</span>
                        </span>
                    </div>
                </div>
                <div class="center-side">
                    <div class="source-dest">
                        <h2 class="source">#:data.StartingPoint#</h2>
                        <h2 class="dest">#:data.Destination#</h2>
                    </div>
                    <div class="send-date">
                        <span >تاریخ ارسال:</span>
                        <span class="senddate-util">#:data.CreateDate#</span>
                    </div>
                    <div class="clear"></div>
                    <div class="inquiry-body">
                        <h2>کالا:
                            <span class="kala">#:data.LoadType#</span>
                        </h2>
                        <h2>وسیله حمل: 
                            <span>#:data.NoVaTedadeVasileyeHaml#</span>
                        </h2>
                        <h2>وزن خالص: 
                            <span>#:data.VazneKol#</span>
                        </h2>
                        <h2>تاریخ آماده به حمل:
                            <span class="hamldate-util">#: data.ActionDate # </span>
                        </h2>
                        <span class="khatarnak">#:data.Khatarnak#</span>
                    </div>
                </div>
                <div class="left-side">
                    <div class="daycount">
                        <span class="date-util">#:data.ExpireDate#</span>
                        <span class="data-util-end">باقی مانده </span>
                    </div>                
                    <div class="replay-button">
                        <a class="dnnSecondaryAction" href="javascript:void(0);" onclick="replyToInquiry(#:data.Id#);">پاسخ</a>
                    </div>
                </div>
            </div>
		</td>
	</tr>
    </script>

<script type="text/javascript">

    $(document).ready(function() {
        $(".ajax-load").fadeIn(100);

        window.getGridGroupCells = function(dt) {
            alert(dt);
            return kendo.parseDate(dt, "yyyy/MM/dd");
        }

        var sf = $.ServicesFramework(<%= ModuleId %>);

        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Inquiries/GetInquiryList",
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            bindInquiryList(result);

            ReplaceTokens();

            $(".ajax-load").fadeOut(300);
        }).fail(function(xhr, status, error) {
            alert(error);
        });


        function bindInquiryList(inquiryList) {
            $("#grdInquiryList").kendoGrid({
                dataSource: {
                    data: inquiryList,
                    pageSize: 10
                },
                model: {
                    fields: {
                        ActionDate: { type: "date" }
                    }
                },
                rowTemplate: kendo.template($("#rowTemplate").html()),
                height: 750,
                resizable: false,
                columnMenu: false,
                scrollable: true,
                sortable: false,
                filterable: false,
                pageable: {
                    input: true,
                    numeric: false
                },
                columns: [
                    { title: " ", field: "Id", width: "100%" },
                    { title: "", field: "ActionDate", format: "{yyyy}" }
                ]
            });


            $(".rate-item").each(function() {
                $(this).html("<img src='/desktopmodules/mydnn_ehaml/mydnn_ehaml_inquiries/images/star_" + Math.round($(this).text().split('|')[1]) + ".png' />");
            });

        }
    });

    function replyToInquiry(id) {
        window.location = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl={2}&InqId=", this.TabId, this.ModuleId, Settings["NameControlForReply"]) %>' + id;
    }
</script>

<script type="text/javascript">
    function ReplaceTokens() {
        $(".kala").each(function() {
            if ($(this).html().indexOf("کالای خطرناک (IMDG)") > 0) {
                var val = $(this).html();
                val = val.substring(0, $(this).html().indexOf("کالای خطرناک (IMDG)"));
                $(this).html(val);
            }
        });

        $(".ratpower").each(function() {
            if ($(this).html() == "null") {
                $(this).html("0");
            }
        });

        $(".ratqality").each(function() {
            if ($(this).html() == "null") {
                $(this).html("0");
            }
            $(this).addClass("rate_" + $(this).html());
        });

        $(".khatarnak").each(function() {
            if ($(this).html() == "true")
                $(this).html("کالای خطرناک");
            else
                $(this).hide();
        });


        $(".date-util").each(function() {
            var val = _diffDays($(this).html());

            if (val >= 10)
                $(this).addClass("greenback");
            else if (val >= 5)
                $(this).addClass("blueback");
            else if (val <= 4)
                $(this).addClass("redback");

            val += " روز ";

            $(this).html(val);
        });

        $(".senddate-util").each(function() {
            var val = _diffDays2($(this).html());
            val = (val == 0 ? "امروز" : val + " روز قبل ");
            $(this).html(val);
        });

        $(".hamldate-util").each(function() {
            var dtStr = $(this).html().replace(/\s+/g, "");
            var myDate = Date.parse(dtStr);
            var pDate = ToPersianDate(myDate);
            $(this).html(pDate);
        });
    }
</script>