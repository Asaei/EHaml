using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Web.UI.WebControls;
using Telerik.Web.UI;

namespace MyDnn_EHaml.MyDnn_EHaml_Inquiries
{
    public partial class Inquiry_Tk : PortalModuleBase
    {
        private void lnkSub_Click(object sender, EventArgs e)
        {
            Session["FinalReturnTabId"] = "tabid=" + this.TabId;
            Response.Redirect("/default.aspx?tabid=" +
                              PortalController.GetPortalSettingAsInteger("SubscriptionTabId", PortalId, -1) + "&type=1");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            dtpActionDate.MinDate = DateTime.Today.Date;
            dtpExpiredate.MinDate = DateTime.Today.Date;
            if (!Page.IsPostBack)
            {

                Util util = new Util();
                string status = util.IsUserOk(UserId, 1);
                if (status != "OK")
                {
                    switch (status)
                    {
                        case "LoginNakarde":
                            pnlMessageForLoginNakarde.Visible = true;
                            lnkSubmit.Enabled = false;
                            break;
                        case "ApproveNashode":
                            pnlMessageForNotApproved.Visible = true;
                            lnkSubmit.Enabled = false;
                            break;
                        case "Bedehkare":
                            pnlMessageForBedehkarUser.Visible = true;
                            break;
                        case "SubscribeNistMamooli":
                            pnlMessageForNotSubscribeUser.Visible = true;
                            lnkSubmit.Enabled = false;
                            break;
                        case "SubscribeNistAvaziS":
                            pnlMessageForNotSubscribeAvaziSUser.Visible = true;
                            lnkSubmit.Enabled = false;
                            break;
                        case "SubscribeNistAvaziK":
                            pnlMessageForNotSubscribeAvaziKUser.Visible = true;
                            lnkSubmit.Enabled = false;
                            break;
                    }
                }
                FillPageControl();
            }
        }

        private void FillPageControl()
        {
            lblDarkhastKonandeValue.Text = this.UserInfo.DisplayName;
            FillCbolIsReallyNeed();
            FillCbolNoeAmaliyat();
            FillRptNoeContiner();
            FillCbolStartingPointOstan();
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += lnkSubmit_Click;
            lnkTasviye.Click += lnkSub_Click;
            lnkTasviyeS.Click += lnkSub_Click;
            btnErsaleLinkTaeid11.Click += btnErsaleLinkTaeid1_Click;
//            cbolStartingPointOstan.SelectedIndexChanged += cbolStartingPointOstan_SelectedIndexChanged;
            lnkPrintKon.Click += lnkPrintKon_Click;
        }

        private void lnkPrintKon_Click(object sender, EventArgs e)
        {
            Response.Redirect("/default.aspx?tabid=" + this.TabId + "&mid=" + this.ModuleId +
                              "&ctl=ReplyToInquiry_Tk&InqId=" + hiddenFieldId.Value + "&popUp=true&IsPrint=Yes");
        }

        private void cbolStartingPointOstan_SelectedIndexChanged(object sender,
            RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string country = cbolStartingPointOstan.SelectedItem.Value;


            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var countryValue = (from j in context.Lists
                    where j.ListName == "Country"
                          && j.Text == country
                    select j.EntryID).Single();

                var list = (from i in context.Lists
                    where i.ListName == "City" && i.ParentID == countryValue
                    select new {Text = i.Text, Value = i.Text}).ToList();

                cbolStartingPointShahr.DataTextField = "Text";
                cbolStartingPointShahr.DataValueField = "Value";
                cbolStartingPointShahr.DataSource = list;
                cbolStartingPointShahr.DataBind();
            }
        }

        private void btnErsaleLinkTaeid1_Click(object sender, EventArgs e)
        {
            Util util = new Util();
            string appCode = util.getUserAppCode(util.GetUserEHamlUserIdByPortalId(UserId));
            string link = "http://" + PortalSettings.DefaultPortalAlias.ToLower().Replace("http://", "") +
                          "/default.aspx?tabid=" + 124 +
                          "&mid=439&ctl=Approve&AppCode=" + appCode;

            util.SendAppLinkToUserMail(UserId, link);
            pnlMessageForNotApproved.Visible = false;
            pnlMessageForNotApprovedAfterErsal.Visible = true;
        }

        private void lnkSubmit_Click(object sender, EventArgs e)
        {

            Util util = new Util();
            string message = util.IsValidateDates(dtpActionDate: dtpActionDate, dtpExpiredate: dtpExpiredate);
            bool isReturn = message != "OK";

            message += "<span>لطفآ فرم را دوباره و با دقت بیشتری تکمیل نمایید.</span>";
            message = message.Replace("OK", "");
            errorMessages.InnerHtml = message;

            if (isReturn)
            {
                errorMessages.Visible = true;
                return;
            }
            else
            {
                errorMessages.Visible = false;
            }
            string userStatus = util.IsUserOk(this.UserId, 1);
            if ((userStatus != "OK"))
            {
                util.MakeThisUserOk(this.UserId, userStatus, this.TabId.ToString(), 1);
            }
            else
            {
                using (
                    DataClassesDataContext context =
                        new DataClassesDataContext(Config.GetConnectionString()))
                {
                    MyDnn_EHaml_Inquiry_Tk Tk = new MyDnn_EHaml_Inquiry_Tk();

                    Tk.NoVaTedadVaJoziyatContiner = CreateNameVaTedadVaZojiyateContiner();
                    Tk.NoeAmaliyat = cbolNoeAmaliyat.SelectedItem.Value;

                    context.MyDnn_EHaml_Inquiry_Tks.InsertOnSubmit(Tk);
                    context.SubmitChanges();

                    MyDnn_EHaml_Inquiry inquiry = new MyDnn_EHaml_Inquiry()
                    {
                        CreateDate = DateTime.Now,
                        ActionDate = dtpActionDate.SelectedDate,
                        ExpireDate = dtpExpiredate.SelectedDate,
                        StartingPoint =
                            "(" + cbolStartingPointOstan.SelectedItem.Value + " : " + cbolStartingPointShahr.Text + ")",
                        //Destination = "انگلیس:پاریس",
                        IsReallyNeed = bool.Parse(cbolIsReallyNeed.SelectedItem.Value),
                        InquiryType = "Tk"
                    };


                    inquiry.MyDnn_EHaml_User_Id = (context.MyDnn_EHaml_Users.Where(i => i.PortalUserId == this.UserId)
                        .Select(i => i.Id)).Single();

                    inquiry.InquiryDetail_Id = Tk.Id;
                    context.MyDnn_EHaml_Inquiries.InsertOnSubmit(inquiry);
                    context.SubmitChanges();


                    hiddenFieldId.Value = inquiry.Id.ToString();
                    messageAfterSubmit.Visible = true;
                    messageAfterSubmit.InnerHtml = "استعلام شما با موفقیت ثبت گردید.";
                    messageAfterSubmit.Attributes["class"] = "dnnFormMessage dnnFormSuccess";
                    lnkSubmit.Visible = false;
                    lnkPrintKon.Visible = true;
                }
            }
        }

        private string CreateNameVaTedadVaZojiyateContiner()
        {
            string result = string.Empty;
            foreach (var item in cblocontinertype.CheckedItems)
            {
                //                                    <dnn:DnnComboBoxItem runat="server" Text="کانتینر GP'20" Value="کانتینر GP'20"/>
                //<dnn:DnnComboBoxItem runat="server" Text="کانتینر GP'40" Value="کانتینر GP'40"/>
                //<dnn:DnnComboBoxItem runat="server" Text="کانتینر HC'40" Value="کانتینر HC'40"/>
                //<dnn:DnnComboBoxItem runat="server" Text="کانتینر RF'20" Value="کانتینر RF'20"/>
                //<dnn:DnnComboBoxItem runat="server" Text="کانتینر RF'40" Value="کانتینر RF'40"/>
                switch (item.Value)
                {
                    case "کانتینر GP'20":
                        result += "[نوع کانتینر: " + item.Value + "]" + "[تعداد:" + txtTedad.Text + " دستگاه]" +
                                  "[وزن ناخالص: " + txtVazneNakhales.Text + "  کیلوگرم  ]" +
                                  "[نوع مالکیت: " + cbolNoeMalekiyat.SelectedItem.Value + "]|";
                        break;
                    case "کانتینر GP'40":
                        result += "[نوع کانتینر: " + item.Value + "]" + "[تعداد:" + txtTedad40.Text + " دستگاه]" +
                                  "[وزن ناخالص: " + txtVazneNakhales40.Text + "  کیلوگرم  ]" +
                                  "[نوع مالکیت: " + cbolNoeMalekiyat40.SelectedItem.Value + "]|";
                        break;
                    case "کانتینر HC'40":
                        result += "[نوع کانتینر: " + item.Value + "]" + "[تعداد:" + txtTedadHC40.Text + " دستگاه]" +
                                  "[وزن ناخالص: " + txtVazneNakhalesHC40.Text + "  کیلوگرم  ]" +
                                  "[نوع مالکیت: " + cbolNoeMalekiyatHC40.SelectedItem.Value + "]|";
                        break;
                    case "کانتینر RF'20":
                        result += "[نوع کانتینر: " + item.Value + "]" + "[تعداد:" + txtTedadRF20.Text + " دستگاه]" +
                                  "[وزن ناخالص: " + txtVazneNakhalesRF20.Text + "  کیلوگرم  ]" +
                                  "[نوع مالکیت: " + cbolNoeMalekiyatRF20.SelectedItem.Value + "]|";
                        break;
                    case "کانتینر RF'40":
                        result += "[نوع کانتینر: " + item.Value + "]" + "[تعداد:" + txtTedadRF40.Text + " دستگاه]" +
                                  "[وزن ناخالص: " + txtVazneNakhalesRF40.Text + "  کیلوگرم  ]" +
                                  "[نوع مالکیت: " + cbolNoeMalekiyatRF40.SelectedItem.Value + "]|";
                        break;
                }
            }
            return result;
        }

        private void FillCbolStartingPointOstan()
        {
            DotNetNuke.Common.Lists.ListController lc = new DotNetNuke.Common.Lists.ListController();
            var leCountries = lc.GetListEntryInfoItems("Country", "", base.PortalSettings.PortalId).ToList();

            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                cbolStartingPointOstan.DataValueField = "Value";
                cbolStartingPointOstan.DataTextField = "Text";
                var ostanList = (from i in leCountries
                    select new {Text = i.Text, Value = i.Text}).ToList();
                ostanList.RemoveAt(0);
                ostanList.RemoveAt(ostanList.Count - 1);

                
                foreach (var item in ostanList.Distinct())
                {
                    cbolStartingPointOstan.Items.Add(new RadComboBoxItem(item.Text, item.Value));
                }
            }
        }

        private void FillRptNoeContiner()
        {
            //using (
            //    DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            //{
            //    List<NoeContiner> noeContiners = (from i in context.MyDnn_EHaml_NoeContiners
            //        select new NoeContiner() {ContinerName = i.NoeContiner}).ToList();

            //    rptNoeContiner.DataSource = noeContiners;
            //    rptNoeContiner.DataBind();
            //}
        }

        private void FillCbolNoeAmaliyat()
        {
            cbolNoeAmaliyat.Items.Add(new DnnComboBoxItem("تخلیه", "تخلیه"));
            cbolNoeAmaliyat.Items.Add(new DnnComboBoxItem("بارگیری", "بارگیری"));
        }

        private void FillCbolIsReallyNeed()
        {
            
            cbolIsReallyNeed.Items.Add(new DnnComboBoxItem("صرفآ برای اطلاع از قیمت استعلام می کنم", "false"));
            cbolIsReallyNeed.Items.Add(new DnnComboBoxItem("صرفا برای اطلاع از قیمت نیست و نیاز به این خدمات دارم",
                "true"));

            
            
        }
    }
}