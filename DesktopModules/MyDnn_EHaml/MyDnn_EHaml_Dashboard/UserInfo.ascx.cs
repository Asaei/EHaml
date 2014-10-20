using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Profile;
using DotNetNuke.Entities.Users;


namespace MyDnn_EHaml.MyDnn_EHaml_Dashboard
{
    public partial class MyDnn_EHaml_UserInfo : PortalModuleBase
    {
        private Util _util = new Util();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["ERTEID"] != null)
                {
                    string ERTEID = string.Empty;
                    string typeela = string.Empty;

                    ERTEID = Request.QueryString["ERTEID"].ToString();
                    int type = Convert.ToInt32(Request.QueryString["Type"].ToString());

                    FillPageControll2(ERTEID, type);
                }
                else
                {
                    string irti = Request.QueryString["IRTIId"].ToString();
                    int type = Convert.ToInt32(Request.QueryString["Type"].ToString());
                    FillPageControll(irti, type);
                }
            }
        }

        private void FillPageControll2(string erteid, int type)
        {
            DotNetNuke.Entities.Users.UserInfo universal = new UserInfo();


            if (erteid != null)
            {
                int erteId = Convert.ToInt32(erteid);

                using (
                    DataClassesDataContext context =
                        new DataClassesDataContext(Config.GetConnectionString()))
                {
                    string typeela = (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                        where i.Id == erteId
                        select i.ElamiyeType).Single();

                    if (type == 1)
                    {
                    }
                    else if (type == 0)
                    {
                        if (typeela.Contains("Jadei"))
                        {
                            int sahebId = (int) (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                                join j in context.MyDnn_EHaml_ReplyToElamiye_KhaliJadeis on i.ReplyToElamiyeId equals
                                    j.Id
                                join k in context.MyDnn_EHaml_Users on j.MyDnn_EHaml_User_Id equals k.Id
                                where i.Id == erteId
                                select k.PortalUserId).Single();

                            universal = UserController.GetUserById(this.PortalId, sahebId);
                        }
                        if (typeela.Contains("Daryayi"))
                        {
                            int sahebId = (int) (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                                join j in context.MyDnn_EHaml_ReplyToElamiye_KhaliDaryayis on i.ReplyToElamiyeId equals
                                    j.Id
                                join k in context.MyDnn_EHaml_Users on j.MyDnn_EHaml_User_Id equals k.Id
                                where i.Id == erteId
                                select k.PortalUserId).Single();

                            universal = UserController.GetUserById(this.PortalId, sahebId);
                        }
                        if (typeela.Contains("Reyli"))
                        {
                            int sahebId = (int) (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                                join j in context.MyDnn_EHaml_ReplyToElamiye_KhaliReylis on i.ReplyToElamiyeId equals
                                    j.Id
                                join k in context.MyDnn_EHaml_Users on j.MyDnn_EHaml_User_Id equals k.Id
                                where i.Id == erteId
                                select k.PortalUserId).Single();

                            universal = UserController.GetUserById(this.PortalId, sahebId);
                        }

                        FillUserInfoPaneleSaheb(universal.UserID);
                    }
                    if (Request.QueryString["Info"] != null && Request.QueryString["Info"] == "M")
                    {
                        pnlUserInfo.Visible = false;
                    }
                    else
                    {
                        txtName.Text = universal.DisplayName;
                        txtNameSherkat.Text = universal.Profile.GetPropertyValue("Company");
                        txtTell.Text = universal.Profile.GetPropertyValue("Telephone");
                        txtCell.Text = universal.Profile.GetPropertyValue("Cell");
                        txtAddress.Text = universal.Profile.GetPropertyValue("Address");
                        txtEmail.Text = universal.Email;
                    }
                }
            }
        }

        private void FillPageControll(string irti, int type)
        {
            int irtiId = Convert.ToInt32(irti);


            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                //                var IRTI = (from i in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                //                    where i.Id == irtiId
                //                    select i).Single();

                UserInfo userInfo = new UserInfo();
                if (type == 1)
                {
                    userInfo = UserController.GetUserById(this.PortalId, _util.GetSahebUserByIRTI(irtiId));


                    FillUserInfoPaneleSaheb(userInfo.UserID);
                }
                else if (type == 0)
                {
                    userInfo = UserController.GetUserById(this.PortalId,
                        _util.GetServantUserByInquiryReplyToInquiryId(irtiId));

                    FillUserInfoPaneleKhedmat(userInfo.UserID);
                }
                if (Request.QueryString["Info"] != null && Request.QueryString["Info"] == "M")
                {
                    pnlUserInfo.Visible = false;
                }
                else
                {
                    txtName.Text = userInfo.DisplayName;
                    txtNameSherkat.Text = userInfo.Profile.GetPropertyValue("Company");
                    txtTell.Text = userInfo.Profile.GetPropertyValue("Telephone");
                    txtCell.Text = userInfo.Profile.GetPropertyValue("Cell");
                    txtAddress.Text = userInfo.Profile.GetPropertyValue("Address");
                    txtEmail.Text = userInfo.Email;
                }
            }
        }

        private void FillUserInfoPaneleKhedmat(int p)
        {
            int eUserId = _util.GetUserEHamlUserIdByPortalId(p);
            txtGodratKh.Text = _util.GetUserPower(eUserId).ToString();
            txtNazareKoliKh.Text = _util.GetNazareKoliKhoobSahebBeKhadamat(eUserId).ToString();
            txtlblNazareKoliBadKh.Text = _util.GetNazareKoliBadSahebBeKhadamat(eUserId).ToString();
            rtgErtebatateOomoomiKh.Value = _util.GetErtebatateOomoomiKh(eUserId);
            rtgDeghatDarAnjameMasooliyatha.Value = _util.GetDeghatDarAnjameMasooliyatha(eUserId);
            rtgPaybandiBeGofteha.Value = _util.GetPaybandiBeGofteha(eUserId);
            rtgPaybandiBeTaahodeZamani.Value = _util.GetPaybandiBeTaahodeZamani(eUserId);
            rtgPaybandiBeTaahodeGeymati.Value = _util.GetPaybandiBeTaahodeGeymati(eUserId);

            txtTedadeNazarat.Text = _util.GetTedadeMajmooeNazaratGerefteBeOnvaneKhedmatresan(eUserId).ToString();
            pnlNazarSanjiKhedmatDetail.Visible = true;
        }

        private void FillUserInfoPaneleSaheb(int p)
        {
            int eUserId = _util.GetUserEHamlUserIdByPortalId(p);
            txtGodrat.Text = _util.GetUserPower(eUserId).ToString();
            txtNazarKoliKhob.Text = _util.GetNazareKoliKhoobKhadamatBeSaheb(eUserId).ToString();
            txtNazareKoliBad.Text = _util.GetNazareKoliBadKhadamatBeSaheb(eUserId).ToString();
            rtgErtebatateOomoomi.Value = Convert.ToDecimal(_util.GetErtebateOomoomi(eUserId));
            rtgPardakhteDaghigVaBeMoghe.Value = Convert.ToDecimal(_util.GetPardakhteDaghigVaBeMoghe(eUserId));
            rtgSehateEtelaateEstelam.Value = Convert.ToDecimal(_util.GetSehateEtelaateEstelam(eUserId));

            txtTedadeNazarat.Text = _util.GetTedadeMajmooeNazaratGerefteBeOnvaneSaheb(eUserId).ToString();
            pnlNazarSanjiSahebDetail.Visible = true;
        }
    }
}