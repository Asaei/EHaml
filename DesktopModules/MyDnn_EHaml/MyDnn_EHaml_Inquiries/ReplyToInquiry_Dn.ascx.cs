using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mime;
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
    public partial class ReplyToInquiry_Dn : PortalModuleBase
    {
        private Util util = new Util();

        #region Methods (6) 

        private void lnkSub_Click(object sender, EventArgs e)
        {
            Session["FinalReturnTabId"] = "tabid=" + this.TabId;
            Response.Redirect("/default.aspx?tabid=" +
                              PortalController.GetPortalSettingAsInteger("SubscriptionTabId", PortalId, -1) + "&type=0");
        }

        // Protected Methods (2) 

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += LnkSubmitOnClick;
            lnkTasviye.Click += lnkSub_Click;
            btnErsaleLinkTaeid1454.Click += btnErsaleLinkTaeid1_Click;
            lnkPrintKon.Click += lnkPrintKon_Click;
        }

        private void lnkPrintKon_Click(object sender, EventArgs e)
        {
            Response.Redirect("/default.aspx?tabid=1147&mid=3561&ctl=ReplyToInquiryShenasname&RepId=" +
                              hiddenFieldId.Value + "&IsPrint=Yes&popUp=true");
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

                if (Request.QueryString["IsPrint"] == "Yes" || Request.QueryString["popUp"] == "true")
                {
                    pnlMessageForBedehkarUser.Visible = false;
                    pnlMessageForLoginNakarde.Visible = false;
                    pnlMessageForNotApproved.Visible = false;
                    pnlMessageForNotSubscribeUser.Visible = false;
                    lnkSubmit.Visible = false;
                    logoForPrint.Visible = true;
                    pnlMessageForNotSubscribeAvaziSUser.Visible = false;
                    pnlMessageForNotSubscribeAvaziKUser.Visible = false;
                }

                string inquiryId = Request.QueryString["InqId"];
                FillPageControllsShenasname(inquiryId);
                FillPageControllsReply(inquiryId);
            }
        }

        // Private Methods (4) 
        private void FillCbolPishbini()
        {
            cbolPishbini.Items.Add(new DnnComboBoxItem("-- انتخاب نماييد --", "-1"));
            cbolPishbini.Items.Add(new DnnComboBoxItem("مطلوب", "مطلوب"));
            cbolPishbini.Items.Add(new DnnComboBoxItem("کند", "کند"));
            cbolPishbini.Items.Add(new DnnComboBoxItem("بسیار کند", "بسیار کند"));

            cbolPishbini.SelectedValue = "-1";
            cbolPishbini.Items[0].Enabled = false;
        }

        private void FillPageControllsReply(string inquiryId)
        {
            FillCbolPishbini();
            lblPasokhDahandeValue.Text = this.UserInfo.DisplayName;
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                string nameVaJoziyat = (from i in context.MyDnn_EHaml_Inquiries
                    join j in context.MyDnn_EHaml_Inquiry_Dns on i.InquiryDetail_Id equals j.Id
                    where i.Id == int.Parse(inquiryId)
                    select j.NoVaTedadVaJoziyatContiner).Single();

                List<ContinerNameVaJoziyatJft> nameVaJoziyats = new List<ContinerNameVaJoziyatJft>();

                string[] nameVajoziyatList = nameVaJoziyat.Remove(nameVaJoziyat.LastIndexOf('|')).Split('|');
                foreach (string nameVaJoziyatItem in nameVajoziyatList)
                {
                    nameVaJoziyats.Add(new ContinerNameVaJoziyatJft()
                    {
                        ContinerNameVaJoziyat = nameVaJoziyatItem
                    });
                }


                rptNoeContiner.DataSource = nameVaJoziyats;
                rptNoeContiner.DataBind();
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

                MyDnn_EHaml_Inquiry_Dn Dn = (from i in context.MyDnn_EHaml_Inquiry_Dns
                    where i.Id == inquiry.InquiryDetail_Id
                    select i).Single();
                lblHSCodeShValue.Text = Dn.HSCode;
                if (bool.Parse(Dn.IsKhahaneErsaleEstelamBeKharej.ToString()))
                {
                    lblIsKhahaneErsaleBeKharejihaValue.Text = "بله";
                }
                else
                {
                    lblIsKhahaneErsaleBeKharejihaValue.Text = "خیر";
                }

                if (bool.Parse(Dn.IsTHCDarMabda.ToString()))
                {
                    lblIsTHCDarMabdaShValue.Text = "بله";
                }
                else
                {
                    lblIsTHCDarMabdaShValue.Text = "خیر";
                }

                if (bool.Parse(Dn.IsTHCDarMagsad.ToString()))
                {
                    lblIsTHCDarMagsadShValue.Text = "بله";
                }
                else
                {
                    lblIsTHCDarMagsadShValue.Text = "خیر";
                }

                if (bool.Parse(Dn.IsTarkhisiyeDarMagsad.ToString()))
                {
                    lblIsTarkhisiyeDarMagsadShValue.Text = "بله";
                }
                else
                {
                    lblIsTarkhisiyeDarMagsadShValue.Text = "خیر";
                }
                lblNoVaTedadeVaJoziyatValue.Text = Dn.NoVaTedadVaJoziyatContiner;
                hplFileArzesheBar.Text =
                    "با توجه به در خواست نکردن بیمه توسط استعلام کننده ، لذا این فایل موجود نمی باشد.";

                //lblEmptyingChargesValue.Text = "خیر";
            }
        }

        private string GenerateVahedVaKolBaJoziyat()
        {
            string result = string.Empty;
            foreach (RepeaterItem repeaterItem in rptNoeContiner.Items)
            {
                var noVaTaded = repeaterItem.FindControl("txtGeymateVahede") as TextBox;
                var geymateVahed = repeaterItem.FindControl("txtGeymateVahede") as TextBox;
//                var geymateKol = (repeaterItem.FindControl("txtGeymateKol")) as TextBox;
//                var geymateKoleKol = (repeaterItem.FindControl("txtGeymateKolKoli")) as TextBox;

                result += noVaTaded.ToolTip + ":" + "{(" + geymateVahed.Text + ")}|";
            }
            return result;
        }

        private int GenerateVahedVaKolBaJoziyat2()
        {
            List<int> geymathaList = new List<int>();
            string result = string.Empty;
            foreach (RepeaterItem repeaterItem in rptNoeContiner.Items)
            {
                var noVaTaded = repeaterItem.FindControl("txtGeymateVahede") as TextBox;
                var geymateVahed = repeaterItem.FindControl("txtGeymateVahede") as TextBox;
                var geymateKol = (repeaterItem.FindControl("txtGeymateKol")) as TextBox;
                //                var geymateKoleKol = (repeaterItem.FindControl("txtGeymateKolKoli")) as TextBox;
                if (!string.IsNullOrEmpty(geymateVahed.Text) && !string.IsNullOrWhiteSpace(geymateVahed.Text))
                {
                    geymathaList.Add(Convert.ToInt32(geymateKol.Text));
                    result += noVaTaded.ToolTip + ":" + "{(" + geymateVahed.Text + ")(" + geymateKol.Text + ")}|";
                }
            }
            return geymathaList.Sum();
        }

        private void LnkSubmitOnClick(object sender, EventArgs eventArgs)
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
                    MyDnn_EHaml_ReplyToInquiry_Dn dnnEHamlReplyToInquiryDn = new MyDnn_EHaml_ReplyToInquiry_Dn();


                    dnnEHamlReplyToInquiryDn.IsTHCDarMabda = chkIsBaEhtesabeTHCDarMabda.Checked;
                    dnnEHamlReplyToInquiryDn.IsTHCDarMagsad = chkIsBaEhtesabeTHCDarMagsad.Checked;
                    dnnEHamlReplyToInquiryDn.IsTarkhisiyeDarMagsad = chkIsBaEhtesabeAkhseTarkhisiye.Checked;

                    dnnEHamlReplyToInquiryDn.GeymateVahedVaKolBajoziyat = GenerateVahedVaKolBaJoziyat();

                    context.MyDnn_EHaml_ReplyToInquiry_Dns.InsertOnSubmit(dnnEHamlReplyToInquiryDn);
                    context.SubmitChanges();

                    MyDnn_EHaml_ReplyToInquiry replyToInquiry = new MyDnn_EHaml_ReplyToInquiry();
                    replyToInquiry.Pishbini = cbolPishbini.SelectedItem.Value;
                    replyToInquiry.ReplyToInquiryDetail_Id = (dnnEHamlReplyToInquiryDn.Id);

                    replyToInquiry.ReplyToInquiryType = "Dn";

                    replyToInquiry.MyDnn_EHaml_User_Id = (from i in context.MyDnn_EHaml_Users
                        where i.PortalUserId == this.UserId
                        select i.Id).Single();
                    replyToInquiry.KoleModatZamaneHaml = txtModatRooz.Text;
                    replyToInquiry.ZamaneAmadegiBarayeShooroo = dtpZamaneAmadegiBarayeShoorooeAmaliyat.SelectedDate;

                    if (chkIsGozareshAmaliyat.Checked)
                    {
                        replyToInquiry.GozareshAmaliyat = true;
                    }

                    replyToInquiry.GeymateKol = decimal.Parse(util.getPool(txtGeymateKol.Text));
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

                    hiddenFieldId.Value = myDnnEHamlInquiryReplyToInquiry.Id.ToString();
                    messageAfterSubmit.Visible = true;
                    messageAfterSubmit.InnerHtml = "فرم شما با موفقیت ثبت گردید.";
                    messageAfterSubmit.Attributes["class"] = "dnnFormMessage dnnFormSuccess";
                    lnkSubmit.Visible = false;
                    lnkPrintKon.Visible = true;

                    string inquiryId = Request.QueryString["InqId"];
                    var content = util.ContentForEtelaresaniReplyToInquiry(context,
                        myDnnEHamlInquiryReplyToInquiry.Id.ToString());
                    util.EtelaresaniForReplyToInquiry(Convert.ToInt32(myDnnEHamlInquiryReplyToInquiry.Id), content);
                }
            }
        }

        #endregion Methods 
    }

    internal class ContinerNameVaJoziyatJft
    {
        #region Properties (1) 

        public string ContinerNameVaJoziyat { get; set; }

        #endregion Properties 
    }
}