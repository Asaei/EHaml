using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Users;
using DotNetNuke.Web.UI.WebControls;
using Microsoft.VisualBasic;
using MyDnn_EHaml.Services;
using Telerik.Web.UI;
using System.Media;

namespace MyDnn_EHaml.MyDnn_EHaml_Settings
{
    public partial class Settings : PortalModuleBase
    {
        private Util _util = new Util();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                FillPageControlls();
            }
        }


        protected void Page_Init(object sender, EventArgs e)
        {
            lnkUpdate.Click += lnkUpdate_Click;
            btnUserBanks.Click += btnUserBank_Click;
            cbolKeshvarList.SelectedIndexChanged += cbolKeshvarList_SelectedIndexChanged;
            lnkUpdateShahrs.Click += lnkUpdateShahrs_Click;
        }

        private void lnkUpdateShahrs_Click(object sender, EventArgs e)
        {
            if (cbolKeshvarList.SelectedItem.Text != "-- انتخاب نمایید --")
            {
                if (!string.IsNullOrEmpty(txtListeShahrha.Text) && !string.IsNullOrWhiteSpace(txtListeShahrha.Text))
                {
                    string alreadyShahrList = GetKeshvarShahrList(cbolKeshvarList.SelectedItem.Value);

                    char[] spliters = {','};
                    List<string> shahrs = new List<string>(txtListeShahrha.Text.Split(spliters));
                    string newShahrList = txtListeShahrha.Text;
                    using (DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
                    {
                        int keshvarId = (from i in context.Lists
                            where i.ListName == "Country"
                                  && i.Text == cbolKeshvarList.SelectedItem.Value
                            select i.EntryID).Single();

                        List<List> lists = new List<List>();


                        shahrs.RemoveAll(alreadyShahrList.Contains);

                        foreach (string shahr in shahrs)
                        {
                            string value = shahr.Trim();

                            List list = new List
                            {
                                CreatedByUserID = this.UserId,
                                ParentID = keshvarId,
                                ListName = "City",
                                Text = value,
                                Value = value,
                                Level = 0,
                                SortOrder = 0,
                                DefinitionID = -1,
                                Description = null,
                                PortalID = -1,
                                SystemList = false,
                                CreatedOnDate = DateAndTime.Now,
                                LastModifiedByUserID = this.UserId,
                                LastModifiedOnDate = DateAndTime.Now
                            };

                            lists.Add(list);
                        }

                        context.Lists.InsertAllOnSubmit(lists);
                        context.SubmitChanges();

                        List<string> vakeshiShodeha = new List<string>(alreadyShahrList.Split(spliters));

                        vakeshiShodeha.RemoveAll(newShahrList.Contains);
                        List<List> pakshodeHa = new List<List>();

                        foreach (string shahrHayePakShode in vakeshiShodeha)
                        {
                            var sharh = (from i in context.Lists
                                where i.Text == shahrHayePakShode.Trim() && i.ParentID == keshvarId
                                select i).Single();
                            pakshodeHa.Add(sharh);
                        }

                        if (pakshodeHa.Count > 0)
                        {
                            context.Lists.DeleteAllOnSubmit(pakshodeHa);
                            context.SubmitChanges();
                        }
                    }
                }
            }
        }

        private void cbolKeshvarList_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as DnnComboBox).SelectedItem.Text == "-- انتخاب نمایید --")
            {
                txtListeShahrha.Text = "";
            }
            else
            {
                FillTxtListeShahrha(cbolKeshvarList.SelectedItem.Value);
            }
        }

        private void FillTxtListeShahrha(string keshvarName)
        {
            List<ShahrListJft> shahrList = new List<ShahrListJft>();
            using (DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var countryValue = (from j in context.Lists
                    where j.ListName == "Country"
                          && j.Text == keshvarName
                    select j.EntryID).Single();

                shahrList = (from i in context.Lists
                    where i.ListName == "City" && i.ParentID == countryValue
                    select new ShahrListJft() {Shahr = i.Text}).Distinct().ToList();

                string shahrs = string.Empty;
                foreach (var shahr in shahrList)
                {
                    shahrs += shahr.Shahr + " , ";
                }

                txtListeShahrha.Text = shahrs;
            }
        }

        public string GetKeshvarShahrList(string keshvarName)
        {
            List<ShahrListJft> shahrList = new List<ShahrListJft>();
            using (DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var countryValue = (from j in context.Lists
                    where j.ListName == "Country"
                          && j.Text == keshvarName
                    select j.EntryID).Single();

                shahrList = (from i in context.Lists
                    where i.ListName == "City" && i.ParentID == countryValue
                    select new ShahrListJft() {Shahr = i.Text}).Distinct().ToList();

                string shahrs = string.Empty;
                foreach (var shahr in shahrList)
                {
                    shahrs += shahr.Shahr + " , ";
                }

                return shahrs;
            }
        }

        private void btnUserBank_Click(object sender, EventArgs e)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_BankTransactionDetail detail = new MyDnn_EHaml_BankTransactionDetail();
                detail.Status = 1;
                context.MyDnn_EHaml_BankTransactionDetails.InsertOnSubmit(detail);
                context.SubmitChanges();

                MyDnn_EHaml__Bank bank = new MyDnn_EHaml__Bank();
//                bank.Date = DateAndTime.Now;
                bank.Amount = Convert.ToInt32(txtMablag.Text);
                bank.Description = txtBabate.Text;
                bank.EHaml_User_Id = Convert.ToInt32(cbolUserNameList.SelectedItem.Value);
                bank.Approve = true;
                bank.Type = Convert.ToByte(cbolNoeAmaliyatBanki.SelectedItem.Value);
                bank.MyDnn_EHaml_BankTransactionDetail_Id = detail.Id;

                context.MyDnn_EHaml__Banks.InsertOnSubmit(bank);
                context.SubmitChanges();
            }
        }

        private void lnkUpdate_Click(object sender, EventArgs e)
        {
            if (fupLogoFile.HasFile)
            {
                UploadLogoFile(fupLogoFile);
            }
            _util.UpdateSettings(KendoTheme: cbolKendoThem.SelectedItem.Value,
                FontLabel: cbollableFontLable.SelectedItem.Value
                , LabelFontSize: txtLabelFontSize.Text, LabelFontColor: cpLabelBackground.SelectedColor,
                TextBoxFontSize: txtTextBoxFontSize.Text, TextBoxFontColor: cpTextBoxFontColor.SelectedColor,
                TextBoxBackgroundColor: cpTextBoxBackgroundColor.SelectedColor, TextBoxWidth: txtTextBoxWidth.Text
                , TextBoxHeight: txtTextBoxHeight.Text,
                NahveyeBarkhordBaBedehkarha: cbolNahveyeBarkhordBaBedehkari.SelectedItem.Value,
                NahveyeBarkhordBaBedehkarhaValue: txtNahveyeBarkhordBaBedehkarhaValue.Text,
                TedadeRoozBadAzAnjamKarBarayeNemayesheNazarsanji:
                    txtTedadeRoozBadAzAnjamKarBarayeNemayesheNazarsanji.Text,
                TedadeRoozBarayeNemayesheDarDashboardBadAzNemayesheNazarSanji:
                    txtTedadeRoozBarayeNemayesheDarDashboardBadAzNemayesheNazarSanji.Text,
                poorsantNameBValue: getPoorsantNameValue(),
                ShomareTerminal: txtShomareTerminal.Text,
                ShomarePazirande: txtShomarePazirande.Text,
                KelideEkhtesasi: txtKelideEktesasi.Text,
                AddressePazgashtAzBank: txtAddresseBazgashtAzBank.Text,
                txtOnvanePishnahad: txtOnvanePishnahad.Text,
                txtMatnePishnahad: txtMatnePishnahad.Text,
                txtOnvaneTaeidPishnahad: txtOnvaneTaeidPishnahad.Text,
                txtMatneTaeidPishnahad: txtMatneTaeidPishnahad.Text,
                txtOnvaneEMailLinkeTaeed: txtOnvaneEMailLinkeTaeed.Text,
                txtMatneEMailLinkeTaeed: txtMatneEMailLinkeTaeed.Text,
                txtMatnePishnahadSMS: txtMatnePishnahadSMS.Text,
                txtMatneTaeidPishnahadSMS: txtMatneTaeidPishnahadSMS.Text
                );
        }

        private NameValueCollection getPoorsantNameValue()
        {
            NameValueCollection collection = new NameValueCollection();

            foreach (RepeaterItem item in rptPoorsant.Items)
            {
                string InquiryType = ((item).FindControl("txtMegdarePoorsant") as TextBox).ToolTip;
                string DarsadePoorsant = ((item).FindControl("txtMegdarePoorsant") as TextBox).Text;

                collection.Add(InquiryType, DarsadePoorsant);
            }
            return collection;
        }

        private void UploadLogoFile(FileUpload fileUpload)
        {
            string filePath = PortalSettings.HomeDirectoryMapPath;
            //string now = DateTime.Now.ToShortDateString().Replace('\\', '_');
            string fileName = "Logo.png";

            if (File.Exists(filePath + fileName))
            {
                File.Delete(filePath + fileName);
            }
            fileUpload.SaveAs(filePath + fileName);
        }

        private void FillPageControlls()
        {
            FillCbolKendoThem();
            FillCbollableFontLable();
            txtLabelFontSize.Text = getCurrentLabelFontSize();
            cpLabelBackground.SelectedColor = getCurrentLabelFontColor();

            /////////////////////////////////////////////////////////////

            FillCbolTextBoxFontLable();
            cpTextBoxBackgroundColor.SelectedColor = getCurrentTextBoxBackgroundColor();
            cpTextBoxFontColor.SelectedColor = getCurrentTextBoxFontColor();
            txtTextBoxFontSize.Text = getCurrentTextBoxFontSize();
            txtTextBoxHeight.Text = getCurrentTextBoxHeight();
            txtTextBoxWidth.Text = getCurrentTextBoxWidth();

            /////////////////////////////////////////////////////////////

            FillCbolNahveyeBarkhordBaBedehkari();
            txtNahveyeBarkhordBaBedehkarhaValue.Text =
                getCurrentNahveyeBarkhordBabedehkaraValue(_util.getNahveyeBarkhordBaBedehkari());
            txtTedadeRoozBadAzAnjamKarBarayeNemayesheNazarsanji.Text =
                _util.GetTedadeRoozBadAzEtmamJahateNemayesheNazarSanji().ToString();
            txtTedadeRoozBarayeNemayesheDarDashboardBadAzNemayesheNazarSanji.Text =
                _util.GetTedadeRoozBarayeNemayeshDarListBadAzNemayesheNazarSanji();

            /////////////////////////////////////////////////////////////

            FillRptPoorsant();

            /////////////////////////////////////////////////////////////

            txtAddresseBazgashtAzBank.Text = _util.getCurrentAddresseBazgashtAzBank();
            txtKelideEktesasi.Text = _util.getCurrentKelideEkhtesasi();
            txtShomarePazirande.Text = _util.getCurrentShomarePazirande();
            txtShomareTerminal.Text = _util.getCurrentShomareTerminal();

            /////////////////////////////////////////////////////////////

            FillCbolUserNameList();

            /////////////////////////////////////////////////////////////

            txtOnvanePishnahad.Text = _util.CurrentTxtOnvanePishnahad();
            txtOnvaneTaeidPishnahad.Text = _util.CurrentTxtOnvaneTaeidPishnahad();
            txtMatnePishnahad.Text = _util.CurrentTxtMatnePishnahad();
            txtMatneTaeidPishnahad.Text = _util.CurrentTxtMatneTaeidPishnahad();

            ////////////////////////////////////////////////////////////

            txtOnvaneEMailLinkeTaeed.Text = _util.CurrentTxtOnvaneEMailLinkeTaeed();
            txtMatneEMailLinkeTaeed.Text = _util.CurrentTxtMatneEMailLinkeTaeed();

            ////////////////////////////////////////////////////////////

            txtMatnePishnahadSMS.Text = _util.CurrentTxtMatnePishnahadSMS();
            txtMatneTaeidPishnahadSMS.Text = _util.CurrentTxtMatneTaeidPishnahadSMS();

            ////////////////////////////////////////////////////////////

            FillCbolKeshvarList();
        }

        private void FillCbolKeshvarList()
        {
            using (DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                DotNetNuke.Common.Lists.ListController lc = new DotNetNuke.Common.Lists.ListController();
                var leCountries = lc.GetListEntryInfoItems("Country", "", base.PortalSettings.PortalId).ToList();

                cbolKeshvarList.DataValueField = "Value";
                cbolKeshvarList.DataTextField = "Text";
                var ostanList = (from i in leCountries
                    select new {Text = i.Text, Value = i.Text}).ToList();
                ostanList.RemoveAt(0);
                ostanList.RemoveAt(ostanList.Count - 1);

                cbolKeshvarList.Items.Add(new RadComboBoxItem("-- انتخاب نمایید --"));
                foreach (var item in ostanList.Distinct())
                {
                    cbolKeshvarList.Items.Add(new RadComboBoxItem(item.Text, item.Value));
                }
            }
        }

        private void FillCbolUserNameList()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var list2 = UserController.GetUsers(this.PortalId);


                foreach (UserInfo userInfo in list2)
                {
                    cbolUserNameList.Items.Add(new RadComboBoxItem(userInfo.DisplayName, userInfo.UserID.ToString()));
                }
            }
        }

        private void FillRptPoorsant()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                rptPoorsant.DataSource = (from i in context.MyDnn_EHaml_DarsadePoorsants
                    select new {Name = i.InquiryType, Megdar = i.DarsadePoorsant}).ToList();
                rptPoorsant.DataBind();
            }
        }

        private string getCurrentNahveyeBarkhordBabedehkaraValue(string NahveyeBarkhordBaBedehkari)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                if (NahveyeBarkhordBaBedehkari == "TedadeAmaliyat")
                {
                    return (from i in context.MyDnn_EHaml_GeneralSettings
                        where i.SettingName == "TedadAmaliyateBadAzAvalinBedehkari"
                        select i.SettingValue).Single();
                }
                else
                {
                    return (from i in context.MyDnn_EHaml_GeneralSettings
                        where i.SettingName == "TedadRoozBadAzAvalinBedehkari"
                        select i.SettingValue).Single();
                }
            }
        }

        private void FillCbolNahveyeBarkhordBaBedehkari()
        {
            cbolNahveyeBarkhordBaBedehkari.Items.Add(new RadComboBoxItem("تعداد عملیات", "TedadeAmaliyat"));
            cbolNahveyeBarkhordBaBedehkari.Items.Add(new RadComboBoxItem("تعداد روز", "TedadeRooz"));

            cbolNahveyeBarkhordBaBedehkari.SelectedValue = _util.getNahveyeBarkhordBaBedehkari();
        }

        private string getCurrentTextBoxWidth()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "CurrentTextBoxWidth"
                    select i.SettingValue).Single();
            }
        }

        private string getCurrentTextBoxHeight()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "CurrentTextBoxHeight"
                    select i.SettingValue).Single();
            }
        }

        private string getCurrentTextBoxFontSize()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "CurrentTextBoxFontSize"
                    select i.SettingValue).Single();
            }
        }

        private Color getCurrentTextBoxFontColor()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                System.Drawing.Color color = ColorTranslator.FromHtml((from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "CurrentTextBoxFontColor"
                    select i.SettingValue).Single());

                return color;
            }
        }

        private Color getCurrentTextBoxBackgroundColor()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                System.Drawing.Color color = ColorTranslator.FromHtml((from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "CurrentTextBoxBackgroundColor"
                    select i.SettingValue).Single());

                return color;
            }
        }

        private void FillCbolTextBoxFontLable()
        {
            cbolTextBoxFontLable.Items.Add(new RadComboBoxItem("tahoma", "tahoma"));
            cbolTextBoxFontLable.Items.Add(new RadComboBoxItem("arial", "arial"));
            cbolTextBoxFontLable.Items.Add(new RadComboBoxItem("", ""));
            cbolTextBoxFontLable.Items.Add(new RadComboBoxItem("", ""));
            cbolTextBoxFontLable.Items.Add(new RadComboBoxItem("", ""));
            cbolTextBoxFontLable.Items.Add(new RadComboBoxItem("", ""));
            cbolTextBoxFontLable.Items.Add(new RadComboBoxItem("", ""));

            cbolTextBoxFontLable.SelectedValue = _util.getCurrentTextBoxFontName();
        }


        private Color getCurrentLabelFontColor()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                System.Drawing.Color color = ColorTranslator.FromHtml((from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "CureentLableFontColor"
                    select i.SettingValue).Single());

                return color;
            }
        }

        private string getCurrentLabelFontSize()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                return (from i in context.MyDnn_EHaml_GeneralSettings
                    where i.SettingName == "CurrentLabelFontSize"
                    select i.SettingValue).Single();
            }
        }

        private void FillCbollableFontLable()
        {
            cbollableFontLable.Items.Add(new RadComboBoxItem("tahoma", "tahoma"));
            cbollableFontLable.Items.Add(new RadComboBoxItem("arial", "arial"));
            cbollableFontLable.Items.Add(new RadComboBoxItem("", ""));
            cbollableFontLable.Items.Add(new RadComboBoxItem("", ""));
            cbollableFontLable.Items.Add(new RadComboBoxItem("", ""));
            cbollableFontLable.Items.Add(new RadComboBoxItem("", ""));
            cbollableFontLable.Items.Add(new RadComboBoxItem("", ""));

            cbollableFontLable.SelectedValue = _util.getCurrentlabelFontName();
        }

        private void FillCbolKendoThem()
        {
            cbolKendoThem.Items.Add(new RadComboBoxItem("Default", "kendo.default.min.css"));
            cbolKendoThem.Items.Add(new RadComboBoxItem("metro", "kendo.metro.min.css"));
            cbolKendoThem.Items.Add(new RadComboBoxItem("metroblack", "kendo.metroblack.min.css"));
            cbolKendoThem.Items.Add(new RadComboBoxItem("silver", "kendo.silver.min.css"));
            cbolKendoThem.Items.Add(new RadComboBoxItem("uniform", "kendo.uniform.min.css"));
            cbolKendoThem.Items.Add(new RadComboBoxItem("blueopal", "kendo.blueopal.min.css"));
            cbolKendoThem.Items.Add(new RadComboBoxItem("highcontrast", "kendo.highcontrast.min.css"));
            cbolKendoThem.Items.Add(new RadComboBoxItem("moonlight", "kendo.moonlight.min.css"));
            cbolKendoThem.Items.Add(new RadComboBoxItem("bootstrap", "kendo.bootstrap.min.css"));
            cbolKendoThem.Items.Add(new RadComboBoxItem("flat", "kendo.flat.min.css"));
            cbolKendoThem.Items.Add(new RadComboBoxItem("black", "kendo.black.min.css"));

            cbolKendoThem.SelectedValue = _util.getCurrentKendoTheme();
        }
    }
}