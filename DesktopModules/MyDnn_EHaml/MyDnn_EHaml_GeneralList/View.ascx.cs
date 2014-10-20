using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.Security;
using DotNetNuke.Web.Api;


namespace MyDnn_EHaml.MyDnn_EHaml_GeneralList
{
    public partial class View : PortalModuleBase
    {
        private Util _util = new Util();

        protected void Page_Load(object sender, EventArgs e)
        {
            List<InquiryListItemJftGeneral> list = GetInquiryLisGeneral();

            rptGeneralList.DataSource = list;
            rptGeneralList.DataBind();
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            rptGeneralList.ItemDataBound += rptGeneralList_ItemDataBound;
        }

        private void rptGeneralList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            InquiryListItemJftGeneral DataItem = e.Item.DataItem as InquiryListItemJftGeneral;

            string template = getTemplate();
            if (template != "Nothing")
            {
                template = template.Replace("[ID]", (DataItem.Id == null ? "" : DataItem.Id.ToString()));
                template = template.Replace("[ActionDate]",
                    (DataItem.ActionDate == null ? "" : DataItem.ActionDate.ToString()));
                template = template.Replace("[CreateDate]",
                    (DataItem.CreateDate == null ? "" : DataItem.CreateDate.ToString()));
//                if (DataItem.Destination != null)
//                {
//
//                   DataItem.Destination= DataItem.Destination.Replace("(", "");
//                    DataItem.Destination = DataItem.Destination.Replace(")", "");
//                    template = template.Replace("[Destination]", (DataItem.Destination));
//                }
//                else
//                {
//                    template = "-";
//                }
                template = template.Replace("[Destination]",
                    (DataItem.Destination == null
                        ? ""
                        : DataItem.Destination.ToString().Replace("(", "").Replace(")", "")));

                template = template.Replace("[DisplayName]",
                    (DataItem.DisplayName == null ? "" : DataItem.DisplayName.ToString()));
                template = template.Replace("[EmptyingCharges]",
                    (DataItem.EmptyingCharges == null ? "" : DataItem.EmptyingCharges.ToString()));
                template = template.Replace("[ExpireDate]",
                    (DataItem.ExpireDate == null ? "" : DataItem.ExpireDate.ToString()));
                template = template.Replace("[FileArzesheBar]",
                    (DataItem.FileArzesheBar == null ? "" : DataItem.FileArzesheBar.ToString()));
                template = template.Replace("[InquiryType]",
                    (DataItem.InquiryType == null ? "" : _util.GeTypeInFarsiReal(DataItem.InquiryType.ToString())));
                template = template.Replace("[InquiryType2]",
                    (DataItem.InquiryType == null ? "" : DataItem.InquiryType.ToString()));
                template = template.Replace("[IsReallyNeed]",
                    (DataItem.IsReallyNeed == null ? "" : DataItem.IsReallyNeed.ToString()));
                template = template.Replace("[IsTender]",
                    (DataItem.IsTender == null ? "" : DataItem.IsTender.ToString()));
                template = template.Replace("[LoadType]",
                    (DataItem.LoadType == null ? "" : DataItem.LoadType.ToString()));
                template = template.Replace("[NoVaTedadeVasileyeHaml]",
                    (DataItem.NoVaTedadeVasileyeHaml == null ? "" : DataItem.NoVaTedadeVasileyeHaml.ToString()));
                template = template.Replace("[StartingPoint]",
                    (DataItem.StartingPoint == null
                        ? ""
                        : DataItem.StartingPoint.ToString().Replace("(", "").Replace(")", "")));
//                template = template.Replace("[Status]", (dataItem.==null?"":DataItem.Status.ToString());
                template = template.Replace("[WithInsurance]",
                    (DataItem.WithInsurance == null ? "" : DataItem.WithInsurance.ToString()));
                template = template.Replace("[Company]", (DataItem.Company == null ? "" : DataItem.Company.ToString()));
                template = template.Replace("[IRTI]", (DataItem.IRTI == null ? "" : DataItem.IRTI.ToString()));
//                template = template.Replace("[NazarSanji]", (dataItem.==null?"":DataItem.NazarSanji.ToString());
//                template = template.Replace("[StatusPR]", (dataItem.==null?"":DataItem.StatusPR.ToString());
                template = template.Replace("[Rank]", (DataItem.Rank == null ? "" : DataItem.Rank.ToString()));
                template = template.Replace("[Power]", (DataItem.Power == null ? "" : DataItem.Power.ToString()));
                template = template.Replace("[TedadePasokhha]",
                    (DataItem.TedadePasokhha == null ? "" : DataItem.TedadePasokhha.ToString()));
                template = template.Replace("[Khatarnak]",
                    (DataItem.Khatarnak == null ? "" : DataItem.Khatarnak.ToString()));
                template = template.Replace("[NazareKoliyeKhoob]",
                    (DataItem.NazareKoliyeKhoob == null ? "" : DataItem.NazareKoliyeKhoob.ToString()));
                template = template.Replace("[NazareKoliyeBad]",
                    (DataItem.NazareKoliyeBad == null ? "" : DataItem.NazareKoliyeBad.ToString()));
                template = template.Replace("[VazneKol]",
                    (DataItem.VazneKol == null ? "" : DataItem.VazneKol.ToString()));

                LiteralControl objlit = new LiteralControl(template);

                e.Item.FindControl("plcGeneralList").Controls.Add(objlit);
            }
        }

        private string getTemplate()
        {
            string Template = string.Empty;
            if (Settings["InquiryTemplate"] != null)
            {
                Template = Settings["InquiryTemplate"].ToString();
            }
            else
            {
                Template = "Nothing";
            }
            return Template;
        }

//        public List<InquiryListItemJftGeneral> GetInquiryLisGeneral()
//        {
//            //string inquiryTypeForList = this.ActiveModule.TabModuleSettings["InquiryTypeForList"].ToString();
//            List<InquiryListItemJftGeneral> inquiryList = new List<InquiryListItemJftGeneral>();
//            using (
//                DataClassesDataContext context =
//                    new DataClassesDataContext(Config.GetConnectionString())
//                )
//            {
//                int ehamlUserId = (from i in context.MyDnn_EHaml_Users
//                    where i.PortalUserId == this.UserInfo.UserID
//                    select i.Id).Single();
//
//                //if (inquiryTypeForList == "Zadghan")
//                //{
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_ZadghanTs on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    where i.InquiryType == "Zadghan" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "Zadghan" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "Zadghan" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "Zadghan"
//                            select c).Count(),
//                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                  && g.NazareKoli == true
//                            select g).Count()).ToString(),
//                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
//                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
//                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
//                                  && g.NazareKoli == false
//                            select g).Count()).ToString(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
//                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                            select i2.Quality).SingleOrDefault(),
//                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
//                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
//                            select i2.Power).SingleOrDefault(),
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        //DisplayName =
//                        //    UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                        //        (int) j.PortalUserId).DisplayName,
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = k.EmptyingCharges,
//                        NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
//                        WithInsurance = k.WithInsurance,
//                        FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    }));
//                //}
//                //                else if (inquiryTypeForList == "Zadghal")
//                //                {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_Zadghals on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "Zadghal" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "Zadghal" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "Zadghal" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any() && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "Zadghal"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = k.EmptyingCharges,
//                        NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
//                        WithInsurance = k.WithInsurance,
//                        FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    }));
//                //                }
//                //                else if (inquiryTypeForList == "Zaban")
//                //                {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_Zabans on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "Zaban" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "Zaban" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "Zaban" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "Zaban"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = k.EmptyingCharges,
//                        NoVaTedadeVasileyeHaml = "",
//                        WithInsurance = false,
//                        FileArzesheBar = "ندارد",
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    }));
//                //                }
//                //                else if (inquiryTypeForList == "Rl")
//                //                {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_Rls on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "Rl" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "Rl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "Rl" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "Rl"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = k.EmptyingCharges,
//                        NoVaTedadeVasileyeHaml = "",
//                        WithInsurance = false,
//                        FileArzesheBar = "ندارد",
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    }));
//                //                }
//                //                else if (inquiryTypeForList == "Dn")
//                //                {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_Dns on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "Dn" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "Dn" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "Dn" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "Dn"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = false,
//                        NoVaTedadeVasileyeHaml = "",
//                        WithInsurance = false,
//                        FileArzesheBar = "ندارد",
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    }));
//                //                }
//                //                else if (inquiryTypeForList == "Dl")
//                //                {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_Dls on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "Dl" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "Dl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "Dl" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "Dl"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = false,
//                        NoVaTedadeVasileyeHaml = "",
//                        WithInsurance = false,
//                        FileArzesheBar = "ندارد",
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    }));
//                //                }
//                //                else if (inquiryTypeForList == "ZDF")
//                //                {
//                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_ZDFs on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "ZDF" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "ZDF" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "ZDF" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "ZDF"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = false,
//                        NoVaTedadeVasileyeHaml = "",
//                        WithInsurance = false,
//                        FileArzesheBar = "ندارد",
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = k.VazneKoleMahmoole.ToString(),
//                    }));
//                //                }
//                //                else if (inquiryTypeForList == "Dghco")
//                //                {
//                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml__Inquiry_Dghcos on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "Dghco" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "Dghco" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "Dghco" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "Dghco"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = false,
//                        NoVaTedadeVasileyeHaml = "",
//                        WithInsurance = false,
//                        FileArzesheBar = "ندارد",
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    });
//                //                }
//                //                else if (inquiryTypeForList == "Hl")
//                //                {
//                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_Hls on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "Hl" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "Hl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "Hl" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "Hl"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = false,
//                        NoVaTedadeVasileyeHaml = "",
//                        WithInsurance = false,
//                        FileArzesheBar = "ندارد",
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    });
//                //                }
//                //                else if (inquiryTypeForList == "Tj")
//                //                {
//                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_Tjs on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "Tj" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "Tj" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "Tj" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "Tj"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = false,
//                        NoVaTedadeVasileyeHaml = "",
//                        WithInsurance = false,
//                        FileArzesheBar = "ندارد",
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    });
//                //                }
//                //                else if (inquiryTypeForList == "Tk")
//                //                {
//                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_Tks on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "Tk" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "Tk" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "Tk" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "Tk"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = false,
//                        NoVaTedadeVasileyeHaml = "",
//                        WithInsurance = false,
//                        FileArzesheBar = "ندارد",
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    });
//                //                }
//                //                else if (inquiryTypeForList == "Ts")
//                //                {
//                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_Ts on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "Ts" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "Ts" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "Ts" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "Ts"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = false,
//                        NoVaTedadeVasileyeHaml = "",
//                        WithInsurance = false,
//                        FileArzesheBar = "ندارد",
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    });
//                //                }
//                //                else if (inquiryTypeForList == "Tr")
//                //                {
//                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_Trs on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "Tr" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "Tr" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "Tr" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "Tr"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = false,
//                        NoVaTedadeVasileyeHaml = "",
//                        WithInsurance = false,
//                        FileArzesheBar = "ندارد",
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    });
//                //                }
//                //                else if (inquiryTypeForList == "ChandVajhiSabok")
//                //                {
//                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSaboks on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "ChandVajhiSabok" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "ChandVajhiSabok" && c.Status == 1 &&
//                              x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "ChandVajhiSabok" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "ChandVajhiSabok"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = false,
//                        NoVaTedadeVasileyeHaml = "",
//                        WithInsurance = false,
//                        FileArzesheBar = "ندارد",
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    });
//                //                }
//                //                else if (inquiryTypeForList == "ChandVajhiSangin")
//                //                {
//                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSangins on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "ChandVajhiSangin" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "ChandVajhiSangin" && c.Status == 1 &&
//                              x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "ChandVajhiSangin" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "ChandVajhiSangin"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = i.ActionDate.Value.ToShortDateString(),
//                        IsReallyNeed = i.IsReallyNeed,
//                        LoadType = i.LoadType,
//                        EmptyingCharges = false,
//                        NoVaTedadeVasileyeHaml = "",
//                        WithInsurance = false,
//                        FileArzesheBar = "ندارد",
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    });
//                //                }
//                //                else if (inquiryTypeForList == "Bazdid")
//                //                {
//                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
//                    join k in context.MyDnn_EHaml_Inquiry_Bazdids on i.InquiryDetail_Id equals k.Id
//                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
//                    where i.InquiryType == "Bazdid" && (
//                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                        where c.InquiryId == i.Id &&
//                              i.InquiryType == "Bazdid" && c.Status == 1 &&
//                              x.MyDnn_EHaml_User_Id != ehamlUserId
//                        select c).Count() < 3 && !(
//                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                            where z.InquiryId == i.Id &&
//                                  i.InquiryType == "Bazdid" && z.Status == 2 &&
//                                  f.MyDnn_EHaml_User_Id == ehamlUserId
//                            select z).Any()
//                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                    select new InquiryListItemJftGeneral()
//                    {
//                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id && i.InquiryType == "Bazdid"
//                            select c).Count(),
//                        Id = i.Id,
//                        Khatarnak = i.LoadType.Contains("IMDG"),
//                        Rank = v.Quality,
//                        Power = v.Power,
//                        Status = _util.GetUserStatus(j.PortalUserId, 1),
//                        DisplayName =
//                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                (int) j.PortalUserId).DisplayName,
//                        InquiryType = i.InquiryType,
//                        CreateDate = i.CreateDate.Value.ToShortDateString(),
//                        ExpireDate = "",
//                        IsTender = i.IsTender,
//                        StartingPoint = i.StartingPoint,
//                        Destination = i.Destination,
//                        ActionDate = "",
//                        IsReallyNeed = false,
//                        LoadType = "",
//                        EmptyingCharges = false,
//                        NoVaTedadeVasileyeHaml = "",
//                        WithInsurance = false,
//                        FileArzesheBar = "ندارد",
//                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        VazneKol = "",
//                    });
//                //                }
//
//                return (inquiryList);
//            }
//        }


        public List<InquiryListItemJftGeneral> GetInquiryLisGeneral()
        {
//            string inquiryTypeForList = this.ActiveModule.TabModuleSettings["InquiryTypeForList"].ToString();
            List<InquiryListItemJftGeneral> inquiryList = new List<InquiryListItemJftGeneral>();

            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString())
                )
            {
                //                int ehamlUserId = (from i in context.MyDnn_EHaml_Users
                //                    where i.PortalUserId == this.UserInfo.UserID
                //                    select i.Id).Single();
                int ehamlUserId = int.MinValue;
                if (UserId != 1)
                {
                    ehamlUserId = _util.GetUserEHamlUserIdByPortalId(this.UserId);
                }


                //                    if (inquiryTypeForList == "Zadghan")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ZadghanTs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Zadghan" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Zadghan" && c.Status == 1 &&
                              x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Zadghan" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Zadghan"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
                        WithInsurance = k.WithInsurance,
                        FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Zadghal")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Zadghals on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Zadghal" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Zadghal" && c.Status == 1 &&
                              x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Zadghal" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Zadghal"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
                        WithInsurance = k.WithInsurance,
                        FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Zaban")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Zabans on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Zaban" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Zaban" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Zaban" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Zaban"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Rl")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Rls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Rl" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Rl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Rl" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Rl"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Dn")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Dns on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Dn" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Dn" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Dn" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Dn"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Dl")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Dls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Dl" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Dl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Dl" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Dl"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "ZDF")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ZDFs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "ZDF" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "ZDF" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "ZDF" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "ZDF"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Dghco")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml__Inquiry_Dghcos on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Dghco" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Dghco" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Dghco" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Dghco"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = k.EmptyingCharges,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Hl")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Hls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Hl" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Hl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Hl" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Hl"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = false,
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = false,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Hs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Hs" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Hs" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Hs" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Hs"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = false,
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = false,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Tj")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Tjs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Tj" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Tj" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Tj" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Tj"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = false,
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = "",
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Tk")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Tks on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Tk" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Tk" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Tk" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Tk"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = false,
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Ts")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Ts on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Ts" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Ts" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Ts" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Ts"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = false,
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = "",
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Tr")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Trs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Tr" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Tr" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Tr" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Tr"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = false,
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = "",
                        Destination = "",
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "ChandVajhiSabok")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSaboks on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "ChandVajhiSabok" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "ChandVajhiSabok" && c.Status == 1 &&
                              x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "ChandVajhiSabok" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "ChandVajhiSabok"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "ChandVajhiSangin")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSangins on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "ChandVajhiSangin" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "ChandVajhiSangin" && c.Status == 1 &&
                              x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "ChandVajhiSangin" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "ChandVajhiSangin"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = i.ActionDate.Value.ToShortDateString(),
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                //                    else if (inquiryTypeForList == "Bazdid")
                //                    {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Bazdids on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Bazdid" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Bazdid" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Bazdid" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                    /*&& i.ExpireDate.Value.Date >= DateTime.Now.Date*/
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Bazdid"
                            select c).Count(),
                        NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == true
                            select g).Count()).ToString(),
                        NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                            join h in context.MyDnn_EHaml_Inquiries on g.Inquiry_Id equals h.Id
                            where h.MyDnn_EHaml_User == i.MyDnn_EHaml_User
                                  && g.NazareKoli == false
                            select g).Count()).ToString(),
                        Id = i.Id,
                        Khatarnak = false,
                        Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Quality).SingleOrDefault(),
                        Power = (from i2 in context.MyDnn_EHaml_UserRanks
                            where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                            select i2.Power).SingleOrDefault(),
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        InquiryType2 = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = "",
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = "",
                        IsReallyNeed = i.IsReallyNeed,
                        LoadType = i.LoadType,
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                    }
                return (inquiryList.OrderByDescending(x => x.CreateDate).ToList());
            }
        }
    }

    public class InquiryListItemJftGeneral
    {
        public string ActionDate { get; set; }

        public string CreateDate { get; set; }

        public string Destination { get; set; }

        public string DisplayName { get; set; }

        public bool? EmptyingCharges { get; set; }

        public string ExpireDate { get; set; }

        public string FileArzesheBar { get; set; }

        public int Id { get; set; }

        public string InquiryType { get; set; }
        public string InquiryType2 { get; set; }

        public bool? IsReallyNeed { get; set; }

        public bool? IsTender { get; set; }

        public string LoadType { get; set; }

        public string NoVaTedadeVasileyeHaml { get; set; }

        public string StartingPoint { get; set; }
        public string Status { get; set; }

        public bool? WithInsurance { get; set; }
        public string Company { get; set; }
        public int IRTI { get; set; }
        public string NazarSanji { get; set; }
        public string StatusPR { get; set; }

        public double? Rank { get; set; }

        public int? Power { get; set; }
        public int TedadePasokhha { get; set; }
        public bool Khatarnak { get; set; }

        public string NazareKoliyeKhoob { get; set; }

        public string NazareKoliyeBad { get; set; }

        public string VazneKol { get; set; }
    }
}