using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.Modules.Dashboard.Components;


namespace MyDnn_EHaml.MyDnn_EHaml_Dashboard
{
    public partial class ReplyToInquiryShenasname : PortalModuleBase
    {
        private Util _util = new Util();

        private void lnkSub_Click(object sender, EventArgs e)
        {
            Session["FinalReturnTabId"] = "tabid=" + this.TabId;
            Response.Redirect("/default.aspx?tabid=" +
                              PortalController.GetPortalSettingAsInteger("SubscriptionTabId", PortalId, -1) + "&type=1");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Util util = new Util();
                if (util.IsUserOk(this.UserId, 1) != "OK")
                {
                    pnlMessageForNotSubscribeUser.Visible = true;
                }
                string replyId = Request.QueryString["RepId"];
                MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
                using (
                    DataClassesDataContext context =
                        new DataClassesDataContext(Config.GetConnectionString()))
                {
                    replyToInquiry = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join j in context.MyDnn_EHaml_ReplyToInquiries on i.ReplyToInquiryId equals j.Id
                        where i.Id == int.Parse(replyId)
                        select j).Single();

                    MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                        where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                        select i).Single();


                    //lblPasokhDahandeValue.Text = UserController.GetUserById(0, (int) user.PortalUserId).DisplayName +
                    //                             "(" + UserController.GetUserById(0, (int) user.PortalUserId).UserID +
                    //                             ")";

                    lblPasokhDahandeValue.Text =
                        "اطلاعات لازم جهت تماس با خدمات رسان بعد از تاییدیه شما در اختیارتان قرار میگیرد";


                    if (replyToInquiry.GozareshAmaliyat != null &&
                        bool.Parse(replyToInquiry.GozareshAmaliyat.ToString()))
                    {
                        lblIsGozareshAmaliyatValue.Text = "بله";
                    }
                    else
                    {
                        lblIsGozareshAmaliyatValue.Text = "خیر";
                    }

                    lblGeymateKolValue.Text = replyToInquiry.GeymateKol.ToString();
                    lblKoleModatZamaneHaml.Text = replyToInquiry.KoleModatZamaneHaml;
                    if (replyToInquiry.ReplyToInquiryType != "Bazdid")
                    {
                        lblZamaneAmadegiBarayeShoorooeAmaliyatValue.Text =
                            replyToInquiry.ZamaneAmadegiBarayeShooroo.Value.ToString("yyyy MMMM dd");
                    }
                }


                switch (replyToInquiry.ReplyToInquiryType)
                {
                    case "Zadghan":
                        FillPnlReplyToInquiryZadghanShenasnameTitle(replyToInquiry);
                        break;
                    case "Zadghal":
                        FillPnlReplyToInquiryZadghalShenasnameTitle(replyToInquiry);
                        break;
                    case "Zaban":
                        FillPnlReplyToInquiryZabanShenasnameTitle(replyToInquiry);
                        break;
                    case "Rl":
                        FillPnlReplyToInquiryTkShenasnameTitle(replyToInquiry);
                        break;
                    case "Dn":
                        FillPnlReplyToInquiryDnShenasnameTitle(replyToInquiry);
                        break;
                    case "Dl":
                        FillPnlReplyToInquiryDlShenasnameTitle(replyToInquiry);
                        break;
                    case "ZDF":
                        FillpnlReplyToInquiryZDFShenasname(replyToInquiry);
                        break;
                    case "Dghco":
                        FillPnlReplyToInquiryDghcoShenasname(replyToInquiry);
                        break;
                    case "Hl":
                        FillPnlReplyToInquiryHlShenasname(replyToInquiry);
                        break;
                    case "Tj":
                        FillPnlReplyToInquiryTjShenasname(replyToInquiry);
                        break;
                    case "Tk":
                        FillPnlReplyToInquiryTkShenasname(replyToInquiry);
                        break;
                    case "Ts":
                        FillPnlReplyToInquiryTsShenasname(replyToInquiry);
                        break;
                    case "Tr":
                        FillPnlReplyToInquiryTrShenasname(replyToInquiry);
                        break;
                    case "ChandVajhiSabok":
                        FillPnlReplyToInquiryChandVajhiSabokShenasname(replyToInquiry);
                        break;
                    case "ChandVajhiSangin":
                        FillPnlReplyToInquiryChandVajhiSanginShenasname(replyToInquiry);
                        break;
                    case "Bazdid":
                        FillPnlReplyToInquiryBazdidShenasname(replyToInquiry);
                        break;
                    case "Hs":
                        FillPnlReplyToInquiryHsShenasname(replyToInquiry);
                        break;
                }

                if (Request.QueryString["IsPrint"] == "Yes" || Request.QueryString["popUp"] == "true")
                {
//                        pnlMessageForBedehkarUser.Visible = false;
//                        pnlMessageForLoginNakarde.Visible = false;
//                        pnlMessageForNotApproved.Visible = false;
                    pnlMessageForNotSubscribeUser.Visible = false;
                    
                    lnkSubmit.Visible = false;
                    lnkSubmitZadghal.Visible = false;
                    lnkSubmitZaban.Visible = false;
                    lnkSubmitRl.Visible = false;
                    lnkSubmitDn.Visible = false;
                    lnkSubmitDl.Visible = false;
                    lnkSubmitZDF.Visible = false;
                    lnkSubmitDghco.Visible = false;
                    lnkSubmitHl.Visible = false;
                    lnkSubmitTj.Visible = false;
                    lnkSubmitTk.Visible = false;
                    lnkSubmitTs.Visible = false;
                    lnkSubmitTr.Visible = false;
                    lnkSubmitChandVajhiSabok.Visible = false;
                    lnkSubmitChandVajhiSangin.Visible = false;
                    lnkSubmitBazdid.Visible = false;
                    lnkHsSubmit.Visible = false;
                    logoForPrint.Visible = true;
                }
            }
        }


        private void FillPnlReplyToInquiryBazdidShenasname(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryBazdidShenasname.Visible = true;

            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                lblGeymateKolBazdidValue.Text = replyToInquiry.GeymateKol.ToString();
            }
        }

        private void FillPnlReplyToInquiryChandVajhiSanginShenasname(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryChandVajhiSanginShenasname.Visible = true;

            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                var replyToInquiryChandVajhiSabok =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_ChandVajhiSangins
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();

                lblGeymateKoleChandVajhiSanginValue.Text = replyToInquiry.GeymateKol.ToString();
                lblIsTHCDarMabdaChandVajhiSanginValue.Text = replyToInquiryChandVajhiSabok.IsTHCDarMabda.ToString();
                lblBaEhtesabeBimeValueSangin.Text = replyToInquiryChandVajhiSabok.IsBime.ToString();
                lblBaHazineyeBargiriValueSangin.Text = replyToInquiryChandVajhiSabok.IsBargiriDarMabda.ToString();
                lblHazineyeTarkhisDarMabdaValueSangin.Text =
                    replyToInquiryChandVajhiSabok.IsHazineyeTarkhisDarMabda.ToString();
                lblTHCDarMabdaValueSangin.Text = replyToInquiryChandVajhiSabok.IsTHCDarMabda.ToString();
                lblHazinehayeBandariValueSangin.Text = replyToInquiryChandVajhiSabok.IsKoleHazinehayeBandari.ToString();
                lblAkhseTarkhisiyeDarMagsadValueSangin.Text =
                    replyToInquiryChandVajhiSabok.IsAkhseTarkhisiyeDarMagsad.ToString();
                lblTakhliyeDarMagsadValueSangin.Text = replyToInquiryChandVajhiSabok.IsTakhliyeDarMagsad.ToString();
            }
        }

        private void FillPnlReplyToInquiryChandVajhiSabokShenasname(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryChandVajhiSabokShenasname.Visible = true;

            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                var replyToInquiryChandVajhiSabok =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_ChandVajhiSaboks
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();

                lblGeymateKoleChandVajhiSabokValue.Text = replyToInquiry.GeymateKol.ToString();
                lblIsTHCDarMabdaChandVajhiSabokValue.Text = replyToInquiryChandVajhiSabok.IsTHCDarMabda.ToString();
                lblBaEhtesabeBimeValue.Text = replyToInquiryChandVajhiSabok.IsBime.ToString();
                lblBaHazineyeBargiriValue.Text = replyToInquiryChandVajhiSabok.IsBargiriDarMabda.ToString();
                lblHazineyeTarkhisDarMabdaValue.Text =
                    replyToInquiryChandVajhiSabok.IsHazineyeTarkhisDarMabda.ToString();
                lblTHCDarMabdaValue.Text = replyToInquiryChandVajhiSabok.IsTHCDarMabda.ToString();
                lblHazinehayeBandariValue.Text = replyToInquiryChandVajhiSabok.IsKoleHazinehayeBandari.ToString();
                lblAkhseTarkhisiyeDarMagsadValue.Text =
                    replyToInquiryChandVajhiSabok.IsAkhseTarkhisiyeDarMagsad.ToString();
                lblTakhliyeDarMagsadValue.Text = replyToInquiryChandVajhiSabok.IsTakhliyeDarMagsad.ToString();
                lblOdatContinerValue.Text = replyToInquiryChandVajhiSabok.IsHazineyeOdat.ToString();
            }
        }

        private void FillPnlReplyToInquiryTrShenasname(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryTrShenasname.Visible = true;

            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                var replyToInquiryTr =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_Trs
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();

                lblGeymateKoleAmaliyatValue.Text = replyToInquiryTr.GeymateKoleAmaliyat.ToString();
                lblMogeiyateTahvilGereftanTrValue.Text = replyToInquiryTr.MogeiyateTahvilGereftan;
                lblMogeiyateTahvilDaddanTrValue.Text = replyToInquiryTr.MogeiyateTahvilDadan;
            }
        }

        private void FillPnlReplyToInquiryTsShenasname(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryTsShenasname.Visible = true;

            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                var replyToInquiryTs =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_Ts
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();

                hplFormePasokheGeymate.NavigateUrl = replyToInquiryTs.FormePasokheGeymateTakhliyeSangin;
                lblAnjameAmaliyatBeVasileyeValue.Text = replyToInquiryTs.AnjameAmaliyatBeVasileye;
            }
        }

        private void FillPnlReplyToInquiryTkShenasname(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryTkShenasname.Visible = true;
            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                var replyToInquiryTk =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_Tks
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();

                lblGeymatePishnahadiTkValue.Text = replyToInquiryTk.GeymatePishnahadi.ToString();
                lblHamlBeVasileyeValueTk.Text = replyToInquiryTk.AnjameAmaliyatBeVasileye;
                lblNoVaTedadeVasileyeHamlBajoziyatTkValue.Text = replyToInquiryTk.GeymateVahedVaKolBajoziyat;
            }
        }

        private void FillPnlReplyToInquiryTjShenasname(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryTjShenasname.Visible = true;
            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                var replyToInquiryTj =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_Tjs
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();

                lblGeymateKolBarAsaseListeAdlBandiTjValue.Text = replyToInquiry.GeymateKol.ToString();
                lblGeymateKolTjValue.Text = replyToInquiryTj.GeymaqteKolBarAsaseAdl.ToString();
                lblHamlBeVasileyeValue.Text = replyToInquiryTj.AnjameAmaliyatBeVasileye;
            }
        }

        private void FillPnlReplyToInquiryHlShenasname(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryHlShenasname.Visible = true;
            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                var replyToInquiryHl =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_Hls
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();

                lblGeymateKolBarAsaseListeAdlBandiHl.Text = replyToInquiry.GeymateKol.ToString();
                lblGeymateKolHlValue.Text = replyToInquiryHl.GeymaqteKolBarAsaseAdl.ToString();
            }
        }

        private void FillPnlReplyToInquiryDghcoShenasname(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryDghcoShenasname.Visible = true;

            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                var replyToInquiryD =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_Dghcos
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();

                lblGeymateKolAdlBandiDghcoValue.Text = replyToInquiryD.GeymaqteKolBarAsaseAdl.ToString();
                lblGeymateKolDghcoValue.Text = replyToInquiry.GeymateKol.ToString();

                if (replyToInquiryD.EmptyingCharges)
                {
                    lblEmptyingChargesDghcoValue.Text = "بلی";
                }
                else
                {
                    lblEmptyingChargesDghcoValue.Text = "خیر";
                }

                if (replyToInquiryD.IsTarkhisiyeDarMagsad)
                {
                    IsTarkhisiyeDarMagsadValue.Text = "بلی";
                }
                else
                {
                    IsTarkhisiyeDarMagsadValue.Text = "خیر";
                }

                if (replyToInquiryD.IsBargiriRooyeKasshidarMabda)
                {
                    IsBargiriRooyeKasshidarMabdaValue.Text = "بله";
                }
                else
                {
                    IsBargiriRooyeKasshidarMabdaValue.Text = "خیر";
                }
            }
        }

        private void FillpnlReplyToInquiryZDFShenasname(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryZDFShenasname.Visible = true;

            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                var replyToInquiryD =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_ZDFs
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();

                if (replyToInquiryD.Barasase.Contains("تناژ"))
                {
                    lblBarasaseZDFValue.Text = "بر اساس تناژ محموله";
                }
                else
                {
                    lblBarasaseZDFValue.Text = "براساس هر وسیله حمل";
                }

                lblGeymatBaJoziyatZDFValue.Text = replyToInquiryD.ValueBarAsase;

                lblMogeiyateTahvilDaddanZDFValue.Text = replyToInquiryD.MogeiyateTahvilDadanJ;

                lblKerayeyePishnahadiZDFValue.Text = replyToInquiryD.GeymatePishnahadi.ToString();
            }
        }

        private void FillPnlReplyToInquiryDlShenasnameTitle(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryDlShenasnameTitle.Visible = true;

            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                var replyToInquiryD =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_Dls
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();


                if (replyToInquiryD.BarAsase.Contains("FCL"))
                {
                    lblGeymateVahedVaKolBajoziyatDlValue.Text = replyToInquiryD.GeymateKoleDakheli.ToString();
                }
                else
                {
                    lblGeymateVahedVaKolBajoziyatDlValue.Text = replyToInquiryD.GeymateVahedVaKolBajoziyat;
                }


                if (replyToInquiryD.IsTarkhisiyeDarMagsad != null &&
                    bool.Parse(replyToInquiryD.IsTarkhisiyeDarMagsad.ToString()))
                {
                    lblIsTarkhisiyeDarMagsadDlValue.Text = "بله";
                }
                else
                {
                    lblIsTarkhisiyeDarMagsadDlValue.Text = "خیر";
                }

                if (replyToInquiryD.IsTHCDarMagsad)
                {
                    lblIsTHCDarMagsadDlValue.Text = "بله";
                }
                else
                {
                    lblIsTHCDarMagsadDlValue.Text = "خیر";
                }
                if (replyToInquiryD.BarAsase.Contains("FCL"))
                {
                    lblBarAsaseDlValue.Text = "FCL(یک کانتینر کامل)";
                }
                else
                {
                    lblBarAsaseDlValue.Text = "LCL(قسمتی از یک کانتینر)";
                }
            }
        }

        private void FillPnlReplyToInquiryDnShenasnameTitle(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryDnShenasnameTitle.Visible = true;
            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                MyDnn_EHaml_ReplyToInquiry_Dn replyToInquiryDn =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_Dns
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();
                lblGeymateVahedVaKolBajoziyatValue.Text = replyToInquiryDn.GeymateVahedVaKolBajoziyat;

                if (replyToInquiryDn.IsTHCDarMabda != null &&
                    bool.Parse(replyToInquiryDn.IsTHCDarMabda.ToString()))
                {
                    lblIsTHCDarMabdaValue.Text = "بله";
                }
                else
                {
                    lblIsTHCDarMabdaValue.Text = "خیر";
                }

                if (replyToInquiryDn.IsTHCDarMagsad != null &&
                    bool.Parse(replyToInquiryDn.IsTHCDarMagsad.ToString()))
                {
                    lblIsTHCDarMagsadValue.Text = "بله";
                }
                else
                {
                    lblIsTHCDarMagsadValue.Text = "خیر";
                }

                if (replyToInquiryDn.IsTarkhisiyeDarMagsad != null &&
                    bool.Parse(replyToInquiryDn.IsTarkhisiyeDarMagsad.ToString()))
                {
                    lblIsTarkhisiyeDarMagsadValue.Text = "بله";
                }
                else
                {
                    lblIsTarkhisiyeDarMagsadValue.Text = "خیر";
                }
            }
        }

        private void FillPnlReplyToInquiryTkShenasnameTitle(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryTkShenasnameTitle.Visible = true;
            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                MyDnn_EHaml_ReplyToInquiry_Rl replyToInquiryTk =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_Rls
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();

                lblGeymateKolBarAsaseListeAdlBandiRlValue.Text = replyToInquiryTk.GeymaqteKolBarAsaseAdl.ToString();

                if (replyToInquiryTk.IsHazineyeBargiriDarMabda != null &&
                    bool.Parse(replyToInquiryTk.IsHazineyeBargiriDarMabda.ToString()))
                {
                    lblIsHazineyeBargiriDarMabdaValue.Text = "بله";
                }
                else
                {
                    lblIsHazineyeBargiriDarMabdaValue.Text = "خیر";
                }

                if (replyToInquiryTk.EmptyingCharges != null &&
                    bool.Parse(replyToInquiryTk.EmptyingCharges.ToString()))
                {
                    lblIsHazineyeTakhliyeValue.Text = "بله";
                }
                else
                {
                    lblIsHazineyeTakhliyeValue.Text = "خیر";
                }
            }
        }

        private void FillPnlReplyToInquiryZabanShenasnameTitle(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryZabanShenasnameTitle.Visible = true;
            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                MyDnn_EHaml_ReplyToInquiry_Zaban replyToInquiryZaban =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_Zabans
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();

                lblGeymateKolBarAsaseListeAdlBandiValue.Text = replyToInquiryZaban.GeymaqteKolBarAsaseAdl.ToString();
                lblBarasaseValue.Text = replyToInquiryZaban.Barasase;
                lblBarasaseJoziyatValue.Text = replyToInquiryZaban.BarasaseValue;
                if (replyToInquiryZaban.IsOdateCantinereKhali != null &&
                    bool.Parse(replyToInquiryZaban.IsOdateCantinereKhali.ToString()))
                {
                    lblIsOdateContinereKhaliValue.Text = "بله";
                }
                else
                {
                    lblIsOdateContinereKhaliValue.Text = "خیر";
                }

                if (replyToInquiryZaban.IsTakhliyeDarMagsad != null &&
                    bool.Parse(replyToInquiryZaban.IsTakhliyeDarMagsad.ToString()))
                {
                    lblIsTakhliyeDarMahalValue.Text = "بله";
                }
                else
                {
                    lblIsTakhliyeDarMahalValue.Text = "خیر";
                }
            }
        }

        private void FillPnlReplyToInquiryZadghalShenasnameTitle(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryZadghalShenasnameTitle.Visible = true;

            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                MyDnn_EHaml_ReplyToInquiry_ZadghalT replyToInquiryZadghalT =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_ZadghalTs
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();

                lblNoVaTedadeVasileyeHamlZadghalValue.Text = replyToInquiryZadghalT.NoVaTedadeVasileyeHaml;
            }
        }

        private void FillPnlReplyToInquiryZadghanShenasnameTitle(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlReplyToInquiryZadghanShenasnameTitle.Visible = true;

            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                MyDnn_EHaml_ReplyToInquiry_Zadghan replyToInquiryZadghan =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_Zadghans
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();

                lblKerayeyePishnahadiValue.Text = replyToInquiryZadghan.KerayeyePishnahadi;
                lblNoVaTedadeVasileyeHamlValue.Text = replyToInquiryZadghan.NoVaTedadeVasileyeHaml;
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += LnkSubmitOnClick;
            lnkSubmitZadghal.Click += LnkSubmitOnClick;
            lnkSubmitZaban.Click += LnkSubmitOnClick;
            lnkSubmitRl.Click += LnkSubmitOnClick;
            lnkSubmitDn.Click += LnkSubmitOnClick;
            lnkSubmitDl.Click += LnkSubmitOnClick;
            lnkSubmitZDF.Click += LnkSubmitOnClick;
            lnkSubmitDghco.Click += LnkSubmitOnClick;
            lnkSubmitHl.Click += LnkSubmitOnClick;
            lnkSubmitTj.Click += LnkSubmitOnClick;
            lnkSubmitTk.Click += LnkSubmitOnClick;
            lnkSubmitTs.Click += LnkSubmitOnClick;
            lnkSubmitTr.Click += LnkSubmitOnClick;
            lnkSubmitChandVajhiSabok.Click += LnkSubmitOnClick;
            lnkSubmitChandVajhiSangin.Click += LnkSubmitOnClick;
            lnkSubmitBazdid.Click += LnkSubmitOnClick;
            lnkHsSubmit.Click += LnkSubmitOnClick;
        }

        #region ttt

        //private void lnkSubmitBazdid_Click(object sender, EventArgs e)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        //private void lnkSubmitChandVajhiSangin_Click(object sender, EventArgs e)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        //private void lnkSubmitChandVajhiSabok_Click(object sender, EventArgs e)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        //private void lnkSubmitTr_Click(object sender, EventArgs e)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        //private void lnkSubmitTs_Click(object sender, EventArgs e)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        //private void lnkSubmitTk_Click(object sender, EventArgs e)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        //private void LnkSubmitTjOnClick(object sender, EventArgs eventArgs)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        //private void LnkSubmitHlOnClick(object sender, EventArgs eventArgs)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        //private void lnkSubmitDghco_Click(object sender, EventArgs e)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        //private
        //    void lnkSubmitZDF_Click
        //    (object sender, EventArgs e)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        //private
        //    void lnkSubmitDl_Click
        //    (object sender, EventArgs e)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        //private void lnkSubmitDn_Click(object sender, EventArgs e)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        //private void lnkSubmitRl_Click(object sender, EventArgs e)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        //private void lnkSubmitZaban_Click(object sender, EventArgs e)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        //private void lnkSubmitZadghal_Click(object sender, EventArgs e)
        //{
        //    string replyId = Request.QueryString["RepId"];
        //    MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
        //    using (
        //        DataClassesDataContext context =
        //            new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        replyToInquiry = (from i in context.MyDnn_EHaml_ReplyToInquiries
        //            where i.Id == int.Parse(replyId)
        //            select i).Single();

        //        MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
        //            where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
        //            select i).Single();

        //        MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
        //            (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
        //                where i.ReplyToInquiryId == int.Parse(replyId)
        //                select i).Single();


        //        MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
        //            where i.Id == inquiryReplyToInquiry.InquiryId
        //            select i).Single();

        //        inquiry.ServantUserId = user.Id;
        //        inquiry.AcceptedDate = DateTime.Now;

        //        inquiryReplyToInquiry.Status = 1;
        //        context.SubmitChanges();
        //    }
        //}

        #endregion

        private void FillPnlReplyToInquiryHsShenasname(MyDnn_EHaml_ReplyToInquiry replyToInquiry)
        {
            pnlHs.Visible = true;

            using (DataClassesDataContext context =
                new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                    select i).Single();

                var replyToInquiryhs =
                    (from i in context.MyDnn_EHaml_ReplyToInquiry_Hs
                        where i.Id == int.Parse(replyToInquiry.ReplyToInquiryDetail_Id.ToString())
                        select i).Single();

                hplFormePasokheGeymateHs.NavigateUrl = replyToInquiryhs.FormePasokheGeymateTakhliyeSangin;
            }
        }

        private void LnkSubmitOnClick(object sender, EventArgs e)
        {
            string userStatus = _util.IsUserOk(this.UserId, 1);
            if ((userStatus != "OK"))
            {
                _util.MakeThisUserOk(this.UserId, userStatus, this.TabId.ToString(), 1);
            }
            else
            {
                string replyId = Request.QueryString["RepId"];
                MyDnn_EHaml_ReplyToInquiry replyToInquiry = null;
                using (
                    DataClassesDataContext context =
                        new DataClassesDataContext(Config.GetConnectionString()))
                {
                    replyToInquiry = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join j in context.MyDnn_EHaml_ReplyToInquiries on i.ReplyToInquiryId equals j.Id
                        where i.Id == int.Parse(replyId)
                        select j).Single();

                    MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                        where i.Id == replyToInquiry.MyDnn_EHaml_User_Id
                        select i).Single();

                    MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
                        (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            where i.Id == int.Parse(replyId)
                            select i).Single();


                    MyDnn_EHaml_Inquiry inquiry = (from i in context.MyDnn_EHaml_Inquiries
                        where i.Id == inquiryReplyToInquiry.InquiryId
                        select i).Single();

                    inquiry.ServantUserId = user.Id;
                    inquiry.AcceptedDate = DateTime.Now;

                    inquiryReplyToInquiry.Status = 1;
                    context.SubmitChanges();

                    _util.TanzimeBedehkariyeUser((int) user.PortalUserId, inquiry.AcceptedDate);


                    long mablag = (long) _util.MakeKhadamatresanBedehkar(inquiryReplyToInquiry,
                        (int) user.PortalUserId,
                        (_util.GetDarsad(replyToInquiry.GeymateKol, replyToInquiry.ReplyToInquiryType)),
                        _util.getUserTakhfif(user.PortalUserId),
                        0);

                    var content = _util.ContentForEtelaresaniTaeedReply(context, replyId, mablag);
                    _util.EtelaresaniForTaeedReply(Convert.ToInt32(replyId), content);
                }
            }
        }
    }
}