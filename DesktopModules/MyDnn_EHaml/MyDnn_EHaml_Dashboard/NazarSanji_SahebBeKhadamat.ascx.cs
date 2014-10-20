using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Users;
using DotNetNuke.UI.UserControls;
using DotNetNuke.Web.UI.WebControls;
using MyDnn_EHaml.MyDnn_EHaml_Inquiries;

namespace MyDnn_EHaml.MyDnn_EHaml_Dashboard
{
    public partial class NazarSanji_SahebBeKhadamat : PortalModuleBase
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
            if (Request.QueryString["inquiryReplyToInquiry_Id"] != null)
            {
                using (
                    DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
                {
                    int id = Convert.ToInt32(Request.QueryString["inquiryReplyToInquiry_Id"]);

                    MyDnn_EHaml_Inquiry_ReplyToInquiry inquiryReplyToInquiry =
                        (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            where i.Id == id
                            select i).Single();


                    MyDnn_EHaml_NazarSanji_SahebBeKhadamat sahebBeKhadamat =
                        new MyDnn_EHaml_NazarSanji_SahebBeKhadamat();

                    sahebBeKhadamat.NazareKoli = bool.Parse(cbolNazarKoli.SelectedItem.Value);
                    sahebBeKhadamat.PaybandiBeGofteha = (double?) Math.Round((decimal) rtgPaybandiBeGofteha.Value);
                    sahebBeKhadamat.PaybandiBeTaahodeGeymati =
                        (double?) Math.Round((decimal) rtgPaybandiBeTaahodeGeymati.Value);
                    sahebBeKhadamat.PaybandiBeTaahodeZamani =
                        (double?) Math.Round((decimal) rtgPaybandiBeTaahodeZamani.Value);
                    sahebBeKhadamat.DeghatDarAnjameMasooliyat =
                        (double?) Math.Round((decimal) rtgDeghatDarAnjameMasooliyatha.Value);
                    sahebBeKhadamat.Ertebatat = (double?) Math.Round((decimal) rtgErtebatateOomoomi.Value);

                    double quality =
                        (double) (((sahebBeKhadamat.PaybandiBeGofteha + sahebBeKhadamat.PaybandiBeTaahodeGeymati +
                                    sahebBeKhadamat.PaybandiBeTaahodeZamani + sahebBeKhadamat.DeghatDarAnjameMasooliyat +
                                    sahebBeKhadamat.Ertebatat))/5);

                    int tarafikeBeheshNazarMidamId =
                        _util.GetUserEHamlUserIdByPortalId(
                            _util.GetServantUserByInquiryReplyToInquiryId(inquiryReplyToInquiry.Id));

                    sahebBeKhadamat.Inquiry_Id = inquiryReplyToInquiry.InquiryId;
                    sahebBeKhadamat.ReplyToInquiry_Id = inquiryReplyToInquiry.ReplyToInquiryId;

                    context.MyDnn_EHaml_NazarSanji_SahebBeKhadamats.InsertOnSubmit(sahebBeKhadamat);
                    context.SubmitChanges();

                    if (
                        !context.MyDnn_EHaml_UserRanks.Any(
                            x =>
                                x.MyDnn_EHaml_User_Id == tarafikeBeheshNazarMidamId && x.Type == 0))
                    {
                        MyDnn_EHaml_UserRank userRank = new MyDnn_EHaml_UserRank();
                        userRank.MyDnn_EHaml_User_Id = tarafikeBeheshNazarMidamId;
                        userRank.Type = 0;
                        userRank.Quality = (double) Math.Round((decimal) quality);
                        context.MyDnn_EHaml_UserRanks.InsertOnSubmit(userRank);
                        context.SubmitChanges();
                    }
                    else
                    {
                        MyDnn_EHaml_UserRank userRank = (from i in context.MyDnn_EHaml_UserRanks
                            where i.MyDnn_EHaml_User_Id == tarafikeBeheshNazarMidamId && i.Type == 0
                            select i).Single();
                        userRank.Quality =
                            (double)
                                (Math.Round((decimal) (userRank.Quality + (double?) Math.Round((decimal) quality))))/2;
                        context.SubmitChanges();
                    }

                    int thisUserEHamlUserId = _util.GetUserEHamlUserIdByPortalId(this.UserId);

                    if (
                        !context.MyDnn_EHaml_UserRanks.Any(
                            x =>
                                x.MyDnn_EHaml_User_Id == thisUserEHamlUserId && x.Type == 1))
                    {
                        MyDnn_EHaml_UserRank userRank = new MyDnn_EHaml_UserRank();
                        userRank.MyDnn_EHaml_User_Id = thisUserEHamlUserId;
                        userRank.Power = 1;
                        userRank.Type = 1;
                        //userRank.Quality = (double?) Math.Round((decimal) quality, 1);
                        context.MyDnn_EHaml_UserRanks.InsertOnSubmit(userRank);
                        context.SubmitChanges();
                    }
                    else
                    {
                        MyDnn_EHaml_UserRank userRank = (from i in context.MyDnn_EHaml_UserRanks
                            where i.MyDnn_EHaml_User_Id == thisUserEHamlUserId && i.Type == 1
                            select i).Single();
                        userRank.Power += 1;
                        //userRank.Quality = (double?)Math.Round((decimal) (userRank.Quality + (double?)Math.Round((decimal)quality, 1)),1) / 2;
                        context.SubmitChanges();
                    }
                }
                lnkSubmit.Enabled = false;
            }
        }

        private void FillPageControlls()
        {
            int id = 0;
            MyDnn_EHaml_NazarSanji_SahebBeKhadamat result = new MyDnn_EHaml_NazarSanji_SahebBeKhadamat();
            if (Request.QueryString["inquiryReplyToInquiry_Id"] != null)
            {
                id = Convert.ToInt32(Request.QueryString["inquiryReplyToInquiry_Id"]);
                using (
                    DataClassesDataContext context =
                        new DataClassesDataContext(Config.GetConnectionString()))
                {
                    var irti = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        where i.Id == id
                        select i).Single();
                    result = (from i in context.MyDnn_EHaml_NazarSanji_SahebBeKhadamats
                        where i.Inquiry_Id == irti.InquiryId && i.ReplyToInquiry_Id == i.ReplyToInquiry_Id
                        select i).Single();
                }
            }
            else
            {
                id = Convert.ToInt32(Request.QueryString["ERTEID"]);
                using (DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
                {
                    var erte = (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                        where i.Id == id
                        select i).Single();
                    result = (from i in context.MyDnn_EHaml_NazarSanji_SahebBeKhadamats
                        where i.ERTEID == id
                        select i).Single();
                }
            }
            bool isView = Request.QueryString["IsView"] != null;
            if (isView)
            {
                using (
                    DataClassesDataContext context =
                        new DataClassesDataContext(Config.GetConnectionString()))
                {
                    lnkSubmit.Visible = false;
                    rtgErtebatateOomoomi.Enabled = false;
                    rtgDeghatDarAnjameMasooliyatha.Enabled = false;
                    rtgPaybandiBeGofteha.Enabled = false;
                    rtgPaybandiBeTaahodeGeymati.Enabled = false;
                    rtgPaybandiBeTaahodeZamani.Enabled = false;
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
                    rtgDeghatDarAnjameMasooliyatha.Value = (decimal) result.DeghatDarAnjameMasooliyat;
                    rtgPaybandiBeGofteha.Value = (decimal) result.PaybandiBeGofteha;
                    rtgPaybandiBeTaahodeGeymati.Value = (decimal) result.PaybandiBeTaahodeGeymati;
                    rtgPaybandiBeTaahodeZamani.Value = (decimal) result.PaybandiBeTaahodeZamani;
                }
            }
            else
            {
                int inquiryReplyToInquiry = Convert.ToInt32(Request.QueryString["inquiryReplyToInquiry_Id"]);
                lblKhadamatResan.Text =
                    UserController.GetUserById(this.PortalId,
                        _util.GetServantUserByInquiryReplyToInquiryId(inquiryReplyToInquiry)).DisplayName;

                cbolNazarKoli.Items.Add((new DnnComboBoxItem("-- انتخاب نماييد --", "-1")));
                cbolNazarKoli.Items.Add((new DnnComboBoxItem("خوب", "True")));
                cbolNazarKoli.Items.Add((new DnnComboBoxItem("بد", "False")));

                cbolNazarKoli.SelectedValue = "-1";
                cbolNazarKoli.Items[0].Enabled = false;
            }
        }
    }
}