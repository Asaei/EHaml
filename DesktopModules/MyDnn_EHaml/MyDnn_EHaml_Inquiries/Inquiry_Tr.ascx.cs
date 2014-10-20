using System;
using System.Collections.Generic;
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
    public partial class Inquiry_Tr : PortalModuleBase
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
            lnkPrintKon.Click += lnkPrintKon_Click;
        }

        private void lnkPrintKon_Click(object sender, EventArgs e)
        {
            Response.Redirect("/default.aspx?tabid=" + this.TabId + "&mid=" + this.ModuleId +
                              "&ctl=ReplyToInquiry_Tr&InqId=" + hiddenFieldId.Value + "&popUp=true&IsPrint=Yes");
        }

        private void btnErsaleLinkTaeid1_Click(object sender, EventArgs e)
        {
            Util util = new Util();
            string appCode = util.getUserAppCode(util.GetUserEHamlUserIdByPortalId(UserId));
            string link = "http://" + PortalAlias + "/default.aspx?tabid=" + 124 +
                          "&mid=439&ctl=Approve&AppCode=" + appCode;

            util.SendAppLinkToUserMail(UserId, link);
            pnlMessageForNotApproved.Visible = false;
            pnlMessageForNotApprovedAfterErsal.Visible = true;
        }

        private void lnkSubmit_Click(object sender, EventArgs e)
        {
            Util util = new Util();
            string message = util.IsValidateDates(dtpActionDate: dtpActionDate, dtpExpiredate: dtpExpiredate);
            bool isReturn = message != "OK";

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
                    MyDnn_EHaml_Inquiry_Tr Tr = new MyDnn_EHaml_Inquiry_Tr();

                    Tr.IsKhahaneErsaleEstelamBeKharej = chkKhahaneErsalEstelamBeKharej.Checked;

                    if (fupFormeListeAdlBandiFull.HasFile)
                    {
                        Tr.FileListAdlBandi = UploadFormFileAdlBandi(fupFormeListeAdlBandiFull);
                    }
                    if (fupFormeGeymateListeAdlBandi.HasFile)
                    {
                        Tr.FileFactor = UploadFormGeymatFileAdlBandi(fupFormeGeymateListeAdlBandi);
                    }

                    Tr.NoeTarkhis = cbolNoeTarkhis.SelectedItem.Value;
                    Tr.MogiyateTahvilDadan = " ";
                    Tr.MogiyateTahvilGereftan = cbolMogeiyateTahvilGereftan.SelectedItem.Value;
                    Tr.IsKhahaneErsaleEstelamBeKharej = chkKhahaneErsalEstelamBeKharej.Checked;
                    Tr.MahaleTarkhis = cbolMahaleTarkhis.SelectedItem.Value;

                    context.MyDnn_EHaml_Inquiry_Trs.InsertOnSubmit(Tr);
                    context.SubmitChanges();

                    MyDnn_EHaml_Inquiry inquiry = new MyDnn_EHaml_Inquiry()
                    {
                        CreateDate = DateTime.Now,
                        ActionDate = dtpActionDate.SelectedDate,
                        ExpireDate = dtpExpiredate.SelectedDate,
                        //StartingPoint = "ایران:تهران",
                        //Destination = "انگلیس:پاریس",
                        IsReallyNeed = bool.Parse(cbolIsReallyNeed.SelectedItem.Value),
                        InquiryType = "Tr"
                    };


                    inquiry.MyDnn_EHaml_User_Id = (context.MyDnn_EHaml_Users.Where(i => i.PortalUserId == this.UserId)
                        .Select(i => i.Id)).Single();

                    inquiry.InquiryDetail_Id = Tr.Id;
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

        private string UploadFormGeymatFileAdlBandi(FileUpload uploadedFile)
        {
            string guid = Guid.NewGuid().ToString();
            string filePath = PortalSettings.HomeDirectoryMapPath + @"/EHaml/Uploads/";
            //string now = DateTime.Now.ToShortDateString().Replace('\\', '_');
            string fileName = "Tr_GeymatBarAsaseAdlBandi_UId(" + this.UserId + ")_" + guid.Substring(0, 8) +
                              ".xlsx";

            if (!File.Exists(filePath + fileName))
            {
                uploadedFile.SaveAs(filePath + fileName);
            }

            string filePath2 = PortalSettings.HomeDirectory + @"/EHaml/Uploads/";
            //string now = DateTime.Now.ToShortDateString().Replace('\\', '_');
            string fileName2 = "Tr_GeymatBarAsaseAdlBandi_UId(" + this.UserId + ")_" + guid.Substring(0, 8) +
                               ".xlsx";

            return filePath2 + fileName2;
        }

        private string UploadFormFileAdlBandi(FileUpload uploadedFile)
        {
            string guid = Guid.NewGuid().ToString();

            string filePath = PortalSettings.HomeDirectoryMapPath + @"\EHaml\Uploads\";
            //string now = DateTime.Now.ToShortDateString().Replace('\\', '_');
            string fileName = "Tr_AdlBandi_UId(" + this.UserId + ")_" + guid.Substring(0, 8) +
                              ".xlsx";

            if (!File.Exists(filePath + fileName))
            {
                uploadedFile.SaveAs(filePath + fileName);
            }

            string filePath2 = PortalSettings.HomeDirectory + @"/EHaml/Uploads/";
            //string now = DateTime.Now.ToShortDateString().Replace('\\', '_');
            string fileName2 = "Tr_AdlBandi_UId(" + this.UserId + ")_" + guid.Substring(0, 8) +
                               ".xlsx";

            return filePath2 + fileName2;
        }

        private void FillPageControl()
        {
            lblDarkhastKonandeValue.Text = this.UserInfo.DisplayName;
            FillCbolIsReallyNeed();
            FillCbolNoeTarkhis();
            FillCbolMahaleTarkhis();
            FillCbolMogeiyateTahvilDadan();
            FillCbolMogeiyateTahvilGereftan();
        }

        private void FillCbolMogeiyateTahvilGereftan()
        {

            cbolMogeiyateTahvilGereftan.Items.Add(new DnnComboBoxItem("روی کشتی(با احتساب هزینه THC)",
                "روی کشتی(با احتساب هزینه THC)"));
            cbolMogeiyateTahvilGereftan.Items.Add(new DnnComboBoxItem("در کنار کشتی(بدون احتساب هزینه THC)",
                "در کنار کشتی(بدون احتساب هزینه THC)"));
        }

        private void FillCbolMogeiyateTahvilDadan()
        {
            cbolMogeiyateTahvilDadan.Items.Add(new DnnComboBoxItem("روی کشتی(با احتساب هزینه THC)",
                "روی کشتی(با احتساب هزینه THC)"));
            cbolMogeiyateTahvilDadan.Items.Add(new DnnComboBoxItem("در کنار کشتی(بدون احتساب هزینه THC)",
                "در کنار کشتی(بدون احتساب هزینه THC)"));
        }

        private void FillCbolMahaleTarkhis()
        {
            cbolMahaleTarkhis.Items.Add(new DnnComboBoxItem("شهر", "شهر"));
            cbolMahaleTarkhis.Items.Add(new DnnComboBoxItem("گمرک",
                "گمرک"));
        }

        private void FillCbolNoeTarkhis()
        {
            cbolNoeTarkhis.Items.Add(new DnnComboBoxItem("صادرات", "صادرات"));
            cbolNoeTarkhis.Items.Add(new DnnComboBoxItem("واردات", "واردات"));
            cbolNoeTarkhis.Items.Add(new DnnComboBoxItem("ترانزیت داخلی", "ترانزیت داخلی"));
            cbolNoeTarkhis.Items.Add(new DnnComboBoxItem("ترانزیت خارجی", "ترانزیت خارجی"));
        }


        private void FillCbolIsReallyNeed()
        {
            
            cbolIsReallyNeed.Items.Add(new DnnComboBoxItem("صرفآ برای اطلاع از قیمت استعلام می کنم", "false"));
            cbolIsReallyNeed.Items.Add(new DnnComboBoxItem("صرفا برای اطلاع از قیمت نیست و نیاز به این خدمات دارم",
                "true"));

            
            
        }
    }
}