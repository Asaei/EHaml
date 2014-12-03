using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using DotNetNuke.Security;
using DotNetNuke.Web.Api;
using EHamlLibrary;
using EHamlLibrary.DTOs;

namespace EHamlLibrary.Services
{
    [DnnModuleAuthorize(AccessLevel = SecurityAccessLevel.View)]
    public class InquiryListController : DnnApiController
    {
        [HttpGet]
        [AllowAnonymous]
        public HttpResponseMessage GetInquiryListForViewInquiryList()
        {
            string inquiryTypeForViewInquiryList =
                this.ActiveModule.TabModuleSettings["InquiryTypeForViewInquiryList"].ToString();
            List<InquiryListDTO> result = null;
            try
            {
                Asaei_EHaml_Inquiry inquiry = new Asaei_EHaml_Inquiry();
                result = inquiry.GetInquiryListForViewInquiryList(inquiryTypeForViewInquiryList);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        [HttpGet]
        [AllowAnonymous]
        public HttpResponseMessage Test()
        {
            return Request.CreateResponse(HttpStatusCode.OK, "SAdasdasdasd");
        }
    }
}