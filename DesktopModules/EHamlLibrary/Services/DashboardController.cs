using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.Security;
using DotNetNuke.Web.Api;
using EHamlLibrary.DTOs;
using EHamlLibrary.Utility;

namespace EHamlLibrary.Services

{
    [DnnModuleAuthorize(AccessLevel = SecurityAccessLevel.View)]
    public class DashboardController : DnnApiController
    {
        private readonly Utility.Utility _utility = new Utility.Utility();
        private readonly Notification _notification = new Notification();
        private readonly Mali _mali = new Mali();

        [HttpGet]
        [AllowAnonymous]
        public HttpResponseMessage GetSelectedGridForDashboardeSahebBar()
        {
            string result =
                this.ActiveModule.TabModuleSettings["GetSelectedGridForDashboardeSahebBar"].ToString();

            return Request.CreateResponse(HttpStatusCode.OK, result);
        }


        [HttpGet]
        [AllowAnonymous]
        public HttpResponseMessage GetMyInquiryList(int userId, int moduleId)
        {
            ModuleController controller = new ModuleController();
            var setting = controller.GetTabModuleSettings(moduleId);
            string value = setting["GetSelectedGridForDashboardeSahebBar"].ToString();

            DateTime minDateTime;
            DateTime maxDateTime;

            if (value == "استعلامات قبلی")
            {
                minDateTime = DateTime.Today.AddYears(-100).Date;
                maxDateTime = DateTime.Today.Date;
            }
            else
            {
                minDateTime = DateTime.Today.Date.Date;
                maxDateTime = DateTime.Today.AddYears(100).Date;
            }

            List<InquiryListDTO> result = new List<InquiryListDTO>();


            Asaei_EHaml_Inquiry inquiry = new Asaei_EHaml_Inquiry();

            inquiry.GetMyInquiryList(userId, minDateTime, maxDateTime, result);

            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        [HttpGet]
        [AllowAnonymous]
        public HttpResponseMessage GetMyInquiryReplyList(int userId, int inquiryId)
        {
            List<ReplyToInquiryListDTO> result = new List<ReplyToInquiryListDTO>();

            using (EHamlDataClassesDataContext context = new EHamlDataClassesDataContext(Config.GetConnectionString()))
            {
                result = (from i in context.Asaei_EHaml_ReplyToInquiries
                    where i.InquiryId == inquiryId
                    select new ReplyToInquiryListDTO()
                    {
                        InquiryId = i.InquiryId,
                        ReplyToInquiryId = i.Id,
                        StatusPerson = "خوب",
                        DisplayName =
                            UserController.GetUserById(this.PortalSettings.PortalId, (int) i.ServentUserId).DisplayName,
                        GeymateKol = string.Format("{0:C2}", i.GeymateKol),
                        ZamaneAmadegiBarayeShooroo = i.ZamaneAmadegiBarayShoorooeAmaliyatShamsi,
                        Status = i.Vaziyat,
                        CreateDate = i.CreateDateShamsi,
                        ModateAnjameAmaliyat = i.KoleModatZamaneHaml,
                        Pishbini = i.PishbiniEmkanPaziriyeAmaliyat,
                        Power = 20,
                        Rank = 10,
                        NazareKoliKhoob = 20,
                        NazareKoliBad = 10,
                        VaziyatePaziresh = i.Vaziyat,
                        NameKhedmatresan =
                            UserController.GetUserById(this.PortalSettings.PortalId, (int) i.ServentUserId).DisplayName,
                        NazarSanji = "No",
                        InquiryType = i.InquiryType
                    }).ToList();
            }

            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        [HttpGet]
        [AllowAnonymous]
        public HttpResponseMessage SetAcceptTheReplyToInquiry(int inquiryId, int replyToInquiryId)
        {
            using (EHamlDataClassesDataContext context = new EHamlDataClassesDataContext(Config.GetConnectionString()))
            {
                Asaei_EHaml_ReplyToInquiry replyToInquiry = (from i in context.Asaei_EHaml_ReplyToInquiries
                    where i.Id == replyToInquiryId
                    select i).Single();

                replyToInquiry.Vaziyat = "پذیرفته شده";
                replyToInquiry.AcceptDateMiladi = DateTime.Now;
                replyToInquiry.AcceptDateShamsi = _utility.ConvertToPersian(DateTime.Now);
                context.SubmitChanges();

                // AmaliyateBanki
                _mali.DoSuccessInquiry(context, replyToInquiry.InquiryType, (int) replyToInquiry.ServentUserId,
                    replyToInquiry.VahedePool, replyToInquiry.InquiryId, replyToInquiry.Id, replyToInquiry.GeymateKol,
                    replyToInquiry.AcceptDateMiladi, replyToInquiry.AcceptDateShamsi);

                // Etelaresaniha
                _notification.DoSuccessInquiry(replyToInquiry.InquiryType, replyToInquiry.InquiryId, replyToInquiry.Id);
            }


            return Request.CreateResponse(HttpStatusCode.OK, 1);
        }

        [HttpGet]
        [AllowAnonymous]
        public HttpResponseMessage GetMySucsessInquiryList(int userId)
        {
            Asaei_EHaml_Inquiry inquiry = new Asaei_EHaml_Inquiry();
            List<InquiryListDTO> sucsessInquiryList = new List<InquiryListDTO>();
            sucsessInquiryList = inquiry.GetMySucsessInquiryList(userId, sucsessInquiryList);


            return Request.CreateResponse(HttpStatusCode.OK, sucsessInquiryList);
        }

        [HttpGet]
        [AllowAnonymous]
        public HttpResponseMessage GetGrideMoredeNazarVaseDashboardServant()
        {
            string result =
                this.ActiveModule.TabModuleSettings["GetSelectedGridForDashboardeServant"].ToString();

            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        [HttpGet]
        [AllowAnonymous]
        public HttpResponseMessage GetMyReplyToInquiryList(int userId, int moduleId)
        {
            ModuleController controller = new ModuleController();
            var setting = controller.GetTabModuleSettings(moduleId);
            string value = setting["GetSelectedGridForDashboardeServant"].ToString();

            DateTime minDateTime;
            DateTime maxDateTime;

            if (value == "پاسخ به استعلامات قبلی")
            {
                minDateTime = DateTime.Today.AddYears(-100).Date;
                maxDateTime = DateTime.Today.Date;
            }
            else
            {
                minDateTime = DateTime.Today.Date.Date;
                maxDateTime = DateTime.Today.AddYears(100).Date;
            }

            List<ReplyToInquiryListDTO> result = new List<ReplyToInquiryListDTO>();


            Asaei_EHaml_ReplyToInquiry replyToInquiry = new Asaei_EHaml_ReplyToInquiry();

            replyToInquiry.GetMyReplyToInquiryList(userId, minDateTime, maxDateTime, result);

            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        [HttpGet]
        [AllowAnonymous]
        public HttpResponseMessage GetMyReplyToInquiryDetail(int myReplyToInquiryId)
        {
            var replyToInquiryListDto = new List<ReplyToInquiryListDTO>();

            using (EHamlDataClassesDataContext context = new EHamlDataClassesDataContext(Config.GetConnectionString()))
            {
                replyToInquiryListDto = (from i in context.Asaei_EHaml_ReplyToInquiries
                    where i.Id == myReplyToInquiryId
                    select new ReplyToInquiryListDTO()
                    {
                        ReplyToInquiryId = i.Id,
                        Status = i.Vaziyat,
                        ReplyToInquiryCreateDate = i.CreateDateShamsi,
                        ZamaneAmadegiBarayeShooroo = i.ZamaneAmadegiBarayShoorooeAmaliyatShamsi,
                        GeymateKol = i.GeymateKol,
                        Pishbini = i.PishbiniEmkanPaziriyeAmaliyat,
                        ModateAnjameAmaliyat = i.KoleModatZamaneHaml,
                        DisplayName = UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                            (int) i.ServentUserId).DisplayName,
                        InquiryId = i.InquiryId,
                    }).ToList();
            }

            return Request.CreateResponse(HttpStatusCode.OK, replyToInquiryListDto);
        }

        [HttpGet]
        [AllowAnonymous]
        public HttpResponseMessage GetMyReplyToInquiryListThatAccepted(int userId)
        {
            var replyToInquiryListDto = new List<ReplyToInquiryListDTO>();

            using (EHamlDataClassesDataContext context = new EHamlDataClassesDataContext(Config.GetConnectionString()))
            {
                replyToInquiryListDto = (from i in context.Asaei_EHaml_ReplyToInquiries
                                         join j in context.Asaei_EHaml_Inquiries on i.InquiryId equals j.Id
                                         where i.ServentUserId == userId && i.Vaziyat == "پذیرفته شده"
                    select new ReplyToInquiryListDTO()
                    {
                        ReplyToInquiryId = i.Id,
                        Status = i.Vaziyat,
                        ReplyToInquiryCreateDate = i.CreateDateShamsi,
                        ZamaneAmadegiBarayeShooroo = i.ZamaneAmadegiBarayShoorooeAmaliyatShamsi,
                        GeymateKol = i.GeymateKol,
                        Pishbini = i.PishbiniEmkanPaziriyeAmaliyat,
                        ModateAnjameAmaliyat = i.KoleModatZamaneHaml,
                        DisplayName = UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                            (int) i.ServentUserId).DisplayName,
                        InquiryId = i.InquiryId,
                        CreateDate = j.CreateDateShamsi,
                        StartingPoint = j.OstaneMabda,
                        Destination = j.OstaneMagsad,
                        JoziyatLink = _utility.GetLinkeJoziyateInquiry(j.InquiryType,j.Id),
                        Rank = 20,
                        Power = 20,
                        NameSahebBar = UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                            (int)j.UserId).DisplayName,
                            NazareKoliKhoob = 20,
                            NazareKoliBad = 10,
                            NazarSanji = _utility.GetVaziyateNazarSanjiyeKhadamatResanBeSahebBar(),
                    }).ToList();
            }

            return Request.CreateResponse(HttpStatusCode.OK, replyToInquiryListDto);
        }
    }
}