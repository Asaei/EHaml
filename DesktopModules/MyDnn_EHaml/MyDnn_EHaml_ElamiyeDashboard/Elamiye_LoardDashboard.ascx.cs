using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Web.UI.WebControls;


namespace MyDnn_EHaml.MyDnn_EHaml_ElamiyeDashboard
{
    public partial class Elamiye_LoardDashboard : PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Util util2 = new Util();
            if (util2.IsUserKhadamatResan(this.UserId))
            {
                isKhadamatresan.Visible = true;
            }
            //if (!Page.IsPostBack)
            //{
            //    if (this.UserId == 40)
            //    {
            //        Response.Redirect("default.aspx?tabid=" + this.TabId + "&mid=" + this.ModuleId +
            //                          "&ctl=Elamiye_ServantDashboard");
            //    }
            //    //FillPageControlls();
            //}
        }

        //private void FillPageControlls()
        //{
        //    using (
        //        DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
        //    {
        //        int ehamlUserId =
        //            context.MyDnn_EHaml_Users.Where(i => i.PortalUserId == this.UserId).Select(i => i.Id).Single();

        //        List<tListItem> myInquiryList = (from i in context.MyDnn_EHaml_Elamiye_KhaliJadeis

        //            where
        //                i.MyDnn_EHaml_User_Id == ehamlUserId && i.ServentUserId == null && i.ElamiyeType == "KhaliJadei"
        //            select new tListItem()
        //            {
        //                Id = i.Id,
        //                Type = i.ElamiyeType,
        //                Date = i.CreateDate.Value,
        //            }).ToList();

        //        List<tListItem> myInquiryList2 = (from i in context.MyDnn_EHaml_Elamiye_KhaliReylis

        //            where
        //                i.MyDnn_EHaml_User_Id == ehamlUserId && i.ServentUserId == null && i.ElamiyeType == "KhaliReyli"
        //            select
        //                new tListItem()
        //                {
        //                    Id = i.Id,
        //                    Type = i.ElamiyeType,
        //                    Date = i.CreateDate.Value,
        //                }).ToList();


        //        myInquiryList.AddRange(myInquiryList2);

        //        List<tListItem> myInquiryList3 = (from i in context.MyDnn_EHaml_Elamiye_KhaliDaryayis

        //            where
        //                i.MyDnn_EHaml_User_Id == ehamlUserId && i.ServentUserId == null &&
        //                i.ElamiyeType == "KhaliDaryayi"
        //            select
        //                new tListItem()
        //                {
        //                    Id = i.Id,
        //                    Type = i.ElamiyeType,
        //                    Date = i.CreateDate.Value,
        //                }).ToList();

        //        myInquiryList.AddRange(myInquiryList3);

        //        if (!myInquiryList.Any())
        //        {
        //            cbolActiveElamiye.Items.Add(new DnnComboBoxItem("هیچ اعلامیه فعالی وجود ندارد", "-1"));
        //        }
        //        else
        //        {
        //            //lnkSearch.Disabled = false;
        //            foreach (var item in myInquiryList)
        //            {
        //                string date = "تاریخ " + item.Date.ToShortDateString();
        //                string type = GeTypeInFarsi(item.Type);
        //                cbolActiveElamiye.Items.Add(new DnnComboBoxItem(item.Id + ")" + type + " ، " + date,
        //                    item.Id.ToString()));
        //            }
        //        }
        //    }
        //}

        //private string GeTypeInFarsi(string inquiryType)
        //{
        //    string result = string.Empty;
        //    switch (inquiryType)
        //    {
        //        case "KhaliJadei":
        //            result = "اعلامیه خالی جاده ای";
        //            break;
        //        case "KhaliReyli":
        //            result = "اعلامیه خالی ریلی";
        //            break;
        //        case "KhaliDaryayi":
        //            result = "اعلامیه خالی دریایی";
        //            break;
        //    }
        //    return result;
        //}
    }

    //internal class tListItem
    //{
    //    public int Id { get; set; }
    //    public string Type { get; set; }
    //    public DateTime Date { get; set; }
    //}
}