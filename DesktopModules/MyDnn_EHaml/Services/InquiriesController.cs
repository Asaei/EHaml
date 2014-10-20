using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.Security;
using DotNetNuke.Web.Api;
using Telerik.Web.UI.ImageEditor;
using Telerik.Web.UI.ODataSource.Filters;

namespace MyDnn_EHaml.Services
{
    //[SupportedModules]
    [DnnModuleAuthorize(AccessLevel = SecurityAccessLevel.View)]
    public class InquiriesController : DnnApiController
    {
        private Util _util = new Util();

        #region Methods (1) 

        // Public Methods (1) 

        [HttpGet]
        public HttpResponseMessage GetTarhs()
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                List<TarhListItemDTO> tarhsListItemDtos = (from i in context.MyDnn_EHaml_SubscriptionPlans
                    select new TarhListItemDTO()
                    {
                        Id = i.Id,
                        Name = i.PlanName,
                        Description = i.Description,
                        DayCount = i.DayCount.Value,
                        TarhType = i.Type.Value,
                        Price = i.PlanPrice.Value
                    }).ToList();

                return Request.CreateResponse(HttpStatusCode.OK, tarhsListItemDtos);
            }
        }

        [HttpGet]
        public HttpResponseMessage DeleteTarh(int id)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                bool status = (from i in context.MyDnn_EHaml_Subscriptions
                    where i.SubscriptionPlan_Id == id
                          && i.ExpireDate > DateTime.Now.Date
                    select i).Any();
                if (!status)
                {
                    var item = (from i in context.MyDnn_EHaml_SubscriptionPlans
                        where i.Id == id
                        select i).Single();

                    context.MyDnn_EHaml_SubscriptionPlans.DeleteOnSubmit(item);
                    context.SubmitChanges();
                    return Request.CreateResponse(HttpStatusCode.OK, 1);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.ExpectationFailed, 0);
                }
            }
        }

        [HttpGet]
        public HttpResponseMessage GetShahrList(string ostanName)
        {
            List<ShahrListJft> shahrList = new List<ShahrListJft>();
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                shahrList = (from i in context.MyDnn_EHaml_OstanVaShahrs
                    where i.Ostan == ostanName
                    select new ShahrListJft() {Shahr = i.Shahrestan}).Distinct().ToList();
            }

            return Request.CreateResponse(HttpStatusCode.OK, shahrList);
        }

        [HttpGet]
        public HttpResponseMessage GetShahrList2(string keshvarName)
        {
            List<ShahrListJft> shahrList = new List<ShahrListJft>();

            string country = keshvarName;


            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                var countryValue = (from j in context.Lists
                    where j.ListName == "Country"
                          && j.Text == country
                    select j.EntryID).Single();

                shahrList = (from i in context.Lists
                    where i.ListName == "City" && i.ParentID == countryValue
                    select new ShahrListJft() {Shahr = i.Text}).Distinct().ToList();
            }

//            using (
//                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
//            {
//                shahrList = (from i in context.MyDnn_EHaml_OstanVaShahrs
//                    where i.Ostan == ostanName
//                    select new ShahrListJft() {Shahr = i.Shahrestan}).Distinct().ToList();
//            }

            return Request.CreateResponse(HttpStatusCode.OK, shahrList);
        }

        [HttpGet]
        public HttpResponseMessage GetShahrListByCountry(string country, string cityname)
        {
            List<ShahrListJft> shahrList = new List<ShahrListJft>();

            return Request.CreateResponse(HttpStatusCode.OK, shahrList);
        }

        [HttpGet]
        public HttpResponseMessage IsThisUserOk(int UserId, int UserCurrentType)
        {
            Util util = new Util();
            string returnValue = util.IsUserOk(UserId, UserCurrentType);

            return Request.CreateResponse(HttpStatusCode.OK, returnValue);
        }

//        [HttpGet]
//        public HttpResponseMessage GetInquiryList()
//        {
//            string inquiryTypeForList = this.ActiveModule.TabModuleSettings["InquiryTypeForList"].ToString();
//            List<InquiryListItemJft> inquiryList = new List<InquiryListItemJft>();
//            using (
//                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString())
//                )
//            {
//                int ehamlUserId = (from i in context.MyDnn_EHaml_Users
//                    where i.PortalUserId == this.UserInfo.UserID
//                    select i.Id).Single();
//
//                if (inquiryTypeForList == "Zadghan")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_ZadghanTs on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "Zadghan" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "Zadghan" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "Zadghan" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            //DisplayName =
//                            //    UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                            //        (int) j.PortalUserId).DisplayName,
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = k.EmptyingCharges,
//                            NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
//                            WithInsurance = k.WithInsurance,
//                            FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "Zadghal")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_Zadghals on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "Zadghal" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "Zadghal" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "Zadghal" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any() && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = k.EmptyingCharges,
//                            NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
//                            WithInsurance = k.WithInsurance,
//                            FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "Zaban")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_Zabans on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "Zaban" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "Zaban" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "Zaban" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = k.EmptyingCharges,
//                            NoVaTedadeVasileyeHaml = "",
//                            WithInsurance = false,
//                            FileArzesheBar = "ندارد",
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "Rl")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_Rls on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "Rl" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "Rl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "Rl" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = k.EmptyingCharges,
//                            NoVaTedadeVasileyeHaml = "",
//                            WithInsurance = false,
//                            FileArzesheBar = "ندارد",
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "Dn")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_Dns on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "Dn" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "Dn" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "Dn" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = false,
//                            NoVaTedadeVasileyeHaml = "",
//                            WithInsurance = false,
//                            FileArzesheBar = "ندارد",
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "Dl")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_Dls on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "Dl" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "Dl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "Dl" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = false,
//                            NoVaTedadeVasileyeHaml = "",
//                            WithInsurance = false,
//                            FileArzesheBar = "ندارد",
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "ZDF")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_ZDFs on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "ZDF" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "ZDF" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "ZDF" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = false,
//                            NoVaTedadeVasileyeHaml = "",
//                            WithInsurance = false,
//                            FileArzesheBar = "ندارد",
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "Dghco")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml__Inquiry_Dghcos on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "Dghco" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "Dghco" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "Dghco" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = false,
//                            NoVaTedadeVasileyeHaml = "",
//                            WithInsurance = false,
//                            FileArzesheBar = "ندارد",
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "Hl")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_Hls on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "Hl" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "Hl" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "Hl" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = false,
//                            NoVaTedadeVasileyeHaml = "",
//                            WithInsurance = false,
//                            FileArzesheBar = "ندارد",
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "Tj")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_Tjs on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "Tj" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "Tj" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "Tj" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = false,
//                            NoVaTedadeVasileyeHaml = "",
//                            WithInsurance = false,
//                            FileArzesheBar = "ندارد",
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "Tk")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_Tks on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "Tk" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "Tk" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "Tk" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = false,
//                            NoVaTedadeVasileyeHaml = "",
//                            WithInsurance = false,
//                            FileArzesheBar = "ندارد",
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "Ts")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_Ts on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "Ts" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "Ts" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "Ts" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = false,
//                            NoVaTedadeVasileyeHaml = "",
//                            WithInsurance = false,
//                            FileArzesheBar = "ندارد",
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "Tr")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_Trs on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "Tr" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "Tr" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "Tr" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = false,
//                            NoVaTedadeVasileyeHaml = "",
//                            WithInsurance = false,
//                            FileArzesheBar = "ندارد",
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "ChandVajhiSabok")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSaboks on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "ChandVajhiSabok" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "ChandVajhiSabok" && c.Status == 1 &&
//                                  x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "ChandVajhiSabok" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = false,
//                            NoVaTedadeVasileyeHaml = "",
//                            WithInsurance = false,
//                            FileArzesheBar = "ندارد",
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "ChandVajhiSangin")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSangins on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "ChandVajhiSangin" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "ChandVajhiSangin" && c.Status == 1 &&
//                                  x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "ChandVajhiSangin" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = i.ExpireDate.Value.ToShortDateString(),
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = i.ActionDate.Value.ToShortDateString(),
//                            IsReallyNeed = i.IsReallyNeed,
//                            LoadType = i.LoadType,
//                            EmptyingCharges = false,
//                            NoVaTedadeVasileyeHaml = "",
//                            WithInsurance = false,
//                            FileArzesheBar = "ندارد",
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//                else if (inquiryTypeForList == "Bazdid")
//                {
//                    inquiryList = (from i in context.MyDnn_EHaml_Inquiries
//                        join k in context.MyDnn_EHaml_Inquiry_Bazdids on i.InquiryDetail_Id equals k.Id
//                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
//                        where i.InquiryType == "Bazdid" && (
//                            from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
//                            where c.InquiryId == i.Id &&
//                                  i.InquiryType == "Bazdid" && c.Status == 1 &&
//                                  x.MyDnn_EHaml_User_Id != ehamlUserId
//                            select c).Count() < 3 && !(
//                                from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
//                                join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
//                                where z.InquiryId == i.Id &&
//                                      i.InquiryType == "Bazdid" && z.Status == 2 &&
//                                      f.MyDnn_EHaml_User_Id == ehamlUserId
//                                select z).Any()
//                              && i.ExpireDate.Value.Date >= DateTime.Now.Date
//                        select new InquiryListItemJft()
//                        {
//                            Id = i.Id,
//                            Status = _util.GetUserStatus(j.PortalUserId, 1),
//                            DisplayName =
//                                UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
//                                    (int) j.PortalUserId).DisplayName,
//                            InquiryType = i.InquiryType,
//                            CreateDate = i.CreateDate.Value.ToShortDateString(),
//                            ExpireDate = "",
//                            IsTender = i.IsTender,
//                            StartingPoint = i.StartingPoint,
//                            Destination = i.Destination,
//                            ActionDate = "",
//                            IsReallyNeed = false,
//                            LoadType = "",
//                            EmptyingCharges = false,
//                            NoVaTedadeVasileyeHaml = "",
//                            WithInsurance = false,
//                            FileArzesheBar = "ندارد",
//                            Company = this.UserInfo.Profile.GetPropertyValue("Company"),
//                        }).ToList();
//                }
//
//                return Request.CreateResponse(HttpStatusCode.OK, inquiryList);
//            }
//        }

        [HttpGet]
        public HttpResponseMessage GetInquiryList2()
        {
            List<InquiryListItemJft> inquiryList = new List<InquiryListItemJft>();
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString())
                )
            {
                int ehamlUserId = (from i in context.MyDnn_EHaml_Users
                    where i.PortalUserId == this.UserInfo.UserID
                    select i.Id).Single();

                inquiryList = (from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ZadghanTs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    select new InquiryListItemJft()
                    {
                        Id = i.Id,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        //DisplayName =
                        //    UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                        //        (int) j.PortalUserId).DisplayName,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                    }).ToList();
            }


            return Request.CreateResponse(HttpStatusCode.OK, inquiryList);
        }

        [HttpGet]
        public HttpResponseMessage GetInquiryList()
        {
            string inquiryTypeForList = this.ActiveModule.TabModuleSettings["InquiryTypeForList"].ToString();
            List<InquiryListItemJftGeneral> inquiryList = new List<InquiryListItemJftGeneral>();
            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString())
                )
            {
                int ehamlUserId;
                if (UserController.GetCurrentUserInfo().UserID == -1)
                {
                    ehamlUserId = -1;
                }
                else
                {
                    ehamlUserId = (from i in context.MyDnn_EHaml_Users
                        where i.PortalUserId == this.UserInfo.UserID
                        select i.Id).Single();
                }


                try
                {
                    if (inquiryTypeForList == "Zadghan")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_ZadghanTs on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "Zadghan" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "Zadghan" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "Zadghan" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiries
                                        where
                                            c.Id == i.Id && i.InquiryType == "Zadghan" &&
                                            c.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any()
                                  && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                      join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                      where
                                          c.InquiryId == i.Id && i.InquiryType == "Zadghan" && c.Status == 1 &&
                                          x.MyDnn_EHaml_User_Id == ehamlUserId
                                      select c).Any()
                                  && !(
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
                    }
                    else if (inquiryTypeForList == "Zadghal")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_Zadghals on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "Zadghal" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "Zadghal" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "Zadghal" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "Zadghal" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                    }
                    else if (inquiryTypeForList == "Zaban")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_Zabans on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "Zaban" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "Zaban" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "Zaban" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "Zaban" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                    }
                    else if (inquiryTypeForList == "Rl")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_Rls on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "Rl" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "Rl" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "Rl" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "Rl" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                                CreateDate = i.CreateDate.Value.ToShortDateString(),
                                ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                                IsTender = i.IsTender,
                                StartingPoint = i.StartingPoint,
                                Destination = i.Destination,
                                ActionDate = i.ActionDate.Value.ToShortDateString(),
                                IsReallyNeed = i.IsReallyNeed,
                                LoadType = i.LoadType,
                                EmptyingCharges = k.EmptyingCharges,
                                NoVaTedadeVasileyeHaml = k.VagoneMoredeNiyaz,
                                WithInsurance = false,
                                FileArzesheBar = "",
                                Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                                VazneKol = "",
                            }));
                    }
                    else if (inquiryTypeForList == "Dn")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_Dns on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "Dn" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "Dn" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "Dn" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "Dn" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                    }
                    else if (inquiryTypeForList == "Dl")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_Dls on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "Dl" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "Dl" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "Dl" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "Dl" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                    }
                    else if (inquiryTypeForList == "Hs")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_Hs on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "Hs" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "Hs" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "Hs" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "Hs" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                                WithInsurance = k.IsBime,
                                FileArzesheBar = k.FileArzesheBar,
                                Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                                VazneKol = "",
                            }));
                    }
                    else if (inquiryTypeForList == "ZDF")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_ZDFs on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "ZDF" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "ZDF" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "ZDF" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "ZDF" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                    }
                    else if (inquiryTypeForList == "Dghco")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml__Inquiry_Dghcos on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "Dghco" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "Dghco" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "Dghco" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "Dghco" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                    }
                    else if (inquiryTypeForList == "Hl")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_Hls on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "Hl" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "Hl" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "Hl" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "Hl" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                                CreateDate = i.CreateDate.Value.ToShortDateString(),
                                ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                                IsTender = false,
                                StartingPoint = i.StartingPoint,
                                Destination = i.Destination,
                                ActionDate = i.ActionDate.Value.ToShortDateString(),
                                IsReallyNeed = i.IsReallyNeed,
                                LoadType = "مطابق لیست عدل بندی",
                                EmptyingCharges = false,
                                NoVaTedadeVasileyeHaml = "مطابق لیست عدل بندی",
                                WithInsurance = false,
                                FileArzesheBar = "",
                                Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                                VazneKol = "مطابق لیست عدل بندی",
                            }));
                    }
                    else if (inquiryTypeForList == "Tj")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_Tjs on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "Tj" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "Tj" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "Tj" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "Tj" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                    }
                    else if (inquiryTypeForList == "Tk")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_Tks on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "Tk" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "Tk" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "Tk" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "Tk" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                    }
                    else if (inquiryTypeForList == "Ts")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_Ts on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "Ts" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "Ts" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "Ts" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "Ts" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                    }
                    else if (inquiryTypeForList == "Tr")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_Trs on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "Tr" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "Tr" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "Tr" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "Tr" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                    }
                    else if (inquiryTypeForList == "ChandVajhiSabok")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSaboks on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "ChandVajhiSabok" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "ChandVajhiSabok" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "ChandVajhiSabok" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "ChandVajhiSabok" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                    }
                    else if (inquiryTypeForList == "ChandVajhiSangin")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSangins on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "ChandVajhiSangin" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "ChandVajhiSangin" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "ChandVajhiSangin" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "ChandVajhiSangin" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                    }
                    else if (inquiryTypeForList == "Bazdid")
                    {
                        inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                            join k in context.MyDnn_EHaml_Inquiry_Bazdids on i.InquiryDetail_Id equals k.Id
                            join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                            where i.InquiryType == "Bazdid" && (
                                from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                where c.InquiryId == i.Id &&
                                      i.InquiryType == "Bazdid" && c.Status == 1
                                select c).Count() < 3 && !(from c in context.MyDnn_EHaml_Inquiries
                                    where
                                        c.Id == i.Id && i.InquiryType == "Bazdid" &&
                                        c.MyDnn_EHaml_User_Id == ehamlUserId
                                    select c).Any() && !(from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                                        where
                                            c.InquiryId == i.Id && i.InquiryType == "Bazdid" && c.Status == 1 &&
                                            x.MyDnn_EHaml_User_Id == ehamlUserId
                                        select c).Any() && !(
                                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals
                                                f.Id
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
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }

//                foreach (var VARIABLE in COLLECTION)
//                {
//                    
//                }

                return Request.CreateResponse(HttpStatusCode.OK,
                    inquiryList.OrderByDescending(x => x.ActionDate).ToList());
            }
        }

        [HttpGet]
        public HttpResponseMessage GetInquiryLisGeneral()
        {
            string inquiryTypeForList = this.ActiveModule.TabModuleSettings["InquiryTypeForList"].ToString();
            List<InquiryListItemJftGeneral> inquiryList = new List<InquiryListItemJftGeneral>();
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString())
                )
            {
//                int ehamlUserId = (from i in context.MyDnn_EHaml_Users
//                    where i.PortalUserId == this.UserInfo.UserID
//                    select i.Id).Single();

                int ehamlUserId = int.MaxValue;

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
                return Request.CreateResponse(HttpStatusCode.OK, inquiryList);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetUserList()
        {
            List<UserListItem> list = new List<UserListItem>();

            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                list = (from i in context.MyDnn_EHaml_Users
                    select
                        new UserListItem()
                        {
                            Id = i.PortalUserId,
                            DisplayName =
                                UserController.GetUserById(this.PortalSettings.PortalId, (int) i.PortalUserId)
                                    .DisplayName
                        })
                    .ToList();
            }

            return Request.CreateResponse(HttpStatusCode.OK, list);
        }

        [HttpGet]
        public HttpResponseMessage MakeUserApprove(int id)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_User user = (from i in context.MyDnn_EHaml_Users
                    where i.PortalUserId == id
                    select i).Single();

                user.IsApprove = true;

                context.SubmitChanges();
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }


/*        [HttpGet]
        public HttpResponseMessage GetInquiryLisGeneral()
        {
            //string inquiryTypeForList = this.ActiveModule.TabModuleSettings["InquiryTypeForList"].ToString();
            List<InquiryListItemJftGeneral> inquiryList = new List<InquiryListItemJftGeneral>();
            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString())
                )
            {
                int ehamlUserId = (from i in context.MyDnn_EHaml_Users
                    where i.PortalUserId == this.UserInfo.UserID
                    select i.Id).Single();

                //if (inquiryTypeForList == "Zadghan")
                //{
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ZadghanTs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where i.InquiryType == "Zadghan" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Zadghan" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
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
                        //DisplayName =
                        //    UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                        //        (int) j.PortalUserId).DisplayName,
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                //}
                //                else if (inquiryTypeForList == "Zadghal")
                //                {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Zadghals on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
                    where i.InquiryType == "Zadghal" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Zadghal" && c.Status == 1 && x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Zadghal" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any() && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Zadghal"
                            select c).Count(),
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                //                }
                //                else if (inquiryTypeForList == "Zaban")
                //                {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Zabans on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
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
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                }
                //                else if (inquiryTypeForList == "Rl")
                //                {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Rls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
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
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                }
                //                else if (inquiryTypeForList == "Dn")
                //                {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Dns on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
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
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                }
                //                else if (inquiryTypeForList == "Dl")
                //                {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Dls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
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
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    }));
                //                }
                //                else if (inquiryTypeForList == "ZDF")
                //                {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ZDFs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
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
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = k.VazneKoleMahmoole.ToString(),
                    }));
                //                }
                //                else if (inquiryTypeForList == "Dghco")
                //                {
                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml__Inquiry_Dghcos on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
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
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    });
                //                }
                //                else if (inquiryTypeForList == "Hl")
                //                {
                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Hls on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
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
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    });
                //                }
                //                else if (inquiryTypeForList == "Tj")
                //                {
                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Tjs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
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
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    });
                //                }
                //                else if (inquiryTypeForList == "Tk")
                //                {
                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Tks on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
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
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    });
                //                }
                //                else if (inquiryTypeForList == "Ts")
                //                {
                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Ts on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
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
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    });
                //                }
                //                else if (inquiryTypeForList == "Tr")
                //                {
                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Trs on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
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
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    });
                //                }
                //                else if (inquiryTypeForList == "ChandVajhiSabok")
                //                {
                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSaboks on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
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
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    });
                //                }
                //                else if (inquiryTypeForList == "ChandVajhiSangin")
                //                {
                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_ChandVajhiSangins on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
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
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
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
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    });
                //                }
                //                else if (inquiryTypeForList == "Bazdid")
                //                {
                inquiryList.AddRange(from i in context.MyDnn_EHaml_Inquiries
                    join k in context.MyDnn_EHaml_Inquiry_Bazdids on i.InquiryDetail_Id equals k.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    join v in context.MyDnn_EHaml_UserRanks on j.Id equals v.MyDnn_EHaml_User_Id
                    where i.InquiryType == "Bazdid" && (
                        from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        where c.InquiryId == i.Id &&
                              i.InquiryType == "Bazdid" && c.Status == 1 &&
                              x.MyDnn_EHaml_User_Id != ehamlUserId
                        select c).Count() < 3 && !(
                            from z in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join f in context.MyDnn_EHaml_ReplyToInquiries on z.ReplyToInquiryId equals f.Id
                            where z.InquiryId == i.Id &&
                                  i.InquiryType == "Bazdid" && z.Status == 2 &&
                                  f.MyDnn_EHaml_User_Id == ehamlUserId
                            select z).Any()
                          && i.ExpireDate.Value.Date >= DateTime.Now.Date
                    select new InquiryListItemJftGeneral()
                    {
                        TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                            join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                            where c.InquiryId == i.Id && i.InquiryType == "Bazdid"
                            select c).Count(),
                        Id = i.Id,
                        Khatarnak = i.LoadType.Contains("IMDG"),
                        Rank = v.Quality,
                        Power = v.Power,
                        Status = _util.GetUserStatus(j.PortalUserId, 1),
                        DisplayName =
                            UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                                (int) j.PortalUserId).DisplayName,
                        InquiryType = i.InquiryType,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        ExpireDate = "",
                        IsTender = i.IsTender,
                        StartingPoint = i.StartingPoint,
                        Destination = i.Destination,
                        ActionDate = "",
                        IsReallyNeed = false,
                        LoadType = "",
                        EmptyingCharges = false,
                        NoVaTedadeVasileyeHaml = "",
                        WithInsurance = false,
                        FileArzesheBar = "ندارد",
                        Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        VazneKol = "",
                    });
                //                }

                return Request.CreateResponse(HttpStatusCode.OK, inquiryList);
            }
        }*/

        #endregion Methods 
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

        public string NameKhedmatresan { get; set; }

        public int rId { get; set; }

        public int? KhadamatresanId { get; set; }

        public int irti { get; set; }

        public int NazarSanjiVaziyat { get; set; }

        public string JoziyatLink { get; set; }
    }


    public class ShahrListJft
    {
        public string Shahr { get; set; }
    }

    public class InquiryListItemJft
    {
        #region Properties (15) 

        public string ActionDate { get; set; }

        public string CreateDate { get; set; }

        public string Destination { get; set; }

        public string DisplayName { get; set; }

        public bool? EmptyingCharges { get; set; }

        public string ExpireDate { get; set; }

        public string FileArzesheBar { get; set; }

        public int Id { get; set; }

        public string InquiryType { get; set; }

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
        public string ModateAnjam { get; set; }

        #endregion Properties 

        public int TedadePasokhHa { get; set; }

        public string JoziyatLink { get; set; }

        public int SahebId { get; set; }
    }
}