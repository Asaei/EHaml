using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;


namespace MyDnn_EHaml.MyDnn_EHaml_Gozaresh
{
    public partial class GozareshForm : PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            dtpDate.SelectedDate = DateTime.Now;
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkSubmit.Click += lnkSubmit_Click;
        }

        private void lnkSubmit_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["Id"];

            using (DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_GozareshT gozareshT = new MyDnn_EHaml_GozareshT();
                gozareshT.Date = dtpDate.SelectedDate;
                gozareshT.InquiryReplyToInquiry_Id = Convert.ToInt32(id);
                gozareshT.Message = txtGozareshValue.Text;

                context.MyDnn_EHaml_GozareshTs.InsertOnSubmit(gozareshT);
                context.SubmitChanges();
            }
        }
    }
}