using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.Web.UI.WebControls;


namespace MyDnn_EHaml.MyDnn_EHaml_Inquiries
{
    public partial class ReplyToInquiry_ChandVajhiSangi : PortalModuleBase
    {
        private Util util = new Util();

        private void lnkSub_Click(object sender, EventArgs e)
        {
            Session["FinalReturnTabId"] = "tabid=" + this.TabId;
            Response.Redirect("/default.aspx?tabid=" +
                              PortalController.GetPortalSettingAsInteger("SubscriptionTabId", PortalId, -1) + "&type=0");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                dtpZamaneAmadegiBarayeShoorooeAmaliyat.MinDate = DateTime.Today.Date;
                Util util = new Util();
                string status = util.IsUserOk(UserId, 0);
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
                string inquiryId = Request.QueryString["InqId"];
                FillPageControllsShenasname(inquiryId);
                //                    FillPageControllsReply(inquiryId);
                FillCbolPishbini();
            }
        }

        private void FillCbolPishbini()
        {
            cbolPishbini.Items.Add(new DnnComboBoxItem("-- انتخاب نماييد --", "-1"));
            cbolPishbini.Items.Add(new DnnComboBoxItem("مطلوب", "مطلوب"));
            cbolPishbini.Items.Add(new DnnComboBoxItem("کند", "کند"));
            cbolPishbini.Items.Add(new DnnComboBoxItem("بسیار کند", "بسیار کند"));

            cbolPishbini.SelectedValue = "-1";
            cbolPishbini.Items[0].Enabled = false;
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += lnkSubmit_Click;
            lnkTasviye.Click += lnkSub_Click;
            btnErsaleLinkTaeid1.Click += btnErsaleLinkTaeid1_Click;
        }

        private void btnErsaleLinkTaeid1_Click(object sender, EventArgs e)
        {
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
            string userStatus = util.IsUserOk(this.UserId, 0);
            if ((userStatus != "OK"))
            {
                util.MakeThisUserOk(this.UserId, userStatus, this.TabId.ToString(), 0);
            }
            else
            {
                using (
                    DataClassesDataContext context =
                        new DataClassesDataContext(Config.GetConnectionString()))
                {
                    MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
                        where i.Id == int.Parse(Request.QueryString["InqId"])
                        select i).Single();

                    MyDnn_EHaml_ReplyToInquiry_ChandVajhiSangin replyToInquiryChandVajhiSabok =
                        new MyDnn_EHaml_ReplyToInquiry_ChandVajhiSangin();

                    replyToInquiryChandVajhiSabok.IsAkhseTarkhisiyeDarMagsad =
                        chkIsBaEhtesabeTarkhisiyeDarMagsad.Checked;
                    replyToInquiryChandVajhiSabok.IsBargiriDarMabda = chkIsBargiriDarMabda.Checked;
                    replyToInquiryChandVajhiSabok.IsBime = chkIsBaEhtesabeBimeDarTooleMasir.Checked;
                    replyToInquiryChandVajhiSabok.IsHazineyeTarkhisDarMabda =
                        chkIsBaEhtesabeAkhseTarkhisDarMabda.Checked;
                    replyToInquiryChandVajhiSabok.IsHazineyeTarkhisDarMagsad =
                        chkIsBaEhtesabeHazineyeTarkhisDarMagsad.Checked;
                    replyToInquiryChandVajhiSabok.IsKoleHazinehayeBandari =
                        chkIsBaEhtesabeHazinehayeBandariVaGeyre.Checked;
                    replyToInquiryChandVajhiSabok.IsTHCDarMabda = chkIsBaEhtesabeTHCDarMabda.Checked;
                    replyToInquiryChandVajhiSabok.IsTHCDarMagsad = chkIsBaEhtesabeTHCDarMagsad.Checked;
                    replyToInquiryChandVajhiSabok.IsTakhliyeDarMagsad = chkIsEmptying.Checked;

                    context.MyDnn_EHaml_ReplyToInquiry_ChandVajhiSangins.InsertOnSubmit(replyToInquiryChandVajhiSabok);
                    context.SubmitChanges();

                    MyDnn_EHaml_ReplyToInquiry replyToInquiry = new MyDnn_EHaml_ReplyToInquiry();
                    replyToInquiry.Pishbini = cbolPishbini.SelectedItem.Value;
                    replyToInquiry.ReplyToInquiryDetail_Id = (replyToInquiryChandVajhiSabok.Id);

                    replyToInquiry.ReplyToInquiryType = "ChandVajhiSangin";

                    replyToInquiry.MyDnn_EHaml_User_Id = (from i in context.MyDnn_EHaml_Users
                        where i.PortalUserId == this.UserId
                        select i.Id).Single();
                    replyToInquiry.KoleModatZamaneHaml = txtModatRooz.Text;
                    replyToInquiry.ZamaneAmadegiBarayeShooroo = dtpZamaneAmadegiBarayeShoorooeAmaliyat.SelectedDate;


                    replyToInquiry.GozareshAmaliyat = chkIsGozareshAmaliyat.Checked;


                    replyToInquiry.GeymateKol = decimal.Parse(txtGeymateKol.Text);
                    replyToInquiry.CreateDate = DateTime.Now.Date;

                    context.MyDnn_EHaml_ReplyToInquiries.InsertOnSubmit(replyToInquiry);
                    context.SubmitChanges();

                    MyDnn_EHaml_Inquiry_ReplyToInquiry myDnnEHamlInquiryReplyToInquiry =
                        new MyDnn_EHaml_Inquiry_ReplyToInquiry();
                    myDnnEHamlInquiryReplyToInquiry.InquiryId = (from i in context.MyDnn_EHaml_Inquiries
                        where i.Id == int.Parse(Request.QueryString["InqId"])
                        select i.Id).Single();

                    myDnnEHamlInquiryReplyToInquiry.ReplyToInquiryId = replyToInquiry.Id;
                    myDnnEHamlInquiryReplyToInquiry.Status = 2;
                    myDnnEHamlInquiryReplyToInquiry.CreateDate = DateTime.Now.Date;
                    context.MyDnn_EHaml_Inquiry_ReplyToInquiries.InsertOnSubmit(myDnnEHamlInquiryReplyToInquiry);
                    context.SubmitChanges();

                    string inquiryId = Request.QueryString["InqId"];
                    var content = util.ContentForEtelaresaniReplyToInquiry(context,
                        myDnnEHamlInquiryReplyToInquiry.Id.ToString());
                    util.EtelaresaniForReplyToInquiry(Convert.ToInt32(myDnnEHamlInquiryReplyToInquiry.Id), content);
                }
            }
        }

        private void FillPageControllsShenasname(string inquiryId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                lblDarkhastKonandeValue.Text =
                    UserController.GetUserById(this.PortalId, (int) (from i in context.MyDnn_EHaml_Inquiries
                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                        where i.Id == int.Parse(inquiryId)
                        select j.PortalUserId).Single()).DisplayName;

                MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
                    where i.Id == int.Parse(inquiryId)
                    select i).Single();

                lblTarihkeEngezaValue.Text = inquiry.ExpireDate.Value.ToShortDateString();
                lblSherkatValue.Text = this.UserInfo.Profile.GetPropertyValue("Company");

                if (inquiry.IsReallyNeed != null && (bool) inquiry.IsReallyNeed)
                {
                    lblIsReallyNeedValue.Text = "صرفا برای اطلاع از قیمت نیست و نیاز به این خدمات دارم";
                }
                else
                {
                    lblIsReallyNeedValue.Text = "صرفآ برای اطلاع از قیمت استعلام می کنم";
                }

                lblZamaneEstelamValue.Text = inquiry.CreateDate.Value.ToShortDateString();
                if (inquiry.ModifieDate != null)
                {
                    lblAkharinZamaneTagireEstelamValue.Text =
                        inquiry.ModifieDate.Value.ToShortDateString();
                }
                else
                {
                    lblAkharinZamaneTagireEstelamValue.Text = "تغییری نداشته است";
                }

                if (inquiry.IsExtend != null && (bool) inquiry.IsExtend)
                {
                    lblIsExtendValue.Text = "بله";
                }
                else
                {
                    lblIsExtendValue.Text = "خیر";
                }

                if (inquiry.IsTender != null && (bool) inquiry.IsTender)
                {
                    lblIsTenderValue.Text = "بله";
                }
                else
                {
                    lblIsTenderValue.Text = "خیر";
                }

                lblStartingPointValue.Text = inquiry.StartingPoint;
                lblMagsadValue.Text = inquiry.Destination;

                lblActionDateValue.Text = inquiry.ActionDate.Value.ToShortDateString();
                lblLoadTypeValue.Text = inquiry.LoadType;

                MyDnn_EHaml_Inquiry_ChandVajhiSangin inquiryChandVajhiSabok =
                    (from i in context.MyDnn_EHaml_Inquiry_ChandVajhiSangins
                        where i.Id == inquiry.InquiryDetail_Id
                        select i).Single();

                hplFileArzesheBar.NavigateUrl = inquiryChandVajhiSabok.FileVooroodeArzeshBarAsaseListeAdlBandi;
                hplFileArzesheBar.Text = "دریافت";
                hplFileListeAdlBandi.NavigateUrl = inquiryChandVajhiSabok.FileListeAdlBandi;
                hplFileListeAdlBandi.Text = "دریافت";

                lblIsTHCDarMabdaChandVajhiSabokValue.Text = inquiryChandVajhiSabok.IsTHCDarMabda.ToString();
                lblBaEhtesabeBimeValue.Text = inquiryChandVajhiSabok.IsBime.ToString();
                lblBaHazineyeBargiriValue.Text = inquiryChandVajhiSabok.IsBargiriDarMabda.ToString();
                lblHazineyeTarkhisDarMabdaValue.Text =
                    inquiryChandVajhiSabok.IsHazineyeTarkhisDarMabda.ToString();
                lblTHCDarMabdaValue.Text = inquiryChandVajhiSabok.IsTHCDarMabda.ToString();
                lblHazinehayeBandariValue.Text = inquiryChandVajhiSabok.IsKoleHazinehayeBandari.ToString();
                lblAkhseTarkhisiyeDarMagsadValue.Text =
                    inquiryChandVajhiSabok.IsAkhseTarkhisiyeDarMagsad.ToString();
                lblTakhliyeDarMagsadValue.Text = inquiryChandVajhiSabok.IsTakhliyeDarMagsad.ToString();


                lblPackingTypeValue.Text = inquiryChandVajhiSabok.PackingType;
            }
        }
    }
}