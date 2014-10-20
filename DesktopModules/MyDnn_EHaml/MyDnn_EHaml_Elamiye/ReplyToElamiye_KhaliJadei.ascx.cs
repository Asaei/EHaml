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
using Telerik.Web.UI;

namespace MyDnn_EHaml.MyDnn_EHaml_Elamiye
{
    public partial class ReplyToElamiye_KhaliJadei : PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
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

        private void lnkSub_Click(object sender, EventArgs e)
        {
            Session["FinalReturnTabId"] = "tabid=" + this.TabId;
            Response.Redirect("/default.aspx?tabid=" +
                              PortalController.GetPortalSettingAsInteger("SubscriptionTabId", PortalId, -1) + "&type=1");
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
                    MyDnn_EHaml_Elamiye_KhaliJadei elamiye = (from i in context.MyDnn_EHaml_Elamiye_KhaliJadeis
                        where i.Id == int.Parse(Request.QueryString["ElaId"])
                        select i).Single();

                    MyDnn_EHaml_ReplyToElamiye_KhaliJadei replyToElamiyeKhaliJadei =
                        new MyDnn_EHaml_ReplyToElamiye_KhaliJadei();
                    //replyToElamiyeKhaliJadei.GeymateKol = CreateGeymateKol();
                    replyToElamiyeKhaliJadei.MyDnn_EHaml_User_Id = (from i in context.MyDnn_EHaml_Users
                        where i.PortalUserId == this.UserId
                        select i.Id).Single();
                    replyToElamiyeKhaliJadei.VasileyeHamleMoredeNiyaz = elamiye.VasileyeHamleAmadeyeBargiri;
                    replyToElamiyeKhaliJadei.Tedad = int.Parse(txtTedad.Text);
                    replyToElamiyeKhaliJadei.NoeBar = txtNoeBar.Text;
                    replyToElamiyeKhaliJadei.Mabda = txtShahrMabda.Text;
                    replyToElamiyeKhaliJadei.Magsad = txtShahreMagsad.Text;
                    replyToElamiyeKhaliJadei.ZamaneMoredeNiyaz = dtpZamaneAmadegi.SelectedDate;
                    replyToElamiyeKhaliJadei.GeymateKol = 10000;

                    context.MyDnn_EHaml_ReplyToElamiye_KhaliJadeis.InsertOnSubmit(replyToElamiyeKhaliJadei);
                    context.SubmitChanges();

                    MyDnn_EHaml_Elamiye_ReplyToElamiye replyToElamiye = new MyDnn_EHaml_Elamiye_ReplyToElamiye();
                    replyToElamiye.ElamiyeId = elamiye.Id;
                    replyToElamiye.ElamiyeType = "KhaliJadei";
                    replyToElamiye.Status = 2;
                    replyToElamiye.ReplyToElamiyeId = replyToElamiyeKhaliJadei.Id;
                    replyToElamiye.CreateDate = DateTime.Now.Date;

                    context.MyDnn_EHaml_Elamiye_ReplyToElamiyes.InsertOnSubmit(replyToElamiye);
                    context.SubmitChanges();

                    ElamiyeVasileyeKhaliForm0.Visible = false;
                    ElamiyeVasileyeKhaliForm.Visible = false;

                    pnlmessageSubmit.Visible = true;
                }
            }
        }

        private void FillPageControllsShenasname(string elamiyeId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_Elamiye_KhaliJadei elamiyeKhaliJadei =
                    (from i in context.MyDnn_EHaml_Elamiye_KhaliJadeis
                        where i.Id == Convert.ToInt32(elamiyeId)
                        select i).Single();

                lblNameText.Text = elamiyeKhaliJadei.VasileyeHamleAmadeyeBargiri;
                lblTedadText.Text = elamiyeKhaliJadei.Tedad.ToString();
                lblMabdaText.Text = elamiyeKhaliJadei.Mabda;
                lblTarikheEngezaText.Text = elamiyeKhaliJadei.ExpireDate.ToShortDateString();
                lblZamaneAmadegiText.Text = elamiyeKhaliJadei.ZamaneAmadegi.ToShortDateString();
            }
        }
    }

    internal class vasile
    {
        public string VasileName { get; set; }
    }
}