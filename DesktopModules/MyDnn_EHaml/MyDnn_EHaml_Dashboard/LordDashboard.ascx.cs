using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.UI.UserControls;
using DotNetNuke.Web.UI.WebControls;
using MyDnn_EHaml.MyDnn_EHaml_GeneralList;


namespace MyDnn_EHaml
{
    public partial class MyDnn_EHaml_LordDashboard : PortalModuleBase
    {
        private Util _util = new Util();

        protected void Page_Load(object sender, EventArgs e)
        {
            Util util2 = new Util();
            if (util2.IsUserKhadamatResan(this.UserId))
            {
                isKhadamatresan.Visible = true;
            }
            if (!Page.IsPostBack)
            {
                //if (!this.UserInfo.IsInRole("SahebBar"))
                //{
                //    Response.Redirect("default.aspx?tabid=" + this.TabId + "&mid=" + this.ModuleId +
                //                      "&ctl=ServantDashboard");
                //}
                FillPageControlls();
            }
        }

        private void FillPageControlls()
        {
//            FillCbolActiveInquiry();
        }

//        private void FillCbolActiveInquiry()
//        {
//            using (
//                DataClassesDataContext context =
//                    new DataClassesDataContext(Config.GetConnectionString()))
//            {
//                int ehamlUserId =
//                    context.MyDnn_EHaml_Users.Where(i => i.PortalUserId == this.UserId).Select(i => i.Id).Single();
//                var myInquiryList = from i in context.MyDnn_EHaml_Inquiries
//                    where
//                        i.MyDnn_EHaml_User_Id == ehamlUserId
//                        && (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            where c.InquiryId == i.Id &&
//                            c.Status == 1
//                            select c).Count() < 3
//                    select
//                        new
//                        {
//                            Id = i.Id,
//                            Type = i.InquiryType,
//                            Date = i.CreateDate,
//                            Mabda = (i.StartingPoint + ")"),
//                            Magsad = (i.Destination + ")"),
//                            Mahmoole = i.LoadType,
//                        };
//
//                var myInquiryList2 = from i in context.MyDnn_EHaml_Inquiries
//                    where
//                        i.MyDnn_EHaml_User_Id == ehamlUserId && i.ServantUserId == null
//                        && i.InquiryType == "Bazdid" && (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            where c.InquiryId == i.Id
//                            where i.InquiryType == "Bazdid" && c.Status == 1
//                            select c).Count() < 3
//                    select
//                        new
//                        {
//                            Id = i.Id,
//                            Type = i.InquiryType,
//                            Date = i.CreateDate,
//                            Mabda = (i.StartingPoint + ")"),
//                            Magsad = (i.Destination + ")"),
//                            Mahmoole = i.LoadType,
//                        };
//
//
//                if (myInquiryList.Count() == 0)
//                {
//                    //lnkSearch.Disabled = true;
//                    //cbolActiveInquiry.Items.Add(new DnnComboBoxItem("هیچ استعلام فعالی وجود ندارد", "-1"));
//                }
//                else
//                {
//                    //lnkSearch.Disabled = false;
//                    foreach (var item in myInquiryList)
//                    {
//                        string date = "تاریخ " + item.Date.Value.ToShortDateString();
//                        string type = GeTypeInFarsi(item.Type);
//                         if (item.Type == "Tr")
//                        {
//                            cbolActiveInquiryd.Items.Add(
//                                new DnnComboBoxItem(
//                                    item.Id + ")" + type + " ، " + date,
//                                    item.Id.ToString()));
//                        }
//
//                         else if (item.Magsad == null && item.Mahmoole == null)
//                         {
//                             cbolActiveInquiryd.Items.Add(
//                                 new DnnComboBoxItem(
//                                     item.Id + ")" + type + " ، " + date + "| از:" + item.Mabda.Replace(":", "(") +
//                                     " به:" + ("- )") + "| محموله:" + " - ",
//                                     item.Id.ToString()));
//                         }
//                        else
//                        {
//                            cbolActiveInquiryd.Items.Add(
//                                new DnnComboBoxItem(
//                                    item.Id + ")" + type + " ، " + date + "| از:" + item.Mabda.Replace(":", "(") +
//                                    " به:" + item.Magsad.Replace(":", "(") + "| محموله:" + item.Mahmoole,
//                                    item.Id.ToString()));
//                        }
//                    }
//                }
//
//                if (myInquiryList2.Count() > 0)
//                {
//                    foreach (var item in myInquiryList2)
//                    {
//                        string date = "تاریخ " + item.Date.Value.ToShortDateString();
//                        string type = GeTypeInFarsi(item.Type);
//                        new DnnComboBoxItem(
//                            item.Id + ")" + type + " ، " + date + "| از:" + item.Mabda.Replace(":", "(") +
//                            " به:" + item.Magsad.Replace(":", "(") + "| محموله:" + item.Mahmoole,
//                            item.Id.ToString());
//                    }
//                }
//                else
//                {
//                    if (myInquiryList.Count() == 0)
//                    {
//                        cbolActiveInquiryd.Items.Add(new DnnComboBoxItem("هیچ استعلام فعالی وجود ندارد", "-1"));
//                    }
//                }
//            }
//        }

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
                    break;
                case "Hs":
                    result = "استعلام هس";
                    break;
            }
            return result;
        }


//        public InquiryListItemJftGeneral GetInquiryLisGeneral(int UserId)
//        {
//            List<InquiryListItemJftGeneral> inquiryList = new List<InquiryListItemJftGeneral>();
//            using (DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
//            {
//                //                int ehamlUserId = (from i in context.MyDnn_EHaml_Users
//                //                    where i.PortalUserId == this.UserInfo.UserID
//                //                    select i.Id).Single();
//
//                int ehamlUserId = int.MaxValue;
//
//                //                    if (inquiryTypeForList == "Zadghan")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_ZadghanTs on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "Zadghan" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "Zadghan" && c.Status == 1 &&
//                                                x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "Zadghan" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date && i.MyDnn_EHaml_User_Id == UserId
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "Zadghan"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = i.LoadType.Contains("IMDG"),
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = i.IsTender,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = i.Destination,
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = i.LoadType,
//                                          EmptyingCharges = k.EmptyingCharges,
//                                          NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
//                                          WithInsurance = k.WithInsurance,
//                                          FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "Zadghal")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_Zadghals on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "Zadghal" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "Zadghal" && c.Status == 1 &&
//                                                x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "Zadghal" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "Zadghal"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = i.LoadType.Contains("IMDG"),
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = i.IsTender,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = i.Destination,
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = i.LoadType,
//                                          EmptyingCharges = k.EmptyingCharges,
//                                          NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
//                                          WithInsurance = k.WithInsurance,
//                                          FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "Zaban")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_Zabans on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "Zaban" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "Zaban" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "Zaban" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "Zaban"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = i.LoadType.Contains("IMDG"),
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = i.IsTender,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = i.Destination,
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = i.LoadType,
//                                          EmptyingCharges = k.EmptyingCharges,
//                                          NoVaTedadeVasileyeHaml = "",
//                                          WithInsurance = false,
//                                          FileArzesheBar = "",
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "Rl")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_Rls on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "Rl" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "Rl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "Rl" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "Rl"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = i.LoadType.Contains("IMDG"),
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = i.IsTender,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = i.Destination,
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = i.LoadType,
//                                          EmptyingCharges = k.EmptyingCharges,
//                                          NoVaTedadeVasileyeHaml = "",
//                                          WithInsurance = false,
//                                          FileArzesheBar = "",
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "Dn")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_Dns on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "Dn" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "Dn" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "Dn" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "Dn"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = i.LoadType.Contains("IMDG"),
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = i.IsTender,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = i.Destination,
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = i.LoadType,
//                                          EmptyingCharges = false,
//                                          NoVaTedadeVasileyeHaml = "",
//                                          WithInsurance = false,
//                                          FileArzesheBar = "",
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "Dl")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_Dls on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "Dl" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "Dl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "Dl" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "Dl"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = i.LoadType.Contains("IMDG"),
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = i.IsTender,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = i.Destination,
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = i.LoadType,
//                                          EmptyingCharges = false,
//                                          NoVaTedadeVasileyeHaml = "",
//                                          WithInsurance = false,
//                                          FileArzesheBar = "",
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "ZDF")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_ZDFs on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "ZDF" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "ZDF" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "ZDF" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "ZDF"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = i.LoadType.Contains("IMDG"),
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = i.IsTender,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = i.Destination,
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = i.LoadType,
//                                          EmptyingCharges = false,
//                                          NoVaTedadeVasileyeHaml = "",
//                                          WithInsurance = false,
//                                          FileArzesheBar = "",
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "Dghco")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml__Inquiry_Dghcos on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "Dghco" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "Dghco" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "Dghco" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "Dghco"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = i.LoadType.Contains("IMDG"),
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = i.IsTender,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = i.Destination,
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = i.LoadType,
//                                          EmptyingCharges = k.EmptyingCharges,
//                                          NoVaTedadeVasileyeHaml = "",
//                                          WithInsurance = false,
//                                          FileArzesheBar = "",
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "Hl")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_Hls on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "Hl" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "Hl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "Hl" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "Hl"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = false,
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = false,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = i.Destination,
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = "",
//                                          EmptyingCharges = false,
//                                          NoVaTedadeVasileyeHaml = "",
//                                          WithInsurance = false,
//                                          FileArzesheBar = "",
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "Tj")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_Tjs on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "Tj" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "Tj" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "Tj" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "Tj"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = false,
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = i.IsTender,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = "",
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = "",
//                                          EmptyingCharges = false,
//                                          NoVaTedadeVasileyeHaml = "",
//                                          WithInsurance = false,
//                                          FileArzesheBar = "",
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "Tk")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_Tks on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "Tk" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "Tk" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "Tk" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "Tk"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = false,
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = i.IsTender,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = i.Destination,
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = "",
//                                          EmptyingCharges = false,
//                                          NoVaTedadeVasileyeHaml = "",
//                                          WithInsurance = false,
//                                          FileArzesheBar = "",
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "Ts")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_Ts on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "Ts" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "Ts" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "Ts" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "Ts"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = false,
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = i.IsTender,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = "",
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = "",
//                                          EmptyingCharges = false,
//                                          NoVaTedadeVasileyeHaml = "",
//                                          WithInsurance = false,
//                                          FileArzesheBar = "",
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "Tr")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_Trs on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "Tr" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "Tr" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "Tr" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "Tr"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = false,
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = i.IsTender,
//                                          StartingPoint = "",
//                                          Destination = "",
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = "",
//                                          EmptyingCharges = false,
//                                          NoVaTedadeVasileyeHaml = "",
//                                          WithInsurance = false,
//                                          FileArzesheBar = "",
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "ChandVajhiSabok")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSaboks on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "ChandVajhiSabok" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "ChandVajhiSabok" && c.Status == 1 &&
//                                                x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "ChandVajhiSabok" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "ChandVajhiSabok"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = i.LoadType.Contains("IMDG"),
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = i.IsTender,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = i.Destination,
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = i.LoadType,
//                                          EmptyingCharges = false,
//                                          NoVaTedadeVasileyeHaml = "",
//                                          WithInsurance = false,
//                                          FileArzesheBar = "",
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "ChandVajhiSangin")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSangins on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "ChandVajhiSangin" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "ChandVajhiSangin" && c.Status == 1 &&
//                                                x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "ChandVajhiSangin" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                            && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "ChandVajhiSangin"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = i.LoadType.Contains("IMDG"),
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName =this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                                          IsTender = i.IsTender,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = i.Destination,
//                                          ActionDate = i.ActionDate.Value.ToShortDateString(),
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = i.LoadType,
//                                          EmptyingCharges = false,
//                                          NoVaTedadeVasileyeHaml = "",
//                                          WithInsurance = false,
//                                          FileArzesheBar = "",
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
//                //                    else if (inquiryTypeForList == "Bazdid")
//                //                    {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                                      join k in context.MyDnn_EHaml_Inquiry_Bazdids on i.InquiryDetail_Id equals k.Id
//                                      join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                                      where i.InquiryType == "Bazdid" && (
//                                          from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                          join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                          where c.InquiryId == i.Id &&
//                                                i.InquiryType == "Bazdid" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                                          select c).Count() < 3 && !(
//                                              from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                              join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                              where z.InquiryId == i.Id &&
//                                                    i.InquiryType == "Bazdid" && z.Status == 2 &&
//                                                    f.MyDnn_EHaml_User_Id == ehamlUserId
//                                              select z).Any()
//                                      /*&& i.ExpireDate.Value.Date >= DateTime.Now.Date*/
//                                      select new InquiryListItemJftGeneral()
//                                      {
//                                          TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                                                            where c.InquiryId == i.Id && i.InquiryType == "Bazdid"
//                                                            select c).Count(),
//                                          NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                                join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                                where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                      && g.NazareKoli == true
//                                                                select g).Count()).ToString(),
//                                          NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                                                              join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                                                              where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                                                    && g.NazareKoli == false
//                                                              select g).Count()).ToString(),
//                                          Id = i.Id,
//                                          Khatarnak = false,
//                                          Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                  where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                  select i2.Quality).SingleOrDefault(),
//                                          Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                                                   where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                                                   select i2.Power).SingleOrDefault(),
//                                          Status = _util.GetUserStatus(j.PortalUserId, 1),
//                                          DisplayName = this.UserInfo.DisplayName,
//                                          InquiryType = i.InquiryType,
//                                          CreateDate = i.CreateDate.Value.ToShortDateString(),
//                                          ExpireDate = "",
//                                          IsTender = i.IsTender,
//                                          StartingPoint = i.StartingPoint,
//                                          Destination = i.Destination,
//                                          ActionDate = "",
//                                          IsReallyNeed = i.IsReallyNeed,
//                                          LoadType = i.LoadType,
//                                          EmptyingCharges = false,
//                                          NoVaTedadeVasileyeHaml = "",
//                                          WithInsurance = false,
//                                          FileArzesheBar = "",
//                                          Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                                          VazneKol = "",
//                                      }));
//                //                    }
////                return Request.CreateResponse(HttpStatusCode.OK, inquiryList);
//            }
//        }
    }
}