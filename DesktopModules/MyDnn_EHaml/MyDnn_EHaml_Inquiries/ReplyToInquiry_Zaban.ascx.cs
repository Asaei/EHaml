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
    public partial class ReplyToInquiry_Zaban : PortalModuleBase
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

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += LnkSubmitOnClick;
            lnkTasviye.Click += lnkSub_Click;
            btnErsaleLinkTaeid23.Click += btnErsaleLinkTaeid1_Click;
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
                    MyDnn_EHaml_ReplyToInquiry_Zaban myDnnEHamlReplyToInquiryZaban =
                        new MyDnn_EHaml_ReplyToInquiry_Zaban();

                    if (rptBarAsaseTedadVaNo.Controls.Count > 0)
                    {
                        myDnnEHamlReplyToInquiryZaban.Barasase = "بر اساس تعداد و نوع وسیله حمل";
                        myDnnEHamlReplyToInquiryZaban.BarasaseValue =
                            (rptBarAsaseTedadVaNo.Controls[0].FindControl("txtGeymateVahed") as TextBox).ToolTip + "{" +
                            "(" +
                            (rptBarAsaseTedadVaNo.Controls[0].FindControl("txtGeymateVahed") as TextBox).Text + ")";
//                            "(" +
//                            (rptBarAsaseTedadVaNo.Controls[0].FindControl("txtGeymateKol") as TextBox).Text + ")";
                    }
                    else if (rptBarAsaseTonaj.Controls.Count > 0)
                    {
                        myDnnEHamlReplyToInquiryZaban.Barasase = "بر اساس تناژ محموله";
                        myDnnEHamlReplyToInquiryZaban.BarasaseValue = "(" +
                                                                      ((rptBarAsaseTonaj.Controls[0].FindControl(
                                                                          "txtGeymatBeEzayeHarTon"))
                                                                          as TextBox).Text + ")";
//                                                                          + "(" +
//                                                                      ((rptBarAsaseTonaj.Controls[0].FindControl(
//                                                                          "txtGeymateKol")) as
//                                                                          TextBox).Text + ")";
                    }

                    myDnnEHamlReplyToInquiryZaban.IsTakhliyeDarMagsad = chkIsGozareshAmaliyat.Checked;
                    myDnnEHamlReplyToInquiryZaban.IsOdateCantinereKhali =
                        chkIsEhtesabeHazineyeOdateKantinerKhali.Checked;

                    if (pnlgeymatBarAsaseListeAdlBandi.Visible)
                    {
                        myDnnEHamlReplyToInquiryZaban.GeymaqteKolBarAsaseAdl =
                            decimal.Parse(txtGeymateKolBarAsaseListeAdlBandi.Text);
                    }


                    context.MyDnn_EHaml_ReplyToInquiry_Zabans.InsertOnSubmit(myDnnEHamlReplyToInquiryZaban);
                    context.SubmitChanges();


                    MyDnn_EHaml_ReplyToInquiry replyToInquiry = new MyDnn_EHaml_ReplyToInquiry();
                    replyToInquiry.Pishbini = cbolPishbini.SelectedItem.Value;
                    replyToInquiry.ReplyToInquiryDetail_Id = (myDnnEHamlReplyToInquiryZaban.Id);

                    replyToInquiry.ReplyToInquiryType = "Zaban";

                    replyToInquiry.MyDnn_EHaml_User_Id = (from i in context.MyDnn_EHaml_Users
                        where i.PortalUserId == this.UserId
                        select i.Id).Single();
                    replyToInquiry.KoleModatZamaneHaml = txtModatRooz1.Text;
                    replyToInquiry.ZamaneAmadegiBarayeShooroo = dtpZamaneAmadegiBarayeShoorooeAmaliyat.SelectedDate;

                    if (chkIsGozareshAmaliyat.Checked)
                    {
                        replyToInquiry.GozareshAmaliyat = true;
                    }

                    //Todo ino hatman doros kon
                    replyToInquiry.GeymateKol = decimal.Parse(util.getPool(txtGeymateKol2.Text));
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
                MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
                    where i.Id == int.Parse(inquiryId)
                    select i).Single();

                MyDnn_EHaml_Inquiry_Zaban zaban = (from i in context.MyDnn_EHaml_Inquiry_Zabans
                    where i.Id == inquiry.InquiryDetail_Id
                    select i).Single();
                lblBarAsaseValue.Text = zaban.BarAsase;

                if (zaban.BarAsase == "بر اساس تعداد و نوع وسیله حمل")
                {
                    pnlgeymatBarAsaseListeAdlBandi.Visible = false;
                    List<NameVaTedadVaHadeAxareVaznJft> nameVaTedadVaHadeAxareVaznJfts =
                        new List<NameVaTedadVaHadeAxareVaznJft>();
                    nameVaTedadVaHadeAxareVaznJfts.Add(new NameVaTedadVaHadeAxareVaznJft()
                    {
                        NameVatedadVaHadeaxareVazn = zaban.ValueBarAsase
                    });
                    rptBarAsaseTedadVaNo.DataSource = nameVaTedadVaHadeAxareVaznJfts.ToList();
                    rptBarAsaseTedadVaNo.DataBind();
                }
                else if (zaban.BarAsase == "بر اساس تناژ محموله")
                {
                    pnlgeymatBarAsaseListeAdlBandi.Visible = false;
                    List<VazneKolVaVazneHarVahedJft> vazneKolVaVazneHarVahedJfts =
                        new List<VazneKolVaVazneHarVahedJft>();
                    vazneKolVaVazneHarVahedJfts.Add(new VazneKolVaVazneHarVahedJft()
                    {
                        VazneKolVaVazneHarVahed = zaban.ValueBarAsase
                    });
                    rptBarAsaseTonaj.DataSource = vazneKolVaVazneHarVahedJfts.ToList();
                    rptBarAsaseTonaj.DataBind();
                }
            }

            FillcbolMogeiyateTahvilDadan();
        }

        private void FillcbolMogeiyateTahvilDadan()
        {
            cbolMogeiyateTahvilDadan.Items.Add(new DnnComboBoxItem("-- انتخاب نماييد --", "-1"));
            cbolMogeiyateTahvilDadan.Items.Add(new DnnComboBoxItem("در کنار وسیله حمل", "در کنار وسیله حمل"));
            cbolMogeiyateTahvilDadan.Items.Add(new DnnComboBoxItem("روی وسیله حمل", "روی وسیله حمل"));
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

                MyDnn_EHaml_Inquiry_Zaban zaban = (from i in context.MyDnn_EHaml_Inquiry_Zabans
                    where i.Id == inquiry.InquiryDetail_Id
                    select i).Single();


                if (zaban.EmptyingCharges != null && (bool) zaban.EmptyingCharges)
                {
                    lblEmptyingChargesValue.Text = "بله";
                }
                else
                {
                    lblEmptyingChargesValue.Text = "خیر";
                }

                lblMogeiyateTahvilDadanShenasnameValue.Text = zaban.MogeiyateTahvilDadan;
                hplFileListeAdlBandi.NavigateUrl = zaban.FileListAdlBandi;
                hplFileListeAdlBandi.Text = "دریافت";
                lblBarAsaseShValue.Text = zaban.BarAsase;
                lblMegdareBarAsaseShValue.Text = zaban.ValueBarAsase;
                lblHSCodeShValue.Text = zaban.HSCode;
                if (bool.Parse(zaban.IsHazineyeOdatekontiner.ToString()))
                {
                    lblIsHazineyeOdateContinerShValue.Text = "بله";
                }
                else
                {
                    lblIsHazineyeOdateContinerShValue.Text = "خیر";
                }
                if (bool.Parse(zaban.IsKhahaneErsaleEstelamBeKharej.ToString()))
                {
                    lblIsKhahaneErsaleBeKharejihaValue.Text = "بله";
                }
                else
                {
                    lblIsKhahaneErsaleBeKharejihaValue.Text = "خیر";
                }
                lblNoeHamlShValue.Text = zaban.NoeHaml;
            }
        }
    }

    internal class VazneKolVaVazneHarVahedJft
    {
        public string VazneKolVaVazneHarVahed { get; set; }
    }

    internal class NameVaTedadVaHadeAxareVaznJft
    {
        public string NameVatedadVaHadeaxareVazn { get; set; }
    }
}