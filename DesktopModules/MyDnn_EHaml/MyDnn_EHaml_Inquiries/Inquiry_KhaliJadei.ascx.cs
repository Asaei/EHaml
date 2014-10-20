using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using MyDnn_EHaml.MyDnn_EHaml_Inquiries.DataClasses;
using Telerik.Web.UI;

namespace MyDnn_EHaml.MyDnn_EHaml_Inquiries
{
    public partial class Inquiry_KhaliJadei : PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Util util = new Util();
            if (!util.IsUserOk(this.UserId))
            {
                //Do something!
            }
            else
            {
                if (!Page.IsPostBack)
                {
                    FillPageControlls();
                }
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += LnkSubmitOnClick;
        }

        private void LnkSubmitOnClick(object sender, EventArgs eventArgs)
        {
            using (
                InquiryDataClassesDataContext context = new InquiryDataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_Inquiry_KhaliJadei inquiryKhaliJadei = new MyDnn_EHaml_Inquiry_KhaliJadei();

                inquiryKhaliJadei.IsKhahaneErsaleEstelamBeKharej = chkKhahaneErsalEstelamBeKharej.Checked;
                inquiryKhaliJadei.VasileyeHamleAmadeyeBargiri = CreatVasileyeHamleAmadeyeBargiri();

                context.MyDnn_EHaml_Inquiry_KhaliJadeis.InsertOnSubmit(inquiryKhaliJadei);
                context.SubmitChanges();

                MyDnn_EHaml_Inquiry inquiry = new MyDnn_EHaml_Inquiry()
                {
                    CreateDate = DateTime.Now,
                    InquiryType = "KhaliJadei"
                };


                inquiry.MyDnn_EHaml_User_Id = (context.MyDnn_EHaml_Users.Where(i => i.PortalUserId == this.UserId)
                    .Select(i => i.Id)).Single();

                inquiry.InquiryDetail_Id = inquiryKhaliJadei.Id;
                context.MyDnn_EHaml_Inquiries.InsertOnSubmit(inquiry);
                context.SubmitChanges();


                // BarrasiShavad
                Response.Redirect("/fa-ir/Home");
            }
        }

        private string CreatVasileyeHamleAmadeyeBargiri()
        {
            string result = string.Empty;

            foreach (RepeaterItem item in rptNoeContiner.Items)
            {
                string name = (item.FindControl("txtTedad") as Label).ToolTip;
                string tedad = (item.FindControl("txtTedad") as TextBox).Text;
                string shahr = (item.FindControl("txtShahr") as TextBox).Text;
                DateTime zaman = (item.FindControl("dtpZamaneAmadegi") as RadDatePicker).SelectedDate.Value;

                if (!string.IsNullOrEmpty(tedad) && !string.IsNullOrWhiteSpace(tedad))
                {
                    result += name + "(" + tedad + "," + shahr + "," + zaman + ")|";
                }
            }

            return result;
        }

        private void FillPageControlls()
        {
            lblDarkhastKonandeValue.Text = this.UserInfo.DisplayName;

            using (
                InquiryDataClassesDataContext context = new InquiryDataClassesDataContext(Config.GetConnectionString()))
            {
                var vasileList = from i in context.MyDnn_EHaml_VasileyeHamleKhalis
                    select new {VasileName = i.NameVasileyeHaml};

                rptNoeContiner.DataSource = vasileList;
                rptNoeContiner.DataBind();
            }
        }
    }
}