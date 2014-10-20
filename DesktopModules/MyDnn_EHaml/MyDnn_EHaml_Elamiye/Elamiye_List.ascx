<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Elamiye_List.ascx.cs" Inherits="MyDnn_EHaml.MyDnn_EHaml_Elamiye.Elamiye_List" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:DnnCssInclude ID="DnnCssInclude1" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.common.min.css" />
<dnn:DnnCssInclude ID="DnnCssInclude2" runat="server" filepath="~/DesktopModules/MyDnn_EHaml/Styles/kendo.rtl.min.css" />

<script src="/DesktopModules/MyDnn_EHaml/Scripts/kendo.web.min.js"> </script>
<script src="/DesktopModules/MyDnn_EHaml/Scripts/xdate.js"> </script>
<script src="/DesktopModules/MyDnn_EHaml/Scripts/date.js"> </script>
<script src="/DesktopModules/MyDnn_EHaml/Scripts/mydnn.js"> </script>

<div class="dnnForm">
    <div id="grdElamiyeList" class="k-rtl">
    </div>
</div>
<div class="ajax-load">
</div>

<script id="rowTemplateElamiye" type="text/x-kendo-tmpl">
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
                        <h2 class="dest">#:data.Magsad#</h2>
                    </div>
                    <div class="send-date">
                        <span >تاریخ ارسال:</span>
                        <span class="senddate-util">#:data.CreateDate#</span>
                    </div>
                    <div class="clear"></div>
                    <div class="inquiry-body">
<%--                        <h2>؟؟؟:
                            <span class="kala">#:data.LoadType#</span>
                        </h2>--%>
                        <h2 class="vasile">وسیله حمل: 
                            <span>#:data.VasileyeHaml#</span>
                        </h2>
                        <h2>تعداد: 
                            <span>#:data.Tedad# دستگاه</span>
                        </h2>
                        <h2>زمان آمادگی:
                            <span class="hamldate-util">#: data.ZamaneAmadegi # </span>
                        </h2>
                        <%--<span class="khatarnak">#:data.Khatarnak#</span>--%>
                    </div>
                </div>
                <div class="left-side">
                    <div class="daycount">
                        <span class="date-util">#:data.ExpireDate#</span>
                        <span class="data-util-end">باقی مانده </span>
                    </div>                
                    <div class="replay-button">
                        <a class="dnnSecondaryAction" href="javascript:void(0);" onclick="replyToElamiye(#:data.Id#);">پاسخ</a>
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

            return kendo.parseDate(dt, "yyyy/MM/dd");
        }

        var sf = $.ServicesFramework(<%= ModuleId %>);

        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('MyDnn_EHaml_Inquiries') + "Elamiye/GetElamiyeList",
            beforeSend: sf.setModuleHeaders
        }).done(function(result) {
            bindElamiyeList(result);
            ReplaceTokens();
            $(".ajax-load").fadeOut(300);
        }).fail(function(xhr, status, error) {
            alert(error);
        });


        function bindElamiyeList(elamiyeList) {
            $("#grdElamiyeList").kendoGrid({
                dataSource: {
                    data: elamiyeList,
                    pageSize: 10
                },
                model: {
                    fields: {
                        ActionDate: { type: "date" }
                    }
                },
                rowTemplate: kendo.template($("#rowTemplateElamiye").html()),
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
                //    { title: "آیدی", field: "Id", width: "9px" },
                //    { title: "نام", field: "DisplayName", width: "20px" },
                //    { title: "شرکت", field: "Company", width: "20px" },
                //    { title: "نوع اعلامیه", field: "ElamiyeType", width: "20px" },
                //    { title: "وسیله", field: "NoVaTedadeVasileyeHaml", width: "20px" },
                //    {
                //        title: "عملیات",
                //        field: "Id",
                //        width: "19px",
                //        template:
                //            function(dataItem) {
                //                return "<a href='javascript:void(0)' class='k-button k-button-icontext' onclick='replyToElamiye(" + dataItem.Id + ")'><span class=' '></span>مشاهده</a>";
                //            }
                //    }
                //]

            });

            $(".rate-item").each(function() {
                $(this).html("<img src='/desktopmodules/mydnn_ehaml/mydnn_ehaml_inquiries/images/star_" + Math.round($(this).text().split('|')[1]) + ".png' />");
            });
        }
    });

    function replyToElamiye(id) {
        window.location = '<%= string.Format("/default.aspx?tabid={0}&mid={1}&ctl={2}&ElaId=", this.TabId, this.ModuleId, Settings["NameControlForReply"]) %>' + id;
    }

    function voorood(parameters) {
        var modulePath = '/login?ReturnURL=<%= Page.Request.RawUrl %>&popUp=true';
        dnnModal.show(modulePath, true, 550, 960, true, '');
    }
</script>

<script type="text/javascript">
    function ReplaceTokens() {
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

        //$(".khatarnak").each(function () {
        //    if ($(this).html() == "true")
        //        $(this).html("کالای خطرناک");
        //    else
        //        $(this).hide();
        //});


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