using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using Telerik.Web.UI;

namespace MyDnn_EHaml.MyDnn_EHaml_Elamiye
{
    public partial class ReplyToElamiye_KhaliReyli : PortalModuleBase
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

        private void FillPageControllsShenasname(string elamiyeId)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_Elamiye_KhaliReyli elamiyeKhaliReyli =
                    (from i in context.MyDnn_EHaml_Elamiye_KhaliReylis
                        where i.Id == Convert.ToInt32(elamiyeId)
                        select i).Single();

                lblNameText.Text = elamiyeKhaliReyli.VagoneHamleAmadeyeBargiri;

                lblMasireKamelText.Text = elamiyeKhaliReyli.Masir;
                lblMagsadText.Text = elamiyeKhaliReyli.Magsad;
                lblMabdaText.Text = elamiyeKhaliReyli.Mabda;
                lblZamaneAmadegiText.Text = elamiyeKhaliReyli.ZamaneAmadegi.ToShortDateString();
                lblTarikheEngezaText.Text = elamiyeKhaliReyli.ExpireDate.ToShortDateString();
                lblTedadText.Text = elamiyeKhaliReyli.Tedad.ToString();
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += lnkSubmit_Click;
            btnErsaleLinkTaeid1223.Click += btnErsaleLinkTaeid1_Click;
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
                    MyDnn_EHaml_Elamiye_KhaliReyli elamiye = (from i in context.MyDnn_EHaml_Elamiye_KhaliReylis
                        where i.Id == int.Parse(Request.QueryString["ElaId"])
                        select i).Single();

                    MyDnn_EHaml_ReplyToElamiye_KhaliReyli replyToElamiyeKhaliReyli =
                        new MyDnn_EHaml_ReplyToElamiye_KhaliReyli();


                    replyToElamiyeKhaliReyli.MyDnn_EHaml_User_Id = (from i in context.MyDnn_EHaml_Users
                        where i.PortalUserId == this.UserId
                        select i.Id).Single();

                    replyToElamiyeKhaliReyli.VasileyeHamleMoredeNiyaz = elamiye.VagoneHamleAmadeyeBargiri;
                    replyToElamiyeKhaliReyli.Tedad = int.Parse(txtTedad.Text);
                    replyToElamiyeKhaliReyli.Mabda = txtShahrMabda.Text;
                    replyToElamiyeKhaliReyli.Magsad = txtShahreMagsad.Text;
                    replyToElamiyeKhaliReyli.ZamaneMoredeNiyaz = dtpZamaneAmadegi.SelectedDate;
                    replyToElamiyeKhaliReyli.NoeBar = txtNoeMahmoole.Text;
                    replyToElamiyeKhaliReyli.GeymateKol = 10000;

                    context.MyDnn_EHaml_ReplyToElamiye_KhaliReylis.InsertOnSubmit(replyToElamiyeKhaliReyli);
                    context.SubmitChanges();

                    MyDnn_EHaml_Elamiye_ReplyToElamiye replyToElamiye = new MyDnn_EHaml_Elamiye_ReplyToElamiye();
                    replyToElamiye.ElamiyeId = elamiye.Id;
                    replyToElamiye.ElamiyeType = "KhaliReyli";
                    replyToElamiye.Status = 2;
                    replyToElamiye.ReplyToElamiyeId = replyToElamiyeKhaliReyli.Id;
                    replyToElamiye.CreateDate = DateTime.Now.Date;

                    context.MyDnn_EHaml_Elamiye_ReplyToElamiyes.InsertOnSubmit(replyToElamiye);
                    context.SubmitChanges();
                }
            }
        }
    }
}