using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Users;
using DotNetNuke.UI.UserControls;
using DotNetNuke.Web.UI.WebControls;


namespace MyDnn_EHaml.MyDnn_EHaml_Dashboard
{
    public partial class NazarSanji_KhadamatBeSaheb : PortalModuleBase
    {
        private Util _util = new Util();

        protected void Page_Load(object sender, EventArgs e)
        {
            Util util = new Util();
            //string userStatus = util.IsUserOk(this.UserId);
            //if ((userStatus != "OK"))
            //{
            //    util.MakeThisUserOk(this.UserId, userStatus, "default.aspx");
            //}
            //else
            //{
            if (!Page.IsPostBack)
            {
                FillPageControlls();
            }
            //}
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += lnkSubmit_Click;
        }

        private void lnkSubmit_Click(object sender, EventArgs e)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                int id = Convert.ToInt32(Request.QueryString["inquiryReplyToInquiry_Id"]);

                MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
                    (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        where i.Id == id
                        select i).Single();


                MyDnn_EHaml_NazarSanji_KhadamatBeSaheb sahebBeKhadamat = new MyDnn_EHaml_NazarSanji_KhadamatBeSaheb();

                sahebBeKhadamat.Ertebatat = (double?) Math.Round((decimal) rtgErtebatateOomoomi.Value);
                sahebBeKhadamat.NazareKoli = bool.Parse(cbolNazarKoli.SelectedItem.Value);
                sahebBeKhadamat.PardakhteDaghighVaBeMoghe =
                    (double?) Math.Round((decimal) rtgPardakhteDaghigVaBeMoghe.Value);
                sahebBeKhadamat.SehateEtelaateEstelam =
                    (double?) Math.Round((decimal) rtgSehateEtelaateEstelam.Value);

                double quality =
                    (double) (((sahebBeKhadamat.Ertebatat + sahebBeKhadamat.PardakhteDaghighVaBeMoghe +
                                sahebBeKhadamat.SehateEtelaateEstelam
                        ))/3);

                sahebBeKhadamat.Inquiry_Id = inquiryReplyToInquiry.InquiryId;
                sahebBeKhadamat.ReplyToInquiry_Id = inquiryReplyToInquiry.ReplyToInquiryId;

                context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs.InsertOnSubmit(sahebBeKhadamat);
                context.SubmitChanges();


                int tarafikeBeheshNazarMidamId =
                    _util.GetUserEHamlUserIdByPortalId(
                        _util.GetSahebUserByInquiryId((int) inquiryReplyToInquiry.InquiryId));

                if (
                    !context.MyDnn_EHaml_UserRanks.Any(
                        x => x.MyDnn_EHaml_User_Id == tarafikeBeheshNazarMidamId && x.Type == 1))
                {
                    MyDnn_EHaml_UserRank userRank = new MyDnn_EHaml_UserRank();
                    userRank.MyDnn_EHaml_User_Id = tarafikeBeheshNazarMidamId;
                    userRank.Quality = (double) Math.Round((decimal) quality);
                    userRank.Type = 1;

                    context.MyDnn_EHaml_UserRanks.InsertOnSubmit(userRank);
                    context.SubmitChanges();
                }
                else
                {
                    MyDnn_EHaml_UserRank userRank = (from i in context.MyDnn_EHaml_UserRanks
                        where i.MyDnn_EHaml_User_Id == tarafikeBeheshNazarMidamId && i.Type == 1
                        select i).Single();
                    userRank.Quality =
                        (double) (
                            (Math.Round((decimal) (userRank.Quality + (double?) Math.Round((decimal) quality))))/2);
                    context.SubmitChanges();
                }

                int thisUserEHamlUserId = _util.GetUserEHamlUserIdByPortalId(this.UserId);

                if (
                    !context.MyDnn_EHaml_UserRanks.Any(
                        x =>
                            x.MyDnn_EHaml_User_Id == thisUserEHamlUserId && x.Type == 0))
                {
                    MyDnn_EHaml_UserRank userRank = new MyDnn_EHaml_UserRank();
                    userRank.MyDnn_EHaml_User_Id = thisUserEHamlUserId;
                    userRank.Power = 1;
                    userRank.Type = 0;
                    context.MyDnn_EHaml_UserRanks.InsertOnSubmit(userRank);
                    context.SubmitChanges();
                }
                else
                {
                    MyDnn_EHaml_UserRank userRank = (from i in context.MyDnn_EHaml_UserRanks
                        where i.MyDnn_EHaml_User_Id == thisUserEHamlUserId && i.Type == 0
                        select i).Single();
                    userRank.Power += 1;
                    context.SubmitChanges();
                }

                lnkSubmit.Enabled = false;
            }
        }

        private void FillPageControlls()
        {
            bool isView = Request.QueryString["IsView"] != null;
            if (isView)
            {
                int id = Convert.ToInt32(Request.QueryString["inquiryReplyToInquiry_Id"]);
                using (DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
                {
                    var irti = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        where i.Id == id
                        select i).Single();
                    var result = (from i in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                        where i.Inquiry_Id == irti.InquiryId && i.ReplyToInquiry_Id == i.ReplyToInquiry_Id
                        select i).Single();

                    lnkSubmit.Visible = false;
                    rtgErtebatateOomoomi.Enabled = false;
                    rtgPardakhteDaghigVaBeMoghe.Enabled = false;
                    rtgSehateEtelaateEstelam.Enabled = false;
                    cbolNazarKoli.Enabled = false;
                    if (result.NazareKoli.Value)
                    {
                        cbolNazarKoli.Items.Add((new DnnComboBoxItem("خوب", "True")));
                    }
                    else
                    {
                        cbolNazarKoli.Items.Add((new DnnComboBoxItem("بد", "False")));
                    }

                    rtgErtebatateOomoomi.Value = (decimal) result.Ertebatat;
                    rtgPardakhteDaghigVaBeMoghe.Value = (decimal) result.PardakhteDaghighVaBeMoghe;
                    rtgSehateEtelaateEstelam.Value = (decimal) result.SehateEtelaateEstelam;
                }

                // Todo:
            }
            else
            {
                using (
                    DataClassesDataContext context =
                        new DataClassesDataContext(Config.GetConnectionString()))
                {
                    int id = Convert.ToInt32(Request.QueryString["inquiryReplyToInquiry_Id"]);


                    lblSahebBar.Text = "نام صاحب بار : " +
                                       UserController.GetUserById(this.PortalId,
                                           _util.GetSahebUserByIRTI(id)).DisplayName;

                    cbolNazarKoli.Items.Add((new DnnComboBoxItem("-- انتخاب نماييد --", "-1")));
                    cbolNazarKoli.Items.Add((new DnnComboBoxItem("خوب", "True")));
                    cbolNazarKoli.Items.Add((new DnnComboBoxItem("بد", "False")));

                    cbolNazarKoli.SelectedValue = "-1";
                    cbolNazarKoli.Items[0].Enabled = false;
                }
            }
        }
    }
}