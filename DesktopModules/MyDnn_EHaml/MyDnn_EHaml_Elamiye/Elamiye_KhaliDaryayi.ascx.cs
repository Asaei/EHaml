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
    public partial class Elamiye_KhaliDaryayi : PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            dtpZamaneAmadegi.MinDate = DateTime.Today.Date;
            dtpExpireDate.MinDate = DateTime.Today.Date;

            if (!Page.IsPostBack)
            {
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
                FillPageControlls();
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += lnkSubmit_Click;
            btnErsaleLinkTaeid11.Click += btnErsaleLinkTaeid1_Click;
            lnkTasviye.Click += lnkSub_Click;
            lnkTasviyeS.Click += lnkSub_Click;
        }

        private void lnkSub_Click(object sender, EventArgs e)
        {
            Session["FinalReturnTabId"] = "tabid=" + this.TabId;
            Response.Redirect("/default.aspx?tabid=" +
                              PortalController.GetPortalSettingAsInteger("SubscriptionTabId", PortalId, -1) + "&type=0");
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
            if (!Page.IsValid)
            {
                return;
            }
            Util util = new Util();
            string userStatus = util.IsUserOk(this.UserId, 0);
            string status = util.IsUserOk(UserId, 0);
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
                    MyDnn_EHaml_Elamiye_KhaliDaryayi elamiyeKhaliDaryayi = new MyDnn_EHaml_Elamiye_KhaliDaryayi();

                    elamiyeKhaliDaryayi.IsKhahaneErsaleEstelamBeKharej = chkKhahaneErsalEstelamBeKharej.Checked;
                    elamiyeKhaliDaryayi.ContinerHayeAmadeyeBargiri = cbolNoeVasile.SelectedItem.Value;
                    elamiyeKhaliDaryayi.MyDnn_EHaml_User_Id = (from i in context.MyDnn_EHaml_Users
                        where i.PortalUserId == this.UserId
                        select i.Id).Single();
                    elamiyeKhaliDaryayi.Tedad = int.Parse(txtTedad.Text);
                    elamiyeKhaliDaryayi.CreateDate = DateTime.Now.Date;
                    elamiyeKhaliDaryayi.Zarfiyat = double.Parse(txtZarfiyateKashti.Text);
                    elamiyeKhaliDaryayi.OmreKashti = double.Parse(txtOmreKashti.Text);
                    elamiyeKhaliDaryayi.Masir = txtMasireHarakat.Text;
                    elamiyeKhaliDaryayi.ZamaneAmadegi = dtpZamaneAmadegi.SelectedDate.Value;
                    elamiyeKhaliDaryayi.ExpireDate = dtpExpireDate.SelectedDate.Value;
                    elamiyeKhaliDaryayi.ElamiyeType = "KhaliDaryayi";
                    elamiyeKhaliDaryayi.Mabda = txtMabda.Text;
                    elamiyeKhaliDaryayi.Magsad = txtMagsad.Text;
                    elamiyeKhaliDaryayi.NameKeshti = txtNameKeshti.Text;

                    context.MyDnn_EHaml_Elamiye_KhaliDaryayis.InsertOnSubmit(elamiyeKhaliDaryayi);
                    context.SubmitChanges();

                    // BarrasiShavad
                    pnlmessageSubmit.Visible = true;
                    ElamiyeVasileyeKhaliForm.Visible = false;
                }
            }
        }


        private void FillPageControlls()
        {
            lblDarkhastKonandeValue.Text = this.UserInfo.DisplayName;

            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var vasileList = from i in context.MyDnn_EHaml_NoeContiners
                    select new {VasileName = i.NoeContiner};
                cbolNoeVasile.AddItem("-- انتخاب نمایید --", "-- انتخاب نمایید --");
                foreach (var vasile in vasileList)
                {
                    cbolNoeVasile.AddItem("نوع " + vasile.VasileName, vasile.VasileName);
                }
            }
        }
    }
}