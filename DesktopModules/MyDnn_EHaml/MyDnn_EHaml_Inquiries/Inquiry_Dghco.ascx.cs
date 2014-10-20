using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Controllers;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Web.UI.WebControls;
using Telerik.Web.UI;

namespace MyDnn_EHaml.MyDnn_EHaml_Inquiries
{
    public partial class Inquiry_Dghco : PortalModuleBase
    {
        private void lnkSub_Click(object sender, EventArgs e)
        {
            var httpRequest = new HttpRequest("", "http://localhost:100/", "");
            var stringWriter = new StringWriter();
            var httpResponce = new HttpResponse(stringWriter);
            var httpContext = new HttpContext(httpRequest, httpResponce);

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


                FillPageControlls();
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += LnkSubmitOnClick;
            lnkTasviye.Click += lnkSub_Click;
            lnkTasviyeS.Click += lnkSub_Click;
            btnErsaleLinkTaeid11.Click += btnErsaleLinkTaeid1_Click;
//            cbolStartingPointOstan.SelectedIndexChanged += cbolStartingPointOstan_SelectedIndexChanged;
//            cbolDestinationOstan.SelectedIndexChanged += cbolDestinationOstan_SelectedIndexChanged;
            lnkPrintKon.Click += lnkPrintKon_Click;
        }

        private void lnkPrintKon_Click(object sender, EventArgs e)
        {
            Response.Redirect("/default.aspx?tabid=" + this.TabId + "&mid=" + this.ModuleId +
                              "&ctl=ReplyToInquiry_Dghco&InqId=" + hiddenFieldId.Value + "&popUp=true&IsPrint=Yes");
        }

        private void cbolDestinationOstan_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string country = cbolDestinationOstan.SelectedItem.Value;


            using (DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var countryValue = (from j in context.Lists
                    where j.ListName == "Country"
                          && j.Text == country
                    select j.EntryID).Single();

                var list = (from i in context.Lists
                    where i.ListName == "City" && i.ParentID == countryValue
                    select new {Text = i.Text, Value = i.Text}).ToList();

                cbolDestinationShahr.DataTextField = "Text";
                cbolDestinationShahr.DataValueField = "Value";
                cbolDestinationShahr.DataSource = list;
                cbolDestinationShahr.DataBind();
            }
        }

        private void cbolStartingPointOstan_SelectedIndexChanged(object sender,
            RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string country = cbolStartingPointOstan.SelectedItem.Value;


            using (DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var countryValue = (from j in context.Lists
                    where j.ListName == "Country"
                          && j.Text == country
                    select j.EntryID).Single();

                var list = (from i in context.Lists
                    where i.ListName == "City" && i.ParentID == countryValue
                    select new {Text = i.Text, Value = i.Text}).ToList();

                cbolStartingPointShahr.DataTextField = "Text";
                cbolStartingPointShahr.DataValueField = "Value";
                cbolStartingPointShahr.DataSource = list;
                cbolStartingPointShahr.DataBind();
            }
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

        private void LnkSubmitOnClick(object sender, EventArgs eventArgs)
        {
            Util util = new Util();
            string message = util.IsValidateDates(dtpActionDate: dtpActionDate, dtpExpiredate: dtpExpiredate);


            bool isReturn = message != "OK";


            //string loadType2 = CreateLoadType();
            //if (loadType2 == "Error")
            //{
            //    panelekalayekhatarnak.Style["display"] = "block";
            //    message += "<span>مشخص کردن نوع کالای خطرناک الزامی میباشد.</span>";
            //    isReturn = true;
            //}



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
            if ((userStatus != "OK"))
            {
                util.MakeThisUserOk(this.UserId, userStatus, this.TabId.ToString(), 1);
            }
            else
            {
                using (
                    DataClassesDataContext context =
                        new DataClassesDataContext(Config.GetConnectionString()))
                {
                    MyDnn_EHaml__Inquiry_Dghco inquiryDghco = new MyDnn_EHaml__Inquiry_Dghco();

                    inquiryDghco.HSCode = txtCodeHSMahmoole.Text;
                    inquiryDghco.IsKhahaneErsaleEstelamBeKharej = chkKhahaneErsalEstelamBeKharej.Checked;
                    inquiryDghco.EmptyingCharges = chkIsBaEhtesabeAkhseTarkhisiye.Checked;
                    inquiryDghco.IsTarkhisiyeDarMagsad = chkIsBaEhtesabeAkhseTarkhisiye.Checked;
                    var packingtype = cbolPackingType.Items.Where(i => i.Checked == true).Select(j => j.Value);
                    foreach (string s in packingtype)
                    {
                        inquiryDghco.PackingType += s + ",";
                    }
                    inquiryDghco.IsKhahaneErsaleEstelamBeKharej = chkKhahaneErsalEstelamBeKharej.Checked;


                    if (fupFormeListeAdlBandiFull.HasFile)
                    {
                        inquiryDghco.FileListAdlBandi = UploadFormFileAdlBandi(fupFormeListeAdlBandiFull);
                    }

                    if (fupLoadImage.HasFile)
                    {
                        inquiryDghco.LoadImage = UploadLoadImage(fupLoadImage);
                    }

                    string loadType = CreateLoadType();
                    if (loadType == "Error")
                    {
                        pnlMustSelectDangerLoadType.Visible = true;
                        return;
                    }

                    inquiryDghco.IsBargiriRooyeKasshidarMabda = chkIsBaEhtesabeBargiriRooyeCashtiDarBandareMabda.Checked;
                    context.MyDnn_EHaml__Inquiry_Dghcos.InsertOnSubmit(inquiryDghco);
                    context.SubmitChanges();

                    MyDnn_EHaml_Inquiry inquiry = new MyDnn_EHaml_Inquiry()
                    {
                        CreateDate = DateTime.Now,
                        ActionDate = dtpActionDate.SelectedDate,
                        ExpireDate = dtpExpiredate.SelectedDate,
                        StartingPoint =
                            "(" + cbolStartingPointOstan.SelectedItem.Value + " : " + cbolStartingPointShahr.Text + ")",
                        Destination =
                            "(" + cbolDestinationOstan.SelectedItem.Value + " : " + cbolDestinationShahr.Text + ")",
                        IsReallyNeed = bool.Parse(cbolIsReallyNeed.SelectedItem.Value),
                        IsTender = chkIsTender.Checked,
                        LoadType = CreateLoadType(),
                        InquiryType = "Dghco"
                    };


                    inquiry.MyDnn_EHaml_User_Id = (context.MyDnn_EHaml_Users.Where(i => i.PortalUserId == this.UserId)
                        .Select(i => i.Id)).Single();

                    inquiry.InquiryDetail_Id = inquiryDghco.Id;
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

        private string CreateLoadType()
        {
            string loadTypeResult = string.Empty;
            foreach (DnnComboBoxItem loadType in cbolLoadType.Items)
            {
                if (loadType.Checked)
                {
                    loadTypeResult += loadType.Value + ", ";
                }
            }
            return loadTypeResult;
        }

        private string UploadLoadImage(FileUpload uploadedFile)
        {
            string guid = Guid.NewGuid().ToString();
            string filePath = PortalSettings.HomeDirectoryMapPath + @"/EHaml/Uploads/";
            //string now = DateTime.Now.ToShortDateString().Replace('\\', '_');
            string fileName = "Dghco_LoadImage_UId(" + this.UserId + ")_" + guid.Substring(0, 8) +
                              "" + uploadedFile.FileName.Substring(uploadedFile.FileName.LastIndexOf("."));

            if (!File.Exists(filePath + fileName))
            {
                uploadedFile.SaveAs(filePath + fileName);
            }

            string filePath2 = PortalSettings.HomeDirectory + @"/EHaml/Uploads/";
            //string now = DateTime.Now.ToShortDateString().Replace('\\', '_');
            string fileName2 = "Dghco_LoadImage_UId(" + this.UserId + ")_" + guid.Substring(0, 8) +
                               "" + uploadedFile.FileName.Substring(uploadedFile.FileName.LastIndexOf("."));

            return filePath2 + fileName2;
        }

        private string UploadFormFileAdlBandi(FileUpload uploadedFile)
        {
            string guid = Guid.NewGuid().ToString();
            string filePath = PortalSettings.HomeDirectoryMapPath + @"/EHaml/Uploads/";
            //string now = DateTime.Now.ToShortDateString().Replace('\\', '_');
            string fileName = "Dghco_AdlBandi_UId(" + this.UserId + ")_" + guid.Substring(0, 8) +
                              ".xlsx";

            if (!File.Exists(filePath + fileName))
            {
                uploadedFile.SaveAs(filePath + fileName);
            }

            return filePath + fileName;
        }

        //private void FillCbolDestinationOstan()
        //{
        //    DotNetNuke.Common.Lists.ListController lc = new DotNetNuke.Common.Lists.ListController();
        //    var leCountries = lc.GetListEntryInfoItems("Country", "", base.PortalSettings.PortalId).ToList();

        //    using (
        //        DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        cbolStartingPointOstan.DataValueField = "Value";
        //        cbolStartingPointOstan.DataTextField = "Text";
        //        var ostanList = (from i in leCountries
        //                         select new { Text = i.Text , Value = i.Text }).ToList();
        //        ostanList.RemoveAt(0);
        //        ostanList.RemoveAt(ostanList.Count - 1);

        //        
        //        foreach (var item in ostanList.Distinct())
        //        {
        //            cbolStartingPointOstan.Items.Add(new RadComboBoxItem(item.Text, item.Value));
        //        }

        //        
        //        foreach (var item in ostanList.Distinct())
        //        {
        //            cbolDestinationOstan.Items.Add(new RadComboBoxItem(item.Text, item.Value));
        //        }
        //    }
        //}

        private void FillCbolStartingPointOstan()
        {
            DotNetNuke.Common.Lists.ListController lc = new DotNetNuke.Common.Lists.ListController();
            var leCountries = lc.GetListEntryInfoItems("Country", "", base.PortalSettings.PortalId).ToList();

            using (DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                cbolStartingPointOstan.DataValueField = "Value";
                cbolStartingPointOstan.DataTextField = "Text";
                var ostanList = (from i in leCountries
                    select new {Text = i.Text, Value = i.Text}).ToList();
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

        private void FillPageControlls()
        {
            lblDarkhastKonandeValue.Text = this.UserInfo.DisplayName;
            FillCbolIsReallyNeed();
            FillCbolLoadType();
            FillCbolPackingType();
            FillCbolStartingPointOstan();
            //FillCbolDestinationOstan();
        }

        private void FillCbolPackingType()
        {
            cbolPackingType.Items.Add(new DnnComboBoxItem("قابل بارچینی روی هم", "قابل بارچینی روی هم"));
            cbolPackingType.Items.Add(new DnnComboBoxItem("قابل چرخاندن در جهت های مختلف",
                "قابل چرخاندن در جهت های مختلف"));
            cbolPackingType.Items.Add(new DnnComboBoxItem("بسته بندی ضد آب",
                "بسته بندی ضد آب"));
        }

        private void FillCbolLoadType()
        {
            
            cbolLoadType.Items.Add(new DnnComboBoxItem("غیر استاندارد از نظر ابعاد یا وزن",
                "غیر استاندارد از نظر ابعاد یا وزن"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("جنرال کارگو", "جنرال کارگو"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("ماشین آلات", "ماشین آلات"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("لوله", "لوله"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("وسیله نقلیه", "وسیله نقلیه"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("پاکت یا جامبو", "پاکت یا جامبو"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("بشکه", "بشکه"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("پالت", "پالت"));
            cbolLoadType.Items.Add(new DnnComboBoxItem("فله", "فله"));

            
            
        }

        private void FillCbolIsReallyNeed()
        {
            
            cbolIsReallyNeed.Items.Add(new DnnComboBoxItem("صرفآ برای اطلاع از قیمت استعلام می کنم", "false"));
            cbolIsReallyNeed.Items.Add(new DnnComboBoxItem("صرفا برای اطلاع از قیمت نیست و نیاز به این خدمات دارم",
                "true"));

            
            
        }
    }
}