using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Web.UI.WebControls;


namespace MyDnn_EHaml.MyDnn_EHaml_Inquiries
{
    public partial class Inquiry_ChandVajhiSabok : PortalModuleBase
    {
        private void lnkSub_Click(object sender, EventArgs e)
        {
            Session["FinalReturnTabId"] = "tabid=" + this.TabId;
            Response.Redirect("/default.aspx?tabid=" +
                              PortalController.GetPortalSettingAsInteger("SubscriptionTabId", PortalId, -1) + "&type=1");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            dtpActionDate.MinDate = DateTime.Today.Date;
            dtpExpiredate.MinDate = DateTime.Today.Date;
            if (!Page.IsPostBack)
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
                FillPageControl();
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += lnkSubmit_Click;
            lnkTasviye.Click += lnkSub_Click;
            lnkTasviyeS.Click += lnkSub_Click;
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
            pnlMessageForNotApproved.Visible = false;
            pnlMessageForNotApprovedAfterErsal.Visible = true;
        }

        private string CreateLoadType()
        {
            bool isDanger = false;
            string loadTypeResult = string.Empty;
            foreach (DnnComboBoxItem loadType in cbolLoadType.Items)
            {
                if (loadType.Checked)
                {
                    if (loadType.Value == "کالای خطرناک (IMDG)")
                    {
                        isDanger = true;
                    }
                    loadTypeResult += loadType.Value + ", ";
                }
            }

            if (isDanger)
            {
                loadTypeResult += "|||";
                int i = 0;
                foreach (DnnComboBoxItem dangerTypeItem in cbolDangerLoadCodes.Items)
                {
                    if (dangerTypeItem.Checked)
                    {
                        i++;
                        loadTypeResult += dangerTypeItem.Value + ", ";
                    }
                }

                if (i == 0)
                {
                    return "Error";
                }
            }

            return loadTypeResult;
        }

        private void lnkSubmit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }
            Util util = new Util();
            string userStatus = util.IsUserOk(this.UserId, 1);
            if ((userStatus != "OK"))
            {
                util.MakeThisUserOk(this.UserId, userStatus, this.TabId.ToString(), 1);
            }
            else
            {
                using (
                    DataClassesDataContext context = new
                        DataClassesDataContext(Config.GetConnectionString()))
                {
                    MyDnn_EHaml_Inquiry_ChandVajhiSabok inquiryChandVajhiSabok =
                        new MyDnn_EHaml_Inquiry_ChandVajhiSabok();

                    var packingtype = cbolPackingType.Items.Where(i => i.Checked == true).Select(j => j.Value);
                    foreach (string s in packingtype)
                    {
                        inquiryChandVajhiSabok.PackingType += s + ",";
                    }
                    inquiryChandVajhiSabok.HSCode = txtCodeHSMahmoole.Text;
                    inquiryChandVajhiSabok.IsAkhseTarkhisiyeDarMagsad = chkIsBaEhtesabeTarkhisiyeDarMagsad.Checked;
                    inquiryChandVajhiSabok.IsBargiriDarMabda = chkIsBargiriDarMabda.Checked;
                    inquiryChandVajhiSabok.IsBime = chkIsBaEhtesabeBimeDarTooleMasir.Checked;
                    inquiryChandVajhiSabok.IsHazineyeOdat = chkIsOdateContinereKhali.Checked;
                    inquiryChandVajhiSabok.IsHazineyeTarkhisDarMabda = chkIsBaEhtesabeAkhseTarkhisDarMabda.Checked;
                    inquiryChandVajhiSabok.IsHazineyeTarkhisDarMagsad = chkIsBaEhtesabeHazineyeTarkhisDarMagsad.Checked;
                    inquiryChandVajhiSabok.IsKhahaneErsaleEstelamBeKharej = chkKhahaneErsalEstelamBeKharej.Checked;
                    inquiryChandVajhiSabok.TahvilBarAsaseAdl = chkIsTahvilBarAsaseListAdl.Checked;
                    inquiryChandVajhiSabok.TahvilBarAsaseNoVatedadeContiner =
                        chkIsTahvilBarAsaseNoVaTedadeContiner.Checked;
                    inquiryChandVajhiSabok.NoVaTedadVaJoziyatContiner = CreateNameVaTedadVaZojiyateContiner();
                    inquiryChandVajhiSabok.IsStrip = chkIsStrip.Checked;
                    inquiryChandVajhiSabok.IsKoleHazinehayeBandari = chkIsBaEhtesabeHazinehayeBandariVaGeyre.Checked;
                    inquiryChandVajhiSabok.IsTHCDarMabda = chkIsBaEhtesabeTHCDarMabda.Checked;
                    inquiryChandVajhiSabok.IsTHCDarMagsad = chkIsBaEhtesabeTHCDarMagsad.Checked;
                    inquiryChandVajhiSabok.IsTakhliyeDarMagsad = chkIsEmptying.Checked;

                    if (chkIsBaEhtesabeBimeDarTooleMasir.Checked)
                    {
                        if (fupFormeArzeshBarAsaseListeAdlBandiFull.HasFile)
                        {
                            inquiryChandVajhiSabok.FileVooroodeArzeshBarAsaseListeAdlBandi =
                                UploadFileVooroodeArzeshBarAsaseListeAdlBandi(fupFormeArzeshBarAsaseListeAdlBandiFull);
                        }
                        else
                        {
                            //pnlErrorMessageGeneral.Visible = true;
                            //lblErrorMessageGeneral.InnerHtml =
                            //    "کاربر گرامی وارد نمودن تعداد وسیله حمل انتخابی الزامیست.<br>لطفآ فرم استعلام را دوباره و با دقت بیشتری پر نمایید.";
                            return;
                        }
                    }

                    //if (fupFormeListeAdlBandiFull.HasFile)
                    //{
                    //    inquiryChandVajhiSabok.FilelisteAdlBandi = UploadFormFileAdlBandi(fupFormeListeAdlBandiFull);
                    //}


                    string loadType = CreateLoadType();
                    if (loadType == "Error")
                    {
                        pnlMustSelectDangerLoadType.Visible = true;
                        return;
                    }

                    context.MyDnn_EHaml_Inquiry_ChandVajhiSaboks.InsertOnSubmit(inquiryChandVajhiSabok);
                    context.SubmitChanges();

                    MyDnn_EHaml_Inquiry inquiry = new MyDnn_EHaml_Inquiry()
                    {
                        CreateDate = DateTime.Now,
                        ActionDate = dtpActionDate.SelectedDate,
                        ExpireDate = dtpExpiredate.SelectedDate,
                        StartingPoint = "ایران:تهران",
                        Destination = "انگلیس:پاریس",
                        IsReallyNeed = bool.Parse(cbolIsReallyNeed.SelectedItem.Value),
                        LoadType = CreateLoadType(),
                        InquiryType = "ChandVajhiSabok",
                        IsTender = chkIsTender.Checked,
                    };


                    inquiry.MyDnn_EHaml_User_Id = (context.MyDnn_EHaml_Users.Where
                        (i => i.PortalUserId == this.UserId)
                        .Select(i => i.Id)).Single();

                    inquiry.InquiryDetail_Id = inquiryChandVajhiSabok.Id;
                    context.MyDnn_EHaml_Inquiries.InsertOnSubmit(inquiry);
                    context.SubmitChanges();


                    // BarrasiShavad
                    Response.Redirect("/Activity-Feed.aspx");
                }
            }
        }

        private void FillRptNoeContiner()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                List<NoeContiner> noeContiners = (from i in context.MyDnn_EHaml_NoeContiners
                    select new NoeContiner() {ContinerName = i.NoeContiner}).ToList();

                rptNoeContiner.DataSource = noeContiners;
                rptNoeContiner.DataBind();
            }
        }

        private string UploadFileVooroodeArzeshBarAsaseListeAdlBandi(FileUpload uploadedFile)
        {
            string guid = Guid.NewGuid().ToString();
            string filePath = PortalSettings.HomeDirectoryMapPath + @"/EHaml/Uploads/";
            //string now = DateTime.Now.ToShortDateString().Replace('\\', '_');
            string fileName = "ChandVajhiSabok_GeymatBarAsaseAdlBandi_UId(" + this.UserId + ")_" + guid.Substring(0, 8) +
                              ".xlsx";

            if (!File.Exists(filePath + fileName))
            {
                uploadedFile.SaveAs(filePath + fileName);
            }

            string filePath2 = PortalSettings.HomeDirectory + @"/EHaml/Uploads/";
            //string now = DateTime.Now.ToShortDateString().Replace('\\', '_');
            string fileName2 = "ChandVajhiSabok_GeymatBarAsaseAdlBandi_UId(" + this.UserId + ")_" + guid.Substring(0, 8) +
                               ".xlsx";

            return filePath2 + fileName2;
        }

        private string UploadFormFileAdlBandi(FileUpload uploadedFile)
        {
            string guid = Guid.NewGuid().ToString();
            string filePath = PortalSettings.HomeDirectoryMapPath + @"/EHaml/Uploads/";
            //string now = DateTime.Now.ToShortDateString().Replace('\\', '_');
            string fileName = "ChandVajhiSabok_AdlBandi_UId(" + this.UserId + ")_" + guid.Substring(0, 8) +
                              ".xlsx";

            if (!File.Exists(filePath + fileName))
            {
                uploadedFile.SaveAs(filePath + fileName);
            }

            string filePath2 = PortalSettings.HomeDirectory + @"/EHaml/Uploads/";
            //string now = DateTime.Now.ToShortDateString().Replace('\\', '_');
            string fileName2 = "ChandVajhiSabok_AdlBandi_UId(" + this.UserId + ")_" + guid.Substring(0, 8) +
                               ".xlsx";

            return filePath2 + fileName2;
        }

        private string CreateNameVaTedadVaZojiyateContiner()
        {
            string result = string.Empty;
            foreach (RepeaterItem repeaterItem in rptNoeContiner.Items)
            {
                var vazneNakhales = repeaterItem.FindControl("txtVazneNakhales") as TextBox;
                if (vazneNakhales != null && vazneNakhales.Text != string.Empty)
                {
                    var tedad = repeaterItem.FindControl("txtTedad") as TextBox;
                    var noeMalekiyat = repeaterItem.FindControl("cbolNoeMalekiyat") as DnnComboBox;
                    result += vazneNakhales.ToolTip + ":{(" + vazneNakhales.Text + ")(" + tedad.Text + ")" +
                              "(" + noeMalekiyat.SelectedItem.Value + ")}|";
                }
            }
            return result;
        }

        private void FillPageControl()
        {
            //lblDarkhastKonandeValue.Text = this.UserInfo.DisplayName;
            FillCbolIsReallyNeed();
            FillCbolLoadType();
            FillcbolDangerLoadCodes();
            FillCbolPackingType();
            FillRptNoeContiner();
        }


        private void FillCbolPackingType()
        {
            cbolPackingType.Items.Add(new DnnComboBoxItem("-- انتخاب نماييد --", "-1"));
            cbolPackingType.Items.Add(new DnnComboBoxItem("قابل بارچینی روی هم", "قابل بارچینی روی هم"));
            cbolPackingType.Items.Add(new DnnComboBoxItem("قابل چرخاندن در جهت های مختلف",
                "قابل چرخاندن در جهت های مختلف"));
            cbolPackingType.Items.Add(new DnnComboBoxItem("بسته بندی ضد آب",
                "بسته بندی ضد آب"));
            cbolPackingType.SelectedValue = "-1";
            cbolPackingType.Items[0].Enabled = false;
        }

        private void FillcbolDangerLoadCodes()
        {
            
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem("1. مواد  منفجره", "مواد  منفجره"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(" 1.1. مواد دارای جرم قابل انفجار",
                "مواد  دارای جرم قابل انفجار"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(" 1.2. مواد دارای تصاعدات خطرناک قابل انفجار",
                "مواد دارای تصاعدات خطرناک قابل انفجار"));
            cbolDangerLoadCodes.Items.Add(
                new DnnComboBoxItem(
                    " 1.3. مواد دارای خطر آتش گرفتن با خطر ترکیدن و تصاعدات خطرناک کم و بدون جرم قابل انفجار",
                    "(خ) مواد دارای خطر آتش گرفتن با خطر ترکیدن و تصاعدات خطرناک کم و بدون جرم قابل انفجار"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(" 1.4. مواد منفجره غیر خطرناک در حال حاضر",
                "(خ) مواد منفجره غیر خطرناک در حال حاضر"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(" 1.5. مواد منفجره غیر حساس و دارای جرم قابل انفجار",
                "(خ) مواد منفجره غیر حساس و دارای جرم قابل انفجار"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(" 1.6. مواد منفجره خیلی غیرحساس و فاقد جرم قابل انفجار",
                "(خ) مواد منفجره خیلی غیرحساس و فاقد جرم قابل انفجار"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem("2. گازها", "گازها"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(" 2.1. گازهای قابل اشتعال", "(خ) گازهای قابل اشتعال"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(" 2.2. گازهای غیر قابل اشتعال و غیر سمی",
                "(خ) گازهای غیر قابل اشتعال و غیر سمی"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(" 2.3. گازهای سمی", "(خ) گازهای سمی"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem("3. مایعات قابل اشتعال", "مایعات قابل اشتعال"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem("4. جامدات قابل اشتعال ", "جامدات قابل اشتعال "));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(" 4.1. مواد حساس واکنش پذیر و منفجر شونده",
                "(خ) مواد حساس واکنش پذیر و منفجر شونده"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(" 4.2. مواد قابل اشتعال به خودی",
                "(خ) مواد قابل اشتعال به خودی"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(
                " 4.3. موادی که در واکنش با آب گازهای اشتعال آور تولید می کنند",
                "(خ) موادی که در واکنش با آب گازهای اشتعال آور تولید می کنند"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem("5. اکسیدها و پراکسیدها", "اکسیدها و پراکسیدها"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(" 5.1. مواد اکسیدی", "(خ) مواد اکسیدی"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(" 5.2. مواد پراکسیدی", "(خ) مواد پراکسیدی"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem("6. مواد سمی و عفونت زا", ""));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(" 6.1. مواد سمی", "(خ) مواد سمی"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem(" 6.2. مواد عفونت زا", "(خ) مواد عفونت زا"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem("7. مواد رادیواکتیو", "(خ) مواد رادیواکتیو"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem("8. مواد خورنده", "(خ) مواد خورنده"));
            cbolDangerLoadCodes.Items.Add(new DnnComboBoxItem("9. سایر مواد خطرناک", "(خ) سایر مواد خطرناک"));

            
            

            cbolDangerLoadCodes.Items[0].ForeColor = Color.Coral;
            cbolDangerLoadCodes.Items[0].Enabled = false;

            cbolDangerLoadCodes.Items[7].ForeColor = Color.Coral;
            cbolDangerLoadCodes.Items[7].Enabled = false;

            cbolDangerLoadCodes.Items[11].ForeColor = Color.Coral;


            cbolDangerLoadCodes.Items[12].ForeColor = Color.Coral;
            cbolDangerLoadCodes.Items[12].Enabled = false;

            cbolDangerLoadCodes.Items[16].ForeColor = Color.Coral;
            cbolDangerLoadCodes.Items[16].Enabled = false;

            cbolDangerLoadCodes.Items[19].ForeColor = Color.Coral;
            cbolDangerLoadCodes.Items[19].Enabled = false;

            cbolDangerLoadCodes.Items[22].ForeColor = Color.Coral;


            cbolDangerLoadCodes.Items[23].ForeColor = Color.Coral;


            cbolDangerLoadCodes.Items[24].ForeColor = Color.Coral;
        }

        private void FillCbolLoadType()
        {
            
            cbolLoadType.Items.Add(new DnnComboBoxItem("ماشین آلات", "ماشین آلات"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("لوله", "لوله"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("وسیله نقلیه", "وسیله نقلیه"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("پاکت یا جامبو", "پاکت یا جامبو"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("بشکه", "بشکه"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("پالت", "پالت"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("جنرال کارگو", "جنرال کارگو"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("کالای خطرناک (IMDG)", "کالای خطرناک (IMDG)"));

            
            
        }

        private void FillCbolIsReallyNeed()
        {
            
            cbolIsReallyNeed.Items.Add(new DnnComboBoxItem("صرفآ برای اطلاع از قیمت استعلام می کنم", "false"));
            cbolIsReallyNeed.Items.Add(new DnnComboBoxItem("صرفا برای اطلاع از قیمت نیست و نیاز به این خدمات دارم",
                "true"));

            
            
        }
    }
}