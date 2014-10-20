using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using Telerik.Web.UI;

namespace MyDnn_EHaml.MyDnn_EHaml_Elamiye
{
    public partial class ReplyToElamiye_KhaliDaryayi : PortalModuleBase
    {
        private void lnkSub_Click(object sender, EventArgs e)
        {
            Session["FinalReturnTabId"] = "tabid=" + this.TabId;
            Response.Redirect("/default.aspx?tabid=" +
                              PortalController.GetPortalSettingAsInteger("SubscriptionTabId", PortalId, -1) + "&type=1");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            dtpZamaneAmadegi.MinDate = DateTime.Now.Date;
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

            if (!Page.IsPostBack)
            {
                string elamiyeId = Request.QueryString["ElaId"];
                FillPageControllsShenasname(elamiyeId);
            }
        }


        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += lnkSubmit_Click;
            btnErsaleLinkTaeid1223.Click += btnErsaleLinkTaeid1_Click;
            lnkTasviye.Click += lnkSub_Click;
        }

        private void btnErsaleLinkTaeid1_Click(object sender, EventArgs e)
        {
            Util util = new Util();
            string appCode = util.getUserAppCode(util.GetUserEHamlUserIdByPortalId(UserId));
            string link = "http://" + PortalSettings.DefaultPortalAlias.ToLower().Replace("http://", "") +
                          "/default.aspx?tabid=" + 124 +
                          "&mid=439&ctl=Approve&AppCode=" + appCode;

            util.SendAppLinkToUserMail(UserId, link);
            pnlMessageForNotApproved.Visible = false; /*pnlMessageForNotApprovedAfterErsal.Visible = true;*/
        }

        private void lnkSubmit_Click(object sender, EventArgs e)
        {
            Util util = new Util();
            string userStatus = util.IsUserOk(this.UserId, 1);
            string status = util.IsUserOk(UserId, 1);
            if (status != "OK")
            {
                util.MakeThisUserOk(this.UserId, userStatus, this.TabId.ToString(), 1);
            }
            else
            {
                using (
                    DataClassesDataContext context =
                        new DataClassesDataContext(Config.GetConnectionString()))
                {
                    MyDnn_EHaml_Elamiye_KhaliDaryayi elamiye = (from i in context.MyDnn_EHaml_Elamiye_KhaliDaryayis
                        where i.Id == int.Parse(Request.QueryString["ElaId"])
                        select i).Single();

                    MyDnn_EHaml_ReplyToElamiye_KhaliDaryayi replyToElamiyeKhaliDaryayi =
                        new MyDnn_EHaml_ReplyToElamiye_KhaliDaryayi();

                    //replyToElamiyeKhaliJadei.GeymateKol = CreateGeymateKol();
                    replyToElamiyeKhaliDaryayi.MyDnn_EHaml_User_Id = (from i in context.MyDnn_EHaml_Users
                        where i.PortalUserId == this.UserId
                        select i.Id).Single();

                    replyToElamiyeKhaliDaryayi.VasileyeHamleMoredeNiyaz = elamiye.ContinerHayeAmadeyeBargiri;
                    replyToElamiyeKhaliDaryayi.Mabda = txtShahrMabda.Text;
                    replyToElamiyeKhaliDaryayi.Tedad = int.Parse(txtTedad.Text);
                    replyToElamiyeKhaliDaryayi.Magsad = txtShahreMagsad.Text;
                    replyToElamiyeKhaliDaryayi.NoeBar = txtNoeBar.Text;
                    replyToElamiyeKhaliDaryayi.ZamaneMoredeNiyaz = dtpZamaneAmadegi.SelectedDate;
                    replyToElamiyeKhaliDaryayi.GeymateKol = 10000;


                    context.MyDnn_EHaml_ReplyToElamiye_KhaliDaryayis.InsertOnSubmit(replyToElamiyeKhaliDaryayi);
                    context.SubmitChanges();

                    MyDnn_EHaml_Elamiye_ReplyToElamiye replyToElamiye = new MyDnn_EHaml_Elamiye_ReplyToElamiye();
                    replyToElamiye.ElamiyeId = elamiye.Id;
                    replyToElamiye.ElamiyeType = "KhaliDaryayi";
                    replyToElamiye.Status = 2;
                    replyToElamiye.ReplyToElamiyeId = replyToElamiyeKhaliDaryayi.Id;
                    replyToElamiye.CreateDate = DateTime.Now.Date;

                    context.MyDnn_EHaml_Elamiye_ReplyToElamiyes.InsertOnSubmit(replyToElamiye);
                    context.SubmitChanges();

                    ElamiyeVasileyeKhaliForm.Visible = false;
                    ElamiyeVasileyeKhaliForm0.Visible = false;
                    pnlmessageSubmit.Visible = true;
                }
            }
        }


        private void FillPageControllsShenasname(string elamiyeId)
        {
            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_Elamiye_KhaliDaryayi elamiyeKhaliDaryayi =
                    (from i in context.MyDnn_EHaml_Elamiye_KhaliDaryayis
                        where i.Id == Convert.ToInt32(elamiyeId)
                        select i).Single();

                lblMabdaText.Text = elamiyeKhaliDaryayi.Mabda;
                lblMagsadText.Text = elamiyeKhaliDaryayi.Magsad;
                lblMasireKamelText.Text = elamiyeKhaliDaryayi.Masir;
                lblNameKashtiText.Text = elamiyeKhaliDaryayi.NameKeshti;
                lblOmreKashtiText.Text = elamiyeKhaliDaryayi.OmreKashti.ToString();
                lblNameText.Text = elamiyeKhaliDaryayi.ContinerHayeAmadeyeBargiri;
                lblTedadText.Text = elamiyeKhaliDaryayi.Tedad.ToString();
                lblNameKashtiText.Text = elamiyeKhaliDaryayi.NameKeshti;
                lblZarfiyateTonajiKashtiText.Text = elamiyeKhaliDaryayi.Zarfiyat.ToString();
                lblNameKashtiText.Text = elamiyeKhaliDaryayi.NameKeshti;
                lblZamaneAmadegiText.Text = elamiyeKhaliDaryayi.ZamaneAmadegi.ToShortDateString();
            }
        }
    }
}