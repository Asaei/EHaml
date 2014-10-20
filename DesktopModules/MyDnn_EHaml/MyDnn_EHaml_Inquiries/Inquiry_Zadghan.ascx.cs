using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Controls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Framework;
using DotNetNuke.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using Telerik.Web.UI;

namespace MyDnn_EHaml.MyDnn_EHaml_Inquiries.MyDnn_EHaml_Inquiry_Zadghan
{
    public partial class Inquiry_Zadghan : PortalModuleBase
    {
        private string inquiryId;

        #region Methods (2) 

        // Protected Methods (2) 

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += lnkSubmit_Click;
            lnkTasviye.Click += lnkSub_Click;
            lnkTasviyeS.Click += lnkSub_Click;
            btnErsaleLinkTaeid1.Click += btnErsaleLinkTaeid1_Click;
            lnkPrintKon.Click += lnkPrintKon_Click;
        }

        private void lnkPrintKon_Click(object sender, EventArgs e)
        {
            Response.Redirect("/default.aspx?tabid=" + this.TabId + "&mid=" + this.ModuleId +
                              "&ctl=ReplyToInquiry_Zadghan&InqId=" + hiddenFieldId.Value + "&popUp=true&IsPrint=Yes");
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

        private void lnkSub_Click(object sender, EventArgs e)
        {
            Session["FinalReturnTabId"] = "tabid=" + this.TabId;
            Response.Redirect("/default.aspx?tabid=" +
                              PortalController.GetPortalSettingAsInteger("SubscriptionTabId", PortalId, -1) + "&type=1");
        }

        private void lnkSubmit_Click(object sender, EventArgs e)
        {
            Util util = new Util();
            string message = util.IsValidateDates(dtpActionDate: dtpActionDate, dtpExpiredate: dtpExpireDate);
            bool vaziyate = (chkWithInsurance.Checked && !fupFormeVooroodeArzeshBarAsaseVasileyeHamlFull.HasFile);
            bool isReturn = false;

            if (vaziyate)
            {
                message +=
                    "<span>شما گزینه 'احتساب بیمه مسئولیت' را انتخاب نموده ید.لذا وارد کردن فایل 'فرم ورود ارزش محموله' الذامی میباشد.</span>";
                isReturn = true;
            }
            if (chkWithInsurance.Checked)
            {
                paneleVooroodeArzesheBar.Style["display"] = "block";
                isReturn = true;
            }
            string loadType2 = CreateLoadType();
            if (loadType2 == "Error")
            {
                panelekalayekhatarnak.Style["display"] = "block";
                message += "<span>مشخص کردن نوع کالای خطرناک الزامی میباشد.</span>";
                isReturn = true;
            }

            string NoVaTedadeVasileyeHaml2 = CreatNoVaTedadeVasileyeHaml();
            if (NoVaTedadeVasileyeHaml2 == "Error")
            {
                message += "<span>تمامی نوع وسیله های انتخاب شده میبایست دارای تعداد باشند.</span>";
                isReturn = true;
            }

            message += "<span>لطفآ فرم را دوباره و با دقت بیشتری تکمیل نمایید.</span>";
            message = message.Replace("OK", "");
            errorMessages.InnerHtml = message;

            if (isReturn)
            {
                errorMessages.Visible = true;
                return;
            }
            else
            {
                errorMessages.Visible = false;
            }

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
                    MyDnn_EHaml_Inquiry_ZadghanT zadghan = new MyDnn_EHaml_Inquiry_ZadghanT();

                    zadghan.EmptyingCharges = chkEmptyingCharges.Checked;
                    zadghan.WithInsurance = chkWithInsurance.Checked;

                    string NoVaTedadeVasileyeHaml = CreatNoVaTedadeVasileyeHaml();
                    if (NoVaTedadeVasileyeHaml != "Error")
                    {
                        zadghan.NoVaTedadeVasileyeHaml = CreatNoVaTedadeVasileyeHaml();
                    }
                    else
                    {
                        pnlErrorMessageGeneral.Visible = true;
                        lblErrorMessageGeneral.InnerHtml =
                            "کاربر گرامی وارد نمودن تعداد وسیله حمل انتخابی الزامیست.<br>لطفآ فرم استعلام را دوباره و با دقت بیشتری پر نمایید.";
                        return;
                    }


                    if (chkWithInsurance.Checked)
                    {
                        if (fupFormeVooroodeArzeshBarAsaseVasileyeHamlFull.HasFile)
                        {
                            zadghan.FileArzesheBar = UploadFormArzesheBar(fupFormeVooroodeArzeshBarAsaseVasileyeHamlFull);
                        }
                    }


                    string loadType = CreateLoadType();
                    //if (loadType == "Error")
                    //{
                    //    pnlMustSelectDangerLoadType.Visible = true;
                    //    return;
                    //}

                    context.MyDnn_EHaml_Inquiry_ZadghanTs.InsertOnSubmit(zadghan);
                    context.SubmitChanges();
                    MyDnn_EHaml_Inquiry inquiry = new MyDnn_EHaml_Inquiry()
                    {
                        CreateDate = DateTime.Now,
                        ActionDate = dtpActionDate.SelectedDate,
                        ExpireDate = dtpExpireDate.SelectedDate,
                        StartingPoint =
                            cbolStartingPointOstan.SelectedValue + ":" + cbolStartingPointShahr.SelectedValue,
                        Destination = cbolDestinationOstan.SelectedValue + ":" + cbolDestinationShahr.SelectedValue,
                        IsReallyNeed = bool.Parse(cbolIsReallyNeed.SelectedItem.Value),
                        LoadType = CreateLoadType(),
                        InquiryType = "Zadghan"
                    };

                    if (cbolIsReallyNeed.SelectedItem.Value == "true")
                    {
                        inquiry.IsTender = chkIsTender.Checked;
                    }

                    inquiry.MyDnn_EHaml_User_Id = (context.MyDnn_EHaml_Users.Where(i => i.PortalUserId == this.UserId)
                        .Select(i => i.Id)).Single();


                    inquiry.InquiryDetail_Id = zadghan.Id;
                    context.MyDnn_EHaml_Inquiries.InsertOnSubmit(inquiry);
                    context.SubmitChanges();

                    hiddenFieldId.Value = inquiry.Id.ToString();
                    messageAfterSubmit.Visible = true;
                    messageAfterSubmit.InnerHtml = "استعلام شما با موفقیت ثبت گردید.";
                    messageAfterSubmit.Attributes["class"] = "dnnFormMessage dnnFormSuccess";
                    lnkSubmit.Visible = false;
                    lnkPrintKon.Visible = true;
                }
            }
        }

        private string UploadFormArzesheBar(FileUpload uploadedFile)
        {
            string guid = Guid.NewGuid().ToString();
            string filePath = PortalSettings.HomeDirectoryMapPath + @"/EHaml/Uploads/";
            //string now = DateTime.Now.ToShortDateString().Replace('\\', '_');

            string fileName = "Zadghan_ArzesheBar_UId(" + this.UserId + ")_" + guid.Substring(0, 8) +
                              ".xlsx";

            if (!File.Exists(filePath + fileName))
            {
                uploadedFile.SaveAs(filePath + fileName);
            }


            string filePath2 = PortalSettings.HomeDirectory + @"/EHaml/Uploads/";
            //string now = DateTime.Now.ToShortDateString().Replace('\\', '_');
            string fileName2 = "Zadghan_ArzesheBar_UId(" + this.UserId + ")_" + guid.Substring(0, 8) +
                               ".xlsx";

            return filePath2 + fileName2;
        }

        private string CreatNoVaTedadeVasileyeHaml()
        {
            string noVaTedadeVasileyeHamlResult = string.Empty;
            foreach (RadComboBoxItem item in cbolNoeVasileyeHaml.Items)
            {
                if (item.Checked)
                {
                    string noeVasileyeHaml = (item.FindControl("lblVasileName") as Label).Text;
                    string tedadeVasileyeHaml = (item.FindControl("txtTedadeVasile") as TextBox).Text;

                    if (string.IsNullOrEmpty(tedadeVasileyeHaml) || string.IsNullOrWhiteSpace(tedadeVasileyeHaml) ||
                        tedadeVasileyeHaml == "تعداد...")
                    {
                        return "Error";
                    }

                    noVaTedadeVasileyeHamlResult += "[" + noeVasileyeHaml + " - " +
                                                    tedadeVasileyeHaml + " دستگاه], ";
                }
            }

            return noVaTedadeVasileyeHamlResult;
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

        protected void Page_Load(object sender, EventArgs e)
        {
            dtpActionDate.MinDate = DateTime.Today.Date;
            dtpExpireDate.MinDate = DateTime.Today.Date;
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
                            lnkSubmit.Enabled = false;
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
                else
                {
                    using (
                        DataClassesDataContext context =
                            new DataClassesDataContext(Config.GetConnectionString()))
                    {
                        cbolNoeVasileyeHaml.DataValueField = "VasileyeHamlName";
                        cbolNoeVasileyeHaml.DataTextField = "VasileyeHamlName";

                        var list = (from i in context.MyDnn_EHaml_NoeVasileyeHamls
                            select i).ToList();


                        cbolNoeVasileyeHaml.DataSource = list;

                        cbolNoeVasileyeHaml.DataBind();
                    }

                    FillPageControlls();
                }
            }
        }

        private void FillPageControlls()
        {
            //lblDarkhastKonandeValue.Text = UserInfo.DisplayName;
            FillCbolIsReallyNeed();
            FillCbolLoadType();
            FillcbolDangerLoadCodes();
            FillCbolStartingPointOstan();
            //FillCbolDestinationOstan();
        }

        //private void FillCbolDestinationOstan()
        //{
        //    using (
        //        DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        cbolStartingPointOstan.DataValueField = "Value";
        //        cbolStartingPointOstan.DataTextField = "Text";

        //        var ostanList = (from i in context.MyDnn_EHaml_OstanVaShahrs
        //            select new {Text = i.Ostan, Value = i.Ostan}).ToList();
        //        ostanList.RemoveAt(0);
        //        ostanList.RemoveAt(ostanList.Count - 1);

        //        
        //        foreach (var item in ostanList.Distinct())
        //        {
        //            cbolDestinationOstan.Items.Add(new RadComboBoxItem(item.Text, item.Value));
        //        }
        //    }
        //}

        private void FillCbolStartingPointOstan()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                cbolStartingPointOstan.DataValueField = "Value";
                cbolStartingPointOstan.DataTextField = "Text";

                var ostanList = (from i in context.MyDnn_EHaml_OstanVaShahrs
                    select new {Text = i.Ostan, Value = i.Ostan}).ToList();
                ostanList.RemoveAt(0);
                ostanList.RemoveAt(ostanList.Count - 1);


                foreach (var item in ostanList.Distinct())
                {
                    cbolStartingPointOstan.Items.Add(new RadComboBoxItem(item.Text, item.Value));
                }


                foreach (var item in ostanList.Distinct())
                {
                    cbolDestinationOstan.Items.Add(new RadComboBoxItem(item.Text, item.Value));
                }
            }
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

        #endregion Methods 
    }
}