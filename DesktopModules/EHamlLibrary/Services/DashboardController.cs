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

namespace EHamlLibrary.Services

{
    [DnnModuleAuthorize(AccessLevel = SecurityAccessLevel.View)]
    public class DashboardController : DnnApiController
    {
        Utility.Utility _utility = new Utility.Utility();
        
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

            result.AddRange(inquiry.GetMyInquiryList(userId, minDateTime, maxDateTime, result));

            return Request.CreateResponse(HttpStatusCode.OK, result);
        } 
        
        [HttpGet]
        [AllowAnonymous]
        public HttpResponseMessage MyInquiryReplyList(int userId, int inquiryId)
        {
            List<ReplyToInquiry> result = new List<ReplyToInquiry>();

            using (EHamlDataClassesDataContext context = new EHamlDataClassesDataContext(Config.GetConnectionString()))
            {
                result = (from i in context.Asaei_EHaml_ReplyToInquiries
                    where i.InquiryId == inquiryId
                    select new ReplyToInquiry()
                    {
                        InquiryId = i.InquiryId,
                        ReplyToInquiryId = i.Id,
                        StatusPerson = "خوب",
                        DisplayName =   UserController.GetUserById(this.PortalSettings.PortalId,i.ServentUserId).DisplayName,
                        GeymateKol = i.GeymateKol,
                        ZamaneAmadegiBarayeShooroo =i.ZamaneAmadegiBarayShoorooeAmaliyatShamsi,
                        Status = i.Vaziyat,
                        CreateDate = i.CreateDateShamsi,
                        ModateAnjameAmaliyat = i.KoleModatZamaneHaml,
                        Pishbini = i.PishbiniEmkanPaziriyeAmaliyat,
                        Power = 20,
                        Rank = 10,
                        NazareKoliKhoob = 20,
                        NazareKoliBad = 10,
                        VaziyatePaziresh = "پاسخ داده نشده",
                        NameKhedmatresan = UserController.GetUserById(this.PortalSettings.PortalId, i.ServentUserId).DisplayName,
                        NazarSanji = "No",
                        InquiryType = i.InquiryType
                    }).ToList();
            }

            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

    }
}