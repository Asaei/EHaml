using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.UI.UserControls;
using DotNetNuke.Web.UI.WebControls;
using Telerik.Web.UI;


namespace MyDnn_EHaml.MyDnn_EHaml_Gozaresh
{
    public partial class SahebSide : PortalModuleBase
    {
        private Util _util = new Util();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                FillPageControlls();
            }
        }

        private void FillPageControlls()
        {
            FillCbolActiveInquiry();
        }

        private void FillCbolActiveInquiry()
        {
            int userid = _util.GetUserEHamlUserIdByPortalId(this.UserId);

            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var list =
                    (from i in context.MyDnn_EHaml_Inquiries
                        join j in context.MyDnn_EHaml_Inquiry_ReplyToInquiries on i.Id equals j.InquiryId
                        where i.MyDnn_EHaml_User_Id == userid && j.Status == 1
                        select new
                        {
                            j.Id,
                            i.InquiryType,
                            i.ActionDate,
                            i.StartingPoint,
                            i.Destination,
                            i.LoadType,
                        });
                if (!list.Any())
                {
                    cbolActiveInquiry.Items.Add(new RadComboBoxItem("هیچ گزارشی موجود نمی باشد", "-1"));
                    return;
                }


                foreach (var item in list.ToList())
                {
                    string date = "تاریخ " + item.ActionDate.Value.ToShortDateString();
                    if (item.InquiryType == "Hl")
                    {
                        string type = GeTypeInFarsi(item.InquiryType);
                        cbolActiveInquiry.Items.Add(
                            new DnnComboBoxItem(
                                item.Id + ")" + type + " ، " + date + "| از:" + item.StartingPoint.Replace(":", "(") +
                                " به:" + item.Destination.Replace(":", "(") + "| محموله:" + " - ",
                                item.Id.ToString()));
                    }
                    if (item.InquiryType == "Tj" || item.InquiryType == "Ts")
                    {
                        string type = GeTypeInFarsi(item.InquiryType);
                        cbolActiveInquiry.Items.Add(
                            new DnnComboBoxItem(
                                item.Id + ")" + type + " ، " + date + "| از:" + item.StartingPoint.Replace(":", "(") +
                                " به:" + " - (" + "| محموله:" + " - ",
                                item.Id.ToString()));
                    }
                    else if (item.InquiryType == "Tr")
                    {
                        string type = GeTypeInFarsi(item.InquiryType);
                        cbolActiveInquiry.Items.Add(
                            new DnnComboBoxItem(
                                item.Id + ")" + type + " ، " + date,
                                item.Id.ToString()));
                    }
                    else
                    {
                        string type = GeTypeInFarsi(item.InquiryType);
                        cbolActiveInquiry.Items.Add(
                            new DnnComboBoxItem(
                                item.Id + ")" + type + " ، " + date + "| از:" + item.StartingPoint.Replace(":", "(") +
                                " به:" + item.Destination.Replace(":", "(") + "| محموله:" + item.LoadType,
                                item.Id.ToString()));
                    }
                }
            }
        }


        private string GeTypeInFarsi(string inquiryType)
        {
            string result = string.Empty;
            switch (inquiryType)
            {
                case "Zadghan":
                    result = "استعلام زدغن";
                    break;
                case "Zadghal":
                    result = "استعلام زدغل";
                    break;
                case "Zaban":
                    result = "استعلام زبن";
                    break;
                case "Rl":
                    result = "استعلام رل";
                    break;
                case "Dn":
                    result = "استعلام دن";
                    break;
                case "Dl":
                    result = "استعلام دل";
                    break;
                case "ZDF":
                    result = "استعلام زدف";
                    break;
                case "Dghco":
                    result = "استعلام دغک";
                    break;
                case "Hl":
                    result = "استعلام هل";
                    break;
                case "Tj":
                    result = "استعلام تج";
                    break;
                case "Tk":
                    result = "استعلام تک";
                    break;
                case "Ts":
                    result = "استعلام تس";
                    break;
                case "Tr":
                    result = "استعلام تر";
                    break;
                case "ChandVajhiSabok":
                    result = "استعلام چند وجهی سبک";
                    break;
                case "ChandVajhiSangin":
                    result = "استعلام چند وجهی سنگین";
                    break;
                case "Bazdid":
                    result = "بازدید";
                    break;
            }
            return result;
        }
    }

    internal class InquiryListItemForPeygiriyeGozareshDTO
    {
        public int Value { get; set; }
        public string Text { get; set; }
    }
}