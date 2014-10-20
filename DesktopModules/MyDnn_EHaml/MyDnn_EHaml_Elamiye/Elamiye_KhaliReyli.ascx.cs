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
    public partial class Elamiye_KhaliReyli : PortalModuleBase
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
            lnkSubmit.Click += LnkSubmitOnClick;
            btnErsaleLinkTaeid11.Click += btnErsaleLinkTaeid1_Click;
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

        private void LnkSubmitOnClick(object sender, EventArgs eventArgs)
        {
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
                    MyDnn_EHaml_Elamiye_KhaliReyli elamiyeKhaliReyli = new MyDnn_EHaml_Elamiye_KhaliReyli();

                    elamiyeKhaliReyli.IsKhahaneErsaleEstelamBeKharej = false;
                    elamiyeKhaliReyli.VagoneHamleAmadeyeBargiri = cbolNoeVasileVagon.SelectedItem.Value;
                    elamiyeKhaliReyli.MyDnn_EHaml_User_Id = (from i in context.MyDnn_EHaml_Users
                        where i.PortalUserId == this.UserId
                        select i.Id).Single();
                    elamiyeKhaliReyli.Tedad = Convert.ToInt32(txtTedad.Text);
                    elamiyeKhaliReyli.Mabda = txtMabda.Text;
                    elamiyeKhaliReyli.Magsad = txtMagsad.Text;
                    elamiyeKhaliReyli.Masir = txtMasir.Text;
                    elamiyeKhaliReyli.ZamaneAmadegi = dtpZamaneAmadegi.SelectedDate.Value;
                    elamiyeKhaliReyli.ExpireDate = dtpExpireDate.SelectedDate.Value;
                    elamiyeKhaliReyli.CreateDate = DateTime.Now.Date;
                    elamiyeKhaliReyli.ElamiyeType = "KhaliReyli";

                    context.MyDnn_EHaml_Elamiye_KhaliReylis.InsertOnSubmit(elamiyeKhaliReyli);
                    context.SubmitChanges();

                    // BarrasiShavad
                    pnlmessageSubmit.Visible = true;
                    ElamiyeVasileyeKhaliForm.Visible = false;
                }
            }
        }

        private void FillPageControlls()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var vasileList = from i in context.MyDnn_EHaml_VasileyeHamleKhaliReylis
                    select new {VasileName = i.Name};

                cbolNoeVasileVagon.AddItem("-- انتخاب نمایید --", "-- انتخاب نمایید --");
                foreach (var vasile in vasileList)
                {
                    cbolNoeVasileVagon.AddItem(vasile.VasileName, vasile.VasileName);
                }
            }
        }
    }
}